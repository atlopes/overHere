# overHere docs:  Fleet datatypes

Go to

- [Datatypes overview](datatypes.md "Datatypes overview")
- [Fleet datatypes](#datatypes "Fleet datatypes")
- [Response objects](#response "Response objects")

<a name="datatypes"/>

## Datatypes


|  Datatype | Based on | Set | Get |
| ------------ | ------------ | ------------ | ------------ |
| <a name="oh_DrivingRestTimeType"/>oh_DrivingRestTimeType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | Disabled AS Boolean, ShortDriving AS Integer, ShortRest AS Integer, LongDriving AS Integer, LongRest AS Integer, ServiceTimes AS String | - |
| <a name="oh_DropItemType"/>oh_DropItemType | [oh_PickupDropItemType](#oh_PickupDropItemType "oh_PickupDropItemType") | - | - |
| <a name="oh_ImproveForType"/>oh_ImproveForType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_PickupDropItemType"/>oh_PickupDropItemType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | Name AS String, ValueCost AS Double | - |
| <a name="oh_PickupItemType"/>oh_PickupItemType | [oh_PickupDropItemType](#oh_PickupDropItemType "oh_PickupDropItemType") | - | - |
| <a name="oh_ServiceTimeType"/>oh_ServiceTimeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_WaypointWithIdType"/>oh_WaypointWithIdType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | Id AS String, Lat AS Double, Long AS Double | - |


<a name="response"/>

## Response objects

<a name="oh_FailedConstraintType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_FailedConstraintType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Constraint | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Reason | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_FindInterconnectionType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_FindInterconnectionType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | FromWaypoint | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | ToWaypoint | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Distance | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | Time | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | Rest | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | Waiting | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |


<a name="oh_FindWaypointInfoType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_FindWaypointInfoType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Id | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Latitude | [oh_LatitudeType](datatypes_base.md#oh_LatitudeType "oh_LatitudeType")  | - |
|  |  | Longitude | [oh_LongitudeType](datatypes_base.md#oh_LongitudeType "oh_LongitudeType")  | - |
|  |  | Sequence | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | EstimatedArrival | [oh_DatetimeType](datatypes_base.md#oh_DatetimeType "oh_DatetimeType")  | - |
|  |  | EstimatedDeparture | [oh_DatetimeType](datatypes_base.md#oh_DatetimeType "oh_DatetimeType")  | - |
|  |  | FulfilledConstraints | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Collection |


<a name="oh_FindWaypointsDetailsType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_FindWaypointsDetailsType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Waypoints | [oh_FindWaypointInfoType](#oh_FindWaypointInfoType "oh_FindWaypointInfoType")  | Collection |
|  |  | Distance | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | Time | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | Interconnections | [oh_FindInterconnectionType](#oh_FindInterconnectionType "oh_FindInterconnectionType")  | Collection |
|  |  | TimeBreakDown | [oh_TimeBreakDownType](#oh_TimeBreakDownType "oh_TimeBreakDownType")  | - |
|  |  | Description | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_FindWaypointsResponseType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_FindWaypointsResponseType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Results | [oh_FindWaypointsDetailsType](#oh_FindWaypointsDetailsType "oh_FindWaypointsDetailsType")  | Collection |
|  |  | Errors | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Collection |
|  |  | ProcessingTimeDesc | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | RequestId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | ResponseCode | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Warnings | [oh_FindWaypointsWarningType](#oh_FindWaypointsWarningType "oh_FindWaypointsWarningType")  | Collection |


<a name="oh_FindWaypointsWarningType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_FindWaypointsWarningType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Id | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Latitude | [oh_LatitudeType](datatypes_base.md#oh_LatitudeType "oh_LatitudeType")  | - |
|  |  | Longitude | [oh_LongitudeType](datatypes_base.md#oh_LongitudeType "oh_LongitudeType")  | - |
|  |  | FailedConstraints | [oh_FailedConstraintType](#oh_FailedConstraintType "oh_FailedConstraintType")  | Collection |


<a name="oh_TimeBreakDownType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_TimeBreakDownType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Driving | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | Service | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | Rest | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | Waiting | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
