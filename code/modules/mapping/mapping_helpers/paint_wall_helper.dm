/obj/effect/mapping_helpers/paint_wall
	name = "Paint Wall Helper"
	icon = 'icons/effects/paint_helpers.dmi'
	icon_state = "paint"
	late = TRUE
	/// What wall paint this helper will apply
	var/wall_paint
	/// What stripe paint this helper will apply
	var/stripe_paint

/obj/effect/mapping_helpers/paint_wall/LateInitialize()
	for(var/obj/effect/mapping_helpers/paint_wall/paint_helper in loc)
		if(paint_helper == src)
			continue
		WARNING("Duplicate paint helper found at [x], [y], [z]")
		qdel(src)
		return

	var/did_anything = FALSE

	if(istype(loc, /turf/closed/wall))
		var/turf/closed/wall/target_wall = loc
		target_wall.paint_wall(wall_paint)
		target_wall.paint_stripe(stripe_paint)
		did_anything = TRUE

	var/obj/structure/low_wall/low_wall = locate() in loc
	if(low_wall)
		low_wall.set_wall_paint(wall_paint)
		low_wall.set_stripe_paint(stripe_paint)
		did_anything = TRUE

	var/obj/structure/falsewall/falsewall = locate() in loc
	if(falsewall)
		falsewall.paint_wall(wall_paint)
		falsewall.paint_stripe(stripe_paint)
		did_anything = TRUE

	if(!did_anything)
		WARNING("Redundant paint helper found at [x], [y], [z]")

	qdel(src)

/obj/effect/mapping_helpers/paint_wall/free_trade_union_ship
	name = "FTU Wall Paint"
	stripe_paint = "#5B4D41"
	icon_state = "paint_ftu"

/obj/effect/mapping_helpers/paint_wall/bridge
	name = "Bridge Wall Paint"
	stripe_paint = "#334E6D"
	icon_state = "paint_bridge"

/obj/effect/mapping_helpers/paint_wall/hotel
	name = "hotel Wall Paint"
	stripe_paint = "#54402D"
	wall_paint = "#303030"

/obj/effect/mapping_helpers/paint_wall/hotel_wood
	name = "Hotel Wood Paint"
	stripe_paint = "#54402D"
	wall_paint = "#54402D"
