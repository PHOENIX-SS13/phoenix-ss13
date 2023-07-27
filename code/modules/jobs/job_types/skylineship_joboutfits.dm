// Skyline Ship Additions

// Command Outfits

/datum/outfit/job/skyline/first_mate
	name = "First Mate"
	jobtype = /datum/job/skyline/first_mate

	id = /obj/item/card/id/advanced/gold
	belt = /obj/item/pda/heads/skyline/first_mate
	ears = /obj/item/radio/headset/heads/skyline/first_mate
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/cpcofficer
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	head = /obj/item/clothing/head/beret/sec/navyofficer/cpcofficer

	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic=1,
		/obj/item/modular_computer/tablet/preset/advanced/command = 1,
		)
	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/skyline/first_mate

/datum/outfit/job/skyline/bridge_officer
	name = "Bridge Officer"
	jobtype = /datum/job/skyline/bridge_officer

	id = /obj/item/card/id/advanced/silver
	belt = /obj/item/pda/heads/skyline/bridge_officer
	ears = /obj/item/radio/headset/heads/skyline/bridge_officer
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/cpcofficer
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	head = /obj/item/clothing/head/beret/sec/navyofficer/cpcofficer

	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic=1,
		/obj/item/modular_computer/tablet/preset/advanced/command = 1,
		)
	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/skyline/bridge_officer

/datum/outfit/job/skyline/pilot
	name = "Skyline Pilot"
	jobtype = /datum/job/skyline/pilot

	id = /obj/item/card/id/advanced/silver
	belt = /obj/item/pda/heads/skyline/pilot
	ears = /obj/item/radio/headset/heads/skyline/pilot
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/cpcofficer
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	head = /obj/item/clothing/head/beret/sec/navyofficer/cpcofficer

	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic=1,
		/obj/item/modular_computer/tablet/preset/advanced/command = 1,
		)
	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/skyline/pilot

// Engineering Outfits

/datum/outfit/job/skyline/lead_engineer
	name = "Lead Engineer"
	jobtype = /datum/job/skyline/lead_engineer

	id = /obj/item/card/id/advanced/silver
	belt = /obj/item/storage/belt/utility/chief/full
	l_pocket = /obj/item/pda/heads/skyline/lead_engineer
	ears = /obj/item/radio/headset/heads/skyline/lead_engineer
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hardhat/white
	gloves = /obj/item/clothing/gloves/color/black
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced/command/engineering=1)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET

	id_trim = /datum/id_trim/job/skyline/lead_engineer

/datum/outfit/job/skyline/engineer
	name = "Ship Engineer"
	jobtype = /datum/job/skyline/engineer

	belt = /obj/item/storage/belt/utility/full/engi
	l_pocket = /obj/item/pda/engineering
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/hardhat
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced/engineering=1)

	id_trim = /datum/id_trim/job/skyline/engineer

//Medical Outfits

/datum/outfit/job/skyline/lead_doctor
	name = "Lead Medical Doctor"
	jobtype = /datum/job/skyline/lead_doctor

	id = /obj/item/card/id/advanced/silver
	belt = /obj/item/pda/heads/skyline/lead_doctor
	l_pocket = /obj/item/pinpointer/crew
	ears = /obj/item/radio/headset/heads/skyline/lead_doctor
	uniform = /obj/item/clothing/under/rank/medical/doctor
	shoes = /obj/item/clothing/shoes/sneakers/brown
	suit = /obj/item/clothing/suit/toggle/labcoat
	l_hand = /obj/item/storage/firstaid/medical
	suit_store = /obj/item/flashlight/pen/paramedic
	backpack_contents = list(
		/obj/item/modular_computer/tablet/preset/advanced/command=1,
		)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	box = /obj/item/storage/box/survival/medical

	id_trim = /datum/id_trim/job/skyline/lead_doctor

/datum/outfit/job/skyline/doctor
	name = "Medical Doctor"
	jobtype = /datum/job/skyline/doctor

	belt = /obj/item/pda/skyline/doctor
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/doctor
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat
	l_hand = /obj/item/storage/firstaid/medical
	suit_store = /obj/item/flashlight/pen

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

	id_trim = /datum/id_trim/job/skyline/doctor

/datum/outfit/job/skyline/nurse
	name = "Ship Nurse"
	jobtype = /datum/job/skyline/nurse

	belt = /obj/item/pda/skyline/nurse
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/doctor/blue
	shoes = /obj/item/clothing/shoes/sneakers/white
	l_hand = /obj/item/storage/firstaid/medical

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	box = /obj/item/storage/box/survival/medical

	id_trim = /datum/id_trim/job/skyline/nurse

/datum/outfit/job/skyline/roboticist
	name = "Ship Roboticist"
	jobtype = /datum/job/skyline/roboticist

	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/pda/skyline/roboticist
	ears = /obj/item/radio/headset/headset_medsci
	uniform = /obj/item/clothing/under/rank/rnd/roboticist
	suit = /obj/item/clothing/suit/toggle/labcoat/roboticist

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	duffelbag = /obj/item/storage/backpack/duffelbag/toxins
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/science=1)

	pda_slot = ITEM_SLOT_LPOCKET

	id_trim = /datum/id_trim/job/skyline/roboticist

/datum/outfit/job/skyline/chemist
	name = "Ship Chemist"
	jobtype = /datum/job/skyline/chemist

	glasses = /obj/item/clothing/glasses/science
	belt = /obj/item/pda/skyline/chemist
	l_pocket = /obj/item/reagent_containers/glass/bottle/random_buffer
	r_pocket = /obj/item/reagent_containers/dropper
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/chemist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/chemist
	backpack = /obj/item/storage/backpack/chemistry
	satchel = /obj/item/storage/backpack/satchel/chem
	duffelbag = /obj/item/storage/backpack/duffelbag/chemistry
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

	id_trim = /datum/id_trim/job/skyline/chemist

/datum/outfit/job/skyline/virologist
	name = "Ship Virologist"
	jobtype = /datum/job/skyline/virologist

	belt = /obj/item/pda/skyline/virology
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/virologist
	mask = /obj/item/clothing/mask/surgical
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat/virologist
	suit_store =  /obj/item/flashlight/pen

	backpack = /obj/item/storage/backpack/virology
	satchel = /obj/item/storage/backpack/satchel/vir
	duffelbag = /obj/item/storage/backpack/duffelbag/virology
	box = /obj/item/storage/box/survival/medical

	id_trim = /datum/id_trim/job/skyline/virologist

// Research Outfits

/datum/outfit/job/skyline/lead_researcher
	name = "Lead Researcher"
	jobtype = /datum/job/skyline/lead_researcher

	id = /obj/item/card/id/advanced/silver
	belt = /obj/item/pda/heads/skyline/lead_researcher
	ears = /obj/item/radio/headset/heads/skyline/lead_researcher
	uniform = /obj/item/clothing/under/rank/rnd/research_director/turtleneck
	shoes = /obj/item/clothing/shoes/sneakers/brown
	suit = /obj/item/clothing/suit/toggle/labcoat
	backpack_contents = list(
		/obj/item/modular_computer/tablet/preset/advanced/command=1,
		)

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	duffelbag = /obj/item/storage/backpack/duffelbag/toxins

	id_trim = /datum/id_trim/job/skyline/lead_researcher

/datum/outfit/job/skyline/researcher
	name = "Ship Researcher"
	jobtype = /datum/job/skyline/researcher

	belt = /obj/item/pda/skyline/researcher
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	duffelbag = /obj/item/storage/backpack/duffelbag/toxins
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/science=1)

	id_trim = /datum/id_trim/job/skyline/researcher

/datum/outfit/job/skyline/researcher/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(0.4))
		neck = /obj/item/clothing/neck/tie/horrible

/datum/outfit/job/skyline/geneticist
	name = "Ship Geneticist"
	jobtype = /datum/job/skyline/geneticist

	belt = /obj/item/pda/skyline/geneticist
	ears = /obj/item/radio/headset/headset_medsci
	uniform = /obj/item/clothing/under/rank/rnd/geneticist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/genetics
	suit_store = /obj/item/flashlight/pen
	l_pocket = /obj/item/sequence_scanner

	backpack = /obj/item/storage/backpack/genetics
	satchel = /obj/item/storage/backpack/satchel/gen
	duffelbag = /obj/item/storage/backpack/duffelbag/genetics

	id_trim = /datum/id_trim/job/skyline/geneticist

/datum/outfit/job/skyline/xenobotanist
	name = "Xenobotanist"
	jobtype = /datum/job/skyline/xenobotanist

	belt = /obj/item/pda/skyline/xenobotanist
	ears = /obj/item/radio/headset/skyline/xenobotanist
	uniform = /obj/item/clothing/under/rank/civilian/hydroponics
	suit = /obj/item/clothing/suit/apron
	gloves =/obj/item/clothing/gloves/botanic_leather
	suit_store = /obj/item/plant_analyzer

	backpack = /obj/item/storage/backpack/botany
	satchel = /obj/item/storage/backpack/satchel/hyd
	duffelbag = /obj/item/storage/backpack/duffelbag/hydroponics

	id_trim = /datum/id_trim/job/skyline/xenobotanist

// Security Outfits

/datum/outfit/job/skyline/security_team_lead
	name = "Security Team Lead"
	jobtype = /datum/job/skyline/security_team_lead

	id = /obj/item/card/id/advanced/silver
	belt = /obj/item/pda/heads/skyline/security_team_lead
	ears = /obj/item/radio/headset/heads/skyline/security_team_lead
	uniform = /obj/item/clothing/under/rank/security/head_of_security/formal/security_team_lead
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/hos/trenchcoat
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/beret/sec/navyhos/security_team_lead
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	suit_store = /obj/item/gun/energy/e_gun
	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(/obj/item/melee/baton/loaded=1,
		/obj/item/modular_computer/tablet/preset/advanced/command=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	chameleon_extras = list(/obj/item/gun/energy/e_gun/hos,
		/obj/item/stamp/hos)

	id_trim = /datum/id_trim/job/skyline/security_team_lead

/datum/outfit/job/skyline/security_officer
	name = "Security Officer"
	jobtype = /datum/job/skyline/security_officer

	belt = /obj/item/pda/skyline/security_officer
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/officer/skylineship
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/sec
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	suit_store = /obj/item/gun/energy/disabler
	backpack_contents = list(/obj/item/melee/baton/loaded=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	chameleon_extras = list(/obj/item/gun/energy/disabler,
		/obj/item/clothing/glasses/hud/security/sunglasses,
		/obj/item/clothing/head/helmet)
	//The helmet is necessary because /obj/item/clothing/head/helmet/sec is overwritten in the chameleon list by the standard helmet

	id_trim = /datum/id_trim/job/skyline/security_officer

/datum/outfit/job/skyline/customs_officer
	name = "Customs Officer"
	jobtype = /datum/job/skyline/customs_officer

	belt = /obj/item/pda/skyline/customs_officer
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/beret/sec/navyofficer
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	suit_store = /obj/item/gun/energy/disabler
	backpack_contents = list(/obj/item/melee/baton/loaded=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	chameleon_extras = list(/obj/item/gun/energy/disabler,
		/obj/item/clothing/glasses/hud/security/sunglasses,
		/obj/item/clothing/head/beret/sec/navyofficer)

	id_trim = /datum/id_trim/job/skyline/customs_officer

// Cargo Outfits

/datum/outfit/job/skyline/lead_deckhand
	name = "Lead Deckhand"
	jobtype = /datum/job/skyline/lead_deckhand

	belt = /obj/item/pda/heads/skyline/lead_deckhand
	ears = /obj/item/radio/headset/heads/skyline/lead_deckhand
	uniform = /obj/item/clothing/under/rank/cargo/qm
	shoes = /obj/item/clothing/shoes/sneakers/brown
	glasses = /obj/item/clothing/glasses/sunglasses
	l_hand = /obj/item/clipboard
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo/quartermaster = 1)

	chameleon_extras = /obj/item/stamp/qm

	id_trim = /datum/id_trim/job/skyline/lead_deckhand

/datum/outfit/job/skyline/deckhand
	name = "Deckhand"
	jobtype = /datum/job/skyline/deckhand

	belt = /obj/item/pda/skyline/deckhand
	ears = /obj/item/radio/headset/headset_cargo
	uniform = /obj/item/clothing/under/rank/cargo/tech
	shoes = /obj/item/clothing/shoes/sneakers/brown

	id_trim = /datum/id_trim/job/skyline/deckhand

/datum/outfit/job/skyline/salvage_worker
	name = "Salvage Worker"
	jobtype = /datum/job/skyline/salvage_worker

	belt = /obj/item/pda/skyline/salvage_worker
	ears = /obj/item/radio/headset/skyline/salvage_worker
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/cargo/miner/lavaland
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/survival
	r_pocket = /obj/item/storage/bag/ore //causes issues if spawned in backpack
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,\
		)

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag/explorer
	box = /obj/item/storage/box/survival/mining

	id_trim = /datum/id_trim/job/skyline/salvage_worker

// Service Outfits

/datum/outfit/job/skyline/private_investigator
	name = "Private Investigator"
	jobtype = /datum/job/skyline/private_investigator

	belt = /obj/item/pda/skyline/private_investigator
	ears = /obj/item/radio/headset/skyline/private_investigator
	uniform = /obj/item/clothing/under/rank/security/detective
	neck = /obj/item/clothing/neck/tie/detective
	shoes = /obj/item/clothing/shoes/sneakers/brown
	suit = /obj/item/clothing/suit/det_suit
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/fedora/det_hat
	l_pocket = /obj/item/toy/crayon/white
	r_pocket = /obj/item/lighter
	backpack_contents = list(/obj/item/storage/box/evidence=1,
		/obj/item/detective_scanner=1,
		)

	id_trim = /datum/id_trim/job/skyline/private_investigator

/datum/outfit/job/skyline/janitor
	name = "Ship Janitor"
	jobtype = /datum/job/skyline/janitor

	belt = /obj/item/pda/skyline/janitor
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/janitor
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

	id_trim = /datum/id_trim/job/skyline/janitor

// Civilian Outfits

/datum/outfit/job/skyline/stowaway
	name = "Stowaway"
	jobtype = /datum/job/skyline/stowaway

	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/job/skyline/stowaway

/datum/outfit/job/skyline/stowaway/pre_equip(mob/living/carbon/human/H)
	..()
	if (CONFIG_GET(flag/grey_assistants))
		if(H.jumpsuit_style == PREF_SUIT)
			uniform = /obj/item/clothing/under/color/grey
		else
			uniform = /obj/item/clothing/under/color/jumpskirt/grey
	else
		if(H.jumpsuit_style == PREF_SUIT)
			uniform = /obj/item/clothing/under/color/random
		else
			uniform = /obj/item/clothing/under/color/jumpskirt/random

/datum/outfit/job/skyline/off_duty_crewmember
	name = "Off-Duty Crewmember"
	jobtype = /datum/job/skyline/off_duty
	id_trim = /datum/id_trim/job/skyline/off_duty
