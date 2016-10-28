-----------------
View Renderings
-----------------

Setup
--------------

Getting started with **View Renderings** is easy.  All you need to do is register the ``RegisterGlassMvcServices`` extension method with Autofac, and create a few Views and ViewModels.

Registering the services with Autofac is as simple as: 

.. code-block:: c#

	builder.RegisterGlassMvcServices("YOURPROJECT.Web");

.. note:: If you followed the instructions in the :doc:`../getting-started/quickstart`, then you should already have this extension method registered, and the appropriate config file in your App_Config/Include directory.


Creating a View
-----------------

Creating a View is as easy as adding a new Razor View to your web project.  You should then use the ``@inherits`` directive to specify the base type for the View.  We recommend using the ``CustomGlassView<T>`` like so:

.. code-block:: c#

	@inherits Jabberwocky.Glass.Autofac.Mvc.Views.CustomGlassView<MyViewModel>

The generic type parameter is the type of your ViewModel.


Creating a ViewModel
---------------------

A ViewModel is simply a class that inherits from the ``GlassViewModel<T>`` base class.  The generic type parameter for the ``GlassViewModel<T>`` is the type of Glass Mapper model to use as the ``GlassModel`` property.  This allows you to, from your View, access your ViewModel from the ``Model`` property, or your Glass Mapper model from your ``Model.GlassModel`` property.

If you don't have a need for a particular Glass Mapper model in your View, but you still want to use a ViewModel, you can do so by specifying the generic type parameter as ``IGlassBase``, which all Sitecore items should be assignment compatible with.

Because your View is now decoupled from your Glass Mapper model, and instead is using your custom ViewModel, you can also elect to use constructor injection within your ViewModel.  This allows you to pull in arbitrary dependencies in your ViewModel to write logic that dictates specific behavior for your View, without having to resort to polluting your Glass Mapper models (or creating one-off extension methods) with view-specific logic.

In the :doc:`next section<view-model>`, we'll look at some of the advanced options available to you when using the Jabberwocky View Model pattern.