# overHere docs:  Maps datatypes

Go to

- [Datatypes overview](datatypes.md "Datatypes overview")
- [Maps datatypes](#datatypes "Maps datatypes")
- [Response objects](#response "Response objects")

<a name="datatypes"/>

## Datatypes


|  Datatype | Based on | Set | Get |
| ------------ | ------------ | ------------ | ------------ |
| <a name="oh_CustomTextConfigType"/>oh_CustomTextConfigType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | - | - |
| <a name="oh_CustomTextCoordType"/>oh_CustomTextCoordType | [oh_CustomTextType](#oh_CustomTextType "oh_CustomTextType") | Lat AS Double, Long AS Double, Text AS String, Color AS StringOrNumber, BorderColor AS StringOrNumber, Size AS Integer | - |
| <a name="oh_CustomTextType"/>oh_CustomTextType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | Text AS String, Color AS StringOrNumber, BorderColor AS StringOrNumber, Size AS Integer | - |
| <a name="oh_CustomTextXYType"/>oh_CustomTextXYType | [oh_CustomTextType](#oh_CustomTextType "oh_CustomTextType") | X AS Integer, Y AS Integer, Text AS String, Color AS StringOrNumber, BorderColor AS StringOrNumber, Size AS Integer | - |
| <a name="oh_GraphObjectConfigType"/>oh_GraphObjectConfigType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | - | - |
| <a name="oh_GraphObjectType"/>oh_GraphObjectType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | Lat AS Double, Long AS Double, Value AS Double, Fill AS StringOrNumber, BorderColor AS StringOrNumber | - |
| <a name="oh_ImageFormatType"/>oh_ImageFormatType | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | - |
| <a name="oh_MapRouteMarkerGroupConfigType"/>oh_MapRouteMarkerGroupConfigType | [oh_PointOfInterestConfigType](#oh_PointOfInterestConfigType "oh_PointOfInterestConfigType") | - | - |
| <a name="oh_MapRouteMarkerGroupType"/>oh_MapRouteMarkerGroupType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | - | - |
| <a name="oh_MapSchemeType"/>oh_MapSchemeType | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | - |
| <a name="oh_MapViewType"/>oh_MapViewType | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | - |
| <a name="oh_PointOfInterestConfigType"/>oh_PointOfInterestConfigType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | - | - |
| <a name="oh_PointOfInterestType"/>oh_PointOfInterestType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | Lat AS Double, Long AS Double, Fill AS String, Color AS String, Size AS Integer, Text AS String | - |
| <a name="oh_ScaleBarsType"/>oh_ScaleBarsType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_ZoomLevelType"/>oh_ZoomLevelType | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | - |


<a name="response"/>

## Response objects

