/obj/structure/reflector
	name = "reflector base"
	icon = 'icons/obj/structures.dmi'
	icon_state = "reflector_map"
	desc = "A base for reflector assemblies."
	anchored = FALSE
	density = FALSE
	var/deflector_icon_state
	var/image/deflector_overlay
	var/finished = FALSE
	var/admin = FALSE //Can't be rotated or deconstructed
	var/can_rotate = TRUE
	var/framebuildstacktype = /obj/item/stack/sheet/iron
	var/framebuildstackamount = 5
	var/buildstacktype = /obj/item/stack/sheet/iron
	var/buildstackamount = 0
	var/list/allowed_projectile_typecache = list(/obj/projectile/beam)
	var/rotation_angle = -1

/obj/structure/reflector/Initialize()
	. = ..()
	icon_state = "reflector_base"
	allowed_projectile_typecache = typecacheof(allowed_projectile_typecache)
	if(deflector_icon_state)
		deflector_overlay = image(icon, deflector_icon_state)
		add_overlay(deflector_overlay)

	if(rotation_angle == -1)
		set_angle(dir2angle(dir))
	else
		set_angle(rotation_angle)

	if(admin)
		can_rotate = FALSE

/obj/structure/reflector/examine(mob/user)
	. = ..()
	if(finished)
		. += "It is set to [rotation_angle] degrees, and the rotation is [can_rotate ? "unlocked" : "locked"]."
		if(!admin)
			if(can_rotate)
				. += SPAN_NOTICE("Alt-click to adjust its direction.")
			else
				. += SPAN_NOTICE("Use screwdriver to unlock the rotation.")

/obj/structure/reflector/proc/set_angle(new_angle)
	if(can_rotate)
		rotation_angle = new_angle
		if(deflector_overlay)
			cut_overlay(deflector_overlay)
			deflector_overlay.transform = turn(matrix(), new_angle)
			add_overlay(deflector_overlay)


/obj/structure/reflector/setDir(new_dir)
	return ..(NORTH)

/obj/structure/reflector/bullet_act(obj/projectile/P)
	var/pdir = P.dir
	var/pangle = P.Angle
	var/ploc = get_turf(P)
	if(!finished || !allowed_projectile_typecache[P.type] || !(P.dir in GLOB.cardinals))
		return ..()
	if(auto_reflect(P, pdir, ploc, pangle) != BULLET_ACT_FORCE_PIERCE)
		return ..()
	return BULLET_ACT_FORCE_PIERCE

/obj/structure/reflector/proc/auto_reflect(obj/projectile/P, pdir, turf/ploc, pangle)
	P.ignore_source_check = TRUE
	P.range = P.decayedRange
	P.decayedRange = max(P.decayedRange--, 0)
	return BULLET_ACT_FORCE_PIERCE

/obj/structure/reflector/attackby(obj/item/W, mob/user, params)
	if(admin)
		return

	if(W.tool_behaviour == TOOL_SCREWDRIVER)
		can_rotate = !can_rotate
		to_chat(user, SPAN_NOTICE("You [can_rotate ? "unlock" : "lock"] [src]'s rotation."))
		W.play_tool_sound(src)
		return

	if(W.tool_behaviour == TOOL_WRENCH)
		if(anchored)
			to_chat(user, SPAN_WARNING("Unweld [src] from the floor first!"))
			return
		user.visible_message(SPAN_NOTICE("[user] starts to dismantle [src]."), SPAN_NOTICE("You start to dismantle [src]..."))
		if(W.use_tool(src, user, 80, volume=50))
			to_chat(user, SPAN_NOTICE("You dismantle [src]."))
			new framebuildstacktype(drop_location(), framebuildstackamount)
			if(buildstackamount)
				new buildstacktype(drop_location(), buildstackamount)
			qdel(src)
	else if(W.tool_behaviour == TOOL_WELDER)
		if(obj_integrity < max_integrity)
			if(!W.tool_start_check(user, amount=0))
				return

			user.visible_message(SPAN_NOTICE("[user] starts to repair [src]."),
								SPAN_NOTICE("You begin repairing [src]..."),
								SPAN_HEAR("You hear welding."))
			if(W.use_tool(src, user, 40, volume=40))
				obj_integrity = max_integrity
				user.visible_message(SPAN_NOTICE("[user] repairs [src]."), \
									SPAN_NOTICE("You finish repairing [src]."))

		else if(!anchored)
			if(!W.tool_start_check(user, amount=0))
				return

			user.visible_message(SPAN_NOTICE("[user] starts to weld [src] to the floor."),
								SPAN_NOTICE("You start to weld [src] to the floor..."),
								SPAN_HEAR("You hear welding."))
			if (W.use_tool(src, user, 20, volume=50))
				set_anchored(TRUE)
				to_chat(user, SPAN_NOTICE("You weld [src] to the floor."))
		else
			if(!W.tool_start_check(user, amount=0))
				return

			user.visible_message(SPAN_NOTICE("[user] starts to cut [src] free from the floor."),
								SPAN_NOTICE("You start to cut [src] free from the floor..."),
								SPAN_HEAR("You hear welding."))
			if (W.use_tool(src, user, 20, volume=50))
				set_anchored(FALSE)
				to_chat(user, SPAN_NOTICE("You cut [src] free from the floor."))

	//Finishing the frame
	else if(istype(W, /obj/item/stack/sheet))
		if(finished)
			return
		var/obj/item/stack/sheet/S = W
		if(istype(S, /obj/item/stack/sheet/glass))
			if(S.use(5))
				new /obj/structure/reflector/single(drop_location())
				qdel(src)
			else
				to_chat(user, SPAN_WARNING("You need five sheets of glass to create a reflector!"))
				return
		if(istype(S, /obj/item/stack/sheet/rglass))
			if(S.use(10))
				new /obj/structure/reflector/double(drop_location())
				qdel(src)
			else
				to_chat(user, SPAN_WARNING("You need ten sheets of reinforced glass to create a double reflector!"))
				return
		if(istype(S, /obj/item/stack/sheet/mineral/diamond))
			if(S.use(1))
				new /obj/structure/reflector/box(drop_location())
				qdel(src)
		if(istype(S, /obj/item/stack/sheet/mineral/plasma))
			if(S.use(4))
				new /obj/structure/reflector/diffuser(drop_location())
				qdel(src)
			else
				to_chat(user, SPAN_WARNING("You need four sheets of plasma to create a diffuser box!"))
				return
	else
		return ..()

/obj/structure/reflector/proc/rotate(mob/user)
	if (!can_rotate || admin)
		to_chat(user, SPAN_WARNING("The rotation is locked!"))
		return FALSE
	var/new_angle = input(user, "Input a new angle for primary reflection face.", "Reflector Angle", rotation_angle) as null|num
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, !iscyborg(user)))
		return
	if(!isnull(new_angle))
		set_angle(SIMPLIFY_DEGREES(new_angle))
	return TRUE

/obj/structure/reflector/AltClick(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, !iscyborg(user)))
		return
	else if(finished)
		rotate(user)


//TYPES OF REFLECTORS, SINGLE, DOUBLE, BOX

//SINGLE

/obj/structure/reflector/single
	name = "reflector"
	deflector_icon_state = "reflector"
	desc = "An angled mirror for reflecting laser beams."
	density = TRUE
	finished = TRUE
	buildstacktype = /obj/item/stack/sheet/glass
	buildstackamount = 5

/obj/structure/reflector/single/anchored
	anchored = TRUE

/obj/structure/reflector/single/mapping
	admin = TRUE
	anchored = TRUE

/obj/structure/reflector/single/auto_reflect(obj/projectile/P, pdir, turf/ploc, pangle)
	var/incidence = GET_ANGLE_OF_INCIDENCE(rotation_angle, (P.Angle + 180))
	if(abs(incidence) > 90 && abs(incidence) < 270)
		return FALSE
	var/new_angle = SIMPLIFY_DEGREES(rotation_angle + incidence)
	P.set_angle_centered(new_angle)
	return ..()

//DOUBLE

/obj/structure/reflector/double
	name = "double sided reflector"
	deflector_icon_state = "reflector_double"
	desc = "A double sided angled mirror for reflecting laser beams."
	density = TRUE
	finished = TRUE
	buildstacktype = /obj/item/stack/sheet/rglass
	buildstackamount = 10

/obj/structure/reflector/double/anchored
	anchored = TRUE

/obj/structure/reflector/double/mapping
	admin = TRUE
	anchored = TRUE

/obj/structure/reflector/double/auto_reflect(obj/projectile/P, pdir, turf/ploc, pangle)
	var/incidence = GET_ANGLE_OF_INCIDENCE(rotation_angle, (P.Angle + 180))
	var/new_angle = SIMPLIFY_DEGREES(rotation_angle + incidence)
	P.set_angle_centered(new_angle)
	return ..()

//BOX

/obj/structure/reflector/box
	name = "reflector box"
	deflector_icon_state = "reflector_box"
	desc = "A box with an internal set of mirrors that reflects all laser beams in a single direction."
	density = TRUE
	finished = TRUE
	buildstacktype = /obj/item/stack/sheet/mineral/diamond
	buildstackamount = 1

/obj/structure/reflector/box/anchored
	anchored = TRUE

/obj/structure/reflector/box/mapping
	admin = TRUE
	anchored = TRUE

/obj/structure/reflector/box/auto_reflect(obj/projectile/P)
	P.set_angle_centered(rotation_angle)
	return ..()

//Diffuser
//Splits the emitter beam into 2 weaker ones with 90*deg between themselves
/obj/structure/reflector/diffuser
	name = "diffuser box"
	deflector_icon_state = "diffuser_box"
	desc = "A box with a set of plasma-based prisms, designed to diffuse and split laser beams."
	density = TRUE
	finished = TRUE
	buildstacktype = /obj/item/stack/sheet/mineral/plasma
	buildstackamount = 4

/obj/structure/reflector/diffuser/anchored
	anchored = TRUE

/obj/structure/reflector/diffuser/auto_reflect(obj/projectile/beam/beam_projectile)
	/// List of angle translations which randomly has either -45,+45/+45,-45 on 1 and 2 indexes
	var/list/angle_translation_list = list()
	switch(rand(1,2))
		if(1)
			angle_translation_list += SIMPLIFY_DEGREES(rotation_angle - 45)
			angle_translation_list += SIMPLIFY_DEGREES(rotation_angle + 45)
		if(2)
			angle_translation_list += SIMPLIFY_DEGREES(rotation_angle + 45)
			angle_translation_list += SIMPLIFY_DEGREES(rotation_angle - 45)

	beam_projectile.set_angle_centered(angle_translation_list[1])
	if(beam_projectile.split)
		return ..()
	beam_projectile.decayedRange--
	///Create and shoot a split projectile
	var/turf/my_turf = get_turf(src)
	var/obj/projectile/beam/new_beam = new beam_projectile.type(my_turf)
	new_beam.fire(angle_translation_list[2])

	///Iterate over the old and new beam and modify them
	for(var/i in 1 to 2)
		var/obj/projectile/beam/iterated_beam
		switch(i)
			if(1)
				iterated_beam = beam_projectile
			if(2)
				iterated_beam = new_beam

		iterated_beam.ignore_source_check = TRUE
		iterated_beam.range = beam_projectile.decayedRange
		iterated_beam.decayedRange = max(beam_projectile.decayedRange, 0)
		iterated_beam.split = TRUE
		iterated_beam.damage /= 2 //Half the damage

	return BULLET_ACT_FORCE_PIERCE

/obj/structure/reflector/ex_act()
	if(admin)
		return FALSE
	return ..()

/obj/structure/reflector/singularity_act()
	if(admin)
		return
	else
		return ..()
