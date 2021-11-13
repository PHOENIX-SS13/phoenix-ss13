// Helpers for checking whether a sub-zone conforms to a specific requirement

// Basic levels
#define is_centcom_level(atom) SSmapping.sub_zone_trait(atom, ZTRAIT_CENTCOM)

#define is_station_level(atom) SSmapping.sub_zone_trait(atom, ZTRAIT_STATION)

#define is_mining_level(atom) SSmapping.sub_zone_trait(atom, ZTRAIT_MINING)

#define is_reserved_level(atom) SSmapping.sub_zone_trait(atom, ZTRAIT_RESERVED)

#define is_away_level(atom) SSmapping.sub_zone_trait(atom, ZTRAIT_AWAY)
