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
		var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(linked_overmap_object.name, list(), mapzone, world.maxx, world.maxy, ALLOCATION_FULL, reservation_margin = 0)
		var/datum/parsed_map/pm = new(file("_maps/overmap/[linked_overmap_object.map_path]"))
		pm.load(vlevel.low_x, vlevel.low_y, vlevel.z_value, no_changeturf = FALSE)

/datum/overmap_object/custom
	var/map_path = null
	var/instances = 1