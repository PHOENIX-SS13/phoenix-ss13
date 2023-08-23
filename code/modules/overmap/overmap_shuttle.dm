/datum/overmap_object/shuttle
	name = "Shuttle"
	visual_type = /obj/effect/abstract/overmap/shuttle
	overmap_process = TRUE
	is_overmap_controllable = TRUE

	var/obj/docking_port/mobile/my_shuttle
	var/obj/machinery/computer/shuttle/my_console
	var/datum/transit_instance/transit_instance
	var/angle = 0

	var/velocity_x = 0
	var/velocity_y = 0

	var/impulse_power = 1

	var/helm_command = HELM_IDLE
	var/destination_x = 0
	var/destination_y = 0

	var/last_checked_vlevels = list()
	var/last_check_x = 0
	var/last_check_y = 0

	/// Otherwise it's abstract and it doesnt have a physical shuttle in transit, or people in it. Maintain this for the purposes of AI raid ships
	var/is_physical = TRUE

	/// If true then it doesn't have a "shuttle" and is not alocated in transit and cannot dock anywhere, but things may dock into it
	var/is_seperate_z_level = FALSE //(This can mean it's several z levels too)

	/// For sensors lock follow
	var/follow_range = 1

	var/shuttle_ui_tab = SHUTTLE_TAB_GENERAL

	/// At which offset range the helm pad will apply at
	var/helm_pad_range = 3
	/// If true, then the applied offsets will be relative to the ship position, instead of direction position
	var/helm_pad_relative_destination = TRUE

	var/helm_pad_engage_immediately = TRUE

	var/open_comms_channel = FALSE
	var/microphone_muted = FALSE

	var/datum/overmap_lock/lock

	var/target_command = TARGET_IDLE

	var/scan_text = ""
	var/scan_id = 0

	var/datum/overmap_shuttle_controller/shuttle_controller
	var/uses_rotation = TRUE
	var/fixed_parallax_dir
	var/shuttle_capability = ALL_SHUTTLE_CAPABILITY

	//Extensions
	var/list/all_extensions = list()
	var/list/engine_extensions = list()
	var/list/shield_extensions = list()
	var/list/transporter_extensions = list()
	var/list/weapon_extensions = list()

	var/speed_divisor_from_mass = 1

	//Turf to which you need access range to access in order to do topics (this is done in this way so I dont need to keep track of consoles being in use)
	var/turf/control_turf

	var/last_shield_change_state = 0

	var/current_parallax_dir = 0

/datum/overmap_object/shuttle/proc/GetSensorTargets()
	var/list/targets = list()
	for(var/ov_obj in current_system.GetObjectsInRadius(x,y,SENSOR_RADIUS))
		var/datum/overmap_object/overmap_object = ov_obj
		if(overmap_object != src && overmap_object.overmap_flags & OV_SHOWS_ON_SENSORS)
			targets += overmap_object
	return targets

/datum/overmap_object/shuttle/proc/GetCapSpeed()
	var/cap_speed = 0
	for(var/i in engine_extensions)
		var/datum/shuttle_extension/engine/ext = i
		if(!ext.CanOperate())
			continue
		cap_speed += ext.GetCapSpeed(impulse_power)
	return cap_speed / speed_divisor_from_mass

/datum/overmap_object/shuttle/proc/DrawThrustFromAllEngines()
	var/draw_thrust = 0
	for(var/i in engine_extensions)
		var/datum/shuttle_extension/engine/ext = i
		if(!ext.CanOperate())
			continue
		draw_thrust += ext.DrawThrust(impulse_power)
	return draw_thrust / speed_divisor_from_mass

/datum/overmap_object/shuttle/ui_state(mob/user)
	return GLOB.not_incapacitated_state

/datum/overmap_object/shuttle/proc/set_my_console(obj/console)
	var/obj/machinery/computer/shuttle/cons = console
	my_console = cons

/datum/overmap_object/shuttle/proc/GetNearbyLevels()
	if(x == last_check_x && y == last_check_y)
		return last_checked_vlevels
	var/list/virtual_levels = list()
	var/list/nearby_objects = current_system.GetObjectsOnCoords(x,y)
	for(var/datum/overmap_object/IO as anything in nearby_objects)
		if(!IO.can_be_docked)
			continue
		if(IO.related_map_zone)
			for(var/datum/virtual_level/vlevel in IO.related_map_zone.virtual_levels)
				virtual_levels |= vlevel
	last_check_x = x
	last_check_y = y
	last_checked_vlevels = virtual_levels
	return virtual_levels

/datum/overmap_object/shuttle/proc/GetDocksInLevels()
	var/list/vlevels = GetNearbyLevels()
	var/list/obj/docking_port/stationary/docks = list()
	//var/list/options = params2list(my_shuttle.possible_destinations)
	for(var/i in SSshuttle.stationary)
		var/obj/docking_port/stationary/iterated_dock = i
		var/datum/virtual_level/level = iterated_dock.get_virtual_level()
		if(!(level in vlevels))
			continue
		//if(!options.Find(iterated_dock.port_destinations))
		//	continue
		if(!my_shuttle.check_dock(iterated_dock, silent = TRUE))
			continue
		docks += iterated_dock
	return docks

/datum/overmap_object/shuttle/ui_static_data(mob/user)
	var/list/data = list()
	// SENSORS
	data["sensorTargets"] = list()
	var/list/targets = GetSensorTargets()
	for(var/ov_obj in targets)
		var/datum/overmap_object/cast = ov_obj
		var/list/objdata = list(
			name = cast.name,
			x = cast.x,
			y = cast.y,
			dist = FLOOR(TWO_POINT_DISTANCE(x,y,cast.x,cast.y),1),
			id = cast.id
		)
		data["sensorTargets"] += list(objdata)
	// DOCK
	data["freeformDocks"] = list()
	var/list/vlevels = GetNearbyLevels()
	for(var/lvl in vlevels)
		var/datum/virtual_level/vlevel = lvl
		var/list/vleveldata = list(
			name = vlevel.name,
			mapId = vlevel.parent_map_zone.id,
			vlevelId = vlevel.id
		)
		data["freeformDocks"] += list(vleveldata)

	data["docks"] = list()
	var/list/docks = GetDocksInLevels()
	for(var/dockvar in docks)
		var/obj/docking_port/stationary/dock = dockvar
		var/list/dockdata = list(
			name = dock.name,
			id = dock.id,
			mapname = dock.get_map_zone()
		)
		data["docks"] += list(dockdata)
	return data

/datum/overmap_object/shuttle/ui_data(mob/user)
	var/list/data = list()
	// GENERAL
	data["name"] = name
	data["overmapView"] = shuttle_controller.mob_controller != null
	data["status"] = my_shuttle.mode
	data["position_x"] = x
	data["position_y"] = y
	data["commsListen"] = open_comms_channel
	data["commsBroadcast"] = microphone_muted
	// ENGINES
	data["engines"] = list()
	var/engineindex = 1
	for(var/datum/shuttle_extension/engine/engine in engine_extensions)
		var/list/enginedata = list(
			functioning = engine.CanOperate(),
			online = engine.turned_on,
			name = engine.name,
			index = engineindex,
			fuel_percent = (engine.current_fuel / engine.maximum_fuel),
			efficiency = (engine.current_efficiency * 100),
		)
		data["engines"] += list(enginedata)
		engineindex += 1
	// HELM
	data["destination_x"] = destination_x
	data["destination_y"] = destination_y
	data["speed"] = VECTOR_LENGTH(velocity_x, velocity_y)
	data["impulse"] = impulse_power
	data["topSpeed"] = GetCapSpeed()
	data["currentCommand"] = get_command_string()
	data["padControl"] = FALSE
	// TARGET
	data["hasTarget"] = FALSE
	if(lock)
		data["hasTarget"] = TRUE
		var/lockedTarget = list(
			name = lock.target.name,
			id = lock.target.id,
			x = lock.target.x,
			y = lock.target.y,
			dist = 0
		)
		data["lockedTarget"] = lockedTarget
	data["lockStatus"] = (lock ? (lock.is_calibrated ? "Locked" : "Calibrating...") : "None")
	data["targetCommand"] = target_command
	data["scanInfo"] = scan_text
	data["scanId"] = scan_id

	return data

/datum/overmap_object/shuttle/proc/get_command_string()
	switch(helm_command)
		if(HELM_IDLE)
			return "Idle"
		if(HELM_FULL_STOP)
			return "Full Stop"
		if(HELM_MOVE_TO_DESTINATION)
			return "Moving to destination..."
		if(HELM_TURN_TO_DESTINATION)
			return "Turning to face destination..."
		if(HELM_FOLLOW_SENSOR_LOCK)
			return "Following target..."
		if(HELM_TURN_TO_SENSOR_LOCK)
			return "Turning to target..."
	return "ERROR. Please contact system administrator."

/datum/overmap_object/shuttle/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("update_static_data")
			update_static_data(usr)
		// GENERAL
		if("overmap")
			GrantOvermapView(usr)
			return TRUE
		if("comms_input")
			microphone_muted = !microphone_muted
			return TRUE
		if("comms_output")
			open_comms_channel = !open_comms_channel
			my_visual.update_appearance()
			return TRUE
		if("hail")
			var/hail_msg = params["hail"]
			if(hail_msg)
				hail_msg = strip_html_simple(hail_msg, MAX_BROADCAST_LEN, TRUE)
				my_console?.say("Sent.")
			return TRUE
		// ENGINES
		if("engines_off")
			my_shuttle.TurnEnginesOff()
			my_console?.say("Engines offline.")
			return TRUE
		if("engines_on")
			my_shuttle.TurnEnginesOn()
			my_console?.say("Engines online.")
			return TRUE
		if("toggle_engine")
			var/index = params["index"]
			if(length(engine_extensions) < index)
				return
			var/datum/shuttle_extension/engine/ext = engine_extensions[index]
			ext.turned_on = !ext.turned_on
		if("set_efficiency")
			var/index = params["index"]
			if(length(engine_extensions) < index)
				return
			var/datum/shuttle_extension/engine/ext = engine_extensions[index]
			ext.current_efficiency = clamp((params["efficiency"]/100), 0, 1)
		if("overmap_view")
			GrantOvermapView(usr, get_turf(src))
			return TRUE
		// HELM
		if("command_stop")
			helm_command = HELM_FULL_STOP
			return TRUE
		if("command_move_dest")
			helm_command = HELM_MOVE_TO_DESTINATION
			return TRUE
		if("command_turn_dest")
			helm_command = HELM_TURN_TO_DESTINATION
			return TRUE
		if("command_follow_sensor")
			helm_command = HELM_FOLLOW_SENSOR_LOCK
			return TRUE
		if("command_turn_sensor")
			helm_command = HELM_TURN_TO_SENSOR_LOCK
			return TRUE
		if("command_idle")
			helm_command = HELM_IDLE
			return TRUE
		if("change_x")
			destination_x = clamp(params["new_x"], 1, current_system.maxx)
			return TRUE
		if("change_y")
			destination_y = clamp(params["new_y"], 1, current_system.maxy)
			return TRUE
		if("show_helm_pad")
			DisplayHelmPad(usr)
			return TRUE
		if("change_impulse_power")
			var/new_speed = input(usr, "Choose new impulse power (0% - 100%)", "Helm Control", (impulse_power*100)) as num|null
			if(new_speed)
				impulse_power = clamp((new_speed/100), 0, 1)
				return TRUE
		// SENSORS
		if("sensor")
			if(!(shuttle_capability & SHUTTLE_CAN_USE_SENSORS))
				return
			var/id = text2num(params["target_id"])
			if(!id)
				return
			var/datum/overmap_object/ov_obj = SSovermap.GetObjectByID(id)
			if(!ov_obj)
				return
			if(params["sensor_action"] == "target")
				SetLockTo(ov_obj)
				return TRUE
			if(params["sensor_action"] == "destination")
				destination_x = ov_obj.x
				destination_y = ov_obj.y
				return TRUE
		// TARGET
		if("target")
			if(!(shuttle_capability & SHUTTLE_CAN_USE_TARGET))
				return
			if(!lock)
				return
			var/targetaction = params["target_action"]
			switch(targetaction)
				if("disengage_lock")
					SetLockTo(null)
					return TRUE
				if("command_idle")
					target_command = TARGET_IDLE
					return TRUE
				if("command_fire_once")
					target_command = TARGET_FIRE_ONCE
					return TRUE
				if("command_keep_firing")
					target_command = TARGET_KEEP_FIRING
					return TRUE
				if("command_scan")
					target_command = TARGET_SCAN
					scan_text = "Scanning..."
					scan_id = lock.target.id
					addtimer(CALLBACK(src, .proc/Scan), 3 SECONDS)
					return TRUE
				if("command_beam_on_board")
					target_command = TARGET_BEAM_ON_BOARD
					return TRUE
		// DOCK
		if("designated_dock")
			if(shuttle_controller.busy)
				return
			if(velocity_x + velocity_y > 0)
				my_console?.say("Halt shuttle before attempting to dock.")
				return
			var/dock_id = params["dock_id"]
			var/obj/docking_port/stationary/target_dock = SSshuttle.getDock(dock_id)
			if(!target_dock)
				return
			var/datum/map_zone/mapzone = target_dock.get_map_zone()
			var/datum/overmap_object/dock_overmap_object = mapzone.related_overmap_object
			if(!dock_overmap_object)
				return
			if(!current_system.ObjectsAdjacent(src, dock_overmap_object))
				return
			switch(SSshuttle.moveShuttle(my_shuttle.id, dock_id, 1))
				if(0)
					shuttle_controller.busy = TRUE
					shuttle_controller.RemoveCurrentControl()
					var/datum/tgui/ui = SStgui.get_open_ui(usr, src)
					ui.close()
					my_console.say("Initiating docking procedure.")
			return TRUE
		if("freeform_dock")
			if(shuttle_controller.busy)
				return
			if(velocity_x + velocity_y > 0)
				my_console?.say("Halt shuttle before attempting to dock.")
				return
			if(shuttle_controller.freeform_docker)
				return
			var/sub_id = text2num(params["sub_id"])
			var/map_id = text2num(params["map_id"])
			if(!sub_id || !map_id)
				return
			var/datum/map_zone/mapzone = SSmapping.get_map_zone_id(map_id)
			if(!mapzone)
				return
			var/datum/virtual_level/vlevel = SSmapping.get_virtual_level_id(sub_id)
			if(!vlevel)
				return
			var/datum/overmap_object/mapzone_overmap_object = mapzone.related_overmap_object
			if(!mapzone_overmap_object)
				return
			if(!current_system.ObjectsAdjacent(src, mapzone_overmap_object))
				return
			shuttle_controller.SetController(usr)
			shuttle_controller.freeform_docker = new /datum/shuttle_freeform_docker(shuttle_controller, usr, vlevel)
			var/datum/tgui/ui = SStgui.get_open_ui(usr, src)
			ui.close()
			return TRUE

/datum/overmap_object/shuttle/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OvermapShuttle")
		ui.open()


/datum/overmap_object/shuttle/proc/DisplayUI(mob/user, turf/usage_turf)
	if(usage_turf)
		control_turf = usage_turf
	var/list/dat = list()

	dat += "<center><a href='?src=[REF(src)];task=tab;tab=0' [shuttle_ui_tab == 0 ? "class='linkOn'" : ""]>General</a>"
	if(shuttle_capability & SHUTTLE_CAN_USE_ENGINES)
		dat += "<a href='?src=[REF(src)];task=tab;tab=1' [shuttle_ui_tab == 1 ? "class='linkOn'" : ""]>Engines</a>"
		dat += "<a href='?src=[REF(src)];task=tab;tab=2' [shuttle_ui_tab == 2 ? "class='linkOn'" : ""]>Helm</a>"
	if(shuttle_capability & SHUTTLE_CAN_USE_SENSORS)
		dat += "<a href='?src=[REF(src)];task=tab;tab=3' [shuttle_ui_tab == 3 ? "class='linkOn'" : ""]>Sensors</a>"
		if(shuttle_capability & SHUTTLE_CAN_USE_TARGET)
			dat += "<a href='?src=[REF(src)];task=tab;tab=4' [shuttle_ui_tab == 4 ? "class='linkOn'" : ""]>Target</a>"
	if(shuttle_capability & SHUTTLE_CAN_USE_DOCK)
		dat += "<a href='?src=[REF(src)];task=tab;tab=5' [shuttle_ui_tab == 5 ? "class='linkOn'" : ""]>Dock</a>"
	dat += " <a href='?src=[REF(src)];task=refresh'>Refresh</a></center><HR>"

	switch(shuttle_ui_tab)
		if(SHUTTLE_TAB_GENERAL)
			var/shield_engaged = IsShieldOn()
			dat += "Hull: 100% integrity"
			if(length(shield_extensions))
				dat += "<BR>Shields: [GetShieldPercent()*100]% <a href='?src=[REF(src)];task=general;general_control=shields' [shield_engaged ? "class='linkOn'" : ""]>[shield_engaged ? "Engaged" : "Disengaged"]</a>"
			else
				dat += "<BR>Shields: Not installed"
			dat += "<BR>Position: X: [x] , Y: [y]"
			dat += "<BR>Overmap View: <a href='?src=[REF(src)];task=general;general_control=overmap'>Open</a>"
			dat += "<BR>Send a Hail: <a href='?src=[REF(src)];task=general;general_control=hail'>Send...</a>"
			dat += "<BR>Communications Channel: <a href='?src=[REF(src)];task=general;general_control=comms' [open_comms_channel ? "class='linkOn'" : ""]>[open_comms_channel ? "Open" : "Closed"]</a> - Microphone: <a href='?src=[REF(src)];task=general;general_control=microphone_muted' [microphone_muted ? "" : "class='linkOn'"]>[microphone_muted ? "Muted" : "Open"]</a>"

		if(SHUTTLE_TAB_ENGINES)
			if(engine_extensions.len == 0)
				dat += "<B>No engines installed.</B>"
			else
				dat += "<a href='?src=[REF(src)];task=engines;engines_control=all_on'>All On</a><a href='?src=[REF(src)];task=engines;engines_control=all_off'>All Off</a><a href='?src=[REF(src)];task=engines;engines_control=all_efficiency'>Set All Efficiency</a><HR>"
				var/iterator = 0
				for(var/i in engine_extensions)
					iterator++
					var/datum/shuttle_extension/engine/engine_ext = i
					var/can_operate = engine_ext.CanOperate()
					var/fuel_percent = "[(engine_ext.current_fuel / engine_ext.maximum_fuel)*100]%"
					var/efficiency_percent = "[engine_ext.current_efficiency*100]%"
					dat += "<B>Engine [iterator]</B>: [engine_ext.name] - <a href='?src=[REF(src)];task=engines;engines_control=toggle_online;engine_index=[iterator]' [engine_ext.turned_on ? "class='linkOn'" : ""]>[engine_ext.turned_on ? "Online" : "Offline"]</a>"
					dat += "<BR>Efficiency: <a href='?src=[REF(src)];task=engines;engines_control=set_efficiency;engine_index=[iterator]'>[efficiency_percent]</a>"
					dat += "<BR>Fuel: [fuel_percent]"
					dat += "<BR>Status: [can_operate ? "Nominal" : "Not Functioning"]"
					dat += "<HR>"


		if(SHUTTLE_TAB_HELM)
			dat += "<B>Command: "
			switch(helm_command)
				if(HELM_IDLE)
					dat += "Idle.</B>"
				if(HELM_FULL_STOP)
					dat += "Full stop.</B>"
				if(HELM_MOVE_TO_DESTINATION)
					dat += "Move to destination.</B>"
				if(HELM_TURN_TO_DESTINATION)
					dat += "Turn to destination.</B>"
				if(HELM_FOLLOW_SENSOR_LOCK)
					dat += "Follow sensor lock.</B>"
				if(HELM_TURN_TO_SENSOR_LOCK)
					dat += "Turn to sensor lock.</B>"

			dat += "<BR>Position: X: [x] , Y: [y]"
			dat += "<BR>Destination: "
			dat += "X: <a href='?src=[REF(src)];task=helm;helm_control=change_x'>[destination_x]</a>"
			dat += " , Y: <a href='?src=[REF(src)];task=helm;helm_control=change_y'>[destination_y]</a>"
			var/cur_speed = VECTOR_LENGTH(velocity_x, velocity_y)
			dat += "<BR>Current speed: [cur_speed]"
			dat += "<BR> - Impulse Power: <a href='?src=[REF(src)];task=helm;helm_control=change_impulse_power'>[impulse_power*100]%</a>"
			dat += "<BR> - Top speed: [GetCapSpeed()]"
			if(engine_extensions.len == 0)
				dat += "<BR><B>No engines installed.</B>"
			else
				dat += "<BR>Commands:"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_stop'>Full Stop</a>"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_move_dest'>Move to Destination</a>"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_turn_dest'>Turn to Destination</a>"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_follow_sensor'>Follow Sensor Lock</a>"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_turn_sensor'>Turn to Sensor Lock</a>"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_idle'>Idle</a>"
				dat += "<BR>Pad Control: <a href='?src=[REF(src)];task=helm;helm_control=pad'>Open</a>"

		if(SHUTTLE_TAB_SENSORS)
			var/list/targets = GetSensorTargets()
			dat += "<table align='center'; width='100%'; height='100%'; style='background-color:#13171C'>"
			dat += "<tr style='vertical-align:top'>"
			dat += "<td width=30%>Name:</td>"
			dat += "<td width=10%>X:</td>"
			dat += "<td width=10%>Y:</td>"
			dat += "<td width=10%>Dist:</td>"
			dat += "<td width=40%>Actions:</td>"
			dat += "</tr>"
			var/even = TRUE
			for(var/ov_obj in targets)
				even = !even
				var/datum/overmap_object/overmap_obj = ov_obj
				var/dist = FLOOR(TWO_POINT_DISTANCE(x,y,overmap_obj.x,overmap_obj.y),1)
				var/is_destination = (destination_x == overmap_obj.x && destination_y == overmap_obj.y)
				var/is_target = (lock && lock.target == overmap_obj)
				dat += "<tr style='background-color: [even ? "#17191C" : "#23273C"];'>"
				dat += "<td>[overmap_obj.name]</td>"
				dat += "<td>[overmap_obj.x]</td>"
				dat += "<td>[overmap_obj.y]</td>"
				dat += "<td>[dist]</td>"
				dat += "<td>"
				var/in_lock_range = IN_LOCK_RANGE(src,overmap_obj)
				if(shuttle_capability & SHUTTLE_CAN_USE_TARGET)
					dat += "<a href='?src=[REF(src)];task=sensor;sensor_task=target;target_id=[overmap_obj.id]'[in_lock_range ? "" : "class='linkOff'"][is_target ? "class='linkOn'" : ""]>Target</a>"
				if(shuttle_capability & SHUTTLE_CAN_USE_ENGINES)
					dat += "<a href='?src=[REF(src)];task=sensor;sensor_task=destination;target_id=[overmap_obj.id]' [is_destination ? "class='linkOn'" : ""]>As Dest.</a>"
				dat += "</td></tr>"
			dat += "</table>"

		if(SHUTTLE_TAB_TARGET)
			var/locked_thing_name = lock ? lock.target.name : "NONE"
			var/locked_status = "NOT ENGAGED"
			var/locked_and_calibrated = FALSE
			if(lock)
				if(lock.is_calibrated)
					locked_and_calibrated = TRUE
					locked_status = "LOCKED"
				else
					locked_status = "CALIBRATING"

			dat += "Target: [locked_thing_name]"
			dat	+= "<BR>Lock status: [locked_status] [lock ? "<a href='?src=[REF(src)];task=target;target_control=disengage_lock'>Disengage</a>" : ""]"
			dat	+= "<BR><B>Current Command:</B> "
			switch(target_command)
				if(TARGET_IDLE)
					dat	+= "Idle."
				if(TARGET_FIRE_ONCE)
					dat	+= "Fire Once!"
				if(TARGET_KEEP_FIRING)
					dat	+= "Keep Firing!"
				if(TARGET_SCAN)
					dat	+= "Scan."
				if(TARGET_BEAM_ON_BOARD)
					dat	+= "Beam on board."
			dat += "<BR>Commands:"
			dat += "<BR> - <a href='?src=[REF(src)];task=target;target_control=command_idle' [locked_and_calibrated ? "" : "class='linkOff'"]>Idle</a>"
			dat += "<BR> - <a href='?src=[REF(src)];task=target;target_control=command_fire_once' [locked_and_calibrated ? "" : "class='linkOff'"]>Fire Once!</a>"
			dat += "<BR> - <a href='?src=[REF(src)];task=target;target_control=command_keep_firing' [locked_and_calibrated ? "" : "class='linkOff'"]>Keep Firing!</a>"
			dat += "<BR> - <a href='?src=[REF(src)];task=target;target_control=command_scan' [locked_and_calibrated ? "" : "class='linkOff'"]>Scan</a>"
			dat += "<BR> - <a href='?src=[REF(src)];task=target;target_control=command_beam_on_board' [locked_and_calibrated ? "" : "class='linkOff'"]>Beam on Board</a>"
			dat += "<BR><B>Scan Info: </B><BR>[scan_text]"

		if(SHUTTLE_TAB_DOCKING)
			if(!my_shuttle || is_seperate_z_level)
				return
			if(VECTOR_LENGTH(velocity_x, velocity_y) > SHUTTLE_MAXIMUM_DOCKING_SPEED)
				dat += "<B>Cannot safely dock in high velocities!</B>"
			else
				var/list/virtual_levels = list()
				var/list/nearby_objects = current_system.GetObjectsOnCoords(x,y)
				var/list/freeform_virtual_levels = list()
				for(var/datum/overmap_object/IO as anything in nearby_objects)
					if(!IO.can_be_docked)
						continue
					var/iter = 0
					if(IO.related_map_zone)
						for(var/datum/virtual_level/vlevel in IO.related_map_zone.virtual_levels)
							iter++
							virtual_levels |= vlevel
							freeform_virtual_levels["[iter]. [vlevel.name] - Freeform"] = vlevel

				var/list/obj/docking_port/stationary/docks = list()
				var/list/options = params2list(my_shuttle.possible_destinations)
				var/iter = 0
				for(var/i in SSshuttle.stationary)
					var/obj/docking_port/stationary/iterated_dock = i
					var/datum/virtual_level/vlevel = iterated_dock.get_virtual_level()
					if(!(vlevel in virtual_levels))
						continue
					if(!options.Find(iterated_dock.port_destinations))
						continue
					if(!my_shuttle.check_dock(iterated_dock, silent = TRUE))
						continue
					iter++
					docks["[iter]. [iterated_dock.name]"] = iterated_dock

				dat += "<B>Designated docks:</B>"
				for(var/key in docks)
					dat += "<BR> - [key] - <a href='?src=[REF(src)];task=dock;dock_control=normal_dock;dock_id=[docks[key].id]'>Dock</a>"

				dat += "<BR><BR><B>Freeform docking spaces:</B>"
				for(var/key in freeform_virtual_levels)
					var/datum/virtual_level/vlevel = freeform_virtual_levels[key]
					var/datum/map_zone/parent_zone = vlevel.parent_map_zone
					dat += "<BR> - [key] - <a href='?src=[REF(src)];task=dock;dock_control=freeform_dock;map_id=[parent_zone.id];sub_id=[vlevel.id]'>Designate Location</a>"

	var/datum/browser/popup = new(user, "overmap_shuttle_control", "Shuttle Control", 400, 440)
	popup.set_content(dat.Join())
	popup.open()

/datum/overmap_object/shuttle/proc/Scan()
	var/txt = ""
	txt += lock.target.GetScanText()
	scan_text = txt
	scan_id = lock.target.id
	target_command = TARGET_IDLE
	return scan_text

/datum/overmap_object/shuttle/proc/DisplayHelmPad(mob/user)
	var/list/dat = list("<center>")
	dat += "<a href='?src=[REF(src)];pad_topic=nw'>O</a><a href='?src=[REF(src)];pad_topic=n'>O</a><a href='?src=[REF(src)];pad_topic=ne'>O</a>"
	dat += "<BR><a href='?src=[REF(src)];pad_topic=w'>O</a><a href='?src=[REF(src)];pad_topic=stop'>O</a><a href='?src=[REF(src)];pad_topic=e'>O</a>"
	dat += "<BR><a href='?src=[REF(src)];pad_topic=sw'>O</a><a href='?src=[REF(src)];pad_topic=s'>O</a><a href='?src=[REF(src)];pad_topic=se'>O</a></center>"
	dat += "<BR>Pad Range: <a href='?src=[REF(src)];pad_topic=range'>[helm_pad_range]</a>"
	dat += "<BR>Relative Destination: <a href='?src=[REF(src)];pad_topic=relative_dir'>[helm_pad_relative_destination ? "Yes" : "No"]</a>"
	dat += "<BR>Engage Immediately: <a href='?src=[REF(src)];pad_topic=engage_immediately'>[helm_pad_engage_immediately ? "Yes" : "No"]</a>"
	dat += "<BR>Pos.: X: [x] , Y: [y]"
	dat += " | Dest.: X: [destination_x] , Y: [destination_y]"
	dat += "<BR><center><a href='?src=[REF(src)];pad_topic=engage'>Engage</a></center>"
	var/datum/browser/popup = new(user, "overmap_helm_pad", "Helm Pad Control", 250, 250)
	popup.set_content(dat.Join())
	control_turf = get_turf(user)
	popup.open()

/datum/overmap_object/shuttle/proc/InputHelmPadDirection(input_x = 0, input_y = 0)
	if(!input_x && !input_y)
		StopMove()
		return
	if(helm_pad_relative_destination)
		destination_x = x
		destination_y = y
	if(input_x)
		destination_x += input_x * helm_pad_range
		destination_x = clamp(destination_x, 1, current_system.maxx)
	if(input_y)
		destination_y += input_y * helm_pad_range
		destination_y = clamp(destination_y, 1, current_system.maxy)
	if(helm_pad_engage_immediately)
		helm_command = HELM_MOVE_TO_DESTINATION
	return

/datum/overmap_object/shuttle/proc/LockLost()
	target_command = TARGET_IDLE

/datum/overmap_object/shuttle/proc/SetLockTo(datum/overmap_object/ov_obj)
	if(lock)
		if(ov_obj == lock.target)
			return
		else
			QDEL_NULL(lock)
	if(ov_obj && IN_LOCK_RANGE(src,ov_obj))
		lock = new(src, ov_obj)

/datum/overmap_object/shuttle/Topic(href, href_list)
	if(!control_turf)
		return
	var/mob/user = usr
	if(!isliving(user) || !user.canUseTopic(control_turf, BE_CLOSE, FALSE, NO_TK))
		return
	if(href_list["pad_topic"])
		if(!(shuttle_capability & SHUTTLE_CAN_USE_ENGINES))
			return
		switch(href_list["pad_topic"])
			if("nw")
				InputHelmPadDirection(-1, 1)
			if("n")
				InputHelmPadDirection(0, 1)
			if("ne")
				InputHelmPadDirection(1, 1)
			if("w")
				InputHelmPadDirection(-1, 0)
			if("e")
				InputHelmPadDirection(1, 0)
			if("sw")
				InputHelmPadDirection(-1, -1)
			if("s")
				InputHelmPadDirection(0, -1)
			if("se")
				InputHelmPadDirection(1, -1)
			if("stop")
				InputHelmPadDirection()
			if("engage")
				helm_command = HELM_MOVE_TO_DESTINATION
			if("range")
				var/new_range = input(usr, "Choose new pad range", "Helm Pad Control", helm_pad_range) as num|null
				if(new_range)
					helm_pad_range = new_range
			if("relative_dir")
				helm_pad_relative_destination = !helm_pad_relative_destination
			if("engage_immediately")
				helm_pad_engage_immediately = !helm_pad_engage_immediately
		DisplayHelmPad(usr)
		return
	switch(href_list["task"])
		if("tab")
			shuttle_ui_tab = text2num(href_list["tab"])
		if("engines")
			switch(href_list["engines_control"])
				if("all_on")
					for(var/i in engine_extensions)
						var/datum/shuttle_extension/engine/ext = i
						ext.turned_on = TRUE
				if("all_off")
					for(var/i in engine_extensions)
						var/datum/shuttle_extension/engine/ext = i
						ext.turned_on = FALSE
				if("all_efficiency")
					var/new_eff = input(usr, "Choose new efficiency", "Engine Control") as num|null
					if(new_eff)
						var/new_value = clamp((new_eff/100),0,1)
						for(var/i in engine_extensions)
							var/datum/shuttle_extension/engine/ext = i
							ext.current_efficiency = new_value
				if("toggle_online")
					var/index = text2num(href_list["engine_index"])
					if(length(engine_extensions) < index)
						return
					var/datum/shuttle_extension/engine/ext = engine_extensions[index]
					ext.turned_on = !ext.turned_on
				if("set_efficiency")
					var/new_eff = input(usr, "Choose new efficiency", "Engine Control") as num|null
					if(new_eff)
						var/index = text2num(href_list["engine_index"])
						if(length(engine_extensions) < index)
							return
						var/datum/shuttle_extension/engine/ext = engine_extensions[index]
						ext.current_efficiency = clamp((new_eff/100),0,1)
		if("dock")
			if(!(shuttle_capability & SHUTTLE_CAN_USE_DOCK))
				return
			if(VECTOR_LENGTH(velocity_x, velocity_y) > SHUTTLE_MAXIMUM_DOCKING_SPEED)
				return

			switch(href_list["dock_control"])
				if("normal_dock")
					if(shuttle_controller.busy)
						return
					var/dock_id = href_list["dock_id"]
					var/obj/docking_port/stationary/target_dock = SSshuttle.getDock(dock_id)
					if(!target_dock)
						return
					var/datum/map_zone/mapzone = target_dock.get_map_zone()
					var/datum/overmap_object/dock_overmap_object = mapzone.related_overmap_object
					if(!dock_overmap_object)
						return
					if(!current_system.ObjectsAdjacent(src, dock_overmap_object))
						return
					switch(SSshuttle.moveShuttle(my_shuttle.id, dock_id, 1))
						if(0)
							shuttle_controller.busy = TRUE
							shuttle_controller.RemoveCurrentControl()
				if("freeform_dock")
					if(shuttle_controller.busy)
						return
					if(shuttle_controller.freeform_docker)
						return
					var/sub_id = text2num(href_list["sub_id"])
					var/map_id = text2num(href_list["map_id"])
					if(!sub_id || !map_id)
						return
					var/datum/map_zone/mapzone = SSmapping.get_map_zone_id(map_id)
					if(!mapzone)
						return
					var/datum/virtual_level/vlevel = SSmapping.get_virtual_level_id(sub_id)
					if(!vlevel)
						return
					var/datum/overmap_object/mapzone_overmap_object = mapzone.related_overmap_object
					if(!mapzone_overmap_object)
						return
					if(!current_system.ObjectsAdjacent(src, mapzone_overmap_object))
						return
					shuttle_controller.SetController(usr)
					shuttle_controller.freeform_docker = new /datum/shuttle_freeform_docker(shuttle_controller, usr, vlevel)

		if("target")
			if(!(shuttle_capability & SHUTTLE_CAN_USE_TARGET))
				return
			if(!lock)
				return
			switch(href_list["target_control"])
				if("disengage_lock")
					SetLockTo(null)
				if("command_idle")
					target_command = TARGET_IDLE
				if("command_fire_once")
					target_command = TARGET_FIRE_ONCE
				if("command_keep_firing")
					target_command = TARGET_KEEP_FIRING
				if("command_scan")
					target_command = TARGET_SCAN
					scan_text = "Scanning..."
					addtimer(CALLBACK(src, .proc/Scan), 3 SECONDS)
				if("command_beam_on_board")
					target_command = TARGET_BEAM_ON_BOARD
		if("sensor")
			if(!(shuttle_capability & SHUTTLE_CAN_USE_SENSORS))
				return
			var/id = text2num(href_list["target_id"])
			if(!id)
				return
			var/datum/overmap_object/ov_obj = SSovermap.GetObjectByID(id)
			if(!ov_obj)
				return
			switch(href_list["sensor_task"])
				if("target")
					SetLockTo(ov_obj)
				if("destination")
					destination_x = ov_obj.x
					destination_y = ov_obj.y
		if("general")
			switch(href_list["general_control"])
				if("shields")
					var/shields_engaged = IsShieldOn()
					if(shields_engaged)
						TurnShieldsOff()
					else
						TurnShieldsOn()
				if("overmap")
					GrantOvermapView(usr)
				if("microphone_muted")
					microphone_muted = !microphone_muted
				if("comms")
					open_comms_channel = !open_comms_channel
					my_visual.update_appearance()
				if("hail")
					var/hail_msg = input(usr, "Compose a hail message:", "Hail Message")  as text|null
					if(hail_msg)
						hail_msg = strip_html_simple(hail_msg, MAX_BROADCAST_LEN, TRUE)
		if("helm")
			if(!(shuttle_capability & SHUTTLE_CAN_USE_ENGINES))
				return
			switch(href_list["helm_control"])
				if("pad")
					DisplayHelmPad(usr)
					return
				if("command_stop")
					helm_command = HELM_FULL_STOP
				if("command_move_dest")
					helm_command = HELM_MOVE_TO_DESTINATION
				if("command_turn_dest")
					helm_command = HELM_TURN_TO_DESTINATION
				if("command_follow_sensor")
					helm_command = HELM_FOLLOW_SENSOR_LOCK
				if("command_turn_sensor")
					helm_command = HELM_TURN_TO_SENSOR_LOCK
				if("command_idle")
					helm_command = HELM_IDLE
				if("change_x")
					var/new_x = input(usr, "Choose new X destination", "Helm Control", destination_x) as num|null
					if(new_x)
						destination_x = clamp(new_x, 1, current_system.maxx)
				if("change_y")
					var/new_y = input(usr, "Choose new Y destination", "Helm Control", destination_y) as num|null
					if(new_y)
						destination_y = clamp(new_y, 1, current_system.maxy)
				if("change_impulse_power")
					var/new_speed = input(usr, "Choose new impulse power (0% - 100%)", "Helm Control", (impulse_power*100)) as num|null
					if(new_speed)
						impulse_power = clamp((new_speed/100), 0, 1)
	DisplayUI(usr)

/datum/overmap_object/shuttle/New()
	. = ..()
	destination_x = x
	destination_y = y
	shuttle_controller = new(src)

/datum/overmap_object/shuttle/proc/RegisterToShuttle(obj/docking_port/mobile/register_shuttle)
	can_be_docked = FALSE
	my_shuttle = register_shuttle
	my_shuttle.my_overmap_object = src
	for(var/i in my_shuttle.all_extensions)
		var/datum/shuttle_extension/extension = i
		extension.AddToOvermapObject(src)

	var/obj/docking_port/stationary/transit/my_transit = my_shuttle.assigned_transit
	related_map_zone = my_transit.reserved_mapzone
	transit_instance = my_transit.transit_instance
	transit_instance.overmap_shuttle = src

	update_perceived_parallax()

/datum/overmap_object/shuttle/Destroy()
	if(transit_instance)
		transit_instance.overmap_shuttle = null
		transit_instance = null
	control_turf = null
	QDEL_NULL(shuttle_controller)
	if(my_shuttle)
		for(var/i in my_shuttle.all_extensions)
			var/datum/shuttle_extension/extension = i
			extension.RemoveFromOvermapObject()
		my_shuttle.my_overmap_object = null
		my_shuttle = null
	engine_extensions = null
	shield_extensions = null
	transporter_extensions = null
	weapon_extensions = null
	all_extensions = null
	return ..()

/datum/overmap_object/shuttle/UpdateVisualOffsets()
	. = ..()
	if(shuttle_controller)
		shuttle_controller.NewVisualOffset(FLOOR(partial_x,1),FLOOR(partial_y,1))

/datum/overmap_object/shuttle/proc/update_perceived_parallax()
	var/established_direction = FALSE
	if(velocity_y || velocity_x)
		var/absx = abs(velocity_x)
		var/absy = abs(velocity_y)
		if(absy > absx)
			if(velocity_y > 0)
				established_direction = NORTH
			else
				established_direction = SOUTH
		else
			if(velocity_x > 0)
				established_direction = EAST
			else
				established_direction = WEST

	var/changed = FALSE
	if(my_shuttle)
		current_parallax_dir = established_direction ? (my_shuttle.preferred_direction ? my_shuttle.preferred_direction : established_direction) : FALSE
		if(current_parallax_dir != my_shuttle.overmap_parallax_dir)
			my_shuttle.overmap_parallax_dir = current_parallax_dir
			changed = TRUE
			var/area/hyperspace_area = transit_instance.dock.assigned_area
			hyperspace_area.parallax_movedir = current_parallax_dir
	else if (is_seperate_z_level && related_map_zone)
		current_parallax_dir = (established_direction && fixed_parallax_dir) ? fixed_parallax_dir : established_direction
		if(current_parallax_dir != related_map_zone.parallax_movedir)
			related_map_zone.parallax_movedir = current_parallax_dir
			changed = TRUE

	if(changed)
		for(var/i in GetAllClientMobs())
			var/mob/mob = i
			mob.hud_used.update_parallax()

/datum/overmap_object/shuttle/proc/GrantOvermapView(mob/user, turf/passed_turf)
	//Camera control
	if(!shuttle_controller)
		return
	if(user.client && !shuttle_controller.busy)
		shuttle_controller.SetController(user)
		if(passed_turf)
			shuttle_controller.control_turf = passed_turf
		return TRUE

/datum/overmap_object/shuttle/proc/CommandMove(dest_x, dest_y)
	destination_y = dest_y
	destination_x = dest_x
	helm_command = HELM_MOVE_TO_DESTINATION

/datum/overmap_object/shuttle/proc/StopMove()
	helm_command = HELM_FULL_STOP

/datum/overmap_object/shuttle/relaymove(mob/living/user, direction)
	return

/datum/overmap_object/shuttle/station
	name = "Space Station"
	visual_type = /obj/effect/abstract/overmap/shuttle/station
	is_seperate_z_level = TRUE
	uses_rotation = FALSE
	shuttle_capability = STATION_SHUTTLE_CAPABILITY
	speed_divisor_from_mass = 40
	clears_hazards_on_spawn = TRUE

/datum/overmap_object/shuttle/ship
	name = "Ship"
	visual_type = /obj/effect/abstract/overmap/shuttle/ship
	is_seperate_z_level = TRUE
	shuttle_capability = STATION_SHUTTLE_CAPABILITY
	speed_divisor_from_mass = 20
	clears_hazards_on_spawn = TRUE

/datum/overmap_object/shuttle/ship/bearcat
	name = "FTV Bearcat"
	fixed_parallax_dir = NORTH

/datum/overmap_object/shuttle/ship/skyline
	name = "CPCV Skyline"
	fixed_parallax_dir = NORTH

/datum/overmap_object/shuttle/planet
	name = "Planet"
	visual_type = /obj/effect/abstract/overmap/shuttle/planet
	is_seperate_z_level = TRUE
	uses_rotation = FALSE
	shuttle_capability = PLANET_SHUTTLE_CAPABILITY
	speed_divisor_from_mass = 1000 //1000 times as harder as a shuttle to move
	clears_hazards_on_spawn = TRUE
	var/planet_color = COLOR_WHITE

/datum/overmap_object/shuttle/planet/New()
	. = ..()
	my_visual.color = planet_color

/datum/overmap_object/shuttle/planet/lavaland
	name = "Lavaland"
	planet_color = LIGHT_COLOR_BLOOD_MAGIC

/datum/overmap_object/shuttle/planet/icebox
	name = "Ice Planet"
	planet_color = COLOR_TEAL

/datum/overmap_object/shuttle/ess_crow
	name = "ESS Crow"
	speed_divisor_from_mass = 4
