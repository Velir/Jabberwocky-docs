-------------------------
Asynchronous Caching
-------------------------

Overview
-----------

The ``IAsyncCacheProvider`` interface exposes the asynchronous caching functions.

Unlike their synchronous counterparts found in the ``ISyncCacheProvider``, these functions all follow the Task-based Asynchronous Pattern (TAP), are are thus ``Task<T>`` returning.

Effectively, this means that these functions are all **non-blocking**, and will all execute asynchronously.  Furthermore, this means that each of the asynchronous functions can be **awaited** with the ``await`` keyword.

The benefits to using the asynchronous functions become clear in situations where you may have long-running IO operations (like network calls), or are already executing code in an asynchronous context, and want to prevent blocking on synchronous locks.

Thus, by using the asynchronous caching functions, you gain the benefit of:

#. Non-blocking asynchronous locking
#. Asynchronous cache callback execution

The first point is important to note, because as outlined in the :ref:`callback documentation <cache-callback>`, when resorting to executing the ``callback``, the cache will enter a **critical region**.  In an asynchronous execution context, it is important to eliminate blocking calls, as these can (potentially) lead to deadlocks.

Thus, the asynchronous caching functions use an asynchronous locking primitive that does **not** block the thread.

GetFromCacheAsync
-----------------------

There are a few variations on the asynchronous caching functions (ignoring the overloads with expiration):

.. code-block:: c#
	
	Task<T> GetFromCacheAsync<T>(string key, Func<T> callback, 
		CancellationToken token = default(CancellationToken))

	Task<T> GetFromCacheAsync<T>(string key, Func<CancellationToken, Task<T>> callback, 
		CancellationToken token = default(CancellationToken))

Regardless of which function is used, they are all asynchronous, and will return a ``Task<T>``.  This allows you to ``await`` the result of the call asynchronously.

There are two variations that allow you to specify either a synchronous cache ``callback``, or an asynchronous one.  While it may seem counter-intuitive to include an asynchronous overload that allows for executing a synchronous callback, the reason for this is to allow you to execute expensive synchronous callbacks, while still allowing you to asynchronously await the caching function.

The primary benefit of doing this is that the **critical region** of the asynchronous function still uses an asynchronous lock, and thus it is desirable to use the asynchronous overload when caching a synchronous callback, so that multiple threads attempting to retrieve the same cached value don't **block**.

Cancellation
--------------

All of the provided overloads accept an optional ``CancellationToken``.  By passing in a vaild token, you can cancel an ongoing cache operation.  There are two points where a caching operation can be cancelled:

#. When the function attempts to execute the cache ``callback``, and enters the **critical region**, or
#. When the function has already entered the **critical region**, and is currently executing the ``callback``.

In the first case, if the ``CancellationToken`` is cancelled while the current thread is awaiting on the asynchronous lock, the function will throw.

In the second case, it is up to the implementor of the ``callback`` fuction to appropriately handle cancellation, as the token is passed into the ``callback`` as the sole parameter.