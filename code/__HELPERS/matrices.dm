
/atom/proc/SpinAnimation(speed = 10)
	var/matrix/m120 = matrix(transform)
	m120.Turn(120)
	var/matrix/m240 = matrix(transform)
	m240.Turn(240)
	var/matrix/m360 = matrix(transform)
	speed /= 3      //Gives us 3 equal time segments for our three turns.
	                //Why not one turn? Because byond will see that the start and finish are the same place and do nothing
	                //Why not two turns? Because byond will do a flip instead of a turn
	animate(src, transform = m120, time = speed, loop = -1)
	animate(transform = m240, time = speed)
	animate(transform = m360, time = speed)

/atom/proc/FusRoDah(speed = 10)
	var/matrix/m120 = matrix(transform)
	m120.Turn(120)
	var/matrix/m240 = matrix(transform)
	m240.Turn(240)
	var/matrix/m360 = matrix(transform)
	speed /= 3      //Gives us 3 equal time segments for our three turns.
	                //Why not one turn? Because byond will see that the start and finish are the same place and do nothing
	                //Why not two turns? Because byond will do a flip instead of a turn
	animate(src, transform = m120, time = speed, loop = 0)
	animate(transform = m240, time = speed)
	animate(transform = m360, time = speed)