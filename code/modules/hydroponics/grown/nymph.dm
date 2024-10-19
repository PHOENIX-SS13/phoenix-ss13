/obj/item/seeds/nymph
	name = "pack of diona nymph seeds"
	desc = "These seeds grow into diona nymphs."
	icon_state = "seed-replicapod"
	species = "replicapod"
	plantname = "Nymph Pod"
	product = /obj/item/food/grown/nymph_pod
	maturation = 10
	lifespan = 50
	endurance = 8
	production = 1
	yield = 1
	growthstages = 6
	growing_icon = 'icons/obj/hydroponics/growing.dmi'
	icon_grow = "replicapod-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "replicapod-dead" // Same for the dead icon
	reagents_add = list(/datum/reagent/water = 0.4, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/medicine/omnizine = 0.3, /datum/reagent/consumable/nutriment = 0.2, /datum/reagent/liquidgibs = 0.2)

/obj/item/food/grown/nymph_pod
	seed = /obj/item/seeds/nymph
	name = "nymph pod"
	desc = "A peculiar wriggling pod with a grown nymph inside. Crack it open to let the nymph out."
	icon_state = "mushy"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES | GROSS
	tastes = list("screaming grasses" = 2)
	distill_reagent = /datum/reagent/consumable/ethanol/whiskey

/obj/item/food/grown/nymph_pod/attack_self(mob/user)
	new /mob/living/simple_animal/diona(get_turf(user))
	to_chat(user, "<span class='notice'>You crack open [src] letting the nymph out.</span>")
	user.dropItemToGround()
	qdel(src)
