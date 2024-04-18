/datum/config_entry/number/autoshell_pop //At what pop to stop spawning autoshells for the ai
	config_entry_value = 8 //0 means disabled
	integer = TRUE
	min_val = -1

/datum/config_entry/number/hostile_health_mult //multiplier for /simple_animal/hostile health
	config_entry_value = 1
	integer = FALSE
	min_val = 0.1

/datum/config_entry/string/ffprobe_path //filepath (including the file and its extension) for ffprobe for reading jukebox song metadata
	config_entry_value = ""
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN
