force_mainmenu_signin = 0

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
	create_frontend_bg
	frontend_load_soundcheck
	reset_all_special_events
	clear_exclusive_devices
	setmenuautorepeattimes \{(0.3, 0.05)}
	disable_pause
	unpausegame
	change \{check_for_unplugged_controllers = 1}
	change \{current_num_players = 1}
	change structurename = player1_status controller = ($primary_controller)
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
	change \{battle_do_or_die = 0}
	change \{battle_do_or_die_speed_scale = 1.0}
	change \{battle_do_or_die_attack_scale = 1.0}
	change \{rich_presence_context = presence_menus}
	change \{player1_device = 0}
	change \{player2_device = 1}
	change \{player3_device = 2}
	change \{player4_device = 3}
	change \{current_gig_number = 1}
	change \{current_progression_flag = none}
	change \{options_for_manage_band = 0}
	if NOT ($invite_controller = -1)
		change \{invite_controller = -1}
		main_menu_select_online
		fadetoblack \{off
			time = 0}
	else
	endif
	if ($autolaunch_cas = 1 || $autolaunch_cas_artist = 1)
		change \{autolaunch_cas = 0}
		spawnscriptlater main_menu_select_cas params = {device_num = ($primary_controller)}
	endif
	spawnscriptnow \{menu_music_fade
		params = {
			in
			time = 0.01
		}}
	destroy_loading_screen
endscript

script create_frontend_bg 
	if NOT screenelementexists \{id = current_bg_anchor}
		createscreenelement \{type = descinterface
			id = current_bg_anchor
			parent = root_window
			desc = 'main_menu_layout'
			just = [
				center
				center
			]}
		current_bg_anchor :obj_spawnscriptnow \{frontend_background_anim}
	endif
endscript

script cleanup_frontend_bg 
	if screenelementexists \{id = current_bg_anchor}
		killspawnedscript \{name = frontend_background_anim}
		destroyscreenelement \{id = current_bg_anchor}
	endif
endscript

script mainmenu_focus 
	obj_getid
	gettags
	if gotparam \{isinterface}
		<objid> :se_setprops item_color = ($menu_focus_color)
		<objid> :focus_set_spinners
	else
		se_setprops rgba = ($menu_focus_color)
		<objid> :menu_focus_set_highlight
	endif
endscript

script mainmenu_unfocus 
	obj_getid
	gettags
	if gotparam \{isinterface}
		<objid> :se_setprops item_color = ($menu_unfocus_color)
		if <objid> :desc_resolvealias name = alias_left_spinner
			hide_spinners spinner_id = <objid>
		endif
	else
		se_setprops rgba = ($menu_unfocus_color)
	endif
endscript

script hookup_spinner_focus_functionality \{menu = current_menu_anchor}
	obj_getid
	setscreenelementprops {
		id = <objid>
		event_handlers = [
			{focus focus_set_spinners params = {menu = <menu>}}
		]
	}
	if <objid> :desc_resolvealias name = alias_left_spinner
		setscreenelementprops {
			id = <objid>
			event_handlers = [
				{unfocus hide_spinners params = {spinner_id = <objid>}}
			]
		}
	endif
endscript

script focus_set_spinners \{menu = current_menu_anchor}
	obj_getid
	<objid> :se_getprops
	if (<type> = descinterface)
		if <objid> :desc_resolvealias name = alias_left_spinner
			if scriptisrunning \{animate_spinners}
				killspawnedscript \{name = animate_spinners}
			endif
			<objid> :obj_spawnscript animate_spinners params = {menu_id = <objid>}
		else
			<objid> :menu_focus_set_highlight menu = <menu>
		endif
	else
		<objid> :menu_focus_set_highlight menu = <menu>
	endif
endscript
spinner_spin_rate = 45.0

script animate_spinners spin_rate = ($spinner_spin_rate)
	setscriptcannotpause

	if NOT screenelementexists id = <menu_id>

	endif
	if <menu_id> :desc_resolvealias name = alias_spinner
		spinner_id = <resolved_id>
	else
		spinner_id = <menu_id>
	endif
	if NOT screenelementexists id = <spinner_id>
		return
	endif
	if <spinner_id> :desc_resolvealias name = alias_left_spinner
		left_spinner_id = <resolved_id>
		<left_spinner_id> :se_setprops alpha = 1.0 time = 0.0
	endif
	if <spinner_id> :desc_resolvealias name = alias_right_spinner
		right_spinner_id = <resolved_id>
		<right_spinner_id> :se_setprops alpha = 1.0 time = 0.0
	endif
	begin
	if NOT screenelementexists id = <spinner_id>
		break
	endif
	if screenelementexists id = <left_spinner_id>
		<left_spinner_id> :se_getprops rot_angle
		<left_spinner_id> :se_setprops rot_angle = (<rot_angle> + <spin_rate>) time = 0.5
	elseif <spinner_id> :desc_resolvealias name = alias_left_spinner
		left_spinner_id = <resolved_id>
	endif
	if screenelementexists id = <right_spinner_id>
		<right_spinner_id> :se_getprops rot_angle
		<right_spinner_id> :se_setprops rot_angle = (<rot_angle> - <spin_rate>) time = 0.5
	elseif <spinner_id> :desc_resolvealias name = alias_right_spinner
		right_spinner_id = <resolved_id>
	endif
	wait \{5
		gameframes
		ignoreslomo}
	repeat
endscript

script hide_spinners \{spinner_id = current_menu_anchor}
	if screenelementexists id = <spinner_id>
		if <spinner_id> :desc_resolvealias name = alias_left_spinner
			left_spinner_id = <resolved_id>
			<left_spinner_id> :se_setprops alpha = 0.0 time = 0.0
		endif
		if <spinner_id> :desc_resolvealias name = alias_right_spinner
			right_spinner_id = <resolved_id>
			<right_spinner_id> :se_setprops alpha = 0.0 time = 0.0
		endif
	endif
endscript

script highlight_motion \{menu_id = current_menu_anchor
		alias_name = alias_highlight
		motion = spin}
	array_size = 0
	if <menu_id> :desc_resolvealias name = <alias_name>
		if NOT (<motion> = spin)
			if getscreenelementchildren id = <resolved_id>
				getarraysize <children>
				prev = (<array_size> - 1)
				curr = 0
				prev_id = (<children> [<prev>])
				curr_id = (<children> [<curr>])
			else
				return
			endif
		endif
	endif
	switch <motion>
		case spin
		animate_spinners menu_id = <menu_id>
		case movie
		begin
		if (<array_size> > 0)
			prev_id = (<children> [<prev>])
			curr_id = (<children> [<curr>])
			<prev_id> :se_setprops alpha = 0.0
			<curr_id> :se_setprops alpha = 1
			prev = <curr>
			curr = (<curr> + 1)
			if (<curr> >= <array_size>)
				curr = 0
			endif
		endif
		wait \{0.1
			second}
		repeat
		case bounce
		return
		case random_highlight
		if (<array_size> > 0)
			begin
			<prev_id> :se_setprops alpha = 0.0
			<curr_id> :se_setprops alpha = 1
			prev = <curr>
			next = RandomInteger (0.0, 2.0)
			if (<next> = <prev>)
				curr = (<curr> + 1)
			else
				curr = <next>
			endif
			if (<curr> >= <array_size>)
				curr = 0
			endif
			if NOT gotparam \{no_flip}
				rand = Random (@ 0 @ 1 )
				if (<rand> = 1)
					<curr_id> :se_setprops flip_v = true
				else
					<curr_id> :se_setprops flip_v = false
				endif
				rand = Random (@ 0 @ 1 )
				if (<rand> = 1)
					<curr_id> :se_setprops flip_h = true
				else
					<curr_id> :se_setprops flip_h = false
				endif
			endif
			wait \{0.1
				second}
			repeat
		endif
		default

	endswitch
endscript

script create_main_menu_elements 
	if NOT ($invite_controller = -1)
		return
	endif
	if screenelementexists \{id = current_menu_anchor}
		current_menu_anchor :die
	endif
	set_focus_color \{rgba = [
			146
			7
			10
			255
		]}
	set_unfocus_color \{rgba = [
			0
			0
			0
			255
		]}
	createscreenelement \{type = descinterface
		parent = root_window
		id = current_menu_anchor
		desc = 'menu_frontend'
		just = [
			center
			center
		]}
	if <id> :desc_resolvealias name = alias_menu
		assignalias id = <resolved_id> alias = current_menu
		current_menu :se_setprops {
			event_handlers = [
				{pad_up generic_menu_up_or_down_sound params = {up}}
				{pad_down generic_menu_up_or_down_sound params = {down}}
			]
			tags = {item_scale = <item_scale>}
			spacing_between = -15
		}
	endif
	add_menu_frontend_item \{desc = 'menu_tape_01'
		text = qs(0xde7ec8b3)
		pad_choose_script = main_menu_select_career}
	add_menu_frontend_item \{desc = 'menu_tape_02'
		text = qs(0xfabdce2b)
		pad_choose_script = main_menu_select_quickplay}
	add_menu_frontend_item \{desc = 'menu_tape_03'
		text = qs(0xfef0f891)
		pad_choose_script = main_menu_select_multiplayer}
	add_menu_frontend_item \{desc = 'menu_tape_04'
		text = qs(0x17044f94)
		pad_choose_script = main_menu_select_backstage}
	add_menu_frontend_item \{desc = 'menu_tape_03'
		text = qs(0x3ea7dec9)
		pad_choose_script = ui_select_practice_mode_choose
		pad_choose_params = {
			practice = 1
		}}
	add_menu_frontend_item \{desc = 'menu_tape_01'
		text = qs(0x2c98ca28)
		pad_choose_script = main_menu_select_options}
	show_debug_menus = 0
	if ($enable_button_cheats = 1)
		<show_debug_menus> = 1
		if ($enable_debug_menus = 0)
			<show_debug_menus> = 0
		endif
	endif
	if (<show_debug_menus> = 1)
		add_menu_frontend_item \{text = qs(0x8592df80)
			internal_scale = 0.8
			pad_choose_script = main_menu_select_debug}
	endif
	return
endscript

script add_mainmenu_item \{default_container_params = {
			dims = (200.0, 50.0)
			child_anchor = [
				center
				top
			]
			scale = 1.8
		}
		default_text_params = {
			text = qs(0x03ac90f0)
			rgba = [
				200
				200
				200
				250
			]
			font = fontgrid_text_a11_large
			just = [
				center
				center
			]
		}
		choose_script = nullscript}
	if globalexists \{name = massive_build}
		if NOT ($massive_build = 0)
			if gotparam \{massive_secret_item}
				return
			endif
		endif
	endif
	createscreenelement {
		<default_container_params>
		<container_params>
		type = containerelement
		parent = <parent>
		event_handlers = [
			{focus mainmenu_item_focus}
			{unfocus mainmenu_item_unfocus}
			{pad_choose <choose_script>}
		]
	}
	container_id = <id>
	createscreenelement {
		font = ($test_menu_font)
		<default_text_params>
		<text_params>
		type = textelement
		parent = <container_id>
		local_id = text
	}
	getscreenelementdims id = <id>
	if (<width> > 420)
		setscreenelementprops id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((420.0, 0.0) + <height> * (0.0, 1.0))
	endif
	return container_id = <container_id>
endscript

script mainmenu_item_focus 
	obj_getid
	<id> = <objid>
	setscreenelementprops id = {<id> child = text} rgba = [210 210 210 250]
endscript

script mainmenu_item_unfocus 
	obj_getid
	<id> = <objid>
	setscreenelementprops id = {<id> child = text} rgba = [200 200 200 250]
endscript

script destroy_main_menu 
	generic_ui_destroy
	destroy_viewport_ui
endscript

script main_menu_select_career 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	change \{game_mode = p1_career}
	main_menu_select_generic device_num = <device_num> state = uistate_game_mode data = {use_all_controllers}
endscript

script main_menu_select_quickplay 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	main_menu_select_generic device_num = <device_num> state = uistate_game_mode data = {mode = quickplay}
endscript

script main_menu_select_multiplayer 
	getactivecontrollers
	getarraysize <active_controllers>
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
		change primary_controller = <device_num>
		ui_event_wait \{event = menu_change
			data = {
				state = uistate_generic_alert_popup
				is_popup
				title = qs(0xcf5deb58)
				text = qs(0xc8986629)
			}}
	else
		spawnscriptnow \{0x0308347c}
	endif
endscript

script 0x077dbb38 
	destroy_generic_popup
	launchevent \{type = focus
		target = current_menu}
endscript

script 0x0308347c 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	change \{game_mode = p2_faceoff}
	change \{current_num_players = 2}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	create_loading_screen
	main_menu_select_generic device_num = <device_num> state = uistate_select_controller
endscript

script main_menu_select_training 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	change \{game_mode = training}
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

script main_menu_select_backstage 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	create_loading_screen \{0xdf3c5641}
	set_primary_controller device_num = <device_num> state = uistate_backstage
endscript

script main_menu_select_options 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	generic_menu_pad_choose_sound
	set_primary_controller device_num = <device_num> state = uistate_options
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
	hide_glitch \{num_frames = 20}
	set_primary_controller device_num = <device_num> state = uistate_character_selection data = {from_main_menu = 1}
endscript

script main_menu_select_debug 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	generic_event_choose \{state = uistate_debug}
endscript

script main_menu_select_generic 
	if screenelementexists \{id = current_menu}
		launchevent \{type = unfocus
			target = current_menu}
	endif
	generic_event_choose state = <state> data = <data>
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
			if pakfilesarecached
				setpakmancurrentblock \{map = zones
					pak = z_soundcheck
					block_scripts = 1}
			else
				setpakmancurrentblock map = zones pak = z_soundcheck block_scripts = (<async> - 1)
			endif
		endif
		loadvenuevideo \{pn = z_soundcheck}
		if gotparam \{load_anims}
			load_frontend_anim_paks async = <async>
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
initial_bg_anim_spawn = 1

script frontend_background_anim 

	se_getprops \{mm_bg_top_pos}
	<org_mm_bg_top_pos> = <mm_bg_top_pos>
	se_getprops \{mm_bg_bot_pos}
	<org_mm_bg_bot_pos> = <mm_bg_bot_pos>
	se_getprops \{mm_bg_bot_02_pos}
	<org_mm_bg_bot_02_pos> = <mm_bg_bot_02_pos>
	se_getprops \{mm_white_stripe_01_pos}
	<org_mm_white_stripe_01_pos> = <mm_white_stripe_01_pos>
	se_getprops \{mm_white_stripe_01b_pos}
	<org_mm_white_stripe_01b_pos> = <mm_white_stripe_01b_pos>
	se_getprops \{mm_white_stripe_02_pos}
	<org_mm_white_stripe_02_pos> = <mm_white_stripe_02_pos>
	se_getprops \{mm_white_stripe_02b_pos}
	<org_mm_white_stripe_02b_pos> = <mm_white_stripe_02b_pos>
	se_getprops \{mm_white_stripe_03_pos}
	<org_mm_white_stripe_03_pos> = <mm_white_stripe_03_pos>
	se_getprops \{mm_white_stripe_04_pos}
	<org_mm_white_stripe_04_pos> = <mm_white_stripe_04_pos>
	se_getprops \{mm_black_stripe_01_pos}
	<org_mm_black_stripe_01_pos> = <mm_black_stripe_01_pos>
	se_getprops \{mm_black_stripe_01b_pos}
	<org_mm_black_stripe_01b_pos> = <mm_black_stripe_01b_pos>
	se_getprops \{mm_black_stripe_02_pos}
	<org_mm_black_stripe_02_pos> = <mm_black_stripe_02_pos>
	se_getprops \{mm_black_stripe_03_pos}
	<org_mm_black_stripe_03_pos> = <mm_black_stripe_03_pos>
	se_getprops \{mm_blacktrans_stripe_11_pos}
	<org_mm_blacktrans_stripe_11_pos> = <mm_blacktrans_stripe_11_pos>
	if ($initial_bg_anim_spawn = 1)
		change \{initial_bg_anim_spawn = 0}
		se_setprops mm_bg_top_pos = (<org_mm_bg_top_pos> + (2000.0, 150.0))
		se_setprops mm_bg_bot_pos = (<org_mm_bg_bot_pos> + (-1450.0, 0.0))
		se_setprops mm_bg_bot_02_pos = (<org_mm_bg_bot_02_pos> + (1060.0, -110.0))
		se_setprops mm_white_stripe_01_pos = (<org_mm_white_stripe_01_pos> + (2056.0, 200.0))
		se_setprops mm_white_stripe_01b_pos = (<org_mm_white_stripe_01b_pos> + (273.0, -277.0))
		se_setprops mm_white_stripe_02_pos = (<org_mm_white_stripe_02_pos> + (162.0, 875.0))
		se_setprops mm_white_stripe_02b_pos = (<org_mm_white_stripe_02b_pos> + (1600.0, 0.0))
		se_setprops mm_white_stripe_03_pos = (<org_mm_white_stripe_03_pos> + (80.0, 442.0))
		se_setprops mm_white_stripe_04_pos = (<org_mm_white_stripe_04_pos> + (893.0, -13.0))
		se_setprops mm_black_stripe_01_pos = (<org_mm_black_stripe_01_pos> + (-1481.0, 242.0))
		se_setprops mm_black_stripe_01b_pos = (<org_mm_black_stripe_01b_pos> + (391.0, 329.0))
		se_setprops mm_black_stripe_02_pos = (<org_mm_black_stripe_02_pos> + (0.0, 0.0))
		se_setprops \{mm_black_stripe_02_alpha = 0.0}
		se_setprops mm_black_stripe_03_pos = (<org_mm_black_stripe_03_pos> + (98.0, -1238.0))
		se_setprops mm_blacktrans_stripe_11_pos = (<org_mm_blacktrans_stripe_11_pos> + (98.0, -1238.0))
		se_setprops \{logogh_vh_alpha = 0.0}
		se_setprops \{logogh_vh_alpha = 1.0
			time = 3.5}
		wait \{0.33
			seconds}
		se_setprops mm_bg_top_pos = <org_mm_bg_top_pos> time = 0.06
		wait \{0.21000001
			seconds}
		se_setprops mm_bg_bot_pos = <org_mm_bg_bot_pos> time = 0.04
		wait \{0.22
			seconds}
		se_setprops mm_bg_bot_02_pos = <org_mm_bg_bot_02_pos> time = 0.044999998
		wait \{0.43
			seconds}
		se_setprops mm_black_stripe_01_pos = <org_mm_black_stripe_01_pos> time = 0.13
		se_setprops mm_black_stripe_01b_pos = <org_mm_black_stripe_01b_pos> time = 0.2
		wait \{0.23
			seconds}
		se_setprops mm_white_stripe_01b_pos = <org_mm_white_stripe_01b_pos> time = 0.05
		se_setprops mm_white_stripe_02b_pos = <org_mm_white_stripe_02b_pos> time = 0.11
		wait \{0.16
			seconds}
		se_setprops mm_white_stripe_01_pos = <org_mm_white_stripe_01_pos> time = 0.055
		se_setprops mm_white_stripe_02_pos = <org_mm_white_stripe_02_pos> time = 0.11
		wait \{0.17
			seconds}
		se_setprops mm_white_stripe_03_pos = <org_mm_white_stripe_03_pos> time = 0.09
		se_setprops mm_white_stripe_04_pos = <org_mm_white_stripe_04_pos> time = 0.075
		se_setprops mm_black_stripe_03_pos = <org_mm_black_stripe_03_pos> time = 0.08
		se_setprops mm_blacktrans_stripe_11_pos = (<org_mm_blacktrans_stripe_11_pos>) time = 0.08
		se_setprops \{mm_black_stripe_02_alpha = 1.0
			time = 1.5}
	endif
	wait \{2
		seconds}
	begin
	element = Random (@ mm_white_stripe_01 @ mm_white_stripe_02 @ mm_white_stripe_03 @ mm_white_stripe_04 @ mm_black_stripe_01 @ mm_black_stripe_02 @ mm_black_stripe_03 )
	switch <element>
		case mm_white_stripe_01
		se_setprops mm_white_stripe_01_pos = (<org_mm_white_stripe_01_pos> + (-1900.0, -150.0)) time = 0.33
		se_setprops mm_white_stripe_01_pos = (<org_mm_white_stripe_01_pos> + (1485.0, 88.0)) time = 0
		se_setprops mm_white_stripe_01_pos = <org_mm_white_stripe_01_pos> time = 0.33
		case mm_white_stripe_02
		se_setprops mm_white_stripe_02_pos = (<org_mm_white_stripe_02_pos> + (385.0, -980.0)) time = 0.33
		se_setprops mm_white_stripe_02_pos = (<org_mm_white_stripe_02_pos> + (162.0, 875.0)) time = 0.0
		se_setprops mm_white_stripe_02_pos = <org_mm_white_stripe_02_pos> time = 0.33
		case mm_white_stripe_03
		se_setprops mm_white_stripe_03_pos = (<org_mm_white_stripe_03_pos> + (-1167.0, -523.0)) time = 0.33
		se_setprops mm_white_stripe_03_pos = (<org_mm_white_stripe_03_pos> + (80.0, 442.0)) time = 0.0
		se_setprops mm_white_stripe_03_pos = <org_mm_white_stripe_03_pos> time = 0.33
		case mm_white_stripe_04
		se_setprops mm_white_stripe_04_pos = (<org_mm_white_stripe_04_pos> + (-513.0, 584.0)) time = 0.33
		se_setprops mm_white_stripe_04_pos = (<org_mm_white_stripe_04_pos> + (893.0, -13.0)) time = 0.0
		se_setprops mm_white_stripe_04_pos = <org_mm_white_stripe_04_pos> time = 0.33
		case mm_black_stripe_01
		se_setprops mm_black_stripe_01_pos = (<org_mm_black_stripe_01_pos> + (-1473.0, 474.0)) time = 0.33
		se_setprops mm_black_stripe_01_pos = (<org_mm_black_stripe_01_pos> + (-1481.0, 242.0)) time = 0.0
		se_setprops mm_black_stripe_01_pos = <org_mm_black_stripe_01_pos> time = 0.33
		case mm_black_stripe_02
		se_setprops \{mm_black_stripe_02_alpha = 0.0
			time = 0.5}
		wait \{0.66
			seconds}
		se_setprops \{mm_black_stripe_02_alpha = 1.0
			time = 0.5}
		case mm_black_stripe_03
		se_setprops mm_black_stripe_03_pos = (<org_mm_black_stripe_03_pos> + (602.0, 1199.0)) time = 0.33
		se_setprops mm_blacktrans_stripe_11_pos = (<org_mm_blacktrans_stripe_11_pos> + (602.0, 1199.0)) time = 0.33
		se_setprops mm_black_stripe_03_pos = (<org_mm_black_stripe_03_pos> + (98.0, -1238.0)) time = 0.0
		se_setprops mm_blacktrans_stripe_11_pos = (<org_mm_blacktrans_stripe_11_pos> + (98.0, -1238.0)) time = 0.0
		se_setprops mm_black_stripe_03_pos = <org_mm_black_stripe_03_pos> time = 0.33
		se_setprops mm_blacktrans_stripe_11_pos = (<org_mm_blacktrans_stripe_11_pos>) time = 0.33
	endswitch
	randtime = Random (@ 2 )
	wait <randtime> seconds
	repeat
endscript
