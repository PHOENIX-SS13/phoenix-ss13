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
	species_language_holder = /datum/language_holder/plant
	always_customizable = TRUE
	default_color = "000"
	breathid = "co2" // plants breathe co2!
	exotic_bloodtype = "D"
	meat = /obj/item/food/meat/slab/human/mutant/plant
	say_mod = list(
		"creaks",
		"oscillates",
		"emits"
	)
	mutantliver	=   /obj/item/organ/liver/diona
	mutantlungs	=   /obj/item/organ/lungs/diona
	mutantheart	=   /obj/item/organ/heart/diona
	mutanteyes	=   /obj/item/organ/eyes/diona //Default darksight of 2.
	mutantbrain =   /obj/item/organ/brain/diona
	mutantappendix = /obj/item/organ/appendix/diona
	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/diona,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/diona,
		BODY_ZONE_HEAD  = /obj/item/bodypart/head/diona,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/diona,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/diona,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/diona,
	)

	liked_food = VEGETABLES | FRUIT | GRAIN
	disliked_food = ALCOHOL
	toxic_food = MEAT

	limbs_icon = 'icons/mob/species/diona_parts.dmi'
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	var/pod = FALSE //did they come from a pod? If so, they're stronger than normal Diona.

	ass_image = "icons/ass/assdiona.png"

	burnmod = 1.25
	heatmod = 1.5
	speedmod = 1.2
/*
	language = "Nymphsong"
	speech_sounds = list('sound/voice/dionatalk1.ogg') //Credit https://www.youtube.com/watch?v=ufnvlRjsOTI [0:13 - 0:16]
	speech_chance = 20
	unarmed_type = /datum/unarmed_attack/diona

	max_age = 300

	bodyflags = SHAVED
	dietflags = DIET_HERB	//Diona regenerate nutrition in light and water, no diet necessary, but if they must, they eat other plants *scream
	taste_sensitivity = TASTE_SENSITIVITY_DULL
	reagent_tag = PROCESS_ORG

	flesh_color = "#907E4A"
	default_hair_colour = "#000000"
	blood_color = "#004400"
	skinned_type = /obj/item/stack/sheet/wood
	remains_type = /obj/effect/decal/cleanable/ash
*/

/datum/species/diona/can_understand(mob/other)
	if(isnymph(other))
		return TRUE
	return FALSE

/datum/species/diona/on_species_gain(mob/living/carbon/human/H)
	..()
	H.gender = NEUTER

/datum/species/diona/on_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.clear_alert("nolight")

	for(var/mob/living/simple_animal/diona/N in H.contents) // Let nymphs wiggle out
		N.split()

/datum/species/diona/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H, delta_time, times_fired)
	if(chem.type == /datum/reagent/toxin/plantbgone || chem.type == /datum/reagent/toxin/plantbgone/weedkiller)
		H.adjustToxLoss(3 * REAGENTS_EFFECT_MULTIPLIER * delta_time)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * delta_time)
		return TRUE

/datum/species/diona/spec_life(mob/living/carbon/human/H, delta_time, times_fired)
	if(H.stat == DEAD)
		return

	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	if(isturf(H.loc)) //else, there's considered to be no light
		var/turf/T = H.loc
		light_amount = min(1, T.get_lumcount()) - 0.5
		H.adjust_nutrition(5 * light_amount * delta_time)
		if(H.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
			H.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL)
		if(light_amount > 0.2 && !H.suiciding) //if there's enough light, heal
			H.heal_overall_damage(0.5 * delta_time, 0.5 * delta_time, 0, BODYPART_ORGANIC)
			H.adjustToxLoss(-0.5 * delta_time)
			H.adjustOxyLoss(-0.5 * delta_time)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		H.adjustBruteLoss(2)

/datum/species/diona/bullet_act(obj/projectile/P, mob/living/carbon/human/H, def_zone)
	if(istype(P, /obj/projectile/energy/floramut))
		P.nodamage = TRUE
		H.Stun(1 SECONDS)
		if(prob(80))
			H.easy_randmut(NEGATIVE+MINOR_NEGATIVE)
		else
			H.easy_randmut(POSITIVE)
		H.visible_message("[H] writhes for a moment as [H.p_their()] nymphs squirm and mutate.", "All of you squirm uncomfortably for a moment as you feel your genes changing.")
	else if(istype(P, /obj/projectile/energy/florayield))
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
	id = "diona_pod"
	pod = TRUE
	inherent_factions = list("plants", "vines")
