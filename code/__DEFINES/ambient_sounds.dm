#define AMBIENCE_LAVA 1
#define AMBIENCE_WATER 2
#define AMBIENCE_HEARTBEAT 3
#define AMBIENCE_SPARKS 4
#define AMBIENCE_THUNDER 5
#define AMBIENCE_STATION_CREAK 6
#define AMBIENCE_FIRE 7
#define AMBIENCE_SERVER 8
#define AMBIENCE_VENDING 9
#define AMBIENCE_GENERIC 10
#define AMBIENCE_HOLY 11
#define AMBIENCE_DANGER 12
#define AMBIENCE_RUINS 13
#define AMBIENCE_ENGI 14
#define AMBIENCE_MINING 15
#define AMBIENCE_MEDICAL 16
#define AMBIENCE_SPOOKY 17
#define AMBIENCE_SPACE 18
#define AMBIENCE_MAINT 19
#define AMBIENCE_AWAY 20
#define AMBIENCE_REEBE 21
#define AMBIENCE_CREEPY 22
#define AMBIENCE_BEACH 23
#define AMBIENCE_VAPORWAVE 24
#define AMBIENCE_AI_CORE 25
#define AMBIENCE_ABANDONED_TELEPORTER 26
#define AMBIENCE_SIGNAL 27
#define AMBIENCE_PSYCH 28
#define AMBIENCE_DETECTIVE 29
#define AMBIENCE_FORGOTTEN_SHIP 30
#define AMBIENCE_FORGOTTEN_CARGO 31
#define AMBIENCE_FORGOTTEN_VAULT 32
#define AMBIENCE_TCOMM 33
#define AMBIENCE_WINDY 34
#define AMBIENCE_DESERT 35
#define AMBIENCE_JUNGLE 36
#define AMBIENCE_MAGMA 37
#define AMBIENCE_SHROUDED 38
#define AMBIENCE_TUNDRA 39
#define AMBIENCE_GRAVGEN 40
#define AMBIENCE_BEEP_CONSOLE 41
#define AMBIENCE_AIR_PUMP 42
#define AMBIENCE_DEEP_INTERCOM 43
#define AMBIENCE_AI_SPACEJAM 44

#define TOTAL_AMBIENT_SOUNDS 44 //KEEP THIS UP TO DATE!


#define AMBIENCE_SWEEP_TIME 3 SECONDS

#define AMBIENCE_LOOPING_EXTRA_QUEUE_TIME 1 SECONDS

#define MAX_AMBIENCE_RANGE 5
#define MAX_DISTANCE_AMBIENCE_SOUND 6

#define AMBIENCE_FALLOFF_DISTANCE 2
#define AMBIENCE_FALLOFF_EXPONENT 1

#define SHIP_AMBIENCE_VOLUME 15

/// For hallucinations
GLOBAL_LIST_INIT(creepy_ambience,list(
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
	'sound/hallucinations/wail.ogg'))
