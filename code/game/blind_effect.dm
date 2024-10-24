/// Plays a visual effect representing a sound cue for people with vision obstructed by blindness
/proc/play_blind_effect(atom/center, range, icon_state, dir = SOUTH, ignore_self = FALSE, angle = 0)
	var/turf/anchor_point = get_turf(center)
	var/image/fov_image
	for(var/mob/living/living_mob in get_hearers_in_view(range, center))
		var/client/mob_client = living_mob.client
		if(!mob_client)
			continue
		if(ignore_self && living_mob == center)
			continue
		if(living_mob.in_clear_view(center))
			continue
		if(HAS_TRAIT(living_mob, TRAIT_DEAF)) //Deaf people can't hear sounds so no sound indicators
			continue
		if(!fov_image) //Make the image once we found one recipient to receive it
			fov_image = image(icon = 'icons/effects/blind_effects.dmi', icon_state = icon_state, loc = anchor_point)
			fov_image.plane = FULLSCREEN_PLANE
			fov_image.layer = FOV_EFFECTS_LAYER
			fov_image.dir = dir
			fov_image.appearance_flags = RESET_COLOR | RESET_TRANSFORM
			if(angle)
				var/matrix/matrix = new
				matrix.Turn(angle)
				fov_image.transform = matrix
			fov_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		mob_client.images += fov_image
		addtimer(CALLBACK(GLOBAL_PROC, PROC_REF(remove_image_from_client), fov_image, mob_client), 30)

// Range at which nearsighted people will receive blind effects
#define NEARSIGHT_BLIND_EFF_RANGE 2

/// Checks if the atoms is in clear view of a mob. Checks blindness and nearsightnedness.
/mob/living/proc/in_clear_view(atom/observed_atom)
	if(is_blind())
		return FALSE
	if(HAS_TRAIT(src, TRAIT_NEARSIGHT))
		//Checking if our dude really is suffering from nearsightness! (very nice nearsightness code)
		if(iscarbon(src))
			var/mob/living/carbon/carbon_me = src
			if(carbon_me.glasses)
				var/obj/item/clothing/glasses/glass = carbon_me.glasses
				if(glass.vision_correction)
					return TRUE
		var/turf/my_turf = get_turf(src)
		var/rel_x = observed_atom.x - my_turf.x
		var/rel_y = observed_atom.y - my_turf.y
		if((rel_x >= NEARSIGHT_BLIND_EFF_RANGE || rel_x <= -NEARSIGHT_BLIND_EFF_RANGE) || (rel_y >= NEARSIGHT_BLIND_EFF_RANGE || rel_y <= -NEARSIGHT_BLIND_EFF_RANGE))
			return FALSE
	return TRUE

#undef NEARSIGHT_BLIND_EFF_RANGE
