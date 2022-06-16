/datum/recipe_component/item/reagent
	abstract_type = /datum/recipe_component/item/reagent
	dispose_item = FALSE //By default dont delete the container of the reagents
	types = list(/obj/item/reagent_containers)
	/// Whether to consume the reagents.
	var/use_reagents = TRUE
	/// The type of the reagent to use.
	var/reagent_type
	/// Amount of the reagent to use.
	var/reagent_amount = 0
	/// Reagent list to be used for checks and interactions instead of above single type.
	var/list/reagent_list
	/// If defined, it's the minimum required temperature.
	var/minimum_temp
	/// If defined, it's the maximum required temperature.
	var/maximum_temp
	/// Whether we need an open container to do this.
	var/needs_open_container = TRUE

/datum/recipe_component/item/reagent/New()
	if(!reagent_type && !reagent_list)
		CRASH("Reagent recipe component doesn't specify any reagents.")
	..()

/datum/recipe_component/item/reagent/check_item(atom/movable/item)
	if(!item.reagents)
		return FALSE
	if(needs_open_container && !item.is_open_container())
		return FALSE
	if(!isnull(minimum_temp) && item.reagents.chem_temp < minimum_temp)
		return FALSE
	if(!isnull(maximum_temp) && item.reagents.chem_temp > maximum_temp)
		return FALSE
	if(reagent_list)
		if(!item.reagents.has_reagent_list(reagent_list))
			return FALSE
	else
		if(!item.reagents.has_reagent(reagent_type, reagent_amount))
			return FALSE
	return TRUE

/datum/recipe_component/item/reagent/dispose_item(atom/movable/item)
	// Delete the reagents if we need to.
	if(use_reagents)
		if(reagent_list)
			item.reagents.remove_reagent_list(reagent_list)
		else
			item.reagents.remove_reagent(reagent_type, reagent_amount)
	// Delete the container if we need to.
	..()
