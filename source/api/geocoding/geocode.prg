**************************************************************
*
* overHere / geocoding
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\dtbase")
DO (ADDBS(JUSTPATH(SYS(16))) + "..\..\datatypes\dtgeocode")

DO (ADDBS(JUSTPATH(SYS(16))) + "..\response")

DEFINE CLASS oh_GeocodeResource AS oh_Resource

	ResourceURL = "https://geocoder{cit}.api.here.com"
	ResourcePath = "/6.2/"

ENDDEFINE

DEFINE CLASS oh_ReverseGeocodeResource AS oh_Resource

	ResourceURL = "https://reverse.geocoder{cit}.api.here.com"
	ResourcePath = "/6.2/"

ENDDEFINE
