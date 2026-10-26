
script ui_create_options_settings 
	change \{ui_options_from_submenu = 1}
	GetGlobalTags \{user_options}
	if ScreenElementExists \{id = settings_submenu}
		DestroyScreenElement \{id = settings_submenu}
	endif
	CreateScreenElement {
		type = DescInterface
		desc = 'settings_submenu_big'
		parent = <container_id>
		id = settings_submenu
		pos = (-1600.0, 300.0)
		scale = 1.2
		just = [center center]
	}
	if <id> :Desc_ResolveAlias name = alias_menu
		AssignAlias id = <resolved_id> alias = current_submenu
		current_submenu :SE_SetProps \{event_handlers = [
				{
					pad_up
					generic_menu_up_or_down_sound
					params = {
						up
					}
				}
				{
					pad_down
					generic_menu_up_or_down_sound
					params = {
						down
					}
				}
				{
					pad_back
					ui_options_check_settings
					params = {
						no_loading_screen
					}
				}
			]}
		GetScreenElementChildren \{id = current_submenu}
		get_player_num_from_controller \{controller_index = $primary_controller}
		GetPlayerInfo <player_num> lefty_flip
		if (<lefty_flip> = 1)
			<check_alpha> = 1
			<cross_alpha> = 0
		else
			<check_alpha> = 0
			<cross_alpha> = 1
		endif
		if isXenon
			(<children> [0]) :SE_SetProps {
				text_text = qs("Lefty Flip")
				check_alpha = <check_alpha>
				cross_alpha = <cross_alpha>
				event_handlers = [
					{pad_choose ui_options_controller_choose_lefty_flip params = {popup = <popup> player_device = $primary_controller}}
					{focus ui_options_settings_focus}
					{unfocus ui_options_settings_unfocus}
				]
			}
		else
			(<children> [0]) :SE_SetProps {
				text_text = qs("Lefty Flip")
				check_alpha = <check_alpha>
				cross_alpha = <cross_alpha>
				event_handlers = [
					{pad_choose ui_options_controller_choose_lefty_flip params = {popup = <popup> player_device = $primary_controller}}
					{focus ui_options_settings_focus}
					{unfocus ui_options_settings_unfocus}
				]
			}
			current_menu :SetTags lefty_id = <item_id>
		endif
		vocals_get_highway_view \{player = 1}
		if (<highway_view> != static)
			<check_alpha> = 1
			<cross_alpha> = 0
		else
			<check_alpha> = 0
			<cross_alpha> = 1
		endif
		if ($vocal_enable_static_view = 1)
			(<children> [1]) :SE_SetProps {
				text_text = qs("Scrolling Vocals")
				check_alpha = <check_alpha>
				cross_alpha = <cross_alpha>
				event_handlers = [
					{pad_choose options_change_vocals_highway_view params = {no_restart player = 1}}
					{focus ui_options_settings_focus}
					{unfocus ui_options_settings_unfocus}
				]
			}
		else
			(<children> [1]) :SE_SetProps {
				text_text = qs("Scrolling Vocals")
				check_alpha = <check_alpha>
				cross_alpha = <cross_alpha>
				not_focusable
				rgba = [110 100 90 175]
			}
		endif
		GetPlayerInfo <player_num> vocals_sp_clap
		if (<vocals_sp_clap> = 1)
			<check_alpha> = 1
			<cross_alpha> = 0
		else
			<check_alpha> = 0
			<cross_alpha> = 1
		endif
		(<children> [2]) :SE_SetProps {
			text_text = qs("Star Power Clap")
			check_alpha = <check_alpha>
			cross_alpha = <cross_alpha>
			event_handlers = [
				{pad_choose options_change_vocals_sp_clap params = {player = 1}}
				{focus ui_options_settings_focus}
				{unfocus ui_options_settings_unfocus}
			]
		}
		if (<unpause_count> = 1)
			<check_alpha> = 1
			<cross_alpha> = 0
		else
			<check_alpha> = 0
			<cross_alpha> = 1
		endif
		(<children> [3]) :SE_SetProps {
			text_text = qs("Countdown")
			check_alpha = <check_alpha>
			cross_alpha = <cross_alpha>
			event_handlers = [
				{pad_choose ui_options_settings_choose_count params = {player = 1}}
				{focus ui_options_settings_focus}
				{unfocus ui_options_settings_unfocus}
			]
		}
		GetPlayerInfo <player_num> use_tilt_for_starpower
		if (<use_tilt_for_starpower> = 1)
			<check_alpha> = 1
			<cross_alpha> = 0
		else
			<check_alpha> = 0
			<cross_alpha> = 1
		endif
		(<children> [4]) :SE_SetProps {
			text_text = qs("Star Power Tilt")
			check_alpha = <check_alpha>
			cross_alpha = <cross_alpha>
			event_handlers = [
				{pad_choose options_change_tilt_star_power params = {player = 1}}
				{focus ui_options_settings_focus}
				{unfocus ui_options_settings_unfocus}
			]
		}
		GetPlayerInfo <player_num> enable_touch_strip
		if (<enable_touch_strip> = 1)
			<check_alpha> = 1
			<cross_alpha> = 0
		else
			<check_alpha> = 0
			<cross_alpha> = 1
		endif
		(<children> [5]) :SE_SetProps {
			text_text = qs("Touch Strip")
			check_alpha = <check_alpha>
			cross_alpha = <cross_alpha>
			event_handlers = [
				{pad_choose options_change_touch_strip_option params = {player = 1}}
				{focus ui_options_settings_focus}
				{unfocus ui_options_settings_unfocus}
			]
		}
		if NOT IsPAL
			if ($PS2_ProgressiveScan = 1)
				<check_alpha> = 1
				<cross_alpha> = 0
			else
				<check_alpha> = 0
				<cross_alpha> = 1
			endif
			(<children> [6]) :SE_SetProps {
				text_text = qs(0xaec6cab2)
				check_alpha = <check_alpha>
				cross_alpha = <cross_alpha>
				event_handlers = [
					{pad_choose ui_options_settings_progressive_scan_toggle}
					{focus ui_options_settings_focus}
					{unfocus ui_options_settings_unfocus}
				]
			}
		else
			(<children> [6]) :SE_SetProps {
				check_alpha = 0.0
				cross_alpha = 0.0
				alpha = 0.0
				not_focusable
			}
		endif
		current_submenu :obj_spawnscript \{highlight_motion
			params = {
				menu_id = settings_submenu
			}}
	endif
	settings_submenu :obj_spawnscript \{ui_options_settings_animate_in}
	ui_options_set_settings
endscript

script ui_destroy_options_settings 
	if ScreenElementExists \{id = settings_submenu}
		settings_submenu :obj_spawnscript \{ui_options_settings_animate_out}
	endif
	clean_up_user_control_helpers
endscript

script ui_return_options_settings 
	clean_up_user_control_helpers
	add_gamertag_helper \{exclusive_device = $primary_controller}
endscript

script ui_options_settings_choose_count 
	Obj_GetID
	GetGlobalTags \{user_options
		param = unpause_count}
	if (<unpause_count> = 1)
		<unpause_count> = 0
		SoundEvent \{event = checkbox_sfx}
		if GotParam \{popup}
			<ObjID> :SE_SetProps check_alpha = 0
			<ObjID> :SE_SetProps cross_alpha = 1
		else
			<ObjID> :SE_SetProps check_alpha = 0
			<ObjID> :SE_SetProps cross_alpha = 1
		endif
	else
		<unpause_count> = 1
		SoundEvent \{event = CheckBox_Check_SFX}
		if GotParam \{popup}
			<ObjID> :SE_SetProps check_alpha = 1
			<ObjID> :SE_SetProps cross_alpha = 0
		else
			<ObjID> :SE_SetProps check_alpha = 1
			<ObjID> :SE_SetProps cross_alpha = 0
		endif
	endif
	SetGlobalTags user_options params = {unpause_count = <unpause_count>}
endscript

script ui_create_options_settings_lefty_warning 
	LaunchEvent \{type = unfocus
		target = current_submenu}
	create_dialog_box \{heading_text = qs("WARNING")
		body_text = qs(0x844b0500)
		options = [
			{
				func = ui_destroy_options_settings_lefty_warning
				text = qs("CONTINUE")
			}
		]}
endscript

script ui_destroy_options_settings_lefty_warning 
	Wait \{1
		seconds}
	destroy_dialog_box
	LaunchEvent \{type = focus
		target = current_submenu}
endscript

script ui_options_settings_lefty_warning 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	current_menu :GetSingleTag \{lefty_id}
	obj_spawnscript \{ui_options_controller_choose_lefty_flip
		params = {
			player_device = $primary_controller
		}}
	generic_event_back
endscript

script ui_options_settings_animate_in 
	if ScreenElementExists \{id = current_menu_anchor}
		current_menu_anchor :SE_SetProps \{GH5_logo_pos = {
				relative
				(-500.0, 0.0)
			}
			time = 0.15
			motion = linear}
	endif
	SE_SetProps \{pos = (-1200.0, -25.0)
		time = 0.15
		motion = linear}
	SE_SetProps \{darker_alpha = 0.4
		time = 0.15}
endscript

script ui_options_settings_animate_out 
	if ScreenElementExists \{id = current_menu_anchor}
		current_menu_anchor :SE_SetProps \{GH5_logo_pos = {
				relative
				(500.0, 0.0)
			}
			time = 0.15
			motion = linear}
	endif
	SE_SetProps \{pos = (-1600.0, 300.0)
		time = 0.15
		motion = linear}
	SE_SetProps \{darker_alpha = 0.0
		time = 0.15}
	SE_WaitProps
	if ScreenElementExists \{id = settings_submenu}
		DestroyScreenElement \{id = settings_submenu}
	endif
endscript

script ui_options_settings_focus 
	Obj_GetID
	if GotParam \{ObjID}
		if <ObjID> :Desc_ResolveAlias name = alias_text
			<resolved_id> :SE_SetProps rgba = (($default_color_scheme).text_focus_color)
		endif
	endif
	GetTags
	if settings_submenu :Desc_ResolveAlias \{name = alias_highlight}
		AssignAlias id = <resolved_id> alias = highlight
		Wait \{2
			gameframe}
		if <ObjID> :Desc_ResolveAlias name = alias_text
			GetScreenElementChildren id = <resolved_id>
			GetScreenElementDims id = (<children> [0])
			scale = (((1.0, 0.0) * (((<width> + 25.0) / 256.0))) + (0.0, 1.5))
			GetScreenElementPosition id = (<children> [0]) summed
			highlight :SE_SetProps pos = {absolute (<screenelementpos>)} scale = <scale>
			highlight :SE_WaitProps
			GetScreenElementPosition id = (<children> [0]) summed
			highlight :SE_SetProps pos = {absolute (<screenelementpos> + (0.0, -10.0))} time = 0.05
			highlight :SE_WaitProps
			GetScreenElementPosition id = (<children> [0]) summed
			highlight :SE_SetProps pos = {absolute (<screenelementpos>)} scale = <scale> time = 0.05
			highlight :SE_WaitProps
		endif
	endif
endscript

script ui_options_settings_unfocus 
	Obj_GetID
	if GotParam \{ObjID}
		if <ObjID> :Desc_ResolveAlias name = alias_text
			<resolved_id> :SE_SetProps rgba = (($default_color_scheme).text_color)
		endif
	endif
endscript

script ui_options_settings_progressive_scan_toggle 
	if ($PS2_ProgressiveScan = 1)
		change \{PS2_ProgressiveScan = 0}
		SetProgressive \{on = 0}
		ui_event \{event = menu_refresh}
	else
		ui_create_progressive_scan_warning
	endif
endscript

script ui_create_progressive_scan_warning 
	LaunchEvent \{type = unfocus
		target = current_submenu}
	create_dialog_box \{heading_text = qs("WARNING")
		body_text = qs(0x7cedf58b)
		options = [
			{
				func = ps2_progressive_scan_ok
				text = qs("OK")
			}
			{
				func = ui_destroy_progressive_scan_warning
				text = qs("CANCEL")
			}
		]
		back_button_script = ui_destroy_progressive_scan_warning}
	add_user_control_helper \{text = qs("BACK")
		button = red}
endscript

script ps2_progressive_scan_ok 
	destroy_dialog_box
	change \{PS2_ProgressiveScan = 1}
	SetProgressive \{on = 1}
	create_dialog_box \{heading_text = qs("CONFIRM")
		body_text = qs(0xcac12143)
		options = [
			{
				func = ps2_confirm_progressive_mode
				text = qs("OK")
			}
			{
				func = ps2_cancel_progressive_mode
				text = qs("CANCEL")
			}
		]
		back_button_script = ps2_cancel_progressive_mode}
	if dialog_box_desc_id :Desc_ResolveAlias \{name = alias_dlog_vmenu}
		<resolved_id> :Menu_ChangeSelection
	endif
	spawnscriptnow \{ps2_wait_for_progressive_ok}
endscript

script ps2_wait_for_progressive_ok 
	Wait \{15
		seconds}
	spawnscriptnow \{ps2_cancel_progressive_mode}
endscript

script ps2_confirm_progressive_mode 
	KillSpawnedScript \{name = ps2_wait_for_progressive_ok}
	GetScreenElementChildren \{id = current_submenu}
	(<children> [6]) :SE_SetProps {
		check_alpha = 1
		cross_alpha = 0
	}
	ui_destroy_progressive_scan_warning
endscript

script ps2_cancel_progressive_mode 
	KillSpawnedScript \{name = ps2_wait_for_progressive_ok}
	change \{PS2_ProgressiveScan = 0}
	SetProgressive \{on = 0}
	ui_destroy_progressive_scan_warning
endscript

script ui_destroy_progressive_scan_warning 
	destroy_dialog_box
	LaunchEvent \{type = focus
		target = current_submenu}
endscript
