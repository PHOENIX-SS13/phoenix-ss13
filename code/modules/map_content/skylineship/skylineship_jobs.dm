// SKYLINE JOBS

// SKYLINE COMMAND //

/datum/job/skyline/captain
	title = "CPC Ship Captain"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	head_announce = list(RADIO_CHANNEL_COMMAND)
	department_head = list("CentCom")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Commonwealth of Periphery Colonies' Navy Commander"
	selection_color = "#ccccff"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 180
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/captain
	plasmaman_outfit = /datum/outfit/plasmaman/captain

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_CAPTAIN
	departments_list = list(
		/datum/job_department/command,
		)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS

	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)

/datum/job/skyline/captain/get_captaincy_announcement(mob/living/captain)
	return "Captain [captain.real_name] on deck!"

/datum/job/skyline/first_mate
	title = "CPC First Mate"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	head_announce = list(RADIO_CHANNEL_COMMAND)
	department_head = list("Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Captain"
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 10
	exp_requirements = 180
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/first_mate
	plasmaman_outfit = /datum/outfit/plasmaman/first_mate

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SRV
	bounty_types = CIV_JOB_RANDOM

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL
	departments_list = list(
		/datum/job_department/command,
		)
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS

	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)

/datum/job/skyline/first_mate/get_captaincy_announcement(mob/living/captain)
	return "Due to staffing shortages, newly promoted Acting Captain [captain.real_name] on deck!"

/datum/job/skyline/bridge_officer
	title = "CPC Bridge Officer"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	head_announce = list(RADIO_CHANNEL_COMMAND)
	department_head = list("First Mate", "Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Captain"
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 10
	exp_requirements = 180
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/bridge_officer
	plasmaman_outfit = /datum/outfit/plasmaman/bridge_officer

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SRV
	bounty_types = CIV_JOB_RANDOM

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL
	departments_list = list(
		/datum/job_department/command,
		)
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS

	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)

/datum/job/skyline/bridge_officer/get_captaincy_announcement(mob/living/captain)
	return "Due to staffing shortages, newly promoted Acting Captain [captain.real_name] on deck!"

/datum/job/skyline/pilot
	title = "CPC Skyline Pilot"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	head_announce = list(RADIO_CHANNEL_COMMAND)
	department_head = list("First Mate", "Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Captain"
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 10
	exp_requirements = 180
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/pilot
	plasmaman_outfit = /datum/outfit/plasmaman/pilot

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SRV
	bounty_types = CIV_JOB_RANDOM

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL
	departments_list = list(
		/datum/job_department/command,
		)
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS

/datum/job/skyline/pilot/get_captaincy_announcement(mob/living/captain)
	return "Due to staffing shortages, newly promoted Acting Captain [captain.real_name] on deck!"

// SKYLINE ENGINEERING //

/datum/job/skyline/lead_engineer
	title = "CPC Lead Engineer"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	head_announce = list("Engineering")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Captain, First Mate, and Bridge Officers"
	selection_color = "#ffeeaa"
	req_admin_notify = 1
	minimal_player_age = 7
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_ENGINEERING
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/lead_engineer
	plasmaman_outfit = /datum/outfit/plasmaman/chief_engineer
	departments_list = list(
		/datum/job_department/engineering,
		)

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_ENG

	display_order = JOB_DISPLAY_ORDER_CHIEF_ENGINEER
	bounty_types = CIV_JOB_ENG

	banned_quirks = list(HEAD_RESTRICTED_QUIRKS, "Paraplegic" = TRUE)

	family_heirlooms = list(/obj/item/clothing/head/hardhat/white, /obj/item/screwdriver, /obj/item/wrench, /obj/item/weldingtool, /obj/item/crowbar, /obj/item/wirecutters)

	mail_goodies = list(
		/obj/item/stack/sheet/mineral/diamond = 15,
		/obj/item/stack/sheet/mineral/uranium/five = 15,
		/obj/item/stack/sheet/mineral/plasma/five = 15,
		/obj/item/stack/sheet/mineral/gold = 15,
		/obj/effect/spawner/lootdrop/space/fancytool/engineonly = 3
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS

	required_languages = IMPORTANT_ROLE_LANGUAGE_REQUIREMENT

/datum/job/skyline/engineer
	title = "CPC Ship Engineer"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 4
	spawn_positions = 4
	supervisors = "the First Mate and the Captain"
	selection_color = "#fff5cc"
	exp_requirements = 60
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/engineer
	plasmaman_outfit = /datum/outfit/plasmaman/engineering

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_ENG

	display_order = JOB_DISPLAY_ORDER_STATION_ENGINEER
	bounty_types = CIV_JOB_ENG
	departments_list = list(
		/datum/job_department/engineering,
		)
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS



// SKYLINE MEDICAL //

/datum/job/skyline/lead_doctor
	title = "CPC Lead Medical Doctor"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	head_announce = list(RADIO_CHANNEL_MEDICAL)
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffddf0"
	req_admin_notify = 1
	minimal_player_age = 7
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_MEDICAL
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/lead_doctor
	plasmaman_outfit = /datum/outfit/plasmaman/chief_medical_officer
	departments_list = list(
		/datum/job_department/medical,
		)

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER
	bounty_types = CIV_JOB_MED

	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)

	mail_goodies = list(
		/obj/effect/spawner/lootdrop/organ_spawner = 10,
		/obj/effect/spawner/lootdrop/memeorgans = 8,
		/obj/effect/spawner/lootdrop/space/fancytool/advmedicalonly = 4,
		/obj/effect/spawner/lootdrop/space/fancytool/raremedicalonly = 1
	)
	family_heirlooms = list(/obj/item/storage/firstaid/ancient/heirloom)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS

	voice_of_god_power = 1.4 //Command staff has authority

	required_languages = IMPORTANT_ROLE_LANGUAGE_REQUIREMENT

/datum/job/skyline/doctor
	title = "CPC Ship Medical Doctor"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 2
	spawn_positions = 2
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffeef0"

	outfit = /datum/outfit/job/skyline/doctor
	plasmaman_outfit = /datum/outfit/plasmaman/medical

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_MEDICAL_DOCTOR
	bounty_types = CIV_JOB_MED
	departments_list = list(
		/datum/job_department/medical,
		)
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS


/datum/job/skyline/nurse
	title = "CPC Ship Nurse"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 2
	spawn_positions = 2
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffeef0"

	outfit = /datum/outfit/job/skyline/nurse
	plasmaman_outfit = /datum/outfit/plasmaman/medical

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_MEDICAL_DOCTOR
	bounty_types = CIV_JOB_MED
	departments_list = list(
		/datum/job_department/medical,
		)
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE

/datum/job/skyline/chemist
	title = "CPC Ship Chemist"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 2
	spawn_positions = 2
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffeef0"
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/chemist
	plasmaman_outfit = /datum/outfit/plasmaman/chemist

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_CHEMIST
	bounty_types = CIV_JOB_CHEM
	departments_list = list(
		/datum/job_department/medical,
	)

	family_heirlooms = list(/obj/item/book/manual/wiki/chemistry, /obj/item/ph_booklet)

	mail_goodies = list(
		/obj/item/reagent_containers/glass/bottle/flash_powder = 15,
		/obj/item/reagent_containers/glass/bottle/exotic_stabilizer = 5,
		/obj/item/reagent_containers/glass/bottle/leadacetate = 5,
		/obj/item/paper/secretrecipe = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS


/datum/job/skyline/virologist
	title = "CPC Ship Virologist"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffeef0"
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/virologist
	plasmaman_outfit = /datum/outfit/plasmaman/viro

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_VIROLOGIST
	bounty_types = CIV_JOB_VIRO
	departments_list = list(
		/datum/job_department/medical,
		)

	family_heirlooms = list(/obj/item/reagent_containers/syringe)

	mail_goodies = list(
		/obj/item/reagent_containers/glass/bottle/random_virus = 15,
		/obj/item/reagent_containers/glass/bottle/formaldehyde = 10,
		/obj/item/reagent_containers/glass/bottle/synaptizine = 10,
		/obj/item/stack/sheet/mineral/plasma = 10,
		/obj/item/stack/sheet/mineral/uranium = 5
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS

/datum/job/skyline/roboticist
	title = "CPC Ship Roboticist"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffeeff"
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	bounty_types = CIV_JOB_ROBO

	outfit = /datum/outfit/job/skyline/roboticist
	plasmaman_outfit = /datum/outfit/plasmaman/robotics
	departments_list = list(
		/datum/job_department/medical,
		)

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_VIROLOGIST

	mail_goodies = list(
		/obj/item/storage/box/flashes = 20,
		/obj/item/stack/sheet/iron/twenty = 15,
		/obj/item/modular_computer/tablet/preset/advanced = 5
	)

	family_heirlooms = list(/obj/item/toy/plush/pkplush)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS


/datum/job/skyline/roboticist/New()
	. = ..()
	family_heirlooms += subtypesof(/obj/item/toy/mecha)


// SKYLINE RESEARCH //

/datum/job/skyline/lead_researcher
	title = "CPC Lead Researcher"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	head_announce = list("Science")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffddff"
	req_admin_notify = 1
	minimal_player_age = 7
	exp_required_type_department = EXP_TYPE_SCIENCE
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/lead_researcher
	plasmaman_outfit = /datum/outfit/plasmaman/research_director
	departments_list = list(
		/datum/job_department/science,
		)

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_RESEARCH_DIRECTOR
	bounty_types = CIV_JOB_SCI

	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS

/datum/job/skyline/researcher
	title = "CPC Ship Researcher"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 4
	spawn_positions = 4
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffeeff"
	exp_requirements = 60
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/researcher
	plasmaman_outfit = /datum/outfit/plasmaman/science

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_SCIENTIST
	bounty_types = CIV_JOB_SCI
	departments_list = list(
		/datum/job_department/science,
		)
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS


/datum/job/skyline/geneticist
	title = "CPC Ship Geneticist"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffeeff"
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/geneticist
	plasmaman_outfit = /datum/outfit/plasmaman/genetics
	departments_list = list(
		/datum/job_department/medical,
		/datum/job_department/science,
		)

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_GENETICIST
	bounty_types = CIV_JOB_SCI

	mail_goodies = list(
		/obj/item/storage/box/monkeycubes = 10
	)

	family_heirlooms = list(/obj/item/clothing/under/shorts/purple)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS

/datum/job/skyline/xenobotanist
	title = "CPC Ship Xenobotanist"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 3
	spawn_positions = 3
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffeeff"

	outfit = /datum/outfit/job/skyline/xenobotanist
	plasmaman_outfit = /datum/outfit/plasmaman/botany

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_SCIENTIST
	bounty_types = CIV_JOB_GROW
	departments_list = list(
		/datum/job_department/service,
		/datum/job_department/science,
		)
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS



// SKYLINE SECURITY //

/datum/job/skyline/security_team_lead
	title = "CPC Security Team Lead"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("First Mate", "Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and Captain"
	selection_color = "#ffdddd"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 300
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SECURITY
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/security_team_lead
	plasmaman_outfit = /datum/outfit/plasmaman/head_of_security
	departments_list = list(
		/datum/job_department/security,
		)

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_SECURITY
	bounty_types = CIV_JOB_SEC

	banned_quirks = list(SEC_RESTRICTED_QUIRKS, HEAD_RESTRICTED_QUIRKS)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS

	required_languages = IMPORTANT_ROLE_LANGUAGE_REQUIREMENT

/datum/job/skyline/security_officer
	title = "CPC Security Officer"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Security Team Lead", "Bridge Officer", "First Mate", "Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Security Team Lead, Bridge Officers, First Mate, and the Captain"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 300
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/security_officer
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC
	departments_list = list(
		/datum/job_department/security,
		)

	banned_quirks = list(SEC_RESTRICTED_QUIRKS)

	required_languages = IMPORTANT_ROLE_LANGUAGE_REQUIREMENT

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/boomerang/loaded = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS


/datum/job/skyline/customs_officer
	title = "CPC Customs Officer"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Security Team Lead", "Bridge Officer", "First Mate", "Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 2
	spawn_positions = 2
	supervisors = "the security team lead"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 300
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/customs_officer
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC
	departments_list = list(
		/datum/job_department/security,
		)

	banned_quirks = list(SEC_RESTRICTED_QUIRKS)

	required_languages = IMPORTANT_ROLE_LANGUAGE_REQUIREMENT

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/boomerang/loaded = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS


// SKYLINE CARGO //

/datum/job/skyline/lead_deckhand
	title = "CPC Lead Deckhand"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"
	selection_color = "#d7b088"
	exp_required_type_department = EXP_TYPE_SUPPLY
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/lead_deckhand
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_QUARTERMASTER
	bounty_types = CIV_JOB_RANDOM
	departments_list = list(
		/datum/job_department/cargo,
		)
	family_heirlooms = list(/obj/item/stamp, /obj/item/stamp/denied)
	mail_goodies = list(
		/obj/item/circuitboard/machine/emitter = 3
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS

	banned_quirks = list(HEAD_RESTRICTED_QUIRKS) //Not a head.. YET

	required_languages = IMPORTANT_ROLE_LANGUAGE_REQUIREMENT

/datum/job/skyline/deckhand
	title = "CPC Deckhand"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 6
	spawn_positions = 3
	supervisors = "the First Mate and the Captain"
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/skyline/deckhand
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_CAR
	display_order = JOB_DISPLAY_ORDER_CARGO_TECHNICIAN
	bounty_types = CIV_JOB_RANDOM
	departments_list = list(
		/datum/job_department/cargo,
		)
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS


/datum/job/skyline/salvage_worker
	title = "CPC Salvage Worker"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 3
	spawn_positions = 3
	supervisors = "the First Mate and the Captain"
	selection_color = "#dcba97"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/salvage_worker
	plasmaman_outfit = /datum/outfit/plasmaman/mining

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_SHAFT_MINER
	bounty_types = CIV_JOB_MINE
	departments_list = list(
		/datum/job_department/cargo,
		/datum/job_department/engineering,
		)

	family_heirlooms = list(/obj/item/pickaxe/mini, /obj/item/shovel)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS

	required_languages = LESS_IMPORTANT_ROLE_LANGUAGE_REQUIREMENT


// SKYLINE SERVICE //

/datum/job/skyline/private_investigator
	title = "CPC Private Investigator"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 300
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/private_investigator
	plasmaman_outfit = /datum/outfit/plasmaman/detective
	departments_list = list(
		/datum/job_department/service,
		)

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_JANITOR

	family_heirlooms = list(/obj/item/reagent_containers/food/drinks/bottle/whiskey)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS

/datum/job/skyline/janitor
	title = "CPC Ship Janitor"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"
	selection_color = "#bbe291"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/skyline/janitor
	plasmaman_outfit = /datum/outfit/plasmaman/janitor

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_JANITOR
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/mop, /obj/item/clothing/suit/caution, /obj/item/reagent_containers/glass/bucket, /obj/item/paper/fluff/stations/soap)

	mail_goodies = list(
		/obj/item/grenade/chem_grenade/cleaner = 30,
		/obj/item/storage/box/lights/mixed = 20,
		/obj/item/lightreplacer = 10
	)

	required_languages = LESS_IMPORTANT_ROLE_LANGUAGE_REQUIREMENT
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS

/datum/job/curator/skyline
	title = "CPC Ship Curator"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"

/datum/job/chaplain/skyline
	title = "CPC Ship Chaplain"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"

/datum/job/bartender/skyline
	title = "CPC Ship Bartender"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"

/datum/job/cook/skyline
	title = "CPC Ship Cook"
	department_head = list("First Mate", "Bridge Officer", "Ship Captain")
	faction = FACTION_SKYLINESHIP
	total_positions = 2
	spawn_positions = 1
	supervisors = "the First Mate and the Captain"

// SKYLINE CIVILIAN //

/datum/job/skyline/off_duty
	title = "CPC Off-Duty Crewmember"
	faction = FACTION_SKYLINESHIP
	total_positions = 20
	spawn_positions = 10
	supervisors = "your current employment"
	selection_color = "#dddddd"
	outfit = /datum/outfit/job/skyline/off_duty_crewmember
	plasmaman_outfit = /datum/outfit/plasmaman
	paycheck = PAYCHECK_ASSISTANT

	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_ASSISTANT
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS


/datum/job/skyline/stowaway
	title = "Stowaway"
	faction = FACTION_SKYLINESHIP
	total_positions = 3
	spawn_positions = 3
	supervisors = "your own interests"
	selection_color = "#dddddd"
	outfit = /datum/outfit/job/skyline/stowaway
	plasmaman_outfit = /datum/outfit/plasmaman
	paycheck = PAYCHECK_ASSISTANT

	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_PRISONER
	job_flags = JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK


// SKYLINE SILICONS //

/datum/job/ai/skyline
	title = "CPC Ship AI"
	faction = FACTION_SKYLINESHIP
	supervisors = "the First Mate and the Captain"

/datum/job/cyborg/skyline
	title = "CPC Ship Cyborg"
	faction = FACTION_SKYLINESHIP
	total_positions = 2
	spawn_positions = 2
	supervisors = "the First Mate and the Captain"
