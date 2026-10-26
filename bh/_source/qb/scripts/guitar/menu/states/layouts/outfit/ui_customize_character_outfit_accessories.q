
script ui_create_customize_character_outfit_accessories 
	make_generic_menu \{back_state = UIstate_cas
		vmenu_id = create_customize_character_outfit_accessories_vmenu
		title = qs("ACCESSORIES")
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
	setup_cas_menu_handlers \{vmenu_id = create_customize_character_outfit_accessories_vmenu
		camera_list = [
			'customize_character'
			'customize_character_R'
			'customize_character_B'
			'customize_character_L'
		]
		zoom_camera = 'customize_character_Zoom'}
	add_generic_menu_text_item {
		text = qs("FACE")
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			text = qs("CHOOSE FACE ACCESSORY")
			cam_name = 'customize_face'
			camera_list = ['customize_face' 'customize_character_hair_R' 'customize_character_hair_B' 'customize_character_hair_L']
			zoom_camera = 'customize_character_Zoom'
			part = CAS_Acc_Face
			stance = Stance_Select_Head
			is_popup
			hist_tex = icon_face_acc
			color_wheel = ($clothing_colorwheel)
			purchase_menu
			stance = Stance_Select_Glasses
		}
	}
	add_generic_menu_text_item {
		text = qs("HAT")
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			text = qs("CHOOSE HAT")
			cam_name = 'customize_hat'
			camera_list = ['customize_hat' 'customize_character_hair_R' 'customize_character_hair_B' 'customize_character_hair_L']
			zoom_camera = 'customize_character_Zoom'
			part = CAS_Hat
			hist_tex = AccessoriesHat
			stance = Stance_Select_Head
			is_popup
			color_wheel = ($clothing_colorwheel)
			purchase_menu
			stance = Stance_Select_Hat
		}
	}
	add_generic_menu_text_item {
		text = qs("LEFT ARM")
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			text = qs("CHOOSE LEFT ARM ACCESSORY")
			cam_name = 'customize_left_arm'
			camera_list = ['customize_left_arm' 'customize_left_arm_R' 'customize_left_arm_B' 'customize_left_arm_L']
			zoom_camera = 'customize_character_Zoom'
			part = CAS_Acc_Left
			hist_tex = AccessoriesLeftArm
			stance = Stance_Select_Arm_L
			is_popup
			color_wheel = ($clothing_colorwheel)
			purchase_menu
			stance = Stance_Select_Arm_L
			additional_init_script = hide_car_parts_accessories
			additional_deinit_script = unhide_car_parts_accessories
		}
	}
	acc_right_state = UIstate_popout_select_part
	part = CAS_Acc_Right
	if NOT (is_female_char)
		acc_right_state = UIstate_cag_select_part_inclusion
		body_part = CAS_Male_Torso
		part = CAS_Male_Acc_Right
	endif
	add_generic_menu_text_item {
		text = qs("RIGHT ARM")
		choose_state = <acc_right_state>
		choose_state_data = {
			text = qs("CHOOSE RIGHT ARM ACCESSORY")
			cam_name = 'customize_right_arm'
			camera_list = ['customize_right_arm' 'customize_right_arm_R' 'customize_right_arm_L']
			zoom_camera = 'customize_character_Zoom'
			part = <part>
			body_part = <body_part>
			hist_tex = AccessoriesRightArm
			is_popup
			color_wheel = ($clothing_colorwheel)
			purchase_menu
			stance = Stance_Select_Arm_R
			initial_stance = Stance_Select_Arm_R
			additional_init_script = hide_car_parts_accessories
			additional_deinit_script = unhide_car_parts_accessories
		}
	}
	add_generic_menu_text_item {
		text = qs("PIERCINGS")
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			hist_tex = icon_face_piercing
			cam_name = 'customize_character_head'
			camera_list = ['customize_character_head' 'customize_character_head_R' 'customize_character_head_B' 'customize_character_head_L']
			zoom_camera = 'customize_character_Zoom'
			part = CAS_Acc_Ears
			stance = Stance_Select_Head
			is_popup
			color_wheel = ($clothing_colorwheel)
			purchase_menu
			stance = Stance_Select_Head
			additional_init_script = hide_car_parts_piercings
			additional_deinit_script = unhide_car_parts_piercings
		}
	}
	if GetCurrentCASObject
		BandManager_ChangeStance name = <cas_object> stance = stance_frontend no_wait
	endif
	menu_finish \{car_helper_text}
endscript

script ui_return_customize_character_outfit_accessories 
	menu_finish \{car_helper_text}
endscript

script ui_destroy_customize_character_outfit_accessories 
	destroy_generic_menu
endscript

script hide_car_parts_accessories 
	PushTemporaryCASAppearance
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

script unhide_car_parts_accessories 
	MergePartIntoTemporaryCASAppearance \{part_list = [
			CAS_Acc_Left
			CAS_Acc_Right
		]}
endscript

script hide_car_parts_piercings 
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

script unhide_car_parts_piercings 
	MergePartIntoTemporaryCASAppearance \{part_list = [
			CAS_Acc_Ears
		]}
endscript
