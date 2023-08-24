//defining broadcast station on overmap
/datum/overmap_object/custom/broadcast_station
	name = "Broadcast Station"
	description = "A commercial broadcast radio station, built into a carved-out asteroid."
	visual_type = /obj/effect/abstract/overmap/broadcast_station
	clears_hazards_on_spawn = TRUE
	can_be_docked = TRUE
	map_path = "broadcast_station.dmm"
	instances = 1

/obj/effect/abstract/overmap/broadcast_station
	icon_state = "broadcast_station"
	color = COLOR_MOSTLY_PURE_PINK
	layer = OVERMAP_LAYER_STATION

//area defines
/area/ruin/space/broadcast_station
	name = "Broadcast Station"
	icon_state = "tcomsatcham"
	has_gravity = STANDARD_GRAVITY
	outdoors = FALSE
	requires_power = TRUE
	always_unpowered = FALSE
	sound_environment = SOUND_AREA_STANDARD_STATION
	power_equip = TRUE
	power_light = TRUE
	power_environ = TRUE

/area/ruin/space/broadcast_station/waste
	name = "Broadcast Station Waste Release"
	icon_state = "atmos"
	outdoors = TRUE
	requires_power = FALSE
	has_gravity = FALSE

//Tcomms item subtypes

/obj/item/encryptionkey/broadcast
	name = "broadcast encryption key"
	icon_state = "srv_cypherkey"
	color = COLOR_MOSTLY_PURE_PINK
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
