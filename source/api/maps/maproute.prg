**************************************************************
*
* overHere / maps / route
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "mapimagepoi")

DEFINE CLASS oh_RouteMap AS oh_MapImagePOI

	ResourceName = "route"
	PostQueryString = .T.

	* geo coordinates
	ADD OBJECT MapCenter AS oh_GeoCoordinateType

	* route
	ADD OBJECT Routes AS Collection
	ADD OBJECT RouteMarkerConfig AS oh_MapRouteMarkerGroupConfigType

	* flags
	NoIcon = .F.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="mapcenter" type="property" display="MapCenter" />' + ;
						'<memberdata name="routes" type="property" display="Routes" />' + ;
						'<memberdata name="routemarkerconfig" type="property" display="RouteMarkerConfig" />' + ;
						'<memberdata name="noicon" type="property" display="NoIcon" />' + ;
						'</VFPData>'

	PROCEDURE PrepareRequest ()

		DODEFAULT()

		This._Pos(This.MapCenter, "ctr", "ectr")

		LOCAL Marker AS oh_MapRouteMarkerGroupType
		LOCAL ItemIndex AS Integer
		LOCAL SuffixIndex AS String

		IF This.Routes.Count > 1
			m.ItemIndex = 0
			m.SuffixIndex = "0"
		ELSE
			m.ItemIndex = .NULL.
			m.SuffixIndex = ""
		ENDIF

		This.AddObjArgument("mlbl", This.RouteMarkerConfig.Label)
		This.AddObjArgument("mthm", This.RouteMarkerConfig.Theme)

		FOR EACH m.Marker IN This.Routes

			This.AddObjArgument("r" + m.SuffixIndex, m.Marker.RouteCoords)
			This.AddObjArgument("m" + m.SuffixIndex, m.Marker.MarkerCoords)
			This.AddObjArgument("lc" + m.SuffixIndex, m.Marker.Config.LineColor)
			This.AddObjArgument("lw" + m.SuffixIndex, m.Marker.Config.LineWidth)
			This.AddObjArgument("sc" + m.SuffixIndex, m.Marker.Config.BorderColor)
			This.AddObjArgument("mfc" + m.SuffixIndex, m.Marker.Config.FillColor)
			This.AddObjArgument("mtxc" + m.SuffixIndex, m.Marker.Config.TextColor)
			This.AddObjArgument("mtxs" + m.SuffixIndex, m.Marker.Config.TextSize)

			IF !ISNULL(m.ItemIndex)
				m.ItemIndex = m.ItemIndex + 1
				m.SuffixIndex = LTRIM(STR(m.ItemIndex, 10, 0))
			ENDIF

		ENDFOR

		This.AddFlag("noicon", This.NoIcon)

	ENDFUNC

ENDDEFINE
