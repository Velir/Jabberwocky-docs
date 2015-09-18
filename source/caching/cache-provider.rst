------------------
Cache Provider
------------------

The primary caching provider is exposed through the ``ICacheProvider`` interface.  This implements both the ``ISyncCacheProvider`` and ``IAsyncCacheProvider`` interfaces.

The base implementation of the ``ICacheProvider`` is the ``BaseCacheProvider``, which provides an abstract implementation for the interface.  This allows developers to extend the base caching facility with their own functionality.

.. important:: If you intend to extend the base caching implementation, be aware the caching classes are expected to be **thread-safe**, and any descendants must also be **thread-safe**.

For general caching purposes, a ``GeneralCache`` class has been provided, which inherits from the ``BaseCacheProvider`` abstract class.

General Cache
--------------

The ``GeneralCache`` uses .NET's MemoryCache under the hood, and is thus suitable for a variety of situations.  Notably, it has no dependencies on the HttpContext, or System.Web DLL, so it can be used in any type of application.


Site Cache
-------------

The ``SiteCache`` is a **singleton** implementation of the ``BaseCacheProvider``.  It is intended to be used for ASP.NET websites, and provides a handler to clear the entire cache.

This is ideal for Sitecore solutions, where it is desirable to clear the site's cache on publish.

.. note:: If you include the ``Jabberwocky.Glass`` package in your project, a **Jabberwocky.Glass.config** file will automatically be added to your ``App_Config\Include`` directory, which will wire up publish event handlers to clear the cache.


In the :doc:`next section<sitecore-decorator>`, we will take a look at how the ``SiteCache`` is extended to work seamlessly with Sitecore out-of-the-box, requiring virtually no setup.


.. _cache-callback:

Understanding The Cache Callback
----------------------------------

It is important to understand how the caching operation works.  The ``BaseCacheProvider`` implements the reusable caching logic, and so all inheritors also inherit this logic.

When caching an object via one of the caching functions, the cache will attempt to locate the object in the underlying ``MemoryCache`` using the provided cache ``key`` parameter.  If it is found, the cached object is immediately returned, and no further processing is required.

On the other hand, if the object is not found, then the cache will be required to execute the cache callback to calculate the value to be cached.  Before this happens, the cache will enter a **critical region** (by locking on an a temporary cache object, discriminated by the unique cache ``key`` parameter).

.. important:: This is why it is important to create **correct** cache keys. These keys act as mutually exclusive locks, so that only a single cache ``callback`` can be executed at the same time, per unique ``key``.

By wrapping all invocations of the cache ``callback`` in a critical region, we ensure that only a single thread can execute the callback at a time, thus causing all other concurrent requests for the same cache ``key`` to block.  

In most cases, this ends up saving time and resources, as this prevents the expensive ``callback`` operation from being called more than once.  Intead, all blocking threads will receive the cached result once the initial ``callback`` operation completes.