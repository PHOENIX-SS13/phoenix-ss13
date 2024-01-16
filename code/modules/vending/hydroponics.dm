/obj/machinery/vending/hydronutrients
	name = "\improper NutriMax"
	desc = "A plant nutrients vendor."
	product_slogans = "Aren't you glad you don't have to fertilize the natural way?;Now with 50% less stink!;Plants are people too!"
	product_ads = "We like plants!;Don't you want some?;The greenest thumbs ever.;We like big plants.;Soft soil..."
	icon_state = "hydronutrients"
	icon_broken = "snack-broken"
	icon_deny = "snack-deny"
	icon_off = "snack-off"
	icon_panel = "snack-panel"
	light_mask = "snack-light-mask"
	input_display_header = "Nutrimax Max Nutrients Selection"
	products = list(/obj/item/reagent_containers/glass/bottle/nutrient/ez = 30,
					/obj/item/reagent_containers/glass/bottle/nutrient/l4z = 20,
					/obj/item/reagent_containers/glass/bottle/nutrient/rh = 10,
					/obj/item/reagent_containers/spray/pestspray = 20,
					/obj/item/reagent_containers/syringe = 5,
					/obj/item/storage/bag/plants = 5,
					/obj/item/cultivator = 3,
					/obj/item/shovel/spade = 3,
					/obj/item/secateurs = 3,
					/obj/item/plant_analyzer = 4)
	contraband = list(/obj/item/reagent_containers/glass/bottle/ammonia = 10,
					  /obj/item/reagent_containers/glass/bottle/diethylamine = 5)
	refill_canister = /obj/item/vending_refill/hydronutrients
	default_price = PAYCHECK_ASSISTANT * 0.8
	extra_price = PAYCHECK_HARD * 0.8
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/hydronutrients
	machine_name = "NutriMax"
	icon_state = "refill_plant"

/obj/machinery/vending/hydroseeds
	name = "\improper MegaSeed Servitor"
	desc = "When you need seeds fast!"
	product_slogans = "THIS'S WHERE TH' SEEDS LIVE! GIT YOU SOME!;Hands down the best seed selection on the station!;Also certain mushroom varieties available, more for experts! Get certified today!"
	product_ads = "We like plants!;Grow some crops!;Grow, baby, growww!;Aw h'yeah son!"
	icon_state = "hydroseeds"
	icon_broken = "hydroseeds-broken"
	icon_deny = "hydroseeds-deny"
	icon_off = "hydroseeds-off"
	icon_panel = "hydroseeds-panel"
	light_mask = "hydroseeds-light-mask"
	products = list(/obj/item/seeds/aloe = 3,
					/obj/item/seeds/ambrosia = 3,
					/obj/item/seeds/apple = 3,
					/obj/item/seeds/banana = 3,
					/obj/item/seeds/berry = 3,
					/obj/item/seeds/cabbage = 3,
					/obj/item/seeds/carrot = 3,
					/obj/item/seeds/cherry = 3,
					/obj/item/seeds/chanter = 3,
					/obj/item/seeds/chili = 3,
					/obj/item/seeds/cocoapod = 3,
					/obj/item/seeds/coffee = 3,
					/obj/item/seeds/cotton = 3,
					/obj/item/seeds/corn = 3,
					/obj/item/seeds/eggplant = 3,
					/obj/item/seeds/garlic = 3,
					/obj/item/seeds/grape = 3,
					/obj/item/seeds/grass = 3,
					/obj/item/seeds/korta_nut = 3,
					/obj/item/seeds/lemon = 3,
					/obj/item/seeds/lime = 3,
					/obj/item/seeds/onion = 3,
					/obj/item/seeds/orange = 3,
					/obj/item/seeds/peas = 3,
					/obj/item/seeds/pineapple = 3,
					/obj/item/seeds/potato = 3,
					/obj/item/seeds/poppy = 3,
					/obj/item/seeds/pumpkin = 3,
					/obj/item/seeds/wheat/rice = 3,
					/obj/item/seeds/rose = 3,
					/obj/item/seeds/soya = 3,
					/obj/item/seeds/sugarcane = 3,
					/obj/item/seeds/sunflower = 3,
					/obj/item/seeds/tea = 3,
					/obj/item/seeds/tobacco = 3,
					/obj/item/seeds/tomato = 3,
					/obj/item/seeds/tower = 3,
					/obj/item/seeds/watermelon = 3,
					/obj/item/seeds/wheat = 3,
					/obj/item/seeds/whitebeet = 3)
	contraband = list(/obj/item/seeds/amanita = 2,
					/obj/item/seeds/glowshroom = 2,
					/obj/item/seeds/liberty = 2,
					/obj/item/seeds/nettle = 2,
					/obj/item/seeds/plump = 2,
					/obj/item/seeds/reishi = 2,
					/obj/item/seeds/cannabis = 3,
					/obj/item/seeds/starthistle = 2,
					/obj/item/seeds/random = 2)
	premium = list(/obj/item/reagent_containers/spray/waterflower = 1)
	refill_canister = /obj/item/vending_refill/hydroseeds
	default_price = PAYCHECK_PRISONER
	extra_price = PAYCHECK_ASSISTANT
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/hydroseeds
	machine_name = "MegaSeed Servitor"
	icon_state = "refill_plant"
