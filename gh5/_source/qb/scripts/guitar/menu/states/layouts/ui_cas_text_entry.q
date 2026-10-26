
script ui_create_cas_text_entry 
	change \{num_name_size = 14}
	if NOT GotParam \{no_show_history}
		show_history = {show_history}
	endif
	if English
		hist_tex = icon_name
	elseif German
		hist_tex = icon_name_german
	elseif French
		hist_tex = icon_name_french
	elseif Italian
		hist_tex = icon_name_italian
	elseif Spanish
		hist_tex = icon_name_spanish
	endif
	make_generic_menu {
		title = qs("ENTER NAME")
		num_icons = <num_icons>
		hist_tex = <hist_tex>
		<show_history>
	}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	CreateScreenElement {
		type = DescInterface
		desc = 'generic_menu_name'
		parent = root_window
		id = name_entry
		exclusive_device = ($primary_controller)
	}
	<id> :Desc_ResolveAlias name = alias_vmenu_entry
	AssignAlias id = <resolved_id> alias = current_menu
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
		marker_focus_color = <focus_color>
		text_unfocus_color = <unfocus_color>
		marker_unfocus_color = <unfocus_color>
		pos = (45.0, 15.0)
		marker_offset = (-7.0, -10.0)
	}
	ui_cas_text_entry_helper_text
	lock_to_text_entry
	ui_event_add_params \{hist_tex = icon_name}
	if GotParam \{cam_name}
		spawnscriptnow task_menu_default_anim_in params = {base_name = <cam_name>}
	endif
endscript

script ui_cas_text_entry_helper_text 
	add_user_control_helper \{text = qs("ACCEPT")
		button = green
		z = 100000
		all_buttons}
	add_user_control_helper \{text = qs("CANCEL")
		button = red
		z = 100000}
	add_user_control_helper \{text = qs("ADD LETTER")
		button = Yellow
		z = 100000}
	add_user_control_helper \{text = qs("BACKSPACE")
		button = Blue
		z = 100000}
	add_user_control_helper \{text = qs("CAPS")
		button = Orange
		z = 100000}
endscript

script ui_return_cas_text_entry 
	ui_cas_text_entry_helper_text
endscript

script ui_destroy_cas_text_entry 
	SoundEvent \{event = Enter_Band_Name_Finish}
	if ScreenElementExists \{id = generic_menu}
		DestroyScreenElement \{id = generic_menu}
	endif
	generic_ui_destroy
	if ScreenElementExists \{id = name_entry}
		DestroyScreenElement \{id = name_entry}
	endif
endscript

script lock_to_text_entry 
	LaunchEvent \{type = focus
		target = current_menu
		data = {
			child_index = 0
		}}
	LaunchEvent \{type = pad_choose}
endscript
