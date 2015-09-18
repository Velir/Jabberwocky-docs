--------------
Initial Setup
--------------

Setting up the Glass Interface Factory is both easy and straightforward.  Depending on your needs, you may use it with, or without Autofac.

With Autofac
--------------

If you're using Autofac, then you don't need to do anything other than register the factory via the ``builder.RegisterGlassFactory()`` extension method.

Then in your code, you should be able to use constructor injection to request the ``IGlassInterfaceFactory`` interface as a dependency, like so:

.. code-block:: c#
	
	private readonly IGlassInterfaceFactory _factory;
	public MyService(IGlassInterfaceFactory factory) {
		_factory = factory;
	}

Without Autofac
-----------------

If for any reason you can't use Autofac, you can manually construct the factory using the provided ``DefaultGlassFactoryBuilder``:

.. code-block:: c#
	
	var options = new ConfigurationOptions(debugEnabled: false, assemblies: "YOURPROJECT.Library");
	var sitecoreServiceFunc = () => new SitecoreContext() ?? new SitecoreService("web");
	_builder = new DefaultGlassFactoryBuilder(options, sitecoreServiceFunc);

	var factory = _builder.BuildFactory();

.. important:: It is important that you also store the result of the ``_builder.BuildFactory()`` as a singleton, as the ``GlassInterfaceFactory`` is **thread-safe**, and the process of creating the factory is expensive.

.. attention:: The above code is provided as a sample only.  The ``sitecoreServiceFunc`` will return the current context's glass version of the Sitecore.Context.  However, this will only work within the context of an HTTP request, so be aware that this may not work when in the context of a Sitecore pipeline, or other non-HTTP context. In those cases, the above func will return use the **web** database.

Configuration Options
----------------------

Regardless of whether or not you use Autofac, you can configure the setup of the ``GlassInterfaceFactory`` to specify:

	* Enable/Disable Debug mode
	* Which assemblies to scan for ``GlassFactoryInterface`` and ``GlassFactoryType`` declarations.

With Autofac, that might look something like:

.. code-block:: c#

	var options = new ConfigurationOptions(debugEnabled: true, assemblies: "YOURLIBRARY");
	builder.RegisterGlassFactory(options);

The **debug** flag is useful for catching errors during development.  It enables behavior that will throw a ``TypeMismatchException`` when the Glass Interface Factory attempts to convert a Glass Mapper item to its corresponding Glass Factory Type implementation, and it detects that the runtime type of the Glass Model is incompatible with the Glass Factory Type's expected Glass Model Type.

This is usually the result of out-of-sync TDS models, and/or incorrectly passing in Glass Mapper models to the ``GetItem<T>`` function without using the ``SitecoreService.GetItem<IGlassBase>(inferType: true)`` overload.