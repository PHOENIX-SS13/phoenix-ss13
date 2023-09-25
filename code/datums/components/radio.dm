/datum/component/radio
	var/frequency = FREQ_COMMON
	var/broadcasting = FALSE
	var/listening = TRUE
	var/canhear_range = 3

/datum/component/radio/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_HEAR, .proc/handle_hear)
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	RegisterSignal(parent, COMSIG_CLICK_ALT, .proc/toggle_broadcasting)
	RegisterSignal(parent, COMSIG_CLICK_ALT_SECONDARY, .proc/toggle_listening)

/datum/component/radio/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOVABLE_HEAR)
	UnregisterSignal(parent, COMSIG_PARENT_EXAMINE)
	UnregisterSignal(parent, COMSIG_CLICK_ALT)
	UnregisterSignal(parent, COMSIG_CLICK_ALT_SECONDARY)

/datum/component/radio/Initialize(var/freq)
	frequency = freq

/datum/component/radio/proc/toggle_broadcasting(/mob/user)
	broadcasting = !broadcasting
	source.balloon_alert(user, "Microphone turned [broadcasting ? "on" : "off"].")

/datum/component/radio/proc/toggle_listening(/mob/user)
	listening = !listening
	source.balloon_alert(user, "Speaker turned [listening ? "on" : "off"].")

/datum/component/radio/proc/on_examine()
	SIGNAL_HANDLER
	. += SPAN_NOTICE("Its radio is tuned to the [frequency / 10] wavelength. The speaker is [listening ? "on" : "off"], and the microphone is [broadcasting ? "on" : "off"].")
	. += SPAN_INFO("You can toggle the microphone with alt+click and the speaker with alt+rclick.")

/datum/component/radio/proc/handle_hear(datum/source, list/orig_args)
	SIGNAL_HANDLER
	if(orig_args[HEARING_RADIO_FREQ] || !broadcasting || get_dist(src, orig_args[HEARING_SPEAKER]) > canhear_range)
		return

	talk_into(orig_args)
