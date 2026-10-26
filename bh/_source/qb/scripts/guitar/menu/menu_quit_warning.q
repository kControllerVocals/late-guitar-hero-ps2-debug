
script create_quit_warning_menu \{player = 1
		option1_text = qs("CANCEL")
		option2_text = qs("QUIT")
		option1_func = generic_event_back
		option1_func_params = {
		}
		option2_func = quit_warning_select_quit
		option2_func_params = {
		}
		skip_song = false}
	disable_pause
	player_device = ($last_start_pressed_device)
	if (<skip_song> = true)
		body_text = qs(0x88152393)
		option2_text = qs("SKIP SONG")
		option2_func = quickplay_skip_song
	elseif NOT game_is_scored
		body_text = qs(0xe4b9c437)
	else
		body_text = qs("You will lose all unsaved progress for this song if you quit. Are you sure you want to quit?")
	endif
	create_dialog_box {
		body_text = <body_text>
		player_device = <player_device>
		no_background
		options = [
			{
				func = <option1_func>
				func_params = <option1_func_params>
				text = <option1_text>
			}
			{
				func = generic_quit_warning_select_quit
				func_params = {func = <option2_func> func_params = <option2_func_params>}
				text = <option2_text>
			}
		]
	}
endscript

script destroy_quit_warning_menu 
	destroy_dialog_box
endscript

script generic_quit_warning_select_quit 
	restore_player_part_settings
	<func> <func_params>
endscript

script quit_warning_select_quit \{player = 1
		callback = generic_event_choose
		data = {
			state = uistate_pausemenu_song_ended
		}}
	restore_player_part_settings
	if GotParam \{quit_career_confirm}
		GameMode_GetType
		if (<type> = career)
			career_song_ended_select_quit
		endif
	endif
	if isXenon
		if NOT ($current_song = jamsession)
			WriteSongDataToFile \{incomplete = 1}
		endif
	endif
	end_singleplayer_game
	ResetScoreUpdateReady
	GH3_SFX_fail_song_stop_sounds
	hide_glitch \{num_frames = 3}
	<callback> data = <data> no_sound
endscript
