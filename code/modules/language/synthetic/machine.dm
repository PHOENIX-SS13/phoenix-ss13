/datum/language/machine
	name = "Encoded Audio Language"
	desc = "An efficient language of encoded tones developed by synthetics and cyborgs."
	key = "m"
	icon_state = "eal"
	spans = list(SPEECH_SPAN_ROBOT)
	space_chance = 10
	default_priority = 90
	flags = NO_STUTTER
	syllables = list(
	"beep","beep","beep","beep","beep","boop","boop","boop","bop","bop","dee","dee",
	"doo","doo","hiss","hss","buzz","buzz","bzz","ksssh","keey","wurr","wahh","tzzz"
	)

/datum/language/machine/get_random_name()
	if(prob(70))
		return "[pick(GLOB.posibrain_names)]-[rand(100, 9999)]"
	return pick(GLOB.ai_names)
