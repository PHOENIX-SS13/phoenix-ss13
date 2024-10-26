/datum/language/draconic
	name = "Draconic"
	desc = "The common language of lizard-people, composed of sibilant hisses and rattles."
	key = "dr"
	flags = TONGUELESS_SPEECH
	space_chance = 40
	sentence_chance = 80
	syllables = list(
/*2 letter syllables*/
//       -A   -E   -I   -O   -U   -Y   -H   -L   -K   -S   -R   -N   -D   -T   -G   -J   -Q
/*A-*/       "ae",                    "ah","al","ak","as","ar","an","ad","at","ag","aj","aq",
/*E-*/            "ei",               "eh","el","ek","es","er","en","ed","et",          "eq",
/*I-*/                                "ih","il","ik","is","ir","in","id","it","ig",
/*O-*/                           "oy","oh","ol","ok","os","or","on","od","ot","og",
/*U-*/            "ui",     "uu","uy","uh","ul","uk","us","ur","un","ud","ut","ug",
/*Y-*/                                "yh","yl","yk","ys","yr","yn","yd","yt",
/*H-*/  "ha","he","hi","ho","hu","hy",     "hl","hk","hs","hr","hn","hd","ht",
/*L-*/  "la","le","li","lo","lu","ly","lh","ll",	 "ls",
/*K-*/  "ka","ke","ki","ko","ku","ky","kh","kl",     "ks","kr",               "kg",
/*S-*/  "sa","se","si","so","su","sy","sh","sl","sk","ss","sr","sn","sd","st","sg",
/*R-*/  "ra","re","ri","ro","ru","ry",				 "rs",
/*N-*/  "na","ne","ni","no","nu","ny",				 "ns",
/*D-*/  "da","de","di","do","du","dy",				 "ds",
/*T-*/  "ta","te","ti","to","tu","ty",				 "ts",
/*G-*/  "ga",
/*J-*/       "je",
/*Q-*/            "qi","qo","qu","qy","qh","ql",     "qs","qr",               "qg"
	)
	icon_state = "lizard"
	default_priority = 90
