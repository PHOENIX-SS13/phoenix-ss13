/**
 * # N-spect scanner
 *
 * Creates reports for area inspection bounties.
 */
/obj/item/inspector
	name = "\improper N-spect scanner"
	desc = "Central Command-issued inspection device. Performs inspections according to Nanotrasen protocols when activated, then \
			prints an encrypted report regarding the maintenance of the station. Hard to replace."
	icon = 'icons/obj/device.dmi'
	icon_state = "inspector"
	worn_icon_state = "salestagger"
	inhand_icon_state = "electronic"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_range = 1
	throw_speed = 1

/obj/item/inspector/attack_self(mob/user)
	. = ..()
	if(do_after(user, 5 SECONDS, target = user, progress=TRUE))
		print_report()

///Prints out a report for bounty purposes, and plays a short audio blip.
/obj/item/inspector/proc/print_report()
	// Create our report
	var/obj/item/paper/report/slip = new(get_turf(src))
	slip.generate_report(get_area(src))
	playsound(src, 'sound/machines/high_tech_confirm.ogg', 50, FALSE)

/obj/item/paper/report
	name = "encrypted station inspection"
	desc = "Contains no information about the station's current status."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "slip"
	///What area the inspector scanned when the report was made. Used to verify the security bounty.
	var/area/scanned_area
	show_written_words = FALSE

/obj/item/paper/report/proc/generate_report(area/scan_area)
	scanned_area = scan_area
	icon_state = "slipfull"
	desc = "Contains detailed information about the station's current status."

	var/list/characters = list()
	characters += GLOB.alphabet
	characters += GLOB.alphabet_upper
	characters += GLOB.numerals

	info = random_string(rand(180,220), characters)
	info += "[prob(50) ? "=" : "=="]" //Based64 encoding

/obj/item/paper/report/examine(mob/user)
	. = ..()
	if(scanned_area?.name)
		. += SPAN_NOTICE("\The [src] contains data on [scanned_area.name].")
	else if(scanned_area)
		. += SPAN_NOTICE("\The [src] contains data on a vague area on station, you should throw it away.")
	else if(info)
		icon_state = "slipfull"
		. += SPAN_NOTICE("Wait a minute, this isn't an encrypted inspection report! You should throw it away.")
	else
		. += SPAN_NOTICE("Wait a minute, this thing's blank! You should throw it away.")
