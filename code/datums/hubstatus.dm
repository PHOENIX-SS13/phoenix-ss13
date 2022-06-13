/datum/hubstatus
	var/popcap
	var/server_name
	var/server_desc
	var/website_url
	var/forum_url
	var/clients
	var/players

/datum/hubstatus/proc/get_status()
	clients = GLOB.clients.len
	players = GLOB.player_list.len

	if(config)
		website_url = CONFIG_GET(string/websiteurl)
		forum_url = CONFIG_GET(string/forumurl)

		popcap = max(CONFIG_GET(number/extreme_popcap), CONFIG_GET(number/hard_popcap), CONFIG_GET(number/soft_popcap))
		server_name = CONFIG_GET(string/servername)
		server_desc = CONFIG_GET(string/serverdesc)

	server_name = server_name ? server_name : station_name()

	// Intermediates, that get constructed partly with config values.
	// Make sure these can return valid values even if no config is loaded!
	var/forumurl_text = forum_url ? " — <a href=\"[forum_url]\">Discord</a>" : ""
	var/population_text = "[clients][popcap ? "/[popcap]" : ""], [players] playing"
	var/map_text = "Map: [SSmapping.config.map_name]"

	// Our custom status construct
	var/hubstatus = {"
	<b>[website_url ? "<a href=\"[website_url]\">[server_name]</a>" : server_name]</b>\] [forumurl_text]
	[server_desc ? "<i>[server_desc]</i>" : ""]

	[map_text]
	\[[population_text]"}

	return hubstatus
