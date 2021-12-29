/datum/map_generator_module/bottom_layer/repair_floor_plasteel
	spawnableTurfs = list(/turf/open/floor/iron = 100)
	var/ignore_wall = FALSE
	allowAtomsOnSpace = TRUE

/datum/map_generator_module/bottom_layer/repair_floor_plasteel/place(turf/T)
	if(isclosedturf(T) && !ignore_wall)
		return FALSE
	return ..()

/datum/map_generator_module/bottom_layer/repair_floor_plasteel/flatten
	ignore_wall = TRUE

/datum/map_generator_module/border/normal_walls
	spawnableAtoms = list()
	spawnableTurfs = list(/turf/closed/wall = 100)
	allowAtomsOnSpace = TRUE

/datum/map_generator/repair
	modules = list(/datum/map_generator_module/bottom_layer/repair_floor_plasteel,
	/datum/map_generator_module/bottom_layer/repressurize)
	buildmode_name = "Repair: Floor"

/datum/map_generator/repair/delete_walls
	modules = list(/datum/map_generator_module/bottom_layer/repair_floor_plasteel/flatten,
	/datum/map_generator_module/bottom_layer/repressurize)
	buildmode_name = "Repair: Floor: Flatten Walls"

/datum/map_generator/repair/enclose_room
	modules = list(/datum/map_generator_module/bottom_layer/repair_floor_plasteel/flatten,
	/datum/map_generator_module/border/normal_walls,
	/datum/map_generator_module/bottom_layer/repressurize)
	buildmode_name = "Repair: Generate Aired Room"

