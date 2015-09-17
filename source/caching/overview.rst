-----------------
Overview
-----------------

Jabberwocky has a built-in caching framework based on the underlying .NET MemoryCache.  This makes it extremely portable and flexible - it can be used across any .NET project, and it can be extended to provide additional functionality.

The base implementation provided by the Core library is the ``BaseCacheProvider``.  This implements the ``ICacheProvider`` interface, which itself is a composition of two sub-interfaces:

* ``ISyncCacheProvider``
* ``IAsyncCacheProvider``

These interfaces expose **synchronous** and **asynchronous** caching functions, respectively.

Finally, there are multiple cache classes defined within the Jabberwocky libraries:

* ``GeneralCache``
* ``SiteCache``

.. note:: If you plan on using IoC (via Autofac, which is highly recommended for all Sitecore projects), then you should avoid direct references to either of these concrete implementation, and instead rely on the ``ICacheProvider`` interface instead.