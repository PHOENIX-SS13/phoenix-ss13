/datum/attribute
	/// Name of the attribute
	var/name = "Attribute"
	/// Description of the attribute
	var/desc = "Description"

/// Returns a common DnD-like modifier (12 giving a +1, 14 a +2, 9 a -1 etc.). This often matches the affinity impact for skills
/datum/attribute/proc/get_common_modifier_string(value)
	var/modifier_value = FLOOR((value - ATTRIBUTE_BASE) / 2, 1)
	if(modifier_value > 0)
		return "+[modifier_value]"
	return "[modifier_value]" //Negative values will implicitly get the minus prefix

/datum/attribute/strength
	name = "Strength"
	desc = "Increases unarmed damage and damage with melee and thrown weaponry. Allows you to hold people in grabs and resist grabs more easily."

/datum/attribute/dexterity
	name = "Dexterity"
	desc = "Increases your accuracy with ranged and thrown weaponry."

/datum/attribute/condition
	name = "Condition"
	desc = "Increases stamina regeneration, pain tolerance and reduces the feeling of fatigue. Condition also makes your metabolism more robust."

/datum/attribute/intelligence
	name = "Intelligence"
	desc = "Increases your wit, raising the proficiency in most skills."
