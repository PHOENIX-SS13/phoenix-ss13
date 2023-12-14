/obj/effect/overlay/distress_effect
	icon = 'icons/overmap/targeted.dmi'
	icon_state = "locking"
	layer = FLY_LAYER
	plane = GAME_PLANE
	appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	mouse_opacity = 0

/datum/overmap_distress
	var/obj/machinery/shuttle_comms/parent
	var/datum/overmap_object/target
	var/obj/effect/overlay/distress_effect/effect

/datum/overmap_distress/New(pr, tg)
	parent = pr
	target = tg
	effect = new
	target.my_visual.vis_contents += effect
	RegisterSignal(target, COMSIG_PARENT_QDELETING, .proc/Destroy)

/datum/overmap_distress/Destroy()
	. = ..()
	target.my_visual.vis_contents -= effect
	qdel(effect)
	UnregisterSignal(target, COMSIG_PARENT_QDELETING)

/datum/overmap_distress/proc/check_mapzone(var/datum/overmap_object/ov_obj)
	if(target != ov_obj)
		target.my_visual.vis_contents -= effect
		qdel(effect)
		UnregisterSignal(target, COMSIG_PARENT_QDELETING)
		target = ov_obj
		effect = new
		ov_obj.my_visual.vis_contents += effect
		RegisterSignal(ov_obj, COMSIG_PARENT_QDELETING, .proc/Destroy)
