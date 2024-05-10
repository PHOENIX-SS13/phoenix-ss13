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
	icon_dead = "nymph_dead"
	pass_flags = PASSTABLE | PASSMOB
	mob_biotypes = MOB_ORGANIC | MOB_PLANT
	mob_size = MOB_SIZE_SMALL
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0

	maxHealth = 50
	health = 50

	speak_emote = list("chirrups","sings","hums","chirps","sounds","chitters","peeps","tweets","trills","jabbers")
	emote_hear = list("produces a low hum.","sounds out a low resonation.","produces a very dim series of purple light flashes.")
	emote_see = list("resonates.")

	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "pushes"
	response_disarm_simple = "push"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"

	melee_damage_lower = 5
	melee_damage_upper = 8
	attack_verb_continuous = "with its many little legs furiously rugburns"
	attack_verb_simple = "aggressively attempts to latch onto"
	attack_sound = 'sound/weapons/slice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH

	speed = 0
	stop_automated_movement = FALSE
	turns_per_move = 4

	var/list/donors = list()
	holder_type = /obj/item/clothing/head/mob_holder/diona
	can_collar = TRUE

	a_intent = INTENT_HELP
	var/evolve_donors = 5 //amount of blood donors needed before evolving
	var/awareness_donors = 3 //amount of blood donors needed for understand language
	var/nutrition_need = 500 //amount of nutrition needed before evolving

	var/datum/action/innate/diona/merge/merge_action = new()
	var/datum/action/innate/diona/evolve/evolve_action = new()
	var/datum/action/innate/diona/steal_blood/steal_blood_action = new()

/mob/living/simple_animal/diona/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/diona/update_resting()
	. = ..()
	if(resting)
		icon_state = "[initial(icon_state)]_rest"
	else
		icon_state = "[initial(icon_state)]"
	if(loc != card)
		visible_message(SPAN_NOTICE("[src] [resting? "lays down for a moment..." : "perks up from the ground"]"))

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

/mob/living/simple_animal/diona/attack_hand(mob/living/carbon/human/M)
	//Let people pick the little buggers up.
	if(M.a_intent == INTENT_HELP)
		if(isdiona(M))
			to_chat(M, "You feel your being twine with that of [src] as it merges with your biomass.")
			to_chat(src, "You feel your being twine with that of [M] as you merge with its biomass.")
			throw_alert(GESTALT_ALERT, /atom/movable/screen/alert/nymph, new_master = src) //adds a screen alert that can call resist
			M.throw_alert(NYMPH_ALERT, /atom/movable/screen/alert/gestalt, new_master = src)
			forceMove(M)
		else if(issynthetic(M))
			M.visible_message("<span class='notice'>[M] playfully boops [src] on the head!</span>", "<span class='notice'>You playfully boop [src] on the head!</span>")
		else
			get_scooped(M)
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
		if(ismob(A) || istype(A, /obj/item/holder))
			hasMobs = TRUE
	if(!hasMobs)
		D.status_flags /*&= ~PASSEMOTES*/
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
		to_chat(src, "<span class='warning'>You need to binge on weeds in order to have the energy to grow...</span>")
		return FALSE

	if(isdiona(loc) && !split()) //if it's merged with diona, needs to able to split before evolving
		return FALSE

	visible_message("<span class='danger'>[src] begins to shift and quiver, and erupts in a shower of shed bark as it splits into a tangle of nearly a dozen new dionaea.</span>","<span class='danger'>You begin to shift and quiver, feeling your awareness splinter. All at once, we consume our stored nutrients to surge with growth, splitting into a tangle of at least a dozen new dionaea. We have attained our gestalt form.</span>")

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
	adult.real_name = adult.dna.species.get_random_name()	//I hate this being here of all places but unfortunately dna is based on real_name!

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
