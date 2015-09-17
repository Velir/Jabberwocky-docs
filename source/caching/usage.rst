------------
Usage
------------

You should consider using the ``ICacheProvider`` service whenever the result of an expensive operation needs to be cached for later use.

Prime candidates include:

* Web service calls
* Sitecore descendants traversal
* `and so much more...`

Simple
------------------

Generally speaking, when working in a Sitecore solution, you should consider using the following overload that accepts a ``string`` key parameter, and a ``Func<T>`` callback parameter:

.. code-block:: c#

	var returnVal = _cacheProvider.GetFromCache<object>("key", () => obj);

This is the simplest way to cache an item, and will keep the cached item in memory until either:

	#. A publish operation occurs, or
	#. The .NET runtime is under memory pressure, and the cache item gets evicted automatically

You can also use the **asynchronous** functions to perform the same function, but instead of blocking on the call, you can ``await`` it instead.

.. code-block:: c#
	
	var returnVal = await _cacheProvider.GetFromCacheAsync<object>("key", () => obj);

or

.. code-block:: c#
	
	var returnVal = await _cacheProvider.GetFromCacheAsync<object>("key", async ct => await GetResultAsync(ct));


Advanced
-------------------

You can also use the provided overloads with an absolute expiration.

For the asynchronous overloads, there is also an optional ``CancellationToken`` parameter that you can pass to the ``GetFromCacheAsync`` function.  If the token is cancelled while the function is being awaited, you can either handle it yourself in the callback, or in the case where the current call is awaiting on the underlying asynchronous lock, the operation will be cancelled.