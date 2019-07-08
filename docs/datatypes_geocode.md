# overHere docs:  Geocode datatypes

Go to

- [Datatypes overview](datatypes.md "Datatypes overview")
- [Geocode datatypes](#datatypes "Geocode datatypes")
- [Response objects](#response "Response objects")

<a name="datatypes"/>

## Datatypes


|  Datatype | Based on | Set | Get |
| ------------ | ------------ | ------------ | ------------ |
| <a name="oh_CurrencyType"/>oh_CurrencyType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_DrivingSideType"/>oh_DrivingSideType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_FunctionalClassType"/>oh_FunctionalClassType | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | - |
| <a name="oh_LinkAccessFlagType"/>oh_LinkAccessFlagType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_LinkFlagType"/>oh_LinkFlagType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_LocationTypeType"/>oh_LocationTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_MatchCodeType"/>oh_MatchCodeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_MatchLevelType"/>oh_MatchLevelType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_MatchTypeType"/>oh_MatchTypeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_RelationshipType"/>oh_RelationshipType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_ReverseGeocodeModeType"/>oh_ReverseGeocodeModeType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_SpeedCategoryType"/>oh_SpeedCategoryType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_SpeedLimitType"/>oh_SpeedLimitType | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | Limit AS Integer, Unit AS String | - |
| <a name="oh_SpeedLimitUnitType"/>oh_SpeedLimitUnitType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_SystemOfMeasurementType"/>oh_SystemOfMeasurementType | [oh_EnumerationType](datatypes_base.md#oh_EnumerationType "oh_EnumerationType") | - | - |
| <a name="oh_UTCTimeOffsetType"/>oh_UTCTimeOffsetType | [oh_Datatype](datatypes_base.md#oh_Datatype "oh_Datatype") | Hours AS Integer, Minutes AS Integer | - |


<a name="response"/>

## Response objects



<a name="oh_AddressDetailsType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_AddressDetailsType** | [oh_BaseAddressType](#oh_BaseAddressType "oh_BaseAddressType") |  |  |  |
|  |  | CountryCode | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | StreetDetails | [oh_StreetDetailsType](#oh_StreetDetailsType "oh_StreetDetailsType")  | - |


<a name="oh_AddressNamesType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_AddressNamesType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Country | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Collection |
|  |  | State | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Collection |
|  |  | County | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Collection |
|  |  | City | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Collection |
|  |  | District | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Collection |
|  |  | SubDistrict | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Collection |
|  |  | Street | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Collection |


<a name="oh_AddressType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_AddressType** | [oh_BaseAddressType](#oh_BaseAddressType "oh_BaseAddressType") |  |  |  |
|  |  | Label | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | DistanceMarker | [oh_DistanceMarkerType](#oh_DistanceMarkerType "oh_DistanceMarkerType")  | - |
|  |  | AddressLine | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | AdditionalData | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Key collection |


<a name="oh_AdminInfoType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_AdminInfoType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | LocalTime | [oh_DatetimeType](datatypes_base.md#oh_DatetimeType "oh_DatetimeType")  | - |
|  |  | UTCTimezoneOffset | [oh_UTCTimeOffsetType](#oh_UTCTimeOffsetType "oh_UTCTimeOffsetType")  | - |
|  |  | Currency | [oh_CurrencyType](#oh_CurrencyType "oh_CurrencyType")  | - |
|  |  | DrivingSide | [oh_DrivingSideType](#oh_DrivingSideType "oh_DrivingSideType")  | - |
|  |  | SystemOfMeasure | [oh_SystemOfMeasurementType](#oh_SystemOfMeasurementType "oh_SystemOfMeasurementType")  | - |
|  |  | Timezone | [oh_TimezoneType](#oh_TimezoneType "oh_TimezoneType")  | - |


<a name="oh_BaseAddressType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_BaseAddressType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Country | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | State | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | County | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | City | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | District | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | SubDistrict | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Street | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | HouseNumber | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | PostalCode | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Building | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_BaseLocationType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_BaseLocationType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | LocationId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | LocationType | [oh_LocationTypeType](#oh_LocationTypeType "oh_LocationTypeType")  | - |
|  |  | LocationName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | DisplayPosition | [oh_GeoCoordinateType](datatypes_base.md#oh_GeoCoordinateType "oh_GeoCoordinateType")  | - |
|  |  | NavigationPosition | [oh_GeoCoordinateType](datatypes_base.md#oh_GeoCoordinateType "oh_GeoCoordinateType")  | - |
|  |  | MapView | [oh_GeoBoundingBoxType](datatypes_base.md#oh_GeoBoundingBoxType "oh_GeoBoundingBoxType")  | - |
|  |  | Shape | [oh_GeoShapeType](datatypes_base.md#oh_GeoShapeType "oh_GeoShapeType")  | - |
|  |  | Address | [oh_AddressType](#oh_AddressType "oh_AddressType")  | - |
|  |  | AddressDetails | [oh_AddressDetailsType](#oh_AddressDetailsType "oh_AddressDetailsType")  | - |
|  |  | AddressNames | [oh_AddressNamesType](#oh_AddressNamesType "oh_AddressNamesType")  | - |
|  |  | MapReference | [oh_MapReferenceType](#oh_MapReferenceType "oh_MapReferenceType")  | - |
|  |  | LinkInfo | [oh_LinkInfoType](#oh_LinkInfoType "oh_LinkInfoType")  | - |
|  |  | AdminInfo | [oh_AdminInfoType](#oh_AdminInfoType "oh_AdminInfoType")  | - |
|  |  | AdditionalData | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Key collection |


<a name="oh_CategoryType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_CategoryType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | CategoryId | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | CategorySystemId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_DistanceMarkerType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_DistanceMarkerType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Value | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Offset | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | Unit | [oh_DistanceUnitType](datatypes_base.md#oh_DistanceUnitType "oh_DistanceUnitType")  | - |
|  |  | DirectionOnSign | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_GeocodeSuggestionType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_GeocodeSuggestionType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | label | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | language | [oh_LanguageCodeType](datatypes_base.md#oh_LanguageCodeType "oh_LanguageCodeType")  | - |
|  |  | countryCode | [oh_CountryCodeType](datatypes_base.md#oh_CountryCodeType "oh_CountryCodeType")  | - |
|  |  | locationId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | address | [oh_SuggestedAddressType](#oh_SuggestedAddressType "oh_SuggestedAddressType")  | - |
|  |  | distance | [oh_DistanceType](datatypes_base.md#oh_DistanceType "oh_DistanceType")  | - |
|  |  | matchLevel | [oh_MatchLevelType](#oh_MatchLevelType "oh_MatchLevelType")  | - |


<a name="oh_LinkInfoType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_LinkInfoType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | FunctionalClass | [oh_FunctionalClassType](#oh_FunctionalClassType "oh_FunctionalClassType")  | - |
|  |  | TravelDirection | [oh_CardinalDirectionType](datatypes_base.md#oh_CardinalDirectionType "oh_CardinalDirectionType")  | - |
|  |  | SpeedCategory | [oh_SpeedCategoryType](#oh_SpeedCategoryType "oh_SpeedCategoryType")  | - |
|  |  | SpeedLimit | [oh_SpeedLimitType](#oh_SpeedLimitType "oh_SpeedLimitType")  | - |
|  |  | Traffic | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | LinkFlags | [oh_LinkFlagType](#oh_LinkFlagType "oh_LinkFlagType")  | List |
|  |  | AcessFlags | [oh_LinkAccessFlagType](#oh_LinkAccessFlagType "oh_LinkAccessFlagType")  | List |


<a name="oh_LocationType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_LocationType** | [oh_BaseLocationType](#oh_BaseLocationType "oh_BaseLocationType") |  |  |  |
|  |  | Related | [oh_RelatedLocationType](#oh_RelatedLocationType "oh_RelatedLocationType")  | - |


<a name="oh_MapReferenceType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_MapReferenceType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | ReferenceId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | MapVersion | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | MapReleaseDate | [oh_DateType](datatypes_base.md#oh_DateType "oh_DateType")  | - |
|  |  | MapId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Spot | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | SideOfStreet | [oh_SideOfStreetType](datatypes_base.md#oh_SideOfStreetType "oh_SideOfStreetType")  | - |
|  |  | CountryId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | StateId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | CountyId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | CityId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | DistrictId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | RoadLinkId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | BuildingId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | AddressId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_MatchQualityType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_MatchQualityType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Country | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | State | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | County | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | City | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | District | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | SubDistrict | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | Street | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | Array |
|  |  | HouseNumber | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | PostalCode | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | Building | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |


<a name="oh_ParsedRequestType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_ParsedRequestType** | [oh_BaseAddressType](#oh_BaseAddressType "oh_BaseAddressType") |  |  |  |
|  |  | LandmarkName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Label | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | AddressLine | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | AdditionalData | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Key collection |


<a name="oh_PlaceType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_PlaceType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | PlaceId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | PlaceName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Category | [oh_CategoryType](#oh_CategoryType "oh_CategoryType")  | - |
|  |  | Location | [oh_LocationType](#oh_LocationType "oh_LocationType")  | - |


<a name="oh_RelatedLocationType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_RelatedLocationType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Type | [oh_RelationshipType](#oh_RelationshipType "oh_RelationshipType")  | - |
|  |  | MatchType | [oh_MatchTypeType](#oh_MatchTypeType "oh_MatchTypeType")  | - |
|  |  | RouteDistance | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | Direction | [oh_HeadingType](datatypes_base.md#oh_HeadingType "oh_HeadingType")  | - |
|  |  | Location | [oh_BaseLocationType](#oh_BaseLocationType "oh_BaseLocationType")  | - |


<a name="oh_SearchResponseMetaInfoType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_SearchResponseMetaInfoType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | RequestId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Timestamp | [oh_DatetimeType](datatypes_base.md#oh_DatetimeType "oh_DatetimeType")  | - |
|  |  | NextPage | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | PreviousPage | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | AdditionalData | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Key collection |


<a name="oh_SearchResponseType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_SearchResponseType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | MetaInfo | [oh_SearchResponseMetaInfoType](#oh_SearchResponseMetaInfoType "oh_SearchResponseMetaInfoType")  | - |
|  |  | Views | [oh_SearchResponseViewType](#oh_SearchResponseViewType "oh_SearchResponseViewType")  | Collection |


<a name="oh_SearchResponseViewType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_SearchResponseViewType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | ViewId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | PerformedSearch | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Results | [oh_SearchResultType](#oh_SearchResultType "oh_SearchResultType")  | Collection |


<a name="oh_SearchResultType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_SearchResultType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Relevance | [oh_DoubleType](datatypes_base.md#oh_DoubleType "oh_DoubleType")  | - |
|  |  | Distance | [oh_DistanceType](datatypes_base.md#oh_DistanceType "oh_DistanceType")  | - |
|  |  | Direction | [oh_HeadingType](datatypes_base.md#oh_HeadingType "oh_HeadingType")  | - |
|  |  | MatchLevel | [oh_MatchLevelType](#oh_MatchLevelType "oh_MatchLevelType")  | - |
|  |  | MatchQuality | [oh_MatchQualityType](#oh_MatchQualityType "oh_MatchQualityType")  | Collection |
|  |  | MatchType | [oh_MatchTypeType](#oh_MatchTypeType "oh_MatchTypeType")  | - |
|  |  | Location | [oh_LocationType](#oh_LocationType "oh_LocationType")  | - |
|  |  | Place | [oh_PlaceType](#oh_PlaceType "oh_PlaceType")  | - |
|  |  | ParsedRequest | [oh_ParsedRequestType](#oh_ParsedRequestType "oh_ParsedRequestType")  | - |
|  |  | AdditionalData | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | Key collection |


<a name="oh_StreetDetailsType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_StreetDetailsType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | BaseName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | StreetType | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | StreetTypeBefore | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | StreetTypeAttached | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Prefix | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Suffix | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Direction | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_SuggestedAddressType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_SuggestedAddressType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Country | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | State | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | County | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | City | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | District | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Street | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | HouseNumber | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Unit | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | PostalCode | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |


<a name="oh_SuggestionResponseType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_SuggestionResponseType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | suggestions | [oh_GeocodeSuggestionType](#oh_GeocodeSuggestionType "oh_GeocodeSuggestionType")  | Collection |


<a name="oh_TimezoneType"/>

| Structure | Based on | Members | Type | Aggregator |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **oh_TimezoneType** | [oh_Structure](datatypes_base.md#oh_Structure "oh_Structure") |  |  |  |
|  |  | Id | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | Offset | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | RawOffset | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
|  |  | NameShort | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | NameLong | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | NameDstShort | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | NameDstLong | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType")  | - |
|  |  | InDaylightTime | [oh_BooleanType](datatypes_base.md#oh_BooleanType "oh_BooleanType")  | - |
|  |  | DstSavings | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType")  | - |
