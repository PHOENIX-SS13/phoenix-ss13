/obj/item/circuitboard/shuttle_comms
	name = "long-range communications circuitboard"

/obj/machinery/shuttle_comms
	name = "comms array"
	desc = "An assortment of radio equipment and accessories designed to facilitate long-range communication and broadcast distress signals when necessary. It is incredibly durable and powers itself internally in order to continue functioning even when the shuttle is disabled somehow."
	icon = 'icons/obj/computer.dmi'
	icon_state = "computer"
	use_power = NO_POWER_USE
	max_integrity = 200
	armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 60, BIO = 60, RAD = 60, FIRE = 60, ACID = 60)
	verb_say = "buzzes"
	verb_yell = ""
