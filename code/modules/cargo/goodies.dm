
/datum/supply_pack/goody
	access = NONE
	group = "Goodies"
	goody = TRUE

/datum/supply_pack/goody/dumdum38
	name = ".38 DumDum Speedloader"
	desc = "Contains one speedloader of .38 DumDum ammunition, good for embedding in soft targets."
	cost = PAYCHECK_MEDIUM * 2
	access_view = ACCESS_BRIG
	contains = list(/obj/item/ammo_box/c38/dumdum)

/datum/supply_pack/goody/match38
	name = ".38 Match Grade Speedloader"
	desc = "Contains one speedloader of match grade .38 ammunition, perfect for showing off trickshots."
	cost = PAYCHECK_MEDIUM * 2
	access_view = ACCESS_BRIG
	contains = list(/obj/item/ammo_box/c38/match)

/datum/supply_pack/goody/rubber
	name = ".38 Rubber Speedloader"
	desc = "Contains one speedloader of bouncy rubber .38 ammunition, for when you want to bounce your shots off anything and everything."
	cost = PAYCHECK_MEDIUM * 1.5
	access_view = ACCESS_BRIG
	contains = list(/obj/item/ammo_box/c38/match/bouncy)

/datum/supply_pack/goody/stingbang
	name = "Stingbang Single-Pack"
	desc = "Contains one \"stingbang\" grenade, perfect for playing meanhearted pranks."
	cost = PAYCHECK_HARD * 2.5
	access_view = ACCESS_BRIG
	contains = list(/obj/item/grenade/stingbang)

/datum/supply_pack/goody/combatknives_single
	name = "Combat Knife Single-Pack"
	desc = "Contains one sharpened combat knive. Guaranteed to fit snugly inside any Nanotrasen-standard boot."
	cost = PAYCHECK_HARD * 1.75
	contains = list(/obj/item/kitchen/knife/combat)

/datum/supply_pack/goody/ballistic_single
	name = "Combat Shotgun Single-Pack"
	desc = "For when the enemy absolutely needs to be replaced with lead. Contains one Aussec-designed Combat Shotgun, and one Shotgun Bandolier."
	cost = PAYCHECK_HARD * 15
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/ballistic/shotgun/automatic/combat, /obj/item/storage/belt/bandolier)

/datum/supply_pack/goody/energy_single
	name = "Energy Gun Single-Pack"
	desc = "Contains one energy gun, capable of firing both nonlethal and lethal blasts of light."
	cost = PAYCHECK_HARD * 12
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/energy/e_gun)

/datum/supply_pack/goody/hell_single
	name = "Hellgun Kit Single-Pack"
	desc = "Contains one hellgun degradation kit, an old pattern of laser gun infamous for its ability to horribly disfigure targets with burns. Technically violates the Space Geneva Convention when used on humanoids."
	cost = PAYCHECK_MEDIUM * 2
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/weaponcrafting/gunkit/hellgun)

/datum/supply_pack/goody/wt550_single
	name = "WT-550 Auto Rifle Single-Pack"
	desc = "Contains one high-powered, semiautomatic rifles chambered in 4.6x30mm." // "high-powered" lol yea right
	cost = PAYCHECK_HARD * 20
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/ballistic/automatic/wt550)

/datum/supply_pack/goody/wt550ammo_single
	name = "WT-550 Auto Rifle Ammo Single-Pack"
	desc = "Contains a 20-round magazine for the WT-550 Auto Rifle. Each magazine is designed to facilitate rapid tactical reloads."
	cost = PAYCHECK_HARD * 6
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/ammo_box/magazine/wt550m9)

/datum/supply_pack/goody/sologamermitts
	name = "Insulated Gloves Single-Pack"
	desc = "The backbone of modern society. Barely ever ordered for actual engineering."
	cost = PAYCHECK_MEDIUM * 8
	contains = list(/obj/item/clothing/gloves/color/yellow)

/datum/supply_pack/goody/gripper_single
	name = "Gripper Gloves Single-Pack"
	desc = "A spare pair of gripper gloves. Perfect for when the security vendor is empty (or when you're not actually a security officer)."
	cost = PAYCHECK_HARD * 6
	contains = list(/obj/item/clothing/gloves/tackler)

/datum/supply_pack/goody/firstaidbruises_single
	name = "Bruise Treatment Kit Single-Pack"
	desc = "A single brute first-aid kit, perfect for recovering from being crushed in an airlock. Did you know people get crushed in airlocks all the time? Interesting..."
	cost = PAYCHECK_MEDIUM * 4
	contains = list(/obj/item/storage/firstaid/brute)

/datum/supply_pack/goody/firstaidburns_single
	name = "Burn Treatment Kit Single-Pack"
	desc = "A single burn first-aid kit. The advertisement displays a winking atmospheric technician giving a thumbs up, saying \"Mistakes happen!\""
	cost = PAYCHECK_MEDIUM * 4
	contains = list(/obj/item/storage/firstaid/fire)

/datum/supply_pack/goody/firstaid_single
	name = "First Aid Kit Single-Pack"
	desc = "A single first-aid kit, fit for healing most types of bodily harm."
	cost = PAYCHECK_MEDIUM * 3
	contains = list(/obj/item/storage/firstaid/regular)

/datum/supply_pack/goody/firstaidoxygen_single
	name = "Oxygen Deprivation Kit Single-Pack"
	desc = "A single oxygen deprivation first-aid kit, marketed heavily to those with crippling fears of asphyxiation."
	cost = PAYCHECK_MEDIUM * 4
	contains = list(/obj/item/storage/firstaid/o2)

/datum/supply_pack/goody/firstaidtoxins_single
	name = "Toxin Treatment Kit Single-Pack"
	desc = "A single first aid kit focused on healing damage dealt by heavy toxins."
	cost = PAYCHECK_MEDIUM * 4
	contains = list(/obj/item/storage/firstaid/toxin)

/datum/supply_pack/goody/toolbox // mostly just to water down coupon probability
	name = "Mechanical Toolbox"
	desc = "A fully stocked mechanical toolbox, for when you're too lazy to just print them out."
	cost = PAYCHECK_MEDIUM * 3
	contains = list(/obj/item/storage/toolbox/mechanical)

/datum/supply_pack/goody/valentine
	name = "Valentine Card"
	desc = "Make an impression on that special someone! Comes with one valentine card and a free candy heart!"
	cost = PAYCHECK_ASSISTANT * 2
	contains = list(/obj/item/valentine, /obj/item/food/candyheart)

/datum/supply_pack/goody/beeplush
	name = "Bee Plushie"
	desc = "The most important thing you could possibly spend your hard-earned money on."
	cost = PAYCHECK_EASY * 4
	contains = list(/obj/item/toy/plush/beeplushie)

/datum/supply_pack/goody/dyespray
	name = "Hair Dye Spray"
	desc = "A cool spray to dye your hair with awesome colors!"
	cost = PAYCHECK_EASY * 2
	contains = list(/obj/item/dyespray)

/datum/supply_pack/goody/beach_ball
	name = "Beach Ball"
	// uses desc from item
	cost = PAYCHECK_MEDIUM
	contains = list(/obj/item/toy/beach_ball/branded)

/datum/supply_pack/goody/beach_ball/New()
	..()
	var/obj/item/toy/beach_ball/branded/beachball_type = /obj/item/toy/beach_ball/branded
	desc = initial(beachball_type.desc)

/datum/supply_pack/goody/medipen_twopak
	name = "Medipen Two-Pak"
	desc = "Contains one standard epinephrine medipen and one standard emergency first-aid kit medipen. For when you want to prepare for the worst."
	cost = PAYCHECK_MEDIUM * 2
	contains = list(/obj/item/reagent_containers/hypospray/medipen, /obj/item/reagent_containers/hypospray/medipen/ekit)

// Emergency Race Stuff
/datum/supply_pack/goody/airsuppliesnitrogen
	name = "Emergency Air Supplies (Nitrogen)"
	desc = "A vox breathing mask and nitrogen tank."
	cost = PAYCHECK_MEDIUM
	contains = list(
		/obj/item/tank/internals/nitrogen/belt,
		/obj/item/clothing/mask/breath/vox,
	)

/datum/supply_pack/goody/airsuppliesoxygen
	name = "Emergency Air Supplies (Oxygen)"
	desc = "A breathing mask and emergency oxygen tank."
	cost = PAYCHECK_MEDIUM
	contains = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/clothing/mask/breath,
	)

/datum/supply_pack/goody/airsuppliesplasma
	name = "Emergency Air Supplies (Plasma)"
	desc = "A breathing mask and plasmaman plasma tank."
	cost = PAYCHECK_MEDIUM
	contains = list(
		/obj/item/tank/internals/plasmaman/belt,
		/obj/item/clothing/mask/breath,
	)

/datum/supply_pack/goody/boombox
	name = "Boombox"
	desc = "A classic-style boombox! A large set of speakers, your own portable jukebox!"
	cost = PAYCHECK_HARD * 21
	contains = list(
		/obj/item/boombox
	)

// Misc Stuff
/datum/supply_pack/goody/crayons
	name = "Box of Crayons"
	desc = "Colorful!"
	cost = PAYCHECK_MEDIUM * 2
	contains = list(/obj/item/storage/crayons)

/datum/supply_pack/goody/candles
	name = "Candles"
	desc = "Low-tech lighting, perfect for a romantic dinner!"
	cost = PAYCHECK_MEDIUM * 2
	contains = list(/obj/item/storage/fancy/candle_box,
					/obj/item/storage/box/matches)

/datum/supply_pack/goody/diamondring
	name = "Diamond Ring"
	desc = "Show them your love is like a diamond: unbreakable and everlasting. No refunds."
	cost = PAYCHECK_MEDIUM * 50
	contains = list(/obj/item/storage/fancy/ringbox/diamond)

// Carpet Packs
/datum/supply_pack/goody/carpet
	name = "Classic Carpet Pack"
	desc = "Contains a single 50 pack of `Classic` carpet. Reddish-brown in appearance."
	cost = PAYCHECK_MEDIUM * 1.5
	contains = list(/obj/item/stack/tile/carpet/fifty)

/datum/supply_pack/goody/carpet/blue
	name = "Blue Carpet Pack"
	desc = "Contains three different hues of carpet. Blue, Royal Blue, and Cyan. Comes in stacks of 50."
	cost = PAYCHECK_MEDIUM * 3
	contains = list(
		/obj/item/stack/tile/carpet/blue/fifty,
		/obj/item/stack/tile/carpet/royalblue/fifty,
		/obj/item/stack/tile/carpet/cyan/fifty,
	)

/datum/supply_pack/goody/carpet/dark
	name = "Dark Carpet Pack"
	desc = "Contains three different hues of carpet. Black, Royal Black, and Purple. Comes in stacks of 50."
	cost = PAYCHECK_MEDIUM * 3
	contains = list(
		/obj/item/stack/tile/carpet/black/fifty,
		/obj/item/stack/tile/carpet/royalblack/fifty,
		/obj/item/stack/tile/carpet/purple/fifty,
	)

/datum/supply_pack/goody/carpet/light
	name = "Light Carpet Pack"
	cost = PAYCHECK_MEDIUM * 3
	desc = "Contains three different hues of carpet. Red, Green, and Orange. Comes in stacks of 50."
	contains = list(
		/obj/item/stack/tile/carpet/red/fifty,
		/obj/item/stack/tile/carpet/orange/fifty,
		/obj/item/stack/tile/carpet/green/fifty,
	)
