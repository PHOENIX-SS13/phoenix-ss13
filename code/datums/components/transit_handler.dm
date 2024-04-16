/datum/component/transit_handler
	/// Our transit instance
	var/datum/transit_instance/transit_instance
	/// Time until we'll consider stranding a thing, they need to be in transit for some time until we delete them
	var/time_until_strand = 0

/datum/component/transit_handler/Initialize(datum/transit_instance/transit_instance_)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	transit_instance = transit_instance_
	time_until_strand = world.time + 1 SECONDS
	transit_instance.affected_movables[parent] = TRUE
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_parent_moved))

/datum/component/transit_handler/proc/on_parent_moved(atom/movable/source, atom/old_loc, Dir, Forced)
	if(QDELETED(source))
		return
	var/turf/new_location = get_turf(source)
	if(!istype(new_location, /turf/open/space/transit))
		qdel(src)
	transit_instance.movable_moved(source, time_until_strand)

/datum/component/transit_handler/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	transit_instance.affected_movables -= parent
