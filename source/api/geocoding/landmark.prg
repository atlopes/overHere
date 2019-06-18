**************************************************************
*
* overHere / geocode / search
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "search.prg")

DEFINE CLASS oh_LandmarkSearch AS oh_GeocodeSearch

	ResourceName = "search.xml"

	* filters
	ADD OBJECT CategoryIds AS oh_ValuesListType
	ADD OBJECT LandmarkName AS oh_StringType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="categoryids" type="property" display="CategoryIds" />' + ;
						'<memberdata name="landmarkname" type="property" display="LandmarkName" />' + ;
						'</VFPData>'

	PROCEDURE PrepareRequest ()

		DODEFAULT()

		This.AddObjArgument("categoryids", This.CategoryIds)
		This.AddObjArgument("name", This.LandmarkName, .T.)

	ENDPROC

ENDDEFINE