lefty_flip_warning_menu_font = fontgrid_title_a1

script create_lefty_flip_warning_menu 
	disable_pause
	player_device = ($last_start_pressed_device)
	<num_players> = ($current_num_players)
	if (<num_players> > 0)
		i = 1
		begin
		GetPlayerInfo <i> controller
		if (<controller> = <player_device>)
			player = <i>
			break
		endif
		i = (<i> + 1)
		repeat <num_players>
	endif
	create_dialog_box {
		body_text = qs("To change the lefty flip setting, this song must be restarted. You will lose all unsaved progress if you restart. Are you sure you want to continue?")
		player_device = <player_device>
		no_background
		options = [
			{
				func = lefty_flip_warning_go_back
				text = qs("CANCEL")
			}
			{
				func = menu_lefty_flip_warning_select_yes
				func_params = {player = <player>}
				text = qs("RESTART")
			}
		]
	}
endscript

script lefty_flip_warning_go_back 
	enable_pause
	generic_event_back
endscript

script destroy_lefty_flip_warning_menu 
	destroy_dialog_box
endscript

script menu_lefty_flip_warning_select_yes 
	set_loading_screen \{full}
	generic_event_back \{state = uistate_gameplay}
	ResetScoreUpdateReady
	GH3_SFX_fail_song_stop_sounds
	MonitorControllerStates
	toggle_lefty_flip player = <player>
	spawnscriptnow lefty_flip_func params = {player = <player>}
endscript
