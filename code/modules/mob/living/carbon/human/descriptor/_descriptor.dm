/// Descriptor datum which can add examines specific to all sorts of characteristics such as age, height etc.
/datum/descriptor
	/// Whether the descriptor can be compared to the same one of its type for another human.
	var/comparable = TRUE

/// Internal proc for returning a comparison
/datum/descriptor/proc/get_comparison(mob/living/carbon/human/comparator, mob/living/carbon/human/examined)
	var/diff = description_value(examined) - description_value(comparator)
	return compare(comparator, examined, diff)

/// Internal proc for returning a description
/datum/descriptor/proc/get_description(mob/living/carbon/human/examined)
	return describe(examined, description_value(examined))

/// Internal proc for checking describe conditions and comparable boolean
/datum/descriptor/proc/can_really_describe(mob/living/carbon/human/examined, compared, mob/living/carbon/human/comparator)
	if(!can_describe(examined))
		return FALSE
	if(compared)
		if(!comparable)
			return FALSE
		// The comparator doesn't have any or such a descriptor to compare themselves against.
		if(!comparator.descriptors || !(type in comparator.descriptors))
			return FALSE
	return TRUE

/// Overridable proc to get a measurable integer value to use in descriptions and comparisons
/datum/descriptor/proc/description_value(mob/living/carbon/human/examined)
	return 0

/// Overridable proc to determine whether a human can be described in a way.
/datum/descriptor/proc/can_describe(mob/living/carbon/human/examined)
	return TRUE

/// Overridable proc to return a string description.
/datum/descriptor/proc/describe(mob/living/carbon/human/examined, description_value)
	return

/// Overridable proc to return a string comparison.
/datum/descriptor/proc/compare(mob/living/carbon/human/comparator, mob/living/carbon/human/examined, description_difference)
	return
