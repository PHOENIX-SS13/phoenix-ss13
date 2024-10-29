/datum/component/storage/concrete/wallet/on_alternate_click(datum/source, mob/user)
	if(!isliving(user) || !user.CanReach(parent) || user.incapacitated())
		return
	if(locked)
		to_chat(user, SPAN_WARNING("[parent] seems to be locked!"))
		return

	. = COMPONENT_CANCEL_CLICK_RIGHT
	var/obj/item/storage/wallet/A = parent
	if(istype(A) && A.front_id && !issilicon(user) && !(A.item_flags & IN_STORAGE)) //if it's a wallet in storage seeing the full inventory is more useful
		var/obj/item/I = A.front_id
		INVOKE_ASYNC(src, PROC_REF(attempt_put_in_hands), I, user)
		return
	return ..()
