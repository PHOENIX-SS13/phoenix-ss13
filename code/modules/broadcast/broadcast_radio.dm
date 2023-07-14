/obj/item/radio/broadcast
    name = "Broadcast Station Radio"
    desc = "A special radio designed for commercial broadcast. Activate for radio UI and right click for boombox UI."
    keyslot = new /obj/item/encryptionkey/broadcast
    frequency = FREQ_BROADCAST
    freqlock = TRUE
    broadcasting = TRUE
    command = TRUE
    var/datum/can_broadcast = TRUE
    /// Reference to the song list from the jukebox subsystem.
    var/static/list/songs
    /// Currently selected track.
    var/static/datum/jukebox_track/selection
    /// Currently played track.
    var/datum/jukebox_playing_track/played_track
    /// Volume of the songs played
    var/volume = 70
    //list of initialized broadcast radios.
    var/static/list/broadcast_radio_list = list()


/obj/item/radio/broadcast/RightClick(mob/user)
    ui_interact(user)
    //show_boombox_ui(user)
    return TRUE

/obj/item/radio/broadcast/Initialize()
    . = ..()
    add_atom_colour("#f12272", ADMIN_COLOUR_PRIORITY)
    broadcast_radio_list.Add(src)
    if(!songs)
        songs = SSjukebox.tracks

/obj/item/radio/broadcast/proc/play_song()
    if(!selection)
        return
    if(played_track)
        return
    var/free_channel = SSjukebox.get_free_channel()
    if(!free_channel)
        return
    played_track = new(src, selection, free_channel, BOOMBOX_RANGE_MULTIPLIER)
    update_appearance()

/obj/item/radio/broadcast/proc/stop_song()
    if(played_track)
        qdel(played_track)

/obj/item/radio/broadcast/proc/song_ended()
    played_track = null
    update_appearance()
/*
/obj/item/radio/broadcast/proc/show_boombox_ui(mob/user)
    if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
        return
    var/list/dat = list()

    dat += "Selected track: <a href='?src=[REF(src)];action=selection'>[selection ? "[selection.song_artist] - [selection.song_title]" : "None"]</a>"
    dat += "<a href='?src=[REF(src)];action=toggle_play' [played_track ? "class='linkOn'" : ""]>[played_track ? "Stop" : "Start"]</a>"
    dat += "<BR>Volume:<a href='?src=[REF(src)];action=minus_volume'>-</a> <a href='?src=[REF(src)];action=set_volume'>[volume]</a> <a href='?src=[REF(src)];action=plus_volume'>+</a>"

    var/datum/browser/popup = new(user, "broadcast radio", "Broadcast Radio", 380, 170)
    popup.set_content(dat.Join())
    popup.open()

/obj/item/radio/broadcast/Topic(href, href_list)
    var/mob/user = usr
    if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
        return
    if(!href_list["action"])
        return
    switch(href_list["action"])
        if("toggle_play")
            if(played_track)
                for(var/obj/item/radio/broadcast/instance in broadcast_radio_list)
                    instance.stop_song()
            else
                for(var/obj/item/radio/broadcast/instance in broadcast_radio_list)
                    instance.play_song()
        if("minus_volume")
            volume = max(volume - 10, 0)
        if("plus_volume")
            volume = min(volume + 10, 100)
        if("set_volume")
            var/volume_input = input(user, "Input volume (0-100)", volume) as num|null
            if(!isnum(volume_input))
                return
            volume = clamp(volume_input, 0, 100)
        if("selection")
            if(played_track)
                to_chat(user, SPAN_WARNING("Stop the track first!"))
                return
            var/list/available = list()
            for(var/datum/jukebox_track/song in songs)
                available["[song.song_artist] - [song.song_title]"] = song
            sortList(available)
            var/song_input = input(user, "Select track:") as anything in available
            if(!song_input)
                return
            if(played_track)
                return
            selection = available[song_input]
    if(can_broadcast)
        show_boombox_ui(user)
    else
        show_receiver_ui(user)
*/

/obj/item/radio/ui_interact(mob/user, datum/tgui/ui, datum/ui_state/state)
    ui = SStgui.try_update_ui(user, src, ui)
    if(!ui)
        ui = new(user, src, "BroadcastRadio", name)
        if(state)
            ui.set_state(state)
        ui.open()

/obj/item/radio/broadcast/receiver/ui_data(mob/user)
    var/list/data = list()

    data["canBroadcast"] = can_broadcast
    data["broadcasting"] = broadcasting
    data["listening"] = listening
    data["frequency"] = frequency
    data["minFrequency"] = freerange ? MIN_FREE_FREQ : MIN_FREQ
    data["maxFrequency"] = freerange ? MAX_FREE_FREQ : MAX_FREQ
    data["freqlock"] = freqlock
    data["channels"] = list()
    for(var/channel in channels)
        data["channels"][channel] = channels[channel] & FREQ_LISTENING
    data["command"] = command
    data["useCommand"] = use_command
    data["subspace"] = subspace_transmission
    data["subspaceSwitchable"] = subspace_switchable
    data["headset"] = FALSE

    data["musicActive"] = played_track ? TRUE : FALSE
    data["trackSelected"] = null
    data["trackLength"] = null
    if(selection)
        data["trackSelected"] = "[selection.song_artist] - [selection.song_title]"
        data["trackLength"] = DisplayTimeText(selection.song_length)
    data["volume"] = volume
    data["songs"] = list()
    for(var/datum/jukebox_track/S in songs)
        var/list/track_data = list(
            name = "[S.song_artist] - [S.song_title]"
        )
        data["songs"] += list(track_data)
    return data
        
/obj/item/radio/broadcast/ui_act(action, list/params)
    . = ..()
    if(.)
        return
    switch(action)
        if("frequency")
            if(freqlock)
                return
            var/tune = params["tune"]
            var/adjust = text2num(params["adjust"])
            if(adjust)
                tune = frequency + adjust * 10
                . = TRUE
            else if(text2num(tune) != null)
                tune = tune * 10
                . = TRUE
            if(.)
                set_frequency(sanitize_frequency(tune, freerange))
        if("listen")
            listening = !listening
            . = TRUE
        if("broadcast")
            broadcasting = !broadcasting
            . = TRUE
        if("channel")
            var/channel = params["channel"]
            if(!(channel in channels))
                return
            if(channels[channel] & FREQ_LISTENING)
                channels[channel] &= ~FREQ_LISTENING
            else
                channels[channel] |= FREQ_LISTENING
            . = TRUE
        if("command")
            use_command = !use_command
            . = TRUE
        if("subspace")
            if(subspace_switchable)
                subspace_transmission = !subspace_transmission
                if(!subspace_transmission)
                    channels = list()
                else
                    recalculateChannels()
                . = TRUE
        if("toggle")
            if(QDELETED(src))
                return
            if(!played_track)
                play_song()
                START_PROCESSING(SSobj, src)
                return TRUE
            else
                /// Deleting the track stops the song.
                qdel(played_track)
                return TRUE
        if("select_track")
            var/list/available = list()
            for(var/datum/jukebox_track/S in songs)
                available["[S.song_artist] - [S.song_title]"] = S
            var/selected = params["track"]
            if(QDELETED(src) || !selected || !istype(available[selected], /datum/jukebox_track))
                return
            selection = available[selected]
            return TRUE
        if("set_volume")
            var/new_volume = params["volume"]
            if(new_volume  == "reset")
                volume = initial(volume)
                return TRUE
            else if(new_volume == "min")
                volume = max(volume - 10, 0)
                return TRUE
            else if(new_volume == "max")
                volume = min(volume + 10, 100)
                return TRUE
            else if(text2num(new_volume) != null)
                volume = text2num(new_volume)
                return TRUE

//RADIO FOR RECEIVING

/obj/item/radio/broadcast/receiver
    name = "Broadcast Radio Listener"
    desc = "A special radio designed for listening to commercial broadcasts. Interact for radio UI. Right click for music UI."
    can_broadcast = FALSE
    broadcasting = FALSE
    command = FALSE
    custom_price = PAYCHECK_EASY

/obj/item/radio/broadcast/receiver/RightClick(mob/user)
    ui_interact(user)
    //show_receiver_ui(user)
    return FALSE
/*
/obj/item/radio/broadcast/proc/show_receiver_ui(mob/user)
    if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
        return
    var/list/dat = list()

    dat += "Current track: [selection ? "[selection.song_artist] - [selection.song_title]" : "None"]"
    dat += "<BR>Volume:<a href='?src=[REF(src)];action=minus_volume'>-</a> <a href='?src=[REF(src)];action=set_volume'>[volume]</a> <a href='?src=[REF(src)];action=plus_volume'>+</a>"

    var/datum/browser/popup = new(user, "broadcast receiver", "Broadcast Receiver", 380, 170)
    popup.set_content(dat.Join())
    popup.open()
*/