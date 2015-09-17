---------------------
Sitecore Integration
---------------------

When the ``Jabberwocky.Glass`` package is imported, you'll have access to the ``ContainerBuilder`` extension method: ``builder.RegisterCacheServices()``.

.. note:: If you followed the :doc:`../getting-started/quickstart`, then you should already have this registered.

When cache services have been registered with Autofac by calling the extension method above, then the ``ICacheProvider`` (and ``ISyncCacheProvider``/``IAsyncCacheProvider``) will have been registered for you.

Included as part of this registration is a decorator that will wrap the underlying cache provider, and provide Sitecore specific behavior.  By default, the underlying cache provider is the ``SiteCache``.

This behavior is provided by the ``SitecoreCacheDecorator`` class, and it ensures that all cache calls works seamlessly with Sitecore, by providing the following services:

#. Cache keys will automatically vary by Sitecore Context parameters:
	* Language
	* Database
	* Site Name
#. Caching will only occur in the ``web`` database context
	* The cache acts as a 'no-op' when in the ``master`` context.
#. The Cache will automatically clear on publish