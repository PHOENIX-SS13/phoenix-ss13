/obj/item/dyespray
	name = "hair dye spray"
	desc = "A spray to dye your hair any gradients you'd like. Includes a bleaching agent to remove it as well."
	icon = 'icons/obj/dyespray.dmi'
	icon_state = "dyespray"

/obj/item/dyespray/attack_self(mob/user)
	dye(user)

/obj/item/dyespray/attack_self_secondary(mob/user, modifiers)
	bleach(user)

/obj/item/dyespray/pre_attack(atom/target, mob/living/user, params)
	if(ishuman(target))
		dye(target)
		// Cancel attack chain so we don't bop ourselves/others with the spray
		return TRUE
	// Else just call the parent so we can do other things
	return ..()

/obj/item/dyespray/pre_attack_secondary(atom/target, mob/living/user, params)
	if(ishuman(target))
		bleach(target)
		// Cancel attack chain so we don't call pre_attack().
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	return ..()

/**
 * Applies a gradient and a gradient color to a mob.
 *
 * Arguments:
 * * target - The mob who we will apply the gradient and gradient color to.
 */

/obj/item/dyespray/proc/dye(mob/target)
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/human_target = target
	var/primary_gradient_slot = human_target.hair_gradient_style_primary
	var/secondary_gradient_slot = human_target.hair_gradient_style_secondary

	// We already have a primary and secondary gradient, abort.
	if(primary_gradient_slot && secondary_gradient_slot)
		to_chat(human_target, SPAN_WARNING("Your hair does not seem to be able to hold more dye!"))
		return

	var/new_hair_gradient_style = input(usr, "Choose a color pattern:", "Character Preference")  as null|anything in GLOB.hair_gradients_list
	if(!new_hair_gradient_style || new_hair_gradient_style == "None")
		return

	var/new_hair_gradient_color = input(
		usr,
		"Choose a secondary hair color:",
		"Character Preference",
		"#[primary_gradient_slot ? human_target.hair_gradient_color_secondary : human_target.hair_gradient_color_primary]"
	) as color|null
	if(!new_hair_gradient_color)
		return

	to_chat(human_target, SPAN_NOTICE("You start applying the hair dye..."))
	if(!do_after(usr, 3 SECONDS, target))
		return

	// If we don't have a primary hair gradient, apply it to the first slot and mark it as dye
	if(!primary_gradient_slot)
		human_target.hair_gradient_is_dye = TRUE
		human_target.hair_gradient_style_primary = new_hair_gradient_style
		human_target.hair_gradient_color_primary = sanitize_hexcolor(new_hair_gradient_color)
	// Else we have a primary hair gradient, so we need to apply it to the secondary slot
	else
		human_target.hair_gradient_style_secondary = new_hair_gradient_style
		human_target.hair_gradient_color_secondary = sanitize_hexcolor(new_hair_gradient_color)

	playsound(src, 'sound/effects/spray.ogg', 3, TRUE, 2)
	human_target.update_hair()

/**
 * Removes a gradient and a gradient color from a mob.
 *
 * Arguments:
 * * target - The mob who we will remove the gradient and gradient color from.
 */

/obj/item/dyespray/proc/bleach(mob/target)
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/human_target = target
	var/primary_gradient_slot = human_target.hair_gradient_style_primary
	var/primary_is_dye = human_target.hair_gradient_is_dye
	var/secondary_gradient_slot = human_target.hair_gradient_style_secondary

	if((!primary_gradient_slot || (primary_gradient_slot && !primary_is_dye)) && !secondary_gradient_slot)
		to_chat(human_target, SPAN_WARNING("There is no dye to remove from your hair!"))
		return

	to_chat(human_target, SPAN_NOTICE("You start removing the dye from your hair..."))
	if(!do_after(usr, 3 SECONDS, target))
		return

	// Clear the secondary slot first if it exists
	if(secondary_gradient_slot)
		human_target.hair_gradient_style_secondary = null
	// Else no secondary exists, clear the primary slot.
	// We also already checked on if its dye above, so we can just skip checks.
	else
		human_target.hair_gradient_style_primary = null

	playsound(src, 'sound/effects/spray.ogg', 3, TRUE, 2)
	human_target.update_hair()
