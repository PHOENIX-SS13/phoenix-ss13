/datum/species/anthromorph
	name = "Anthromorph"
	id = "anthromorph"
	flavor_text = "A broad category which refers to multiple bipedal, sapient species all analogous to animals from the Human homeworld."
	default_color = "4B4B4B"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"horns" = ACC_NONE,
		"ears" = ACC_RANDOM,
		"legs" = ACC_RANDOM,
		"taur" = ACC_NONE,
		"wings" = ACC_NONE,
		"neck" = ACC_NONE,
	)
	cultures = list(CULTURES_GENERIC, CULTURES_HUMAN, CULTURES_ANTHROMORPH)
	locations = list(LOCATIONS_GENERIC, LOCATIONS_HUMAN, LOCATIONS_ANTHROMORPH)
	factions = list(FACTIONS_GENERIC, FACTIONS_HUMAN, FACTIONS_ANTHROMORPH)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = BREAKFAST | MEAT | SUGAR // generic!
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'icons/mob/species/anthro_parts_greyscale.dmi'

/datum/species/anthromorph/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/third_color
	var/random = rand(1,7)
	switch(random)
		if(1)
			main_color = "FFFFFF"
			second_color = "333333"
			third_color = "333333"
		if(2)
			main_color = "FFFFDD"
			second_color = "DD6611"
			third_color = "AA5522"
		if(3)
			main_color = "DD6611"
			second_color = "FFFFFF"
			third_color = "DD6611"
		if(4)
			main_color = "CCCCCC"
			second_color = "FFFFFF"
			third_color = "FFFFFF"
		if(5)
			main_color = "AA5522"
			second_color = "CC8833"
			third_color = "FFFFFF"
		if(6)
			main_color = "FFFFDD"
			second_color = "FFEECC"
			third_color = "FFDDBB"
		if(7) //Oh no you've rolled the sparkle dog
			main_color = random_color()
			second_color = random_color()
			third_color = random_color()
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = third_color
	return returned

/datum/species/anthromorph/get_random_body_markings(list/passed_features)
	var/name = "None"
	var/list/candidates = GLOB.body_marking_sets.Copy()
	for(var/candi in candidates)
		var/datum/body_marking_set/setter = GLOB.body_marking_sets[candi]
		if(setter.recommended_species && !(id in setter.recommended_species))
			candidates -= candi
	if(length(candidates))
		name = pick(candidates)
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings
