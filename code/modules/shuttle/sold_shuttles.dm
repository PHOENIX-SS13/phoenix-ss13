/datum/sold_shuttle
	/// Name of the shuttle
	var/name = "Shuttle Name"
	/// Description of the shuttle
	var/desc = "Description."
	/// Detailed description of the ship
	var/detailed_desc = "Detailed specifications."
	/// ID of the shuttle
	var/shuttle_id
	/// How much does it cost
	var/cost = 5000
	/// How much left in stock
	var/stock = 2
	/// What type of the shuttle it is. Consoles may have limited purchase range
	var/shuttle_type = SHUTTLE_CIV
	/// Associative to TRUE list of dock id's that this template can fit into
	var/allowed_docks = list()

/datum/sold_shuttle/petrel
	name = "MS Petrel"
	desc = "A small sized mining shuttle with a single seat for piloting."
	detailed_desc = "It's a small sized mining shuttle, equipped with the bare necessities for mining and travel. It contains a singular container of co2 and air, a portable generator, two mining lasers, and a transporter."
	shuttle_id = "common_petrel"
	cost = 3000
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_MINING

/datum/sold_shuttle/pigeon
	name = "CTS Pigeon"
	desc = "A small sized civilian transport shuttle."
	detailed_desc = "It's a small sized transport shuttle that is normally utilized by colonies, this model featuring a small cargo bay. This shuttle is normally considered the workhorse of the frontier."
	shuttle_id = "common_pigeon"
	cost = 3000
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_CIV

/datum/sold_shuttle/rockdove
	name = "EMS Rockdove"
	desc = "A small sized emergency medical shuttle."
	detailed_desc = "A medical shuttle conversion of the CTS Pigeon by Frontier Practical Solutions, in which the cargo bay has been converted into a triage zone. While sometimes utilized by colony hospitals, it is often a rare sight on the frontier."
	shuttle_id = "common_rockdove"
	cost = 4500 //upcharge on the conversion, debatable if actually worth it
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_CIV

/datum/sold_shuttle/vulture
	name = "MS Vulture"
	desc = "A medium sized mining shuttle, equipped with a living quarter."
	detailed_desc = "It's medium sized and is equipped with three propulsion engines, canisters of co2 and oxygen, a portable generator, two mining lasers, a transporter and some emergency supplies. It has a singular living quarter and a restroom"
	shuttle_id = "common_vulture"
	cost = 7500
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_MINING

/datum/sold_shuttle/crow
	name = "ESS Crow"
	desc = "A medium sized exploration shuttle."
	detailed_desc = "It's medium sized and is equipped with four propulsion engines, canisters of co2 and oxygen, a portable generator, excavation gear and some emergency supplies."
	shuttle_id = "exploration_crow"
	cost = 10000
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_EXPLORATION

/datum/sold_shuttle/platform_small
	name = "Small Shuttle Platform"
	desc = "Empty 'build your own shuttle' platform. It's small sized (13x9) and of rectangular shape. It comes with some construction supplies."
	detailed_desc = "The construction supplies contain:\
		<BR> - 1 Shuttle Computer (Circuit board)\
		<BR> - 2 Propulsion Engines (Circuit board)\
		<BR> - 1 Rapid Pipe Dispenser\
		<BR> - 1 Rapid Construction Device\
		<BR> - 1 mechanical toolbox\
		<BR> - 1 electrical toolbox\
		<BR> - 1 APC electronics\
		<BR> - 1 air alarm electronics\
		<BR> - 1 air canister\
		<BR> - 50 iron sheets\
		<BR> - 50 glass sheets\
		<BR> - 50 titanium sheets\
		"
	cost = 3000
	shuttle_id = "common_platform_small"
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)

/datum/sold_shuttle/platform_medium
	name = "Medium Shuttle Platform"
	desc = "Empty 'build your own shuttle' platform. It's medium sized (17x13) and of a bullet shape. It comes with some construction supplies."
	detailed_desc = "The construction supplies contain:\
		<BR> - 1 Shuttle Computer (Circuit board)\
		<BR> - 3 Propulsion Engines (Circuit board)\
		<BR> - 1 Rapid Pipe Dispenser\
		<BR> - 1 Rapid Construction Device\
		<BR> - 1 mechanical toolbox\
		<BR> - 1 electrical toolbox\
		<BR> - 1 APC electronics\
		<BR> - 1 air alarm electronics\
		<BR> - 2 air canisters\
		<BR> - 100 iron sheets\
		<BR> - 100 glass sheets\
		<BR> - 100 titanium sheets\
		"
	cost = 5000
	shuttle_id = "common_platform_medium"
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)

/datum/sold_shuttle/platform_large
	name = "Large Shuttle Platform"
	desc = "Empty 'build your own shuttle' platform. It's large sized (23x15) and of a bullet shape. It comes with some construction supplies."
	detailed_desc = "The construction supplies contain:\
		<BR> - 1 Shuttle Computer (Circuit board)\
		<BR> - 5 Propulsion Engines (Circuit board)\
		<BR> - 1 Rapid Pipe Dispenser\
		<BR> - 1 Rapid Construction Device\
		<BR> - 1 mechanical toolbox\
		<BR> - 1 electrical toolbox\
		<BR> - 1 APC electronics\
		<BR> - 1 air alarm electronics\
		<BR> - 4 air canister\
		<BR> - 200 iron sheets\
		<BR> - 200 glass sheets\
		<BR> - 200 titanium sheets\
		"
	cost = 10000
	shuttle_id = "common_platform_large"
	allowed_docks = list(DOCKS_LARGE_UPWARDS)
