/turf/closed/wall/mineral/cult
	name = "runed metal wall"
	desc = "A cold metal wall engraved with indecipherable symbols. Studying them causes your head to pound."
	icon = 'icons/turf/walls/cult_wall.dmi'
	smoothing_flags = SMOOTH_BITMASK
	canSmoothWith = null
	plating_material = /datum/material/runedmetal
	color = "#3C3434" //To display in mapping softwares

/turf/closed/wall/mineral/cult/Initialize()
	new /obj/effect/temp_visual/cult/turf(src)
	. = ..()

/turf/closed/wall/mineral/cult/Exited(atom/movable/gone, direction)
	. = ..()
	if(istype(gone, /mob/living/simple_animal/hostile/construct/harvester)) //harvesters can go through cult walls, dragging something with
		var/mob/living/simple_animal/hostile/construct/harvester/H = gone
		var/atom/movable/stored_pulling = H.pulling
		if(stored_pulling)
			stored_pulling.setDir(direction)
			stored_pulling.forceMove(src)
			H.start_pulling(stored_pulling, supress_message = TRUE)

/turf/closed/wall/mineral/cult/artificer
	name = "runed stone wall"
	desc = "A cold stone wall engraved with indecipherable symbols. Studying them causes your head to pound."

/turf/closed/wall/mineral/cult/artificer/break_wall()
	new /obj/effect/temp_visual/cult/turf(get_turf(src))
	return null //excuse me we want no runed metal here

/turf/closed/wall/mineral/cult/artificer/devastate_wall()
	new /obj/effect/temp_visual/cult/turf(get_turf(src))

/turf/closed/wall/vault
	name = "strange wall"
	smoothing_flags = NONE
	canSmoothWith = null
	smoothing_groups = null
	rcd_memory = null

/turf/closed/wall/vault/rock
	name = "rocky wall"
	desc = "You feel a strange nostalgia from looking at this..."

/turf/closed/wall/vault/alien
	name = "alien wall"
	icon_state = "alienvault"
	base_icon_state = "alienvault"

/turf/closed/wall/vault/sandstone
	name = "sandstone wall"
	icon_state = "sandstonevault"
	base_icon_state = "sandstonevault"

/turf/closed/wall/ice
	desc = "A wall covered in a thick sheet of ice."
	smoothing_flags = SMOOTH_BITMASK
	canSmoothWith = null
	rcd_memory = null
	hardness = 35
	slicing_duration = 150 //welding through the ice+metal
	bullet_sizzle = TRUE

/turf/closed/wall/rust
	name = "rusted wall"
	desc = "A rusted metal wall."
	hardness = 45
	rusted = TRUE

/turf/closed/wall/r_wall/rust
	name = "rusted reinforced wall"
	desc = "A huge chunk of rusted reinforced metal."
	hardness = 15
	rusted = TRUE

/turf/closed/wall/mineral/bronze
	name = "clockwork wall"
	desc = "A huge chunk of bronze, decorated like gears and cogs."
	smoothing_flags = SMOOTH_BITMASK
	plating_material = /datum/material/bronze
	color = "#92661A" //To display in mapping softwares

/turf/closed/wall/concrete
	name = "concrete wall"
	desc = "A dense slab of reinforced stone, not much will get through this."
	hardness = 10
	explosion_block = 2
	rad_insulation = RAD_HEAVY_INSULATION

/turf/closed/wall/concrete/deconstruction_hints(mob/user)
	return SPAN_NOTICE("Nothing's going to cut that.")

/turf/closed/wall/concrete/try_decon(obj/item/I, mob/user, turf/T)
	if(I.tool_behaviour == TOOL_WELDER)
		to_chat(user, SPAN_WARNING("This wall is way too hard to cut through!"))
	return FALSE
