#define CULTURE_CULTURE "culture"
#define CULTURE_FACTION "faction"
#define CULTURE_LOCATION "location"

//Amount of linguistic points people have by default. 1 point to understand, 2 points to get it spoken
#define LINGUISTIC_POINTS_DEFAULT 5

#define LANGUAGE_UNDERSTOOD	1
#define LANGUAGE_SPOKEN	2

#define LESS_IMPORTANT_ROLE_LANGUAGE_REQUIREMENT null
#define NORMAL_ROLE_LANGUAGE_REQUIREMENT list(/datum/language/common = LANGUAGE_UNDERSTOOD)
#define IMPORTANT_ROLE_LANGUAGE_REQUIREMENT list(/datum/language/common = LANGUAGE_SPOKEN)


//GROUPED CULTURAL DEFINES FOR SPECIES
#define CULTURES_GENERIC 	/datum/cultural_info/culture/generic, \
						 	/datum/cultural_info/culture/vatgrown, \
						 	/datum/cultural_info/culture/spacer_core, \
						 	/datum/cultural_info/culture/spacer_frontier
#define GENERIC_CULTURAL_LANGUAGES 		/datum/language/codespeak, \
								   		/datum/language/spacer, \
								   		/datum/language/slime, \
								   		/datum/language/sylvan, \
								   		/datum/language/moffic, \
								   		/datum/language/narsie

#define CULTURES_ANTHROMORPH

#define CULTURES_AQUATIC
#define AQUATIC_CULTURAL_LANGUAGES

#define CULTURES_ETHEREAL
#define ETHEREAL_CULTURAL_LANGUAGES /datum/language/voltaic

#define CULTURES_HUMAN		/datum/cultural_info/culture/generic_human, \
							/datum/cultural_info/culture/martian_surfacer, \
							/datum/cultural_info/culture/martian_tunneller, \
							/datum/cultural_info/culture/earthling, \
							/datum/cultural_info/culture/luna_poor, \
							/datum/cultural_info/culture/luna_rich, \
							/datum/cultural_info/culture/terran, \
							/datum/cultural_info/culture/venusian_upper, \
							/datum/cultural_info/culture/venusian_surfacer, \
							/datum/cultural_info/culture/belter, \
							/datum/cultural_info/culture/plutonian, \
							/datum/cultural_info/culture/ceti
#define HUMAN_CULTURAL_LANGUAGES 		/datum/language/common, \
										/datum/language/uncommon, \
										/datum/language/russian, \
										/datum/language/terrum, \
										/datum/language/gutter, \
										/datum/language/spacer

#define CULTURES_INSECT
#define INSECT_CULTURAL_LANGUAGES	 	/datum/language/buzzwords, \
										/datum/language/moffic

#define CULTURES_JELLY
#define JELLY_CULTURAL_LANGUAGES 		/datum/language/slime

#define CULTURES_LIZARD 	/datum/cultural_info/culture/lavaland
#define LIZARD_CULTURAL_LANGUAGES 		/datum/language/draconic

#define CULTURES_PLANT
#define PLANT_CULTURAL_LANGUAGES 		/datum/language/sylvan, \
										/datum/language/mushroom

#define CULTURES_SYNTHETIC
#define SYNTHETIC_CULTURAL_LANGUAGES 	/datum/language/drone, \
								   		/datum/language/machine, \
								   		/datum/language/swarmer, \
								   		/datum/language/sylvan

#define CULTURES_TAJARAN
#define TAJARAN_CULTURAL_LANGUAGES

#define CULTURES_TESHARI /datum/cultural_info/culture/sirisai
#define TESHARI_CULTURAL_LANGUAGES 		/datum/language/schechi

#define CULTURES_UNDEAD
#define UNDEAD_CULTURAL_LANGUAGES 		/datum/language/calcic, \
										/datum/language/shadowtongue

#define CULTURES_VULPKANIN
#define VULPKANIN_CULTURAL_LANGUAGES 	/datum/language/canilunzt

#define CULTURES_VOX
#define VOX_CULTURAL_LANGUAGES 			/datum/language/vox

#define CULTURES_XENOMORPH_HYBRID
#define XENO_CULTURAL_LANGUAGES 		/datum/language/xenocommon

//GROUPED LOCATIONAL DEFINES FOR SPECIES
#define LOCATIONS_GENERIC	/datum/cultural_info/location/generic, \
							/datum/cultural_info/location/stateless

#define LOCATIONS_ANTHROMORPH

#define LOCATIONS_AQUATIC

#define LOCATIONS_ETHEREAL

#define LOCATIONS_HUMAN 	/datum/cultural_info/location/earth, \
							/datum/cultural_info/location/mars, \
							/datum/cultural_info/location/luna, \
							/datum/cultural_info/location/mars, \
							/datum/cultural_info/location/venus, \
							/datum/cultural_info/location/ceres, \
							/datum/cultural_info/location/pluto, \
							/datum/cultural_info/location/cetiepsilon, \
							/datum/cultural_info/location/eos, \
							/datum/cultural_info/location/terra, \
							/datum/cultural_info/location/tersten, \
							/datum/cultural_info/location/lorriman, \
							/datum/cultural_info/location/cinu, \
							/datum/cultural_info/location/yuklid, \
							/datum/cultural_info/location/lordania, \
							/datum/cultural_info/location/kingston, \
							/datum/cultural_info/location/gaia, \
							/datum/cultural_info/location/magnitka

#define LOCATIONS_INSECT

#define LOCATIONS_JELLY

#define LOCATIONS_LIZARD

#define LOCATIONS_PLANT

#define LOCATIONS_SYNTHETIC

#define LOCATIONS_TAJARAN

#define LOCATIONS_TESHARI

#define LOCATIONS_UNDEAD

#define LOCATIONS_VULPKANIN

#define LOCATIONS_VOX

#define LOCATIONS_XENOMORPH_HYBRID

//GROUPED FACTION DEFINES FOR SPECIES
#define FACTIONS_GENERIC	/datum/cultural_info/faction/none, \
							/datum/cultural_info/faction/generic, \
							/datum/cultural_info/faction/nanotrasen, \
							/datum/cultural_info/faction/freetrade

#define FACTIONS_ANTHROMORPH

#define FACTIONS_AQUATIC

#define FACTIONS_ETHEREAL

#define FACTIONS_HUMAN		/datum/cultural_info/faction/solgov, \
							/datum/cultural_info/faction/fleet, \
							/datum/cultural_info/faction/torchco, \
							/datum/cultural_info/faction/gcc, \
							/datum/cultural_info/faction/remote, \
							/datum/cultural_info/faction/police, \
							/datum/cultural_info/faction/xynergy, \
							/datum/cultural_info/faction/hephaestus, \
							/datum/cultural_info/faction/pcrc, \
							/datum/cultural_info/faction/saare, \
							/datum/cultural_info/faction/dais

#define FACTIONS_INSECT

#define FACTIONS_JELLY

#define FACTIONS_LIZARD

#define FACTIONS_PLANT

#define FACTIONS_SYNTHETIC

#define FACTIONS_TAJARAN

#define FACTIONS_TESHARI

#define FACTIONS_UNDEAD

#define FACTIONS_VULPKANIN

#define FACTIONS_VOX

#define FACTIONS_XENOMORPH_HYBRID


