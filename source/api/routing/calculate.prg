**************************************************************
*
* overHere / routing / calculate
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "route.prg")

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_CalculateRoute AS oh_RouteResource

	ResourceName = "calculateroute.xml"

	* itinerary definition
	ADD OBJECT Mode AS oh_RoutingModeType
	ADD OBJECT Waypoints AS Collection && OF oh_WaypointParameterType
	ADD OBJECT Alternatives AS oh_IntegerType

	* metainformation
	ADD OBJECT RequestId AS oh_StringType

	* general constraints
	ADD OBJECT AvoidAreas AS oh_GeoBoundingBoxArrayType
	ADD OBJECT AvoidLinks AS oh_LinkIdsListType
	ADD OBJECT AvoidSeasonalClosures AS oh_BooleanType
	ADD OBJECT AvoidTurns AS oh_ValuesListType WITH ValuesClass = "oh_TurnTypeType"
	ADD OBJECT ExcludeZoneTypes AS oh_ValuesListType WITH ValuesClass = "oh_RoutingZoneTypeType"
	ADD OBJECT ExcludeCountries AS oh_ValuesListType WITH ValuesClass = "oh_CountryCodeType"

	* data settings
	ADD OBJECT Departure AS oh_DatetimeType
	ADD OBJECT Arrival AS oh_DatetimeType

	* vehicle characteristics
	ADD OBJECT Vehicle AS oh_VehicleType

	* truck settings
	ADD OBJECT TruckType AS oh_TruckTypeType
	ADD OBJECT TrailersCount AS oh_IntegerType WITH Minimum = 0, Maximum = 4
	ADD OBJECT HazardousGoods AS oh_ValuesListType WITH ValuesClass = "oh_HazardousGoodsTypeType"
	ADD OBJECT LimitedWeight AS oh_IntegerType WITH Minimum = 0, Maximum = 1000
	ADD OBJECT WeightPerAxle AS oh_IntegerType WITH Minimum = 0, Maximum = 1000
	ADD OBJECT TruckHeight AS oh_IntegerType WITH Minimum = 0, Maximum = 50
	ADD OBJECT TruckWidth AS oh_IntegerType WITH Minimum = 0, Maximum = 50
	ADD OBJECT TruckLength AS oh_IntegerType WITH Minimum = 0, Maximum = 300
	ADD OBJECT TunnelCategory AS oh_TunnelCategoryType
	ADD OBJECT TruckRestrictionPenalty AS oh_TruckRestrictionPenaltyType

	* public transport / pedestrian settings
	ADD OBJECT WalkSpeed AS oh_DoubleType WITH Minimum = 0.5, Maximum = 2
	ADD OBJECT WalkTimeMultiplier AS oh_DoubleType WITH Minimum = 0.01, Maximum = 100
	ADD OBJECT AvoidTransportTypes AS oh_ValuesListType WITH ValuesClass = "oh_PublicTransportTypeType"
	ADD OBJECT MaxNumberOfChanges AS oh_IntegerType WITH Minimum = 0, Maximum = 10
	ADD OBJECT WalkRadius AS oh_IntegerType WITH Minimum = 0, Maximum = 6000
	ADD OBJECT CombineChange AS oh_BooleanType

	* response configuration
	ADD OBJECT Language AS oh_LanguageCodeType
	ADD OBJECT Representation AS oh_RouteRepresentationOptionsType
	ADD OBJECT InstructionFormat AS oh_InstructionFormatType
	ADD OBJECT RouteAttrib AS oh_ValuesListType WITH ValuesClass = "oh_RouteAttributeType"
	ADD OBJECT LegAttrib AS oh_ValuesListType WITH ValuesClass = "oh_RouteLegAttributeType"
	ADD OBJECT ManeuverAttrib AS oh_ValuesListType WITH ValuesClass = "oh_ManeuverAttributeType"
	ADD OBJECT LineAttrib AS oh_ValuesListType WITH ValuesClass = "oh_PublicTransportLineAttributeType"
	ADD OBJECT MetricSystem AS oh_MetricSystemType
	ADD OBJECT ViewBounds AS oh_GeoBoundingBoxType
	ADD OBJECT ReturnElevation AS oh_BooleanType
	ADD OBJECT SpeedProfile AS oh_SpeedProfileType

	* response object
	ADD OBJECT Response AS oh_Response

	Route = .NULL.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="mode" type="property" display="Mode" />' + ;
						'<memberdata name="waypoints" type="property" display="Waypoints" />' + ;
						'<memberdata name="alternatives" type="property" display="Alternatives" />' + ;
						'<memberdata name="requestid" type="property" display="RequestId" />' + ;
						'<memberdata name="avoidareas" type="property" display="AvoidAreas" />' + ;
						'<memberdata name="avoidlinks" type="property" display="AvoidLinks" />' + ;
						'<memberdata name="avoidseasonalclosures" type="property" display="AvoidSeasonalClosures" />' + ;
						'<memberdata name="avoidturns" type="property" display="AvoidTurns" />' + ;
						'<memberdata name="excludezonetypes" type="property" display="ExcludeZoneTypes" />' + ;
						'<memberdata name="excludecountries" type="property" display="ExcludeCountries" />' + ;
						'<memberdata name="departure" type="property" display="Departure" />' + ;
						'<memberdata name="arrival" type="property" display="Arrival" />' + ;
						'<memberdata name="vehicle" type="property" display="Vehicle" />' + ;
						'<memberdata name="trucktype" type="property" display="TruckType" />' + ;
						'<memberdata name="trailerscount" type="property" display="TrailersCount" />' + ;
						'<memberdata name="hazardousgoods" type="property" display="HazardousGoods" />' + ;
						'<memberdata name="limitedweight" type="property" display="LimitedWeight" />' + ;
						'<memberdata name="weightperaxle" type="property" display="WeightPerAxle" />' + ;
						'<memberdata name="truckheight" type="property" display="TruckHeight" />' + ;
						'<memberdata name="truckwidth" type="property" display="TruckWidth" />' + ;
						'<memberdata name="trucklength" type="property" display="TruckLength" />' + ;
						'<memberdata name="tunnelcategory" type="property" display="TunnelCategory" />' + ;
						'<memberdata name="truckrestrictionpenalty" type="property" display="TruckRestrictionPenalty" />' + ;
						'<memberdata name="walkspeed" type="property" display="WalkSpeed" />' + ;
						'<memberdata name="walktimemultiplier" type="property" display="WalkTimeMultiplier" />' + ;
						'<memberdata name="avoidtransporttypes" type="property" display="AvoidTransportTypes" />' + ;
						'<memberdata name="maxnumberofchanges" type="property" display="MaxNumberOfChanges" />' + ;
						'<memberdata name="walkradius" type="property" display="WalkRadius" />' + ;
						'<memberdata name="combinechange" type="property" display="CombineChange" />' + ;
						'<memberdata name="language" type="property" display="Language" />' + ;
						'<memberdata name="representation" type="property" display="Representation" />' + ;
						'<memberdata name="instructionformat" type="property" display="InstructionFormat" />' + ;
						'<memberdata name="routeattrib" type="property" display="RouteAttrib" />' + ;
						'<memberdata name="legattrib" type="property" display="LegAttrib" />' + ;
						'<memberdata name="maneuverattrib" type="property" display="ManeuverAttrib" />' + ;
						'<memberdata name="lineattrib" type="property" display="LineAttrib" />' + ;
						'<memberdata name="metricsystem" type="property" display="MetricSystem" />' + ;
						'<memberdata name="viewbounds" type="property" display="ViewBounds" />' + ;
						'<memberdata name="returnelevation" type="property" display="ReturnElevation" />' + ;
						'<memberdata name="speedprofile" type="property" display="SpeedProfile" />' + ;
						'<memberdata name="response" type="property" display="Response" />' + ;
						'<memberdata name="route" type="property" display="Route" />' + ;
						'<memberdata name="calculate" type="method" display="Calculate" />' + ;
						'</VFPData>'

	FUNCTION Calculate (Request AS Logical) AS oh_CalculateRouteResponseType

		SAFETHIS

		IF !m.Request OR This.Request()
			RETURN This.Route
		ELSE
			RETURN .NULL.
		ENDIF

	ENDFUNC

	FUNCTION Request () AS Logical

		SAFETHIS

		This.PrepareRequest()

		IF This.Call()
			This.Route = This.Response.Read(This.ServerXMLResponse.selectNodes("//Response").item(0), CREATEOBJECT("oh_CalculateRouteResponseType"))
		ENDIF

		RETURN !ISNULL(This.Route)

	ENDFUNC

	PROCEDURE PrepareRequest ()

		SAFETHIS

		LOCAL WP AS oh_WaypointParameterType
		LOCAL ItemIndex AS Integer
		LOCAL TransportMode AS String

		This.Route = .NULL.

		This.PrepareQueryString()

		This.AddObjArgument("mode", This.Mode)
		m.TransportMode = This.Mode.TransportMode.Get()
		This.AddObjArgument("alternatives", This.Alternatives)

		This.AddObjArgument("requestId", This.RequestId)

		m.ItemIndex = 0
		FOR EACH m.WP IN This.Waypoints
			IF This.AddObjArgument("waypoint" + LTRIM(STR(m.ItemIndex, 10, 0)), m.WP, .T.)
				m.ItemIndex = m.ItemIndex + 1
			ENDIF
		ENDFOR

		This.AddObjArgument("avoidareas", This.AvoidAreas)
		This.AddObjArgument("avoidlinks", This.AvoidLinks)
		This.AddObjArgument("avoidseasonalclosures", This.AvoidSeasonalClosures)
		This.AddObjArgument("avoidturns", This.AvoidTurns)
		This.AddObjArgument("excludezonetypes", This.ExcludeZoneTypes)
		This.AddObjArgument("excludecountries", This.ExcludeCountries)

		IF !This.AddObjArgument("departure", This.Departure)
			IF m.TransportMode == "publicTransportTimetable"
				This.AddObjArgument("arrival", This.Arrival)
			ENDIF
		ENDIF

		This.AddObjArgument("vehicle", This.Vehicle)

		IF m.TransportMode == "truck"
			This.AddObjArgument("trucktype", This.TruckType)
			This.AddObjArgument("trailerscount", This.TrailersCount)
			This.AddObjArgument("shippedhazardousgoods", This.HazardousGoods)
			This.AddObjArgument("limitedweight", This.LimitedWeight)
			This.AddObjArgument("weightperaxle", This.WeightPerAxle)
			This.AddObjArgument("height", This.TruckHeight)
			This.AddObjArgument("width", This.TruckWidth)
			This.AddObjArgument("length", This.TruckLength)
			This.AddObjArgument("tunnelcategory", This.TunnelCategory)
			This.AddObjArgument("truckrestrictionpenalty", This.TruckRestrictionPenalty)
		ENDIF

		This.AddObjArgument("walkspeed", This.WalkSpeed)
		IF m.TransportMode $ "publicTransport"
			This.AddObjArgument("walktimemultiplier", This.WalkTimeMultiplier)
			This.AddObjArgument("avoidtransporttypes", This.AvoidTransportTypes)
			This.AddObjArgument("maxnumberofchanges", This.MaxNumberOfChanges)
			This.AddObjArgument("walkradius", This.WalkRadius)
			This.AddObjArgument("combinechange", This.CombineChange)
		ENDIF

		This.AddObjArgument("language", This.Language)
		This.AddObjArgument("representation", This.Representation)
		This.AddObjArgument("instructionFormat", This.InstructionFormat)
		This.AddObjArgument("routeattributes", This.RouteAttrib)
		This.AddObjArgument("legattributes", This.LegAttrib)
		This.AddObjArgument("maneuverattributes", This.ManeuverAttrib)
		This.AddObjArgument("lineattributes", This.LineAttrib)
		This.AddObjArgument("metricsystem", This.MetricSystem)
		This.AddObjArgument("viewbounds", This.ViewBounds)
		This.AddObjArgument("returnelevation", This.ReturnElevation)
		This.AddObjArgument("returnelevation", This.SpeedProfile)

	ENDPROC

ENDDEFINE