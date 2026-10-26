practice_return_venue = none
practice_return_state = none

script create_practice_warning_menu 
	disable_pause
	player_device = ($last_start_pressed_device)
	get_song_struct song = ($current_song)
	warning_text = qs("YOUR PROGRESS IN THIS SONG WILL BE LOST IF YOU EXIT TO PRACTICE NOW. EXIT?")
	disable_pause
	create_dialog_box {
		body_text = <warning_text>
		player_device = <player_device>
		no_background
		options = [
			{
				func = generic_event_back
				text = qs("CANCEL")
			}
			{
				func = practice_warning_menu_select_practice_mode
				text = qs("PRACTICE MODE")
			}
		]
	}
endscript

script destroy_practice_warning_menu 
	destroy_dialog_box
endscript

script practice_warning_menu_select_practice 
	kill_intro_celeb_ui
	if ($game_mode = gh4_p1_career || $game_mode = gh4_p2_career || $band_mode_mode = career)
		career_song_ended_select_quit
	endif
	GH3_SFX_fail_song_stop_sounds
	kill_gem_scroller
	ResetScoreUpdateReady
	if ScreenElementExists \{id = dialog_box_vmenu}
		dialog_box_vmenu :SetProps \{block_events}
	endif
	change practice_return_venue = ($current_level)
endscript

script practice_warning_menu_select_practice_mode 
	set_loading_screen \{full}
	practice_warning_menu_select_practice
	change \{practice_return_state = uistate_select_song_section}
	do_training_loading part = ($player1_status.part)
	ui_event \{event = menu_change
		state = uistate_select_song_section
		data = {
			from_in_game = 1
		}}
endscript
