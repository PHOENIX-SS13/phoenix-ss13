/obj/item/organ/diona/process()
	return

/// All these turn into a nymph instantly, no transplanting possible.

/obj/item/organ/heart/diona
	name = "neural strata"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/obj/item/organ/lungs/diona
	name = "respiratory vacuoles"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/obj/item/organ/brain/diona
	name = "gas bladder"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/obj/item/organ/kidneys/diona
	name = "polyp segment"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/obj/item/organ/appendix/diona
	name = "anchoring ligament"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/obj/item/organ/eyes/diona
	name = "electromagnetic receptor array"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

//TODO:Make absorb rads on insert //done! radimmune!
/obj/item/organ/liver/diona
	name = "nutrient vessel"
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"
	alcohol_tolerance = 0.5

/obj/item/organ/tongue/diona
	name = "sonic resonance gland network"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

//dionae are giant colonies right? there should be a lot of decentralized systems crammed in there
/obj/item/organ/eyes/diona/alt
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_ADAMANTINE_RESONATOR
	name = "narrow-band electromagnetic receptor node"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/obj/item/organ/eyes/diona/alt/alt
	zone = BODY_ZONE_CHEST
	name = "wide-spectrum electromagnetic receptor node"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/obj/item/organ/heart/diona/alt //groin organ one
	zone = BODY_ZONE_PRECISE_GROIN
	name = "auxiliary neural strata"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"

/obj/item/organ/tongue/diona/alt //and groin organ two
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_XENO_HIVENODE
	name = "electromagnetic resonance gland network"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"
