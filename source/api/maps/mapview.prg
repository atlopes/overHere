**************************************************************
*
* overHere / maps / mapview
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "mapimagetextpoi")

DEFINE CLASS oh_MapView AS oh_MapImageTextPOI

	* map characteristics
	ADD OBJECT ViewType AS oh_MapViewType

	ADD OBJECT RotationAngle AS oh_DoubleType
	ADD OBJECT ScaleBars AS oh_ScaleBarsType
	ADD OBJECT PictureInPicture AS oh_IntegerType

	* geo coordinates
	ADD OBJECT MapCenter AS oh_GeoCoordinateType
	ADD OBJECT PositionCoord AS oh_GeoCoordinateType
	ADD OBJECT Latitude AS oh_LatitudeType
	ADD OBJECT Longitude AS oh_LongitudeType
	ADD OBJECT BoundingBox AS oh_GeoCoordinatesListType

	* name search
	ADD OBJECT CityName AS oh_StringType
	ADD OBJECT CountryName AS oh_StringType
	ADD OBJECT StreetName AS oh_StringType
	ADD OBJECT HouseNumber AS oh_StringType
	ADD OBJECT PostalCode AS oh_StringType
	ADD OBJECT MaxHits AS oh_IntegerType

	* markers and highlights
	ADD OBJECT Radius AS oh_DistanceType
	ADD OBJECT UncertainRadius AS oh_DistanceType

	* map elements
	ADD OBJECT Information AS oh_BooleanType
	ADD OBJECT OtherLanguage AS oh_StringType

	* flags
	NoCompass = .F.
	NoDot = .F.
	NoMarkers = .F.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="viewtype" type="property" display="ViewType" />' + ;
						'<memberdata name="rotationangle" type="property" display="RotationAngle" />' + ;
						'<memberdata name="scalebars" type="property" display="ScaleBars" />' + ;
						'<memberdata name="pictureinpicture" type="property" display="PictureInPicture" />' + ;
						'<memberdata name="mapcenter" type="property" display="MapCenter" />' + ;
						'<memberdata name="positioncoord" type="property" display="PositionCoord" />' + ;
						'<memberdata name="latitude" type="property" display="Latitude" />' + ;
						'<memberdata name="longitude" type="property" display="Longitude" />' + ;
						'<memberdata name="boundingbox" type="property" display="BoundingBox" />' + ;
						'<memberdata name="cityname" type="property" display="CityName" />' + ;
						'<memberdata name="countryname" type="property" display="CountryName" />' + ;
						'<memberdata name="streetname" type="property" display="StreetName" />' + ;
						'<memberdata name="housenumber" type="property" display="HouseNumber" />' + ;
						'<memberdata name="postalcode" type="property" display="PostalCode" />' + ;
						'<memberdata name="maxhits" type="property" display="MaxHits" />' + ;
						'<memberdata name="radius" type="property" display="Radius" />' + ;
						'<memberdata name="uncertainradius" type="property" display="UncertainRadius" />' + ;
						'<memberdata name="information" type="property" display="Information" />' + ;
						'<memberdata name="otherlanguage" type="property" display="OtherLanguage" />' + ;
						'<memberdata name="nocompass" type="property" display="NoCompass" />' + ;
						'<memberdata name="nodot" type="property" display="NoDot" />' + ;
						'<memberdata name="nomarkers" type="property" display="NoMarkers" />' + ;
						'</VFPData>'

	PROCEDURE PrepareRequest ()

		DODEFAULT()

		This.AddObjArgument("vt", This.ViewType)
		This.AddObjArgument("ra", This.RotationAngle)
		This.AddObjArgument("sb", This.ScaleBars)
		This.AddObjArgument("pip", This.PictureInPicture)

		This.AddObjArgument("bbox", This.BoundingBox)
		This._Pos(This.MapCenter, "ctr", "ectr")
		IF !This._Pos(This.PositionCoord, "c", "e")
			This.AddObjArgument("lat", This.Latitude)
			This.AddObjArgument("lon", This.Longitude)
		ENDIF

		This.AddObjArgument("co", This.CountryName, .T.)
		This.AddObjArgument("ci", This.CityName, .T.)
		This.AddObjArgument("zi", This.PostalCode, .T.)
		This.AddObjArgument("s", This.StreetName, .T.)
		This.AddObjArgument("n", This.HouseNumber, .T.)
		This.AddObjArgument("maxhits", This.MaxHits)

		This.AddObjArgument("rad", This.Radius)
		This.AddObjArgument("u", This.UncertainRadius)

		This.AddObjArgument("i", This.Information)
		IF This.Language.IsSet()
			This.AddObjArgument("ml2", This.OtherLanguage)
		ENDIF

		This.AddFlag("nocmp", This.NoCompass)
		This.AddFlag("nodot", This.NoDot)
		This.AddFlag("nomrk", This.NoMarkers)

	ENDFUNC

ENDDEFINE