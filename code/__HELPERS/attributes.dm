/// Turns an associative list into a readable multi-line string
/proc/attrib_list_to_multiline_text(list/attribute_list)
	var/string = ""
	var/first = TRUE
	for(var/attribute_type in attribute_list)
		var/datum/attribute/attribute = GLOB.attributes[attribute_type]
		if(!first)
			string += "<br>"
		string += "[attribute.name]: [attribute_list[attribute_type]]"
		first = FALSE
	return string

/proc/skill_list_to_multiline_text(list/skill_list)
	var/string = ""
	var/first = TRUE
	for(var/skill_type in skill_list)
		var/datum/skill/skill = GLOB.skills[skill_type]
		if(!first)
			string += "<br>"
		string += "[skill.name]: [skill_list[skill_type]]"
		first = FALSE
	return string
