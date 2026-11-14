// /mob/var/stat things.
#define CONSCIOUS   0
#define UNCONSCIOUS 1
#define DEAD        2

//Bitflags defining which status effects could be or are inflicted on a mob
#define CANSTUN				1
#define CANWEAKEN			2
#define CANPARALYSE			4
#define CANPUSH				8
#define LEAPING				16
#define PASSEMOTES			32      //Mob has a cortical borer or holders inside of it that need to see emotes.
#define GOTTAGOFAST			64
#define GODMODE				4096
#define FAKEDEATH			8192	//Replaces stuff like changeling.changeling_fakedeath
#define DISFIGURED			16384	//I'll probably move this elsewhere if I ever get wround to writing a bitflag mob-damage system
#define XENO_HOST			32768	//Tracks whether we're gonna be a baby alien's mummy.
#define STATUS_NO_PAIN		65536

// Grab levels.
#define GRAB_AGGRESSIVE 2
#define GRAB_NECK       3
#define GRAB_UPGRADING  4
#define GRAB_KILL       5

#define BORGMESON 0x1
#define BORGTHERM 0x2
#define BORGXRAY  0x4

#define HOSTILE_STANCE_IDLE      1
#define HOSTILE_STANCE_ALERT     2
#define HOSTILE_STANCE_ATTACK    3
#define HOSTILE_STANCE_ATTACKING 4
#define HOSTILE_STANCE_TIRED     5
#define HOSTILE_STANCE_INSIDE    6

#define LEFT  1
#define RIGHT 2

// Pulse levels, very simplified.
#define PULSE_NONE    0 // So !M.pulse checks would be possible.
#define PULSE_SLOW    1 // <60     bpm
#define PULSE_NORM    2 //  60-90  bpm
#define PULSE_FAST    3 //  90-120 bpm
#define PULSE_2FAST   4 // >120    bpm
#define PULSE_THREADY 5 // Occurs during hypovolemic shock
#define GETPULSE_HAND 0 // Less accurate. (hand)
#define GETPULSE_TOOL 1 // More accurate. (med scanner, sleeper, etc.)

//intent flags, why wasn't this done the first time?

//These are used Bump() code for living mobs, in the mob_bump_flag, mob_swap_flags, and mob_push_flags vars to determine whom can bump/swap with whom.
#define HUMAN 1
#define MONKEY 2
#define ALIEN 4
#define ROBOT 8
#define HEAVY 32

// Robot AI notifications

// Appearance change flags

// Click cooldown
#define DEFAULT_SLOW_COOLDOWN	16 //The default cooldown for slow actions.
#define DEFAULT_ATTACK_COOLDOWN 8 //Default timeout for aggressive actions
#define DEFAULT_QUICK_COOLDOWN  4

// NT's alignment towards the character

// Defines mob sizes, used by lockers and to determine what is considered a small sized mob, etc.

// Gluttony levels.

// Devour speeds, returned by can_devour()

// Incapacitation flags, used by the mob/proc/incapacitated() proc

// Organs.
#define BP_MOUTH    "mouth"

// Limbs.
#define BP_L_FOOT "l_foot"
#define BP_R_FOOT "r_foot"
#define BP_L_LEG  "l_leg"
#define BP_R_LEG  "r_leg"
#define BP_L_HAND "l_hand"
#define BP_R_HAND "r_hand"
#define BP_L_ARM  "l_arm"
#define BP_R_ARM  "r_arm"
#define BP_HEAD   "head"
#define BP_CHEST  "chest"
#define BP_GROIN  "groin"

#define SYNTH_BLOOD_COLOUR "#030303"

//carbon taste sensitivity defines, used in mob/living/carbon/proc/ingest

//Used by show_message() and emotes

//used for getting species temp values

//Synthetic human temperature vals

//Moods levels for humans
#define MOOD_LEVEL_HAPPY4 20
#define MOOD_LEVEL_HAPPY3 15
#define MOOD_LEVEL_HAPPY2 10
#define MOOD_LEVEL_HAPPY1 5
#define MOOD_LEVEL_NEUTRAL 0
#define MOOD_LEVEL_SAD1 -5
#define MOOD_LEVEL_SAD2 -10
#define MOOD_LEVEL_SAD3 -15
#define MOOD_LEVEL_SAD4 -20

//Hygiene levels for humans
#define HYGIENE_LEVEL_CLEAN 250
#define HYGIENE_LEVEL_NORMAL 200
#define HYGIENE_LEVEL_DIRTY 75
#define HYGIENE_FACTOR 0.1

//Disgust levels for humans

#define ARMOR_BLOCKED 2
#define ARMOR_SOFTEN 1
#define ARMOR_FUDEU 0

#define ARMOR_ROUPA 10
#define ARMOR_LEATHER 20
#define ARMOR_CHAINMAIL 30
#define ARMOR_METAL 40
#define ARMOR_FODIDA 50