# overHere docs: Resources

Go to
* [Maps resources](resources_maps.md "Maps")
* [Geocode resources](resources_geocode.md "Geocode")
* [Route resources](resources_route.md "Route")
* [Overview](../README.md "Overview")

## overHere Resources

The OH resources are classes of objects used to access the Web services of the Here location platform.

A resource contains a set of objects based on OH datatypes that are used to parameterize the access and to store the result in the cases that the platform returns structured information instead of an image.

Resources are instantiated through an overHere object (see next section) by calling the `SetResource()` method. After the manager instantiates and returns a resource object, the application may set the value of the resource's parameters and may execute the method that communicates with the Here location platform.

## The overHere manager class

The `overHere` class lays the foundations of access to the Here platform.

It provides the resource classes with methods to compose a request and to call a platform service.

For regular, synchronous calls (that is, where the application waits for a call to finish to resume execution), resource objects instantiated by the manager are fully detached, and the application can release them freely when it has no more need for them.

For asynchronous calls, the manager object guarantees that the caller resource object is not released, even if defined as local at some program or method, by maintaining a persistent reference that keeps the object alive.

Usually, the only methods that applications need to know about are `SetCredentials()` to identify the application or installation at the Here platform, and `SetResource()` to create a resource object. Regular operations use the resource object, afterward.

### Example code

```foxpro
m.oh = CREATEOBJECT("overHere")
m.oh.SetCredentials("{API Key}")
m.gc = m.oh.SetResource("GeocodeSearch")
```

