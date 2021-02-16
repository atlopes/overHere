*************************************************************
*
* overHere geocode datatypes classes
*
*************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_ReverseGeocodeModeType AS oh_EnumerationType

	_Enumeration = "retrieveAddresses,retrieveAreas,retrieveLandmarks,retrieveAll,trackPosition"

ENDDEFINE

DEFINE CLASS oh_ReverseGeocodeSortByType AS oh_EnumerationType

	_Enumeration = "distance,population,size"

ENDDEFINE

DEFINE CLASS oh_MatchLevelType AS oh_EnumerationType

	_Enumeration = "country,state,county,city,district,street,intersection,houseNumber,postalCode,landmark"

ENDDEFINE

DEFINE CLASS oh_MatchTypeType AS oh_EnumerationType

	_Enumeration = "pointAddress,interpolated"

ENDDEFINE

DEFINE CLASS oh_MatchCodeType AS oh_EnumerationType

	_Enumeration = "exact,ambiguous,upHierarchy,ambiguousUpHierarchy"

ENDDEFINE

DEFINE CLASS oh_LocationTypeType AS oh_EnumerationType

	_Enumeration = "area,address,trail,park,lake,mountainPeak,volcano,river,golfCourse,industrialComplex,island," + ;
						"woodland,cemetery,canalWaterChannel,bayHarbor,airport,hospital,sportsComplex,shoppingCentre," + ;
						"universityCollege,nativeAmericanReservation,railroad,militaryBase,parkingLot,parkingGarage," + ;
						"animalPark,beach,distanceMarker,point"

ENDDEFINE

DEFINE CLASS oh_FunctionalClassType AS oh_IntegerType

	Minimum = 1
	Maximum = 5

ENDDEFINE

DEFINE CLASS oh_LinkFlagType AS oh_EnumerationType

	_Enumeration = "ControlledAccess,MultiDigitized,Frontage,Paved,Ramp,Private,Tollway,PoiAccess,FourWheelDrive,ParkingLotRoad" + ;
						"CarpoolRoad,Reversible,ExpressLane"

ENDDEFINE

DEFINE CLASS oh_LinkAccessFlagType AS oh_EnumerationType

	_Enumeration = "Automobiles,Buses,Taxis,Carpools,Pedestrians,Trucks,Deliveries,EmergencyVehicle,ThroughTraffic,Motorcycles"

ENDDEFINE

DEFINE CLASS oh_RelationshipType AS oh_EnumerationType

	_Enumeration = "nearByDistanceMarker,nearByAddress,microPointAddress"

ENDDEFINE

DEFINE CLASS oh_UTCTimeOffsetType AS oh_Datatype

	RequireRegEx = .T.

	FUNCTION Set (Hours AS Integer, Minutes AS Integer) AS Logical

		SAFETHIS

		IF This.IsValid(m.Hours, m.Minutes)
			This.Value = TEXTMERGE("UTC<<IIF(m.Hours < 0,'-','+')>><<TRANSFORM(ABS(m.Hours),'@L 99')>>:<<TRANSFORM(m.Minutes,'@L 99')>>")
			This._IsSet = .T.
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION IsValid (Hours AS Integer, Minutes AS Integer) AS Logical

		RETURN VARTYPE(m.Hours) + VARTYPE(m.Minutes) == "NN" ;
			AND m.Hours = INT(m.Hours) AND m.Minutes = INT(m.Minutes) ;
			AND BETWEEN(m.Hours, -12, 14) ;
			AND BETWEEN(m.Minutes, 0, 59) ;
			AND (m.Hours > -12 OR m.Minutes = 0) ;
			AND (m.Hours < 14 OR m.Minutes = 0)

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		This.RegEx.Pattern = "^UTC[+-][0-9]{2}:[0-9]{2}$"
		IF This.RegEx.Test(m.Input)
			RETURN This.Set(VAL(SUBSTR(m.Input, 4, 3)), VAL(SUBSTR(m.Input, 8)))
		ELSE
			This._IsSet = .F.
			RETURN .F.
		ENDIF

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_CurrencyType AS oh_EnumerationType

	_Enumeration = "AED,AFN,ALL,AMD,ANG,AOA,ARS,AUD,AWG,AZN,BAM,BBD,BDT,BGN,BHD,BIF,BMD,BND,BOB,BOV,BRL,BSD,BTN,BWP,BYN,BZD," + ;
						"CAD,CDF,CHE,CHF,CHW,CLF,CLP,CNY,COP,COU,CRC,CUC,CUP,CVE,CZK,DJF,DKK,DOP,DZD,EGP,ERN,ETB,EUR,FJD,FKP," + ;
						"GBP,GEL,GHS,GIP,GMD,GNF,GTQ,GYD,HKD,HNL,HRK,HTG,HUF,IDR,ILS,INR,IQD,IRR,ISK,JMD,JOD,JPY," + ;
						"KES,KGS,KHR,KMF,KPW,KRW,KWD,KYD,KZT,LAK,LBP,LKR,LRD,LSL,LYD," + ;
						"MAD,MDL,MGA,MKD,MMK,MNT,MOP,MRU,MUR,MVR,MWK,MXN,MXV,MYR,MZN,NAD,NGN,NIO,NOK,NPR,NZD,OMR," + ;
						"PAB,PEN,PGK,PHP,PKR,PLN,PYG,QAR,RON,RSD,RUB,RWF,SAR,SBD,SCR,SDG,SEK,SGD,SHP,SLL,SOS,SRD,SSP,STN,SVC,SYP,SZL," + ;
						"THB,TJS,TMT,TND,TOP,TRY,TTD,TWD,TZS,UAH,UGX,USD,USN,UYI,UYU,UYW,UZS,VES,VND,VUV,WST," + ;
						"XAF,XAG,XAU,XBA,XBB,XBC,XBD,XCD,XDR,XOF,XPD,XPF,XPT,XSU,XTS,XUA,XXX,YER,ZAR,ZMW,ZWL"

ENDDEFINE

DEFINE CLASS oh_DrivingSideType AS oh_EnumerationType

	_Enumeration = "left,right"

ENDDEFINE

DEFINE CLASS oh_SystemOfMeasurementType AS oh_EnumerationType

	_Enumeration = "imperial,metric"

ENDDEFINE

DEFINE CLASS oh_SpeedCategoryType AS oh_EnumerationType

	_Enumeration = "SC1,SC2,SC3,SC4,SC5,SC6,SC7,SC8"

ENDDEFINE

DEFINE CLASS oh_SpeedLimitUnitType AS oh_EnumerationType

	_Enumeration = "kph,mph"

ENDDEFINE

DEFINE CLASS oh_SpeedLimitType AS oh_IntegerType

	Minimum = 1
	Maximum = 999

	ADD OBJECT Unit AS oh_SpeedLimitUnitType

	FUNCTION Set (Limit AS Integer, Unit AS String) AS Logical

		SAFETHIS

		IF !(oh_IntegerType::Set(m.Limit) AND This.Unit.Set(m.Unit))
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION ToString ()

		RETURN oh_IntegerType::ToString() + This.Unit.ToString()

	ENDFUNC

ENDDEFINE

*************************************************************
* structures
*************************************************************

DEFINE CLASS oh_SearchResponseType AS oh_Structure

	ADD OBJECT MetaInfo AS oh_SearchResponseMetaInfoType
	ADD OBJECT Views AS Collection && OF oh_SearchResponseViewType

	Members = '<member type="oh_SearchResponseMetaInfoType" name="MetaInfo" />' + ;
					'<member type="collection:oh_SearchResponseViewType" name="Views" element="View" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="metainfo" type="property" display="MetaInfo" />' + ;
						'<memberdata name="views" type="property" display="Views" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_SearchResponseViewType AS oh_Structure

	ADD OBJECT ViewId AS oh_StringType
	ADD OBJECT PerformedSearch AS oh_StringType

	ADD OBJECT Results AS Collection && OF oh_SearchResultType

	Members = '<member type="oh_StringType" name="ViewId" />' + ;
					'<member type="oh_StringType" name="PerformedSearch" />' + ;
					'<member type="collection:oh_SearchResultType" name="Results" element="Result" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="viewid" type="property" display="ViewId" />' + ;
						'<memberdata name="performedsearch" type="property" display="PerformedSearch" />' + ;
						'<memberdata name="results" type="property" display="Results" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_SearchResponseMetaInfoType AS oh_Structure

	ADD OBJECT RequestId AS oh_StringType
	ADD OBJECT Timestamp AS oh_DatetimeType
	ADD OBJECT NextPage AS oh_IntegerType
	ADD OBJECT PreviousPage AS oh_IntegerType

	ADD OBJECT AdditionalData AS Collection && KEY OF oh_StringType

	Members = '<member type="oh_StringType" name="RequestId" />' + ;
					'<member type="oh_DatetimeType" name="Timestamp" />' + ;
					'<member type="oh_IntegerType" name="NextPage" />' + ;
					'<member type="oh_IntegerType" name="PreviousPage" />' + ;
					'<member type="keys:oh_StringType" name="AdditionalData" key="@key" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="requestid" type="property" display="RequestId" />' + ;
						'<memberdata name="timestamp" type="property" display="Timestamp" />' + ;
						'<memberdata name="nextpage" type="property" display="NextPage" />' + ;
						'<memberdata name="previouspage" type="property" display="PreviousPage" />' + ;
						'<memberdata name="additionaldata" type="property" display="AdditionalData" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_SearchResultType AS oh_Structure

	ADD OBJECT Relevance AS oh_DoubleType
	ADD OBJECT Distance AS oh_DistanceType
	ADD OBJECT Direction AS oh_HeadingType
	ADD OBJECT MatchLevel AS oh_MatchLevelType
	ADD OBJECT MatchQuality AS Collection && OF oh_MatchQualityType
	ADD OBJECT MatchType AS oh_MatchTypeType
	ADD OBJECT Location AS oh_LocationType
	ADD OBJECT Place AS oh_PlaceType
	ADD OBJECT ParsedRequest AS oh_ParsedRequestType

	ADD OBJECT AdditionalData AS Collection && KEY OF oh_StringType

	Members = '<member type="oh_DoubleType" name="Relevance" />' + ;
						'<member type="oh_DistanceType" name="Distance" />' + ;
						'<member type="oh_HeadingType" name="Direction" />' + ;
						'<member type="oh_MatchLevelType" name="MatchLevel" />' + ;
						'<member type="collection:oh_MatchQualityType" name="MatchQuality" />' + ;
						'<member type="oh_MatchTypeType" name="MatchType" />' + ;
						'<member type="oh_LocationType" name="Location" />' + ;
						'<member type="oh_PlaceType" name="Place" />' + ;
						'<member type="oh_ParsedRequestType" name="ParsedRequest" />' + ;
						'<member type="keys:oh_StringType" name="AdditionalData" key="@key" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="relevance" type="property" display="Relevance" />' + ;
						'<memberdata name="distance" type="property" display="Distance" />' + ;
						'<memberdata name="direction" type="property" display="Direction" />' + ;
						'<memberdata name="matchlevel" type="property" display="MatchLevel" />' + ;
						'<memberdata name="matchquality" type="property" display="MatchQuality" />' + ;
						'<memberdata name="matchtype" type="property" display="MatchType" />' + ;
						'<memberdata name="location" type="property" display="Location" />' + ;
						'<memberdata name="place" type="property" display="Place" />' + ;
						'<memberdata name="parsedrequest" type="property" display="ParsedRequest" />' + ;
						'<memberdata name="additionaldata" type="property" display="AdditionalData" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_PlaceType AS oh_Structure

	ADD OBJECT PlaceId AS oh_StringType
	ADD OBJECT PlaceName AS oh_StringType
	ADD OBJECT Category AS oh_CategoryType
	ADD OBJECT Location AS oh_LocationType

	Members = '<member type="oh_StringType" name="PlaceId" />' + ;
					'<member type="oh_StringType" name="PlaceName" element="Name" />' + ;
					'<member type="oh_CategoryType" name="Category" />' + ;
					'<member type="oh_LocationType" name="Location" element="Locations" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="placeid" type="property" display="PlaceId" />' + ;
						'<memberdata name="placename" type="property" display="PlaceName" />' + ;
						'<memberdata name="category" type="property" display="Category" />' + ;
						'<memberdata name="location" type="property" display="Location" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_LocationType AS oh_BaseLocationType

	ADD OBJECT Related AS oh_RelatedLocationType
	
	AdditionalMembers = '<member type="oh_RelatedLocationType" name="Related" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="related" type="property" display="Related" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_BaseLocationType AS oh_Structure

	ADD OBJECT LocationId AS oh_StringType
	ADD OBJECT LocationType AS oh_LocationTypeType
	ADD OBJECT LocationName AS oh_StringType
	ADD OBJECT DisplayPosition AS oh_GeoCoordinateType
	ADD OBJECT NavigationPosition AS oh_GeoCoordinateType
	ADD OBJECT MapView AS oh_GeoBoundingBoxType
	ADD OBJECT Shape AS oh_GeoShapeType
	ADD OBJECT Address AS oh_AddressType
	ADD OBJECT AddressDetails AS oh_AddressDetailsType
	ADD OBJECT AddressNames AS oh_AddressNamesType
	ADD OBJECT MapReference AS oh_MapReferenceType
	ADD OBJECT LinkInfo AS oh_LinkInfoType
	ADD OBJECT AdminInfo AS oh_AdminInfoType

	ADD OBJECT AdditionalData AS Collection && KEY OF oh_StringType

	Members = '<member type="oh_StringType" name="LocationId" />' + ;
					'<member type="oh_LocationTypeType" name="LocationType" />' + ;
					'<member type="oh_StringType" name="LocationName" element="Name" />' + ;
					'<member type="oh_GeoCoordinateType" name="DisplayPosition" />' + ;
					'<member type="oh_GeoCoordinateType" name="NavigationPosition" />' + ;
					'<member type="oh_GeoBoundingBoxType" name="MapView" />' + ;
					'<member type="oh_GeoShapeType" name="Shape" />' + ;
					'<member type="oh_AddressType" name="Address" />' + ;
					'<member type="oh_AddressNamesType" name="AddressDetails" />' + ;
					'<member type="oh_AddressNamesType" name="AddressNames" />' + ;
					'<member type="oh_MapReferenceType" name="MapReference" />' + ;
					'<member type="oh_LinkInfoType" name="LinkInfo" />' + ;
					'<member type="oh_AdminInfoType" name="AdminInfo" />' + ;
					'<member type="keys:oh_StringType" name="AdditionalData" key="@key" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="locationid" type="property" display="LocationId" />' + ;
						'<memberdata name="locationtype" type="property" display="LocationType" />' + ;
						'<memberdata name="locationname" type="property" display="LocationName" />' + ;
						'<memberdata name="displayposition" type="property" display="DisplayPosition" />' + ;
						'<memberdata name="navigationposition" type="property" display="NavigationPosition" />' + ;
						'<memberdata name="mapview" type="property" display="MapView" />' + ;
						'<memberdata name="shape" type="property" display="Shape" />' + ;
						'<memberdata name="address" type="property" display="Address" />' + ;
						'<memberdata name="addressdetails" type="property" display="AddressDetails" />' + ;
						'<memberdata name="addressnames" type="property" display="AddressNames" />' + ;
						'<memberdata name="mapreference" type="property" display="MapReference" />' + ;
						'<memberdata name="linkinfo" type="property" display="LinkInfo" />' + ;
						'<memberdata name="admininfo" type="property" display="AdminInfo" />' + ;
						'<memberdata name="additionaldata" type="property" display="AdditionalData" />' + ;
						'</VFPData>'


ENDDEFINE

DEFINE CLASS oh_MatchQualityType AS oh_Structure

	ADD OBJECT Country AS oh_DoubleType
	ADD OBJECT State AS oh_DoubleType
	ADD OBJECT County AS oh_DoubleType
	ADD OBJECT City AS oh_DoubleType
	ADD OBJECT District AS oh_DoubleType
	ADD OBJECT SubDistrict AS oh_DoubleType
	DIMENSION Street(1) && OF oh_DoubleType
	ADD OBJECT HouseNumber AS oh_DoubleType
	ADD OBJECT PostalCode AS oh_DoubleType
	ADD OBJECT Building AS oh_DoubleType

	Members = '<member type="oh_DoubleType" name="Country" />' + ;
					'<member type="oh_DoubleType" name="State" />' + ;
					'<member type="oh_DoubleType" name="County" />' + ;
					'<member type="oh_DoubleType" name="City" />' + ;
					'<member type="oh_DoubleType" name="District" />' + ;
					'<member type="oh_DoubleType" name="SubDistrict" />' + ;
					'<member type="array:oh_DoubleType" name="Street" />' + ;
					'<member type="oh_DoubleType" name="HouseNumber" />' + ;
					'<member type="oh_DoubleType" name="PostalCode" />' + ;
					'<member type="oh_DoubleType" name="Building" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="country" type="property" display="Country" />' + ;
						'<memberdata name="state" type="property" display="State" />' + ;
						'<memberdata name="county" type="property" display="County" />' + ;
						'<memberdata name="city" type="property" display="City" />' + ;
						'<memberdata name="district" type="property" display="District" />' + ;
						'<memberdata name="subdistrict" type="property" display="SubDistrict" />' + ;
						'<memberdata name="street" type="property" display="Street" />' + ;
						'<memberdata name="housenumber" type="property" display="HouseNumber" />' + ;
						'<memberdata name="postalcode" type="property" display="PostalCode" />' + ;
						'<memberdata name="building" type="property" display="Building" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_ParsedRequestType AS oh_BaseAddressType

	ADD OBJECT LandmarkName AS oh_StringType
	ADD OBJECT Label AS oh_StringType
	ADD OBJECT AddressLine AS oh_StringType

	ADD OBJECT AdditionalData AS Collection && KEY OF oh_StringType

	AdditionalMembers = '<member type="oh_StringType" name="LandmarkName" element="Name" />' + ;
								'<member type="oh_StringType" name="Label" />' + ;
								'<member type="oh_StringType" name="AddressLine" />' + ;
								'<member type="keys:oh_StringType" name="AdditionalData" key="@key" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="landmarkname" type="property" display="LandmarkName" />' + ;
						'<memberdata name="label" type="property" display="Label" />' + ;
						'<memberdata name="addressline" type="property" display="AddressLine" />' + ;
						'<memberdata name="additionaldata" type="property" display="AdditionalData" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_AddressType AS oh_BaseAddressType

	ADD OBJECT Label AS oh_StringType
	ADD OBJECT DistanceMarker AS oh_DistanceMarkerType
	ADD OBJECT AddressLine AS oh_StringType

	ADD OBJECT AdditionalData AS Collection && KEY OF oh_StringType

	AdditionalMembers = '<member type="oh_StringType" name="Label" />' + ;
								'<member type="oh_DistanceMarkerType" name="DistanceMarker" />' + ;
								'<member type="oh_StringType" name="AddressLine" />' + ;
								'<member type="keys:oh_StringType" name="AdditionalData" key="@key" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="label" type="property" display="Label" />' + ;
						'<memberdata name="distancemarker" type="property" display="DistanceMarker" />' + ;
						'<memberdata name="addressline" type="property" display="AddressLine" />' + ;
						'<memberdata name="additionaldata" type="property" display="AdditionalData" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_DistanceMarkerType AS oh_Structure

	ADD OBJECT Value AS oh_StringType
	ADD OBJECT Offset AS oh_DoubleType
	ADD OBJECT Unit AS oh_DistanceUnitType
	ADD OBJECT DirectionOnSign AS oh_StringType

	Members = '<member type="oh_StringType" name="Value" />' + ;
					'<member type="oh_DoubleType" name="Offset" />' + ;
					'<member type="oh_DistanceUnitType" name="Unit" />' + ;
					'<member type="oh_StringType" name="DirectionOnSign" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="value" type="property" display="Value" />' + ;
						'<memberdata name="offset" type="property" display="Offset" />' + ;
						'<memberdata name="unit" type="property" display="Unit" />' + ;
						'<memberdata name="directiononsign" type="property" display="DirectionOnSign" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_AddressDetailsType AS oh_BaseAddressType

	ADD OBJECT CountryCode AS oh_StringType
	ADD OBJECT StreetDetails AS oh_StreetDetailsType

	AdditionalMembers = '<member type="oh_StringType" name="CountryCode" />' + ;
								'<member type="oh_StreetDetailsType" name="StreetDetails" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="countrycode" type="property" display="CountryCode" />' + ;
						'<memberdata name="streetdetails" type="property" display="StreetDetails" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_StreetDetailsType AS oh_Structure

	ADD OBJECT BaseName AS oh_StringType
	ADD OBJECT StreetType AS oh_StringType
	ADD OBJECT StreetTypeBefore AS oh_StringType
	ADD OBJECT StreetTypeAttached AS oh_StringType
	ADD OBJECT Prefix AS oh_StringType
	ADD OBJECT Suffix AS oh_StringType
	ADD OBJECT Direction AS oh_StringType

	Members = '<member type="oh_StringType" name="BaseName" />' + ;
					'<member type="oh_StringType" name="StreetType" />' + ;
					'<member type="oh_StringType" name="StreetTypeBefore" />' + ;
					'<member type="oh_StringType" name="StreetTypeAttached" />' + ;
					'<member type="oh_StringType" name="Prefix" />' + ;
					'<member type="oh_StringType" name="Suffix" />' + ;
					'<member type="oh_StringType" name="Direction" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="basename" type="property" display="BaseName" />' + ;
						'<memberdata name="streettype" type="property" display="StreetType" />' + ;
						'<memberdata name="streettypebefore" type="property" display="StreetTypeBefore" />' + ;
						'<memberdata name="streettypeattached" type="property" display="StreetTypeAttached" />' + ;
						'<memberdata name="prefix" type="property" display="Prefix" />' + ;
						'<memberdata name="suffix" type="property" display="Suffix" />' + ;
						'<memberdata name="direction" type="property" display="Direction" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_MapReferenceType AS oh_Structure

	ADD OBJECT ReferenceId AS oh_StringType
	ADD OBJECT MapVersion AS oh_StringType
	ADD OBJECT MapReleaseDate AS oh_DateType
	ADD OBJECT MapId AS oh_StringType
	ADD OBJECT Spot AS oh_IntegerType
	ADD OBJECT SideOfStreet AS oh_SideOfStreetType
	ADD OBJECT CountryId AS oh_StringType
	ADD OBJECT StateId AS oh_StringType
	ADD OBJECT CountyId AS oh_StringType
	ADD OBJECT CityId AS oh_StringType
	ADD OBJECT DistrictId AS oh_StringType
	ADD OBJECT RoadLinkId AS oh_StringType
	ADD OBJECT BuildingId AS oh_StringType
	ADD OBJECT AddressId AS oh_StringType

	Members = '<member name="ReferenceId" type="oh_StringType" />' + ;
					'<member name="MapVersion" type="oh_StringType" />' + ;
					'<member name="MapReleaseDate" type="oh_DateType" />' + ;
					'<member name="MapId" type="oh_StringType" />' + ;
					'<member name="Spot" type="oh_IntegerType" />' + ;
					'<member name="SideOfStreet" type="oh_SideOfStreetType" />' + ;
					'<member name="CountryId" type="oh_StringType" />' + ;
					'<member name="StateId" type="oh_StringType" />' + ;
					'<member name="CountyId" type="oh_StringType" />' + ;
					'<member name="CityId" type="oh_StringType" />' + ;
					'<member name="DistrictId" type="oh_StringType" />' + ;
					'<member name="RoadLinkId" type="oh_StringType" />' + ;
					'<member name="BuildingId" type="oh_StringType" />' + ;
					'<member name="AddressId" type="oh_StringType" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="referenceid" type="property" display="ReferenceId" />' + ;
						'<memberdata name="mapversion" type="property" display="MapVersion" />' + ;
						'<memberdata name="mapreleasedate" type="property" display="MapReleaseDate" />' + ;
						'<memberdata name="mapid" type="property" display="MapId" />' + ;
						'<memberdata name="spot" type="property" display="Spot" />' + ;
						'<memberdata name="sideofstreet" type="property" display="SideOfStreet" />' + ;
						'<memberdata name="countryid" type="property" display="CountryId" />' + ;
						'<memberdata name="stateid" type="property" display="StateId" />' + ;
						'<memberdata name="countyid" type="property" display="CountyId" />' + ;
						'<memberdata name="cityid" type="property" display="CityId" />' + ;
						'<memberdata name="districtid" type="property" display="DistrictId" />' + ;
						'<memberdata name="roadlinkid" type="property" display="RoadLinkId" />' + ;
						'<memberdata name="buildingid" type="property" display="BuildingId" />' + ;
						'<memberdata name="addressid" type="property" display="AddressId" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_LinkInfoType AS oh_Structure

	ADD OBJECT FunctionalClass AS oh_FunctionalClassType
	ADD OBJECT TravelDirection AS oh_CardinalDirectionType
	ADD OBJECT SpeedCategory AS oh_SpeedCategoryType
	ADD OBJECT SpeedLimit AS oh_SpeedLimitType
	ADD OBJECT Traffic AS oh_StringType
	ADD OBJECT LinkFlags AS Collection && LIST OF oh_LinkFlagType
	ADD OBJECT AcessFlags AS Collection && LIST OF oh_LinkAccessFlagType

	Members = '<member name="FunctionalClass" type="oh_FunctionalClassType" />' + ;
					'<member name="TravelDirection" type="oh_CardinalDirectionType" />' + ;
					'<member name="SpeedCategory" type="oh_SpeedCategoryType" />' + ;
					'<member name="SpeedLimit" type="oh_SpeedLimitType" />' + ;
					'<member name="Traffic" type="oh_StringType" />' + ;
					'<member name="LinkFlags" type="list:oh_LinkFlagType" />' + ;
					'<member name="AcessFlags" type="list:oh_LinkAccessFlagType" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="functionalclass" type="property" display="FunctionalClass" />' + ;
						'<memberdata name="traveldirection" type="property" display="TravelDirection" />' + ;
						'<memberdata name="speedcategory" type="property" display="SpeedCategory" />' + ;
						'<memberdata name="speedlimit" type="property" display="SpeedLimit" />' + ;
						'<memberdata name="traffic" type="property" display="Traffic" />' + ;
						'<memberdata name="linkflags" type="property" display="LinkFlags" />' + ;
						'<memberdata name="acessflags" type="property" display="AcessFlags" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_AdminInfoType AS oh_Structure

	ADD OBJECT LocalTime AS oh_DatetimeType
	ADD OBJECT UTCTimezoneOffset AS oh_UTCTimeOffsetType
	ADD OBJECT Currency AS oh_CurrencyType
	ADD OBJECT DrivingSide AS oh_DrivingSideType
	ADD OBJECT SystemOfMeasure AS oh_SystemOfMeasurementType
	ADD OBJECT Timezone AS oh_TimezoneType

	Members = '<member name="LocalTime" type="oh_DatetimeType" />' + ;
					'<member name="UTCTimezoneOffset" type="oh_UTCTimeOffsetType" />' + ;
					'<member name="Currency" type="oh_CurrencyType" />' + ;
					'<member name="DrivingSide" type="oh_DrivingSideType" />' + ;
					'<member name="SystemOfMeasure" type="oh_SystemOfMeasurementType" />' + ;
					'<member name="TimeZone" type="oh_TimezoneType" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="localtime" type="property" display="LocalTime" />' + ;
						'<memberdata name="utctimezoneoffset" type="property" display="UTCTimezoneOffset" />' + ;
						'<memberdata name="currency" type="property" display="Currency" />' + ;
						'<memberdata name="drivingside" type="property" display="DrivingSide" />' + ;
						'<memberdata name="systemofmeasure" type="property" display="SystemOfMeasure" />' + ;
						'<memberdata name="timezone" type="property" display="Timezone" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_TimezoneType AS oh_Structure

	ADD OBJECT Id AS oh_StringType
	ADD OBJECT Offset AS oh_IntegerType
	ADD OBJECT RawOffset AS oh_IntegerType
	ADD OBJECT NameShort AS oh_StringType
	ADD OBJECT NameLong AS oh_StringType
	ADD OBJECT NameDstShort AS oh_StringType
	ADD OBJECT NameDstLong AS oh_StringType
	ADD OBJECT InDaylightTime AS oh_BooleanType
	ADD OBJECT DstSavings AS oh_IntegerType

	Members = '<member name="Id" type="oh_StringType" />' + ;
					'<member name="Offset" type="oh_IntegerType" />' + ;
					'<member name="RawOffset" type="oh_IntegerType" />' + ;
					'<member name="NameShort" type="oh_StringType" />' + ;
					'<member name="NameLong" type="oh_StringType" />' + ;
					'<member name="NameDstShort" type="oh_StringType" />' + ;
					'<member name="NameDstLong" type="oh_StringType" />' + ;
					'<member name="InDaylightTime" type="oh_BooleanType" />' + ;
					'<member name="DstSavings" type="oh_IntegerType" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="id" type="property" display="Id" />' + ;
						'<memberdata name="offset" type="property" display="Offset" />' + ;
						'<memberdata name="rawoffset" type="property" display="RawOffset" />' + ;
						'<memberdata name="nameshort" type="property" display="NameShort" />' + ;
						'<memberdata name="namelong" type="property" display="NameLong" />' + ;
						'<memberdata name="namedstshort" type="property" display="NameDstShort" />' + ;
						'<memberdata name="namedstlong" type="property" display="NameDstLong" />' + ;
						'<memberdata name="indaylighttime" type="property" display="InDaylightTime" />' + ;
						'<memberdata name="dstsavings" type="property" display="DstSavings" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_RelatedLocationType AS oh_Structure

	ADD OBJECT Type AS oh_RelationshipType
	ADD OBJECT MatchType AS oh_MatchTypeType
	ADD OBJECT RouteDistance AS oh_DoubleType
	ADD OBJECT Direction AS oh_HeadingType
	ADD OBJECT Location AS oh_BaseLocationType

	Members = '<member name="Type" type="oh_RelationshipType" />' + ;
					'<member name="MatchType" type="oh_MatchTypeType" />' + ;
					'<member name="RouteDistance" type="oh_DoubleType" />' + ;
					'<member name="Direction" type="oh_HeadingType" />' + ;
					'<member name="Location" type="oh_BaseLocationType" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="type" type="property" display="Type" />' + ;
						'<memberdata name="matchtype" type="property" display="MatchType" />' + ;
						'<memberdata name="routedistance" type="property" display="RouteDistance" />' + ;
						'<memberdata name="direction" type="property" display="Direction" />' + ;
						'<memberdata name="location" type="property" display="Location" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_AddressNamesType AS oh_Structure

	ADD OBJECT Country AS Collection && OF oh_StringType
	ADD OBJECT State AS Collection && OF oh_StringType
	ADD OBJECT County AS Collection && OF oh_StringType
	ADD OBJECT City AS Collection && OF oh_StringType
	ADD OBJECT District AS Collection && OF oh_StringType
	ADD OBJECT SubDistrict AS Collection && OF oh_StringType
	ADD OBJECT Street AS Collection && OF oh_StringType

	Members = '<member name="Country" type="collection:oh_StringType" />' + ;
					'<member name="State" type="collection:oh_StringType" />' + ;
					'<member name="County" type="collection:oh_StringType" />' + ;
					'<member name="City" type="collection:oh_StringType" />' + ;
					'<member name="District" type="collection:oh_StringType" />' + ;
					'<member name="SubDistrict" type="collection:oh_StringType" />' + ;
					'<member name="Street" type="collection:oh_StringType" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="country" type="property" display="Country" />' + ;
						'<memberdata name="state" type="property" display="State" />' + ;
						'<memberdata name="county" type="property" display="County" />' + ;
						'<memberdata name="city" type="property" display="City" />' + ;
						'<memberdata name="district" type="property" display="District" />' + ;
						'<memberdata name="subdistrict" type="property" display="SubDistrict" />' + ;
						'<memberdata name="street" type="property" display="Street" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_BaseAddressType AS oh_Structure

	ADD OBJECT Country AS oh_StringType
	ADD OBJECT State AS oh_StringType
	ADD OBJECT County AS oh_StringType
	ADD OBJECT City AS oh_StringType
	ADD OBJECT District AS oh_StringType
	ADD OBJECT SubDistrict AS oh_StringType
	ADD OBJECT Street AS oh_StringType
	ADD OBJECT HouseNumber AS oh_StringType
	ADD OBJECT PostalCode AS oh_StringType
	ADD OBJECT Building AS oh_StringType

	Members = '<member name="Country" type="oh_StringType" />' + ;
					'<member name="State" type="oh_StringType" />' + ;
					'<member name="County" type="oh_StringType" />' + ;
					'<member name="City" type="oh_StringType" />' + ;
					'<member name="District" type="oh_StringType" />' + ;
					'<member name="SubDistrict" type="oh_StringType"/>' + ;
					'<member name="Street" type="oh_StringType" />' + ;
					'<member name="HouseNumber" type="oh_StringType" />' + ;
					'<member name="PostalCode" type="oh_StringType" />' + ;
					'<member name="Building" type="oh_StringType" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="country" type="property" display="Country" />' + ;
						'<memberdata name="state" type="property" display="State" />' + ;
						'<memberdata name="county" type="property" display="County" />' + ;
						'<memberdata name="city" type="property" display="City" />' + ;
						'<memberdata name="district" type="property" display="District" />' + ;
						'<memberdata name="subdistrict" type="property" display="SubDistrict" />' + ;
						'<memberdata name="street" type="property" display="Street" />' + ;
						'<memberdata name="housenumber" type="property" display="HouseNumber" />' + ;
						'<memberdata name="postalcode" type="property" display="PostalCode" />' + ;
						'<memberdata name="building" type="property" display="Building" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_CategoryType AS oh_Structure

	ADD OBJECT CategoryId AS oh_IntegerType
	ADD OBJECT CategorySystemId AS oh_StringType

	Members = '<member type="oh_IntegerType" name="CategoryId" />' + ;
					'<member type="oh_StringType" name="CategorySystemId" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="categoryid" type="property" display="CategoryId" />' + ;
						'<memberdata name="categorysystemid" type="property" display="CategorySystemId" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_SuggestionResponseType AS oh_Structure

	ADD OBJECT suggestions AS Collection && OF oh_GeocodeSuggestionType

	Members = '<member type="collection:oh_GeocodeSuggestionType" name="suggestions" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="suggestions" type="property" display="Suggestions" />' + ;
						'</VFPData>'
ENDDEFINE

DEFINE CLASS oh_GeocodeSuggestionType AS oh_Structure

	ADD OBJECT label AS oh_StringType
	ADD OBJECT language AS oh_LanguageCodeType
	ADD OBJECT countryCode AS oh_CountryCodeType
	ADD OBJECT locationId AS oh_StringType
	ADD OBJECT address AS oh_SuggestedAddressType
	ADD OBJECT distance AS oh_DistanceType
	ADD OBJECT matchLevel AS oh_MatchLevelType

	Members = '<member type="oh_StringType" name="label" />' + ;
					'<member type="oh_LanguageCodeType" name="language" />' + ;
					'<member type="oh_CountryCodeType" name="countryCode" />' + ;
					'<member type="oh_StringType" name="locationId" />' + ;
					'<member type="oh_SuggestedAddressType" name="address" />' + ;
					'<member type="oh_DistanceType" name="distance" />' + ;
					'<member type="oh_MatchLevelType" name="matchLevel" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="label" type="property" display="Label" />' + ;
						'<memberdata name="language" type="property" display="Language" />' + ;
						'<memberdata name="countrycode" type="property" display="CountryCode" />' + ;
						'<memberdata name="locationid" type="property" display="LocationId" />' + ;
						'<memberdata name="address" type="property" display="Address" />' + ;
						'<memberdata name="distance" type="property" display="Distance" />' + ;
						'<memberdata name="matchlevel" type="property" display="MatchLevel" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_SuggestedAddressType AS oh_Structure

	ADD OBJECT Country AS oh_StringType
	ADD OBJECT State AS oh_StringType
	ADD OBJECT County AS oh_StringType
	ADD OBJECT City AS oh_StringType
	ADD OBJECT District AS oh_StringType
	ADD OBJECT Street AS oh_StringType
	ADD OBJECT HouseNumber AS oh_StringType
	ADD OBJECT Unit AS oh_StringType
	ADD OBJECT PostalCode AS oh_StringType

	Members = '<member name="country" type="oh_StringType" />' + ;
					'<member name="state" type="oh_StringType" />' + ;
					'<member name="county" type="oh_StringType" />' + ;
					'<member name="city" type="oh_StringType" />' + ;
					'<member name="district" type="oh_StringType" />' + ;
					'<member name="street" type="oh_StringType" />' + ;
					'<member name="houseNumber" type="oh_StringType" />' + ;
					'<member name="postalCode" type="oh_StringType" />' + ;
					'<member name="unit" type="oh_StringType" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="country" type="property" display="Country" />' + ;
						'<memberdata name="state" type="property" display="State" />' + ;
						'<memberdata name="county" type="property" display="County" />' + ;
						'<memberdata name="city" type="property" display="City" />' + ;
						'<memberdata name="district" type="property" display="District" />' + ;
						'<memberdata name="street" type="property" display="Street" />' + ;
						'<memberdata name="housenumber" type="property" display="HouseNumber" />' + ;
						'<memberdata name="postalcode" type="property" display="PostalCode" />' + ;
						'<memberdata name="unit" type="property" display="Unit" />' + ;
						'</VFPData>'

ENDDEFINE
