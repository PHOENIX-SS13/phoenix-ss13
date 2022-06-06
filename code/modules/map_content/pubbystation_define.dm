/datum/map_config/pubbystation
	map_name = "Pubby Station"
	map_path = "map_files/PubbyStation"
	map_file = "PubbyStation.dmm"

	traits = null
	space_ruin_levels = 3

	minetype = "lavaland"

	allow_custom_shuttles = TRUE
	shuttles = list(
		"cargo" = "cargo_pubby",
		"ferry" = "ferry_fancy",
		"whiteship" = "whiteship_pubby",
		"emergency" = "emergency_pubby",
	)

	job_changes = list()

	overmap_object_type = /datum/overmap_object/shuttle/station
