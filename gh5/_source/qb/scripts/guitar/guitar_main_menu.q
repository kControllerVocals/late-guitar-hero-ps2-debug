g_mainmenu_text = {
}
0x76b71b2a = 0

script mainmenu_populate_menu_options_global 
	mainmenu_text = {
		career = {
			menu_item_text = qs(0xde7ec8b3)
			helper_text = qs(0x3a276c3f)
		}
		quickplay = {
			menu_item_text = qs(0xfabdce2b)
			helper_text = qs(0x2d615275)
		}
		freeplay = {
			menu_item_text = qs(0x2406ab68)
			helper_text = qs(0xa39e4e93)
		}
		training = {
			menu_item_text = qs(0xd093953b)
			helper_text = qs(0x1d06e07b)
		}
		multiplayer = {
			menu_item_text = qs(0xfef0f891)
			helper_text = qs(0x18dea7fd)
		}
		music_store = {
			menu_item_text = qs(0xa8e9637f)
			helper_text = qs(0xb21014b9)
		}
		music_central = {
			menu_item_text = qs(0x79dfdd25)
			helper_text = qs(0x8d02ba13)
		}
		creator = {
			menu_item_text = qs(0x9f894c1e)
			helper_text = qs(0x351586ce)
		}
		options = {
			menu_item_text = qs(0x976cf9e7)
			helper_text = qs(0xce7f2ae9)
		}
		top_rockers = {
			menu_item_text = qs(0x88572463)
			helper_text = qs(0xb1e36b7c)
		}
		debugmenu = {
			menu_item_text = qs(0x4a5146a0)
			helper_text = qs(0x8cd7a038)
		}
		motd = {
			menu_item_text = qs(0x3e13521a)
			helper_text = qs(0x11d60d78)
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
	closesonglogfile
	reset_quickplay_song_list
	cas_destroy_all_characters
	reset_character_ids
	sanity_check_fix_deleted_characters
	band_builder_clear_random_appearances
	destroy_band
	destroy_bandname_viewport
	frontend_load_soundcheck
	clear_exclusive_devices
	setmenuautorepeattimes \{(0.3, 0.1)}
	disable_pause
	unpausegame
	change \{check_for_unplugged_controllers = 1}
	change \{current_num_players = 1}
	getplayerinfo \{1
		controller}
	if (<controller> != ($primary_controller))
		found = 0
		player = 2
		begin
		getplayerinfo <player> controller
		if (<controller> = ($primary_controller))
			getplayerinfo \{1
				controller}
			setplayerinfo 1 controller = ($primary_controller)
			setplayerinfo <player> controller = <controller>
			swap_player_status_elements player_a = 1 player_b = <player> lefty_flip
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
	change \{setlist_previous_tier = 1}
	change \{setlist_previous_song = 0}
	change \{setlist_previous_tab = tab_setlist}
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
		spawnscriptlater main_menu_select_cas params = {device_num = ($primary_controller)}
	endif
	spawnscriptnow \{menu_music_fade
		params = {
			in
			time = 0.01
		}}
endscript

script 0xe40c3ad9 
	spawnscriptlater 0xa7d50a03 params = {<...>}
endscript

script 0xa7d50a03 
	wait \{2
		gameframes}
	spawnscriptlater <...>
endscript

script mainmenu_focus 
	obj_getid
	gettags
	se_setprops \{rgba = [
			0
			0
			0
			255
		]}
	if current_menu_anchor :desc_resolvealias \{name = alias_highlight}
		wait \{2
			gameframe}
		<objid> :se_getparentid
		<parent_id> :se_getprops
		hscale = ((1.0, 0.0).<scale>)
		getscreenelementdims id = <objid>
		<width> = (<width> * <hscale>)
		0xc446b6d3 = 25.0
		scale = (((1.0, 0.0) * (((<width> + (<0xc446b6d3> * 2)) / 256.0))) + (0.0, 1.5))
		getscreenelementposition id = <objid> summed
		<resolved_id> :se_setprops pos = {absolute <screenelementpos>} scale = <scale>
		<resolved_id> :se_waitprops
		getscreenelementposition id = <objid> summed
		<resolved_id> :se_setprops pos = {absolute (<screenelementpos> + (0.0, -10.0))} time = 0.05
		<resolved_id> :se_waitprops
		getscreenelementposition id = <objid> summed
		<resolved_id> :se_setprops pos = {absolute <screenelementpos>} scale = <scale> time = 0.05
		<resolved_id> :se_waitprops
	endif
endscript

script mainmenu_unfocus 
	se_setprops \{rgba = [
			255
			255
			255
			255
		]}
endscript

script 0x63332911 

	if getscreenelementchildren id = <0x638b9bc5>
		if getscreenelementchildren id = (<children> [0])
			if getscreenelementchildren id = (<children> [0])
				0x1427d1e8 = [1 1]
				movement = [(0.0, 5.0) (0.0, 3.0)]
				bounce = [0.15 0.1]
				(<children> [0]) :se_setprops pos = (-0.5 * (<movement> [0]))
				(<children> [1]) :se_setprops pos = (-0.5 * (<movement> [1]))
				begin
				i = 0
				begin
				if NOT (<children> [<i>]) :se_ismorphing
					if (<0x1427d1e8> [<i>])
						(<children> [<i>]) :se_setprops time = (<bounce> [<i>]) pos = (<movement> [<i>])
						setarrayelement arrayname = 0x1427d1e8 index = <i> newvalue = 0
					else
						(<children> [<i>]) :se_setprops time = (<bounce> [<i>]) pos = (-1.0 * (<movement> [<i>]))
						setarrayelement arrayname = 0x1427d1e8 index = <i> newvalue = 1
					endif
				endif
				i = (<i> + 1)
				repeat 2
				wait \{1
					gameframes}
				repeat
			endif
		endif
	endif
endscript

script highlight_motion \{menu_id = current_menu_anchor
		alias_name = alias_highlight}
	if <menu_id> :desc_resolvealias name = <alias_name>
		0x63332911 0x638b9bc5 = <resolved_id>
	endif
endscript

script create_main_menu_elements 
	0xc0a98a59
	if NOT ($invite_controller = -1)
		return
	endif
	createscreenelement \{parent = root_window
		id = mainmenu_id
		type = descinterface
		desc = 'mainmenu'
		tags = {
			motd_id = none
		}}
	0x72fc1318 \{venue = $current_level}
	formattext checksumname = background_texture 'background_%z' z = <prefix>
	createscreenelement {
		type = spriteelement
		id = 0x3b92a71e
		parent = mainmenu_id
		rgba = [255 255 255 255]
		pos = (640.0, 360.0)
		just = [center center]
		dims = (1280.0, 720.0)
		z_priority = 1
		texture = <background_texture>
	}
	mainmenu_setup_physics_elements \{screen_id = mainmenu_id}
	mainmenu_setup_option \{choose_script = main_menu_select_quickplay
		choose_params = {
			lobby_mode = quickplay
		}
		menu_item = quickplay}
	mainmenu_setup_option \{choose_script = main_menu_select_freeplay
		menu_item = freeplay}
	mainmenu_setup_option \{choose_script = main_menu_select_career
		choose_params = {
			lobby_mode = career
		}
		menu_item = career}
	mainmenu_setup_option \{choose_script = main_menu_select_options
		menu_item = options}
	mainmenu_setup_option \{choose_script = 0x3abe2710
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
	change \{0x9b2cba3f = 0}
	change \{0xc7e670d7 = 0}
	current_menu :se_setprops \{event_handlers = [
			{
				pad_option2
				0x858b117f
			}
		]}
	set_focus_color
	set_unfocus_color
endscript

script mainmenu_setup_physics_elements 

	create_2d_spring_system desc_id = <screen_id> num_springs = 2 stiffness = 50 rest_length = 1
	if <screen_id> :desc_resolvealias name = alias_skull_add_container param = skull_add_id
		<skull_add_id> :obj_spawnscript ui_shakey
	else

	endif
	if <screen_id> :desc_resolvealias name = alias_skull_add_container param = skull_add_id
		<skull_add_id> :obj_spawnscript ui_frazzmatazz
	else

	endif
	if <screen_id> :desc_resolvealias name = alias_logo_container param = gh5_logo_id
		<gh5_logo_id> :obj_spawnscript ui_alphaflight
	else

	endif
	if <screen_id> :desc_resolvealias name = alias_mainmenu_up_arrow
		arrow_up_id = <resolved_id>
	else

	endif
	if <screen_id> :desc_resolvealias name = alias_mainmenu_down_arrow
		arrow_down_id = <resolved_id>
	else

	endif
	if <screen_id> :desc_resolvealias name = alias_mainmenu_vmenu
		assignalias id = <resolved_id> alias = current_menu
		current_menu :settags \{smooth_morph_time = 0.1}
		<event_handlers> = [
			{pad_up mainmenu_pad_up params = {arrow_id = <arrow_up_id>}}
			{pad_up smoothmenuscroll params = {dir = -1 isvertical = true}}
			{pad_down smoothmenuscroll params = {dir = 1 isvertical = true}}
			{pad_down mainmenu_pad_down params = {arrow_id = <arrow_down_id>}}
		]
		current_menu :se_setprops event_handlers = <event_handlers>
	else

	endif
endscript

script mainmenu_setup_option 
	if screenelementexists \{id = mainmenu_id}

		menu_item_text = ($g_mainmenu_text.<menu_item>.menu_item_text)
	else

	endif
	createscreenelement {
		type = descinterface
		parent = current_menu
		desc = 'menurow_txt_desc'
		autosizedims = true
		menurow_txt_item_text = <menu_item_text>
		menurow_txt_item_font = fontgrid_title_a1
		menurow_txt_item_rgba = ($menu_unfocus_color)
	}
	if gotparam \{blank_entry}
		<id> :se_setprops {
			not_focusable
		}
	elseif gotparam \{not_focusable}
		<id> :se_setprops {
			not_focusable
			menurow_txt_item_rgba = [64 64 64 255]
		}
	else
		if screenelementexists \{id = mainmenu_id}
			<id> :settags {
				menu_item = <menu_item>
			}
		elseif gotparam \{helper_text}

			<id> :settags {
				helper_text = <helper_text>
				screen_id = <screen_id>
			}
		endif
		array = [
			{focus mainmenu_item_focus}
			{unfocus mainmenu_item_unfocus}
		]
		if gotparam \{choose_state}
			addarrayelement array = <array> element = {pad_choose generic_event_choose params = {state = <choose_state> data = {<choose_params>}}}
		elseif gotparam \{choose_script}
			addarrayelement array = <array> element = {pad_choose <choose_script> params = {<choose_params>}}
		endif
		if gotparam \{back_state}
			addarrayelement array = <array> element = {pad_back generic_event_back params = {state = <back_state>}}
		elseif gotparam \{back_script}
			addarrayelement array = <array> element = {pad_back <back_script>}
		endif
		<id> :se_setprops event_handlers = <array>
	endif
	return mainmenu_item_id = <id>
endscript

script mainmenu_item_focus \{time = 0.05
		grow_scale = 1.5}
	if NOT gotparam \{id}
		obj_getid
		<id> = <objid>
	endif
	if screenelementexists \{id = mainmenu_id}
		if <id> :getsingletag menu_item
			mainmenu_id :se_setprops mainmenu_helper_text_text = ($g_mainmenu_text.<menu_item>.helper_text)
		endif
	else
		<id> :gettags
		if gotparam \{helper_text}
			<screen_id> :se_setprops mainmenu_helper_text_text = <helper_text>
		endif
	endif
	<id> :se_setprops {
		menurow_scale = <grow_scale>
		menurow_txt_item_font = fontgrid_title_a1
		menurow_txt_item_rgba = ($menu_focus_color)
		motion = ease_in
		time = <time>
	}
endscript

script mainmenu_item_unfocus \{time = 0.05}
	if NOT gotparam \{id}
		obj_getid
		<id> = <objid>
	endif
	<id> :se_setprops {
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
	obj_getid
	createscreenelement {
		type = spriteelement
		parent = <objid>
		texture = dropdown_arrow
		dims = (64.0, 32.0)
		pos = (32.0, 16.0)
		just = [center center]
		rgba = (($g_menu_colors).gh5_focus_white)
		z_priority = 6
	}
	if gotparam \{down}
		<id> :se_setprops flip_h
	endif
	<id> :se_setprops scale = 1.3 time = 0.01 relative_scale
	<id> :se_waitprops
	<id> :se_setprops scale = 1.0 time = 0.1 relative_scale
	wait \{0.1
		seconds}
	destroyscreenelement id = <id>
endscript

script mainmenu_do_scroll_glow 
	obj_getid
	createscreenelement {
		type = spriteelement
		parent = <objid>
		texture = circle_gradient_64
		dims = (64.0, 64.0)
		pos = (32.0, 16.0)
		rgba = [255 215 0 255]
		just = [center center]
		z_priority = 0
		alpha = 0.2
		blend = add
	}
	<id> :se_setprops scale = 1.2 relative_scale
	<id> :se_setprops scale = (Random (@ 2.0 @ 2.5 @ 3.0 )) alpha = 0.0 time = 0.2 relative_scale motion = ease_out
	wait \{0.2
		seconds}
	destroyscreenelement id = <id>
endscript

script destroy_main_menu 
	generic_ui_destroy
	destroy_viewport_ui
	destroyscreenelement \{id = mainmenu_id}
endscript

script 0x858b117f 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	change \{band_mode_mode = quickplay}
	change \{game_mode = p1_quickplay}
	change \{current_num_players = 1}
	change \{in_join_band_screens = 1}
	change \{0xc7e670d7 = 1}
	main_menu_select_generic device_num = <device_num> state = uistate_game_mode data = {mode = 0x955f856c}
endscript

script main_menu_select_career 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	change \{game_mode = gh4_p1_career}
	if NOT current_band_has_band_name
		if NOT ($0x76b71b2a)
			spawnscript \{0x1f67cee5}
		endif
	endif
	main_menu_select_generic device_num = <device_num> state = uistate_game_mode data = {use_all_controllers}
endscript

script 0x1f67cee5 
	ui_event_wait_for_safe
	menu_music_off
	playmovieandwait \{movie = 'career_intro'
		noblack
		focus}
	get_movie_id_by_name \{movie = 'career_intro'}
	setglobaltags <id> params = {unlocked = 1} all_active_players = 1
	change \{0x76b71b2a = 1}
	menu_music_on
endscript

script main_menu_select_quickplay 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	main_menu_select_generic device_num = <device_num> state = uistate_game_mode data = {mode = quickplay}
endscript

script main_menu_select_freeplay 
	change \{band_mode_mode = quickplay}
	change \{game_mode = p1_quickplay}
	change \{current_num_players = 1}
	change \{in_join_band_screens = 1}
	change \{0x9b2cba3f = 1}
	main_menu_select_generic device_num = <device_num> state = uistate_game_mode data = {mode = freeplay}
endscript

script main_menu_select_multiplayer 
	generic_menu_pad_choose_sound
	if scriptisrunning \{menu_transition_in_spawned}
		killspawnedscript \{name = menu_transition_in_spawned}
	endif
	if scriptisrunning \{menu_transition_in}
		killspawnedscript \{name = menu_transition_in}
	endif
	getactivecontrollers
	getarraysize <active_controllers>
	if gotparam \{device_num}
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
			case drums
			<drum_count> = (<drum_count> + 1)
		endswitch
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	if ((<guitar_count> < 2) && (<drum_count> < 2))
		ui_event_wait \{event = menu_change
			data = {
				state = uistate_generic_alert_popup
				is_popup
				title = qs(0xcf5deb58)
				text = qs(0xc8986629)
			}}
	else
		spawnscriptnow 0x0308347c params = {<...>}
	endif
endscript

script 0x0308347c 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	change \{game_mode = p2_pro_faceoff}
	change \{current_num_players = 2}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	main_menu_select_generic device_num = <device_num> state = uistate_select_controller
endscript

script main_menu_select_jam 
	unload_gempaks
	setspawninstancelimits \{max = 1
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
	wait \{1
		seconds}
	bg_crowd_front_end_silence \{immediate = 1}
endscript

script main_menu_select_cas device_num = ($primary_controller)
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	set_primary_controller device_num = <device_num> state = uistate_character_selection data = {from_main_menu = 1}
endscript

script main_menu_select_training 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	change \{game_mode = practice}
	change \{current_num_players = 1}
	change \{came_to_practice_from = main_menu}
	change \{came_to_practice_from_progression = none}
	change \{came_to_practice_character_id = emptyguy}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	set_primary_controller device_num = <device_num> state = uistate_select_practice_mode data = <...>
endscript

script main_menu_select_options 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	set_primary_controller device_num = <device_num> state = uistate_options
endscript

script 0x3abe2710 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	setup_top_rockers_single device_num = <device_num>
endscript

script main_menu_select_debug 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	generic_event_choose \{state = uistate_debug}
endscript

script main_menu_select_generic 

	change primary_controller = <device_num>
	if screenelementexists \{id = current_menu}
		launchevent \{type = unfocus
			target = current_menu}
	endif
	generic_event_choose state = <state> data = {<data>}
endscript

script set_primary_controller \{event = menu_change}

	if screenelementexists \{id = current_menu}
		launchevent \{type = unfocus
			target = current_menu}
	endif
	if ((gotparam force) || ($force_mainmenu_signin = 1))
		change \{primary_controller = -1}
		change \{last_start_pressed_device = -1}
		change \{force_mainmenu_signin = 0}
	endif
	change \{respond_to_signin_changed = 1}
	change \{signin_jam_mode = 0}
	getplayerinfo \{1
		controller}
	if (<controller> != <device_num>)
		player = 2
		begin
		getplayerinfo <player> controller
		if (<controller> = <device_num>)
			getplayerinfo \{1
				controller}
			setplayerinfo 1 controller = <device_num>
			setplayerinfo <player> controller = <controller>
			swap_player_status_elements player_a = 1 player_b = <player> lefty_flip
			break
		endif
		player = (<player> + 1)
		repeat 3
	endif
	if ($current_num_players = 1)
		if (<device_num> > -1)
			setplayerinfo 1 controller = <device_num>
		endif
	endif
	if gotparam \{jam}
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

	if getpakmancurrent \{map = zones}

		if NOT (<pak> = z_soundcheck)
			load_soundcheck = 1
		endif
		if NOT gotparam \{load_soundcheck}
			if NOT istextureloaded \{id = main_menu_skull}
				load_soundcheck = 1
			endif
		endif
	endif
	if NOT frontend_anim_paks_are_loaded
		load_anims = 1
	endif
	if ((gotparam load_soundcheck) || (gotparam load_anims))
		needs_loading_screen = 1
		if pakfilesarecached
			needs_loading_screen = 0
			if NOT frontend_anim_paks_are_loaded
				needs_loading_screen = 1
			endif
		endif
		if gotparam \{loadingscreen}
			if (<needs_loading_screen> = 1)
				create_loading_screen \{0xdf3c5641}
			else
				hide_glitch \{num_frames = 3}
			endif
		endif
		if NOT isps3 \{testkit}
			if NOT pakfilesarecached
				if ((cd) || ($force_pak_caching = 1))
					if ($disable_pak_caching = 0)
						if cachepakfiles
							block \{untilevent = cache_pak_files_loaded}
						endif
					endif
				endif
			endif
		endif
		if gotparam \{load_soundcheck}
			0x72fc1318 \{venue = $current_level}
			if pakfilesarecached
				setpakmancurrentblock map = zones pak = <prefix_crc> block_scripts = 1
			else
				setpakmancurrentblock map = zones pak = <prefix_crc> block_scripts = (<async> - 1)
			endif
		endif
		loadvenuevideo \{pn = z_soundcheck}
		if gotparam \{load_anims}
			anim_paks_set_state \{state = frontend
				async = 0}
		endif
		if NOT gotparam \{gigboard}
			hide_glitch \{num_frames = 30}
		endif
		if gotparam \{loadingscreen}
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
