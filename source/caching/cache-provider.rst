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


In the next section, we will take a look at how the ``SiteCache`` is extended to work seamlessly with Sitecore out-of-the-box, requiring virtually no setup.