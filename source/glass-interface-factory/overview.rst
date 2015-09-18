-------------------
Overview
-------------------

Introduction
-------------

The Glass Interface Factory is a re-imagining of the (Custom) Item Interface Factory.

It is built to work with **Glass Mapper** items, and is intended to be used with auto-generated glass templates (ie. with **TDS**).

In essence, it provides services that can be thought of as codifying both the **Adapter** and (more loosely) **Dynamic/Multi-Dispatch** patterns into a single easy to use framework.

What this means in practice is that you can now easily encapsulate business logic that should apply to specific Sitecore templates within common **interfaces**.  With those defined, you can then create implementations of those interfaces for a given Sitecore template.  This defines the **adapter pattern** part.

.. note:: The **interfaces** and **implementations** of those interfaces referred to above, are called the **Glass Factory Interface** and **Glass Factory Type** respectively.

The real magic occurs when you consider the Sitecore template hierarchy.  Using a form of **dynamic dispatch**, we can create faux object-inheritance hierarchies between implementations of these **interfaces**.  

Because each **Glass Factory Type** is an adapter for a particular Sitecore template, when a particular function is not implemented for a particular **Glass Factory Type**, we can search the base template hierarchy for that particular template to see if there exists another **Glass Factory Type** that both implements the specified **Glass Factory Interface**, and acts an adapter for a base Sitecore template of the original template.

This allows us to write code once and apply common behavior to base Sitecore templates, while letting us also override said behavior as needed on more derived Sitecore templates.

You can find more information on how this works in the :doc:`implementation` section.

Implementations
---------------

There are two primary implementations of the Glass Interface Factory to allow for use both with, and without Autofac.

In both cases, a factory **builder** is provided for ease of setup:

* Without Autofac: ``DefaultGlassFactoryBuilder``
* With Autofac: ``AutofacGlassFactoryBuilder``

.. note:: If you followed the :doc:`quickstart guide <../getting-started/quickstart>`, then you don't need to use any builders directly.  Instead, the ``builder.RegisterGlassFactory()`` extension will automatically register the ``IGlassInterfaceFactory`` service for you, and will handle construction of the factory.

The next section will cover setting up the factory.