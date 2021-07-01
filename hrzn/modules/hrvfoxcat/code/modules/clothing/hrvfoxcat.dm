/obj/item/clothing/head/helmet/space/chronos/hrvfoxcat
	name = "HRV FoxCat Armor Helmet"
	desc = "An advanced armor that is equipped with a Hyper Reality Visor. Equipped with advanced telemetry tech."
	icon_state = "skiesuit"
	inhand_icon_state = "helmet"
	slowdown = 1
	armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 30, BIO = 90, RAD = 90, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/list/chronosafe_items = list(
		/obj/item/chrono_eraser,
		/obj/item/gun/energy/chrono_gun,
		/obj/item/gun/energy/pulse/pistol/m1911,
		/obj/item/storage/backpack/holding,
	)
	mutant_variants = NONE

/obj/item/clothing/suit/space/chronos/hrvfoxcat
	name = "HRV FoxCat Armor"
	desc = "An advanced spacesuit designed to microtear into different areas using stabilized reality port jumps. Equipped with a light shield for extra protection."
	icon_state = "skiesuit"
	inhand_icon_state = "skiesuit"
	actions_types = list(/datum/action/item_action/toggle_spacesuit, /datum/action/item_action/toggle)
	armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 30, BIO = 90, RAD = 90, FIRE = 100, ACID = 1000)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/space/chronos/hrvfoxcat/Initialize()
	AddComponent(/datum/component/shielded, max_charges = 2, recharge_start_delay = 15 SECONDS, charge_increment_delay = 1 SECONDS, shield_icon = "shield_blue")
	. = ..()
