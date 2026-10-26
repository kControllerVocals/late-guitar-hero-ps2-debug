
script ui_create_customize_character_body_art 
	make_generic_menu \{vmenu_id = create_customize_character_body_art_vmenu
		title = qs("TATTOOS")
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
	setup_cas_menu_handlers \{vmenu_id = create_customize_character_body_art_vmenu
		camera_list = [
			'customize_tat_torso'
			'customize_tat_torso_R'
			'customize_tat_torso_B'
			'customize_tat_torso_L'
		]
		zoom_camera = 'customize_tat_torso_zoom'}
	add_generic_menu_text_item \{text = qs("Torso")
		choose_state = UIstate_customize_character_sub_sections
		choose_state_data = {
			text = qs("TORSO TATTOO")
			cam_name = 'customize_tat_torso'
			part = CAS_Torso_Art
			stance = Stance_Select_Tat_Chest
			choose_script = ui_event
			choose_params = {
				event = menu_back
			}
			num_icons = 2
			camera_list = [
				'customize_tat_torso'
				'customize_tat_torso_R'
				'customize_tat_torso_B'
				'customize_tat_torso_L'
			]
			zoom_camera = 'customize_character_Zoom'
		}}
	add_generic_menu_text_item \{text = qs("Right Arm")
		choose_state = UIstate_customize_character_sub_sections
		choose_state_data = {
			text = qs("RIGHT ARM")
			cam_name = 'customize_tat_right_arm'
			part = CAS_Right_Arm_Art
			stance = Stance_Select_Tat_Arm_R
			choose_script = ui_event
			choose_params = {
				event = menu_back
			}
			num_icons = 2
			camera_list = [
				'customize_tat_right_arm'
				'customize_tat_right_arm_R'
				'customize_tat_right_arm_L'
			]
			zoom_camera = 'customize_character_Zoom'
		}}
	add_generic_menu_text_item \{text = qs("Left Arm")
		choose_state = UIstate_customize_character_sub_sections
		choose_state_data = {
			text = qs("LEFT ARM")
			cam_name = 'customize_tat_left_arm'
			part = CAS_Left_Arm_Art
			stance = Stance_Select_Tat_Arm_L
			choose_script = ui_event
			choose_params = {
				event = menu_back
			}
			num_icons = 2
			camera_list = [
				'customize_tat_left_arm'
				'customize_tat_left_arm_R'
				'customize_tat_left_arm_L'
			]
			zoom_camera = 'customize_character_Zoom'
		}}
	menu_finish \{car_helper_text}
	LaunchEvent type = focus target = create_customize_character_body_art_vmenu data = {child_index = <selected_index>}
endscript

script ui_destroy_customize_character_body_art 
	destroy_generic_menu
endscript

script hide_torso_parts_for_body_art 
	PushTemporaryCASAppearance
	SetCASAppearancePartInstance \{part = CAS_Acc_Left
		part_instance = {
			desc_id = none
		}}
	SetCASAppearancePartInstance \{part = CAS_Acc_Right
		part_instance = {
			desc_id = none
		}}
	if is_female_char
		SetCASAppearancePartInstance \{part = CAS_Torso
			part_instance = {
				desc_id = F_Fun_Torso_BikiniTop
			}}
	else
		SetCASAppearancePartInstance \{part = CAS_Torso
			part_instance = {
				desc_id = none
			}}
	endif
	RebuildCurrentCASModel
endscript

script unhide_torso_parts_for_body_art 
	MergePartIntoTemporaryCASAppearance \{part_list = [
			CAS_Body
			CAS_Right_Arm_Art
			CAS_Left_Arm_Art
			CAS_Torso_Art
		]}
endscript

script ui_init_customize_character_body_art 
	spawnscriptnow \{hide_torso_parts_for_body_art}
endscript

script ui_deinit_customize_character_body_art 
	ForceCASReload
	spawnscriptnow \{unhide_torso_parts_for_body_art}
endscript
