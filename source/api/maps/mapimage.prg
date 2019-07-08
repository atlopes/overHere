**************************************************************
*
* overHere / maps / mapimage
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "maps")

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_MapImage AS oh_MapsResource

	* map characteristics
	ADD OBJECT MapScheme AS oh_MapSchemeType

	ADD OBJECT ZoomLevel AS oh_ZoomLevelType
	ADD OBJECT PoliticalView AS oh_StringType

	* map elements
	ADD OBJECT Language AS oh_StringType

	* resulting image
	ADD OBJECT ImageFormat AS oh_ImageFormatType
	ADD OBJECT ImageHeight AS oh_IntegerType
	ADD OBJECT ImageWidth AS oh_IntegerType
	ADD OBJECT Resolution AS oh_IntegerType
	ADD OBJECT ImageCompression AS oh_IntegerType

	* flags
	NoCropping = .F.
	NoCopyright = .F.

	PictureObject = .NULL.

	Base64Encoding = .F.
	EncodingPrefix = .T.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="mapscheme" type="property" display="MapScheme" />' + ;
						'<memberdata name="zoomlevel" type="property" display="ZoomLevel" />' + ;
						'<memberdata name="politicalview" type="property" display="PoliticalView" />' + ;
						'<memberdata name="language" type="property" display="Language" />' + ;
						'<memberdata name="imageformat" type="property" display="ImageFormat" />' + ;
						'<memberdata name="imageheight" type="property" display="ImageHeight" />' + ;
						'<memberdata name="imagewidth" type="property" display="ImageWidth" />' + ;
						'<memberdata name="resolution" type="property" display="Resolution" />' + ;
						'<memberdata name="imagecompression" type="property" display="ImageCompression" />' + ;
						'<memberdata name="nocropping" type="property" display="NoCropping" />' + ;
						'<memberdata name="nocopyright" type="property" display="NoCopyright" />' + ;
						'<memberdata name="pictureobject" type="property" display="PictureObject" />' + ;
						'<memberdata name="base64encoding" type="property" display="Base64Encoding" />' + ;
						'<memberdata name="encodingprefix" type="property" display="EncodingPrefix" />' + ;
						'<memberdata name="getimage" type="method" display="GetImage" />' + ;
						'</VFPData>'

	FUNCTION GetImage (Request AS Logical) AS Blob

		SAFETHIS

		IF (m.Request AND This.Request()) OR !ISNULL(This.PictureObject)
			RETURN This.PictureObject
		ELSE
			RETURN 0h
		ENDIF

	ENDFUNC

	FUNCTION Request () AS Logical

		SAFETHIS

		This.PrepareRequest()
		
		IF This.Call()
			This.PictureObject = This.ServerResponse
		ELSE
			This.PictureObject = .NULL.
		ENDIF

		RETURN !ISNULL(This.PictureObject)

	ENDFUNC

	PROCEDURE PrepareRequest ()

		SAFETHIS

		This.PrepareQueryString()

		This.AddObjArgument("t", This.MapScheme)
		This.AddObjArgument("z", This.ZoomLevel)
		This.AddObjArgument("pview", This.PoliticalView)

		This.AddObjArgument("ml", This.Language)

		This.AddObjArgument("f", This.ImageFormat)
		This.AddObjArgument("h", This.ImageHeight)
		This.AddObjArgument("w", This.ImageWidth)
		This.AddObjArgument("ppi", This.Resolution)
		This.AddObjArgument("q", This.ImageCompression)

		This.AddFlag("nocp", This.NoCopyright)
		This.AddFlag("nocrop", This.NoCropping)

	ENDPROC

	PROTECTED FUNCTION _Pos (Coord AS oh_GeoCoordinateType, NumArg AS String, EncArg AS String) AS Logical

		SAFETHIS

		LOCAL Argument AS String

		IF m.Coord.IsSet()
			IF This.Base64Encoding
				m.Argument = This.APIService.FloatPairBase64EncoderX(m.Coord.Get("Lat"), m.Coord.Get("Long"), IIF(This.EncodingPrefix, "e", ""))
				This.AddArgument(IIF(!This.EncodingPrefix, m.EncArg, m.NumArg), m.Argument)
			ELSE
				m.Argument = m.Coord.ToString()
				This.AddArgument(m.NumArg, m.Argument)
			ENDIF
			RETURN .T.
		ENDIF

		RETURN .F.
	ENDFUNC

ENDDEFINE