/// Generic

// Generic
/datum/cultural_info/culture/generic
	name = "Other culture"
	description = "<b>This option allows a variety of exotic languages, make sure to only pick those who fit your backstory.</b><BR>You are from one of the many small, \
	relatively unknown cultures scattered across the galaxy."
	additional_langs = list(GENERIC_CULTURAL_LANGUAGES)

// Vat Grown
/datum/cultural_info/culture/vatgrown
	name = "Vat-Grown"
	description = "<b>This option allows a variety of exotic languages, make sure to only pick those who fit your backstory.</b><BR>You were not born like most of the people, \
	instead grown and raised in laboratory conditions, either as clone, gene-adapt or some experiment. Your outlook diverges from baseline humanity accordingly."
	additional_langs = list(GENERIC_CULTURAL_LANGUAGES)

// Tradeship
/datum/cultural_info/culture/interstellar_trader
	name = "Former Interstellar Trader"
	description = "<b>This option allows a variety of exotic languages, make sure to only pick those who fit your backstory.</b><BR>You are the descendent of a clan inhabiting \
	and operating a colossal interstellar trading vessel. For one reason or another, you have disembarked from that which houses both your family and all you have known."
	additional_langs = list(GENERIC_CULTURAL_LANGUAGES)

// Generic rural
/datum/cultural_info/culture/spacer_core
	name = "Spacer, Core Systems"
	description = "You are from the void between worlds, though close to home. You are from one of the myriad space stations, orbital platforms, long haul freighters, \
	gateway installations or other facilities that occupy the vastness of space. Spacers near the core worlds are accustomed to life in the fast lane, constantly moving between \
	places, meeting a myriad of people and experiencing many of the cultures and worlds close to humanity's home. As such, Spacers of the core systems tend to be busy, sociable and \
	mobile, rarely satisfied with settled life. They almost universally know how to live and work in the void and take to such jobs more readily than their planet-bound counterparts."
	additional_langs = list(/datum/language/spacer)

// Generic VERY rural
/datum/cultural_info/culture/spacer_frontier
	name = "Spacer, Frontier"
	description =  "You are from the void between worlds, though you are in the distant, vast frontier of SCG space and beyond. Out here things like national identity and culture mean less; \
	those who live so far from anything only look to their close family and friends rather than any larger group. Raised on one of the long haul freighters that move between frontier worlds delivering \
	vital goods, a lonely outpost on the edge of a dreary backwater, such people are raised in small, confined environments with few others, and tend to be most familiar with older, reliable but outdated \
	technology. An independent sort, people on the frontier are more likely to be isolationist and self-driven."
	economic_power = 0.9
	additional_langs = list(/datum/language/spacer)
