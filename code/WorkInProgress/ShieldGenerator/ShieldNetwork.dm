
var/datum/shieldnetwork/ShieldNetwork

//I should just rename this ShieldNetwork.dm

//Oh wait, I did.

//Not bothering to comment it at this point.

/datum/shieldnetwork
	var/global/NetworkCount = 0
	var/on
	var/ShieldNetNum
	var/list/Nodes = list( )
	var/list/Cables = list( )

	var/capacitators = 0

//This entire proc should at some point be stripped, once proper shield networks are in

//Balance charge amongst all capacitors - whether they're online or not
/datum/shieldnetwork/proc/Balance()
	var/TotalCharge = 0
	var/TotalCaps = 0

	for(var/obj/machinery/shielding/capacitor/S in Nodes)
		TotalCharge += S.charge
		TotalCaps++

	for(var/obj/machinery/shielding/capacitor/S in Nodes)
		S.charge = TotalCharge / TotalCaps

	return

//Whether there is (any) shield energy available
/datum/shieldnetwork/proc/HasPower()
	// at least three capacitators need to be working
	return (capacitators >= 3)

//Use an amount of shield energy.  Returns 1 if the energy was supplied in full, or 0 otherwise

//TODO remove these or figure out a better system that makes sense in-RP

//They can stay for now, though.
/datum/shieldnetwork/proc/startshields()
	if(!ShieldNetwork.HasPower())
		return
	for(var/obj/machinery/shielding/emitter/E in Nodes)
		E.control = 1
	for(var/obj/machinery/shielding/capacitor/C in Nodes)
		C.shields_enabled = 1
	on = 1

/datum/shieldnetwork/proc/stopshields()
	for(var/obj/machinery/shielding/emitter/E in Nodes)
		E.control = 0
	for(var/obj/machinery/shielding/capacitor/C in Nodes)
		C.shields_enabled = 0
	on = 0