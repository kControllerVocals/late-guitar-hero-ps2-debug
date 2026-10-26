
script ui_create_customize_character_head 
	make_generic_menu \{vmenu_id = customize_head_vmenu
		back_state = UIstate_cas
		title = qs("HEAD")
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
	setup_cas_menu_handlers \{vmenu_id = customize_head_vmenu
		camera_list = [
			'customize_character_head'
			'customize_character_head_R'
			'customize_character_head_B'
			'customize_character_head_L'
		]
		zoom_camera = 'customize_character_Zoom'}
	add_generic_menu_text_item \{text = qs("FACE")
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			text = qs(0xbae5b37d)
			part = CAS_Base_Torso
			num_icons = 2
			is_popup
			return_stance = Stance_Select_Head
			camera_list = [
				'customize_character_head'
				'customize_character_head_R'
				'customize_character_head_B'
				'customize_character_head_L'
			]
			zoom_camera = 'customize_character_Zoom'
		}}
	if NOT (is_female_char)
		add_generic_menu_text_item \{text = qs("FACIAL HAIR")
			choose_state = UIstate_popout_select_part
			choose_state_data = {
				text = qs("Select Facial Hair Style")
				part = CAS_Male_Facial_Hair
				num_icons = 2
				is_popup
				hist_tex = icon_facial_hair
				return_stance = Stance_Select_Head
				camera_list = [
					'customize_character_head'
					'customize_character_head_R'
					'customize_character_head_B'
					'customize_character_head_L'
				]
				zoom_camera = 'customize_character_Zoom'
			}}
	endif
	if (is_female_char)
		add_generic_menu_text_item \{text = qs("EYE MAKEUP")
			choose_state = UIstate_popout_select_part
			choose_state_data = {
				text = qs("EYE MAKEUP")
				part = CAS_Eye_Makeup
				num_icons = 2
				is_popup
				additional_deinit_script = unhide_car_parts_for_face_paint
				additional_init_script = hide_car_parts_for_face_paint
				hist_tex = icon_makeup
				return_stance = Stance_Select_Head
				camera_list = [
					'customize_character_head'
					'customize_character_head_R'
					'customize_character_head_B'
					'customize_character_head_L'
				]
				zoom_camera = 'customize_character_Zoom'
			}}
		add_generic_menu_text_item \{text = qs("LIP MAKEUP")
			choose_state = UIstate_popout_select_part
			choose_state_data = {
				text = qs("LIP MAKEUP")
				part = CAS_Lip_Makeup
				num_icons = 2
				is_popup
				additional_deinit_script = unhide_car_parts_for_face_paint
				additional_init_script = hide_car_parts_for_face_paint
				hist_tex = icon_lips
				return_stance = Stance_Select_Head
				camera_list = [
					'customize_character_head'
					'customize_character_head_R'
					'customize_character_head_B'
					'customize_character_head_L'
				]
				zoom_camera = 'customize_character_Zoom'
			}}
	endif
	GetCurrentCASObject
	if GotParam \{cas_object}
		BandManager_ChangeStance name = <cas_object> stance = Stance_Select_Head no_wait
	endif
	menu_finish \{car_helper_text}
endscript

script ui_return_customize_character_head 
	menu_finish \{car_helper_text}
endscript

script ui_destroy_customize_character_head 
	destroy_generic_menu
endscript

script ui_init_customize_character_head 
	ui_load_cas_rawpak \{part = CAS_Body}
endscript

script hide_car_parts_for_face_paint 
	PushTemporaryCASAppearance
	SetCASAppearancePartInstance \{part = CAS_Hair
		part_instance = {
			desc_id = none
		}}
	SetCASAppearancePartInstance \{part = CAS_Hat_Hair
		part_instance = {
			desc_id = none
		}}
	SetCASAppearancePartInstance \{part = CAS_Hat
		part_instance = {
			desc_id = none
		}}
	SetCASAppearancePartInstance \{part = CAS_Acc_Face
		part_instance = {
			desc_id = none
		}}
	RebuildCurrentCASModel
endscript

script unhide_car_parts_for_face_paint 
	MergePartIntoTemporaryCASAppearance \{part_list = [
			CAS_Body
			CAS_Eye_Makeup
			CAS_Lip_Makeup
		]}
endscript
