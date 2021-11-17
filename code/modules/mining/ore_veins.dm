/// Ore veins that can be mined by projectiles (efficiently by emitters), or inefficiently by mining tools
/obj/structure/ore_vein
	name = "ore vein"
	desc = "A large rock with chunks of ore."
	icon = 'icons/obj/structures/ore_vein_gags.dmi'
	icon_state = "ore_vein"
	density = TRUE
	anchored = TRUE
	max_integrity = 400
	resistance_flags = FIRE_PROOF
	greyscale_config = /datum/greyscale_config/ore_vein
	armor = list(MELEE = 40, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 100, RAD = 100, FIRE = 100, ACID = 100)
	/// Material whose ores the vein will drop
	var/material_type = /datum/material/iron
	/// Progress to mining the next chunk of ore
	var/mine_progress = 0
	/// Ores remaining to drop from this vein
	var/ores_remaining = 100
	/// When rolling how much ores this has, this is the upper bound
	var/ores_high = 35
	/// When rolling how much ores this has, this is the lower bound
	var/ores_low = 20

#define DEVASTATE_ORE_DROP_LOW 10
#define DEVASTATE_ORE_DROP_HIGH 30
#define HEAVY_ORE_DROP_LOW 5
#define HEAVY_ORE_DROP_HIGH 10

/obj/structure/ore_vein/ex_act(severity, target)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			drop_ore_chunks(rand(DEVASTATE_ORE_DROP_LOW, DEVASTATE_ORE_DROP_HIGH))
		if(EXPLODE_HEAVY)
			drop_ore_chunks(rand(HEAVY_ORE_DROP_LOW, HEAVY_ORE_DROP_HIGH))

#define MINE_PROGRESS_PER_TOOL_ATTACK 20

/obj/structure/ore_vein/attackby(obj/item/weapon, mob/user, params)
	if(weapon.tool_behaviour == TOOL_MINING)
		to_chat(user, SPAN_NOTICE("You inefficiently strike \the [src] with \the [weapon]."))
		weapon.play_tool_sound(src)
		user.do_attack_animation(src)
		user.changeNext_move(CLICK_CD_MELEE)
		add_mine_progress(weapon.toolspeed * MINE_PROGRESS_PER_TOOL_ATTACK)
		return TRUE
	return ..()

#undef MINE_PROGRESS_PER_TOOL_ATTACK

#undef DEVASTATE_ORE_DROP_LOW
#undef DEVASTATE_ORE_DROP_HIGH
#undef HEAVY_ORE_DROP_LOW
#undef HEAVY_ORE_DROP_HIGH

#define EMITTER_MINING_FACTOR_MULTIPLY 0.25

/// Add mining progress equal to the damage of the projectile hitting it, lowering it for emitters, since they can run 24/7
/obj/structure/ore_vein/bullet_act(obj/projectile/projectile)
	var/progress_to_add = projectile.damage

	if(istype(projectile, /obj/projectile/beam/emitter))
		progress_to_add *= EMITTER_MINING_FACTOR_MULTIPLY

	add_mine_progress(progress_to_add)
	return BULLET_ACT_HIT

#undef EMITTER_MINING_FACTOR_MULTIPLY

/obj/structure/ore_vein/Initialize(mapload)
	ores_remaining = rand(ores_low, ores_high)
	initialize_vein_vars()
	. = ..()
	icon_state = "[initial(icon_state)][rand(1,3)]"

#define ORE_DROP_LOW 1
#define ORE_DROP_HIGH 3

/obj/structure/ore_vein/proc/add_mine_progress(progress)
	mine_progress += progress
	if(mine_progress >= 100)
		mine_progress -= 100
		drop_ore_chunks(rand(ORE_DROP_LOW, ORE_DROP_HIGH))

#undef ORE_DROP_LOW
#undef ORE_DROP_HIGH

/obj/structure/ore_vein/proc/drop_ore_chunks(drop_amount)
	playsound(src, 'sound/effects/break_stone.ogg', 30, TRUE)
	var/actual_yield = min(drop_amount, ores_remaining)
	ores_remaining -= actual_yield

	var/turf/drop_turf = get_turf(src)
	var/list/open_turfs = get_adjacent_open_turfs(drop_turf)
	for(var/i in 1 to open_turfs.len)
		var/turf/picked_turf = pick(open_turfs)
		if(!picked_turf.is_blocked_turf())
			drop_turf = picked_turf
			break
		open_turfs -= picked_turf

	var/datum/material/material_ref = GET_MATERIAL_REF(material_type)
	if(material_ref.ore_type) // In case someone makes alloy veins
		visible_message(SPAN_NOTICE("Chunks of ore splinter off \The [src]."))
		new material_ref.ore_type(drop_turf, drop_amount)

	/// We ran out of ores, delete self
	if(!ores_remaining)
		visible_message(SPAN_WARNING("\The [src] breaks down!"))
		qdel(src)

/obj/structure/ore_vein/proc/initialize_vein_vars()
	var/datum/material/material_ref = GET_MATERIAL_REF(material_type)
	var/datum/map_zone/mapzone = SSmapping.get_map_zone(src)
	greyscale_colors = "[material_ref.greyscale_colors][mapzone.rock_color]"
	name = "[material_ref.name] vein"

/obj/structure/ore_vein/large
	greyscale_config = /datum/greyscale_config/ore_vein_large
	pixel_x = -16
	max_integrity = 200
	ores_high = 70
	ores_low = 50
	layer = FLY_LAYER

/obj/structure/ore_vein/crystal
	icon = 'icons/obj/structures/crystal_gags.dmi'
	icon_state = "crystal"
	name = "ore crystal"
	desc = "A large crystal composed of ore."
	greyscale_config = /datum/greyscale_config/ore_vein_crystal

/obj/structure/ore_vein/crystal/initialize_vein_vars()
	var/datum/material/material_ref = GET_MATERIAL_REF(material_type)
	greyscale_colors = "[material_ref.greyscale_colors]"
	name = "[material_ref.name] crystal"

/obj/structure/ore_vein/crystal/large
	greyscale_config = /datum/greyscale_config/ore_vein_crystal_large
	pixel_x = -16
	max_integrity = 400
	ores_high = 70
	ores_low = 50
	layer = FLY_LAYER

/obj/structure/ore_vein/iron
	material_type = /datum/material/iron

/obj/structure/ore_vein/gold
	material_type = /datum/material/gold

/obj/structure/ore_vein/silver
	material_type = /datum/material/silver

/obj/structure/ore_vein/titanium
	material_type = /datum/material/titanium

/obj/structure/ore_vein/plasma
	material_type = /datum/material/plasma

/obj/structure/ore_vein/diamond
	material_type = /datum/material/diamond

/obj/structure/ore_vein/uranium
	material_type = /datum/material/uranium

/obj/structure/ore_vein/bluespace
	material_type = /datum/material/bluespace

/obj/structure/ore_vein/large/iron
	material_type = /datum/material/iron

/obj/structure/ore_vein/large/gold
	material_type = /datum/material/gold

/obj/structure/ore_vein/large/silver
	material_type = /datum/material/silver

/obj/structure/ore_vein/large/titanium
	material_type = /datum/material/titanium

/obj/structure/ore_vein/large/plasma
	material_type = /datum/material/plasma

/obj/structure/ore_vein/large/diamond
	material_type = /datum/material/diamond

/obj/structure/ore_vein/large/uranium
	material_type = /datum/material/uranium

/obj/structure/ore_vein/large/bluespace
	material_type = /datum/material/bluespace

/obj/structure/ore_vein/crystal/iron
	material_type = /datum/material/iron

/obj/structure/ore_vein/crystal/gold
	material_type = /datum/material/gold

/obj/structure/ore_vein/crystal/silver
	material_type = /datum/material/silver

/obj/structure/ore_vein/crystal/titanium
	material_type = /datum/material/titanium

/obj/structure/ore_vein/crystal/plasma
	material_type = /datum/material/plasma

/obj/structure/ore_vein/crystal/diamond
	material_type = /datum/material/diamond

/obj/structure/ore_vein/crystal/uranium
	material_type = /datum/material/uranium

/obj/structure/ore_vein/crystal/bluespace
	material_type = /datum/material/bluespace

/obj/structure/ore_vein/crystal/large/iron
	material_type = /datum/material/iron

/obj/structure/ore_vein/crystal/large/gold
	material_type = /datum/material/gold

/obj/structure/ore_vein/crystal/large/silver
	material_type = /datum/material/silver

/obj/structure/ore_vein/crystal/large/titanium
	material_type = /datum/material/titanium

/obj/structure/ore_vein/crystal/large/plasma
	material_type = /datum/material/plasma

/obj/structure/ore_vein/crystal/large/diamond
	material_type = /datum/material/diamond

/obj/structure/ore_vein/crystal/large/uranium
	material_type = /datum/material/uranium

/obj/structure/ore_vein/crystal/large/bluespace
	material_type = /datum/material/bluespace
