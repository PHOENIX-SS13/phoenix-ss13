//NOT using the existing /obj/machinery/door type, since that has some complications on its own, mainly based on its
//machineryness

/obj/structure/mineral_door
	name = "iron door"
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	layer = CLOSED_DOOR_LAYER
	color = "#BBBBBB"

	icon = 'icons/obj/doors/mineral_doors.dmi'
	icon_state = "metal"
	max_integrity = 200
	armor = list(MELEE = 15, BULLET = 0, LASER = 0, ENERGY = 100, BOMB = 10, BIO = 100, RAD = 100, FIRE = 50, ACID = 50)
	CanAtmosPass = ATMOS_PASS_DENSITY
	flags_1 = RAD_PROTECT_CONTENTS_1 | RAD_NO_CONTAMINATE_1
	rad_insulation = RAD_MEDIUM_INSULATION

	var/door_opened = FALSE //if it's open or not.
	var/isSwitchingStates = FALSE //don't try to change stats if we're already opening

	var/close_delay = -1 //-1 if does not auto close.
	var/openSound = 'sound/effects/stonedoor_openclose.ogg'
	var/closeSound = 'sound/effects/stonedoor_openclose.ogg'

	var/sheetType = /obj/item/stack/sheet/iron //what we're made of
	var/sheetAmount = 7 //how much we drop when deconstructed

	/// With a lock installed, this is the ID of the lock
	var/key_id
	/// If has a lock, this keeps track whether it has been locked or not
	var/locked = FALSE

/obj/structure/mineral_door/Initialize()
	. = ..()
	var/turf/my_turf = get_turf(src)
	var/turf/east_turf = get_step(my_turf, EAST)
	var/turf/west_turf = get_step(my_turf, WEST)
	//If east and west isn't blocked, face that direction
	if(!east_turf.is_blocked_turf() && !west_turf.is_blocked_turf())
		setDir(WEST)
	/// If we initialize with a key id (lock, most likely mapped by mappers), and are not opened, lock us.
	if(key_id && !door_opened)
		locked = TRUE
	update_appearance()
	air_update_turf(TRUE, TRUE)

/obj/structure/mineral_door/Destroy()
	if(!door_opened)
		air_update_turf(TRUE, FALSE)
	. = ..()

/obj/structure/mineral_door/Move()
	var/turf/T = loc
	. = ..()
	if(!door_opened)
		move_update_air(T)

/obj/structure/mineral_door/Bumped(atom/movable/AM)
	..()
	if(!door_opened && !locked)
		return TryToSwitchState(AM)

/obj/structure/mineral_door/attack_ai(mob/user) //those aren't machinery, they're just big fucking slabs of a mineral
	if(isAI(user)) //so the AI can't open it
		return
	else if(iscyborg(user)) //but cyborgs can
		if(get_dist(user,src) <= 1) //not remotely though
			return TryToSwitchState(user)

/obj/structure/mineral_door/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/mineral_door/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	return TryToSwitchState(user)

/obj/structure/mineral_door/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(istype(mover, /obj/effect/beam))
		return !opacity

/obj/structure/mineral_door/proc/TryToSwitchState(atom/user)
	if(isSwitchingStates || !anchored)
		return
	if(locked)
		playsound(src, 'sound/misc/knuckles.ogg', 50, TRUE)
		to_chat(user, SPAN_WARNING("\The [src] is locked!"))
		return
	if(isliving(user))
		var/mob/living/M = user
		if(M.client)
			if(iscarbon(M))
				var/mob/living/carbon/C = M
				if(!C.handcuffed)
					SwitchState()
			else
				SwitchState()
	else if(ismecha(user))
		SwitchState()

/obj/structure/mineral_door/proc/SwitchState()
	if(door_opened)
		Close()
	else
		Open()

/obj/structure/mineral_door/proc/Open()
	isSwitchingStates = TRUE
	play_blind_effect(src, 5, "door_open", dir)
	playsound(src, openSound, 100, TRUE)
	set_opacity(FALSE)
	update_appearance()
	sleep(10)
	set_density(FALSE)
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	air_update_turf(TRUE, FALSE)
	isSwitchingStates = FALSE
	update_appearance()

	if(close_delay != -1)
		addtimer(CALLBACK(src, PROC_REF(Close)), close_delay)

/obj/structure/mineral_door/proc/Close()
	if(isSwitchingStates || !door_opened)
		return
	var/turf/T = get_turf(src)
	for(var/mob/living/L in T)
		return
	isSwitchingStates = TRUE
	play_blind_effect(src, 5, "door_close", dir)
	playsound(src, closeSound, 100, TRUE)
	update_appearance()
	sleep(10)
	set_density(TRUE)
	set_opacity(TRUE)
	door_opened = FALSE
	layer = initial(layer)
	air_update_turf(TRUE, TRUE)
	isSwitchingStates = FALSE
	update_appearance()

/obj/structure/mineral_door/update_icon_state()
	if(isSwitchingStates)
		if(door_opened)
			icon_state = "[initial(icon_state)]closing"
		else
			icon_state = "[initial(icon_state)]opening"
	else
		if(door_opened)
			icon_state = "[initial(icon_state)]open"
		else
			icon_state = "[initial(icon_state)]"
	return ..()

/obj/structure/mineral_door/update_overlays()
	. = ..()
	if(key_id)
		var/lock_state
		if(isSwitchingStates)
			if(door_opened)
				lock_state = "lockclosing"
			else
				lock_state = "lockopening"
		else
			if(door_opened)
				lock_state = "lockopen"
			else
				lock_state = "lock"
		. += mutable_appearance(icon, lock_state, appearance_flags = RESET_COLOR)

/obj/structure/mineral_door/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/lockpick))
		var/obj/item/lockpick/lockpick_item = I
		if(!key_id)
			to_chat(user, SPAN_WARNING("\The [src] does not have a lock!"))
			return
		if(!locked)
			to_chat(user, SPAN_WARNING("\The [src] is unlocked!"))
			return
		user.visible_message(SPAN_NOTICE("[user] begins lockpicking \the [src]."), SPAN_NOTICE("You begin lockpicking \the [src]."))
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src, 'sound/misc/knuckles.ogg', 50, TRUE)
		if(do_after(user, LOCKPICK_TIME, target = src))
			if(!locked)
				return
			if(prob(LOCKPICK_BREAK_CHANCE))
				to_chat(user, SPAN_WARNING("\The [lockpick_item] breaks!"))
				qdel(lockpick_item)
				return
			if(prob(LOCKPICK_SUCCESS_CHANCE))
				to_chat(user, SPAN_NOTICE("You unlock \the [src]!"))
				locked = FALSE
			else
				to_chat(user, SPAN_WARNING("You fail to unlock \the [src]!"))
			playsound(src, 'sound/misc/knuckles.ogg', 50, TRUE)
		return
	if(istype(I, /obj/item/lock))
		var/obj/item/lock/lock_item = I
		if(key_id)
			to_chat(user, SPAN_WARNING("\The [src] already has a lock!"))
			return
		to_chat(user, SPAN_NOTICE("You install \the [lock_item] on \the [src]."))
		key_id = lock_item.key_id
		update_appearance()
		qdel(lock_item)
		return
	if(istype(I, /obj/item/key))
		var/obj/item/key/key_item = I
		if(isSwitchingStates)
			return
		if(!key_id)
			to_chat(user, SPAN_WARNING("\The [src] does not have a lock!"))
			return
		if(door_opened)
			to_chat(user, SPAN_WARNING("Close \the [src] first!"))
			return
		if(key_item.key_id != key_id)
			to_chat(user, SPAN_WARNING("\The [key_item] does not fit \the [src]!"))
			return
		if(locked)
			to_chat(user, SPAN_NOTICE("You unlock \the [src]."))
		else
			to_chat(user, SPAN_NOTICE("You lock \the [src]."))
		locked = !locked
		playsound(src, 'sound/misc/knuckles.ogg', 50, TRUE)
		return
	if(pickaxe_door(user, I))
		return
	else if(!user.combat_mode)
		return attack_hand(user)
	else
		return ..()

/obj/structure/mineral_door/set_anchored(anchorvalue) //called in default_unfasten_wrench() chain
	. = ..()
	set_opacity(anchored ? !door_opened : FALSE)
	air_update_turf(TRUE, anchorvalue)

/obj/structure/mineral_door/wrench_act(mob/living/user, obj/item/I)
	if(locked)
		to_chat(user, SPAN_WARNING("Can't unwrench \the [src] while it's locked."))
		return
	..()
	default_unfasten_wrench(user, I, 40)
	return TRUE


/////////////////////// TOOL OVERRIDES ///////////////////////


/obj/structure/mineral_door/proc/pickaxe_door(mob/living/user, obj/item/I) //override if the door isn't supposed to be a minable mineral.
	if(!istype(user))
		return
	if(I.tool_behaviour != TOOL_MINING)
		return
	. = TRUE
	to_chat(user, SPAN_NOTICE("You start digging [src]..."))
	if(I.use_tool(src, user, 40, volume=50))
		to_chat(user, SPAN_NOTICE("You finish digging."))
		deconstruct(TRUE)

/obj/structure/mineral_door/welder_act(mob/living/user, obj/item/I) //override if the door is supposed to be flammable.
	if(locked)
		to_chat(user, SPAN_WARNING("Can't weld \the [src] while it's locked."))
		return
	..()
	. = TRUE
	if(anchored)
		to_chat(user, SPAN_WARNING("[src] is still firmly secured to the ground!"))
		return

	user.visible_message(SPAN_NOTICE("[user] starts to weld apart [src]!"), SPAN_NOTICE("You start welding apart [src]."))
	if(!I.use_tool(src, user, 60, 5, 50))
		to_chat(user, SPAN_WARNING("You failed to weld apart [src]!"))
		return

	user.visible_message(SPAN_NOTICE("[user] welded [src] into pieces!"), SPAN_NOTICE("You welded apart [src]!"))
	deconstruct(TRUE)

/obj/structure/mineral_door/proc/crowbar_door(mob/living/user, obj/item/I) //if the door is flammable, call this in crowbar_act() so we can still decon it
	. = TRUE
	if(anchored)
		to_chat(user, SPAN_WARNING("[src] is still firmly secured to the ground!"))
		return

	user.visible_message(SPAN_NOTICE("[user] starts to pry apart [src]!"), SPAN_NOTICE("You start prying apart [src]."))
	if(!I.use_tool(src, user, 60, volume = 50))
		to_chat(user, SPAN_WARNING("You failed to pry apart [src]!"))
		return

	user.visible_message(SPAN_NOTICE("[user] pried [src] into pieces!"), SPAN_NOTICE("You pried apart [src]!"))
	deconstruct(TRUE)


/////////////////////// END TOOL OVERRIDES ///////////////////////


/obj/structure/mineral_door/deconstruct(disassembled = TRUE)
	var/turf/T = get_turf(src)
	if(disassembled)
		new sheetType(T, sheetAmount)
	else
		new sheetType(T, max(sheetAmount - 2, 1))
	qdel(src)


/obj/structure/mineral_door/iron
	name = "iron door"
	max_integrity = 300

/obj/structure/mineral_door/silver
	name = "silver door"
	color = "#E4E4E4"
	sheetType = /obj/item/stack/sheet/mineral/silver
	max_integrity = 300
	rad_insulation = RAD_HEAVY_INSULATION

/obj/structure/mineral_door/gold
	name = "gold door"
	color = "#F3B831"
	sheetType = /obj/item/stack/sheet/mineral/gold
	rad_insulation = RAD_HEAVY_INSULATION

/obj/structure/mineral_door/uranium
	name = "uranium door"
	color = "#84B54B"
	sheetType = /obj/item/stack/sheet/mineral/uranium
	max_integrity = 300

/obj/structure/mineral_door/sandstone
	name = "sandstone door"
	icon_state = "stone"
	color = "#CDBB91"
	sheetType = /obj/item/stack/sheet/mineral/sandstone
	max_integrity = 100

/obj/structure/mineral_door/transparent
	opacity = FALSE
	rad_insulation = RAD_VERY_LIGHT_INSULATION

/obj/structure/mineral_door/transparent/Close()
	..()
	set_opacity(FALSE)

/obj/structure/mineral_door/transparent/plasma
	name = "plasma door"
	color = "#AF4492"
	sheetType = /obj/item/stack/sheet/mineral/plasma

/obj/structure/mineral_door/transparent/plasma/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/atmos_sensitive, mapload)

/obj/structure/mineral_door/transparent/plasma/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/mineral_door/transparent/plasma/attackby(obj/item/W, mob/user, params)
	if(W.get_temperature())
		var/turf/T = get_turf(src)
		message_admins("Plasma mineral door ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(T)]")
		log_game("Plasma mineral door ignited by [key_name(user)] in [AREACOORD(T)]")
		TemperatureAct()
	else
		return ..()

/obj/structure/mineral_door/transparent/plasma/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return exposed_temperature > 300

/obj/structure/mineral_door/transparent/plasma/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	TemperatureAct()

/obj/structure/mineral_door/transparent/plasma/proc/TemperatureAct()
	atmos_spawn_air("plasma=500;TEMP=1000")
	deconstruct(FALSE)

/obj/structure/mineral_door/transparent/diamond
	name = "diamond door"
	sheetType = /obj/item/stack/sheet/mineral/diamond
	color = "#96D4D4"
	max_integrity = 1000
	rad_insulation = RAD_EXTREME_INSULATION

/obj/structure/mineral_door/wood
	name = "wood door"
	icon_state = "wood"
	color = "#A36D39"
	openSound = 'sound/effects/doorcreaky.ogg'
	closeSound = 'sound/effects/doorcreaky.ogg'
	sheetType = /obj/item/stack/sheet/mineral/wood
	resistance_flags = FLAMMABLE
	max_integrity = 200
	rad_insulation = RAD_VERY_LIGHT_INSULATION

/obj/structure/mineral_door/wood/pickaxe_door(mob/living/user, obj/item/I)
	return

/obj/structure/mineral_door/wood/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/mineral_door/wood/crowbar_act(mob/living/user, obj/item/I)
	return crowbar_door(user, I)

/obj/structure/mineral_door/wood/attackby(obj/item/I, mob/living/user)
	if(I.get_temperature())
		fire_act(I.get_temperature())
		return

	return ..()

/obj/structure/mineral_door/paperframe
	name = "paper frame door"
	icon_state = "wood"
	color = "#9E704B"
	openSound = 'sound/effects/doorcreaky.ogg'
	closeSound = 'sound/effects/doorcreaky.ogg'
	sheetType = /obj/item/stack/sheet/paperframes
	sheetAmount = 3
	resistance_flags = FLAMMABLE
	max_integrity = 20

/obj/structure/mineral_door/paperframe/examine(mob/user)
	. = ..()
	if(obj_integrity < max_integrity)
		. += SPAN_INFO("It looks a bit damaged, you may be able to fix it with some <b>paper</b>.")

/obj/structure/mineral_door/paperframe/pickaxe_door(mob/living/user, obj/item/I)
	return

/obj/structure/mineral_door/paperframe/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/mineral_door/paperframe/crowbar_act(mob/living/user, obj/item/I)
	return crowbar_door(user, I)

/obj/structure/mineral_door/paperframe/attackby(obj/item/I, mob/living/user)
	if(I.get_temperature()) //BURN IT ALL DOWN JIM
		fire_act(I.get_temperature())
		return

	if((!user.combat_mode) && istype(I, /obj/item/paper) && (obj_integrity < max_integrity))
		user.visible_message(SPAN_NOTICE("[user] starts to patch the holes in [src]."), SPAN_NOTICE("You start patching some of the holes in [src]!"))
		if(do_after(user, 2 SECONDS, src))
			obj_integrity = min(obj_integrity+4,max_integrity)
			qdel(I)
			user.visible_message(SPAN_NOTICE("[user] patches some of the holes in [src]."), SPAN_NOTICE("You patch some of the holes in [src]!"))
			return TRUE

	return ..()
