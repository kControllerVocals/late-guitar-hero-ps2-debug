in_sing_a_long = false

script ui_init_sing_a_long 
	change \{in_sing_a_long = true}
	player_info_store = []
	i = 1
	begin
	GetPlayerInfo <i> vocals_highway_view
	AddArrayElement array = <player_info_store> element = <vocals_highway_view>
	player_info_store = <array>
	i = (<i> + 1)
	repeat 4
	CreateScreenElement {
		type = ContainerElement
		id = sing_a_long_container
		parent = root_window
		pos_anchor = [left top]
		just = [left top]
		dims = (1280.0, 720.0)
		tags = {
			back_state = <back_state>
			song = <song>
			venue = <venue>
			game_mode = ($game_mode)
			Cheat_Invincible = ($Cheat_Invincible)
			disable_all_starpower = ($disable_all_starpower)
			player_info_store = <player_info_store>
		}
		event_handlers = [
			{pad_back ui_sing_a_long_back}
		]
	}
	add_user_control_helper {
		override_parent = sing_a_long_container
		button = red text = qs("QUIT")
		pos = (0.0, -72.0)
		just = [center top]
		pos_anchor = [center bottom]
		controller = ($primary_controller)
		all_buttons
	}
	i = 1
	begin
	SetPlayerInfo <i> part = Vocals
	SetPlayerInfo <i> scoring = 0
	SetPlayerInfo <i> vocals_highway_view = karaoke
	SetPlayerInfo <i> in_game = 1
	SetPlayerInfo <i> difficulty = beginner
	i = (<i> + 1)
	repeat 4
	vocals_distribute_mics
	change \{game_mode = p1_quickplay}
	change \{Cheat_Invincible = 1}
	change \{disable_all_starpower = 1}
	if GotParam \{venue}
		change g_band_lobby_current_level = <venue>
	endif
	ui_sing_a_long_band_override
	sing_a_long_container :obj_spawnscript \{ui_sing_a_long_spawned}
endscript

script ui_create_sing_a_long 
endscript

script ui_destroy_sing_a_long 
endscript

script ui_deinit_sing_a_long 
	sing_a_long_container :GetTags
	change game_mode = <game_mode>
	change Cheat_Invincible = <Cheat_Invincible>
	change disable_all_starpower = <disable_all_starpower>
	i = 1
	begin
	SetPlayerInfo <i> vocals_highway_view = (<player_info_store> [<i> -1])
	i = (<i> + 1)
	repeat 4
	DestroyScreenElement \{id = sing_a_long_container}
	change \{in_sing_a_long = false}
endscript

script ui_sing_a_long_spawned 
	SetScriptCannotPause
	GetTags
	ui_event_wait_for_safe
	ui_event_block \{event = menu_change
		data = {
			state = uistate_play_song
		}}
	LaunchEvent \{type = focus
		target = sing_a_long_container}
	begin
	if ScreenElementExists \{id = Vignette_of_failure}
		Vignette_of_failure :SE_SetProps \{hide}
	endif
	if ScreenElementExists \{id = hud_root}
		hud_root :SE_SetProps \{hide}
	endif
	VocalsHighway_GetId \{player = 1}
	if ScreenElementExists id = <vocals_highway_id>
		<vocals_highway_id> :Desc_ResolveAlias name = alias_now_bar param = now_bar
		<now_bar> :SE_SetProps hide
		<vocals_highway_id> :Desc_ResolveAlias name = alias_static_note_scale param = static_note_scale
		<static_note_scale> :SE_SetProps hide
		<vocals_highway_id> :Desc_ResolveAlias name = alias_static_phrase_start param = static_phrase_start
		<static_phrase_start> :SE_SetProps hide
		<vocals_highway_id> :Desc_ResolveAlias name = alias_static_phrase_end param = static_phrase_end
		<static_phrase_end> :SE_SetProps hide
		<vocals_highway_id> :SE_SetProps lyrics_bg_alpha = 0.0
		<vocals_highway_id> :SE_SetProps static_next_phrase_bg_alpha = 0.0
		<vocals_highway_id> :SE_SetProps border_rgba = [0 0 0 0]
		<vocals_highway_id> :SE_SetProps static_window_alpha = 0.0
		<vocals_highway_id> :SE_SetProps Bg_accent_alpha = 0.0
		<vocals_highway_id> :SE_SetProps Bg_alpha = 0.0
	endif
	change \{Cheat_Invincible = 1}
	Wait \{1
		gameframe}
	repeat
endscript

script ui_sing_a_long_back 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	SE_SetProps \{block_events}
	GetSingleTag \{back_state}
	if NOT GotParam \{back_state}
		back_state = UIstate_mainmenu
	endif
	ui_event_wait_for_safe
	generic_event_back state = <back_state>
endscript

script ui_sing_a_long_start 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}


	ui_event_get_top
	FormatText checksumname = back_state 'uistate_%b' b = <base_name>
	generic_event_choose state = uistate_sing_a_long data = {song = <song> venue = <venue> back_state = <back_state>}
endscript

script ui_sing_a_long_band_override 
endscript
