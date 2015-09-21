=====================
Inversion of Control
=====================

--------------
Overview
--------------

Inversion of Control (IoC) is a software design pattern that inverts the resposibility of the ownership and creation of dependencies.  It advocates for removing such direct dependencies from user code, and pushing the `flow of control out into a separate library or process <https://en.wikipedia.org/wiki/Inversion_of_control>`_.

Jabberwocky has a tight integration with **Autofac**, a library that enables Dependency Injection (DI, a specific form of IoC).

In order to improve upon the experience when working within these frameworks, Jabberwocky provides a few extensions and services to greatly ease the burden of development.

---------------------
Autowired Services
---------------------

One of the tedious parts of using DI frameworks is in registering your dependencies.

Consider the following code, which is standard for most DI Containers (like Autofac):

.. code-block:: c#

	var builder = new ContainerBuilder();
	builder.RegisterType<NavigationBuilder>().As<INavigationBuilder>().InstancePerLifetimeScope();
	builder.RegisterType<EmailService>().As<IEmailService>().InstancePerLifetimeScope();
	builder.RegisterType<AccountNotificationService>().As<INotificationService>().InstancePerLifetimeScope();

We can reduce the amount of boilerplate code required (like above) by using the provided ``AutowireServiceAttribute``.

You can decorate your concrete classes with this attribute, and you can replace all of the ``builder.RegisterType<>`` calls with a single line:

.. code-block:: c#
	
	builder.AutowireServices("YOUR.Library");

What this does it automatically scan the provided assemblies, and for each type that is decorated with ``AutowireServiceAttribute``, Jabberwocky with automatically register that type as each of its implemented interfaces.

So given a service with two interfaces, decorated with the ``AutowireServiceAttribute``:

.. code-block:: c#

	[AutowireService]
	public class MyService : IMyService, IAnotherService
	{
		// Implementation elided
	}

This would be equivalent to registering the following manually:

.. code-block:: c#

	builder.RegisterType<MyService>().As<IMyService>().As<IAnotherService>();


--------------
Configuration
--------------

The ``AutowireServiceAttribute`` class has a few optional parameters that can be supplied to it:

	* **Scope**: This represents the Lifetime Scope of the registration
	*  **IsAggregateService**: Whether or not the registration is for an *Aggregate Service*

**Scope** can have one of the following assignments:

 * **Default**: This has transient behavior; ie. one instance per dependency
 * **PerScope**: An instance per parent resolution scope
 * **PerRequest**: For web-based scenarios; instance per web request
 * **NoTracking**: Externally owned; will not be tracked by the container
 * **SingleInstance**: Singleton semantics

For more information on lifetime scopes in Autofac, `take a look at the documentation here <http://docs.autofac.org/en/latest/lifetime/index.html>`_.

**IsAggregateService** is a special case, and should be used on **interface** definitions.  It registers that a given interface as an **aggregate service**, which you can `read more about here <http://docs.autofac.org/en/latest/advanced/aggregate-services.html>`_.