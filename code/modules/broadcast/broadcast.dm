//Spawning broadcast station on overmap

SUBSYSTEM_DEF(broadcast)
	name = "Broadcast"
	init_order = INIT_ORDER_NETWORKS - 1
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	var/station

/datum/controller/subsystem/broadcast/Initialize(timeofday)
	var/datum/overmap_object/linked_overmap_object = new /datum/overmap_object/broadcast_station(SSovermap.main_system, rand(5,20), rand(5,20))
	var/datum/map_zone/mapzone = SSmapping.create_map_zone("Broadcast Station", linked_overmap_object)
	var/datum/virtual_level/vlevel = SSmapping.create_virtual_level("Broadcast Station", ZTRAITS_SPACE, mapzone, world.maxx, world.maxy, ALLOCATION_FULL, reservation_margin = 2)
	var/datum/parsed_map/pm = new(file("_maps/RandomRuins/SpaceRuins/broadcast_station.dmm"))
	pm.load(vlevel.low_x, vlevel.low_y, vlevel.z_value, no_changeturf = TRUE)
	flags |= SS_NO_FIRE
	return ..()
	
//defining broadcast station on overmap

/datum/overmap_object/broadcast_station
	name = "Broadcast Station"
	visual_type = /obj/effect/abstract/overmap/trade_hub
	clears_hazards_on_spawn = TRUE

/obj/effect/abstract/overmap/broadcast_station
	icon_state = "trade"
	color = COLOR_MOSTLY_PURE_PINK
	layer = OVERMAP_LAYER_STATION

//Tcomms item subtypes

/obj/item/encryptionkey/broadcast
	name = "broadcast encryption key"
	icon_state = "srv_cypherkey"
	channels = list(RADIO_CHANNEL_BROADCAST = 1)

/obj/item/radio/headset/headset_broadcast
	name = "Broadcast Headset"
	desc = "Headset used by radio station staff."
	icon_state = "srv_headset"
	keyslot = new /obj/item/encryptionkey/broadcast

/obj/machinery/telecomms/broadcaster/preset_broadcast
	id = "Broadcast Broadcaster"
	network = "tcommsat"
	autolinkers = list("broadcast")
	freq_listening = list(FREQ_BROADCAST, FREQ_COMMON)

/obj/machinery/telecomms/bus/preset_broadcast
	id = "Bus 3"
	network = "tcommsat"
	freq_listening = list(FREQ_BROADCAST, FREQ_COMMON)
	autolinkers = list("broadcast")

/obj/machinery/telecomms/processor/preset_broadcast
	id = "Processor 3"
	network = "tcommsat"
	autolinkers = list("broadcast")
	freq_listening = list(FREQ_BROADCAST, FREQ_COMMON)

/obj/machinery/telecomms/receiver/preset_broadcast
	id = "Broadcast Receiver"
	network = "tcommsat"
	autolinkers = list("broadcast") // link to relay
	freq_listening = list(FREQ_BROADCAST, FREQ_COMMON)

/obj/machinery/telecomms/relay/preset/broadcast
	id = "Broadcast Relay"
	autolinkers = list("broadcast")
	freq_listening = list(FREQ_BROADCAST, FREQ_COMMON)