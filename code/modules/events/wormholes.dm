/datum/round_event_control/wormholes
	name = "Wormholes"
	typepath = /datum/round_event/wormholes
	max_occurrences = 3
	weight = 2
	min_players = 2

	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL)


/datum/round_event/wormholes
	announceWhen = 10
	endWhen = 90

	var/list/pick_turfs
	var/list/pick_areas
	var/list/wormholes = list()
	var/shift_frequency = 10
	var/pairs_of_wormholes = 150
	/// Amount of pairs to persist and stabilize. Randomized in setup()
	var/pairs_to_persist = 0

/datum/round_event/wormholes/setup()
	announceWhen = rand(0, 20)
	endWhen = rand(70, 100)
	pairs_to_persist = rand(1, 3)

/datum/round_event/wormholes/start()
	pick_turfs = SSmapping.station_map_zone.get_block()
	pick_areas = GLOB.the_station_areas
	for(var/i in 1 to pairs_of_wormholes)
		var/turf/turf_one = random_wormhole_turf()
		var/turf/turf_two = random_wormhole_turf()
		var/obj/effect/portal/wormhole/wormhole_one = new /obj/effect/portal/wormhole(turf_one, 0, null, FALSE)
		var/obj/effect/portal/wormhole/wormhole_two = new /obj/effect/portal/wormhole(turf_two, 0, null, FALSE)
		wormhole_one.linked = wormhole_two
		wormhole_two.linked = wormhole_one
		if(pairs_to_persist)
			pairs_to_persist--
			wormhole_one.will_persist = TRUE
			wormhole_two.will_persist = TRUE
		wormholes += wormhole_one
		wormholes += wormhole_two

/// Picks a semi-random turf across the station z levels for the wormholes to spawn in / move to
/datum/round_event/wormholes/proc/random_wormhole_turf()
	if(prob(50))
		return pick(pick_turfs)
	else
		var/area/picked_area = pick(pick_areas)
		return pick(get_area_turfs(picked_area))

/datum/round_event/wormholes/announce(fake)
	priority_announce("Space-time anomalies detected on the station. There is no additional data.", "Anomaly Alert", ANNOUNCER_SPANOMALIES)

/datum/round_event/wormholes/tick()
	if(activeFor % shift_frequency == 0)
		for(var/obj/effect/portal/wormhole/wormhole as anything in wormholes)
			var/turf/picked_turf = random_wormhole_turf()
			wormhole.forceMove(picked_turf)

/datum/round_event/wormholes/end()
	for(var/obj/effect/portal/wormhole/wormhole as anything in wormholes)
		if(wormhole.will_persist)
			wormhole.make_stable()
			announce_to_ghosts(wormhole)
			continue
		qdel(wormhole)
	wormholes = null

/obj/effect/portal/wormhole
	name = "wormhole"
	desc = "It looks highly unstable; It could close at any moment."
	icon = 'icons/obj/objects.dmi'
	icon_state = "anom"
	mech_sized = TRUE
	var/stable = FALSE
	/// Keeping track of which will persist, to make stable and not delete when the event ends
	var/will_persist = FALSE

/obj/effect/portal/wormhole/examine(mob/user)
	. = ..()
	if(stable)
		. += SPAN_NOTICE("Using an anomaly neutralizer may destabilize the wormhole.")

/obj/effect/portal/wormhole/update_icon_state()
	. = ..()
	icon_state = stable ? "anom_stable" : "anom"

/obj/effect/portal/wormhole/teleport(atom/movable/movable_atom)
	if(!linked)
		return
	if(iseffect(movable_atom)) //sparks don't teleport
		return
	if(movable_atom.anchored)
		if(!(ismecha(movable_atom) && mech_sized))
			return

	if(ismovable(movable_atom))
		///You will appear adjacent to the beacon
		var/turf/target_turf = linked.loc
		do_teleport(movable_atom, target_turf, TRUE, TRUE, FALSE, FALSE, channel = TELEPORT_CHANNEL_WORMHOLE)

/obj/effect/portal/wormhole/attackby(obj/item/weapon, mob/user, params)
	if(stable && istype(weapon, /obj/item/anomaly_neutralizer))
		to_chat(user, SPAN_NOTICE("You destabilize \the [src] with \the [weapon]."))
		destabilize()
		qdel(weapon)
		return
	return ..()

/// Make it visually stable and be able to be interacted with some rnd devices and such.
/obj/effect/portal/wormhole/proc/make_stable()
	stable = TRUE
	name = "stable wormhole"
	desc = "This one doesn't look too unstable."
	update_appearance()

/// 66.6% something bad happens
#define WORMHOLE_DESTAB_FIRE 1
#define WORMHOLE_DESTAB_EMP 2
#define WORMHOLE_DESTAB_NOTHING 3
#define WORMHOLE_DESTAB_EFFECTS 3

/// When an anomaly neutralizer is used on a stable wormhole
/obj/effect/portal/wormhole/proc/destabilize()
	var/obj/effect/portal/wormhole/wormhole_two = linked
	/// Save their locations before closing
	var/turf/turf_one = loc
	var/turf/turf_two = wormhole_two.loc

	/// Close them first so we dont teleport any effects of destabilization around
	close_from_neutralizer()
	wormhole_two.close_from_neutralizer()

	/// Roll the funny effect!
	var/rand_roll = rand(1, WORMHOLE_DESTAB_EFFECTS)
	switch(rand_roll)
		if(WORMHOLE_DESTAB_FIRE)
			/// Create a small fire at both of the spots where anomalies used to be.
			turf_one.atmos_spawn_air("o2=20;plasma=40;TEMP=600")
			turf_two.atmos_spawn_air("o2=20;plasma=40;TEMP=600")
		if(WORMHOLE_DESTAB_EMP)
			/// EMP at both spots of where the anomalies used to be.
			empulse(turf_one, 4, 1)
			empulse(turf_two, 4, 1)
	/// Create an anomaly core at either of the places where wormholes used to be.
	var/turf/location = prob(50) ? turf_one : turf_two
	new /obj/item/raw_anomaly_core/random(location)

#undef WORMHOLE_DESTAB_FIRE
#undef WORMHOLE_DESTAB_EMP
#undef WORMHOLE_DESTAB_NOTHING
#undef WORMHOLE_DESTAB_EFFECTS

/// Do some effects and close
/obj/effect/portal/wormhole/proc/close_from_neutralizer()
	do_sparks(5, FALSE, src)
	qdel(src)
