/datum/component/radio
	var/frequency = FREQ_COMMON
	var/broadcasting = FALSE
	var/listening = TRUE
	var/independent = TRUE
	var/canhear_range = 3

/datum/component/radio/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_HEAR, PROC_REF(handle_hear))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_CLICK_ALT, PROC_REF(toggle_broadcasting))
	RegisterSignal(parent, COMSIG_CLICK_ALT_SECONDARY, PROC_REF(toggle_listening))
	RegisterSignal(parent, COMSIG_OBJ_RECEIVE_SIGNAL, PROC_REF(receive_signal))

/datum/component/radio/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOVABLE_HEAR)
	UnregisterSignal(parent, COMSIG_PARENT_EXAMINE)
	UnregisterSignal(parent, COMSIG_CLICK_ALT)
	UnregisterSignal(parent, COMSIG_CLICK_ALT_SECONDARY)
	UnregisterSignal(parent, COMSIG_OBJ_RECEIVE_SIGNAL)

/datum/component/radio/Initialize(freq)
	frequency = freq
	//adds to global list
	add_radio_component(src, frequency)
	//adds to frequency's list of listeners
	SSradio.add_object(parent, frequency)


/datum/component/radio/Destroy()
	//adds to global list
	remove_radio_component(src, frequency)
	//adds to frequency's list of listeners
	SSradio.remove_object(parent, frequency)
	return ..()

/datum/component/radio/proc/toggle_broadcasting(mob/user)
	SIGNAL_HANDLER

	broadcasting = !broadcasting
	user.balloon_alert(user, "Microphone turned [broadcasting ? "on" : "off"].")

/datum/component/radio/proc/toggle_listening(mob/user)
	SIGNAL_HANDLER

	listening = !listening
	user.balloon_alert(user, "Speaker turned [listening ? "on" : "off"].")

/datum/component/radio/proc/on_examine(datum/source, mob/user, list/examine_text)
	SIGNAL_HANDLER

	examine_text += SPAN_NOTICE("Its radio is tuned to the [frequency / 10] wavelength. The speaker is [listening ? "on" : "off"], and the microphone is [broadcasting ? "on" : "off"].")
	examine_text += SPAN_INFO("You can toggle the microphone with alt+click and the speaker with alt+rclick.")

/datum/component/radio/proc/handle_hear(datum/source, list/orig_args)
	SIGNAL_HANDLER

	if(orig_args[HEARING_RADIO_FREQ] || !broadcasting || get_dist(src, orig_args[HEARING_SPEAKER]) > canhear_range)
		return

	talk_into(orig_args)

/datum/component/radio/proc/talk_into(list/orig_args)
	//TODO: Modify original speech and send radio signal
	return

/datum/component/radio/proc/receive_signal(datum/signal/signal)
	//TODO: determine whether to speak, and then speak
	SIGNAL_HANDLER
