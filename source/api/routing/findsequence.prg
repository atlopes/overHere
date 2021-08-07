**************************************************************
*
* overHere / routing / findsequence
*
**************************************************************

IF !SYS(16) $ SET("Procedure")
	SET PROCEDURE TO (SYS(16)) ADDITIVE
ENDIF

DO (ADDBS(JUSTPATH(SYS(16))) + "fleet.prg")

#DEFINE SAFETHIS			ASSERT !USED("This") AND TYPE("This") == "O"

DEFINE CLASS oh_FindSequence AS oh_FleetTelematicsResource

	ResourceName = "findsequence2"
	PostQueryString = .T.

	* itinerary definition
	ADD OBJECT Mode AS oh_RoutingModeType
	ADD OBJECT ImproveFor AS oh_ImproveForType
	ADD OBJECT Start AS oh_WaypointWithIdType
	ADD OBJECT Destinations AS Collection && OF oh_WaypointWithIdType
	ADD OBJECT End AS oh_WaypointWithIdType

	* metainformation
	ADD OBJECT RequestId AS oh_StringType

	* general constraints
	ADD OBJECT AvoidAreas AS oh_GeoBoundingBoxArrayType
	ADD OBJECT AvoidLinks AS oh_LinkIdsListType

	* date and time settings
	ADD OBJECT Departure AS oh_DatetimeType
	ADD OBJECT RestTimes AS oh_DrivingRestTimeType

	* truck settings
	ADD OBJECT TruckType AS oh_TruckTypeType
	ADD OBJECT HazardousGoods AS oh_ValuesListType WITH ValuesClass = "oh_HazardousGoodsTypeType"
	ADD OBJECT LimitedWeight AS oh_IntegerType WITH Minimum = 0, Maximum = 1000
	ADD OBJECT WeightPerAxle AS oh_IntegerType WITH Minimum = 0, Maximum = 1000
	ADD OBJECT TruckHeight AS oh_IntegerType WITH Minimum = 0, Maximum = 50
	ADD OBJECT TruckWidth AS oh_IntegerType WITH Minimum = 0, Maximum = 50
	ADD OBJECT TruckLength AS oh_IntegerType WITH Minimum = 0, Maximum = 300
	ADD OBJECT TunnelCategory AS oh_TunnelCategoryType

	* public transport / pedestrian settings
	ADD OBJECT WalkSpeed AS oh_DoubleType WITH Minimum = 0.5, Maximum = 2

	* response object
	ADD OBJECT Response AS oh_ResponseJSON

	Sequence = .NULL.

	_MemberData = '<VFPData>' + ;
						'<memberdata name="mode" type="property" display="Mode" />' + ;
						'<memberdata name="improvefor" type="property" display="ImproveFor" />' + ;
						'<memberdata name="start" type="property" display="Start" />' + ;
						'<memberdata name="destinations" type="property" display="Destinations" />' + ;
						'<memberdata name="end" type="property" display="End" />' + ;
						'<memberdata name="requestid" type="property" display="RequestId" />' + ;
						'<memberdata name="avoidareas" type="property" display="AvoidAreas" />' + ;
						'<memberdata name="avoidlinks" type="property" display="AvoidLinks" />' + ;
						'<memberdata name="departure" type="property" display="Departure" />' + ;
						'<memberdata name="resttimes" type="property" display="RestTimes" />' + ;
						'<memberdata name="trucktype" type="property" display="TruckType" />' + ;
						'<memberdata name="hazardousgoods" type="property" display="HazardousGoods" />' + ;
						'<memberdata name="limitedweight" type="property" display="LimitedWeight" />' + ;
						'<memberdata name="weightperaxle" type="property" display="WeightPerAxle" />' + ;
						'<memberdata name="truckheight" type="property" display="TruckHeight" />' + ;
						'<memberdata name="truckwidth" type="property" display="TruckWidth" />' + ;
						'<memberdata name="trucklength" type="property" display="TruckLength" />' + ;
						'<memberdata name="tunnelcategory" type="property" display="TunnelCategory" />' + ;
						'<memberdata name="walkspeed" type="property" display="WalkSpeed" />' + ;
						'<memberdata name="response" type="property" display="Response" />' + ;
						'<memberdata name="sequence" type="property" display="Sequence" />' + ;
						'<memberdata name="find" type="method" display="Find" />' + ;
						'</VFPData>'

	FUNCTION Find (Request AS Logical) AS oh_FindWaypointsResponseType

		SAFETHIS

		IF !m.Request OR This.Request()
			RETURN This.Sequence
		ELSE
			RETURN .NULL.
		ENDIF

	ENDFUNC

	FUNCTION Request () AS Logical

		SAFETHIS

		LOCAL XML AS MSXML2.DOMDocument60

		This.PrepareRequest()

		IF This.Call()
			m.XML = This.Response.ToXML("" + This.ServerResponse, "FindSequence")
			IF !ISNULL(m.XML)
				This.Sequence = This.Response.Read(m.XML.selectNodes("/FindSequence").item(0), CREATEOBJECT("oh_FindWaypointsResponseType"))
			ENDIF
		ENDIF

		RETURN !ISNULL(This.Sequence)

	ENDFUNC

	PROCEDURE PrepareRequest ()

		SAFETHIS

		LOCAL WP AS oh_WaypointWithIdType
		LOCAL ItemIndex AS Integer

		This.Sequence = .NULL.

		This.PrepareQueryString()

		This.AddObjArgument("mode", This.Mode)
		This.AddObjArgument("improveFor", This.ImproveFor)

		This.AddObjArgument("requestId", This.RequestId)

		This.AddObjArgument("start", This.Start)

		m.ItemIndex = 0
		FOR EACH m.WP IN This.Destinations
			IF This.AddObjArgument("destination" + LTRIM(STR(m.ItemIndex)), m.WP, .T.)
				m.ItemIndex = m.ItemIndex + 1
			ENDIF
		ENDFOR

		This.AddObjArgument("end", This.End)

		This.AddObjArgument("avoidareas", This.AvoidAreas)
		This.AddObjArgument("avoidlinks", This.AvoidLinks)

		This.AddObjArgument("departure", This.Departure)
		This.AddObjArgument("restTimes", This.RestTimes)

		This.AddObjArgument("trucktype", This.TruckType)
		This.AddObjArgument("shippedhazardousgoods", This.HazardousGoods)
		This.AddObjArgument("limitedweight", This.LimitedWeight)
		This.AddObjArgument("weightperaxle", This.WeightPerAxle)
		This.AddObjArgument("height", This.TruckHeight)
		This.AddObjArgument("width", This.TruckWidth)
		This.AddObjArgument("length", This.TruckLength)
		This.AddObjArgument("tunnelcategory", This.TunnelCategory)

		This.AddObjArgument("walkspeed", This.WalkSpeed)

	ENDPROC

ENDDEFINE