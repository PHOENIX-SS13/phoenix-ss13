/// We need to load loadout item datum after greyscale subsystem parsed them
SUBSYSTEM_DEF(loadouts)
	name = "Loadouts"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_GREYSCALE - 1 //Always after greyscale

/datum/controller/subsystem/loadouts/Initialize()
	for(var/loadout_type as anything in GLOB.loadout_items)
		var/datum/loadout_item/loadout_item = GLOB.loadout_items[loadout_type]
		loadout_item.parse_gags()
	return ..()
