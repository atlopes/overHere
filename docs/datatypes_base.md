# overHere docs:  Maps datatypes

Go to

- [Datatypes overview](datatypes.md "Datatypes overview")
- [Maps datatypes](#datatypes "Maps datatypes")
- [Response objects](#response "Response objects")

<a name="datatypes"/>

## Datatypes


|  Datatype | Based on | Set | Get |
| ------------ | ------------ | ------------ | ------------ |
| <a name="oh_Base"/>oh_Base | Custom | - | - |
| <a name="oh_BooleanType"/>oh_BooleanType | [oh_Datatype](#oh_Datatype "oh_Datatype") | - | - |
| <a name="oh_CardinalDirectionType"/>oh_CardinalDirectionType | [oh_EnumerationType](#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_ColorType"/>oh_ColorType | [oh_StringType](#oh_StringType "oh_StringType") | Input AS StringOrNumber | - |
| <a name="oh_CountryCodeType"/>oh_CountryCodeType | [oh_EnumerationType](#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_Datatype"/>oh_Datatype | [oh_Base](#oh_Base "oh_Base") | Value | - |
| <a name="oh_DateType"/>oh_DateType | [oh_Datatype](#oh_Datatype "oh_Datatype") | Input AS Date | - |
| <a name="oh_DatetimeType"/>oh_DatetimeType | [oh_Datatype](#oh_Datatype "oh_Datatype") | Input AS Datetime | - |
| <a name="oh_DistanceType"/>oh_DistanceType | [oh_DoubleType](#oh_DoubleType "oh_DoubleType") | - | - |
| <a name="oh_DistanceUnitType"/>oh_DistanceUnitType | [oh_EnumerationType](#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_DoubleType"/>oh_DoubleType | [oh_Datatype](#oh_Datatype "oh_Datatype") | - | - |
| <a name="oh_DurationType"/>oh_DurationType | [oh_IntegerType](#oh_IntegerType "oh_IntegerType") | - | - |
| <a name="oh_EnumerationType"/>oh_EnumerationType | [oh_Datatype](#oh_Datatype "oh_Datatype") | - | - |
| <a name="oh_GeoBoundingBoxArrayType"/>oh_GeoBoundingBoxArrayType | [oh_Datatype](#oh_Datatype "oh_Datatype") | Corner AS String, Lat AS Double, Long AS Double, Alt AS Double | - |
| <a name="oh_GeoBoundingBoxType"/>oh_GeoBoundingBoxType | [oh_Datatype](#oh_Datatype "oh_Datatype") | Corner AS String, Lat AS Double, Long AS Double, Alt AS Double | Corner AS String, Coord AS String |
| <a name="oh_GeoCoordinateType"/>oh_GeoCoordinateType | [oh_Datatype](#oh_Datatype "oh_Datatype") | Lat AS Double, Long AS Double, Alt AS Double | Coord AS String |
| <a name="oh_GeoCoordinatesListType"/>oh_GeoCoordinatesListType | [oh_ValuesListType](#oh_ValuesListType "oh_ValuesListType") | Lat AS Double, Long AS Double | - |
| <a name="oh_GeoPolylineType"/>oh_GeoPolylineType | [oh_GeoCoordinatesListType](#oh_GeoCoordinatesListType "oh_GeoCoordinatesListType") | - | - |
| <a name="oh_GeoPositionType"/>oh_GeoPositionType | [oh_Datatype](#oh_Datatype "oh_Datatype") | Lat AS Double, Long AS Double, Alt AS Double, Heading AS Double | Coord AS String |
| <a name="oh_GeoProximityType"/>oh_GeoProximityType | [oh_Datatype](#oh_Datatype "oh_Datatype") | Lat AS Double, Long AS Double, Alt AS Double, Radius AS Double | Coord AS String |
| <a name="oh_GeoShapeType"/>oh_GeoShapeType | [oh_Datatype](#oh_Datatype "oh_Datatype") | - | - |
| <a name="oh_HeadingType"/>oh_HeadingType | [oh_DoubleType](#oh_DoubleType "oh_DoubleType") | - | - |
| <a name="oh_IntegerType"/>oh_IntegerType | [oh_Datatype](#oh_Datatype "oh_Datatype") | Input AS Integer | - |
| <a name="oh_KeyValuePairType"/>oh_KeyValuePairType | [oh_Datatype](#oh_Datatype "oh_Datatype") | KeyPart AS String, ValuePart AS String | - |
| <a name="oh_KeyValuePairsListType"/>oh_KeyValuePairsListType | [oh_Datatype](#oh_Datatype "oh_Datatype") | KeyPart AS String, ValuePart AS String | - |
| <a name="oh_LanguageCodeType"/>oh_LanguageCodeType | [oh_StringType](#oh_StringType "oh_StringType") | - | - |
| <a name="oh_LatitudeType"/>oh_LatitudeType | [oh_DoubleType](#oh_DoubleType "oh_DoubleType") | - | - |
| <a name="oh_LinkIdType"/>oh_LinkIdType | [oh_StringType](#oh_StringType "oh_StringType") | - | - |
| <a name="oh_LinkIdsListType"/>oh_LinkIdsListType | [oh_ValuesListType](#oh_ValuesListType "oh_ValuesListType") | - | - |
| <a name="oh_LongitudeType"/>oh_LongitudeType | [oh_DoubleType](#oh_DoubleType "oh_DoubleType") | - | - |
| <a name="oh_MetricSystemType"/>oh_MetricSystemType | [oh_EnumerationType](#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_ShapeFormatType"/>oh_ShapeFormatType | [oh_EnumerationType](#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_SideOfStreetType"/>oh_SideOfStreetType | [oh_EnumerationType](#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_StringType"/>oh_StringType | [oh_Datatype](#oh_Datatype "oh_Datatype") | - | - |
| <a name="oh_Structure"/>oh_Structure | [oh_Base](#oh_Base "oh_Base") | - | - |
| <a name="oh_ValuesListType"/>oh_ValuesListType | [oh_Datatype](#oh_Datatype "oh_Datatype") | Value | ElementIndex AS Integer |
| <a name="oh_WKTShapeType"/>oh_WKTShapeType | [oh_GeoShapeType](#oh_GeoShapeType "oh_GeoShapeType") | - | - |


<a name="response"/>

## Response objects

