**************************************************************
*
* overHere / geocode / reverse
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "geocode.prg")

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_ReverseGeocode AS oh_ReverseGeocodeResource

	ResourceName = "reversegeocode.xml"

	* request and response adjustment
	ADD OBJECT AdditionalData AS oh_KeyValuePairsListType
	ADD OBJECT AddressAttributes AS oh_ValuesListType
	ADD OBJECT LocationAttributes AS oh_ValuesListType
	ADD OBJECT ResponseAttributes AS oh_ValuesListType
	ADD OBJECT Language AS oh_StringType
	ADD OBJECT PoliticalView AS oh_StringType
	ADD OBJECT StrictLanguageMode AS oh_BooleanType
	ADD OBJECT SortBy AS oh_ReverseGeocodeSortByType

	* filters
	ADD OBJECT Proximity AS oh_GeoProximityType
	ADD OBJECT MinResults AS oh_IntegerType
	ADD OBJECT Mode AS oh_ReverseGeocodeModeType
	ADD OBJECT Level AS oh_MatchLevelType

	ADD OBJECT Pos AS oh_GeoPositionType

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
						'<memberdata name="sortby" type="property" display="SortBy" />' + ;
						'<memberdata name="proximity" type="property" display="Proximity" />' + ;
						'<memberdata name="minresults" type="property" display="MinResults" />' + ;
						'<memberdata name="mode" type="property" display="Mode" />' + ;
						'<memberdata name="level" type="property" display="Level" />' + ;
						'<memberdata name="pos" type="property" display="Pos" />' + ;
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
			This.Location = This.Response.Read(This.ServerXMLResponse.selectNodes("//Response").item(0), CREATEOBJECT("oh_SearchResponseType"))
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
		This.AddObjArgument("sortby", This.SortBy)

		This.AddObjArgument("prox", This.Proximity)
		This.AddObjArgument("minresults", This.MinResults)
		This.AddObjArgument("mode", This.Mode)
		This.AddObjArgument("level", This.Level)

		This.AddObjArgument("pos", This.Pos)

		This.AddObjArgument("maxresults", This.MaxResults)
		This.AddObjArgument("pageinformation", This.PageInformation)

	ENDPROC

ENDDEFINE