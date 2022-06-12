/datum/slapcraft_recipe/flamethrower
	name = "flamethrower"
	examine_hint = "You could craft a flamethrower, starting by attaching an igniter..."
	category = SLAP_CAT_WEAPONS
	steps = list(
		/datum/slapcraft_step/flamethrower_welder,
		/datum/slapcraft_step/flamethrower_igniter,
		/datum/slapcraft_step/stack/flamethrower_rod,
		/datum/slapcraft_step/tool/screwdriver/flamethrower
		)
	result_type = /obj/item/flamethrower

/datum/slapcraft_step/flamethrower_welder
	desc = "Start with normal sized welding tool."
	finished_desc = "A welding tool has been added."
	item_types = list(/obj/item/weldingtool)
	blacklist_item_types = list(/obj/item/weldingtool/mini, /obj/item/weldingtool/largetank, /obj/item/weldingtool/experimental)
	insert_item_into_result = TRUE

/datum/slapcraft_step/flamethrower_igniter
	desc = "Attach an igniter to the welder."
	finished_desc = "An igniter has been added to welder."
	todo_desc = "You could add an igniter to the welder..."
	finish_msg = "You attach the igniter to the welder."
	item_types = list(/obj/item/assembly/igniter)
	insert_item_into_result = TRUE

/datum/slapcraft_step/stack/flamethrower_rod
	desc = "Add a rod to the assembly."
	finished_desc = "A rod is added."
	todo_desc = "You could add a rod..."
	finish_msg = "You insert a rod to the assembly."
	item_types = list(/obj/item/stack/rods)
	amount = 1

/datum/slapcraft_step/tool/screwdriver/flamethrower
	desc = "Secure the parts with a screwdriver."
	todo_desc = "You could secure the parts with a screwdriver..."
	finish_msg = "You secure the parts with a screwdriver."
