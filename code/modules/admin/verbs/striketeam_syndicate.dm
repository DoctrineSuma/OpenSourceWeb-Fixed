//STRIKE TEAMS

var/const/syndicate_commandos_possible = 6 //if more Commandos are needed in the future
var/global/sent_syndicate_strike_team = 0

/client/proc/create_syndicate_death_commando(obj/spawn_location, syndicate_leader_selected = 0)
	var/mob/living/carbon/human/new_syndicate_commando = new(spawn_location.loc)
	var/syndicate_commando_leader_rank = pick("Lt.")
	var/syndicate_commando_rank = pick("Pvt.", "Pfc.", "LCpl.", "Cpl.", "Sgt.")
	var/syndicate_commando_name = pick(last_names)

	if(trapapoc.Find(ckey(src.key)))
		new_syndicate_commando.gender = pick(MALE,FEMALE)
	else
		new_syndicate_commando.gender = MALE

	var/datum/preferences/A = new()//Randomize appearance for the commando.
	A.randomize_appearance_for(new_syndicate_commando)

	new_syndicate_commando.real_name = "[!syndicate_leader_selected ? syndicate_commando_rank : syndicate_commando_leader_rank] [syndicate_commando_name]"
	new_syndicate_commando.age = !syndicate_leader_selected ? rand(23,35) : rand(35,45)

	new_syndicate_commando.dna.ready_dna(new_syndicate_commando)//Creates DNA.

	//Creates mind stuff.
	new_syndicate_commando.mind_initialize()
	new_syndicate_commando.mind.assigned_role = "MODE"
	new_syndicate_commando.mind.special_role = "Tribunal Ordinator"
	new_syndicate_commando.old_job = "Tribunal Ordinator"
	new_syndicate_commando.job = "Tribunal Ordinator"
	new_syndicate_commando.equip_syndicate_commando(syndicate_leader_selected)
	qdel(spawn_location)
	return new_syndicate_commando

/mob/living/carbon/human/proc/equip_syndicate_commando(syndicate_leader_selected = 0)
	var/radio_freq = COMM_FREQ
	var/obj/item/device/radio/R = new /obj/item/device/radio/headset/tribunal(src)
	R.set_frequency(radio_freq) //Same frequency as the syndicate team in Nuke mode.
	equip_to_slot_or_del(R, slot_l_ear)
	equip_to_slot_or_del(new /obj/item/clothing/under/ordinator(src), slot_w_uniform)
	equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/infantry(src), slot_shoes)
	equip_to_slot_or_del(new /obj/item/weapon/shield/generator/wrist(src), slot_wrist_l)
	src.client.color = null
	src.my_stats.st = 13
	src.my_stats.dx = rand(10,11)
	src.my_stats.ht = rand(12,14)
	src.my_stats.pr = rand(14,16)
	src.my_skills.CHANGE_SKILL(SKILL_MELEE, rand(13,15))
	src.my_skills.CHANGE_SKILL(SKILL_RANGE, rand(13,15))
	src.my_skills.CHANGE_SKILL(SKILL_CLIMB, rand(12,13))
	src.my_skills.CHANGE_SKILL(SKILL_SURG, 11)
	src.my_skills.CHANGE_SKILL(SKILL_MEDIC, 11)
	var/obj/item/weapon/card/id/syndicate/W = new(src) //Untrackable by AI
	W.name = "[real_name]'s ID Card"
	W.icon_state = "id"
	W.access = get_all_accesses()//They get full station access because obviously the syndicate has HAAAX, and can make special IDs for their most elite members.
	W.access += list(access_cent_general, access_cent_specops, access_cent_living, access_cent_storage, access_syndicate)//Let's add their forged CentCom access and syndicate access.
	W.assignment = "Tribunal Ordinator"
	W.registered_name = real_name
	equip_to_slot_or_del(W, slot_wear_id)

	return 1