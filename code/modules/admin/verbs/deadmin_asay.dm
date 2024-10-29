/client/proc/deadmin_asay()
	set name = "Toggle Deadmin Asay"
	set category = "Admin"
	set desc = "Toggle access to asay while deadminned."
	var/new_state
	if(ckey in GLOB.asay_deadmins)
		new_state = FALSE
		GLOB.asay_deadmins -= ckey
		remove_verb(src, TYPE_PROC_REF(/client, cmd_admin_say))
	else
		new_state = TRUE
		GLOB.asay_deadmins += ckey
		add_verb(src, TYPE_PROC_REF(/client, cmd_admin_say))
	message_admins("[key_name_admin(usr)] [new_state ? "enabled" : "disabled"] their asay while deadminned.")
	to_chat(usr, SPAN_INFOPLAIN("You will [new_state ? "now" : "no longer"] be able to asay while deadminned."))
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Deadmin Asay", "[new_state ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
