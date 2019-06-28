**************************************************************
*
* overHere / geocode / autocomplete
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "geocode.prg")

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_GeocodeAutoComplete AS oh_GeocodeResource

	ResourceURL = "https://autocomplete.geocoder{cit}.api.here.com"
	ResourceName = "suggest.json"

	AsyncEnabled = .T.

	* request and response adjustment
	ADD OBJECT Language AS oh_StringType
	ADD OBJECT MaxResults AS oh_IntegerType WITH Minimum = 1, Maximum = 20
	ADD OBJECT BeginHighlight AS oh_StringType
	ADD OBJECT EndHighlight AS oh_StringType

	* filters
	ADD OBJECT MapView AS oh_GeoBoundingBoxType
	ADD OBJECT Proximity AS oh_GeoProximityType
	ADD OBJECT Country AS oh_ValuesListType WITH ValuesClass = "oh_CountryCodeType"

	ADD OBJECT QueryText AS oh_StringType

	* response object
	ADD OBJECT Response AS oh_ResponseJSON

	Suggestion = .NULL.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="language" type="property" display="Language" />' + ;
						'<memberdata name="maxresults" type="property" display="MaxResults" />' + ;
						'<memberdata name="beginhighlight" type="property" display="BeginHighlight" />' + ;
						'<memberdata name="endhighlight" type="property" display="EndHighlight" />' + ;
						'<memberdata name="mapview" type="property" display="MapView" />' + ;
						'<memberdata name="proximity" type="property" display="Proximity" />' + ;
						'<memberdata name="country" type="property" display="Country" />' + ;
						'<memberdata name="querytext" type="property" display="QueryText" />' + ;
						'<memberdata name="response" type="property" display="Response" />' + ;
						'<memberdata name="suggestion" type="property" display="Suggestion" />' + ;
						'<memberdata name="getsuggestion" type="method" display="GetSuggestion" />' + ;
						'</VFPData>'

	FUNCTION GetSuggestion (Request AS Logical) AS oh_SuggestionResponseType

		SAFETHIS

		IF !m.Request OR This.Request()
			RETURN This.Suggestion
		ELSE
			RETURN .NULL.
		ENDIF

	ENDFUNC

	FUNCTION Request (NoCall AS Logical) AS Logical

		SAFETHIS

		LOCAL XML AS MSXML2.DOMDocument60

		This.PrepareRequest()

		IF m.NoCall OR This.Call()
			IF !This.Async OR m.NoCall
				m.XML = This.Response.ToXML("" + This.ServerResponse, "AutoComplete")
				IF !ISNULL(m.XML)
					This.Suggestion = This.Response.Read(m.XML.selectNodes("/AutoComplete").item(0), CREATEOBJECT("oh_SuggestionResponseType"))
				ENDIF
			ENDIF
		ENDIF

		RETURN !ISNULL(This.Suggestion)

	ENDFUNC

	PROCEDURE PrepareRequest ()

		SAFETHIS

		This.Suggestion = .NULL.

		This.PrepareQueryString()

		This.AddObjArgument("language", This.Language)
		This.AddObjArgument("maxresults", This.MaxResults)
		This.AddObjArgument("beginhighlight", This.BeginHighlight, .T.)
		This.AddObjArgument("endhighlight", This.EndHighlight, .T.)

		This.AddObjArgument("mapview", This.MapView)
		This.AddObjArgument("prox", This.Proximity)
		This.AddObjArgument("country", This.Country)

		This.AddObjArgument("query", This.QueryText, .T.)

	ENDPROC

ENDDEFINE