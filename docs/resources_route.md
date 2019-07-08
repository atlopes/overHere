# overHere docs: Route resources

Go to
* [Resources](resources.md "Resources")
* [Overview](../README.md "Overview")

## overHere Route resources
* [CalculateRoute](#calculateroute "CalculateRoute")

<a name="calculateroute" />

### CalculateRoute

| Class | Source Location | Based on | Here API reference | Asynchronous |
| --- | --- | --- | --- | --- |
| oh_CalculateRoute | [calculate.prg](../source/api/routing/calculate.prg "calculate.prg") | [oh_RouteResource](../source/api/routing/route.prg "oh_RouteResource") | [Calculate Route resource](https://developer.here.com/documentation/routing/topics/resource-calculate-route.html "Calculate Route Resource") | Disabled |

| Method | Args | Result | Notes |
| --- | --- | --- | --- |
| Calculate | Request AS Logical | [oh_CalculateRouteResponseType](datatypes_route.md#oh_CalculateRouteResponseType "oh_CalculateRouteResponseType") (.NULL. if failed) | `m.Request` = .T. if route calculation is to be requested from server, otherwise from previous request if available |
| Request | - | Logical (.T. if success) | - |

| Response property | Type |
| --- | --- |
| Route | [oh_CalculateRouteResponseType](datatypes_route.md#oh_CalculateRouteResponseType "oh_CalculateRouteResponseType") |

| Parameter | Based on | Aggregator | Here name |
| --- | --- | --- | --- |
| Alternatives | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | alternatives |
| Arrival | [oh_DatetimeType](datatypes_base.md#oh_DatetimeType "oh_DatetimeType") | - | arrival |
| AvoidAreas | [oh_GeoBoundingBoxArrayType](datatypes_base.md#oh_GeoBoundingBoxArrayType "oh_GeoBoundingBoxArrayType") | - | avoidareas |
| AvoidLinks | [oh_LinkIdsListType](datatypes_base.md#oh_LinkIdsListType "oh_LinkIdsListType") | - | avoidlinks |
| AvoidSeasonalClosures | [oh_BooleanType](datatypes_base.md#oh_BooleanType "oh_BooleanType") | - | avoidseasonalclosures |
| AvoidTransportTypes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | avoidtransporttypes |
| AvoidTurns | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | avoidturns |
| CombineChange | [oh_BooleanType](datatypes_base.md#oh_BooleanType "oh_BooleanType") | - | combinechange |
| Departure | [oh_DatetimeType](datatypes_base.md#oh_DatetimeType "oh_DatetimeType") | - | departure |
| ExcludeCountries | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | excludecountries |
| ExcludeZoneTypes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | excludezonetypes |
| HazardousGoods | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | shippedhazardousgoods |
| InstructionFormat | [oh_InstructionFormatType](datatypes_route.md#oh_InstructionFormatType "oh_InstructionFormatType") | - | instructionFormat |
| Language | [oh_LanguageCodeType](datatypes_base.md#oh_LanguageCodeType "oh_LanguageCodeType") | - | language |
| LegAttrib | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | legattributes |
| LimitedWeight | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | limitedweight |
| LineAttrib | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | lineattributes |
| ManeuverAttrib | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | maneuverattributes |
| MaxNumberOfChanges | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | maxnumberofchanges |
| MetricSystem | [oh_MetricSystemType](datatypes_base.md#oh_MetricSystemType "oh_MetricSystemType") | - | metricsystem |
| Mode | [oh_RoutingModeType](datatypes_route.md#oh_RoutingModeType "oh_RoutingModeType") | - | mode |
| Representation | [oh_RouteRepresentationOptionsType](datatypes_route.md#oh_RouteRepresentationOptionsType "oh_RouteRepresentationOptionsType") | - | representation |
| RequestId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | requestId |
| ReturnElevation | [oh_BooleanType](datatypes_base.md#oh_BooleanType "oh_BooleanType") | - | returnelevation |
| RouteAttrib | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | routeattributes |
| SpeedProfile | [oh_SpeedProfileType](datatypes_route.md#oh_SpeedProfileType "oh_SpeedProfileType") | - | returnelevation |
| TrailersCount | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | trailerscount |
| TruckHeight | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | height |
| TruckLength | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | length |
| TruckRestrictionPenalty | [oh_TruckRestrictionPenaltyType](datatypes_route.md#oh_TruckRestrictionPenaltyType "oh_TruckRestrictionPenaltyType") | - | truckrestrictionpenalty |
| TruckType | [oh_TruckTypeType](datatypes_route.md#oh_TruckTypeType "oh_TruckTypeType") | - | trucktype |
| TruckWidth | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | width |
| TunnelCategory | [oh_TunnelCategoryType](datatypes_route.md#oh_TunnelCategoryType "oh_TunnelCategoryType") | - | tunnelcategory |
| Vehicle | [oh_VehicleType](datatypes_route.md#oh_VehicleType "oh_VehicleType") | - | vehicle |
| ViewBounds | [oh_GeoBoundingBoxType](datatypes_base.md#oh_GeoBoundingBoxType "oh_GeoBoundingBoxType") | - | viewbounds |
| WalkRadius | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | walkradius |
| WalkSpeed | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType") | - | walkspeed |
| WalkTimeMultiplier | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType") | - | walktimemultiplier |
| Waypoints | [oh_WaypointParameterType](datatypes_route.md#oh_WaypointParameterType "oh_WaypointParameterType") | Collection | waypoint |
| WeightPerAxle | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | weightperaxle |
