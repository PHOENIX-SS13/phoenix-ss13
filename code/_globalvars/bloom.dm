GLOBAL_LIST_EMPTY(bloom_overlays_cache)

#define BLOOM_SIZE_SMALL 1
#define BLOOM_SIZE_MEDIUM 2
#define BLOOM_SIZE_LARGE 3

#define BLOOM_DEFAULT_SIZE BLOOM_SIZE_MEDIUM

#define BLOOM_VERY_WEAK_ALPHA 18
#define BLOOM_WEAK_ALPHA 27
#define BLOOM_NORMAL_ALPHA 36
#define BLOOM_STRONG_ALPHA 45

#define BLOOM_DEFAULT_ALPHA BLOOM_NORMAL_ALPHA

#define BLOOM_DEFAULT_COLOR "#FFFFFF"

/proc/bloom_appearance(bloom_size = BLOOM_DEFAULT_SIZE, alpha = BLOOM_DEFAULT_ALPHA, color = BLOOM_DEFAULT_COLOR, pixel_x = 0, pixel_y = 0)
	var/key = "[bloom_size]-[alpha]-[color]-[pixel_x]-[pixel_y]"
	if(!GLOB.bloom_overlays_cache[key])
		var/bloom_icon
		switch(bloom_size)
			if(BLOOM_SIZE_SMALL)
				bloom_icon = 'icons/effects/bloom/bloom_small.dmi'
			if(BLOOM_SIZE_MEDIUM)
				bloom_icon = 'icons/effects/bloom/bloom_medium.dmi'
			if(BLOOM_SIZE_LARGE)
				bloom_icon = 'icons/effects/bloom/bloom_large.dmi'

		var/mutable_appearance/bloom = mutable_appearance(bloom_icon, "bloom", FLY_LAYER, ABOVE_LIGHTING_MOUSE_TRANSPARENT_PLANE)
		bloom.color = color
		bloom.alpha = alpha

		switch(bloom_size)
			if(BLOOM_SIZE_MEDIUM)
				bloom.pixel_x = -16
				bloom.pixel_y = -16
			if(BLOOM_SIZE_LARGE)
				bloom.pixel_x = -48
				bloom.pixel_y = -48

		bloom.pixel_x += pixel_x
		bloom.pixel_y += pixel_y
		GLOB.bloom_overlays_cache[key] = bloom

	return GLOB.bloom_overlays_cache[key]
