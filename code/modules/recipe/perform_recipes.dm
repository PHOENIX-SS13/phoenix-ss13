/// Attempts to perform recipes with the passed arguments.
/proc/perform_recipes(appliance, atom/source, list/atoms, list/conditions)
	// Recipe list which is already sorted while building the global list.
	var/list/recipe_list = GLOB.appliance_recipes[appliance]
	for(var/datum/recipe/recipe as anything in recipe_list)
		if(recipe.try_perform(source, atoms, conditions))
			// Remove used up atoms.
			for(var/atom/movable/check_atom as anything in atoms)
				if(QDELETED(check_atom))
					atoms -= check_atom
			. = TRUE
