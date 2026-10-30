
script ui_create_pause_options 
	ui_pausemenu_create_bg \{title_text = qs(0x976cf9e7)}
	if pausemenu_bg :desc_resolvealias \{name = alias_menu}
		<parent> = <resolved_id>
	endif
	if ($pause_menu_no_bg = 0)
		if ($g_in_tutorial = 1)
			title_text = <tutorial_pause_title>
		else
			title_text = qs(0x48a351fa)
		endif
		if NOT issingleplayergame
			formattext textname = title_text qs(0x6caaee30) p = <player>
		endif
		if ($in_tutorial_mode = 1)
			if (<tutorial_failed> = 1)
				title_text = qs(0xdf397aff)
			else
				title_text = qs(0xe588a6c9)
			endif
		endif
	endif
	make_generic_barrel_menu {
		title = <title_text>
		pad_back_script = generic_event_back data = {state = uistate_pausemenu}
		exclusive_device = <player_device>
		z_priority = (600)
		max_expansion = 5
	}
	<show_audio_options> = 0
	gamemode_getproperty \{prop = faceoff}
	if (<player_device> = $primary_controller)
		<show_audio_options> = 1
	elseif (<faceoff> = true)
		gamemode_getnumplayers
		if (<num_players> = 2)
			if playerinfoequals \{1
					part = vocals}
				<show_audio_options> = 1
			endif
		endif
	endif
	if (<show_audio_options> = 1)
		add_generic_barrel_menu_text_item {
			text = qs(0xf6b95a7e)
			choose_state = uistate_options_audio
			choose_state_data = {device_num = <player_device> from_pause}
		}
	endif
	player_index = 0
	begin
	getplayerinfo (<player_index> + 1) controller
	if (<controller> = <player_device>)
		getplayerinfo (<player_index> + 1) part
		getplayerinfo (<player_index> + 1) lefty_flip
		break
	endif
	player_index = (<player_index> + 1)
	repeat ($current_num_players)
	if (<player_device> = $primary_controller)
		add_generic_barrel_menu_text_item {
			text = qs(0xdc79581d)
			choose_state = uistate_options_calibrate_lag_warning
			choose_state_data = {controller = <player_device>}
		}
	endif
	getplayerinfo <player> part
	if NOT (<part> = vocals)
		add_generic_barrel_menu_text_item {
			text = qs(0x8b9a0bf5)
			choose_state = uistate_pausemenu_lefty_flip_warning
			choose_state_data = {player = <player>}
		}
		getplayerinfo <player> lefty_flip
		if (<lefty_flip> = 1)
			lefty_tex = options_controller_check
		else
			lefty_tex = options_controller_x
		endif
		createscreenelement {
			type = spriteelement
			parent = <item_container_id>
			texture = <lefty_tex>
			dims = (48.0, 48.0)
			pos = (390.0, 25.0)
		}
	endif
	if NOT ((<part> = vocals) || (<part> = drum))
		add_generic_barrel_menu_text_item {
			text = qs(0xab123355)
			pad_choose_sound = nullsound
			pad_choose_script = options_change_tilt_star_power
			pad_choose_params = {player = <player>}
		}
		getplayerinfo <player> use_tilt_for_starpower
		if (<use_tilt_for_starpower> = 1)
			tilt_tex = options_controller_check
		else
			tilt_tex = options_controller_x
		endif
		createscreenelement {
			local_id = tilt_check
			type = spriteelement
			parent = <item_container_id>
			texture = <tilt_tex>
			dims = (48.0, 48.0)
			pos = (390.0, 25.0)
		}
	endif
	if NOT ((<part> = vocals) || (<part> = drum))
		add_generic_barrel_menu_text_item {
			text = qs(0x971d7498)
			pad_choose_sound = nullsound
			pad_choose_script = options_change_touch_strip_option
			pad_choose_params = {player = <player>}
		}
		getplayerinfo <player> enable_touch_strip
		if (<enable_touch_strip> = 1)
			touch_tex = options_controller_check
		else
			touch_tex = options_controller_x
		endif
		createscreenelement {
			local_id = touch_check
			type = spriteelement
			parent = <item_container_id>
			texture = <touch_tex>
			dims = (48.0, 48.0)
			pos = (390.0, 25.0)
		}
	endif
	if ($current_song != jamsession)
		if (<part> = vocals)
			if ($vocal_enable_static_view = 1)
				add_generic_barrel_menu_text_item {
					text = qs(0x675aab1a)
					pad_choose_sound = nullsound
					choose_state = uistate_options_vocals_view_warning
					choose_state_data = {controller = <player_device> player = <player>}
				}
				vocals_get_highway_view player = <player>
				<vocals_highway_view> = <highway_view>
				if (<vocals_highway_view> = static)
					scroll_tex = options_controller_x
				else
					scroll_tex = options_controller_check
				endif
				createscreenelement {
					type = spriteelement
					parent = <item_container_id>
					texture = <scroll_tex>
					dims = (48.0, 48.0)
					pos = (390.0, 25.0)
				}
			endif
			add_generic_barrel_menu_text_item {
				text = qs(0x9b202e1f)
				internal_scale = (0.8, 1.0)
				pad_choose_sound = nullsound
				pad_choose_script = ui_pause_options_choose_sp_clap
				pad_choose_params = {popup = 1 player = (<player_index> + 1) device_num = <player_device>}
			}
			getplayerinfo <player> vocals_sp_clap
			if (<vocals_sp_clap> = 0)
				scroll_tex = options_controller_x
			else
				scroll_tex = options_controller_check
			endif
			createscreenelement {
				local_id = check
				type = spriteelement
				parent = <item_container_id>
				texture = <scroll_tex>
				dims = (48.0, 48.0)
				pos = (390.0, 25.0)
			}
		endif
	endif
	count_texture = options_controller_x
	get_savegame_from_controller controller = ($last_start_pressed_device)
	getglobaltags user_options param = unpause_count savegame = <savegame>
	if (<unpause_count> = 1)
		count_texture = options_controller_check
	endif
	add_generic_barrel_menu_text_item \{text = qs(0x9a8c87cc)
		pad_choose_sound = nullsound
		pad_choose_script = ui_pause_options_choose_count
		pad_choose_params = {
			popup = 1
			player = 1
		}}
	createscreenelement {
		type = spriteelement
		parent = <item_container_id>
		local_id = check
		dims = (48.0, 48.0)
		pos = (390.0, 25.0)
		just = [center center]
		texture = <count_texture>
	}
	generic_barrel_menu_finish
	menu_finish
endscript

script ui_destroy_pause_options 
	generic_ui_destroy
	ui_pausemenu_destroy_bg
	destroy_generic_barrel_menu
endscript

script ui_pause_options_choose_count 
	obj_getid
	get_savegame_from_controller controller = <device_num>
	getglobaltags user_options param = unpause_count savegame = <savegame>
	if resolvescreenelementid id = {<objid> child = check}
		if (<unpause_count> = 1)
			<unpause_count> = 0
			soundevent \{event = checkbox_sfx}
			if gotparam \{popup}
				<resolved_id> :setprops texture = options_controller_x
			else
				<resolved_id> :setprops texture = data_settings_xmark
			endif
		else
			<unpause_count> = 1
			soundevent \{event = checkbox_check_sfx}
			if gotparam \{popup}
				<resolved_id> :setprops texture = options_controller_check
			else
				<resolved_id> :setprops texture = data_settings_checkmark
			endif
		endif
		setglobaltags user_options params = {unpause_count = <unpause_count>} savegame = <savegame>
	endif
endscript

script ui_pause_options_choose_sp_clap 
	obj_getid
	getplayerinfo player = <player> vocals_sp_clap
	if resolvescreenelementid id = {<objid> child = check}
		if (<vocals_sp_clap> = 1)
			<vocals_sp_clap> = 0
			soundevent \{event = checkbox_sfx}
			if gotparam \{popup}
				<resolved_id> :setprops texture = options_controller_x
			else
				<resolved_id> :setprops texture = data_settings_xmark
			endif
		else
			<vocals_sp_clap> = 1
			soundevent \{event = checkbox_check_sfx}
			if gotparam \{popup}
				<resolved_id> :setprops texture = options_controller_check
			else
				<resolved_id> :setprops texture = data_settings_checkmark
			endif
		endif
		vocals_set_star_power_clap player = <player> clap = <vocals_sp_clap> controller = <device_num>
	endif
endscript
