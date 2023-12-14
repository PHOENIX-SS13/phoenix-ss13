/obj/item/circuitboard/machine/shuttle_comms
	name = "long-range communications circuitboard"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/shuttle_comms
	req_components = list(
		/obj/item/stock_parts/subspace/filter = 1,
		/obj/item/stock_parts/subspace/ansible = 1,
		/obj/item/stock_parts/subspace/transmitter = 1,
		/obj/item/stock_parts/subspace/crystal = 1)

/obj/machinery/shuttle_comms
	name = "comms array"
	desc = "An assortment of radio equipment and accessories designed to facilitate long-range communication and broadcast distress signals when necessary. It is incredibly durable and powers itself internally in order to continue functioning even when the shuttle is disabled."
	icon = 'icons/obj/radio.dmi'
	icon_state = "radio"
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/machine/shuttle_comms
	max_integrity = 200
	armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 60, BIO = 60, RAD = 60, FIRE = 60, ACID = 60)
	verb_say = "buzzes"
	verb_yell = ""

	var/datum/overmap_distress/overmap_effect = null
	var/obj/item/radio/intercom/wideband/internal_radio = null
	///Is the distress signal being broadcasted?
	var/distress = FALSE
	///list of who we're monitoring for automatic distress signals
	var/list/mob/living/monitoring = list()
	///percentage of monitored mobs that must be in bad health before distress signal auto-starts
	var/distress_threshold = 1
	///percentage of health a mob must be below in order to count towards the threshold
	var/health_threshold = 0.1
	///whether the subsystem should process this array
	var/should_process = TRUE

/obj/machinery/shuttle_comms/Initialize()
	. = ..()
	//AddComponent(/datum/component/radio, list(FREQ_WIDEBAND))
	internal_radio = new /obj/item/radio/intercom/wideband(src)

	if(should_process)
		SSshuttlecomms.add_array(src)

/obj/machinery/shuttle_comms/Destroy()
	. = ..()
	qdel(internal_radio)
	qdel(overmap_effect)
	SSshuttlecomms.remove_array(src)

/obj/machinery/shuttle_comms/proc/toggle_broadcasting()
	var/mic = !(internal_radio.broadcasting)
	internal_radio.broadcasting = mic
	src.balloon_alert(src, "Microphone turned [mic ? "on" : "off"].")

/obj/machinery/shuttle_comms/proc/toggle_listening()
	var/speakers = !(internal_radio.listening)
	internal_radio.listening = speakers
	src.balloon_alert(src, "Speakers turned [speakers ? "on" : "off"].")

/obj/machinery/shuttle_comms/proc/create_effect()
	var/datum/map_zone/mapzone = get_map_zone()
	overmap_effect = new /datum/overmap_distress(mapzone.related_overmap_object)

/obj/machinery/shuttle_comms/proc/destroy_effect()
	qdel(overmap_effect)

/obj/machinery/shuttle_comms/proc/set_distress(value)
	if(distress == value)
		return

	distress = value
	if(value)
		create_effect()
	else
		destroy_effect()

/obj/machinery/shuttle_comms/proc/toggle_distress()
	if(distress)
		set_distress(FALSE)
	else
		set_distress(TRUE)

/obj/machinery/shuttle_comms/proc/monitor()
	var/datum/map_zone/mapzone = get_map_zone()
	if(distress)
		overmap_effect.process(mapzone.related_overmap_object)
	if(!length(monitoring))
		return
	var/hurt = 0

	for(var/mob/living/L in monitoring)
		if(L.get_map_zone != mapzone)
			monitoring -= L
			continue
		if(L.health / L.maxHealth <= health_threshold)
			hurt++

	if(hurt / length(monitoring) >= distress_threshold)
		if(!distress)
			set_distress(TRUE)
	else
		if(distress)
			set_distress(FALSE)

// /obj/machinery/shuttle_comms/AltClick(mob/user)
//	toggle_broadcasting()

// /obj/machinery/shuttle_comms/alt_click_secondary(mob/user)
//	toggle_listening()

/obj/machinery/shuttle_comms/examine(mob/user)
	. = ..()
	. += SPAN_NOTICE("There's an inbuilt wideband radio. The speaker is [internal_radio.listening ? "on" : "off"], and the microphone is [internal_radio.broadcasting ? "on" : "off"].")
	. += SPAN_INFO("The emergency broadcast is currently [distress ? "active" : "inactive"].")

/obj/machinery/shuttle_comms/ui_interact(mob/user, datum/tgui/ui, datum/ui_state/state)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ShuttleComms", name)
		if(state)
			ui.set_state(state)
		ui.open()

/obj/machinery/shuttle_comms/ui_data(mob/user)
	var/list/data = list()

	data["listening"] += internal_radio.listening
	data["broadcasting"] += internal_radio.broadcasting
	data["distress"] += distress
	data["distress_threshold"] += distress_threshold
	data["health_threshold"] += health_threshold

	return data


/obj/machinery/shuttle_comms/ui_static_data(mob/user)
	var/list/data = list()

	var/datum/map_zone/mapzone = get_map_zone()
	var/list/mob/clients = mapzone.get_client_mobs()

	data["clients"] = list()
	for(var/mob/M in clients)
		data["clients"] += M.name

	data["monitoring"] = list()
	for(var/mob/M in monitoring)
		data["monitoring"] += M.name

	return data

/obj/machinery/shuttle_comms/ui_act(action, list/params)
	. = ..()
	if(.)
		return TRUE
	switch(action)
		if("listen")
			toggle_listening()
			return TRUE
		if("broadcast")
			toggle_broadcasting()
			return TRUE
		if("toggle_distress")
			toggle_distress()
			return TRUE
		if("health_threshold")
			health_threshold = params["adjust"]
			return TRUE
		if("distress_threshold")
			distress_threshold = params["adjust"]
			return TRUE
		if("toggle_monitoring")
			var/name = params["target"]
			for(var/mob/living/L in monitoring)
				if(L.name == name)
					monitoring -= L
					update_static_data(usr)
					return TRUE
			var/datum/map_zone/mapzone = get_map_zone()
			var/list/mob/living/mobs = mapzone.get_client_mobs()
			for(var/mob/living/L in mobs)
				if(L.name == name)
					monitoring += L
					update_static_data(usr)
					return TRUE
			say("Could not find target.")
			update_static_data(usr)
			return TRUE

/obj/machinery/shuttle_comms/active

/obj/machinery/shuttle_comms/active/Initialize()
	. = ..()
	set_distress(TRUE)
