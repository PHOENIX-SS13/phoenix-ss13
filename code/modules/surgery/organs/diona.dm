/obj/item/bodypart/chest/diona
	name = "core trunk"
	max_damage = 200
//	min_broken_damage = 50
//	amputation_point = "trunk"
//	encased = null
//	gendered_icon = FALSE

/obj/item/bodypart/l_arm/diona
	name = "left upper tendril"
	max_damage = 35
//	min_broken_damage = 20
//	amputation_point = "upper left trunk"
	attack_verb_continuous = list("lashes", "bludgeons")
	attack_verb_simple = list("lash", "bludgeon")

/obj/item/bodypart/r_arm/diona
	name = "right upper tendril"
	max_damage = 35
//	min_broken_damage = 20
//	amputation_point = "upper right trunk"
	attack_verb_continuous = list("lashes", "bludgeons")
	attack_verb_simple = list("lash", "bludgeon")

/obj/item/bodypart/l_leg/diona
	name = "left lower tendril"
	max_damage = 35
//	min_broken_damage = 20
//	amputation_point = "lower left fork"
	attack_verb_continuous = list("lashes", "bludgeons")
	attack_verb_simple = list("lash", "bludgeon")

/obj/item/bodypart/r_leg/diona
	name = "right lower tendril"
	max_damage = 35
//	min_broken_damage = 20
//	amputation_point = "lower right fork"
	attack_verb_continuous = list("lashes", "bludgeons")
	attack_verb_simple = list("lash", "bludgeon")

/obj/item/bodypart/head/diona
	max_damage = 50
//	min_broken_damage = 25
//	encased = null
//	amputation_point = "upper trunk"
//	gendered_icon = FALSE

/obj/item/organ/diona/process()
	return

/// Turns into a nymph instantly, no transplanting possible.
/obj/item/organ/heart/diona
	name = "neural strata"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/obj/item/organ/lungs/diona
	name = "respiratory vacuoles"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/// Turns into a nymph instantly, no transplanting possible.
/obj/item/organ/brain/diona
	name = "gas bladder"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/// Turns into a nymph instantly, no transplanting possible.
/obj/item/organ/kidneys/diona
	name = "polyp segment"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/// Turns into a nymph instantly, no transplanting possible.
/obj/item/organ/appendix/diona
	name = "anchoring ligament"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/// Turns into a nymph instantly, no transplanting possible.
/obj/item/organ/eyes/diona
	name = "receptor node"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

//TODO:Make absorb rads on insert //done! radimmune!

/// Turns into a nymph instantly, no transplanting possible.
/obj/item/organ/liver/diona
	name = "nutrient vessel"
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"
	alcohol_tolerance = 0.5
