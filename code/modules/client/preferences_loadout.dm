/datum/preferences/proc/set_loadout_slot(new_slot, force)
	if(isnull(new_slot))
		return
	if(new_slot == loadout_slot && !force)
		return
	// Create a new slot and set it to that if we want to set it to one that doesn't exist
	if(loadouts.len < new_slot)
		if(loadouts.len >= MAX_LOADOUT_SLOTS)
			return
		loadouts.len++
		loadouts[loadouts.len] = list()
		loadout_slot = loadouts.len
	else
		loadout_slot = new_slot
	needs_update = TRUE
	calculate_loadout_points()

/// Resets current loadout slot
/datum/preferences/proc/reset_loadout_slot(slot_to_reset)
	if(!slot_to_reset)
		slot_to_reset = loadout_slot
	loadouts[slot_to_reset] = list()
	if(slot_to_reset == loadout_slot)
		calculate_loadout_points()

/datum/preferences/proc/remove_loadout_slot(slot_to_remove)
	// Can't remove first slot
	if(slot_to_remove == 1)
		return
	// Slot doesn't exist
	if(slot_to_remove > loadouts.len)
		return
	// Remove the slot
	loadouts -= loadouts[slot_to_remove]
	// If we are removing this slot or a slot below, move the selected loadout slot to 1 below
	if(slot_to_remove <= loadout_slot)
		set_loadout_slot(loadout_slot - 1)

/datum/preferences/proc/calculate_loadout_points()
	loadout_points = get_loadout_points_for_slot()

/datum/preferences/proc/get_loadout_points_for_slot(slot_to_get)
	var/calculated_points = LOADOUT_POINTS_MAX
	var/list/current_slot = get_loadout_slot(slot_to_get)
	for(var/datum/loadout_entry/entry as anything in current_slot)
		var/datum/loadout_item/loadout_item = GLOB.loadout_items[entry.path]
		calculated_points -= loadout_item.cost
	return calculated_points

/datum/preferences/proc/add_loadout_item(loadout_item_path)
	var/datum/loadout_item/loadout_item = GLOB.loadout_items[loadout_item_path]
	if(!loadout_item)
		return //Will happen with migrations
	if(get_loadout_entry(loadout_item_path))
		return
	if(!can_purchase_loadout_item(loadout_item_path))
		return
	var/list/current_slot = get_loadout_slot()
	current_slot += new /datum/loadout_entry(loadout_item_path)
	needs_update = TRUE
	calculate_loadout_points()

/datum/preferences/proc/remove_loadout_item(loadout_item_path)
	var/datum/loadout_entry/entry = get_loadout_entry(loadout_item_path)
	if(!entry)
		return
	var/list/current_slot = get_loadout_slot()
	current_slot -= entry
	needs_update = TRUE
	calculate_loadout_points()

/datum/preferences/proc/get_loadout_entry(loadout_item_path, list/passed_slot)
	var/list/current_slot = passed_slot || get_loadout_slot()
	for(var/datum/loadout_entry/entry as anything in current_slot)
		if(entry.path == loadout_item_path)
			return entry

/datum/preferences/proc/can_purchase_loadout_item(loadout_item_path)
	var/datum/loadout_item/loadout_item = GLOB.loadout_items[loadout_item_path]
	if(loadout_points >= loadout_item.cost)
		return TRUE
	return FALSE

/datum/preferences/proc/change_loadout_item(loadout_item_path)
	if(isnull(loadout_item_path))
		return
	if(get_loadout_entry(loadout_item_path))
		remove_loadout_item(loadout_item_path)
	else
		add_loadout_item(loadout_item_path)

/datum/preferences/proc/get_loadout_slot(slot_to_get)
	if(!slot_to_get)
		slot_to_get = loadout_slot
	var/list/current_slot = loadouts[slot_to_get]
	if(!current_slot)
		CRASH("Couldn't find a loadout list for the current slot.")
	return current_slot

/datum/preferences/proc/print_loadout_table(equipped, category, subcategory)
	var/list/dat = list()
	var/list/loadout_items_in_page
	var/list/current_slot = get_loadout_slot()
	if(equipped)
		loadout_items_in_page = list()
		for(var/datum/loadout_entry/entry as anything in current_slot)
			loadout_items_in_page += entry.path
	else
		loadout_items_in_page = GLOB.loadout_category_to_subcategory_to_items[category][subcategory]
	
	dat += "<table align='center'; width='100%'; height='100%'; style='background-color:#13171C'>"
	dat += "<tr style='vertical-align:top'>"
	dat += "<td width=28%><font size=2><b>Name</b></font></td>"
	dat += "<td width=20%><font size=2><b>Customization</b></font></td>"
	dat += "<td width=47%><font size=2><b>Description</b></font></td>"
	dat += "<td width=5%><font size=2><center><b>Cost</b></center></font></td>"
	dat += "</tr>"

	var/even = FALSE
	for(var/item_path in loadout_items_in_page)
		var/background_cl = even ? "#17191C" : "#23273C"
		even = !even
		var/datum/loadout_item/loadout_item = GLOB.loadout_items[item_path]
		var/datum/loadout_entry/loadout_entry = get_loadout_entry(item_path, current_slot)
		var/loadout_button_class

		if(loadout_entry) //We have this item purchased, but we can sell it
			loadout_button_class = "href='?_src_=prefs;task=change_loadout;item=[item_path]' class='linkOn'"
		else if(can_purchase_loadout_item(item_path))
			loadout_button_class = "href='?_src_=prefs;task=change_loadout;item=[item_path]'"
		else
			loadout_button_class = "class='linkOff'"

		var/displayed_name
		var/displayed_desc
		var/change_name_button
		var/change_desc_button
		var/color_button = ""

		if(loadout_entry)
			if(loadout_item.customization_flags & CUSTOMIZE_NAME)
				change_name_button = " <a href='?_src_=prefs;task=customize_loadout;item=[item_path];customize=[TOPIC_CUSTOMIZE_NAME]'>Change</a>"
			if(loadout_item.customization_flags & CUSTOMIZE_DESC)
				change_desc_button = " <a href='?_src_=prefs;task=customize_loadout;item=[item_path];customize=[TOPIC_CUSTOMIZE_DESC]'>Change</a>"
			
			if(loadout_item.customization_flags & CUSTOMIZE_COLOR)
				if(loadout_item.gags_colors)
					var/gags_string = loadout_entry.custom_gags_colors || loadout_item.get_gags_string()
					var/list/gags_list = color_string_to_list(gags_string)
					for(var/i in 1 to loadout_item.gags_colors)
						var/iterated_color = gags_list[i]
						if(i != 1)
							color_button += "<BR>"
						color_button += "Color #[i]: <span class='color_holder_box' style='background-color:[iterated_color]'></span> <a href='?_src_=prefs;task=customize_loadout;item=[item_path];customize=[TOPIC_CUSTOMIZE_COLOR_GAGS];index=[i]'>Change</a>"
				else
					var/shown_color = loadout_entry.custom_color ? loadout_entry.custom_color : "#FFFFFF"
					color_button += "Color: <span class='color_holder_box' style='background-color:[shown_color]'></span> <a href='?_src_=prefs;task=customize_loadout;item=[item_path];customize=[TOPIC_CUSTOMIZE_COLOR]'>Change</a>"
			// Color rotation is not compatible with non-gags color modifications
			if (loadout_item.customization_flags & CUSTOMIZE_COLOR_ROTATION)
				var/shown_rotation = loadout_entry.custom_color_rotation || 0
				if(color_button)
					color_button += "<BR>"
				color_button += "Color Rotation: <a href='?_src_=prefs;task=customize_loadout;item=[item_path];customize=[TOPIC_CUSTOMIZE_COLOR_ROTATION]'>[shown_rotation]</a>"
		if(loadout_entry && loadout_entry.custom_name)
			displayed_name = "*[loadout_entry.custom_name]"
		else
			displayed_name = loadout_item.name
		
		if(loadout_entry && loadout_entry.custom_desc)
			displayed_desc = "*[loadout_entry.custom_desc]"
		else
			displayed_desc = loadout_item.description

		/// If we don't have an item in our loadout, show the user if it could be colorable
		if(!loadout_entry)
			color_button = "<i><font color='#6b6b6b'>"
			var/first_line = FALSE
			if(loadout_item.customization_flags & CUSTOMIZE_COLOR)
				first_line = TRUE
				if(loadout_item.gags_colors)
					color_button += "Adv. colors"
				else
					color_button += "Color"
			if (loadout_item.customization_flags & CUSTOMIZE_COLOR_ROTATION)
				if(first_line)
					color_button += " | "
				color_button += "Color rotation "
			color_button += "</font></i>"


		dat += "<tr style='vertical-align:top; background-color: [background_cl];'>"
		dat += "<td><a [loadout_button_class]>[displayed_name]</a>[change_name_button]</td>"
		dat += "<td>[color_button]</td>"
		dat += "<td><i>[displayed_desc]</i>[change_desc_button]</td>"
		dat += "<td><center>[loadout_item.cost]</center></td>"
		dat += "</tr>"

	dat += "</table>"
	return dat

/datum/preferences/proc/validate_loadouts()
	if(!length(loadouts))
		set_loadout_slot(1, TRUE)
	var/slot_index = 0
	for(var/list/slot_list as anything in loadouts)
		slot_index++
		for(var/datum/loadout_entry/entry as anything in slot_list)
			var/datum/loadout_item/loadout_item = GLOB.loadout_items[entry.path]
			// Entry doesn't point to an item, remove it
			if(!loadout_item)
				slot_list -= entry
		var/points_in_slot = get_loadout_points_for_slot(slot_index)
		if(points_in_slot <= 0)
			reset_loadout_slot(slot_index)

/datum/preferences/proc/customize_loadout_entry(loadout_item_path, customization_type, mob/user, gags_index)
	var/datum/loadout_entry/entry = get_loadout_entry(loadout_item_path)
	if(!entry)
		return
	var/datum/loadout_item/loadout_item = GLOB.loadout_items[loadout_item_path]
	needs_update = TRUE
	switch(customization_type)
		if(TOPIC_CUSTOMIZE_NAME)
			var/current_name_display = entry.custom_name ? entry.custom_name : loadout_item.name
			var/new_name = input(user, "Choose loadout item name: (empty to reset)", "Loadout Customization", current_name_display) as text|null
			if(isnull(new_name) || QDELETED(entry))
				return
			if(new_name == "" || new_name == loadout_item.name)
				entry.custom_name = null
				return
			new_name = strip_html_simple(new_name, MAX_ITEM_NAME_LEN, TRUE)
			entry.custom_name = new_name
		if(TOPIC_CUSTOMIZE_DESC)
			var/current_desc_display = entry.custom_desc ? entry.custom_desc : loadout_item.description
			var/new_desc = input(user, "Choose loadout item description: (empty to reset)", "Loadout Customization", current_desc_display) as text|null
			if(isnull(new_desc) || QDELETED(entry))
				return
			if(new_desc == "" || new_desc == loadout_item.description)
				entry.custom_desc = null
				return
			new_desc = strip_html_simple(new_desc, MAX_ITEM_DESC_LEN, TRUE)
			entry.custom_desc = new_desc
		if(TOPIC_CUSTOMIZE_COLOR)
			if(loadout_item.gags_colors)
				return
			var/current_color_display = entry.custom_color ? entry.custom_color : "#FFFFFF"
			var/new_color = input(user, "Choose loadout item color:", "Loadout Customization", current_color_display) as color|null
			if(!new_color || QDELETED(entry))
				return
			new_color = sanitize_hexcolor(new_color, 6, TRUE)
			if(new_color == "#FFFFFF")
				entry.custom_color = null
				return
			entry.custom_color = new_color
		if(TOPIC_CUSTOMIZE_COLOR_GAGS)
			if(!loadout_item.gags_colors || !gags_index)
				return
			var/gags_string = entry.custom_gags_colors || loadout_item.get_gags_string()
			var/list/gags_list = color_string_to_list(gags_string)
			var/current_color_display = gags_list[gags_index]
			var/new_color = input(user, "Choose loadout item color [gags_index]:", "Loadout Customization", current_color_display) as color|null
			if(!new_color || QDELETED(entry))
				return
			new_color = sanitize_hexcolor(new_color, 6, TRUE)
			if(new_color == "#FFFFFF")
				entry.custom_color = null
				return
			gags_list[gags_index] = new_color
			entry.custom_gags_colors = color_list_to_string(gags_list)
		if(TOPIC_CUSTOMIZE_COLOR_ROTATION)
			var/current_rotation = entry.custom_color_rotation || 0
			var/new_rotation = input(user, "Choose loadout item color rotation (0-360) (This is incompatible with non advanced color customization):", "Loadout Customization", current_rotation) as num|null
			if(isnull(new_rotation) || QDELETED(entry))
				return
			new_rotation = sanitize_integer(new_rotation, 0, 360, 0)
			if(new_rotation == 0)
				entry.custom_color_rotation = null
				return
			entry.custom_color_rotation = new_rotation
