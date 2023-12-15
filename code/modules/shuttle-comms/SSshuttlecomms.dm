SUBSYSTEM_DEF(shuttlecomms)
	name = "Shuttle Comms"
	wait = 1 SECONDS
	flags = SS_POST_FIRE_TIMING
	priority = FIRE_PRIORITY_SHUTTLECOMMS
	runlevels = RUNLEVEL_GAME
	init_order = INIT_ORDER_SHUTTLECOMMS
	var/list/obj/machinery/shuttle_comms/comms

/datum/controller/subsystem/shuttlecomms/Initialize(start_timeofday)
	comms = list()
	return

/datum/controller/subsystem/shuttlecomms/fire(resumed)
	for(var/obj/machinery/shuttle_comms/array in comms)
		array.monitor()
	return

/datum/controller/subsystem/shuttlecomms/proc/add_array(obj/machinery/shuttle_comms/array)
	comms += array

/datum/controller/subsystem/shuttlecomms/proc/remove_array(obj/machinery/shuttle_comms/array)
	comms -= array
