
script ui_create_pause_options 
	ui_pausemenu_create_bg \{title_text = qs("OPTIONS")}
	if pausemenu_bg :Desc_ResolveAlias \{name = alias_menu}
		<parent> = <resolved_id>
	endif
	if ($pause_menu_no_bg = 0)
		if ($g_in_tutorial = 1)
			title_text = <tutorial_pause_title>
		else
			title_text = qs("PAUSE")
		endif
		if NOT isSinglePlayerGame
			FormatText TextName = title_text qs("P%p PAUSED") p = <player>
		endif
		if ($in_tutorial_mode = 1)
			if (<tutorial_failed> = 1)
				title_text = qs("TUTORIAL FAILED")
			else
				title_text = qs("TUTORIAL PAUSED")
			endif
		endif
	endif
	make_generic_barrel_menu {
		title = <title_text>
		pad_back_script = generic_event_back data = {state = UIstate_pausemenu}
		exclusive_device = <player_device>
		z_priority = (600)
		max_expansion = 5
	}
	<show_audio_options> = 0
	GameMode_GetProperty \{prop = faceoff}
	if (<player_device> = $primary_controller)
		<show_audio_options> = 1
	elseif (<faceoff> = true)
		GameMode_GetNumPlayers
		if (<num_players> = 2)
			if PlayerInfoEquals \{1
					part = Vocals}
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
	GetPlayerInfo (<player_index> + 1) controller
	if (<controller> = <player_device>)
		GetPlayerInfo (<player_index> + 1) part
		GetPlayerInfo (<player_index> + 1) lefty_flip
		break
	endif
	player_index = (<player_index> + 1)
	repeat ($current_num_players)
	if (<player_device> = $primary_controller)
		add_generic_barrel_menu_text_item {
			text = qs("Calibrate Lag")
			choose_state = uistate_options_calibrate_lag_warning
			choose_state_data = {controller = <player_device>}
		}
	endif
	GetPlayerInfo <player> part
	if NOT (<part> = Vocals)
		add_generic_barrel_menu_text_item {
			text = qs(0x8b9a0bf5)
			choose_state = uistate_pausemenu_lefty_flip_warning
			choose_state_data = {player = <player>}
		}
		GetPlayerInfo <player> lefty_flip
		if (<lefty_flip> = 1)
			lefty_tex = Options_Controller_Check
		else
			lefty_tex = Options_Controller_X
		endif
		CreateScreenElement {
			type = SpriteElement
			parent = <item_container_id>
			texture = <lefty_tex>
			dims = (48.0, 48.0)
			pos = (390.0, 25.0)
		}
	endif
	if NOT ((<part> = Vocals) || (<part> = drum))
		add_generic_barrel_menu_text_item {
			text = qs(0xab123355)
			pad_choose_sound = NullSound
			pad_choose_script = options_change_tilt_star_power
			pad_choose_params = {player = <player>}
		}
		GetPlayerInfo <player> use_tilt_for_starpower
		if (<use_tilt_for_starpower> = 1)
			tilt_tex = Options_Controller_Check
		else
			tilt_tex = Options_Controller_X
		endif
		CreateScreenElement {
			local_id = tilt_check
			type = SpriteElement
			parent = <item_container_id>
			texture = <tilt_tex>
			dims = (48.0, 48.0)
			pos = (390.0, 25.0)
		}
	endif
	if NOT ((<part> = Vocals) || (<part> = drum))
		add_generic_barrel_menu_text_item {
			text = qs(0x971d7498)
			pad_choose_sound = NullSound
			pad_choose_script = options_change_touch_strip_option
			pad_choose_params = {player = <player>}
		}
		GetPlayerInfo <player> enable_touch_strip
		if (<enable_touch_strip> = 1)
			touch_tex = Options_Controller_Check
		else
			touch_tex = Options_Controller_X
		endif
		CreateScreenElement {
			local_id = touch_check
			type = SpriteElement
			parent = <item_container_id>
			texture = <touch_tex>
			dims = (48.0, 48.0)
			pos = (390.0, 25.0)
		}
	endif
	if ($current_song != jamsession)
		if (<part> = Vocals)
			if ($vocal_enable_static_view = 1)
				add_generic_barrel_menu_text_item {
					text = qs(0x675aab1a)
					pad_choose_sound = NullSound
					choose_state = uistate_options_vocals_view_warning
					choose_state_data = {controller = <player_device> player = <player>}
				}
				vocals_get_highway_view player = <player>
				<vocals_highway_view> = <highway_view>
				if (<vocals_highway_view> = static)
					scroll_tex = Options_Controller_X
				else
					scroll_tex = Options_Controller_Check
				endif
				CreateScreenElement {
					type = SpriteElement
					parent = <item_container_id>
					texture = <scroll_tex>
					dims = (48.0, 48.0)
					pos = (390.0, 25.0)
				}
			endif
			add_generic_barrel_menu_text_item {
				text = qs(0x9b202e1f)
				internal_scale = (0.8, 1.0)
				pad_choose_sound = NullSound
				pad_choose_script = ui_pause_options_choose_sp_clap
				pad_choose_params = {popup = 1 player = (<player_index> + 1) device_num = <player_device>}
			}
			GetPlayerInfo <player> vocals_sp_clap
			if (<vocals_sp_clap> = 0)
				scroll_tex = Options_Controller_X
			else
				scroll_tex = Options_Controller_Check
			endif
			CreateScreenElement {
				local_id = check
				type = SpriteElement
				parent = <item_container_id>
				texture = <scroll_tex>
				dims = (48.0, 48.0)
				pos = (390.0, 25.0)
			}
		endif
	endif
	count_texture = Options_Controller_X
	get_savegame_from_controller controller = ($last_start_pressed_device)
	GetGlobalTags user_options param = unpause_count savegame = <savegame>
	if (<unpause_count> = 1)
		count_texture = Options_Controller_Check
	endif
	add_generic_barrel_menu_text_item \{text = qs(0x9a8c87cc)
		pad_choose_sound = NullSound
		pad_choose_script = ui_pause_options_choose_count
		pad_choose_params = {
			popup = 1
			player = 1
		}}
	CreateScreenElement {
		type = SpriteElement
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
	Obj_GetID
	get_savegame_from_controller controller = <device_num>
	GetGlobalTags user_options param = unpause_count savegame = <savegame>
	if ResolveScreenElementId id = {<ObjID> child = check}
		if (<unpause_count> = 1)
			<unpause_count> = 0
			SoundEvent \{event = checkbox_sfx}
			if GotParam \{popup}
				<resolved_id> :SetProps texture = Options_Controller_X
			else
				<resolved_id> :SetProps texture = data_settings_xmark
			endif
		else
			<unpause_count> = 1
			SoundEvent \{event = CheckBox_Check_SFX}
			if GotParam \{popup}
				<resolved_id> :SetProps texture = Options_Controller_Check
			else
				<resolved_id> :SetProps texture = data_settings_checkmark
			endif
		endif
		SetGlobalTags user_options params = {unpause_count = <unpause_count>} savegame = <savegame>
	endif
endscript

script ui_pause_options_choose_sp_clap 
	Obj_GetID
	GetPlayerInfo player = <player> vocals_sp_clap
	if ResolveScreenElementId id = {<ObjID> child = check}
		if (<vocals_sp_clap> = 1)
			<vocals_sp_clap> = 0
			SoundEvent \{event = checkbox_sfx}
			if GotParam \{popup}
				<resolved_id> :SetProps texture = Options_Controller_X
			else
				<resolved_id> :SetProps texture = data_settings_xmark
			endif
		else
			<vocals_sp_clap> = 1
			SoundEvent \{event = CheckBox_Check_SFX}
			if GotParam \{popup}
				<resolved_id> :SetProps texture = Options_Controller_Check
			else
				<resolved_id> :SetProps texture = data_settings_checkmark
			endif
		endif
		vocals_set_star_power_clap player = <player> clap = <vocals_sp_clap> controller = <device_num>
	endif
endscript
