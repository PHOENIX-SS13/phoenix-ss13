/obj/item/encryptionkey/broadcast
	name = "broadcast encryption key"
	icon_state = "srv_cypherkey"
	channels = list(RADIO_CHANNEL_BROADCAST = 1)

/obj/item/radio/headset/headset_broadcast
	name = "Broadcast Headset"
	desc = "Headset used by radio station staff."
	icon_state = "srv_headset"
	keyslot = new /obj/item/encryptionkey/broadcast

/obj/machinery/telecomms/broadcaster/preset_broadcast
	id = "Broadcast Broadcaster"
	network = "tcommsat"
	autolinkers = list("broadcast")
	freq_listening = list(FREQ_BROADCAST, FREQ_COMMON)

/obj/machinery/telecomms/bus/preset_broadcast
	id = "Bus 3"
	network = "tcommsat"
	freq_listening = list(FREQ_BROADCAST, FREQ_COMMON)
	autolinkers = list("broadcast")

/obj/machinery/telecomms/processor/preset_broadcast
	id = "Processor 3"
	network = "tcommsat"
	autolinkers = list("broadcast")
	freq_listening = list(FREQ_BROADCAST, FREQ_COMMON)

/obj/machinery/telecomms/receiver/preset_broadcast
	id = "Broadcast Receiver"
	network = "tcommsat"
	autolinkers = list("broadcast") // link to relay
	freq_listening = list(FREQ_BROADCAST, FREQ_COMMON)

/obj/machinery/telecomms/relay/preset/broadcast
	id = "Broadcast Relay"
	autolinkers = list("broadcast")
	freq_listening = list(FREQ_BROADCAST, FREQ_COMMON)