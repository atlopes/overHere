# overHere docs: Fleet Telematics resources

Go to
* [Resources](resources.md "Resources")
* [Overview](../README.md "Overview")

## overHere Fleet Telematics resources
* [FindSequence](#findsequence "FindSequence")

<a name="findsequence" />

### FindSequence

| Class | Source Location | Based on | Here API reference | Asynchronous |
| --- | --- | --- | --- | --- |
| oh_FindSequence | [findsequence.prg](../source/api/routing/findsequence.prg "findsequence.prg") | [oh_FleetTelematicsResource](../source/api/routing/fleet.prg "oh_FleetTelematicsResource") | [Waypoints Sequence](https://developer.here.com/documentation/routing-waypoints/dev_guide/topics/what-is.html "Waypoints Sequence") | Disabled |

| Method | Args | Result | Notes |
| --- | --- | --- | --- |
| Find | Request AS Logical | [oh_FindWaypointsResponseType](datatypes_fleet.md#oh_FindWaypointsResponseType "oh_FindWaypointsResponseType") (.NULL. if failed) | `m.Request` = .T. if sequence is to be requested from server, otherwise from previous request if available |
| Request | - | Logical (.T. if success) | - |

| Response property | Type |
| --- | --- |
| Sequence | [oh_FindWaypointsResponseType](datatypes_fleet.md#oh_FindWaypointsResponseType "oh_FindWaypointsResponseType") |

| Parameter | Based on | Aggregator | Here name |
| --- | --- | --- | --- |
| AvoidAreas | [oh_GeoBoundingBoxArrayType](datatypes_base.md#oh_GeoBoundingBoxArrayType "oh_GeoBoundingBoxArrayType") | - | avoidareas |
| AvoidLinks | [oh_LinkIdsListType](datatypes_base.md#oh_LinkIdsListType "oh_LinkIdsListType") | - | avoidlinks |
| Departure | [oh_DatetimeType](datatypes_base.md#oh_DatetimeType "oh_DatetimeType") | - | departure |
| Destinations | [oh_WaypointWithIdType](datatypes_fleet.md#oh_WaypointWithIdType "oh_WaypointWithIdType") | Collection | destination |
| End | [oh_WaypointWithIdType](datatypes_fleet.md#oh_WaypointWithIdType "oh_WaypointWithIdType") | - | end |
| HazardousGoods | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | shippedhazardousgoods |
| ImproveFor | [oh_ImproveForType](datatypes_fleet.md#oh_ImproveForType "oh_ImproveForType") | - | improveFor |
| LimitedWeight | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | limitedweight |
| Mode | [oh_RoutingModeType](datatypes_route.md#oh_RoutingModeType "oh_RoutingModeType") | - | mode |
| RequestId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | requestId |
| RestTimes | [oh_DrivingRestTimeType](datatypes_fleet.md#oh_DrivingRestTimeType "oh_DrivingRestTimeType") | - | restTimes |
| Start | [oh_WaypointWithIdType](datatypes_fleet.md#oh_WaypointWithIdType "oh_WaypointWithIdType") | - | start |
| TruckHeight | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | height |
| TruckLength | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | length |
| TruckType | [oh_TruckTypeType](datatypes_route.md#oh_TruckTypeType "oh_TruckTypeType") | - | trucktype |
| TruckWidth | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | width |
| TunnelCategory | [oh_TunnelCategoryType](datatypes_route.md#oh_TunnelCategoryType "oh_TunnelCategoryType") | - | tunnelcategory |
| WalkSpeed | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType") | - | walkspeed |
| WeightPerAxle | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | weightperaxle |

