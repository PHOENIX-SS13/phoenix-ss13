/obj/effect/landmark/start/autoshell_spawner
    name = "AI Autoshell"
    icon_state = "Cyborg"
    delete_after_roundstart = FALSE

/mob/living/silicon/robot/autoshell
	shell = TRUE

/datum/proc/make_autoshells()
    var/datum/controller/subsystem/gamemode/mode = SSgamemode
    mode.update_crew_infos()
    var/maxpop = CONFIG_GET(number/autoshell_pop)
    if(mode.active_players > maxpop && maxpop != -1)
        return
    for(var/obj/effect/landmark/start/autoshell_spawner/sp in GLOB.landmarks_list)
        //var/spawnloc = sp.loc
        if(sp.used)
            return
        new /mob/living/silicon/robot/autoshell/(sp.loc)
        sp.used = TRUE