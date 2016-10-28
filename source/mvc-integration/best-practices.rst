--------------------
Best Practices
--------------------

For simplicity's sake, and as a general rule of thumb, we recommend developing primarily against View Renderings when using Sitecore MVC.

The reason for this is that we can rely on a few utilities in the Jabberwocky libraries to greatly reduce the amount of boilerplate we need to write in order to create a rendering.  With a View Rendering, all we need to do is create a **View** (razor cshtml file), and a **ViewModel** (a class that inherits from ``GlassViewModel<T>``).  The actual binding of the model to the view (which normally occurs in the Controller code) happens automatically in the case of Jabberwocky's ``GlassViewModel<T>``. 

Contrast this to **Controller Renderings**, which are much more aligned with standard MVC, but require the addition of a Controller class.  The downside to this approach is that you have to manually construct a model, populate it's values, and pass it off to the view itself, which becomes tedious and time consuming with the more components you have.  Therefore, the primary reason to use a Controller Rendering over a View Rendering would be in situations requiring handling of post-backs (or GET-requests with complicated query string parsing).  Otherwise, for simple components, View Renderings are the way to go.

On the topic of **ViewModels**, the approach we are recommending is more in line with Model-View-Presenter (MVP), or more loosely, Model-View-ViewModel (MVVM).

When using the **View Rendering** approach to developing components for Sitecore MVC, using a **ViewModel** over a straight up Glass Mapper model offers many benefits, the biggest of which is probably that you can choose to create a ViewModel that composes *multiple* Glass Mapper models.  This makes it easier to develop a component that has *more* than one data source.  Furthermore, using a ViewModel as opposed to the direct Glass Mapper model allows you to implement View-specific logic within your ViewModel --  logic which might not make sense to put within the Glass Mapper model itself.