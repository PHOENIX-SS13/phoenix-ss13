/datum/species/diona
	name = "Diona"
	//name_plural = "Dionae"
	id = "diona"
	flavor_text = "The Dionae are plant-like creatures made up of a gestalt of smaller Nymphs. Dionae lack any form of \
	centralized government or homeworld, the closest thing being their known origin point, the Topiary in the Epislon \
	Ursae Minoris system. Avoiding the affairs of the wider galaxy, most prefer instead to focus \
	on the spread of their species.<br/><br/> As a gestalt entity, each nymph possesses an individual personality, yet \
	they communicate collectively. Consequently, Diona often speak in a unique blend of first and third person, using \
	'We' and 'I' to reflect their internal dialogue."
	inherent_traits = list(
		TRAIT_CAN_STRIP,
		TRAIT_RADIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_STABLEHEART,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NO_HUSK
	)
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID | MOB_PLANT
	cultures = list(CULTURES_GENERIC, CULTURES_HUMAN, CULTURES_PLANT)
	locations = list(LOCATIONS_GENERIC, LOCATIONS_HUMAN, LOCATIONS_PLANT)
	factions = list(FACTIONS_GENERIC, FACTIONS_HUMAN, FACTIONS_PLANT)
	default_color = "000"
	breathid = "co2" // plants breathe co2!
	mutantliver	=   /obj/item/organ/liver/diona
	mutantlungs	=   /obj/item/organ/lungs/diona
	mutantheart	=   /obj/item/organ/heart/diona
	mutanteyes	=   /obj/item/organ/eyes/diona //Default darksight of 2.
	mutantbrain =   /obj/item/organ/brain/diona
	mutantkidneys = /obj/item/organ/kidneys/diona
	mutantappendix = /obj/item/organ/appendix/diona
	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/diona,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/diona,
		BODY_ZONE_HEAD  = /obj/item/bodypart/head/diona,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/diona,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/diona,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/diona,
	)
	//max_age = 300
	limbs_icon = 'icons/mob/species/diona_parts.dmi'
	var/pod = FALSE //did they come from a pod? If so, they're stronger than normal Diona.

/*
	//language = "Nymphsong"
	//speech_sounds = list('sound/voice/dionatalk1.ogg') //Credit https://www.youtube.com/watch?v=ufnvlRjsOTI [0:13 - 0:16]
	//speech_chance = 20
	//unarmed_type = /datum/unarmed_attack/diona
	//remains_type = /obj/effect/decal/cleanable/ash
	//heatmod = 3
	//clothing_flags = HAS_SOCKS
	//default_hair_colour = "#000000"
	//bodyflags = SHAVED
	//dietflags = DIET_HERB		//Diona regenerate nutrition in light and water, no diet necessary, but if they must, they eat other plants *scream
	//taste_sensitivity = TASTE_SENSITIVITY_DULL
	skinned_type = /obj/item/stack/sheet/wood
	flesh_color = "#907E4A"

	blood_color = "#004400"
	butt_sprite = "diona"
	reagent_tag = PROCESS_ORG

	has_limbs = list(
		"chest" =  list("path" = /obj/item/organ/external/chest/diona, "descriptor" = "core trunk"),
		"groin" =  list("path" = /obj/item/organ/external/groin/diona, "descriptor" = "fork"),
		"head" =   list("path" = /obj/item/organ/external/head/diona, "descriptor" = "head"),
		"l_arm" =  list("path" = /obj/item/organ/external/arm/diona, "descriptor" = "left upper tendril"),
		"r_arm" =  list("path" = /obj/item/organ/external/arm/right/diona, "descriptor" = "right upper tendril"),
		"l_leg" =  list("path" = /obj/item/organ/external/leg/diona, "descriptor" = "left lower tendril"),
		"r_leg" =  list("path" = /obj/item/organ/external/leg/right/diona, "descriptor" = "right lower tendril"),
		"l_hand" = list("path" = /obj/item/organ/external/hand/diona, "descriptor" = "left grasper"),
		"r_hand" = list("path" = /obj/item/organ/external/hand/right/diona, "descriptor" = "right grasper"),
		"l_foot" = list("path" = /obj/item/organ/external/foot/diona, "descriptor" = "left foot"),
		"r_foot" = list("path" = /obj/item/organ/external/foot/right/diona, "descriptor" = "right foot")
		)

	suicide_messages = list(
		"is losing branches!",
		"pulls out a secret stash of herbicide and takes a hearty swig!",
		"is pulling themselves apart!")

/datum/species/diona/can_understand(mob/other)
	if(isnymph(other))
		return TRUE
	return FALSE
*/
/datum/species/diona/on_species_gain(mob/living/carbon/human/H)
	..()
	H.gender = NEUTER

/datum/species/diona/on_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.clear_alert("nolight")

	for(var/mob/living/simple_animal/diona/N in H.contents) // Let nymphs wiggle out
		N.split()

/datum/species/diona/handle_reagents(mob/living/carbon/human/H, datum/reagent/R)
	if(R.id == "glyphosate" || R.id == "atrazine")
		H.adjustToxLoss(3) //Deal aditional damage
		return TRUE
	return ..()

/datum/species/diona/handle_life(mob/living/carbon/human/H)
	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	var/is_vamp = H.mind && H.mind.has_antag_datum(/datum/antagonist/vampire)
	if(isturf(H.loc)) //else, there's considered to be no light
		var/turf/T = H.loc
		light_amount = min(1, T.get_lumcount()) - 0.5
		if(light_amount > 0)
			H.clear_alert("nolight")
		else
			H.throw_alert("nolight", /atom/movable/screen/alert/nolight)

		if(!is_vamp)
			H.adjust_nutrition(light_amount * 10)
			if(H.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
				H.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL)

		if(light_amount > 0.2 && !H.suiciding) //if there's enough light, heal
			if(!pod && H.health <= 0)
				return
			H.adjustBruteLoss(-1)
			H.adjustToxLoss(-1)
			H.adjustOxyLoss(-1)

	if(!is_vamp && H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		H.adjustBruteLoss(2)
	..()

/datum/species/diona/bullet_act(obj/item/projectile/P, mob/living/carbon/human/H, def_zone)
	if(istype(P, /obj/item/projectile/energy/floramut))
		P.nodamage = TRUE
		H.Weaken(1 SECONDS)
		if(prob(80))
			randmutb(H)
		else
			randmutg(H)
		H.visible_message("[H] writhes for a moment as [H.p_their()] nymphs squirm and mutate.", "All of you squirm uncomfortably for a moment as you feel your genes changing.")
	else if(istype(P, /obj/item/projectile/energy/florayield))
		P.nodamage = TRUE
		var/obj/item/bodypart/organ = H.getorgan(check_zone(def_zone))
		if(!organ)
			organ = H.getorgan("chest")
		organ.heal_damage(5, 5)
		H.visible_message("[H] seems invogorated as [P] hits [H.p_their()] [organ.name].", "Your [organ.name] greedily absorbs [P].")
	return TRUE

/// Same name and everything; we want the same limitations on them; we just want their regeneration to kick in at all times and them to have special factions
/datum/species/diona/pod
	name = "Podgrown Diona" //Seperate name needed else can't select diona period
	id = "diona/pod"
	pod = TRUE
	inherent_factions = list("plants", "vines")
