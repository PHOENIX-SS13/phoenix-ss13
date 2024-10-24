/obj/structure/mold/core/classic
	name = "glowing core"
	icon = 'icons/mold/classic/mold_core.dmi'
	icon_state = "blob_core"
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	ambience = AMBIENCE_HEARTBEAT

/obj/structure/mold/core/classic/Initialize()
	. = ..()
	update_appearance()

/obj/structure/mold/core/classic/update_overlays()
	. = ..()
	. += mutable_appearance(icon, "[icon_state]_overlay", appearance_flags = RESET_COLOR)
	. += emissive_appearance(icon, "[icon_state]_overlay")

/obj/structure/mold/resin/classic
	name = "mold"
	desc = "It looks like mold, but it seems alive."
	icon = 'icons/mold/classic/mold_resin.dmi'
	/// Whether we are glowing and applying the glowy overlay
	var/blooming = FALSE

#define RESIN_BLOOM_CHANCE 7

/obj/structure/mold/resin/classic/Initialize()
	. = ..()
	if(prob(RESIN_BLOOM_CHANCE))
		blooming = TRUE
		set_light(2, 1, LIGHT_COLOR_LAVA)
		update_appearance()

#undef RESIN_BLOOM_CHANCE

/obj/structure/mold/resin/classic/update_overlays()
	. = ..()
	if(blooming)
		. += mutable_appearance(icon, "[icon_state]_overlay", appearance_flags = RESET_COLOR)
		. += emissive_appearance(icon, "[icon_state]_overlay")

/obj/structure/mold/structure/bulb
	name = "empty bulb"
	icon = 'icons/mold/classic/mold_bulb.dmi'
	icon_state = "blob_bulb_empty"
	density = FALSE
	layer = TABLE_LAYER
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	max_integrity = 100
	/// Whether the bulb is full.
	var/is_full = FALSE
	/// Turfs we register signals to for proximity checking.
	var/list/registered_turfs = list()

/obj/structure/mold/structure/bulb/update_name()
	. = ..()
	name = is_full ? "glowing bulb" : "empty bulb"

/obj/structure/mold/structure/bulb/update_icon_state()
	. = ..()
	icon_state = is_full ? "blob_bulb_full" : "blob_bulb_empty"

/obj/structure/mold/structure/bulb/update_overlays()
	. = ..()
	if(is_full)
		. += mutable_appearance(icon, "blob_bulb_overlay", appearance_flags = RESET_COLOR)
		. += emissive_appearance(icon, "blob_bulb_overlay")

/obj/structure/mold/structure/bulb/proc/set_full(full_state)
	//Called by a timer, check if we exist
	if(QDELETED(src))
		return
	if(full_state)
		is_full = TRUE
		set_light(2,1,LIGHT_COLOR_LAVA)
		density = TRUE
	else
		is_full = FALSE
		set_light(0)
		density = FALSE
	update_appearance()

/obj/structure/mold/structure/bulb/Initialize()
	. = ..()
	set_full(TRUE)
	for(var/open_turf in get_adjacent_open_turfs(src))
		registered_turfs += open_turf
		RegisterSignal(open_turf, COMSIG_ATOM_ENTERED, PROC_REF(proximity_trigger))

/obj/structure/mold/structure/bulb/proc/proximity_trigger(datum/source, atom/movable/movable_atom)
	if(!isliving(movable_atom))
		return
	var/mob/living/living_mob = movable_atom
	if(!(FACTION_MOLD in living_mob.faction))
		discharge()

/obj/structure/mold/structure/bulb/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	discharge()
	return ..()

/obj/structure/mold/structure/bulb/proc/discharge()
	if(!is_full)
		return
	discharge_effect()
	playsound(src, 'sound/effects/bamf.ogg', 100, TRUE)
	set_full(FALSE)
	addtimer(CALLBACK(src, PROC_REF(set_full), TRUE), 150 SECONDS, TIMER_UNIQUE|TIMER_NO_HASH_WAIT)

/obj/structure/mold/structure/bulb/proc/discharge_effect()
	return

/obj/structure/mold/structure/hatchery
	name = "hatchery"
	icon = 'icons/mold/classic/mold_spawner.dmi'
	icon_state = "blob_spawner"
	density = FALSE
	layer = LOW_OBJ_LAYER
	max_integrity = 150
	/// What monster types can this hatchery make
	var/monster_types
	/// How many monsters at once can this hatchery make
	var/max_spawns = 1
	/// What's the cooldown on making a monster
	var/spawn_cooldown = 60 SECONDS

/obj/structure/mold/structure/hatchery/Initialize()
	. = ..()
	if(!monster_types)
		return
	AddComponent(/datum/component/spawner, monster_types, spawn_cooldown, list(FACTION_MOLD), "emerges from", max_spawns)

/obj/structure/mold/wall/classic
	name = "mold wall"
	desc = "Looks like some kind of thick resin."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "resin_wall-0"
	base_icon_state = "resin_wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_ALIEN_RESIN)
	canSmoothWith = list(SMOOTH_GROUP_ALIEN_RESIN)

/mob/living/simple_animal/hostile/mold
	icon = 'icons/mold/classic/mold_mobs.dmi'
	gold_core_spawnable = HOSTILE_SPAWN
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	see_in_dark = 4
	mob_biotypes = MOB_ORGANIC
	gold_core_spawnable = NO_SPAWN
	vision_range = 5
	aggro_vision_range = 8
	move_to_delay = 6
	faction = list(FACTION_MOLD)

//If you want to change vars regarding all subtypes, do it here
/datum/mold_controller/classic

///Null the color of everything on core death (only resins would survive)
/datum/mold_controller/classic/core_death()
	for(var/obj/structure/mold/resin/classic/mold_thing as anything in all_resin)
		mold_thing.color = null
		mold_thing.blooming = FALSE
		mold_thing.update_appearance()
	return ..()

//Fire mold
/datum/mold_controller/classic/fire
	resin_type = /obj/structure/mold/resin/classic/fire
	wall_type = /obj/structure/mold/wall/classic/fire
	structure_types = list(
		/obj/structure/mold/structure/bulb/fire,
		/obj/structure/mold/structure/hatchery/fire
		)

/obj/structure/mold/core/classic/fire
	controller_type = /datum/mold_controller/classic/fire
	attack_damage_type = BURN
	color = FIRE_MOLD_COLOR
	resistance_flags = FIRE_PROOF

/obj/structure/mold/core/classic/fire/retaliate_effect()
	visible_message(SPAN_WARNING("\The [src] releases a cloud of flames!"))
	var/turf/my_turf = get_turf(src)
	my_turf.atmos_spawn_air("o2=20;plasma=20;TEMP=600")

/obj/structure/mold/resin/classic/fire
	desc = "It looks like mold, but it seems alive. It feels hot to the touch."
	color = FIRE_MOLD_COLOR
	resistance_flags = FIRE_PROOF

/obj/structure/mold/wall/classic/fire
	color = FIRE_MOLD_COLOR
	resistance_flags = FIRE_PROOF

/obj/structure/mold/structure/bulb/fire
	color = FIRE_MOLD_COLOR
	resistance_flags = FIRE_PROOF

/obj/structure/mold/structure/bulb/fire/discharge_effect()
	visible_message(SPAN_WARNING("\The [src] puffs into a cloud of flames!"))
	var/turf/my_turf = get_turf(src)
	my_turf.atmos_spawn_air("o2=20;plasma=20;TEMP=600")

/obj/structure/mold/structure/hatchery/fire
	color = FIRE_MOLD_COLOR
	resistance_flags = FIRE_PROOF
	monster_types = list(/mob/living/simple_animal/hostile/mold/oil_shambler)

/mob/living/simple_animal/hostile/mold/oil_shambler
	name = "oil shambler"
	desc = "Humanoid figure covered in oil, or maybe they're just oil? They seem to be perpetually on fire."
	icon_state = "oil_shambler"
	icon_living = "oil_shambler"
	icon_dead = "oil_shambler"
	speak_emote = list("blorbles")
	emote_hear = list("blorbles")
	speak_chance = 5
	turns_per_move = 4
	maxHealth = 150
	health = 150
	obj_damage = 40
	melee_damage_lower = 10
	melee_damage_upper = 15
	attack_sound = 'sound/effects/attackblob.ogg'
	melee_damage_type = BURN
	del_on_death = TRUE
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_FIRE
	damage_coeff = list(BRUTE = 1, BURN = 0, TOX = 0, CLONE = 1, STAMINA = 0, OXY = 0)
	maxbodytemp = INFINITY
	gender = MALE

/mob/living/simple_animal/hostile/mold/oil_shambler/Initialize()
	. = ..()
	update_appearance()

/mob/living/simple_animal/hostile/mold/oil_shambler/Destroy()
	visible_message(SPAN_WARNING("\The [src] ruptures!"))
	var/datum/reagents/reagents = new/datum/reagents(300)
	reagents.my_atom = src
	reagents.add_reagent(/datum/reagent/napalm, 50)
	chem_splash(loc, 5, list(reagents))
	playsound(src, 'sound/effects/splat.ogg', 50, TRUE)
	return ..()

/mob/living/simple_animal/hostile/mold/oil_shambler/update_overlays()
	. = ..()
	. += mutable_appearance(icon, "oil_shambler_overlay")
	. += emissive_appearance(icon, "oil_shambler_overlay")

/mob/living/simple_animal/hostile/mold/oil_shambler/AttackingTarget()
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		if(prob(20))
			L.fire_stacks += 2
		if(L.fire_stacks)
			L.IgniteMob()

///EMP Mold
/datum/mold_controller/classic/emp
	resin_type = /obj/structure/mold/resin/classic/emp
	wall_type = /obj/structure/mold/wall/classic/emp
	structure_types = list(
		/obj/structure/mold/structure/bulb/emp,
		/obj/structure/mold/structure/hatchery/emp
		)

/obj/structure/mold/core/classic/emp
	controller_type = /datum/mold_controller/classic/emp
	attack_damage_type = BURN
	color = EMP_MOLD_COLOR

/obj/structure/mold/core/classic/emp/retaliate_effect()
	visible_message(SPAN_WARNING("The [src] sends out electrical discharges!"))
	var/turf/my_turf = get_turf(src)
	if(prob(50))
		empulse(src, 3, 4)
		for(var/mob/living/living_mob in get_hearers_in_view(3, my_turf))
			if(living_mob.flash_act(affect_silicon = 1))
				living_mob.Paralyze(20)
				living_mob.Knockdown(20)
			living_mob.soundbang_act(1, 20, 10, 5)
	else
		do_sparks(3, TRUE, src)
		tesla_zap(src, 4, 10000, ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE)

/obj/structure/mold/resin/classic/emp
	desc = "It looks like mold, but it seems alive. You can notice small sparks travelling in the vines."
	color = EMP_MOLD_COLOR

/obj/structure/mold/wall/classic/emp
	color = EMP_MOLD_COLOR

/obj/structure/mold/structure/bulb/emp
	color = EMP_MOLD_COLOR

/obj/structure/mold/structure/bulb/emp/discharge_effect()
	visible_message(SPAN_WARNING("\The [src] puffs into an electrical discharge!"))
	var/turf/my_turf = get_turf(src)
	if(prob(50))
		empulse(src, 3, 4)
		for(var/mob/living/living_mob in get_hearers_in_view(3, my_turf))
			if(living_mob.flash_act(affect_silicon = 1))
				living_mob.Paralyze(20)
				living_mob.Knockdown(20)
			living_mob.soundbang_act(1, 20, 10, 5)
	else
		do_sparks(3, TRUE, src)
		tesla_zap(src, 4, 10000, ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE)

/obj/structure/mold/structure/hatchery/emp
	color = EMP_MOLD_COLOR
	monster_types = list(/mob/living/simple_animal/hostile/mold/electric_mosquito)

/mob/living/simple_animal/hostile/mold/electric_mosquito
	name = "electric mosquito"
	desc = "An ovesized mosquito, with what it seems like electricity inside its body."
	icon_state = "electric_mosquito"
	icon_living = "electric_mosquito"
	icon_dead = "electric_mosquito_dead"
	speak_emote = list("buzzes")
	emote_hear = list("buzzes")
	speak_chance = 5
	turns_per_move = 4
	maxHealth = 70
	health = 70
	obj_damage = 20
	melee_damage_lower = 5
	melee_damage_upper = 6
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"
	attack_sound = 'sound/effects/attackblob.ogg'
	melee_damage_type = BRUTE
	pass_flags = PASSTABLE

/mob/living/simple_animal/hostile/mold/electric_mosquito/AttackingTarget()
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		carbon_target.reagents.add_reagent(/datum/reagent/teslium, 2)

///Fungus Mold
/datum/mold_controller/classic/fungus
	resin_type = /obj/structure/mold/resin/classic/fungus
	wall_type = /obj/structure/mold/wall/classic/fungus
	structure_types = list(
		/obj/structure/mold/structure/bulb/fungus,
		/obj/structure/mold/structure/hatchery/fungus
		)

/obj/structure/mold/core/classic/fungus
	controller_type = /datum/mold_controller/classic/fungus
	color = FUNGUS_MOLD_COLOR

/obj/structure/mold/core/classic/fungus/retaliate_effect()
	visible_message(SPAN_WARNING("\The [src] emitts a cloud!"))
	var/datum/reagents/reagents = new/datum/reagents(300)
	reagents.my_atom = src
	reagents.add_reagent(/datum/reagent/cordycepsspores, 50)
	var/datum/effect_system/smoke_spread/chem/smoke = new()
	smoke.set_up(reagents, 5)
	smoke.attach(src)
	smoke.start()

/obj/structure/mold/resin/classic/fungus
	desc = "It looks like mold, but it seems alive. It looks like it's rotting."
	color = FUNGUS_MOLD_COLOR

/obj/structure/mold/wall/classic/fungus
	color = FUNGUS_MOLD_COLOR

/obj/structure/mold/structure/bulb/fungus
	color = FUNGUS_MOLD_COLOR

/obj/structure/mold/structure/bulb/fungus/discharge_effect()
	visible_message(SPAN_WARNING("\The [src] puffs into a cloud!"))
	var/datum/reagents/reagents = new/datum/reagents(300)
	reagents.my_atom = src
	reagents.add_reagent(/datum/reagent/cordycepsspores, 50)
	var/datum/effect_system/smoke_spread/chem/smoke = new()
	smoke.set_up(reagents, 5)
	smoke.attach(src)
	smoke.start()

/obj/structure/mold/structure/hatchery/fungus
	color = FUNGUS_MOLD_COLOR
	monster_types = list(/mob/living/simple_animal/hostile/mold/diseased_rat)

/mob/living/simple_animal/hostile/mold/diseased_rat
	name = "diseased rat"
	desc = "An incredibly large, rabid looking rat. There's shrooms growing out of it"
	icon_state = "diseased_rat"
	icon_living = "diseased_rat"
	icon_dead = "diseased_rat_dead"
	speak_emote = list("chitters")
	emote_hear = list("chitters")
	speak_chance = 5
	turns_per_move = 4
	maxHealth = 70
	health = 70
	obj_damage = 30
	melee_damage_lower = 7
	melee_damage_upper = 13
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	pass_flags = PASSTABLE
	butcher_results = list(/obj/item/food/meat/slab = 1)
	attack_sound = 'sound/weapons/bite.ogg'
	melee_damage_type = BRUTE

/datum/disease/cordyceps
	form = "Disease"
	name = "Cordyceps omniteralis"
	max_stages = 5
	spread_text = "Airborne"
	cure_text = "Spaceacillin & Convermol"
	cures = list(/datum/reagent/medicine/spaceacillin, /datum/reagent/medicine/c2/convermol)
	agent = "Fungal Cordycep bacillus"
	viable_mobtypes = list(/mob/living/carbon/human)
	cure_chance = 30
	desc = "Fungal virus that attacks patient's muscles and brain in an attempt to hijack them. Causes fever, headaches, muscle spasms, and fatigue."
	severity = DISEASE_SEVERITY_BIOHAZARD
	bypasses_immunity = TRUE

/datum/disease/cordyceps/stage_act()
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(prob(2))
				affected_mob.emote("twitch")
				to_chat(affected_mob, SPAN_DANGER("You twitch."))
			if(prob(2))
				to_chat(affected_mob, SPAN_DANGER("Your feel tired"))
			if(prob(5))
				to_chat(affected_mob, SPAN_DANGER("You head hurts."))
		if(3,4)
			if(prob(2))
				to_chat(affected_mob, SPAN_USERDANGER("You see four of everything!"))
				affected_mob.Dizzy(5)
			if(prob(2))
				to_chat(affected_mob, SPAN_DANGER("You suddenly feel exhausted."))
				affected_mob.adjustStaminaLoss(30, FALSE)
			if(prob(2))
				to_chat(affected_mob, SPAN_DANGER("You feel hot."))
				affected_mob.adjust_bodytemperature(20)
		if(5)
			if(prob(5))
				to_chat(affected_mob, SPAN_USERDANGER("[pick("Your muscles seize!", "You collapse!")]"))
				affected_mob.adjustStaminaLoss(50, FALSE)
				affected_mob.Paralyze(40, FALSE)
				affected_mob.adjustBruteLoss(5) //It's damaging the muscles
			if(prob(2))
				affected_mob.adjustStaminaLoss(100, FALSE)
				affected_mob.visible_message(SPAN_WARNING("[affected_mob] faints!"), SPAN_USERDANGER("You surrender yourself and feel at peace..."))
				affected_mob.AdjustSleeping(100)
			if(prob(5))
				to_chat(affected_mob, SPAN_USERDANGER("You feel your mind relax and your thoughts drift!"))
				affected_mob.set_confusion(min(100, affected_mob.get_confusion() + 8))
				affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
			if(prob(10))
				to_chat(affected_mob, SPAN_DANGER("[pick("You feel uncomfortably hot...", "You feel like unzipping your jumpsuit", "You feel like taking off some clothes...")]"))
				affected_mob.adjust_bodytemperature(30)

/datum/reagent/cordycepsspores
	name = "Cordycep bacillus microbes"
	description = "Active fungal spores."
	color = "#92D17D"
	chemical_flags = NONE
	taste_description = "slime"
	penetrates_skin = NONE

/datum/reagent/cordycepsspores/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT)) || ((methods & VAPOR) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/cordyceps(), FALSE, TRUE)

///Toxic Mold - low effort kinda
/datum/mold_controller/classic/toxic
	resin_type = /obj/structure/mold/resin/classic/toxic
	wall_type = /obj/structure/mold/wall/classic/toxic
	structure_types = list(
		/obj/structure/mold/structure/bulb/toxic,
		/obj/structure/mold/structure/hatchery/toxic
		)

/obj/structure/mold/core/classic/toxic
	controller_type = /datum/mold_controller/classic/toxic
	color = TOXIC_MOLD_COLOR

/obj/structure/mold/core/classic/toxic/retaliate_effect()
	visible_message(SPAN_WARNING("\The [src] spews out a foam!"))
	var/turf/my_turf = get_turf(src)
	var/datum/reagents/reagents = new/datum/reagents(300)
	reagents.my_atom = src
	reagents.add_reagent(/datum/reagent/toxin, 30)
	var/datum/effect_system/foam_spread/foam = new
	foam.set_up(40, my_turf, reagents)
	foam.start()

/obj/structure/mold/resin/classic/toxic
	desc = "It looks like mold, but it seems alive. It looks like it's rotting."
	color = TOXIC_MOLD_COLOR

/obj/structure/mold/wall/classic/toxic
	color = TOXIC_MOLD_COLOR

/obj/structure/mold/structure/bulb/toxic
	color = TOXIC_MOLD_COLOR

/obj/structure/mold/structure/bulb/toxic/discharge_effect()
	visible_message(SPAN_WARNING("\The [src] puffs into a foam!"))
	var/turf/my_turf = get_turf(src)
	var/datum/reagents/reagents = new/datum/reagents(300)
	reagents.my_atom = src
	reagents.add_reagent(/datum/reagent/toxin, 30)
	var/datum/effect_system/foam_spread/foam = new
	foam.set_up(40, my_turf, reagents)
	foam.start()

/obj/structure/mold/structure/hatchery/toxic
	color = TOXIC_MOLD_COLOR
	monster_types = list(/mob/living/simple_animal/hostile/giant_spider)
