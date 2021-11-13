/// Makes sure objects using greyscale configs have, if any, the correct number of colors
/datum/unit_test/greyscale_color_count

/datum/unit_test/greyscale_color_count/Run()
	for(var/atom/thing as anything in subtypesof(/atom))
		var/datum/greyscale_config/config = SSgreyscale.configurations["[initial(thing.greyscale_config)]"]
		if(!config)
			continue
		var/list/colors = splittext(initial(thing.greyscale_colors), "#")
		if(!length(colors))
			continue
		var/number_of_colors = length(colors) - 1
		if(config.expected_colors != number_of_colors)
			Fail("[thing] has the wrong amount of colors configured for [config.DebugName()]. Expected [config.expected_colors] but only found [number_of_colors].")
