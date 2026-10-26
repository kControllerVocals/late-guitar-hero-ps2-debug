calibrate_lag_warning_menu_font = fontgrid_title_a1

script create_calibrate_lag_warning_menu \{Body = qs("To calibrate lag, this song must be restarted. You will lose all unsaved progress if you restart. Are you sure you want to continue?")
		cancel_script = generic_event_back
		yes_func_params = {
		}}
	disable_pause
	if NOT GotParam \{controller}
		<controller> = $primary_controller
	endif
	create_dialog_box {
		body_text = <Body>
		player_device = <controller>
		no_background
		options = [
			{
				func = <cancel_script>
				text = qs("CANCEL")
			}
			{
				func = menu_calibrate_lag_warning_select_yes
				func_params = <yes_func_params>
				text = qs("CALIBRATE")
			}
		]
	}
endscript

script destroy_calibrate_lag_warning_menu 
	destroy_dialog_box
	enable_pause
endscript

script menu_calibrate_lag_warning_select_yes 
	kill_intro_celeb_ui
	ResetScoreUpdateReady
	GH3_SFX_fail_song_stop_sounds
	StopSoundsByBuss \{Encore_Events}
	generic_event_choose event = menu_replace state = UIstate_options_calibrate_lag data = {from_in_game = 1 <...>}
endscript
