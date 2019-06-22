*************************************************************
*
* overHere maps datatypes classes
*
*************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_MapRouteMarkerGroupType AS oh_Datatype

	ADD OBJECT RouteCoords AS oh_GeoCoordinatesListType
	ADD OBJECT MarkerCoords AS oh_GeoCoordinatesListType
	ADD OBJECT Config AS oh_MapRouteMarkerGroupConfigType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="routecoords" type="property" display="RouteCoords" />' + ;
						'<memberdata name="markercoords" type="property" display="MarkerCoords" />' + ;
						'<memberdata name="config" type="property" display="Config" />' + ;
						'</VFPData>'

ENDDEFINE
	
DEFINE CLASS oh_MapRouteMarkerGroupConfigType AS oh_PointOfInterestConfigType

	ADD OBJECT LineColor AS oh_ColorType
	ADD OBJECT BorderColor AS oh_ColorType
	ADD OBJECT LineWidth AS oh_IntegerType WITH Minimum = 1, Maximum = 20

	_MemberData = '<VFPData>' + ;
						'<memberdata name="linecolor" type="property" display="LineColor" />' + ;
						'<memberdata name="bordercolor" type="property" display="BorderColor" />' + ;
						'<memberdata name="linewidth" type="property" display="LineWidth" />' + ;
						'</VFPData>'

	FUNCTION Reset ()

		DODEFAULT()
		This.LineColor.Reset()
		This.LineWidth.Reset()

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_GraphObjectType AS oh_Datatype

	ADD OBJECT Latitude AS oh_LatitudeType
	ADD OBJECT Longitude AS oh_LongitudeType
	ADD OBJECT StatValue AS oh_DoubleType
	ADD OBJECT Config AS oh_GraphObjectConfigType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="latitude" type="property" display="Latitude" />' + ;
						'<memberdata name="longitude" type="property" display="Longitude" />' + ;
						'<memberdata name="statvalue" type="property" display="StatValue" />' + ;
						'<memberdata name="config" type="property" display="Config" />' + ;
						'</VFPData>'

	FUNCTION IsValid (Lat AS Double, Long AS Double, Value AS Double, Fill AS String, BorderColor AS String) AS Logical

		RETURN This.Latitude.IsValid(m.Lat) AND This.Longitude.IsValid(m.Long) AND This.StatValue.IsValid(m.Value) AND ;
			(This.Config.FillColor.IsValid(m.Fill) OR (VARTYPE(m.Fill) == "L" AND !m.Fill)) AND ;
			(This.Config.BorderColor.IsValid(m.BorderColor) OR (VARTYPE(m.BorderColor) == "L" AND !m.BorderColor))

	ENDFUNC

	FUNCTION Set (Lat AS Double, Long AS Double, Value AS Double, Fill AS StringOrNumber, BorderColor AS StringOrNumber) AS Logical

		SAFETHIS

		This.Reset()

		IF This.IsValid(m.Lat, m.Long, m.Value, m.Fill, m.BorderColor)
			IF This.Latitude.Set(m.Lat) AND This.Longitude.Set(m.Long) AND This.StatValue.Set(m.Value) AND ;
					(VARTYPE(m.Fill) == "L" OR This.Config.FillColor.Set(m.Fill)) AND ;
					(VARTYPE(m.BorderColor) == "L" OR This.Config.BorderColor.Set(m.BorderColor))
				This._IsSet = .T.
			ENDIF
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		This._IsSet = .F.
		This.Latitude.Reset()
		This.Longitude.Reset()
		This.Config.Reset()

	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		RETURN This.Latitude.ToString() + "," + This.Longitude.ToString() + ";" + This.StatValue.ToString() + ";" + ;
			This.Config.FillColor.ToString() + ";" + This.Config.BorderColor.ToString()

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_GraphObjectConfigType AS oh_Datatype

	ADD OBJECT FillColor AS oh_ColorType
	ADD OBJECT BorderColor AS oh_ColorType
	ADD OBJECT LocationPoint AS oh_IntegerType WITH Minimum = 0, Maximum = 1
	ADD OBJECT GraphType AS oh_IntegerType WITH Minimum = 0, Maximum = 1

	_MemberData = '<VFPData>' + ;
						'<memberdata name="fillcolor" type="property" display="FillColor" />' + ;
						'<memberdata name="bordercolor" type="property" display="BorderColor" />' + ;
						'<memberdata name="locationpoint" type="property" display="LocationPoint" />' + ;
						'<memberdata name="graphtype" type="property" display="GraphType" />' + ;
						'</VFPData>'

	FUNCTION Reset ()

		This._IsSet = .F.
		This.FillColor.Reset()
		This.BorderColor.Reset()
		This.LocationPoint.Reset()
		This.GraphType.Reset()

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_PointOfInterestType AS oh_Datatype

	ADD OBJECT Latitude AS oh_LatitudeType
	ADD OBJECT Longitude AS oh_LongitudeType
	ADD OBJECT Config AS oh_PointOfInterestConfigType
	ADD OBJECT Text AS oh_StringType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="latitude" type="property" display="Latitude" />' + ;
						'<memberdata name="longitude" type="property" display="Longitude" />' + ;
						'<memberdata name="config" type="property" display="Config" />' + ;
						'<memberdata name="text" type="property" display="Text" />' + ;
						'</VFPData>'

	FUNCTION IsValid (Lat AS Double, Long AS Double, Fill AS String, Color AS String, Size AS Integer, Text AS String) AS Logical

		RETURN This.Latitude.IsValid(m.Lat) AND This.Longitude.IsValid(m.Long) AND ;
			(This.Config.FillColor.IsValid(m.Fill) OR (VARTYPE(m.Fill) == "L" AND !m.Fill)) AND ;
			(This.Config.TextColor.IsValid(m.Color) OR (VARTYPE(m.Color) == "L" AND !m.Color)) AND ;
			(This.Config.TextSize.IsValid(m.Size) OR (VARTYPE(m.Size) == "L" AND !m.Size)) AND ;
			(This.Text.IsValid(m.Text) OR (VARTYPE(m.Text) == "L" AND !m.Text))

	ENDFUNC

	FUNCTION Set (Lat AS Double, Long AS Double, Fill AS String, Color AS String, Size AS Integer, Text AS String) AS Logical

		SAFETHIS

		This.Reset()

		IF This.IsValid(m.Lat, m.Long, m.Fill, m.Color, m.Size, m.Text)
			IF This.Latitude.Set(m.Lat) AND This.Longitude.Set(m.Long) AND ;
					(VARTYPE(m.Fill) == "L" OR This.Config.FillColor.Set(m.Fill)) AND ;
					(VARTYPE(m.Color) == "L" OR This.Config.TextColor.Set(m.Color)) AND ;
					(VARTYPE(m.Size) == "L" OR This.Config.TextSize.Set(m.Size)) AND ;
					(VARTYPE(m.Text) == "L" OR This.Text.Set(m.Text))
				This._IsSet = .T.
			ENDIF
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		This._IsSet = .F.
		This.Latitude.Reset()
		This.Longitude.Reset()
		This.Config.Reset()
		This.Text.Reset()

	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		RETURN This.Latitude.ToString() + "," + This.Longitude.ToString() + ";" + ;
			This.Config.FillColor.ToString() + ";" + This.Config.TextColor.ToString() + ";" + ;
			This.Config.TextSize.ToString() + ";" + ;
			STRTRAN(This.Text.ToString(), ";", "\;")

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_PointOfInterestConfigType AS oh_Datatype

	ADD OBJECT FillColor AS oh_ColorType
	ADD OBJECT TextColor AS oh_ColorType
	ADD OBJECT TextSize AS oh_IntegerType WITH Minimum = 8, Maximum = 30
	ADD OBJECT Label AS oh_IntegerType WITH Minimum = 0, Maximum = 1
	ADD OBJECT Theme AS oh_IntegerType WITH Minimum = 0, Maximum = 2

	_MemberData = '<VFPData>' + ;
						'<memberdata name="fillcolor" type="property" display="FillColor" />' + ;
						'<memberdata name="textcolor" type="property" display="TextColor" />' + ;
						'<memberdata name="textsize" type="property" display="TextSize" />' + ;
						'<memberdata name="label" type="property" display="Label" />' + ;
						'<memberdata name="theme" type="property" display="Theme" />' + ;
						'</VFPData>'

	FUNCTION Reset ()

		This._IsSet = .F.
		This.FillColor.Reset()
		This.TextColor.Reset()
		This.TextSize.Reset()
		This.Label.Reset()
		This.Theme.Reset()

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_CustomTextXYType AS oh_CustomTextType

	ADD OBJECT X AS oh_IntegerType
	ADD OBJECT Y AS oh_IntegerType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="x" type="property" display="X" />' + ;
						'<memberdata name="y" type="property" display="Y" />' + ;
						'</VFPData>'

	FUNCTION IsValid (X AS Integer, Y AS Integer, Text AS String, Color AS String, BorderColor AS String, Size AS Integer) AS Logical

		RETURN This.X.IsValid(m.X) AND This.Y.IsValid(m.Y) AND ;
			oh_CustomTextType::IsValid(m.Text, m.Color, m.BorderColor, m.Size)

	ENDFUNC

	FUNCTION Set (X AS Integer, Y AS Integer, Text AS String, Color AS StringOrNumber, BorderColor AS StringOrNumber, Size AS Integer) AS Logical

		SAFETHIS

		IF oh_CustomTextType::Set(m.Text, m.Color, m.BorderColor, m.Size) AND This.X.Set(m.X) AND This.Y.Set(m.Y)
			This._IsSet = .T.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		oh_CustomTextType::Reset()
		This.X.Reset()
		This.Y.Reset()

	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		RETURN This.X.ToString() + "," + This.Y.ToString() + ";" + oh_CustomTextType::ToString()

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_CustomTextCoordType AS oh_CustomTextType

	ADD OBJECT Latitude AS oh_LatitudeType
	ADD OBJECT Longitude AS oh_LongitudeType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="latitude" type="property" display="Latitude" />' + ;
						'<memberdata name="longitude" type="property" display="Longitude" />' + ;
						'</VFPData>'

	FUNCTION IsValid (Lat AS Double, Long AS Double, Text AS String, Color AS String, BorderColor AS String, Size AS Integer) AS Logical

		RETURN This.Latitude.IsValid(m.Lat) AND This.Longitude.IsValid(m.Long) AND ;
			oh_CustomTextType::IsValid(m.Text, m.Color, m.BorderColor, m.Size)

	ENDFUNC

	FUNCTION Set (Lat AS Double, Long AS Double, Text AS String, Color AS StringOrNumber, BorderColor AS StringOrNumber, Size AS Integer) AS Logical

		SAFETHIS

		IF oh_CustomTextType::Set(m.Text, m.Color, m.BorderColor, m.Size) AND This.Latitude.Set(m.Lat) AND This.Longitude.Set(m.Long)
			This._IsSet = .T.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		oh_CustomTextType::Reset()
		This.Latitude.Reset()
		This.Longitude.Reset()

	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		RETURN This.Latitude.ToString() + "," + This.Longitude.ToString() + ";" + oh_CustomTextType::ToString()

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_CustomTextType AS oh_Datatype

	ADD OBJECT Text AS oh_StringType
	ADD OBJECT Config AS oh_CustomTextConfigType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="text" type="property" display="Text" />' + ;
						'<memberdata name="config" type="property" display="Config" />' + ;
						'</VFPData>'

	FUNCTION Text.IsValid (Input AS String) AS Logical

		RETURN oh_StringType::IsValid(m.Input) AND !EMPTY(m.Input)

	ENDFUNC

	FUNCTION IsValid (Text AS String, Color AS String, BorderColor AS String, Size AS Integer) AS Logical

		RETURN This.Text.IsValid(m.Text) AND ;
			(This.Config.TextColor.IsValid(m.Color) OR (VARTYPE(m.Color) == "L" AND !m.Color)) AND ;
			(This.Config.BorderColor.IsValid(m.BorderColor) OR (VARTYPE(m.BorderColor) == "L" AND !m.BorderColor)) AND ;
			(This.Config.TextSize.IsValid(m.Size) OR (VARTYPE(m.Size) == "L" AND !m.Size))

	ENDFUNC

	FUNCTION Set (Text AS String, Color AS StringOrNumber, BorderColor AS StringOrNumber, Size AS Integer) AS Logical

		SAFETHIS

		This.Reset()
		IF This.Text.Set(m.Text) AND ;
				(VARTYPE(m.Color) == "L" OR This.Config.TextColor.Set(m.Color)) AND ;
				(VARTYPE(m.BorderColor) == "L" OR This.Config.BorderColor.Set(m.BorderColor)) AND ;
				(VARTYPE(m.Size) == "L" OR This.Config.TextSize.Set(m.Size))
			This._IsSet = .T.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		This._IsSet = .F.
		This.Text.Reset()
		This.Config.Reset()

	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		RETURN STRTRAN(This.Text.ToString(), ";", "\;") + ";" + ;
			This.Config.TextColor.ToString() + ";" + This.Config.BorderColor.ToString() + ";" + ;
			This.Config.TextSize.ToString()

	ENDFUNC
	
ENDDEFINE

DEFINE CLASS oh_CustomTextConfigType AS oh_Datatype

	ADD OBJECT TextColor AS oh_ColorType
	ADD OBJECT BorderColor AS oh_ColorType
	ADD OBJECT TextSize AS oh_IntegerType WITH Minimum = 8, Maximum = 30

	_MemberData = '<VFPData>' + ;
						'<memberdata name="textcolor" type="property" display="TextColor" />' + ;
						'<memberdata name="bordercolor" type="property" display="BorderColor" />' + ;
						'<memberdata name="textsize" type="property" display="TextSize" />' + ;
						'</VFPData>'

	FUNCTION Reset ()

		This._IsSet = .F.
		This.TextColor.Reset()
		This.BorderColor.Reset()
		This.TextSize.Reset()

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_ImageFormatType AS oh_IntegerType

	Minimum = 0
	Maximum = 5

	_MemberData = '<VFPData>' + ;
						'<memberdata name="getextension" type="method" display="GetExtension" />' + ;
						'<memberdata name="getmimetype" type="method" display="GetMimetype" />' + ;
						'</VFPData>'

	FUNCTION GetExtension () AS String

		LOCAL ImgType AS Integer

		m.ImgType = NVL(This.Get(), 1)

		RETURN STREXTRACT(":png:jpg:gif:bmp:png8:svg:", ":", ":", m.ImgType + 1)

	ENDFUNC

	FUNCTION GetMimetype () AS String

		LOCAL ImgType AS Integer

		m.ImgType = NVL(This.Get(), 1)

		RETURN "image/" + STREXTRACT(":png:jpeg:gif:bmp:png:svg+xml:", ":", ":", m.ImgType + 1)

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_MapSchemeType AS oh_IntegerType

	Minimum = 0
	Maximum = 14

ENDDEFINE

DEFINE CLASS oh_MapViewType AS oh_IntegerType

	Minimum = 0
	Maximum = 2

ENDDEFINE

DEFINE CLASS oh_ScaleBarsType AS oh_EnumerationType

	_Enumeration = "k,m,km,mk"

ENDDEFINE

DEFINE CLASS oh_ZoomLevelType AS oh_IntegerType

	Minimum = 0
	Maximum = 20

ENDDEFINE
