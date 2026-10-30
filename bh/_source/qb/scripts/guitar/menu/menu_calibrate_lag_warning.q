
script create_calibrate_lag_warning_menu \{body = qs(0x0a3798b8)
		cancel_script = generic_event_back
		yes_func_params = {
		}}
	disable_pause
	if NOT gotparam \{controller}
		<controller> = $primary_controller
	endif
	create_dialog_box {
		body_text = <body>
		player_device = <controller>
		no_background
		options = [
			{
				func = <cancel_script>
				text = qs(0xf7723015)
			}
			{
				func = menu_calibrate_lag_warning_select_yes
				func_params = <yes_func_params>
				text = qs(0x0e56c83c)
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
	resetscoreupdateready
	gh3_sfx_fail_song_stop_sounds
	stopsoundsbybuss \{encore_events}
	generic_event_choose event = menu_replace state = uistate_options_calibrate_lag data = {from_in_game = 1 <...>}
endscript
