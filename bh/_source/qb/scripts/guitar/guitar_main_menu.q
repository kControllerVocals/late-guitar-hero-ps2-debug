g_mainmenu_text = {
}
g_career_intro_viewed = 0

script mainmenu_populate_menu_options_global 
	mainmenu_text = {
		career = {
			menu_item_text = qs("CAREER")
			helper_text = qs("EARN STARS AND TRAVEL THE GLOBE!")
		}
		quickplay = {
			menu_item_text = qs("QUICKPLAY")
			helper_text = qs("PLAY SONGS, SAVE SCORES AND CLIMB THE RANKS.")
		}
		freeplay = {
			menu_item_text = qs(0x2406ab68)
			helper_text = qs(0xa39e4e93)
		}
		singalong = {
			menu_item_text = qs("SING-ALONG")
			helper_text = qs(0x601382c4)
		}
		training = {
			menu_item_text = qs("TRAINING")
			helper_text = qs("LEARN THE ROPES OF BAND HERO.")
		}
		multiplayer = {
			menu_item_text = qs("HEAD TO HEAD")
			helper_text = qs(0x18dea7fd)
		}
		creator = {
			menu_item_text = qs("ROCK STAR CREATOR")
			helper_text = qs("CREATE YOUR VERY OWN DIGITAL ROCK GOD.")
		}
		options = {
			menu_item_text = qs("OPTIONS")
			helper_text = qs(0x47e44fbd)
		}
		top_rockers = {
			menu_item_text = qs("TOP ROCKERS")
			helper_text = qs("CHECK OUT HOW YOU RANK IN THE ROCK ARENA.")
		}
		debugmenu = {
			menu_item_text = qs("\L(debug menu)")
			helper_text = qs(0xac8b0f84)
		}
	}
	change g_mainmenu_text = <mainmenu_text>
endscript
force_mainmenu_signin = 0

script fix_primary_controller_for_autolaunch 
	if (($primary_controller) = -1)
		change \{primary_controller = 0}
	endif
endscript

script create_main_menu 
	change \{respond_to_signin_changed = 0}
	reset_quickplay_song_list
	cas_destroy_all_characters
	reset_character_ids
	sanity_check_fix_deleted_characters
	band_builder_clear_random_appearances
	destroy_band
	frontend_load_soundcheck
	clear_exclusive_devices
	SetMenuAutoRepeatTimes \{(0.3, 0.1)}
	disable_pause
	UnPauseGame
	change \{check_for_unplugged_controllers = 1}
	change \{current_num_players = 1}
	GetPlayerInfo \{1
		controller}
	if (<controller> != ($primary_controller))
		found = 0
		player = 2
		begin
		GetPlayerInfo <player> controller
		if (<controller> = ($primary_controller))
			GetPlayerInfo \{1
				controller}
			SetPlayerInfo 1 controller = ($primary_controller)
			SetPlayerInfo <player> controller = <controller>
			swap_player_status_elements player_A = 1 player_B = <player> lefty_flip
			found = 1
			break
		endif
		player = (<player> + 1)
		repeat 3
		if (<found> = 0)
			change structurename = player1_status controller = ($primary_controller)
		endif
	endif
	disable_pause
	spawnscriptnow \{menu_music_on}
	if ($is_demo_mode = 1)
		demo_mode_disable = {rgba = [128 128 128 255] not_focusable}
	else
		demo_mode_disable = {}
	endif
	change \{should_reset_gig_posters_selection = 1}
	change \{current_song = $startup_song}
	change \{end_credits = 0}
	change \{rich_presence_context = presence_menus}
	change \{player1_device = 0}
	change \{player2_device = 1}
	change \{player3_device = 2}
	change \{player4_device = 3}
	change \{current_gig_number = 1}
	change \{current_progression_flag = none}
	change \{options_for_manage_band = 0}
	if ($autolaunch_cas = 1 || $autolaunch_cas_artist = 1)
		change \{autolaunch_cas = 0}
		fix_primary_controller_for_autolaunch
		SpawnScriptLater main_menu_select_cas params = {device_num = ($primary_controller)}
	endif
	spawnscriptnow \{menu_music_fade
		params = {
			in
			time = 0.01
		}}
endscript

script spawn_later 
	SpawnScriptLater spawn_later_spawned params = {<...>}
endscript

script spawn_later_spawned 
	Wait \{2
		gameframes}
	SpawnScriptLater <...>
endscript

script mainmenu_focus 
	Obj_GetID
	GetTags
	if NOT current_menu :GetSingleTag \{color_scheme}
		SE_SetProps \{rgba = [
				0
				0
				0
				255
			]}
	else
		SE_SetProps {
			rgba = (<color_scheme>.text_focus_color)
			font = (<color_scheme>.text_focus_font)
		}
	endif
	if current_menu_anchor :Desc_ResolveAlias \{name = alias_highlight}
		Wait \{2
			gameframe}
		<ObjID> :SE_GetParentId
		<parent_id> :SE_GetProps
		hscale = ((1.0, 0.0).<scale>)
		GetScreenElementDims id = <ObjID>
		<width> = (<width> * <hscale>)
		extend = 25.0
		scale = (((1.0, 0.0) * (((<width> + (<extend> * 2)) / 256.0))) + (0.0, 1.5))
		GetScreenElementPosition id = <ObjID> summed
		<resolved_id> :SE_SetProps pos = {absolute <screenelementpos>} scale = <scale>
		<resolved_id> :SE_WaitProps
		GetScreenElementPosition id = <ObjID> summed
		<resolved_id> :SE_SetProps pos = {absolute (<screenelementpos> + (0.0, -10.0))} time = 0.05
		<resolved_id> :SE_WaitProps
		GetScreenElementPosition id = <ObjID> summed
		<resolved_id> :SE_SetProps pos = {absolute <screenelementpos>} scale = <scale> time = 0.05
		<resolved_id> :SE_WaitProps
	endif
endscript

script mainmenu_unfocus 
	if NOT current_menu :GetSingleTag \{color_scheme}
		SE_SetProps \{rgba = [
				255
				255
				255
				255
			]}
	else
		SE_SetProps {
			rgba = (<color_scheme>.text_color)
			font = (<color_scheme>.text_font)
		}
	endif
endscript

script highlight_motion_worker 

	if GetScreenElementChildren id = <highlight_container_id>
		if GetScreenElementChildren id = (<children> [0])
			if GetScreenElementChildren id = (<children> [0])
				go_up = [1 1]
				movement = [(0.0, 5.0) (0.0, 3.0)]
				bounce = [0.15 0.1]
				(<children> [0]) :SE_SetProps pos = (-0.5 * (<movement> [0]))
				(<children> [1]) :SE_SetProps pos = (-0.5 * (<movement> [1]))
				begin
				i = 0
				begin
				if NOT (<children> [<i>]) :SE_IsMorphing
					if (<go_up> [<i>])
						(<children> [<i>]) :SE_SetProps time = (<bounce> [<i>]) pos = (<movement> [<i>])
						SetArrayElement ArrayName = go_up index = <i> newvalue = 0
					else
						(<children> [<i>]) :SE_SetProps time = (<bounce> [<i>]) pos = (-1.0 * (<movement> [<i>]))
						SetArrayElement ArrayName = go_up index = <i> newvalue = 1
					endif
				endif
				i = (<i> + 1)
				repeat 2
				Wait \{1
					gameframes}
				repeat
			endif
		endif
	endif
endscript

script highlight_motion \{menu_id = current_menu_anchor
		alias_name = alias_highlight}
	if <menu_id> :Desc_ResolveAlias name = <alias_name>
		highlight_motion_worker highlight_container_id = <resolved_id>
	endif
endscript

script create_main_menu_elements 
	qi_clear_object
	if NOT ($invite_controller = -1)
		return
	endif
	CreateScreenElement \{parent = root_window
		id = mainmenu_id
		type = DescInterface
		desc = 'mainmenu'
		tags = {
			motd_id = none
		}}
	ui_create_particle_circle \{z_offset = 18.0}
	get_frontend_venue_checksum \{venue = $current_level}
	CreateScreenElement \{type = SpriteElement
		id = mainmenu_background_id
		parent = mainmenu_id
		rgba = [
			255
			255
			255
			255
		]
		pos = (640.0, 360.0)
		just = [
			center
			center
		]
		dims = (1280.0, 720.0)
		z_priority = 9.0
		texture = song_summary_bg}
	mainmenu_setup_physics_elements \{screen_id = mainmenu_id}
	mainmenu_setup_option \{choose_script = main_menu_select_quickplay
		choose_params = {
			lobby_mode = quickplay
		}
		menu_item = quickplay}
	mainmenu_setup_option \{choose_script = main_menu_select_freeplay
		menu_item = freeplay}
	mainmenu_setup_option \{choose_script = main_menu_select_singalong
		menu_item = singalong}
	mainmenu_setup_option \{choose_script = main_menu_select_career
		choose_params = {
			lobby_mode = career
		}
		menu_item = career}
	mainmenu_setup_option \{choose_script = main_menu_select_options
		menu_item = options}
	mainmenu_setup_option \{choose_script = main_menu_select_top_rockers
		menu_item = top_rockers}
	mainmenu_setup_option \{choose_script = main_menu_select_cas
		menu_item = creator}
	mainmenu_setup_option \{choose_script = main_menu_select_training
		menu_item = training}
	mainmenu_setup_option \{choose_script = main_menu_select_multiplayer
		menu_item = multiplayer}
	show_debug_menus = 0
	if ($enable_button_cheats = 1)
		<show_debug_menus> = 1
		if ($enable_debug_menus = 0)
			<show_debug_menus> = 0
		endif
	endif
	if (<show_debug_menus>)
		mainmenu_setup_option \{choose_script = main_menu_select_debug
			menu_item = debugmenu}
	endif
	change \{is_freeplay_mode = 0}
	change \{is_partyplay_mode = 0}
	change \{is_singalong_mode = 0}
	current_menu :SE_SetProps \{event_handlers = [
			{
				pad_option2
				main_menu_select_partyplay
			}
		]}
	set_focus_color
	set_unfocus_color
endscript

script mainmenu_setup_physics_elements 

	create_2D_spring_system desc_id = <screen_id> num_springs = 2 stiffness = 50 rest_length = 1
	if <screen_id> :Desc_ResolveAlias name = alias_skull_add_container param = skull_add_id
		<skull_add_id> :obj_spawnscript ui_shakey
	else

	endif
	if <screen_id> :Desc_ResolveAlias name = alias_skull_add_container param = skull_add_id
		<skull_add_id> :obj_spawnscript ui_frazzmatazz
	else

	endif
	if <screen_id> :Desc_ResolveAlias name = alias_logo_container param = gh5_logo_id
		<gh5_logo_id> :obj_spawnscript ui_alphaflight
	else

	endif
	if <screen_id> :Desc_ResolveAlias name = alias_mainmenu_up_arrow
		arrow_up_id = <resolved_id>
	else

	endif
	if <screen_id> :Desc_ResolveAlias name = alias_mainmenu_down_arrow
		arrow_down_id = <resolved_id>
	else

	endif
	if <screen_id> :Desc_ResolveAlias name = alias_mainmenu_vmenu
		AssignAlias id = <resolved_id> alias = current_menu
		current_menu :SetTags \{smooth_morph_time = 0.1}
		<event_handlers> = [
			{pad_up mainmenu_pad_up params = {arrow_id = <arrow_up_id>}}
			{pad_up SmoothMenuScroll params = {dir = -1 isVertical = true}}
			{pad_down SmoothMenuScroll params = {dir = 1 isVertical = true}}
			{pad_down mainmenu_pad_down params = {arrow_id = <arrow_down_id>}}
		]
		current_menu :SE_SetProps event_handlers = <event_handlers>
	else

	endif
endscript

script mainmenu_setup_option 
	if ScreenElementExists \{id = mainmenu_id}

		menu_item_text = ($g_mainmenu_text.<menu_item>.menu_item_text)
	else

	endif
	CreateScreenElement {
		type = DescInterface
		parent = current_menu
		desc = 'menurow_txt_desc'
		autoSizeDims = true
		menurow_txt_item_text = <menu_item_text>
		menurow_txt_item_font = fontgrid_title_a1
		menurow_txt_item_rgba = ($menu_unfocus_color)
	}
	if GotParam \{blank_entry}
		<id> :SE_SetProps {
			not_focusable
		}
	elseif GotParam \{not_focusable}
		<id> :SE_SetProps {
			not_focusable
			menurow_txt_item_rgba = [64 64 64 255]
		}
	else
		if ScreenElementExists \{id = mainmenu_id}
			<id> :SetTags {
				menu_item = <menu_item>
			}
		elseif GotParam \{helper_text}

			<id> :SetTags {
				helper_text = <helper_text>
				screen_id = <screen_id>
			}
		endif
		array = [
			{focus mainmenu_item_focus}
			{unfocus mainmenu_item_unfocus}
		]
		if GotParam \{choose_state}
			AddArrayElement array = <array> element = {pad_choose generic_event_choose params = {state = <choose_state> data = {<choose_params>}}}
		elseif GotParam \{choose_script}
			AddArrayElement array = <array> element = {pad_choose <choose_script> params = {<choose_params>}}
		endif
		if GotParam \{back_state}
			AddArrayElement array = <array> element = {pad_back generic_event_back params = {state = <back_state>}}
		elseif GotParam \{back_script}
			AddArrayElement array = <array> element = {pad_back <back_script>}
		endif
		<id> :SE_SetProps event_handlers = <array>
	endif
	return mainmenu_item_id = <id>
endscript

script mainmenu_item_focus \{time = 0.05
		grow_scale = 1.5}
	if NOT GotParam \{id}
		Obj_GetID
		<id> = <ObjID>
	endif
	if ScreenElementExists \{id = mainmenu_id}
		if <id> :GetSingleTag menu_item
			mainmenu_id :SE_SetProps mainmenu_helper_text_text = ($g_mainmenu_text.<menu_item>.helper_text)
		endif
	else
		<id> :GetTags
		if GotParam \{helper_text}
			<screen_id> :SE_SetProps mainmenu_helper_text_text = <helper_text>
		endif
	endif
	<id> :SE_SetProps {
		menurow_scale = <grow_scale>
		menurow_txt_item_font = fontgrid_title_a1
		menurow_txt_item_rgba = ($menu_focus_color)
		motion = ease_in
		time = <time>
	}
endscript

script mainmenu_item_unfocus \{time = 0.05}
	if NOT GotParam \{id}
		Obj_GetID
		<id> = <ObjID>
	endif
	<id> :SE_SetProps {
		menurow_scale = 1.0
		menurow_txt_item_font = fontgrid_title_a1
		menurow_txt_item_rgba = ($menu_unfocus_color)
		motion = ease_in
		time = <time>
	}
endscript

script mainmenu_pad_up 

	generic_menu_up_or_down_sound \{up}
	<arrow_id> :obj_spawnscript mainmenu_do_scroll_glow
	<arrow_id> :obj_spawnscript mainmenu_do_arrow_pulse
endscript

script mainmenu_pad_down 

	generic_menu_up_or_down_sound \{down}
	<arrow_id> :obj_spawnscript mainmenu_do_scroll_glow
	<arrow_id> :obj_spawnscript mainmenu_do_arrow_pulse params = {down}
endscript

script mainmenu_do_arrow_pulse 
	Obj_GetID
	<ObjID> :SE_SetProps hiddenLocal = true
	CreateScreenElement {
		type = SpriteElement
		parent = <ObjID>
		texture = Dropdown_Arrow
		dims = (40.0, 40.0)
		pos = (20.0, 15.0)
		just = [center center]
		rgba = [225 , 225 , 225 , 200]
		z_priority = 112
	}
	if GotParam \{down}
		<id> :SE_SetProps flip_h
		<id> :SE_SetProps pos = {(0.0, 9.0) relative}
	endif
	<id> :SE_SetProps scale = 1.3 time = 0.01 relative_scale
	<id> :SE_WaitProps
	<id> :SE_SetProps scale = 1.0 time = 0.1 relative_scale
	<id> :SE_WaitProps
	<ObjID> :SE_SetProps hiddenLocal = false
	DestroyScreenElement id = <id>
endscript

script mainmenu_do_scroll_glow 
	Obj_GetID
	CreateScreenElement {
		type = SpriteElement
		parent = <ObjID>
		texture = circle_gradient_64
		dims = (64.0, 64.0)
		pos = (20.0, 15.0)
		rgba = [255 215 0 255]
		just = [center center]
		z_priority = 100
		alpha = 0.2
		blend = Add
	}
	<id> :SE_SetProps scale = 1.2 relative_scale
	<id> :SE_SetProps scale = (Random (@ 2.0 @ 2.5 @ 3.0 )) alpha = 0.0 time = 0.2 relative_scale motion = ease_out
	<id> :SE_WaitProps
	DestroyScreenElement id = <id>
endscript

script destroy_main_menu 
	generic_ui_destroy
	destroy_viewport_ui
	ui_destroy_particle_circle
	DestroyScreenElement \{id = mainmenu_id}
endscript

script main_menu_select_partyplay 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	change \{band_mode_mode = quickplay}
	change \{game_mode = p1_quickplay}
	change \{current_num_players = 1}
	change \{in_join_band_screens = 1}
	change \{is_partyplay_mode = 1}
	main_menu_select_generic device_num = <device_num> state = uistate_game_mode data = {mode = partyplay}
endscript

script main_menu_select_career 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	change \{game_mode = gh4_p1_career}
	if NOT current_band_has_band_name
		if NOT ($g_career_intro_viewed)
			SpawnScript \{main_menu_play_career_intro}
		endif
	endif
	main_menu_select_generic device_num = <device_num> state = uistate_game_mode data = {use_all_controllers}
endscript

script main_menu_play_career_intro 
	ui_event_wait_for_safe
	Menu_Music_Off
	PlayMovieAndWait \{movie = 'career_intro'
		noblack
		focus}
	get_movie_id_by_name \{movie = 'career_intro'}
	SetGlobalTags <id> params = {unlocked = 1} all_active_players = 1
	change \{g_career_intro_viewed = 1}
	menu_music_on
endscript

script main_menu_select_quickplay 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	main_menu_select_generic device_num = <device_num> state = uistate_game_mode data = {mode = quickplay}
endscript

script main_menu_select_freeplay 
	change \{band_mode_mode = quickplay}
	change \{game_mode = p1_quickplay}
	change \{current_num_players = 1}
	change \{in_join_band_screens = 1}
	change \{is_freeplay_mode = 1}
	main_menu_select_generic device_num = <device_num> state = uistate_game_mode data = {mode = freeplay}
endscript

script main_menu_select_singalong 
	GetActiveControllers
	GetArraySize <active_controllers>
	if GotParam \{device_num}
		change primary_controller = <device_num>
		change last_start_pressed_device = <device_num>
	endif
	i = 0
	vocal_player = 0
	has_instrument_controller = 0
	begin
	if (<active_controllers> [<i>] = 1)
		if is_regular_controller controller = <i>
			if ($primary_controller = <i>)
				if IsMicrophonePluggedIn
					vocal_player = 1
				endif
			endif
		else
			has_instrument_controller = 1
		endif
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	if (<vocal_player> = 0)
		SoundEvent \{UI_SFX_Negative_Select}
		if IsPAL
			ui_event_wait \{event = menu_change
				data = {
					state = UIstate_generic_alert_popup
					is_popup
					title = qs("NOTICE")
					text = qs(0xbc7fe356)
				}}
		else
			ui_event_wait \{event = menu_change
				data = {
					state = UIstate_generic_alert_popup
					is_popup
					title = qs("NOTICE")
					text = qs(0x5a57b2b6)
				}}
		endif
	else
		change \{band_mode_mode = quickplay}
		change \{is_freeplay_mode = 1}
		change \{is_singalong_mode = 1}
		change \{structurename = player1_status
			part = Vocals}
		set_primary_controller device_num = <device_num> state = uistate_setlist data = {mode = freeplay}
	endif
endscript

script main_menu_select_multiplayer 
	generic_menu_pad_choose_sound
	if ScriptIsRunning \{menu_transition_in_spawned}
		KillSpawnedScript \{name = menu_transition_in_spawned}
	endif
	if ScriptIsRunning \{menu_transition_in}
		KillSpawnedScript \{name = menu_transition_in}
	endif
	GetActiveControllers
	GetArraySize <active_controllers>
	if GotParam \{device_num}
		change primary_controller = <device_num>
	endif
	i = 0
	guitar_count = 0
	drum_count = 0
	begin
	if (<active_controllers> [<i>] = 1)
		ui_options_get_controller_type controller = <i>
		switch (<type>)
			case guitar
			<guitar_count> = (<guitar_count> + 1)
			case Drums
			<drum_count> = (<drum_count> + 1)
		endswitch
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	if ((<guitar_count> < 2) && (<drum_count> < 2))
		ui_event_wait \{event = menu_change
			data = {
				state = UIstate_generic_alert_popup
				is_popup
				title = qs("NOTICE")
				text = qs(0x11a0bfa9)
			}}
	else
		spawnscriptnow main_menu_continue_multiplayer params = {<...>}
	endif
endscript

script main_menu_continue_multiplayer 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	change \{game_mode = p2_pro_faceoff}
	change \{current_num_players = 2}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	change \{Cheat_FreeDrum = 0}
	GetArraySize \{$guitar_hero_cheats}
	i = 0
	begin
	if ($guitar_hero_cheats [<i>].name = 'FreeDrum')
		SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = <i> newvalue = 0
		GetGlobalTags \{user_options}
		FormatText checksumname = cheat_idx 'cheat_index%a' a = <i>
		AddParam structure_name = params name = <cheat_idx> value = 0
		SetGlobalTags user_options params = <params>
		break
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	main_menu_select_generic device_num = <device_num> state = uistate_select_controller
endscript

script main_menu_select_jam 
	Unload_gempaks
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	change \{respond_to_signin_changed = 1}
	set_primary_controller device_num = <device_num> state = uistate_jam
	spawnscriptnow \{menu_music_fade
		params = {
			time = 8.160001
			out
			dont_fade_crowd
		}}
	Wait \{1
		seconds}
	BG_Crowd_Front_End_Silence \{immediate = 1}
endscript

script main_menu_select_cas device_num = ($primary_controller)
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	set_primary_controller device_num = <device_num> state = uistate_character_selection data = {from_main_menu = 1}
endscript

script main_menu_select_training 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	change \{game_mode = practice}
	change \{current_num_players = 1}
	change \{came_to_practice_from = main_menu}
	change \{came_to_practice_from_progression = none}
	change \{came_to_practice_character_id = EmptyGuy}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	set_primary_controller device_num = <device_num> state = uistate_select_practice_mode data = <...>
endscript

script main_menu_select_options 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	set_primary_controller device_num = <device_num> state = uistate_options
endscript

script main_menu_select_top_rockers 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	setup_top_rockers_single device_num = <device_num>
endscript

script main_menu_select_debug 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	generic_event_choose \{state = uistate_debug}
endscript

script main_menu_select_generic 

	change primary_controller = <device_num>
	change last_start_pressed_device = <device_num>
	if ScreenElementExists \{id = current_menu}
		LaunchEvent \{type = unfocus
			target = current_menu}
	endif
	generic_event_choose state = <state> data = {<data>}
endscript

script set_primary_controller \{event = menu_change}

	if ScreenElementExists \{id = current_menu}
		LaunchEvent \{type = unfocus
			target = current_menu}
	endif
	if ((GotParam force) || ($force_mainmenu_signin = 1))
		change \{primary_controller = -1}
		change \{last_start_pressed_device = -1}
		change \{force_mainmenu_signin = 0}
	endif
	change \{respond_to_signin_changed = 1}
	change \{signin_jam_mode = 0}
	GetPlayerInfo \{1
		controller}
	if (<controller> != <device_num>)
		player = 2
		begin
		GetPlayerInfo <player> controller
		if (<controller> = <device_num>)
			GetPlayerInfo \{1
				controller}
			SetPlayerInfo 1 controller = <device_num>
			SetPlayerInfo <player> controller = <controller>
			swap_player_status_elements player_A = 1 player_B = <player> lefty_flip
			break
		endif
		player = (<player> + 1)
		repeat 3
	endif
	if ($current_num_players = 1)
		if (<device_num> > -1)
			SetPlayerInfo 1 controller = <device_num>
		endif
	endif
	if GotParam \{jam}
		if ($jam_view_cam_created = 1)

		endif
		change \{signin_jam_mode = 1}
		generic_event_choose event = <event> state = uistate_signin data = {device_num = <device_num> allow_back = 1 new_state = <state> new_data = <data> jam = 1 require_live = <require_live>}
	else
		assign_new_primary_controller device_num = <device_num>
		generic_event_choose event = <event> no_sound state = <state> data = <data>
	endif
endscript
force_pak_caching = 0
disable_pak_caching = 0

script frontend_load_soundcheck \{async = 1}

	if GetPakManCurrent \{map = zones}

		if NOT (<pak> = z_soundcheck)
			load_soundcheck = 1
		endif
		if NOT GotParam \{load_soundcheck}
			if NOT IsTextureLoaded \{id = main_menu_skull}
				load_soundcheck = 1
			endif
		endif
	endif
	if NOT frontend_anim_paks_are_loaded
		load_anims = 1
	endif
	if ((GotParam load_soundcheck) || (GotParam load_anims))
		needs_loading_screen = 1
		if PakFilesAreCached
			needs_loading_screen = 0
			if NOT frontend_anim_paks_are_loaded
				needs_loading_screen = 1
			endif
		endif
		if GotParam \{loadingscreen}
			if (<needs_loading_screen> = 1)
				create_loading_screen \{keep_menu_music}
			else
				hide_glitch \{num_frames = 3}
			endif
		endif
		if NOT IsPs3 \{testkit}
			if NOT PakFilesAreCached
				if ((CD) || ($force_pak_caching = 1))
					if ($disable_pak_caching = 0)
						if CachePakFiles
							Block \{untilevent = cache_pak_files_loaded}
						endif
					endif
				endif
			endif
		endif
		if GotParam \{load_soundcheck}
			get_frontend_venue_checksum \{venue = $current_level}
			if PakFilesAreCached
				SetPakManCurrentBlock map = zones pak = <prefix_crc> block_scripts = 1
			else
				SetPakManCurrentBlock map = zones pak = <prefix_crc> block_scripts = (<async> - 1)
			endif
		endif
		LoadVenueVideo \{pn = z_soundcheck}
		if GotParam \{load_anims}
			anim_paks_set_state \{state = FrontEnd
				async = 0}
		endif
		if NOT GotParam \{gigboard}
			hide_glitch \{num_frames = 30}
		endif
		if GotParam \{loadingscreen}
			if (<needs_loading_screen> = 1)
				destroy_loading_screen
			endif
		endif
	endif
endscript

script reset_character_ids 

	change \{structurename = player1_status
		character_id = judy}
	change \{structurename = player2_status
		character_id = judy}
	change \{structurename = player3_status
		character_id = judy}
	change \{structurename = player4_status
		character_id = judy}
endscript
