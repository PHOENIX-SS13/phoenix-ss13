/datum/recipe_component_state/item
	/// Keeps track of items used by this component
	var/list/used_items = list()

/datum/recipe_component/item
	abstract_type = /datum/recipe_component/item
	component_state = /datum/recipe_component_state/item
	/// Whether we reserve the item, blocking other components from using it.
	var/reserve_item = TRUE
	/// Whether we mark the item as used so the recipe can know which item is used.
	var/use_item = TRUE
	/// Whether we delete the item after the recipe is finished.
	var/dispose_item = TRUE
	/// Whether we use a typecheck to find the item.
	var/check_types = TRUE
	/// List of valid types.
	var/list/types
	/// Typecache of valid types.
	var/list/typecache
	/// List of blacklisted types.
	var/list/blacklist_types
	/// Typecache of blacklisted types.
	var/list/blacklist_typecache
	/// Minimum amount of required items in this component.
	var/min_amount = 1
	/// Maximum amount of required items in this component.
	var/max_amount = 1

/datum/recipe_component/item/New()
	..()
	if(check_types)
		if(!types)
			CRASH("Item recipe component of type [type] checks types but lacks them.")
		typecache = typecacheof(types)
		if(blacklist_types)
			blacklist_typecache = typecacheof(blacklist_types)

/datum/recipe_component/item/check_component(atom/movable/source, turf/location, list/atoms, list/conditions, datum/recipe_component_state/item/state, list/used)
	var/items_so_far = 0
	for(var/atom/movable/item as anything in atoms)
		// Check item type
		if(!check_item_type(item.type))
			continue
		// Check item through virtual proc.
		if(!check_item(item))
			continue
		// We passed
		items_so_far++
		state.used_items += item
		// Reserve the item if desired.
		if(reserve_item)
			reserve_item(item, atoms)
		// Mark the item as used if desired.
		if(use_item)
			use_item(item, used)
		// We got the maximum amount of items.
		if(items_so_far >= max_amount)
			break
	if(items_so_far >= min_amount)
		return TRUE
	return FALSE

/datum/recipe_component/item/use_component(atom/movable/source, turf/location, list/atoms, list/conditions, datum/recipe_component_state/item/state)
	for(var/atom/movable/item as anything in state.used_items)
		dispose_item(item)

/// Disposes of the item
/datum/recipe_component/item/proc/dispose_item(atom/movable/item)
	if(dispose_item)
		qdel(item)

/// Checks if the item type is valid.
/datum/recipe_component/item/proc/check_item_type(item_type)
	if(!check_types)
		return TRUE
	if(typecache[item_type])
		if(blacklist_typecache && blacklist_typecache[item_type])
			return FALSE
		return TRUE
	return FALSE

/// Virtual to allow subtypes to check whether an item is valid.
/datum/recipe_component/item/proc/check_item(atom/movable/item)
	return TRUE
