// The language of the diona, basically picture a bunch of flood forms but made of tree bark and friendly
/datum/language/diona
	name = "Nymphsong" // formerly rootsong/rootspeak... but diona don't have roots, so we changed it
	desc = "It seems to operate via oscillating sine and cosine waves in a variety of mediums. \
	Pressure and electromagnetic spectra are the most common. The larger the collective, generally \
	speaking, the larger the wavelength. While nymphs prefer to use ultrasound and low-level x-rays, \
	collectives of humanoid scale prefer sound and ultraviolet light. Larger gestalts make use of \
	infrared light and infrasound while in atmospheres, while the largest documented have been known \
	to reach into the radio spectrum."
	key = "di"
	icon_state = "diona"
	//speech_verb = "creaks and rustles"
	//ask_verb = "creaks"
	//exclaim_verbs = list("rustles")
	//colour = "diona"
	space_chance = 20
	default_priority = 90
	syllables = list(
		"hs","zt","kr","st","sh"
	)

/datum/language/diona/get_random_name()
	var/new_name
	if(prob(90))
		new_name += "[pick(GLOB.names_dionae_first_prefix)]"
	if(prob(80))
		new_name += "[pick(GLOB.names_dionae_first)]"
	if(prob(100))
		new_name += "[pick(GLOB.names_dionae_first_suffix)]"
	if(prob(30))
		new_name += "[pick(GLOB.names_dionae_middle_prefix)]"
	if(prob(80))
		new_name += "[pick(GLOB.names_dionae_middle)]"
		if(prob(90))
			new_name += "[pick(GLOB.names_dionae_last_prefix)]"
		if(prob(70))
			new_name += "[pick(GLOB.names_dionae_last)]"
		if(prob(90))
			new_name += "[pick(GLOB.names_dionae_last_suffix)]"
	new_name = replacetext(new_name,"eing","ing")
	new_name = replacetext(new_name,"nying","nizing")
	new_name = replacetext(new_name,"sss","sses")
	new_name = replacetext(new_name,"ys","ies")
	new_name = replacetext(new_name,"stills","still")
	new_name = replacetext(new_name,"stilling","still")
	new_name = replacetext(new_name,"songing","singing")
	new_name = replacetext(new_name,"heiring","heir")
	new_name = replacetext(new_name,"puritying","purifying")
	new_name = replacetext(new_name,"restorationing","restoring")
	new_name = replacetext(new_name,"elementing","element")
	new_name = replacetext(new_name,"nymphing","nymph")
	new_name = replacetext(new_name,"hiving","hive")
	new_name = replacetext(new_name,"gestalting","gestalt")
	new_name = replacetext(new_name,"unioning","unifying")
	new_name = replacetext(new_name,"unitying","uniting")
	new_name = replacetext(new_name,"wander's","wanderer's")
	new_name = replacetext(new_name,"soothefall","Soothing Autumn")
	new_name = replacetext(new_name,"undeathing","undying")
	new_name = replacetext(new_name,"tentativing","tentative")
	new_name = replacetext(new_name,"tentativefall","tentative")
	new_name = replacetext(new_name,"ings","ing")
	new_name = replacetext(new_name,"ings","ing")
	return new_name
