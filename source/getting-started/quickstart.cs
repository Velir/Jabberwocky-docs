public class AutofacConfig
{
	public static void Start()
	{
		var builder = new ContainerBuilder();

		builder.RegisterGlassServices();
		builder.RegisterCacheServices();
		builder.RegisterProcessors(Assembly.Load("YOURPROJECT.Library"));
		builder.RegisterGlassMvcServices("YOURPROJECT.Web");
		builder.RegisterGlassFactory("YOURPROJECT.Library");
		builder.RegisterApiControllers(Assembly.GetExecutingAssembly());
		builder.RegisterControllers(Assembly.GetExecutingAssembly());

		// Module registrations
		builder.RegisterModule(new MiniProfilerModule("YOURPROJECT.Library", "YOURPROJECT.Web"));
		builder.RegisterModule(new LogInjectionModule<ILog>(LogManager.GetLogger);

		// Custom Registrations

		// This is necessary to 'seal' the container, and make it resolvable from the AutofacStartup.ServiceLocator singleton
		IContainer container = builder.Build();
		container.RegisterContainer();

		// Create the dependency resolver.
		var resolver = new AutofacWebApiDependencyResolver(container);

		// Configure Web API with the dependency resolver.
		GlobalConfiguration.Configuration.DependencyResolver = resolver;

		// Configure the MVC dependency resolver
		DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
	}
}