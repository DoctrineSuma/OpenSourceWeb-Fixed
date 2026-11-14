//Janitors!  Janitors, janitors, janitors!  -Sayu

//Conspicuously not-recent versions of suspicious cleanables

/obj/effect/decal/cleanable/blood/old
	name = "dried blood"
	desc = "Looks like it's been here a while.  Eew."
//	basecolor="#FFFFFF"
//	color="#FFFFFF"
	New()
		..()
		icon_state += "-old"

/obj/effect/decal/cleanable/blood/gibs/old
	name = "old rotting gibs"
	desc = "Oh god, why didn't anyone clean this up?  It smells terrible."
//	basecolor="#FFFFFF"
	New()
		..()
		icon_state += "-old"
		dir = pick(1,2,4,8)

/obj/effect/decal/cleanable/vomit/old
	name = "crusty dried vomit"
	desc = "You try not to look at the chunks, and fail."
	New()
		..()
		icon_state += "-old"

/obj/effect/decal/remains/robot/old
	name = "dusty robot debris"
	desc = "Looks like nobody has touched this in a while."

//Making the station dirty, one tile at a time. Called by master controller's setup_objects
