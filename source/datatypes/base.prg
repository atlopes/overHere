*************************************************************
*
* overHere base datatypes classes
*
*************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_LatitudeType AS oh_DoubleType

	Precision = 7
	Minimum = -90
	Maximum = 90

ENDDEFINE

DEFINE CLASS oh_LongitudeType AS oh_DoubleType

	Precision = 7
	Minimum = -180
	Maximum = 180

ENDDEFINE

DEFINE CLASS oh_DistanceType AS oh_DoubleType

	Precision = 4

ENDDEFINE

DEFINE CLASS oh_DistanceUnitType AS oh_EnumerationType

	_Enumeration = "mi,km"

ENDDEFINE

DEFINE CLASS oh_MetricSystemType AS oh_EnumerationType

	_Enumeration = "imperial,metric"

ENDDEFINE

DEFINE CLASS oh_DurationType AS oh_IntegerType

	Minimum = 0

ENDDEFINE

DEFINE CLASS oh_HeadingType AS oh_DoubleType

	Precision = 4

	FUNCTION IsValid (Input AS Double) AS Logical

		RETURN oh_DoubleType::IsValid(m.Input) AND m.Input >= 0 AND m.Input < 360

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_CardinalDirectionType AS oh_EnumerationType

	_Enumeration = "N,E,S,W,NE,SE,SW,NW"

ENDDEFINE

DEFINE CLASS oh_CountryCodeType AS oh_EnumerationType

	_Enumeration = "ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,ASM,ATA,ATF,ATG,AUS,AUT,AZE," + ;
		"BDI,BEL,BEN,BES,BFA,BGD,BGR,BHR,BHS,BIH,BLM,BLR,BLZ,BMU,BOL,BRA,BRB,BRN,BTN,BVT,BWA," + ;
		"CAF,CAN,CCK,CHE,CHL,CHN,CIV,CMR,COD,COG,COK,COL,COM,CPV,CRI,CUB,CUW,CXR,CYM,CYP,CZE," + ;
		"DEU,DJI,DMA,DNK,DOM,DZA,ECU,EGY,ERI,ESH,ESP,EST,ETH,FIN,FJI,FLK,FRA,FRO,FSM," + ;
		"GAB,GBR,GEO,GGY,GHA,GIB,GIN,GLP,GMB,GNB,GNQ,GRC,GRD,GRL,GTM,GUF,GUM,GUY,HKG,HMD,HND,HRV,HTI,HUN," + ;
		"IDN,IMN,IND,IOT,IRL,IRN,IRQ,ISL,ISR,ITA,JAM,JEY,JOR,JPN,KAZ,KEN,KGZ,KHM,KIR,KNA,KOR,KWT," + ;
		"LAO,LBN,LBR,LBY,LCA,LIE,LKA,LSO,LTU,LUX,LVA," + ;
		"MAC,MAF,MAR,MCO,MDA,MDG,MDV,MEX,MHL,MKD,MLI,MLT,MMR,MNE,MNG,MNP,MOZ,MRT,MSR,MTQ,MUS,MWI,MYS,MYT," + ;
		"NAM,NCL,NER,NFK,NGA,NIC,NIU,NLD,NOR,NPL,NRU,NZL,OMN,PAK,PAN,PCN,PER,PHL,PLW,PNG,POL,PRI,PRK,PRT,PRY,PSE,PYF," + ;
		"QAT,REU,ROU,RUS,RWA,SAU,SDN,SEN,SGP,SGS,SHN,SJM,SLB,SLE,SLV,SMR,SOM,SPM,SRB,SSD,STP,SUR,SVK,SVN,SWE,SWZ,SXM,SYC,SYR," + ;
		"TCA,TCD,TGO,THA,TJK,TKL,TKM,TLS,TON,TTO,TUN,TUR,TUV,TWN,TZA,UGA,UKR,UMI,URY,USA,UZB," + ;
		"VAT,VCT,VEN,VGB,VIR,VNM,VUT,WLF,WSM,YEM,ZAF,ZMB,ZWE"

ENDDEFINE

DEFINE CLASS oh_ShapeFormatType AS oh_EnumerationType

	_Enumeration = "WKT"

ENDDEFINE

DEFINE CLASS oh_GeoCoordinateType AS oh_Datatype

	ADD OBJECT Latitude AS oh_LatitudeType
	ADD OBJECT Longitude AS oh_LongitudeType
	ADD OBJECT Altitude AS oh_DoubleType

	_SetXML = .T.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="latitude" type="property" display="Latitude" />' + ;
						'<memberdata name="longitude" type="property" display="Longitude" />' + ;
						'<memberdata name="altitude" type="property" display="Altitude" />' + ;
						'</VFPData>'

	FUNCTION Set (Lat AS Double, Long AS Double, Alt AS Double) AS Logical

		LOCAL Result AS Logical

		m.Result = This.Latitude.Set(m.Lat) AND This.Longitude.Set(m.Long)
		IF m.Result
			IF PCOUNT() = 3
				m.Result = This.Altitude.Set(m.Alt)
			ELSE
				This.Altitude.Reset()
			ENDIF
		ENDIF

		This._IsSet = m.Result

		RETURN m.Result

	ENDFUNC

	FUNCTION IsValid (Lat AS Double, Long AS Double, Alt AS Double)

		RETURN This.Latitude.IsValid(m.Lat) AND This.Longitude.IsValid(m.Long) AND (PCOUNT() = 2 OR This.Altitude.IsValid(m.Alt))

	ENDFUNC

	FUNCTION SetXML (Source AS MSXML2.IXMLDOMNode) AS Logical

		SAFETHIS

		LOCAL Lat AS MSXML2.IXMLDOMNode
		LOCAL Long AS MSXML2.IXMLDOMNode
		LOCAL Alt AS MSXML2.IXMLDOMNode

		IF !ISNULL(m.Source)

			m.Lat = m.Source.selectNodes("Latitude").item(0)
			m.Long = m.Source.selectNodes("Longitude").item(0)
			m.Alt = m.Source.selectNodes("Altitude").item(0)

			IF !ISNULL(m.Lat) AND !ISNULL(m.Long)

				IF ISNULL(m.Alt)
					This.Parse(m.Lat.text + "," + m.Long.text)
				ELSE
					This.Parse(m.Lat.text + "," + m.Long.text + "," + m.Alt.text)
				ENDIF

			ELSE

				This.Reset()

			ENDIF

		ELSE

			This.Reset()

		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Get (Coord AS String) AS Double

		LOCAL _Coord AS String
		LOCAL LenCoord AS Integer

		m._Coord = TRIM(UPPER(m.Coord))
		m.LenCoord = LEN(m._Coord)

		DO CASE
		CASE m.LenCoord < 4
			RETURN .NULL.

		CASE PADR("LATITUDE", m.LenCoord) == m._Coord
			RETURN This.Latitude.Get()

		CASE PADR("LONGITUDE", m.LenCoord) == m._Coord
			RETURN This.Longitude.Get()

		CASE PADR("ALTITUDE", m.LenCoord) == m._Coord
			RETURN This.Altitude.Get()

		OTHERWISE
			RETURN .NULL.
		ENDCASE

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		LOCAL ARRAY Parts(1)
		LOCAL Result AS Logical

		IF BETWEEN(ALINES(m.Parts, m.Input, 0, ","), 2, 3)

			m.Result = This.Latitude.Parse(m.Parts(1)) AND This.Longitude.Parse(m.Parts(2))
			IF m.Result
				IF ALEN(m.Parts) = 3
					m.Result = This.Altitude.Parse(m.Parts(3))
				ELSE
					This.Altitude.Reset()
				ENDIF
			ENDIF
		ELSE
			m.Result = .F.
		ENDIF

		This._IsSet = m.Result
		RETURN m.Result

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL Result AS String

		m.Result = This.Latitude.ToString() + "," + This.Longitude.ToString()
		IF !ISNULL(This.Altitude.Get())
			m.Result = m.Result + "," + This.Altitude.ToString()
		ENDIF

		RETURN m.Result

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_GeoBoundingBoxType AS oh_Datatype

	ADD OBJECT TopLeft AS oh_GeoCoordinateType
	ADD OBJECT BottomRight AS oh_GeoCoordinateType

	_SetXML = .T.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="topleft" type="property" display="TopLeft" />' + ;
						'<memberdata name="bottomright" type="property" display="BottomRight" />' + ;
						'</VFPData>'

	FUNCTION Set (Corner AS String, Lat AS Double, Long AS Double, Alt AS Double) AS Logical

		LOCAL CornerCoord AS oh_GeoCoordinateType
		LOCAL Success AS Logical

		m.CornerCoord = This.GetCorner(m.Corner)
		IF !ISNULL(m.CornerCoord)
			IF PCOUNT() = 4
				m.Success = m.CornerCoord.Set(m.Lat, m.Long, m.Alt)
			ELSE
				m.Success = m.CornerCoord.Set(m.Lat, m.Long)
			ENDIF
			This._IsSet = This.TopLeft.IsSet() AND This.BottomRight.IsSet()
			RETURN m.Success
		ENDIF

		This._IsSet = .F.
		RETURN .F.

	ENDFUNC

	FUNCTION SetXML (Source AS MSXML2.IXMLDOMNode) AS Logical

		SAFETHIS

		IF !ISNULL(m.Source)

			This._IsSet = This.TopLeft.SetXML(m.Source.selectNodes("TopLeft").item(0)) AND ;
								This.BottomRight.SetXML(m.Source.selectNodes("BottomRight").item(0))

		ELSE

			This.Reset()

		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Get (Corner AS String, Coord AS String)

		LOCAL CornerCoord AS oh_GeoCoordinateType

		m.CornerCoord = This.GetCorner(m.Corner)
		IF !ISNULL(m.CornerCoord)
			RETURN m.CornerCoord.Get(m.Coord)
		ENDIF

		RETURN .NULL.

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		SAFETHIS

		LOCAL ARRAY Parts(1)

		IF ALINES(m.Parts, m.Input, 0, ";") = 2
			This._IsSet = This.TopLeft.Parse(m.Parts(1)) AND This.BottomRight.Parse(m.Parts(2))
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC		

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		RETURN This.TopLeft.ToString() + ";" + This.BottomRight.ToString()

	ENDFUNC

	HIDDEN FUNCTION GetCorner (Corner AS String) AS oh_GeoCoordinateType

		SAFETHIS

		LOCAL _Corner AS String
		LOCAL LenCorner AS Integer

		m._Corner = UPPER(m.Corner)
		m.LenCorner = LEN(m._Corner)

		DO CASE
		CASE m.LenCorner < 2
			RETURN .NULL.

		CASE m._Corner == "TL" OR PADR(LEFT("TOPLEFT", m.LenCorner), m.LenCorner) == m._Corner
			RETURN This.TopLeft

		CASE m._Corner == "BR" OR PADR(LEFT("BOTTOMRIGHT", m.LenCorner), m.LenCorner) == m._Corner
			RETURN This.BottomRight

		OTHERWISE
			RETURN .NULL.
		ENDCASE

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_GeoBoundingBoxArrayType AS oh_Datatype

	FUNCTION PreInit

		This.Value = CREATEOBJECT("Collection")

	ENDFUNC

	FUNCTION Set (Corner AS String, Lat AS Double, Long AS Double, Alt AS Double) AS Logical

		SAFETHIS

		LOCAL BoundingBox AS oh_GeoBoundingBoxType

		m.BoundingBox = CREATEOBJECT("oh_GeoBoundingBoxType")
		IF (PCOUNT() = 3 AND m.BoundingBox.Set(m.Corner, m.Lat, m.Long)) OR (PCOUNT() = 4 AND m.BoundingBox.Set(m.Corner, m.Lat, m.Long, m.Alt))
			This.Value.Add(m.BoundingBox)
			This._IsSet = .T.
		ELSE
			This.Reset()
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		This.Value.Remove(-1)
		This._IsSet = .F.

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		SAFETHIS

		LOCAL ARRAY Elements(1)
		LOCAL BoundingBoxStr AS String
		LOCAL BoundingBox AS oh_GeoBoundingBoxType

		m.BoundingBox = CREATEOBJECT("oh_GeoBoundingBoxType")

		ALINES(m.Elements, m.Input, 0, "!")

		FOR EACH m.BoundingBoxStr IN m.Elements
			IF !m.BoundingBox.Parse(m.BoundingBoxStr)
				This.Reset()
				EXIT
			ELSE
				This.Value.Add(m.BoundingBox)
				This._IsSet = .T.
			ENDIF
		ENDFOR

		RETURN This._IsSet

	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL BoundingBox AS oh_GeoBoundingBoxType
		LOCAL Result AS String
		LOCAL Sep AS Character

		m.Result = ""
		m.Sep = ""

		FOR EACH m.BoundingBox IN This.Value
			m.Result = m.Result + m.Sep + m.BoundingBox.ToString()
			m.Sep = "!"
		ENDFOR

		RETURN m.Result

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_GeoCoordinatesListType AS oh_ValuesListType

	ValuesClass = "oh_GeoCoordinateType"

	FUNCTION Set (Lat AS Double, Long AS Double)

		SAFETHIS

		LOCAL Element AS oh_GeoCoordinateType

		m.Element = CREATEOBJECT(This.ValuesClass)

		IF m.Element.Set(m.Lat, m.Long)
			This.Value.Add(m.Element)
			This._IsSet = .T.
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		SAFETHIS

		LOCAL ARRAY Parts(1)
		LOCAL NumCoords AS Integer
		LOCAL Value AS Integer

		This.Reset()

		m.NumCoords = ALINES(m.Parts, m.Input, 0, ",")
		IF m.NumCoords % 2 = 0
			FOR m.Value = 1 TO m.NumCoords STEP 2
				IF !This.Set(VAL(CHRTRAN(m.Parts(m.Value), ".", SET("Point"))), VAL(CHRTRAN(m.Parts(m.Value + 1), ".", SET("Point"))))
					This.Reset()
					EXIT
				ENDIF
			ENDFOR
		ENDIF

		RETURN This._IsSet

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_GeoPolylineType AS oh_GeoCoordinatesListType
ENDDEFINE

DEFINE CLASS oh_GeoProximityType AS oh_Datatype

	ADD OBJECT Center AS oh_GeoCoordinateType
	ADD OBJECT Radius AS oh_DoubleType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="center" type="property" display="Center" />' + ;
						'<memberdata name="radius" type="property" display="Radius" />' + ;
						'</VFPData>'

	FUNCTION Set (Lat AS Double, Long AS Double, Alt AS Double, Radius AS Double) AS Logical
		
		SAFETHIS

		IF This.Center.Set(m.Lat, m.Long)	&& Altitude not being used...
			IF PCOUNT() = 4
				This._IsSet = This.Radius.Set(m.Radius)
			ELSE
				This.Radius.Reset()
				This._IsSet = .T.
			ENDIF
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Get (Coord AS String) AS Double

		IF PCOUNT() = 0
			RETURN This.Radius.Get()
		ELSE
			RETURN This.Center.Get(m.Coord)
		ENDIF

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		IF This.Center.Parse(LEFT(m.Input, RAT(",", m.Input) - 1))
			RETURN This.Radius.Parse(SUBSTR(m.Input, RAT(",", m.Input) + 1))
		ENDIF

		RETURN .F.

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL RadString AS String

		m.RadString = This.Radius.ToString()
		RETURN This.Center.ToString() + IIF(!EMPTY(m.RadString), "," + m.RadString, "")

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_GeoPositionType AS oh_Datatype

	ADD OBJECT Coordinate AS oh_GeoCoordinateType
	ADD OBJECT Heading AS oh_HeadingType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="coordinate" type="property" display="Coordinate" />' + ;
						'<memberdata name="heading" type="property" display="Heading" />' + ;
						'</VFPData>'

	FUNCTION Set (Lat AS Double, Long AS Double, Alt AS Double, Heading AS Double) AS Logical
		
		SAFETHIS

		IF This.Coordinate.Set(m.Lat, m.Long)	&& Altitude not being used...
			IF PCOUNT() = 4
				This._IsSet = This.Heading.Set(m.Heading)
			ELSE
				This.Heading.Reset()
				This._IsSet = .T.
			ENDIF
		ELSE
			This._IsSet = .F
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Get (Coord AS String) AS Double

		IF PCOUNT() = 0
			RETURN This.Heading.Get()
		ELSE
			RETURN This.Coordinate.Get(m.Coord)
		ENDIF

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		IF This.Coordinate.Parse(LEFT(m.Input, RAT(",", m.Input) - 1))
			RETURN This.Heading.Parse(SUBSTR(m.Input, RAT(",", m.Input) + 1))
		ENDIF

		RETURN .F.

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL HeadString AS String

		m.HeadString = This.Heading.ToString()
		RETURN This.Coordinate.ToString() + IIF(!EMPTY(m.HeadString), "," + m.HeadString, "")

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_GeoShapeType AS oh_Datatype

	ADD OBJECT ShapeFormat AS oh_ShapeFormatType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="shapeformat" type="property" display="ShapeFormat" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_WKTShapeType AS oh_GeoShapeType

	FUNCTION PreInit

		This.ShapeFormat.Set("WKT")

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_SideOfStreetType AS oh_EnumerationType

	_Enumeration = "left,right,neither"

ENDDEFINE

DEFINE CLASS oh_ValuesListType AS oh_Datatype

	ValuesClass = "oh_StringType"
	Element = .NULL.

	_SetXML = .T.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="valuesclass" type="property" display="ValuesClass" />' + ;
						'<memberdata name="element" type="property" display="Element" />' + ;
						'</VFPData>'

	FUNCTION PreInit ()

		SAFETHIS

		This.Value = CREATEOBJECT("Collection")
		This.Element = CREATEOBJECT(This.ValuesClass)

		RETURN .T.

	ENDFUNC

	FUNCTION Set (Value) AS Logical

		SAFETHIS

		LOCAL Element

		m.Element = CREATEOBJECT(This.ValuesClass)

		IF m.Element.Set(m.Value)
			This.Value.Add(m.Element)
			This._IsSet = .T.
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION SetXML (Source AS MSXML2.IXMLDOMNode) AS Logical

		SAFETHIS

		IF !ISNULL(m.Source)

			This._IsSet = This.Parse(CHRTRAN(m.Source.text, " ", ","))

		ELSE

			This.Reset()

		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Get (ElementIndex AS Integer)

		SAFETHIS

		IF !This._IsSet OR This.Value.Count = 0
			RETURN .NULL.
		ENDIF

		IF PCOUNT() = 0
			m.ElementIndex = 1
		ENDIF

		IF m.ElementIndex = -1
			RETURN This.Value.Item(This.Value.Count)
		ELSE
			IF BETWEEN(m.ElementIndex, 1, This.Value.Count)
				RETURN This.Value.Item(m.ElementIndex)
			ENDIF
		ENDIF

		RETURN .NULL.

	ENDFUNC

	FUNCTION IsValid (Input) AS Logical

		RETURN This.Element.IsValid(m.Input)

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		SAFETHIS

		LOCAL ARRAY Parts(1)
		LOCAL Value AS Integer
		LOCAL Element

		This.Reset()

		FOR m.Value = 1 TO ALINES(m.Parts, m.Input, 0, ",")
			m.Element = CREATEOBJECT(This.ValuesClass)
			This._IsSet = m.Element.Parse(m.Parts(m.Value))
			IF !This._IsSet
				This.Reset()
				EXIT
			ELSE
				This.Value.Add(m.Element)
			ENDIF

		ENDFOR

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		This.Value.Remove(-1)
		This._IsSet = .F.

	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		LOCAL Result AS String
		LOCAL Value AS String
		LOCAL Sep AS Character

		IF !This._IsSet
			RETURN ""
		ENDIF

		m.Result = ""
		m.Sep = ""
		FOR EACH m.Value IN This.Value
			m.Result = m.Result + m.Sep + m.Value.ToString()
			m.Sep = ","
		ENDFOR

		RETURN m.Result

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_KeyValuePairsListType AS oh_Datatype

	FUNCTION PreInit ()
		This.Value = CREATEOBJECT("Collection")
	ENDFUNC

	FUNCTION Set (KeyPart AS String, ValuePart AS String)

		SAFETHIS

		LOCAL KP AS oh_KeyValuePairType

		m.KP = CREATEOBJECT("oh_KeyValuePairType")
		IF m.KP.Set(m.KeyPart, m.ValuePart)
			This.Value.Add(m.KP)
		ELSE
			m.KP = .NULL.
		ENDIF

		This._IsSet = !ISNULL(m.KP)

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		SAFETHIS

		LOCAL ARRAY Parts(1)
		LOCAL Pair AS Integer

		This.Reset()

		FOR m.Pair = 1 TO ALINES(m.Parts, m.Input, 0, ";")
			IF !This.Set(GETWORDNUM(m.Parts(m.Pair), 1, ","), GETWORDNUM(m.Parts(m.Pair), 2, ","))
				EXIT
			ENDIF
		ENDFOR

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		This.Value.Remove(-1)
		This._IsSet = .F.

	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		LOCAL Result AS String
		LOCAL Sep AS Character
		LOCAL KP AS oh_KeyValuePairType

		IF !This._IsSet
			RETURN ""
		ENDIF

		m.Result = ""
		m.Sep = ""
		FOR EACH m.KP IN This.Value
			m.Result = m.Result + m.Sep + m.KP.ToString()
			m.Sep = ";"
		ENDFOR

		RETURN m.Result

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_KeyValuePairType AS oh_Datatype

	KeyId = .NULL.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="keyid" type="property" display="KeyId" />' + ;
						'</VFPData>'

	FUNCTION Set (KeyPart AS String, ValuePart AS String) AS Logical

		SAFETHIS

		IF This.IsValid(m.KeyPart, m.ValuePart)
			This.KeyId = m.KeyPart
			This.Value = m.ValuePart
			This._IsSet = .T.
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Get () AS String

		RETURN This.ToString()

	ENDFUNC

	FUNCTION IsValid (KeyPart AS String, ValuePart AS String) AS Logical

		RETURN VARTYPE(m.KeyPart) + VARTYPE(m.ValuePart) == "CC" AND !EMPTY(m.KeyPart) AND !EMPTY(m.ValuePart)

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		RETURN VARTYPE(m.Input) == "C" AND This.Set(LEFT(m.Input, AT(",", m.Input) - 1), SUBSTR(m.Input, AT(",", m.Input) + 1))

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		RETURN IIF(This._IsSet, This.KeyId + "," + This.Value, "")

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_ColorType AS oh_StringType

	FUNCTION IsValid (Input AS StringOrNumber) AS Logical

		RETURN oh_StringType::IsValid(m.Input) OR (VARTYPE(m.Input) == "N" AND BETWEEN(m.Input, 0, RGB(255, 255, 255)))

	ENDFUNC

	FUNCTION Set (Input AS StringOrNumber) AS Logical

		SAFETHIS

		LOCAL HexRGB AS String

		IF VARTYPE(m.Input) == "C"
			RETURN oh_StringType::Set(m.Input)
		ELSE
			This._IsSet = .F.
			IF This.IsValid(m.Input)
				m.HexRGB = RIGHT(TRANSFORM(m.Input, "@0"), 6)
				This.Value = RIGHT(m.HexRGB, 2) + SUBSTR(m.HexRGB, 3, 2) + LEFT(m.HexRGB, 2)
				This._IsSet = .T.
			ENDIF
		ENDIF

		RETURN This._IsSet

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_LinkIdType AS oh_StringType

	FUNCTION IsValid (Input AS String) AS Logical

		RETURN oh_StringType::IsValid(m.Input) AND LEN(m.Input) > 1 AND LEFT(m.Input, 1) $ "+-*" AND LEN(CHRTRAN(SUBSTR(m.Input, 2), "0123456789", "")) = 0

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_LinkIdsListType AS oh_ValuesListType

	ValuesClass = "oh_LinkIdType"

ENDDEFINE

DEFINE CLASS oh_LanguageCodeType AS oh_StringType
ENDDEFINE

******************************************************************************************************
* base types
******************************************************************************************************

DEFINE CLASS oh_EnumerationType AS oh_Datatype

	DIMENSION Enumeration (1)
	_Enumeration = ""

	_MemberData = '<VFPData>' + ;
						'<memberdata name="enumeration" type="property" display="Enumeration" />' + ;
						'<memberdata name="_enumeration" type="property" display="_Enumeration" />' + ;
						'<memberdata name="entries" type="property" display="Entries" />' + ;
						'</VFPData>'

	FUNCTION PreInit () AS Logical

		SAFETHIS

		LOCAL Entry AS String

		ALINES(This.Enumeration, This._Enumeration, 0, ",")

		This.AddProperty("Entries", CREATEOBJECT("Empty"))
		FOR EACH m.Entry IN This.Enumeration
			ADDPROPERTY(This.Entries, m.Entry, m.Entry)
		ENDFOR

	ENDFUNC

	FUNCTION IsValid (Input AS String) AS Logical

		SAFETHIS

		RETURN VARTYPE(m.Input) == "C" AND ASCAN(This.Enumeration, m.Input, -1, -1, -1, 6) != 0

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		RETURN This.Set(m.Input)

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_DatetimeType AS oh_Datatype

	FUNCTION IsValid (Input AS Datetime) AS Logical

		RETURN VARTYPE(m.Input) == "T" AND !EMPTY(m.Input)

	ENDFUNC

	FUNCTION Set (Input AS Datetime) AS Logical

		SAFETHIS

		IF This.IsValid(m.Input)
			This.Value = m.Input
			This._IsSet = .T.
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		LOCAL Dt AS Datetime

		TRY
			m.Dt = EVALUATE("{^" + SUBSTR(LEFT(m.Input, 19), "T", " ") + "}")
		CATCH
			m.Dt = {:}
		ENDTRY

		RETURN This.Set(m.Dt)

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		RETURN TTOC(This.Value, 3)

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_DateType AS oh_Datatype

	FUNCTION IsValid (Input AS Datetime) AS Logical

		RETURN VARTYPE(m.Input) $ "DT" AND !EMPTY(m.Input)

	ENDFUNC

	FUNCTION Set (Input AS Date) AS Logical

		SAFETHIS

		IF This.IsValid(m.Input)
			This.Value = IIF(VARTYPE(m.Input) == "D", m.Input, TTOD(m.Input))
			This._IsSet = .T.
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		LOCAL Dt AS Date

		TRY
			m.Dt = EVALUATE("{^" + LEFT(m.Input, 10) + "}")
		CATCH
			m.Dt = {}
		ENDTRY

		RETURN This.Set(m.Dt)

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		RETURN LEFT(TTOC(This.Value, 3), 10)

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_IntegerType AS oh_Datatype

	Minimum = -2147483647
	Maximum = 2147483647

	_MemberData = '<VFPData>' + ;
						'<memberdata name="minimum" type="property" display="Minimum" />' + ;
						'<memberdata name="maximum" type="property" display="Maximum" />' + ;
						'</VFPData>'

	FUNCTION IsValid (Input AS Integer) AS Logical

		RETURN VARTYPE(m.Input) == "N" AND BETWEEN(INT(m.Input), This.Minimum, This.Maximum)

	ENDFUNC

	FUNCTION Set (Input AS Integer) AS Logical

		SAFETHIS

		IF This.IsValid(m.Input)
			This.Value = INT(m.Input)
			This._IsSet = .T.
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		LOCAL Result AS Logical
		LOCAL Process AS String

		m.Process = ALLTRIM(m.Input)

		IF LEFT(m.Process, 1) == "-"
			m.Process = SUBSTR(m.Process, 2)
		ENDIF

		m.Result = LEN(m.Process) > 0 AND LEN(CHRTRAN(m.Process, "0123456789", "")) = 0

		IF m.Result
			m.Result = This.Set(VAL(m.Input))
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN m.Result

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		RETURN IIF(This._IsSet AND !ISNULL(This.Value), LTRIM(TRANSFORM(This.Value, "99999999999")), "")

	ENDFUNC

ENDDEFINE
	
DEFINE CLASS oh_DoubleType AS oh_Datatype

	RequireRegEx = .T.
	Precision = 4
	Minimum = .NULL.
	Maximum = .NULL.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="precision" type="property" display="Precision" />' + ;
						'<memberdata name="minimum" type="property" display="Minimum" />' + ;
						'<memberdata name="maximum" type="property" display="Maximum" />' + ;
						'</VFPData>'

	FUNCTION IsValid (Input AS Double) AS Logical

		SAFETHIS

		RETURN VARTYPE(m.Input) == "N" AND m.Input >= NVL(This.Minimum, m.Input) AND m.Input <= NVL(This.Maximum, m.Input)

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		LOCAL Result AS Logical

		This.RegEx.Pattern = "^\s*-?\d+(\.\d+)?\s*$"
		m.Result = This.RegEx.Test(m.Input)

		IF m.Result
			m.Result = This.Set(VAL(CHRTRAN(m.Input, ".", SET("Point"))))
		ENDIF

		This._IsSet = m.Result
		RETURN m.Result

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		LOCAL SetPoint AS String
		LOCAL SetFixed AS String
		LOCAL SetDecimals AS Integer
		LOCAL Result AS String

		IF !This._IsSet
			RETURN ""
		ENDIF

		m.SetPoint = SET("Point")
		m.SetFixed = SET("Fixed")
		m.SetDecimals = SET("Decimals")
		SET POINT TO "."
		IF !ISNULL(This.Precision)
			SET FIXED ON
			SET DECIMALS TO This.Precision
		ELSE
			SET FIXED OFF
		ENDIF

		m.Result = TRANSFORM(This.Value)
		IF !ISNULL(This.Precision) AND "." $ m.Result
			m.Result = TRIM(TRIM(m.Result, 0, "0"), 0, ".")
		ENDIF

		SET POINT TO (m.SetPoint)
		IF m.SetFixed == "ON"
			SET FIXED ON
		ELSE
			SET FIXED OFF
		ENDIF
		SET DECIMALS TO m.SetDecimals

		RETURN m.Result

	ENDFUNC

	FUNCTION Precision_assign (NewValue)
	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_BooleanType AS oh_Datatype

	FUNCTION IsValid (Input AS Logical) AS Logical

		RETURN VARTYPE(m.Input) == "L"

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		IF VARTYPE(m.Input) == "C"
			RETURN This.Set(IIF(m.Input == "true", .T., IIF(m.Input == "false", .F., m.Input)))
		ENDIF

		This._IsSet = .F.
		RETURN .F.

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		RETURN IIF(!This._IsSet OR ISNULL(This.Value), "", IIF(This.Value, "true", "false"))

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_StringType AS oh_Datatype

	AllowEmpty = .F.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="allowempty" type="property" display="AllowEmpty" />' + ;
						'</VFPData>'

	FUNCTION IsValid (Input AS String) AS Logical

		SAFETHIS

		RETURN VARTYPE(m.Input) == "C" AND (!EMPTY(ALLTRIM(m.Input)) OR This.AllowEmpty)

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		RETURN This.Set(m.Input)

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_Structure AS oh_Base

	Members = ""
	AdditionalMembers = ""
	OverHereClass = "structure"

	_MemberData = '<VFPData>' + ;
						'<memberdata name="members" type="property" display="Members" />' + ;
						'<memberdata name="additionalmembers" type="property" display="AdditionalMembers" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_Datatype AS oh_Base

	PROTECTED _IsSet
	Value = .NULL.
	RegEx = .NULL.
	RequireRegEx = .F.
	_IsSet = .F.
	OverHereClass = "regular"
	_SetXML = .F.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="value" type="property" display="Value" />' + ;
						'<memberdata name="regex" type="property" display="RegEx" />' + ;
						'<memberdata name="requireregex" type="property" display="RequireRegEx" />' + ;
						'<memberdata name="_setxml" type="property" display="_SetXML" />' + ;
						'<memberdata name="preinit" type="method" display="PreInit" />' + ;
						'<memberdata name="reset" type="method" display="Reset" />' + ;
						'<memberdata name="set" type="method" display="Set" />' + ;
						'<memberdata name="get" type="method" display="Get" />' + ;
						'<memberdata name="setxml" type="method" display="SetXML" />' + ;
						'<memberdata name="isset" type="method" display="IsSet" />' + ;
						'<memberdata name="isvalid" type="method" display="IsValid" />' + ;
						'<memberdata name="parse" type="method" display="Parse" />' + ;
						'<memberdata name="tostring" type="method" display="ToString" />' + ;
					'</VFPData>'

	FUNCTION PreInit () AS Logical

		RETURN .T.

	ENDFUNC

	FUNCTION Init (Value AS Anytype) AS Logical

		SAFETHIS

		IF This.PreInit()
			IF This.RequireRegEx
				This.RegEx = CREATEOBJECT("VBScript.RegExp")
			ENDIF
			IF (!This.RequireRegEx OR !ISNULL(This.RegEx)) AND (PCOUNT() = 0 OR This.Set(m.Value))
				RETURN .T.
			ENDIF
		ENDIF

		RETURN .F.

	ENDFUNC
				
	FUNCTION Reset ()

		This.Value = .NULL.
		This._IsSet = .F.

	ENDFUNC

	FUNCTION Set (Value) AS Logical

		SAFETHIS

		IF This.IsValid(m.Value)
			This.Value = m.Value
			This._IsSet = .T.
		ELSE
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Get ()

		SAFETHIS

		RETURN This.Value

	ENDFUNC

	FUNCTION IsValid (Input) AS Logical

		RETURN .F.

	ENDFUNC

	FUNCTION IsSet () AS Logical

		SAFETHIS

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		RETURN .F.

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		RETURN IIF(This._IsSet, TRANSFORM(NVL(This.Value, "")), "")

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_Base AS Custom

	OverHereClass = "base"

	_MemberData = '<VFPData>' + ;
						'<memberdata name="overhereclass" type="property" display="OverHereClass" />' + ;
						'</VFPData>'

	PROCEDURE OverHereClass_Assign (NewValue)
	ENDPROC

ENDDEFINE

