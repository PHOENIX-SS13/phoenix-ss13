/datum/recipe_result/item
	abstract_type = /datum/recipe_result/item
	/// Type of the item to spawn.
	var/item_type
	/// Amount of the item to spawn.
	var/item_amount = 1
	/// Alternatively you can use an associative list of items to amounts of created.
	var/list/item_list
	/// Whether to spawn the items in the source, otherwise the location turf will be used
	var/spawn_in_source = FALSE

/datum/recipe_result/item/New()
	if(!item_type && !item_list)
		CRASH("Item recipe result of type [type] doesn't spawn any items.")
	..()

/datum/recipe_result/item/create_result(atom/movable/source, turf/location, list/atoms, list/conditions, list/results)
	var/atom/destination = spawn_in_source ? source : location
	if(item_list)
		for(var/iterated_item_type in item_list)
			var/amount = item_list[iterated_item_type]
			for(var/i in 1 to amount)
				results += new iterated_item_type(destination)
	else
		for(var/i in 1 to item_amount)
			results += new item_type(destination)
