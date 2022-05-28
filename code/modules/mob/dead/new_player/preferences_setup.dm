
	//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/random_character(gender_override, antag_override = FALSE)
	if(!pref_species)
		var/rando_race = pick(GLOB.roundstart_races)
		set_new_species(rando_race)
	real_name = pref_species.random_name(gender,1)
	if(gender_override)
		gender = gender_override
	else
		gender = pick(MALE,FEMALE,PLURAL)
	age = rand(AGE_MIN,AGE_MAX)
	underwear = random_underwear(gender, pref_species)
	underwear_color = random_short_color()
	undershirt = random_undershirt(gender, pref_species)
	socks = random_socks(pref_species)
	backpack = random_backpack()
	jumpsuit_style = pick(GLOB.jumpsuitlist)
	hairstyle = random_hairstyle(gender, pref_species)
	facial_hairstyle = random_facial_hairstyle(gender, pref_species)
	hair_color = random_short_color()
	facial_hair_color = random_short_color()
	set_skin_tone(random_skin_tone())
	eye_color = random_eye_color()
	if(gender in list(MALE, FEMALE))
		body_type = gender
	else
		body_type = pick(MALE, FEMALE)
	//features = pref_species.get_random_features()
	var/list/new_features = pref_species.get_random_features() //We do this to keep flavor text, genital sizes etc.
	for(var/key in new_features)
		features[key] = new_features[key]
	mutant_bodyparts = pref_species.get_random_mutant_bodyparts(features)
	body_markings = pref_species.get_random_body_markings(features)
	needs_update = TRUE

/datum/preferences/proc/random_species()
	var/random_species_type = GLOB.species_list[pick(GLOB.roundstart_races)]
	set_new_species(random_species_type)


/datum/preferences/proc/update_preview_icon()
	// Determine what job is marked as 'High' priority, and dress them up as such.
	var/datum/job/previewJob
	var/highest_pref = 0
	for(var/job in job_preferences)
		if(job_preferences[job] > highest_pref)
			previewJob = SSjob.GetJob(job)
			highest_pref = job_preferences[job]

	if(previewJob)
		// Silicons only need a very basic preview since there is no customization for them.
		if(istype(previewJob,/datum/job/ai))
			parent.show_character_previews(image('icons/mob/ai.dmi', icon_state = resolve_ai_icon(preferred_ai_core_display), dir = SOUTH))
			return
		if(istype(previewJob,/datum/job/cyborg))
			parent.show_character_previews(image('icons/mob/robots.dmi', icon_state = "robot", dir = SOUTH))
			return

	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
	mannequin.add_overlay(mutable_appearance('icons/turf/floors.dmi', icon_state = background_state, layer = SPACE_LAYER))
	apply_prefs_to(mannequin, TRUE, TRUE)

	switch(preview_pref)
		if(PREVIEW_PREF_JOB)
			if(previewJob)
				mannequin.job = previewJob.title
				mannequin.dress_up_as_job(previewJob, TRUE)
			mannequin.underwear_visibility = NONE
		if(PREVIEW_PREF_LOADOUT)
			mannequin.underwear_visibility = NONE
			equip_preference_loadout(mannequin, TRUE, previewJob)
			mannequin.underwear_visibility = NONE
		if(PREVIEW_PREF_NAKED)
			mannequin.underwear_visibility = UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_SOCKS
	mannequin.update_body() //Unfortunately, due to a certain case we need to update this just in case

	COMPILE_OVERLAYS(mannequin)
	parent.show_character_previews(new /mutable_appearance(mannequin))
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)

//This proc makes sure that we only have the parts that the species should have, add missing ones, remove extra ones(should any be changed)
//Also, this handles missing color keys
/datum/preferences/proc/validate_species_parts()
	if(!pref_species)
		return

	var/list/target_bodyparts = pref_species.default_mutant_bodyparts.Copy()

	//Remove all "extra" accessories
	for(var/key in mutant_bodyparts)
		if(!GLOB.sprite_accessories[key]) //That accessory no longer exists, remove it
			mutant_bodyparts -= key
			continue
		if(!pref_species.default_mutant_bodyparts[key])
			mutant_bodyparts -= key
			continue
		if(!GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]) //The individual accessory no longer exists
			mutant_bodyparts[key][MUTANT_INDEX_NAME] = pref_species.default_mutant_bodyparts[key]
		validate_color_keys_for_part(key) //Validate the color count of each accessory that wasnt removed

	//Add any missing accessories
	for(var/key in target_bodyparts)
		if(!mutant_bodyparts[key])
			var/datum/sprite_accessory/SA
			if(target_bodyparts[key] == ACC_RANDOM)
				SA = random_accessory_of_key_for_species(key, pref_species)
			else
				SA = GLOB.sprite_accessories[key][target_bodyparts[key]]
			var/final_list = list()
			final_list[MUTANT_INDEX_NAME] = SA.name
			final_list[MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)
			mutant_bodyparts[key] = final_list

	if(!allow_advanced_colors)
		reset_colors()

/datum/preferences/proc/validate_color_keys_for_part(key)
	var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
	var/list/colorlist = mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST]
	if(SA.color_src == USE_MATRIXED_COLORS && colorlist.len != 3)
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)
	else if (SA.color_src == USE_ONE_COLOR && colorlist.len != 1)
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)

/datum/preferences/proc/set_new_species(new_species_path)
	pref_species = new new_species_path()
	random_character(FALSE, antag_override = FALSE)
	if(pref_species.use_skintones)
		features["uses_skintones"] = TRUE
	//We reset the quirk-based stuff
	augments = list()
	all_quirks = list()
	//Reset cultural stuff
	pref_culture = pref_species.cultures[1]
	pref_location = pref_species.locations[1]
	pref_faction = pref_species.factions[1]
	try_get_common_language()
	validate_languages()

/datum/preferences/proc/reset_colors()
	for(var/key in mutant_bodyparts)
		var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
		if(SA.always_color_customizable)
			continue
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)

	for(var/zone in body_markings)
		var/list/bml = body_markings[zone]
		for(var/key in bml)
			var/datum/body_marking/BM = GLOB.body_markings[key]
			bml[key] = BM.get_default_color(features, pref_species)

/datum/preferences/proc/equip_preference_loadout(mob/living/carbon/human/H, just_preview = FALSE, datum/job/choosen_job, blacklist, initial)
	if(!ishuman(H))
		return
	var/list/items_to_pack = list()
	var/list/loadout_slot = get_loadout_slot()
	for(var/datum/loadout_entry/entry as anything in loadout_slot)
		var/obj/item/loadout_item = entry.get_spawned_item()
		if(!H.equip_to_appropriate_slot(loadout_item ,blacklist=blacklist,initial=initial))
			if(!just_preview)
				items_to_pack += loadout_item
				//Here we stick it into a bag, if possible
				if(!H.equip_to_slot_if_possible(loadout_item, ITEM_SLOT_BACKPACK, disable_warning = TRUE, bypass_equip_delay_self = TRUE, initial=initial))
					//Otherwise - on the ground
					loadout_item.forceMove(get_turf(H))
			else
				qdel(loadout_item)

	return items_to_pack

//This needs to be a seperate proc because the character could not have the proper backpack during the moment of loadout equip
/datum/preferences/proc/add_packed_items(mob/living/carbon/human/H, list/packed_items, del_on_fail = TRUE)
	//Here we stick loadout items that couldn't be equipped into a bag.
	var/obj/item/back_item = H.back
	for(var/item in packed_items)
		var/obj/item/ITEM = item
		if(back_item)
			ITEM.forceMove(back_item)
		else if (del_on_fail)
			qdel(ITEM)
		else
			ITEM.forceMove(get_turf(H))
