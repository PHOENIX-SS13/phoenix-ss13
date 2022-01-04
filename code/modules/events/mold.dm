/datum/round_event_control/mold
	name = "Mold"
	typepath = /datum/round_event/mold
	weight = 10
	max_occurrences = 2

	min_players = 20

	track = EVENT_TRACK_MAJOR
	tags = list(TAG_DESTRUCTIVE, TAG_COMBAT)

/datum/round_event/mold
	announceWhen = 120

/datum/round_event/mold/setup()
	announceWhen = rand(120, 180)

/datum/round_event/mold/announce(fake)
	priority_announce("Confirmed outbreak of level 6 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", ANNOUNCER_OUTBREAK5)

#define MOLD_CORES_TO_PICK list(\
	/obj/structure/mold/core/classic/fire,\
	/obj/structure/mold/core/classic/emp,\
	/obj/structure/mold/core/classic/fungus,\
	/obj/structure/mold/core/classic/toxic\
	)

/datum/round_event/mold/start()
	if(!GLOB.xeno_spawn.len)
		WARNING("Unable to spawn Mold event due to lack of xeno spawn markers on the map.")
		return
	var/turf/spot = pick(GLOB.xeno_spawn)
	var/mold_core_type = pick(MOLD_CORES_TO_PICK)
	var/obj/mold_core = new mold_core_type(spot)
	announce_to_ghosts(mold_core)
	
#undef MOLD_CORES_TO_PICK
