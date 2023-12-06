/obj/effect/overlay/distress_effect
	icon = 'icons/obj/monitors.dmi'
	icon_state = "alert2"
	layer = FLY_LAYER
	plane = GAME_PLANE
	appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	mouse_opacity = 0

/datum/overmap_distress
	var/datum/overmap_object/target
	var/obj/effect/overlay/distress_effect/effect

/datum/overmap_distress/New(tg)
	target = tg
	effect = new
	target.my_visual.vis_contents += effect
	RegisterSignal(target, COMSIG_PARENT_QDELETING, .proc/Destroy)

/datum/overmap_distress/Destroy()
	target.my_visual.vis_contents -= effect
	qdel(effect)
	UnregisterSignal(target, COMSIG_PARENT_QDELETING)
	return ..()
