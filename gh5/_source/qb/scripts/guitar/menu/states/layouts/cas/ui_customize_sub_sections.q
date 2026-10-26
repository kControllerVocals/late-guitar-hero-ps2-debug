CAS_Temp_Parts = [
]

script ui_create_customize_character_sub_sections 
	draw_gc_logo = false
	switch (<part>)
		case CAS_Torso_Art
		icon = BodyArt_Chest
		cam_name = 'customize_tat_torso'
		sections = CAS_Body_Art_Sections
		scroll_thumb_new_offset = 100
		case CAS_Right_Arm_Art
		icon = BodyArt_RightArm
		cam_name = 'customize_tat_right_arm'
		sections = CAS_Body_Art_Sections
		scroll_thumb_new_offset = 100
		case CAS_Left_Arm_Art
		icon = BodyArt_LeftArm
		cam_name = 'customize_tat_left_arm'
		sections = CAS_Body_Art_Sections
		scroll_thumb_new_offset = 100
		case CAS_Drum_Detail
		icon = icon_cadrm_skin
		cam_name = 'cad_select_skin'
		sections = CAS_Drum_Skin_Sections
		inclusion_part = CAS_Drums
		if GetCurrentCASObject
			<cas_object> :Anim_Command target = moment_blend command = PartialSwitch_SetState params = {on BlendDuration = 0.0}
			<cas_object> :Anim_Command target = moment_blend_inner command = PartialSwitch_SetState params = {off BlendDuration = 0.0}
		endif
		draw_gc_logo = true
		smaller_menu = 1
		case CAS_Drum_Finish
		icon = icon_cadrm_shell
		cam_name = 'cad_select_shell'
		sections = CAS_Drum_Shell_Sections
		inclusion_part = CAS_Drums
		if GetCurrentCASObject
			<cas_object> :Anim_Command target = moment_blend command = PartialSwitch_SetState params = {on BlendDuration = 0.0}
			<cas_object> :Anim_Command target = moment_blend_inner command = PartialSwitch_SetState params = {off BlendDuration = 0.0}
		endif
		draw_gc_logo = true
	endswitch
	if NOT GotParam \{smaller_menu}
		make_generic_menu {
			vmenu_id = create_customize_character_body_art_vmenu
			title = <text>
			num_icons = 2
			show_history
		}
	else
		make_generic_menu {
			vmenu_id = create_customize_character_body_art_vmenu
			title = <text>
			num_icons = 2
			show_history
			smaller_menu
		}
	endif
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	setup_cas_menu_handlers vmenu_id = create_customize_character_body_art_vmenu camera_list = <camera_list> zoom_camera = <zoom_camera> no_rotate = <no_rotate> no_zoom = <no_zoom> pull_back_distance = <pull_back_distance>
	GetArraySize ($<sections>)
	i = 0
	begin
	show_set = 1
	if GotParam \{inclusion_part}
		ui_customize_character_sub_sections_get_included_count part = <part> parts_list = ($<sections> [<i>].parts) inclusion_part = <inclusion_part>
		if (<included_count> < 2)
			show_set = 0
		endif
	endif
	if (<show_set> = 1)
		add_generic_menu_text_item {
			text = ($<sections> [<i>].text)
			pad_choose_script = ui_select_object_subset_and_continue
			pad_choose_params = {<...> parts_list = ($<sections> [<i>].parts) inclusion_part = <inclusion_part>}
		}
	endif
	i = (<i> + 1)
	repeat <array_size>
	menu_finish \{car_helper_text}
	if (<draw_gc_logo> = true)
		draw_guitar_center_logo
	endif
	if GotParam \{stance}
		GetCurrentCASObject
		if (Stance_Select_Drum = <stance>)
			<cas_object> :Anim_Command target = moment_blend command = PartialSwitch_SetState params = {on BlendDuration = 0.0}
			<cas_object> :Anim_Command target = moment_blend_inner command = PartialSwitch_SetState params = {off BlendDuration = 0.0}
			debug_Printf \{qs(0xf57f774b)}
		endif
	endif
	LaunchEvent type = focus target = create_customize_character_body_art_vmenu data = {child_index = <selected_index>}
endscript

script ui_destroy_customize_character_sub_sections 
	GetCurrentCASObject
	if GotParam \{return_stance}
		BandManager_ChangeStance name = <cas_object> stance = <return_stance> no_wait
	else
		BandManager_ChangeStance name = <cas_object> stance = stance_frontend no_wait
	endif
	destroy_generic_menu
endscript

script ui_select_object_subset_and_continue 
	change \{CAS_Temp_Parts = [
		]}
	GetArraySize (<parts_list>)
	i = 0
	begin
	temp_desc = (<parts_list> [<i>])
	GetActualCASOptionStruct part = <part> desc_id = <temp_desc>
	temp_struct = {desc_id = <temp_desc> frontend_desc = <frontend_desc>}
	if GotParam \{materials}
		temp_struct = {<temp_struct> materials = <materials>}
	endif
	if GotParam \{hidden}
		temp_struct = {<temp_struct> hidden}
	endif
	if GotParam \{inclusion_part}
		get_inclusion_list body_part = <inclusion_part>
		if cas_in_inclusion_list inclusion = <inclusion> part_name = <part> part_desc_id = <temp_desc>
			AddArrayElement array = ($CAS_Temp_Parts) element = <temp_struct>
			change CAS_Temp_Parts = <array>
		endif
	else
		AddArrayElement array = ($CAS_Temp_Parts) element = <temp_struct>
		change CAS_Temp_Parts = <array>
	endif
	i = (<i> + 1)
	repeat (<array_size>)
	ui_event event = menu_change data = {state = UIstate_popout_select_part text = <text> cam_name = <cam_name> part = CAS_Temp_Parts surrogate_part = <part> num_icons = 2 is_popup icon_offset = (50.0, 120.0) list_offset = (50.0, 155.0) color_wheel = ($clothing_colorwheel) stance = <stance> return_stance = <stance> camera_list = <camera_list> zoom_camera = <zoom_camera> no_rotate = <no_rotate> no_zoom = <no_zoom> pull_back_distance = <pull_back_distance> play_current_anim = <play_current_anim>}
endscript

script ui_init_customize_character_sub_sections 
	if GotParam \{additional_init_script}
		<additional_init_script>
	endif
	if GotParam \{stance}
		GetCurrentCASObject
		BandManager_ChangeStance name = <cas_object> stance = <stance> no_wait
		if (Stance_Select_Drum = <stance>)
			<cas_object> :Anim_Command target = moment_blend command = PartialSwitch_SetState params = {on BlendDuration = 0.0}
			<cas_object> :Anim_Command target = moment_blend_inner command = PartialSwitch_SetState params = {off BlendDuration = 0.0}
		endif
	endif
	if GotParam \{cam_name}
		spawnscriptnow ui_customize_character_sub_sections_animate_cam_in params = {<...>}
	endif
	if NOT GotParam \{surrogate_part}
		ResolveBodySpecificPartInAppearance part = <part>
		surrogate_part = <part>
	endif
	if NOT load_part_desc_pak part_type = <surrogate_part>
		ui_event_add_params unload_desc_pak_type = <surrogate_part>
	endif
endscript

script ui_deinit_customize_character_sub_sections 
	if GotParam \{additional_deinit_script}
		<additional_deinit_script>
	endif
	GetCurrentCASObject
	if GotParam \{return_stance}
		BandManager_ChangeStance name = <cas_object> stance = <return_stance> no_wait
	else
		BandManager_ChangeStance name = <cas_object> stance = stance_frontend no_wait
	endif
	if GotParam \{unload_desc_pak_type}
		unload_part_desc_pak part_type = <unload_desc_pak_type>
	endif
endscript

script ui_return_customize_character_sub_sections 
	menu_finish \{car_helper_text}
endscript

script ui_customize_character_sub_sections_get_included_count 
	GetArraySize (<parts_list>)
	included_count = 0
	i = 0
	begin
	temp_desc = (<parts_list> [<i>])
	get_inclusion_list body_part = <inclusion_part>
	if cas_in_inclusion_list inclusion = <inclusion> part_name = <part> part_desc_id = <temp_desc>
		included_count = (<included_count> + 1)
	endif
	i = (<i> + 1)
	repeat (<array_size>)
	return included_count = <included_count>
endscript

script ui_customize_character_sub_sections_animate_cam_in 
	change \{generic_menu_block_input = 1}
	task_menu_default_anim_in base_name = <cam_name>
	change \{generic_menu_block_input = 0}
endscript
