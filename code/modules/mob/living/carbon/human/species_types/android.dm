/datum/species/android
	name = "Android"
	id = "android"
	say_mod = "states"
	species_traits = list(
		NOBLOOD,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOMETABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_RESISTHEAT,
		TRAIT_NOBREATH,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE,
		TRAIT_GENELESS,
		TRAIT_NOFIRE,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOHUNGER,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NOCLONELOSS,
	)
	cultures = list(CULTURES_GENERIC, CULTURES_HUMAN, CULTURES_SYNTHETIC)
	locations = list(LOCATIONS_GENERIC, LOCATIONS_HUMAN, LOCATIONS_SYNTHETIC)
	factions = list(FACTIONS_GENERIC, FACTIONS_HUMAN, FACTIONS_SYNTHETIC)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	meat = null
	damage_overlay_type = "android"
	mutanttongue = /obj/item/organ/tongue/robot
	species_language_holder = /datum/language_holder/synthetic
	limbs_id = "android"
	wings_icons = list(
		"Robotic",
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	scream_sounds = list(
		NEUTER = 'sound/voice/scream_silicon.ogg',
	)

/datum/species/android/on_species_gain(mob/living/carbon/Android)
	. = ..()
	for(var/X in Android.bodyparts)
		var/obj/item/bodypart/Limbs = X
		Limbs.change_bodypart_status(BODYPART_ROBOTIC, FALSE, TRUE)
		Limbs.brute_reduction = 5
		Limbs.burn_reduction = 4
	// Androids don't eat, hunger or metabolise foods. Let's do some cleanup.
	Android.set_safe_hunger_level()

/datum/species/android/on_species_loss(mob/living/carbon/Android)
	. = ..()
	for(var/X in Android.bodyparts)
		var/obj/item/bodypart/Limbs = X
		Limbs.change_bodypart_status(BODYPART_ORGANIC,FALSE, TRUE)
		Limbs.brute_reduction = initial(Limbs.brute_reduction)
		Limbs.burn_reduction = initial(Limbs.burn_reduction)

// Sneaky little impersonators

/datum/species/android/infiltration_android
	name = "Infiltration Android" //inherited from the real species, for health scanners and things
	id = "android_infiltration"
	say_mod = "beep boops" //inherited from a user's real species
	sexes = 0
	species_traits = list(
		NOTRANSSTING,
	) //all of these + whatever we inherit from the real species
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NODISMEMBER,
		TRAIT_NOLIMBDISABLE,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
	)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	meat = null
	damage_overlay_type = "infiltration_android"
	limbs_id = "infiltration_android"
	///If your health becomes equal to or less than this value, your disguise is supposed to break. Unfortunately, that feature currently isn't implemented, so currently, all this threshold is used for is (I kid you not) determining whether or not your speech uses SPEECH_SPAN_CLOWN while you're disguised as a bananium golem. See the handle_speech() proc further down in this file for more information on that check.
	var/disguise_fail_health = 75
	var/datum/species/fake_species //a species to do most of our work for us, unless we're damaged
	var/list/initial_species_traits //for getting these values back for assume_disguise()
	var/list/initial_inherent_traits
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC
	species_language_holder = /datum/language_holder/synthetic
	scream_sounds = list(
		NEUTER = 'sound/voice/scream_silicon.ogg',
	)

/datum/species/android/infiltration_android/New()
	initial_species_traits = species_traits.Copy()
	initial_inherent_traits = inherent_traits.Copy()
	..()

/datum/species/android/infiltration_android/military
	name = "Militarized Infiltration Android"
	id = "android_infiltration_militarized"
	armor = 25
	punchdamagelow = 10
	punchdamagehigh = 19
	punchstunthreshold = 14 //about 50% chance to stun
	disguise_fail_health = 50
	changesource_flags = MIRROR_BADMIN | WABBAJACK

/datum/species/android/infiltration_android/on_species_gain(mob/living/carbon/human/Infiltration_Android, datum/species/old_species)
	..()
	assume_disguise(old_species, Infiltration_Android)
	RegisterSignal(Infiltration_Android, COMSIG_MOB_SAY, .proc/handle_speech)
	Infiltration_Android.set_safe_hunger_level()

/datum/species/android/infiltration_android/on_species_loss(mob/living/carbon/human/Infiltration_Android)
	. = ..()
	UnregisterSignal(Infiltration_Android, COMSIG_MOB_SAY)

/datum/species/android/infiltration_android/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H, delta_time, times_fired)
	if(chem.type == /datum/reagent/medicine/c2/synthflesh)
		chem.expose_mob(H, TOUCH, 2 * REAGENTS_EFFECT_MULTIPLIER * delta_time,0) //heal a little
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * delta_time)
		return TRUE
	return ..()


/datum/species/android/infiltration_android/proc/assume_disguise(datum/species/S, mob/living/carbon/human/H)
	if(S && !istype(S, type))
		name = S.name
		say_mod = S.say_mod
		sexes = S.sexes
		species_traits = initial_species_traits.Copy()
		inherent_traits = initial_inherent_traits.Copy()
		species_traits |= S.species_traits
		inherent_traits |= S.inherent_traits
		attack_verb = S.attack_verb
		attack_effect = S.attack_effect
		attack_sound = S.attack_sound
		miss_sound = S.miss_sound
		meat = S.meat
		mutant_bodyparts = S.mutant_bodyparts.Copy()
		mutant_organs = S.mutant_organs.Copy()
		nojumpsuit = S.nojumpsuit
		no_equip = S.no_equip.Copy()
		limbs_id = S.limbs_id
		use_skintones = S.use_skintones
		fixed_mut_color = S.fixed_mut_color
		hair_color = S.hair_color
		fake_species = new S.type
	else
		name = initial(name)
		say_mod = initial(say_mod)
		species_traits = initial_species_traits.Copy()
		inherent_traits = initial_inherent_traits.Copy()
		attack_verb = initial(attack_verb)
		attack_effect = initial(attack_verb)
		attack_sound = initial(attack_sound)
		miss_sound = initial(miss_sound)
		mutant_bodyparts = list()
		nojumpsuit = initial(nojumpsuit)
		no_equip = list()
		qdel(fake_species)
		fake_species = null
		meat = initial(meat)
		limbs_id = "infiltration_android"
		use_skintones = 0
		sexes = 0
		fixed_mut_color = ""
		hair_color = ""

	for(var/X in H.bodyparts) //propagates the damage_overlay changes
		var/obj/item/bodypart/BP = X
		BP.update_limb()
	H.update_body_parts() //to update limb icon cache with the new damage overlays

//Proc redirects:
//Passing procs onto the fake_species, to ensure we look as much like them as possible

/datum/species/android/infiltration_android/handle_hair(mob/living/carbon/human/H, forced_colour)
	if(fake_species)
		fake_species.handle_hair(H, forced_colour)
	else
		return ..()


/datum/species/android/infiltration_android/handle_body(mob/living/carbon/human/H)
	if(fake_species)
		fake_species.handle_body(H)
	else
		return ..()


/datum/species/android/infiltration_android/handle_mutant_bodyparts(mob/living/carbon/human/H, forced_colour)
	if(fake_species)
		fake_species.handle_mutant_bodyparts(H,forced_colour)
	else
		return ..()


/datum/species/android/infiltration_android/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	if (isliving(source)) // yeah it's gonna be living but just to be clean
		var/mob/living/L = source
		if(fake_species && L.health > disguise_fail_health)
			switch(fake_species.type)
				if (/datum/species/golem/bananium)
					speech_args[SPEECH_SPANS] |= SPEECH_SPAN_CLOWN

