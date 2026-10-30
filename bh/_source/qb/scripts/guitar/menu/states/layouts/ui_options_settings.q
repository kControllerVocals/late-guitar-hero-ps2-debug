
script ui_create_options_settings 
	change \{ui_options_from_submenu = 1}
	getglobaltags \{user_options}
	0x2ea532a9 \{pad_back_script = ui_options_check_settings
		pad_back_params = {
			no_loading_screen
		}}
	0x9d0992fe {
		parent = current_submenu
		0x6d96b274
		text = qs(0x2e9b1b43)
		0xc1f386b6
		pad_choose_script = ui_options_controller_choose_lefty_flip
		pad_choose_params = {popup = <popup> player_device = $primary_controller}
	}
	get_player_num_from_controller \{controller_index = $primary_controller}
	getplayerinfo <player_num> lefty_flip
	if (<lefty_flip> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :se_setprops {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	current_menu :settags lefty_id = <item_id>
	if ($vocal_enable_static_view = 1)
		0x9d0992fe \{parent = current_submenu
			0x6d96b274
			text = qs(0x7a043839)
			0xc1f386b6
			pad_choose_script = options_change_vocals_highway_view
			pad_choose_params = {
				no_restart
				player = 1
			}}
	else
		0x9d0992fe \{parent = current_submenu
			0x6d96b274
			text = qs(0x7a043839)
			0xc1f386b6
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
	<item_id> :se_setprops {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	0x9d0992fe \{parent = current_submenu
		0x6d96b274
		text = qs(0x38a48aed)
		0xc1f386b6
		pad_choose_script = options_change_vocals_sp_clap
		pad_choose_params = {
			player = 1
		}}
	getplayerinfo <player_num> vocals_sp_clap
	if (<vocals_sp_clap> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :se_setprops {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	0x9d0992fe \{parent = current_submenu
		0x6d96b274
		text = qs(0xc987ca62)
		0xc1f386b6
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
	<item_id> :se_setprops {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	0x9d0992fe \{parent = current_submenu
		0x6d96b274
		text = qs(0x88113eb5)
		0xc1f386b6
		pad_choose_script = options_change_tilt_star_power
		pad_choose_params = {
			player = 1
		}}
	getplayerinfo <player_num> use_tilt_for_starpower
	if (<use_tilt_for_starpower> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :se_setprops {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	0x9d0992fe \{parent = current_submenu
		0x6d96b274
		text = qs(0xa2b47a6e)
		0xc1f386b6
		pad_choose_script = options_change_touch_strip_option
		pad_choose_params = {
			player = 1
		}}
	getplayerinfo <player_num> enable_touch_strip
	if (<enable_touch_strip> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :se_setprops {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	if NOT ispal
		0x9d0992fe \{parent = current_submenu
			0x6d96b274
			text = qs(0x37f773d2)
			0xc1f386b6
			pad_choose_script = 0x2cb6987e}
		if ($ps2_progressivescan = 1)
			<check_alpha> = 1
			<cross_alpha> = 0
		else
			<check_alpha> = 0
			<cross_alpha> = 1
		endif
		<item_id> :se_setprops {
			check_alpha = <check_alpha>
			cross_alpha = <cross_alpha>
		}
	endif
	ui_options_set_settings
endscript

script ui_destroy_options_settings 
	0x7f9ab085
endscript

script ui_return_options_settings 
	clean_up_user_control_helpers
	add_gamertag_helper \{exclusive_device = $primary_controller}
endscript

script ui_options_settings_choose_count 
	obj_getid
	getglobaltags \{user_options
		param = unpause_count}
	if (<unpause_count> = 1)
		<unpause_count> = 0
		soundevent \{event = box_uncheck_sfx}
		check_alpha = 0
		cross_alpha = 1
	else
		<unpause_count> = 1
		soundevent \{event = box_check_sfx}
		check_alpha = 1
		cross_alpha = 0
	endif
	<objid> :se_setprops check_alpha = <check_alpha>
	<objid> :se_setprops cross_alpha = <cross_alpha>
	setglobaltags user_options params = {unpause_count = <unpause_count>}
endscript

script ui_create_options_settings_lefty_warning 
	launchevent \{type = unfocus
		target = current_submenu}
	create_dialog_box \{heading_text = qs(0xaa163738)
		body_text = qs(0x844b0500)
		options = [
			{
				func = ui_destroy_options_settings_lefty_warning
				text = qs(0x182f0173)
			}
		]}
endscript

script ui_destroy_options_settings_lefty_warning 
	wait \{1
		seconds}
	destroy_dialog_box
	launchevent \{type = focus
		target = current_submenu}
	menu_finish
endscript

script ui_options_settings_lefty_warning 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	current_menu :getsingletag \{lefty_id}
	obj_spawnscript \{ui_options_controller_choose_lefty_flip
		params = {
			player_device = $primary_controller
		}}
	generic_event_back
endscript

script ui_options_settings_animate_in 
	if screenelementexists \{id = current_menu_anchor}
		current_menu_anchor :se_setprops \{0x09197a7d = {
				relative
				(-500.0, 0.0)
			}
			time = 0.15
			motion = linear}
	endif
	se_setprops \{pos = (-1200.0, -25.0)
		time = 0.15
		motion = linear}
	se_setprops \{darker_alpha = 0.4
		time = 0.15}
endscript

script ui_options_settings_animate_out 
	if screenelementexists \{id = current_menu_anchor}
		current_menu_anchor :se_setprops \{0x09197a7d = {
				relative
				(500.0, 0.0)
			}
			time = 0.15
			motion = linear}
	endif
	se_setprops \{pos = (-1600.0, 300.0)
		time = 0.15
		motion = linear}
	se_setprops \{darker_alpha = 0.0
		time = 0.15}
	se_waitprops
	if screenelementexists \{id = settings_submenu}
		destroyscreenelement \{id = settings_submenu}
	endif
endscript

script ui_options_settings_focus 
	obj_getid
	if gotparam \{objid}
		if <objid> :desc_resolvealias name = alias_text
			<resolved_id> :se_setprops rgba = (($default_color_scheme).text_focus_color)
		endif
	endif
	gettags
	if settings_submenu :desc_resolvealias \{name = alias_highlight}
		assignalias id = <resolved_id> alias = highlight
		wait \{2
			gameframe}
		if <objid> :desc_resolvealias name = alias_text
			getscreenelementchildren id = <resolved_id>
			getscreenelementdims id = (<children> [0])
			scale = (((1.0, 0.0) * (((<width> + 25.0) / 256.0))) + (0.0, 1.5))
			getscreenelementposition id = (<children> [0]) summed
			highlight :se_setprops pos = {absolute (<screenelementpos>)} scale = <scale>
			highlight :se_waitprops
			getscreenelementposition id = (<children> [0]) summed
			highlight :se_setprops pos = {absolute (<screenelementpos> + (0.0, -10.0))} time = 0.05
			highlight :se_waitprops
			getscreenelementposition id = (<children> [0]) summed
			highlight :se_setprops pos = {absolute (<screenelementpos>)} scale = <scale> time = 0.05
			highlight :se_waitprops
		endif
	endif
endscript

script ui_options_settings_unfocus 
	obj_getid
	if gotparam \{objid}
		if <objid> :desc_resolvealias name = alias_text
			<resolved_id> :se_setprops rgba = (($default_color_scheme).text_color)
		endif
	endif
endscript

script 0x2cb6987e 
	if ($ps2_progressivescan = 1)
		soundevent \{box_uncheck_sfx}
		change \{ps2_progressivescan = 0}
		setprogressive \{on = 0}
		ui_event \{event = menu_refresh}
	else
		soundevent \{box_check_sfx}
		0xb966ebc9
	endif
endscript

script 0xb966ebc9 
	launchevent \{type = unfocus
		target = current_submenu}
	create_dialog_box \{heading_text = qs(0xaa163738)
		body_text = qs(0xb6ee6e80)
		options = [
			{
				func = 0xc66462bb
				text = qs(0x0e41fe46)
			}
			{
				func = 0xdcb1d1d7
				text = qs(0xf7723015)
			}
		]
		back_button_script = 0xdcb1d1d7
		back_button_params = {
			0x8333d9ba
		}}
	add_user_control_helper \{text = qs(0xaf4d5dd2)
		button = red}
endscript

script 0xc66462bb 
	destroy_dialog_box
	change \{ps2_progressivescan = 1}
	setprogressive \{on = 1}
	create_dialog_box \{heading_text = qs(0x326e2d2f)
		body_text = qs(0xcac12143)
		options = [
			{
				func = 0xa252dfe6
				text = qs(0x0e41fe46)
			}
			{
				func = 0xb3aac927
				text = qs(0xf7723015)
			}
		]
		back_button_script = 0xb3aac927
		back_button_params = {
			0x8333d9ba
		}}
	if dialog_box_desc_id :desc_resolvealias \{name = alias_dlog_vmenu}
		<resolved_id> :menu_changeselection
	endif
	spawnscriptnow \{0xc8201a39}
endscript

script 0xc8201a39 
	wait \{15
		seconds}
	spawnscriptnow \{0xb3aac927}
endscript

script 0xa252dfe6 
	killspawnedscript \{name = 0xc8201a39}
	getscreenelementchildren \{id = current_submenu}
	(<children> [6]) :se_setprops {
		check_alpha = 1
		cross_alpha = 0
	}
	0xdcb1d1d7
endscript

script 0xb3aac927 
	killspawnedscript \{name = 0xc8201a39}
	change \{ps2_progressivescan = 0}
	setprogressive \{on = 0}
	0xdcb1d1d7 <...>
endscript

script 0xdcb1d1d7 
	if gotparam \{0x8333d9ba}
		generic_menu_pad_back_sound
	endif
	destroy_dialog_box
	launchevent \{type = focus
		target = current_submenu}
	menu_finish
endscript
