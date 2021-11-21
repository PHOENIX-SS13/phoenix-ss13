/obj/structure/mold
	anchored = TRUE
	/// Reference to our controller.
	var/datum/mold_controller/controller
	/// String of our faction.
	var/faction_type = FACTION_MOLD

/obj/structure/mold/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
		if(BURN)
			playsound(loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/mold/Destroy()
	controller = null
	playsound(src.loc, 'sound/effects/splat.ogg', 30, TRUE)
	return ..()

/datum/looping_sound/core_heartbeat
	mid_length = 3 SECONDS
	mid_sounds = list('hrzn/sound/effects/heart_beat_loop3.ogg'=1)
	volume = 20

/obj/structure/mold/core
	density = TRUE
	layer = TABLE_LAYER
	max_integrity = 550
	/// Type of our controller to be instantiated.
	var/controller_type = /datum/mold_controller
	/// Whether the core can attack nearby hostiles as its processing.
	var/can_attack = TRUE
	/// How much damage do we do on attacking
	var/attack_damage = 12
	/// What damage do we inflict on attacking
	var/attack_damage_type = BRUTE
	/// Tracks how long we should be attacking. After being hit the core is allowed to attack to retaliate
	var/attack_time = 0
	/// Whether we do a retaliate effect
	var/does_retaliate_effect = TRUE
	/// Cooldown for retaliate effect
	var/retaliate_effect_cooldown = 40 SECONDS
	/// Next retaliate effect.
	var/next_retaliate_effect = 0
	/// Heartbeat soundloop of the core.
	var/datum/looping_sound/core_heartbeat/soundloop

/obj/structure/mold/core/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	if(controller)
		controller.core_damaged()
	attack_time = world.time + 6 SECONDS
	if(does_retaliate_effect && next_retaliate_effect <= world.time)
		next_retaliate_effect = world.time + retaliate_effect_cooldown
		retaliate_effect()
	return ..()

/obj/structure/mold/core/Initialize()
	. = ..()
	controller = new controller_type(src)
	soundloop = new(list(src),  TRUE)
	START_PROCESSING(SSobj, src)

/obj/structure/mold/core/Destroy()
	STOP_PROCESSING(SSobj, src)
	soundloop.stop()
	QDEL_NULL(soundloop)
	if(controller)
		controller.core_death()
	return ..()

/obj/structure/mold/core/process(delta_time)
	if(attack_time <= world.time)
		return
	var/has_attacked = FALSE
	for(var/turf/range_turf as anything in RANGE_TURFS(1, loc))
		for(var/thing in range_turf)
			if(istype(thing, /mob/living))
				var/mob/living/living_thing = thing
				if(!(faction_type in living_thing.faction))
					living_thing.apply_damage(attack_damage, attack_damage_type)
					has_attacked = TRUE
			else if(istype(thing, /obj/vehicle/sealed/mecha))
				var/obj/vehicle/sealed/mecha/mecha_thing = thing
				mecha_thing.take_damage(attack_damage, attack_damage_type, MELEE, 0, get_dir(mecha_thing, src))
				has_attacked = TRUE
			if(has_attacked)
				playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
				do_attack_animation(thing, ATTACK_EFFECT_PUNCH)
				break
		if(has_attacked)
			break

/obj/structure/mold/core/proc/retaliate_effect()
	return

/obj/structure/mold/resin
	icon_state = "floor"
	density = FALSE
	plane = FLOOR_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN
	max_integrity = 50
	/// Whether this can be made wall resin, make sure the controller knows of that too
	var/can_be_made_wall_resin = TRUE
	//Are we a floor resin? If not then we're a wall resin
	var/floor = TRUE

/obj/structure/mold/resin/Initialize()
	. = ..()
	if(can_be_made_wall_resin)
		handle_wallability()

/obj/structure/mold/resin/Destroy()
	if(controller)
		controller.resin_death(src)
	return ..()

#define RESIN_FLOOR_DIR 16

/obj/structure/mold/resin/proc/handle_wallability()
	var/direction = RESIN_FLOOR_DIR
	var/turf/location = loc
	for(var/wall_dir in GLOB.cardinals)
		var/turf/new_turf = get_step(location, wall_dir)
		if(new_turf && new_turf.density)
			direction |= wall_dir

	for(var/obj/structure/mold/resin/other_resin in location)
		if(other_resin == src)
			continue
		if(other_resin.floor) //special
			direction &= ~RESIN_FLOOR_DIR
		else
			direction &= ~other_resin.dir

	var/list/dir_list = list()

	for(var/wall_dir in list(NORTH, SOUTH, EAST, WEST, RESIN_FLOOR_DIR))
		if(direction & wall_dir)
			dir_list += wall_dir

	if(dir_list.len)
		if(RESIN_FLOOR_DIR in dir_list)
			setDir(pick(GLOB.cardinals))
		else
			var/new_dir = pick(dir_list)
			floor = FALSE
			setDir(new_dir)
			switch(dir) //offset to make it be on the wall rather than on the floor
				if(NORTH)
					pixel_y = 32
				if(SOUTH)
					pixel_y = -32
				if(EAST)
					pixel_x = 32
				if(WEST)
					pixel_x = -32
			icon_state = "wall"
			plane = GAME_PLANE
			layer = ABOVE_NORMAL_TURF_LAYER
			obj_flags &= ~BLOCK_Z_OUT_DOWN
			update_appearance()

#undef RESIN_FLOOR_DIR

/obj/structure/mold/resin/wall
	floor = FALSE

/obj/structure/mold/wall
	density = TRUE
	opacity = TRUE
	max_integrity = 200
	CanAtmosPass = ATMOS_PASS_DENSITY

/obj/structure/mold/wall/Initialize()
	. = ..()
	var/turf/my_turf = get_turf(src)
	my_turf.ImmediateCalculateAdjacentTurfs()

/obj/structure/mold/wall/Destroy()
	if(controller)
		controller.wall_death(src)
	return ..()

/obj/structure/mold/structure
	density = TRUE

/obj/structure/mold/structure/Destroy()
	if(controller)
		controller.structure_death(src)
	return ..()
