/datum/controller/process/garbage_collector/setup()
	name = "garbage"
	schedule_interval = 30
	start_delay = 10

	garbageCollector = src

/datum/controller/process/garbage_collector/doWork()
	// Garbage collection code can be found in code\modules\garbage collection\garbage_collector.dm
	processGarbage()
