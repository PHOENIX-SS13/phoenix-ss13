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
	max_integrity = 200
	armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 60, BIO = 60, RAD = 60, FIRE = 60, ACID = 60)
	verb_say = "buzzes"
	verb_yell = ""

	var/obj/item/radio/intercom/wideband/internal_radio = null
	///Is the distress signal being broadcasted?
	var/distress = FALSE
	///list of who we're monitoring for automatic distress signals
	var/list/mob/living/monitoring = list()
	///percentage of monitored mobs that must be in bad health before distress signal auto-starts
	var/distress_threshold = 100
	///percentage of health a mob must be below in order to count towards the threshold
	var/health_threshold = 10

/obj/machinery/shuttle_comms/Initialize()
	. = ..()
	//AddComponent(/datum/component/radio, list(FREQ_WIDEBAND))
	internal_radio = new /obj/item/radio/intercom/wideband(src)

/obj/machinery/shuttle_comms/AltClick(mob/user)
	var/mic = !(internal_radio.broadcasting)
	internal_radio.broadcasting = mic
	src.balloon_alert(user, "Microphone turned [mic ? "on" : "off"].")

/obj/machinery/shuttle_comms/alt_click_secondary(mob/user)
	var/speakers = !(internal_radio.listening)
	internal_radio.listening = speakers
	src.balloon_alert(user, "Speakers turned [speakers ? "on" : "off"].")

/obj/machinery/shuttle_comms/examine(mob/user)
	. = ..()
	. += SPAN_NOTICE("There's an inbuilt wideband radio. The speaker is [internal_radio.listening ? "on" : "off"], and the microphone is [internal_radio.broadcasting ? "on" : "off"].")
	. += SPAN_INFO("You can toggle the microphone with alt+click and the speaker with alt+rclick.")

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

	data["monitoring"] += monitoring

	return data

/obj/machinery/shuttle_comms/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	switch(action)
		if("listen")
			return
		if("broadcast")
			return
		if("toggle_distress")
			return
		if("health_threshold")
			return
		if("distress_threshold")
			return
		if("toggle_monitoring")
			return
