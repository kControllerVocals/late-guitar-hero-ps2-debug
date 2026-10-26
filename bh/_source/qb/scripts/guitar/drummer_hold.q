
script Hold_Body_Loops 
	Wait \{$Drummer_Offset
		seconds}
	if (<Body_type> = Idle)
		KillSpawnedScript \{name = Drummer_Transit_Loops}
		index = 0
		Drummer :Obj_SpawnScriptNow Drummer_Transit_Idles params = {state = <state> tapin = <tapin> currentset = <currentset> Last_Hit = <Last_Hit>}
		if CompositeObjectExists \{drummer2}
			Wait \{1
				frame}
			drummer2 :Obj_SpawnScriptNow Drummer_Transit_Idles params = {state = <state> tapin = <tapin> currentset = <currentset> Last_Hit = <Last_Hit>}
		endif
	else
		KillSpawnedScript \{name = Drummer_Transit_Idles}
		Drummer :Obj_SpawnScriptNow Drummer_Transit_Loops params = {state = <state> BlendDuration = <BlendDuration>}
		if CompositeObjectExists \{drummer2}
			Wait \{1
				frame}
			drummer2 :Obj_SpawnScriptNow Drummer_Transit_Loops params = {state = <state> BlendDuration = <BlendDuration>}
		endif
	endif
	drummer_Ids = [musician1]
	state = in
	tapin = false
	Last_Hit = false
	currentset = 0
	BlendDuration = 0.0
endscript

script Idle_Check 
	Time_From_Idle = (((1 - $Drum_Idlepoint_Arm_SHit) * $Drum_Slowest_Arm_Hit) / 1000.0)
	time_to_Hit_1 = (<time_to_Hit_1> / 1000.0)
	waittime = 0.0
	if ($Drummer_Idle = true)
		change \{Drummer_Idle = false}
		if (<time_to_Hit_1> > <Time_From_Idle>)
			waittime = (<time_to_Hit_1> - <Time_From_Idle>)
			Wait <waittime> seconds
			spawnscriptnow Hold_Body_Loops params = {
				Body_type = Loop
				num_Drummers = <num_Drummers>
				drummer_Ids = <drummer_Ids>
				state = in
				BlendDuration = <Time_From_Idle>
			}
		else
			spawnscriptnow Hold_Body_Loops params = {
				Body_type = Loop
				num_Drummers = <num_Drummers>
				drummer_Ids = <drummer_Ids>
				state = in
				BlendDuration = <time_to_Hit_1>
			}
		endif
	else
		if (<Should_Idle> = true)
			spawnscriptnow Hold_Body_Loops params = {
				Body_type = Idle
				Last_Hit = <Last_Hit>
				currentset = <currentset>
				num_Drummers = <num_Drummers>
				drummer_Ids = <drummer_Ids>
				state = in
				tapin = <tapin>
			}
			waittime = (<time_to_Hit_1> - <Time_From_Idle>)
			Wait <waittime> seconds
			spawnscriptnow Hold_Body_Loops params = {
				Body_type = Loop
				num_Drummers = <num_Drummers>
				drummer_Ids = <drummer_Ids>
				state = in
				BlendDuration = <Time_From_Idle>
			}
		endif
	endif
	return lost_time = (<waittime> * 1000.0)
	num_Drummers = 0
	drummer_Ids = [musician2]
	Last_Hit = false
	currentset = 0
	tapin = false
endscript

script Hold_Transit_requests \{time_to_trans_Long = 0.0
		time_to_trans_short = 0.0}
	currentset = $Current_DB_Base
	Idle_Check {
		Last_Hit = <Last_Hit>
		time_to_Hit_1 = <time_to_Hit_1>
		num_Drummers = <num_Drummers>
		drummer_Ids = <drummer_Ids>
		Should_Idle = <Should_Idle>
		tapin = <tapin>
		currentset = <currentset>
	}
	Hold_Transit_requests_CFunc
endscript
smooth_body_transit_curve_long = [
	1.0
	0.9927499
	0.97199994
	0.93924993
	0.89599997
	0.84375006
	0.784
	0.71825
	0.64800006
	0.57475
	0.5
	0.42525002
	0.35200003
	0.28175
	0.216
	0.15625
	0.104
	0.0607499
	0.027999999
	0.00725001
	0.0
]
smooth_body_transit_curve_short = [
	1.0
	0.9927499
	0.97199994
	0.93924993
	0.89599997
	0.84375006
	0.784
	0.71825
	0.64800006
	0.57475
	0.5
	0.42525002
	0.35200003
	0.28175
	0.216
	0.15625
	0.104
	0.0607499
	0.027999999
	0.00725001
	0.0
]

script hold_Body_Trans 
	Wait <waittime> seconds
	hold_Body_Trans_CFunc
endscript
smooth_transit_arms_curve = [
	1.0
	0.9927499
	0.97199994
	0.93924993
	0.89599997
	0.84375006
	0.784
	0.71825
	0.64800006
	0.57475
	0.5
	0.42525002
	0.35200003
	0.28175
	0.216
	0.15625
	0.104
	0.0607499
	0.027999999
	0.00725001
	0.0
]

script Hold_Transit_Arms 
	Wait \{$Drummer_Offset
		seconds}
	Hold_Transit_Arms_CFunc
endscript
