#define VEND_FOOD "Food"
#define VEND_WATER "Water"

/obj/machinery/food_machine
	name = "Food Machine"
	desc = ""
	icon = 'icons/obj/vending.dmi'
	icon_state = "xneosnack"
	var/normal_state = "xneosnack"
	var/broken_state = "xneosnack0"
	anchored = 1
	use_power = 1
	idle_power_usage = 10
	var/screenbroken = FALSE
	pixel_y = 26
	plane = 21
	var/vends = VEND_FOOD

/obj/machinery/food_machine/New()
	..()
	set_light(2, 3, 2.8, 1, "#c95f5b")

/obj/machinery/food_machine/attackby(obj/item/I as obj, mob/living/carbon/human/user as mob)
	var/obj/item/weapon/spacecash/CA = I
	if(istype(CA,/obj/item/weapon/spacecash))
		if(CA.worth < 10)
			to_chat(user, "I need 10 obols.")
		else if(CA.worth > 10)
			to_chat(user, "I have more than 10 obols.")
		else if(CA.worth == 10)
			qdel(CA)
			playsound(src.loc, 'sound/machines/coin_ins.ogg', 30, 0)
			DoVend(user)
			supply_shuttle.points += 5
		else
			to_chat(user,"This isn't working for it.")
	if(istype(I, /obj/item/coupon/food))
		qdel(I)
		playsound(src.loc, 'sound/machines/coin_ins.ogg', 30, 0)
		DoVend(user)

/obj/machinery/food_machine/proc/DoVend(mob/user)
	if(vends == VEND_FOOD)
		new /obj/item/weapon/reagent_containers/food/snacks/plump_pie (user.loc) // finally normal food? instead of a fucking candy.
	else
		new /obj/item/weapon/reagent_containers/glass/bottle/waterbottle (user.loc)

/obj/machinery/food_machine/RightClick(mob/user)
	if(user.stat)
		return

	var/vend_what = input(usr, "What do you want to buy?", "Food Machine", null) as anything in list(VEND_FOOD, VEND_WATER) | null
	if(vend_what == VEND_FOOD || vend_what == VEND_WATER)
		to_chat(user, "You set [src] to vend [lowertext(vend_what)]")
		vends = vend_what

#undef VEND_FOOD
#undef VEND_WATER
