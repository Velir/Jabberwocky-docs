=========================
Mini Profiler
=========================

-------------
Overview
-------------

A MiniProfiler integration has been included in the ``Jabberwocky.Autofac.Extras.MiniProfiler`` nuget package.

By installing this package, you will be provided with deep profiling telemetry of all of your code.  It provides timing information for each of your classes' methods, allowing you to examine where the most time is spent in your code.

Depending on how you set this up, you can choose to have this enabled only on certain environments, or even configure it to switch on and off on Production environments to troubleshoot performance issues.


-------------
Module Setup
-------------

This integration takes the form of an Autofac Module, and can be installed with a single line:

.. code-block:: c#

	builder.RegisterModule(new MiniProfilerModule("YOURPROJECT.Library", "YOURPROJECT.Web"));

.. note:: Be sure that you have included the ``Jabberwocky.Autofac.Extras.MiniProfiler`` nuget package in your Website project, otherwise you won't have access to the module.

As an example, you can consider conditionally enabling/disabling the module based on the DEBUG compiler flag:

.. code-block:: c#
	
	#if DEBUG
			builder.RegisterModule(new MiniProfilerModule("YOURPROJECT.Web"));
	#endif

----------------
Configuration
----------------

There are multiple configuration options for the MiniProfiler integration.  First and foremost, you must specify which assemblies to instrument.  The MiniProfiler module will only provide profiling information for types found in those assemblies.

.. important:: If you are also using the Glass Interface Factory, and wish to profile the Glass Interface Types, then you should use the MiniProfileModule's constructor that accepts an array of ``IProxyStrategy`` types, and pass in a new instance of the following type: ``GlassInterfaceFactoryStrategy``.

The available configuration options (in reverse order of precendence):

#. **assemblies**: Specifies which assemblies to instrument
#. **includeNamespaces**: Specifies root namespaces to instrument types from (filtered by assemblies)
#. **excludeNamespaces**: Excludes specific root namespaces from instrumentation
#. **excludeTypes**: Excludes specific types from instrumentation
#. **excludeAssemblies**: Excludes specific assemblies from instrumentation
#. **strategies**: Allows for specifying new strategies for generating proxies for instrumentation

The ``strategies`` parameter is provided in case you ever need to extend the proxy implementation. As with the ``GlassInterfaceFactoryStrategy``, if there is a specific use case where you need to change the proxy behavior, you can do so by creating your own strategy.

.. note::  The order of the strategies matters, as the selection algorithm will use the first strategy that returns true when ``CanHandle`` is called.

-------------------
MiniProfiler Setup
-------------------

To configure MiniProfiler itself, you will need to follow the `instructions here <http://miniprofiler.com/>`_

In short, on your primary base layout, add the following directive (**RenderIncludes**):

.. code-block:: c#

	@using StackExchange.Profiling;
	<head>
	 ..
	</head>
	<body>
	  ...
	  @MiniProfiler.RenderIncludes()
	</body>

Then add the following to your Global.asax(.cs):

.. code-block:: c#

	
	#if DEBUG
		protected void Application_BeginRequest()
		{
			if (Sitecore.Context.Item != null && !Sitecore.Context.PageMode.IsPageEditorEditing 
				&& !Sitecore.Context.PageMode.IsPreview)
			{
				MiniProfiler.Start();
			}
		}

		protected void Application_EndRequest()
		{
			MiniProfiler.Stop();
		}
	#endif

Like in the example, you can optionally choose to include the conditional preprocessor directives to only enable profiling when the ``DEBUG`` compiler flag is set to ``true``.