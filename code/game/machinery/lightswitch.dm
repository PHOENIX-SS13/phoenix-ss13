#define STAGE_INITIAL 0
#define STAGE_CONNECT 1
#define STAGE_PANEL 2
#define STAGE_FINAL 3

/// The light switch. Can have multiple per area.
/obj/machinery/light_switch
	name = "light switch"
	icon = 'icons/obj/power.dmi'
	icon_state = "light1"
	base_icon_state = "light"
	desc = "Make dark."
	power_channel = AREA_USAGE_LIGHT
	/// Set this to a string, path, or area instance to control that area
	/// instead of the switch's location.
	var/area/area = null
	/// Our current build stage; starts off finalized and gets set to initial if built by the wallframe item
	var/build_stage = STAGE_FINAL

/obj/item/wallframe/light_switch
	name = "light switch frame"
	desc = "Used for building light switches."
	icon_state = "light_switch"
	result_path = /obj/machinery/light_switch
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)

/obj/machinery/light_switch/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/usb_port, list(
		/obj/item/circuit_component/light_switch,
	))

/obj/machinery/light_switch/directional/north
	dir = SOUTH
	pixel_y = 26

/obj/machinery/light_switch/directional/south
	dir = NORTH
	pixel_y = -26

/obj/machinery/light_switch/directional/east
	dir = WEST
	pixel_x = 26

/obj/machinery/light_switch/directional/west
	dir = EAST
	pixel_x = -26

/obj/machinery/light_switch/Initialize(mapload, ndir = 0, built = FALSE)
	. = ..()
	if(istext(area))
		area = text2path(area)
	if(ispath(area))
		area = GLOB.areas_by_type[area]
	if(!area)
		area = get_area(src)

	if(built) // Is there an easier way of doing this? Maybe make a set_dir_shift proc?
		build_stage = STAGE_INITIAL
		dir = ndir
		switch(ndir)
			if(EAST)
				pixel_x = -26
			if(WEST)
				pixel_x = 26
			if(NORTH)
				pixel_y = -26
			if(SOUTH)
				pixel_y = 26
		update_appearance()
		return INITIALIZE_HINT_NORMAL

	update_appearance()
	if(mapload)
		return INITIALIZE_HINT_LATELOAD

/obj/machinery/light_switch/wrench_act(mob/living/user, obj/item/tool)
	if(build_stage == STAGE_INITIAL)
		playsound(loc, 'sound/machines/click.ogg', 75, TRUE)
		user.balloon_alert(user, "removed the light switch frame")
		transfer_fingerprints_to(new /obj/item/wallframe/light_switch(get_turf(user)))
		qdel(src)
		return TRUE

/obj/machinery/light_switch/screwdriver_act(mob/living/user, obj/item/tool)
	switch(build_stage)
		if(STAGE_INITIAL)
			user.balloon_alert(user, "secured the wires")
			build_stage++
			. = TRUE
		if(STAGE_CONNECT)
			user.balloon_alert(user, "unsecured the wires")
			build_stage--
			. = TRUE
		if(STAGE_PANEL)
			user.balloon_alert(user, "secured the front panel")
			build_stage++
			. = TRUE
		if(STAGE_FINAL)
			user.balloon_alert(user, "removed the front panel")
			build_stage--
			. = TRUE
	if(.)
		update_appearance()

/obj/machinery/light_switch/multitool_act(mob/living/user, obj/item/tool)
	switch(build_stage)
		if(STAGE_CONNECT)
			user.balloon_alert(user, "connected the light switch")
			build_stage++
			if(area.lightswitch)
				set_lights(!area.lightswitch)
			if(area.power_light)
				user.electrocute_act(10, src)
				do_sparks(5, FALSE, src)
			. = TRUE
		if(STAGE_PANEL)
			user.balloon_alert(user, "disconnected the light switch")
			if(area.power_light)
				user.electrocute_act(10, src)
				do_sparks(5, FALSE, src)
			build_stage--
			. = TRUE
	if(.)
		update_appearance()

/obj/machinery/light_switch/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/pen) && build_stage == STAGE_PANEL)
		var/newname = stripped_input(user, "Lightswitch name:")
		if(newname)
			name = newname
		return
	return ..()

/obj/machinery/light_switch/LateInitialize()
	if(area.lightswitch)
		set_lights(!area.lightswitch)

/obj/machinery/light_switch/update_appearance(updates=ALL)
	. = ..()
	if(build_stage == STAGE_FINAL)
		luminosity = (machine_stat & NOPOWER) ? FALSE : TRUE
	else
		luminosity = FALSE

/obj/machinery/light_switch/update_icon_state()
	if(build_stage != STAGE_FINAL)
		icon_state = "[base_icon_state]_build[build_stage]"
		return ..()
	if(machine_stat & NOPOWER)
		icon_state = "[base_icon_state]-p"
		return ..()
	icon_state = "[base_icon_state][area.lightswitch ? 1 : 0]"
	return ..()

/obj/machinery/light_switch/update_overlays()
	. = ..()
	if(!(machine_stat & NOPOWER) && build_stage == STAGE_FINAL)
		. += emissive_appearance(icon, "[base_icon_state]-glow", alpha = src.alpha)

/obj/machinery/light_switch/examine(mob/user)
	. = ..()
	switch(build_stage)
		if(STAGE_INITIAL)
			. += SPAN_NOTICE("The wires are loose and could be <i>screwed</i> into place.")
		if(STAGE_CONNECT)
			. += SPAN_NOTICE("The wires are not connected and could be connected with a <i>multitool</i>.")
		if(STAGE_PANEL)
			. += SPAN_NOTICE("The front panel is removed and could be <i>screwed</i> into place.")
		if(STAGE_FINAL)
			. += SPAN_NOTICE("The front panel is secured with <i>screws</i>.")
			. += SPAN_NOTICE("It is [area.lightswitch ? "on" : "off"].")

/obj/machinery/light_switch/interact(mob/user)
	. = ..()
	if(build_stage != STAGE_FINAL)
		return
	playsound(src, 'sound/effects/light/lightswitch.ogg', 100, TRUE)
	set_lights(!area.lightswitch)

/// Toggle our areas lightswitch var and update the area and all its light switches, including us!
/obj/machinery/light_switch/proc/set_lights(status)
	if(area.lightswitch == status)
		return
	area.lightswitch = status
	area.update_appearance()

	for(var/obj/machinery/light_switch/light_switch in area)
		light_switch.update_appearance()
		SEND_SIGNAL(light_switch, COMSIG_LIGHT_SWITCH_SET, status)

	area.power_change()

/obj/machinery/light_switch/power_change()
	SHOULD_CALL_PARENT(FALSE)
	if(area == get_area(src))
		return ..()

/obj/machinery/light_switch/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	if(!(machine_stat & (BROKEN|NOPOWER)))
		power_change()

/obj/item/circuit_component/light_switch
	display_name = "Light Switch"
	desc = "Allows to control the lights of an area."
	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL

	///If the lights should be turned on or off when the trigger is triggered.
	var/datum/port/input/on_setting
	///Whether the lights are turned on
	var/datum/port/output/is_on

	var/obj/machinery/light_switch/attached_switch

/obj/item/circuit_component/light_switch/populate_ports()
	on_setting = add_input_port("On", PORT_TYPE_NUMBER)
	is_on = add_output_port("Is On", PORT_TYPE_NUMBER)

/obj/item/circuit_component/light_switch/register_usb_parent(atom/movable/parent)
	. = ..()
	if(istype(parent, /obj/machinery/light_switch))
		attached_switch = parent
		RegisterSignal(parent, COMSIG_LIGHT_SWITCH_SET, PROC_REF(on_light_switch_set))

/obj/item/circuit_component/light_switch/unregister_usb_parent(atom/movable/parent)
	attached_switch = null
	UnregisterSignal(parent, COMSIG_LIGHT_SWITCH_SET)
	return ..()

/obj/item/circuit_component/light_switch/proc/on_light_switch_set(datum/source, status)
	SIGNAL_HANDLER
	is_on.set_output(status)

/obj/item/circuit_component/light_switch/input_received(datum/port/input/port)
	attached_switch?.set_lights(on_setting.value ? TRUE : FALSE)

#undef STAGE_INITIAL
#undef STAGE_CONNECT
#undef STAGE_PANEL
#undef STAGE_FINAL
