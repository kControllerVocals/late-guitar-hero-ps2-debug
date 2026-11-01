
script ui_create_game_mode \{mode = career}
	change \{game_mode = p1_quickplay}
	change \{current_num_players = 1}
	change \{in_join_band_screens = 0}
	change \{first_character_hub_enter = 1}
	change \{respond_to_signin_changed = 0}
	change \{respond_to_signin_changed_func = main_menu_signin_changed}
	clear_exclusive_devices
	change \{band_mode_menu_tags = none}
	change \{band_mode_mode = none}
	if (<mode> = career)
		choose_script = game_mode_select_career
		text = qs(0xde7ec8b3)
	else
		choose_script = game_mode_select_quickplay
		text = qs(0xfabdce2b)
	endif
	make_menu_frontend {
		pad_back_script = ui_game_mode_back
		title = <text>
		use_all_controllers
		pos = (15.0, 40.0)
	}
	add_menu_frontend_item text = qs(0xdfe62bc8) pad_choose_script = <choose_script>
	if (<mode> = quickplay || <mode> = career)
		if are_multiple_controllers_connected
			add_menu_frontend_item text = qs(0xdabf99c0) pad_choose_script = <choose_script> pad_choose_params = {band}
			<window_id> :obj_spawnscript ui_game_mode_poll_for_band_mode params = {band_mode_allowed = 1 mode = <mode>}
		else
			add_menu_frontend_item text = qs(0xdabf99c0) pad_choose_script = <choose_script> pad_choose_params = {band} rgba = [50 44 35 255]
			<window_id> :obj_spawnscript ui_game_mode_poll_for_band_mode params = {band_mode_allowed = 0 mode = <mode>}
		endif
	else
		add_menu_frontend_item text = qs(0xdabf99c0) pad_choose_script = <choose_script> pad_choose_params = {band}
	endif
	add_menu_frontend_item \{text = qs(0xd093953b)
		pad_choose_script = set_primary_controller
		pad_choose_params = {
			state = uistate_select_practice_mode
		}}
	ui_return_game_mode
endscript

script ui_destroy_game_mode 
	generic_ui_destroy
endscript

script ui_return_game_mode 
	add_user_control_helper \{text = qs(0xc18d5e76)
		button = green
		z = 100000
		all_buttons}
	add_user_control_helper \{text = qs(0xaf4d5dd2)
		button = red
		z = 100000
		all_buttons}
endscript

script game_mode_select_career 
	if NOT isguitarcontroller controller = <device_num>
		if NOT isdrumcontroller controller = <device_num>
			if NOT ismicrophonepluggedin
				if ($allow_controller_for_all_instruments = 0)
					ui_event event = menu_change data = {is_popup state = uistate_generic_alert_popup title = qs(0x361603ec) text = ($0x8f75a8b6) player_device = <device_num>}
					return
				endif
			endif
		endif
	endif
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	if NOT gotparam \{band}
		change \{game_mode = p1_career}
		change \{current_num_players = 1}
		change \{structurename = player1_status
			part = guitar}
		change structurename = player1_status controller = ($primary_controller)
		change globalname = player1_device newvalue = ($primary_controller)
		change \{structurename = player2_status
			part = guitar}
		change \{band_mode_mode = none}
	else
		change \{game_mode = p2_career}
		change \{current_num_players = 2}
		change \{band_mode_mode = career}
		change \{in_join_band_screens = 1}
		ui_group_play_select_local device_num = <device_num>
		return
	endif
	if ($band_mode_mode = none)
		change \{respond_to_signin_changed = 1}
		change \{respond_to_signin_changed_func = none}
		set_primary_controller device_num = <device_num> state = uistate_select_instrument
	elseif ($band_mode_mode = career)
		set_primary_controller device_num = <device_num> state = uistate_band_mode
	endif
endscript

script game_mode_select_quickplay 
	if NOT gotparam \{band}
		if NOT isguitarcontroller controller = <device_num>
			if NOT isdrumcontroller controller = <device_num>
				if NOT ismicrophonepluggedin
					if ($allow_controller_for_all_instruments = 0)
						ui_event event = menu_change data = {is_popup state = uistate_generic_alert_popup title = qs(0x361603ec) text = ($0x8f75a8b6) player_device = <device_num>}
						return
					endif
				endif
			endif
		endif
		change \{game_mode = p1_quickplay}
		change \{current_num_players = 1}
		change structurename = player1_status controller = ($primary_controller)
		change globalname = player1_device newvalue = ($primary_controller)
		change \{respond_to_signin_changed = 1}
		change \{respond_to_signin_changed_func = none}
		set_primary_controller device_num = <device_num> state = uistate_select_instrument
	else
		if NOT are_multiple_controllers_connected
			ui_event \{event = menu_change
				data = {
					is_popup
					state = uistate_generic_alert_popup
					title = qs(0x361603ec)
					text = qs(0x2dda730c)
				}}
			return
		else
			change \{band_mode_mode = quickplay}
			change \{game_mode = p2_quickplay}
			change \{current_num_players = 2}
			change \{in_join_band_screens = 1}
			set_primary_controller device_num = <device_num> state = uistate_band_mode
		endif
	endif
endscript

script ui_game_mode_back 
	generic_event_back
endscript

script ui_game_mode_poll_for_band_mode 
	begin
	if NOT are_multiple_controllers_connected
		if (<band_mode_allowed> = 1)
			ui_event event = menu_replace data = {state = uistate_game_mode mode = <mode>}
			block
		endif
	else
		if (<band_mode_allowed> = 0)
			ui_event event = menu_replace data = {state = uistate_game_mode mode = <mode>}
			block
		endif
	endif
	wait \{1
		gameframe}
	repeat
endscript
