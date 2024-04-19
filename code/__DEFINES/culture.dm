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
						 	/datum/cultural_info/culture/interstellar_trader, \
						 	/datum/cultural_info/culture/spacer_core, \
						 	/datum/cultural_info/culture/spacer_frontier
#define GENERIC_CULTURAL_LANGUAGES 		/datum/language/codespeak, \
								   		/datum/language/spacer, \
								   		/datum/language/slime, \
								   		/datum/language/sylvan, \
								   		/datum/language/moffic, \
								   		/datum/language/narsie

#define CULTURES_ANTHROMORPH

#define CULTURES_AQUATIC	/datum/cultural_info/culture/aquatic, \
							/datum/cultural_info/culture/aquatic/eskith, \
							/datum/cultural_info/culture/aquatic/eskith/colonies
#define AQUATIC_CULTURAL_LANGUAGES

#define CULTURES_ETHEREAL	/datum/cultural_info/culture/tau_ceti/ethereal
#define ETHEREAL_CULTURAL_LANGUAGES /datum/language/voltaic

#define CULTURES_HUMAN		/datum/cultural_info/culture/generic_human, \
							/datum/cultural_info/culture/tau_ceti, \
							/datum/cultural_info/culture/venusian_surfacer, \
							/datum/cultural_info/culture/venusian_upper, \
							/datum/cultural_info/culture/earthling, \
							/datum/cultural_info/culture/luna_poor, \
							/datum/cultural_info/culture/luna_rich, \
							/datum/cultural_info/culture/martian_surfacer, \
							/datum/cultural_info/culture/martian_tunneller, \
							/datum/cultural_info/culture/belter, \
							/datum/cultural_info/culture/titan, \
							/datum/cultural_info/culture/plutonian, \
							/datum/cultural_info/culture/terran, \

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

#define CULTURES_TESHARI	/datum/cultural_info/culture/sirisai, \
							/datum/cultural_info/culture/titan/immigrant, \
							/datum/cultural_info/culture/sirisai/avali
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

#define LOCATIONS_AQUATIC	//datum/cultural_info/location/nralakk/qerrbalak

#define LOCATIONS_ETHEREAL	/datum/cultural_info/location/tau_ceti/tau_ceti_b, \

#define LOCATIONS_HUMAN 	/datum/cultural_info/location/tau_ceti/tau_ceti_b/tau_ceti_bv, \
							/datum/cultural_info/location/sol/venus, \
							/datum/cultural_info/location/sol/earth, \
							/datum/cultural_info/location/sol/earth/luna, \
							/datum/cultural_info/location/sol/mars, \
							/datum/cultural_info/location/sol/ceres, \
							/datum/cultural_info/location/sol/saturn/titan, \
							/datum/cultural_info/location/sol/pluto, \
							/datum/cultural_info/location/helios/eos, \
							/datum/cultural_info/location/gavil/tersten, \
							/datum/cultural_info/location/lucinaer/cinu, \
							/datum/cultural_info/location/yuklid/yuklid_f, \
							/datum/cultural_info/location/gessshire/lorriman, \
							/datum/cultural_info/location/lordania/lordania_b, \
							/datum/cultural_info/location/lordania/kingston, \
							/datum/cultural_info/location/galilei/gaia, \
							/datum/cultural_info/location/ursa/magnitka, \
							/datum/cultural_info/location/gilgamesh/terra

#define LOCATIONS_INSECT

#define LOCATIONS_JELLY

#define LOCATIONS_LIZARD	//datum/cultural_info/location/beta_centaurus/moghes

#define LOCATIONS_PLANT

#define LOCATIONS_SYNTHETIC

#define LOCATIONS_TAJARAN	//datum/cultural_info/location/tau_ceti/ahdomai

#define LOCATIONS_TESHARI	//datum/cultural_info/location/nralakk/qerrbalak

#define LOCATIONS_UNDEAD

#define LOCATIONS_VULPKANIN	//datum/cultural_info/location/vazzend/altam, \
							//datum/cultural_info/location/vazzend/kelune

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


