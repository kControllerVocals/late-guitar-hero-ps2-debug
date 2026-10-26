g_watch_timer_swing_angle = 0.0
g_watch_timer_second_angle = 0.0
g_watch_timer_minute_angle = 0.0

script make_watch_timer \{id = watch_timer}
	CreateScreenElement {
		id = <id>
		parent = root_window
		type = DescInterface
		desc = 'watch_timer'
		pos = <pos>
		z_priority = 5000
	}
	<id> :animate_watch_timer
endscript

script animate_watch_timer 
	Obj_SpawnScriptNow \{animate_watch_timer_swing}
	Obj_SpawnScriptNow \{animate_watch_timer_sweep_second}
	Obj_SpawnScriptNow \{animate_watch_timer_sweep_minute}
endscript

script animate_watch_timer_swing 
	SetScriptCannotPause
	SE_SetProps \{Timer_watch_alpha = 0.0}
	SE_SetProps \{Timer_hand_big_alpha = 0.0}
	SE_SetProps \{Timer_hand_small_alpha = 0.0}
	SE_SetProps \{Timer_watch_alpha = 1.0
		time = 0.25}
	SE_SetProps \{Timer_hand_big_alpha = 1.0
		time = 0.25}
	SE_SetProps \{Timer_hand_small_alpha = 1.0
		time = 0.25}
	<Angle> = $g_watch_timer_swing_angle
	begin
	sin <Angle>
	SE_SetProps Timer_rot_angle = (3.0 * <sin>)
	WaitOneGameFrame
	<Angle> = (<Angle> + 5.0)
	if (<Angle> > 360.0)
		<Angle> = (<Angle> - 360.0)
	endif
	change g_watch_timer_swing_angle = <Angle>
	repeat
endscript

script animate_watch_timer_sweep_second 
	SetScriptCannotPause
	<Angle> = $g_watch_timer_second_angle
	begin
	SE_SetProps timer_hand_big_rot_angle = <Angle>
	WaitOneGameFrame
	<Angle> = (<Angle> + 10.0)
	if (<Angle> > 360.0)
		<Angle> = (<Angle> - 360.0)
	endif
	change g_watch_timer_second_angle = <Angle>
	repeat
endscript

script animate_watch_timer_sweep_minute 
	SetScriptCannotPause
	<Angle> = $g_watch_timer_minute_angle
	begin
	SE_SetProps timer_hand_small_rot_angle = <Angle>
	WaitOneGameFrame
	<Angle> = (<Angle> + 1.0)
	if (<Angle> > 360.0)
		<Angle> = (<Angle> - 360.0)
	endif
	change g_watch_timer_minute_angle = <Angle>
	repeat
endscript

script watch_animate_in 
	SetScriptCannotPause
	if GetSingleTag \{animating_out}
		if (<animating_out> = 0)
			return
		endif
		SetTags \{animating_out = 0}
		SE_SetProps Timer_watch_alpha = 1.0 time = <time>
		SE_SetProps Timer_hand_big_alpha = 1.0 time = <time>
		SE_SetProps Timer_hand_small_alpha = 1.0 time = <time>
	endif
endscript

script watch_animate_out 
	SetScriptCannotPause
	SetTags \{animating_out = 1}
	SE_SetProps Timer_watch_alpha = 0.0 time = <time>
	SE_SetProps Timer_hand_big_alpha = 0.0 time = <time>
	SE_SetProps Timer_hand_small_alpha = 0.0 time = <time>
endscript
