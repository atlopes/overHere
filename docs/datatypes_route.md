# overHere docs:  Route datatypes

Go to

- [Datatypes overview](datatypes.md "Datatypes overview")
- [Route datatypes](#datatypes "Route datatypes")
- [Response objects](#response "Response objects")

<a name="datatypes"/>

## Datatypes


|  Datatype | Based on | Set | Get |
| ------------ | ------------ | ------------ | ------------ |
| <a name="oh_ConsumptionModelType"/>oh_ConsumptionModelType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | Component AS String, Value AS Double, Speed AS Integer | - |
| <a name="oh_DirectionType"/>oh_DirectionType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_EngineType"/>oh_EngineType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_GeoWaypointParameterType"/>oh_GeoWaypointParameterType | [oh_WaypointParameterType](#oh_WaypointParameterType "oh_WaypointParameterType") | Type AS String, StopOverDuration AS Integer, Lat AS Double, Long AS Double, Alt AS Double, Radius AS Integer, UserLabel AS String, Heading AS Double | - |
| <a name="oh_HazardousGoodsTypeType"/>oh_HazardousGoodsTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_IncidentTypeType"/>oh_IncidentTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_InstructionFormatType"/>oh_InstructionFormatType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_LicensePlatePatternType"/>oh_LicensePlatePatternType | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | - |
| <a name="oh_LinkNavigationWaypointParamet"/>oh_LinkNavigationWaypointParamet | [oh_WaypointParameterType](#oh_WaypointParameterType "oh_WaypointParameterType") | - | - |
| <a name="oh_ManeuverAttributeType"/>oh_ManeuverAttributeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_PrivateTransportActionType"/>oh_PrivateTransportActionType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_PublicTransportActionType"/>oh_PublicTransportActionType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_PublicTransportFlagType"/>oh_PublicTransportFlagType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_PublicTransportLineAttributeT"/>oh_PublicTransportLineAttributeT | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_PublicTransportLinkFlagType"/>oh_PublicTransportLinkFlagType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_PublicTransportTypeType"/>oh_PublicTransportTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RecurringTimeIntervalsCombina"/>oh_RecurringTimeIntervalsCombina | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | - |
| <a name="oh_ResourceTypeType"/>oh_ResourceTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RouteAttributeType"/>oh_RouteAttributeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RouteFeatureType"/>oh_RouteFeatureType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RouteFeatureWeightType"/>oh_RouteFeatureWeightType | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | - |
| <a name="oh_RouteFeaturesListType"/>oh_RouteFeaturesListType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | Feature AS String, Weight AS Integer | - |
| <a name="oh_RouteLegAttributeType"/>oh_RouteLegAttributeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RouteLinkAttributeType"/>oh_RouteLinkAttributeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RouteLinkFlagType"/>oh_RouteLinkFlagType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RouteNoteCodeType"/>oh_RouteNoteCodeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RouteNoteTypeType"/>oh_RouteNoteTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RouteRepresentationOptionsTyp"/>oh_RouteRepresentationOptionsTyp | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RoutingModeType"/>oh_RoutingModeType | [oh_RoutingTypeType](#oh_RoutingTypeType "oh_RoutingTypeType") | Component AS String, Value AS String, Weight AS Integer | - |
| <a name="oh_RoutingTypeType"/>oh_RoutingTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RoutingZoneTypeType"/>oh_RoutingZoneTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_ShapeQualityType"/>oh_ShapeQualityType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_SourceSupplierNoteTypeType"/>oh_SourceSupplierNoteTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_SpeedConsumptionType"/>oh_SpeedConsumptionType | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | - |
| <a name="oh_SpeedProfileType"/>oh_SpeedProfileType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_StreetNavigationWaypointParam"/>oh_StreetNavigationWaypointParam | [oh_WaypointParameterType](#oh_WaypointParameterType "oh_WaypointParameterType") | - | - |
| <a name="oh_TimeDependentRestrictionTypeT"/>oh_TimeDependentRestrictionTypeT | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_TrafficModeType"/>oh_TrafficModeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_TransportModeType"/>oh_TransportModeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_TruckRestrictionPenaltyType"/>oh_TruckRestrictionPenaltyType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_TruckTypeType"/>oh_TruckTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_TunnelCategoryType"/>oh_TunnelCategoryType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_TurnTypeType"/>oh_TurnTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_VehicleType"/>oh_VehicleType | [oh_EngineType](#oh_EngineType "oh_EngineType") | Engine AS String, Consumption AS Double | - |
| <a name="oh_WaypointParameterType"/>oh_WaypointParameterType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | - | - |
| <a name="oh_WaypointTypeType"/>oh_WaypointTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |


<a name="response"/>

## Response objects



<a name="oh_CalculateRouteResponseType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_CalculateRouteResponseType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | MetaInfo | [oh_RouteResponseMetaInfoType](#oh_RouteResponseMetaInfoType "oh_RouteResponseMetaInfoType")  | - |
|  |  | Routes | [oh_RouteType](#oh_RouteType "oh_RouteType")  | Collection |
|  |  | Language | [oh_LanguageCodeType](datatypes_base.md#oh_LanguageCodeType "oh_LanguageCodeType")  | - |
|  |  | SourceAttribution | [oh_SourceAttributionType](#oh_SourceAttributionType "oh_SourceAttributionType")  | - |


<a name="oh_CountryChangeDetailsType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_CountryChangeDetailsType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | ToCountry | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_GeneralizationType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_GeneralizationType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Tolerance | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | Index | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |


<a name="oh_IncidentType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_IncidentType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | ValidityPeriod | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Text | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Type | [oh_IncidentTypeType](#oh_IncidentTypeType "oh_IncidentTypeType")  | - |
|  |  | Criticality | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | FirstPoint | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | LastPoint | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |


<a name="oh_ManeuverGroupType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_ManeuverGroupType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | firstmaneuver | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | lastmaneuver | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | mode | [oh_RoutingModeType](#oh_RoutingModeType "oh_RoutingModeType")  | - |
|  |  | summaryDescription | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | arrivalDescription | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | waitDescription | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | publicTransportType | [oh_PublicTransportTypeType](#oh_PublicTransportTypeType "oh_PublicTransportTypeType")  | - |


<a name="oh_ManeuverType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_ManeuverType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | id | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Position | [oh_GeoCoordinateType](datatypes_base.md#oh_GeoCoordinateType "oh_GeoCoordinateType")  | - |
|  |  | Instruction | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | TravelTime | [oh_DurationType](datatypes_base.md#oh_DurationType "oh_DurationType")  | - |
|  |  | Length | [oh_DistanceType](datatypes_base.md#oh_DistanceType "oh_DistanceType")  | - |
|  |  | Shape | [oh_GeoPolylineType](datatypes_base.md#oh_GeoPolylineType "oh_GeoPolylineType")  | - |
|  |  | FirstPoint | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | LastPoint | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | Time | [oh_DatetimeType](datatypes_base.md#oh_DatetimeType "oh_DatetimeType")  | - |
|  |  | Note | [oh_RouteNoteType](#oh_RouteNoteType "oh_RouteNoteType")  | - |
|  |  | NextManeuver | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | ToLink | [oh_LinkIdType](datatypes_base.md#oh_LinkIdType "oh_LinkIdType")  | - |
|  |  | BoundingBox | [oh_GeoBoundingBoxType](datatypes_base.md#oh_GeoBoundingBoxType "oh_GeoBoundingBoxType")  | - |
|  |  | ShapeQuality | [oh_ShapeQualityType](#oh_ShapeQualityType "oh_ShapeQualityType")  | - |


<a name="oh_PublicTransportTicketType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_PublicTransportTicketType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | ID | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | TicketName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Currency | [oh_CurrencyType](datatypes_base.md#oh_CurrencyType "oh_CurrencyType")  | - |
|  |  | Price | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |


<a name="oh_PublicTransportTicketsType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_PublicTransportTicketsType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | ID | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | PublicTransportTickets | [oh_PublicTransportTicketType](#oh_PublicTransportTicketType "oh_PublicTransportTicketType")  | Collection |


<a name="oh_RouteLegType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_RouteLegType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Start | [oh_WaypointType](#oh_WaypointType "oh_WaypointType")  | - |
|  |  | End | [oh_WaypointType](#oh_WaypointType "oh_WaypointType")  | - |
|  |  | Length | [oh_DistanceType](datatypes_base.md#oh_DistanceType "oh_DistanceType")  | - |
|  |  | TravelTime | [oh_DurationType](datatypes_base.md#oh_DurationType "oh_DurationType")  | - |
|  |  | Maneuvers | [oh_ManeuverType](#oh_ManeuverType "oh_ManeuverType")  | Collection |
|  |  | Links | [oh_LinkIdsListType](datatypes_base.md#oh_LinkIdsListType "oh_LinkIdsListType")  | - |
|  |  | BoundingBox | [oh_GeoBoundingBoxType](datatypes_base.md#oh_GeoBoundingBoxType "oh_GeoBoundingBoxType")  | - |
|  |  | Shape | [oh_GeoPolylineType](datatypes_base.md#oh_GeoPolylineType "oh_GeoPolylineType")  | - |
|  |  | FirstPoint | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | LastPoint | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | TrafficTime | [oh_DurationType](datatypes_base.md#oh_DurationType "oh_DurationType")  | - |
|  |  | BaseTime | [oh_DurationType](datatypes_base.md#oh_DurationType "oh_DurationType")  | - |
|  |  | Summary | [oh_RouteSummaryType](#oh_RouteSummaryType "oh_RouteSummaryType")  | - |
|  |  | SubLegSummary | [oh_RouteSummaryType](#oh_RouteSummaryType "oh_RouteSummaryType")  | - |


<a name="oh_RouteNoteType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_RouteNoteType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Type | [oh_RouteNoteTypeType](#oh_RouteNoteTypeType "oh_RouteNoteTypeType")  | - |
|  |  | Code | [oh_RouteNoteCodeType](#oh_RouteNoteCodeType "oh_RouteNoteCodeType")  | - |
|  |  | Text | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | AdditionalData | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Key collection |
|  |  | CountryChangeDetails | [oh_CountryChangeDetailsType](#oh_CountryChangeDetailsType "oh_CountryChangeDetailsType")  | - |


<a name="oh_RouteResponseMetaInfoType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_RouteResponseMetaInfoType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | RequestId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Timestamp | [oh_DatetimeType](datatypes_base.md#oh_DatetimeType "oh_DatetimeType")  | - |
|  |  | MapVersion | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | AvailableMapVersion | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | ModuleVersion | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | InterfaceVersion | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_RouteShapeReferenceType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_RouteShapeReferenceType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | FirstPoint | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | LastPoint | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |


<a name="oh_RouteSummaryType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_RouteSummaryType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Distance | [oh_DistanceType](datatypes_base.md#oh_DistanceType "oh_DistanceType")  | - |
|  |  | TrafficTime | [oh_DurationType](datatypes_base.md#oh_DurationType "oh_DurationType")  | - |
|  |  | BaseTime | [oh_DurationType](datatypes_base.md#oh_DurationType "oh_DurationType")  | - |
|  |  | Flags | [oh_RouteLinkFlagType](#oh_RouteLinkFlagType "oh_RouteLinkFlagType")  | Collection |
|  |  | TravelTime | [oh_DurationType](datatypes_base.md#oh_DurationType "oh_DurationType")  | - |
|  |  | Text | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Co2Emission | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |


<a name="oh_RouteType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_RouteType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | RouteId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Waypoints | [oh_WaypointType](#oh_WaypointType "oh_WaypointType")  | Collection |
|  |  | Mode | [oh_RoutingModeType](#oh_RoutingModeType "oh_RoutingModeType")  | - |
|  |  | Shape | [oh_GeoPolylineType](datatypes_base.md#oh_GeoPolylineType "oh_GeoPolylineType")  | - |
|  |  | BoundingBox | [oh_GeoBoundingBoxType](datatypes_base.md#oh_GeoBoundingBoxType "oh_GeoBoundingBoxType")  | - |
|  |  | Legs | [oh_RouteLegType](#oh_RouteLegType "oh_RouteLegType")  | Collection |
|  |  | PublicTransportLine | [oh_PublicTransportLineType](datatypes_base.md#oh_PublicTransportLineType "oh_PublicTransportLineType")  | Collection |
|  |  | PublicTransportTickets | [oh_PublicTransportTicketsType](#oh_PublicTransportTicketsType "oh_PublicTransportTicketsType")  | - |
|  |  | Notes | [oh_RouteNoteType](#oh_RouteNoteType "oh_RouteNoteType")  | Collection |
|  |  | Summary | [oh_RouteSummaryType](#oh_RouteSummaryType "oh_RouteSummaryType")  | - |
|  |  | SummaryByCountry | [oh_RouteSummaryByCountryType](datatypes_base.md#oh_RouteSummaryByCountryType "oh_RouteSummaryByCountryType")  | Collection |
|  |  | Generalizations | [oh_GeneralizationType](#oh_GeneralizationType "oh_GeneralizationType")  | Collection |
|  |  | ManeuverGroup | [oh_ManeuverGroupType](#oh_ManeuverGroupType "oh_ManeuverGroupType")  | Collection |
|  |  | Incident | [oh_IncidentType](#oh_IncidentType "oh_IncidentType")  | - |
|  |  | Label | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Zone | [oh_RoutingZoneType](#oh_RoutingZoneType "oh_RoutingZoneType")  | - |
|  |  | TimeDependentRestriction | [oh_TimeDependentRestrictionType](#oh_TimeDependentRestrictionType "oh_TimeDependentRestrictionType")  | - |


<a name="oh_RoutingZoneType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_RoutingZoneType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Id | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | ZoneName |   | Collection |
|  |  | Type | [oh_RoutingZoneTypeType](#oh_RoutingZoneTypeType "oh_RoutingZoneTypeType")  | - |
|  |  | ShapeIndices | [oh_RouteShapeReferenceType](#oh_RouteShapeReferenceType "oh_RouteShapeReferenceType")  | Collection |
|  |  | Restriction | [oh_VehicleRestrictionType](#oh_VehicleRestrictionType "oh_VehicleRestrictionType")  | Collection |


<a name="oh_SourceAttributionType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_SourceAttributionType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Attribution | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | SourceSupplier | [oh_SourceSupplierType](#oh_SourceSupplierType "oh_SourceSupplierType")  | - |


<a name="oh_SourceSupplierNoteType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_SourceSupplierNoteType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Type | [oh_SourceSupplierNoteTypeType](#oh_SourceSupplierNoteTypeType "oh_SourceSupplierNoteTypeType")  | - |
|  |  | Text | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Href | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | HrefText | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_SourceSupplierType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_SourceSupplierType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Title | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Href | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Note | [oh_SourceSupplierNoteType](#oh_SourceSupplierNoteType "oh_SourceSupplierNoteType")  | - |


<a name="oh_TimeDependentRestrictionType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_TimeDependentRestrictionType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | ValidityPeriod | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Type | [oh_TimeDependentRestrictionTypeT](#oh_TimeDependentRestrictionTypeT "oh_TimeDependentRestrictionTypeT")  | - |


<a name="oh_VehicleRestrictionType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_VehicleRestrictionType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | ValidityPeriod | [oh_RecurringTimeIntervalsCombina](#oh_RecurringTimeIntervalsCombina "oh_RecurringTimeIntervalsCombina")  | - |
|  |  | LicensePlatePattern | [oh_LicensePlatePatternType](#oh_LicensePlatePatternType "oh_LicensePlatePatternType")  | - |


<a name="oh_WaypointType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| oh_WaypointType | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | LinkId | [oh_LinkIdType](datatypes_base.md#oh_LinkIdType "oh_LinkIdType")  | - |
|  |  | MappedPosition | [oh_GeoCoordinateType](datatypes_base.md#oh_GeoCoordinateType "oh_GeoCoordinateType")  | - |
|  |  | OriginalPosition | [oh_GeoCoordinateType](datatypes_base.md#oh_GeoCoordinateType "oh_GeoCoordinateType")  | - |
|  |  | Type | [oh_WaypointTypeType](#oh_WaypointTypeType "oh_WaypointTypeType")  | - |
|  |  | Spot | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | SideOfStreet | [oh_SideOfStreetType](datatypes_base.md#oh_SideOfStreetType "oh_SideOfStreetType")  | - |
|  |  | MappedRoadName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Label | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | UserLabel | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | ShapeIndex | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
