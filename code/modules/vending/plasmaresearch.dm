//This one's from bay12
/obj/machinery/vending/plasmaresearch
	/* TODO: MAKE CUSTOM SPRITES!!! leaving these inherited vars here to drive the point home. */
	icon_state = "generic"
	icon_broken = "generic-broken"
	icon_off = "generic-off"
	icon_panel = "generic-panel"
	light_mask = "generic-light-mask"
	name = "\improper Toximate 3000"
	desc = "All the fine parts you need in one vending machine!"
	input_display_header = "Toxinmate 3000"
	products = list(/obj/item/clothing/under/rank/rnd/scientist = 6,
		            /obj/item/clothing/suit/bio_suit = 6,
		            /obj/item/clothing/head/bio_hood = 6,
					/obj/item/transfer_valve = 6,
					/obj/item/assembly/timer = 6,
					/obj/item/assembly/signaler = 6,
					/obj/item/assembly/prox_sensor = 6,
					/obj/item/assembly/igniter = 6)
	contraband = list(/obj/item/assembly/health = 3)
	default_price = PAYCHECK_ASSISTANT
	extra_price = PAYCHECK_ASSISTANT
	payment_department = ACCOUNT_SCI
