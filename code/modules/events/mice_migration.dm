/datum/round_event_control/mice_migration
	name = "Mice Migration"
	typepath = /datum/round_event/mice_migration
	weight = 10

	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_COMMUNAL)

/datum/round_event_control/mice_migration/roundstart
	name = "Mice Shelter"
	roundstart = TRUE
	min_players = 15 //Mice are REALLY annoying for lowpop, especially if it's a roundstart tedium to do

/datum/round_event/mice_migration
	var/minimum_mice = 5
	var/maximum_mice = 15

/datum/round_event/mice_migration/announce(fake)
	var/cause = pick("space-winter", "budget-cuts", "Ragnarok",
		"space being cold", "\[REDACTED\]", "climate change",
		"bad luck")
	var/plural = pick("a number of", "a horde of", "a pack of", "a swarm of",
		"a whoop of", "not more than [maximum_mice]")
	var/name = pick("rodents", "mice", "squeaking things",
		"wire eating mammals", "\[REDACTED\]", "energy draining parasites")
	var/movement = pick("migrated", "swarmed", "stampeded", "descended")
	var/location = pick("maintenance tunnels", "maintenance areas",
		"\[REDACTED\]", "place with all those juicy wires")

	priority_announce("Due to [cause], [plural] [name] have [movement] \
		into the [location].", "Migration Alert",
		'sound/effects/mousesqueek.ogg')

/datum/round_event/mice_migration/start()
	trigger_migration(rand(minimum_mice, maximum_mice))

/datum/round_event/mice_migration/proc/find_exposed_wires()
	var/list/exposed_wires = list()

	var/list/all_turfs
	for(var/datum/sub_map_zone/subzone in SSmapping.sub_zones_by_trait(ZTRAIT_STATION))
		all_turfs += subzone.get_block()
	for(var/turf/open/floor/plating/T in all_turfs)
		if(T.is_blocked_turf())
			continue
		if(locate(/obj/structure/cable) in T)
			exposed_wires += T

	return shuffle(exposed_wires)

#define PROB_MOUSE_SPAWN 98

/datum/round_event/mice_migration/proc/trigger_migration(num_mice=10)
	var/list/exposed_wires = find_exposed_wires()

	var/mob/living/simple_animal/mouse/mouse
	var/turf/proposed_turf

	while((num_mice > 0) && exposed_wires.len)
		proposed_turf = pick_n_take(exposed_wires)
		if(prob(PROB_MOUSE_SPAWN))
			if(!mouse)
				mouse = new(proposed_turf)
			else
				mouse.forceMove(proposed_turf)
		else
			mouse = new /mob/living/simple_animal/hostile/regalrat/controlled(proposed_turf)
		if(mouse.environment_air_is_safe())
			num_mice -= 1
			mouse = null

#undef PROB_MOUSE_SPAWN
