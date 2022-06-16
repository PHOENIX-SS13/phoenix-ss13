/// Datums to handle creation of results from recipes.
/datum/recipe_result
	abstract_type = /datum/recipe_result

/datum/recipe_result/proc/create_result(atom/movable/source, turf/location, list/atoms, list/conditions, list/results)
	return
