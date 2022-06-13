//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki()
	set name = "wiki"
	set desc = "Visit the Wiki."
	set hidden = TRUE
	var/wikiurl = CONFIG_GET(string/wikiurl)
	if(wikiurl)
		if(tgui_alert(src, "This will open the wiki in your browser. Are you sure?", buttons = list("Yes", "No")) != "Yes")
			return
		DIRECT_OUTPUT(src, link(wikiurl))
	else
		to_chat(src, SPAN_DANGER("The wiki URL is not set in the server configuration."))
	return

/client/verb/community()
	set name = "community"
	set desc = "Visit the Community."
	set hidden = TRUE
	var/forumurl = CONFIG_GET(string/forumurl)
	if(forumurl)
		if(tgui_alert(src, "This will open a link to the community in your browser. Are you sure?", buttons = list("Yes", "No")) != "Yes")
			return
		DIRECT_OUTPUT(src, link(forumurl))
	else
		to_chat(src, SPAN_DANGER("The forum URL is not set in the server configuration."))
	return

/client/verb/rules()
	set name = "rules"
	set desc = "Show Server Rules."
	set hidden = TRUE
	var/rulesurl = CONFIG_GET(string/rulesurl)
	if(rulesurl)
		if(tgui_alert(src, "This will open the rules in your browser. Are you sure?", buttons = list("Yes", "No")) != "Yes")
			return
		DIRECT_OUTPUT(src, link(rulesurl))
	else
		to_chat(src, SPAN_DANGER("The rules URL is not set in the server configuration."))
	return

/client/verb/sourcecode()
	set name = "sourcecode"
	set desc = "Visit the source code."
	set hidden = TRUE
	var/sourcerepourl = CONFIG_GET(string/sourcerepourl)
	if(sourcerepourl)
		if(tgui_alert(src, "This will open the sourecode repository in your browser. Are you sure?", buttons = list("Yes", "No")) != "Yes")
			return
		DIRECT_OUTPUT(src, link(sourcerepourl))
	else
		to_chat(src, SPAN_DANGER("The Sourcecode repo URL is not set in the server configuration."))
	return

/client/verb/reportissue()
	set name = "report-issue"
	set desc = "Report an issue"
	set hidden = TRUE
	var/sourcerepourl = CONFIG_GET(string/sourcerepourl)
	if(sourcerepourl)
		var/message = "This will open the issue reporter in your browser. Are you sure?"
		if(GLOB.revdata.testmerge.len)
			message += "<br>The following experimental changes are active and are probably the cause of any new or sudden issues you may experience. If possible, please try to find a specific thread for your issue instead of posting to the general issue tracker:<br>"
			message += GLOB.revdata.GetTestMergeInfo(FALSE)
		// We still use tgalert here because some people were concerned that if someone wanted to report that tgui wasn't working
		// then the report issue button being tgui-based would be problematic.
		if(tgalert(src, message, "Report Issue", "Yes", "No") != "Yes")
			return

		// Keep a static version of the template to avoid reading file
		var/static/issue_template = file2text(".github/ISSUE_TEMPLATE/bug_report.md")

		// Get a local copy of the template for modification
		var/local_template = issue_template

		// Remove comment header
		var/content_start = findtext(local_template, "<")
		if(content_start)
			local_template = copytext(local_template, content_start)

		// Insert round
		if(GLOB.round_id)
			local_template = replacetext(local_template, "## Round ID:\n", "## Round ID:\n[GLOB.round_id]")

		// Insert testmerges
		if(GLOB.revdata.testmerge.len)
			var/list/all_tms = list()
			for(var/entry in GLOB.revdata.testmerge)
				var/datum/tgs_revision_information/test_merge/tm = entry
				all_tms += "- \[[tm.title]\]([sourcerepourl]/pull/[tm.number])"
			var/all_tms_joined = all_tms.Join("\n") // for some reason this can't go in the []
			local_template = replacetext(local_template, "## Testmerges:\n", "## Testmerges:\n[all_tms_joined]")

		var/url_params = "Reporting client version: [byond_version].[byond_build]\n\n[local_template]"
		DIRECT_OUTPUT(src, link("[sourcerepourl]/issues/new?body=[url_encode(url_params)]"))
	else
		to_chat(src, SPAN_DANGER("The sourecode repo URL is not set in the server configuration."))
	return

/client/verb/changelog()
	set name = "Changelog"
	set category = "OOC"
	if(!GLOB.changelog_tgui)
		GLOB.changelog_tgui = new /datum/changelog()

	GLOB.changelog_tgui.ui_interact(mob)
	if(prefs.lastchangelog != GLOB.changelog_hash)
		prefs.lastchangelog = GLOB.changelog_hash
		prefs.save_preferences()
		winset(src, "infowindow.changelog", "font-style=;")
