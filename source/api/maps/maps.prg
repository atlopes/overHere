**************************************************************
*
* overHere / maps
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\dtbase")
DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\dtmaps")

DEFINE CLASS oh_MapsResource AS oh_Resource

	ResourceURL = "https://image.maps.ls.hereapi.com"
	ResourcePath = "/mia/1.6/"

ENDDEFINE
