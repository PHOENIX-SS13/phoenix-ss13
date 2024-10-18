/mob/living/carbon/human/say_mod(input, list/message_mods = list())
	if(!length(dna.features["custom_say"]))
		verb_say = dna.species.say_mod
	if(slurring)
		if (HAS_TRAIT(src, TRAIT_SIGN_LANG))
			return "loosely signs"
		else
			return "slurs"
	else
		. = ..()

/mob/living/carbon/human/say_understands(atom/movable/other, datum/language/speaking = null)
	if(dna.species.can_understand(other))
		return TRUE

	//These only pertain to common. Languages are handled by mob/say_understands()
	if(!speaking && ismob(other))
		if(isnymph(other))
			var/mob/nymph = other
			if(length(nymph.languages) >= 2) //They've sucked down some blood and can speak common now.
				return TRUE
		if(issilicon(other))
			return TRUE
		if(isbot(other))
			return TRUE
		if(isbrain(other))
			return TRUE
		if(isslime(other))
			return TRUE

	return ..()

/mob/living/carbon/human/GetVoice()
	if(istype(wear_mask, /obj/item/clothing/mask/chameleon))
		var/obj/item/clothing/mask/chameleon/V = wear_mask
		if(V.voice_change && wear_id)
			var/obj/item/card/id/idcard = wear_id.GetID()
			if(istype(idcard))
				return idcard.registered_name
			else
				return real_name
		else
			return real_name
	if(istype(wear_mask, /obj/item/clothing/mask/infiltrator))
		var/obj/item/clothing/mask/infiltrator/V = wear_mask
		if(V.voice_unknown)
			return ("Unknown")
		else
			return real_name
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling?.mimicing )
			return changeling.mimicing
	if(GetSpecialVoice())
		return GetSpecialVoice()
	return real_name

/mob/living/carbon/human/IsVocal()
	// how do species that don't breathe talk? magic, that's what.
	if(!HAS_TRAIT_FROM(src, TRAIT_NOBREATH, SPECIES_TRAIT) && !getorganslot(ORGAN_SLOT_LUNGS))
		return FALSE
	if(mind)
		return !mind.miming
	return TRUE

/mob/living/carbon/human/proc/SetSpecialVoice(new_voice)
	if(new_voice)
		special_voice = new_voice
	return

/mob/living/carbon/human/proc/UnsetSpecialVoice()
	special_voice = ""
	return

/mob/living/carbon/human/proc/GetSpecialVoice()
	return special_voice

/mob/living/carbon/human/binarycheck()
	if(stat >= SOFT_CRIT || !ears)
		return FALSE
	var/obj/item/radio/headset/dongle = ears
	if(!istype(dongle))
		return FALSE
	return dongle.translate_binary

/mob/living/carbon/human/radio(message, list/message_mods = list(), list/spans, language) //Poly has a copy of this, lazy bastard
	. = ..()
	if(.)
		return

	if(message_mods[MODE_HEADSET])
		if(ears)
			ears.talk_into(src, message, , spans, language, message_mods)
		return ITALICS | REDUCE_RANGE
	else if(message_mods[RADIO_EXTENSION] == MODE_DEPARTMENT)
		if(ears)
			ears.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
		return ITALICS | REDUCE_RANGE
	else if(GLOB.radiochannels[message_mods[RADIO_EXTENSION]])
		if(ears)
			ears.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
			return ITALICS | REDUCE_RANGE

	return FALSE

/mob/living/carbon/human/get_alt_name()
	if(name != GetVoice())
		return " (as [get_id_name("Unknown")])"\
