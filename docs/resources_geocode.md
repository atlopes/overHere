# overHere docs: Geocode resources

Go to
* [Resources](resources.md "Resources")
* [Overview](../README.md "Overview")

## overHere Geocode resources

* [GeocodeSearch](#geocodesearch "GeocodeSearch")
* [LandmarkSearch](#landmarksearch "LandmarkSearch")
* [ReverseGeocode](#reversegeocode "ReverseGeocode")
* [GeocodeAutoComplete](#geocodeautocomplete "GeocodeAutoComplete")

<a name="geocodesearch" />

### GeocodeSearch

| Class | Source Location | Based on | Here API reference | Asynchronous |
| --- | --- | --- | --- | --- |
| oh_GeocodeSearch | [search.prg](../source/api/geocoding/search.prg "search.prg") | [oh_GeocodeResource](../source/api/geocoding/geocode.prg "oh_GeocodeResource") | [Geocode resource](https://developer.here.com/documentation/geocoder/topics/resource-geocode.html "Geocode Resource") | Disabled |

| Method | Args | Result | Notes |
| --- | --- | --- | --- |
| GetLocation | Request AS Logical | [oh_SearchResponseType](datatypes_geocode.md#oh_SearchResponseType "oh_SearchResponseType") (.NULL. if failed) | `m.Request` = .T. if location is to be requested from server, otherwise from previous request if available |
| Request | - | Logical (.T. if success) | - |

| Response property | Type |
| --- | --- |
| Location | [oh_SearchResponseType](datatypes_geocode.md#oh_SearchResponseType "oh_SearchResponseType") |

| Parameter | Based on | Aggregator | Here name |
| --- | --- | --- | --- |
| AdditionalData | [oh_KeyValuePairsListType](datatypes_base.md#oh_KeyValuePairsListType "oh_KeyValuePairsListType") | - | additionaldata |
| AddressAttributes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | addressattributes |
| BoundingBox | [oh_GeoBoundingBoxType](datatypes_base.md#oh_GeoBoundingBoxType "oh_GeoBoundingBoxType") | - | bbox |
| CityName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | city |
| CountryFocus | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | countryfocus |
| CountryName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | country |
| CountyName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | county |
| DistrictName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | district |
| HouseNumber | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | housenumber |
| Language | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | language |
| LocationAttributes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | locationattributes |
| LocationId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | locationid |
| MapView | [oh_GeoBoundingBoxType](datatypes_base.md#oh_GeoBoundingBoxType "oh_GeoBoundingBoxType") | - | mapview |
| MaxResults | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | maxresults |
| PageInformation | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | pageinformation |
| PoliticalView | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | politicalview |
| PostalCode | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | postalcode |
| Proximity | [oh_GeoProximityType](datatypes_base.md#oh_GeoProximityType "oh_GeoProximityType") | - | prox |
| ResponseAttributes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | responseattributes |
| SearchText | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | searchtext |
| StateName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | state |
| StreetName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | street |
| StrictLanguageMode | [oh_BooleanType](datatypes_base.md#oh_BooleanType "oh_BooleanType") | - | strictlanguagemode |

<a name="landmarksearch" />

### LandmarkSearch

| Class | Source Location | Based on | Here API reference | Asynchronous |
| --- | --- | --- | --- | --- |
| oh_GeocodeSearch | [search.prg](../source/api/geocoding/search.prg "search.prg") | [oh_GeocodeResource](../source/api/geocoding/geocode.prg "oh_GeocodeResource") | [Landmark Geocode resource](https://developer.here.com/documentation/geocoder/topics/resource-search.html "Landmark Geocode Resource") | Disabled |

| Method | Args | Result | Notes |
| --- | --- | --- | --- |
| GetLocation | Request AS Logical | [oh_SearchResponseType](datatypes_geocode.md#oh_SearchResponseType "oh_SearchResponseType") (.NULL. if failed) | `m.Request` = .T. if location is to be requested from server, otherwise from previous request if available |
| Request | - | Logical (.T. if success) | - |

| Response property | Type |
| --- | --- |
| Location | [oh_SearchResponseType](datatypes_geocode.md#oh_SearchResponseType "oh_SearchResponseType") |

| Parameter | Based on | Aggregator | Here name |
| --- | --- | --- | --- |
| AdditionalData | [oh_KeyValuePairsListType](datatypes_base.md#oh_KeyValuePairsListType "oh_KeyValuePairsListType") | - | additionaldata |
| AddressAttributes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | addressattributes |
| BoundingBox | [oh_GeoBoundingBoxType](datatypes_base.md#oh_GeoBoundingBoxType "oh_GeoBoundingBoxType") | - | bbox |
| CategoryIds | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | categoryids |
| CityName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | city |
| CountryFocus | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | countryfocus |
| CountryName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | country |
| CountyName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | county |
| DistrictName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | district |
| HouseNumber | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | housenumber |
| LandmarkName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | name |
| Language | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | language |
| LocationAttributes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | locationattributes |
| LocationId | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | locationid |
| MapView | [oh_GeoBoundingBoxType](datatypes_base.md#oh_GeoBoundingBoxType "oh_GeoBoundingBoxType") | - | mapview |
| MaxResults | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | maxresults |
| PageInformation | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | pageinformation |
| PoliticalView | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | politicalview |
| PostalCode | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | postalcode |
| Proximity | [oh_GeoProximityType](datatypes_base.md#oh_GeoProximityType "oh_GeoProximityType") | - | prox |
| ResponseAttributes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | responseattributes |
| SearchText | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | searchtext |
| StateName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | state |
| StreetName | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | street |
| StrictLanguageMode | [oh_BooleanType](datatypes_base.md#oh_BooleanType "oh_BooleanType") | - | strictlanguagemode |

<a name="reversegeocode" />

### ReverseGeocode

| Class | Source Location | Based on | Here API reference | Asynchronous |
| --- | --- | --- | --- | --- |
| oh_ReverseGeocode | [reverse.prg](../source/api/geocoding/reverse.prg "reverse.prg") | [oh_ReverseGeocodeResource](../source/api/geocoding/geocode.prg "oh_ReverseGeocodeResource") | [Reserve Geocode resource](https://developer.here.com/documentation/geocoder/dev_guide/topics/resource-reverse-geocode.html "Reverse Geocode Resource") | Disabled |

| Method | Args | Result | Notes |
| --- | --- | --- | --- |
| GetLocation | Request AS Logical | [oh_SearchResponseType](datatypes_geocode.md#oh_SearchResponseType "oh_SearchResponseType") (.NULL. if failed) | `m.Request` = .T. if location is to be requested from server, otherwise from previous request if available |
| Request | - | Logical (.T. if success) | - |

| Response property | Type |
| --- | --- |
| Location | [oh_SearchResponseType](datatypes_geocode.md#oh_SearchResponseType "oh_SearchResponseType") |

| Parameter | Based on | Aggregator | Here name |
| --- | --- | --- | --- |
| AdditionalData | [oh_KeyValuePairsListType](datatypes_base.md#oh_KeyValuePairsListType "oh_KeyValuePairsListType") | - | additionaldata |
| AddressAttributes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | addressattributes |
| Level | [oh_MatchLevelType](datatypes_geocode.md#oh_MatchLevelType "oh_MatchLevelType") | - | level |
| Language | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | language |
| Level | [oh_MatchLevelType](datatypes_geocode.md#oh_MatchLevelType "oh_MatchLevelType") | - | level |
| LocationAttributes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | locationattributes |
| MaxResults | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | maxresults |
| MinResults | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | minresults |
| Mode | [oh_ReverseGeocodeModeType](datatypes_geocode.md#oh_ReverseGeocodeModeType "oh_ReverseGeocodeModeType") | - | mode |
| PageInformation | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | pageinformation |
| PoliticalView | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | politicalview |
| Pos | [oh_GeoPositionType](datatypes_base.md#oh_GeoPositionType "oh_GeoPositionType") | - | pos |
| Proximity | [oh_GeoProximityType](datatypes_base.md#oh_GeoProximityType "oh_GeoProximityType") | - | prox |
| ResponseAttributes | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | responseattributes |
| SortBy | [oh_ReverseGeocodeSortByType](datatypes_geocode.md#oh_ReverseGeocodeSortByType "oh_ReverseGeocodeSortByType") | - | sortby |
| StrictLanguageMode | [oh_BooleanType](datatypes_base.md#oh_BooleanType "oh_BooleanType") | - | strictlanguagemode |

<a name="geocodeautocomplete" />

### GeocodeAutoComplete

| Class | Source Location | Based on | Here API reference | Asynchronous |
| --- | --- | --- | --- | --- |
| oh_GeocodeAutoComplete | [autocomplete.prg](../source/api/geocoding/autocomplete.prg "autocomplete.prg") | [oh_GeocodeResource](../source/api/geocoding/geocode.prg "oh_GeocodeResource") | [Geocode Autocomplete resource](https://developer.here.com/documentation/geocoder-autocomplete/topics/resource-suggest.html "Geocode Autocomplete resource") | Enabled |

| Method | Args | Result | Notes |
| --- | --- | --- | --- |
| GetSuggestion | Request AS Logical | [oh_SuggestionResponseType](datatypes_geocode.md#oh_SuggestionResponseType "oh_SuggestionResponseType") (.NULL. if failed) | `m.Request` = .T. if suggestion is to be requested from server, otherwise from previous request if available |
| Request | NoCall AS Logical | Logical (.T. if success) | `m.NoCall` = .T. if the request is to be built from a completed asynchronous call |

| Response property | Type |
| --- | --- |
| Suggestion | [oh_SuggestionResponseType](datatypes_geocode.md#oh_SuggestionResponseType "oh_SuggestionResponseType") |

| Parameter | Based on | Aggregator | Here name |
| --- | --- | --- | --- |
| BeginHighlight | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | beginhighlight |
| Country | [oh_ValuesListType](datatypes_base.md#oh_ValuesListType "oh_ValuesListType") | - | country |
| EndHighlight | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | endhighlight |
| Language | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | language |
| MapView | [oh_GeoBoundingBoxType](datatypes_base.md#oh_GeoBoundingBoxType "oh_GeoBoundingBoxType") | - | mapview |
| MaxResults | [oh_IntegerType](datatypes_base.md#oh_IntegerType "oh_IntegerType") | - | maxresults |
| Proximity | [oh_GeoProximityType](datatypes_base.md#oh_GeoProximityType "oh_GeoProximityType") | - | prox |
| QueryText | [oh_StringType](datatypes_base.md#oh_StringType "oh_StringType") | - | query |
