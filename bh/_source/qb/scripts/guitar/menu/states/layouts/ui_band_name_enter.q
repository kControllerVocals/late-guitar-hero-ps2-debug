
script ui_create_band_name_enter 
	change menu_flow_locked = ($menu_flow_locked + 1)
	disable_pause
	spawnscriptnow ui_create_band_name_enter_spawned params = <...>
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_create_band_name_enter_spawned 
	change menu_flow_locked = ($menu_flow_locked + 1)
	frontend_load_soundcheck \{loadingscreen}
	GetWaypointPos \{name = Z_SoundCheck_TRG_Waypoint_CAR_Start}
	cam_pos = (<pos> + (-0.3, 1.4499999, 1.0))
	PlayIGCCam {
		name = ui_band_name_enter_camera
		viewport = bg_viewport
		pos = <cam_pos>
		Quat = (0.0, -1.0, 0.0)
		Play_hold = 1
		interrupt_current
	}
	if GotParam \{from_band_logo}
		if Spanish
			make_generic_menu \{title = qs(0xe116f6ac)
				pad_back_script = nullscript
				title_dims = (350.0, 50.0)
				shift = (-50.0, 0.0)}
		elseif Italian
			make_generic_menu \{title = qs(0xe116f6ac)
				pad_back_script = nullscript
				title_dims = (280.0, 50.0)
				shift = (-20.0, 0.0)}
		elseif German
			make_generic_menu \{title = qs(0xe116f6ac)
				pad_back_script = nullscript
				title_dims = (300.0, 50.0)
				shift = (-30.0, 0.0)}
		elseif French
			make_generic_menu \{title = qs(0xe116f6ac)
				pad_back_script = nullscript
				title_dims = (310.0, 50.0)
				shift = (-30.0, 0.0)}
		else
			make_generic_menu \{title = qs(0xe116f6ac)
				pad_back_script = nullscript}
		endif
		get_savegame_from_controller controller = <device_num>
		get_current_band_info
		bandname_id = <band_info>
		GetGlobalTags <bandname_id> param = name savegame = <savegame>
		random_name = <name>
		skip_deinit = 1
		pad_back_script = generic_event_back
		dims = (1.5 * (350.0, 29.0))
	else
		if Spanish
			make_generic_menu \{title = qs("ENTER BAND NAME")
				pad_back_script = nullscript
				title_dims = (350.0, 50.0)
				shift = (-50.0, 0.0)}
		elseif Italian
			make_generic_menu \{title = qs("ENTER BAND NAME")
				pad_back_script = nullscript
				title_dims = (280.0, 50.0)
				shift = (-20.0, 0.0)}
		elseif German
			make_generic_menu \{title = qs("ENTER BAND NAME")
				pad_back_script = nullscript
				title_dims = (300.0, 50.0)
				shift = (-30.0, 0.0)}
		elseif French
			make_generic_menu \{title = qs("ENTER BAND NAME")
				pad_back_script = nullscript
				title_dims = (300.0, 50.0)
				shift = (-30.0, 0.0)}
		else
			make_generic_menu \{title = qs("ENTER BAND NAME")
				pad_back_script = nullscript}
		endif
		pad_back_script = nullscript
		dims = (1.0 * (350.0, 37.0))
		cas_random_band_name
		skip_deinit = 1
	endif
	change \{num_name_size = 20}
	text_entry_add_item {
		pad_choose_script = ui_band_name_confirm
		pad_choose_params = {from_options = <from_options> from_band_logo = <from_band_logo> event_params = <event_params>}
		pad_back_script = nullscript
		linear_flow
		text = <random_name>
		dims = <dims>
		validity_message = qs(0x6d83d9d1)
		skip_deinit = <skip_deinit>
	}
	if IsGuitarController controller = ($primary_controller)
		event_handlers = [
			{pad_option re_randomize_band_name params = {text_entry = <text_entry>}}
			{pad_option generic_menu_pad_choose_sound}
			{pad_square generic_event_back}
		]
	else
		if IsDrumController controller = ($primary_controller)
			event_handlers = [
				{pad_option re_randomize_band_name params = {text_entry = <text_entry>}}
				{pad_option generic_menu_pad_choose_sound}
				{pad_l1 generic_event_back}
			]
		else
			event_handlers = [
				{pad_option re_randomize_band_name params = {text_entry = <text_entry>}}
				{pad_option generic_menu_pad_choose_sound}
				{pad_r2 generic_event_back}
			]
		endif
	endif
	SetScreenElementProps {
		id = current_menu
		event_handlers = <event_handlers>
	}
	menu_finish \{no_helper_text}
	LaunchEvent \{type = focus
		target = current_menu
		data = {
			child_index = 0
		}}
	LaunchEvent \{type = pad_choose}
	ui_band_name_enter_helper_text
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_band_name_enter_helper_text 
	add_user_control_helper \{text = qs("NEXT")
		button = green
		z = 100000
		all_buttons}
	add_user_control_helper \{text = qs("DELETE")
		button = red
		z = 100000}
	add_user_control_helper \{text = qs("CAPS")
		button = Yellow
		z = 100000}
	add_user_control_helper \{text = qs("RANDOM")
		button = Blue
		z = 100000}
	add_user_control_helper \{text = qs("BACK")
		button = Orange
		z = 100000}
	add_user_control_helper \{text = qs("OK")
		button = start
		z = 100000}
endscript

script ui_return_band_name_enter 
	change menu_flow_locked = ($menu_flow_locked + 1)
	ui_band_name_enter_helper_text
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_band_name_enter 
	change menu_flow_locked = ($menu_flow_locked + 1)
	KillCamAnim \{name = ui_band_name_enter_camera}
	destroy_generic_menu
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_band_name_confirm 
	change menu_flow_locked = ($menu_flow_locked + 1)
	if NOT ui_band_name_is_valid <...>
		SoundEvent \{event = Menu_Warning_SFX}

		if ($one_menu_popup = 0)

			change menu_flow_locked = ($menu_flow_locked - 1)
			if ScreenElementExists \{id = current_menu}
				LaunchEvent \{type = unfocus
					target = current_menu}
				create_dialog_box \{body_text = qs(0x6d83d9d1)
					options = [
						{
							func = enter_band_remove_warning_refocus
							text = qs("CONTINUE")
						}
					]}
			endif
		endif
	else
		get_current_band_info
		bandname_id = <band_info>
		GetTrueStartTime
		FormatText checksumname = band_unique_id 'band_info_%d' d = <StartTime>
		SetGlobalTags <bandname_id> params = {name = <text> band_unique_id = <band_unique_id>}
		agora_update band_id = <band_unique_id> name = <text> new_band
		SoundEvent \{event = Enter_Band_Name_Finish}
		change menu_flow_locked = ($menu_flow_locked - 1)
		if GotParam \{from_band_logo}
			generic_event_back \{data = {
					supress_model_load
				}}
		elseif ($options_for_manage_band = 1)
			generic_event_choose \{event = menu_change
				state = UIstate_options_manage_band_logo}
		else
			if GotParam \{from_options}
				generic_event_choose \{event = menu_replace
					state = UIstate_options_manage_band_logo}
			else
				create_loading_screen
				generic_event_replace state = UIstate_band_logo_choose data = {event_params = <event_params>}
			endif
		endif
	endif
endscript

script enter_band_remove_warning_refocus 
	destroy_dialog_box
	enter_band_name_reset_user_control_helpers
	LaunchEvent \{type = focus
		target = current_menu
		data = {
			child_index = 0
		}}
	LaunchEvent \{type = pad_choose}
endscript

script re_randomize_band_name 

	cas_random_band_name
	seed_text_entry text = <random_name> text_entry = <text_entry>
	refresh_text_on_screen text_entry = <text_entry>
endscript

script ui_band_name_is_valid 
	StringRemoveTrailingWhitespace string = <text>
	StringToCharArray string = <new_string>
	GetArraySize <char_array>
	if (<array_size> = 0)
		return \{false}
	else
		return \{true}
	endif
endscript
