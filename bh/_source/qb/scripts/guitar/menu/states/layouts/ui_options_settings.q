
script ui_create_options_settings 
	change \{ui_options_from_submenu = 1}
	GetGlobalTags \{user_options}
	make_generic_stripe_submenu \{pad_back_script = ui_options_check_settings
		pad_back_params = {
			no_loading_screen
		}}
	add_generic_stripe_menu_item {
		parent = current_submenu
		option_left
		text = qs("LEFTY FLIP")
		option_checkbox
		pad_choose_script = ui_options_controller_choose_lefty_flip
		pad_choose_params = {popup = <popup> player_device = $primary_controller}
	}
	get_player_num_from_controller \{controller_index = $primary_controller}
	GetPlayerInfo <player_num> lefty_flip
	if (<lefty_flip> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :SE_SetProps {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	current_menu :SetTags lefty_id = <item_id>
	if ($vocal_enable_static_view = 1)
		add_generic_stripe_menu_item \{parent = current_submenu
			option_left
			text = qs("SCROLLING VOCALS")
			option_checkbox
			pad_choose_script = options_change_vocals_highway_view
			pad_choose_params = {
				no_restart
				player = 1
			}}
	else
		add_generic_stripe_menu_item \{parent = current_submenu
			option_left
			text = qs("SCROLLING VOCALS")
			option_checkbox
			pad_choose_script = nullscript
			pad_choose_sound = ui_bonus_videos_negative_sfx
			focus_rgba = [
				160
				150
				140
				175
			]
			unfocus_rgba = [
				160
				150
				140
				175
			]}
	endif
	vocals_get_highway_view \{player = 1}
	if (<highway_view> != static)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :SE_SetProps {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	add_generic_stripe_menu_item \{parent = current_submenu
		option_left
		text = qs("STAR POWER CLAP")
		option_checkbox
		pad_choose_script = options_change_vocals_sp_clap
		pad_choose_params = {
			player = 1
		}}
	GetPlayerInfo <player_num> vocals_sp_clap
	if (<vocals_sp_clap> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :SE_SetProps {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	add_generic_stripe_menu_item \{parent = current_submenu
		option_left
		text = qs("COUNTDOWN")
		option_checkbox
		pad_choose_script = ui_options_settings_choose_count
		pad_choose_params = {
			player = 1
		}}
	if (<unpause_count> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :SE_SetProps {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	add_generic_stripe_menu_item \{parent = current_submenu
		option_left
		text = qs("STAR POWER TILT")
		option_checkbox
		pad_choose_script = options_change_tilt_star_power
		pad_choose_params = {
			player = 1
		}}
	GetPlayerInfo <player_num> use_tilt_for_starpower
	if (<use_tilt_for_starpower> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :SE_SetProps {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	add_generic_stripe_menu_item \{parent = current_submenu
		option_left
		text = qs("TOUCH STRIP")
		option_checkbox
		pad_choose_script = options_change_touch_strip_option
		pad_choose_params = {
			player = 1
		}}
	GetPlayerInfo <player_num> enable_touch_strip
	if (<enable_touch_strip> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :SE_SetProps {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	if NOT IsPAL
		add_generic_stripe_menu_item \{parent = current_submenu
			option_left
			text = qs(0x37f773d2)
			option_checkbox
			pad_choose_script = ui_options_settings_progressive_scan_toggle}
		if ($PS2_ProgressiveScan = 1)
			<check_alpha> = 1
			<cross_alpha> = 0
		else
			<check_alpha> = 0
			<cross_alpha> = 1
		endif
		<item_id> :SE_SetProps {
			check_alpha = <check_alpha>
			cross_alpha = <cross_alpha>
		}
	endif
	ui_options_set_settings
endscript

script ui_destroy_options_settings 
	destroy_generic_stripe_submenu
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
		SoundEvent \{event = Box_UnCheck_SFX}
		check_alpha = 0
		cross_alpha = 1
	else
		<unpause_count> = 1
		SoundEvent \{event = Box_Check_SFX}
		check_alpha = 1
		cross_alpha = 0
	endif
	<ObjID> :SE_SetProps check_alpha = <check_alpha>
	<ObjID> :SE_SetProps cross_alpha = <cross_alpha>
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
	menu_finish
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
		SoundEvent \{Box_UnCheck_SFX}
		change \{PS2_ProgressiveScan = 0}
		SetProgressive \{on = 0}
		ui_event \{event = menu_refresh}
	else
		SoundEvent \{Box_Check_SFX}
		ui_create_progressive_scan_warning
	endif
endscript

script ui_create_progressive_scan_warning 
	LaunchEvent \{type = unfocus
		target = current_submenu}
	create_dialog_box \{heading_text = qs("WARNING")
		body_text = qs(0xb6ee6e80)
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
		back_button_script = ui_destroy_progressive_scan_warning
		back_button_params = {
			play_back_sound
		}}
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
		back_button_script = ps2_cancel_progressive_mode
		back_button_params = {
			play_back_sound
		}}
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
	ui_destroy_progressive_scan_warning <...>
endscript

script ui_destroy_progressive_scan_warning 
	if GotParam \{play_back_sound}
		generic_menu_pad_back_sound
	endif
	destroy_dialog_box
	LaunchEvent \{type = focus
		target = current_submenu}
	menu_finish
endscript
