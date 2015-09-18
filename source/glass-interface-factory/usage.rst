----------------------
Usage
----------------------

Once you have your **Glass Factory Interfaces** and **Glass Factory Types** defined and implemented, then you are ready to use the ``IGlassInterfaceFactory`` in your code:

.. code-block:: c#

	public IListable GetIListable(IGlassInterfaceFactory factory, 
		ISitecoreContext context) {

		var contextItem = context.GetItem<IGlassBase>(inferType: true);
		IListable listable = factory.GetItem<IListable>(contextItem);

		return listable;
	}

.. important:: Note that we use ``inferType: true`` when getting the current context item via Glass Mapper's ``ISitecoreContext`` service.  This ensures that the runtime type of the returned ``contextItem`` variable is set to the actual Glass Mapper model that matches the current item's Sitecore template.

In the example above, we assume that an ``IListable`` **Glass Factory Interface** has been defined, and that the current context item in Sitecore has a corresponding **Glass Factory Type** implementation.  If not, the ``factory.GetItem<IListable>`` will return null.