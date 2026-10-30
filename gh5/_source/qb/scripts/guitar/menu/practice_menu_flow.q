came_to_practice_from = main_menu
came_to_practice_from_progression = none
came_to_practice_character_id = emptyguy
came_to_practice_difficulty = easy
came_to_practice_difficulty2 = easy

script practice_check_song_for_parts 
	destroy_band
	0xce69e479
	load_songqpak song_name = ($current_song) async = 0
	set_song_section_array \{player = 1}
	generic_event_choose \{state = uistate_practice_select_difficulty}
endscript

script practice_check_song_for_parts_back 
	load_songqpak song_name = ($current_song) async = 0
	get_song_struct song = ($current_song)
	if structurecontains structure = <song_struct> no_rhythm_track
		return \{flow_state = practice_setlist_fs}
	endif
	songfilemanager func = 0xb08ce65f song_name = ($current_song) difficulty = easy part = guitar
	if (<0x2d1d62d3> > 0)
		return \{flow_state = practice_select_part_fs}
	endif
	if structurecontains structure = <song_struct> use_coop_notetracks
		return \{flow_state = practice_select_part_fs}
	endif
	return \{flow_state = practice_setlist_fs}
endscript

script practice_start_song \{device_num = 0}
	change \{game_mode = practice}
	change \{current_transition = practice}
	change \{current_level = load_z_studio}
	start_song {
		starttime = ($practice_start_time)
		device_num = <device_num>
		practice_intro = 1
		endtime = ($practice_end_time)
		starttime = <starttime>
		uselaststarttime = <uselaststarttime>
	}
	spawnscriptnow \{practice_update}
endscript

script practice_restart_song 
	end_song
	resetscoreupdateready
	spawnscriptnow \{practice_restart_song_spawned}
endscript

script practice_restart_song_spawned 
	setscriptcannotpause
	change \{game_mode = practice}
	change \{current_transition = practice}
	generic_event_back \{state = uistate_gameplay}
	restart_song practice_intro = 1 starttime = ($practice_start_time) endtime = ($practice_end_time)
	killspawnedscript \{name = practice_update}
	spawnscriptnow \{practice_update}
endscript

script practice_update 
	setscriptcannotpause
	resetpracticesoundbusses
	begin
	practice_audio_filter
	getsongtimems
	if (<time> > ($practice_end_time))
		songsetmastervolume \{vol = -100
			time = 0.4}
		if (<time> > (($practice_end_time) + ($song_win_delay * 1000 - 100)))
			if ($practice_loop_section = 0)
				disable_pause
				ui_event_wait_for_safe
				ui_event_get_top
				if NOT (<base_name> = 'gameplay')
					ui_event_block \{event = menu_back
						data = {
							state = uistate_gameplay
						}}
					do_gh3_unpause
				endif
				spawnscriptnow \{finish_practice_song}
				return
			else
				spawnscriptnow \{practice_loop_song}
				return
			endif
		endif
	endif
	enable_pause \{nospam}
	wait \{1
		gameframes}
	repeat
endscript

script practice_loop_song 
	stoprendering
	removeplayerserverfretbariterator \{fretbar_id = createfretbar
		id = player1_status}
	removeplayerserverfretbariterator \{fretbar_id = prefretbarevent
		id = player1_status}
	removeplayerserverfretbariterator \{fretbar_id = fretbarevent
		id = player1_status}
	removeplayerserverfretbariterator \{fretbar_id = createvocalmarker
		id = player1_status}
	clearplayerservermessages
	launchgemevent \{event = kill_objects}
	flushplayerservermessages
	killspawnedscript \{name = guitarevent_missednote}
	killspawnedscript \{name = guitarevent_unnecessarynote}
	killspawnedscript \{name = guitarevent_hitnotes}
	killspawnedscript \{name = guitarevent_hitnote}
	killspawnedscript \{name = guitarevent_starpoweron}
	killspawnedscript \{name = guitarevent_starpoweroff}
	killspawnedscript \{name = guitarevent_starhitnote}
	killspawnedscript \{name = guitarevent_starsequencebonus}
	killspawnedscript \{name = guitarevent_starmissnote}
	killspawnedscript \{name = guitarevent_whammyon}
	killspawnedscript \{name = guitarevent_whammyoff}
	killspawnedscript \{name = guitarevent_starwhammyon}
	killspawnedscript \{name = guitarevent_starwhammyoff}
	killspawnedscript \{name = guitarevent_note_window_open}
	killspawnedscript \{name = guitarevent_note_window_close}
	killspawnedscript \{name = guitarevent_crowd_poor_medium}
	killspawnedscript \{name = guitarevent_crowd_medium_good}
	killspawnedscript \{name = guitarevent_crowd_medium_poor}
	killspawnedscript \{name = guitarevent_crowd_good_medium}
	killspawnedscript \{name = guitarevent_createfirstgem}
	killspawnedscript \{name = highway_pulse_black}
	killspawnedscript \{name = guitarevent_hitnote_spawned}
	killspawnedscript \{name = hit_note_fx}
	killspawnedscript \{name = do_starpower_stagefx}
	killspawnedscript \{name = do_starpower_camera}
	killspawnedscript \{name = first_gem_fx}
	killspawnedscript \{name = gem_iterator}
	killspawnedscript \{name = gem_array_stepper}
	killspawnedscript \{name = gem_array_events}
	killspawnedscript \{name = gem_step}
	killspawnedscript \{name = gem_step_end}
	killspawnedscript \{name = drumkit_anim_iterator}
	killspawnedscript \{name = watchforstartplaying_iterator}
	band_disabletempoiterator
	killspawnedscript \{name = tempo_matching_iterator}
	killspawnedscript \{name = momentcamera_playanim_spawned}
	killspawnedscript \{name = fretbar_update_tempo}
	killspawnedscript \{name = fretbar_update_hammer_on_tolerance}
	killspawnedscript \{name = gem_scroller}
	killspawnedscript \{name = button_checker}
	killspawnedscript \{name = check_buttons}
	notemap_deinit
	reset_score \{player_status = player1_status}
	transition_time = 2000
	if (($player1_status.part) = vocals)
		resetvocalhighwayindexes \{player = 1}
		transition_time = 4000
	endif
	setslomo \{0.001}
	reset_song_time starttime = ($practice_start_time - <transition_time>)
	setarrayelement \{arrayname = currently_holding
		globalarray
		index = 0
		newvalue = 0}
	spawnscriptlater \{update_score_fast
		params = {
			player_status = player1_status
		}}
	spawnscriptnow gem_scroller params = {
		player = 1
		player_status = player1_status
		player_text = 'p1'
		training_mode = 0
		song_name = ($current_song)
		difficulty = ($player1_status.difficulty)
		difficulty2 = ($player2_status.difficulty)
		looping = 1
	}
	if (($player1_status.part) != vocals)
		spawnscriptnow button_checker params = {
			player = 1
			player_status = player1_status
			player_text = 'p1'
			training_mode = 0
			song_name = ($current_song)
			difficulty = ($player1_status.difficulty)
			difficulty2 = ($player2_status.difficulty)
			looping = 1
		}
	endif
	calc_songscoreinfo \{player_status = player1_status}
	spawnscriptnow \{practice_update}
	wait \{1
		gameframe}
	songpause
	setseekposition_song position = ($practice_start_time - <transition_time>)
	songunpause
	setslomo \{$current_speedfactor}
	pausegh3
	wait \{1
		gameframe}
	unpausegh3
	startrendering
endscript

script finish_practice_song 
	killspawnedscript \{name = practice_update}
	guitarevent_songwon
	disable_pause
	ui_event_wait_for_safe
	ui_event_get_top
	if NOT (<base_name> = 'gameplay')
		ui_event_block \{event = menu_back
			data = {
				state = uistate_gameplay
			}}
	endif
	menu_start_transition
	generic_event_choose \{state = uistate_song_breakdown
		data = {
			for_practice = 1
		}
		no_sound}
	ui_event_wait_for_safe
endscript

script practice_audio_filter 
endscript

script shut_down_practice_mode 
	killspawnedscript \{name = practice_update}
endscript
practice_calibrate_speedfactor = 1.0

script practice_calibrate_speedfactor_store 
	change practice_calibrate_speedfactor = ($current_speedfactor)
	change \{current_speedfactor = 1.0}
	setslomo \{1.0}
endscript

script practice_calibrate_restart_song 
	change current_speedfactor = ($practice_calibrate_speedfactor)
	setslomo \{$current_speedfactor}
	practice_restart_song
endscript

script end_practice_song_slomo 
	change \{current_speedfactor = 1.0}
	setslomo \{$current_speedfactor}
endscript

script end_practice_song 

	end_practice_song_slomo
	spawnscriptnow \{xenon_singleplayer_session_complete_uninit
		params = {
			song_failed
		}}
	kill_gem_scroller
endscript
