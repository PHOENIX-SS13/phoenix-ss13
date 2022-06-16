/datum/recipe_component
	abstract_type = /datum/recipe_component
	/// Type of the state this recipe will use to save states.
	var/component_state = /datum/recipe_component_state

/// A proc to make using an item more verbose.
/datum/recipe_component/proc/use_item(atom/movable/item, list/used)
	used |= item

/// A proc to make reserving an item more verbose.
/datum/recipe_component/proc/reserve_item(atom/movable/item, list/atoms)
	atoms -= item

/// Returns whether the component of a recipe passes.
/datum/recipe_component/proc/check_component(atom/movable/source, turf/location, list/atoms, list/conditions, datum/recipe_component_state/state, list/used)
	return TRUE

/// Applies the component to the results of the recipe.
/datum/recipe_component/proc/apply_component(atom/movable/source, turf/location, list/atoms, list/conditions, datum/recipe_component_state/state, list/results)
	return

/// Uses up whatever the component was requiring, if anything. Called after the recipe's result is finished.
/datum/recipe_component/proc/use_component(atom/movable/source, turf/location, list/atoms, list/conditions, datum/recipe_component_state/state)
	return
