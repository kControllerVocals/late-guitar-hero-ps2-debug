
script ui_create_pausemenu_change_difficulty_warning 
	create_pausemenu_change_difficulty_warning <...>
endscript

script ui_destroy_pausemenu_change_difficulty_warning 
	destroy_dialog_box
endscript

script create_pausemenu_change_difficulty_warning \{vocalist_without_controller = -1}
	disable_pause
	if (($is_partyplay_mode = 1) && (GotParam band_mode))
		body_text = qs(0x2e325b58)
		continue_text = qs("QUIT")
	else
		body_text = qs("To change the difficulty setting, this song must be restarted. You will lose all unsaved progress if you restart. Are you sure you want to continue?")
		continue_text = qs("RESTART")
	endif
	create_dialog_box {
		body_text = <body_text>
		player_device = <player_device>
		no_background
		options = [
			{
				func = {generic_event_back params = {vocalist_without_controller = <vocalist_without_controller>}}
				text = qs("CANCEL")
			}
			{
				func = pausemenu_change_difficulty_warning_yes
				func_params = {double_kick = <double_kick> difficulty = <difficulty> vocalist_without_controller = <vocalist_without_controller> band_mode = <band_mode>}
				text = <continue_text>
			}
		]
	}
endscript

script pausemenu_change_difficulty_warning_yes 
	kill_intro_celeb_ui
	if GotParam \{band_mode}
		generic_event_back \{state = uistate_band_difficulty}
	else
		generic_event_choose state = UIstate_pausemenu_change_difficulty_confirm data = {<...> difficulty = <difficulty>}
	endif
endscript
