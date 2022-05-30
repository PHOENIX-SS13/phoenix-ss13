/datum/sprite_accessory/wings
	icon = 'icons/mob/clothing/wings.dmi'
	generic = "Wings"
	key = "wings"
	color_src = USE_ONE_COLOR
	recommended_species = list("human", "felinid", "lizard", "mammal")
	organ_type = /obj/item/organ/wings
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER, BODY_ADJ_LAYER)

/datum/sprite_accessory/wings/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.wear_suit && H.try_hide_mutant_parts)
		return TRUE
	return FALSE

/datum/sprite_accessory/wings/none
	name = "None"
	icon_state = "none"
	factual = FALSE

/datum/sprite_accessory/wings/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	locked = TRUE
	color_src = USE_ONE_COLOR
	default_color = "FFF"

/datum/sprite_accessory/wings/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/megamoth
	name = "Megamoth"
	icon_state = "megamoth"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE
	color_src = USE_ONE_COLOR
	default_color = "FFF"

/datum/sprite_accessory/wings/moth
	icon = 'icons/mob/sprite_accessory/moth_wings.dmi' //Needs new icon to suit new naming convention
	default_color = "FFF"
	recommended_species = list("moth", "mammal", "insect") //Mammals too, I guess. They wont get flight though, see the wing organs for that logic
	organ_type = /obj/item/organ/wings/moth
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/wings/moth/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if((H.wear_suit && (H.try_hide_mutant_parts || (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(H.dna.species, H.wear_suit.species_exception)))))
		return TRUE
	return FALSE

/datum/sprite_accessory/wings/moth/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/wings/moth/monarch
	name = "Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/wings/moth/luna
	name = "Luna"
	icon_state = "luna"

/datum/sprite_accessory/wings/moth/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/wings/moth/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/wings/moth/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/wings/moth/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/wings/moth/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/wings/moth/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/wings/moth/punished
	name = "Burnt Off"
	icon_state = "punished"
	locked = TRUE

/datum/sprite_accessory/wings/moth/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/wings/moth/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/wings/moth/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/wings/moth/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/wings/moth/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/wings/moth/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/wings/moth/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/wings/moth/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/wings/moth/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/wings/moth/rosy
	name = "Rosy"
	icon_state = "rosy"

/datum/sprite_accessory/wings/moth/featherful
	name = "Featherful"
	icon_state = "featherful"

/datum/sprite_accessory/wings/moth/brown
	name = "Brown"
	icon_state = "brown"

/datum/sprite_accessory/wings/moth/plasmafire
	name = "Plasmafire"
	icon_state = "plasmafire"

/datum/sprite_accessory/wings/mammal
	icon = 'icons/mob/sprite_accessory/wings.dmi'
	default_color = DEFAULT_PRIMARY
	recommended_species = list("mammal", "lizard")
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)


/datum/sprite_accessory/wings/mammal/wide
	icon = 'icons/mob/sprite_accessory/wingswide.dmi'
	dimension_x = 46
	dimension_y = 34
	center = TRUE

/datum/sprite_accessory/wings/mammal/bat //TODO: port my sprite from hyper for this one
	name = "Bat"
	icon_state = "bat"

/datum/sprite_accessory/wings/mammal/fairy
	name = "Fairy"
	icon_state = "fairy"

/datum/sprite_accessory/wings/mammal/feathery
	name = "Feathery"
	icon_state = "feathery"

/datum/sprite_accessory/wings/mammal/wide/featheryalt1
	name = "Feathery (alt 1)"
	icon_state = "featheryalt1"

/datum/sprite_accessory/wings/mammal/wide/featheryalt2
	name = "Feathery (alt 2)"
	icon_state = "featheryalt2"

/datum/sprite_accessory/wings/mammal/bee
	name = "Bee"
	icon_state = "bee"

/datum/sprite_accessory/wings/mammal/wide/succubus
	name = "Succubus"
	icon_state = "succubus"

/datum/sprite_accessory/wings/mammal/wide/dragon_synth
	name = "Dragon (synthetic alt)"
	icon_state = "dragonsynth"

/datum/sprite_accessory/wings/mammal/wide/dragon_alt1
	name = "Dragon (alt 1)"
	icon_state = "dragonalt1"

/datum/sprite_accessory/wings/mammal/wide/dragon_alt2
	name = "Dragon (alt 2)"
	icon_state = "dragonalt2"

/datum/sprite_accessory/wings/mammal/wide/harpywings
	name = "Harpy"
	icon_state = "harpy"

/datum/sprite_accessory/wings/mammal/wide/harpywingsalt1
	name = "Harpy (alt 1)"
	icon_state = "harpyalt"

/datum/sprite_accessory/wings/mammal/wide/harpywingsalt2
	name = "Harpy (Bat)"
	icon_state = "harpybat"


/datum/sprite_accessory/wings/mammal/wide/harpywings_top
	name = "Harpy (Top)"
	icon_state = "harpy_top"

/datum/sprite_accessory/wings/mammal/wide/harpywingsalt1_top
	name = "Harpy (alt 1) (Top)"
	icon_state = "harpyalt_top"

/datum/sprite_accessory/wings/mammal/wide/harpywingsalt2_top
	name = "Harpy (Bat) (Top)"
	icon_state = "harpybat_top"

/datum/sprite_accessory/wings/mammal/wide/low_wings
	name = "Low wings"
	icon_state = "low"

/datum/sprite_accessory/wings/mammal/wide/low_wings_top
	name = "Low wings (Top)"
	icon_state = "low_top"

/datum/sprite_accessory/wings/mammal/wide/spider
	name = "Spider legs"
	icon_state = "spider_legs"

/datum/sprite_accessory/wings/mammal/wide/robowing
	name = "mechanical dragon wings"
	icon_state = "robowing"

/datum/sprite_accessory/wings/skeleton
	name = "Skeleton"
	icon_state = "skele"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/skeleton
	name = "Skeleton"
	icon_state = "skele"
	dimension_x = 96
	center = TRUE
	dimension_y = 32

/datum/sprite_accessory/wings/robotic
	name = "Robotic"
	icon_state = "robotic"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/robotic
	name = "Robotic"
	icon_state = "robotic"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
