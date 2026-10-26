practice_enabled = 0

script ui_init_select_practice_mode 
	push_num_players \{num = 1}
	change \{practice_enabled = 1}
	change \{came_to_practice_from = main_menu}
	change \{game_mode = practice}
	change \{respond_to_signin_changed = 1}
	change \{respond_to_signin_changed_func = none}
	spawnscriptnow \{do_training_loading}
endscript
g_training_loading_done = 0

script do_training_loading 
	change \{g_training_loading_done = 0}
	if ScreenElementExists \{id = current_menu_anchor}
		LaunchEvent \{target = current_menu_anchor
			type = unfocus}
	endif
	if NOT ($current_progression_flag = none)
		change came_to_practice_from_progression = ($current_progression_flag)
	endif
	change \{current_progression_flag = none}
	GetPlayerInfo \{1
		character_id}
	if NOT (<character_id> = EmptyGuy)
		change came_to_practice_character_id = <character_id>
		SetPlayerInfo \{1
			character_id = EmptyGuy}
	endif
	destroy_band
	StopSoundsByBuss \{Encore_Events}
	apply_band_logo_to_venue \{step = build}
	if GotParam \{part}
		tutorial_setup_band players = ($current_num_players) part = <part>
	else
		tutorial_setup_band players = ($current_num_players)
	endif
	get_frontend_venue_checksum
	change current_level = <frontend_venue>
	Load_Venue \{block_scripts = 0}
	apply_band_logo_to_venue \{step = apply}
	create_bandname_viewport
	Wait \{2
		gameframes}
	destroy_bg_viewport
	setup_bg_viewport
	change \{current_num_players = 1}
	GameMode_UpdateNumPlayers \{num_players = 1}
	change \{g_training_loading_done = 1}
	hide_band
endscript

script ui_create_select_practice_mode 
	spawnscriptnow \{ui_create_select_practice_mode_spawned}
endscript

script ui_create_select_practice_mode_spawned 
	BG_Crowd_Front_End_Silence
	begin
	if ($g_training_loading_done = 1)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	disable_pause
	UnPauseGame
	make_generic_stripe_menu \{title = qs("TRAINING")
		pad_back_script = menu_select_practice_back}
	add_generic_stripe_menu_item \{text = qs("PRACTICE")
		pad_choose_script = ui_select_practice_mode_choose
		pad_choose_params = {
			practice
		}}
	add_generic_stripe_menu_item \{text = qs("TUTORIALS")
		pad_choose_script = ui_select_practice_mode_choose}
	ui_create_particle_circle \{z_offset = 700.0}
	menu_finish
	LaunchEvent type = focus target = current_menu data = {child_index = <selected_index>}
endscript

script menu_select_practice_back 
	generic_event_back
endscript

script ui_destroy_select_practice_mode 
	ui_destroy_particle_circle
	generic_ui_destroy
endscript

script ui_deinit_select_practice_mode 
	pop_num_players
	destroy_band
	destroy_bandname_viewport
	tutorial_disable_botplay
	change \{practice_enabled = 0}
endscript

script ui_select_practice_mode_choose 
	change \{practice_enabled = 1}
	change \{came_to_practice_from = main_menu}
	change \{game_mode = practice}
	change \{respond_to_signin_changed = 1}
	change \{respond_to_signin_changed_func = none}

	if GotParam \{practice}
		set_loading_screen \{mini}
		change \{training_mode = practice}
		change \{game_mode = practice}
	else
		set_loading_screen \{full}
		do_training_loading
		change \{training_mode = tutorials}
	endif
	if ($training_mode = tutorials)
		set_primary_controller device_num = <device_num> state = uistate_select_tutorial no_sound
	else
		change \{current_num_players = 1}
		GameMode_UpdateNumPlayers \{num_players = 1}
		clear_exclusive_devices
		add_exclusive_device device = ($primary_controller)
		if (($allow_controller_for_all_instruments) = 0)
			if NOT IsGuitarController controller = <device_num>
				if IsDrumController controller = <device_num>
					ui_select_instrument_done instrument = drum device_num = <device_num> skip
				else
					ui_select_instrument_done instrument = Vocals device_num = <device_num> skip
				endif
				ui_event_wait_for_safe
				destroy_loading_screen
				SetButtonEventMappings \{unblock_menu_input}
				return
			endif
		endif
		generic_event_choose \{state = uistate_select_instrument}
	endif
endscript

script check_tutorial_allowances \{allow_RB_drums = 1}
	if ($allow_controller_for_all_instruments = 1)
		return \{allowances = all}
	endif
	if IsGuitarController \{controller = $primary_controller}
		<allowances> = guitar
	elseif isRBDrum \{controller = $primary_controller}
		if (<allow_RB_drums> = 1)
			<allowances> = drum
		else
			<allowances> = rb_drum
		endif
	elseif IsDrumController \{controller = $primary_controller}
		<allowances> = drum
	else
		ui_get_controller_parts_allowed \{controller = $primary_controller}
		if StructureContains Structure = <allowed> Vocals
			<allowances> = Vocals
		else
			<allowances> = not_specific
		endif
	endif
	return allowances = <allowances>
endscript
