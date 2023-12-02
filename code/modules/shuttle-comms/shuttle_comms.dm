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
	icon = 'icons/obj/computer.dmi'
	icon_state = "computer"
	use_power = NO_POWER_USE
	max_integrity = 200
	armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 60, BIO = 60, RAD = 60, FIRE = 60, ACID = 60)
	verb_say = "buzzes"
	verb_yell = ""
	var/build_step = 0
	var/obj/item/radio/intercom/wideband/internal_radio = null

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
	. += SPAN_NOTICE("Its radio is tuned to the [frequency / 10] wavelength. The speaker is [listening ? "on" : "off"], and the microphone is [broadcasting ? "on" : "off"].")
	. += SPAN_INFO("You can toggle the microphone with alt+click and the speaker with alt+rclick.")
