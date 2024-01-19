/obj/machinery/vending/liberationstation
	name = "\improper Liberation Station"
	desc = "An overwhelming amount of <b>ancient patriotism</b> washes over you just by looking at the machine."
	icon_state = "liberationstation"
	icon_broken = "liberationstation-broken"
	icon_deny = "liberationstation-deny"
	icon_off = "liberationstation-off"
	icon_panel = "liberationstation-panel"
	light_mask = "liberationstation-light-mask"
	product_slogans = "Liberation Station: Your one-stop shop for all things second amendment!;YOU are the well-regulated militia.;Be a patriot today, pick up a gun!;Quality weapons for cheap prices!;Better dead than red!"
	product_ads = "A well regulated Militia, being necessary to the security of a free State, the right of the people to keep and bear Arms, shall not be infringed.;Float like an astronaut, sting like an Enola!!;Patriotism!;Express your second amendment today!;Guns don't kill people, but you can!;Who needs responsibilities when you have guns?;Bear arms!;Keep arms!"
	vend_reply = "Remember the name: Liberation Station!"
	input_display_header = "Liberty!!!"
	product_categories = list(
		list(
			"name" = "Backyard Grill",
			"products" = list(
				/obj/item/food/burger/plain = 10, //O say can you see, by the dawn's early light
				/obj/item/food/burger/baseball = 7, //What so proudly we hailed at the twilight's last gleaming
				/obj/item/food/burger/baconburger = 5, // this is america, land of EQUALITY. there are no PREMIUM burgers!!!
				/obj/item/food/burger/superbite = 3,
				/obj/item/food/fries = 10, //Whose broad stripes and bright stars through the perilous fight
				/obj/item/food/cheesyfries = 5,
				/obj/item/reagent_containers/food/drinks/beer/light = 10 //O'er the ramparts we watched, were so gallantly streaming?
			),
		),
		list(
			"name" = "Pieces",
			"products" = list(
				/obj/item/gun/ballistic/automatic/pistol = 4,
				/obj/item/gun/ballistic/automatic/pistol/aps = 1,
				/obj/item/gun/ballistic/automatic/pistol/m1911 = 3,
				/obj/item/gun/ballistic/automatic/pistol/deagle = 2,
		        /obj/item/gun/ballistic/automatic/pistol/deagle/camo = 2,
		        /obj/item/gun/ballistic/automatic/pistol/deagle/gold = 1,
			),
		),
		list(
			"name" = "Freedom Winners",
			"products" = list(
				/obj/item/gun/ballistic/automatic/ar = 2,
				/obj/item/gun/ballistic/automatic/l6_saw/unrestricted = 1,
				/obj/item/gun/ballistic/shotgun = 2,
				/obj/item/gun/ballistic/shotgun/automatic/combat = 2
			),
		),
		list(
			"name" = "Special Issue",
			"products" = list(
				/obj/item/gun/ballistic/automatic/proto/unrestricted = 2,
				/obj/item/gun/ballistic/automatic/gyropistol = 1,
			),
		),
		list(
			"name" = "Gift Shop",
			"products" = list(
				/obj/item/clothing/under/misc/patriotsuit = 3,
		    	/obj/item/bedsheet/patriot = 5  //U S A
			),
		),
	)
	premium = list(/obj/item/ammo_box/magazine/m9mm = 4,
		           /obj/item/ammo_box/magazine/smgm9mm = 2,
		           /obj/item/ammo_box/magazine/m50 = 4,
		           /obj/item/ammo_box/magazine/m45 = 2,
		           /obj/item/ammo_box/magazine/m75 = 2,
		           /obj/item/ammo_box/magazine/mm712x82 = 2
				   )
	contraband = list(/obj/item/gun/ballistic/automatic/pistol/stickman = 2
					  )
	armor = list(MELEE = 100, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 50)
	resistance_flags = FIRE_PROOF
	default_price = PAYCHECK_HARD * 2.5
	extra_price = PAYCHECK_COMMAND * 2.5
	payment_department = ACCOUNT_SEC
