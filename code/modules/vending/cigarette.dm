/obj/machinery/vending/cigarette
	name = "\improper ShadyCigs Deluxe"
	desc = "If you want to get cancer, might as well do it in style."
	product_slogans = "Space cigs taste good like a cigarette should.;I'd rather toolbox than switch.;Smoke!;Don't believe the reports - smoke today!"
	product_ads = "Probably not bad for you!;Don't believe the scientists!;It's good for you!;Don't quit, buy more!;Smoke!;Nicotine heaven.;Best cigarettes since 2150.;Award-winning cigs."
	icon_state = "cigs"
	icon_broken = "cigs-broken"
	icon_off = "cigs-off"
	icon_panel = "cigs-panel"
	light_mask = "cigs-light-mask"
	products = list(/obj/item/lighter/greyscale = 4,
					/obj/item/storage/fancy/cigarettes = 5,
					/obj/item/storage/fancy/cigarettes/cigpack_candy = 4,
					/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_robust = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_midori = 3,
					/obj/item/storage/box/matches = 10,
					/obj/item/storage/box/matches/matchbook = 5)
	contraband = list(/obj/item/clothing/mask/vape = 5,
					  /obj/item/storage/fancy/cigarettes/cigpack_robustgold = 3,
					  /obj/item/storage/fancy/cigarettes/cigpack_syndicate = 2)
	premium = list(
				   /obj/item/lighter = 3,
				   /obj/item/storage/fancy/cig_carton = 2,
				   /obj/item/storage/fancy/cig_carton/dromedary = 2,
				   /obj/item/storage/fancy/cig_carton/uplift = 2,
				   /obj/item/storage/fancy/cig_carton/carp = 2,
				   /obj/item/storage/box/gum/nicotine = 2,
				   /obj/item/storage/fancy/rollingpapers = 5,
		           /obj/item/storage/fancy/cigarettes/cigars = 1,
		           /obj/item/storage/fancy/cigarettes/cigars/havana = 1,
		           /obj/item/storage/fancy/cigarettes/cigars/cohiba = 1)
	refill_canister = /obj/item/vending_refill/cigarette
	default_price = PAYCHECK_ASSISTANT
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/cigarette
	machine_name = "ShadyCigs Deluxe"
	icon_state = "refill_smoke"

/obj/machinery/vending/cigarette/pre_throw(obj/item/I)
	if(istype(I, /obj/item/lighter))
		var/obj/item/lighter/L = I
		L.set_lit(TRUE)

/obj/machinery/vending/cigarette/beach //Used in the lavaland_biodome_beach.dmm ruin
	name = "\improper ShadyCigs Ultra"
	desc = "Now with extra premium products!"
	product_ads = "Probably not bad for you!;Dope will get you through times of no money better than money will get you through times of no dope!;It's good for you!"
	product_slogans = "Turn on, tune in, drop out!;Better living through chemistry!;Toke!;Don't forget to keep a smile on your lips and a song in your heart!"
	products = list(/obj/item/storage/fancy/cigarettes = 5,
					/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_robust = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_midori = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_cannabis = 5,
					/obj/item/storage/box/matches = 10,
					/obj/item/lighter/greyscale = 4,
					/obj/item/storage/fancy/rollingpapers = 5)
	premium = list(/obj/item/storage/fancy/cigarettes/cigpack_mindbreaker = 5,
				   /obj/item/clothing/mask/vape = 5,
				   /obj/item/lighter = 3,
				   /obj/item/storage/fancy/cigarettes/cigpack_robustgold = 3,
				   /obj/item/storage/box/gum/nicotine = 2,
				   /obj/item/lighter = 3,
		           /obj/item/storage/fancy/cigarettes/cigars = 1,
		           /obj/item/storage/fancy/cigarettes/cigars/havana = 1,
		           /obj/item/storage/fancy/cigarettes/cigars/cohiba = 1)



/obj/machinery/vending/cigarette/syndicate
	name = "\improper SusSmokes"
	desc = "A suspiciously well-stocked cigarette machine. Wow! It even has the limited edition series! Where did they get those?"
	product_slogans = "Brigged for elegant taste.;Smoke!;Light with your esword today!;Omnizine filter cigarettes! Certified healthy by 3 out of 7 Interdyne pharmacists!"
	product_ads = "Smoke!;Nicotine heaven.;Serious cigs for serious spacemen.;Don't buy that NT propaganda! Smoke today!"
	icon_state = "sussmokes"
	icon_broken = "sussmokes-broken"
	icon_off = "sussmokes-off"
	icon_panel = "sussmokes-panel"
	light_color = COLOR_VERY_PALE_LIME_GREEN
	products = list(/obj/item/lighter = 2,
					/obj/item/lighter/greyscale = 4,
					/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 7,
					/obj/item/storage/fancy/cigarettes/cigpack_uplift = 4,
					/obj/item/storage/fancy/cigarettes/cigpack_candy = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_robust = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_carp = 4,
					/obj/item/storage/fancy/cigarettes/cigpack_midori = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_robustgold = 2,
		            /obj/item/storage/fancy/cigarettes/cigars = 1,
		            /obj/item/storage/fancy/cigarettes/cigars/havana = 1,
		            /obj/item/storage/fancy/cigarettes/cigars/cohiba = 1,
		            /obj/item/storage/box/gum/nicotine = 2,
		            /obj/item/storage/fancy/rollingpapers = 5,
		            /obj/item/storage/box/matches = 10,
					/obj/item/storage/box/matches/matchbook = 5)
	contraband = list(/obj/item/clothing/mask/vape = 5)
	premium = list(/obj/item/storage/fancy/cig_carton = 1,
				   /obj/item/storage/fancy/cig_carton/dromedary = 1,
				   /obj/item/storage/fancy/cig_carton/uplift = 1,
				   /obj/item/storage/fancy/cig_carton/carp = 1)
	default_price = PAYCHECK_PRISONER
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES
