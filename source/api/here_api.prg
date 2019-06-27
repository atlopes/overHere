*************************************************************
*
* overHere base API classes
*
*************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

LOCAL oh_Path AS String

m.oh_Path = JUSTPATH(SYS(16))
SET PATH TO (m.oh_Path) ADDITIVE
SET PATH TO (ADDBS(m.oh_Path) + "maps") ADDITIVE
SET PATH TO (ADDBS(m.oh_Path) + "geocoding") ADDITIVE
SET PATH TO (ADDBS(m.oh_Path) + "routing") ADDITIVE
SET PATH TO (ADDBS(m.oh_Path) + "..\datatypes") ADDITIVE

DEFINE CLASS overHere AS Custom

	HTTP = .NULL.
	App_ID = ""
	App_Code = ""
	Production = .F.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="HTTP" type="property" display="HTTP" />' + ;
						'<memberdata name="app_id" type="property" display="App_ID" />' + ;
						'<memberdata name="app_code" type="property" display="App_Code" />' + ;
						'<memberdata name="production" type="property" display="Production" />' + ;
						'<memberdata name="setresource" type="method" display="SetResource" />' + ;
						'<memberdata name="call" type="method" display="Call" />' + ;
						'<memberdata name="setcredentials" type="method" display="SetCredentials" />' + ;
						'<memberdata name="composecredentials" type="method" display="ComposeCredentials" />' + ;
						'<memberdata name="composeargument" type="method" display="ComposeArgument" />' + ;
						'<memberdata name="urlencode" type="method" display="URLEncode" />' + ;
						'<memberdata name="floatpairbase64encoderx" type="method" display="FloatPairBase64EncoderX" />' + ;
						'<memberdata name="base64encoderx" type="method" display="Base64EncoderX" />' + ;
						'</VFPData>'

	FUNCTION Init ()

		This.HTTP = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0")
		This.HTTP.setTimeouts(0, 30000, 60000, 60000)

	ENDFUNC

	FUNCTION SetResource (ResourceClass AS String, ResourceLibrary AS String) AS oh_Resource

		LOCAL ResourceObj AS oh_Resource
		LOCAL Oh_ResourceClass AS String

		IF !(UPPER(LEFT(m.ResourceClass, 3)) == "OH_")
			m.Oh_ResourceClass = "oh_" + m.ResourceClass
		ELSE
			m.Oh_ResourceClass = m.ResourceClass
		ENDIF

		TRY
			IF PCOUNT() = 2
				m.ResourceObj = NEWOBJECT(m.oh_ResourceClass, m.ResourceLibrary, "", This)
			ELSE
				m.ResourceObj = CREATEOBJECT(m.oh_ResourceClass, This)
			ENDIF
		CATCH TO kkk
			m.ResourceObj = .NULL.
		ENDTRY

		RETURN m.ResourceObj

	ENDFUNC

	FUNCTION Call (Here AS oh_Resource, URL AS String, PostParameters AS String) AS Logical

		SAFETHIS

		m.Here.ServerCall = m.URL
		TRY
			IF EMPTY(m.PostParameters)
				m.Here.ServerParameters = ""
				This.HTTP.open("Get", m.URL, .F.)
				This.HTTP.send()
			ELSE
				m.Here.ServerParameters = m.PostParameters
				This.HTTP.open("Post", m.URL, .F.)
				This.HTTP.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8")
				This.HTTP.send(m.PostParameters)
			ENDIF
			m.Here.ServerStatus = This.HTTP.status
			m.Here.ServerStatusText = This.HTTP.statusText
			m.Here.ServerResponse = This.HTTP.responseBody
			m.Here.ServerXMLResponse = This.HTTP.responseXML
			m.Here.ServerHeaders = This.HTTP.getAllResponseHeaders()
		CATCH
			m.Here.ServerStatus = -1
			m.Here.ServerStatusText = "No access to server"
			m.Here.ServerResponse = 0h
			m.Here.ServerXMLResponse = .NULL.
			m.Here.ServerHeaders = ""
		ENDTRY		

		RETURN BETWEEN(m.Here.ServerStatus, 200, 299)

	ENDFUNC

	FUNCTION SetCredentials (Id AS String, Code AS String)

		This.App_ID = m.Id
		This.App_Code = m.Code

	ENDFUNC
			
	FUNCTION ComposeCredentials () AS String

		SAFETHIS

		RETURN This.ComposeArgument("app_id", This.App_ID) + "&" + This.ComposeArgument("app_code", This.App_Code)

	ENDFUNC

	FUNCTION ComposeArgument (ArgKey AS String, ArgValue AS String, UTF8 AS Boolean) AS String

		RETURN m.ArgKey + "=" + This.URLEncode(m.ArgValue, m.UTF8)

	ENDFUNC

	FUNCTION URLEncode (Text AS String, UTF8 AS Boolean) AS String

		LOCAL OriginalText AS String
		LOCAL Encoded AS String
		LOCAL CharIndex AS Integer
		LOCAL CharAt AS Character
		
		IF m.UTF8
			m.OriginalText = STRCONV(STRCONV(m.Text, 1), 9)
		ELSE
			m.OriginalText = m.Text
		ENDIF

		m.Encoded = ""
		FOR m.CharIndex = 1 TO LEN(m.OriginalText)
		
			m.CharAt = SUBSTR(m.OriginalText,m.CharIndex,1)
			
			IF m.CharAt == " "
				m.CharAt = "+"
			ELSE
				IF m.CharAt $ ":/|?#\[]@!$&'()*+,;=%" OR !BETWEEN(ASC(m.CharAt), 33, 127)
					m.CharAt = "%" + STRCONV(m.CharAt,15)
				ENDIF
			ENDIF

			m.Encoded = m.Encoded + m.CharAt
		
		ENDFOR
		
		RETURN m.Encoded

	ENDFUNC

	FUNCTION FloatPairBase64EncoderX (Item1 AS Double, Item2 AS Double, Prefix AS String) AS String

		RETURN This.Base64EncoderX(BINTOC(m.Item1, "FR") + BINTOC(m.Item2, "FR"), m.Prefix)

	ENDFUNC

	FUNCTION Base64EncoderX (Unencoded AS String, Prefix AS String)

		RETURN IIF(!EMPTY(m.Prefix), m.Prefix + ".", "") + CHRTRAN(TRIM(STRCONV(m.Unencoded, 13), 0, "="), "+/", "-_")

	ENDFUNC
	
ENDDEFINE
	
DEFINE CLASS oh_Resource AS Custom

	ResourceURL = ""
	ResourcePath = ""
	ResourceName = ""

	PostQueryString = .F.

	QueryString = ""
	QueryStringSeparator = ""

	ServerCall = ""
	ServerParameters = ""
	ServerStatus = 0
	ServerStatusText = ""
	ServerResponse = .NULL.
	ServerXMLResponse = .NULL.
	ServerHeaders = ""

	APIService = .NULL.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="resourceurl" type="property" display="ResourceURL" />' + ;
						'<memberdata name="resourcepath" type="property" display="ResourcePath" />' + ;
						'<memberdata name="resourcename" type="property" display="ResourceName" />' + ;
						'<memberdata name="querystring" type="property" display="QueryString" />' + ;
						'<memberdata name="postquerystring" type="property" display="PostQueryString" />' + ;
						'<memberdata name="querystringseparator" type="property" display="QueryStringSeparator" />' + ;
						'<memberdata name="servercall" type="property" display="ServerCall" />' + ;
						'<memberdata name="serverparameters" type="property" display="ServerParameters" />' + ;
						'<memberdata name="serverstatus" type="property" display="ServerStatus" />' + ;
						'<memberdata name="serverstatustext" type="property" display="ServerStatusText" />' + ;
						'<memberdata name="serverresponse" type="property" display="ServerResponse" />' + ;
						'<memberdata name="serverxmlresponse" type="property" display="ServerXMLResponse" />' + ;
						'<memberdata name="serverheaders" type="property" display="ServerHeaders" />' + ;
						'<memberdata name="apiservice" type="property" display="APIService" />' + ;
						'<memberdata name="preparequerystring" type="method" display="PrepareQueryString" />' + ;
						'<memberdata name="addargument" type="method" display="AddArgument" />' + ;
						'<memberdata name="addobjargument" type="method" display="AddObjArgument" />' + ;
						'<memberdata name="addflag" type="method" display="AddFlag" />' + ;
						'<memberdata name="buildurl" type="method" display="BuildURL" />' + ;
						'<memberdata name="call" type="method" display="Call" />' + ;
						'<memberdata name="preparerequest" type="method" display="PrepareRequest" />' + ;
						'<memberdata name="request" type="method" display="Request" />' + ;
						'</VFPData>'


	FUNCTION Init (API AS oh_API)

		SAFETHIS

		LOCAL ServerEnvironment AS String

		IF VARTYPE(m.API) == "O"
			This.APIService = m.API
			m.ServerEnvironment = IIF(m.API.Production, "", ".cit")
			This.ResourceURL = STRTRAN(This.ResourceURL, "{cit}", m.ServerEnvironment)
		ELSE
			RETURN .F.
		ENDIF

	ENDFUNC

	FUNCTION Destroy ()

		This.APIService = .NULL.

	ENDFUNC

	FUNCTION QueryString_Assign (NewValue AS String)

		This.QueryString = m.NewValue
		This.QueryStringSeparator = IIF(EMPTY(m.NewValue), "", "&")

	ENDFUNC

	FUNCTION PrepareQueryString ()

		This.QueryString = ""

	ENDFUNC

	FUNCTION AddArgument (ArgKey AS String, ArgValue AS String, UTF8 AS Boolean)

		SAFETHIS

		This.QueryString = This.QueryString + This.QueryStringSeparator + ;
			This.APIService.ComposeArgument(m.ArgKey, m.ArgValue, m.UTF8)

	ENDFUNC

	FUNCTION AddObjArgument (ArgKey AS String, ArgValue AS oh_Datatype, UTF8 AS Boolean) AS Logical

		SAFETHIS

		IF m.ArgValue.IsSet()
			This.QueryString = This.QueryString + This.QueryStringSeparator + ;
				This.APIService.ComposeArgument(m.ArgKey, m.ArgValue.ToString(), m.UTF8)
			RETURN .T.
		ENDIF

		RETURN .F.
	
	ENDFUNC

	FUNCTION AddFlag (FlagKey AS String, FlagValue AS Logical)

		SAFETHIS

		IF m.FlagValue
			This.QueryString = This.QueryString + This.QueryStringSeparator + m.FlagKey
		ENDIF

	ENDFUNC

	FUNCTION BuildURL () AS String

		SAFETHIS

		RETURN This.ResourceURL + This.ResourcePath + This.ResourceName + "?" + This.APIService.ComposeCredentials()

	ENDFUNC

	FUNCTION Call () AS Logical

		SAFETHIS

		IF This.PostQueryString
			RETURN This.APIService.Call(This, This.BuildURL(), This.QueryString)
		ELSE
			RETURN This.APIService.Call(This, This.BuildURL() + "&" + This.QueryString)
		ENDIF

	ENDFUNC

	PROCEDURE PrepareRequest ()
	ENDPROC

	FUNCTION Request () AS Logical
		RETURN .F.
	ENDFUNC

ENDDEFINE

