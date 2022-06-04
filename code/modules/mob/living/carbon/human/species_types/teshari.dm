/datum/species/teshari //small voxes
	name = "Avali"
	id = "teshari"
	default_color = "6060FF"
	eyes_icon = 'icons/mob/species/teshari_eyes.dmi'
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		NO_UNDERWEAR,
		HAS_FLESH,
		HAS_BONE,
		HAS_MARKINGS,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
	)
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"ears" = ACC_RANDOM,
	)
	mutanttongue = /obj/item/organ/tongue/avian
	disliked_food = GROSS | GRAIN
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	limbs_icon = 'icons/mob/species/teshari_parts_greyscale.dmi'
	offset_features = list(
		OFFSET_EARS = list(0,-4),
		OFFSET_FACEMASK = list(0,-5),
		OFFSET_HEAD = list(0,-4),
		OFFSET_FACE = list(0,-4),
		OFFSET_BELT = list(0,-4),
		OFFSET_BACK = list(0,-4),
		OFFSET_NECK = list(0,-4),
		OFFSET_INHANDS = list(0,-2),
		OFFSET_SUIT = list(0,-4),
		OFFSET_S_STORE = list(0,-2),
		OFFSET_GLASSES = list(0,-5),
		OFFSET_ID = list(0,-4),
		OFFSET_ACCESSORY = list(0,-4),
	)
	coldmod = 0.3 // Except cold.
	heatmod = 1.5
	brutemod = 1.5
	burnmod = 1.5 // They take more damage from practically everything
	punchdamagelow = 2 // Lower bound punch damage
	punchdamagehigh = 6
	bodytemp_normal = BODYTEMP_NORMAL - 50
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT - 50
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT - 50
	species_language_holder = /datum/language_holder/teshari
	learnable_languages = list(
		/datum/language/common,
		/datum/language/schechi,
	)
	body_size_restricted = TRUE
	bodytype = BODYTYPE_TESHARI
	flavor_text = "A race of feathered raptors who developed alongside the Skrell, inhabiting the polar tundral regions outside of Skrell territory. Extremely fragile, they developed hunting skills that emphasized taking out their prey without themselves getting hit. They are only recently becoming known on human stations after reaching space with Skrell assistance."

/datum/species/teshari/get_bodytype(item_slot = NONE, obj/item/checked_item_for)
	///Always return a Teshari bodytype if the item accounts for it
	if(checked_item_for && checked_item_for.fitted_bodytypes & bodytype)
		return bodytype
	///Treat as having a digitigrade head cause of a snout shape, if above check didn't go through
	if((item_slot == ITEM_SLOT_HEAD || item_slot == ITEM_SLOT_MASK))
		return BODYTYPE_DIGITIGRADE
	return bodytype
