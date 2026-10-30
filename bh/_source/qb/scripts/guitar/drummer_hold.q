
script hold_body_loops 
	wait \{$drummer_offset
		seconds}
	if (<body_type> = idle)
		killspawnedscript \{name = drummer_transit_loops}
		index = 0
		drummer :obj_spawnscriptnow drummer_transit_idles params = {state = <state> tapin = <tapin> currentset = <currentset> last_hit = <last_hit>}
		if compositeobjectexists \{drummer2}
			wait \{1
				frame}
			drummer2 :obj_spawnscriptnow drummer_transit_idles params = {state = <state> tapin = <tapin> currentset = <currentset> last_hit = <last_hit>}
		endif
	else
		killspawnedscript \{name = drummer_transit_idles}
		drummer :obj_spawnscriptnow drummer_transit_loops params = {state = <state> blendduration = <blendduration>}
		if compositeobjectexists \{drummer2}
			wait \{1
				frame}
			drummer2 :obj_spawnscriptnow drummer_transit_loops params = {state = <state> blendduration = <blendduration>}
		endif
	endif
	drummer_ids = [musician1]
	state = in
	tapin = false
	last_hit = false
	currentset = 0
	blendduration = 0.0
endscript

script idle_check 
	time_from_idle = (((1 - $drum_idlepoint_arm_shit) * $drum_slowest_arm_hit) / 1000.0)
	time_to_hit_1 = (<time_to_hit_1> / 1000.0)
	waittime = 0.0
	if ($drummer_idle = true)
		change \{drummer_idle = false}
		if (<time_to_hit_1> > <time_from_idle>)
			waittime = (<time_to_hit_1> - <time_from_idle>)
			wait <waittime> seconds
			spawnscriptnow hold_body_loops params = {
				body_type = loop
				num_drummers = <num_drummers>
				drummer_ids = <drummer_ids>
				state = in
				blendduration = <time_from_idle>
			}
		else
			spawnscriptnow hold_body_loops params = {
				body_type = loop
				num_drummers = <num_drummers>
				drummer_ids = <drummer_ids>
				state = in
				blendduration = <time_to_hit_1>
			}
		endif
	else
		if (<should_idle> = true)
			spawnscriptnow hold_body_loops params = {
				body_type = idle
				last_hit = <last_hit>
				currentset = <currentset>
				num_drummers = <num_drummers>
				drummer_ids = <drummer_ids>
				state = in
				tapin = <tapin>
			}
			waittime = (<time_to_hit_1> - <time_from_idle>)
			wait <waittime> seconds
			spawnscriptnow hold_body_loops params = {
				body_type = loop
				num_drummers = <num_drummers>
				drummer_ids = <drummer_ids>
				state = in
				blendduration = <time_from_idle>
			}
		endif
	endif
	return lost_time = (<waittime> * 1000.0)
	num_drummers = 0
	drummer_ids = [musician2]
	last_hit = false
	currentset = 0
	tapin = false
endscript

script hold_transit_requests \{time_to_trans_long = 0.0
		time_to_trans_short = 0.0}
	currentset = $current_db_base
	idle_check {
		last_hit = <last_hit>
		time_to_hit_1 = <time_to_hit_1>
		num_drummers = <num_drummers>
		drummer_ids = <drummer_ids>
		should_idle = <should_idle>
		tapin = <tapin>
		currentset = <currentset>
	}
	0xad8b48df
endscript
0xad14cdc7 = [
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
0x1bd54232 = [
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

script hold_body_trans 
	wait <waittime> seconds
	0xa1e646e3
endscript
0x6b846a4a = [
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

script hold_transit_arms 
	wait \{$drummer_offset
		seconds}
	0x9334aad7
endscript
