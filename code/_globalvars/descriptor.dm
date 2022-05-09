GLOBAL_LIST_INIT(descriptors, init_descriptors())

/proc/init_descriptors()
	var/list/descriptors = list()
	for(var/type in subtypesof(/datum/descriptor))
		descriptors[type] = new type()
	return descriptors
