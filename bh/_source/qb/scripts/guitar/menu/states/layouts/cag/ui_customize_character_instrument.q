
script ui_create_customize_character_instrument 
	spawnscriptnow \{change_cas_to_guitar}
	spawnscriptnow ui_create_customize_character_instrument_spawned params = {<...>}
endscript

script ui_create_customize_character_instrument_spawned 
	OnExitRun \{InputHandlerPermit}
	InputHandlerForbid
	change \{rich_presence_context = presence_band_logo_edit_and_instrument_edit}
	CASBlockForLoading
	CASWaitForComposite
	cas_queue_wait
	make_generic_menu \{vmenu_id = create_customize_character_instrument_vmenu
		title = qs("EDIT INSTRUMENTS")
		num_icons = 1
		show_history
		cai_bg = 1}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	setup_cas_menu_handlers \{vmenu_id = create_customize_character_instrument_vmenu
		no_rotate = 1
		no_zoom}
	change \{cas_current_instrument = none}
	get_frontend_venue_player_start_checksums
	cas_set_object_node_pos player = ($cas_current_player) node = <Drum_Start>
	i = 0
	begin
	add_generic_menu_text_item {
		text = ((($cag_instruments) [<i>]).text)
		choose_state = UIstate_cag_main
		choose_state_data = {instrument_info = (($cag_instruments) [<i>]) hist_tex = ((($cag_instruments) [<i>]).icon)}
	}
	i = (<i> + 1)
	repeat 2
	add_generic_menu_text_item {
		text = qs("DRUMS")
		choose_state = UIstate_cadrm_main
		choose_state_data = {instrument_info = (($cag_instruments) [2])}
	}
	add_generic_menu_text_item {
		text = qs("MIC")
		choose_state = UIstate_customize_character_mic
		choose_state_data = {instrument_info = (($cag_instruments) [3])}
	}
	menu_finish \{car_helper_text
		no_rotate_text
		no_zoom_text}

	if GetCurrentCASObject
		BandManager_ChangeStance name = <cas_object> stance = stance_frontend no_wait
	endif
	LaunchEvent type = focus target = create_customize_character_instrument_vmenu data = {child_index = <selected_index>}
	draw_guitar_center_logo
endscript

script ui_destroy_customize_character_instrument 
	KillSpawnedScript \{name = ui_create_customize_character_instrument_spawned}
	destroy_generic_menu
endscript

script ui_init_customize_character_instrument 
endscript

script ui_deinit_customize_character_instrument 
endscript

script change_cas_instrument_if_necessary 
	if NOT ($cas_current_instrument = <instrument>)
		get_frontend_venue_player_start_checksums
		cas_set_object_node_pos player = ($cas_current_player) node = <Drum_Start>
		if GetCurrentCASObject
			<cas_object> :hide
		endif
		if NOT (<instrument> = none)
		endif
		change cas_current_instrument = <instrument>
		RebuildCurrentCASModel instrument = <instrument>
	endif
endscript
