/// This step requires an item with a specific tool behaviour.
/datum/slapcraft_step/tool
	abstract_type = /datum/slapcraft_step/tool
	insert_item = FALSE
	check_types = FALSE
	/// What tool behaviour do we need for this step.
	var/tool_behaviour
	/// How much fuel is required, only relevant for welding tools.
	var/required_fuel = 0

/datum/slapcraft_step/tool/can_perform(mob/living/user, obj/item/item)
	if(item.tool_behaviour != tool_behaviour)
		return FALSE
	if(!item.tool_use_check(user, required_fuel))
		return
	return TRUE

/datum/slapcraft_step/tool/perform_do_after(mob/living/user, obj/item/item, obj/item/slapcraft_assembly/assembly, time_to_do)
	// This will play the tool sound aswell. Rackety
	if(!item.use_tool(assembly, user, time_to_do, volume = 50))
		return FALSE
	return TRUE

// Only relevant for welding tools I believe.
/datum/slapcraft_step/tool/on_perform(mob/living/user, obj/item/item, obj/item/slapcraft_assembly/assembly)
	item.use(required_fuel)

/datum/slapcraft_step/tool/screwdriver
	abstract_type = /datum/slapcraft_step/tool/screwdriver
	list_desc = "screwdriver"
	tool_behaviour = TOOL_SCREWDRIVER
