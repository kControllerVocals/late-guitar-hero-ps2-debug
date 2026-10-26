
script ui_create_cag_custom_head 
	make_generic_menu \{vmenu_id = create_cag_custom_head_id
		show_history
		title = qs("Change Head")}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	setup_cas_menu_handlers \{vmenu_id = create_cag_custom_head_id
		camera_list = [
			'cag_custom_head'
			'cag_custom_head_R'
			'cag_custom_head_B'
			'cag_custom_head_L'
		]
		zoom_camera = 'cag_custom_head_Zoom'}
	add_generic_menu_text_item {
		text = qs("STYLE")
		choose_state = UIstate_cag_select_part_inclusion
		choose_state_data = {
			part = <part>
			body_part = <body_part>
			text = qs("CHOOSE HEAD")
			is_popup
			hist_tex = icon_cag_head_type
			color_wheel = ($guitar_colorwheel)
			camera_list = ['cag_custom_head' 'cag_custom_head_R' 'cag_custom_head_B' 'cag_custom_head_L']
			zoom_camera = 'cag_custom_head_Zoom'
			is_esp = <is_esp>
			no_edit
		}
	}
	if GetCASAppearancePart part = <part>
		GetActualCASOptionStruct part = <part> desc_id = <desc_id>
		if GotParam \{Finishable}
			add_generic_menu_text_item {
				text = qs("FINISHES")
				choose_state = UIstate_cag_select_part_inclusion
				choose_state_data = {part = (<Finishable>) body_part = <part> text = qs("Finishes") camera_list = ['cag_custom_head' 'cag_custom_head_R' 'cag_custom_head_B' 'cag_custom_head_L'] zoom_camera = 'cag_select_fretboard_Zoom' container_id = <container_id> is_popup hist_tex = icon_cag_head_finishes}
			}
		endif
		if GotParam \{Detailable}
			add_generic_menu_text_item {
				text = qs("DETAILS")
				choose_state = UIstate_cag_select_part_inclusion
				choose_state_data = {part = (<Detailable>) body_part = <part> text = qs("Details") camera_list = ['cag_custom_head' 'cag_custom_head_R' 'cag_custom_head_B' 'cag_custom_head_L'] zoom_camera = 'cag_select_fretboard_Zoom' container_id = <container_id> is_popup hist_tex = icon_cag_head_finishes}
			}
		endif
		if GotParam \{Fadeable}
			add_generic_menu_text_item {
				text = qs("FADES")
				choose_state = UIstate_cag_select_part_inclusion
				choose_state_data = {part = (<Fadeable>) body_part = <part> text = qs("Fades") camera_list = ['cag_custom_head' 'cag_custom_head_R' 'cag_custom_head_B' 'cag_custom_head_L'] zoom_camera = 'cag_select_fretboard_Zoom' container_id = <container_id> is_popup hist_tex = icon_cag_head_finishes}
			}
		endif
	endif
	menu_finish \{car_helper_text}
	draw_guitar_center_logo
	LaunchEvent type = focus target = create_cag_custom_head_id data = {child_index = <selected_index>}
endscript

script ui_destroy_cag_custom_head 
	destroy_generic_menu
endscript

script ui_return_cag_custom_head 
	spawnscriptnow \{ui_event_block
		params = {
			event = menu_refresh
		}}
endscript
