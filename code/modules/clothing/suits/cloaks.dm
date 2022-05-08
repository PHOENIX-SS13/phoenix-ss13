//Cloaks. No, not THAT kind of cloak.

/obj/item/clothing/neck/cloak
	name = "brown cloak"
	desc = "It's a cape that can be worn around your neck."
	icon = 'icons/obj/clothing/cloaks.dmi'
	icon_state = "qmcloak"
	inhand_icon_state = "qmcloak"
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESUITSTORAGE
	worn_template_bodytypes = BODYTYPE_TESHARI
	greyscale_config_worn_template = /datum/greyscale_config/worn_template_two_tone_cloak
	worn_template_greyscale_color = "#AAAAAA#AAAAAA"

/obj/item/clothing/neck/cloak/suicide_act(mob/user)
	user.visible_message(SPAN_SUICIDE("[user] is strangling [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return(OXYLOSS)

/obj/item/clothing/neck/cloak/hos
	name = "head of security's cloak"
	desc = "Worn by Securistan, ruling the station with an iron fist."
	icon_state = "hoscloak"
	worn_template_greyscale_color = "#3B3B3B#8D001B"

/obj/item/clothing/neck/cloak/qm
	name = "quartermaster's cloak"
	desc = "Worn by Cargonia, supplying the station with the necessary tools for survival."
	worn_template_greyscale_color = "#4D381A#B1C00B"

/obj/item/clothing/neck/cloak/cmo
	name = "chief medical officer's cloak"
	desc = "Worn by Meditopia, the valiant men and women keeping pestilence at bay."
	icon_state = "cmocloak"
	worn_template_greyscale_color = "#154B58#154B58"

/obj/item/clothing/neck/cloak/ce
	name = "chief engineer's cloak"
	desc = "Worn by Engitopia, wielders of an unlimited power."
	icon_state = "cecloak"
	resistance_flags = FIRE_PROOF
	worn_template_greyscale_color = "#504C02#CC6F00"

/obj/item/clothing/neck/cloak/rd
	name = "research director's cloak"
	desc = "Worn by Sciencia, thaumaturges and researchers of the universe."
	icon_state = "rdcloak"
	worn_template_greyscale_color = "#E9E9E9#5D0175"

/obj/item/clothing/neck/cloak/cap
	name = "captain's cloak"
	desc = "Worn by the commander of Space Station 13."
	icon_state = "capcloak"
	worn_template_greyscale_color = "#234254#9B9915"

/obj/item/clothing/neck/cloak/hop
	name = "head of personnel's cloak"
	desc = "Worn by the Head of Personnel. It smells faintly of bureaucracy."
	icon_state = "hopcloak"
	worn_template_greyscale_color = "#006086#C4B435"

/obj/item/clothing/suit/hooded/cloak/goliath
	name = "goliath cloak"
	icon_state = "goliath_cloak"
	desc = "A staunch, practical cape made out of numerous monster materials, it is coveted amongst exiles & hermits."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/pickaxe, /obj/item/spear, /obj/item/organ/regenerative_core/legion, /obj/item/kitchen/knife/combat/bone, /obj/item/kitchen/knife/combat/survival)
	armor = list(MELEE = 35, BULLET = 10, LASER = 25, ENERGY = 35, BOMB = 25, BIO = 0, RAD = 0, FIRE = 60, ACID = 60) //a fair alternative to bone armor, requiring alternative materials and gaining a suit slot
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/head/hooded/cloakhood/goliath
	name = "goliath cloak hood"
	icon_state = "golhood"
	desc = "A protective & concealing hood."
	armor = list(MELEE = 35, BULLET = 10, LASER = 25, ENERGY = 35, BOMB = 25, BIO = 0, RAD = 0, FIRE = 60, ACID = 60)
	clothing_flags = SNUG_FIT
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	transparent_protection = HIDEMASK

/obj/item/clothing/suit/hooded/cloak/drake
	name = "drake armour"
	icon_state = "dragon"
	desc = "A suit of armour fashioned from the remains of an ash drake."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/spear)
	armor = list(MELEE = 70, BULLET = 30, LASER = 50, ENERGY = 50, BOMB = 70, BIO = 60, RAD = 50, FIRE = 100, ACID = 100)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/drake
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	transparent_protection = HIDEGLOVES|HIDESUITSTORAGE|HIDEJUMPSUIT|HIDESHOES

/obj/item/clothing/head/hooded/cloakhood/drake
	name = "drake helm"
	icon_state = "dragon"
	desc = "The skull of a dragon."
	armor = list(MELEE = 70, BULLET = 30, LASER = 50, ENERGY = 50, BOMB = 70, BIO = 60, RAD = 50, FIRE = 100, ACID = 100)
	clothing_flags = SNUG_FIT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/hooded/cloak/godslayer
	name = "godslayer armour"
	icon_state = "godslayer"
	desc = "A suit of armour fashioned from the remnants of a knight's armor, and parts of a wendigo."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/spear)
	armor = list("melee" = 50, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 50, "rad" = 100, "fire" = 100, "acid" = 100)
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/godslayer
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF | FREEZE_PROOF
	transparent_protection = HIDEGLOVES|HIDESUITSTORAGE|HIDEJUMPSUIT|HIDESHOES
	/// Amount to heal when the effect is triggered
	var/heal_amount = 500
	/// Time until the effect can take place again
	var/effect_cooldown_time = 10 MINUTES
	/// Current cooldown for the effect
	COOLDOWN_DECLARE(effect_cooldown)
	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY)

/obj/item/clothing/head/hooded/cloakhood/godslayer
	name = "godslayer helm"
	icon_state = "godslayer"
	desc = "The horns and skull of a wendigo, held together by the remaining icey energy of a demonic miner."
	armor = list("melee" = 50, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 50, "rad" = 100, "fire" = 100, "acid" = 100)
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	flash_protect = FLASH_PROTECTION_WELDER
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	resistance_flags = FIRE_PROOF | ACID_PROOF | FREEZE_PROOF
	fitted_bodytypes = NONE

/obj/item/clothing/suit/hooded/cloak/godslayer/examine(mob/user)
	. = ..()
	if(loc == user && !COOLDOWN_FINISHED(src, effect_cooldown))
		. += "You feel like the revival effect will be able to occur again in [COOLDOWN_TIMELEFT(src, effect_cooldown) / 10] seconds."

/obj/item/clothing/suit/hooded/cloak/godslayer/equipped(mob/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_OCLOTHING)
		RegisterSignal(user, COMSIG_MOB_STATCHANGE, .proc/resurrect)
		return
	UnregisterSignal(user, COMSIG_MOB_STATCHANGE)

/obj/item/clothing/suit/hooded/cloak/godslayer/dropped(mob/user)
	..()
	UnregisterSignal(user, COMSIG_MOB_STATCHANGE)

/obj/item/clothing/suit/hooded/cloak/godslayer/proc/resurrect(mob/living/carbon/user, new_stat)
	SIGNAL_HANDLER
	if(new_stat > CONSCIOUS && new_stat < DEAD && COOLDOWN_FINISHED(src, effect_cooldown))
		user.heal_ordered_damage(heal_amount, damage_heal_order)
		user.visible_message(SPAN_NOTICE("[user] suddenly revives, as their armor swirls with demonic energy!"), SPAN_NOTICE("You suddenly feel invigorated!"))
		playsound(user.loc, 'sound/magic/clockwork/ratvar_attack.ogg', 50)
		COOLDOWN_START(src, effect_cooldown, effect_cooldown_time)
