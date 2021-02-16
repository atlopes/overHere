*************************************************************
*
* overHere fleeting datatypes classes
*
*************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_WaypointWithIdType AS oh_Datatype

	ADD OBJECT Id AS oh_ControlledStringType WITH RegExPattern = "^[A-Za-z][A-Za-z0-9]*$"
	ADD OBJECT Position AS oh_GeoCoordinateType
	ADD OBJECT ServiceTime AS oh_DurationType
	ADD OBJECT Appointment AS oh_DatetimeType
	ADD OBJECT AccessDayFrom AS oh_WeekdayType
	ADD OBJECT AccessHourFrom AS oh_TimeType
	ADD OBJECT AccessDayTo AS oh_WeekdayType
	ADD OBJECT AccessHourTo AS oh_TimeType
	ADD OBJECT BeforeWaypoints AS Collection && of oh_IntegerType
	ADD OBJECT Pickups AS Collection && of oh_PickupItemType
	ADD OBJECT Drops AS Collection && of oh_DropItemType

	_MemberData = '<VFPData>' + ;
						'<memberdata name="id" type="property" display="Id" />' + ;
						'<memberdata name="position" type="property" display="Position" />' + ;
						'<memberdata name="servicetime" type="property" display="ServiceTime" />' + ;
						'<memberdata name="appointment" type="property" display="Appointment" />' + ;
						'<memberdata name="accessdayfrom" type="property" display="AccessDayFrom" />' + ;
						'<memberdata name="accesshourfrom" type="property" display="AccessHourFrom" />' + ;
						'<memberdata name="accessdayto" type="property" display="AccessDayTo" />' + ;
						'<memberdata name="accesshourto" type="property" display="AccessHourTo" />' + ;
						'<memberdata name="beforewaypoints" type="property" display="BeforeWaypoints" />' + ;
						'<memberdata name="pickups" type="property" display="Pickups" />' + ;
						'<memberdata name="drops" type="property" display="Drops" />' + ;
						'</VFPData>'

	FUNCTION Set (Id AS String, Lat AS Double, Long AS Double)

		This.Reset()
		IF (EMPTY(m.Id) OR This.Id.Set(m.Id)) AND This.Position.Set(m.Lat, m.Long)
			This._IsSet = .T.
		ENDIF

	ENDFUNC

	FUNCTION Get () AS String

		RETURN This.ToString()

	ENDFUNC

	FUNCTION Reset ()

		This._IsSet = .F.
		This.Id.Reset()
		This.Position.Reset()
		This.ServiceTime.Reset()
		This.Appointment.Reset()
		This.AccessDayFrom.Reset()
		This.AccessHourFrom.Reset()
		This.AccessDayTo.Reset()
		This.AccessHourTo.Reset()
		This.BeforeWaypoints.Remove(-1)
		This.Pickups.Remove(-1)
		This.Drops.Remove(-1)

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL Result AS String
		LOCAL Parcial AS String
		LOCAL Segment AS String
		LOCAL RefWP AS oh_IntegerType
		LOCAL RefPI AS oh_PickupItemType
		LOCAL RefDI AS oh_DropItemType
		
		m.Result = This.Id.ToString()
		IF !EMPTY(m.Result)
			m.Result = m.Result + ";"
		ENDIF
		m.Result = m.Result + This.Position.ToString()
		m.Segment = This.ServiceTime.ToString()
		IF !EMPTY(m.Segment)
			m.Result = m.Result + ";st:" + m.Segment
		ENDIF
		m.Segment = This.Appointment.ToString()
		IF !EMPTY(m.Segment)
			m.Result = m.Result + ";at:" + m.Segment
		ENDIF
		m.Segment = This.AccessDayFrom.ToString()
		IF !EMPTY(m.Segment)
			m.Parcial = ";acc:" + m.Segment
			m.Segment = This.AccessHourFrom.ToString()
			IF !EMPTY(m.Segment)
				m.Parcial = m.Parcial + m.Segment + "|"
				m.Segment = This.AccessDayTo.ToString()
				IF !EMPTY(m.Segment)
					m.Parcial = m.Parcial + m.Segment
					m.Segment = This.AccessDayHour.ToString()
					IF !EMPTY(m.Segment)
						m.Result = m.Result + m.Parcial + m.Segment
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		FOR EACH m.RefWP IN This.BeforeWaypoints
			m.Segment = m.RefWP.ToString()
			IF !EMPTY(m.Segment)
				m.Result = m.Result + ";before:destination" + m.Segment
			ENDIF
		ENDFOR
		FOR EACH m.RefPI IN This.Pickups
			m.Segment = m.RefPI.ToString()
			IF !EMPTY(m.Segment)
				m.Result = m.Result + ";" + m.Segment
			ENDIF
		ENDFOR
		FOR EACH m.RefDI IN This.Drops
			m.Segment = m.RefDI.ToString()
			IF !EMPTY(m.Segment)
				m.Result = m.Result + ";" + m.Segment
			ENDIF
		ENDFOR

		RETURN m.Result

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_PickupItemType AS oh_PickupDropItemType

	PDType = "pickup"

ENDDEFINE

DEFINE CLASS oh_DropItemType AS oh_PickupDropItemType

	PDType = "drop"

ENDDEFINE

DEFINE CLASS oh_PickupDropItemType AS oh_Datatype

	ADD OBJECT Name AS oh_ControlledStringType WITH RegExPattern = "^[A-Za-z0-9\-\s\/]*$"
	ADD OBJECT CostCapacity AS oh_DoubleType

	PDType = ""

	FUNCTION Set (Name AS String, ValueCost AS Double)

		This.Name.Reset()
		This.CostCapacity.Reset()

		IF This.Name.Set(m.Name) AND PCOUNT() = 2
			This.CostCapacity.Set(m.ValueCost)
		ENDIF

		RETURN This.Name.IsSet()

	ENDFUNC

	FUNCTION Get ()
		RETURN This.ToString()
	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		LOCAL Result AS String
		LOCAL Segment AS String
	
		m.Result = This.Name.ToString()
		IF !EMPTY(m.Result)
			m.Result = This.PDType + ":" + m.Result
			m.Segment = This.CostCapacity.ToString()
			IF !EMPTY(m.Segment)
				m.Result = m.Result + ",value:" + m.Segment
			ENDIF
		ENDIF

		RETURN m.Result

	ENDFUNC
	
ENDDEFINE

DEFINE CLASS oh_ImproveForType AS oh_EnumerationType

	_Enumeration = "time,distance"

ENDDEFINE

DEFINE CLASS oh_ServiceTimeType AS oh_EnumerationType

	_Enumeration = "rest,work"

ENDDEFINE

DEFINE CLASS oh_DrivingRestTimeType AS oh_Datatype

	ADD OBJECT Disabled AS oh_BooleanType
	ADD OBJECT Default AS oh_BooleanType
	ADD OBJECT ShortDriving AS oh_IntegerType
	ADD OBJECT ShortRest AS oh_IntegerType
	ADD OBJECT LongDriving AS oh_IntegerType
	ADD OBJECT LongRest AS oh_IntegerType
	ADD OBJECT ServiceTimes AS oh_ServiceTimeType

	FUNCTION Reset ()

		DODEFAULT()
		This.Disabled.Reset()
		This.Default.Reset()
		This.ShortDriving.Reset()
		This.ServiceTimes.Reset()

	ENDFUNC

	FUNCTION Get ()
		RETURN This.ToString()
	ENDFUNC

	FUNCTION Set (Disabled AS Boolean, ShortDriving AS Integer, ShortRest AS Integer, LongDriving AS Integer, LongRest AS Integer, ServiceTimes AS String)

		This.Reset()
		This.Disabled.Set(m.Disabled)
		IF !m.Disabled
			IF PCOUNT() = 1
				This.Default.Set(.T.)
				This._IsSet = .T.
			ELSE
				IF This.ShortDriving.Set(m.ShortDriving) AND This.ShortRest.Set(m.ShortRest) AND ;
						This.LongDriving.Set(m.LongDriving) AND This.LongRest.Set(m.LongRest) AND ;
						This.ServiceTimes.Set(m.ServiceTimes)
					This._IsSet = .T.
				ENDIF
			ENDIF
		ELSE
			This._IsSet = .T.
		ENDIF
			
		RETURN This._IsSet

	ENDFUNC

	FUNCTION ToString () AS String

		IF !This.IsSet()
			RETURN ""
		ENDIF

		SAFETHIS

		LOCAL Result AS String

		DO CASE
		CASE This.Disabled.Get()
			m.Result = "disabled"

		CASE This.Default.Get()
			m.Result = "default"

		OTHERWISE
			m.Result = "durations:" + This.ShortDriving.ToString() + "," + This.ShortRest.ToString() + "," + ;
						This.LongDriving.ToString() + "," + This.LongRest.Set(m.LongRest) + ";" + ;
						"serviceTimes:" + This.ServiceTimes.ToString()
		ENDCASE

		RETURN m.Result

	ENDFUNC

ENDDEFINE	

*************************************************************
* structures
*************************************************************

DEFINE CLASS oh_FindWaypointsResponseType AS oh_Structure

	ADD OBJECT Results AS Collection && OF oh_FindWaypointsDetailsType
	ADD OBJECT Errors AS Collection && OF oh_StringType
	ADD OBJECT ProcessingTimeDesc AS oh_StringType
	ADD OBJECT RequestId AS oh_StringType
	ADD OBJECT ResponseCode AS oh_StringType
	ADD OBJECT Warnings AS Collection && OF oh_FindWaypointsWarningType

	Members = '<member type="collection:oh_FindWaypointsDetailsType" name="results" />' + ;
					'<member type="collection:oh_StringType" name="errors" />' + ;
					'<member type="oh_StringType" name="processingTimeDesc" />' + ;
					'<member type="oh_StringType" name="requestId" />' + ;
					'<member type="oh_StringType" name="responseCode" />' + ;
					'<member type="collection:oh_FindWaypointsWarningType" name="warnings" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="results" type="property" display="Results" />' + ;
						'<memberdata name="errors" type="property" display="Errors" />' + ;
						'<memberdata name="processingtimedesc" type="property" display="ProcessingTimeDesc" />' + ;
						'<memberdata name="requestid" type="property" display="RequestId" />' + ;
						'<memberdata name="responsecode" type="property" display="ResponseCode" />' + ;
						'<memberdata name="warnings" type="property" display="Warnings" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_FindWaypointsDetailsType AS oh_Structure

	ADD OBJECT Waypoints AS Collection && OF oh_FindWaypointInfoType
	ADD OBJECT Distance AS oh_IntegerType
	ADD OBJECT Time AS oh_IntegerType
	ADD OBJECT Interconnections AS Collection && OF oh_FindInterconnectionType
	ADD OBJECT TimeBreakDown AS oh_TimeBreakDownType
	ADD OBJECT Description AS oh_StringType

	Members = '<member type="collection:oh_FindWaypointInfoType" name="waypoints" />' + ;
					'<member type="oh_IntegerType" name="distance" />' + ;
					'<member type="oh_IntegerType" name="time" />' + ;
					'<member type="collection:oh_FindInterconnectionType" name="interconnections" />' + ;
					'<member type="oh_TimeBreakDownType" name="timeBreakDown" />' + ;
					'<member type="oh_String" name="description" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="waypoints" type="property" display="Waypoints" />' + ;
						'<memberdata name="distance" type="property" display="Distance" />' + ;
						'<memberdata name="time" type="property" display="Time" />' + ;
						'<memberdata name="interconnections" type="property" display="Interconnections" />' + ;
						'<memberdata name="timebreakdown" type="property" display="TimeBreakDown" />' + ;
						'<memberdata name="description" type="property" display="Description" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_FindWaypointsWarningType AS oh_Structure

	ADD OBJECT Id AS oh_StringType
	ADD OBJECT Latitude AS oh_LatitudeType
	ADD OBJECT Longitude AS oh_LongitudeType
	ADD OBJECT FailedConstraints AS Collection && OF oh_FailedConstraintType

	Members = '<member type="oh_StringType" name="id" />' + ;
					'<member type="oh_LatitudeType" element="lat" name="latitude" />' + ;
					'<member type="oh_LongitudeType" element="lng" name="longitude" />' + ;
					'<member type="collection:oh_FailedConstraintType" name="failedConstraints" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="id" type="property" display="Id" />' + ;
						'<memberdata name="latitude" type="property" display="Latitude" />' + ;
						'<memberdata name="longitude" type="property" display="Longitude" />' + ;
						'<memberdata name="failedconstraints" type="property" display="FailedConstraints" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_FailedConstraintType AS oh_Structure

	ADD OBJECT Constraint AS oh_StringType
	ADD OBJECT Reason AS oh_StringType

	Members = '<member type="oh_StringType" name="constraint" />' + ;
					'<member type="oh_StringType" name="reason" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="constraint" type="property" display="Constraint" />' + ;
						'<memberdata name="reason" type="property" display="Reason" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_FindWaypointInfoType AS oh_Structure

	ADD OBJECT Id AS oh_StringType
	ADD OBJECT Latitude AS oh_LatitudeType
	ADD OBJECT Longitude AS oh_LongitudeType
	ADD OBJECT Sequence AS oh_IntegerType
	ADD OBJECT EstimatedArrival AS oh_DatetimeType
	ADD OBJECT EstimatedDeparture AS oh_DatetimeType
	ADD OBJECT FulfilledConstraints AS Collection && OF oh_StringType

	Members = '<member type="oh_StringType" name="id" />' + ;
					'<member type="oh_LatitudeType" element="lat" name="latitude" />' + ;
					'<member type="oh_LongitudeType" element="lng" name="longitude" />' + ;
					'<member type="oh_IntegerType" name="sequence" />' + ;
					'<member type="oh_DatetimeType" name="estimatedArrival" />' + ;
					'<member type="oh_DatetimeType" name="estimatedDeparture" />' + ;
					'<member type="collection:oh_StringType" name="fulfilledConstraints" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="id" type="property" display="Id" />' + ;
						'<memberdata name="lat" type="property" display="Lat" />' + ;
						'<memberdata name="lng" type="property" display="Lng" />' + ;
						'<memberdata name="sequence" type="property" display="Sequence" />' + ;
						'<memberdata name="estimatedarrival" type="property" display="EstimatedArrival" />' + ;
						'<memberdata name="estimateddeparture" type="property" display="EstimatedDeparture" />' + ;
						'<memberdata name="fulfilledconstraints" type="property" display="FulfilledConstraints" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_FindInterconnectionType AS oh_Structure

	ADD OBJECT FromWaypoint AS oh_StringType
	ADD OBJECT ToWaypoint AS oh_StringType
	ADD OBJECT Distance AS oh_IntegerType
	ADD OBJECT Time AS oh_IntegerType
	ADD OBJECT Rest AS oh_IntegerType
	ADD OBJECT Waiting AS oh_IntegerType

	Members = '<member type="oh_StringType" name="fromWaypoint" />' + ;
					'<member type="oh_StringType" name="toWaypoint" />' + ;
					'<member type="oh_IntegerType" name="distance" />' + ;
					'<member type="oh_IntegerType" name="time" />' + ;
					'<member type="oh_IntegerType" name="rest" />' + ;
					'<member type="oh_IntegerType" name="waiting" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="fromwaypoint" type="property" display="FromWaypoint" />' + ;
						'<memberdata name="towaypoint" type="property" display="ToWaypoint" />' + ;
						'<memberdata name="distance" type="property" display="Distance" />' + ;
						'<memberdata name="time" type="property" display="Time" />' + ;
						'<memberdata name="rest" type="property" display="Rest" />' + ;
						'<memberdata name="waiting" type="property" display="Waiting" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_TimeBreakDownType AS oh_Structure

	ADD OBJECT Driving AS oh_IntegerType
	ADD OBJECT Service AS oh_IntegerType
	ADD OBJECT Rest AS oh_IntegerType
	ADD OBJECT Waiting AS oh_IntegerType

	Members = '<member type="oh_IntegerType" name="driving" />' + ;
					'<member type="oh_IntegerType" name="service" />' + ;
					'<member type="oh_IntegerType" name="rest" />' + ;
					'<member type="oh_IntegerType" name="waiting" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="driving" type="property" display="Driving" />' + ;
						'<memberdata name="service" type="property" display="Service" />' + ;
						'<memberdata name="rest" type="property" display="Rest" />' + ;
						'<memberdata name="waiting" type="property" display="Waiting" />' + ;
						'</VFPData>'

ENDDEFINE



