/// Throw an immovable rod at the target
/datum/smite/rod
	name = "Immovable Rod"
	var/force_looping = FALSE

/datum/smite/rod/configure(client/user)
	var/loop_input = tgui_alert(usr,"Would you like this rod to force-loop across space z-levels?", "Loopy McLoopface", list("Yes", "No"))

	force_looping = (loop_input == "Yes")

/datum/smite/rod/effect(client/user, mob/living/target)
	. = ..()
	var/turf/target_turf = get_turf(target)
	var/startside = pick(GLOB.cardinals)
	var/datum/virtual_level/vlevel = target_turf.get_virtual_level()
	var/turf/start_turf = vlevel.get_side_turf(startside)
	var/turf/end_turf = vlevel.get_side_turf(REVERSE_DIR(startside))
	new /obj/effect/immovablerod(start_turf, end_turf, target, force_looping)
