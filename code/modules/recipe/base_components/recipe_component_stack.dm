/datum/recipe_component/item/stack
	abstract_type = /datum/recipe_component/item/stack
	types = list(/obj/item/stack)
	// Required amount of items in the stack for this to pass.
	var/stack_amount = 1

/datum/recipe_component/item/stack/dispose_item(atom/movable/item)
	if(dispose_item)
		var/obj/item/stack/stack_item = item
		stack_item.use(stack_amount)

/datum/recipe_component/item/stack/check_item(atom/movable/item)
	var/obj/item/stack/stack_item = item
	if(stack_item.amount >= stack_amount)
		return TRUE
	return FALSE
