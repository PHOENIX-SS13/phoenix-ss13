/atom/var/CanAtmosPass = ATMOS_PASS_YES

/atom/proc/CanAtmosPass(turf/T, vertical = FALSE)
	switch (CanAtmosPass)
		if (ATMOS_PASS_PROC)
			return ATMOS_PASS_YES
		if (ATMOS_PASS_DENSITY)
			return !density
		else
			return CanAtmosPass

/turf/CanAtmosPass = ATMOS_PASS_NO

/turf/open/CanAtmosPass = ATMOS_PASS_PROC

///Do NOT use this to see if 2 turfs are connected, it mutates state, and we cache that info anyhow.
///Use TURFS_CAN_SHARE or TURF_SHARES depending on your usecase
/turf/open/CanAtmosPass(turf/target_turf, vertical = FALSE)
	var/can_pass = TRUE
	var/direction = vertical ? get_dir_multiz(src, target_turf) : get_dir(src, target_turf)
	var/opposite_direction = REVERSE_DIR(direction)
	if(vertical && !(zAirOut(direction, target_turf) && target_turf.zAirIn(direction, src)))
		can_pass = FALSE
	if(blocks_air || target_turf.blocks_air)
		can_pass = FALSE
	//This path is a bit weird, if we're just checking with ourselves no sense asking objects on the turf
	if (target_turf == src)
		return can_pass

	//Can't just return if canpass is false here, we need to set superconductivity
	for(var/obj/checked_object in contents + target_turf.contents)
		var/turf/other = (checked_object.loc == src ? target_turf : src)
		if(CANATMOSPASS(checked_object, other, vertical))
			continue
		can_pass = FALSE
		//the direction and open/closed are already checked on can_atmos_pass() so there are no arguments
		if(checked_object.BlockSuperconductivity())
			atmos_supeconductivity |= direction
			target_turf.atmos_supeconductivity |= opposite_direction
			return FALSE //no need to keep going, we got all we asked (Is this even faster? fuck you it's soul)

	//Superconductivity is a bitfield of directions we can't conduct with
	//Yes this is really weird. Fuck you
	atmos_supeconductivity &= ~direction
	target_turf.atmos_supeconductivity &= ~opposite_direction

	return can_pass

/atom/movable/proc/BlockSuperconductivity() // objects that block air and don't let superconductivity act
	return FALSE

/turf/proc/ImmediateCalculateAdjacentTurfs()
	//Basic optimization, if we can't share why bother asking other people ya feel?
	var/canpass = CANATMOSPASS(src, src, FALSE)
	for(var/direction in GLOB.cardinals_multiz)
		var/turf/current_turf = get_step_multiz(src, direction)
		if(!isopenturf(current_turf)) // not interested in you brother
			continue
		//Can you and me form a deeper relationship, or is this just a passing wind
		// (direction & (UP | DOWN)) is just "is this vertical" by the by
		if(canpass && CANATMOSPASS(current_turf, src, (direction & (UP|DOWN))) && !(blocks_air || current_turf.blocks_air))
			LAZYINITLIST(atmos_adjacent_turfs)
			LAZYINITLIST(current_turf.atmos_adjacent_turfs)
			atmos_adjacent_turfs[current_turf] = TRUE
			current_turf.atmos_adjacent_turfs[src] = TRUE
		else
			if (atmos_adjacent_turfs)
				atmos_adjacent_turfs -= current_turf
			if (current_turf.atmos_adjacent_turfs)
				current_turf.atmos_adjacent_turfs -= src
			UNSETEMPTY(current_turf.atmos_adjacent_turfs)
	UNSETEMPTY(atmos_adjacent_turfs)
	src.atmos_adjacent_turfs = atmos_adjacent_turfs
	update_adjacent_pollutants() //Atmos adjacency could unlock/block adjacent pollutants, this is dirty flags anyway so its fine having it here

//returns a list of adjacent turfs that can share air with this one.
//alldir includes adjacent diagonal tiles that can share
// air with both of the related adjacent cardinal tiles
/turf/proc/GetAtmosAdjacentTurfs(alldir = 0)
	var/adjacent_turfs
	if (atmos_adjacent_turfs)
		adjacent_turfs = atmos_adjacent_turfs.Copy()
	else
		adjacent_turfs = list()

	if (!alldir)
		return adjacent_turfs

	var/turf/curloc = src

	for (var/direction in GLOB.diagonals_multiz)
		var/matchingDirections = 0
		var/turf/S = get_step_multiz(curloc, direction)
		if(!S)
			continue

		for (var/checkDirection in GLOB.cardinals_multiz)
			var/turf/checkTurf = get_step(S, checkDirection)
			if(!S.atmos_adjacent_turfs || !S.atmos_adjacent_turfs[checkTurf])
				continue

			if (adjacent_turfs[checkTurf])
				matchingDirections++

			if (matchingDirections >= 2)
				adjacent_turfs += S
				break

	return adjacent_turfs

/atom/proc/air_update_turf(update = FALSE, remove = FALSE)
	var/turf/T = get_turf(loc)
	if(!T)
		return
	T.air_update_turf(update, remove)

/**
 * A helper proc for dealing with atmos changes
 *
 * Ok so this thing is pretty much used as a catch all for all the situations someone might wanna change something
 * About a turfs atmos. It's real clunky, and someone needs to clean it up, but not today.
 * Arguments:
 * * update - Has the state of the structures in the world changed? If so, update our adjacent atmos turf list, if not, don't.
 * * remove - Are you removing an active turf (Read wall), or adding one
*/
/turf/air_update_turf(update = FALSE, remove = FALSE)
	if(update)
		ImmediateCalculateAdjacentTurfs()
	if(remove)
		SSair.remove_from_active(src)
	else
		SSair.add_to_active(src)

/atom/movable/proc/move_update_air(turf/T)
	if(isturf(T))
		T.air_update_turf(TRUE, FALSE) //You're empty now
	air_update_turf(TRUE, TRUE) //You aren't

/atom/proc/atmos_spawn_air(text) //because a lot of people loves to copy paste awful code lets just make an easy proc to spawn your plasma fires
	var/turf/open/T = get_turf(src)
	if(!istype(T))
		return
	T.atmos_spawn_air(text)

/turf/open/atmos_spawn_air(text)
	if(!text || !air)
		return

	var/datum/gas_mixture/G = new
	G.parse_gas_string(text)

	air.merge(G)
	archive()
	SSair.add_to_active(src)
