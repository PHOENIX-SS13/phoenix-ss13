///This spawner clears the terrain of flora and other stuff, and ScrapeAway's mineral turfs
/obj/effect/spawner/clear
	name = "clear terrain"

/obj/effect/spawner/clear/Initialize()
	..()
	var/turf/my_turf = get_turf(src)
	if(ismineralturf(my_turf))
		my_turf.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	clear_turf(my_turf)
	return INITIALIZE_HINT_QDEL
