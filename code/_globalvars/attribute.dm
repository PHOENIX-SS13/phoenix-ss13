/// Associative list of attribute types to singletons
GLOBAL_LIST_INIT(attributes, build_attribute_list())
/// Associative list of skill types to singletons
GLOBAL_LIST_INIT(skills, build_skill_list())
/// Associative list of attribute sheet types to singletons
GLOBAL_LIST_INIT(attribute_sheets, build_attribute_sheet_list())

/proc/build_attribute_list()
	var/list/attribute_list = list()
	for(var/type in subtypesof(/datum/attribute))
		attribute_list[type] = new type()
	return attribute_list

/proc/build_skill_list()
	var/list/skill_list = list()
	for(var/type in subtypesof(/datum/skill))
		skill_list[type] = new type()
	return skill_list

/proc/build_attribute_sheet_list()
	var/list/attribute_sheet_list = list()
	for(var/type in subtypesof(/datum/attribute_sheet))
		attribute_sheet_list[type] = new type()
	return attribute_sheet_list
