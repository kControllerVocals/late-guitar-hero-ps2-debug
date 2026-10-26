
script ui_create_cag_custom_body 
	part = (<instrument_info>.body_part)
	make_generic_menu \{vmenu_id = create_cag_custom_body_vmenu
		title = qs("BODY")
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
	setup_cas_menu_handlers \{vmenu_id = create_cag_custom_body_vmenu
		camera_list = [
			'cag_custom_body'
			'cag_custom_body_R'
			'cag_custom_body_B'
			'cag_custom_body_L'
		]
		zoom_camera = 'cag_custom_body_zoom'}
	add_generic_menu_text_item {
		text = qs("STYLE")
		pad_choose_script = continue_to_type
		pad_choose_params = {
			part = <part>
			is_popup
			cam_name = 'cag_custom_body'
			camera_list = ['cag_custom_body' 'cag_custom_body_R' 'cag_custom_body_B' 'cag_custom_body_L']
			zoom_camera = 'cag_custom_body_zoom'
			is_esp = <is_esp>
		}
	}
	if GetCASAppearancePart part = <part>
		GetActualCASOptionStruct part = <part> desc_id = <desc_id>
		if GotParam \{Finishable}
			add_generic_menu_text_item {
				text = qs("FINISHES")
				choose_state = UIstate_cag_select_part_inclusion
				choose_state_data = {part = (<Finishable>) body_part = <part> text = qs("Finishes") cam_name = 'cag_custom_body' container_id = <container_id> is_popup hist_tex = icon_cag_finishes camera_list = ['cag_custom_body' 'cag_custom_body_R' 'cag_custom_body_B' 'cag_custom_body_L'] zoom_camera = 'cag_custom_body_zoom'}
			}
		endif
		if GotParam \{Detailable}
			add_generic_menu_text_item {
				text = qs("DETAILS")
				choose_state = UIstate_cag_select_part_inclusion
				choose_state_data = {part = (<Detailable>) body_part = <part> text = qs("Details") cam_name = 'cag_custom_body' container_id = <container_id> is_popup hist_tex = icon_details camera_list = ['cag_custom_body' 'cag_custom_body_R' 'cag_custom_body_B' 'cag_custom_body_L'] zoom_camera = 'cag_custom_body_zoom'}
			}
		endif
		if GotParam \{Fadeable}
			add_generic_menu_text_item {
				text = qs("FADES")
				choose_state = UIstate_cag_select_part_inclusion
				choose_state_data = {part = (<Fadeable>) body_part = <part> text = qs("Fades") cam_name = 'cag_custom_body' container_id = <container_id> is_popup hist_tex = icon_details camera_list = ['cag_custom_body' 'cag_custom_body_R' 'cag_custom_body_B' 'cag_custom_body_L'] zoom_camera = 'cag_custom_body_zoom'}
			}
		endif
		if GotParam \{Logoable}
			add_generic_menu_text_item {
				text = qs(0xa0af3d41)
				choose_state = UIstate_cag_select_part_inclusion
				choose_state_data = {part = (<Logoable>) body_part = <part> text = qs("Band Logo") cam_name = 'cag_custom_body' container_id = <container_id> is_popup hist_tex = icon_graphics camera_list = ['cag_custom_body' 'cag_custom_body_R' 'cag_custom_body_B' 'cag_custom_body_L'] zoom_camera = 'cag_custom_body_zoom'}
			}
		endif
	endif
	change \{generic_menu_block_input = 0}
	menu_finish \{car_helper_text}
	draw_guitar_center_logo
	LaunchEvent type = focus target = create_cag_custom_body_vmenu data = {child_index = <selected_index>}
endscript

script ui_destroy_cag_custom_body 
	destroy_generic_menu
endscript

script ui_return_cag_custom_body 
	change \{generic_menu_block_input = 1}
	spawnscriptnow \{ui_event_block
		params = {
			event = menu_refresh
		}}
endscript

script continue_to_finishes 
	if Is_ui_event_running
		return \{false}
	endif
	ui_event_block event = menu_change data = {state = UIstate_cap_artist_layer_popout <...>}
endscript

script continue_to_type 
	if Is_ui_event_running
		return \{false}
	endif
	ui_event_block event = menu_change data = {state = UIstate_cag_custom_body_types <...>}
endscript
