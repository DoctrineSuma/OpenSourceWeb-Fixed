//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

proc/Stagger(mob/M,d) //Technically not a d_filter, but it relates to drunkenness.
	step(M, pick(d,turn(d,90),turn(d,-90)))

proc/Ellipsis(original_msg, chance = 50)
	if(chance <= 0) return "..."
	if(chance >= 100) return original_msg

	var/list/words = text2list(original_msg," ")
	var/list/new_words = list()

	var/new_msg = ""

	for(var/w in words)
		if(prob(chance))
			new_words += "..."
		else
			new_words += w

	new_msg = list2text(new_words," ")

	return new_msg
