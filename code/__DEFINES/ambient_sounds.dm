#define AMBIENCE_LAVA 1
#define AMBIENCE_WATER 2
#define AMBIENCE_HEARTBEAT 3
#define AMBIENCE_SPARKS 4
#define AMBIENCE_THUNDER 5
#define AMBIENCE_STATION_CREAK 6
#define AMBIENCE_FIRE 7
#define AMBIENCE_CRUNCHY_SERVER 8
#define AMBIENCE_SERVER 9
#define AMBIENCE_VENDING 10
#define AMBIENCE_GENERIC 11
#define AMBIENCE_HOLY 12
#define AMBIENCE_DANGER 13
#define AMBIENCE_RUINS 14
#define AMBIENCE_ENGI 15
#define AMBIENCE_MINING 16
#define AMBIENCE_MEDICAL 17
#define AMBIENCE_SPOOKY 18
#define AMBIENCE_SPACE 19
#define AMBIENCE_MAINT 20
#define AMBIENCE_AWAY 21
#define AMBIENCE_REEBE 22
#define AMBIENCE_CREEPY 23
#define AMBIENCE_BEACH 24
#define AMBIENCE_VAPORWAVE 25
#define AMBIENCE_AI_CORE 26
#define AMBIENCE_ABANDONED_TELEPORTER 27
#define AMBIENCE_SIGNAL 28
#define AMBIENCE_PSYCH 29
#define AMBIENCE_DETECTIVE 30
#define AMBIENCE_FORGOTTEN_SHIP 31
#define AMBIENCE_FORGOTTEN_CARGO 32
#define AMBIENCE_FORGOTTEN_VAULT 33
#define AMBIENCE_TCOMM 34
#define AMBIENCE_WINDY 35
#define AMBIENCE_DESERT 36
#define AMBIENCE_JUNGLE 37
#define AMBIENCE_MAGMA 38
#define AMBIENCE_SHROUDED 39
#define AMBIENCE_TUNDRA 40
#define AMBIENCE_GRAVGEN 41

#define TOTAL_AMBIENT_SOUNDS 41 //KEEP THIS UP TO DATE!


#define AMBIENCE_SWEEP_TIME 3 SECONDS

#define AMBIENCE_QUEUE_TIME 4 SECONDS

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
