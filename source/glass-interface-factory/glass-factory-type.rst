----------------------------
Glass Factory Type
----------------------------

The **Glass Factory Type** should implement the specific functionality defined in one or more **Glass Factory Interfaces**.

Requirements
--------------

In order to create a **Glass Factory Type**, the implementing class must satisfy the following criteria:

	#. Be marked ``abstract``
	#. Be decorated with the ``GlassFactoryTypeAttriute``
	#. Specify a valid Glass Mapper type in the ``GlassFactoryTypeAttribute``'s parameter

.. note:: You can also optionally inherit from the ``BaseInterface<T>`` abstract class.  Doing so allows you to access the underlying Glass Model via a ``InnerItem`` property.

Example
----------

Continuing on from the ``IListable`` example in the previous section, let's assume we have the following template hierarchy in Sitecore (indented lines represent nested base templates):

1. Article Page Template
	* Global Page Template

2. Blog Post Template
	* Global Page Template

With such a template hierarchy, we can start to implement our ``IListable`` interface for any of the given templates.

Here's an example of what our implementation of ``IListable`` might look like as it pertains to the **Article Page Template**.

.. code-block:: c#

	[GlassFactoryType(typeof(IArticlePage))]
	public abstract class ArticlePageModel : BaseInterface<IArticlePage>, IListable
	{
		public ArticlePageModel(IArticlePage model) : base(model)
		{			
		}

		public abstract string ListTitle { get; }
		public abstract string Url { get; }
		public abstract string Topic { get; }
		public abstract string DisplayDate { get; }

		public string Author
		{
			get { return InnerItem.Authors; }
		}

		public abstract string ListImage { get; }
	}

Notice that the ``GlassFactoryTypeAttribute`` has the ``typeof(IArticlePage)`` parameter defined.  This binds the implementation to that particular Sitecore template.

.. important:: If you elect to inherit from the (recommended) ``BaseInterface<T>``, then you must ensure that the generic type param ``T`` matches the parameter in the ``GlassFactoryTypeAttribute``.

What's important to note here is that the class is marked ``abstract``, and you only need implement the specific functionality that may differ from the base functionality.  In this case, only the ``Author`` property has been implemented (by returning the underlying ``IArticlePage``'s ``Authors`` field value.)

All of the other properties have been marked as ``abstract``, and by doing this it is assumed that one of the underlying base-templates of the **Article Page Template** will implement this functionality.


Fall-back Behavior
---------------------

For any given property or function that is not implemented for a given **Glass Factory Type**, it is assumed that the implementation must lie in another **Glass Factory Type** that is bound to a base template.  When this is the case, the Glass Interface Factory will dynamically dispatch calls to these 'unimplemented' functions to base-template implementations.

This behavior is referred to as **fall-back** behavior, and is a powerful feature of the **Glass Interface Factory**.

With this feature, we can write common units of business logic, and apply those to common base templates in Sitecore.  Whenever a specific template that inherits from these base templates needs different logic, we can simply change the logic in the corresponding **Glass Factory Type** implementation, without affecting any of the base template logic.  Any functions that don't require special logic need not change, since by marking them as ``abstract``, we automatically gain the ability to inherit the functionality from existing base template implementations.

Given the ``ArticlePageModel`` definition above, if we were to define an implementation of ``IListable`` for the  **Global Page Template**, then all of the functions marked as ``abstract`` in the ``ArticlePageModel`` would **fall-back** to the implementation in the ``GlobalPageModel``:

.. code-block:: c#

	[GlassFactoryType(typeof(IGlobalPage))]
	public abstract class GlobalPageModel : BaseInterface<IGlobalPage>, IListable
	{
		public GlobalPageModel(IArticlePage model) : base(model)
		{			
		}

		public string ListTitle => InnerItem.Title;
		public string string Url => InnerItem.Url;
		public string Topic => InnerItem.Topic;
		public string DisplayDate => InnerItem.PublishDate.ToString();

		public abstract string Author { get; }

		public string ListImage => InnerItem.ThumnailImage.Url;
	}

.. note:: If a property or function has no base implementation (because all implementors have marked it as ``abstract``), then the return value will simply be ``null``.