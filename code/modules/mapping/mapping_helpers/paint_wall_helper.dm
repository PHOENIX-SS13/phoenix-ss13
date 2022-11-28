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

// Skyline Ship Additions //

/obj/effect/mapping_helpers/paint_wall/skyline

/obj/effect/mapping_helpers/paint_wall/skyline/outer_hull
	name = "CPCV Skyline Outer Hull"
	wall_paint = "#fcba03"

/obj/effect/mapping_helpers/paint_wall/skyline/outer_hull/stripe
	name = "CPCV Skyline Outer Hull Stripe"
	wall_paint = "#e3e3e3"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull
	name = "CPCV Skyline Inner Hull"
	wall_paint = "#53565A"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull/cook
	name = "CPCV Skyline Inner Hull - Cook"
	stripe_paint = "#DE3A3A"
	wall_paint = "#53565A"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull/detective
	name = "CPCV Skyline Inner Hull - Detective"
	stripe_paint = "#54402D"
	wall_paint = "#53565A"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull/janitor
	name = "CPCV Skyline Inner Hull - Janitor"
	stripe_paint = "#D381C9"
	wall_paint = "#53565A"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull/cargo
	name = "CPCV Skyline Inner Hull - Cargo"
	stripe_paint = "#EFB341"
	wall_paint = "#53565A"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull/command
	name = "CPCV Skyline Inner Hull - Command"
	stripe_paint = "#3a6abd"
	wall_paint = "#53565A"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull/engineering
	name = "CPCV Skyline Inner Hull - Engineering"
	stripe_paint = "#fcba03"
	wall_paint = "#53565A"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull/medbay
	name = "CPCV Skyline Inner Hull - Medbay"
	stripe_paint = "#52B4E9"
	wall_paint = "#53565A"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull/research
	name = "CPCV Skyline Inner Hull - Research"
	stripe_paint = "#D381C9"
	wall_paint = "#53565A"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull/security
	name = "CPCV Skyline Inner Hull Security"
	stripe_paint = "#DE3A3A"
	wall_paint = "#53565A"

/obj/effect/mapping_helpers/paint_wall/skyline/inner_hull/silicon
	name = "CPCV Skyline Inner Hull - Silicon"
	stripe_paint = "#aaaaaa"
	wall_paint = "#53565A"

