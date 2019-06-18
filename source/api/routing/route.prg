**************************************************************
*
* overHere / routing
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\base")
DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\route")

DO (ADDBS(JUSTPATH(SYS(16))) + "..\response")

DEFINE CLASS oh_RouteResource AS oh_Resource

	ResourceURL = "https://route{cit}.api.here.com"
	ResourcePath = "/routing/7.2/"

ENDDEFINE

