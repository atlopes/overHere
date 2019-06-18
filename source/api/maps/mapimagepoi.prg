**************************************************************
*
* overHere / maps / mapimagetext
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "mapimage")

DEFINE CLASS oh_MapImagePOI AS oh_MapImage

	* markers and highlights
	ADD OBJECT PointsOfInterest AS Collection
	ADD OBJECT PointsOfInterestMarks AS Collection
	ADD OBJECT PointsOfInterestConfig AS oh_PointOfInterestConfigType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="pointsofinterest" type="property" display="PointsOfInterest" />' + ;
						'<memberdata name="pointsofinterestmarks" type="property" display="PointsOfInterestMarks" />' + ;
						'<memberdata name="pointsofinterestconfig" type="property" display="PointsOfInterestConfig" />' + ;
						'</VFPData>'

	PROCEDURE PrepareRequest ()

		LOCAL Coord AS oh_GeoCoordinateType
		LOCAL CoordList AS String
		LOCAL POI AS oh_PointOfInterestType
		LOCAL ItemIndex AS Integer

		DODEFAULT()

		This.AddObjArgument("poitxs", This.PointsOfInterestConfig.TextSize)
		This.AddObjArgument("poitxc", This.PointsOfInterestConfig.TextColor)
		This.AddObjArgument("poifc", This.PointsOfInterestConfig.FillColor)
		This.AddObjArgument("poilbl", This.PointsOfInterestConfig.Label)
		This.AddObjArgument("poithm", This.PointsOfInterestConfig.Theme)

		m.CoordList = ""
		FOR EACH m.Coord IN This.PointsOfInterestMarks
			IF m.Coord.IsSet()
				m.CoordList = m.CoordList + IIF(EMPTY(m.CoordList), "", ",") + m.Coord.ToString()
			ENDIF
		ENDFOR
		IF !EMPTY(m.CoordList)
			This.AddArgument("poi", m.CoordList)
		ELSE
			m.ItemIndex = 0
			FOR EACH m.POI IN This.PointsOfInterest
				IF This.AddObjArgument("poix" + LTRIM(STR(m.ItemIndex, 10, 0)), m.POI, .T.)
					m.ItemIndex = m.ItemIndex + 1
				ENDIF
			ENDFOR
		ENDIF

	ENDPROC

ENDDEFINE