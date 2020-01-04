# overHere docs: Map resources

Go to
* [Resources](resources.md "Resources")
* [Overview](../README.md "Overview")

## overHere Map resources

* [MapView](#mapview "MapView")
* [RouteMap](#routemap "RouteMap")
* [MapStatistics](#mapstatistics "MapStatistics")
* [RegionMap](#regionmap "RegionMap")

<a name="mapview" />

### MapView

| Class | Source Location | Based on | Here API reference | Asynchronous |
| --- | --- | --- | --- | --- |
| oh_MapView | [mapview.prg](../source/api/maps/mapview.prg "mapview.prg") | [oh_MapImageTextPOI](../source/api/maps/mapimagetextpoi.prg "oh_MapImageTextPOI") | [MapView resource](https://developer.here.com/documentation/map-image/topics/resource-map.html "MapView Resource") | Disabled |

| Method | Args | Result | Notes |
| --- | --- | --- | --- |
| GetImage | Request AS Logical | Blob (0h if failed) | `m.Request` = .T. if image is to be requested from server, otherwise from previous request if available |
| Request | - | Logical (.T. if success) | - |

| Response property | Type |
| --- | --- |
| PictureObject | Image |

| Parameter | Based on | Aggregator | Here name |
| --- | --- | --- | --- |
| BoundingBox | [oh_GeoCoordinatesListType](datatypes_base.md#oh_GeoCoordinatesListType "oh_GeoCoordinatesListType") | - | bbox |
| CityName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | ci |
| CountryName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | co |
| CustomText | [oh_CustomTextCoordType](datatypes_maps.md#oh_CustomTextCoordType "oh_CustomTextCoordType") | Collection | txc |
| CustomTextConfig | [oh_CustomTextConfigType](datatypes_maps.md#oh_CustomTextConfigType "oh_CustomTextConfigType") | - | txc |
| CustomTextXY | [oh_CustomTextXYType](datatypes_maps.md#oh_CustomTextXYType "oh_CustomTextXYType") | Collection | tx.xy |
| HouseNumber | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | n |
| ImageCompression | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | q |
| ImageFormat | [oh_ImageFormatType](datatypes_maps.md#oh_ImageFormatType "oh_ImageFormatType") | - | f |
| ImageHeight | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | h |
| ImageWidth | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | w |
| Information | [oh_BooleanType](datatypes_base.md#oh_BooleanType "oh_BooleanType") | - | i |
| Language | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | ml |
| Latitude | [oh_LatitudeType](datatypes_base.md#oh_LatitudeType "oh_LatitudeType") | - | lat |
| Longitude | [oh_LongitudeType](datatypes_base.md#oh_LongitudeType "oh_LongitudeType") | - | lon |
| MapCenter | [oh_GeoCoordinateType](datatypes_base.md#oh_GeoCoordinateType "oh_GeoCoordinateType") | - | ctr, ectr |
| MapScheme | [oh_MapSchemeType](datatypes_maps.md#oh_MapSchemeType "oh_MapSchemeType") | - | t |
| MaxHits | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | maxhits |
| OtherLanguage | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | ml2 |
| PictureInPicture | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | pip |
| PointsOfInterest | [oh_PointOfInterestType](datatypes_maps.md#oh_PointOfInterestType "oh_PointOfInterestType") | Collection | poi |
| PointsOfInterestConfig | [oh_PointOfInterestConfigType](datatypes_maps.md#oh_PointOfInterestConfigType "oh_PointOfInterestConfigType") | - | poitxs, poitxc, poifc, poilbl, poithm |
| PointsOfInterestMarks | [oh_GeoCoordinateType](datatypes_base.md#oh_GeoCoordinateType "oh_GeoCoordinateType") | Collection | poix |
| PoliticalView | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | pview |
| PositionCoord | [oh_GeoCoordinateType](datatypes_base.md#oh_GeoCoordinateType "oh_GeoCoordinateType") | - | c, e |
| PostalCode | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | zi |
| Radius | [oh_DistanceType](datatypes_base.md#oh_DistanceType "oh_DistanceType") | - | rad |
| Resolution | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | ppi |
| RotationAngle | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType") | - | ra |
| ScaleBars | [oh_ScaleBarsType](datatypes_maps.md#oh_ScaleBarsType "oh_ScaleBarsType") | - | sb |
| StreetName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | s |
| UncertainRadius | [oh_DistanceType](datatypes_base.md#oh_DistanceType "oh_DistanceType") | - | u |
| ViewType | [oh_MapViewType](datatypes_maps.md#oh_MapViewType "oh_MapViewType") | - | vt |
| ZoomLevel | [oh_ZoomLevelType](datatypes_maps.md#oh_ZoomLevelType "oh_ZoomLevelType") | - | z |

<a name="routemap" />

### RouteMap

| Class | Source Location | Based on | Here API reference | Asynchronous |
| --- | --- | --- | --- | --- |
| oh_RouteMap | [maproute.prg](../source/api/maps/maproute.prg "maproute.prg") | [oh_MapImagePOI](../source/api/maps/mapimagepoi.prg "oh_MapImagePOI") | [Route resource](https://developer.here.com/documentation/map-image/topics/resource-route.html "Route Resource") | Disabled |

| Method | Args | Result | Notes |
| --- | --- | --- | --- |
| GetImage | Request AS Logical | Blob (0h if failed) | `m.Request` = .T. if image is to be requested from server, otherwise from previous request if available |
| Request | - | Logical (.T. if success) | - |

| Response property | Type |
| --- | --- |
| PictureObject | Image |

| Parameter | Based on | Aggregator | Here name |
| --- | --- | --- | --- |
| ImageCompression | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | q |
| ImageFormat | [oh_ImageFormatType](datatypes_maps.md#oh_ImageFormatType "oh_ImageFormatType") | - | f |
| ImageHeight | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | h |
| ImageWidth | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | w |
| Language | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | ml |
| MapCenter | [oh_GeoCoordinateType](datatypes_base.md#oh_GeoCoordinateType "oh_GeoCoordinateType") | - | ctr, ectr |
| MapScheme | [oh_MapSchemeType](datatypes_maps.md#oh_MapSchemeType "oh_MapSchemeType") | - | t |
| PointsOfInterest | [oh_PointOfInterestType](datatypes_maps.md#oh_PointOfInterestType "oh_PointOfInterestType") | Collection | poi |
| PointsOfInterestConfig | [oh_PointOfInterestConfigType](datatypes_maps.md#oh_PointOfInterestConfigType "oh_PointOfInterestConfigType") | - | poitxs, poitxc, poifc, poilbl, poithm |
| PointsOfInterestMarks | [oh_GeoCoordinateType](datatypes_base.md#oh_GeoCoordinateType "oh_GeoCoordinateType") | Collection | poix |
| PoliticalView | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | pview |
| Resolution | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | ppi |
| RouteMarkerConfig | [oh_MapRouteMarkerGroupConfigType](datatypes_maps.md#oh_MapRouteMarkerGroupConfigType "oh_MapRouteMarkerGroupConfigType") | - | mlbl, mthm |
| Routes | [oh_MapRouteMarkerGroupType](datatypes_maps.md#oh_MapRouteMarkerGroupType "oh_MapRouteMarkerGroupType") | Collection | r, m, lc, lw, sc, mfc, mtxc, mtxs |
| ZoomLevel | [oh_ZoomLevelType](datatypes_maps.md#oh_ZoomLevelType "oh_ZoomLevelType") | - | z |

<a name="mapstatistics" />

### MapStatistics

| Class | Source Location | Based on | Here API reference | Asynchronous |
| --- | --- | --- | --- | --- |
| oh_MapStatistics | [statistics.prg](../source/api/maps/statistics.prg "statistics.prg") | [oh_MapImageText](../source/api/maps/mapimagetext.prg "oh_MapImageText") | [Statistics resource](https://developer.here.com/documentation/map-image/topics/resource-stat.html "Statistics Resource") | Disabled |

| Method | Args | Result | Notes |
| --- | --- | --- | --- |
| GetImage | Request AS Logical | Blob (0h if failed) | `m.Request` = .T. if image is to be requested from server, otherwise from previous request if available |
| Request | - | Logical (.T. if success) | - |

| Response property | Type |
| --- | --- |
| PictureObject | Image |

| Parameter | Based on | Aggregator | Here name |
| --- | --- | --- | --- |
| CustomText | [oh_CustomTextCoordType](datatypes_maps.md#oh_CustomTextCoordType "oh_CustomTextCoordType") | Collection | txc |
| CustomTextConfig | [oh_CustomTextConfigType](datatypes_maps.md#oh_CustomTextConfigType "oh_CustomTextConfigType") | - | txc |
| CustomTextXY | [oh_CustomTextXYType](datatypes_maps.md#oh_CustomTextXYType "oh_CustomTextXYType") | Collection | tx.xy |
| GraphObjects | [oh_GraphObjectType](datatypes_maps.md#oh_GraphObjectType "oh_GraphObjectType") | Collection | ofc |
| GraphObjectsConfig | [oh_GraphObjectConfigType](datatypes_maps.md#oh_GraphObjectConfigType "oh_GraphObjectConfigType") | - | ofc, osc, olp, ot |
| ImageCompression | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | q |
| ImageFormat | [oh_ImageFormatType](datatypes_maps.md#oh_ImageFormatType "oh_ImageFormatType") | - | f |
| ImageHeight | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | h |
| ImageWidth | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | w |
| Language | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | ml |
| MapScheme | [oh_MapSchemeType](datatypes_maps.md#oh_MapSchemeType "oh_MapSchemeType") | - | t |
| PoliticalView | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | pview |
| Resolution | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | ppi |
| ZoomLevel | [oh_ZoomLevelType](datatypes_maps.md#oh_ZoomLevelType "oh_ZoomLevelType") | - | z |

<a name="regionmap" />

### RegionMap

| Class | Source Location | Based on | Here API reference | Asynchronous |
| --- | --- | --- | --- | --- |
| oh_RegionMap | [mapregion.prg](../source/api/maps/mapregion.prg "mapregion.prg") | [oh_MapImageText](../source/api/maps/mapimagetext.prg "oh_MapImageText") | [Region resource](https://developer.here.com/documentation/map-image/topics/resource-region.html "Region Resource") | Disabled |

| Method | Args | Result | Notes |
| --- | --- | --- | --- |
| GetImage | Request AS Logical | Blob (0h if failed) | `m.Request` = .T. if image is to be requested from server, otherwise from previous request if available |
| Request | - | Logical (.T. if success) | - |

| Response property | Type |
| --- | --- |
| PictureObject | Image |

| Parameter | Based on | Aggregator | Here name |
| --- | --- | --- | --- |
| CustomText | [oh_CustomTextCoordType](datatypes_maps.md#oh_CustomTextCoordType "oh_CustomTextCoordType") | Collection | txc |
| CustomTextConfig | [oh_CustomTextConfigType](datatypes_maps.md#oh_CustomTextConfigType "oh_CustomTextConfigType") | - | txc |
| CustomTextXY | [oh_CustomTextXYType](datatypes_maps.md#oh_CustomTextXYType "oh_CustomTextXYType") | Collection | tx.xy |
| ImageCompression | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | q |
| ImageFormat | [oh_ImageFormatType](datatypes_maps.md#oh_ImageFormatType "oh_ImageFormatType") | - | f |
| ImageHeight | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | h |
| ImageWidth | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | w |
| Language | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | ml |
| MapScheme | [oh_MapSchemeType](datatypes_maps.md#oh_MapSchemeType "oh_MapSchemeType") | - | t |
| PoliticalView | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | pview |
| Regions | [oh_MapRegionType](datatypes_maps.md#oh_MapRegionType "oh_MapRegionType") | Collection | a, fc, lc, lw, rad |
| Resolution | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | ppi |
| ZoomLevel | [oh_ZoomLevelType](datatypes_maps.md#oh_ZoomLevelType "oh_ZoomLevelType") | - | z |
