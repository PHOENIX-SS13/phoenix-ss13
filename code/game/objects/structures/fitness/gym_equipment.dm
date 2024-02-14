/* Gym Equipment
 * -------------
 * Contains:
 * Weight Machine parent
 * Stacklifter
 * Weightlifter
 * Punching bag
 */

// Weight machine
/obj/structure/weightmachine
	name = "weight machine"
	desc = "Just looking at this thing makes you feel tired."
	icon = 'icons/obj/structures/fitness/weight_machine.dmi'
	density = TRUE
	anchored = TRUE
	blocks_emissive = EMISSIVE_BLOCK_UNIQUE
	var/icon_state_inuse
	var/list/lift_sounds = list('sound/effects/fitness/lift_1.ogg', 'sound/effects/fitness/lift_2.ogg', 'sound/effects/fitness/lift_3.ogg',\
	'sound/effects/fitness/lift_4.ogg', 'sound/effects/fitness/lift_5.ogg', 'sound/effects/fitness/drop_1.ogg', 'sound/effects/fitness/drop_2.ogg')

/obj/structure/weightmachine/proc/AnimateMachine(mob/living/user)
	return

/obj/structure/weightmachine/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(obj_flags & IN_USE)
		to_chat(user, SPAN_WARNING("It's already in use - wait a bit!"))
		return
	else
		obj_flags |= IN_USE
		icon_state = icon_state_inuse
		user.setDir(SOUTH)
		user.Stun(80)
		user.forceMove(src.loc)
		var/bragmessage = pick("pushing it to the limit","going into overdrive","burning with determination","rising up to the challenge", "getting strong now","getting ripped")
		user.visible_message("<B>[user] is [bragmessage]!</B>")
		AnimateMachine(user)

		playsound(user, 'sound/machines/click.ogg', 60, TRUE)
		obj_flags &= ~IN_USE
		user.pixel_y = user.base_pixel_y
		var/finishmessage = pick("You feel stronger!","You feel like you can take on the world!","You feel robust!","You feel indestructible!")
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "exercise", /datum/mood_event/exercise)
		icon_state = initial(icon_state)
		to_chat(user, finishmessage)
		user.apply_status_effect(STATUS_EFFECT_EXERCISED)

// Stack Lifter
/obj/structure/weightmachine/stacklifter
	name = "cable machine"
	desc = "Great for seated pulldowns. Feel those arms burn!"
	icon_state = "cable"
	icon_state_inuse = "[icon_state]-flick"

/obj/structure/weightmachine/stacklifter/AnimateMachine(mob/living/user)
	var/lifts = 0
	while (lifts++ < 6)
		if (user.loc != src.loc)
			break
		sleep(3)
		animate(user, pixel_y = -2, time = 3)
		sleep(3)
		animate(user, pixel_y = -4, time = 3)
		sleep(3)
		playsound(user, pick(lift_sounds), 60, TRUE)

// Weight Lifter
/obj/structure/weightmachine/weightlifter
	name = "barbell station"
	icon_state = "weight"
	icon_state_inuse = "[icon_state]-flick"

/obj/structure/weightmachine/weightlifter/AnimateMachine(mob/living/user)
	var/mutable_appearance/swole_overlay = mutable_appearance(icon, "[icon_state]-barbell", WALL_OBJ_LAYER)
	add_overlay(swole_overlay)
	var/reps = 0
	user.pixel_y = 5
	while (reps++ < 6)
		if (user.loc != src.loc)
			break
		for (var/innerReps = max(reps, 1), innerReps > 0, innerReps--)
			sleep(3)
			animate(user, pixel_y = (user.pixel_y == 3) ? 5 : 3, time = 3)
		playsound(user, pick(lift_sounds), 60, TRUE)
	sleep(3)
	animate(user, pixel_y = 2, time = 3)
	sleep(3)
	cut_overlay(swole_overlay)

// Punching bag
/obj/structure/punching_bag
	name = "punching bag"
	desc = "A punching bag. Can you get to speed level 4???"
	icon = 'icons/obj/structures/fitness/punching_bag.dmi'
	icon_state = "punchingbag"
	anchored = TRUE
	layer = WALL_OBJ_LAYER
	var/list/hit_sounds = list('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg',\
	'sound/weapons/punch1.ogg', 'sound/weapons/punch2.ogg', 'sound/weapons/punch3.ogg', 'sound/weapons/punch4.ogg')

/obj/structure/punching_bag/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	flick("[icon_state]-flick", src)
	playsound(loc, pick(hit_sounds), 25, TRUE, -1)
	if(isliving(user))
		var/mob/living/L = user
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "exercise", /datum/mood_event/exercise)
		L.apply_status_effect(STATUS_EFFECT_EXERCISED)
