
script ui_create_customize_character_outfit 
	make_generic_menu \{vmenu_id = create_customize_character_outfit_vmenu
		title = qs("OUTFIT")
		num_icons = 1
		show_history}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	get_frontend_venue_player_start_checksums
	cas_set_object_node_pos player = ($cas_current_player) node = <Drum_Start>
	setup_cas_menu_handlers \{vmenu_id = create_customize_character_outfit_vmenu
		camera_list = [
			'customize_character_outfit'
			'customize_character_R'
			'customize_character_B'
			'customize_character_L'
		]
		zoom_camera = 'customize_character_Zoom'}
	add_generic_menu_text_item {
		text = qs("TORSO")
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			text = qs("SELECT TOP")
			cam_name = 'customize_torso'
			camera_list = ['customize_torso' 'customize_torso_R' 'customize_torso_B' 'customize_torso_L']
			zoom_camera = 'customize_torso_zoom'
			part = CAS_Torso
			purchase_menu
			num_icons = 2
			hist_tex = Outfit_Torso
			is_popup
			icon_offset = (0.0, 20.0)
			list_offset = (0.0, 55.0)
			color_wheel = ($clothing_colorwheel)
			stance = Stance_Select_Torso}
	}
	add_generic_menu_text_item {
		text = qs("PANTS")
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			text = qs("SELECT PANTS")
			cam_name = 'customize_pants'
			camera_list = ['customize_pants' 'customize_pants_R' 'customize_pants_B' 'customize_pants_L']
			zoom_camera = 'customize_character_Zoom'
			part = CAS_Legs
			purchase_menu
			num_icons = 2
			hist_tex = pants
			is_popup
			color_wheel = ($clothing_colorwheel)
			stance = Stance_Select_Pants}
	}
	add_generic_menu_text_item {
		text = qs("SHOES")
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			text = qs("SELECT SHOES")
			cam_name = 'customize_shoes'
			camera_list = ['customize_shoes' 'customize_shoes_R' 'customize_shoes_B' 'customize_shoes_L']
			zoom_camera = 'customize_character_Zoom'
			part = CAS_Shoes
			purchase_menu
			num_icons = 2
			hist_tex = shoes
			is_popup
			color_wheel = ($clothing_colorwheel)
			stance = Stance_Select_Shoes}
	}
	add_generic_menu_text_item \{text = qs("ACCESSORIES")
		choose_state = UIstate_customize_character_outfit_accessories}
	menu_finish \{car_helper_text}
	GetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue param = visit_outfit
	if (<visit_outfit> = 0)
		SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {visit_outfit = 1}
		create_customize_character_outfit_vmenu :obj_spawnscript \{ui_customize_character_outfit_popup}
	endif
endscript

script ui_return_customize_character_outfit 
	create_customize_character_outfit_vmenu :SE_SetProps \{unblock_events}
	clean_up_user_control_helpers
	menu_finish \{car_helper_text}
endscript

script ui_customize_character_outfit_popup 
endscript

script ui_destroy_customize_character_outfit 
	destroy_generic_menu
endscript

script ui_init_customize_character_outfit 
	load_part_desc_pak_list part_list = ($part_def_clusters.ui_customize_character_outfit)
	GetArraySize <parts_loaded>
	if (<array_size> > 0)
		ui_event_add_params part_unload_list = <parts_loaded>
	endif
endscript

script ui_deinit_customize_character_outfit 
	if GotParam \{part_unload_list}
		unload_part_desc_pak_list part_list = <part_unload_list>
	endif
endscript
