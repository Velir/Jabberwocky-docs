------------------------
Glass Factory Interface
------------------------

The **Glass Factory Interface** should encapsulate common business functionality that should have potential applications across multilple Sitecore templates.

For instance, the canonical example would be an interface to adapt Sitecore items as listable items, usable within search listings across the site.

We might name this interface ``IListable``, and we could define it like so:

.. code-block:: c#
	
	[GlassFactoryInterface]
	public interface IListable
	{
		string ListTitle { get; }
		string Url { get; }
		string Topic { get; }
		string DisplayDate { get; }
		string Author { get; }
		string ListImage { get; }
	}

The goal here is to encapsulate all of the information that we might need in order to display an arbitrary Sitecore item within a listing component on the site.

.. important:: Notice that the interface is decorated with the  ``[GlassFactoryInterface]`` attribute.  This is required in order to use this interface with the Glass Interface Factory.

We can include arbitrary functions or properties in the interface declaration, however convention dictates that we make all properties **get-only**.  It is also a best-practice to ensure that all exposed functions and properties have no side-effects - ie. they are `pure functions <https://en.wikipedia.org/wiki/Pure_function>`_.

In the next section, we'll examine how to implement this functionality, and bind it to specific Sitecore templates.