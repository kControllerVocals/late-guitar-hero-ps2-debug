
script ui_init_game_mode 
	push_num_players \{num = 1}
endscript

script ui_deinit_game_mode 
	pop_num_players
endscript

script ui_create_game_mode \{mode = career}
	if loading_screen_exists
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
	GetPlayerInfo <i> controller
	GetPlayerInfo <i> part
	if (<part> = Band)
		SetPlayerInfo <i> part = guitar
		GetPlayerInfo <i> part
	endif
	GetSavegameFromController controller = <controller>
	cas_get_random_preset_character savegame = <savegame> part = <part>
	SetPlayerInfo <i> character_id = <character_id>
	i = (<i> + 1)
	repeat 4
	if (<mode> = career)
		choose_script = game_mode_select_career
		text = qs("CAREER")
	elseif (<mode> = partyplay)
		choose_script = game_mode_select_partyplay
		text = qs("PARTY PLAY")
	elseif (<mode> = freeplay)
		choose_script = game_mode_select_freeplay
		text = qs(0x2406ab68)
	else
		choose_script = game_mode_select_quickplay
		text = qs("QUICKPLAY")
	endif
	make_generic_stripe_menu {
		pad_back_script = ui_game_mode_back
		title = <text>
		use_all_controllers
	}
	add_generic_stripe_menu_item text = qs("SINGLE") pad_choose_script = <choose_script>
	if ((<mode> = quickplay) || (<mode> = partyplay) || (<mode> = freeplay))
		if are_multiple_controllers_connected
			add_generic_stripe_menu_item text = qs("BAND") pad_choose_script = <choose_script> pad_choose_params = {Band}
			<window_id> :obj_spawnscript ui_game_mode_poll_for_band_mode params = {band_mode_allowed = 1 mode = <mode>}
		else
			add_generic_stripe_menu_item text = qs("BAND") pad_choose_script = <choose_script> pad_choose_params = {Band}
		endif
		<desc_id> :Obj_SpawnScriptNow career_menu_jaw_anim
	else
		if has_enough_controllers_for_band
			add_generic_stripe_menu_item {
				text = qs("BAND")
				pad_choose_script = <choose_script> pad_choose_params = {Band}
			}
		else
			add_generic_stripe_menu_item {
				text = qs("BAND")
				pad_choose_script = <choose_script> pad_choose_params = {Band}
			}
		endif
		add_generic_stripe_menu_item \{text = qs("TUTORIALS")
			pad_choose_script = ui_select_practice_mode_choose}
		<desc_id> :Obj_SpawnScriptNow career_menu_jaw_anim
	endif
	ui_create_particle_circle \{z_offset = 700.0}
	ui_return_game_mode
endscript

script career_menu_jaw_anim 
	if ScreenElementExists \{id = movie_handler}
		begin
		Wait \{2
			frame}
		if NOT ScreenElementExists \{id = movie_handler}
			break
		endif
		repeat
	endif
	if Desc_ResolveAlias \{name = alias_projection_glow
			param = projection_glow_id}
		<projection_glow_id> :obj_spawnscript ui_flicker_highlight params = {glow_dimly}
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
	KillSpawnedScript \{name = career_menu_jaw_anim}
	ui_destroy_particle_circle
	generic_ui_destroy
endscript

script ui_return_game_mode 
	add_user_control_helper \{text = qs("SELECT")
		button = green
		z = 100000
		all_buttons}
	add_user_control_helper \{text = qs("BACK")
		button = red
		z = 100000
		all_buttons}
endscript

script game_mode_select_career 
	if NOT IsGuitarController controller = <device_num>
		if NOT IsDrumController controller = <device_num>
			if NOT IsMicrophonePluggedIn
				if ($allow_controller_for_all_instruments = 0)
					ui_event event = menu_change data = {is_popup state = UIstate_generic_alert_popup title = qs("Warning") text = qs(0x67b7ef20) player_device = <device_num>}
					return
				endif
			endif
		endif
	endif
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	if ScriptIsRunning \{menu_transition_in_spawned}
		KillSpawnedScript \{name = menu_transition_in_spawned}
	endif
	if ScriptIsRunning \{menu_transition_in}
		KillSpawnedScript \{name = menu_transition_in}
	endif
	if NOT GotParam \{Band}
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
			if NOT IsGuitarController controller = <device_num>
				if IsDrumController controller = <device_num>
					ui_select_instrument_done instrument = drum device_num = <device_num> skip
					return
				else
					ui_select_instrument_done instrument = Vocals device_num = <device_num> skip
					return
				endif
			endif
		endif
		set_primary_controller device_num = <device_num> state = uistate_select_instrument
	elseif ($band_mode_mode = career)
		set_primary_controller device_num = <device_num> state = UIstate_band_mode
	endif
endscript

script game_mode_select_freeplay 
	game_mode_select_quickplay freeplay <...>
endscript

script game_mode_select_partyplay 
	game_mode_select_quickplay partyplay <...>
endscript

script game_mode_select_quickplay 
	if ScriptIsRunning \{menu_transition_in_spawned}
		KillSpawnedScript \{name = menu_transition_in_spawned}
	endif
	if ScriptIsRunning \{menu_transition_in}
		KillSpawnedScript \{name = menu_transition_in}
	endif
	if NOT GotParam \{Band}
		change \{game_mode = p1_quickplay}
		change \{current_num_players = 1}
		change primary_controller = <device_num>
		change structurename = player1_status controller = <device_num>
		change globalname = player1_device newvalue = <device_num>
		change \{respond_to_signin_changed = 1}
		change \{respond_to_signin_changed_func = none}
		if NOT IsGuitarController controller = <device_num>
			if NOT IsDrumController controller = <device_num>
				if NOT IsMicrophonePluggedIn
					if ($allow_controller_for_all_instruments = 0)
						ui_event event = menu_change data = {is_popup state = UIstate_generic_alert_popup title = qs("Warning") text = qs(0x67b7ef20) player_device = <device_num>}
						return
					endif
				endif
			endif
		endif
		if (($allow_controller_for_all_instruments) = 0)
			if NOT IsGuitarController controller = <device_num>
				if IsDrumController controller = <device_num>
					ui_select_instrument_done instrument = drum device_num = <device_num> skip
					return
				else
					ui_select_instrument_done instrument = Vocals device_num = <device_num> skip
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
			Block
		endif
	else
		if (<band_mode_allowed> = 0)
			ui_event event = menu_replace data = {state = uistate_game_mode mode = <mode>}
			Block
		endif
	endif
	Wait \{1
		gameframe}
	repeat
endscript
