/*
 * Tiny babby plant critter plus procs.
 */

//Mob defines.
#define GESTALT_ALERT "gestalt screen alert"
#define NYMPH_ALERT "nymph screen alert"

/mob/living/simple_animal/diona
	name = "diona nymph"
	icon = 'icons/mob/monkey.dmi'
	icon_state = "nymph"
	icon_living = "nymph"
	var/icon_resting = "nymph_rest"
	icon_dead = "nymph_dead"
	pass_flags = PASSTABLE | PASSMOB
	mob_biotypes = MOB_ORGANIC | MOB_PLANT
	mob_size = MOB_SIZE_SMALL
	density = FALSE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0

	/// Flavor text announced to nymphs on [/mob/proc/Login]
	var/flavortext = \
	"<span class='notice'>Diona nymphs are a ghost role that are allowed to fix the station and build things. Interfering with the round as a drone is against the rules.</span>\n"+\
	"<span class='notice'>Actions that constitute interference include, but are not limited to:</span>\n"+\
	"<span class='notice'>     - Interacting with round critical objects (IDs, weapons, contraband, powersinks, bombs, etc.)</span>\n"+\
	"<span class='notice'>     - Interacting with living beings (communication, attacking, healing, etc.)</span>\n"+\
	"<span class='notice'>     - Interacting with non-living beings (dragging bodies, looting bodies, etc.)</span>\n"+\
	"<span class='warning'>These rules are at admin discretion and will be heavily enforced.</span>\n"+\
	"<span class='warning'><u>If you do not have the regular drone laws, follow your laws to the best of your ability.</u></span>\n"+\
	"<span class='notice'>Prefix your message with :b to speak in Drone Chat.</span>\n"

	maxHealth = 50
	health = 50
	damage_coeff = list(BRUTE = 1, BURN = 1.5, TOX = 1, CLONE = 0, STAMINA = 1, OXY = 1)
	faction = list("neutral", FACTIONS_PLANT)
	initial_language_holder = /datum/language_holder/plant/nymph
	gender = NEUTER
	speak_emote = list("chirrups","sings","hums","chirps","sounds","chitters","peeps","tweets","trills","jabbers")
	emote_hear = list("produces a low hum.","sounds out a low resonation.","produces a very dim series of purple light flashes.")
	emote_see = list("resonates.")

	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "pushes"
	response_disarm_simple = "push"
	response_harm_continuous = "strikes"
	response_harm_simple = "strike"
	deathmessage = "becomes inert."

	butcher_results = /obj/item/food/meat/slab/human/mutant/plant

	melee_damage_lower = 5
	melee_damage_upper = 8
	attack_verb_continuous = "with its many little legs furiously rugburns"
	attack_verb_simple = "aggressively attempts to latch onto"
	attack_sound = 'sound/weapons/slice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH

	speed = 0
	stop_automated_movement = FALSE
	turns_per_move = 4

	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	gold_core_spawnable = FRIENDLY_SPAWN
	can_be_held = TRUE
	worn_slot_flags = ITEM_SLOT_HEAD

	var/list/donors = list()
	//can_collar = TRUE

	var/evolve_donors = 5 //amount of blood donors needed before evolving
	var/awareness_donors = 3 //amount of blood donors needed for understand language
	var/nutrition_need = 500 //amount of nutrition needed before evolving

	var/datum/action/innate/diona/merge/merge_action = new()
	var/datum/action/innate/diona/evolve/evolve_action = new()
	var/datum/action/innate/diona/steal_blood/steal_blood_action = new()

/mob/living/simple_animal/diona/Initialize()
	. = ..()
	add_verb(src, /mob/living/proc/toggle_resting)
	add_cell_sample()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/diona/Login()
	. = ..()
	if(!. || !client)
		return FALSE

	if(flavortext)
		to_chat(src, "[flavortext]")

/mob/living/simple_animal/diona/auto_deadmin_on_login()
	if(!client?.holder)
		return TRUE
	if(CONFIG_GET(flag/auto_deadmin_players) || (client.prefs?.toggles))
		return client.holder.auto_deadmin()
	return ..()

/mob/living/simple_animal/diona/add_cell_sample()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_GRAPE, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/mob/living/simple_animal/diona/original/add_cell_sample()
	return

/mob/living/simple_animal/diona/update_resting()
	. = ..()
	if(stat == DEAD)
		return
	if(resting)
		icon_state = icon_resting
	else
		icon_state = "[initial(icon_state)]"
	regenerate_icons()

/mob/living/simple_animal/diona/Life(delta_time = SSMOBS_DT, times_fired)
	if(!stat && !buckled && !client)
		if(DT_PROB(0.5, delta_time))
			manual_emote(pick("lays down for a moment...", "grows still and silent momentarily...", "loses track of time, daydreaming..."))
			set_resting(TRUE)
		else if(DT_PROB(0.5, delta_time))
			manual_emote(pick("conceals its sensory organs by curling up into a little ball.", "sploots on the ground, all its little limbs spreading out.", "concentrates on a spot on the floor."))
			set_resting(TRUE)
		else if(DT_PROB(0.5, delta_time))
			if (resting)
				manual_emote(pick("perks up from the ground.", "rises to its tiny legs and and scuttles around in a circle.", "stops resting."))
				set_resting(FALSE)
			else
				manual_emote(pick("chirps and vibrates.", "emits an earthy thrum.", "produces tiny flashes of light."))

/datum/action/innate/diona/merge
	name = "Merge with gestalt"
	icon_icon = 'icons/mob/species/diona_parts.dmi'
	button_icon_state = "preview"

/datum/action/innate/diona/merge/Activate()
	var/mob/living/simple_animal/diona/user = owner
	user.merge()

/datum/action/innate/diona/evolve
	name = "Evolve"
	icon_icon = 'icons/obj/machines/cloning.dmi'
	button_icon_state = "pod_cloning"

/datum/action/innate/diona/evolve/Activate()
	var/mob/living/simple_animal/diona/user = owner
	user.evolve()

/datum/action/innate/diona/steal_blood
	name = "Steal blood"
	icon_icon = 'icons/obj/bloodpack.dmi'
	button_icon_state = "chempack"

/datum/action/innate/diona/steal_blood/Activate()
	var/mob/living/simple_animal/diona/user = owner
	user.steal_blood()

/mob/living/simple_animal/diona/New()
	..()
	if(name == initial(name)) //To stop Pun-Pun becoming generic.
		name = "[name] ([rand(1, 1000)])"
		real_name = name
	grant_language(/datum/language/diona, TRUE, TRUE, LANGUAGE_MIND)
	merge_action.Grant(src)
	evolve_action.Grant(src)
	steal_blood_action.Grant(src)

/mob/living/simple_animal/diona/UnarmedAttack(atom/A)
	if(isdiona(A) && (src in A.contents)) //can't attack your gestalt
		visible_message("[src] wiggles around a bit.")
	else
		..()

/mob/living/simple_animal/diona/resist()
	if(!split())
		..()

/mob/living/simple_animal/diona/attack_hand(mob/living/user, list/modifiers)
	//Let people pick the little buggers up.
	if(!user.combat_mode)
		if(isdiona(user))
			to_chat(user, "You feel your being twine with that of [src] as it merges with your biomass.")
			to_chat(src, "You feel your being twine with that of [user] as you merge with its biomass.")
			throw_alert(GESTALT_ALERT, /atom/movable/screen/alert/nymph, new_master = src) //adds a screen alert that can call resist
			user.throw_alert(NYMPH_ALERT, /atom/movable/screen/alert/gestalt, new_master = src)
			forceMove(user)
		else if(issilicon(user))
			user.visible_message("<span class='notice'>[user] playfully boops [src] on the head!</span>", "<span class='notice'>You playfully boop [src] on the head!</span>")
		else
			if(ishuman(user))
				if(stat == DEAD || status_flags & GODMODE || !can_be_held)
					..()
					return
				if(user.get_active_held_item())
					to_chat(user, SPAN_WARNING("Your hands are full!"))
					return
				visible_message(SPAN_WARNING("[user] starts picking up [src]."), \
								SPAN_USERDANGER("[user] starts picking you up!"))
				if(!do_after(user, 20, target = src))
					return
				visible_message(SPAN_WARNING("[user] picks up [src]!"), \
								SPAN_USERDANGER("[user] picks you up!"))
				if(buckled)
					to_chat(user, SPAN_WARNING("[src] is buckled to [buckled] and cannot be picked up!"))
					return
				to_chat(user, SPAN_NOTICE("You pick [src] up."))
				drop_all_held_items()
				var/obj/item/clothing/head/mob_holder/diona/DH = new(get_turf(src), src)
				DH.slot_flags = worn_slot_flags
				user.put_in_hands(DH)
	else
		..()

/mob/living/simple_animal/diona/proc/merge()
	if(stat != CONSCIOUS)
		return FALSE

	var/list/choices = list()
	for(var/mob/living/carbon/human/H in view(1,src))
		if(!(Adjacent(H)) || !isdiona(H))
			continue
		choices += H

	if(!length(choices))
		to_chat(src, "<span class='warning'>No suitable diona nearby.</span>")
		return FALSE

	var/mob/living/M = tgui_input_list(src, "Who do you wish to merge with?", "Nymph Merging", choices)

	if(!M || !src || !(Adjacent(M)) || stat != CONSCIOUS) //input can take a while, so re-validate
		return FALSE

	if(isdiona(M))
		to_chat(M, "You feel your being twine with that of [src] as it merges with your biomass.")
		M.status_flags |= PASSEMOTES
		to_chat(src, "You feel your being twine with that of [M] as you merge with its biomass.")
		forceMove(M)
		throw_alert(GESTALT_ALERT, /atom/movable/screen/alert/nymph, new_master = src) //adds a screen alert that can call resist
		M.throw_alert(NYMPH_ALERT, /atom/movable/screen/alert/gestalt, new_master = src)
		return TRUE
	else
		return FALSE

/mob/living/simple_animal/diona/proc/split(forced = FALSE)
	if((stat != CONSCIOUS && !forced) || !isdiona(loc))
		return FALSE
	var/mob/living/carbon/human/D = loc
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	to_chat(loc, "You feel a pang of loss as [src] splits away from your biomass.")
	to_chat(src, "You wiggle out of the depths of [loc]'s biomass and plop to the ground.")
	forceMove(T)

	var/hasMobs = FALSE
	for(var/atom/A in D.contents)
		if(ismob(A) || istype(A, /obj/item/clothing/head/mob_holder))
			hasMobs = TRUE
	if(!hasMobs)
		D.status_flags &= ~PASSEMOTES
		D.clear_alert(NYMPH_ALERT)

	clear_alert(GESTALT_ALERT)
	return TRUE

/mob/living/simple_animal/diona/proc/evolve()
	if(stat != CONSCIOUS)
		return FALSE

	if(length(donors) < evolve_donors)
		to_chat(src, "<span class='warning'>You need more blood in order to ascend to a new state of consciousness...</span>")
		return FALSE

	if(nutrition < nutrition_need)
		to_chat(src, "<span class='warning'>You need to binge in order to have the energy to grow...</span>")
		return FALSE

	if(isdiona(loc) && !split()) //if it's merged with dionae, needs to able to split before evolving
		return FALSE

	visible_message("<span class='danger'>[src] begins to shift and quiver, and erupts in a shower of shed bark as it splits into a tangle of nearly a dozen new dionae.</span>","<span class='danger'>You begin to shift and quiver, feeling your awareness splinter. All at once, we consume our stored nutrients to surge with growth, splitting into a tangle of at least a dozen new dionae. We have attained our gestalt form.</span>")

	var/mob/living/carbon/human/species/diona/adult = new(get_turf(loc))
	adult.set_species(/datum/species/diona)

	if(istype(loc, /obj/item/clothing/head/mob_holder/diona))
		var/obj/item/clothing/head/mob_holder/diona/L = loc
		forceMove(L.loc)
		qdel(L)

	for(var/datum/language/L in languages)
		adult.grant_language(L.name)
	adult.regenerate_icons()

	adult.name = "diona ([rand(100,999)])"
	adult.real_name = adult.name
	adult.ckey = ckey
	adult.real_name = adult.dna.species.random_name() //I hate this being here of all places but unfortunately dna is based on real_name!

	for(var/obj/item/W in contents)
		doUnEquip(W)

	qdel(src)
	return TRUE

// Consumes plant matter other than weeds to evolve
/mob/living/simple_animal/diona/proc/consume(obj/item/food/G)
	if(nutrition >= nutrition_need) // Prevents griefing by overeating plant items without evolving.
		to_chat(src, "<span class='warning'>You're too full to consume this! Perhaps it's time to grow bigger...</span>")
	else
		if(do_after(src, 20, target = G))
			visible_message("[src] ravenously consumes [G].", "You ravenously devour [G].")
			playsound(loc, 'sound/items/eatfood.ogg', 30, 0, frequency = 1.5)
			if(G.reagents.get_reagent_amount("nutriment") + G.reagents.get_reagent_amount("vitamin") < 1)
				adjust_nutrition(2)
			else
				adjust_nutrition((G.reagents.get_reagent_amount("nutriment") + G.reagents.get_reagent_amount("vitamin")) * 2)
			qdel(G)

/mob/living/simple_animal/diona/proc/steal_blood()
	if(stat != CONSCIOUS)
		return FALSE

	var/list/choices = list()
	for(var/mob/living/carbon/human/H in oview(1,src))
		if(Adjacent(H) && H.dna && !(NOBLOOD in H.dna.species.species_traits))
			choices += H

	if(!length(choices))
		to_chat(src, "<span class='warning'>No suitable blood donors nearby.</span>")
		return FALSE

	var/mob/living/carbon/human/M = tgui_input_list(src, "Who do you wish to take a sample from?", "Blood Sampling", choices)

	if(!M || !src || !(Adjacent(M)) || stat != CONSCIOUS) //input can take a while, so re-validate
		return FALSE

	if(!M.dna || (NOBLOOD in M.dna.species.species_traits))
		to_chat(src, "<span class='warning'>That donor has no blood to take.</span>")
		return FALSE

	if(donors.Find(M.real_name))
		to_chat(src, "<span class='warning'>That donor offers you nothing new.</span>")
		return FALSE

	visible_message("<span class='danger'>[src] flicks out a feeler and neatly steals a sample of [M]'s blood.</span>","<span class='danger'>You flick out a feeler and neatly steal a sample of [M]'s blood.</span>")
	donors += M.real_name
	for(var/datum/language/L in M.languages)
		if(!(L.flags & HIVEMIND))
			languages |= L

	spawn(25)
		update_progression()

/mob/living/simple_animal/diona/proc/update_progression()
	if(stat != CONSCIOUS || !length(donors))
		return FALSE

	if(length(donors) == evolve_donors)
		to_chat(src, "<span class='noticealien'>You feel ready to move on to your next stage of growth.</span>")
	else if(length(donors) == awareness_donors)
		universal_understand = TRUE
		to_chat(src, "<span class='noticealien'>You feel your awareness expand, and realize you know how to understand the creatures around you.</span>")
	else
		to_chat(src, "<span class='noticealien'>The blood seeps into your small form, and you draw out the echoes of memories and personality from it, working them into your budding mind.</span>")


/mob/living/simple_animal/diona/put_in_hands(obj/item/W)
	W.forceMove(get_turf(src))
	W.layer = initial(W.layer)
	W.plane = initial(W.plane)
	W.dropped()

/mob/living/simple_animal/diona/put_in_active_hand(obj/item/W)
	to_chat(src, "<span class='warning'>You don't have any hands!</span>")
	return

/mob/living/simple_animal/diona/CheckParts(list/parts)
	..()
	var/obj/item/organ/brain/B = locate(/obj/item/organ/brain) in contents
	if(!B || !B.brainmob || !B.brainmob.mind)
		return
	B.brainmob.mind.transfer_to(src)
	to_chat(src, "<span class='big bold'>You are a diona nymph!</span><b> You're a harmless cat/cake hybrid that everyone loves. People can take bites out of you if they're hungry, but you regenerate health \
	so quickly that it generally doesn't matter. You're remarkably resilient to any damage besides this and it's hard for you to really die at all. You should go around and bring happiness and \
	free cake to the station!</b>")
	var/new_name = stripped_input(src, "Enter your name, or press \"Cancel\" to stick with Keeki.", "Name Change")
	if(new_name)
		to_chat(src, SPAN_NOTICE("Your name is now <b>\"new_name\"</b>!"))
		name = new_name

#undef GESTALT_ALERT
#undef NYMPH_ALERT
