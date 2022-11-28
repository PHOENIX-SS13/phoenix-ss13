/datum/map_config/skylineship
	map_name = "CPCV Skyline"
	map_path = "map_files/skylineship"
	map_file = "skylineship.dmm"

	traits = list(
		list(
			"Up" = 1,
		),
		list(
			"Up" = 1,
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),
		list(
			"Up" = 1,
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),
		list(
			"Up" = 1,
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),
		list(
			"Up" = 1,
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),
		list(
			"Up" = 1,
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),
		list(
			"Down" = -1,
			"Baseturf" = "/turf/open/openspace",
		),

	)

	space_ruin_levels = 4

	minetype = "none"

	global_trading_hub_type = /datum/trade_hub/worldwide/skyline

	allow_custom_shuttles = TRUE
	shuttles = list(
		"cargo" = "cargo_skyline",
		"mining" = "common_vista",
		"emergency" = "emergency_skyline",
		"whiteship" = "whiteship_kilo",
		"ferry" = null,
	)

	job_faction = FACTION_SKYLINESHIP

	overflow_job = /datum/job/skyline/off_duty

	overmap_object_type = /datum/overmap_object/shuttle/ship/skyline

/datum/map_config/skylineship/get_map_info()
	return {"You are aboard the <b>[map_name]</b>, a military peacekeeping vessel affiliated with the Commonwealth of Periphery Colonies.
No meaningful authorities call to claim the planets and resources in this unregulated sector, so development is fair game."}
