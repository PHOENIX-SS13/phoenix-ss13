SUBSYSTEM_DEF(overmapcustoms)
	name = "Overmap Customs"
	init_order = INIT_ORDER_MAPPING - 1 //right after mapping init
	runlevels = RUNLEVELS_DEFAULT
	flags = SS_NO_FIRE
	var/list/datum/overmap_object/custom/objlist

/datum/controller/subsystem/overmapcustoms/Initialize(timeofday)
	for(var/typepath in subtypesof(/datum/overmap_object/custom))
		var/datum/overmap_object/custom/path_loading = typepath
		loadOvermapCustom(path_loading)
	return ..()

/datum/controller/subsystem/overmapcustoms/proc/loadOvermapCustom(datum/overmap_object/custom/obj)
	var/i
	for(i=0, i<initial(obj.instances), i++)
		var/datum/overmap_object/custom/linked_overmap_object = new obj(SSovermap.main_system, rand(5,20), rand(5,20))
		var/datum/map_zone/mapzone = SSmapping.create_map_zone(linked_overmap_object.name, linked_overmap_object)
		var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(linked_overmap_object.name, list(), mapzone, linked_overmap_object.size["width"], linked_overmap_object.size["height"], ALLOCATION_FULL, reservation_margin = 0)
		var/datum/parsed_map/pm = new(file("_maps/overmap/[linked_overmap_object.map_path]"))
		pm.load(vlevel.low_x, vlevel.low_y, vlevel.z_value, no_changeturf = FALSE)


//THINGS TO DEFINE IF YOU WANT TO MAKE A NEW ONE
/datum/overmap_object/custom
	name = "Custom Overmap Object"
	var/map_path = null			//relative to _maps/overmap/
	var/list/size = list("width" = 50, "height" = 50)
	var/instances = 1			//how many to put on the overmap
	visual_type = /obj/effect/abstract/overmap/hazard
	clears_hazards_on_spawn = TRUE
	can_be_docked = FALSE		//can this be docked from the overmap through Shuttle Controls?

/obj/effect/abstract/overmap/custom
	icon_state = "event"
	color = COLOR_GREEN
	layer = OVERMAP_LAYER_STATION
//end THINGS TO DEFINE IF YOU WANT TO MAKE A NEW ONE

/client/verb/overmap_ghost()
	set name = "Overmap Ghost"
	set category = "OOC"
	var/can_ghost = TRUE

	if (!isobserver(usr))
		can_ghost = admin_ghost()

	if(!can_ghost)
		to_chat(src, SPAN_INTERFACE("You can only do this as an admin or a ghost!"), confidential = TRUE)
		return FALSE

	var/mob/dead/observer/observer = usr
	to_chat(src, SPAN_INTERFACE("Ghosting to overmap."), confidential = TRUE)
	var/obj/effect/abstract/overmap/ovmobj = locate(/obj/effect/abstract/overmap/shuttle/station)
	if(!ovmobj)
		ovmobj = locate(/obj/effect/abstract/overmap/shuttle)
	observer.ManualFollow(ovmobj)
	return
