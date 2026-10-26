g_mini_loading_screen = {
	show_count = 0
	busy_show = 0
	busy_hide = 0
	fade_in_time = 0.15
	fade_out_time = 0.15
	minimum_display_time = 0.5
	pos = (640.0, 360.0)
	just = [
		center
		center
	]
	internal_just = [
		center
		center
	]
	z_priority = 200000
	background = {
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		just = [
			center
			center
		]
		fade_in_time = 0.0
	}
	text = {
		pos = (-400.0, 200.0)
		just = [
			left
			center
		]
		delay = 1.5
		fade_in_time = 0.15
		loading_string = qs("LOADING")
	}
	watch_timer = {
		pos = (0.0, -600.0)
		delay = 2.5
		fade_in_time = 0.15
	}
	message = {
		pos = (-300.0, -100.0)
		just = [
			center
			center
		]
		delay = 3.5
		fade_in_time = 0.15
	}
}

script is_mini_loading_screen_visible 
	if ($g_mini_loading_screen.show_count > 0)
		return true show_count = ($g_mini_loading_screen.show_count)
	endif
	return false show_count = ($g_mini_loading_screen.show_count)
endscript

script show_mini_loading_screen 
	if ($g_mini_loading_screen.show_count = 0)
		change \{structurename = g_mini_loading_screen
			show_count = 1}
		change \{structurename = g_mini_loading_screen
			busy_show = 1}
		spawnscriptnow \{_show_mini_loading_screen_spawned}
	endif
endscript

script hide_mini_loading_screen 
	if ($g_mini_loading_screen.show_count > 0)
		change \{structurename = g_mini_loading_screen
			show_count = 0}
		change \{structurename = g_mini_loading_screen
			busy_hide = 1}
		spawnscriptnow \{_hide_mini_loading_screen_spawned}
	endif
endscript

script push_mini_loading_screen 
	if ($g_mini_loading_screen.show_count < 100)
		if ($g_mini_loading_screen.show_count = 0)
			show_mini_loading_screen
		else
			change structurename = g_mini_loading_screen show_count = ($g_mini_loading_screen.show_count + 1)
		endif
	else

	endif
endscript

script pop_mini_loading_screen 
	if ($g_mini_loading_screen.show_count > 0)
		if ($g_mini_loading_screen.show_count = 1)
			hide_mini_loading_screen
		else
			change structurename = g_mini_loading_screen show_count = ($g_mini_loading_screen.show_count - 1)
		endif
	else

	endif
endscript

script is_mini_loading_screen_busy 
	if ($g_mini_loading_screen.busy_show > 0)
		return \{true}
	endif
	if ($g_mini_loading_screen.busy_hide > 0)
		return \{true}
	endif
	return \{false}
endscript

script wait_mini_loading_screen 
	begin
	if NOT is_mini_loading_screen_busy
		break
	endif
	WaitOneGameFrame

	repeat
endscript

script _show_mini_loading_screen_spawned 
	InputHandlerForbid
	ui_fx_forbid
	_mini_loading_screen_create_elements
	_mini_loading_screen_animate_show
	change \{structurename = g_mini_loading_screen
		busy_show = 0}
endscript

script _hide_mini_loading_screen_spawned 
	_mini_loading_screen_animate_hide
	_mini_loading_screen_delete_elements
	ui_fx_permit
	InputHandlerPermit
	change \{structurename = g_mini_loading_screen
		busy_hide = 0}
endscript

script _mini_loading_screen_create_elements 
	if NOT ScreenElementExists \{id = mini_loading_screen}
		CreateScreenElement {
			type = ContainerElement
			parent = root_window
			id = mini_loading_screen
			pos = ($g_mini_loading_screen.pos)
			z_priority = ($g_mini_loading_screen.z_priority)
			just = ($g_mini_loading_screen.just)
			internal_just = ($g_mini_loading_screen.internal_just)
		}
		CreateScreenElement {
			type = SpriteElement
			parent = mini_loading_screen
			id = mini_loading_screen_background
			texture = black
			z_priority = ($g_mini_loading_screen.z_priority + 1)
			no_zwrite
			pos = ($g_mini_loading_screen.background.pos)
			dims = ($g_mini_loading_screen.background.dims)
			just = ($g_mini_loading_screen.background.just)
			rgba = [0 0 0 255]
			alpha = 0.0
		}
		CreateScreenElement {
			type = TextElement
			parent = mini_loading_screen
			id = mini_loading_screen_text
			pos = ($g_mini_loading_screen.text.pos)
			z_priority = ($g_mini_loading_screen.z_priority + 2)
			just = ($g_mini_loading_screen.text.just)
			rgba = [127 127 127 255]
			alpha = 0.0
			scale = 1.0
			font = fontgrid_title_a1
			text = qs("")
		}
		CreateScreenElement {
			type = DescInterface
			parent = mini_loading_screen
			id = mini_loading_screen_watch_timer
			pos = ($g_mini_loading_screen.watch_timer.pos)
			z_priority = ($g_mini_loading_screen.z_priority + 2)
			alpha = 0.0
			desc = 'watch_timer'
		}
		_mini_loading_screen_get_message
		CreateScreenElement {
			type = TextBlockElement
			parent = mini_loading_screen
			id = mini_loading_screen_message
			pos = ($g_mini_loading_screen.message.pos)
			z_priority = ($g_mini_loading_screen.z_priority + 2)
			dims = (800.0, 400.0)
			rot_angle = -5
			just = ($g_mini_loading_screen.message.just)
			internal_just = [center center]
			rgba = [128 64 64 250]
			alpha = 0.0
			scale = 0.55
			font = fontgrid_text_a6
			text = <message>
			single_line = false
			fit_width = wrap
			fit_height = `scale down if larger`
			scale_mode = proportional
		}
	endif
endscript

script _mini_loading_screen_delete_elements 
	if ScreenElementExists \{id = mini_loading_screen}
		DestroyScreenElement \{id = mini_loading_screen}
	endif
endscript

script _mini_loading_screen_animate_show 
	if ScreenElementExists \{id = mini_loading_screen}
		mini_loading_screen_background :Obj_SpawnScriptNow \{_mini_loading_screen_background_animate}
		mini_loading_screen_text :Obj_SpawnScriptNow \{_mini_loading_screen_text_animate}
		mini_loading_screen_watch_timer :Obj_SpawnScriptNow \{_mini_loading_screen_watch_timer_animate}
		mini_loading_screen_message :Obj_SpawnScriptNow \{_mini_loading_screen_message_animate}
		change structurename = g_mini_loading_screen busy_show = ($g_mini_loading_screen.busy_show + 1)
		Wait ($g_mini_loading_screen.minimum_display_time) seconds
		change structurename = g_mini_loading_screen busy_show = ($g_mini_loading_screen.busy_show - 1)
	endif
endscript

script _mini_loading_screen_animate_hide 
	if ScreenElementExists \{id = mini_loading_screen}
		mini_loading_screen_background :obj_killallspawnedscripts
		mini_loading_screen_text :obj_killallspawnedscripts
		mini_loading_screen_watch_timer :obj_killallspawnedscripts
		mini_loading_screen_message :obj_killallspawnedscripts
		mini_loading_screen :SE_SetProps alpha = 0.0 time = ($g_mini_loading_screen.fade_out_time)
		mini_loading_screen :SE_WaitProps
	endif
endscript

script _mini_loading_screen_background_animate 
	SE_SetProps alpha = 1.0 time = ($g_mini_loading_screen.background.fade_in_time)
	SE_WaitProps
	change structurename = g_mini_loading_screen busy_show = ($g_mini_loading_screen.busy_show + 1)
	Wait ($g_mini_loading_screen.minimum_display_time) seconds
	change structurename = g_mini_loading_screen busy_show = ($g_mini_loading_screen.busy_show - 1)
endscript

script _mini_loading_screen_text_animate 
	SE_SetProps \{alpha = 0.0
		time = 0.0}
	Wait ($g_mini_loading_screen.text.delay) seconds
	SE_SetProps text = ($g_mini_loading_screen.text.loading_string)
	SE_SetProps alpha = 1.0 time = ($g_mini_loading_screen.text.fade_in_time)
	SE_WaitProps
	Obj_SpawnScriptNow \{_mini_loading_screen_text_animate_dots}
	change structurename = g_mini_loading_screen busy_show = ($g_mini_loading_screen.busy_show + 1)
	Wait ($g_mini_loading_screen.minimum_display_time) seconds
	change structurename = g_mini_loading_screen busy_show = ($g_mini_loading_screen.busy_show - 1)
endscript

script _mini_loading_screen_text_animate_dots 
	begin
	SE_SetProps text = ($g_mini_loading_screen.text.loading_string)
	Wait \{0.5
		seconds}
	FormatText TextName = text '%s.' s = ($g_mini_loading_screen.text.loading_string)
	SE_SetProps text = <text>
	Wait \{0.5
		seconds}
	FormatText TextName = text '%s..' s = ($g_mini_loading_screen.text.loading_string)
	SE_SetProps text = <text>
	Wait \{0.5
		seconds}
	FormatText TextName = text '%s...' s = ($g_mini_loading_screen.text.loading_string)
	SE_SetProps text = <text>
	Wait \{0.5
		seconds}
	repeat
endscript

script _mini_loading_screen_watch_timer_animate 
	SE_SetProps \{alpha = 0.0
		time = 0.0}
	Wait ($g_mini_loading_screen.watch_timer.delay) seconds
	animate_watch_timer
	SE_SetProps alpha = 1.0 time = ($g_mini_loading_screen.watch_timer.fade_in_time)
	SE_WaitProps
	change structurename = g_mini_loading_screen busy_show = ($g_mini_loading_screen.busy_show + 1)
	Wait ($g_mini_loading_screen.minimum_display_time) seconds
	change structurename = g_mini_loading_screen busy_show = ($g_mini_loading_screen.busy_show - 1)
endscript

script _mini_loading_screen_message_animate 
	SE_SetProps \{alpha = 0.0
		time = 0.0}
	Wait ($g_mini_loading_screen.message.delay) seconds
	SE_SetProps alpha = 1.0 time = ($g_mini_loading_screen.message.fade_in_time)
	SE_WaitProps
	change structurename = g_mini_loading_screen busy_show = ($g_mini_loading_screen.busy_show + 1)
	Wait ($g_mini_loading_screen.minimum_display_time) seconds
	change structurename = g_mini_loading_screen busy_show = ($g_mini_loading_screen.busy_show - 1)
endscript

script _mini_loading_screen_get_message 
	GetRandomValue \{name = global_or_not
		a = 0
		b = 2
		Integer}
	if (<global_or_not> = 1)
		<tips_array> = ($loading_screen_tips)
	else
		if ($current_song = jamsession)
			<tips_array> = ($loading_screen_tips_jam)
		elseif GotParam \{leaderboard}
			<tips_array> = ($loading_screen_tips_leaderboard)
		elseif ($current_num_players = 1)
			<part> = ($player1_status.part)
			switch <part>
				case guitar
				<tips_array> = ($loading_screen_tips_guitar)
				case drum
				<tips_array> = ($loading_screen_tips_drum)
				case Vocals
				<tips_array> = ($loading_screen_tips_vocals)
				case Bass
				<tips_array> = ($loading_screen_tips_bass)
				default
				<tips_array> = ($loading_screen_tips_guitar)
			endswitch
		else
			if ($game_mode = p2_pro_faceoff)
				<tips_array> = ($loading_screen_tips)
			else
				<tips_array> = ($loading_screen_tips_band)
			endif
		endif
	endif
	GetArraySize <tips_array>
	GetRandomValue name = rand_num a = 0 b = (<array_size> - 1) Integer
	message = (<tips_array> [<rand_num>])
	return message = <message>
endscript

script test_mini_loading_screen \{time = 1.0}

	push_mini_loading_screen

	wait_mini_loading_screen

	Wait <time> seconds

	pop_mini_loading_screen

	wait_mini_loading_screen

endscript
