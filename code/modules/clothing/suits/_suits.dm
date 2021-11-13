/obj/item/clothing/suit
	icon = 'icons/obj/clothing/suits.dmi'
	worn_icon = 'icons/mob/clothing/suit.dmi'
	name = "suit"
	var/fire_resist = T0C+100
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	slot_flags = ITEM_SLOT_OCLOTHING
	fitted_bodytypes = BODYTYPE_DIGITIGRADE
	var/blood_overlay_type = "suit"
	var/togglename = null
	var/suittoggled = FALSE
	limb_integrity = 0 // disabled for most exo-suits
	large_worn_icon = 'icons/mob/clothing/wide_suits.dmi'


/obj/item/clothing/suit/worn_overlays(mutable_appearance/standing, isinhands = FALSE, file2use, bodytype = BODYTYPE_HUMANOID)
	. = ..()
	if(isinhands)
		return

	if(damaged_clothes)
		var/damagefile2use = (bodytype & BODYTYPE_TAUR_ALL) ? 'icons/horizon/mob/64x32_item_damage.dmi' : 'icons/effects/item_damage.dmi'
		. += mutable_appearance(damagefile2use, "damaged[blood_overlay_type]")
	if(HAS_BLOOD_DNA(src))
		var/bloodfile2use = (bodytype & BODYTYPE_TAUR_ALL) ? 'icons/horizon/mob/64x32_blood.dmi' : 'icons/effects/blood.dmi'
		. += mutable_appearance(bloodfile2use, "[blood_overlay_type]blood")

	var/mob/living/carbon/human/M = loc
	if(!ishuman(M) || !M.w_uniform)
		return
	var/obj/item/clothing/under/U = M.w_uniform
	if(istype(U) && U.attached_accessory)
		var/obj/item/clothing/accessory/A = U.attached_accessory
		if(A.above_suit)
			. += U.accessory_overlay

/obj/item/clothing/suit/update_clothes_damaged_state(damaged_state = CLOTHING_DAMAGED)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_wear_suit()
