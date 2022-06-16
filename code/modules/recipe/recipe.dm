/// A recipe which implements a way to create something from components, be it effects or items
/datum/recipe
	abstract_type = /datum/recipe
	/// Required appliance to perform this recipe.
	var/appliance
	/// Priority in which this recipe should be checked for. Broader recipes should have lower priorities, while more specific ones higher.
	var/priority = RECIPE_PRIORITY_NORMAL
	/// List of recipe_component's, all of them need to pass for the recipe to be completed.
	var/list/recipe_components
	/// Datum path to the result of the recipe.
	var/recipe_result

/datum/recipe/New()
	if(!appliance)
		CRASH("Recipe of type [type] has no appliance.")
	if(!recipe_result)
		CRASH("Recipe of type [type] has no recipe result.")
	if(!recipe_components)
		CRASH("Recipe of type [type] has no recipe components.")
	..()

// Tries to perform the recipe and returns TRUE if passed, FALSE if not.
/datum/recipe/proc/try_perform(atom/movable/source, list/atoms, list/conditions)
	var/turf/location = get_turf(source)

	// Create those two lists to allow components to "reserve" atoms to block other components
	var/list/atoms_available = atoms.Copy()
	// A list that components can add atoms to mark them as being used by the recipe.
	var/list/used = list()
	// List of component states for components to save.
	var/list/component_states = list()

	for(var/component_type in recipe_components)
		var/datum/recipe_component/comp = RECIPE_COMPONENT(component_type)
		component_states[component_type] = new comp.component_state
		if(!comp.check_component(source, location, atoms_available, conditions, component_states[component_type], used))
			return FALSE
	// All components have passed, see if the recipe can be performed.
	if(!check_recipe(source, location, used, conditions))
		return FALSE

	var/list/results = list()

	// Create the result.
	create_result(source, location, used, conditions, results)

	// "Apply" the checked components to the result.
	for(var/component_type in recipe_components)
		var/datum/recipe_component/comp = RECIPE_COMPONENT(component_type)
		comp.apply_component(source, location, used, conditions, component_states[component_type], results)

	// Use the checked components.
	for(var/component_type in recipe_components)
		var/datum/recipe_component/comp = RECIPE_COMPONENT(component_type)
		comp.use_component(source, location, used, conditions, component_states[component_type])

	return TRUE

// Called after all components have been checked, checks if the recipe can be performed.
/datum/recipe/proc/check_recipe(atom/movable/source, turf/location, list/atoms, list/conditions)
	return TRUE

// Creates a result of the recipe, this could be anything from making an item to creation an explosion.
/datum/recipe/proc/create_result(atom/movable/source, turf/location, list/atoms, list/conditions, list/results)
	var/datum/recipe_result/result = RECIPE_RESULT(recipe_result)
	result.create_result(source, location, atoms, conditions, results)
