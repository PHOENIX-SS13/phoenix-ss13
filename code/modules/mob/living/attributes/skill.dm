/datum/skill
	/// Name of the skill
	var/name = "Skill"
	/// Description of the skill
	var/desc = "Description"
	/// Contribution to the skill value from attributes (counted from base value)
	var/list/affinities

/datum/skill/proc/get_capability_description(value)
	switch(value)
		if(-INFINITY to -3)
			return "Catastrophic"
		if(-2)
			return "Terrible"
		if(-1)
			return "Bad"
		if(0)
			return "Dabbling"
		if(1)
			return "Novice"
		if(2)
			return "Adequete"
		if(3)
			return "Competent"
		if(4)
			return "Skilled"
		if(5 to INFINITY)
			return "Proficient"

/datum/skill/first_aid
	name = "First Aid"
	desc = "The ability to effectively perform first aid, applying ointments, sutures, gauze or splints aswell as performing CPR and setting limbs."
	affinities = list(/datum/attribute/intelligence = 0.5)

/datum/skill/surgery
	name = "Surgery"
	desc = "Precision, hand coordination and the anatomical knowledge required to perform surgery."
	affinities = list(/datum/attribute/intelligence = 0.5)

/datum/skill/electrical
	name = "Electrical"
	desc = "Knowledge of electrical components and systems, helps with hacking and figuring out which wires do what."
	affinities = list(/datum/attribute/intelligence = 0.5)

/datum/skill/mechanical
	name = "Mechanical"
	desc = "Proficiency with machinery, tools and it's usage. Increases the speed at which you use tools."
	affinities = list(/datum/attribute/intelligence = 0.5)

/datum/skill/eva
	name = "Extra-Vehicular Activity"
	desc = "The ability to gracefully perform tasks in no gravity environments and adjusting yourself to changes in gravity or air pressure."
	affinities = list(/datum/attribute/dexterity = 0.5)
