/// Validates attributes and skills saved in the preferences.
/datum/preferences/proc/validate_attributes()
	/// If there isn't a list for either of those, just reset them, most likely it's savefile getting those for the first time.
	if(!length(attributes) || !length(skills))
		reset_attributes()
		return
	/// Make sure they have all the attributes and skills.
	for(var/attribute_type in GLOB.attributes)
		if(isnull(attributes[attribute_type]))
			attributes[attribute_type] = 0
	for(var/skill_type in GLOB.skills)
		if(isnull(skills[skill_type]))
			skills[skill_type] = 0

	/// Make sure none of their attributes or skills exceed the set minimums and maximums
	for(var/attribute_type in GLOB.attributes)
		var/value = attributes[attribute_type]
		if(value > ATTRIBUTE_ALLOCATION_MAXIMUM || value < ATTRIBUTE_ALLOCATION_MINIMUM)
			attributes[attribute_type] = 0
	for(var/skill_type in GLOB.skills)
		var/value = skills[skill_type]
		if(value > SKILL_ALLOCATION_MAXIMUM || value < SKILL_ALLOCATION_MINIMUM)
			skills[skill_type] = 0

	/// See if we exceed our remaining points, if so then reset attributes
	if(remaining_attribute_points() < 0 || remaining_skill_points() < 0)
		reset_attributes()

/// Resets attributes and skills to no changes.
/datum/preferences/proc/reset_attributes(reset_attributes = TRUE, reset_skills = TRUE)
	if(reset_attributes)
		attributes = list()
		for(var/attribute_type in GLOB.attributes)
			attributes[attribute_type] = 0
	if(reset_skills)
		skills = list()
		for(var/skill_type in GLOB.skills)
			skills[skill_type] = 0

/datum/preferences/proc/update_perceived_attributes()
	perceived_attributes = attributes.Copy()
	perceived_skills = skills.Copy()
	// Add base values
	for(var/skill_type in GLOB.skills)
		perceived_skills[skill_type] += SKILL_BASE
	for(var/attribute_type in GLOB.attributes)
		perceived_attributes[attribute_type] += ATTRIBUTE_BASE
	// Apply any expected sheets (currently none)
	// Calculate affinities (very similar code to what /datum/attribute_holder does, im not a fan but it is what it is)
	for(var/skill_type in GLOB.skills)
		var/datum/skill/skill = GLOB.skills[skill_type]
		if(!skill.affinities)
			continue
		for(var/affinity_type in skill.affinities)
			var/attribute_value = perceived_attributes[affinity_type] - ATTRIBUTE_BASE
			var/affinity_modifier = skill.affinities[affinity_type]
			var/modifier_value = FLOOR(attribute_value * affinity_modifier, 1)
			perceived_skills[skill_type] += modifier_value

/// Returns amount of remaining attribute points
/datum/preferences/proc/remaining_attribute_points()
	var/remaining = ATTRIBUTE_POINTS_TO_ALLOCATE
	for(var/attribute_type in GLOB.attributes)
		remaining -= attributes[attribute_type]
	return remaining

/// Returns whether an attribute can be modified by a value.
/datum/preferences/proc/can_modify_attribute(attribute_type, value)
	var/remaining = remaining_attribute_points()
	if(remaining < value)
		return FALSE
	var/target_value = attributes[attribute_type] + value
	if(target_value < ATTRIBUTE_ALLOCATION_MINIMUM)
		return FALSE
	if(target_value > ATTRIBUTE_ALLOCATION_MAXIMUM)
		return FALSE
	return TRUE

/// Modifies an attribute by a value
/datum/preferences/proc/modify_attribute(attribute_type, value)
	if(!can_modify_attribute(attribute_type, value))
		return
	attributes[attribute_type] += value

/// Returns amount of remaining skill points.
/datum/preferences/proc/remaining_skill_points()
	var/remaining = SKILL_POINTS_TO_ALLOCATE
	for(var/skill_type in GLOB.skills)
		remaining -= skills[skill_type]
	return remaining

/// Returns whether a skill can be modified by a value.
/datum/preferences/proc/can_modify_skill(skill_type, value)
	var/remaining = remaining_skill_points()
	if(remaining < value)
		return FALSE
	var/target_value = skills[skill_type] + value
	if(target_value < SKILL_ALLOCATION_MINIMUM)
		return FALSE
	if(target_value > SKILL_ALLOCATION_MAXIMUM)
		return FALSE
	return TRUE

/// Modifies a skill by a value.
/datum/preferences/proc/modify_skill(skill_type, value)
	if(!can_modify_skill(skill_type, value))
		return
	skills[skill_type] += value

/// Will try to customize the stat and skill allocations to match a passed attribute sheet.
/datum/preferences/proc/allocate_to_sheet(sheet_type, allocate_attributes = TRUE, allocate_skills = TRUE)
	var/datum/attribute_sheet/sheet = GLOB.attribute_sheets[sheet_type]
	if(!sheet)
		return
	/// If the sheet doesnt have any attributes, dont even try to change anything there
	if(!sheet.attributes)
		allocate_attributes = FALSE
	/// If the sheet doesnt have any skills, dont even try to change anything there
	if(!sheet.skills)
		allocate_skills = FALSE
	reset_attributes(allocate_attributes, allocate_skills)
	if(allocate_attributes)
		for(var/attribute_type in sheet.attributes)
			modify_attribute(attribute_type, sheet.attributes[attribute_type])
	if(allocate_skills)
		for(var/skill_type in sheet.skills)
			modify_skill(skill_type, sheet.skills[skill_type])

/datum/preferences/proc/print_attributes_page()
	update_perceived_attributes()
	var/list/dat = list()
	dat += "<center><i>Here you can customize your character's attributes and skills by pressing the +1 and -1 buttons.</i></center>"
	dat += "<table width='100%'>"
	dat += "<center><h2>Attributes:</h2></center>"
	dat += "<center><i>Attributes define your character's strengths and weaknesses, aswell as impact your skills.<BR>Stimulants, drugs, moods, and other things may affect them.</i></center>"
	dat += "<b>Points remaining: [remaining_attribute_points()]</b>"
	dat += "<tr>"
	dat += "<td width='15%'></td>" //Name
	dat += "<td width='5%'></td>" //Minus
	dat += "<td width='5%'></td>" //Plus
	dat += "<td width='10%'></td>" //Value
	dat += "<td width='5%'></td>" //Common modifier
	dat += "<td width='60%'></td>" //Description
	dat += "</tr>"
	var/even = FALSE
	var/background_cl
	for(var/attribute_type in GLOB.attributes)
		even = !even
		background_cl = even ? "#17191C" : "#23273C"
		var/datum/attribute/attribute = GLOB.attributes[attribute_type]
		var/add_link = can_modify_attribute(attribute_type, 1) ? "href='?_src_=prefs;task=attributes;attribute_task=set_attribute;type=[attribute_type];amount=1'" : "class='linkOff'"
		var/sub_link = can_modify_attribute(attribute_type, -1) ? "href='?_src_=prefs;task=attributes;attribute_task=set_attribute;type=[attribute_type];amount=-1'" : "class='linkOff'"
		var/base_value = attributes[attribute_type] + ATTRIBUTE_BASE
		var/perceived_value = perceived_attributes[attribute_type]
		dat += "<tr style='background-color: [background_cl]'>"
		dat += "<td>[attribute.name]</td>" //Name
		dat += "<td><a [sub_link]>-1</a></td>" //Minus
		dat += "<td><a [add_link]>+1</a></td>" //Plus
		dat += "<td><center><b>[perceived_value]</b> ([base_value])</center></td>" //Value
		dat += "<td><b><center>[attribute.get_common_modifier_string(perceived_value)]</center></b></td>" //Common modifier
		dat += "<td><i>[attribute.desc]</i></td>" //Description
		dat += "</tr>"
	dat += "</table>"

	dat += "<table width='100%'>"
	dat += "<center><h2>Skills:</h2></center>"
	dat += "<center><i>Skills define how proficient or trained you are in doing certain tasks. Attributes affect them, mostly intelligence.</i> <a href='?_src_=prefs;task=attributes;attribute_task=choose_template;'>Skill Templates</a></center>"
	dat += "<b>Points remaining: [remaining_skill_points()]</b>"
	dat += "<tr>"
	dat += "<td width='20%'></td>" //Name
	dat += "<td width='5%'></td>" //Minus
	dat += "<td width='5%'></td>" //Plus
	dat += "<td width='10%'></td>" //Value
	dat += "<td width='10%'></td>" //Capability Description
	dat += "<td width='50%'></td>" //Description
	dat += "</tr>"
	even = FALSE
	for(var/skill_type in GLOB.skills)
		even = !even
		background_cl = even ? "#17191C" : "#23273C"
		var/datum/skill/skill = GLOB.skills[skill_type]
		var/base_value = skills[skill_type] + SKILL_BASE
		var/perceived_value = perceived_skills[skill_type]
		var/add_link = can_modify_skill(skill_type, 1) ? "href='?_src_=prefs;task=attributes;attribute_task=set_skill;type=[skill_type];amount=1'" : "class='linkOff'"
		var/sub_link = can_modify_skill(skill_type, -1) ? "href='?_src_=prefs;task=attributes;attribute_task=set_skill;type=[skill_type];amount=-1'" : "class='linkOff'"
		dat += "<tr style='background-color: [background_cl]'>"
		dat += "<td>[skill.name]</td>" //Name
		dat += "<td><a [sub_link]>-1</a></td>" //Minus
		dat += "<td><a [add_link]>+1</a></td>" //Plus
		dat += "<td><center><b>[perceived_value]</b> ([base_value])</center></td>" //Value
		dat += "<td>[skill.get_capability_description(perceived_value)]</td>" //Capability Description
		dat += "<td><i>[skill.desc]</i></td>" //Description
		dat += "</tr>"
	dat += "</table>"
	return dat

/datum/preferences/proc/handle_attributes_topic(mob/user, list/href_list)
	switch(href_list["attribute_task"])
		if("set_skill")
			var/skill_type = text2path(href_list["type"])
			var/amount = text2num(href_list["amount"])
			modify_skill(skill_type, amount)
		if("set_attribute")
			var/attribute_type = text2path(href_list["type"])
			var/amount = text2num(href_list["amount"])
			modify_attribute(attribute_type, amount)
		if("choose_template")
			var/list/compiled_list = list()
			for(var/sheet_type in SKILL_TEMPLATE_SHEETS)
				var/datum/attribute_sheet/sheet = GLOB.attribute_sheets[sheet_type]
				compiled_list[sheet.name] = sheet_type
			var/chosen_sheet_type = input(user, "Choose a skill set template:", "Skills") as null|anything in compiled_list
			if(!chosen_sheet_type)
				return
			allocate_to_sheet(compiled_list[chosen_sheet_type])
