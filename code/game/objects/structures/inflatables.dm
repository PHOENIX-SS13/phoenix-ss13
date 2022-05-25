#define FAST_INFLATE_TIME 0.3 SECONDS
/// Time it takes for the inflatable to inflate.
#define FAST_DEFLATE_TIME 1 SECONDS
/// Time it takes for the inflatable to quickly deflate, e.g. by manual usage
#define SLOW_DEFLATE_TIME 5 SECONDS
/// Time it takes for the inflatable to slowly deflate, e.g. by puncturing
#define DEPLOY_DELAY 2 SECONDS
/// The delay before the inflatable deploys it's structural variant
#define WALL_DEFLATED_SCALE_X 0.55
/// Width scale of the wall structure, to match the item
#define WALL_DEFLATED_SCALE_Y 0.4
/// Height scale of the wall structure, to match the item
#define WALL_SPRITE_MARGIN -4
/// How big the margin on all sides of the sprites are, solve for (-)MARGIN/2
/// Example: If the sprite is 40x40, the margin is 8 pixels in both directions (4 on each side), negate it, presto.
// This is primarily a micro-optimization, to avoid having to calculate it for each instance.
// Does it matter? I don't know.
#define SUICIDE_INFLATION_PROBABILITY 100
/// How likely it is to become a balloon animal if suiciding

// Custom broken plastic decal
/obj/effect/decal/cleanable/plastic/inflatables
	name = "rubber shreds"
	color = "#e9d285"

/obj/item/inflatable
	name = "inflatable wall"
	desc = "A neatly folded package of a rubber-like material, with a re-usable pulltab sticking out from it."
	icon = 'icons/obj/items/inflatables.dmi'
	icon_state = "folded"
	w_class = WEIGHT_CLASS_NORMAL
	var/deploy_structure = /obj/structure/inflatable

/obj/item/inflatable/Initialize()
	. = ..()
	src.desc = "[src.desc]\nThere is a warning in big bold letters below the instructions, \"[SPAN_WARNING("WARNING: RETIRE IMMEDIATELY AFTER PULLING TAB. DO NOT HOLD. STAND BACK UNTIL INFLATED.")]\""

/obj/item/inflatable/attack_self(mob/user, modifiers)
	if(!pre_inflate(user))
		return

	to_chat(user, SPAN_NOTICE("You pull on \the [src]'s expand tab."))

	if(do_after(user, 0.50 SECONDS, src))
		// We put it on the floor, and quickly pulled on the tab
		addtimer(CALLBACK(src, .proc/inflate, user), DEPLOY_DELAY)
	else
		// We just drop it to the ground cause we somehow couldn't pull on the tab quick enough.
		to_chat(user, SPAN_NOTICE("You lost your grip on the tab!"))
		user.dropItemToGround(src)

/obj/item/inflatable/suicide_act(mob/user)
	user.visible_message(
		SPAN_SUICIDE("[user] painfully stuffs \the [src] into one of [user.p_their()] cavities and is pulling on the tab! It looks like [user.p_theyre()] trying to commit suicide by becoming a balloon animal!")
	)

	if(prob(SUICIDE_INFLATION_PROBABILITY) && iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		carbon_user.inflate_gib()

	src.inflate(user, is_suiciding = TRUE)
	return BRUTELOSS

/obj/item/inflatable/proc/pre_inflate(mob/user)
	if(!deploy_structure)
		return
	if(locate(/obj/structure/inflatable) in get_turf(user))
		to_chat(user, SPAN_WARNING("There is already an inflatable here!"))
		return

	playsound(loc, 'sound/items/zip.ogg', vol=70, vary=TRUE)
	return TRUE

/obj/item/inflatable/proc/inflate(mob/user, is_suiciding = FALSE)
	var/location = get_turf(src)

	if(user.get_held_index_of_item(src))
		location = user.loc
		if(!is_suiciding)
			user.throw_at(get_edge_target_turf(get_turf(src), pick(GLOB.alldirs)), 1, 2)

	var/obj/structure/inflatable/new_inflatable = new deploy_structure(location)
	new_inflatable.deployer_item = src.type
	transfer_fingerprints_to(new_inflatable)
	new_inflatable.add_fingerprint(user)
	qdel(src)

/// A temporary structure that can be deployed by using an item
/// Will deflate after a while, or after being pierced.
/obj/structure/inflatable
	name = "inflatable wall"
	desc = "An inflated membrane. Do not puncture."
	icon = 'icons/obj/structures/inflatables.dmi'
	icon_state = "wall"
	density = TRUE
	anchored = TRUE
	max_integrity = 50
	CanAtmosPass = ATMOS_PASS_DENSITY
	// These are made for SPAAACE
	resistance_flags = FLAMMABLE | FREEZE_PROOF
	var/deflating = FALSE
	var/deployer_item = /obj/item/inflatable

/obj/structure/inflatable/Initialize()
	. = ..()
	air_update_turf(TRUE, TRUE)
	// As the sprite is larger than 32x32, we need to translate it a little bit
	var/matrix/pre_matrix = new
	pre_matrix.Translate(WALL_SPRITE_MARGIN)
	pre_matrix.Scale(WALL_DEFLATED_SCALE_X, WALL_DEFLATED_SCALE_Y)
	transform = pre_matrix
	var/matrix/post_matrix = new
	post_matrix.Translate(WALL_SPRITE_MARGIN)
	playsound(loc, 'sound/effects/smoke.ogg', vol=70, vary=TRUE, frequency=1.5)
	animate(src, FAST_INFLATE_TIME, transform = post_matrix)

/obj/structure/inflatable/deconstruct(disassembled)
	SEND_SIGNAL(src, COMSIG_OBJ_DECONSTRUCT, disassembled)
	deflate(by_user = disassembled)

/obj/structure/inflatable/attack_hand(mob/living/user, list/modifiers)
	if(deflating)
		return ..()

	. = ..()

	deconstruct(TRUE)

/obj/structure/inflatable/hitby(atom/movable/thrown_thing, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(deflating)
		return ..()

	if(thrown_thing.throwforce >= 20)
		deflate(violent = TRUE)
		return

	if(isitem(thrown_thing))
		var/obj/item/thrown_item = thrown_thing
		if(thrown_item.sharpness > 0 && thrown_item.force >= 8)
			deflate(violent = TRUE)
			return

	. = ..()

/obj/structure/inflatable/bullet_act(obj/projectile/projectile)
	if(deflating)
		return ..()

	. = ..()
	// Make sure the projectile is of damage_type BRUTE or BURN
	// AND that it's damage is above the inflatable's current integrity
	if((projectile.damage_type == BRUTE || projectile.damage_type == BURN) && ((src.get_integrity() - projectile.damage) <= 0))
		deflate(violent = TRUE)
		return

/obj/structure/inflatable/attackby(obj/item/item, mob/living/user, params)
	// We're already deflating, no real point doing anything special
	if(deflating)
		return ..()

	// Yes we are shadowing the original integrity and caching it here
	var/integrity = src.get_integrity()
	var/violently_deflate = FALSE

	// Check if we should pop it immediately
	if(integrity <= (max_integrity * 0.8))
		// We have a relatively sharp item or something quite deadly
		if(item.sharpness > NONE && item.force >= 8)
			violently_deflate = TRUE

		// We have something quite deadly and the inflatable might get popped by it
		if(item.force >= 20 && integrity - item.force <= 0)
			violently_deflate = TRUE

	if(violently_deflate)
		deflate(violent = TRUE)
		return

	return ..()

/// Causes our structure to deflate
/// by_user - Is a user manually deflating it in a controlled manner?
/// violent - Is the deflating caused by a violent action?
/obj/structure/inflatable/proc/deflate(by_user = FALSE, violent = FALSE)
	if(QDELETED(src) || deflating)
		return

	if(violent)
		playsound(loc, 'sound/effects/snap.ogg', vol = 95, vary = TRUE, frequency = 0.6, falloff_distance = 2)
		new /obj/effect/decal/cleanable/plastic/inflatables(get_turf(src))
		qdel(src)
		air_update_turf(TRUE, TRUE)
		return

	var/deflate_time = by_user ? FAST_DEFLATE_TIME : SLOW_DEFLATE_TIME
	var/matrix/matrix = new
	matrix.Scale(WALL_DEFLATED_SCALE_X, WALL_DEFLATED_SCALE_Y)

	deflating = TRUE
	playsound(loc, 'sound/effects/smoke.ogg', vol=70, vary=TRUE)
	animate(src, deflate_time, transform = matrix)
	set_density(FALSE)
	air_update_turf(TRUE, TRUE)
	addtimer(CALLBACK(src, .proc/post_deflate), deflate_time)

/obj/structure/inflatable/proc/post_deflate()
	if(QDELETED(src))
		return
	var/obj/item/inflatable/inflatable_item = new deployer_item(src.loc)
	transfer_fingerprints_to(inflatable_item)
	qdel(src)

#undef FAST_DEFLATE_TIME
#undef SLOW_DEFLATE_TIME
#undef DEPLOY_DELAY
#undef WALL_DEFLATED_SCALE_X
#undef WALL_DEFLATED_SCALE_Y
#undef WALL_SPRITE_MARGIN
#undef SUICIDE_INFLATION_PROBABILITY
