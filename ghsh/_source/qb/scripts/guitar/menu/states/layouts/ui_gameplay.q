gameplay_restart_song = 0
gameplay_loading_transition = 0

script ui_create_gameplay 
	show_highway
	if ($gameplay_restart_song = 1)
		loading_transition = ($gameplay_loading_transition)
		change \{gameplay_loading_transition = 0}
		if NOT scriptisrunning \{restart_song}
			spawnscriptnow restart_song params = {loading_transition = <loading_transition>}
		endif
		change \{gameplay_restart_song = 0}
	endif
	vocals_mute_all_mics \{mute = false}
	unpause_audio = 0
	if gotparam \{unpause_audio}
		<unpause_audio> = 1
	endif
	spawnscriptnow ui_create_gameplay_spawned params = {unpause_audio = <unpause_audio>}
endscript

script ui_destroy_gameplay 
	if screenelementexists \{id = intro_container}
		destroyscreenelement \{id = intro_container}
	endif
endscript

script ui_create_gameplay_spawned \{unpause_audio = 0}
	setscriptcannotpause
	spawn_player_drop_listeners \{drop_player_script = gameplay_drop_player
		end_game_script = gameplay_end_game}
	if (<unpause_audio> = 0)
		wait \{5
			gameframes}
	endif
	disable_pause
	begin
	if NOT scriptisrunning \{restart_song}
		if NOT scriptisrunning \{restart_gem_scroller}
			if ($is_changing_levels = 0)
				break
			endif
		endif
	endif
	wait \{1
		gameframe}
	disable_pause \{nospam}
	repeat
	if NOT scriptisrunning \{guitarevent_songfailed}
		if NOT scriptisrunning \{guitarevent_songwon}
			if NOT scriptisrunning \{guitarevent_songfailed_spawned}
				if NOT scriptisrunning \{guitarevent_songwon_spawned}
					if NOT scriptisrunning \{finish_practice_song}
						if NOT scriptisrunning \{practice_update}
							if NOT screenelementexists \{id = you_rock}
								if NOT screenelementexists \{id = yourock}
									enable_pause
								endif
							endif
						endif
					endif
				endif
			endif
		endif
	endif
	gamemode_gettype
	if (<type> = career)
		if NOT progression_check_intro_complete
			if ($transition_playing = true)
				if ($current_playing_transition = careerintro)
					disable_pause
				endif
			endif
		endif
	endif
	resumecontrollerchecking
	change \{sysnotify_paused_controllers = [
		]}
	change \{unknown_drum_type = 0}
	if ($songtime_paused = 1)
		change \{songtime_paused = 0}
		startrendering
	endif
endscript

script ui_deinit_gameplay 
	change menu_flow_locked = ($menu_flow_locked + 1)

	killspawnedscript \{name = ui_create_gameplay_spawned}
	spawnscriptnow \{kill_gem_scroller}
	if screenelementexists \{id = yourock}
		destroyscreenelement \{id = yourock}
	endif
	0x5e591606
	unpausegame
	disable_pause
	if NOT ui_event_exists_in_stack \{name = 'jam'}
		if ($game_mode = p1_career || $game_mode = p2_career || $band_mode_mode = career)
			band_builder_clear_random_appearances \{cpu_only}
		else
			if ($game_mode = p1_quickplay)
				band_builder_clear_random_appearances \{cpu_only}
			endif
		endif
	endif
	0x136c76bb
	if 0x2e51d96c
		0x29472091
	endif
	change menu_flow_locked = ($menu_flow_locked - 1)
	killspawnedscript \{name = sysnotify_handle_pause_controller}
	killspawnedscript \{name = sysnotify_handle_pause_controller_spawned}
endscript

script animate_drop_player_msg 

	obj_getid
	<objid> :se_setprops {gamertag_alpha = 1.0 gamertag_name_text = <drop_msg> gamertag_scale = (3.0, 1.1) time = 0.1 motion = ease_out}
	<objid> :se_waitprops
	<objid> :se_setprops {gamertag_scale = (1.3, 1.1) time = 0.1 motion = ease_out}
	<objid> :se_waitprops
endscript
