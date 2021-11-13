/obj/item/key
	name = "key"
	desc = "A small key, what could it unlock?"
	icon = 'icons/obj/items/keys_locks.dmi'
	icon_state = "key"
	w_class = WEIGHT_CLASS_TINY
	/// ID of the key
	var/key_id = 0
	/// Whether it is possible to make a copy of the key's ID
	var/can_copy_id = TRUE
	/// Next ID of a newly fabricated key, starts from 11,000 to allow mappers to use 1-9999 freely, and coders to use 10000-10999 for pre-defined stuff
	var/static/next_key_id = KEY_ID_UNIQUE_START
	/// What overlay state this will show on a keyring
	var/keyring_overlay = "keyring_key"

/obj/item/key/Initialize(mapload, new_id)
	. = ..()
	//If we are initialized with an ID parameter, apply it
	if(new_id)
		key_id = new_id
	//Otherwise, check if we have a predefined id, if not, apply a new unique one
	else if(!key_id)
		next_key_id++
		key_id = next_key_id

/obj/item/key/atv
	name = "ATV key"
	desc = "A small grey key for starting and operating ATVs."
	key_id = KEY_ID_ATV

/obj/item/key/security
	desc = "A keyring with a small steel key, and a rubber stun baton accessory."
	icon_state = "keysec"
	key_id = KEY_ID_SECWAY
	keyring_overlay = "keyring_sec"

/obj/item/key/janitor
	desc = "A keyring with a small steel key, and a pink fob reading \"Pussy Wagon\"."
	icon_state = "keyjanitor"
	key_id = KEY_ID_JANICART
	keyring_overlay = "keyring_jani"

/obj/item/key/lasso
	name = "bone lasso"
	desc = "Perfect for taming all kinds of supernatural beasts! (Warning: only perfect for taming one kind of supernatural beast.)"
	force = 12
	icon_state = "lasso"
	inhand_icon_state = "chain"
	worn_icon_state = "whip"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	attack_verb_continuous = list("flogs", "whips", "lashes", "disciplines")
	attack_verb_simple = list("flog", "whip", "lash", "discipline")
	hitsound = 'sound/weapons/whip.ogg'
	slot_flags = ITEM_SLOT_BELT
	can_copy_id = FALSE
	key_id = KEY_ID_BONE_LASSO
	keyring_overlay = "keyring_lasso"

/obj/item/key/collar
	name = "collar key"
	desc = "A key for a tiny lock on a collar."
	key_id = KEY_ID_COLLAR

/obj/item/lock
	name = "lock"
	desc = "Lock away the seven seas, or a crate or something."
	icon = 'icons/obj/items/keys_locks.dmi'
	icon_state = "lock"
	w_class = WEIGHT_CLASS_SMALL
	/// ID of the keys that will unlock us
	var/key_id = 0

/obj/item/lock/Initialize(mapload, new_id)
	. = ..()
	//Apply our ID
	key_id = new_id

/obj/item/key_assembly
	name = "key assembly"
	desc = "A crudely shaped thin piece of metal."
	icon = 'icons/obj/items/keys_locks.dmi'
	icon_state = "key_crude"
	w_class = WEIGHT_CLASS_TINY
	/// Recorded ID that we'll imprint on the key we make
	var/key_id = 0

/obj/item/key_assembly/attackby(obj/item/weapon, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(weapon.tool_behaviour == TOOL_WELDER)
		if(!weapon.tool_start_check(user, amount=0))
			return
		to_chat(user, SPAN_NOTICE("You begin shaping up the key..."))
		if(weapon.use_tool(src, user, 4 SECONDS, volume = 50))
			to_chat(user, SPAN_NOTICE("You finalize the key."))
			new /obj/item/key(get_turf(src), key_id)
			qdel(src)
		return TRUE
	if(istype(weapon, /obj/item/key))
		var/obj/item/key/key_item = weapon
		to_chat(user, SPAN_NOTICE("You prepare the key to be a copy of \the [key_item]."))
		key_id = key_item.key_id
		return
	return ..()

/obj/item/key_assembly/examine(mob/user)
	. = ..()
	. += SPAN_NOTICE("You could use another key on it to shape up a copy. Not making a copy will make a unique key.")
	. += SPAN_NOTICE("You could <b>weld</b> it to finalize it.")

/obj/item/lock_assembly
	name = "lock assembly"
	desc = "A crudely shaped lock assembly."
	icon = 'icons/obj/items/keys_locks.dmi'
	icon_state = "lock_crude"
	w_class = WEIGHT_CLASS_SMALL
	/// Recorded ID that we'll imprint on the lock we make
	var/key_id = 0

/obj/item/lock_assembly/attackby(obj/item/weapon, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(weapon.tool_behaviour == TOOL_WELDER)
		if(!weapon.tool_start_check(user, amount=0))
			return
		to_chat(user, SPAN_NOTICE("You begin shaping up the lock..."))
		if(weapon.use_tool(src, user, 4 SECONDS, volume = 50))
			to_chat(user, SPAN_NOTICE("You finalize the lock."))
			new /obj/item/lock(get_turf(src), key_id)
			qdel(src)
		return TRUE
	if(istype(weapon, /obj/item/key))
		var/obj/item/key/key_item = weapon
		to_chat(user, SPAN_NOTICE("You prepare the lock to be a fit for \the [key_item]."))
		key_id = key_item.key_id
		return
	return ..()

/obj/item/lock_assembly/examine(mob/user)
	. = ..()
	. += SPAN_NOTICE("You could use key on it to make the lock a fit for it.")
	. += SPAN_NOTICE("You could <b>weld</b> it to finalize it.")

/obj/item/lockpick
	name = "lockpick"
	desc = "A small bent piece of metal used for picking old fashioned locks."
	icon = 'icons/obj/items/keys_locks.dmi'
	icon_state = "lockpick"
	w_class = WEIGHT_CLASS_TINY

/obj/item/storage/key_ring
	name = "key ring"
	desc = "Can hold many keys."
	icon = 'icons/obj/items/keys_locks.dmi'
	icon_state = "keyring"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_BELT

/obj/item/storage/key_ring/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_TINY
	STR.max_combined_w_class = 7
	STR.set_holdable(list(/obj/item/key))

/obj/item/storage/key_ring/update_overlays()
	. = ..()
	var/key_amt = 0
	for(var/obj/item/key/key_item in contents)
		key_amt++
		var/list/offset_list
		///Determine an offset based off amount of keys
		switch(key_amt)
			if(1)
				offset_list = list(0,0)
			if(2)
				offset_list = list(-4,1)
			if(3)
				offset_list = list(4,1)
			if(4)
				offset_list = list(-6,2)
			if(5)
				offset_list = list(6,2)
			if(6)
				offset_list = list(-2,1)
			if(7)
				offset_list = list(2,1)
			else
				offset_list = list(0,0)
		var/mutable_appearance/key_overlay = mutable_appearance(icon, key_item.keyring_overlay, appearance_flags = RESET_COLOR)
		key_overlay.color = key_item.color
		key_overlay.pixel_x = offset_list[1]
		key_overlay.pixel_y = offset_list[2]
		. += key_overlay
