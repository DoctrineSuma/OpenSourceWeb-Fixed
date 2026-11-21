/*
/datum/admins/proc/skip_baron()
	set category = "Server"
	set name = "Skip Baron Check"
	if(!ticker)
		alert("Unable to start the game as it is not set up.")
		return
	if(ticker.jobbypass == FALSE)
		ticker.jobbypass = TRUE
		src << "<b>JOB BYPASS TOGGLED :</b> [ticker.jobbypass]"
	else
		ticker.jobbypass = FALSE
		src << "<b>JOB BYPASS TOGGLED :</b> [ticker.jobbypass]"
*/

// So lights and airlocks that are in charger-covered areas don't drain batteries
/client/proc/toggle_admin_free_power()
	set category = "Server"
	set name = "Toggle Free Power (Lifeweb)"

	if(!check_rights(R_SERVER))
		return

	adminFreePower = !adminFreePower
	log_admin("[key_name(src)] has turned free power [adminFreePower ? "on" : "off"].")
	message_admins("[key_name_admin(src)] has turned free power [adminFreePower ? "on" : "off"].")
	to_chat(src, "<b>FREE POWER:</b> [adminFreePower ? "ENABLED (no battery drain)" : "DISABLED"]")
