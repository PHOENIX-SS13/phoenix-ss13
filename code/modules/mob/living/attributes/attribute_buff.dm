// A datum holding information about a buff that is being applied to an attribute holder
/datum/attribute_buff
	/// Name of the buff so the player can know what is affecting them
	var/name
	/// Description of the buff
	var/desc
	/// Whether its hidden from the player
	var/hidden = FALSE
	/// Nullable assoc list of attribute types to values this buff will give
	var/list/attributes
	/// Nullable assoc list of skill types to values this buff will give
	var/list/skills
	/// Nullable message to send to the affected mob when they receive the buff.
	var/gain_message
	/// Nullable message to send to the affected mob when they loose the buff.
	var/lose_message
	/// Whether the buff is positive or not
	var/positive = TRUE

/datum/attribute_buff/caffeine
	name = "Caffeinated"
	desc = "Your brain is being stimulated by some good caffeine."
	attributes = list(/datum/attribute/intelligence = 1)

/* TODO's
/datum/attribute_buff/fatigued
/datum/attribute_buff/exhausted
/datum/attribute_buff/debiliating_pain
/datum/attribute_buff/revival_shock
*/
