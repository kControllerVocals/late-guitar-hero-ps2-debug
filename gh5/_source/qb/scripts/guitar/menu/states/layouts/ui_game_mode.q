
script 0x6776bbc8 
	0xfd22d1e7 \{num = 1}
endscript

script 0x93700c16 
	0x88e84c31
endscript

script ui_create_game_mode \{mode = career}
	if 0x8658e568
		destroy_loading_screen
	endif
	cas_destroy_all_characters
	change \{game_mode = p1_quickplay}
	change \{current_num_players = 1}
	change \{in_join_band_screens = 0}
	change \{first_character_hub_enter = 1}
	change \{respond_to_signin_changed = 0}
	change \{respond_to_signin_changed_func = main_menu_signin_changed}
	change \{current_progression_flag = none}
	change \{practice_enabled = 0}
	clear_exclusive_devices
	reset_band_mode
	change \{band_mode_menu_tags = none}
	change \{band_mode_mode = none}
	i = 1
	begin
	getplayerinfo <i> controller
	getplayerinfo <i> part
	if (<part> = band)
		setplayerinfo <i> part = guitar
		getplayerinfo <i> part
	endif
	getsavegamefromcontroller controller = <controller>
	cas_get_random_preset_character savegame = <savegame> part = <part>
	setplayerinfo <i> character_id = <character_id>
	i = (<i> + 1)
	repeat 4
	if (<mode> = career)
		choose_script = game_mode_select_career
		text = qs(0xde7ec8b3)
	elseif (<mode> = 0x955f856c)
		choose_script = 0xde1174ba
		text = qs(0x8a778398)
	elseif (<mode> = freeplay)
		choose_script = 0xcbadbeff
		text = qs(0x2406ab68)
	else
		choose_script = game_mode_select_quickplay
		text = qs(0xfabdce2b)
	endif
	make_menu_frontend {
		pad_back_script = ui_game_mode_back
		title = <text>
	}
	add_menu_frontend_item text = qs(0xdfe62bc8) pad_choose_script = <choose_script>
	if ((<mode> = quickplay) || (<mode> = 0x955f856c) || (<mode> = freeplay))
		if are_multiple_controllers_connected
			add_menu_frontend_item text = qs(0xdabf99c0) pad_choose_script = <choose_script> pad_choose_params = {band}
			<window_id> :obj_spawnscript ui_game_mode_poll_for_band_mode params = {band_mode_allowed = 1 mode = <mode>}
		else
			add_menu_frontend_item text = qs(0xdabf99c0) pad_choose_script = <choose_script> pad_choose_params = {band}
		endif
		<desc_id> :obj_spawnscriptnow career_menu_jaw_anim
	else
		if has_enough_controllers_for_band
			add_menu_frontend_item {
				text = qs(0xdabf99c0)
				pad_choose_script = <choose_script> pad_choose_params = {band}
			}
		else
			add_menu_frontend_item {
				text = qs(0xdabf99c0)
				pad_choose_script = <choose_script> pad_choose_params = {band}
			}
		endif
		add_menu_frontend_item \{text = qs(0xc6510dd1)
			pad_choose_script = ui_select_practice_mode_choose}
		<desc_id> :obj_spawnscriptnow career_menu_jaw_anim
	endif
	if <desc_id> :desc_resolvealias name = 0xa954edbf param = 0xa1309942
		<0xa1309942> :se_setprops dims = (685.04926, 670.0)
		<0xa1309942> :se_setprops pos = (925.0, 325.0)
	else

	endif
	if <desc_id> :desc_resolvealias name = 0xd389b1ff param = 0xb9ea5094
		<0xb9ea5094> :se_setprops dims = (685.04926, 670.0)
		<0xb9ea5094> :se_setprops pos = (925.0, 325.0)
	else

	endif
	ui_return_game_mode
endscript

script career_menu_jaw_anim 
	if screenelementexists \{id = movie_handler}
		begin
		wait \{2
			frame}
		if NOT screenelementexists \{id = movie_handler}
			break
		endif
		repeat
	endif
	if desc_resolvealias \{name = 0xd389b1ff
			param = 0xb9ea5094}
		<0xb9ea5094> :obj_spawnscript 0xd5b5a21b params = {0xc2c7c0e4}
	else

	endif
endscript

script game_mode_anim_in 
	menu_transition_in \{menu = current_menu_anchor}
endscript

script game_mode_anim_out 
	menu_transition_out \{menu = current_menu_anchor}
endscript

script ui_destroy_game_mode 
	killspawnedscript \{name = career_menu_jaw_anim}
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
					ui_event event = menu_change data = {is_popup state = uistate_generic_alert_popup title = qs(0x361603ec) text = qs(0x67b7ef20) player_device = <device_num>}
					return
				endif
			endif
		endif
	endif
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	if scriptisrunning \{menu_transition_in_spawned}
		killspawnedscript \{name = menu_transition_in_spawned}
	endif
	if scriptisrunning \{menu_transition_in}
		killspawnedscript \{name = menu_transition_in}
	endif
	if NOT gotparam \{band}
		change \{game_mode = gh4_p1_career}
		change \{current_num_players = 1}
		change \{structurename = player1_status
			part = guitar}
		change primary_controller = <device_num>
		change structurename = player1_status controller = <device_num>
		change globalname = player1_device newvalue = <device_num>
		change \{structurename = player2_status
			part = guitar}
		change \{band_mode_mode = none}
	else
		change \{game_mode = gh4_p2_career}
		change \{current_num_players = 2}
		change \{band_mode_mode = career}
		change \{in_join_band_screens = 1}
		ui_group_play_select_local device_num = <device_num>
		return
	endif
	if ($band_mode_mode = none)
		change \{respond_to_signin_changed = 1}
		change \{respond_to_signin_changed_func = none}
		if (($allow_controller_for_all_instruments) = 0)
			if NOT isguitarcontroller controller = <device_num>
				if isdrumcontroller controller = <device_num>
					ui_select_instrument_done instrument = drum device_num = <device_num> skip
					return
				else
					ui_select_instrument_done instrument = vocals device_num = <device_num> skip
					return
				endif
			endif
		endif
		set_primary_controller device_num = <device_num> state = uistate_select_instrument
	elseif ($band_mode_mode = career)
		set_primary_controller device_num = <device_num> state = uistate_band_mode
	endif
endscript

script 0xcbadbeff 
	game_mode_select_quickplay freeplay <...>
endscript

script 0xde1174ba 
	game_mode_select_quickplay 0x955f856c <...>
endscript

script game_mode_select_quickplay 
	if scriptisrunning \{menu_transition_in_spawned}
		killspawnedscript \{name = menu_transition_in_spawned}
	endif
	if scriptisrunning \{menu_transition_in}
		killspawnedscript \{name = menu_transition_in}
	endif
	if NOT gotparam \{band}
		if NOT isguitarcontroller controller = <device_num>
			if NOT isdrumcontroller controller = <device_num>
				if NOT ismicrophonepluggedin
					if ($allow_controller_for_all_instruments = 0)
						ui_event event = menu_change data = {is_popup state = uistate_generic_alert_popup title = qs(0x361603ec) text = qs(0x67b7ef20) player_device = <device_num>}
						return
					endif
				endif
			endif
		endif
		change \{game_mode = p1_quickplay}
		change \{current_num_players = 1}
		change primary_controller = <device_num>
		change structurename = player1_status controller = <device_num>
		change globalname = player1_device newvalue = <device_num>
		change \{respond_to_signin_changed = 1}
		change \{respond_to_signin_changed_func = none}
		if (($allow_controller_for_all_instruments) = 0)
			if NOT isguitarcontroller controller = <device_num>
				if isdrumcontroller controller = <device_num>
					ui_select_instrument_done instrument = drum device_num = <device_num> skip
					return
				else
					ui_select_instrument_done instrument = vocals device_num = <device_num> skip
					return
				endif
			endif
		endif
		set_primary_controller device_num = <device_num> state = uistate_select_instrument
	else
		change \{band_mode_mode = quickplay}
		change \{game_mode = p2_quickplay}
		change \{current_num_players = 2}
		change \{in_join_band_screens = 1}
		ui_group_play_select_local device_num = <device_num>
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
