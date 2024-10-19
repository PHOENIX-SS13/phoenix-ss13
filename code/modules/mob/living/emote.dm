
/* EMOTE DATUMS */
/datum/emote/living
	mob_type_allowed_typecache = /mob/living
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/blush
	key = "blush"
	key_third_person = "blushes"
	message = "blushes."

/datum/emote/living/bow
	key = "bow"
	key_third_person = "bows"
	message = "bows."
	message_param = "bows to %t."
	hands_use_check = TRUE

/datum/emote/living/burp
	key = "burp"
	key_third_person = "burps"
	message = "burps."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/burp/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'sound/voice/emotes/male/burp_m.ogg'
		return 'sound/voice/emotes/female/burp_f.ogg'
	return

/datum/emote/living/choke
	key = "choke"
	key_third_person = "chokes"
	message = "chokes!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/cross
	key = "cross"
	key_third_person = "crosses"
	message = "crosses their arms."
	hands_use_check = TRUE

/datum/emote/living/chuckle
	key = "chuckle"
	key_third_person = "chuckles"
	message = "chuckles."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/collapse
	key = "collapse"
	key_third_person = "collapses"
	message = "collapses!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/collapse/run_emote(mob/user, params, type_override, intentional, override_message, override_emote_type)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Unconscious(40)

/datum/emote/living/cough
	key = "cough"
	key_third_person = "coughs"
	message = "coughs!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/cough/can_run_emote(mob/user, status_check = TRUE , intentional)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_SOOTHED_THROAT))
		return FALSE

/datum/emote/living/cough/get_sound(mob/living/user)
	if(isvox(user))
		return 'sound/voice/voxcough.ogg'
	if(iscarbon(user))
		if(user.gender == MALE)
			return pick(
				'sound/voice/emotes/male/male_cough_1.ogg',
				'sound/voice/emotes/male/male_cough_2.ogg',
				'sound/voice/emotes/male/male_cough_3.ogg',
			)
		return pick(
			'sound/voice/emotes/female/female_cough_1.ogg',
			'sound/voice/emotes/female/female_cough_2.ogg',
			'sound/voice/emotes/female/female_cough_3.ogg',
		)
	return

/datum/emote/living/dance
	key = "dance"
	key_third_person = "dances"
	message = "dances around happily."
	hands_use_check = TRUE

/datum/emote/living/deathgasp
	key = "deathgasp"
	key_third_person = "deathgasps"
	message = "seizes up and falls limp, their eyes dead and lifeless..."
	message_robot = "shudders violently for a moment before falling still, its eyes slowly darkening."
	message_AI = "screeches, its screen flickering as its systems slowly halt."
	message_alien = "lets out a waning guttural screech, and collapses onto the floor..."
	message_larva = "lets out a sickly hiss of air and falls limply to the floor..."
	message_monkey = "lets out a faint chimper as it collapses and stops moving..."
	message_simple =  "stops moving..."
	cooldown = (15 SECONDS)
	stat_allowed = HARD_CRIT

/datum/emote/living/deathgasp/run_emote(mob/user, params, type_override, intentional, override_message, override_emote_type)
	var/mob/living/simple_animal/S = user
	if(istype(S) && S.deathmessage)
		message_simple = S.deathmessage
	. = ..()
	message_simple = initial(message_simple)
	if(. && user.deathsound)
		if(isliving(user))
			var/mob/living/L = user
			if(!L.can_speak_vocal() || L.oxyloss >= 50)
				return //stop the sound if oxyloss too high/cant speak
		playsound(user, user.deathsound, 200, TRUE, TRUE)

/datum/emote/living/drool
	key = "drool"
	key_third_person = "drools"
	message = "drools."

/datum/emote/living/faint
	key = "faint"
	key_third_person = "faints"
	message = "faints."

/datum/emote/living/faint/run_emote(mob/user, params, type_override, intentional, override_message, override_emote_type)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.SetSleeping(200)

/datum/emote/living/flap
	key = "flap"
	key_third_person = "flaps"
	message = "flaps their wings."
	hands_use_check = TRUE
	var/wing_time = 20
/* Fix this later
/datum/emote/living/flap/run_emote(mob/user, params, type_override, intentional, override_message, override_emote_type)
	. = ..()
	if(. && ishuman(user))
		var/mob/living/carbon/human/H = user
		var/open = FALSE
		if(H.dna.features["wings"] != "None")
			if(H.dna.species.mutant_bodyparts["wingsopen"])
				open = TRUE
				H.CloseWings()
			else
				H.OpenWings()
			addtimer(CALLBACK(H, open ? /mob/living/carbon/human.proc/OpenWings : /mob/living/carbon/human.proc/CloseWings), wing_time)
*/
/datum/emote/living/flap/aflap
	key = "aflap"
	key_third_person = "aflaps"
	message = "flaps their wings ANGRILY!"
	hands_use_check = TRUE
	wing_time = 10

/datum/emote/living/frown
	key = "frown"
	key_third_person = "frowns"
	message = "frowns."

/datum/emote/living/gag
	key = "gag"
	key_third_person = "gags"
	message = "gags."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/gasp
	key = "gasp"
	key_third_person = "gasps"
	message = "gasps!"
	emote_type = EMOTE_AUDIBLE
	stat_allowed = HARD_CRIT

/datum/emote/living/gasp/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return pick(
				'sound/voice/emotes/male/gasp_m1.ogg',
				'sound/voice/emotes/male/gasp_m2.ogg',
				'sound/voice/emotes/male/gasp_m3.ogg',
				'sound/voice/emotes/male/gasp_m4.ogg',
				'sound/voice/emotes/male/gasp_m5.ogg',
				'sound/voice/emotes/male/gasp_m6.ogg',
			)
		return pick(
			'sound/voice/emotes/female/gasp_f1.ogg',
			'sound/voice/emotes/female/gasp_f2.ogg',
			'sound/voice/emotes/female/gasp_f3.ogg',
			'sound/voice/emotes/female/gasp_f4.ogg',
			'sound/voice/emotes/female/gasp_f5.ogg',
			'sound/voice/emotes/female/gasp_f6.ogg',
		)
	return

/datum/emote/living/giggle
	key = "giggle"
	key_third_person = "giggles"
	message = "giggles."
	message_mime = "giggles silently!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/glare
	key = "glare"
	key_third_person = "glares"
	message = "glares."
	message_param = "glares at %t."

/datum/emote/living/grin
	key = "grin"
	key_third_person = "grins"
	message = "grins."

/datum/emote/living/groan
	key = "groan"
	key_third_person = "groans"
	message = "groans!"
	message_mime = "appears to groan!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/grimace
	key = "grimace"
	key_third_person = "grimaces"
	message = "grimaces."

/datum/emote/living/jump
	key = "jump"
	key_third_person = "jumps"
	message = "jumps!"
	hands_use_check = TRUE

/datum/emote/living/kiss
	key = "kiss"
	key_third_person = "kisses"
	cooldown = 3 SECONDS

/datum/emote/living/kiss/run_emote(mob/living/user, params, type_override, intentional, override_message, override_emote_type)
	. = ..()
	if(!.)
		return
	var/kiss_type = /obj/item/kisser

	if(HAS_TRAIT(user, TRAIT_KISS_OF_DEATH))
		kiss_type = /obj/item/kisser/death

	var/obj/item/kiss_blower = new kiss_type(user)
	if(user.put_in_hands(kiss_blower))
		to_chat(user, SPAN_NOTICE("You ready your kiss-blowing hand."))
	else
		qdel(kiss_blower)
		to_chat(user, SPAN_WARNING("You're incapable of blowing a kiss in your current state."))

/datum/emote/living/laugh
	key = "laugh"
	key_third_person = "laughs"
	message = "laughs."
	message_mime = "laughs silently!"
	emote_type = EMOTE_AUDIBLE
	audio_cooldown = 5 SECONDS
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/laugh/get_sound(mob/living/user)
	if(ismoth(user))
		return 'sound/voice/mothlaugh.ogg'
	if(iscarbon(user))
		if(user.gender == MALE)
			return pick(
				'sound/voice/human/manlaugh1.ogg',
				'sound/voice/human/manlaugh2.ogg',
			)
		return pick(
			'sound/voice/emotes/female/female_giggle_1.ogg',
			'sound/voice/emotes/female/female_giggle_2.ogg',
		)
	return

/datum/emote/living/look
	key = "look"
	key_third_person = "looks"
	message = "looks."
	message_param = "looks at %t."

/datum/emote/living/nod
	key = "nod"
	key_third_person = "nods"
	message = "nods."
	message_param = "nods at %t."

/datum/emote/living/point
	key = "point"
	key_third_person = "points"
	message = "points."
	message_param = "points at %t."
	hands_use_check = TRUE

/datum/emote/living/point/run_emote(mob/user, params, type_override, intentional, override_message, override_emote_type)
	message_param = initial(message_param) // reset
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.usable_hands == 0)
			if(H.usable_legs != 0)
				message_param = "tries to point at %t with a leg, [SPAN_USERDANGER("falling down")] in the process!"
				H.Paralyze(20)
			else
				message_param = "[SPAN_USERDANGER("bumps [user.p_their()] head on the ground")] trying to motion towards %t."
				H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
	return ..()

/datum/emote/living/pout
	key = "pout"
	key_third_person = "pouts"
	message = "pouts."

/datum/emote/living/scream
	key = "scream"
	key_third_person = "screams"
	message = "screams!"
	message_mime = "acts out a scream!"
	emote_type = EMOTE_AUDIBLE
	mob_type_blacklist_typecache = list(
		/mob/living/brain,
		/mob/living/simple_animal/slime
	)
	vary = TRUE

/datum/emote/living/scream/can_run_emote(mob/living/user, status_check, intentional)
	if(iscyborg(user))
		var/mob/living/silicon/robot/R = user

		if(R.cell?.charge < 200)
			to_chat(R, SPAN_WARNING("Scream module deactivated. Please recharge."))
			return FALSE
		R.cell.use(200)
	return ..()

/datum/emote/living/scream/get_sound(mob/living/user, override = FALSE)
	if(!override)
		return
	if(iscyborg(user))
		return 'sound/voice/scream_silicon.ogg'
	if(istype(user, /mob/living/simple_animal/hostile/gorilla))
		return 'sound/creatures/gorilla.ogg'
	if(isalien(user))
		return 'sound/voice/hiss6.ogg'
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/datum/species/species_user = human_user.dna.species
		if(human_user.mind?.miming) return

		if(user.gender == MALE && prob(1))
			return 'sound/voice/human/wilhelm_scream.ogg'

		// If we have dedicated scream sounds..
		if(length(species_user.scream_sounds[user.gender]))
			// use them!
			return pick(species_user.scream_sounds[user.gender])
		else
			// or use these else
			return pick(species_user.scream_sounds[NEUTER])
	return

/datum/emote/living/scream/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(!user.is_muzzled())
		var/sound = get_sound(user, TRUE)
		playsound(user.loc, sound, sound_volume, vary, 4, 1.2)
	if(ishuman(user))
		user.adjustOxyLoss(5)

/datum/emote/living/scream/select_message_type(mob/user, intentional)
	. = ..()
	if(!intentional && isanimal(user))
		. = "makes a loud and pained whimper."
	if(user.is_muzzled())
		. = "makes a very loud noise."

/datum/emote/living/scream/screech //If a human tries to screech it'll just scream.
	key = "screech"
	key_third_person = "screeches"
	message = "screeches."
	emote_type = EMOTE_AUDIBLE
	vary = FALSE

/datum/emote/living/raptorscream
	key = "raptorscream"
	message = "screams!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/scream_raptor.ogg'

/datum/emote/living/rodentscream
	key = "rodentscream"
	message = "screams!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/scream_rodent.ogg'

/datum/emote/living/felinescream
	key = "felinescream"
	message = "screams!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound_volume = 40
	sound = 'sound/voice/cat_scream.ogg'

/datum/emote/living/scowl
	key = "scowl"
	key_third_person = "scowls"
	message = "scowls."

/datum/emote/living/shake
	key = "shake"
	key_third_person = "shakes"
	message = "shakes their head."

/datum/emote/living/shiver
	key = "shiver"
	key_third_person = "shiver"
	message = "shivers."

/datum/emote/living/sigh
	key = "sigh"
	key_third_person = "sighs"
	message = "sighs."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sigh/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'sound/voice/male_sigh.ogg'
		return 'sound/voice/female_sigh.ogg'
	return

/datum/emote/living/sit
	key = "sit"
	key_third_person = "sits"
	message = "sits down."

/datum/emote/living/smile
	key = "smile"
	key_third_person = "smiles"
	message = "smiles."

/datum/emote/living/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "sneezes."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/sneeze/get_sound(mob/living/user)
	if(isvox(user))
		return 'sound/voice/voxsneeze.ogg'
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'sound/voice/male_sneeze.ogg'
		return 'sound/voice/female_sneeze.ogg'
	return

/datum/emote/living/smug
	key = "smug"
	key_third_person = "smugs"
	message = "grins smugly."

/datum/emote/living/sniff
	key = "sniff"
	key_third_person = "sniffs"
	message = "sniffs."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/sniff/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'sound/voice/male_sniff.ogg'
		return 'sound/voice/female_sniff.ogg'
	return

/datum/emote/living/sniff/run_emote(mob/user, params, type_override, intentional, override_message, override_emote_type)
	. = ..()
	if(.)
		var/turf/open/current_turf = get_turf(user)
		if(istype(current_turf) && current_turf.pollution)
			if(iscarbon(user))
				var/mob/living/carbon/carbon_user = user
				if(carbon_user.internal) //Breathing from internals means we cant smell
					return
				carbon_user.next_smell = world.time + SMELL_COOLDOWN
			current_turf.pollution.smell_act(user)

/datum/emote/living/snore
	key = "snore"
	key_third_person = "snores"
	message = "snores."
	message_mime = "sleeps soundly."
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS
	vary = TRUE
	sound = 'sound/voice/snore.ogg'

/datum/emote/living/stare
	key = "stare"
	key_third_person = "stares"
	message = "stares."
	message_param = "stares at %t."

/datum/emote/living/strech
	key = "stretch"
	key_third_person = "stretches"
	message = "stretches their arms."

/datum/emote/living/sulk
	key = "sulk"
	key_third_person = "sulks"
	message = "sulks down sadly."

/datum/emote/living/surrender
	key = "surrender"
	key_third_person = "surrenders"
	message = "puts their hands on their head and falls to the ground, they surrender%s!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/surrender/run_emote(mob/user, params, type_override, intentional, override_message, override_emote_type)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Paralyze(200)
		L.remove_status_effect(STATUS_EFFECT_SURRENDER)

/datum/emote/living/sway
	key = "sway"
	key_third_person = "sways"
	message = "sways around dizzily."

/datum/emote/living/tremble
	key = "tremble"
	key_third_person = "trembles"
	message = "trembles in fear!"

/datum/emote/living/twitch
	key = "twitch"
	key_third_person = "twitches"
	message = "twitches violently."

/datum/emote/living/twitch_s
	key = "twitch_s"
	message = "twitches."

/datum/emote/living/wave
	key = "wave"
	key_third_person = "waves"
	message = "waves."

/datum/emote/living/whimper
	key = "whimper"
	key_third_person = "whimpers"
	message = "whimpers."
	message_mime = "appears hurt."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/wsmile
	key = "wsmile"
	key_third_person = "wsmiles"
	message = "smiles weakly."

/datum/emote/living/yawn
	key = "yawn"
	key_third_person = "yawns"
	message = "yawns."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/gurgle
	key = "gurgle"
	key_third_person = "gurgles"
	message = "makes an uncomfortable gurgle."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/custom
	key = "me"
	key_third_person = "custom"
	message = null
	var/subtle = FALSE
	cooldown = 0

/datum/emote/living/custom/can_run_emote(mob/user, status_check, intentional)
	. = ..() && intentional

/datum/emote/living/custom/check_cooldown(mob/user, intentional)
	// me-verb emotes should not have a cooldown check
	return TRUE

/datum/emote/living/custom/proc/check_invalid(mob/user, input)
	var/static/regex/stop_bad_mime = regex(@"says|exclaims|yells|asks")
	if(stop_bad_mime.Find(input, 1, 1))
		to_chat(user, SPAN_DANGER("Invalid emote."))
		return TRUE
	return FALSE

/datum/emote/living/custom/run_emote(mob/user, params, type_override, intentional, override_message, override_emote_type)
	var/custom_emote
	var/custom_emote_type
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	if(is_banned_from(user.ckey, "Emote"))
		to_chat(user, SPAN_BOLDWARNING("You cannot send custom emotes (banned)."))
		return FALSE
	if(QDELETED(user))
		return FALSE
	if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, SPAN_BOLDWARNING("You cannot send IC messages (muted)."))
		return FALSE
	if(!params)
		return FALSE
	//	custom_emote = copytext(sanitize(input("Choose an emote to display.") as text|null), 1, MAX_MESSAGE_LEN)
	//	if(!custom_emote)
	//		return FALSE
	//	if(custom_emote && !check_invalid(user, custom_emote))
	//		var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
	//		if(!type)
	//			return FALSE
	//		switch(type)
	//			if("Visible")
	//				custom_emote_type = EMOTE_VISIBLE
	//			if("Hearable")
	//				custom_emote_type = EMOTE_AUDIBLE
	else
		custom_emote = params
		if(type_override)
			custom_emote_type = type_override
	if(subtle)
		custom_emote = "<i>[custom_emote]</i>"
	override_message = custom_emote
	override_emote_type = custom_emote_type
	. = ..()

/datum/emote/living/custom/replace_pronoun(mob/user, message)
	return message

/datum/emote/living/custom/subtle
	key = "subtle"
	key_third_person = "subtling"
	subtle = TRUE
	emote_distance = 1

/datum/emote/living/custom/subtle/anti_ghost
	key = "subtler"
	key_third_person = "subtlering" //What do you mean third person???
	show_ghosts = FALSE

/datum/emote/living/beep
	key = "beep"
	key_third_person = "beeps"
	message = "beeps."
	message_param = "beeps at %t."
	sound = 'sound/machines/twobeep.ogg'
	mob_type_allowed_typecache = list(/mob/living/brain, /mob/living/silicon)
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/inhale
	key = "inhale"
	key_third_person = "inhales"
	message = "breathes in."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/exhale
	key = "exhale"
	key_third_person = "exhales"
	message = "breathes out."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/quill
	key = "quill"
	key_third_person = "quills"
	message = "rustles their quills."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'sound/voice/voxrustle.ogg'

/datum/emote/living/bawk
	key = "bawk"
	key_third_person = "bawks"
	message = "bawks like a chicken."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/bawk.ogg'

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/caw.ogg'

/datum/emote/living/caw2
	key = "caw2"
	key_third_person = "caws twice"
	message = "caws twice!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/caw2.ogg'

/datum/emote/living/whistle
	key = "whistle"
	key_third_person = "whistles"
	message = "whistles."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/blep
	key = "blep"
	key_third_person = "bleps"
	message = "bleps their tongue out. Blep."
	message_AI = "shows an image of a random blepping animal. Blep."
	message_robot = "bleps their robo-tongue out. Blep."

/datum/emote/living/bork
	key = "bork"
	key_third_person = "borks"
	message = "lets out a bork."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/bork.ogg'

/datum/emote/living/hoot
	key = "hoot"
	key_third_person = "hoots"
	message = "hoots!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/hoot.ogg'

/datum/emote/living/growl
	key = "growl"
	key_third_person = "growls"
	message = "lets out a growl."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'sound/voice/growl.ogg'

/datum/emote/living/woof
	key = "woof"
	key_third_person = "woofs"
	message = "lets out a woof."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/woof.ogg'

/datum/emote/living/baa
	key = "baa"
	key_third_person = "baas"
	message = "lets out a baa."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/baa.ogg'

/datum/emote/living/baa2
	key = "baa2"
	key_third_person = "baas"
	message = "bleats."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/baa2.ogg'

/datum/emote/living/warble
	key = "warble"
	key_third_person = "warbles"
	message = "warbles!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/warbles.ogg'

/datum/emote/living/wurble
	key = "wurble"
	key_third_person = "wurbles"
	message = "lets out a wurble."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/wurble.ogg'

/datum/emote/living/awoo2
	key = "awoo2"
	key_third_person = "awoos"
	message = "lets out an awoo!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/long_awoo.ogg'
	cooldown = 3 SECONDS

/datum/emote/living/rattle
	key = "rattle"
	key_third_person = "rattles"
	message = "rattles!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'sound/voice/rattle.ogg'

/datum/emote/living/cackle
	key = "cackle"
	key_third_person = "cackles"
	message = "cackles hysterically!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/cackle/get_sound(mob/living/user)
	return pick(
		'sound/voice/hyena/cackle.ogg',
		'sound/voice/hyena/cackle_giggle.ogg',
	)

/datum/emote/living/headtilt
	key = "tilt"
	key_third_person = "tilts"
	message = "tilts their head."
	message_AI = "tilts the image on their display."

/datum/emote/living/clap1
	key = "clap1"
	key_third_person = "claps once"
	message = "claps once."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = TRUE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/clap1/get_sound(mob/living/user)
	return pick(
		'sound/effects/claponce1.ogg',
		'sound/effects/claponce2.ogg',
	)

/datum/emote/living/clap1/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional)
	if(!iscarbon(user)) return FALSE
	if(user.usable_hands < 2) return FALSE
	return ..()

/datum/emote/living/clap
	key = "clap"
	key_third_person = "claps"
	message = "claps."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = TRUE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/clap/get_sound(mob/living/user)
	return pick(
		'sound/effects/clap1.ogg',
		'sound/effects/clap2.ogg',
		'sound/effects/clap3.ogg',
		'sound/effects/clap4.ogg',
	)

/datum/emote/living/clap/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional)
	if(!iscarbon(user)) return FALSE
	if(user.usable_hands < 2) return FALSE
	return ..()

/datum/emote/living/peep
	key = "peep"
	key_third_person = "peeps"
	message = "peeps like a bird!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/peep_once.ogg'

/datum/emote/living/peep2
	key = "peep2"
	key_third_person = "peeps twice"
	message = "peeps twice like a bird!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/peep.ogg'

/datum/emote/living/snap
	key = "snap"
	key_third_person = "snaps"
	message = "snaps their fingers."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'sound/effects/fingers_snap.ogg'

/datum/emote/living/snap2
	key = "snap2"
	key_third_person = "snaps twice"
	message = "snaps twice."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'sound/effects/fingers_snap2.ogg'

/datum/emote/living/snap3
	key = "snap3"
	key_third_person = "snaps thrice"
	message = "snaps thrice."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'sound/effects/fingers_snap3.ogg'

/datum/emote/living/awoo
	key = "awoo"
	key_third_person = "awoos"
	message = "lets out an awoo!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/awoo.ogg'

/datum/emote/living/nya
	key = "nya"
	key_third_person = "nyas"
	message = "lets out a nya!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/nya.ogg'

/datum/emote/living/weh
	key = "weh"
	key_third_person = "wehs"
	message = "lets out a weh!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/weh.ogg'

/datum/emote/living/dab
	key = "dab"
	key_third_person = "dabs"
	message = "suddenly hits a dab!"
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE

/datum/emote/living/mothsqueak
	key = "msqueak"
	key_third_person = "lets out a tiny squeak"
	message = "lets out a tiny squeak!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/mothsqueak.ogg'

/datum/emote/living/merp
	key = "merp"
	key_third_person = "merps"
	message = "merps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/merp.ogg'

/datum/emote/living/simple_animal/diona_chirp
	key = "chirp"
	key_third_person = "chirps"
	message = "chirps!"
	sound = "sound/creatures/nymphchirp.ogg"
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/simple_animal/diona, /mob/living/carbon/human/species/diona)

/datum/emote/living/bark
	key = "bark"
	key_third_person = "barks"
	message = "barks!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/bark2.ogg'

/datum/emote/living/whine
	key = "whine"
	message = "whines!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/whine1.ogg'

/datum/emote/living/whine2
	key = "whine2"
	message = "whines!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/whine2.ogg'

/datum/emote/living/yelp
	key = "yelp"
	message = "yelps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/yelp1.ogg'

/datum/emote/living/yelp2
	key = "yelp2"
	message = "yelps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/yelp2.ogg'

/datum/emote/living/rawr
	key = "rawr"
	key_third_person = "rawrs"
	message = "rawrs!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/rawr.ogg'

/datum/emote/living/squish
	key = "squish"
	key_third_person = "squishes"
	message = "squishes!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/slime_squish.ogg'

/datum/emote/living/meow
	key = "meow"
	key_third_person = "meows"
	message = "meows!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/meow.ogg'

/datum/emote/living/purr
	key = "purr"
	key_third_person = "purrs"
	message = "purrs!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/feline_purr.ogg'

/datum/emote/living/felinehiss
	key = "fhiss"
	key_third_person = "fhisses"
	message = "hisses!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/feline_hiss.ogg'

/datum/emote/living/catchirp
	key = "catchirp"
	message = "chirps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/catchirp.ogg'

/datum/emote/living/hiss
	key = "hiss"
	key_third_person = "hisses"
	message = "hisses!"
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'sound/voice/hiss.ogg'

/datum/emote/living/trills
	key = "trill"
	key_third_person = "trills"
	message = "trills!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/voice/trills.ogg'

/datum/emote/living/chitter
	key = "chitter"
	key_third_person = "chitters"
	message = "chitters!"
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'sound/voice/mothchitter.ogg'

/datum/emote/living/whoop
	key = "whoop"
	key_third_person = "whoops"
	message = "lets out a whoop!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/whoop/get_sound(mob/living/user)
	return pick(
		'sound/voice/hyena/whoop.ogg',
		'sound/voice/hyena/whoop_long.ogg',
	)

/datum/emote/living/hyena_laugh
	key = "hlaugh"
	message = "laughs like a hyena!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound_volume = 25

/datum/emote/living/hyena_laugh/get_sound(mob/living/user)
	return pick(
		'sound/voice/hyena/laugh_bright.ogg',
		'sound/voice/hyena/laugh_low.ogg',
		'sound/voice/hyena/laugh_short.ogg',
		'sound/voice/hyena/laugh_twice.ogg',
		'sound/voice/hyena/laugh1.ogg',
		'sound/voice/hyena/laugh2.ogg',
	)

/mob/living/proc/do_ass_slap_animation(atom/slapped)
	do_attack_animation(slapped, no_effect=TRUE)
	var/image/gloveimg = image('icons/effects/effects.dmi', slapped, "slapglove", slapped.layer + 0.1)
	gloveimg.pixel_y = -5
	gloveimg.pixel_x = 0
	flick_overlay(gloveimg, GLOB.clients, 10)

	// And animate the attack!
	animate(gloveimg, alpha = 175, transform = matrix() * 0.75, pixel_x = 0, pixel_y = -5, pixel_z = 0, time = 3)
	animate(time = 1)
	animate(alpha = 0, time = 3, easing = CIRCULAR_EASING|EASE_OUT)
