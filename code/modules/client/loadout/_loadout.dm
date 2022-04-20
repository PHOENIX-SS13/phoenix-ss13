/datum/loadout_item
	///Name of the loadout item, automatically set by New() if null
	var/name
	///Description of the loadout item, automatically set by New() if null
	var/description
	///Typepath to the item being spawned
	var/path
	///How much loadout points does it cost?
	var/cost = 1
	///Category in which the item belongs to LOADOUT_CATEGORY_UNIFORM, LOADOUT_CATEGORY_BACKPACK etc.
	var/category = LOADOUT_CATEGORY_NONE
	///Subcategory in which the item belongs to
	var/subcategory = LOADOUT_SUBCATEGORY_MISC
	/// Flags for customizing the item
	var/customization_flags = CUSTOMIZE_ALL
	/// String of the default gags colors. Can be null even if `gags_colors` is something (for cases where default items randomize for example)
	var/gags_colors_string
	/// Amount of gags colors this item expects. If null, it's not a GAGS item
	var/gags_colors

/datum/loadout_item/New()
	var/obj/loadout_item = path
	if(!description)
		description = initial(loadout_item.desc)
	if(!name)
		name = initial(loadout_item.name)

/// Ran from SSloadouts after SSgreyscale initializes so we can properly read some information
/datum/loadout_item/proc/parse_gags()
	var/obj/loadout_item = path
	var/gags_config_type = initial(loadout_item.greyscale_config)
	if(gags_config_type)
		gags_colors_string = initial(loadout_item.greyscale_colors)
		var/datum/greyscale_config/gags_config = SSgreyscale.configurations["[gags_config_type]"] //TODO: unwrap the gags config association from strings, literally no reason to do this
		gags_colors = gags_config.expected_colors

/// Gets a string for the gags config
/datum/loadout_item/proc/get_gags_string()
	if(!gags_colors)
		return
	if(gags_colors_string)
		return gags_colors_string
	. = ""
	for(var/i in 1 to gags_colors)
		. += "#FFFFFF" //If for some reason the item doesn't have default values. Fill it with whites

/// Datum for storing and customizing a selected loadout item
/datum/loadout_entry
	/// Path to the loadout item (/datum/loadout_item)
	var/path
	/// Customized name if any.
	var/custom_name
	/// Customized description if any.
	var/custom_desc
	/// Customized color if any.
	var/custom_color
	/// Customized GAGS colors if any.
	var/custom_gags_colors
	/// Customized color rotation if any.
	var/custom_color_rotation

/datum/loadout_entry/New(path, custom_name, custom_desc, custom_color, custom_gags_colors, custom_color_rotation)
	src.path = path
	src.custom_name = custom_name
	src.custom_desc = custom_desc
	src.custom_color = custom_color
	src.custom_gags_colors = custom_gags_colors
	src.custom_color_rotation = custom_color_rotation

/datum/loadout_entry/proc/get_spawned_item()
	var/datum/loadout_item/loadout_item = GLOB.loadout_items[path]
	var/obj/item/spawned = new loadout_item.path()
	customize(spawned, loadout_item)
	return spawned

/datum/loadout_entry/proc/customize(obj/item/spawned, datum/loadout_item/loadout_item)
	if(custom_name && loadout_item.customization_flags & CUSTOMIZE_NAME)
		spawned.name = custom_name
	if(custom_desc && loadout_item.customization_flags & CUSTOMIZE_DESC)
		spawned.desc = custom_desc
	if(custom_gags_colors && loadout_item.customization_flags & CUSTOMIZE_COLOR && loadout_item.gags_colors)
		spawned.set_greyscale(custom_gags_colors)
	if(custom_color && loadout_item.customization_flags & CUSTOMIZE_COLOR && !loadout_item.gags_colors)
		spawned.add_atom_colour(custom_color, FIXED_COLOUR_PRIORITY)
	if(custom_color_rotation && loadout_item.customization_flags & CUSTOMIZE_COLOR_ROTATION)
		spawned.add_atom_colour(color_matrix_rotate_hue(custom_color_rotation), FIXED_COLOUR_PRIORITY)
