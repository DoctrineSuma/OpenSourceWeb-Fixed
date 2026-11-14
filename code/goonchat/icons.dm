var/regex/is_http_protocol = new(regex("^https?://"))

//Converts an icon to base64. Operates by putting the icon in the iconCache savefile,
// exporting it as text, and then parsing the base64 from that.
// (This relies on byond automatically storing icons in savefiles as base64)

/proc/icon2html(thing, target, icon_state, dir, frame = 1, moving = FALSE, realsize = FALSE, class = null)
	if (!thing)
		return

	var/key
	var/icon/I = thing
	if (!target)
		return
	if (target == world)
		target = clients

	var/list/targets
	if (!islist(target))
		targets = list(target)
	else
		targets = target
		if (!targets.len)
			return
	if (!isicon(I))
		if (isfile(thing)) //special snowflake
			var/name = "[generate_asset_name(thing)].png"
			register_asset(name, thing)
			for (var/thing2 in targets)
				send_asset(thing2, key, FALSE)
			return "<img class='icon icon-misc [class]' src=\"[url_encode(name)]\">"
		var/atom/A = thing
		if (isnull(dir))
			dir = A.dir
		if (isnull(icon_state))
			icon_state = A.icon_state
		I = A.icon
		if (ishuman(thing)) // Shitty workaround for a BYOND issue.
			var/icon/temp = I
			I = icon()
			I.Insert(temp, dir = SOUTH)
			dir = SOUTH
	else
		if (isnull(dir))
			dir = SOUTH
		if (isnull(icon_state))
			icon_state = ""

	I = icon(I, icon_state, dir, frame, moving)

	key = "[generate_asset_name(I)].png"
	register_asset(key, I)
	for (var/thing2 in targets)
		send_asset(thing2, key, FALSE)

	if(realsize)
		return "<img class='icon icon-[icon_state] [class]' style='width:[I.Width()]px;height:[I.Height()]px;min-height:[I.Height()]px' src=\"[url_encode(key)]\">"

	return "<img class='icon icon-[icon_state] [class]' style='width:25px;height:25px;min-height:25px' src=\"[url_encode(key)]\">"

//Costlier version of icon2html() that uses getFlatIcon() to account for overlays, underlays, etc. Use with extreme moderation, ESPECIALLY on mobs.