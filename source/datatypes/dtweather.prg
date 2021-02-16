*************************************************************
*
* overHere weather report datatypes classes
*
*************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"


*************************************************************
* structures
*************************************************************

DEFINE CLASS oh_WeatherLocationMetadataType AS oh_Structure

	ADD OBJECT Id AS oh_StringType
	ADD OBJECT Country AS oh_StringType
	ADD OBJECT State AS oh_StringType
	ADD OBJECT City AS oh_StringType
	ADD OBJECT Latitude AS oh_LatitudeType
	ADD OBJECT Longitude AS oh_LongitudeType
	ADD OBJECT Elevation AS oh_DoubleType
	ADD OBJECT Distance AS oh_DoubleType
	ADD OBJECT DayOfWeek AS oh_IntegerType
	ADD OBJECT WeekDay AS oh_StringType
	ADD OBJECT UtcTime AS oh_DatetimeType
	ADD OBJECT LocalTime AS oh_StringType
	ADD OBJECT LocalTimeFormat AS oh_StringType
	ADD OBJECT Timezone AS oh_IntegerType

ENDDEFINE


