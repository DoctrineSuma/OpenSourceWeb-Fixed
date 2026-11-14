
/mob/living/carbon/human/proc/unbuckle_someone()
	if(!buckled_mob) return

	buckled_mob.buckled = null
	buckled_mob.update_canmove()
	buckled_mob = null