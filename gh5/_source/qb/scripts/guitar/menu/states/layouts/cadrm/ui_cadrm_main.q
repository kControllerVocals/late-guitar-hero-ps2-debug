
script ui_create_cadrm_main 
	spawnscriptnow ui_create_cadrm_main_spawned params = {<...>}
endscript

script ui_create_cadrm_main_spawned 
	OnExitRun \{InputHandlerPermit}
	InputHandlerForbid
	cas_queue_wait
	if NOT GotParam \{old_save_checksum}
		globaltag_getarraychecksum savegame = ($cas_current_savegame) array_name = player_drum_save
		old_save_checksum = <array_checksum>
		ui_event_add_params old_save_checksum = <old_save_checksum>
	endif
	make_generic_menu \{vmenu_id = create_cadrm_main_vmenu
		title = qs("DRUMS")
		num_icons = 2
		show_history}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	setup_cas_menu_handlers \{vmenu_id = create_cadrm_main_vmenu
		zoom_camera = 'cadrm_zoom'
		camera_list = [
			'cadrm_main'
			'cad_select_skin'
			'cad_select_shell'
		]}
	add_generic_menu_text_item {
		text = qs("CUSTOMIZE")
		choose_state = UIstate_cadrm_hub
		choose_state_data = {instrument_info = <instrument_info>}
	}
	dim_save_option_for_guest <...>
	add_generic_menu_text_item {
		text = qs("SAVE")
		choose_state = UIstate_cas_save_slots
		choose_state_data = {savegame = ($cas_current_savegame) text = qs("SAVE DRUM KIT") slot_list = player_drum_save instrument_info = <instrument_info> save_guitar loaded_index = <loaded_index> hist_tex = icon_save}
		not_focusable = <not_focusable>
	}
	add_generic_menu_text_item {
		text = qs("LOAD")
		choose_state = UIstate_cas_save_slots
		choose_state_data = {savegame = ($cas_current_savegame) text = qs("LOAD DRUM KIT") slot_list = player_drum_save instrument_info = <instrument_info> load_drum hist_tex = icon_load}
		not_focusable = <not_focusable>
	}
	add_generic_menu_text_item \{text = qs("RANDOM")
		pad_choose_script = generate_random_instrument
		pad_choose_params = {
			type = drum
			rebuild
		}
		pad_choose_sound = nullscript}

	if GetCurrentCASObject
		BandManager_ChangeStance name = <cas_object> stance = Stance_Select_Drum no_wait
		<cas_object> :Anim_Command target = moment_blend command = PartialSwitch_SetState params = {on BlendDuration = 0.0}
		<cas_object> :Anim_Command target = moment_blend_inner command = PartialSwitch_SetState params = {off BlendDuration = 0.0}
	endif
	LaunchEvent \{type = focus
		target = create_cadrm_main_vmenu}
	menu_finish \{car_helper_text}
	draw_guitar_center_logo
endscript

script ui_destroy_cadrm_main 
	KillSpawnedScript \{name = ui_create_cadrm_main_spawned}
	if is_female_char
		if GetCurrentCASObject
		endif
	endif
	destroy_generic_menu
endscript

script ui_init_cadrm_main 
	change_cas_instrument_if_necessary instrument = (<instrument_info>.instrument_name)
	load_part_desc_pak_list part_list = ($instrument_part_sets.drum)
	GetArraySize <parts_loaded>
	if (<array_size> > 0)
		ui_event_add_params part_unload_list = <parts_loaded>
	endif
endscript

script ui_deinit_cadrm_main 
	if GotParam \{part_unload_list}
		unload_part_desc_pak_list part_list = <part_unload_list>
	endif
endscript

script cadrm_exit_save 
	globaltag_getarraychecksum savegame = ($cas_current_savegame) array_name = player_drum_save
	if NOT (<old_save_checksum> = <array_checksum>)
		cas_get_player_status
		if CheckForSignIn local controller_index = ($<player_status>.controller)
			ui_memcard_autosave event = menu_back data = {num_states = 2 savegame = ($cas_current_savegame)}
		else
			generic_event_back
		endif
	else
		generic_event_back
	endif
endscript
