---------------------
Implementation Guide
---------------------

There are two pieces to implement when using the **Glass Interface Factory**:

	* Glass Factory **Interface**
	* Glass Factory **Type**

The **Glass Factory Interface** defines the adapter contract (like any other interface), and the **Glass Factory Type** implements the interface, and binds it to a specific Glass Mapper model type.

This is accomplished by using two attributes:

	* ``GlassFactoryInterfaceAttribute``
	* ``GlassFactoryTypeAttribute``

You can apply these attributes to an **interface** and a **class** for each of the ``GlassFactoryInterfaceAttribute`` and ``GlassFactoryTypeAttribute`` respectively.

Check out the respective pages below for instructions on how to implement and use each of these types:

.. toctree::
   :titlesonly:

   glass-factory-interface
   glass-factory-type