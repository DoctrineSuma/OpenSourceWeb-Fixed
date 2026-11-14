/*This file is a list of all preclaimed planes & layers

All planes & layers should be given a value here instead of using a magic/arbitrary number.

After fiddling with planes and layers for some time, I figured I may as well provide some documentation:

What are planes?
	Think of Planes as a sort of layer for a layer - if plane X is a larger number than plane Y, the highest number for a layer in X will be below the lowest
	number for a layer in Y.
	Planes also have the added bonus of having planesmasters.

What are Planesmasters?
	Planesmasters, when in the sight of a player, will have its appearance properties (for example, colour matrices, alpha, transform, etc)
	applied to all the other objects in the plane. This is all client sided.
	Usually you would want to add the planesmaster as an invisible image in the client's screen.

What can I do with Planesmasters?
	You can: Make certain players not see an entire plane,
	Make an entire plane have a certain colour matrices,
	Make an entire plane transform in a certain way,
	Make players see a plane which is hidden to normal players - I intend to implement this with the antag HUDs for example.
	Planesmasters can be used as a neater way to deal with client images or potentially to do some neat things

How do planes work?
	A plane can be any integer from -100 to 100. (If you want more, bug lummox.)
	All planes above 0, the 'base plane', are visible even when your character cannot 'see' them, for example, the HUD.
	All planes below 0, the 'base plane', are only visible when a character can see them.

How do I add a plane?
	Think of where you want the plane to appear, look through the pre-existing planes and find where it is above and where it is below
	Slot it in in that place, and change the pre-existing planes, making sure no plane shares a number.
	Add a description with a comment as to what the plane does.

How do I make something a planesmaster?
	Add the PLANE_MASTER appearance flag to the appearance_flags variable.

What is the naming convention for planes or layers?
	Make sure to use the name of your object before the _LAYER or _PLANE, eg: [NAME_OF_YOUR_OBJECT HERE]_LAYER or [NAME_OF_YOUR_OBJECT HERE]_PLANE
	Also, as it's a define, it is standard practice to use capital letters for the variable so people know this.

*/

/*
	from stddef.dm, planes & layers built into byond.

	FLOAT_LAYER = -1
	AREA_LAYER = 1
	TURF_LAYER = 2
	OBJ_LAYER = 3
	MOB_LAYER = 4
	FLY_LAYER = 5
	EFFECTS_LAYER = 5000
	TOPDOWN_LAYER = 10000
	BACKGROUND_LAYER = 20000
	EFFECTS_LAYER = 5000
	TOPDOWN_LAYER = 10000
	BACKGROUND_LAYER = 20000
	------

	FLOAT_PLANE = -32767
*/

#define HIDDEN_SHIT_PLANE  -499 //Used for the hiding of the vision cone masking object.
#define SPACE_PLANE -498

#define DUST_PLANE SPACE_PLANE + 2

//Reserve planes for openspace

	// TURF_LAYER 2

#define PLATING_PLANE                -21

#define ABOVE_PLATING_PLANE          -20

	#define HOLOMAP_LAYER        2 // NOTE: ENSURE this is equal to the one at ABOVE_TURF_PLANE!

#define TURF_PLANE				-19

#define WALL_PLANE 				-18

#define ABOVE_TURF_PLANE              -16 // For items which should appear above turfs but below other objects and hiding mobs, eg: wires & pipes

	//#define HOLOMAP_LAYER               1 // NOTE: ENSURE this is equal to the one at ABOVE_PLATING_PLANE!
	#define BLOOD_LAYER                 19

#define OBJ_PLANE                     -15 // For objects which appear below humans.
	#define ABOVE_OBJ_LAYER         29

#define LYING_HUMAN_PLANE             -13 // humans that are lying down

#define ABOVE_OBJ_PLANE               -12 // for objects that are below humans when they are standing but above them when they are not. - eg, blankets.

#define HUMAN_PLANE                   -10 // For Humans that are standing up.
	#define BASE_MOB_LAYER 38

#define MOB_PLANE                      -11 // For Mobs.
	// MOB_LAYER 4

#define ABOVE_HUMAN_PLANE              -6 // For things that should appear above humans.

#define BULLET_PLANE 				   -5 //Same as blob plane but blobs are not used in warfare.

#define EFFECTS_BELOW_LIGHTING_PLANE   -4 // For special effects.

	#define FIRE_LAYER              46

#define OBSERVER_PLANE                 -3 // For observers and ghosts

	//#define LIGHTING_LAYER         1

	#define FULLSCREEN_LAYER    0
	#define IMPAIRED_LAYER      2
	#define BLIND_LAYER         3
	#define CRIT_LAYER          4

#define HUD_PLANE                       7 // For the Head-Up Display

	#define HUD_ABOVE_ITEM_LAYER 3

#define SHADOWCASTING_REFLECTOR_PLANE 16

#define SHADOWCASTING_PLANE 18

#define AMBIENT_OCCLUSION filter(type="drop_shadow", x=0, y=-2, size=4, color="#04080FAA")

//This is difference between highest and lowest visible
/image
	plane = FLOAT_PLANE			// this is defunct, lummox fixed this on recent compilers, but it will bug out if I remove it for coders not on the most recent compile.

/atom/proc/reset_plane_and_layer()
	plane = initial(plane)
	layer = initial(layer)

/*
  PLANE MASTERS
*/

/obj/blur_planemaster/New()
    appearance_flags = PLANE_MASTER
    plane = -10
    screen_loc = "1,1"
    mouse_opacity = 1

//I don't know what the fuck this shit is used for.

/obj/screen/plane_master/ghost_master/New()
	plane = OBSERVER_PLANE
	filters = filter(type = "blur", size = 1)

/obj/screen/plane_master/bullet_plane/New()
	plane = BULLET_PLANE
	filters = filter(type = "blur", size = 1)

/obj/screen/plane_master/human_blur/New()
	plane = HUMAN_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/turf_blur/New()
	plane = TURF_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/wall_blur/New()
	plane = WALL_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/obj_blur/New()
	plane = OBJ_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/lhuman_blur/New()
	plane = LYING_HUMAN_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/mob_blur/New()
	plane = MOB_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/above_human_blur/New()
	plane = ABOVE_HUMAN_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/abover_turf_blur/New()
	plane = ABOVE_TURF_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/abover_obj_blur/New()
	plane = ABOVE_OBJ_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/plating_blur/New()
	plane = PLATING_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/effects_blur/New()
	plane = EFFECTS_BELOW_LIGHTING_PLANE
	filters = filter(type = "blur", size = 2)

/obj/screen/plane_master/ghost_dummy
	// this avoids a bug which means plane masters which have nothing to control get angry and mess with the other plane masters out of spite
	alpha = 0
	appearance_flags = 0
	plane = OBSERVER_PLANE

/obj/screen/plane_master/humanAO/New()
	plane = HUMAN_PLANE
	filters = AMBIENT_OCCLUSION

/obj/screen/plane_master/wallAO/New()
	plane = WALL_PLANE
	filters = AMBIENT_OCCLUSION

/obj/screen/plane_master/objectAO/New()
	plane = OBJ_PLANE
	filters = AMBIENT_OCCLUSION

/obj/screen/plane_master/lying_human/New()
	plane = LYING_HUMAN_PLANE
	filters = AMBIENT_OCCLUSION

/obj/screen/plane_master/mobAO/New()
	plane = MOB_PLANE
	filters = AMBIENT_OCCLUSION

/obj/screen/plane_master
	appearance_flags = PLANE_MASTER
	screen_loc = "CENTER,CENTER"

/obj/screen/plane_master/vision_cone_target
	name = "vision cone master"
	plane = HIDDEN_SHIT_PLANE
	render_target = "vision_cone_target"

/obj/screen/plane_master/vision_cone_blender
	render_target = "vision_cone_target"

//A series of vision related masters. They all have the same RT name to lower load on client.
/obj/screen/plane_master/vision_cone/

/obj/screen/plane_master/vision_cone/primary/New() //For when you want things to not appear under the blind section.
	. = ..()
	add_filter("alpha", 4, list("type" = "alpha", render_source="vision_cone_target", flags=MASK_INVERSE))

/obj/screen/plane_master/vision_cone/inverted //for things you want specifically to show up on the blind section.

/obj/screen/plane_master/vision_cone/inverted/New()
	. = ..()
	add_filter("alpha", 4, list("type" = "alpha", render_source="vision_cone_target"))

/obj/screen/plane_master/shadowcasting
	name = "shadowcasting plane master"
	plane = SHADOWCASTING_PLANE
	render_target = "all3"

/obj/screen/plane_master/shadowcasting/New()
	. = ..()
	add_filter("blur", 4, list("type" = "blur", size=2))
