/*****************************Dice Bags********************************/

/obj/item/storage/pill_bottle/dice
	name = "bag of dice"
	desc = "Contains all the luck you'll ever need."
	icon = 'icons/obj/dice.dmi'
	icon_state = "dicebag"
	var/list/special_die = list(
				/obj/item/dice/d1,
				/obj/item/dice/d2,
				/obj/item/dice/fudge,
				/obj/item/dice/d6/space,
				/obj/item/dice/d00,
				/obj/item/dice/eightbd20,
				/obj/item/dice/fourdd6,
				/obj/item/dice/d100,
				/obj/item/deathroll_dice
				)

/obj/item/storage/pill_bottle/dice/PopulateContents()
	new /obj/item/dice/d4(src)
	new /obj/item/dice/d6(src)
	new /obj/item/dice/d8(src)
	new /obj/item/dice/d10(src)
	new /obj/item/dice/d12(src)
	new /obj/item/dice/d20(src)
	var/picked = pick(special_die)
	new picked(src)

/obj/item/storage/pill_bottle/dice/suicide_act(mob/user)
	user.visible_message(SPAN_SUICIDE("[user] is gambling with death! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (OXYLOSS)

/obj/item/storage/pill_bottle/dice/hazard

/obj/item/storage/pill_bottle/dice/hazard/PopulateContents()
	new /obj/item/dice/d6(src)
	new /obj/item/dice/d6(src)
	new /obj/item/dice/d6(src)
	for(var/i in 1 to 2)
		if(prob(7))
			new /obj/item/dice/d6/ebony(src)
		else
			new /obj/item/dice/d6(src)

/*****************************Dice********************************/

/obj/item/dice //depreciated d6, use /obj/item/dice/d6 if you actually want a d6
	name = "die"
	desc = "A die with six sides. Basic and serviceable."
	icon = 'icons/obj/dice.dmi'
	icon_state = "d6"
	w_class = WEIGHT_CLASS_TINY
	var/sides = 6
	var/result = null
	var/list/special_faces = list() //entries should match up to sides var if used
	var/microwave_riggable = TRUE

	var/rigged = DICE_NOT_RIGGED
	var/rigged_value

/obj/item/dice/Initialize()
	. = ..()
	if(!result)
		result = roll(sides)
	update_appearance()

/obj/item/dice/suicide_act(mob/user)
	user.visible_message(SPAN_SUICIDE("[user] is gambling with death! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (OXYLOSS)

/obj/item/dice/d1
	name = "d1"
	desc = "A die with only one side. Deterministic!"
	icon_state = "d1"
	sides = 1

/obj/item/dice/d2
	name = "d2"
	desc = "A die with two sides. Coins are undignified!"
	icon_state = "d2"
	sides = 2

/obj/item/dice/d4
	name = "d4"
	desc = "A die with four sides. The nerd's caltrop."
	icon_state = "d4"
	sides = 4

/obj/item/dice/d4/Initialize(mapload)
	. = ..()
	// 1d4 damage
	AddElement(/datum/element/caltrop, name, min_damage = 1, max_damage = 4)

/obj/item/dice/d6
	name = "d6"

/obj/item/dice/d6/ebony
	name = "ebony die"
	desc = "A die with six sides made of dense black wood. It feels cold and heavy in your hand."
	icon_state = "de6"
	microwave_riggable = FALSE // You can't melt wood in the microwave

/obj/item/dice/d6/space
	name = "space cube"
	desc = "A die with six sides. 6 TIMES 255 TIMES 255 TILE TOTAL EXISTENCE, SQUARE YOUR MIND OF EDUCATED STUPID: 2 DOES NOT EXIST."
	icon_state = "spaced6"

/obj/item/dice/d6/space/Initialize()
	. = ..()
	if(prob(10))
		name = "spess cube"

/obj/item/dice/fudge
	name = "fudge die"
	desc = "A die with six sides but only three results. Is this a plus or a minus? Your mind is drawing a blank..."
	sides = 3 //shhh
	icon_state = "fudge"
	special_faces = list("minus","blank","plus")

/obj/item/dice/d8
	name = "d8"
	desc = "A die with eight sides. It feels... lucky."
	icon_state = "d8"
	sides = 8

/obj/item/dice/d10
	name = "d10"
	desc = "A die with ten sides. Useful for percentages."
	icon_state = "d10"
	sides = 10

/obj/item/dice/d00
	name = "d00"
	desc = "A die with ten sides. Works better for d100 rolls than a golf ball."
	icon_state = "d00"
	sides = 10

/obj/item/dice/d12
	name = "d12"
	desc = "A die with twelve sides. There's an air of neglect about it."
	icon_state = "d12"
	sides = 12

/obj/item/dice/d20
	name = "d20"
	desc = "A die with twenty sides. The preferred die to throw at the GM."
	icon_state = "d20"
	sides = 20

/obj/item/dice/d100
	name = "d100"
	desc = "A die with one hundred sides! Probably not fairly weighted..."
	icon_state = "d100"
	w_class = WEIGHT_CLASS_SMALL
	sides = 100

/obj/item/dice/d100/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/dice/eightbd20
	name = "strange d20"
	desc = "A weird die with raised text printed on the faces. Everything's white on white so reading it is a struggle. What poor design!"
	icon_state = "8bd20"
	sides = 20
	special_faces = list("It is certain","It is decidedly so","Without a doubt","Yes, definitely","You may rely on it","As I see it, yes","Most likely","Outlook good","Yes","Signs point to yes","Reply hazy try again","Ask again later","Better not tell you now","Cannot predict now","Concentrate and ask again","Don't count on it","My reply is no","My sources say no","Outlook not so good","Very doubtful")

/obj/item/dice/eightbd20/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/dice/fourdd6
	name = "4d d6"
	desc = "A die that exists in four dimensional space. Properly interpreting them can only be done with the help of a mathematician, a physicist, and a priest."
	icon_state = "4dd6"
	sides = 48
	special_faces = list("Cube-Side: 1-1","Cube-Side: 1-2","Cube-Side: 1-3","Cube-Side: 1-4","Cube-Side: 1-5","Cube-Side: 1-6","Cube-Side: 2-1","Cube-Side: 2-2","Cube-Side: 2-3","Cube-Side: 2-4","Cube-Side: 2-5","Cube-Side: 2-6","Cube-Side: 3-1","Cube-Side: 3-2","Cube-Side: 3-3","Cube-Side: 3-4","Cube-Side: 3-5","Cube-Side: 3-6","Cube-Side: 4-1","Cube-Side: 4-2","Cube-Side: 4-3","Cube-Side: 4-4","Cube-Side: 4-5","Cube-Side: 4-6","Cube-Side: 5-1","Cube-Side: 5-2","Cube-Side: 5-3","Cube-Side: 5-4","Cube-Side: 5-5","Cube-Side: 5-6","Cube-Side: 6-1","Cube-Side: 6-2","Cube-Side: 6-3","Cube-Side: 6-4","Cube-Side: 6-5","Cube-Side: 6-6","Cube-Side: 7-1","Cube-Side: 7-2","Cube-Side: 7-3","Cube-Side: 7-4","Cube-Side: 7-5","Cube-Side: 7-6","Cube-Side: 8-1","Cube-Side: 8-2","Cube-Side: 8-3","Cube-Side: 8-4","Cube-Side: 8-5","Cube-Side: 8-6")

/obj/item/dice/fourdd6/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/dice/attack_self(mob/user)
	diceroll(user)

/obj/item/dice/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/mob/thrown_by = thrownby?.resolve()
	if(thrown_by)
		diceroll(thrown_by)
	return ..()

/obj/item/dice/proc/diceroll(mob/user)
	result = roll(sides)
	if(rigged != DICE_NOT_RIGGED && result != rigged_value)
		if(rigged == DICE_BASICALLY_RIGGED && prob(clamp(1/(sides - 1) * 100, 25, 80)))
			result = rigged_value
		else if(rigged == DICE_TOTALLY_RIGGED)
			result = rigged_value

	. = result

	var/fake_result = roll(sides)//Daredevil isn't as good as he used to be
	var/comment = ""
	if(sides == 20 && result == 20)
		comment = "NAT 20!"
	else if(sides == 20 && result == 1)
		comment = "Ouch, bad luck."
	update_appearance()
	if(initial(icon_state) == "d00")
		result = (result - 1)*10
	if(special_faces.len == sides)
		result = special_faces[result]
	if(user != null) //Dice was rolled in someone's hand
		user.visible_message(SPAN_NOTICE("[user] throws [src]. It lands on [result]. [comment]"), \
			SPAN_NOTICE("You throw [src]. It lands on [result]. [comment]"), \
			SPAN_HEAR("You hear [src] rolling, it sounds like a [fake_result]."))
	else if(!src.throwing) //Dice was thrown and is coming to rest
		visible_message(SPAN_NOTICE("[src] rolls to a stop, landing on [result]. [comment]"))

/obj/item/dice/update_overlays()
	. = ..()
	. += "[icon_state]-[result]"

/obj/item/dice/microwave_act(obj/machinery/microwave/M)
	if(microwave_riggable)
		rigged = DICE_BASICALLY_RIGGED
		rigged_value = result
	..(M)

/// A special kind of dice, new type because it is completely different.
/obj/item/deathroll_dice
	name = "deathroll die"
	desc = "An electronic die used for 'deathrolling'. The first to roll a one looses. \nThe die has a screen on each side, with an electrical display inside that seems to always face the screen up."
	icon = 'icons/obj/items/deathroll_dice.dmi'
	icon_state = "dice"
	w_class = WEIGHT_CLASS_SMALL
	custom_price = PAYCHECK_HARD //Electronic, so it costs a bit
	/// Current result of the dice, initial is the maximum result. 99 because that fits good on the screen
	var/result = 99
	/// Whether we are emagged and about to blow, prevent further rolling as if the dice was stuck
	var/about_to_blow = FALSE

/obj/item/deathroll_dice/examine(mob/user)
	. = ..()
	. += SPAN_NOTICE("Alt-click to reset the counter. It will reset automatically when throwing a 'one' result.")

/obj/item/deathroll_dice/Initialize()
	. = ..()
	update_appearance()

/obj/item/deathroll_dice/AltClick(mob/living/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	result = initial(result)
	to_chat(user, SPAN_NOTICE("You reset \the [src]."))
	update_appearance()

/obj/item/deathroll_dice/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	to_chat(user, SPAN_WARNING("You overload \the [src]'s random seed computing core."))
	obj_flags |= EMAGGED

/obj/item/deathroll_dice/update_overlays()
	. = ..()
	var/display_color
	switch(result)
		if(1)
			display_color = "#ff8000" //Almost red color
		if(2,3)
			display_color = "#ffd500" //Yellowish color
		else
			display_color = "#34ebeb" //Neon color
	var/result_string = "[result]"
	var/characters = length(result_string)
	var/offset = (characters == 1) ? 6 : (characters * 4)
	for(var/i in 1 to characters)
		var/letter = result_string[i]
		var/x_shift = i * 4 - offset
		var/mutable_appearance/letter_overlay = mutable_appearance(icon, letter, appearance_flags = RESET_COLOR|KEEP_TOGETHER)
		letter_overlay.color = display_color
		letter_overlay.pixel_x = x_shift
		. += letter_overlay

/obj/item/deathroll_dice/attack_self(mob/user)
	diceroll(user)

/obj/item/deathroll_dice/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/mob/thrown_by = thrownby?.resolve()
	if(thrown_by)
		diceroll(thrown_by)
	return ..()

/obj/item/deathroll_dice/proc/diceroll(mob/user)
	if(result == 1) //If we throw a failed roll, reset the dice first
		result = initial(result)

	var/comment = ""
	var/fake_result = roll(result)//Daredevil isn't as good as he used to be

	if(!about_to_blow)
		result = roll(result)
		update_appearance()

		if(result == 1)
			comment = "You lose!"
			playsound(get_turf(src), 'sound/machines/buzz-sigh.ogg', 25, TRUE)
			if(obj_flags & EMAGGED)
				about_to_blow = TRUE
				addtimer(CALLBACK(src, PROC_REF(emag_boom)), 1 SECONDS)

	if(user != null) //Dice was rolled in someone's hand
		user.visible_message(SPAN_NOTICE("[user] throws [src]. The screen shows [result]. [comment]"), \
			SPAN_NOTICE("You throw [src]. The screen shows [result]. [comment]"), \
			SPAN_HEAR("You hear [src] rolling, it feels like a [fake_result]."))
	else if(!src.throwing) //Dice was thrown and is coming to rest
		visible_message(SPAN_NOTICE("[src] rolls to a stop, landing on [result]. [comment]"))

/obj/item/deathroll_dice/proc/emag_boom()
	if(QDELETED(src))
		return
	message_admins(SPAN_NOTICE("Deathroll dice detonated due to being emagged at [ADMIN_VERBOSEJMP(src)]!"))
	explosion(get_turf(src), 0, 1, 2, 3)
	qdel(src)
