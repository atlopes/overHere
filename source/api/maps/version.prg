**************************************************************
*
* overHere / maps / version
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "maps")

DEFINE CLASS oh_MapVersion AS oh_MapsResource

	ADD OBJECT Components AS Collection
	ResourceName = "version"

	_MemberData = '<VFPData>' + ;
						'<memberdata name="components" type="property" display="Components" />' + ;
						'<memberdata name="getversion" type="method" display="GetVersion" />' + ;
						'</VFPData>'

	FUNCTION GetVersion (Component AS String) AS String

		LOCAL ARRAY Components(1)
		LOCAL CompIndex AS Integer
		LOCAL CompName AS String

		IF This.Components.Count = 0
			This.PrepareQueryString()
			IF This.Call()
				FOR m.CompIndex = 1 TO ALINES(m.Components, "" + This.APIService.ServerResponse, 1, "<br>")
					This.Components.Add(SUBSTR(m.Components(m.CompIndex), AT(" ", m.Components(m.CompIndex)) + 1), ;
												UPPER(LEFT(m.Components(m.CompIndex), AT(":", m.Components(m.CompIndex)) - 1)))
				ENDFOR
			ELSE
				RETURN .NULL.
			ENDIF
		ENDIF

		m.CompName = UPPER(EVL(m.Component, "MIA"))
		IF This.Components.GetKey(m.CompName) != 0
			RETURN This.Components.Item(m.CompName)
		ELSE
			RETURN ""
		ENDIF

	ENDFUNC

ENDDEFINE