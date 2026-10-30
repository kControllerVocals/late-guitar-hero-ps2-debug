ispauseenabled = true

script setup_pause 
	setscreenelementprops \{id = root_window
		event_handlers = [
			{
				pad_start
				gh3_start_pressed
			}
		]
		replace_handlers}
	launchevent \{type = focus
		target = root_window}
endscript

script disable_pause 
	if NOT gotparam \{nospam}

	endif
	kill_start_key_binding <...>
endscript

script enable_pause 
	if NOT gotparam \{nospam}

	endif
	restore_start_key_binding <...>
endscript
0xf7f2af61 = 0

script pausegame 
	0x99e89651
	if ($0xf7f2af61 = 1)
	endif
endscript

script unpausegame \{0xd5b464ed = 1
		0xd5af9b26 = 1}
	if ($0xf7f2af61 = 1)
		wait \{0.5
			seconds}
	endif

	0xc1bff55c 0xd5b464ed = <0xd5b464ed> 0xd5af9b26 = <0xd5af9b26>
endscript

script pausegh3 \{for_practice = 0}



	broadcastevent \{type = event_pause_game}
	waitonegameframe
	waitonegameframe
	do_gh3_pause
	if NOT (camanimfinished name = cutscene)
		moviemembfunc \{name = cutscene
			func = cut_gel_pause}
	endif
	if ($practice_enabled)
		for_practice = 1
	endif
	if ($transition_playing = true)
		if ($current_playing_transition = careerintro)
			setslomo \{1.0}
		endif
	endif
	if gotparam \{from_handler}
		ui_event_wait event = menu_change event = menu_change data = {state = uistate_pausemenu for_practice = <for_practice>}
	endif
	waitonegameframe
endscript

script do_gh3_pause 
	if ($is_network_game && $playing_song)
		return
	endif
	pausegh3sounds <...>
	pausefullscreenmovie
	pausegame
	if ismovieplaying \{textureslot = 0}
		pausemovie \{textureslot = 0}
	endif
	if ismovieplaying \{textureslot = 1}
		pausemovie \{textureslot = 1}
	endif
endscript

script unpausegh3 \{0xd5af9b26 = 1}



	waitonegameframe
	waitonegameframe
	ui_event_get_top

	if (<base_name> = 'gameplay')
		do_gh3_unpause 0xd5af9b26 = <0xd5af9b26>
		return
	endif
	if ui_event_exists_in_stack \{above = 'gameplay'
			name = 'song_unpause'}
		ui_event \{event = menu_replace
			data = {
				state = uistate_pausemenu
			}}
		return
	endif
	if gotparam \{from_handler}
		getglobaltags \{user_options
			param = unpause_count}
		if (<unpause_count> = 0)
			ui_event_block \{event = menu_change
				event = menu_back
				data = {
					state = uistate_gameplay
				}}
			do_gh3_unpause 0xd5af9b26 = <0xd5af9b26>
		else
			ui_event \{event = menu_replace
				data = {
					state = uistate_song_unpause
				}}
		endif
	else
		do_gh3_unpause 0xd5af9b26 = <0xd5af9b26>
	endif
	waitonegameframe
	if NOT (camanimfinished name = cutscene)
		moviemembfunc \{name = cutscene
			func = cut_gel_pause
			params = {
				off
			}}
	endif
	resumecontrollerchecking
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
endscript

script do_gh3_unpause \{0xd5b464ed = 1
		0xd5af9b26 = 1}
	unpausefullscreenmovie
	unpausegame 0xd5b464ed = <0xd5b464ed> 0xd5af9b26 = <0xd5af9b26>
	if (0xd5b464ed = 1)
		unpausegh3sounds <...>
	endif
	if ismovieplaying \{textureslot = 0}
		resumemovie \{textureslot = 0}
	endif
	if ismovieplaying \{textureslot = 1}
		resumemovie \{textureslot = 1}
	endif
endscript
last_start_pressed_device = 0
g_pause_is_busy = 0

script gh3_start_pressed \{device_num = -1}

	if ($is_attract_mode = 1)
		return
	endif
	if ($player1_status.bot_play = 1)
		if (<device_num> = ($primary_controller))
			device_num = -1
		else
			if gotparam \{from_handler}
				if globalexists \{name = debug_pause_control}
					ui_event_wait_for_safe
					if gameispaused
						ui_event_block \{event = menu_back
							data = {
								state = uistate_gameplay
							}}
						do_gh3_unpause
					else
						ui_event_block \{event = menu_change
							data = {
								state = uistate_debug
							}}
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
		i = 1
		begin
		status = ($0x2994109a [<i>])
		<controller> = (($<status>).controller)
		if (<device_num> = <controller>)
			start_pressed_device = <device_num>
			break
		endif
		i = (<i> + 1)
		repeat $current_num_players
		if ((<i> - 1) = $current_num_players)
			if cd
				if gotparam \{from_handler}
					if globalexists \{name = debug_pause_control}
						ui_event_wait_for_safe
						if gameispaused
							ui_event_block \{event = menu_back
								data = {
									state = uistate_gameplay
								}}
							do_gh3_unpause
						else
							ui_event_block \{event = menu_change
								data = {
									state = uistate_debug
								}}
							do_gh3_pause
						endif
					endif
				endif
			endif
			return
		endif
	endif
	if gameispaused
		if NOT (<device_num> = -1)
			if NOT (<start_pressed_device> = $last_start_pressed_device)
				return
			endif
			setinput controller = <device_num> pattern = 0 strum = 0
		endif
	else
		change last_start_pressed_device = <start_pressed_device>
	endif

	spawnscriptnow gh3_start_pressed_spawned params = {<...>}
endscript

script gh3_start_pressed_spawned 
	if ($g_pause_is_busy = 1)
		return
	endif
	change \{g_pause_is_busy = 1}
	if (<device_num> = -1)
		change \{0xf7f2af61 = 0}
	else
		change \{0xf7f2af61 = 1}
	endif

	if NOT ($view_mode = 0)
		if gameispaused
			unpausegh3sounds <...>
			unpausegame
		else
			pausegh3sounds <...>
			pausegame
			unpausespawnedscript \{update_crowd_model_cam}
		endif
		change \{g_pause_is_busy = 0}
		return
	endif
	if gameispaused
		0xd5af9b26 = 1
		if ($transition_playing = true)
			if NOT ($current_playing_transition = none)
				0xd5af9b26 = 0
			endif
		endif
		unpausegh3 <...>
		broadcastevent \{type = event_unpause_game}
		change \{viewer_buttons_enabled = 1}
		if (($game_mode = training) && ($training_mode = practice))
			wait \{1.5
				seconds}
		endif
	else
		if ($net_pause = 1)
			net_unpausegh
			change \{g_pause_is_busy = 0}
			return
		elseif ($is_network_game && $playing_song)
			net_pausegh
			change \{g_pause_is_busy = 0}
			return
		endif
		if NOT scriptisrunning \{guitarevent_songwon}
			if NOT scriptisrunning \{guitarevent_songwon_spawned}
				pausegh3 <...>
				change \{viewer_buttons_enabled = 0}
				spawnscriptnow \{block_input}
			endif
		endif
	endif
	change \{g_pause_is_busy = 0}
	change \{0xf7f2af61 = 0}
endscript

script block_input 
	if ($fade_overlay_count = 0)
		setbuttoneventmappings \{block_menu_input}
		wait \{0.25
			seconds}
		setbuttoneventmappings \{unblock_menu_input}
	endif
endscript

script create_gh3_pause_menu 
	change \{toggleviewmode_enabled = false}
	createscreenelement \{type = containerelement
		parent = root_window
		id = pause_menu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		z_priority = 100}
endscript

script destroy_gh3_pause_menu 
	if screenelementexists \{id = pause_menu}
		destroyscreenelement \{id = pause_menu}
	endif
	legacydoscreenelementmorph \{id = hud_window
		alpha = 1}
	change \{g_pause_is_busy = 0}
endscript

script safe_create_gh3_pause_menu 
	if NOT screenelementexists \{id = pause_menu}
		create_gh3_pause_menu <...>
	endif
endscript

script create_generic_backdrop 
	if NOT screenelementexists \{id = generic_backdrop_container}
		createscreenelement \{type = containerelement
			parent = root_window
			id = generic_backdrop_container
			pos = (0.0, 0.0)
			just = [
				left
				top
			]}
		createscreenelement \{type = spriteelement
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
		legacydoscreenelementmorph \{id = hud_window
			alpha = 0
			time = 0.5}
	endif
endscript

script destroy_generic_backdrop 
	if screenelementexists \{id = generic_backdrop_container}
		destroyscreenelement \{id = generic_backdrop_container}
	endif
endscript

script handle_pause_event 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	if is_ui_event_running
		return
	elseif ($playing_song = 0)
		return
	elseif scriptisrunning \{sysnotify_handle_pause_controller}
		return
	elseif scriptisrunning \{sysnotify_handle_pause}
		return
	elseif scriptisrunning \{sysnotify_handle_unpause}
		return
	endif
	gamemode_gettype
	if (<type> = career)
		if NOT progression_check_intro_complete
			if ($transition_playing = true)
				if ($current_playing_transition = careerintro)
					return
				endif
			endif
		endif
	endif
	if gotparam \{device_num}
		if ($playing_song_for_real = 0)
			return
		endif
	endif
	if NOT gameispaused
		if ($transition_playing = true)
			if (($current_playing_transition = songlost) || ($current_playing_transition = songwon))
				disable_pause
				return
			endif
		endif
	endif

	if gameispaused
		if ($is_attract_mode = 0)

			keepcontrollersalive
		endif
	endif
	spawnscriptnow \{0x91acb55b}
	spawnscriptnow gh3_start_pressed params = {<...> from_handler}
endscript

script 0x91acb55b \{delay_time = 1.0}
	kill_start_key_binding
	wait <delay_time> seconds
	if NOT gameispaused
		if ($transition_playing = true)
			if (($current_playing_transition != songlost) && ($current_playing_transition != songwon))
				restore_start_key_binding
			endif
		else
			restore_start_key_binding
		endif
	else
		restore_start_key_binding
	endif
endscript
