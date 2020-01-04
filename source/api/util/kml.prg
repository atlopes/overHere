* KML
*
* A class to process KML based information to facilitate its use by the overHere classes
*

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS KML AS Custom

	XMLDoc = .NULL.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="xmldoc" type="property" display="XMLDoc" />' + ;
						'<memberdata name="load" type="method" display="Load" />' + ;
						'<memberdata name="toheregeocoordinates" type="method" display="ToHereGeoCoordinates" />' + ;
						'<memberdata name="toheregeocoordinateslist" type="method" display="ToHereGeoCoordinatesList" />' + ;
						'</VFPData>'

	PROCEDURE Init
		This.XMLDoc = CREATEOBJECT("MSXML2.DOMDocument.6.0")
		This.XMLDoc.SetProperty("SelectionNamespaces", 'xmlns:k="http://www.opengis.net/kml/2.2" xmlns:g="http://www.google.com/kml/ext/2.2"')
		This.XMLDoc.Async = .F.
	ENDPROC

	PROCEDURE Load (Source AS StringOrURL)
		RETURN This.XMLDoc.LoadXML(m.Source) OR This.XMLDoc.Load(m.Source)
	ENDPROC

	* change from KML LongLat to Here LatLong coordinates notation
	PROCEDURE ToHereGeoCoordinates (Tree AS String)

		LOCAL GeoCoord AS String
		LOCAL Contents AS String
		LOCAL Result AS String

		m.Result = ""
		m.Sep = ""
		m.Contents = This.XMLDoc.selectNodes(m.Tree).item(0)
		IF !ISNULL(m.Contents)
			m.GeoCoord = m.Contents.text
			m.Result = SUBSTR(m.GeoCoord, AT(",", m.GeoCoord) + 1) + "," + ;
					LEFT(m.GeoCoord, AT(",", m.GeoCoord) - 1)
		ENDIF

		RETURN m.Result

	ENDPROC

	* change list from KML LongLat to Here LatLong coordinates notation
	PROCEDURE ToHereGeoCoordinatesList (Tree AS String)

		LOCAL ARRAY GeoCoords(1)
		LOCAL GeoCoord AS String
		LOCAL Contents AS String
		LOCAL CoordsIndex AS Integer
		LOCAL Sep AS Character
		LOCAL Result AS String

		m.Result = ""
		m.Sep = ""
		m.Contents = This.XMLDoc.selectNodes(m.Tree).item(0)
		IF !ISNULL(m.Contents)
			FOR m.CoordsIndex = 1 TO ALINES(m.GeoCoords, m.Contents.text, 0, " ")
				m.GeoCoord = m.GeoCoords(m.CoordsIndex)
				m.Result = m.Result + m.Sep + ;
					SUBSTR(m.GeoCoord, AT(",", m.GeoCoord) + 1) + "," + ;
					LEFT(m.GeoCoord, AT(",", m.GeoCoord) - 1)
				m.Sep = ","
			ENDFOR
		ENDIF

		RETURN m.Result

	ENDPROC

ENDDEFINE
