/client/proc/air_report()
	set category = "Debug"
	set name = "Show Air Report"

	if(!master_controller || !air_master)
		alert(usr,"Master_controller or air_master not found.","Air Report")
		return

	var/active_groups = air_master.active_zones
	var/inactive_groups = air_master.zones.len - active_groups

	var/hotspots = 0
	for(var/obj/fire/hotspot in world)
		hotspots++

	var/active_on_main_station = 0
	var/inactive_on_main_station = 0
	for(var/zone/zone in air_master.zones)
		var/turf/simulated/turf = locate() in zone.contents
		if(turf && turf.z in vessel_z)
			if(zone.needs_update)
				active_on_main_station++
			else
				inactive_on_main_station++

	var/output = {"<B>AIR SYSTEMS REPORT</B><HR>
<B>General Processing Data</B><BR>
	Cycle: [air_master.current_cycle]<br>
	Groups: [air_master.zones.len]<BR>
---- <I>Active:</I> [active_groups]<BR>
---- <I>Inactive:</I> [inactive_groups]<BR><br>
---- <I>Active on station:</i> [active_on_main_station]<br>
---- <i>Inactive on station:</i> [inactive_on_main_station]<br>
<BR>
<B>Special Processing Data</B><BR>
	Hotspot Processing: [hotspots]<BR>
<br>
<B>Geometry Processing Data</B><BR>
	Tile Update: [air_master.tiles_to_update.len]<BR>
"}

	usr << browse(output,"window=airreport")

/client/proc/reload_admins()
	set name = "Reload Admins"
	set category = "Debug"

	if(!check_rights(R_SERVER))	return
	message_admins("[usr] manually reloaded admins")
	load_admins()

/client/proc/print_jobban_old()
	set name = "Print Jobban Log"
	set desc = "This spams all the active jobban entries for the current round to standard output."
	set category = "Debug"

	usr << "<b>Jobbans active in this round.</b>"
	for(var/t in jobban_keylist)
		usr << "[t]"

/client/proc/print_jobban_old_d_filter()
	set name = "Search Jobban Log"
	set desc = "This searches all the active jobban entries for the current round and outputs the results to standard output."
	set category = "Debug"

	var/d_filter = input("Contains what?","d_filter") as text|null
	if(!d_filter)
		return

	usr << "<b>Jobbans active in this round.</b>"
	for(var/t in jobban_keylist)
		if(findtext(t, d_filter))
			usr << "[t]"
