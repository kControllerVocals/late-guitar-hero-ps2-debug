
script create_lefty_flip_warning_menu 
	disable_pause
	player_device = ($last_start_pressed_device)
	<num_players> = ($current_num_players)
	if (<num_players> > 0)
		i = 1
		begin
		getplayerinfo <i> controller
		if (<controller> = <player_device>)
			player = <i>
			break
		endif
		i = (<i> + 1)
		repeat <num_players>
	endif
	create_dialog_box {
		body_text = qs(0x2ba14213)
		player_device = <player_device>
		no_background
		options = [
			{
				func = lefty_flip_warning_go_back
				text = qs(0xf7723015)
			}
			{
				func = menu_lefty_flip_warning_select_yes
				func_params = {player = <player>}
				text = qs(0xb8790f2f)
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
	0xe9384b7a \{full}
	generic_event_back \{state = uistate_gameplay}
	resetscoreupdateready
	gh3_sfx_fail_song_stop_sounds
	monitorcontrollerstates
	0x978e7147 player = <player>
	spawnscriptnow lefty_flip_func params = {player = <player>}
endscript
