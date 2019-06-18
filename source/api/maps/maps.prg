**************************************************************
*
* overHere / maps
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\base")
DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\maps")

DEFINE CLASS oh_MapsResource AS oh_Resource

	ResourceURL = "https://image.maps{cit}.api.here.com"
	ResourcePath = "/mia/1.6/"

ENDDEFINE
