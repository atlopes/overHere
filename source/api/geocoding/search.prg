**************************************************************
*
* overHere / geocode / search
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "geocode.prg")

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_GeocodeSearch AS oh_GeocodeResource

	ResourceName = "geocode.xml"

	* request and response adjustment
	ADD OBJECT AdditionalData AS oh_KeyValuePairsListType
	ADD OBJECT AddressAttributes AS oh_ValuesListType
	ADD OBJECT LocationAttributes AS oh_ValuesListType
	ADD OBJECT ResponseAttributes AS oh_ValuesListType
	ADD OBJECT Language AS oh_StringType
	ADD OBJECT PoliticalView AS oh_StringType
	ADD OBJECT StrictLanguageMode as oh_BooleanType

	* filters
	ADD OBJECT BoundingBox AS oh_GeoBoundingBoxType
	ADD OBJECT MapView AS oh_GeoBoundingBoxType
	ADD OBJECT Proximity AS oh_GeoProximityType

	ADD OBJECT CountryName AS oh_StringType
	ADD OBJECT CountryFocus AS oh_StringType
	ADD OBJECT StateName AS oh_StringType
	ADD OBJECT CountyName AS oh_StringType
	ADD OBJECT CityName AS oh_StringType
	ADD OBJECT DistrictName AS oh_StringType
	ADD OBJECT StreetName AS oh_StringType
	ADD OBJECT HouseNumber AS oh_StringType
	ADD OBJECT PostalCode AS oh_StringType

	ADD OBJECT LocationId AS oh_StringType

	ADD OBJECT SearchText AS oh_StringType

	* pagination
	ADD OBJECT MaxResults AS oh_IntegerType
	ADD OBJECT PageInformation AS oh_IntegerType

	* response object
	ADD OBJECT Response AS oh_Response

	Location = .NULL.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="additionaldata" type="property" display="AdditionalData" />' + ;
						'<memberdata name="addressattributes" type="property" display="AddressAttributes" />' + ;
						'<memberdata name="locationattributes" type="property" display="LocationAttributes" />' + ;
						'<memberdata name="responseattributes" type="property" display="ResponseAttributes" />' + ;
						'<memberdata name="language" type="property" display="Language" />' + ;
						'<memberdata name="politicalview" type="property" display="PoliticalView" />' + ;
						'<memberdata name="strictlanguagemode" type="property" display="StrictLanguageMode" />' + ;
						'<memberdata name="boundingbox" type="property" display="BoundingBox" />' + ;
						'<memberdata name="mapview" type="property" display="MapView" />' + ;
						'<memberdata name="proximity" type="property" display="Proximity" />' + ;
						'<memberdata name="countryname" type="property" display="CountryName" />' + ;
						'<memberdata name="countryfocus" type="property" display="CountryFocus" />' + ;
						'<memberdata name="statename" type="property" display="StateName" />' + ;
						'<memberdata name="countyname" type="property" display="CountyName" />' + ;
						'<memberdata name="cityname" type="property" display="CityName" />' + ;
						'<memberdata name="districtname" type="property" display="DistrictName" />' + ;
						'<memberdata name="streetname" type="property" display="StreetName" />' + ;
						'<memberdata name="housenumber" type="property" display="HouseNumber" />' + ;
						'<memberdata name="postalcode" type="property" display="PostalCode" />' + ;
						'<memberdata name="locationid" type="property" display="LocationId" />' + ;
						'<memberdata name="searchtext" type="property" display="SearchText" />' + ;
						'<memberdata name="maxresults" type="property" display="MaxResults" />' + ;
						'<memberdata name="pageinformation" type="property" display="PageInformation" />' + ;
						'<memberdata name="response" type="property" display="Response" />' + ;
						'<memberdata name="location" type="property" display="Location" />' + ;
						'<memberdata name="getlocation" type="method" display="GetLocation" />' + ;
						'</VFPData>'

	FUNCTION GetLocation (Request AS Logical) AS oh_SearchResponseType

		SAFETHIS

		IF !m.Request OR This.Request()
			RETURN This.Location
		ELSE
			RETURN .NULL.
		ENDIF

	ENDFUNC

	FUNCTION Request () AS Logical

		SAFETHIS

		This.PrepareRequest()

		IF This.Call()
			This.Location = This.Response.Read(This.APIService.ServerXMLResponse.selectNodes("//Response").item(0), CREATEOBJECT("oh_SearchResponseType"))
		ENDIF

		RETURN !ISNULL(This.Location)

	ENDFUNC

	PROCEDURE PrepareRequest ()

		SAFETHIS

		This.Location = .NULL.

		This.PrepareQueryString()

		This.AddObjArgument("additionaldata", This.AdditionalData)
		This.AddObjArgument("addressattributes", This.AddressAttributes)
		This.AddObjArgument("locationattributes", This.LocationAttributes)
		This.AddObjArgument("responseattributes", This.ResponseAttributes)
		This.AddObjArgument("language", This.Language)
		This.AddObjArgument("politicalview", This.PoliticalView)
		This.AddObjArgument("strictlanguagemode", This.StrictLanguageMode)

		This.AddObjArgument("bbox", This.BoundingBox)
		This.AddObjArgument("mapview", This.MapView)
		This.AddObjArgument("prox", This.Proximity)

		This.AddObjArgument("country", This.CountryName, .T.)
		This.AddObjArgument("countryfocus", This.CountryFocus)
		This.AddObjArgument("state", This.StateName, .T.)
		This.AddObjArgument("county", This.CountyName, .T.)
		This.AddObjArgument("city", This.CityName, .T.)
		This.AddObjArgument("district", This.DistrictName, .T.)
		This.AddObjArgument("street", This.StreetName, .T.)
		This.AddObjArgument("housenumber", This.HouseNumber, .T.)
		This.AddObjArgument("postalcode", This.PostalCode, .T.)

		This.AddObjArgument("locationid", This.LocationId)

		This.AddObjArgument("searchtext", This.SearchText, .T.)

		This.AddObjArgument("maxresults", This.MaxResults)
		This.AddObjArgument("pageinformation", This.PageInformation)

	ENDPROC

ENDDEFINE