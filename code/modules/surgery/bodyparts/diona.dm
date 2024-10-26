#define DIONA_LIGHT_BRUTE_MSG "jostled"
#define DIONA_MEDIUM_BRUTE_MSG "discoherent"
#define DIONA_HEAVY_BRUTE_MSG "riddled with dead nymphs"

#define DIONA_LIGHT_BURN_MSG "mottled"
#define DIONA_MEDIUM_BURN_MSG "charred"
#define DIONA_HEAVY_BURN_MSG "covered in smoldering nymphs"

//For ye whom may venture here, split up arm / hand sprites are formatted as "l_hand" & "l_arm".
//The complete sprite (displayed when the limb is on the ground) should be named "borg_l_arm".
//Failure to follow this pattern will cause the hand's icons to be missing due to the way get_limb_icon() works to generate the mob's icons using the aux_zone var.

/obj/item/bodypart/chest/diona
	name = "truncal nymph colony"
//	icon = "icons/mob/species/diona_parts.dmi"
//	icon_state = 'diona_chest'
	max_damage = 200
	species_id = "diona"
//	min_broken_damage = 50
//	amputation_point = "trunk"
//	encased = null
	dmg_overlay_type = "diona"
	light_brute_msg = DIONA_LIGHT_BRUTE_MSG
	medium_brute_msg = DIONA_MEDIUM_BRUTE_MSG
	heavy_brute_msg = DIONA_HEAVY_BRUTE_MSG
	light_burn_msg = DIONA_LIGHT_BURN_MSG
	medium_burn_msg = DIONA_MEDIUM_BURN_MSG
	heavy_burn_msg = DIONA_HEAVY_BURN_MSG

/obj/item/bodypart/l_arm/diona
	name = "left manipulatory nymph colony"
//	icon = "icons/mob/species/diona_parts.dmi"
//	icon_state = 'diona_l_arm'
	max_damage = 35
//	min_broken_damage = 20
//	amputation_point = "upper left trunk"
	attack_verb_continuous = list("lashes", "bludgeons")
	attack_verb_simple = list("lash", "bludgeon")
	species_id = "diona"
	dmg_overlay_type = "diona"
	light_brute_msg = DIONA_LIGHT_BRUTE_MSG
	medium_brute_msg = DIONA_MEDIUM_BRUTE_MSG
	heavy_brute_msg = DIONA_HEAVY_BRUTE_MSG
	light_burn_msg = DIONA_LIGHT_BURN_MSG
	medium_burn_msg = DIONA_MEDIUM_BURN_MSG
	heavy_burn_msg = DIONA_HEAVY_BURN_MSG

/obj/item/bodypart/r_arm/diona
	name = "right manipulatory nymph colony"
//	icon = "icons/mob/species/diona_parts.dmi"
//	icon_state = 'diona_r_arm'
	max_damage = 35
//	min_broken_damage = 20
//	amputation_point = "upper right trunk"
	attack_verb_continuous = list("lashes", "bludgeons")
	attack_verb_simple = list("lash", "bludgeon")
	species_id = "diona"
	dmg_overlay_type = "diona"
	light_brute_msg = DIONA_LIGHT_BRUTE_MSG
	medium_brute_msg = DIONA_MEDIUM_BRUTE_MSG
	heavy_brute_msg = DIONA_HEAVY_BRUTE_MSG
	light_burn_msg = DIONA_LIGHT_BURN_MSG
	medium_burn_msg = DIONA_MEDIUM_BURN_MSG
	heavy_burn_msg = DIONA_HEAVY_BURN_MSG

/obj/item/bodypart/l_leg/diona
	name = "left ambulatory nymph colony"
//	icon = "icons/mob/species/diona_parts.dmi"
//	icon_state = 'diona_l_leg'
	max_damage = 35
//	min_broken_damage = 20
//	amputation_point = "lower left fork"
	attack_verb_continuous = list("lashes", "bludgeons")
	attack_verb_simple = list("lash", "bludgeon")
	species_id = "diona"
	dmg_overlay_type = "diona"
	light_brute_msg = DIONA_LIGHT_BRUTE_MSG
	medium_brute_msg = DIONA_MEDIUM_BRUTE_MSG
	heavy_brute_msg = DIONA_HEAVY_BRUTE_MSG
	light_burn_msg = DIONA_LIGHT_BURN_MSG
	medium_burn_msg = DIONA_MEDIUM_BURN_MSG
	heavy_burn_msg = DIONA_HEAVY_BURN_MSG

/obj/item/bodypart/r_leg/diona
	name = "right ambulatory nymph colony"
//	icon = "icons/mob/species/diona_parts.dmi"
//	icon_state = 'diona_r_leg'
	max_damage = 35
//	min_broken_damage = 20
//	amputation_point = "lower right fork"
	attack_verb_continuous = list("lashes", "bludgeons")
	attack_verb_simple = list("lash", "bludgeon")
	species_id = "diona"
	dmg_overlay_type = "diona"
	light_brute_msg = DIONA_LIGHT_BRUTE_MSG
	medium_brute_msg = DIONA_MEDIUM_BRUTE_MSG
	heavy_brute_msg = DIONA_HEAVY_BRUTE_MSG
	light_burn_msg = DIONA_LIGHT_BURN_MSG
	medium_burn_msg = DIONA_MEDIUM_BURN_MSG
	heavy_burn_msg = DIONA_HEAVY_BURN_MSG

/obj/item/bodypart/head/diona
	name = "cephalic nymph colony"
//	icon = "icons/mob/species/diona_parts.dmi"
//	icon_state = 'diona_head'
	max_damage = 50
//	min_broken_damage = 25
//	encased = null
//	amputation_point = "upper trunk"
	species_id = "diona"
	dmg_overlay_type = "diona"
	light_brute_msg = DIONA_LIGHT_BRUTE_MSG
	medium_brute_msg = DIONA_MEDIUM_BRUTE_MSG
	heavy_brute_msg = DIONA_HEAVY_BRUTE_MSG
	light_burn_msg = DIONA_LIGHT_BURN_MSG
	medium_burn_msg = DIONA_MEDIUM_BURN_MSG
	heavy_burn_msg = DIONA_HEAVY_BURN_MSG


