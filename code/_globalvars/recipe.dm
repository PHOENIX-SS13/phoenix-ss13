GLOBAL_LIST_INIT(recipe_components, build_recipe_component_list())
GLOBAL_LIST_INIT(recipe_results, build_recipe_result_list())
GLOBAL_LIST_EMPTY(appliance_recipes)
GLOBAL_LIST_INIT(recipes, build_recipe_list())

/proc/build_recipe_result_list()
	var/list/recipe_result_list = list()
	for(var/type in typesof(/datum/recipe_result))
		if(is_abstract(type))
			continue
		recipe_result_list[type] = new type()
	return recipe_result_list

/proc/build_recipe_component_list()
	var/list/recipe_component_list = list()
	for(var/type in typesof(/datum/recipe_component))
		if(is_abstract(type))
			continue
		recipe_component_list[type] = new type()
	return recipe_component_list

/proc/build_recipe_list()
	var/list/recipe_list = list()
	for(var/type in typesof(/datum/recipe))
		if(is_abstract(type))
			continue
		var/datum/recipe/new_recipe = new type()
		recipe_list[type] = new_recipe

		if(!GLOB.appliance_recipes[new_recipe.appliance])
			GLOB.appliance_recipes[new_recipe.appliance] = list()
		GLOB.appliance_recipes[new_recipe.appliance] += new_recipe

	// Sort the appliance recipes lists by recipe priority.
	for(var/appliance in GLOB.appliance_recipes)
		sortTim(GLOB.appliance_recipes[appliance],GLOBAL_PROC_REF(cmp_recipe_priority), associative = FALSE)

	return recipe_list
