#define LAZYINITLIST(L) if (!L) L = list()
//Picks from the list, with some safeties, and returns the "default" arg if it fails
// Sets a L back to null iff it is empty
#define UNSETEMPTY(L) if (L && !L.len) L = null
// Removes I from list L, and sets I to null if it is now empty
#define LAZYREMOVE(L, I) if(L) { L -= I; if(!length(L)) { L = null; } }
// Adds I to L, initalizing L if necessary
// Insert I into L at position X, initalizing L if necessary
// Adds I to L, initalizing L if necessary, if I is not already in L
// Sets L[A] to I, initalizing L if necessary
#define LAZYSET(L, A, I) if(!L) { L = list(); } L[A] = I;
// Reads I from L safely - Works with both associative and traditional lists.
// Reads the length of L, returning 0 if null
#define LAZYLEN(L) length(L)
// Safely checks if I is in L
// Null-safe List.Cut() and discard.
// Reads L or an empty list if L is not a list.  Note: Does NOT assign, L may be an expression.

#define sound_to(target, sound)                             target << sound
#define to_target(target, payload)            target << (payload)
#define to_file(handle, value)                to_target(handle, value)
#define legacy_chat(target, message)          to_target(target, message)
#define to_world(message)                     to_chat(world, message)
#define to_world_log(message)                 to_target(world.log, message)
#define send_output(target, msg, control)     to_target(target, output(msg, control))
#define go(message) world << message

//See controllers/globals.dm
#define GLOBAL_MANAGED(X, InitValue)\
/datum/controller/global_vars/proc/InitGlobal##X(){\
	##X = ##InitValue;\
	gvars_datum_init_order += #X;\
}

#ifndef TESTING
#else
#endif

#define GLOBAL_RAW(X) /datum/controller/global_vars/var/global##X

#define GLOBAL_DATUM_INIT(X, Typepath, InitValue) GLOBAL_RAW(Typepath/##X); GLOBAL_MANAGED(X, InitValue)

/// Create a typed list global with an initializer expression

/// Create a typed list global that is initialized as an empty list

#define GLOBAL_PROC "some_magic_bullshit"

#define INVOKE_ASYNC world.ImmediateInvokeAsync

//defines that give qdel hints. these can be given as a return in destory() or by calling

/world/proc/ImmediateInvokeAsync(thingtocall, proctocall, ...)
	set waitfor = FALSE

	if (!thingtocall)
		return

	var/list/calling_arguments = length(args) > 2 ? args.Copy(3) : null

	if (thingtocall == GLOBAL_PROC)
		call(proctocall)(arglist(calling_arguments))
	else
		call(thingtocall, proctocall)(arglist(calling_arguments))

#define TimeOfGame (get_game_time())
#define TimeOfTick (world.tick_usage*0.01*world.tick_lag)

// Process status defines
#define PROCESS_STATUS_IDLE 1
#define PROCESS_STATUS_QUEUED 2
#define PROCESS_STATUS_RUNNING 3
#define PROCESS_STATUS_MAYBE_HUNG 4
#define PROCESS_STATUS_PROBABLY_HUNG 5
#define PROCESS_STATUS_HUNG 6

// Process time thresholds
#define PROCESS_DEFAULT_HANG_WARNING_TIME 	300 // 30 seconds
#define PROCESS_DEFAULT_HANG_ALERT_TIME 	600 // 60 seconds
#define PROCESS_DEFAULT_HANG_RESTART_TIME 	900 // 90 seconds
#define PROCESS_DEFAULT_SCHEDULE_INTERVAL 	50  // 50 ticks
#define PROCESS_DEFAULT_SLEEP_INTERVAL		2	// 2 ticks

// SCHECK macros
// This references src directly to work around a weird bug with try/catch
#define SCHECK_EVERY(this_many_calls) if(++src.calls_since_last_scheck >= this_many_calls) sleepCheck()
#define SCHECK SCHECK_EVERY(50)

/proc/get_game_time()
	var/global/time_offset = 0
	var/global/last_time = 0
	var/global/last_usage = 0

	var/wtime = world.time
	var/wusage = world.tick_usage * 0.01

	if(last_time < wtime && last_usage > 1)
		time_offset += last_usage - 1

	last_time = wtime
	last_usage = wusage

	return wtime + (time_offset + wusage) * world.tick_lag
