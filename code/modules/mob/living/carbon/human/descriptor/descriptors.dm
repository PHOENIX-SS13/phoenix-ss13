/// Descriptor for a human's age.
/datum/descriptor/age

/datum/descriptor/age/can_describe(mob/living/carbon/human/examined)
	if ((examined.wear_mask && (examined.wear_mask.flags_inv & HIDEFACE)) || (examined.head && (examined.head.flags_inv & HIDEFACE)))
		return FALSE
	return TRUE

/datum/descriptor/age/description_value(mob/living/carbon/human/examined)
	switch(examined.age)
		if(0 to 20)
			return 1
		if(21 to 24)
			return 2
		if(25 to 28)
			return 3
		if(29 to 35)
			return 4
		if(36 to 45)
			return 5
		if(46 to 55)
			return 6
		if(56 to 70)
			return 7
		if(71 to INFINITY)
			return 8

/datum/descriptor/age/describe(mob/living/carbon/human/examined, description_value)
	var/age_text
	switch(description_value)
		if(1)
			age_text = "a young adult."
		if(2)
			age_text = "of adult age."
		if(3)
			age_text = "a mature adult."
		if(4 to 5)
			age_text = "middle-aged."
		if(6)
			age_text = "rather old."
		if(7)
			age_text = "very old."
		if(8)
			age_text = "withering away."
	return SPAN_SMALLNOTICE("[examined.p_they(TRUE)] appear[examined.p_s()] to be [age_text]")

/datum/descriptor/age/compare(mob/living/carbon/human/comparator, mob/living/carbon/human/examined, description_difference)
	var/compare_text
	switch(description_difference)
		if(-INFINITY to -3)
			compare_text = "much younger than you."
		if(-2)
			compare_text = "younger than you."
		if(-1)
			compare_text = "slightly younger than you."
		if(0)
			compare_text = "about the same age as you."
		if(1)
			compare_text = "slightly older than you."
		if(2)
			compare_text = "older than you."
		if(3 to INFINITY)
			compare_text = "much older than you."
	return SPAN_SMALLNOTICE("[examined.p_they(TRUE)] appear[examined.p_s()] to be [compare_text]")

/// Descriptor of age for robots
/datum/descriptor/age/robot
	
/datum/descriptor/age/robot/describe(mob/living/carbon/human/examined, description_value)
	var/age_text
	switch(description_value)
		if(1)
			age_text = "fresh from the factory."
		if(2)
			age_text = "in pristine condition."
		if(3)
			age_text = "slightly weathered."
		if(4 to 5)
			age_text = "an aged machine."
		if(6)
			age_text = "slightly worn out."
		if(7)
			age_text = "very worn out."
		if(8)
			age_text = "a scrapheap."
	return SPAN_SMALLNOTICE("[examined.p_they(TRUE)] appear[examined.p_s()] to be [age_text]")

/datum/descriptor/age/robot/compare(mob/living/carbon/human/comparator, mob/living/carbon/human/examined, description_difference)
	var/compare_text
	switch(description_difference)
		if(-INFINITY to -3)
			compare_text = "much younger of a model than you."
		if(-2)
			compare_text = "somewhat younger of a model than you."
		if(-1)
			compare_text = "slightly younger of a model than you."
		if(0)
			compare_text = "a similar model age as you."
		if(1)
			compare_text = "a slightly older of a model than you."
		if(2)
			compare_text = "somewhat older of a model than you."
		if(3 to INFINITY)
			compare_text = "much older of a model than you."
	return SPAN_SMALLNOTICE("[examined.p_they(TRUE)] appear[examined.p_s()] to be [compare_text]")

/// Abstract descriptor for an attrubite of a human.
/datum/descriptor/attribute
	/// The typepath for the attribute to get a value from in `description_value`
	var/attribute_type = /datum/attribute
	/// Whether we want to look at the raw attribute, if not the total one will be looked at
	var/raw = TRUE

/datum/descriptor/attribute/description_value(mob/living/carbon/human/examined)
	var/attribute
	if(raw)
		attribute = examined.attributes.attributes_raw[attribute_type]
	else
		attribute = examined.attributes.attributes_final[attribute_type]
	// Will return a 1 or -1 per each 2 attributes that move away from the base value. So 12 is 1, 8 is -1 etc.
	return FLOOR((attribute - ATTRIBUTE_BASE) * 0.5, 1)

/datum/descriptor/attribute/strength
	attribute_type = /datum/attribute/strength

/datum/descriptor/attribute/strength/can_describe(mob/living/carbon/human/examined)
	if(examined.wear_suit && examined.wear_suit.flags_inv & HIDEJUMPSUIT)
		return FALSE
	return TRUE

/datum/descriptor/attribute/strength/describe(mob/living/carbon/human/examined, description_value)
	var/describe_text
	switch(description_value)
		if(-INFINITY to -2)
			describe_text = "look[examined.p_s()] very weak."
		if(-1)
			describe_text = "look[examined.p_s()] weak."
		if(0)
			describe_text = "look[examined.p_s()] average in strength."
		if(1)
			describe_text = "look[examined.p_s()] strong."
		if(2)
			describe_text = "look[examined.p_s()] very strong."
		if(3 to INFINITY)
			describe_text = "is completely ripped."

	return SPAN_SMALLNOTICE("[examined.p_they(TRUE)] [describe_text]")

/datum/descriptor/attribute/strength/compare(mob/living/carbon/human/comparator, mob/living/carbon/human/examined, description_difference)
	var/compare_text
	switch(description_difference)
		if(-INFINITY to -2)
			compare_text = "appear[examined.p_s()] much weaker than you."
		if(-1)
			compare_text = "appear[examined.p_s()] weaker than you."
		if(0)
			compare_text = "look[examined.p_s()] just as strong as you."
		if(1)
			compare_text = "appear[examined.p_s()] stronger than you."
		if(2 to INFINITY)
			compare_text = "appear[examined.p_s()] much stronger than you."
	return SPAN_SMALLNOTICE("[examined.p_they(TRUE)] [compare_text]")
