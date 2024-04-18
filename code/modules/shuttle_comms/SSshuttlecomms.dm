SUBSYSTEM_DEF(shuttlecomms)
	name = "Shuttle Comms"
	wait = 1 SECONDS
	flags = SS_POST_FIRE_TIMING
	priority = FIRE_PRIORITY_SHUTTLECOMMS
	runlevels = RUNLEVEL_GAME
	init_order = INIT_ORDER_SHUTTLECOMMS
	var/list/obj/machinery/shuttle_comms/comms
	var/list/obj/machinery/shuttle_comms/active/ruin_comms

/datum/controller/subsystem/shuttlecomms/Initialize(start_timeofday)
	comms = list()
	ruin_comms = list()
	return ..()

/datum/controller/subsystem/shuttlecomms/fire(resumed)
	for(var/obj/machinery/shuttle_comms/array in comms)
		array.monitor()
	for(var/obj/machinery/shuttle_comms/active/ruin_array in ruin_comms)
		ruin_array.monitor()

/datum/controller/subsystem/shuttlecomms/proc/add_array(obj/machinery/shuttle_comms/array)
	if(istype(array, /obj/machinery/shuttle_comms/active))
		ruin_comms.Add(array)
		return
	if(istype(array))
		comms.Add(array)

/datum/controller/subsystem/shuttlecomms/proc/remove_array(obj/machinery/shuttle_comms/array)
	if(istype(array, /obj/machinery/shuttle_comms/active))
		comms.Remove(array)
		return
	if(istype(array))
		comms.Remove(array)
