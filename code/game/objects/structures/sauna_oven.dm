#define SAUNA_WATER_PER_WATER_UNIT 5

/obj/structure/sauna_oven
	name = "sauna oven"
	desc = "A modest sauna oven with rocks. Pour some water, turn it on and enjoy the moment."
	icon = 'icons/obj/structures/sauna_oven.dmi'
	icon_state = "sauna_oven"
	density = TRUE
	anchored = TRUE
	resistance_flags = FIRE_PROOF
	var/lit = FALSE
	var/water_amount = 0

/obj/structure/sauna_oven/examine(mob/user)
	. = ..()
	. += SPAN_NOTICE("The rocks are [water_amount ? "moist" : "dry"].")
	. += SPAN_NOTICE("It is currently <b>[lit ? "on" : "off"]</b>.")

/obj/structure/sauna_oven/Destroy()
	if(lit)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/sauna_oven/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSobj, src)
		user.visible_message(SPAN_NOTICE("[user] turns off [src]."), SPAN_NOTICE("You turn off [src]."))
	else
		lit = TRUE
		START_PROCESSING(SSobj, src)
		user.visible_message(SPAN_NOTICE("[user] turns on [src]."), SPAN_NOTICE("You turn on [src]."))
	update_icon()

/obj/structure/sauna_oven/update_overlays()
	. = ..()
	if(lit)
		. += "sauna_oven_on_overlay"

/obj/structure/sauna_oven/update_icon()
	..()
	icon_state = "[lit ? "sauna_oven_on" : initial(icon_state)]"

/obj/structure/sauna_oven/attackby(obj/item/used_item, mob/user)
	if(used_item.tool_behaviour == TOOL_WRENCH)
		to_chat(user, SPAN_NOTICE("You begin to deconstruct [src]."))
		if(used_item.use_tool(src, user, 6 SECONDS, volume = 50))
			to_chat(user, SPAN_NOTICE("You successfully deconstructed [src]."))
			new /obj/item/stack/sheet/mineral/wood(get_turf(src), SAUNA_OVEN_WOOD_COST)
			qdel(src)
		return

	if(istype(used_item, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/reagent_container = used_item
		if(!reagent_container.is_open_container())
			return ..()
		if(reagent_container.reagents.has_reagent(/datum/reagent/water))
			reagent_container.reagents.remove_reagent(/datum/reagent/water, 5)
			user.visible_message(SPAN_NOTICE("[user] pours some \
			water into [src]."), SPAN_NOTICE("You pour \
			some water to [src]."))
			water_amount += 5 * SAUNA_WATER_PER_WATER_UNIT
		else
			to_chat(user, SPAN_WARNING("There's no water in [reagent_container]"))
		return
	return ..()

/obj/structure/sauna_oven/process()
	if(!water_amount)
		return
	water_amount--
	var/turf/open/pos = get_turf(src)
	if(!istype(pos))
		return
	steam_pulse(pos)
	generate_heat(pos)

#define STEAM_PULSE_SPREAD_RANGE 7

/obj/structure/sauna_oven/proc/steam_pulse(turf/open/location)
	var/list/turfs_affected = list(location)
	var/list/turfs_to_spread = list(location)
	var/spread_range = STEAM_PULSE_SPREAD_RANGE
	var/spread_stage = spread_range
	for(var/i in 1 to spread_range)
		if(!turfs_to_spread.len)
			break
		var/list/new_spread_list = list()
		for(var/turf/open/turf_to_spread as anything in turfs_to_spread)
			if(isspaceturf(turf_to_spread))
				continue
			var/obj/effect/abstract/fake_steam/fake_steam = locate() in turf_to_spread
			var/at_edge = FALSE
			if(!fake_steam)
				at_edge = TRUE
				fake_steam = new(turf_to_spread)
			fake_steam.stage_up(spread_stage)

			if(!at_edge)
				for(var/turf/open/open_turf as anything in turf_to_spread.atmos_adjacent_turfs)
					if(!(open_turf in turfs_affected))
						new_spread_list += open_turf
						turfs_affected += open_turf

		turfs_to_spread = new_spread_list
		spread_stage--

#undef STEAM_PULSE_SPREAD_RANGE

#define SAUNA_OVEN_TARGET_TEMPERATURE T20C + 20
#define SAUNA_OVEN_HEATING_POWER 20000

/obj/structure/sauna_oven/proc/generate_heat(turf/open/location)
	var/datum/gas_mixture/enviroment = location.return_air()
	var/heat_capacity = enviroment.heat_capacity()
	var/required_energy = (SAUNA_OVEN_TARGET_TEMPERATURE - enviroment.temperature) * heat_capacity
	required_energy = min(required_energy, SAUNA_OVEN_HEATING_POWER)
	if(required_energy <= 0)
		return
	var/delta_temperature = required_energy / heat_capacity
	if(delta_temperature)
		enviroment.temperature += delta_temperature
		air_update_turf(FALSE, FALSE)

#undef SAUNA_OVEN_TARGET_TEMPERATURE
#undef SAUNA_OVEN_HEATING_POWER

#undef SAUNA_WATER_PER_WATER_UNIT

#define MAX_FAKE_STEAM_STAGES 5
#define STAGE_DOWN_TIME 10 SECONDS

/// Fake steam for the sauna oven
/obj/effect/abstract/fake_steam
	layer = FLY_LAYER
	icon = 'icons/effects/atmospherics.dmi'
	icon_state = "water_vapor"
	blocks_emissive = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/next_stage_down = 0
	var/current_stage = 0

/obj/effect/abstract/fake_steam/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/effect/abstract/fake_steam/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/effect/abstract/fake_steam/process()
	if(next_stage_down > world.time)
		return
	stage_down()

#define FAKE_STEAM_TARGET_ALPHA 204

/obj/effect/abstract/fake_steam/proc/update_alpha()
	alpha = FAKE_STEAM_TARGET_ALPHA * (current_stage / MAX_FAKE_STEAM_STAGES)

#undef FAKE_STEAM_TARGET_ALPHA

/obj/effect/abstract/fake_steam/proc/stage_down()
	if(!current_stage)
		qdel(src)
		return
	current_stage--
	next_stage_down = world.time + STAGE_DOWN_TIME
	update_alpha()

/obj/effect/abstract/fake_steam/proc/stage_up(max_stage = MAX_FAKE_STEAM_STAGES)
	var/target_max_stage = min(MAX_FAKE_STEAM_STAGES, max_stage)
	current_stage = min(current_stage + 1, target_max_stage)
	next_stage_down = world.time + STAGE_DOWN_TIME
	update_alpha()

#undef MAX_FAKE_STEAM_STAGES
