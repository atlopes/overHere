# overHere docs:  Datatypes

Go to

- [Base datatypes](datatypes_base.md "Base datatypes")
- [Maps datatypes](datatypes_maps.md "Maps datatypes")
- [Geocode datatypes](datatypes_geocode.md "Geocode datatypes")
- [Route datatypes](datatypes_base.md "Route datatypes")

## overHere Datatypes

The OH datatypes are classes of objects used to parameterize the access to Here resources and to store most of the information that the location platform returns (images being the exception).

The value of the objects can be assigned with Set() and Parse() methods and accessed with Get() and ToString() methods.

For instance, to assign the value “Paris” to an object of the oh_StringType datatype, use the Set() method
```foxpro
m.someStrObject.Set("Paris")
```
For more complex types that don’t have a direct mapping to VFP scalar datatypes, like the oh_GeoCoordinateType, the Set() method may expect other parameters needed to assign the value of the object completely.
```foxpro
m.someCoordObject.Set(52.475, 0.0001)
```
For this kind of types, the Parse() method may also a comfortable option to assign the value, especially if the platform returned the value to set in a previous operation.
```foxpro
m.someGeoCoordObject.Parse("52.475,0.0001")
```
In general, programs may assign individual elements of lists with Set() methods, or assemble the complete list with a single Parse(). These two snippets are equivalent:
```foxpro
m.someListObject.Set("pp")
m.someListObject.Set("pl")
```
```foxpro
m.someListObject.Parse("pp,pl")
```
The Get() methods of the objects return the object’s value, while ToString() returns the value’s textual representation (most of the times in the form that is passed to OH resources). When the  value of the object has not been set, Get() returns NULL, and ToString() returns an empty string.
