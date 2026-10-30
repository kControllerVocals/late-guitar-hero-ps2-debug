
script ui_create_cas_text_entry 
	change \{num_name_size = 14}
	if NOT gotparam \{no_show_history}
		show_history = {show_history}
	endif
	if english
		hist_tex = icon_name
	elseif german
		hist_tex = icon_name_german
	elseif french
		hist_tex = icon_name_french
	elseif italian
		hist_tex = icon_name_italian
	elseif spanish
		hist_tex = icon_name_spanish
	endif
	make_generic_menu {
		title = qs(0x17f49e18)
		num_icons = <num_icons>
		hist_tex = <hist_tex>
		<show_history>
	}
	if <desc_id> :desc_resolvealias name = 0x44475582 param = 0x7363d093
		<0x7363d093> :obj_spawnscript 0xa7a510a8 params = {0x4d641ae8 0xe99089a3 = $0x187899ed 0xffd05882 = $0xddccbea4}
	else

	endif
	if <desc_id> :desc_resolvealias name = 0xf313b252 param = 0x7c09a415
		<0x7c09a415> :obj_spawnscript 0xa7a510a8 params = {0x4d641ae8 0xe99089a3 = $0x52565f88 0xffd05882 = $0xddccbea4}
	else

	endif
	createscreenelement {
		type = descinterface
		desc = 'generic_menu_name'
		parent = root_window
		id = name_entry
		exclusive_device = ($primary_controller)
	}
	<id> :desc_resolvealias name = alias_vmenu_entry
	assignalias id = <resolved_id> alias = current_menu
	focus_color = [255 255 255 255]
	unfocus_color = [0 0 0 255]
	text_entry_add_item {
		pad_back_script = generic_event_back
		pad_choose_script = <choose_script>
		pad_choose_params = <choose_params>
		text = <text>
		font = fontgrid_text_a11
		dims = (400.0, 55.0)
		text_focus_color = <focus_color>
		0xb90ddda6 = <focus_color>
		text_unfocus_color = <unfocus_color>
		0xbcd8ee4c = <unfocus_color>
		pos = (45.0, 15.0)
		marker_offset = (-7.0, -10.0)
	}
	ui_cas_text_entry_helper_text
	lock_to_text_entry
	ui_event_add_params \{hist_tex = icon_name}
	if gotparam \{save_cap}
		create_menu_backdrop \{texture = 0x6a4c3519}
		0x37c74dec
		createscreenelement \{type = spriteelement
			parent = 0x7c19d7b6
			dims = (222.0, 222.0)
			pos = (100.0, 100.0)
			texture = logo_bg
			alpha = 0.3
			z_priority = 0.5
			rgba = 0x8d470aac}
	endif
	if gotparam \{cam_name}
		spawnscriptnow task_menu_default_anim_in params = {base_name = <cam_name>}
	endif
endscript

script ui_cas_text_entry_helper_text 
	add_user_control_helper \{text = qs(0xb73cb78f)
		button = green
		z = 100000
		all_buttons}
	add_user_control_helper \{text = qs(0xf7723015)
		button = red
		z = 100000}
	add_user_control_helper \{text = qs(0x09758c70)
		button = yellow
		z = 100000}
	add_user_control_helper \{text = qs(0x1c2cd639)
		button = blue
		z = 100000}
	add_user_control_helper \{text = qs(0xa3503d64)
		button = orange
		z = 100000}
endscript

script ui_return_cas_text_entry 
	ui_cas_text_entry_helper_text
endscript

script ui_destroy_cas_text_entry 
	if screenelementexists \{id = generic_menu}
		destroyscreenelement \{id = generic_menu}
	endif
	generic_ui_destroy
	if screenelementexists \{id = name_entry}
		destroyscreenelement \{id = name_entry}
	endif
	0xa00c6b0d
	destroy_menu_backdrop
endscript

script lock_to_text_entry 
	launchevent \{type = focus
		target = current_menu
		data = {
			child_index = 0
		}}
	launchevent \{type = pad_choose}
endscript
