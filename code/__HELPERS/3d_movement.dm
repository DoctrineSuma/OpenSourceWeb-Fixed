/proc/step_towards_3d(var/atom/movable/Ref, var/atom/movable/Trg)
	if (!Ref || !Trg)
		return 0
	if(Ref.z == Trg.z)
		var/S = Ref.loc
		step_towards(Ref, Trg)
		if(Ref.loc != S)
			return 1
		return 0

	var/dx = (Trg.x - Ref.x) / max(abs(Trg.x - Ref.x), 1)
	var/dy = (Trg.y - Ref.y) / max(abs(Trg.y - Ref.y), 1)
	var/dz = (Trg.z - Ref.z) / max(abs(Trg.z - Ref.z), 1)

	var/turf/T = locate(Ref.x + dx, Ref.y + dy, Ref.z + dz)

	if (!T)
		return 0

	Ref.Move(T)

	if (Ref.loc != T)
		return 0

	return 1

//Bwahahaha! I am extending a built-in proc for personal gain!
//(And a bit of nonpersonal gain, I guess)
