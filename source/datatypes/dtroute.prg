*************************************************************
*
* overHere route datatypes classes
*
*************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_WaypointParameterType AS oh_Datatype

	ADD OBJECT Type AS oh_WaypointTypeType
	ADD OBJECT StopOverDuration AS oh_IntegerType
	ADD OBJECT UserLabel AS oh_StringType WITH AllowEmpty = .T.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="type" type="property" display="Type" />' + ;
						'<memberdata name="stopoverduration" type="property" display="StopOverDuration" />' + ;
						'<memberdata name="userlabel" type="property" display="UserLabel" />' + ;
						'</VFPData>'

	FUNCTION Get () AS String

		RETURN This.ToString()

	ENDFUNC

	FUNCTION Reset ()

		This._IsSet = .F.
		This.Type.Reset()
		This.StopOverDuration.Reset()
		This.UserLabel.Reset()

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_GeoWaypointParameterType AS oh_WaypointParameterType

	ADD OBJECT Heading AS oh_HeadingType
	ADD OBJECT Position AS oh_GeoCoordinateType
	ADD OBJECT TransitRadius AS oh_IntegerType

	FUNCTION Set (Type AS String, StopOverDuration AS Integer, ;
						Lat AS Double, Long AS Double, Alt AS Double, Radius AS Integer, ;
						UserLabel AS String, Heading AS Double) AS Logical

		SAFETHIS

		This.Reset()

		IF VARTYPE(m.Alt) == "N"
			This._IsSet = This.Position.Set(m.Lat, m.Long, m.Alt)
		ELSE
			This._IsSet = This.Position.Set(m.Lat, m.Long)
		ENDIF

		IF !EMPTY(m.Type)
			This._IsSet = This._IsSet AND This.Type.Set(m.Type)
		ENDIF
		IF VARTYPE(m.StopOverDuration) == "N"
			This._IsSet = This._IsSet AND This.StopOverDuration.Set(m.StopOverDuration)
		ENDIF
		IF VARTYPE(m.Radius) == "N"
			This._IsSet = This._IsSet AND This.Radius.Set(m.Radius)
		ENDIF
		IF VARTYPE(m.UserLabel) == "C"
			This._IsSet = This._IsSet AND This.UserLabel.Set(m.UserLabel)
		ENDIF
		IF VARTYPE(m.Heading) == "N"
			This._IsSet = This._IsSet AND This.Heading.Set(m.Heading)
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		DODEFAULT()
		This.Heading.Reset()
		This.Position.Reset()
		This.TransitRadius.Reset()

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL Result AS String
		LOCAL Sep AS String
		LOCAL Part AS String

		m.Result = "geo!"
		m.Sep = ""
		IF This.Type.IsSet()
			m.Result = m.Result + This.Type.ToString()
			m.Sep = ","
		ENDIF
		IF This.StopOverDuration.IsSet()
			m.Sep = EVL(m.Sep, "stopOver,")
			m.Result = m.Result + m.Sep + This.StopOverDuration.ToString()
			m.Sep = "!"
		ENDIF
		m.Result = m.Result + CHRTRAN(m.Sep, ",", "!")
		m.Sep = ""

		m.Result = m.Result + This.Position.ToString()

		IF This.TransitRadius.IsSet()
			m.Result = m.Result + ";" + This.TransitRadius.ToString()
			m.Sep = ";"
		ELSE
			m.Sep = ";;"
		ENDIF
		IF This.UserLabel.IsSet()
			m.Part = STRTRAN(This.UserLabel.ToString(), ";", "\;")
			IF !EMPTY(m.Part)
				m.Result = m.Result + m.Sep + m.Part
				m.Sep = ";"
			ELSE
				m.Sep = m.Sep + ";"
			ENDIF
		ELSE
			m.Sep = m.Sep + ";"
		ENDIF
		IF This.Heading.IsSet()
			m.Result = m.Result + m.Sep + This.Heading.ToString()
		ENDIF

		RETURN m.Result

	ENDFUNC
		
ENDDEFINE

DEFINE CLASS oh_StreetNavigationWaypointParameterType AS oh_WaypointParameterType

	ADD OBJECT Heading AS oh_HeadingType
	ADD OBJECT Position AS oh_GeoCoordinateType
	ADD OBJECT StreetName AS oh_StringType WITH AllowEmpty = .T.
	ADD OBJECT DisplayPosition AS oh_GeoCoordinateType
	ADD OBJECT TransitRadius AS oh_IntegerType

	FUNCTION Set (Type AS String, StopOverDuration AS Integer, ;
						LatDisplay AS Double, LongDispla AS Double, AltDisplay AS Double, ;
						UserLabel AS String, ;
						Lat AS Double, Long AS Double, Alt AS Double, StreetName AS String, ;
						Heading AS Double, Radius AS Integer) AS Logical

		SAFETHIS

		This.Reset()

		IF VARTYPE(m.Alt) == "N"
			This._IsSet = This.Position.Set(m.Lat, m.Long, m.Alt)
		ELSE
			This._IsSet = This.Position.Set(m.Lat, m.Long)
		ENDIF

		IF !EMPTY(m.Type)
			This._IsSet = This._IsSet AND This.Type.Set(m.Type)
		ENDIF
		IF !EMPTY(m.StopOverDuration)
			This._IsSet = This._IsSet AND This.StopOverDuration(m.StopOverDuration)
		ENDIF
		IF VARTYPE(m.LatDisplay) == "N"
			IF VARTYPE(m.AltDisplay) == "N"
				This._IsSet = This.DisplayPosition.Set(m.LatDisplay, m.LongDisplay, m.AltDisplay)
			ELSE
				This._IsSet = This.DisplayPosition.Set(m.LatDisplay, m.LongDisplay)
			ENDIF
		ENDIF
		IF VARTYPE(m.UserLabel) == "C"
			This._IsSet = This._IsSet AND This.UserLabel.Set(m.UserLabel)
		ENDIF
		IF VARTYPE(m.StreetName) == "C"
			This._IsSet = This._IsSet AND This.StreetName.Set(m.StreetName)
		ENDIF
		IF VARTYPE(m.Heading) == "N"
			This._IsSet = This._IsSet AND This.Heading.Set(m.Heading)
		ENDIF
		IF VARTYPE(m.Radius) == "N"
			This._IsSet = This._IsSet AND This.Radius.Set(m.Radius)
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		DODEFAULT()
		This.Heading.Reset()
		This.Position.Reset()
		This.DisplayPosition.Reset()
		This.TransitRadius.Reset()

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL Result AS String
		LOCAL Sep AS String
		LOCAL Part AS String

		m.Sep = ""
		m.Result = "street!"
		IF This.Type.IsSet()
			m.Result = m.Result + This.Type.ToString()
			m.Sep = ","
		ENDIF
		IF This.StopOverDuration.IsSet()
			m.Sep = EVL(m.Sep, "stopOver,")
			m.Result = m.Result + m.Sep + This.StopOverDuration.ToString()
			m.Sep = "!"
		ENDIF
		m.Result = m.Result + CHRTRAN(m.Sep, ",", "!")
		m.Sep = ""
		IF This.DisplayPosition.IsSet()
			m.Result = m.Result + This.DisplayPosition.ToString()
			m.Sep = ";"
		ENDIF
		IF This.UserLabel.IsSet()
			m.Part = STRTRAN(This.UserLabel.ToString(), ";", "\;")
			IF !EMPTY(m.Part)
				m.Result = m.Result + EVL(m.Sep, ";") + m.Part
				m.Sep = "!"
			ELSE
				m.Sep = CHRTRAN(m.Sep, ";", "!")
			ENDIF
		ENDIF

		m.Result = m.Result + m.Sep + This.Position.ToString()
		IF This.StreetName.IsSet()
			m.Part = STRTRAN(This.StreetName.ToString(), ";", "\;")
			IF !EMPTY(m.Part)
				m.Result = m.Result + ";" + m.Part
			ENDIF
		ENDIF

		IF This.Heading.IsSet()
			m.Result = m.Result + "!" + This.Heading.ToString()
		ENDIF
		IF This.TransitRadius.IsSet()
			m.Result = m.Result + "!" + This.TransitRadius.ToString()
		ENDIF

		RETURN m.Result

	ENDFUNC
		
ENDDEFINE

DEFINE CLASS oh_LinkNavigationWaypointParameterType AS oh_WaypointParameterType

	ADD OBJECT LinkPosition AS oh_LinkIdType
	ADD OBJECT Spot AS oh_DoubleType
	ADD OBJECT DisplayPosition AS oh_GeoCoordinateType

	FUNCTION Set (Type AS String, StopOverDuration AS Integer, ;
						LatDisplay AS Double, LongDispla AS Double, AltDisplay AS Double, ;
						UserLabel AS String, ;
						LinkPosition AS String, Spot AS Double) AS Logical

		SAFETHIS

		This.Reset()

		This._IsSet = This.LinkPosition.Set(m.LinkPosition)

		IF !EMPTY(m.Type)
			This._IsSet = This._IsSet AND This.Type.Set(m.Type)
		ENDIF
		IF !EMPTY(m.StopOverDuration)
			This._IsSet = This._IsSet AND This.StopOverDuration(m.StopOverDuration)
		ENDIF
		IF VARTYPE(m.LatDisplay) == "N"
			IF VARTYPE(m.AltDisplay) == "N"
				This._IsSet = This.DisplayPosition.Set(m.LatDisplay, m.LongDisplay, m.AltDisplay)
			ELSE
				This._IsSet = This.DisplayPosition.Set(m.LatDisplay, m.LongDisplay)
			ENDIF
		ENDIF
		IF VARTYPE(m.UserLabel) == "C"
			This._IsSet = This._IsSet AND This.UserLabel.Set(m.UserLabel)
		ENDIF
		IF VARTYPE(m.Spot) == "N"
			This._IsSet = This._IsSet AND This.Spot.Set(m.Spot)
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		DODEFAULT()
		This.LinkPosition.Reset()
		This.DisplayPosition.Reset()
		This.Spot.Reset()

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL Result AS String
		LOCAL Sep AS String
		LOCAL Part AS String

		m.Sep = ""
		m.Result = "link!"
		IF This.Type.IsSet()
			m.Result = m.Result + This.Type.ToString()
			m.Sep = ","
		ENDIF
		IF This.StopOverDuration.IsSet()
			m.Sep = EVL(m.Sep, "stopOver,")
			m.Result = m.Result + m.Sep + This.StopOverDuration.ToString()
			m.Sep = "!"
		ENDIF
		m.Result = m.Result + CHRTRAN(m.Sep, ",", "!")
		m.Sep = ""
		IF This.DisplayPosition.IsSet()
			m.Result = m.Result + This.DisplayPosition.ToString()
			m.Sep = ";"
		ENDIF
		IF This.UserLabel.IsSet()
			m.Part = STRTRAN(This.UserLabel.ToString(), ";", "\;")
			IF !EMPTY(m.Part)
				m.Result = m.Result + EVL(m.Sep, ";") + m.Part
				m.Sep = "!"
			ELSE
				m.Sep = CHRTRAN(m.Sep, ";", "!")
			ENDIF
		ENDIF

		m.Result = m.Result + m.Sep + This.LinkPosition.ToString()

		IF This.Spot.IsSet()
			m.Result = m.Result + "," + This.Spot.ToString()
		ENDIF

		RETURN m.Result

	ENDFUNC
		
ENDDEFINE

DEFINE CLASS oh_WaypointTypeType AS oh_EnumerationType

	_Enumeration = "stopOver,passThrough"

ENDDEFINE

DEFINE CLASS oh_RoutingTypeType AS oh_EnumerationType

	_Enumeration = "fastest,shortest,balanced"

ENDDEFINE

DEFINE CLASS oh_TransportModeType AS oh_EnumerationType

	_Enumeration = "car,pedestrian,carHOV,publicTransport,publicTransportTimeTable,truck,bicycle"

ENDDEFINE

DEFINE CLASS oh_TrafficModeType AS oh_EnumerationType

	_Enumeration = "enabled,disabled,default"

ENDDEFINE

DEFINE CLASS oh_RouteFeatureType AS oh_EnumerationType

	_Enumeration = "tollroad,motorway,boatFerry,railFerry,tunnel,dirtRoad,park"

ENDDEFINE

DEFINE CLASS oh_RouteFeatureWeightType AS oh_IntegerType

	Minimum = -3
	Maximum = 0

ENDDEFINE

DEFINE CLASS oh_RouteFeaturesListType AS oh_Datatype

	FUNCTION PreInit ()

		This.Value = CREATEOBJECT("Collection")

	ENDFUNC

	FUNCTION Set (Feature AS String, Weight AS Integer)

		SAFETHIS

		LOCAL RouteFeature AS oh_RouteFeatureType
		LOCAL FeatureWeight AS oh_RouteFeatureWeightType

		IF This._IsSet OR This.Value.Count = 0
			m.RouteFeature = CREATEOBJECT("oh_RouteFeatureType")
			m.FeatureWeight = CREATEOBJECT("oh_RouteFeatureWeightType")

			IF m.RouteFeature.Set(m.Feature) AND m.FeatureWeight.Set(m.Weight)
				This.Value.Add(m.FeatureWeight, m.Feature)
				This._IsSet = .T.
			ELSE
				This.Reset()
			ENDIF
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		This._IsSet = .F.
		This.Value.Remove(-1)

	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL Result AS String
		LOCAL Sep AS String
		LOCAL ItemIndex AS Integer
		LOCAL Weight AS oh_RouteFeatureWeightType

		m.Result = ""
		m.Sep = ""
		FOR m.ItemIndex = 1 TO This.Value.Count
			m.Weight = This.Value.Item(m.ItemIndex)
			m.Result = m.Result + m.Sep + This.Value.GetKey(m.ItemIndex) + ":" + m.Weight.ToString()
			m.Sep = ";"
		ENDFOR

		RETURN m.Result

	ENDFUNC
		
ENDDEFINE

DEFINE CLASS oh_RoutingModeType AS oh_RoutingTypeType

	ADD OBJECT TransportMode AS oh_TransportModeType
	ADD OBJECT TrafficMode AS oh_TrafficModeType
	ADD OBJECT Features AS oh_RouteFeaturesListType

	FUNCTION Set (Component AS String, Value AS String, Weight AS Integer) AS Logical

		SAFETHIS

		IF !VARTYPE(m.Component) == "C" OR LEN(m.Component) < 4
			This.Reset()
			RETURN
		ENDIF

		LOCAL CompName AS String
		LOCAL LenCompName AS Integer
		LOCAL Result AS Logical

		m.CompName = TRIM(UPPER(m.Component))
		m.LenCompName = LEN(m.CompName)

		m.Result = .F.

		DO CASE
		CASE m.CompName == PADR("TYPE", m.LenCompName)
			m.Result = oh_RoutingTypeType::Set(m.Value)
			
		CASE m.CompName == PADR("TRANSPORTMODE", m.LenCompName)
			m.Result = This.TransportMode.Set(m.Value)

		CASE m.CompName == PADR("TRAFFICMODE", m.LenCompName)
			m.Result = This.TrafficMode.Set(m.Value)

		CASE m.CompName == PADR("FEATURES", m.LenCompName)
			m.Result = This.Features.Set(m.Value)

		ENDCASE
	
		IF !m.Result
			This.Reset()
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		DODEFAULT()
		This.TransportMode.Reset()
		This.TrafficMode.Reset()
		This.Features.Reset()

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL Result AS String

		m.Result = oh_RoutingTypeType::ToString()

		IF This.TransportMode.IsSet()
			m.Result = m.Result + ";" + This.TransportMode.ToString()
		ENDIF
		IF This.TrafficMode.IsSet()
			m.Result = m.Result + ";traffic:" + This.TrafficMode.ToString()
		ENDIF
		IF This.Features.IsSet()
			m.Result = m.Result + ";" + This.Features.ToString()
		ENDIF

		RETURN m.Result

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_EngineType AS oh_EnumerationType

	_Enumeration = "gasoline,diesel,electric"

ENDDEFINE

DEFINE CLASS oh_VehicleType AS oh_EngineType

	ADD OBJECT AverageConsumption AS oh_DoubleType

	FUNCTION AverageConsumption.IsValid (Consumption AS Double) AS Logical

		RETURN oh_DoubleType::IsValid(m.Consumption) AND m.Consumption > 0

	ENDFUNC

	FUNCTION Set (Engine AS String, Consumption AS Double) AS Logical

		SAFETHIS

		IF !oh_EngineType::Set(m.Engine) OR !This.AverageConsumption.Set(m.Consumption)
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Parse (Input AS String) AS Logical

		IF VARTYPE(m.Input) == "C"
			RETURN This.Set(LEFT(m.Input, AT(",", m.Input) - 1), VAL(CHRTRAN(SUBSTR(m.Input, AT(",", m.Input) + 1), ".", SET("Point"))))
		ENDIF

	ENDFUNC

	FUNCTION ToString ()

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		RETURN oh_EngineType::ToString() + "," + This.AverageConsumption.ToString()

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_SpeedProfileType AS oh_EnumerationType

	_Enumeration = "default,fast"

ENDDEFINE

DEFINE CLASS oh_SpeedConsumptionType AS oh_IntegerType

	ADD OBJECT Consumption AS oh_DoubleType WITH Minimum = 0

	FUNCTION IsValid (Value AS Integer) AS Logical

		RETURN oh_IntegerType::IsValid(m.Value) AND BETWEEN(m.Value, 0, 255)

	ENDFUNC

	FUNCTION SET(Value AS Integer, Consumption AS Double)

		SAFETHIS

		IF !oh_IntegerType::Set(m.Value) OR !This.Consumption.Set(m.Consumption)
			This._IsSet = .F.
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		RETURN oh_IntegerType::ToString() + "," + This.Consumption.ToString()

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_ConsumptionModelType AS oh_Datatype

	ADD OBJECT Ascent AS oh_DoubleType
	ADD OBJECT Descent AS oh_DoubleType
	ADD OBJECT TimePenalty AS oh_DoubleType
	ADD OBJECT AuxiliaryConsumption AS oh_DoubleType
	ADD OBJECT Acceleration AS oh_DoubleType
	ADD OBJECT Deceleration AS oh_DoubleType

	FUNCTION PreInit ()

		This.Value = CREATEOBJECT("Collection")

	ENDFUNC

	FUNCTION Set (Component AS String, Value AS Double, Speed AS Integer) AS Logical

		SAFETHIS

		IF !VARTYPE(m.Component) == "C" OR LEN(m.Component) < 4
			This.Reset()
			RETURN
		ENDIF

		LOCAL CompName AS String
		LOCAL LenCompName AS Integer
		LOCAL Result AS Logical
		LOCAL SpeedItem AS oh_SpeedConsumptionType

		m.CompName = TRIM(UPPER(m.Component))
		m.LenCompName = LEN(m.CompName)

		m.Result = .F.

		DO CASE
		CASE m.CompName == PADR("SPEED", m.LenCompName)
			m.SpeedItem = CREATEOBJECT("oh_SpeedConsumptionType")
			IF m.SpeedItem.Set(m.Speed, m.Value)
				This.Value.Add(m.SpeedItem)
				m.Result = .T.
			ENDIF
			
		CASE m.CompName == PADR("ASCENT", m.LenCompName)
			m.Result = This.Ascent.Set(m.Value)

		CASE m.CompName == PADR("DESCENT", m.LenCompName)
			m.Result = This.Descent.Set(m.Value)

		CASE m.CompName == PADR("TIMEPENALTY", m.LenCompName)
			m.Result = This.TimePenalty.Set(m.Value)

		CASE m.CompName == PADR("AUXILIARYCONSUMPTION", m.LenCompName)
			m.Result = This.AuxiliaryConsumption.Set(m.Value)

		CASE m.CompName == PADR("ACCELERATION", m.LenCompName)
			m.Result = This.Acceleration.Set(m.Value)

		CASE m.CompName == PADR("DECELERATION", m.LenCompName)
			m.Result = This.Deceleration.Set(m.Value)

		ENDCASE
	
		IF !m.Result
			This.Reset()
		ELSE
			This._IsSet = This.Value.Count > 0 AND This.Ascent.IsSet() AND This.Descent.IsSet()
		ENDIF

		RETURN This._IsSet

	ENDFUNC

	FUNCTION Reset ()

		This._IsSet = .F.
		This.Value.Remove(-1)
		This.Ascent.Reset()
		This.Descent.Reset()
		This.TimePenalty.Reset()
		This.AuxiliaryConsumption.Reset()
		This.Acceleration.Reset()
		This.Deceleration.Reset()

	ENDFUNC

	FUNCTION ToString () AS String

		SAFETHIS

		IF !This._IsSet
			RETURN ""
		ENDIF

		LOCAL Result
		LOCAL SpeedItem AS oh_SpeedConsumptionType

		m.Result = "speed"
		FOR EACH m.SpeedItem IN This.Value
			m.Result = m.Result + "," + m.SpeedItem.ToString()
		ENDFOR

		m.Result = m.Result + ";ascent," + This.Ascent.ToString() + ";descent," + This.Descent.ToString()

		IF This.TimePenalty.IsSet()
			m.Result = m.Result + ";timepenalty," + This.TimePenalty.ToString()
		ENDIF
		IF This.AuxiliaryConsumption.IsSet()
			m.Result = m.Result + ";auxiliaryconsumption," + This.AuxiliaryConsumption.ToString()
		ENDIF
		IF This.Acceleration.IsSet()
			m.Result = m.Result + ";acceleration," + This.Acceleration.ToString()
		ENDIF
		IF This.Deceleration.IsSet()
			m.Result = m.Result + ";deceleration," + This.Deceleration.ToString()
		ENDIF

		RETURN m.Result

	ENDFUNC

ENDDEFINE

DEFINE CLASS oh_RouteRepresentationOptionsType AS oh_EnumerationType

	_Enumeration = "overview,display,dragNDrop,navigation,linkPaging,turnByTurn"

ENDDEFINE

DEFINE CLASS oh_RouteAttributeType AS oh_EnumerationType

	_Enumeration = "waypoints,wp,summary,sm,summaryByCountry,sc,shape,sh,boundingBox,bb,legs,lg,notes,no," + ;
						"lines,li,tickets,tx,labels,la,routeId,ri,groups,gr,incidents,ic,zones,zo"

ENDDEFINE

DEFINE CLASS oh_RouteLegAttributeType AS oh_EnumerationType

	_Enumeration = "waypoint,wp,maneuvers,mn,links,li,length,le,travelTime,tt,shape,sh,indices,ix," + ;
						"boundingBox,bb,baseTime,bt,trafficTime,tm,summary,sm"

ENDDEFINE

DEFINE CLASS oh_ManeuverAttributeType AS oh_EnumerationType

	_Enumeration = "position,po,shape,sh,travelTime,tt,length,le,time,ti,link,li,publicTransportLine,pt,publicTransportTickets,tx," + ;
						"platform,pl,roadName,rn,nextRoadName,nr,roadNumber,ru,nextRoadNumber,nu,signPost,sp,notes,no,action,ac,direction,di," + ;
						"nextManeuver,nm,freewayExit,fe,freewayJunction,fj,baseTime,bt,trafficTime,tm,indices,ix,boundingBox,bb,roadShield,rs," + ;
						"startAngle,sa,waitTime,wt,shapeQuality,sq,publicTransportDelays,td"

ENDDEFINE

DEFINE CLASS oh_RouteLinkAttributeType AS oh_EnumerationType

	_Enumeration = "shape,sh,length,le,speedLimit,sl,dynamicSpeedInfo,ds,truckRestrictions,tr,flags,fl,roadNumber,rn,roadName,ro," + ;
						"timezone,tz,nextLink,nl,publicTransportLine,pt,remainTime,rt,remainDistance,rd,maneuver,ma,functionalClass,fc," + ;
						"nextStopName,ns,indices,ix,consumption,cn,timeDependentRestriction,ti"

ENDDEFINE

DEFINE CLASS oh_PublicTransportLineAttributeType AS oh_EnumerationType

	_Enumeration = "foreground,fg,background,bg,lineStyle,ls,companyShortName,cs,companyLogo,cl,flags,fl,typeName,tn,lineId,li," + ;
						"companyId,ci,systemId,si"

ENDDEFINE

DEFINE CLASS oh_InstructionFormatType AS oh_EnumerationType

	_Enumeration = "text,html"

ENDDEFINE

DEFINE CLASS oh_TruckTypeType AS oh_EnumerationType

	_Enumeration = "truck,tractorTruck"

ENDDEFINE

DEFINE CLASS oh_HazardousGoodsTypeType AS oh_EnumerationType

	_Enumeration = "allhazardousGoods,explosive,gas,flammable,combustible,organic,poison,radioActive,corrosive,poisonousInhalation,harmfulToWater,other"

ENDDEFINE

DEFINE CLASS oh_TunnelCategoryType AS oh_EnumerationType

	_Enumeration = "B,C,D,E"

ENDDEFINE

DEFINE CLASS oh_ShapeQualityType AS oh_EnumerationType

	_Enumeration = "exact,coarse"

ENDDEFINE

DEFINE CLASS oh_RouteNoteTypeType AS oh_EnumerationType

	_Enumeration = "info,warning,restriction,violation,traffic"

ENDDEFINE

DEFINE CLASS oh_RouteNoteCodeType AS oh_EnumerationType

	_Enumeration = "copyright,routingOptionViolated,passingPlace,roadNameChanged,sharpCurveAhead,linkFeatureAhead," + ;
						"timeDependentRestriction,previousIntersection,nextIntersection,adminDivisionChange,countryChange," + ;
						"gateAccess,privateRoad,tollBooth,tollRoad,unpavedRoad,restrictedTurn,truckRestriction,seasonalClosures," + ;
						"congestion,roadworks,accident,closure,trafficFlow"

ENDDEFINE

DEFINE CLASS oh_RouteLinkFlagType AS oh_EnumerationType

	_Enumeration = "boatFerry,HOVLane,dirtRoad,motorway,noThroughRoad,park,railFerry,privateRoad,tollroad,tunnel,builUpArea"

ENDDEFINE

DEFINE CLASS oh_RecurringTimeIntervalsCombinationType AS oh_StringType
ENDDEFINE

DEFINE CLASS oh_LicensePlatePatternType AS oh_StringType
ENDDEFINE

DEFINE CLASS oh_TruckRestrictionPenaltyType AS oh_EnumerationType

	_Enumeration = "strict,soft"

ENDDEFINE

DEFINE CLASS oh_PublicTransportFlagType AS oh_EnumerationType

	_Enumeration = "containsTimeEstimate"

ENDDEFINE

DEFINE CLASS oh_PublicTransportActionType AS oh_EnumerationType

	_Enumeration = "enter,change,leave"

ENDDEFINE

DEFINE CLASS oh_PublicTransportTypeType AS oh_EnumerationType

	_Enumeration = "busPublic,busTouristic,busIntercity,busExpress,railMetro,railMetroRegional,railLight,railRegional,trainRegional," + ;
						"trainIntercity,trainHighSpeed,monoRail,aerial,inclined,water,privateService"

ENDDEFINE

DEFINE CLASS oh_PublicTransportLinkFlagType AS oh_EnumerationType

	_Enumeration = "barrierFree"

ENDDEFINE

DEFINE CLASS oh_ResourceTypeType AS oh_EnumerationType

	_Enumeration = "junctionView,signAsReal,directionArrow,advertising,vendorIcon,vendorLogo,routeTemplate"

ENDDEFINE

DEFINE CLASS oh_DirectionType AS oh_EnumerationType

	_Enumeration = "forward,bearRight,lightRight,right,hardRight,uTurnRight,uTurnLeft,hardLeft,left,lightLeft,bearLeft"

ENDDEFINE

DEFINE CLASS oh_PrivateTransportActionType AS oh_EnumerationType

	_Enumeration = "depart,arrive,leftUTurn,sharpLeftTurn,leftTurn,continue,slightRightTurn,rightTurn,sharpRightTurn," + ;
						"rightUTurn,ferry,leftExit,rightExit,leftRamp,rightRamp,leftFork,middleFork,rightFork,leftMerge,rightMerge," + ;
						"nameChange,leftRoundaboutExit1,leftRoundaboutExit2,leftRoundaboutExit3,leftRoundaboutExit4,leftRoundaboutExit5," + ;
						"leftRoundaboutExit6,leftRoundaboutExit7,leftRoundaboutExit8,leftRoundaboutExit9,leftRoundaboutExit10," + ;
						"leftRoundaboutExit11,leftRoundaboutExit12,rightRoundaboutExit1,rightRoundaboutExit2,rightRoundaboutExit3," + ;
						"rightRoundaboutExit4,rightRoundaboutExit5,rightRoundaboutExit6,rightRoundaboutExit7,rightRoundaboutExit8," + ;
						"rightRoundaboutExit9,rightRoundaboutExit10,rightRoundaboutExit11,rightRoundaboutExit12"

ENDDEFINE

DEFINE CLASS oh_SourceSupplierNoteTypeType AS oh_EnumerationType

	_Enumeration = "ticketPurchase,disclaimer"

ENDDEFINE

DEFINE CLASS oh_RoutingZoneTypeType AS oh_EnumerationType

	_Enumeration = "vignette,congestionPricing,adminClass,environmental"

ENDDEFINE

DEFINE CLASS oh_TurnTypeType AS oh_EnumerationType

	_Enumeration = "difficult"

ENDDEFINE

DEFINE CLASS oh_TimeDependentRestrictionTypeType AS oh_EnumerationType

	_Enumeration = "turnRestriction,closure"

ENDDEFINE

DEFINE CLASS oh_IncidentTypeType AS oh_EnumerationType

	_Enumeration = "accident,congestion,roadworks,closure,flow,other"

ENDDEFINE


*************************************************************
* structures
*************************************************************

DEFINE CLASS oh_CalculateRouteResponseType AS oh_Structure

	ADD OBJECT MetaInfo AS oh_RouteResponseMetaInfoType
	ADD OBJECT Routes AS Collection && OF oh_RouteType
	ADD OBJECT Language AS oh_LanguageCodeType
	ADD OBJECT SourceAttribution AS oh_SourceAttributionType

	Members = '<member type="oh_RouteResponseMetaInfoType" name="MetaInfo" />' + ;
					'<member type="collection:oh_RouteType" name="Routes" element="Route" />' + ;
					'<member type="oh_LanguageCodeType" name="Language" />' + ;
					'<member type="oh_SourceAttributionType" name="SourceAttribution" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="metainfo" type="property" display="MetaInfo" />' + ;
						'<memberdata name="routes" type="property" display="Routes" />' + ;
						'<memberdata name="language" type="property" display="Language" />' + ;
						'<memberdata name="sourceattribution" type="property" display="SourceAttribution" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_RouteResponseMetaInfoType AS oh_Structure

	ADD OBJECT RequestId AS oh_StringType
	ADD OBJECT Timestamp AS oh_DatetimeType
	ADD OBJECT MapVersion AS oh_StringType
	ADD OBJECT AvailableMapVersion AS oh_StringType
	ADD OBJECT ModuleVersion AS oh_StringType
	ADD OBJECT InterfaceVersion AS oh_StringType

	Members = '<member type="oh_StringType" name="RequestId" />' + ;
					'<member type="oh_DatetimeType" name="Timestamp" />' + ;
					'<member type="oh_StringType" name="MapVersion" />' + ;
					'<member type="oh_StringType" name="AvailableMapVersion" />' + ;
					'<member type="oh_StringType" name="ModuleVersion" />' + ;
					'<member type="oh_StringType" name="InterfaceVersion" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="requestid" type="property" display="RequestId" />' + ;
						'<memberdata name="timestamp" type="property" display="Timestamp" />' + ;
						'<memberdata name="mapversion" type="property" display="MapVersion" />' + ;
						'<memberdata name="availablemapversion" type="property" display="AvailableMapVersion" />' + ;
						'<memberdata name="moduleversion" type="property" display="ModuleVersion" />' + ;
						'<memberdata name="interfaceversion" type="property" display="InterfaceVersion" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_RouteType AS oh_Structure

	ADD OBJECT RouteId AS oh_StringType
	ADD OBJECT Waypoints AS Collection && OF oh_WaypointType
	ADD OBJECT Mode AS oh_RoutingModeType
	ADD OBJECT Shape AS oh_GeoPolylineType
	ADD OBJECT BoundingBox AS oh_GeoBoundingBoxType
	ADD OBJECT Legs AS Collection && OF oh_RouteLegType
	ADD OBJECT PublicTransportLine AS Collection && OF oh_PublicTransportLineType
	ADD OBJECT PublicTransportTickets AS oh_PublicTransportTicketsType
	ADD OBJECT Notes AS Collection && OF oh_RouteNoteType
	ADD OBJECT Summary AS oh_RouteSummaryType
	ADD OBJECT SummaryByCountry AS Collection && OF oh_RouteSummaryByCountryType
	ADD OBJECT Generalizations AS Collection && OF oh_GeneralizationType
	ADD OBJECT ManeuverGroup AS Collection && OF oh_ManeuverGroupType
	ADD OBJECT Incident AS oh_IncidentType
	ADD OBJECT Label AS oh_StringType
	ADD OBJECT Zone AS oh_RoutingZoneType
	ADD OBJECT TimeDependentRestriction AS oh_TimeDependentRestrictionType

	Members = '<member type="oh_StringType" name="RouteId" />' + ;
					'<member type="collection:oh_WaypointType" name="Waypoints" element="Waypoint" />' + ;
					'<member type="oh_RoutingModeType" name="Mode" />' + ;
					'<member type="oh_GeoPolylineType" name="Shape" />' + ;
					'<member type="oh_GeoBoundingBoxType" name="BoundingBox" />' + ;
					'<member type="collection:oh_RouteLegType" name="Legs" element="Leg" />' + ;
					'<member type="collection:oh_PublicTransportLineType" name="PublicTransportLine" />' + ;
					'<member type="oh_PublicTransportTicketsType" name="PublicTransportTickets" />' + ;
					'<member type="collection:oh_RouteNoteType" name="Notes" element="Note" />' + ;
					'<member type="oh_RouteSummaryType" name="Summary" />' + ;
					'<member type="collection:oh_RouteSummaryByCountryType" name="SummaryByCountry" />' + ;
					'<member type="collection:oh_GeneralizationType" name="Generalizations" />' + ;
					'<member type="collection:oh_ManeuverGroupType" name="ManeuverGroup" />' + ;
					'<member type="oh_IncidentType" name="Incident" />' + ;
					'<member type="oh_StringType" name="Label" />' + ;
					'<member type="oh_RoutingZoneType" name="Zone" />' + ;
					'<member type="oh_TimeDependentRestrictionType" name="TimeDependentRestriction" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="routeid" type="property" display="RouteId" />' + ;
						'<memberdata name="waypoints" type="property" display="Waypoints" />' + ;
						'<memberdata name="mode" type="property" display="Mode" />' + ;
						'<memberdata name="shape" type="property" display="Shape" />' + ;
						'<memberdata name="boundingbox" type="property" display="BoundingBox" />' + ;
						'<memberdata name="legs" type="property" display="Legs" />' + ;
						'<memberdata name="publictransportline" type="property" display="PublicTransportLine" />' + ;
						'<memberdata name="publictransporttickets" type="property" display="PublicTransportTickets" />' + ;
						'<memberdata name="notes" type="property" display="Notes" />' + ;
						'<memberdata name="summary" type="property" display="Summary" />' + ;
						'<memberdata name="summarybycountry" type="property" display="SummaryByCountry" />' + ;
						'<memberdata name="generalizations" type="property" display="Generalizations" />' + ;
						'<memberdata name="maneuvergroup" type="property" display="ManeuverGroup" />' + ;
						'<memberdata name="incident" type="property" display="Incident" />' + ;
						'<memberdata name="label" type="property" display="Label" />' + ;
						'<memberdata name="zone" type="property" display="Zone" />' + ;
						'<memberdata name="timedependentrestriction" type="property" display="TimeDependentRestriction" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_WaypointType AS oh_Structure

	ADD OBJECT LinkId AS oh_LinkIdType
	ADD OBJECT MappedPosition AS oh_GeoCoordinateType
	ADD OBJECT OriginalPosition AS oh_GeoCoordinateType
	ADD OBJECT Type AS oh_WaypointTypeType
	ADD OBJECT Spot AS oh_DoubleType
	ADD OBJECT SideOfStreet AS oh_SideOfStreetType
	ADD OBJECT MappedRoadName AS oh_StringType
	ADD OBJECT Label AS oh_StringType
	ADD OBJECT UserLabel AS oh_StringType
	ADD OBJECT ShapeIndex AS oh_IntegerType

	Members = '<member type="oh_LinkIdType" name="LinkId" />' + ;
					'<member type="oh_GeoCoordinateType" name="MappedPosition" />' + ;
					'<member type="oh_GeoCoordinateType" name="OriginalPosition" />' + ;
					'<member type="oh_WaypointParameterTypeType" name="Type" />' + ;
					'<member type="oh_DoubleType" name="Spot" />' + ;
					'<member type="oh_SideOfStreetType" name="SideOfStreet" />' + ;
					'<member type="oh_StringType" name="MappedRoadName" />' + ;
					'<member type="oh_StringType" name="Label" />' + ;
					'<member type="oh_StringType" name="UserLabel" />' + ;
					'<member type="oh_IntegerType" name="ShapeIndex" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="linkid" type="property" display="LinkId" />' + ;
						'<memberdata name="mappedposition" type="property" display="MappedPosition" />' + ;
						'<memberdata name="originalposition" type="property" display="OriginalPosition" />' + ;
						'<memberdata name="type" type="property" display="Type" />' + ;
						'<memberdata name="spot" type="property" display="Spot" />' + ;
						'<memberdata name="sideofstreet" type="property" display="SideOfStreet" />' + ;
						'<memberdata name="mappedroadname" type="property" display="MappedRoadName" />' + ;
						'<memberdata name="label" type="property" display="Label" />' + ;
						'<memberdata name="userlabel" type="property" display="UserLabel" />' + ;
						'<memberdata name="shapeindex" type="property" display="ShapeIndex" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_RouteLegType AS oh_Structure

	ADD OBJECT Start AS oh_WaypointType
	ADD OBJECT End AS oh_WaypointType
	ADD OBJECT Length AS oh_DistanceType
	ADD OBJECT TravelTime AS oh_DurationType
	ADD OBJECT Maneuvers AS Collection && OF oh_ManeuverType
	ADD OBJECT Links AS oh_LinkIdsListType
	ADD OBJECT BoundingBox AS oh_GeoBoundingBoxType
	ADD OBJECT Shape AS oh_GeoPolylineType
	ADD OBJECT FirstPoint AS oh_IntegerType
	ADD OBJECT LastPoint AS oh_IntegerType
	ADD OBJECT TrafficTime AS oh_DurationType
	ADD OBJECT BaseTime AS oh_DurationType
	ADD OBJECT Summary AS oh_RouteSummaryType
	ADD OBJECT SubLegSummary AS oh_RouteSummaryType

	Members = '<member type="oh_WaypointType" name="Start" />' + ;
					'<member type="oh_WaypointType" name="End" />' + ;
					'<member type="oh_DistanceType" name="Length" />' + ;
					'<member type="oh_DurationType" name="TravelTime" />' + ;
					'<member type="collection:oh_ManeuverType" name="Maneuvers" element="Maneuver" />' + ;
					'<member type="oh_LinkIdsListType" name="Links" />' + ;
					'<member type="oh_GeoBoundingBoxType" name="BoundingBox" />' + ;
					'<member type="oh_GeoPolylineType" name="Shape" />' + ;
					'<member type="oh_IntegerType" name="FirstPoint" />' + ;
					'<member type="oh_IntegerType" name="LastPoint" />' + ;
					'<member type="oh_DurationType" name="TrafficTime" />' + ;
					'<member type="oh_DurationType" name="BaseTime" />' + ;
					'<member type="oh_RouteSummaryType" name="Summary" />' + ;
					'<member type="oh_RouteSummaryType" name="SubLegSummary" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="start" type="property" display="Start" />' + ;
						'<memberdata name="end" type="property" display="End" />' + ;
						'<memberdata name="length" type="property" display="Length" />' + ;
						'<memberdata name="traveltime" type="property" display="TravelTime" />' + ;
						'<memberdata name="maneuvers" type="property" display="Maneuvers" />' + ;
						'<memberdata name="links" type="property" display="Links" />' + ;
						'<memberdata name="boundingbox" type="property" display="BoundingBox" />' + ;
						'<memberdata name="shape" type="property" display="Shape" />' + ;
						'<memberdata name="firstpoint" type="property" display="FirstPoint" />' + ;
						'<memberdata name="lastpoint" type="property" display="LastPoint" />' + ;
						'<memberdata name="traffictime" type="property" display="TrafficTime" />' + ;
						'<memberdata name="basetime" type="property" display="BaseTime" />' + ;
						'<memberdata name="summary" type="property" display="Summary" />' + ;
						'<memberdata name="sublegsummary" type="property" display="SubLegSummary" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_ManeuverType AS oh_Structure

	ADD OBJECT id AS oh_StringType
	ADD OBJECT Position AS oh_GeoCoordinateType
	ADD OBJECT Instruction AS oh_StringType
	ADD OBJECT TravelTime AS oh_DurationType
	ADD OBJECT Length AS oh_DistanceType
	ADD OBJECT Shape AS oh_GeoPolylineType
	ADD OBJECT FirstPoint AS oh_IntegerType
	ADD OBJECT LastPoint AS oh_IntegerType
	ADD OBJECT Time AS oh_DatetimeType
	ADD OBJECT Note AS oh_RouteNoteType	
	ADD OBJECT NextManeuver AS oh_StringType
	ADD OBJECT ToLink AS oh_LinkIdType
	ADD OBJECT BoundingBox AS oh_GeoBoundingBoxType
	ADD OBJECT ShapeQuality AS oh_ShapeQualityType 

	Members = '<member type="attribute:oh_StringType" name="id" />' + ;
					'<member type="oh_GeoCoordinateType" name="Position" />' + ;
					'<member type="oh_StringType" name="Instruction" />' + ;
					'<member type="oh_DurationType" name="TravelTime" />' + ;
					'<member type="oh_DistanceType" name="Length" />' + ;
					'<member type="oh_GeoPolylineType" name="Shape" />' + ;
					'<member type="oh_IntegerType" name="FirstPoint" />' + ;
					'<member type="oh_IntegerType" name="LastPoint" />' + ;
					'<member type="oh_DatetimeType" name="Time" />' + ;
					'<member type="oh_RouteNoteType" name="Note" />' + ;
					'<member type="oh_StringType" name="NextManeuver" />' + ;
					'<member type="oh_LinkIdType" name="ToLink" />' + ;
					'<member type="oh_GeoBoundingBoxType" name="BoundingBox" />' + ;
					'<member type="oh_ShapeQualityType" name="ShapeQuality" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="id" type="property" display="ID" />' + ;
						'<memberdata name="position" type="property" display="Position" />' + ;
						'<memberdata name="instruction" type="property" display="Instruction" />' + ;
						'<memberdata name="length" type="property" display="Length" />' + ;
						'<memberdata name="traveltime" type="property" display="TravelTime" />' + ;
						'<memberdata name="shape" type="property" display="Shape" />' + ;
						'<memberdata name="firstpoint" type="property" display="FirstPoint" />' + ;
						'<memberdata name="lastpoint" type="property" display="LastPoint" />' + ;
						'<memberdata name="time" type="property" display="Time" />' + ;
						'<memberdata name="note" type="property" display="Note" />' + ;
						'<memberdata name="nextmaneuver" type="property" display="NextManeuver" />' + ;
						'<memberdata name="tolink" type="property" display="ToLink" />' + ;
						'<memberdata name="boundingbox" type="property" display="BoundingBox" />' + ;
						'<memberdata name="shapequality" type="property" display="ShapeQuality" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_ManeuverGroupType AS oh_Structure

	ADD OBJECT firstmaneuver AS oh_StringType
	ADD OBJECT lastmaneuver AS oh_StringType
	ADD OBJECT mode AS oh_RoutingModeType
	ADD OBJECT summaryDescription AS oh_StringType
	ADD OBJECT arrivalDescription AS oh_StringType
	ADD OBJECT waitDescription AS oh_StringType
	ADD OBJECT publicTransportType AS oh_PublicTransportTypeType

	Members = '<member type="oh_StringType" name="firstmaneuver" />' + ;
					'<member type="oh_StringType" name="lastmaneuver" />' + ;
					'<member type="oh_RoutingModeType" name="mode" />' + ;
					'<member type="oh_StringType" name="summaryDescription" />' + ;
					'<member type="oh_StringType" name="arrivalDescription" />' + ;
					'<member type="oh_StringType" name="waitDescription" />' + ;
					'<member type="oh_PublicTransportTypeType" name="publicTransportType" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="firstmaneuver" type="property" display="firstmaneuver" />' + ;
						'<memberdata name="lastmaneuver" type="property" display="lastmaneuver" />' + ;
						'<memberdata name="mode" type="property" display="mode" />' + ;
						'<memberdata name="summarydescription" type="property" display="summaryDescription" />' + ;
						'<memberdata name="arrivaldescription" type="property" display="arrivalDescription" />' + ;
						'<memberdata name="waitdescription" type="property" display="waitDescription" />' + ;
						'<memberdata name="publictransporttype" type="property" display="publicTransportType" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_IncidentType AS oh_Structure

	ADD OBJECT ValidityPeriod AS oh_StringType
	ADD OBJECT Text AS oh_StringType
	ADD OBJECT Type AS oh_IncidentTypeType
	ADD OBJECT Criticality AS oh_IntegerType
	ADD OBJECT FirstPoint AS oh_IntegerType
	ADD OBJECT LastPoint AS oh_IntegerType

	Members = '<member type="oh_StringType" name="ValidityPeriod" />' + ;
					'<member type="oh_StringType" name="Text" />' + ;
					'<member type="oh_IncidentTypeType" name="Type" />' + ;
					'<member type="oh_IntegerType" name="Criticality" />' + ;
					'<member type="oh_IntegerType" name="FirstPoint" />' + ;
					'<member type="oh_IntegerType" name="LastPoint" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="validityperiod" type="property" display="ValidityPeriod" />' + ;
						'<memberdata name="text" type="property" display="Text" />' + ;
						'<memberdata name="type" type="property" display="Type" />' + ;
						'<memberdata name="criticality" type="property" display="Criticality" />' + ;
						'<memberdata name="firstpoint" type="property" display="FirstPoint" />' + ;
						'<memberdata name="lastpoint" type="property" display="LastPoint" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_RouteSummaryType AS oh_Structure

	ADD OBJECT Distance AS oh_DistanceType
	ADD OBJECT TrafficTime AS oh_DurationType
	ADD OBJECT BaseTime AS oh_DurationType
	ADD OBJECT Flags AS Collection && OF oh_RouteLinkFlagType
	ADD OBJECT TravelTime AS oh_DurationType
	ADD OBJECT Text AS oh_StringType
	ADD OBJECT Co2Emission AS oh_DoubleType

	Members = '<member type="oh_DistanceType" name="Distance" />' + ;
					'<member type="oh_DurationType" name="TrafficTime" />' + ;
					'<member type="oh_DurationType" name="BaseTime" />' + ;
					'<member type="collection:oh_RouteLinkFlagType" name="Flags" />' + ;
					'<member type="oh_DurationType" name="TravelTime" />' + ;
					'<member type="oh_StringType" name="Text" />' + ;
					'<member type="oh_DoubleType" name="Co2Emission" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="distance" type="property" display="Distance" />' + ;
						'<memberdata name="traffictime" type="property" display="TrafficTime" />' + ;
						'<memberdata name="basetime" type="property" display="BaseTime" />' + ;
						'<memberdata name="flags" type="property" display="Flags" />' + ;
						'<memberdata name="traveltime" type="property" display="TravelTime" />' + ;
						'<memberdata name="text" type="property" display="Text" />' + ;
						'<memberdata name="co2emission" type="property" display="Co2Emission" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_RouteNoteType AS oh_Structure

	ADD OBJECT Type AS oh_RouteNoteTypeType
	ADD OBJECT Code AS oh_RouteNoteCodeType
	ADD OBJECT Text AS oh_StringType
	ADD OBJECT AdditionalData AS Collection && KEY OF oh_StringType
	ADD OBJECT CountryChangeDetails AS oh_CountryChangeDetailsType

	Members = '<member type="oh_RouteNoteTypeType" name="Type" />' + ;
					'<member type="oh_RouteNoteCodeType" name="Code" />' + ;
					'<member type="oh_StringType" name="Text" />' + ;
					'<member type="keys:oh_StringType" name="AdditionalData" key="@key" />' + ;
					'<member type="oh_CountryChangeDetailsType" name="CountryChangeDetails" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="type" type="property" display="Type" />' + ;
						'<memberdata name="code" type="property" display="Code" />' + ;
						'<memberdata name="text" type="property" display="Text" />' + ;
						'<memberdata name="additionaldata" type="property" display="AdditionalData" />' + ;
						'<memberdata name="countrychangedetails" type="property" display="CountryChangeDetails" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_CountryChangeDetailsType AS oh_Structure

	ADD OBJECT ToCountry AS oh_StringType

	Members = '<member type="oh_StringType" name="ToCountry" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="tocountry" type="property" display="ToCountry" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_PublicTransportTicketsType AS oh_Structure

	ADD OBJECT ID AS oh_StringType
	ADD OBJECT PublicTransportTickets AS Collection && OF oh_PublicTransportTicketType

	Members = '<member type="oh_StringType" name="ID" />' + ;
					'<member type="collection:oh_PublicTransportTicketType" name="PublicTransportTickets" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="id" type="property" display="ID" />' + ;
						'<memberdata name="publictransporttickets" type="property" display="PublicTransportTickets" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_PublicTransportTicketType AS oh_Structure

	ADD OBJECT ID AS oh_StringType
	ADD OBJECT TicketName AS oh_StringType
	ADD OBJECT Currency AS oh_CurrencyType
	ADD OBJECT Price AS oh_DoubleType

	Members = '<member type="oh_StringType" name="ID" />' + ;
					'<member type="oh_StringType" name="TicketName" />' + ;
					'<member type="oh_CurrencyType" name="Currency" />' + ;
					'<member type="oh_DoubleType" name="Price" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="id" type="property" display="ID" />' + ;
						'<memberdata name="ticketname" type="property" display="TicketName" />' + ;
						'<memberdata name="currency" type="property" display="Currency" />' + ;
						'<memberdata name="price" type="property" display="Price" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_RoutingZoneType AS oh_Structure

	ADD OBJECT Id AS oh_DoubleType
	ADD OBJECT ZoneName AS oh_StringType && element = Name
	ADD OBJECT Type AS oh_RoutingZoneTypeType
	ADD OBJECT ShapeIndices AS Collection && OF oh_RouteShapeReferenceType
	ADD OBJECT Restriction AS Collection && OF oh_VehicleRestrictionType

	Members = '<member type="oh_DoubleType" name="Id" />' + ;
					'<member type="oh_StringType" name="ZoneName" element="Name" />' + ;
					'<member type="oh_RoutingZoneTypeType" name="Type" />' + ;
					'<member type="collection:oh_RouteShapeReferenceType" name="ShapeIndices" />' + ;
					'<member type="collection:oh_VehicleRestrictionType" name="Restriction" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="id" type="property" display="Id" />' + ;
						'<memberdata name="zonename" type="property" display="ZoneName" />' + ;
						'<memberdata name="type" type="property" display="Type" />' + ;
						'<memberdata name="shapeindices" type="property" display="ShapeIndices" />' + ;
						'<memberdata name="restriction" type="property" display="Restriction" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_RouteShapeReferenceType AS oh_Structure

	ADD OBJECT FirstPoint AS oh_IntegerType
	ADD OBJECT LastPoint AS oh_IntegerType

	Members = '<member type="oh_IntegerType" name="FirstPoint" />' + ;
					'<member type="oh_IntegerType" name="LastPoint" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="firstpoint" type="property" display="FirstPoint" />' + ;
						'<memberdata name="lastpoint" type="property" display="LastPoint" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_VehicleRestrictionType AS oh_Structure

	ADD OBJECT ValidityPeriod AS oh_RecurringTimeIntervalsCombinationType
	ADD OBJECT LicensePlatePattern AS oh_LicensePlatePatternType

	Members = '<member type="oh_RecurringTimeIntervalsCombinationType" name="ValidityPeriod" />' + ;
					'<member type="oh_LicensePlatePatternType" name="LicensePlatePattern" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="validityperiod" type="property" display="ValidityPeriod" />' + ;
						'<memberdata name="licenseplatepattern" type="property" display="LicensePlatePattern" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_TimeDependentRestrictionType AS oh_Structure

	ADD OBJECT ValidityPeriod AS oh_StringType
	ADD OBJECT Type AS oh_TimeDependentRestrictionTypeType

	Members = '<member type="oh_StringType" name="ValidityPeriod" />' + ;
					'<member type="oh_TimeDependentRestrictionTypeType" name="Type" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="validityperiod" type="property" display="ValidityPeriod" />' + ;
						'<memberdata name="type" type="property" display="Type" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_GeneralizationType AS oh_Structure

	ADD OBJECT Tolerance AS oh_DoubleType
	ADD OBJECT Index AS oh_IntegerType

	Members = '<member type="oh_DoubleType" name="Tolerance" />' + ;
					'<member type="oh_IntegerType" name="Index" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="tolerance" type="property" display="Tolerance" />' + ;
						'<memberdata name="index" type="property" display="Index" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_SourceAttributionType AS oh_Structure

	ADD OBJECT Attribution AS oh_StringType
	ADD OBJECT SourceSupplier AS oh_SourceSupplierType

	Members = '<member type="oh_StringType" name="Attribution" />' + ;
					'<member type="oh_SourceSupplierType" name="SourceSupplier" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="attribution" type="property" display="Attribution" />' + ;
						'<memberdata name="sourcesupplier" type="property" display="SourceSupplier" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_SourceSupplierType AS oh_Structure

	ADD OBJECT Title AS oh_StringType
	ADD OBJECT Href AS oh_StringType
	ADD OBJECT Note AS oh_SourceSupplierNoteType

	Members = '<member type="oh_StringType" name="Title" />' + ;
					'<member type="oh_StringType" name="Href" />' + ;
					'<member type="oh_SourceSupplierNoteType" name="Note" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="title" type="property" display="Title" />' + ;
						'<memberdata name="href" type="property" display="Href" />' + ;
						'<memberdata name="note" type="property" display="Note" />' + ;
						'</VFPData>'

ENDDEFINE

DEFINE CLASS oh_SourceSupplierNoteType AS oh_Structure

	ADD OBJECT Type AS oh_SourceSupplierNoteTypeType
	ADD OBJECT Text AS oh_StringType
	ADD OBJECT Href AS oh_StringType
	ADD OBJECT HrefText AS oh_StringType

	Members = '<member type="oh_SupplierNoteTypeType" name="Type" />' + ;
					'<member type="oh_StringType" name="Text" />' + ;
					'<member type="oh_StringType" name="Href" />' + ;
					'<member type="oh_StringType" name="HrefText" />'

	_MemberData = '<VFPData>' + ;
						'<memberdata name="type" type="property" display="Type" />' + ;
						'<memberdata name="text" type="property" display="Text" />' + ;
						'<memberdata name="href" type="property" display="Href" />' + ;
						'<memberdata name="hreftext" type="property" display="HrefText" />' + ;
						'</VFPData>'

ENDDEFINE
