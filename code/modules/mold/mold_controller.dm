/datum/mold_controller
	/// What resin type are we gonna spawn.
	var/resin_type = /obj/structure/mold/resin
	/// What wall type are we gonna spawn.
	var/wall_type = /obj/structure/mold/wall
	/// Types of structures we can spawn.
	var/list/structure_types
	/// How much progress to spreading we get per second.
	var/spread_progress_per_second = 20
	/// Probably of resin attacking structures per process
	var/attack_prob = 20
	/// Probability of resin making a wall when able per process
	var/wall_prob = 30
	/// Whether we can put resin on walls. This slows down the expansion and will cause the structures to be more densely packed.
	var/can_do_wall_resin = TRUE
	/// Whether the resin can attack.
	var/can_attack = TRUE
	/// Whether the resin can attack doors.
	var/resin_attacks_doors = TRUE
	/// Whether the resin can attack windows.
	var/resin_attacks_windows = FALSE
	/// Whether the resin can spawn walls.
	var/spawns_walls = TRUE
	/// Whether the resin can spawn walls to seal off vaccuum.
	var/wall_off_vaccuum = TRUE
	/// Whether the resin can spawn walls to seal off planetary environments.
	var/wall_off_planetary = TRUE
	/// How many times do we need to spread to spawn an extra structure.
	var/spreads_for_structure = 30
	/// What's the type of our death behaviour.
	var/death_behaviour = MOLD_CORE_DEATH_SLOW_DECAY
	/// Whether we do an initial expansion.
	var/do_initial_expansion = TRUE
	/// How many spread in our initial expansion.
	var/initial_expansion_spreads = 30
	/// How many structures in our initial expansion.
	var/initial_expansion_structures = 3

	//Internal vars
	/// All active resin under this controller.
	var/list/active_resin = list()
	/// All resin under this controller.
	var/list/all_resin = list()
	/// All structures under this controller.
	var/list/all_structures = list()
	/// All walls under this controller.
	var/list/all_walls = list()
	/// Reference to our core.
	var/obj/structure/mold/core/core
	/// Progress to the next resin spread.
	var/spread_progress = 0
	/// Progress to spawning the next structure.
	var/structure_progression = 0
	/// Next time we activate nearby resin when core is damaged.
	var/next_core_damage_resin_activation = 0

/datum/mold_controller/New(obj/structure/mold/core/new_core)
	. = ..()
	core = new_core
	START_PROCESSING(SSobj, src)
	if(do_initial_expansion)
		initial_expansion()

/datum/mold_controller/Destroy()
	//Clear references
	active_resin = null
	if(core)
		core.controller = null
	for(var/obj/structure/mold/mold_thing as anything in all_resin)
		mold_thing.controller = null
	for(var/obj/structure/mold/mold_thing as anything in all_structures)
		mold_thing.controller = null
	for(var/obj/structure/mold/mold_thing as anything in all_walls)
		mold_thing.controller = null

	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/mold_controller/process(delta_time)
	if(!core)
		if(death_behaviour == MOLD_CORE_DEATH_SLOW_DECAY)
			handle_slow_decay()
		else
			WARNING("Mold controller has no post core behaviours and isn't deleting.")
		return
	spread_progress += spread_progress_per_second * delta_time
	var/spread_times = 0
	while(spread_progress >= 100)
		spread_progress -= 100
		spread_times++

	var/first_process_spread = FALSE
	if(spread_times)
		first_process_spread = TRUE
		spread_times--

	resin_process(first_process_spread, TRUE)

	if(spread_times)
		for(var/i in 1 to spread_times)
			resin_process(TRUE, FALSE)

/// The process of handling active resin behaviours
/datum/mold_controller/proc/resin_process(do_spread, do_attack, progress_structure = TRUE)
	// If no resin, spawn one under our core.
	if(!length(all_resin))
		spawn_resin(get_turf(core), resin_type)

	// If no active resin, make all active and let the process figure it out.
	if(!length(active_resin))
		active_resin = all_resin.Copy()

	var/list/spread_turf_canidates = list()
	for(var/obj/structure/mold/resin/resin as anything in active_resin)
		var/could_attack = FALSE
		var/could_do_wall = FALSE

		var/turf/resin_turf = get_turf(resin)

		var/tasks = 0

		if(do_attack && can_attack)
			for(var/turf/open/adjacent_open in get_adjacent_open_turfs(resin))
				for(var/obj/object in adjacent_open)
					if(object.density && \
						(resin_attacks_doors && \
							(istype(object, /obj/machinery/door/airlock) || istype(object, /obj/machinery/door/firedoor)  || istype(object, /obj/structure/door_assembly))\
							)\
						|| \
						(resin_attacks_windows && \
							(istype(object, /obj/structure/window)))
						)
						could_attack = TRUE
						tasks++
						if(prob(attack_prob))
							resin.do_attack_animation(object, ATTACK_EFFECT_PUNCH)
							playsound(object, 'sound/effects/attackblob.ogg', 50, TRUE)
							object.take_damage(40, BRUTE, MELEE, 1, get_dir(object, resin))
						break
				if(could_attack)
					break
		if(do_spread)
			for(var/turf/open/adjacent_open in resin_turf.atmos_adjacent_turfs + resin_turf)
				if(spawns_walls && !could_do_wall)
					if((wall_off_vaccuum && isspaceturf(adjacent_open)) || (wall_off_planetary && adjacent_open.planetary_atmos))
						could_do_wall = TRUE
						tasks++
						if(prob(wall_prob))
							spawn_wall(resin_turf, wall_type)
						continue

				///Check if we can place resin in here
				if(isopenspaceturf(adjacent_open))
					//If we're trying to place on an openspace turf, make sure there's a non openspace turf adjacent
					var/forbidden = TRUE
					for(var/turf/range_turf as anything in RANGE_TURFS(1, adjacent_open))
						if(!isopenspaceturf(range_turf))
							forbidden = FALSE
							break
					if(forbidden)
						continue
				var/resin_count = 0
				var/place_count = 1
				for(var/obj/structure/mold/resin/iterated_resin in adjacent_open)
					resin_count++
				if(can_do_wall_resin)
					for(var/wall_dir in GLOB.cardinals)
						var/turf/step_turf = get_step(adjacent_open, wall_dir)
						if(step_turf.density)
							place_count++
				if(resin_count < place_count)
					tasks++
					spread_turf_canidates[adjacent_open] = TRUE

		//If it tried to spread and attack and failed to do any task, remove from active
		if(!tasks && do_spread && do_attack)
			active_resin -= resin

	if(length(spread_turf_canidates))
		var/turf/picked_turf = pick(spread_turf_canidates)
		spawn_resin(picked_turf, resin_type)

		if(progress_structure && structure_types)
			structure_progression++
		if(structure_progression >= spreads_for_structure)
			var/obj/structure/mold/structure/existing_structure = locate() in picked_turf
			if(!existing_structure)
				structure_progression -= spreads_for_structure
				spawn_structure(picked_turf, pick(structure_types))

/// Spawns and registers a resin at location
/datum/mold_controller/proc/spawn_resin(turf/location, resin_type)
	//Spawn effect
	for(var/obj/machinery/light/light_in_place in location)
		light_in_place.break_light_tube()

	var/obj/structure/mold/resin/new_resin = new resin_type(location)
	new_resin.controller = src
	active_resin += new_resin
	all_resin += new_resin

/// Spawns and registers a wall at location
/datum/mold_controller/proc/spawn_wall(turf/location, wall_type)
	var/obj/structure/mold/wall/new_wall = new wall_type(location)
	new_wall.controller = src
	all_walls += new_wall

/// Spawns and registers a structure at location
/datum/mold_controller/proc/spawn_structure(turf/location, structure_type)
	var/obj/structure/mold/structure/new_structure = new structure_type(location)
	new_structure.controller = src
	all_structures += new_structure

/// When a resin dies, called by resin
/datum/mold_controller/proc/resin_death(obj/structure/mold/resin/dying_resin)
	all_resin -= dying_resin
	active_resin -= dying_resin
	activate_resin_nearby(dying_resin.loc, 2)

/// When a wall dies, called by wall
/datum/mold_controller/proc/wall_death(obj/structure/mold/wall/dying_wall)
	all_walls -= dying_wall
	activate_resin_nearby(dying_wall.loc, 2)

/// When a structure dies, called by structure
/datum/mold_controller/proc/structure_death(obj/structure/mold/structure/dying_structure)
	all_structures -= dying_structure
	activate_resin_nearby(dying_structure.loc, 2)

/// When a core dies, called by core
/datum/mold_controller/proc/core_death()
	core = null
	switch(death_behaviour)
		if(MOLD_CORE_DEATH_DO_NOTHING)
			qdel(src)
		if(MOLD_CORE_DEATH_DELETE_ALL)
			delete_everything()
		if(MOLD_CORE_DEATH_SLOW_DECAY)
			delete_everything(TRUE)

/// Deletes everything, unless an argument is passed, then it just deletes structures
/datum/mold_controller/proc/delete_everything(just_structures = FALSE)
	for(var/obj/structure/mold/mold_thing as anything in all_structures)
		qdel(mold_thing)
	for(var/obj/structure/mold/mold_thing as anything in all_walls)
		qdel(mold_thing)
	if(just_structures)
		return
	for(var/obj/structure/mold/mold_thing as anything in all_resin)
		qdel(mold_thing)
	qdel(core)
	qdel(src)

/// Handles slow decay when core is dead, slowly removing resin and then qdelling self
/datum/mold_controller/proc/handle_slow_decay()
	if(!length(all_resin))
		qdel(src)
		return
	var/obj/structure/mold/resin/some_resin = all_resin[all_resin.len]
	qdel(some_resin)

/// The initial expansion process of a mold, spawns some resin, and then spawns sturctures
/datum/mold_controller/proc/initial_expansion()
	for(var/i in 1 to initial_expansion_spreads)
		resin_process(TRUE, FALSE, FALSE)
	spawn_structures(initial_expansion_structures)

/// Spawns an amount of structured across all resin, guaranteed to spawn atleast 1 of each type
/datum/mold_controller/proc/spawn_structures(amount)
	if(!structure_types)
		return
	var/list/locations = list()
	for(var/obj/structure/mold/mold_thing as anything in all_resin)
		locations[mold_thing.loc] = TRUE
	var/list/guaranteed_structures = structure_types.Copy()
	for(var/i in 1 to amount)
		if(!length(locations))
			break
		var/turf/location = pick(locations)
		locations -= location
		var/structure_to_spawn
		if(length(guaranteed_structures))
			structure_to_spawn = pick_n_take(guaranteed_structures)
		else
			structure_to_spawn = pick(structure_types)
		spawn_structure(location, structure_to_spawn)

/// Activates resin of this controller in a range around a location, following atmos adjacency.
/datum/mold_controller/proc/activate_resin_nearby(turf/location, range)
	var/list/turfs_to_check = list()
	turfs_to_check[location] = TRUE

	if(range)
		var/list/turfs_to_iterate = list()
		var/list/new_iteration_list = list()
		turfs_to_iterate[location] = TRUE
		for(var/i in 1 to range)
			for(var/turf/iterated_turf as anything in turfs_to_iterate)
				for(var/turf/adjacent_turf as anything in iterated_turf.atmos_adjacent_turfs)
					if(!turfs_to_check[adjacent_turf])
						new_iteration_list[adjacent_turf] = TRUE
					turfs_to_check[adjacent_turf] = TRUE
			turfs_to_iterate = new_iteration_list

	for(var/turf/iterated_turf as anything in turfs_to_check)
		for(var/obj/structure/mold/resin/mold_resin in iterated_turf)
			if(mold_resin.controller == src && !QDELETED(mold_resin))
				active_resin |= mold_resin

/// When the core is damaged, activate nearby resin just to make sure that we've sealed up walls near the core, which could be important to prevent cheesing.
/datum/mold_controller/proc/core_damaged()
	if(next_core_damage_resin_activation <= world.time)
		next_core_damage_resin_activation = world.time + 20 SECONDS
		activate_resin_nearby(core.loc, 6)
