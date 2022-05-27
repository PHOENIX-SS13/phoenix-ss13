/datum/sprite_accessory/horns
	key = "horns"
	generic = "Horns"
	relevent_layers = list(BODY_FRONT_LAYER)
	icon = 'icons/mob/sprite_accessory/horns.dmi'
	default_color = "555"

/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
		return TRUE
	return FALSE

/datum/sprite_accessory/horns/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/horns/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/horns/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/horns/curled
	name = "Curled"
	icon_state = "curled"

/datum/sprite_accessory/horns/ram
	name = "Ram"
	icon_state = "ram"

/datum/sprite_accessory/horns/angler
	name = "Angeler"
	icon_state = "angler"
	default_color = DEFAULT_SECONDARY

/datum/sprite_accessory/horns/guilmon
	name = "Guilmon"
	icon_state = "guilmon"

/datum/sprite_accessory/horns/drake
	name = "Drake"
	icon_state = "drake"

/datum/sprite_accessory/horns/knight
	name = "Knight"
	icon_state = "knight"

//BIG HORNS


/datum/sprite_accessory/horns/big
	icon = 'icons/mob/sprite_accessory/horns_big.dmi'

/datum/sprite_accessory/horns/big/antlers
	name = "Antlers"
	icon_state = "antlers"
	relevent_layers = list(BODY_FRONT_LAYER, BODY_ADJ_LAYER, BODY_BEHIND_LAYER)
