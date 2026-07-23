#define LAZYINITLIST(L) if (!L) L = list()
#define DUST_PLANE                 -97
#define SPACE_PLANE                -90

#define sound_to(target, sound)                             target << sound
#define to_target(target, payload)            target << (payload)
#define from_target(target, receiver)         target >> (receiver)
#define to_file(handle, value)                to_target(handle, value)
#define to_save(handle, value)                to_target(handle, value) //semantics
#define from_save(handle, target_var)         from_target(handle, target_var)
#define legacy_chat(target, message)          to_target(target, message)
#define to_world(message)                     to_chat(world, message)
#define to_world_log(message)                 to_target(world.log, message)
#define image_to(target, image)               to_target(target, image)
#define show_browser(target, content, title)  to_target(target, browse(content, title))
#define close_browser(target, title)          to_target(target, browse(null, title))
#define send_rsc(target, content, title)      to_target(target, browse_rsc(content, title))
#define send_link(target, url)                to_target(target, link(url))
#define send_output(target, msg, control)     to_target(target, output(msg, control))
#define go(message) world << message

//See controllers/globals.dm
#define GLOBAL_MANAGED(X, InitValue)\
/datum/controller/global_vars/proc/InitGlobal##X(){\
	##X = ##InitValue;\
	gvars_datum_init_order += #X;\
}
#define GLOBAL_UNMANAGED(X, InitValue) /datum/controller/global_vars/proc/InitGlobal##X()

#ifndef TESTING
#define GLOBAL_PROTECT(X)\
/datum/controller/global_vars/InitGlobal##X(){\
	..();\
	gvars_datum_protected_varlist += #X;\
}
#else
#define GLOBAL_PROTECT(X)
#endif

#define GLOBAL_REAL_VAR(X) var/global/##X
#define GLOBAL_REAL(X, Typepath) var/global##Typepath/##X

#define GLOBAL_RAW(X) /datum/controller/global_vars/var/global##X

#define GLOBAL_VAR_INIT(X, InitValue) GLOBAL_RAW(/##X); GLOBAL_MANAGED(X, InitValue)

#define GLOBAL_VAR_CONST(X, InitValue) GLOBAL_RAW(/const/##X) = InitValue; GLOBAL_UNMANAGED(X, InitValue)

#define GLOBAL_LIST_INIT(X, InitValue) GLOBAL_RAW(/list/##X); GLOBAL_MANAGED(X, InitValue)

#define GLOBAL_LIST_EMPTY(X) GLOBAL_LIST_INIT(X, list())

#define GLOBAL_DATUM_INIT(X, Typepath, InitValue) GLOBAL_RAW(Typepath/##X); GLOBAL_MANAGED(X, InitValue)

#define GLOBAL_VAR(X) GLOBAL_RAW(/##X); GLOBAL_MANAGED(X, null)

#define GLOBAL_LIST(X) GLOBAL_RAW(/list/##X); GLOBAL_MANAGED(X, null)

#define GLOBAL_DATUM(X, Typepath) GLOBAL_RAW(Typepath/##X); GLOBAL_MANAGED(X, null)

//See also controllers/globals.dm

/// Creates a global initializer with a given InitValue expression, do not use
#define GLOBAL_MANAGED(X, InitValue)\
/datum/controller/global_vars/proc/InitGlobal##X(){\
    ##X = ##InitValue;\
    gvars_datum_init_order += #X;\
}
/// Creates an empty global initializer, do not use
#define GLOBAL_UNMANAGED(X) /datum/controller/global_vars/proc/InitGlobal##X() { return; }

/// Prevents a given global from being VV'd
#ifndef TESTING
#define GLOBAL_PROTECT(X)\
/datum/controller/global_vars/InitGlobal##X(){\
    ..();\
    gvars_datum_protected_varlist[#X] = TRUE;\
}
#else
#define GLOBAL_PROTECT(X)
#endif

/// Standard BYOND global, do not use
#define GLOBAL_REAL_VAR(X) var/global/##X

/// Standard typed BYOND global, do not use
#define GLOBAL_REAL(X, Typepath) var/global##Typepath/##X

/// Defines a global var on the controller, do not use
#define GLOBAL_RAW(X) /datum/controller/global_vars/var/global##X

/// Create an untyped global with an initializer expression
#define GLOBAL_VAR_INIT(X, InitValue) GLOBAL_RAW(/##X); GLOBAL_MANAGED(X, InitValue)

/// Create a global const var, do not use
#define GLOBAL_VAR_CONST(X, InitValue) GLOBAL_RAW(/const/##X) = InitValue; GLOBAL_UNMANAGED(X)

/// Create a list global with an initializer expression
#define GLOBAL_LIST_INIT(X, InitValue) GLOBAL_RAW(/list/##X); GLOBAL_MANAGED(X, InitValue)

/// Create a list global that is initialized as an empty list
#define GLOBAL_LIST_EMPTY(X) GLOBAL_LIST_INIT(X, list())

/// Create a typed list global with an initializer expression
#define GLOBAL_LIST_INIT_TYPED(X, Typepath, InitValue) GLOBAL_RAW(/list##Typepath/X); GLOBAL_MANAGED(X, InitValue)

/// Create a typed list global that is initialized as an empty list
#define GLOBAL_LIST_EMPTY_TYPED(X, Typepath) GLOBAL_LIST_INIT_TYPED(X, Typepath, list())

/// Create a typed global with an initializer expression
#define GLOBAL_DATUM_INIT(X, Typepath, InitValue) GLOBAL_RAW(Typepath/##X); GLOBAL_MANAGED(X, InitValue)

/// Create an untyped null global
#define GLOBAL_VAR(X) GLOBAL_RAW(/##X); GLOBAL_UNMANAGED(X)

/// Create a null global list
#define GLOBAL_LIST(X) GLOBAL_RAW(/list/##X); GLOBAL_UNMANAGED(X)

/// Create a typed null global
#define GLOBAL_DATUM(X, Typepath) GLOBAL_RAW(Typepath/##X); GLOBAL_UNMANAGED(X)
