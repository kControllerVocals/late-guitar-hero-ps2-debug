
script ui_create_pausemenu_change_difficulty_confirm 
	create_pausemenu_change_difficulty_confirm <...>
endscript

script ui_destroy_pausemenu_change_difficulty_confirm 
	destroy_dialog_box
endscript

script create_pausemenu_change_difficulty_confirm 
	player_device = ($last_start_pressed_device)
	create_dialog_box {
		body_text = qs("Your difficulty has now been changed permanently until you change it again.")
		player_device = <player_device>
		no_background
		options = [
			{
				func = pausemenu_change_difficulty_confirm_ok
				func_params = {<...>}
				text = qs("OK")
			}
		]
	}
endscript

script pausemenu_change_difficulty_confirm_ok 
	player = 1
	if ($current_num_players > 1)
		player_device = ($last_start_pressed_device)
		i = 1
		begin
		GetPlayerInfo <i> controller
		if (<controller> = <player_device>)
			player = <i>
			break
		endif
		i = (<i> + 1)
		repeat ($current_num_players)
	endif
	if NOT (<vocalist_without_controller> = -1)
		player = (<vocalist_without_controller> + 1)
	endif
	SetPlayerInfo <player> difficulty = <difficulty>
	SetPlayerInfo <player> double_kick_drum = <double_kick>
	if (<vocalist_without_controller> = -1)
		SetArrayElement ArrayName = default_difficulty GlobalArray index = ($last_start_pressed_device) newvalue = <difficulty>
	endif
	change \{should_reset_gig_posters_selection = 1}
	restart_warning_select_restart player = <player>
endscript
