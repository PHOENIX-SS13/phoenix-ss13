/datum/language/swarmer
	name = "Swarmer"
	desc = "A language only consisting of musical notes."
	key = "sw"
	icon_state = "swarmer"
	spans = list(SPEECH_SPAN_ROBOT)
	space_chance = 100
	sentence_chance = 0
	default_priority = 60
	flags = NO_STUTTER

	// since various flats and sharps are the same,
	// all non-accidental notes are doubled in the list

	// The list with unicode symbols for the accents.
	syllables = list(
					"C", "C",
					"C♯", "D♭",
					"D", "D",
					"D♯", "E♭",
					"E", "E",
					"F", "F",
					"F♯", "G♭",
					"G", "G",
					"G♯", "A♭",
					"A", "A",
					"A♯", "B♭",
					"B", "B")
	/*
	syllables = list(
					"C", "C",
					"C#", "D♭",
					"D", "D",
					"D#", "Eb",
					"E", "E",
					"F", "F",
					"F#", "Gb",
					"G", "G",
					"G#", "Ab",
					"A", "A",
					"A#", "Bb",
					"B", "B")
					*/
