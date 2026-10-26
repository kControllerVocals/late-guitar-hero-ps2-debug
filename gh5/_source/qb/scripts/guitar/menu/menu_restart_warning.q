
script create_restart_warning_menu \{player = 1
		cancel_func = generic_event_back
		cancel_func_params = {
		}}
	disable_pause
	if NOT game_is_scored
		body_text = qs(0x0be331bb)
	else
		body_text = qs("You will lose all unsaved progress if you restart. Are you sure you want to restart this song?")
	endif
	player_device = ($last_start_pressed_device)
	create_dialog_box {
		body_text = <body_text>
		player_device = <player_device>
		no_background
		options = [
			{
				func = <cancel_func>
				func_params = <cancel_func_params>
				text = qs("CANCEL")
			}
			{
				func = restart_warning_select_restart
				text = qs("RESTART")
			}
		]
	}
endscript

script destroy_restart_warning_menu 
	destroy_dialog_box
endscript

script restart_warning_select_restart \{player = 1}
	set_loading_screen \{full}
	if ($is_partyplay_mode = 1)
		change \{gameplay_restart_song = 1}
		generic_event_back \{state = uistate_gameplay}
		return
	endif
	change \{ps2_gameplay_restart_song = 1}
	kill_intro_celeb_ui
	if NOT GotParam \{dont_save_song_data}
		if isXenon
			if ($playing_song = 1)
				if NOT ($current_song = jamsession)
					WriteSongDataToFile \{incomplete = 1}
				endif
			endif
		endif
	endif
	restore_player_part_settings
	generic_event_back \{state = uistate_gameplay}
	ResetScoreUpdateReady
	GH3_SFX_fail_song_stop_sounds
	StopSoundsByBuss \{Encore_Events}
	if ($game_mode = practice)
		spawnscriptnow \{practice_restart_song}
	else
		spawnscriptnow \{career_restart_song}
	endif
endscript
