/// User is trying to read a human's descriptors
/mob/living/carbon/human/proc/check_out_descriptors(mob/user, compare = FALSE)
	var/is_user_human = ishuman(user)
	if(compare && !is_user_human) //User needs to be a human if they want to compare
		return null
	if(!has_any_readable_descriptors(compare, user))
		return null
	var/string = ""
	var/first = TRUE
	for(var/type in descriptors)
		var/datum/descriptor/descriptor = GLOB.descriptors[type]
		if(!descriptor.can_really_describe(src, compare, user))
			continue
		if(!first)
			string += "\n"
		if(compare)
			// Human type on user is asserted here thanks to the first check in the proc.
			string += "\t<i>[descriptor.get_comparison(user, src)]</i>"
		else
			string += "\t<i>[descriptor.get_description(src)]</i>"
		first = FALSE

	/// If a human user is looking at a normal description, add a link to do a comparison too.
	if(is_user_human && user != src && !compare && has_any_readable_descriptors(TRUE, user))
		string += "<br/>\t<a href='?src=[REF(src)];lookup_info=compare'>Compare yourself to [src.p_them()].</a>"

	return string

/// Returns whether a human has any readable or comparable descriptor.
/mob/living/carbon/human/proc/has_any_readable_descriptors(must_be_comparable = FALSE, mob/living/carbon/human/comparator)
	for(var/type in descriptors)
		var/datum/descriptor/descriptor = GLOB.descriptors[type]
		if(!descriptor.can_really_describe(src, must_be_comparable, comparator))
			continue
		return TRUE
	return FALSE
