GLOBAL_VAR_INIT(next_jukebox_reload, 0)
/client/proc/jukebox_reload()
	set category = "Server"
	set name = "Reload Jukebox Tracks"
	if(GLOB.next_jukebox_reload > world.time)
		to_chat(usr, SPAN_ADMINNOTICE("Slow down there bub, the jukebox tracks have been reloaded recently, wait a few seconds"), confidential = TRUE)
		return
	GLOB.next_jukebox_reload = world.time + 10 SECONDS
	log_admin("[key_name(usr)] reloaded the jukebox tracklist")
	message_admins("[key_name_admin(usr)] reloaded the jukebox tracklist")
	SSjukebox.load_tracks()

