//Space Ruin Parents

/area/ruin/space
	has_gravity = FALSE
	area_flags = NONE

/area/ruin/space/has_grav
	has_gravity = STANDARD_GRAVITY

/area/ruin/space/has_grav/powered
	requires_power = FALSE

/////////////

/area/ruin/space/way_home
	name = "\improper Salvation"
	icon_state = "away"
	always_unpowered = FALSE

// Ruins of "onehalf" ship

/area/ruin/space/has_grav/onehalf/hallway
	name = "Hallway"
	icon_state = "hallC"

/area/ruin/space/has_grav/onehalf/drone_bay
	name = "Mining Drone Bay"
	icon_state = "engine"

/area/ruin/space/has_grav/onehalf/dorms_med
	name = "Crew Quarters"
	icon_state = "Sleep"

/area/ruin/space/has_grav/onehalf/bridge
	name = "Bridge"
	icon_state = "bridge"



/area/ruin/space/has_grav/powered/dinner_for_two
	name = "Dinner for Two"

/area/ruin/space/has_grav/powered/cat_man
	name = "Kitty Den"

/area/ruin/space/has_grav/powered/authorship
	name = "Authorship"

/area/ruin/space/has_grav/powered/aesthetic
	name = "Aesthetic"
	main_ambience = AMBIENCE_VAPORWAVE


//Ruin of Hotel

/area/ruin/space/has_grav/hotel
	name = "Hotel"

/area/ruin/space/has_grav/hotel/guestroom
	name = "Hotel Guest Room"
	icon_state = "dorms"

/area/ruin/space/has_grav/hotel/guestroom/room_1
	name = "Hotel Guest Room 1"

/area/ruin/space/has_grav/hotel/guestroom/room_2
	name = "Hotel Guest Room 2"

/area/ruin/space/has_grav/hotel/guestroom/room_3
	name = "Hotel Guest Room 3"

/area/ruin/space/has_grav/hotel/guestroom/room_4
	name = "Hotel Guest Room 4"

/area/ruin/space/has_grav/hotel/guestroom/room_5
	name = "Hotel Guest Room 5"

/area/ruin/space/has_grav/hotel/guestroom/room_6
	name = "Hotel Guest Room 6"

/area/ruin/space/has_grav/hotel/guestroom/room_7
	name = "Hotel Guest Room 7"

/area/ruin/space/has_grav/hotel/guestroom/room_8
	name = "Hotel Guest Room 8"

/area/ruin/space/has_grav/hotel/guestroom/room_9
	name = "Hotel Family Room"

/area/ruin/space/has_grav/hotel/guestroom/room_10
	name = "Hotel Deluxe Suite"

/area/ruin/space/has_grav/hotel/security
	name = "Hotel Security Post"
	icon_state = "security"

/area/ruin/space/has_grav/hotel/fitness
	name = "Hotel Fitness Room"
	icon_state = "fitness"
	main_ambience = AMBIENCE_PSYCH

/area/ruin/space/has_grav/hotel/toilet
	name = "Hotel Restrooms"
	icon_state = "toilet"

/area/ruin/space/has_grav/hotel/pool
	name = "Hotel Pool"
	icon_state = "fitness"
	main_ambience = AMBIENCE_PSYCH

/area/ruin/space/has_grav/hotel/sauna
	name = "Hotel Sauna"
	icon_state = "fitness"
	main_ambience = AMBIENCE_PSYCH

/area/ruin/space/has_grav/hotel/bar
	name = "Hotel Bar"
	icon_state = "cafeteria"

/area/ruin/space/has_grav/hotel/laundry
	name = "Hotel Laundry"
	icon_state = "crew_quarters"

/area/ruin/space/has_grav/hotel/bar_backroom
	name = "Hotel Bar Backroom"
	icon_state = "crew_quarters"

/area/ruin/space/has_grav/hotel/dining_hall
	name = "Hotel Dining Hall"
	icon_state = "cafeteria"
	main_ambience = AMBIENCE_DETECTIVE

/area/ruin/space/has_grav/hotel/kitchen
	name = "Hotel Kitchen"
	icon_state = "kitchen"

/area/ruin/space/has_grav/hotel/hydroponics
	name = "Hotel Hydroponics"
	icon_state = "hydro"

/area/ruin/space/has_grav/hotel/power
	name = "Hotel Engineering Room"
	icon_state = "engine_smes"
	main_ambience = AMBIENCE_ENGI

/area/ruin/space/has_grav/hotel/custodial
	name = "Hotel Custodial Closet"
	icon_state = "janitor"

/area/ruin/space/has_grav/hotel/shuttle
	name = "Hotel Shuttle"
	icon_state = "shuttle"
	requires_power = FALSE

/area/ruin/space/has_grav/hotel/dock
	name = "Hotel Shuttle Dock"
	icon_state = "start"

/area/ruin/space/has_grav/hotel/workroom
	name = "Hotel Staff Room"
	icon_state = "crew_quarters"

/area/ruin/space/has_grav/hotel/maintenance
	name = "Hotel Maintenence"
	icon_state = "maintcentral"

/area/ruin/space/has_grav/hotel/first_aid
	name = "Hotel First Aid"
	icon_state = "medbay1"
	main_ambience = AMBIENCE_MEDICAL

/area/ruin/space/has_grav/hotel/hall_aft
	name = "Hotel Arrivals Hallway"
	icon_state = "hallA"

/area/ruin/space/has_grav/hotel/hall_fore
	name = "Hotel Rooms Hallway"
	icon_state = "hallF"

/area/ruin/space/has_grav/hotel/docking_hall
	name = "Hotel Docking Ports"
	icon_state = "entry"

/area/ruin/space/has_grav/hotel/teleporter
	name = "Hotel Teleporter"
	icon_state = "entry"
	main_ambience = AMBIENCE_ENGI

//Ruin of Derelict Oupost

/area/ruin/space/has_grav/derelictoutpost
	name = "Derelict Outpost"
	icon_state = "green"

/area/ruin/space/has_grav/derelictoutpost/cargostorage
	name = "Derelict Outpost Cargo Storage"
	icon_state = "storage"

/area/ruin/space/has_grav/derelictoutpost/cargobay
	name = "Derelict Outpost Cargo Bay"
	icon_state = "quartstorage"

/area/ruin/space/has_grav/derelictoutpost/powerstorage
	name = "Derelict Outpost Power Storage"
	icon_state = "engine_smes"

/area/ruin/space/has_grav/derelictoutpost/dockedship
	name = "Derelict Outpost Docked Ship"
	icon_state = "red"

//Ruin of turretedoutpost

/area/ruin/space/has_grav/turretedoutpost
	name = "Turreted Outpost"
	icon_state = "red"


//Ruin of old teleporter

/area/ruin/space/oldteleporter
	name = "Old Teleporter"
	icon_state = "teleporter"


//Ruin of mech transport

/area/ruin/space/has_grav/powered/mechtransport
	name = "Mech Transport"
	icon_state = "green"


//Ruin of gas the lizard

/area/ruin/space/has_grav/gasthelizard
	name = "Gas the lizard"


//Ruin of Deep Storage

/area/ruin/space/has_grav/deepstorage
	name = "Deep Storage"
	icon_state = "storage"

/area/ruin/space/has_grav/deepstorage/airlock
	name = "Deep Storage Airlock"
	icon_state = "quart"

/area/ruin/space/has_grav/deepstorage/power
	name = "Deep Storage Power and Atmospherics Room"
	icon_state = "engi_storage"

/area/ruin/space/has_grav/deepstorage/hydroponics
	name = "Deep Storage Hydroponics"
	icon_state = "garden"

/area/ruin/space/has_grav/deepstorage/armory
	name = "Deep Storage Secure Storage"
	icon_state = "armory"

/area/ruin/space/has_grav/deepstorage/storage
	name = "Deep Storage Storage"
	icon_state = "storage_wing"

/area/ruin/space/has_grav/deepstorage/dorm
	name = "Deep Storage Dormitory"
	icon_state = "crew_quarters"

/area/ruin/space/has_grav/deepstorage/kitchen
	name = "Deep Storage Kitchen"
	icon_state = "kitchen"

/area/ruin/space/has_grav/deepstorage/crusher
	name = "Deep Storage Recycler"
	icon_state = "storage"


//Ruin of Abandoned Zoo

/area/ruin/space/has_grav/abandonedzoo
	name = "Abandoned Zoo"
	icon_state = "green"


//Ruin of ancient Space Station

/area/ruin/space/has_grav/ancientstation
	name = "Charlie Station Main Corridor"
	icon_state = "green"

/area/ruin/space/has_grav/ancientstation/powered
	name = "Powered Tile"
	icon_state = "teleporter"
	requires_power = FALSE

/area/ruin/space/has_grav/ancientstation/space
	name = "Exposed To Space"
	icon_state = "teleporter"
	has_gravity = FALSE

/area/ruin/space/has_grav/ancientstation/atmo
	name = "Beta Station Atmospherics"
	icon_state = "red"
	main_ambience = AMBIENCE_ENGI
	has_gravity = TRUE

/area/ruin/space/has_grav/ancientstation/betacorridor
	name = "Beta Station Main Corridor"
	icon_state = "bluenew"

/area/ruin/space/has_grav/ancientstation/engi
	name = "Charlie Station Engineering"
	icon_state = "engine"
	main_ambience = AMBIENCE_ENGI

/area/ruin/space/has_grav/ancientstation/comm
	name = "Charlie Station Command"
	icon_state = "captain"

/area/ruin/space/has_grav/ancientstation/hydroponics
	name = "Charlie Station Hydroponics"
	icon_state = "garden"

/area/ruin/space/has_grav/ancientstation/kitchen
	name = "Charlie Station Kitchen"
	icon_state = "kitchen"

/area/ruin/space/has_grav/ancientstation/sec
	name = "Charlie Station Security"
	icon_state = "red"

/area/ruin/space/has_grav/ancientstation/deltacorridor
	name = "Delta Station Main Corridor"
	icon_state = "green"

/area/ruin/space/has_grav/ancientstation/proto
	name = "Delta Station Prototype Lab"
	icon_state = "toxlab"

/area/ruin/space/has_grav/ancientstation/rnd
	name = "Delta Station Research and Development"
	icon_state = "toxlab"

/area/ruin/space/has_grav/ancientstation/deltaai
	name = "Delta Station AI Core"
	icon_state = "ai"
	main_ambience = AMBIENCE_AI_CORE
	ambient_noises = list(
		AMBIENCE_AI_SPACEJAM,
	)

/area/ruin/space/has_grav/ancientstation/mining
	name = "Beta Station Mining Equipment"
	icon_state = "mining"

/area/ruin/space/has_grav/ancientstation/medbay
	name = "Beta Station Medbay"
	icon_state = "medbay"

/area/ruin/space/has_grav/ancientstation/betastorage
	name = "Beta Station Storage"
	icon_state = "storage"

/area/solars/ancientstation
	name = "Charlie Station Solar Array"
	icon_state = "panelsP"

//DERELICT

/area/ruin/space/derelict
	name = "Derelict Station"
	icon_state = "storage"

/area/ruin/space/derelict/hallway/primary
	name = "Derelict Primary Hallway"
	icon_state = "hallP"

/area/ruin/space/derelict/hallway/secondary
	name = "Derelict Secondary Hallway"
	icon_state = "hallS"

/area/ruin/space/derelict/hallway/primary/port
	name = "Derelict Port Hallway"
	icon_state = "hallFP"

/area/ruin/space/derelict/arrival
	name = "Derelict Arrival Centre"
	icon_state = "yellow"

/area/ruin/space/derelict/storage/equipment
	name = "Derelict Equipment Storage"

/area/ruin/space/derelict/bridge
	name = "Derelict Control Room"
	icon_state = "bridge"

/area/ruin/space/derelict/bridge/access
	name = "Derelict Control Room Access"
	icon_state = "auxstorage"

/area/ruin/space/derelict/bridge/ai_upload
	name = "Derelict Computer Core"
	icon_state = "ai"

/area/ruin/space/derelict/solar_control
	name = "Derelict Solar Control"
	icon_state = "engine"

/area/ruin/space/derelict/se_solar
	name = "South East Solars"
	icon_state = "engine"

/area/ruin/space/derelict/medical
	name = "Derelict Medbay"
	icon_state = "medbay"

/area/ruin/space/derelict/medical/chapel
	name = "Derelict Chapel"
	icon_state = "chapel"

/area/solars/derelict_starboard
	name = "Derelict Starboard Solar Array"
	icon_state = "panelsS"

/area/solars/derelict_aft
	name = "Derelict Aft Solar Array"
	icon_state = "yellow"

/area/ruin/space/derelict/singularity_engine
	name = "Derelict Singularity Engine"
	icon_state = "engine"

/area/ruin/space/derelict/gravity_generator
	name = "Derelict Gravity Generator Room"
	icon_state = "red"

/area/ruin/space/derelict/atmospherics
	name = "Derelict Atmospherics"
	icon_state = "red"

//DJSTATION

/area/ruin/space/djstation
	name = "Ruskie DJ Station"
	icon_state = "DJ"
	has_gravity = STANDARD_GRAVITY

/area/ruin/space/djstation/solars
	name = "DJ Station Solars"
	icon_state = "DJ"
	has_gravity = STANDARD_GRAVITY

//ABANDONED TELEPORTER

/area/ruin/space/abandoned_tele
	name = "Abandoned Teleporter"
	icon_state = "teleporter"
	main_ambience = AMBIENCE_ABANDONED_TELEPORTER

//OLD AI SAT

/area/tcommsat/oldaisat
	name = "Abandoned Satellite"
	icon_state = "tcomsatcham"

//ABANDONED BOX WHITESHIP

/area/ruin/space/has_grav/whiteship/box

	name = "Abandoned Ship"
	icon_state = "red"


//SYNDICATE LISTENING POST STATION

/area/ruin/space/has_grav/listeningstation
	name = "Listening Post"
	icon_state = "yellow"

/area/ruin/space/has_grav/powered/ancient_shuttle
	name = "Ancient Shuttle"
	icon_state = "yellow"

//HELL'S FACTORY OPERATING FACILITY
/area/ruin/space/has_grav/hellfactory
	name = "Hell Factory"
	icon_state = "yellow"

/area/ruin/space/has_grav/hellfactoryoffice
	name = "Hell Factory Office"
	icon_state = "red"
	area_flags = VALID_TERRITORY | BLOBS_ALLOWED | UNIQUE_AREA | NOTELEPORT

// HORIZON RUINS !!!

//Engineering Ruin - _maps/RandomRuins/SpaceRuins/outpost_engineering.dmm
// Small outpost with a telecomms relay and some engineering equipment with a habitation area.

/area/ruin/space/has_grav/outpost_engineering
	name = "Service Outpost"
	icon_state = "storage"

/area/ruin/space/has_grav/outpost_engineering/habitation
	name = "Service Outpost Habitation"
	icon_state = "garden"

/area/ruin/space/has_grav/outpost_engineering/roomone
	name = "Service Outpost Bedroom"
	icon_state = "crew_quarters"

/area/ruin/space/has_grav/outpost_engineering/roomtwo
	name = "Service Outpost Bedroom"
	icon_state = "crew_quarters"

/area/ruin/space/has_grav/outpost_engineering/maint
	name = "Service Outpost Maintenance"
	icon_state = "maintcentral"

/area/ruin/space/has_grav/outpost_engineering/hanger
	name = "Service Outpost Hanger"
	icon_state = "entry"

/area/ruin/space/has_grav/outpost_engineering/storage
	name = "Service Outpost Control Room"
	icon_state = "storage"

/area/ruin/space/has_grav/broadcast_station
	name = "Broadcast Station"
	icon_state = "tcomsatcham"