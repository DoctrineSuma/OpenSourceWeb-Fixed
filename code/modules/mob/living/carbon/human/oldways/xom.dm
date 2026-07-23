//XOMITAS QUE ELE VAI AFETAR
var/global/list/xomStatues = list()
var/global/list/xomites = list()

//PRIMEIRO ITEM DA LISTA É A PROBABILIDADE DO EVENTO ACONTECER, O SEGUNDO É A PROC DO EVENTO
var/global/list/xomPowers = list(
	list(20, /mob/living/carbon/human/proc/letsseeafriend),
	list(15, /mob/living/carbon/human/proc/spawnmonsters),
	list(3, /mob/living/carbon/human/proc/throughfire),
	list(10, /mob/living/carbon/human/proc/flylikeabird),
	list(15, /mob/living/carbon/human/proc/getrich),
	list(15, /mob/living/carbon/human/proc/turnintoblackperson),
	list(10, /mob/living/carbon/human/proc/fakeneckwrench),
	list(1, /mob/living/carbon/human/proc/wingame),
	list(10, /mob/living/carbon/human/proc/penisgigante),
	)

//EU DEVIA FAZER UM DATUM MAS FODASE!!
var/xomPhrases = list("Time for some fun!", "Have you ever been breastfed by a god?", "God forgive me... but I will have to fight the envious.", "Invite me to the party...", "The fun never ends!", "Son of a bitch!!!", "Shut your mouth, you son of a bitch!", "I am gay.", "Homosexuals are going to ruin this country.", "Is it 17 or not?", "Viva Lula!", "Viva Cuba!", "I would fuck Dilma Rousseff.", "I don't know what I am, I haven't had sex yet.", "Shut up, you retarded child!", "...")

/obj/structure/oldways
	name = "Xom"
	density = 1
	icon = 'icons/mining.dmi'
	icon_state = "XOM"
	var/convertPhrase = list("Are you into jokes?", "Are you on the call?", "The fun can't end...", "My God in heaven.", "Get out of here, I'm taking a shower!")
	var/textColor = "#808080"
	var/fontSize = "100%"
	anchored = 1
	breakable = TRUE
	hits = 25

/obj/structure/oldways/xom
	icon_state = "XOM"
	fontSize = "133%"

/obj/structure/oldways/xom/New()
	..()
	xomStatues += src

/obj/structure/oldways/RightClick(mob/living/carbon/human/user)
	if(user.old_ways.god == name || user.religion != "Old Ways")
		return
	var/selection = alert("Do you accept [icon_state] as your leader?", "Old Ways", "Yes", "No")
	if(selection == "Yes")
		user.old_ways.god = name
		to_chat(user, "<b>You serve [name]</b> now!")
		if(prob(50))
			var/message = pick(convertPhrase)
			var/ending = copytext(convertPhrase, length(convertPhrase))
			var/icontogo = "h0"

			switch(ending)
				if("!")
					visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>[message]</b></span></span>\"")
					icontogo = "h2"
				if("?")
					visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]; font-size'>[name]</b></span> <span class='sayverb'>asks, </span>\"<span class='saybasic'>[message]</span></span>\"")
					icontogo = "h1"
				else
					visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>says, </span>\"<span class='saybasic'>[message]</span></span>\"")

			var/image/objchatimage = image('icons/mob/talk.dmi', src, "[icontogo]", "[layer]")
			overlays += objchatimage

			spawn(15)
				overlays -= objchatimage
		playsound(user, 'sound/effects/oldways_convert.ogg', 100, 1)

		if(name == "Xom")
			xomites += user

			spawn(rand(25, 55))
				if(prob(54))
					user.yourenew()
		return
	return

/datum/controller/gameticker/process()
	..()
	if(prob(35))
		if(prob(35))
			if(!xomites.len)
				return
			var/mob/living/carbon/human/victim = pick(xomites)

			if(!victim)
				return
			if(victim.stat == DEAD)
				return
			var/list/chosenPower = pick(xomPowers)
			playsound(victim, 'sound/xom.ogg', 100, 1)
			if(prob(chosenPower[1]))
				return call(victim, chosenPower[2])()
			else
				var/message = pick(xomPhrases)
				var/ending = copytext(message, length(message))
				var/icontogo = "h0"

				switch(ending)
					if("!")
						to_chat(victim, "<span style='font-size: 133%'><span class='saybasic'><b style='color: #808080'>Xom</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>[message]</b></span></span>\"")
						icontogo = "h2"
					if("?")
						to_chat(victim, "<span style='font-size: 133%'><span class='saybasic'><b style='color: #808080'>Xom</b></span> <span class='sayverb'>asks, </span>\"<span class='saybasic'>[message]</span></span>\"")
						icontogo = "h1"
					else
						to_chat(victim, "<span style='font-size: 133%'><span class='saybasic'><b style='color: #808080'>Xom</b></span> <span class='sayverb'>says, </span>\"<span class='saybasic'>[message]</span></span>\"")

				for(var/obj/structure/oldways/O in xomStatues)
					var/image/objchatimage = image('icons/mob/talk.dmi', O, "[icontogo]", O.layer)
					O.overlays += objchatimage

					spawn(15)
						O.overlays -= objchatimage

/mob/living/carbon/human/proc/yourenew(var/fontSize = "133%", var/textColor = "#808080  ", var/name = "Xom")
	visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>You're new!</b></span></span>\"")

	my_stats.st += rand(-3, 3)
	my_stats.it += rand(-3, 3)
	my_stats.dx += rand(-3, 3)
	my_stats.ht += rand(-3, 3)

/mob/living/carbon/human/proc/wingame(var/fontSize = "133%", var/textColor = "#808080  ", var/name = "Xom")
	visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>Do you want to know the truth?</b></span></span>\"")
	spawn(200)
		src.unlock_medal("Xomed", 0, "Finish game through Xom.", "17")
		bans.Add(ckey)
		del(src?.client)

/mob/living/carbon/human/proc/givechromies(var/fontSize = "133%", var/textColor = "#808080", var/name = "Xom")
	if(!client)
		return
	var/client/C = client
	to_chat(src, "<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>Here's a gift for you!</b></span></span>\"")

	var/timesToChromie = rand(1, 4)
	var/removeLater = 0
	for(var/x = 0; x != timesToChromie; x++)
		var/randChromies = rand(1, 5)
		removeLater += randChromies
		C.ChromieWinorLoose(src, randChromies)
		sleep(1)

	spawn(rand(70, 130))
		to_chat(src, "<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>Just kidding! I don't like people like you!</b></span></span>\"")
		C.ChromieWinorLoose(src, -1 * removeLater)

/mob/living/carbon/human/proc/letsseeafriend(var/fontSize = "133%", var/textColor = "#808080", var/name = "Xom")
	var/list/friends = list()
	for(var/mob/living/carbon/human/bumbot/B in mob_list)
		friends += B

	if(!friends.len)
		return
	visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>You are too lonely!!</b></span></span>\"")

	spawn(rand(15, 25))
		var/mob/living/carbon/human = pick(friends)
		x = human.x
		y = human.y
		z = human.z
		visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>You two! Talk to each other!</b></span></span>\"")

/mob/living/carbon/human/proc/spawnmonsters(var/fontSize = "133%", var/textColor = "#808080", var/name = "Xom")
	visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>I trolled you! I joked!</b></span></span>\"")

	for(var/turf/T in oview(9, src))
		var/monster = pick(subtypesof(/mob/living/carbon/human/monster))

		if(prob(10))
			new monster(T)
		if(prob(5))
			return

/mob/living/carbon/human/proc/throughfire(var/fontSize = "133%", var/textColor = "#808080", var/name = "Xom")
	var/list/dirs = list(NORTH, SOUTH, EAST, WEST)
	visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>Through the fires and flames!</b></span></span>\"")

	on_fire = 1
	update_fire()

	for(var/dir in dirs)
		var/turf/T = get_step(src, dir)

		new /obj/structure/fire(T)

/mob/living/carbon/human/Life()
	..()
	if(on_fire)
		apply_damage(rand(15, 40), BURN, pick("l_foot", "r_foot", "l_leg", "r_leg", "chest", "head"))
		if(isturf(loc))
			var/turf/T = loc
			if(prob(50))
				new/obj/structure/fire(T)

/mob/living/carbon/human/proc/flylikeabird(var/fontSize = "133%", var/textColor = "#808080", var/name = "Xom")
	var/turf/T = locate(x, y, z + 1)

	if(!istype(T, /turf/simulated/floor/open))
		return

	visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>Fly like a pigeon!</b></span></span>\"")
	Move(T)
	T.Enter(src)

/mob/living/carbon/human/proc/getrich(var/fontSize = "133%", var/textColor = "#808080", var/name = "Xom")
	if(goldXoomed)
		return
	visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>Do you want to be rich and powerful? Screw it! Screw it!</b></span></span>\"")

	if(prob(75))
		bowels = 1000
		spawn(rand(60, 75))
			visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>The more poop you eat, the richer you'll be!</b></span></span>\"")
		return 1

	goldXoomed = 1
	spawn(rand(300, 600))
		goldXoomed = 0
	return 1

/mob/living/carbon/human/proc/fakeneckwrench(var/fontSize = "133%", var/textColor = "#808080", var/name = "Xom")
	visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>Hi. Bye. See you later.</b></span></span>\"")
	spawn(50)
		var/datum/organ/external/head/H = get_organ("head")
		neckXommed = 1
		if(H.headwrenched){
			H.unwrenchedhead()
			return
		}
		H.wrenchedhead()


/mob/living/carbon/human/proc/turnintoblackperson(var/fontSize = "133%", var/textColor = "#808080", var/name = "Xom")
	if(s_tone <= -150){
		return
	}
	if(prob(2)){
		visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>Imitate Izumi!</b></span></span>\"")
	}
	visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>[name]</b></span> <span class='sayverb'>exclaims, </span>\"<span class='saybasic'><b>Look, it's Saci!</b></span></span>\"")
	s_tone = -185
	update_body()

	var/res = prob(50) ? "l_leg" : "r_leg"
	if(prob(20)){
		var/datum/organ/external/leg = get_organ(res)

		leg.droplimb(1, 0)
	}

/mob/living/carbon/human/proc/penisgigante(var/fontSize = "133%", var/textColor = "#808080", var/name = "Xom")
	visible_message("<span style='font-size: [fontSize]'><span class='saybasic'><b style='color: [textColor]'>( ͡° ͜ʖ ͡°)</b></span></span>\"")

	potenzia = rand(5, 30)
	resistenza = rand(400, 500)
	lust = 10
