#define JUKEBOX_MAX_RANGE 22
#define JUKEBOX_FALLOFF_DISTANCE 6
#define JUKEBOX_FALLOFF_EXPONENT 0.5

/// View range at which the jukebox will not echo the sound, as long as hearer sees the jukebox
#define JUKEBOX_VIEW_RANGE 7
/// Range at which the jukebox will echo despite being in the same area
#define JUKEBOX_ECHO_RANGE 13

#define JUKEBOX_ECHO_VOLUME_MODIFIER 0.85

#define JUKEBOX_NO_POSITIONAL_RANGE 3

#define JUKEBOX_MULTI_Z_DISTANCE_MULTIPLICATOR 9

#define MINIMUM_JUKEBOX_PRESSURE_FACTOR 0.2

/// How much %s will the jukebox clamp at maximum from ambience volumes
#define JUKEBOX_AMBIENCE_CLAMP_MAXIMUM 25
/// How much %s do we clamp from ambience per each volume of the jukebox playing
#define JUKEBOX_AMBIENCE_CLAMP_PER_VOLUME 1
