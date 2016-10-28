--------------------
The View Model
--------------------

There are three configurable components to the ViewModel:

#. The **DataSource**
#. The **Rendering Parameters**
#. The **nested datasource strategy**

DataSource
-------------------

The ``GlassViewModel<TDatasource>`` type is used for creating a view-model that expects a strongly typed datasource. This datasource should map to any datasource template type defined on the View Rendering in Sitecore itself.  

In the case where no datasource is specified, the type ``IGlassBase`` can be used, as all glass templates should inherit from this base type.

You can access the underlying Glass datasource model from the ``GlassModel`` property exposed on the ``GlassViewModel<TDatasource>`` type.

.. important:: Attempting to use the ``GlassModel`` property from within the constructor will result in a ``NullReferenceException``.  If you need access to the underlying datasource from within the constructor, use **constructor injection** instead, by including a constructor parameter of type ``TDatasource``.

Rendering Parameters
-------------------

**Rendering Parameters** provide a nice way to define another set of properties that can be used to configure a rendering.  These are defined separately in Sitecore via **Rendering Parameter Templates**, and are then assigned to View Renderings, independently of Datasource Templates.

You can use Rendering Parameters in a strongly-typed fashion by using the generic type of ``GlassViewModel<TDatasource, TRenderingParameter>``, which defines **two generic parameters**: the first, for the datasource template, and the second for the type of rendering parameters.

In this manner, you can access the rendering parameters of the rendering via the ``RenderingParameters`` property.

.. important:: As called out above in the Datasource section, if you need to access the **rendering parameters** from within the constructor, you **cannot** use the ``RenderingParameters`` property.  Instead, you can include a constructor argument of type ``TRenderingParameters``, which will be injected for you automatically.

Nested Datasource Strategy
-------------------

**Sitecore 8** introduced the concept of **nested datasources**.  Previously, if a rendering did not have a datasource specified, the ``Datasource`` property on that rendering would resolve to the current ``Context.Item``.  However, with Sitecore 8+, there is a new setting (enabled by default) that resolves a rendering's datasource to any parent rendering's datasource: 

.. code-block:: c# 

    <setting name="Mvc.AllowDataSourceNesting" value="true"/>

The resolution logic now looks like the following:

#. Explicit DataSource specified (in the Datasource field)
#. Nested DataSource (specified by the Rendering.Item property, and inherited from any parents)
#. Sitecore Context Item (page item)

Step 2 may be unexpected for many people used to pre-8.0 resolution logic (steps 1 & 3), as this was the new step added in Sitecore 8+.  To solve this, we have introduced the following attributes, each of which may be applied directly to a user-defined GlassViewModel.

* DisableNestedDatasource
* AllowNestedDatasource
* ConfigureDatasource

The third attribute (ConfigureDatasource) exposes a constructor param that dictates whether or not to use nested datasource resolution. The first two attributes are simply extensions of the ConfigureDatasource attribute, and are provided as shortcuts for their particular behavior.

.. note:: 

    The absence of any of these attributes indicates that the default Sitecore datasource resolution strategy should be used - this will be dictated by the value in the ``Mvc.AllowDataSourceNesting`` setting.

You can use these attributes on ViewModels like so:

.. code-block:: c#

    [DisableNestedDatasource]
    public class NeverFallbackViewModel : GlassViewModel<IGlassBase>
    {
        // PRE-Sitecore 8 behavior; ignores Mvc.AllowDataSourceNesting value

        // The datasource may come from the direct datasource, or Context Item
        // It will never be from the nested parent datasource
    }

or 

.. code-block:: c#

    [AllowNestedDatasource]
    public class AlwaysFallbackViewModel: GlassViewModel<IGlassBase>
    {
        // POST-Sitecore 8+ behavior; ignores Mvc.AllowDataSourceNesting value

        // The datasource may come from the direct datasource, or nested parent datasource
        // Or finally the Context Item
    }