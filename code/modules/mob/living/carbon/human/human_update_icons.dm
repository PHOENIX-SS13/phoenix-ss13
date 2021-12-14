	///////////////////////
	//UPDATE_ICONS SYSTEM//
	///////////////////////
/* Keep these comments up-to-date if you -insist- on hurting my code-baby ;_;
This system allows you to update individual mob-overlays, without regenerating them all each time.
When we generate overlays we generate the standing version and then rotate the mob as necessary..

As of the time of writing there are 20 layers within this list. Please try to keep this from increasing. //22 and counting, good job guys
	var/overlays_standing[20] //For the standing stance

Most of the time we only wish to update one overlay:
	e.g. - we dropped the fireaxe out of our left hand and need to remove its icon from our mob
	e.g.2 - our hair colour has changed, so we need to update our hair icons on our mob
In these cases, instead of updating every overlay using the old behaviour (regenerate_icons), we instead call
the appropriate update_X proc.
	e.g. - update_l_hand()
	e.g.2 - update_hair()

Note: Recent changes by aranclanos+carn:
	update_icons() no longer needs to be called.
	the system is easier to use. update_icons() should not be called unless you absolutely -know- you need it.
	IN ALL OTHER CASES it's better to just call the specific update_X procs.

Note: The defines for layer numbers is now kept exclusvely in __DEFINES/misc.dm instead of being defined there,
	then redefined and undefiend everywhere else. If you need to change the layering of sprites (or add a new layer)
	that's where you should start.

All of this means that this code is more maintainable, faster and still fairly easy to use.

There are several things that need to be remembered:
> Whenever we do something that should cause an overlay to update (which doesn't use standard procs
	( i.e. you do something like l_hand = /obj/item/something new(src), rather than using the helper procs)
	You will need to call the relevant update_inv_* proc

	All of these are named after the variable they update from. They are defined at the mob/ level like
	update_clothing was, so you won't cause undefined proc runtimes with usr.update_inv_wear_id() if the usr is a
	slime etc. Instead, it'll just return without doing any work. So no harm in calling it for slimes and such.


> There are also these special cases:
		update_damage_overlays() //handles damage overlays for brute/burn damage
		update_body() //Handles updating your mob's body layer and mutant bodyparts
									as well as sprite-accessories that didn't really fit elsewhere (underwear, undershirts, socks, lips, eyes)
									//NOTE: update_mutantrace() is now merged into this!
		update_hair() //Handles updating your hair overlay (used to be update_face, but mouth and
									eyes were merged into update_body())


*/

//HAIR OVERLAY
/mob/living/carbon/human/update_hair()
	dna.species.handle_hair(src)

//used when putting/removing clothes that hide certain mutant body parts to just update those and not update the whole body.
/mob/living/carbon/human/proc/update_mutant_bodyparts()
	dna.species.handle_mutant_bodyparts(src)


/mob/living/carbon/human/update_body()
	dna.species.handle_body(src)
	..()

/mob/living/carbon/human/update_fire()
	..((fire_stacks > HUMAN_FIRE_STACK_ICON_NUM) ? "Standing" : "Generic_mob_burning")


/* --------------------------------------- */
//For legacy support.
/mob/living/carbon/human/regenerate_icons()

	if(!..())
		icon_render_key = null //invalidate bodyparts cache
		update_body()
		update_hair()
		update_inv_w_uniform()
		update_inv_wear_id()
		update_inv_gloves()
		update_inv_glasses()
		update_inv_ears()
		update_inv_shoes()
		update_inv_s_store()
		update_inv_wear_mask()
		update_inv_head()
		update_inv_belt()
		update_inv_back()
		update_inv_wear_suit()
		update_inv_pockets()
		update_inv_neck()
		update_transform()
		//mutations
		update_mutations_overlay()
		//damage overlays
		update_damage_overlays()

/* --------------------------------------- */
//vvvvvv UPDATE_INV PROCS vvvvvv

/mob/living/carbon/human/update_inv_w_uniform()
	remove_overlay(UNIFORM_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_ICLOTHING) + 1]
		inv.update_appearance()

	if(istype(w_uniform, /obj/item/clothing/under))
		var/obj/item/clothing/under/U = w_uniform
		U.screen_loc = ui_iclothing
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += w_uniform
		update_observer_view(w_uniform,1)

		if(wear_suit && (wear_suit.flags_inv & HIDEJUMPSUIT))
			return

		var/target_overlay = U.worn_icon_state || U.icon_state
		if(U.adjusted == ALT_STYLE)
			target_overlay = "[target_overlay]_d"

		var/mutable_appearance/uniform_overlay

		var/female_alpha_mask = NO_FEMALE_UNIFORM

		if(body_type == FEMALE)
			female_alpha_mask = U.fitted

		uniform_overlay = U.build_worn_icon(default_layer = UNIFORM_LAYER, override_state = target_overlay, isinhands = FALSE, femaleuniform = female_alpha_mask, wearer = src, slot = ITEM_SLOT_ICLOTHING)

		overlays_standing[UNIFORM_LAYER] = uniform_overlay

	apply_overlay(UNIFORM_LAYER)
	update_mutant_bodyparts()


/mob/living/carbon/human/update_inv_wear_id()
	remove_overlay(ID_LAYER)
	remove_overlay(ID_CARD_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_ID) + 1]
		inv.update_appearance()

	var/mutable_appearance/id_overlay = overlays_standing[ID_LAYER]

	if(wear_id)
		wear_id.screen_loc = ui_id
		if(client && hud_used?.hud_shown)
			client.screen += wear_id
		update_observer_view(wear_id)

		//TODO: add an icon file for ID slot stuff, so it's less snowflakey
		id_overlay = wear_id.build_worn_icon(default_layer = ID_LAYER, default_icon_file = 'icons/mob/clothing/id.dmi', wearer = src, slot = ITEM_SLOT_ID)
		overlays_standing[ID_LAYER] = id_overlay

		var/obj/item/card/id/shown_id = wear_id.GetID()
		if(shown_id)
			var/mutable_appearance/id_card_overlay = overlays_standing[ID_CARD_LAYER]
			id_card_overlay = shown_id.build_worn_icon(default_layer = ID_CARD_LAYER, default_icon_file = 'icons/mob/clothing/id_card.dmi', wearer = src, slot = ITEM_SLOT_ID)

			overlays_standing[ID_CARD_LAYER] = id_card_overlay

	apply_overlay(ID_LAYER)
	apply_overlay(ID_CARD_LAYER)


/mob/living/carbon/human/update_inv_gloves()
	remove_overlay(GLOVES_LAYER)

	if(client && hud_used?.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1]
		inv.update_appearance()

	if(!gloves && blood_in_hands && (num_hands > 0) && !(NOBLOODOVERLAY in dna.species.species_traits))
		var/mutable_appearance/bloody_overlay = mutable_appearance('icons/effects/blood.dmi', "bloodyhands", -GLOVES_LAYER)
		if(num_hands < 2)
			if(has_left_hand(FALSE))
				bloody_overlay.icon_state = "bloodyhands_left"
			else if(has_right_hand(FALSE))
				bloody_overlay.icon_state = "bloodyhands_right"

		overlays_standing[GLOVES_LAYER] = bloody_overlay

	var/mutable_appearance/gloves_overlay = overlays_standing[GLOVES_LAYER]
	if(gloves)
		gloves.screen_loc = ui_gloves
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += gloves
		update_observer_view(gloves,1)
		overlays_standing[GLOVES_LAYER] = gloves.build_worn_icon(default_layer = GLOVES_LAYER, default_icon_file = 'icons/mob/clothing/hands.dmi', wearer = src, slot = ITEM_SLOT_GLOVES)
		gloves_overlay = overlays_standing[GLOVES_LAYER]
	overlays_standing[GLOVES_LAYER] = gloves_overlay
	apply_overlay(GLOVES_LAYER)


/mob/living/carbon/human/update_inv_glasses()
	remove_overlay(GLASSES_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_EYES) + 1]
		inv.update_appearance()

	if(glasses)
		glasses.screen_loc = ui_glasses //...draw the item in the inventory screen
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown) //if the inventory is open ...
				client.screen += glasses //Either way, add the item to the HUD
		update_observer_view(glasses,1)
		if(!(head && (head.flags_inv & HIDEEYES)) && !(wear_mask && (wear_mask.flags_inv & HIDEEYES)))
			overlays_standing[GLASSES_LAYER] = glasses.build_worn_icon(default_layer = GLASSES_LAYER, default_icon_file = 'icons/mob/clothing/eyes.dmi', wearer = src, slot = ITEM_SLOT_EYES)

		var/mutable_appearance/glasses_overlay = overlays_standing[GLASSES_LAYER]
		if(glasses_overlay)
			overlays_standing[GLASSES_LAYER] = glasses_overlay
	apply_overlay(GLASSES_LAYER)


/mob/living/carbon/human/update_inv_ears()
	remove_overlay(EARS_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_EARS) + 1]
		inv.update_appearance()

	if(ears)
		ears.screen_loc = ui_ears //move the item to the appropriate screen loc
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown) //if the inventory is open
				client.screen += ears //add it to the client's screen
		update_observer_view(ears,1)
		overlays_standing[EARS_LAYER] = ears.build_worn_icon(default_layer = EARS_LAYER, default_icon_file = 'icons/mob/clothing/ears.dmi', wearer = src, slot = ITEM_SLOT_EARS)
		var/mutable_appearance/ears_overlay = overlays_standing[EARS_LAYER]
		overlays_standing[EARS_LAYER] = ears_overlay
	apply_overlay(EARS_LAYER)


/mob/living/carbon/human/update_inv_shoes()
	remove_overlay(SHOES_LAYER)

	if(dna.species.mutant_bodyparts["taur"])
		var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(S.hide_legs)
			return

	if(num_legs<2)
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_FEET) + 1]
		inv.update_appearance()

	if(shoes)
		shoes.screen_loc = ui_shoes //move the item to the appropriate screen loc
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown) //if the inventory is open
				client.screen += shoes //add it to client's screen
		update_observer_view(shoes,1)

		overlays_standing[SHOES_LAYER] = shoes.build_worn_icon(default_layer = SHOES_LAYER, default_icon_file = 'icons/mob/clothing/feet.dmi', wearer = src, slot = ITEM_SLOT_FEET)
		var/mutable_appearance/shoes_overlay = overlays_standing[SHOES_LAYER]
		overlays_standing[SHOES_LAYER] = shoes_overlay

	apply_overlay(SHOES_LAYER)


/mob/living/carbon/human/update_inv_s_store()
	remove_overlay(SUIT_STORE_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_SUITSTORE) + 1]
		inv.update_appearance()

	if(s_store)
		s_store.screen_loc = ui_sstore1
		if(client && hud_used?.hud_shown)
			client.screen += s_store
		update_observer_view(s_store)
		overlays_standing[SUIT_STORE_LAYER] = s_store.build_worn_icon(default_layer = SUIT_STORE_LAYER, default_icon_file = 'icons/mob/clothing/belt_mirror.dmi', wearer = src, slot = ITEM_SLOT_SUITSTORE)
		var/mutable_appearance/s_store_overlay = overlays_standing[SUIT_STORE_LAYER]
		overlays_standing[SUIT_STORE_LAYER] = s_store_overlay
	apply_overlay(SUIT_STORE_LAYER)


/mob/living/carbon/human/update_inv_head()
	..()
	update_mutant_bodyparts()

/mob/living/carbon/human/update_inv_belt()
	remove_overlay(BELT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BELT) + 1]
		inv.update_appearance()

	if(belt)
		belt.screen_loc = ui_belt
		if(client && hud_used?.hud_shown)
			client.screen += belt
		update_observer_view(belt)
		overlays_standing[BELT_LAYER] = belt.build_worn_icon(default_layer = BELT_LAYER, default_icon_file = 'icons/mob/clothing/belt.dmi', wearer = src, slot = ITEM_SLOT_BELT)
		var/mutable_appearance/belt_overlay = overlays_standing[BELT_LAYER]
		overlays_standing[BELT_LAYER] = belt_overlay

	apply_overlay(BELT_LAYER)



/mob/living/carbon/human/update_inv_wear_suit()
	remove_overlay(SUIT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_OCLOTHING) + 1]
		inv.update_appearance()

	if(istype(wear_suit, /obj/item/clothing/suit))
		wear_suit.screen_loc = ui_oclothing
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += wear_suit
		update_observer_view(wear_suit,1)

		overlays_standing[SUIT_LAYER] = wear_suit.build_worn_icon(default_layer = SUIT_LAYER, default_icon_file = 'icons/mob/clothing/suit.dmi', wearer = src, slot = ITEM_SLOT_OCLOTHING)
		var/mutable_appearance/suit_overlay = overlays_standing[SUIT_LAYER]
		overlays_standing[SUIT_LAYER] = suit_overlay
	update_hair()
	update_mutant_bodyparts()

	apply_overlay(SUIT_LAYER)


/mob/living/carbon/human/update_inv_pockets()
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv

		inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_LPOCKET) + 1]
		inv.update_appearance()

		inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_RPOCKET) + 1]
		inv.update_appearance()

		if(l_store)
			l_store.screen_loc = ui_storage1
			if(hud_used.hud_shown)
				client.screen += l_store
			update_observer_view(l_store)

		if(r_store)
			r_store.screen_loc = ui_storage2
			if(hud_used.hud_shown)
				client.screen += r_store
			update_observer_view(r_store)


/mob/living/carbon/human/update_inv_wear_mask()
	..()
	update_mutant_bodyparts() //e.g. upgate needed because mask now hides lizard snout

/mob/living/carbon/human/update_inv_legcuffed()
	remove_overlay(LEGCUFF_LAYER)
	clear_alert("legcuffed")
	if(legcuffed)
		var/mutable_appearance/legcuff_overlay = mutable_appearance('icons/mob/mob.dmi', "legcuff1", -LEGCUFF_LAYER)
		if(legcuffed.blocks_emissive)
			var/mutable_appearance/legcuff_blocker = mutable_appearance('icons/mob/mob.dmi', "legcuff1", plane = EMISSIVE_PLANE, appearance_flags = KEEP_APART)
			legcuff_blocker.color = GLOB.em_block_color
			legcuff_overlay.overlays += legcuff_blocker

		overlays_standing[LEGCUFF_LAYER] = legcuff_overlay
		apply_overlay(LEGCUFF_LAYER)
		throw_alert("legcuffed", /atom/movable/screen/alert/restrained/legcuffed, new_master = src.legcuffed)

/obj/item/proc/wear_alpha_masked_version(passed_state, passed_icon, layer, female_type, taur_type, greyscale_colors)
	var/static/list/alpha_masked_icons = list()
	var/index = "[passed_state]-[passed_icon]-[female_type]-[taur_type]-[greyscale_colors]"
	var/icon/alpha_icon = alpha_masked_icons[index]
	if(!alpha_icon) //Create standing/laying icons if they don't exist
		var/icon/blending_icon = icon(passed_icon, passed_state)
		if(female_type)
			var/female_masked_state = (female_type == FEMALE_UNIFORM_FULL) ? "female_full" : "female_top"
			blending_icon.Blend(icon('icons/mob/clothing/under/masking_helpers.dmi', female_masked_state), ICON_MULTIPLY, -15, -15)
		if(taur_type)
			blending_icon.Blend(icon('icons/mob/clothing/under/masking_helpers.dmi', taur_type), ICON_MULTIPLY, -15, -15)
		alpha_masked_icons[index] = fcopy_rsc(blending_icon)
	return mutable_appearance(alpha_masked_icons[index], layer = -layer)

/mob/living/carbon/human/proc/get_overlays_copy(list/unwantedLayers)
	var/list/out = new
	for(var/i in 1 to TOTAL_LAYERS)
		if(overlays_standing[i])
			if(i in unwantedLayers)
				continue
			out += overlays_standing[i]
	return out


//human HUD updates for items in our inventory

//update whether our head item appears on our hud.
/mob/living/carbon/human/update_hud_head(obj/item/I)
	I.screen_loc = ui_head
	if(client && hud_used?.hud_shown)
		if(hud_used.inventory_shown)
			client.screen += I
	update_observer_view(I,1)

//update whether our mask item appears on our hud.
/mob/living/carbon/human/update_hud_wear_mask(obj/item/I)
	I.screen_loc = ui_mask
	if(client && hud_used?.hud_shown)
		if(hud_used.inventory_shown)
			client.screen += I
	update_observer_view(I,1)

//update whether our neck item appears on our hud.
/mob/living/carbon/human/update_hud_neck(obj/item/I)
	I.screen_loc = ui_neck
	if(client && hud_used?.hud_shown)
		if(hud_used.inventory_shown)
			client.screen += I
	update_observer_view(I,1)

//update whether our back item appears on our hud.
/mob/living/carbon/human/update_hud_back(obj/item/I)
	I.screen_loc = ui_back
	if(client && hud_used?.hud_shown)
		client.screen += I
	update_observer_view(I)

/*
Does everything in relation to building the /mutable_appearance used in the mob's overlays list
covers:
Inhands and any other form of worn item
Rentering large appearances
Layering appearances on custom layers
Building appearances from custom icon files

By Remie Richards (yes I'm taking credit because this just removed 90% of the copypaste in update_icons())

state: A string to use as the state, this is FAR too complex to solve in this proc thanks to shitty old code
so it's specified as an argument instead.

default_layer: The layer to draw this on if no other layer is specified

default_icon_file: The icon file to draw states from if no other icon file is specified

isinhands: If true then alternate_worn_icon is skipped so that default_icon_file is used,
in this situation default_icon_file is expected to match either the lefthand_ or righthand_ file var

femalueuniform: A value matching a uniform item's fitted var, if this is anything but NO_FEMALE_UNIFORM, we
generate/load female uniform sprites matching all previously decided variables


*/
/obj/item/proc/build_worn_icon(default_layer = 0, default_icon_file = null, isinhands = FALSE, override_state, femaleuniform = NO_FEMALE_UNIFORM, mob/living/carbon/wearer, slot = NONE)
	var/static/list/slot_translation = SLOT_TRANSLATION_LIST
	var/static/list/bodytype_translation = BODYTYPE_TRANSLATION_LIST

	var/real_bodytype = wearer ? wearer.dna.species.bodytype : BODYTYPE_HUMANOID
	var/bodytype = wearer ? wearer.dna.species.get_bodytype(slot, src) : BODYTYPE_HUMANOID
	var/perc_bodytype = bodytype
	var/wear_template = FALSE
	if(!(fitted_bodytypes & bodytype))
		if(worn_template_bodytypes & bodytype)
			wear_template = TRUE
		else
			perc_bodytype = BODYTYPE_HUMANOID

	//Find a valid icon_state from variables+arguments
	var/t_state
	if(override_state)
		t_state = override_state
	else
		t_state = !isinhands ? (worn_icon_state ? worn_icon_state : icon_state) : (inhand_icon_state ? inhand_icon_state : icon_state)

	var/translated_slot = slot_translation["[slot]"]
	if(!isinhands)
		if(wear_template)
			t_state = "[translated_slot]_[bodytype_translation["[perc_bodytype]"]]"
		else
			t_state = "[translated_slot]_[bodytype_translation["[perc_bodytype]"]]_[t_state]"

	var/chosen_worn_icon
	if(wear_template)
		if(perc_bodytype & BODYTYPE_TAUR_ALL)
			if(!large_worn_template_icon)
				large_worn_template_icon = SSgreyscale.GetColoredIconByType(greyscale_config_large_worn_template, worn_template_greyscale_color)
			chosen_worn_icon = large_worn_template_icon
		else
			if(!worn_template_icon)
				worn_template_icon = SSgreyscale.GetColoredIconByType(greyscale_config_worn_template, worn_template_greyscale_color)
			chosen_worn_icon = worn_template_icon
	else
		chosen_worn_icon = (perc_bodytype & BODYTYPE_TAUR_ALL) ? large_worn_icon : worn_icon

	//Find a valid icon file from variables+arguments
	var/file2use = !isinhands ? (chosen_worn_icon ? chosen_worn_icon : default_icon_file) : default_icon_file

	//Find a valid layer from variables+arguments
	var/layer2use = alternate_worn_layer ? alternate_worn_layer : default_layer

	var/mutable_appearance/standing
	var/taur_alpha_mask
	//If we're a taur, and what we're wearing will not get a taur variant
	if(bodytype & BODYTYPE_TAUR_ALL && !(perc_bodytype & BODYTYPE_TAUR_ALL) && slot == ITEM_SLOT_ICLOTHING)
		var/datum/sprite_accessory/taur/taur_sprite = GLOB.sprite_accessories["taur"][wearer.dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(body_parts_covered & LEGS) //If we cover legs, apply the taur alpha mask
			taur_alpha_mask = taur_sprite.alpha_mask_type

	if(femaleuniform || taur_alpha_mask)
		standing = wear_alpha_masked_version(t_state, file2use, layer2use, femaleuniform, taur_alpha_mask, greyscale_colors) //should layer2use be in sync with the adjusted value below? needs testing - shiz
	if(!standing)
		standing = mutable_appearance(file2use, t_state, -layer2use)

	//Get the overlays for this item when it's being worn
	//eg: ammo counters, primed grenade flashes, etc.
	var/list/worn_overlays = worn_overlays(standing, isinhands, file2use, perc_bodytype)
	if(worn_overlays?.len)
		standing.overlays.Add(worn_overlays)

	var/x_center
	var/y_center
	x_center = isinhands ? inhand_x_dimension : worn_x_dimension
	y_center = isinhands ? inhand_y_dimension : worn_y_dimension
	standing = center_image(standing, x_center, y_center)

	//Worn offsets
	var/list/offsets = get_worn_offsets(isinhands)
	standing.pixel_x += offsets[1]
	standing.pixel_y += offsets[2]

	standing.alpha = alpha
	standing.color = color

	///Species offsets, only applied when the bodytype is not fitted. (using human variants instead)
	if(!wear_template && wearer && wearer.dna.species.offset_features)
		if(isinhands && wearer.dna.species.offset_features[OFFSET_INHANDS])
			var/list/offset_list = wearer.dna.species.offset_features[OFFSET_INHANDS]
			standing.pixel_x += offset_list[1]
			standing.pixel_y += offset_list[2]
		else if(real_bodytype != perc_bodytype && wearer.dna.species.offset_features[translated_slot])
			var/list/offset_list = wearer.dna.species.offset_features[translated_slot]
			standing.pixel_x += offset_list[1]
			standing.pixel_y += offset_list[2]

	//Large worn offsets
	if(perc_bodytype & BODYTYPE_TAUR_ALL)
		standing.pixel_x -= 16
	return standing

/// Returns offsets used for equipped item overlays in list(px_offset,py_offset) form.
/obj/item/proc/get_worn_offsets(isinhands)
	. = list(0,0) //(px,py)
	if(isinhands)
		//Handle held offsets
		var/mob/holder = loc
		if(istype(holder))
			var/list/offsets = holder.get_item_offsets_for_index(holder.get_held_index_of_item(src))
			if(offsets)
				.[1] = offsets["x"]
				.[2] = offsets["y"]
	else
		.[2] = worn_y_offset

//Can't think of a better way to do this, sadly
/mob/proc/get_item_offsets_for_index(i)
	switch(i)
		if(3) //odd = left hands
			return list("x" = 0, "y" = 16)
		if(4) //even = right hands
			return list("x" = 0, "y" = 16)
		else //No offsets or Unwritten number of hands
			return list("x" = 0, "y" = 0)//Handle held offsets

//produces a key based on the human's limbs
/mob/living/carbon/human/generate_icon_render_key()
	. = "[dna.species.limbs_id]"

	if(dna.check_mutation(HULK))
		. += "-coloured-hulk"
	else if(dna.species.use_skintones)
		. += "-coloured-[skin_tone]"
	else if(dna.species.fixed_mut_color)
		. += "-coloured-[dna.species.fixed_mut_color]"
	else if(MUTCOLORS in dna.species.species_traits)
		. += "-coloured-[dna.features["mcolor"]]"
	else
		. += "-not_coloured"

	. += "-[body_type]"

	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		. += "-[BP.body_zone]"
		if(BP.use_digitigrade)
			. += "-digitigrade[BP.use_digitigrade]"
		if(BP.dmg_overlay_type)
			. += "-[BP.dmg_overlay_type]"
		if(HAS_TRAIT(BP, TRAIT_PLASMABURNT))
			. += "-plasmaburnt"
		if(BP.organic_render)
			. += "-OR"

	if(HAS_TRAIT(src, TRAIT_HUSK))
		. += "-husk"

/mob/living/carbon/human/load_limb_from_cache()
	..()
	update_hair()



/mob/living/carbon/human/proc/update_observer_view(obj/item/I, inventory)
	if(observers?.len)
		for(var/M in observers)
			var/mob/dead/observe = M
			if(observe.client && observe.client.eye == src)
				if(observe.hud_used)
					if(inventory && !observe.hud_used.inventory_shown)
						continue
					observe.client.screen += I
			else
				observers -= observe
				if(!observers.len)
					observers = null
					break

// Only renders the head of the human
/mob/living/carbon/human/proc/update_body_parts_head_only()
	if (!dna)
		return

	if (!dna.species)
		return

	var/obj/item/bodypart/HD = get_bodypart("head")

	if (!istype(HD))
		return

	HD.update_limb()

	add_overlay(HD.get_limb_icon())
	update_damage_overlays()

	if(HD && !(HAS_TRAIT(src, TRAIT_HUSK)))
		// lipstick
		if(lip_style && (LIPS in dna.species.species_traits))
			var/mutable_appearance/lip_overlay = mutable_appearance('icons/mob/sprite_accessory/human_face.dmi', "lips_[lip_style]", -BODY_LAYER)
			lip_overlay.color = lip_color
			if(dna.species.offset_features && (OFFSET_FACE in dna.species.offset_features))
				lip_overlay.pixel_x += dna.species.offset_features[OFFSET_FACE][1]
				lip_overlay.pixel_y += dna.species.offset_features[OFFSET_FACE][2]
			add_overlay(lip_overlay)

		// eyes
		if(!(NOEYESPRITES in dna.species.species_traits))
			var/obj/item/organ/eyes/E = getorganslot(ORGAN_SLOT_EYES)
			var/mutable_appearance/eye_overlay
			if(!E)
				eye_overlay = mutable_appearance('icons/mob/sprite_accessory/human_face.dmi', "eyes_missing", -BODY_LAYER)
			else
				eye_overlay = mutable_appearance('icons/mob/sprite_accessory/human_face.dmi', E.eye_icon_state, -BODY_LAYER)
			if((EYECOLOR in dna.species.species_traits) && E)
				eye_overlay.color = "#" + eye_color
			if(dna.species.offset_features && (OFFSET_FACE in dna.species.offset_features))
				eye_overlay.pixel_x += dna.species.offset_features[OFFSET_FACE][1]
				eye_overlay.pixel_y += dna.species.offset_features[OFFSET_FACE][2]
			add_overlay(eye_overlay)

	dna.species.handle_hair(src)

	update_inv_head()
	update_inv_wear_mask()

//Removed the icon cache from this, as its not worth it to make a cache for the plathora of customizable species and markings
//If icon cache exists what ends up happening is that people customizing their characters will be creating hundreds of caches as they customize markings, eating memory 4nr
/mob/living/carbon/human/update_body_parts()
	//CHECK FOR UPDATE
	var/oldkey = icon_render_key
	icon_render_key = generate_icon_render_key()
	if(oldkey == icon_render_key)
		return

	remove_overlay(BODYPARTS_LAYER)

	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		BP.update_limb()

	var/is_taur = FALSE
	if(dna?.species.mutant_bodyparts["taur"])
		var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(S.hide_legs)
			is_taur = TRUE

	//GENERATE NEW LIMBS
	var/list/new_limbs = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(is_taur && (BP.body_part == LEG_LEFT || BP.body_part == LEG_RIGHT))
			continue

		new_limbs += BP.get_limb_icon()
	if(new_limbs.len)
		overlays_standing[BODYPARTS_LAYER] = new_limbs

	apply_overlay(BODYPARTS_LAYER)
	update_damage_overlays()
