/// This unit test iterates over all wearable items and makes sure they have worn icons for all bodytypes and slots they can fit
/datum/unit_test/worn_icons/Run()
	var/list/slot_translation = SLOT_TRANSLATION_LIST
	var/list/bodytype_translation = BODYTYPE_TRANSLATION_LIST

	// Types we ignore, put in abstract types that make the CI complain here
	var/list/ignored_types = list(
		/obj/item/clothing/head/hooded/cloakhood,
		/obj/item/clothing/head/hooded,
		/obj/item/clothing/head
		)
	ignored_types += typesof(/obj/item/clothing/head/chameleon)
	ignored_types += typesof(/obj/item/clothing/suit/chameleon)
	ignored_types += typesof(/obj/item/clothing/under/chameleon)
	ignored_types += typesof(/obj/item/clothing/shoes/chameleon)

	// The turf we will spawn clothes that need to get their GAGS icon
	var/turf/spawn_at = run_loc_floor_bottom_left

	/// Iterate over all items and get relevant initials
	for(var/clothing_type_path in typesof(/obj/item))
		if(clothing_type_path in ignored_types)
			continue
		var/obj/item/cast_clothing = clothing_type_path
		var/clothing_slot_flags = initial(cast_clothing.slot_flags)
		var/clothing_worn_icon_state = initial(cast_clothing.worn_icon_state) || initial(cast_clothing.icon_state)
		var/clothing_worn_icon = initial(cast_clothing.worn_icon)
		var/large_clothing_worn_icon = initial(cast_clothing.large_worn_icon)

		///If has a gags config, make sure we use the proper gags worn icon
		if(initial(cast_clothing.greyscale_config_worn))
			var/obj/item/temporary_item = new clothing_type_path(spawn_at)
			clothing_worn_icon_state = temporary_item.worn_icon_state || temporary_item.icon_state
			clothing_worn_icon = temporary_item.worn_icon
			large_clothing_worn_icon = temporary_item.large_worn_icon
			qdel(temporary_item)

		if(!clothing_worn_icon || !clothing_worn_icon_state || !clothing_slot_flags)
			continue

		var/clothing_allowed_bodytypes = initial(cast_clothing.allowed_bodytypes)
		var/clothing_fitted_bodytypes = initial(cast_clothing.fitted_bodytypes)

		var/list/icon_states_available = icon_states(clothing_worn_icon)

		var/list/large_icon_states_available
		if(large_clothing_worn_icon)
			large_icon_states_available = icon_states(large_clothing_worn_icon)

		// Allow the default humanoid bodytype if it's in allowed, as it's the one things fall back to
		if(!(clothing_fitted_bodytypes & BODYTYPE_HUMANOID) && (clothing_allowed_bodytypes & BODYTYPE_HUMANOID))
			clothing_fitted_bodytypes ^= BODYTYPE_HUMANOID

		// Iterate over all item slot bitflags (as strings)
		for(var/item_slot_string in slot_translation)
			var/item_slot = text2num(item_slot_string)
			// See if the clothing can be worn on the iterated slot
			if(clothing_slot_flags & item_slot)
				/// If it can, iterate over all bodytypes and check which ones are fitted.
				for(var/bodytype_string in bodytype_translation)
					var/bodytype = text2num(bodytype_string)
					/// If a bodytype is allowed and fitted, check its icon state
					if(clothing_allowed_bodytypes & bodytype)
						var/real_bodytype_string = bodytype_translation[bodytype_string]
						var/real_item_slot_string = slot_translation[item_slot_string]
						var/worn_string = "[real_item_slot_string]_[real_bodytype_string]_[clothing_worn_icon_state]"
						var/used_lookup_list = icon_states_available
						if(bodytype & BODYTYPE_TAUR_ALL)
							used_lookup_list = large_icon_states_available
						var/list/states_to_check = list(worn_string)

						///Check if it's a uniform and add its casual state to the check if it can be adjusted
						if(istype(clothing_type_path, /obj/item/clothing/under))
							var/obj/item/clothing/under/uniform_cast = clothing_type_path
							var/adjusted_string = "[worn_string]_d"
							if(initial(uniform_cast.can_adjust))
								states_to_check += adjusted_string
							else if (used_lookup_list && (adjusted_string in used_lookup_list))
								Fail("[clothing_type_path] has an adjusted state that will not be used: [states_to_check]. Set `can_adjust` to TRUE, or remove the state.")

						for(var/state_to_check in states_to_check)
							if(clothing_fitted_bodytypes & bodytype)
								if(!used_lookup_list)
									Fail("[clothing_type_path] has taur fitted worn icons, but no large_worn_icon")
								///If we are missing the state in our icons, print a fail
								if(!(state_to_check in used_lookup_list))
									Fail("[clothing_type_path] has missing worn state: [state_to_check]")
							else
								if(!used_lookup_list)
									continue
								//Check if there is a icon state for this bodytype, but isn't fitted for it
								if(state_to_check in used_lookup_list)
									Fail("[clothing_type_path] has worn state that will not be used: [state_to_check]")
