/datum/component/heirloom
	var/datum/mind/owner
	var/family_name

/datum/component/heirloom/Initialize(new_owner, new_family_name)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	owner = new_owner
	family_name = new_family_name

	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(examine))

/datum/component/heirloom/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(user.mind == owner)
		examine_list += SPAN_NOTICE("It is your precious [family_name] family heirloom. Keep it safe!")
	else if(isobserver(user))
		examine_list += SPAN_NOTICE("It is the [family_name] family heirloom, belonging to [owner].")
	else
		var/datum/antagonist/obsessed/creeper = user.mind.has_antag_datum(/datum/antagonist/obsessed)
		if(creeper && creeper.trauma.obsession == owner)
			examine_list += SPAN_NICEGREEN("This must be [owner]'s family heirloom! It smells just like them...")
