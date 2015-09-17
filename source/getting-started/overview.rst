Jabberwocky Overview
======================

The following packages are included as part of the Jabberwocky library suite.

The **core libraries** represent the common stack for developing on all new Sitecore solutions.  The **extra libraries** are recommended (but entirely optional), and include specific features that can be included in solutions piecemeal.

Core Libraries
-------------------

* Jabberwocky.Core
* Jabberwocky.Autofac
* Jabberwocky.Glass
* Jabberwocky.Glass.Autofac
* Jabberwocky.Glass.Autofac.Mvc
* Jabberwocky.WebApi


Extra Libraries
-------------------

* Jabberwocky.Autofac.Extras.MiniProfiler


Dependency Graph
-------------------

The naming convention for each project attempts to make clear its dependencies.

For instance, the **Jabberwocky.Core** library contains no dependencies, and can be included in any standard .NET project.

Similar to the Core project, the **Jabberwocky.Autofac** project has no external dependencies other than **Jabberwocky.Core** and Autofac, and by extension, its dependencies (ie. Castle.Core).  This means that the **Jabberwocky.Autofac** project may be used outside of Sitecore projects, wherever IoC may be desirable.

The **Jabberwocky.WebApi** project also has no dependencies other than on **Jabberwocky.Core**, and WebApi.

The remaining **Jabberwocky.Glass.\*** projects all rely on Glass Mapper, with each subsequent package relying on more and more dependencies (Autofac, MVC), and are meant to bootstrap and codify Sitecore development with a common set of patterns and practices.