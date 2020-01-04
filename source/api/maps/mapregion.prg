**************************************************************
*
* overHere / maps / region
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "mapimagetext")

DEFINE CLASS oh_RegionMap AS oh_MapImageText

	ResourceName = "region"

	* regions definition (circle center | segment | polygon
	ADD OBJECT Regions AS Collection && OF oh_MapRegionType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="regions" type="property" display="Regions" />' + ;
						'</VFPData>'

	PROCEDURE PrepareRequest ()

		DODEFAULT()

		LOCAL Region AS oh_MapRegionType
		LOCAL ItemIndex AS Integer
		LOCAL SuffixIndex AS String

		IF This.Regions.Count > 1
			m.ItemIndex = 0
			m.SuffixIndex = "0"
		ELSE
			m.ItemIndex = .NULL.
			m.SuffixIndex = ""
		ENDIF

		FOR EACH m.Region IN This.Regions

			This.AddObjArgument("a" + m.SuffixIndex, m.Region.RegionCoords)
			This.AddObjArgument("rad" + m.SuffixIndex, m.Region.Radius)
			This.AddObjArgument("fc" + m.SuffixIndex, m.Region.Config.FillColor)
			This.AddObjArgument("lc" + m.SuffixIndex, m.Region.Config.LineColor)
			This.AddObjArgument("lw" + m.SuffixIndex, m.Region.Config.LineWidth)

			IF !ISNULL(m.ItemIndex)
				m.ItemIndex = m.ItemIndex + 1
				m.SuffixIndex = LTRIM(STR(m.ItemIndex))
			ENDIF

		ENDFOR

	ENDFUNC

ENDDEFINE
