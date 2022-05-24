/*An alternative to exit gateways, signposts send you back to somewhere safe onstation with their semiotic magic.*/
/obj/structure/signpost
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "signpost"
	anchored = TRUE
	density = TRUE
	var/question = "Travel back?"

/obj/structure/signpost/Initialize()
	. = ..()
	set_light(2)

/obj/structure/signpost/interact(mob/user)
	. = ..()
	if(.)
		return
	if(tgui_alert(usr,question,name,list("Yes","No")) == "Yes" && Adjacent(user))
		var/turf/T = find_safe_turf()

		if(T)
			var/atom/movable/AM = user.pulling
			if(AM)
				AM.forceMove(T)
			user.forceMove(T)
			if(AM)
				user.start_pulling(AM)
			to_chat(user, SPAN_NOTICE("You blink and find yourself in [get_area_name(T)]."))
		else
			to_chat(user, "Nothing happens. You feel that this is a bad sign.")

/obj/structure/signpost/attackby(obj/item/W, mob/user, params)
	return interact(user)

/obj/structure/signpost/attack_paw(mob/user, list/modifiers)
	return interact(user)

/obj/structure/signpost/attack_hulk(mob/user)
	return

/obj/structure/signpost/attack_larva(mob/user)
	return interact(user)

/obj/structure/signpost/attack_robot(mob/user)
	if (Adjacent(user))
		return interact(user)

/obj/structure/signpost/attack_slime(mob/user)
	return interact(user)

/obj/structure/signpost/attack_animal(mob/user, list/modifiers)
	return interact(user)

/obj/structure/signpost/salvation
	name = "\proper salvation"
	desc = "In the darkest times, we will find our way home."
	resistance_flags = INDESTRUCTIBLE
