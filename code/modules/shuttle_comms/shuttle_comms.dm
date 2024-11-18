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
	///was the distress signal turned on manually?
	var/manual_distress = FALSE
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
	if(!QDELETED(internal_radio))
		Destroy(internal_radio)
	if(!QDELETED(overmap_effect))
		Destroy(overmap_effect)
	SSshuttlecomms.remove_array(src)
	return ..()

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
	var/datum/overmap_object/ov_obj = mapzone.related_overmap_object
	overmap_effect = new /datum/overmap_distress(src, ov_obj)

/obj/machinery/shuttle_comms/proc/destroy_effect()
	qdel(overmap_effect)

/obj/machinery/shuttle_comms/proc/set_distress(value)
	if(distress == value)
		return

	distress = value
	if(value)
		create_effect()
	else
		manual_distress = FALSE
		destroy_effect()

/obj/machinery/shuttle_comms/proc/toggle_distress()
	if(distress)
		set_distress(FALSE)
	else
		set_distress(TRUE)

/obj/machinery/shuttle_comms/proc/monitor()
	var/datum/map_zone/mapzone = get_map_zone()
	if(distress)
		overmap_effect.check_mapzone(mapzone.related_overmap_object)
	if(!length(monitoring) || manual_distress)
		return
	var/hurt = 0

	for(var/mob/living/L in monitoring)
		if(L.get_map_zone() != mapzone)
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
	. += SPAN_INFO("It is [anchored ? "" : "not "]anchored, and its maintenance panel is [panel_open ? "open" : "closed"].")

/obj/machinery/shuttle_comms/attackby(obj/item/W, mob/user, params)
	var/is_right_clicking = LAZYACCESS(params2list(params), RIGHT_CLICK)
	if(is_right_clicking)
		return
	if(W.tool_behaviour == NONE)
		. = ..()
		return
	switch(W.tool_behaviour)
		if(TOOL_WRENCH)
			anchored = !anchored
			W.play_tool_sound(src)
			to_chat(user, "You [anchored ? "" : "un"]anchor [src].")
		if(TOOL_SCREWDRIVER)
			panel_open = !panel_open
			W.play_tool_sound(src)
			to_chat(user, "You [panel_open ? "open" : "close"] [src]'s maintenance panel.")
		if(TOOL_CROWBAR)
			if(!panel_open)
				to_chat(user, "The [src]'s maintenance panel is closed.")
				return
			W.play_tool_sound(src)
			to_chat(user, "You deconstruct the [src].")
			deconstruct(TRUE)

/obj/machinery/shuttle_comms/deconstruct(disassembled)
	Destroy(internal_radio)
	Destroy(overmap_effect)
	. = ..()

/obj/machinery/shuttle_comms/tool_act(mob/living/user, obj/item/tool, tool_type, is_right_clicking)


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
			if(distress)
				manual_distress = TRUE
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

#define BLACKBOX_INTACT 0
#define BLACKBOX_EXPOSED 1
#define BLACKBOX_RETRIEVED 2

/obj/machinery/shuttle_comms/active
	manual_distress = TRUE
	desc = "A slightly banged up communications array. At least these things can take a beating."
	var/blackbox_status = BLACKBOX_INTACT

/obj/machinery/shuttle_comms/active/Initialize()
	. = ..()
	set_distress(TRUE)

/obj/machinery/shuttle_comms/active/examine(mob/user)
	. = ..()
	switch(blackbox_status)
		if(BLACKBOX_INTACT)
			. += SPAN_NOTICE("Its blackbox is in place and intact. You could retrieve it after removing a few screws.")
		if(BLACKBOX_EXPOSED)
			. += SPAN_NOTICE("Its blackbox is exposed. You could reach in and pull it out.")
		if(BLACKBOX_RETRIEVED)
			. += SPAN_NOTICE("Upon inspection, it's missing its blackbox.")

/obj/machinery/shuttle_comms/active/tool_act(mob/living/user, obj/item/tool, tool_type)
	if(tool_type != TOOL_SCREWDRIVER || blackbox_status != BLACKBOX_INTACT)
		return
	if(do_after(user, 10 SECONDS, src))
		blackbox_status = BLACKBOX_EXPOSED

/obj/machinery/shuttle_comms/active/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(blackbox_status == BLACKBOX_EXPOSED)
		var/obj/item/blackbox/shuttle_comms/bbox = new /obj/item/blackbox/shuttle_comms(src)
		user.put_in_hands(bbox)
		blackbox_status = BLACKBOX_RETRIEVED
		set_distress(FALSE)

/obj/item/blackbox/shuttle_comms
	name = "blackbox"
	desc = "A dense data storage medium containing whatever messages were sent and received by the communications array it was taken from."

/datum/design/board/shuttle_comms
	name = "\proper machine design (comms array)"
	desc = "The circuit board for a comms array."
	id = "shuttle_comms"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/shuttle_comms
	category = list("Subspace Telecomms")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_SCIENCE

/datum/trader/echoes
	name = "Data Specialist"
	possible_origins = list("ECHOES")
	trade_flags = TRADER_MONEY
	speech = list("hail"    = "ECHOES data department. You have a blackbox?",
				"hail_deny"         = "All our operators are currently busy. Please try again later.",

				"trade_complete"    = "Enjoy your bounty.",
				"trade_no_goods"    = "Just check the bounties.",
				"trade_found_unwanted" = "I only need blackboxes.",
				"what_want"         = "If you find any busted up shuttles, get the blackbox from the comms array.",

				"compliment_deny"   = "Just doing my job.",
				"compliment_accept" = "Uh, okay. I mean, just doing my job.",
				"insult_good"       = "I just work here.",
				"insult_bad"        = "Seriously, I just work here.")
	possible_bounties = list(
		/datum/trader_bounty/blackbox = 100,
		)
	initial_bounty_gain_chance = 100
	bounty_gain_chance = 100

/datum/trader_bounty/blackbox
	bounty_name = "\proper blackbox retrieval"
	amount = 1
	reward_cash = 2000
	path = /obj/item/blackbox/shuttle_comms
	bounty_text = "We will reward you for retrieving the blackbox from any incapacitated shuttles that may be in the area."
	bounty_complete_text = "Thank you. Your reward is being transferred."

#undef BLACKBOX_INTACT
#undef BLACKBOX_EXPOSED
#undef BLACKBOX_RETRIEVED
