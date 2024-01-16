/obj/machinery/vending/snack
	name = "\improper Getmore Chocolate Corp. Vendor"
	desc = "A snack machine courtesy of the Getmore Chocolate Corporation, based out of Mars."
	product_slogans = "~Go get more Getmore~!"
	product_ads = "Honkers! Get 'em Cheesy!;GetMore brand ramen? Yum yum!;Space Twinkies!!!;Award-winning chocolate bars!;Mmm! So good!;Oh my god it's so juicy!;Have a snack.;~Go get more Getmore~!;Have some more Getmore!;Best quality snacks straight from Mars.;We love chocolate!;Try our jerky!;Try our nougat bar!;Twice the calories for half the price!"
	icon_state = "snack"
	icon_broken = "snack-broken"
	icon_deny = "snack-deny"
	icon_off = "snack-off"
	icon_panel = "snack-panel"
	light_mask = "snack-light-mask"
	products = list(
		/obj/item/food/spacetwinkie = 6,
		/obj/item/food/cheesiehonkers = 6,
		/obj/item/food/candy = 6,
		/obj/item/food/chips = 6,
		/obj/item/food/sosjerky = 6,
		/obj/item/food/no_raisin = 6,
		/obj/item/food/peanuts = 6,
		/obj/item/food/peanuts/random = 3,
		/obj/item/food/cnds = 6,
		/obj/item/food/cnds/random = 3,
		/obj/item/reagent_containers/food/drinks/dry_ramen = 3,
		/obj/item/storage/box/gum = 3,
		/obj/item/food/energybar = 6)
	contraband = list(
		/obj/item/food/syndicake = 6,
		/obj/item/food/candy/bronx = 1)
	refill_canister = /obj/item/vending_refill/snack
	canload_access_list = list(ACCESS_KITCHEN)
	default_price = PAYCHECK_ASSISTANT * 0.6
	extra_price = PAYCHECK_EASY
	payment_department = ACCOUNT_SRV
	input_display_header = "Snacks, by GetMore"

/obj/item/vending_refill/snack
	machine_name = "Getmore Chocolate Corp. Vendor"

/obj/machinery/vending/snack/blue
	icon_state = "snackblue"

/obj/machinery/vending/snack/orange
	icon_state = "snackorange"

/obj/machinery/vending/snack/green
	icon_state = "snackgreen"

/obj/machinery/vending/snack/olive
	icon_state = "snackolive"

/obj/machinery/vending/snack/yellow
	icon_state = "snackyellow"

/obj/machinery/vending/snack/teal
	icon_state = "snackteal"

/obj/machinery/vending/snack/black
	icon_state = "snackblack"
