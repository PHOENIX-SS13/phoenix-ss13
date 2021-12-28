/datum/ambient_sound/lava
	id = AMBIENCE_LAVA
	volume = 35
	sounds = list(
		'sound/ambience/emitters/lava/lava1.ogg',
		'sound/ambience/emitters/lava/lava2.ogg',
		'sound/ambience/emitters/lava/lava3.ogg',
		'sound/ambience/emitters/lava/lava4.ogg',
		'sound/ambience/emitters/lava/lava5.ogg'
		)
	frequency_time = 3 SECONDS
	sound_length = 6 SECONDS

/datum/ambient_sound/water
	id = AMBIENCE_WATER
	sounds = list('sound/ambience/emitters/water/water1.ogg')
	frequency_time = 3 SECONDS
	sound_length = 6 SECONDS
	volume = 20

/datum/ambient_sound/heartbeat
	id = AMBIENCE_HEARTBEAT
	sounds = list('sound/effects/singlebeat.ogg')
	frequency_time = 1 SECONDS
	sound_length = 1 SECONDS
	loops = FALSE //Great looping sound, but can happen at any frequency just fine.

/datum/ambient_sound/sparks //Resembling of an inducer charging
	id = AMBIENCE_SPARKS
	sounds = list(
		'sound/effects/sparks1.ogg',
		'sound/effects/sparks2.ogg',
		'sound/effects/sparks3.ogg',
		'sound/effects/sparks4.ogg'
		)
	frequency_time = 1 SECONDS
	sound_length = 1 SECONDS

/datum/ambient_sound/thunder
	id = AMBIENCE_THUNDER
	sounds = list(
		'sound/effects/thunder/thunder1.ogg',
		'sound/effects/thunder/thunder2.ogg',
		'sound/effects/thunder/thunder3.ogg',
		'sound/effects/thunder/thunder4.ogg',
		'sound/effects/thunder/thunder5.ogg',
		'sound/effects/thunder/thunder6.ogg',
		'sound/effects/thunder/thunder7.ogg',
		'sound/effects/thunder/thunder8.ogg',
		'sound/effects/thunder/thunder9.ogg',
		'sound/effects/thunder/thunder10.ogg'
		)
	frequency_time = 40 SECONDS
	sound_length = 7 SECONDS
	loops = FALSE

/datum/ambient_sound/station_creak
	id = AMBIENCE_STATION_CREAK
	sounds = list(
		'sound/effects/creak1.ogg',
		'sound/effects/creak2.ogg',
		'sound/effects/creak3.ogg'
		)
	frequency_time = 30 SECONDS
	sound_length = 10 SECONDS
	loops = FALSE

/datum/ambient_sound/fire
	id = AMBIENCE_FIRE
	sounds = list('sound/effects/comfyfire.ogg') //Truly the fiercest fire sound
	frequency_time = 4 SECONDS
	maximum_emitters = 2
	cooldown_between_emitters = 2 SECONDS

/// Obnoxious tcomms ambience, but slightly more bearable now
/datum/ambient_sound/crunchy_server
	id = AMBIENCE_CRUNCHY_SERVER
	sounds = list(
		'sound/machines/tcomms/tcomms_mid1.ogg',
		'sound/machines/tcomms/tcomms_mid2.ogg',
		'sound/machines/tcomms/tcomms_mid3.ogg',
		'sound/machines/tcomms/tcomms_mid4.ogg',
		'sound/machines/tcomms/tcomms_mid5.ogg',
		'sound/machines/tcomms/tcomms_mid6.ogg',
		'sound/machines/tcomms/tcomms_mid7.ogg'
		)
	frequency_time = 2 SECONDS
	sound_length = 2 SECONDS
	volume = 2
	range = 3

/datum/ambient_sound/server //Nice, subtle hdd crunching
	id = AMBIENCE_SERVER
	sounds = list(
		'sound/ambience/emitters/server/server1.ogg',
		'sound/ambience/emitters/server/server2.ogg',
		'sound/ambience/emitters/server/server3.ogg'
		)
	frequency_time = 2 SECONDS
	sound_length = 2.8 SECONDS
	range = 3
	volume = 15

/datum/ambient_sound/vending
	id = AMBIENCE_VENDING
	sounds = list(
		'sound/ambience/emitters/vending/vending1.ogg',
		'sound/ambience/emitters/vending/vending2.ogg',
		'sound/ambience/emitters/vending/vending3.ogg',
		'sound/ambience/emitters/vending/vending4.ogg',
		'sound/ambience/emitters/vending/vending5.ogg'
		)
	frequency_time = 2 SECONDS
	sound_length = 2.8 SECONDS
	range = 3
	volume = 10

/datum/ambient_sound/generic
	id = AMBIENCE_GENERIC
	sounds = list(
	'sound/ambience/ambigen1.ogg', 'sound/ambience/ambigen3.ogg',
	'sound/ambience/ambigen4.ogg', 'sound/ambience/ambigen5.ogg',
	'sound/ambience/ambigen6.ogg', 'sound/ambience/ambigen7.ogg',
	'sound/ambience/ambigen8.ogg', 'sound/ambience/ambigen9.ogg',
	'sound/ambience/ambigen10.ogg', 'sound/ambience/ambigen11.ogg',
	'sound/ambience/ambigen12.ogg', 'sound/ambience/ambigen14.ogg',
	'sound/ambience/ambigen15.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/holy
	id = AMBIENCE_HOLY
	sounds = list(
	'sound/ambience/ambicha1.ogg', 'sound/ambience/ambicha2.ogg',
	'sound/ambience/ambicha3.ogg', 'sound/ambience/ambicha4.ogg',
	'sound/ambience/ambiholy.ogg', 'sound/ambience/ambiholy2.ogg',
	'sound/ambience/ambiholy3.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/danger
	id = AMBIENCE_DANGER
	sounds = list(
	'sound/ambience/ambidanger.ogg', 'sound/ambience/ambidanger2.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/ruins
	id = AMBIENCE_RUINS
	sounds = list(
	'sound/ambience/ambimine.ogg', 'sound/ambience/ambicave.ogg',
	'sound/ambience/ambiruin.ogg', 'sound/ambience/ambiruin2.ogg',
	'sound/ambience/ambiruin3.ogg', 'sound/ambience/ambiruin4.ogg',
	'sound/ambience/ambiruin5.ogg', 'sound/ambience/ambiruin6.ogg',
	'sound/ambience/ambiruin7.ogg', 'sound/ambience/ambidanger.ogg',
	'sound/ambience/ambidanger2.ogg', 'sound/ambience/ambitech3.ogg',
	'sound/ambience/ambimystery.ogg', 'sound/ambience/ambimaint1.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/engi
	id = AMBIENCE_ENGI
	sounds = list(
	'sound/ambience/ambisin1.ogg', 'sound/ambience/ambisin2.ogg',
	'sound/ambience/ambisin3.ogg', 'sound/ambience/ambisin4.ogg',
	'sound/ambience/ambiatmos.ogg', 'sound/ambience/ambiatmos2.ogg',
	'sound/ambience/ambitech.ogg', 'sound/ambience/ambitech2.ogg',
	'sound/ambience/ambitech3.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/mining
	id = AMBIENCE_MINING
	sounds = list(
	'sound/ambience/ambimine.ogg', 'sound/ambience/ambicave.ogg',
	'sound/ambience/ambiruin.ogg', 'sound/ambience/ambiruin2.ogg',
	'sound/ambience/ambiruin3.ogg', 'sound/ambience/ambiruin4.ogg',
	'sound/ambience/ambiruin5.ogg', 'sound/ambience/ambiruin6.ogg',
	'sound/ambience/ambiruin7.ogg', 'sound/ambience/ambidanger.ogg',
	'sound/ambience/ambidanger2.ogg', 'sound/ambience/ambimaint1.ogg',
	'sound/ambience/ambilava1.ogg', 'sound/ambience/ambilava2.ogg',
	'sound/ambience/ambilava3.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 70 SECONDS
	frequency_time_high = 220 SECONDS
	loops = FALSE

/datum/ambient_sound/medical
	id = AMBIENCE_MEDICAL
	sounds = list('sound/ambience/ambinice.ogg')
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/spooky
	id = AMBIENCE_SPOOKY
	sounds = list(
	'sound/ambience/ambimo1.ogg', 'sound/ambience/ambimo2.ogg',
	'sound/ambience/ambiruin7.ogg', 'sound/ambience/ambiruin6.ogg',
	'sound/ambience/ambiodd.ogg', 'sound/ambience/ambimystery.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/space
	id = AMBIENCE_SPACE
	sounds = list(
	'sound/ambience/ambispace.ogg', 'sound/ambience/ambispace2.ogg',
	'sound/ambience/ambispace3.ogg', 'sound/ambience/ambiatmos.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/maint
	id = AMBIENCE_MAINT
	sounds = list(
	'sound/ambience/ambimaint1.ogg', 'sound/ambience/ambimaint2.ogg',
	'sound/ambience/ambimaint3.ogg', 'sound/ambience/ambimaint4.ogg',
	'sound/ambience/ambimaint5.ogg', 'sound/voice/lowHiss2.ogg',
	'sound/voice/lowHiss3.ogg', 'sound/voice/lowHiss4.ogg',
	'sound/ambience/ambitech2.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/away
	id = AMBIENCE_AWAY
	sounds = list(
	'sound/ambience/ambitech.ogg', 'sound/ambience/ambitech2.ogg',
	'sound/ambience/ambiruin.ogg', 'sound/ambience/ambiruin2.ogg',
	'sound/ambience/ambiruin3.ogg', 'sound/ambience/ambiruin4.ogg',
	'sound/ambience/ambiruin5.ogg', 'sound/ambience/ambiruin6.ogg',
	'sound/ambience/ambiruin7.ogg', 'sound/ambience/ambidanger.ogg',
	'sound/ambience/ambidanger2.ogg', 'sound/ambience/ambimaint.ogg',
	'sound/ambience/ambiatmos.ogg', 'sound/ambience/ambiatmos2.ogg',
	'sound/ambience/ambiodd.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/creepy
	id = AMBIENCE_CREEPY
	sounds = list(
	'sound/effects/ghost.ogg', 'sound/effects/ghost2.ogg',
	'sound/effects/heart_beat.ogg', 'sound/effects/screech.ogg',
	'sound/hallucinations/behind_you1.ogg', 'sound/hallucinations/behind_you2.ogg',
	'sound/hallucinations/far_noise.ogg', 'sound/hallucinations/growl1.ogg',
	'sound/hallucinations/growl2.ogg', 'sound/hallucinations/growl3.ogg',
	'sound/hallucinations/im_here1.ogg', 'sound/hallucinations/im_here2.ogg',
	'sound/hallucinations/i_see_you1.ogg', 'sound/hallucinations/i_see_you2.ogg',
	'sound/hallucinations/look_up1.ogg', 'sound/hallucinations/look_up2.ogg',
	'sound/hallucinations/over_here1.ogg', 'sound/hallucinations/over_here2.ogg',
	'sound/hallucinations/over_here3.ogg', 'sound/hallucinations/turn_around1.ogg',
	'sound/hallucinations/turn_around2.ogg', 'sound/hallucinations/veryfar_noise.ogg',
	'sound/hallucinations/wail.ogg'
	)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/reebe
	id = AMBIENCE_REEBE
	sounds = list(
		'sound/ambience/ambireebe1.ogg',
		'sound/ambience/ambireebe2.ogg',
		'sound/ambience/ambireebe3.ogg'
		)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE


/datum/ambient_sound/beach
	id = AMBIENCE_BEACH
	sounds = list(
		'sound/ambience/shore.ogg',
		'sound/ambience/seag1.ogg',
		'sound/ambience/seag2.ogg',
		'sound/ambience/seag2.ogg',
		'sound/ambience/ambiodd.ogg',
		'sound/ambience/ambinice.ogg'
		)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/vaporwave
	id = AMBIENCE_VAPORWAVE
	sounds = list('sound/ambience/ambivapor1.ogg')
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/ai_core
	id = AMBIENCE_AI_CORE
	sounds = list(
		'sound/ambience/ambimalf.ogg',
		'sound/ambience/ambitech.ogg',
		'sound/ambience/ambitech2.ogg',
		'sound/ambience/ambiatmos.ogg',
		'sound/ambience/ambiatmos2.ogg'
		)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/abandoned_teleporter
	id = AMBIENCE_ABANDONED_TELEPORTER
	sounds = list('sound/ambience/ambimalf.ogg', 'sound/ambience/signal.ogg')
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/signal
	id = AMBIENCE_SIGNAL
	sounds = list('sound/ambience/signal.ogg')
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/psych
	id = AMBIENCE_PSYCH
	sounds = list('sound/ambience/aurora_caelus_short.ogg')
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/detective
	id = AMBIENCE_DETECTIVE
	sounds = list('sound/ambience/ambidet1.ogg','sound/ambience/ambidet2.ogg')
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/forgotten_ship
	id = AMBIENCE_FORGOTTEN_SHIP
	sounds = list('sound/ambience/ambidanger.ogg', 'sound/ambience/ambidanger2.ogg', 'sound/ambience/ambigen9.ogg', 'sound/ambience/ambigen10.ogg')
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/forgotten_cargo
	id = AMBIENCE_FORGOTTEN_CARGO
	sounds = list('sound/ambience/ambigen4.ogg', 'sound/ambience/signal.ogg')
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/forgotten_vault
	id = AMBIENCE_FORGOTTEN_VAULT
	sounds = list('sound/ambience/ambitech2.ogg', 'sound/ambience/ambitech3.ogg')
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/tcomm
	id = AMBIENCE_TCOMM
	sounds = list(
		'sound/ambience/ambisin2.ogg',
		'sound/ambience/signal.ogg',
		'sound/ambience/signal.ogg',
		'sound/ambience/ambigen10.ogg',
		'sound/ambience/ambitech.ogg',
		'sound/ambience/ambitech2.ogg',
		'sound/ambience/ambitech3.ogg',
		'sound/ambience/ambimystery.ogg'
		)
	sound_length = 30 SECONDS
	frequency_time = 30 SECONDS
	frequency_time_high = 90 SECONDS
	loops = FALSE

/datum/ambient_sound/windy
	id = AMBIENCE_WINDY
	sounds = list(
		'sound/effects/wind/wind1.ogg',
		'sound/effects/wind/wind2.ogg',
		'sound/effects/wind/wind3.ogg',
		'sound/effects/wind/wind4.ogg',
		'sound/effects/wind/wind5.ogg',
		'sound/effects/wind/wind6.ogg'
		)
	sound_length = 10 SECONDS
	frequency_time = 10 SECONDS
	frequency_time_high = 12 SECONDS
	loops = FALSE

/datum/ambient_sound/desert
	id = AMBIENCE_DESERT
	sounds = list(
		'sound/effects/wind/desert0.ogg',
		'sound/effects/wind/desert1.ogg',
		'sound/effects/wind/desert2.ogg',
		'sound/effects/wind/desert3.ogg',
		'sound/effects/wind/desert4.ogg',
		'sound/effects/wind/desert5.ogg',
	)
	sound_length = 20 SECONDS
	frequency_time = 20 SECONDS
	frequency_time_high = 24 SECONDS
	loops = FALSE

/datum/ambient_sound/jungle
	id = AMBIENCE_JUNGLE
	sounds = list(
		'sound/ambience/jungle.ogg',
		'sound/ambience/eeriejungle1.ogg',
		'sound/ambience/eeriejungle2.ogg',
	)
	sound_length = 60 SECONDS
	frequency_time = 60 SECONDS
	frequency_time_high = 70 SECONDS
	loops = FALSE
	volume = 15

/datum/ambient_sound/magma
	id = AMBIENCE_MAGMA
	sounds = list('sound/ambience/magma.ogg')
	sound_length = 55 SECONDS
	frequency_time = 55 SECONDS
	loops = TRUE
	volume = 15

/datum/ambient_sound/shrouded
	id = AMBIENCE_SHROUDED
	sounds = list(
		"sound/ambience/spookyspace1.ogg",
		"sound/ambience/spookyspace2.ogg",
	)
	sound_length = 102 SECONDS
	frequency_time = 102 SECONDS
	loops = FALSE

/datum/ambient_sound/tundra
	id = AMBIENCE_TUNDRA
	sounds = list(
		'sound/effects/wind/tundra0.ogg',
		'sound/effects/wind/tundra1.ogg',
		'sound/effects/wind/tundra2.ogg',
		'sound/effects/wind/spooky0.ogg',
		'sound/effects/wind/spooky1.ogg',
	)
	sound_length = 14 SECONDS
	frequency_time = 14 SECONDS
	frequency_time_high = 16 SECONDS
	loops = FALSE

/datum/ambient_sound/gravgen
	id = AMBIENCE_GRAVGEN
	volume = 35
	sounds = list(
		'sound/machines/gravgen/gravgen_mid1.ogg',
		'sound/machines/gravgen/gravgen_mid2.ogg',
		'sound/machines/gravgen/gravgen_mid3.ogg',
		'sound/machines/gravgen/gravgen_mid4.ogg'
		)
	frequency_time = 1.8 SECONDS
	sound_length = 1.8 SECONDS
