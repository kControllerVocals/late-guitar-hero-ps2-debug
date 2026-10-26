came_to_practice_from = main_menu
came_to_practice_from_progression = none
came_to_practice_character_id = EmptyGuy
came_to_practice_difficulty = easy

script practice_check_song_for_parts 
	destroy_band
	ps2_force_unload_car_part_script
	load_songqpak song_name = ($current_song) async = 0
	set_song_section_array \{player = 1}
	generic_event_choose \{state = uistate_practice_select_difficulty}
endscript

script practice_check_song_for_parts_back 
	load_songqpak song_name = ($current_song) async = 0
	get_song_struct song = ($current_song)
	if StructureContains Structure = <song_struct> no_rhythm_track
		return \{flow_state = practice_setlist_fs}
	endif
	SongFileManager func = get_num_instrument_notes song_name = ($current_song) difficulty = easy part = guitar
	if (<num_instrument_notes> > 0)
		return \{flow_state = practice_select_part_fs}
	endif
	if StructureContains Structure = <song_struct> use_coop_notetracks
		return \{flow_state = practice_select_part_fs}
	endif
	return \{flow_state = practice_setlist_fs}
endscript

script practice_start_song \{device_num = 0}
	change \{game_mode = practice}
	change \{current_transition = practice}
	get_frontend_venue_checksum
	change current_level = <frontend_venue>
	start_song {
		StartTime = ($practice_start_time)
		device_num = <device_num>
		practice_intro = 1
		endtime = ($practice_end_time)
		StartTime = <StartTime>
		uselaststarttime = <uselaststarttime>
	}
	spawnscriptnow \{practice_update}
endscript

script practice_restart_song 
	end_song
	ResetScoreUpdateReady
	spawnscriptnow \{practice_restart_song_spawned}
endscript

script practice_restart_song_spawned 
	SetScriptCannotPause
	change \{game_mode = practice}
	change \{current_transition = practice}
	generic_event_back \{state = uistate_gameplay}
	restart_song practice_intro = 1 StartTime = ($practice_start_time) endtime = ($practice_end_time)
	KillSpawnedScript \{name = practice_update}
	spawnscriptnow \{practice_update}
endscript

script practice_update 
	SetScriptCannotPause
	ResetPracticeSoundBusses
	begin
	practice_audio_filter
	GetSongTimeMs
	if (<time> > ($practice_end_time))
		SongSetMasterVolume \{vol = -100
			time = 0.4}
		if (<time> > (($practice_end_time) + ($Song_Win_Delay * 1000 - 100)))
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
	Wait \{1
		gameframes}
	repeat
endscript

script practice_loop_song 
	stoprendering
	RemovePlayerServerFretbarIterator \{fretbar_id = CreateFretbar
		id = player1_status}
	RemovePlayerServerFretbarIterator \{fretbar_id = PreFretbarEvent
		id = player1_status}
	RemovePlayerServerFretbarIterator \{fretbar_id = FretbarEvent
		id = player1_status}
	RemovePlayerServerFretbarIterator \{fretbar_id = CreateVocalMarker
		id = player1_status}
	ClearPlayerServerMessages
	LaunchGemEvent \{event = kill_objects}
	FlushPlayerServerMessages
	KillSpawnedScript \{name = GuitarEvent_MissedNote}
	KillSpawnedScript \{name = GuitarEvent_UnnecessaryNote}
	KillSpawnedScript \{name = GuitarEvent_HitNotes}
	KillSpawnedScript \{name = GuitarEvent_HitNote}
	KillSpawnedScript \{name = GuitarEvent_StarPowerOn}
	KillSpawnedScript \{name = GuitarEvent_StarPowerOff}
	KillSpawnedScript \{name = GuitarEvent_StarHitNote}
	KillSpawnedScript \{name = GuitarEvent_StarSequenceBonus}
	KillSpawnedScript \{name = GuitarEvent_StarMissNote}
	KillSpawnedScript \{name = GuitarEvent_WhammyOn}
	KillSpawnedScript \{name = GuitarEvent_WhammyOff}
	KillSpawnedScript \{name = GuitarEvent_StarWhammyOn}
	KillSpawnedScript \{name = GuitarEvent_StarWhammyOff}
	KillSpawnedScript \{name = GuitarEvent_Note_Window_Open}
	KillSpawnedScript \{name = GuitarEvent_Note_Window_Close}
	KillSpawnedScript \{name = GuitarEvent_crowd_poor_medium}
	KillSpawnedScript \{name = GuitarEvent_crowd_medium_good}
	KillSpawnedScript \{name = GuitarEvent_crowd_medium_poor}
	KillSpawnedScript \{name = GuitarEvent_crowd_good_medium}
	KillSpawnedScript \{name = GuitarEvent_CreateFirstGem}
	KillSpawnedScript \{name = highway_pulse_black}
	KillSpawnedScript \{name = GuitarEvent_HitNote_Spawned}
	KillSpawnedScript \{name = hit_note_fx}
	KillSpawnedScript \{name = Do_StarPower_StageFX}
	KillSpawnedScript \{name = Do_StarPower_Camera}
	KillSpawnedScript \{name = first_gem_fx}
	KillSpawnedScript \{name = gem_iterator}
	KillSpawnedScript \{name = gem_array_stepper}
	KillSpawnedScript \{name = gem_array_events}
	KillSpawnedScript \{name = gem_step}
	KillSpawnedScript \{name = gem_step_end}
	KillSpawnedScript \{name = Drumkit_anim_iterator}
	KillSpawnedScript \{name = WatchForStartPlaying_iterator}
	Band_DisableTempoIterator
	KillSpawnedScript \{name = tempo_matching_iterator}
	KillSpawnedScript \{name = MomentCamera_PlayAnim_Spawned}
	KillSpawnedScript \{name = fretbar_update_tempo}
	KillSpawnedScript \{name = fretbar_update_hammer_on_tolerance}
	KillSpawnedScript \{name = gem_scroller}
	KillSpawnedScript \{name = button_checker}
	KillSpawnedScript \{name = check_buttons}
	notemap_deinit
	reset_score \{player_status = player1_status}
	transition_time = 2000
	if (($player1_status.part) = Vocals)
		ResetVocalHighwayIndexes \{player = 1}
		transition_time = 4000
	endif
	setslomo \{0.001}
	reset_song_time StartTime = ($practice_start_time - <transition_time>)
	SetArrayElement \{ArrayName = currently_holding
		GlobalArray
		index = 0
		newvalue = 0}
	SpawnScriptLater \{update_score_fast
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
	if (($player1_status.part) != Vocals)
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
	Wait \{1
		gameframe}
	SongPause
	SetSeekPosition_Song position = ($practice_start_time - <transition_time>)
	SongUnPause
	setslomo \{$current_speedfactor}
	pausegh3
	Wait \{1
		gameframe}
	unpausegh3
	startrendering
endscript

script finish_practice_song 
	KillSpawnedScript \{name = practice_update}
	GuitarEvent_SongWon
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
	KillSpawnedScript \{name = practice_update}
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
