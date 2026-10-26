
script ui_create_customize_character_body 
	make_generic_menu \{vmenu_id = customize_body_vmenu
		back_state = UIstate_customize_character_appearance
		title = qs("BODY")
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
	setup_cas_menu_handlers \{vmenu_id = customize_body_vmenu
		camera_list = [
			'customize_character'
			'customize_character_R'
			'customize_character_B'
			'customize_character_L'
		]
		zoom_camera = 'customize_character_Zoom'}
	add_generic_menu_text_item {
		text = qs("SKIN TONE")
		choose_state = UIstate_cas_color_edit
		choose_state_data = {
			text = qs("SKIN TONE")
			part = CAS_Body
			camera_list = ['customize_character_outfit' 'customize_character_R' 'customize_character_B' 'customize_character_L']
			zoom_camera = 'customize_character_Zoom'
			part_materials = [skin]
			num_states = 1
			num_icons = 1
			hist_tex = SkinTone
			color_wheel = ($skin_colorwheel)
		}
	}
	add_generic_menu_text_item \{text = qs("PROPORTIONS")
		choose_state = UIstate_customize_character_proportions}
	add_generic_menu_text_item \{text = qs("TATTOOS")
		choose_state = UIstate_customize_character_body_art}
	menu_finish \{car_helper_text}
endscript

script ui_destroy_customize_character_body 
	destroy_generic_menu
endscript
