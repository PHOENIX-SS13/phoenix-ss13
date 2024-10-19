// dir determines the direction of travel to go upwards
// stairs require /turf/open/openspace as the tile above them to work, unless your stairs have 'force_open_above' set to TRUE
// multiple stair objects can be chained together; the Z level transition will happen on the final stair object in the chain

/obj/structure/stairs
	name = "stairs"
	icon = 'icons/obj/stairs.dmi'
	icon_state = "stairs"
	anchored = TRUE

/obj/structure/stairs/north
	dir = NORTH

/obj/structure/stairs/south
	dir = SOUTH

/obj/structure/stairs/east
	dir = EAST

/obj/structure/stairs/west
	dir = WEST

/obj/structure/stairs/Initialize(mapload)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_exit),
	)
	AddElement(/datum/element/connect_loc, src, loc_connections)
	update_appearance()
	return ..()

/obj/structure/stairs/proc/on_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER
	if(!isobserver(leaving) && direction == dir)
		INVOKE_ASYNC(src, PROC_REF(stair_ascend), leaving)
		return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/stairs/update_icon_state()
	icon_state = "stairs[get_stairs_destination() ? "_t" : null]"
	return ..()

/obj/structure/stairs/proc/get_openspace_above_turf()
	var/turf/my_turf = get_turf(src)
	var/turf/checking = get_step_multiz(my_turf, UP)
	if(!checking)
		return
	if(!checking.zPassIn(src, UP, my_turf))
		return
	return checking

/obj/structure/stairs/proc/get_stairs_destination()
	var/turf/checking = get_openspace_above_turf()
	if(!checking)
		return
	var/turf/target = get_step(checking, dir)
	return target

/obj/structure/stairs/proc/stair_ascend(atom/movable/AM)
	var/turf/checking = get_openspace_above_turf()
	if(!checking)
		return
	if(!checking.zPassIn(AM, UP, get_turf(src)))
		return
	var/turf/target = get_stairs_destination()
	if(!target)
		return
	if(isliving(AM))
		var/mob/living/L = AM
		if(!L.buckled)
			L.forceMove(target, TRUE)
	else
		AM.forceMove(target, TRUE)

/obj/structure/stairs/intercept_zImpact(atom/movable/AM, levels = 1)
	. = ..()
	if(levels <= 1)
		. |= FALL_GRACEFUL
