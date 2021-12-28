SUBSYSTEM_DEF(minor_mapping)
	name = "Minor Mapping"
	init_order = INIT_ORDER_MINOR_MAPPING
	flags = SS_NO_FIRE

/datum/controller/subsystem/minor_mapping/Initialize(timeofday)
	place_satchels()
	return ..()

/datum/controller/subsystem/minor_mapping/proc/place_satchels(amount=10)
	var/list/turfs = find_satchel_suitable_turfs()

	while(turfs.len && amount > 0)
		var/turf/T = pick_n_take(turfs)
		var/obj/item/storage/backpack/satchel/flat/F = new(T)

		SEND_SIGNAL(F, COMSIG_OBJ_HIDE, T.intact)
		amount--

/proc/find_satchel_suitable_turfs()
	var/list/suitable = list()

	for(var/datum/sub_map_zone/subzone in SSmapping.sub_zones_by_trait(ZTRAIT_STATION))
		for(var/t in subzone.get_block())
			if(isfloorturf(t) && !isplatingturf(t))
				suitable += t

	return shuffle(suitable)

