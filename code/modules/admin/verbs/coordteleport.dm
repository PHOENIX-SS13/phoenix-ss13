/client/proc/coordteleport(msg as text)
	set category = "Admin.Game"
	set name = "Coordinate Teleport"

	if(!holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return

	var/x = input(usr, "X", "Coordinate Teleport") as num|null
	var/y = input(usr, "Y", "Coordinate Teleport") as num|null
	var/z = input(usr, "Z", "Coordinate Teleport") as num|null

	if(isnull(x) || isnull(y) || isnull(z))
		return

	var/atom/dest = locate(x, y, z)
	usr.forceMove(dest)
