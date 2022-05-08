/// Attribute sheets are datums which allow to easily add or remove amounts of attributes and skill
/datum/attribute_sheet
	/// Name of the attribute sheet. Important for an admin tool.
	var/name = "Sheet name"
	/// Nullable assoc list of attribute types to values to add (can be negatives)
	var/list/attributes
	/// Nullable assoc list of skill types to values to add (can be negatives)
	var/list/skills

/datum/attribute_sheet/engineer
	name = "Engineer"
	skills = list(
		/datum/skill/electrical = 4,
		/datum/skill/mechanical = 4,
		/datum/skill/eva = 2,
		)

/datum/attribute_sheet/doctor
	name = "Doctor"
	skills = list(
		/datum/skill/first_aid = 5,
		/datum/skill/surgery = 5
		)
