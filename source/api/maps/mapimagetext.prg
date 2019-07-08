**************************************************************
*
* overHere / maps / mapimagetext
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "mapimage")

DEFINE CLASS oh_MapImageText AS oh_MapImage

	* markers and highlights
	ADD OBJECT CustomText AS Collection && OF oh_CustomTextCoordType
	ADD OBJECT CustomTextXY AS Collection && OF oh_CustomTextXYType
	ADD OBJECT CustomTextConfig AS oh_CustomTextConfigType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="customtext" type="property" display="CustomText" />' + ;
						'<memberdata name="customtextxy" type="property" display="CustomTextXY" />' + ;
						'<memberdata name="customtextconfig" type="property" display="CustomTextConfig" />' + ;
						'</VFPData>'

	PROCEDURE PrepareRequest ()

		LOCAL CT AS oh_CustomTextType
		LOCAL ItemIndex AS Integer

		DODEFAULT()

		This.AddObjArgument("txc", This.CustomTextConfig.TextColor)
		This.AddObjArgument("txs", This.CustomTextConfig.TextSize)
		This.AddObjArgument("txsc", This.CustomTextConfig.BorderColor)

		m.ItemIndex = 0
		IF This.CustomText.Count = 1
			m.ItemIndex = IIF(This.AddObjArgument("tx", This.CustomText.Item(1), .T.), 1, 0)
		ELSE
			FOR EACH m.CT IN This.CustomText
				IF This.AddObjArgument("tx" + LTRIM(STR(m.ItemIndex)), m.CT, .T.)
					m.ItemIndex = m.ItemIndex + 1
				ENDIF
			ENDFOR
		ENDIF
		IF m.ItemIndex = 0
			IF This.CustomTextXY.Count = 1
				m.ItemIndex = IIF(This.AddObjArgument("tx.xy", This.CustomTextXY.Item(1), .T.), 1, 0)
			ELSE
				FOR EACH m.CT IN This.CustomTextXY
					IF This.AddObjArgument("tx.xy" + LTRIM(STR(m.ItemIndex)), m.CT, .T.)
						m.ItemIndex = m.ItemIndex + 1
					ENDIF
				ENDFOR
			ENDIF
		ENDIF

	ENDPROC

ENDDEFINE