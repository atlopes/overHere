**************************************************************
*
* overHere / maps / mapstatistics
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "mapimagetext")

DEFINE CLASS oh_MapStatistics AS oh_MapImageText

	ResourceName = "stat"

	* statistics graph objects
	ADD OBJECT GraphObjects AS Collection
	ADD OBJECT GraphObjectsConfig AS oh_GraphObjectConfigType

	GraphObjectShadow = .F.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="graphobjects" type="property" display="GraphObjects" />' + ;
						'<memberdata name="graphobjectsconfig" type="property" display="GraphObjectsConfig" />' + ;
						'<memberdata name="graphobjectshadow" type="property" display="GraphObjectShadow" />' + ;
						'</VFPData>'

	PROCEDURE PrepareRequest ()

		LOCAL GO AS oh_GraphObjectType
		LOCAL ItemIndex AS Integer

		DODEFAULT()

		This.AddObjArgument("ofc", This.GraphObjectsConfig.FillColor)
		This.AddObjArgument("osc", This.GraphObjectsConfig.BorderColor)
		This.AddObjArgument("olp", This.GraphObjectsConfig.LocationPoint)
		This.AddObjArgument("ot", This.GraphObjectsConfig.GraphType)

		IF This.GraphObjects.Count = 1
			This.AddObjArgument("o", This.GraphObjects.Item(1))
		ELSE
			m.ItemIndex = 0
			FOR EACH m.GO IN This.GraphObjects
				IF This.AddObjArgument("o" + LTRIM(STR(m.ItemIndex, 10, 0)), m.GO)
					m.ItemIndex = m.ItemIndex + 1
				ENDIF
			ENDFOR
		ENDIF

		This.AddFlag("shd", This.GraphObjectShadow)

	ENDPROC

ENDDEFINE