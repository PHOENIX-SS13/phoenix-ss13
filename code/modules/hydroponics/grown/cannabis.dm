// Hemp

/obj/item/seeds/hemp
	name = "pack of hemp seeds"
	desc = "These seeds grow into weed. Or cannabis. Or pot. Or marijuana. The devil's lettuce... Taxable."
	icon_state = "seed-hemp"
	species = "hemp"
	plantname = "Hemp"
	product = /obj/item/food/grown/hemp
	maturation = 12
	yield = 6
	potency = 10
	growthstages = 4
	instability = 40
	growing_icon = 'icons/obj/hydroponics/growing_hemp.dmi'
	//icon_grow = "hemp-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "hemp-dead" // Same for the dead icon
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/hemp/rgb,
						/obj/item/seeds/hemp/death,
						/obj/item/seeds/hemp/life,
						/obj/item/seeds/hemp/omega)
	reagents_add = list(/datum/reagent/drug/tetrahydrocannabinol = 0.15)


/obj/item/seeds/hemp/rgb
	name = "pack of prismatic hemp seeds"
	desc = "These seeds grow into prismatic hemp. Groovy... and also highly addictive."
	icon_state = "seed-hemp_rgb"
	species = "hemp_rgb"
	plantname = "Prismatic Hemp"
	product = /obj/item/food/grown/hemp/rgb
	mutatelist = list()
	reagents_add = list(/datum/reagent/drug/tetrahydrocannabiphorol = 0.07, /datum/reagent/drug/tetrahydrocannabinol = 0.07, /datum/reagent/colorful_reagent = 0.05, /datum/reagent/medicine/psicodine = 0.03, /datum/reagent/drug/happiness = 0.1, /datum/reagent/toxin/mindbreaker = 0.1)
	rarity = 40

/obj/item/seeds/hemp/death
	name = "pack of deathweed seeds"
	desc = "These seeds grow into deathweed. Not groovy."
	icon_state = "seed-hemp_death"
	species = "hemp_death"
	plantname = "Deathweed"
	product = /obj/item/food/grown/hemp/death
	mutatelist = list()
	reagents_add = list(/datum/reagent/toxin/cyanide = 0.35, /datum/reagent/drug/tetrahydrocannabiphorol = 0.2, /datum/reagent/drug/tetrahydrocannabinol = 0.1)
	rarity = 40

/obj/item/seeds/hemp/life
	name = "pack of lifeweed seeds"
	desc = "These seeds grow into lifeweed. I will give unto him that is munchies of the fountain of the cravings of life, freely."
	icon_state = "seed-hemp_life"
	species = "hemp_life"
	plantname = "Lifeweed"
	instability = 30
	product = /obj/item/food/grown/hemp/life
	mutatelist = list()
	reagents_add = list(/datum/reagent/medicine/omnizine = 0.35, /datum/reagent/drug/tetrahydrocannabinol = 0.15)
	rarity = 40


/obj/item/seeds/hemp/omega
	name = "pack of omegaweed seeds"
	desc = "These seeds grow into omegaweed."
	icon_state = "seed-hemp_omega"
	species = "hemp_omega"
	plantname = "Omegaweed"
	product = /obj/item/food/grown/hemp/omega
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/green, /datum/plant_gene/trait/modified_volume/hemp/omega)
	mutatelist = list()
	reagents_add = list(/datum/reagent/drug/tetrahydrocannabinol = 0.3,
						/datum/reagent/toxin/mindbreaker = 0.3,
						/datum/reagent/mercury = 0.15,
						/datum/reagent/lithium = 0.15,
						/datum/reagent/medicine/atropine = 0.15,
						/datum/reagent/drug/methamphetamine = 0.15,
						/datum/reagent/drug/bath_salts = 0.15,
						/datum/reagent/drug/crank = 0.15,
						/datum/reagent/drug/krokodil = 0.15,
						/datum/reagent/toxin/lipolicide = 0.15,
						/datum/reagent/drug/nicotine = 0.1)
	rarity = 69
	graft_gene = /datum/plant_gene/trait/glow/green


// ---------------------------------------------------------------

/obj/item/food/grown/hemp
	seed = /obj/item/seeds/hemp
	name = "hemp leaf"
	desc = "A versatile and ancient crop native to the human homeworld."
	icon_state = "hemp"
	bite_consumption_mod = 4
	foodtypes = VEGETABLES //i dont really know what else weed could be to be honest
	tastes = list("hemp" = 1)
	wine_power = 20

/obj/item/food/grown/hemp/rgb
	seed = /obj/item/seeds/hemp/rgb
	name = "prismatic hemp leaf"
	desc = "It is filled with many pigments which reflect light back at different wavelengths based on angle."
	icon_state = "hemp_rgb"
	wine_power = 60

/obj/item/food/grown/hemp/death
	seed = /obj/item/seeds/hemp/death
	name = "deathweed leaf"
	desc = "Looks a bit dark. Oh well."
	icon_state = "hemp_death"
	wine_power = 40

/obj/item/food/grown/hemp/life
	seed = /obj/item/seeds/hemp/life
	name = "lifeweed leaf"
	desc = "It is nearly bleach-white, save accents of pink like a pale rose."
	icon_state = "hemp_life"
	wine_power = 10

/obj/item/food/grown/hemp/omega
	seed = /obj/item/seeds/hemp/omega
	name = "omegaweed leaf"
	desc = "Its glowing pulse is slightly dizzying. Some claim it is relaxing to look at."
	icon_state = "hemp_omega"
	bite_consumption_mod = 2 // Ingesting like 40 units of drugs in 1 bite at 100 potency
	wine_power = 90
