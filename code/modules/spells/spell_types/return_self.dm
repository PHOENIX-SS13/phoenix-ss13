/obj/effect/proc_holder/spell/self/return_back
	/// Admin only spell, teleports and deletes the body, ghosting the user.
	name = "Return"
	desc = "Activates your return beacon."
	clothes_req = NONE
	charge_max = 1
	cooldown_min = 1

	invocation = "Return on!"
	invocation_type = "whisper"
	school = "evocation"
	action_icon_state = "lightning"
	var/quiet = FALSE

/obj/effect/proc_holder/spell/self/return_back/Initialize(mapload, is_quiet)
	quiet = is_quiet
	. = ..()

/obj/effect/proc_holder/spell/self/return_back/can_cast(mob/user = usr, skipcharge = FALSE, silent = FALSE)
	return TRUE

/obj/effect/proc_holder/spell/self/return_back/cast(mob/living/carbon/human/user)
	user.mind.RemoveSpell(src)

	if(!quiet)
		playsound(get_turf(user.loc), 'sound/magic/Repulse.ogg', 100, TRUE)

	var/mob/dead/observer/ghost = user.ghostize(TRUE)

	var/datum/effect_system/spark_spread/quantum/sparks = new
	sparks.set_up(10, 1, user)
	sparks.attach(user.loc)
	sparks.start()

	qdel(user)

	// Get them back to their regular name.
	ghost.set_ghost_appearance()
	if(ghost.client && ghost.client.prefs)
		ghost.deadchat_name = ghost.client.prefs.real_name
