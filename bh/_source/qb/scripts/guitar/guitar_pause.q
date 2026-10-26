
script setup_pause \{pad_start_script = gh3_start_pressed}
	SetScreenElementProps {
		id = root_window
		event_handlers = [{pad_start <pad_start_script>}]
		replace_handlers
	}
	LaunchEvent \{type = focus
		target = root_window}
endscript

script disable_pause 
	if NOT GotParam \{nospam}

	endif
	kill_start_key_binding <...>
endscript

script enable_pause 
	if NOT GotParam \{nospam}

	endif
	restore_start_key_binding <...>
endscript
g_do_pause_delay = 0

script PauseGame 
	c_PauseGame
	if ($g_do_pause_delay = 1)
	endif
endscript

script UnPauseGame 
	if ($g_do_pause_delay = 1)
		Wait \{0.5
			seconds}
	endif
	c_UnPauseGame
endscript

script pausegh3 \{for_practice = 0}



	BroadcastEvent \{type = event_pause_game}
	WaitOneGameFrame
	WaitOneGameFrame
	do_gh3_pause
	if NOT (CamAnimFinished name = cutscene)
		MovieMembFunc \{name = cutscene
			func = Cut_GEL_Pause}
	endif
	if ($practice_enabled)
		for_practice = 1
	endif
	if ($transition_playing = true)
		if ($current_playing_transition = careerintro)
			setslomo \{1.0}
		endif
	endif
	if GotParam \{from_handler}
		ui_event_wait event = menu_change data = {state = UIstate_pausemenu for_practice = <for_practice>}
	endif
	WaitOneGameFrame
endscript

script do_gh3_pause 
	if ($is_network_game && $playing_song)
		return
	endif
	PauseGh3Sounds <...>
	PauseFullScreenMovie
	PauseGame
	if IsMoviePlaying \{TextureSlot = 0}
		PauseMovie \{TextureSlot = 0}
	endif
	if IsMoviePlaying \{TextureSlot = 1}
		PauseMovie \{TextureSlot = 1}
	endif
endscript

script unpausegh3 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}



	ui_event_get_top
	if (<base_name> = 'gameplay')
		do_gh3_unpause
		return
	elseif (<base_name> != 'song_unpause')
		if GotParam \{from_handler}
			GetGlobalTags \{user_options
				param = unpause_count}
			if (<unpause_count> = 1)
				ui_event \{event = menu_replace
					data = {
						state = uistate_song_unpause
					}}
				return
			endif
		endif
	endif
	if ui_event_exists_in_stack \{name = 'gameplay'}
		ui_event_block \{event = menu_back
			data = {
				state = uistate_gameplay
				from_pause
			}
			wait_for_statechange}
	endif
	do_gh3_unpause
	if NOT (CamAnimFinished name = cutscene)
		MovieMembFunc \{name = cutscene
			func = Cut_GEL_Pause
			params = {
				off
			}}
	endif
	ResumeControllerChecking
	change \{sysnotify_paused_controllers = [
		]}
	change \{unknown_drum_type = 0}
	change \{toggleviewmode_enabled = true}
	change \{paused_for_hardware = 0}
	if ($transition_playing = true)
		if ($current_playing_transition = careerintro)
			setslomo ($careerintro_current_slomo)
		endif
	endif
	if NOT ScriptIsRunning \{GuitarEvent_SongFailed}
		if NOT ScriptIsRunning \{GuitarEvent_SongWon}
			if NOT ScriptIsRunning \{GuitarEvent_SongFailed_Spawned}
				if NOT ScriptIsRunning \{GuitarEvent_SongWon_Spawned}
					if NOT ScriptIsRunning \{finish_practice_song}
						enable_pause
					endif
				endif
			endif
		endif
	endif
endscript

script do_gh3_unpause 
	UnPauseFullScreenMovie
	UnPauseGame
	WaitOneGameFrame
	UnpauseGh3Sounds <...>
	if IsMoviePlaying \{TextureSlot = 0}
		ResumeMovie \{TextureSlot = 0}
	endif
	if IsMoviePlaying \{TextureSlot = 1}
		ResumeMovie \{TextureSlot = 1}
	endif
endscript
last_start_pressed_device = 0

script gh3_start_pressed \{device_num = -1}
	SetScriptCannotPause
	if ($is_attract_mode = 1)
		return
	endif
	if ($player1_status.bot_play = 1)
		if (<device_num> = ($primary_controller))
			device_num = -1
		else
			if GotParam \{from_handler}
				if GlobalExists \{name = debug_pause_control}
					ui_event_wait_for_safe
					if GameIsPaused
						ui_event_block \{event = menu_back
							data = {
								state = uistate_gameplay
								from_pause
							}
							wait_for_statechange}
						do_gh3_unpause
					else
						ui_event_block \{event = menu_change
							data = {
								state = uistate_debug
							}
							wait_for_statechange}
						do_gh3_pause
					endif
					return
				endif
			endif
			device_num = -1
		endif
	endif
	if (<device_num> = -1)
		if ($player1_status.bot_play = 1)
			start_pressed_device = ($primary_controller)
		else
			start_pressed_device = ($player1_status.controller)
		endif
	else
		found_device = 0
		<num_players> = $current_num_players
		if ($is_singalong_mode = 1)
			<num_players> = 4
		endif
		if (<num_players> > 0)
			i = 1
			begin
			status = ($player_status_array [<i>])
			<controller> = (($<status>).controller)
			if (<device_num> = <controller>)
				<found_device> = 1
				start_pressed_device = <device_num>
				break
			endif
			i = (<i> + 1)
			repeat <num_players>
		endif
		if (<found_device> = 0)
			if NOT CD
				if GotParam \{from_handler}
					if GlobalExists \{name = debug_pause_control}
						ui_event_wait_for_safe
						if GameIsPaused
							ui_event_block \{event = menu_back
								data = {
									state = uistate_gameplay
									from_pause
								}
								wait_for_statechange}
							do_gh3_unpause
						else
							ui_event_block \{event = menu_change
								data = {
									state = uistate_debug
								}
								wait_for_statechange}
							do_gh3_pause
						endif
					endif
				endif
			endif
			return
		endif
	endif
	if GameIsPaused
		if NOT (<device_num> = -1)
			if NOT (<start_pressed_device> = $last_start_pressed_device)
				return
			endif
			SetInput controller = <device_num> pattern = 0 strum = 0
		endif
	else
		change last_start_pressed_device = <start_pressed_device>
	endif
	if (<device_num> = -1)
		change \{g_do_pause_delay = 0}
	else
		change \{g_do_pause_delay = 1}
	endif
	if GameIsPaused
		unpausegh3 <...>
		BroadcastEvent \{type = event_unpause_game}
		change \{viewer_buttons_enabled = 1}
	else
		if ($net_pause = 1)
			net_unpausegh
			return
		elseif ($is_network_game && $playing_song)
			net_pausegh
			return
		endif
		pausegh3 <...>
		change \{viewer_buttons_enabled = 0}
		spawnscriptnow \{block_input}
	endif
	change \{g_do_pause_delay = 0}
endscript

script block_input 
	if ($fade_overlay_count = 0)
		SetButtonEventMappings \{block_menu_input}
		Wait \{0.25
			seconds}
		SetButtonEventMappings \{unblock_menu_input}
	endif
endscript

script create_gh3_pause_menu 
	change \{toggleviewmode_enabled = false}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = Pause_Menu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		z_priority = 100}
endscript

script destroy_gh3_pause_menu 
	if ScreenElementExists \{id = Pause_Menu}
		DestroyScreenElement \{id = Pause_Menu}
	endif
	LegacyDoScreenElementMorph \{id = hud_window
		alpha = 1}
endscript

script safe_create_gh3_pause_menu 
	if NOT ScreenElementExists \{id = Pause_Menu}
		create_gh3_pause_menu <...>
	endif
endscript

script create_generic_backdrop 
	if NOT ScreenElementExists \{id = generic_backdrop_container}
		CreateScreenElement \{type = ContainerElement
			parent = root_window
			id = generic_backdrop_container
			pos = (0.0, 0.0)
			just = [
				left
				top
			]}
		CreateScreenElement \{type = SpriteElement
			id = pause_backdrop
			parent = generic_backdrop_container
			texture = menu_venue_bg
			rgba = [
				255
				255
				255
				255
			]
			pos = (640.0, 360.0)
			dims = (1280.0, 720.0)
			just = [
				center
				center
			]
			z_priority = 0
			alpha = 1}
		LegacyDoScreenElementMorph \{id = hud_window
			alpha = 0
			time = 0.5}
	endif
endscript

script destroy_generic_backdrop 
	if ScreenElementExists \{id = generic_backdrop_container}
		DestroyScreenElement \{id = generic_backdrop_container}
	endif
endscript

script handle_pause_event 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	if Is_ui_event_running
		return
	elseif ($playing_song = 0)
		return
	elseif ScriptIsRunning \{sysnotify_handle_pause_controller}
		return
	elseif ScriptIsRunning \{sysnotify_handle_pause}
		return
	elseif ScriptIsRunning \{sysnotify_handle_unpause}
		return
	endif
	GameMode_GetType
	if (<type> = career)
		if NOT progression_check_intro_complete
			if ($transition_playing = true)
				if ($current_playing_transition = careerintro)
					return
				endif
			endif
		endif
	endif
	if GotParam \{device_num}
		if ($playing_song_for_real = 0)
			return
		endif
	endif
	if NOT GameIsPaused
		if ($transition_playing = true)
			if (($current_playing_transition = songlost) || ($current_playing_transition = songwon))
				disable_pause
				return
			endif
		endif
	endif
	if ui_event_exists_in_stack \{above = 'gameplay'
			name = 'song_unpause'}
		ui_song_unpause_repause
		return
	endif

	if GameIsPaused
		if ($is_attract_mode = 0)

			KeepControllersAlive
		endif
	endif
	gh3_start_pressed <...> from_handler
endscript

script ps2_delay_pause_input \{delay_time = 1.0}
endscript
