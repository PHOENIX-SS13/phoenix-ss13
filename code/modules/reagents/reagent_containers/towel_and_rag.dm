/obj/item/reagent_containers/rag
	name = "damp rag"
	desc = "For cleaning up messes, you suppose."
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/toy.dmi'
	icon_state = "rag"
	item_flags = NOBLUDGEON
	reagent_flags = OPENCONTAINER
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list()
	volume = 5
	spillable = FALSE
	var/wipe_sound
	var/extinguish_efficiency = 1

/obj/item/reagent_containers/rag/examine(mob/user)
	. = ..()
	. += SPAN_NOTICE("You can smother people with it by right-clicking.")
	. += SPAN_NOTICE("You can rub reagents on people with it by left-clicking.")
	. += SPAN_NOTICE("You can extinguish people with it by left-clicking.")
	. += SPAN_NOTICE("You can wring it dry it by alt-clicking.")

/obj/item/reagent_containers/rag/AltClick(mob/living/user)
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		return
	if(!reagents.total_volume)
		to_chat(user, SPAN_WARNING("\The [src] is dry!"))
		return
	user.visible_message(SPAN_NOTICE("[user] wrings \the [src] dry."), "You wring \the [src] dry.")
	reagents.clear_reagents()

/obj/item/reagent_containers/rag/suicide_act(mob/user)
	user.visible_message(SPAN_SUICIDE("[user] is smothering [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (OXYLOSS)

/obj/item/reagent_containers/rag/afterattack(atom/target_atom, mob/living/user, proximity, params)
	. = ..()
	if(!proximity)
		return
	/// If putting a towel in a bin you won't get a true return value and still attempt to clean it. Pain
	if(.)
		return
	. = TRUE
	var/list/modifiers = params2list(params)
	if(iscarbon(target_atom))
		var/mob/living/carbon/target_carbon = target_atom
		if(reagents?.total_volume)
			var/reagentlist = pretty_string_from_reagent_list(reagents)
			var/log_object = "containing [reagentlist]"
			if(LAZYACCESS(modifiers, RIGHT_CLICK) && !target_carbon.is_mouth_covered())
				reagents.trans_to(target_carbon, reagents.total_volume, transfered_by = user, methods = INGEST)
				target_carbon.visible_message(SPAN_DANGER("[user] smothers \the [target_carbon] with \the [src]!"), SPAN_USERDANGER("[user] smothers you with \the [src]!"), SPAN_HEAR("You hear some struggling and muffled cries of surprise."))
				log_combat(user, target_carbon, "smothered", src, log_object)
				return
			else
				if(target_carbon.on_fire)
					pat_flames_out(target_carbon, user)
					return
				touch_mob(target_carbon, user)
				target_carbon.visible_message(SPAN_NOTICE("[user] touches \the [target_carbon] with \the [src]."))
				log_combat(user, target_carbon, "touched", src, log_object)
				return
		if(target_carbon.on_fire)
			pat_flames_out(target_carbon, user)
			return
		wipe_clean_atom(target_carbon, user)
	else
		wipe_clean_atom(target_atom, user)

/obj/item/reagent_containers/rag/proc/wipe_clean_atom(atom/cleaned_atom, mob/living/user)
	user.visible_message(SPAN_NOTICE("[user] starts to wipe down [cleaned_atom] with [src]!"), SPAN_NOTICE("You start to wipe down [cleaned_atom] with [src]..."))
	if(do_after(user,30, target = cleaned_atom))
		user.visible_message(SPAN_NOTICE("[user] finishes wiping off [cleaned_atom]!"), SPAN_NOTICE("You finish wiping off [cleaned_atom]."))
		if(wipe_sound)
			playsound(cleaned_atom, wipe_sound, 25, 1)
		cleaned_atom.wash(CLEAN_SCRUB)

/obj/item/reagent_containers/rag/proc/pat_flames_out(mob/living/target, mob/living/user)
	user.visible_message(SPAN_WARNING("\The [user] pats out [target == user ? "[user.p_their()]" : "\the [target]'s"] flames with \the [src]!"))
	playsound(target, 'sound/items/towelwipe.ogg', 25, 1)
	target.adjust_fire_stacks(-extinguish_efficiency)
	touch_mob(target, user)

/obj/item/reagent_containers/rag/proc/touch_mob(mob/living/target, mob/living/user)
	reagents.expose(target, TOUCH)
	reagents.clear_reagents()

/obj/item/reagent_containers/rag/towel
	name = "towel"
	desc = "A soft cotton towel."
	slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_HEAD|ITEM_SLOT_OCLOTHING
	icon_state = "towel"
	icon = 'icons/obj/items/towel/towel.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	item_flags = NOBLUDGEON | NO_STRAPS_NEEDED
	worn_icon_state = "towel"
	worn_icon = 'icons/obj/items/towel/towel_worn.dmi'
	inhand_icon_state = "towel"
	lefthand_file = 'icons/obj/items/towel/towel_lefthand.dmi'
	righthand_file = 'icons/obj/items/towel/towel_righthand.dmi'
	hitsound = 'sound/items/towelwhip.ogg'
	wipe_sound = 'sound/items/towelwipe.ogg'
	attack_verb_continuous = list("whipped", "flogged")
	attack_verb_simple = list("whip", "flog")
	fitted_bodytypes = BODYTYPE_HUMANOID|BODYTYPE_DIGITIGRADE
	volume = 10
	force = 1
	extinguish_efficiency = 3

/obj/item/reagent_containers/rag/towel/equipped(mob/living/user, slot)
	. = ..()
	switch(slot)
		if(ITEM_SLOT_BELT)
			body_parts_covered = GROIN|LEGS
			flags_inv = NONE
		if(ITEM_SLOT_OCLOTHING)
			body_parts_covered = CHEST|GROIN|LEGS
			flags_inv = NONE
		if(ITEM_SLOT_HEAD)
			body_parts_covered = HEAD
			flags_inv = HIDEHAIR

/obj/item/reagent_containers/rag/towel/examine(mob/user)
	. = ..()
	. += SPAN_NOTICE("You can whip people with it by attacking on combat mode.")
	. += SPAN_NOTICE("You can lay it down on the ground by using it in hand.")

/obj/item/reagent_containers/rag/towel/attack(mob/living/M, mob/living/user)
	if(user.combat_mode)
		item_flags &= ~(NOBLUDGEON)
		. = TRUE
	..()
	item_flags |= NOBLUDGEON

/obj/item/reagent_containers/rag/towel/on_reagent_change()
	. = ..()
	force = initial(force) + round(reagents.total_volume * 0.5)
	name = reagents.total_volume ? "wet towel" : initial(name)

/obj/item/reagent_containers/rag/towel/attack_self(mob/user)
	if(!user.dropItemToGround(src))
		return
	user.visible_message(SPAN_NOTICE("[user] lays out \the [src] flat on the ground."), SPAN_NOTICE("You lay out \the [src] flat on the ground."))
	icon_state = "towel_flat"
	layer = BELOW_OBJ_LAYER

/obj/item/reagent_containers/rag/towel/pickup(mob/living/user)
	. = ..()
	icon_state = "towel"
	layer = initial(layer)

#define RANDOM_TOWEL_COLORS list("#FBB3FF", "#FF0000","#FF7F00","#FFFF00","#00FF00","#0000FF","#4B0082","#8F00FF")

/obj/item/reagent_containers/rag/towel/random/Initialize(mapload)
	. = ..()
	add_atom_colour(pick(RANDOM_TOWEL_COLORS), FIXED_COLOUR_PRIORITY)

#undef RANDOM_TOWEL_COLORS
