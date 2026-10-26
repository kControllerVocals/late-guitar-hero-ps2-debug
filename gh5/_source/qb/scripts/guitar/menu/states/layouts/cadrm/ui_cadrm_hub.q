
script ui_create_cadrm_hub 
	if GetCurrentCASObject
		<cas_object> :Anim_Command target = moment_blend command = PartialSwitch_SetState params = {on BlendDuration = 0.0}
		<cas_object> :Anim_Command target = moment_blend_inner command = PartialSwitch_SetState params = {off BlendDuration = 0.0}
	endif
	part = (<instrument_info>.body_part)
	make_generic_menu \{vmenu_id = create_cadrm_hub_vmenu
		title = qs(0xaba204d3)
		show_history}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	setup_cas_menu_handlers \{vmenu_id = create_cadrm_hub_vmenu
		zoom_camera = 'cadrm_zoom'
		camera_list = [
			'cadrm_main'
			'cadrm_main_R'
			'cadrm_main'
			'cadrm_main_L'
		]}
	add_generic_menu_text_item {
		text = qs("SIZE")
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			part = <part>
			text = qs("CHOOSE DRUM SET SIZE")
			cam_name = 'cad_select_size'
			choose_script = nullscript
			hist_tex = icon_cadrm_size is_popup
			color_wheel = ($guitar_colorwheel)
			return_stance = Stance_Select_Drum
			purchase_menu
			camera_list = ['cad_select_size' 'cadrm_main_R' 'cadrm_main' 'cadrm_main_L']
			zoom_camera = 'cadrm_zoom'
		}
	}
	add_generic_menu_text_item \{text = qs("SHELL")
		choose_state = UIstate_customize_character_sub_sections
		choose_state_data = {
			text = qs("SHELL")
			cam_name = 'cad_select_shell'
			part = CAS_Drum_Finish
			choose_script = ui_event
			choose_params = {
				event = menu_back
			}
			num_icons = 2
			stance = Stance_Select_Drum
			return_stance = Stance_Select_Drum
			zoom_camera = 'cadrm_zoom'
			camera_list = [
				'cad_select_shell'
				'cad_select_skin'
			]
		}}
	add_generic_menu_text_item \{text = qs("SKIN")
		choose_state = UIstate_customize_character_sub_sections
		choose_state_data = {
			text = qs("SKIN")
			cam_name = 'cad_select_skin'
			part = CAS_Drum_Detail
			choose_script = ui_event
			choose_params = {
				event = menu_back
			}
			num_icons = 2
			stance = Stance_Select_Drum
			return_stance = Stance_Select_Drum
			zoom_camera = 'cadrm_zoom'
			camera_list = [
				'cad_select_skin'
				'cadrm_skin_L'
				'cadrm_skin_R'
			]
		}}
	if is_part_capable part = <part>
		add_generic_menu_text_item {
			text = qs("GRAPHICS")
			choose_state = UIstate_cap_main
			choose_state_data = {savegame = ($cas_current_savegame) part = <part> text = qs("GRAPHICS") cam_name = 'cad_select_skin' hist_tex = icon_graphics color_wheel = ($guitar_colorwheel) return_stance = Stance_Select_Drum zoom_camera = 'cadrm_main' camera_list = ['cad_select_skin' 'cadrm_skin_R' 'cad_select_skin' 'cadrm_skin_L']}
		}
	endif
	add_generic_menu_text_item {
		text = qs("STICKS")
		choose_state = UIstate_popout_select_part
		choose_state_data = {text = qs("CHOOSE DRUM STICKS") purchase_menu cam_name = 'cad_select_drumsticks' part = CAS_Drums_Sticks is_popup hist_tex = icon_sticks color_wheel = ($guitar_colorwheel) stance = Stance_Select_DrumSticks return_stance = Stance_Select_Drum zoom_camera = 'cadrm_main' camera_list = ['cad_select_drumsticks' 'cad_select_drumsticks_R' 'cad_select_drumsticks' 'cad_select_drumsticks_L']}
	}
	GetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue param = visit_cadrm
	if (<visit_cadrm> = 0)
		SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {visit_cadrm = 1}
		ui_event_wait \{event = menu_change
			data = {
				state = UIstate_helper_dialogue
				is_popup
				life = 30
				text = qs("The CUSTOMIZE option allows you to build a custom drum kit. Changing the SIZE of the drum kit will undo any SHELL and SKIN changes that you make.")
			}}
	endif
	menu_finish \{car_helper_text}
	draw_guitar_center_logo
endscript

script ui_return_cadrm_hub 
	if GetCurrentCASObject
		<cas_object> :Anim_Command target = moment_blend command = PartialSwitch_SetState params = {on BlendDuration = 0.0}
		<cas_object> :Anim_Command target = moment_blend_inner command = PartialSwitch_SetState params = {off BlendDuration = 0.0}
	endif
	clean_up_user_control_helpers
	menu_finish \{car_helper_text}
endscript

script ui_destroy_cadrm_hub 
	destroy_generic_menu
endscript
