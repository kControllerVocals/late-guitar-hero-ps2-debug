
script ui_create_customize_character_mic_main 
	make_generic_menu \{vmenu_id = create_customize_character_mic_vmenu
		title = qs("CHOOSE MIC")
		show_history
		hist_tex = icon_customize
		cai_bg = 1}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	setup_cas_menu_handlers \{vmenu_id = create_customize_character_mic_vmenu
		camera_list = [
			'customize_character_mic'
			'customize_character_mic_R'
			'customize_character_mic_B'
			'customize_character_mic_L'
		]
		zoom_camera = 'customize_mic_Zoom'}
	add_generic_menu_text_item \{text = qs("MIC")
		pad_choose_script = mic_wait_before_popout
		pad_choose_params = {
			choose_state = UIstate_popout_select_part
			choose_state_data = {
				text = qs("MIC")
				part = CAS_Mic
				hist_tex = icon_mic
				is_popup
				cam_name = 'customize_microphone'
				camera_list = [
					'customize_microphone_F'
					'customize_microphone_R'
					'customize_microphone_B'
					'customize_microphone_L'
				]
				zoom_camera = 'customize_mic_Zoom'
				stance = Stance_Select_Microphone
				return_stance = Stance_Select_Mic
			}
		}}
	add_generic_menu_text_item \{text = qs("MIC STAND")
		pad_choose_script = mic_wait_before_popout
		pad_choose_params = {
			choose_state = UIstate_popout_select_part
			choose_state_data = {
				text = qs("MIC STAND")
				part = CAS_Mic_Stand
				hist_tex = icon_mic_stand
				is_popup
				cam_name = 'customize_character_mic'
				camera_list = [
					'customize_character_mic'
					'customize_character_mic_R'
					'customize_character_mic_B'
					'customize_character_mic_L'
				]
				zoom_camera = 'customize_mic_Zoom'
				stance = Stance_Select_Mic
				return_stance = Stance_Select_Mic
			}
		}}
	menu_finish \{car_helper_text}
	GetCurrentCASObject

	BandManager_ChangeStance name = <cas_object> stance = Stance_Select_Mic no_wait
	LaunchEvent type = focus target = create_customize_character_mic_vmenu data = {child_index = <selected_index>}
	draw_guitar_center_logo
endscript

script mic_wait_before_popout 
	LaunchEvent \{type = unfocus
		target = create_customize_character_mic_vmenu}
	cas_queue_wait
	ui_event_block event = menu_change data = {state = <choose_state> <choose_state_data> container_id = <id>}
endscript

script ui_destroy_customize_character_mic_main 
	destroy_generic_menu
endscript

script ui_return_customize_character_mic_main 
	menu_finish \{car_helper_text}
endscript
