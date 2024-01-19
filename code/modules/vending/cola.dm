
/obj/machinery/vending/cola
	name = "\improper Robust Softdrinks Vendor"
	desc = "A softdrink vendor provided by Robust Industries, LLC."
	icon_state = "cola"
	icon_broken = "cola-broken"
	icon_deny = "cola-deny"
	icon_off = "cola-off"
	icon_panel = "cola-panel"
	icon_vend = "cola-vend"
	light_mask = "cola-light-mask"
	product_slogans = "Robust Softdrinks: More robust than a toolbox to the head!"
	product_ads = "Refreshing!;Hope you're thirsty!;Over 1 megatrillion drinks sold!;Thirsty? Why not soft drink?;Please, have a soft drink!;Drink up!;The best drinks in space."
	input_display_header = "Robust Softdrinks"
	products = list(/obj/item/reagent_containers/food/drinks/soda_cans/lemon_lime = 25,
					/obj/item/reagent_containers/food/drinks/soda_cans/cola = 20,
		            /obj/item/reagent_containers/food/drinks/soda_cans/space_mountain_wind = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/space_up = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/pwr_game = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/lubricola = 20,
					/obj/item/reagent_containers/food/drinks/waterbottle = 10,
					/obj/item/reagent_containers/food/drinks/bottle/mushi_kombucha = 3)
	contraband = list(/obj/item/reagent_containers/food/drinks/soda_cans/bepis = 6,
		              /obj/item/reagent_containers/food/drinks/soda_cans/shamblers = 6)
	premium = list(/obj/item/reagent_containers/food/drinks/soda_cans/monkey_energy = 10,
		           /obj/item/reagent_containers/food/drinks/drinkingglass/filled/nuka_cola = 10)
	refill_canister = /obj/item/vending_refill/cola
	default_price = PAYCHECK_ASSISTANT * 0.7
	extra_price = PAYCHECK_MEDIUM
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/cola
	machine_name = "Robust Softdrinks Vendor"
	icon_state = "refill_cola"

/obj/machinery/vending/cola/blue
	light_color = COLOR_MODERATE_BLUE

/obj/machinery/vending/cola/black
	icon_state = "cola_black"
	icon_broken = "cola_black-broken"
	icon_off = "cola_black-off"

/obj/machinery/vending/cola/red
	icon_state = "cola_red"
	icon_broken = "cola_red-broken"
	icon_off = "cola_red-off"
	light_mask = "cola_red-light-mask"
	light_color = COLOR_DARK_RED
	name = "\improper Space Cola Vendor"
	desc = "It vends cola, in space."
	product_slogans = "Cola in space!"
	input_display_header = "Space Cola"
	products = list(/obj/item/reagent_containers/food/drinks/soda_cans/cola = 25,
		            /obj/item/reagent_containers/food/drinks/soda_cans/space_mountain_wind = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/space_up = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/pwr_game = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/lemon_lime = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/lubricola = 20,
					/obj/item/reagent_containers/food/drinks/waterbottle = 10,
					/obj/item/reagent_containers/food/drinks/bottle/mushi_kombucha = 3)

/obj/machinery/vending/cola/space_up
	icon_state = "space_up"
	icon_broken = "space_up-broken"
	icon_off = "space_up-off"
	light_mask = "space_up-light-mask"
	light_color = COLOR_DARK_MODERATE_LIME_GREEN
	name = "\improper Space-up! Vendor"
	desc = "Indulge in an explosion of flavor."
	product_slogans = "Space-up! Like a hull breach in your mouth."
	input_display_header = "Space-up!"
	products = list(/obj/item/reagent_containers/food/drinks/soda_cans/space_up = 25,
					/obj/item/reagent_containers/food/drinks/soda_cans/cola = 20,
		            /obj/item/reagent_containers/food/drinks/soda_cans/space_mountain_wind = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/pwr_game = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/lemon_lime = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/lubricola = 20,
					/obj/item/reagent_containers/food/drinks/waterbottle = 10,
					/obj/item/reagent_containers/food/drinks/bottle/mushi_kombucha = 3)

/obj/machinery/vending/cola/pwr_game
	icon_state = "pwr_game"
	icon_broken = "pwr_game-broken"
	icon_off = "pwr_game-off"
	light_mask = "pwr_game-light-mask"
	light_color = COLOR_STRONG_VIOLET
	name = "\improper PWR Game Vendor"
	desc = "You want it, we got it. Brought to you in partnership with Space Cola."
	product_slogans = "The POWER that gamers crave! PWR GAME!"
	product_ads = "You want it, we got it.;Brought to you in partnership with Space Cola.;Parched? Power up with PWR GAME!;Drink, NOW!!!;POWER UP! LET'S GOOOOOOOOOOOOOOOOO-;Not the cause of long term heart damage!"
	input_display_header = "PWR Game"
	products = list(/obj/item/reagent_containers/food/drinks/soda_cans/pwr_game = 25,
					/obj/item/reagent_containers/food/drinks/soda_cans/cola = 20,
		            /obj/item/reagent_containers/food/drinks/soda_cans/space_mountain_wind = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/space_up = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/lemon_lime = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/lubricola = 20,
					/obj/item/reagent_containers/food/drinks/waterbottle = 10,
					/obj/item/reagent_containers/food/drinks/bottle/mushi_kombucha = 3)

/obj/machinery/vending/cola/bepis
	icon_state = "bepis"
	icon_broken = "bepis-broken"
	icon_off = "bepis-off"
	icon_panel = "bepis-panel"
	icon_vend = "bepis-vend"
	light_mask = "bepis-light-mask"
	light_color = COLOR_MODERATE_BLUE
	name = "\improper Bepis Co. Vendor"
	desc = "A softdrink vendor provided by Bepis Co."
	product_slogans = "Bepis: The tastier soft drink!"
	product_ads = "Try it with Space Costco pizza!;Hope you're thirsty!;Over 1 jigamillion drinks sold!;Thirsty? Bepis.;Humanity's drink!;By humans, for everyone!!!;Bottoms up!;Better than Conke!"
	vend_reply = "Enjoy!"
	input_display_header = "Bepis"
	products = list(/obj/item/reagent_containers/food/drinks/soda_cans/bepis = 25,
					/obj/item/reagent_containers/food/drinks/soda_cans/dr_gibb = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/starkist = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/sol_dry = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/welding_fizz = 20,
					/obj/item/reagent_containers/food/drinks/waterbottle = 10,
					/obj/item/reagent_containers/food/drinks/bottle/mushi_kombucha = 3)
	contraband = list(/obj/item/reagent_containers/food/drinks/soda_cans/cola = 6,
		              /obj/item/reagent_containers/food/drinks/soda_cans/shamblers = 6)
	premium = list(/obj/item/reagent_containers/food/drinks/soda_cans/grey_bull = 10,
		           /obj/item/reagent_containers/food/drinks/soda_cans/thirteenloko = 10,
		           /obj/item/reagent_containers/food/drinks/soda_cans/air = 10)

/obj/machinery/vending/cola/bepis/dr_gibb
	icon_state = "drgibb"
	light_color = COLOR_WHITE
	name = "\improper Dr. Gibb Vendor"
	product_slogans = "Doctor Gibb: You'll be back for more!;Dr. Gibb by Bepis Co.!"
	product_ads = "Doctor Gibb!;Quench your thirst!;Cherrylicious!;Get Gibbed!;Dr. Gibb: A recipe so clean, it's never had a controversy. Lately.;Sip your gibb!;Best root drinks in the sector!"
	input_display_header = "Dr. Gibb, by Bepis Co."
	products = list(/obj/item/reagent_containers/food/drinks/soda_cans/dr_gibb = 25,
					/obj/item/reagent_containers/food/drinks/soda_cans/bepis = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/starkist = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/sol_dry = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/welding_fizz = 20,
					/obj/item/reagent_containers/food/drinks/waterbottle = 10,
					/obj/item/reagent_containers/food/drinks/bottle/mushi_kombucha = 3)

/obj/machinery/vending/cola/bepis/starkist
	icon_state = "starkist"
	light_color = COLOR_LIGHT_ORANGE
	name = "\improper Star-kist Vendor"
	product_slogans = "Starkist: Feel the heat, have a Starkist!;Starkist by Bepis Co.!"
	product_ads = "Drink the stars! Star-kist!;Starkist!;The taste of a star in liquid form.;Tangy!"
	input_display_header = "Starkist, by Bepis Co."
	products = list(/obj/item/reagent_containers/food/drinks/soda_cans/starkist = 25,
					/obj/item/reagent_containers/food/drinks/soda_cans/bepis = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/dr_gibb = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/starkist = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/sol_dry = 20,
					/obj/item/reagent_containers/food/drinks/soda_cans/welding_fizz = 20,
					/obj/item/reagent_containers/food/drinks/waterbottle = 10,
					/obj/item/reagent_containers/food/drinks/bottle/mushi_kombucha = 3)

/obj/machinery/vending/cola/shamblers
	name = "\improper Shambler's Juice Vendor"
	desc = "You either love, or hate, their jingle. There is no middleground."
	icon_state = "shamblers_juice"
	icon_broken = "shamblers_juice-broken"
	icon_off = "shamblers_juice-off"
	light_mask = "shamblers_juice-light-mask"
	light_color = COLOR_MOSTLY_PURE_PINK
	product_slogans = "~Shake me up some of that Shambler's Juice~!"
	product_ads = "Refreshing!;Jyrbv dv lg jfdv fw kyrk Jyrdscvi'j Alztv!;Over 1 trillion cans drank!;Over 1 trillion souls drank!;Thirsty? Nyp efk uizeb kyv uribevjj?;Kyv Jyrdscvi uizebj kyv ezxyk!;Drink up!;Krjkp."
	vend_reply = "~Shake me up some of that Shambler's Juice~!"
	input_display_header = "Shambler's"
	products = list(/obj/item/reagent_containers/food/drinks/soda_cans/shamblers = 100)
	contraband = list(/obj/item/reagent_containers/food/drinks/soda_cans/bepis = 6,
		              /obj/item/reagent_containers/food/drinks/soda_cans/cola = 6)
	premium = list(/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 10)
