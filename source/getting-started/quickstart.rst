=============
Quickstart
=============

If you are starting a new project, you will want to download the Jabberwocky packages from the Velir Nuget feed.

If you haven't yet set that up, you'll want to go to Visual Studio -> Tools -> Options -> NuGet Package Manager -> Package Sources

Then you'll want to add 'http://nuget.velir.com/nuget' as a feed (you can also name the feed 'Velir').

If you're starting a new MVC project, you can start by just including the **Jabberwocky.Glass.Autofac.Mvc** package into your website project.  If you're not using MVC, you can include the **Jabberwocky.Glass.Autofac** project instead.

You will also want to pull in the **Glass.Mapper.Sc** package.  This will allow you to setup your Glass Models and configure the attribute loader in the GlassMapperScCustom.cs file.

.. note:: For instructions on setting up Glass.Mapper, `refer to the guide here <http://glass.lu/Mapper/Sc/Tutorials/Tutorial1>`_.

Notice that in either case, we're going to assume you'll be using the common stack of **Glass.Mapper** and **Autofac**.

The first thing that you'll want to do is create a new folder in the root of your Website project, called 'App_Start'.  In this folder, you'll want to create a new class, called **AutofacConfig**.

You can use the following as a template:

.. literalinclude:: quickstart.cs
	:language: c#

.. note:: If you are going to use the ``MiniProfilerModule`` like in the sample above, you will also need to include the ``Jabberwocky.Autofac.Extras.MiniProfiler`` nuget package.