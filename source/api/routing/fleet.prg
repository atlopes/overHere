**************************************************************
*
* overHere / fleet telematics
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\dtbase")
DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\dtroute")
DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\dtfleet")

DO (ADDBS(JUSTPATH(SYS(16))) + "..\response")

DEFINE CLASS oh_FleetTelematicsResource AS oh_Resource

	ResourceURL = "https://wse.ls.hereapi.com"
	ResourcePath = "/2/"

ENDDEFINE
