// This item has a small amount of copypasta from jukeboxes, but it's whatever, low surface amount.
// It wouldn't be an issue to create a common interface if jukeboxes (the machine) werent such a fucking mess in the first place
/obj/item/boombox
	name = "boombox"
	desc = "A dusty, gray, bulky, battery-powered, auto-looping stereo cassette player. An ancient relic from prehistoric times on that one planet with humans and stuff. Yeah, that one."
	icon = 'icons/obj/items/boombox/boombox.dmi'
	lefthand_file = 'icons/obj/items/boombox/bb_lefthand.dmi'
	righthand_file = 'icons/obj/items/boombox/bb_righthand.dmi'
	icon_state = "boombox"
	w_class = WEIGHT_CLASS_NORMAL
	force = 5
	custom_price = PAYCHECK_HARD * 20
	/// Reference to the song list from the jukebox subsystem.
	var/static/list/songs
	/// Currently selected track.
	var/datum/jukebox_track/selection
	/// Currently played track.
	var/datum/jukebox_playing_track/played_track
	/// Volume of the songs played
	var/volume = 70

/obj/item/boombox/Initialize()
	. = ..()
	if(!songs)
		songs = SSjukebox.tracks

/obj/item/boombox/update_icon_state()
	. = ..()
	icon_state = played_track ? "boombox_active" : initial(icon_state)

/obj/item/boombox/attack_self(mob/user)
	show_boombox_ui(user)
	return TRUE

/obj/item/boombox/RightClick(mob/user)
	show_boombox_ui(user)
	return TRUE

/obj/item/boombox/attack_robot(mob/user)
	show_boombox_ui(user)
	return TRUE

/obj/item/boombox/Destroy()
	stop_song()
	return..()

/obj/item/boombox/proc/play_song()
	if(!selection)
		return
	if(played_track)
		return
	var/free_channel = SSjukebox.get_free_channel()
	if(!free_channel)
		return
	played_track = new(src, selection, free_channel, BOOMBOX_RANGE_MULTIPLIER)
	update_appearance()

/obj/item/boombox/proc/stop_song()
	if(played_track)
		qdel(played_track)

/// called by the song ending from the jukebox subsystem
/obj/item/boombox/proc/song_ended()
	played_track = null
	update_appearance()

/obj/item/boombox/proc/show_boombox_ui(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/list/dat = list()

	dat += "Selected track: <a href='?src=[REF(src)];action=selection'>[selection ? "[selection.song_name]" : "None"]</a>"
	dat += "<a href='?src=[REF(src)];action=toggle_play' [played_track ? "class='linkOn'" : ""]>[played_track ? "Stop" : "Start"]</a>"
	dat += "<BR>Volume:<a href='?src=[REF(src)];action=minus_volume'>-</a> <a href='?src=[REF(src)];action=set_volume'>[volume]</a> <a href='?src=[REF(src)];action=plus_volume'>+</a>"

	var/datum/browser/popup = new(user, "boombox", "Boombox", 380, 170)
	popup.set_content(dat.Join())
	popup.open()

/obj/item/boombox/Topic(href, href_list)
	var/mob/user = usr
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	if(!href_list["action"])
		return
	switch(href_list["action"])
		if("toggle_play")
			if(played_track)
				stop_song()
			else
				play_song()
		if("minus_volume")
			volume = max(volume - 10, 0)
		if("plus_volume")
			volume = min(volume + 10, 100)
		if("set_volume")
			var/volume_input = input(user, "Input volume (0-100)", volume) as num|null
			if(!volume_input)
				return
			volume = clamp(volume_input, 0, 100)
		if("selection")
			if(played_track)
				to_chat(user, SPAN_WARNING("Stop the track first!"))
				return
			var/list/available = list()
			for(var/datum/jukebox_track/song in songs)
				available[song.song_name] = song
			var/song_input = input(user, "Select track:") as anything in available
			if(!song_input)
				return
			if(played_track)
				return
			selection = available[song_input]

	show_boombox_ui(user)
