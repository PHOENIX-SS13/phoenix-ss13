/obj/machinery/vending/modularpc
	name = "\improper Silicate Selections"
	desc = "All the parts you need to build your own custom pc."
	icon_state = "modularpc"
	icon_broken = "modularpc-broken"
	icon_deny = "modularpc-deny"
	icon_off = "modularpc-off"
	icon_panel = "modularpc-panel"
	light_mask = "modular-light-mask"
	product_ads = "Get your gamer gear!;The best GPUs for all of your space-crypto needs!;The most robust cooling!;The finest RGB in space!"
	vend_reply = "Game on!"
	input_display_header = "Silicate Selections"
	products = list(/obj/item/modular_computer/laptop = 4,
					/obj/item/modular_computer/tablet = 4,
					/obj/item/computer_hardware/hard_drive = 4,
					/obj/item/computer_hardware/hard_drive/small = 4,
					/obj/item/computer_hardware/network_card = 8,
					/obj/item/computer_hardware/hard_drive/portable = 8,
					/obj/item/computer_hardware/battery = 8,
					/obj/item/stock_parts/cell/computer = 8,
					/obj/item/computer_hardware/processor_unit = 4,
					/obj/item/computer_hardware/processor_unit/small = 4,
					/obj/item/computer_hardware/sensorpackage = 4)
	premium = list(/obj/item/computer_hardware/card_slot = 2,
		           /obj/item/computer_hardware/ai_slot = 2,
		           /obj/item/computer_hardware/printer/mini = 2,
		           /obj/item/computer_hardware/recharger/apc_recharger = 2,
		           /obj/item/paicard = 2,
				   /obj/item/computer_hardware/radio_card = 1)
	refill_canister = /obj/item/vending_refill/modularpc
	default_price = PAYCHECK_MEDIUM
	extra_price = PAYCHECK_HARD
	payment_department = ACCOUNT_SCI

/obj/item/vending_refill/modularpc
	machine_name = "Silicate Selections"
	icon_state = "refill_engi"
