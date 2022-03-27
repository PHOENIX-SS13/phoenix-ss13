#define NO_MAXVOTES_CAP -1

SUBSYSTEM_DEF(autotransfer)
	name = "Autotransfer"
	flags = SS_KEEP_TIMING | SS_BACKGROUND
	wait = 1 MINUTES

	var/start_time
	var/target_time
	/// Maximum round extensions before force-ending the round
	var/vote_interval
	var/max_extension_votes
	var/current_votes = 0

/datum/controller/subsystem/autotransfer/Initialize(start_timeofday)
	var/vote_time = CONFIG_GET(number/autotransfer_vote_timer)
	if(!vote_time)
		can_fire = FALSE
		return ..()
	start_time = world.realtime
	target_time = start_time + vote_time
	vote_interval = CONFIG_GET(number/autotransfer_vote_interval)
	max_extension_votes = CONFIG_GET(number/autotransfer_vote_max_extensions)
	return ..()

/datum/controller/subsystem/autotransfer/Recover()
	start_time = SSautotransfer.start_time
	vote_interval = SSautotransfer.vote_interval
	current_votes = SSautotransfer.current_votes

/datum/controller/subsystem/autotransfer/fire()
	if(world.realtime < target_time)
		return
	if(max_extension_votes == NO_MAXVOTES_CAP || max_extension_votes > current_votes)
		SSvote.initiate_vote("transfer", "server")
		target_time = target_time + vote_interval
		current_votes++
	else
		SSshuttle.auto_transfer()

#undef NO_MAXVOTES_CAP
