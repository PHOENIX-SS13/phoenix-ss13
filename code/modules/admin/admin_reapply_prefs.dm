/client/proc/reapply_prefs(mob/M in GLOB.mob_list)
	set category = "Admin.Game"
	set name = "Reapply Prefs"

	if(!usr.client || !usr.client.holder)
		to_chat(usr, SPAN_DANGER("Admin only."), confidential = TRUE)
		return

	var/mob/living/carbon/human/H = M
	if(!H || !H.client)
		return
	H.client.prefs.apply_prefs_to(H, icon_updates = TRUE)
	SSblackbox.record_feedback("tally", "reapply_prefs", 1, "Reapply Prefs")
