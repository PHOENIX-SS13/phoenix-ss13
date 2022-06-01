/client/verb/looc(msg as text)
	set name = "LOOC"
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, SPAN_DANGER(" Speech is currently admin-disabled."))
		return

	if(!mob)
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	if(!holder)
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		if(findtext(msg, "byond://"))
			to_chat(src, "<B>Advertising other servers is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			return
		if(istype(mob, /mob/dead))
			to_chat(src, SPAN_DANGER("You cannot use LOOC while ghosting."))
			return

	msg = emoji_parse(msg)

	mob.log_talk(msg, LOG_OOC, tag="LOOC")

	var/list/hearers_in_view = get_hearers_in_view(7, mob)
	var/list/seen_by_admins = list()

	for(var/mob/hearer in hearers_in_view)
		if(!hearer.client)
			continue
		var/client/hearer_client = hearer.client
		if (hearer_client.holder)
			seen_by_admins[hearer_client] = TRUE
			continue //they are handled after that
		if (isobserver(hearer))
			continue //Also handled later.
		to_chat(hearer_client, SPAN_LOOC(SPAN_PREFIX("LOOC:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg]")))

	for(var/client/admin as anything in GLOB.admins)
		if(!admin)
			continue
		var/admin_was_in_range_to_see = seen_by_admins[admin]
		if((admin.prefs.chat_toggles & CHAT_ADMIN_LOOC) && !admin_was_in_range_to_see)
			to_chat(admin, SPAN_ALOOC("[ADMIN_FLW(usr)] <span class='prefix'>ALOOC:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span>"))
		else if(admin_was_in_range_to_see)
			to_chat(admin, SPAN_LOOC("[ADMIN_FLW(usr)] <span class='prefix'>LOOC:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span>"))
