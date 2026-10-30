gh3_button_font = buttons_x360
user_control_pill_color = [
	180
	180
	180
	255
]
user_control_pill_text_color = [
	0
	0
	0
	255
]
user_control_pill_scale = 0.6
default_event_handlers = [
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
		generic_event_back
	}
]
g_menu_colors = {
	menu_subhead = [
		255
		255
		255
		255
	]
	gh4_focus_brownish = [
		173
		88
		5
		255
	]
	gh4_unfocus_greyish = [
		100
		88
		71
		255
	]
	gh4_jam_yellowish = [
		255
		215
		0
		255
	]
	gh4_jam_orangeish = [
		210
		130
		0
		255
	]
	grey64 = [
		64
		64
		64
		255
	]
	gh5_focus_yellowish = [
		255
		215
		0
		255
	]
	gh5_unfocus_peru = [
		205
		133
		63
		255
	]
	tomato = [
		255
		99
		71
		255
	]
	gh5_focus_white = [
		225
		225
		225
		255
	]
	gh5_unfocus_grey = [
		170
		170
		170
		200
	]
	filter_light_on = [
		92
		185
		53
		255
	]
	songlist_focus_orangeish = [
		247
		147
		29
		255
	]
	light_brown = [
		240
		225
		200
		255
	]
	brown = [
		172
		124
		112
		255
	]
	pink = [
		170
		80
		115
		255
	]
	lt_violet_grey = [
		230
		220
		240
		255
	]
	md_violet_grey = [
		190
		180
		200
		255
	]
	dk_violet_grey = [
		110
		100
		120
		255
	]
	dk_violet_red = [
		100
		31
		53
		255
	]
	lt_plum = [
		240
		200
		250
		255
	]
	brick = [
		128
		32
		32
		255
	]
	grey50 = [
		50
		50
		50
		255
	]
	grey100 = [
		100
		100
		100
		255
	]
	grey150 = [
		150
		150
		150
		255
	]
	lt_violet_bar = [
		180
		150
		175
		255
	]
	violet_focus = [
		70
		0
		80
		255
	]
	dk_violet_bar = [
		45
		40
		50
		255
	]
	brown_unfocus = [
		145
		120
		75
		255
	]
	red = [
		130
		0
		0
		250
	]
	black = [
		0
		0
		0
		255
	]
	white = [
		230
		230
		230
		255
	]
	pure_white = [
		255
		255
		255
		255
	]
	reddish_grey = [
		180
		50
		50
		255
	]
	gold = [
		254
		204
		55
		255
	]
	grey182 = [
		182
		182
		182
		255
	]
	gold2 = [
		230
		190
		70
		255
	]
	grey150 = [
		150
		150
		150
		255
	]
	cream = [
		250
		245
		195
		255
	]
	cream2 = [
		235
		240
		200
		255
	]
	khaki = [
		60
		60
		30
		255
	]
	burnt_orange = [
		180
		100
		60
		255
	]
	dark_red = [
		115
		10
		10
		255
	]
	blueish_grey = [
		150
		170
		215
		255
	]
	light_grey = [
		240
		235
		240
		255
	]
	pink2 = [
		235
		120
		135
		255
	]
	white230 = [
		230
		230
		230
		255
	]
	flesh = [
		255
		220
		140
		255
	]
	dark_red2 = [
		90
		25
		5
		255
	]
	creamy_grey = [
		190
		185
		165
		255
	]
	chocolate = [
		60
		45
		30
		255
	]
	dark_red3 = [
		110
		30
		20
		255
	]
	blueish_grey2 = [
		135
		170
		200
		255
	]
	pinkish_red = [
		195
		50
		55
		250
	]
	dark_red4 = [
		130
		40
		40
		250
	]
	setlist_orange = [
		200
		120
		0
		250
	]
	dark_orange = [
		50
		30
		10
		255
	]
	white220 = [
		220
		220
		220
		255
	]
	fill_rgba = [
		70
		70
		70
		230
	]
	frame_rgba = [
		175
		65
		70
		255
	]
	online_fill_rgba = [
		10
		0
		30
		170
	]
	p1_orangey = [
		250
		225
		200
		255
	]
	p2_purpley = [
		240
		220
		255
		255
	]
	alert_red = [
		195
		70
		75
		255
	]
	red175 = [
		175
		0
		0
		250
	]
	white210 = [
		210
		210
		210
		250
	]
	orange = [
		255
		128
		0
		255
	]
	dark_red5 = [
		93
		30
		28
		255
	]
	white200 = [
		200
		200
		200
		255
	]
}
default_menu_focus_color = gh5_focus_white
default_menu_unfocus_color = gh5_unfocus_grey
menu_focus_color = [
	225
	225
	225
	255
]
menu_unfocus_color = [
	170
	170
	170
	200
]

script set_focus_color 
	if gotparam \{color}
		if structurecontains structure = ($g_menu_colors) <color>
			if NOT ($menu_focus_color = (($g_menu_colors).<color>))
				change menu_focus_color = (($g_menu_colors).<color>)
			endif
			return
		else

		endif
	endif
	if gotparam \{rgba}
		if NOT ($menu_focus_color = <rgba>)
			change menu_focus_color = <rgba>

		endif
		return
	endif
	if NOT ($menu_focus_color = (($g_menu_colors).($default_menu_focus_color)))
		change menu_focus_color = (($g_menu_colors).($default_menu_focus_color))

	endif
endscript

script set_unfocus_color 
	if gotparam \{color}
		if structurecontains structure = ($g_menu_colors) <color>
			if NOT ($menu_unfocus_color = (($g_menu_colors).<color>))
				change menu_unfocus_color = (($g_menu_colors).<color>)
			endif
			return
		else

		endif
	endif
	if gotparam \{rgba}
		if NOT ($menu_unfocus_color = <rgba>)
			change menu_unfocus_color = <rgba>

		endif
		return
	endif
	if NOT ($menu_unfocus_color = (($g_menu_colors).($default_menu_unfocus_color)))
		change menu_unfocus_color = (($g_menu_colors).($default_menu_unfocus_color))

	endif
endscript

script reset_focus_colors 
	change menu_focus_color = (($g_menu_colors).($default_menu_focus_color))
	change menu_unfocus_color = (($g_menu_colors).($default_menu_unfocus_color))
endscript

script retail_menu_focus 
	if gotparam \{id}
		if screenelementexists id = <id>
			<id> :getsingletag old_font
			if NOT gotparam \{old_font}
				<id> :se_getprops
				<id> :settags old_font = <font>
			endif
			<id> :se_setprops rgba = ($menu_focus_color)
		endif
	else
		getsingletag \{old_font}
		if NOT gotparam \{old_font}
			se_getprops
			settags old_font = <font>
		endif
		setprops rgba = ($menu_focus_color)
	endif
endscript

script retail_menu_unfocus 
	if gotparam \{id}
		if screenelementexists id = <id>
			<id> :getsingletag old_font
			if NOT gotparam \{old_font}
				<id> :se_getprops
				<id> :settags old_font = <font>
				<id> :getsingletag old_font
			endif
			<id> :se_setprops rgba = ($menu_unfocus_color) font = <old_font> material = null
		endif
	else
		getsingletag \{old_font}
		if NOT gotparam \{old_font}
			se_getprops
			settags old_font = <font>
			getsingletag \{old_font}
		endif
		setprops rgba = ($menu_unfocus_color) font = <old_font> material = null
	endif
endscript

script menu_flow_go_back \{player = 1
		create_params = {
		}
		destroy_params = {
		}}
	ui_flow_manager_respond_to_action action = go_back player = <player> create_params = <create_params> destroy_params = <destroy_params>
endscript

script new_menu {
		menu_pos = $menu_pos
		event_handlers = $default_event_handlers
		use_backdrop = 0
		z = 1
		dims = (400.0, 480.0)
		font = fontgrid_text_a1
		font_size = <font_size>
		default_colors = 1
		just = [left top]
		internal_just = [center top]
		menu_parent = root_window
		scrollid = current_scrollmenu
		vmenuid = current_menu
	}
	if screenelementexists id = <scrollid>

		return
	endif
	if screenelementexists id = <vmenuid>

		return
	endif
	createscreenelement {
		type = vscrollingmenu
		parent = <menu_parent>
		id = <scrollid>
		just = <just>
		dims = <dims>
		pos = <menu_pos>
		z_priority = <z>
	}
	if (<use_backdrop> = 1)
		create_generic_backdrop
	endif
	if gotparam \{name}
		createscreenelement {
			type = textelement
			parent = <scrollid>
			font = fontgrid_text_a1
			pos = (0.0, -45.0)
			font_size = 0.2
			rgba = [175 175 175 255]
			text = <name>
			just = <just>
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [0 0 0 255]
		}
	endif
	createscreenelement {
		type = vmenu
		parent = <scrollid>
		id = <vmenuid>
		pos = (0.0, 0.0)
		just = <just>
		internal_just = <internal_just>
		event_handlers = <event_handlers>
		position_children
		rot_angle = <rot_angle>
		spacing_between = <spacing>
		position_children = <position_children>
	}
	if gotparam \{no_wrap}
		setscreenelementprops id = <vmenuid> allow_wrap = false
	endif
	if gotparam \{text_left}
		setscreenelementprops id = <vmenuid> internal_just = [left top]
	endif
	if gotparam \{text_right}
		setscreenelementprops id = <vmenuid> internal_just = [right top]
	endif
	if gotparam \{use_all_controllers}
		removeparameter \{exclusive_device}
		get_all_exclusive_devices
	endif
	if NOT gotparam \{exclusive_device}
		exclusive_device = ($primary_controller)
	endif
	if NOT (<exclusive_device> = none)
		setscreenelementprops {
			id = <scrollid>
			exclusive_device = <exclusive_device>
		}
		setscreenelementprops {
			id = <vmenuid>
			exclusive_device = <exclusive_device>
		}
	endif
	if gotparam \{tierlist}
		tier = 0
		begin
		<tier> = (<tier> + 1)
		setlist_prefix = (<tierlist>.prefix)
		formattext checksumname = tiername '%ptier%i' p = <setlist_prefix> i = (<tier>)
		formattext checksumname = tier_checksum 'tier%s' s = (<tier>)
		<unlocked> = 1
		if ((<unlocked> = 1) || ($is_network_game))
			getarraysize (<tierlist>.<tier_checksum>.songs)
			song_count = 0
			if (<array_size> > 0)
				begin
				format_globaltag_song_checksum part = (<tierlist>.part) song = (<tierlist>.<tier_checksum>.songs [<song_count>])
				for_bonus = 0
				if ($current_tab = tab_bonus)
					<for_bonus> = 1
				endif
				if issongavailable song_checksum = <song_checksum> song = (<tierlist>.<tier_checksum>.songs [<song_count>]) for_bonus = <for_bonus>
					get_song_title song = (<tierlist>.<tier_checksum>.songs [<song_count>])
					createscreenelement {
						type = textelement
						parent = <vmenuid>
						font = <font>
						scale = <font_size>
						rgba = [210 210 210 250]
						text = <song_title>
						just = [left top]
						event_handlers = [
							{focus menu_focus}
							{unfocus menu_unfocus}
							{pad_choose <on_choose> params = {tier = <tier> song_count = <song_count>}}
							{pad_left <on_left> params = {tier = <tier> song_count = <song_count>}}
							{pad_select <on_select> params = {tier = <tier> song_count = <song_count>}}
							{pad_right <on_right> params = {tier = <tier> song_count = <song_count>}}
							{pad_l3 <on_l3> params = {tier = <tier> song_count = <song_count>}}
						]
					}
				endif
				song_count = (<song_count> + 1)
				repeat <array_size>
			endif
		endif
		repeat (<tierlist>.num_tiers)
	endif
	if (<default_colors>)
		set_focus_color rgba = ($default_menu_focus_color)
		set_unfocus_color rgba = ($default_menu_unfocus_color)
	endif
endscript

script destroy_menu \{menu_id = current_scrollmenu}
	if gotparam \{menu_id}
		if screenelementexists id = <menu_id>
			destroyscreenelement id = <menu_id>
		endif
		destroy_generic_backdrop
	endif
endscript

script add_new_menu_item \{parent = current_menu
		focus_script = retail_menu_focus
		unfocus_script = retail_menu_unfocus}
	if globalexists \{name = massive_build}
		if NOT ($massive_build = 0)
			if gotparam \{massive_secret_item}
				return
			endif
		endif
	endif
	if NOT screenelementexists id = <parent>

	endif
	createscreenelement {
		type = textelement
		parent = <parent>
		local_id = text
		font = fontgrid_title_a1
		rgba = ($menu_unfocus_color)
		<...>
		event_handlers = [
			{focus <focus_script> params = <focus_params>}
			{unfocus <unfocus_script> params = <unfocus_params>}
			{pad_choose <choose_script> params = <choose_params>}
		]
	}
	return {id = <id>}
endscript

script guitar_menu_highlighter \{zpri = 50}
	if gotparam \{text_id}
		getscreenelementdims id = <text_id>
		hilite_dims = (<width> * (1.0, 0.0) + <height> * (0.0, 0.7) + (20.0, -1.0))
		bookend_dims = (<height> * (0.5, 0.5))
		hilite_pos = ((<hlinfolist> [<hlindex>]).posh + (-2.0, 2.0))
		setscreenelementprops {
			id = <wthlid>
			pos = <hilite_pos>
			dims = <hilite_dims>
			z_priority = <zpri>
		}
		setscreenelementprops {
			id = <be1id>
			pos = (<hilite_pos> - <bookend_dims>.(1.0, 0.0) * (0.6, 0.0) + <height> * (0.0, 0.1))
			dims = <bookend_dims>
			z_priority = <zpri>
		}
		setscreenelementprops {
			id = <be2id>
			pos = (<hilite_pos> + (<hilite_dims>.(1.0, 0.0) * (1.0, 0.0)) + <height> * (0.0, 0.1) - (<bookend_dims>.(1.0, 0.0) * (0.1, 0.0)))
			dims = <bookend_dims>
			z_priority = <zpri>
			flip_h
		}
	else
		setscreenelementprops {
			id = <be1id>
			pos = ((<hlinfolist> [<hlindex>]).posl)
			dims = ((<hlinfolist> [<hlindex>]).bedims)
			z_priority = <zpri>
		}
		setscreenelementprops {
			id = <be2id>
			pos = ((<hlinfolist> [<hlindex>]).posr)
			dims = ((<hlinfolist> [<hlindex>]).bedims)
			z_priority = <zpri>
		}
		setscreenelementprops {
			id = <wthlid>
			pos = ((<hlinfolist> [<hlindex>]).posh)
			dims = ((<hlinfolist> [<hlindex>]).hdims)
			z_priority = <zpri>
		}
	endif
endscript

script glow_menu_element \{time = 1}
	if NOT screenelementexists id = <id>
		return
	endif
	wait RandomInteger (0.0, 2.0) seconds
	begin
	<id> :legacydomorph alpha = 1 time = <time> motion = smooth
	<id> :legacydomorph alpha = 0 time = <time> motion = smooth
	repeat
endscript

script create_play_song_menu 
	show_highway
endscript

script destroy_play_song_menu 
	hide_highway
endscript

script issingleplayergame 
	gamemode_getproperty \{prop = singleplayer}
	return <singleplayer>
endscript

script options_change_vocals_highway_view 

	resetscoreupdateready
	vocals_get_highway_view player = <player>
	<vocals_highway_view> = <highway_view>
	if (<vocals_highway_view> = static)
		<vocals_highway_view> = scrolling
	else
		<vocals_highway_view> = static
	endif
	vocals_set_highway_view player = <player> view = <vocals_highway_view> controller = <device_num>
	i = 1
	begin
	vocals_set_highway_view player = <i> view = <vocals_highway_view> controller = <device_num>
	i = (<i> + 1)
	repeat 4
	if isobjectscript
		obj_getid
		if (<vocals_highway_view> = static)
			soundevent \{event = checkbox_sfx}
			<objid> :se_setprops check_alpha = 0
			<objid> :se_setprops cross_alpha = 1
		else
			soundevent \{event = checkbox_check_sfx}
			<objid> :se_setprops check_alpha = 1
			<objid> :se_setprops cross_alpha = 0
		endif
	endif
	if NOT gotparam \{no_restart}
		0xe9384b7a \{full}
		gh3_sfx_fail_song_stop_sounds
		if ($game_mode = practice)
			spawnscriptnow \{practice_restart_song}
		else
			spawnscriptnow \{career_restart_song}
		endif
		generic_event_back \{state = uistate_gameplay}
	endif
endscript

script options_change_vocals_sp_clap \{x_tex = data_settings_xmark
		check_tex = data_settings_checkmark}

	getplayerinfo player = <player> vocals_sp_clap
	if (<vocals_sp_clap> = 1)
		<vocals_sp_clap> = 0
	else
		<vocals_sp_clap> = 1
	endif
	vocals_set_star_power_clap player = <player> clap = <vocals_sp_clap> controller = <device_num>
	if isobjectscript
		obj_getid
		if gotparam \{checkbox_child}
			child = <checkbox_child>
		else
			child = check
		endif
		if (<vocals_sp_clap> = 0)
			soundevent \{event = checkbox_sfx}
			<objid> :se_setprops check_alpha = 0
			<objid> :se_setprops cross_alpha = 1
		else
			soundevent \{event = checkbox_check_sfx}
			<objid> :se_setprops check_alpha = 1
			<objid> :se_setprops cross_alpha = 0
		endif
	endif
endscript

script options_change_tilt_star_power 
	getplayerinfo <player> use_tilt_for_starpower
	getplayerinfo <player> checksum
	get_savegame_from_player_status player_status = <checksum>
	if (<use_tilt_for_starpower> = 1)
		soundevent \{event = checkbox_sfx}
		setplayerinfo <player> use_tilt_for_starpower = 0
		setglobaltags savegame = <savegame> user_options params = {use_tilt_for_starpower_save = 0}
		<new_texture> = options_controller_x
	else
		soundevent \{event = checkbox_check_sfx}
		setplayerinfo <player> use_tilt_for_starpower = 1
		setglobaltags savegame = <savegame> user_options params = {use_tilt_for_starpower_save = 1}
		<new_texture> = options_controller_check
	endif
	if isobjectscript
		obj_getid
		if resolvescreenelementid id = {<objid> child = tilt_check}
			<resolved_id> :setprops texture = <new_texture>
		else
			if (<use_tilt_for_starpower> = 1)
				<use_tilt_for_starpower> = 0
				soundevent \{event = checkbox_sfx}
				if gotparam \{popup}
					<objid> :se_setprops check_alpha = 0
					<objid> :se_setprops cross_alpha = 1
				else
					<objid> :se_setprops check_alpha = 0
					<objid> :se_setprops cross_alpha = 1
				endif
			else
				<use_tilt_for_starpower> = 1
				soundevent \{event = checkbox_check_sfx}
				if gotparam \{popup}
					<objid> :se_setprops check_alpha = 1
					<objid> :se_setprops cross_alpha = 0
				else
					<objid> :se_setprops check_alpha = 1
					<objid> :se_setprops cross_alpha = 0
				endif
			endif
		endif
	endif
endscript

script options_change_touch_strip_option 
	getplayerinfo <player> enable_touch_strip
	getplayerinfo <player> checksum
	get_savegame_from_player_status player_status = <checksum>
	if (<enable_touch_strip> = 1)
		soundevent \{event = checkbox_sfx}
		setplayerinfo <player> enable_touch_strip = 0
		setglobaltags savegame = <savegame> user_options params = {enable_touch_strip_save = 0}
		<new_texture> = options_controller_x
	else
		soundevent \{event = checkbox_check_sfx}
		setplayerinfo <player> enable_touch_strip = 1
		setglobaltags savegame = <savegame> user_options params = {enable_touch_strip_save = 1}
		<new_texture> = options_controller_check
	endif
	if isobjectscript
		obj_getid
		if resolvescreenelementid id = {<objid> child = touch_check}
			<resolved_id> :setprops texture = <new_texture>
		else
			if (<enable_touch_strip> = 1)
				<enable_touch_strip> = 0
				soundevent \{event = checkbox_sfx}
				if gotparam \{popup}
					<objid> :se_setprops check_alpha = 0
					<objid> :se_setprops cross_alpha = 1
				else
					<objid> :se_setprops check_alpha = 0
					<objid> :se_setprops cross_alpha = 1
				endif
			else
				<enable_touch_strip> = 1
				soundevent \{event = checkbox_check_sfx}
				if gotparam \{popup}
					<objid> :se_setprops check_alpha = 1
					<objid> :se_setprops cross_alpha = 0
				else
					<objid> :se_setprops check_alpha = 1
					<objid> :se_setprops cross_alpha = 0
				endif
			endif
		endif
	endif
endscript

script destroy_pause_menu 
	clean_up_user_control_helpers
	destroy_pause_menu_frame
	destroy_menu \{menu_id = scrolling_pause}
	destroy_menu \{menu_id = pause_menu_frame_container}
	killspawnedscript \{name = animate_bunny_flame}
	if screenelementexists \{id = warning_message_container}
		destroyscreenelement \{id = warning_message_container}
	endif
	if screenelementexists \{id = leaving_lobby_dialog_menu}
		destroyscreenelement \{id = leaving_lobby_dialog_menu}
	endif
	destroy_pause_menu_frame \{container_id = net_quit_warning}
endscript

script create_menu_backdrop \{texture = menu_venue_bg
		rgba = [
			255
			255
			255
			255
		]
		z_priority = 0}
	if screenelementexists \{id = menu_backdrop_container}
		destroyscreenelement \{id = menu_backdrop_container}
	endif
	createscreenelement \{type = containerelement
		parent = root_window
		id = menu_backdrop_container
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	createscreenelement {
		type = spriteelement
		parent = menu_backdrop_container
		id = menu_backdrop
		texture = <texture>
		rgba = <rgba>
		pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [center center]
		z_priority = <z_priority>
	}
endscript

script destroy_menu_backdrop 
	if screenelementexists \{id = menu_backdrop_container}
		destroyscreenelement \{id = menu_backdrop_container}
	endif
endscript

script create_pause_menu_frame \{x_scale = 1
		y_scale = 1
		tile_sprite = 1
		container_id = pause_menu_frame_container
		z = 0
		gradient = 1
		parent = root_window}
	tile_sprite = 0
	<alpha> = 1
	createscreenelement {
		type = containerelement
		parent = <parent>
		id = <container_id>
		pos = (0.0, 0.0)
		just = [left top]
		z_priority = <z>
		alpha = <alpha>
	}
	<center_pos> = (640.0, 360.0)
	pos_scale_2 = ((0.0, -5.0) * <y_scale>)
	scale_1 = ((1.5, 0.0) * <x_scale> + (0.0, 1.4) * <y_scale>)
	scale_2 = ((1.4, 0.0) * <x_scale> + (0.0, 1.4) * <y_scale>)
	scale_3 = ((1.4, 0.0) * <x_scale> + (0.0, 1.3499999) * <y_scale>)
	scale_4 = ((1.575, 0.0) * <x_scale> + (0.0, 1.5) * <y_scale>)
	scale_5 = ((1.5, 0.0) * <x_scale> + (0.0, 1.4) * <y_scale>)
	if (<tile_sprite> = 1)
		createscreenelement {
			type = windowelement
			parent = <container_id>
			id = pause_menu_scrolling_bg_01
			pos = (642.0, 360.0)
			dims = ((508.0, 0.0) * <x_scale> + (0.0, 340.0) * <y_scale>)
			just = [center center]
			z_priority = (<z> - 1)
		}
		runscriptonscreenelement tilespriteloop id = <id> params = {move_x = -2 move_y = -2}
	else
		createscreenelement {
			type = spriteelement
			id = frame_background
			parent = <container_id>
			rgba = [0 0 0 255]
			pos = (640.0, 360.0)
			just = [center center]
			dims = ((520.0, 0.0) * <x_scale> + (0.0, 340.0) * <y_scale>)
			z_priority = (<z> - 1)
		}
	endif
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_2
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [bottom right]
		z_priority = (<z> + 2)
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_2
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [top right]
		z_priority = (<z> + 2)
		flip_v
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_2
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [top left]
		z_priority = (<z> + 2)
		flip_v
		flip_h
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_2
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [bottom left]
		z_priority = (<z> + 2)
		flip_h
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [bottom right]
		z_priority = (<z> + 2)
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [top right]
		z_priority = (<z> + 2)
		flip_v
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [top left]
		z_priority = (<z> + 2)
		flip_v
		flip_h
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [bottom left]
		z_priority = (<z> + 2)
		flip_h
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [bottom right]
		z_priority = (<z> + 2)
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [top right]
		z_priority = (<z> + 2)
		flip_v
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [top left]
		z_priority = (<z> + 2)
		flip_v
		flip_h
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [bottom left]
		z_priority = (<z> + 2)
		flip_h
	}
endscript

script destroy_pause_menu_frame \{container_id = pause_menu_frame_container}
	destroy_menu menu_id = <container_id>
endscript

script fit_text_convert_legacy_params_props 
	getscreenelementprops id = <id>
	return {scale = <scale>}
endscript

script fit_text_convert_legacy_params 
	if (<keep_ar> = 1)
		<preserve_aspect_ratio> = true
	else
		<preserve_aspect_ratio> = false
	endif
	if (<only_if_larger_x> = 1)
		removeparameter \{only_if_larger_x}
		<only_if_larger_x> = true
	else
		removeparameter \{only_if_larger_x}
		<only_if_larger_x> = false
	endif
	if gotparam \{start_x_scale}
		<factor_start_scale> = true
	elseif gotparam \{start_y_scale}
		<factor_start_scale> = true
	else
		fit_text_convert_legacy_params_props <...>
		<x_dim> = (<dims>.(1.0, 0.0))
		<y_dim> = (<dims>.(0.0, 1.0))
		<x_scale> = (<scale>.(1.0, 0.0))
		<y_scale> = (<scale>.(0.0, 1.0))
		<dims> = ((1.0, 0.0) * <x_dim> / <x_scale> + (0.0, 1.0) * <y_dim> / <y_scale>)
		<factor_start_scale> = false
	endif
	return {
		dims = <dims>
		factor_start_scale = <factor_start_scale>
		preserve_aspect_ratio = <preserve_aspect_ratio>
		only_if_larger_x = <only_if_larger_x>
	}
endscript

script fit_text_in_rectangle \{dims = (100.0, 100.0)
		keep_ar = 0
		only_if_larger_x = 0}
	if NOT gotparam \{id}

	endif
	fit_text_convert_legacy_params <...>
	<id> :se_fittodims {
		dims = <dims>
		factor_start_scale = <factor_start_scale>
		preserve_aspect_ratio = <preserve_aspect_ratio>
		only_if_larger_x = <only_if_larger_x>
		only_if_larger_y = false
	}
	if gotparam \{pos}
		setscreenelementprops id = <id> pos = <pos>
	endif
endscript

script set_user_control_color \{text_rgba = [
			0
			0
			0
			255
		]
		bg_rgba = [
			180
			180
			180
			255
		]}
	change user_control_pill_color = <bg_rgba>
	change user_control_pill_text_color = <text_rgba>
endscript

script 0x65330e0b 
	<0xa0ac0221> = 0
	begin
	getactivecontrollers
	<is_active_controller> = (<active_controllers> [(<controller>)])
	if ((<0xa0ac0221> = 0) && (<is_active_controller> = 1))
		0x356839b2 controller = <controller>
		<0xa0ac0221> = <0x39646908>
	endif
	if NOT (<is_active_controller> = 1)
		0xaf72357f controller = <controller>
		setscreenelementprops \{id = user_control_container
			alpha = 1}
	endif
	wait \{5
		gameframes}
	repeat
endscript

script 0xaf72357f 
	if (<controller> < 0)
		return
	endif
	begin
	getactivecontrollers
	<is_active_controller> = (<active_controllers> [(<controller>)])
	if (<is_active_controller> = 1)
		0x356839b2 controller = <controller>
		return
	endif
	wait \{5
		gameframes}
	repeat
endscript

script 0x356839b2 \{controller = $primary_controller}
	<0x39646908> = 0
	if NOT screenelementexists \{id = user_control_container}
		return 0x39646908 = <0x39646908>
	endif
	if getscreenelementchildren \{id = user_control_container}
		getarraysize <children>
		if (<array_size> > 0)
			<index> = 0
			begin
			<child> = (<children> [<index>])
			<child> :gettags
			if (gotparam button)
				user_control_helper_get_buttonchar button = <button> controller = <controller>
				<child> :se_setprops {
					helper_button_text = <0x510ca03a>
				}
				<child> :desc_resolvealias name = alias_helper_button
				<resolved_id> :se_setprops {
					text = <buttonchar>
				}
			endif
			<index> = (<index> + 1)
			repeat <array_size>
			<0x39646908> = 1
		endif
		spawnscript \{0xa3509323}
	endif
	return 0x39646908 = <0x39646908>
endscript

script hide_user_control_helpers 
	0x0abb709d \{alpha = 0.0}
endscript

script 0xd13df5ab 
	0x0abb709d \{alpha = 1.1}
endscript

script 0x0abb709d 

	if screenelementexists \{id = user_control_container}
		user_control_container :se_setprops alpha = <alpha>
	endif
	if screenelementexists \{id = custom_setlist_continue_helper}
		custom_setlist_continue_helper :se_setprops alpha = <alpha>
	endif
	if screenelementexists \{id = 0xb0b1d617}
		0xb0b1d617 :se_setprops alpha = <alpha>
	endif
	if screenelementexists \{id = custom_setlist_continue_pill}
		custom_setlist_continue_pill :se_setprops alpha = <alpha>
	endif
	if screenelementexists \{id = calibrate_highway_user_pills_container}
		calibrate_highway_user_pills_container :se_setprops alpha = <alpha>
	endif
endscript

script clean_up_user_control_helpers 
	if scriptisrunning \{0x65330e0b}
		killspawnedscript \{name = 0x65330e0b}
	endif
	if scriptisrunning \{0xaf72357f}
		killspawnedscript \{name = 0xaf72357f}
	endif
	if screenelementexists \{id = user_control_container}
		destroyscreenelement \{id = user_control_container}
	endif
	if screenelementexists \{id = custom_setlist_continue_helper}
		destroyscreenelement \{id = custom_setlist_continue_helper}
	endif
	if screenelementexists \{id = 0xb0b1d617}
		destroyscreenelement \{id = 0xb0b1d617}
	endif
	if screenelementexists \{id = custom_setlist_continue_pill}
		destroyscreenelement \{id = custom_setlist_continue_pill}
	endif
	if screenelementexists \{id = calibrate_highway_user_pills_container}
		destroyscreenelement \{id = calibrate_highway_user_pills_container}
	endif
	change \{user_control_pill_color = [
			180
			180
			180
			255
		]}
	change \{user_control_pill_text_color = [
			0
			0
			0
			255
		]}
	change \{user_control_pill_scale = 0.6}
	set_user_control_color
endscript

script user_control_helper_get_buttonchar 
	if gotparam \{controller}
		if (<controller> < 0)
			removeparameter \{controller}
		endif
	endif
	if NOT gotparam \{controller}
		controller = $primary_controller
		if NOT (<controller> = $last_start_pressed_device)
			controller = $last_start_pressed_device
		endif
	endif
	if NOT (<controller> < 0)
		if NOT ((isguitarcontroller controller = <controller>) || (isdrumcontroller controller = <controller>))
			getactivecontrollers
			getarraysize <active_controllers>
			if (<controller> < <array_size>)
				if (<active_controllers> [<controller>] = 1)
					standard = 1
				endif
			endif
		elseif isdrumcontroller controller = <controller>
			drum = 1
			standard = 1
		endif
	endif
	if gotparam \{all_buttons}
		removeparameter \{all_buttons}
	endif
	if gotparam \{button}
		switch (<button>)
			case green
			buttonchar = qs(0x9026221e)
			if gotparam \{standard}
				buttonchar = qs(0xdf67b4d9)
			endif
			if gotparam \{all_buttons}
				buttonchar = qs(0xa11b5a77)
			endif
			case red
			buttonchar = qs(0x893d135f)
			if gotparam \{standard}
				buttonchar = qs(0xb532c60d)
			endif
			if gotparam \{all_buttons}
				buttonchar = qs(0x74aa6ba8)
			endif
			case yellow
			buttonchar = qs(0xa210409c)
			if gotparam \{standard}
				buttonchar = qs(0x64f07d44)
			endif
			if gotparam \{all_buttons}
				buttonchar = qs(0x1da23f16)
			endif
			case blue
			buttonchar = qs(0xbb0b71dd)
			if gotparam \{standard}
				buttonchar = qs(0x8704a48f)
			endif
			if gotparam \{all_buttons}
				buttonchar = qs(0xc8130ec9)
			endif
			case orange
			buttonchar = qs(0x3c936d12)
			if gotparam \{standard}
				buttonchar = qs(0xe244f542)
			endif
			if gotparam \{drum}
				buttonchar = qs(0xc969a681)
			endif
			if gotparam \{all_buttons}
				buttonchar = qs(0x667a6f93)
			endif
			case strumbar
			buttonchar = qs(0x7cc7d8cc)
			if gotparam \{standard}
				buttonchar = qs(0x72fe6f1c)
			endif
			case back
			buttonchar = qs(0x25885c53)
			if gotparam \{standard}
				buttonchar = qs(0x3dbff9db)
			endif
			if gotparam \{all_buttons}
				buttonchar = qs(0xc969a681)
			endif
			case start
			buttonchar = qs(0x57ea8b0f)
			if gotparam \{standard}
				buttonchar = qs(0x24a4c89a)
			endif
			if gotparam \{all_buttons}
				buttonchar = qs(0x0433a81f)
			endif
			case lb
			buttonchar = qs(0x9f330107)
			case rb
			buttonchar = qs(0xb41e52c4)
			case lt
			buttonchar = qs(0xad056385)
			case rt
			buttonchar = qs(0xe244f542)
			case lbrb
			buttonchar = qs(0xbb0b71dd)
			if gotparam \{standard}
				buttonchar = qs(0x41c5c5a3)
			endif
			case pad_left
			buttonchar = qs(0x33864e0b)
			case drum_green
			buttonchar = qs(0x3605ca9d)
		endswitch
	else
		buttonchar = qs(0x03ac90f0)
	endif
	return {buttonchar = <buttonchar> controller_used = <controller>}
endscript

script should_use_all_buttons 
	get_all_exclusive_devices
	if NOT gotparam \{exclusive_device}
		return \{false}
	endif
	<standard_buttons> = false
	<guitar_buttons> = false
	getarraysize \{exclusive_device}
	if (<array_size> = 0)
		return \{false}
	endif
	<i> = 0
	begin
	if isguitarcontroller controller = (<exclusive_device> [<i>])
		<guitar_buttons> = true
	else
		<standard_buttons> = true
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	if (<guitar_buttons> = true && <standard_buttons> = true)
		return \{true}
	endif
	return \{false}
endscript

script pulsate_helper_pill \{time = 1
		delay_time = 1}

	setspawninstancelimits \{max = 1
		management = kill_oldest}
	wait <delay_time> seconds ignoreslomo
	begin
	if screenelementexists id = <id>
		<id> :se_setprops {
			alpha = 0.5
			time = <time>
		}
		wait <time> seconds ignoreslomo
		if screenelementexists id = <id>
			<id> :se_setprops {
				alpha = 1
				time = <time>
			}
			wait <time> seconds ignoreslomo
		else
			return
		endif
	else
		return
	endif
	repeat
endscript

script add_user_control_helper \{z = 10}
	0x9b2729dd = false
	if NOT screenelementexists \{id = user_control_container}
		<0x9b2729dd> = true
		createscreenelement {
			id = user_control_container
			parent = root_window
			type = menuelement
			dims = (1024.0, 36.0)
			pos = (0.0, -36.0)
			pos_anchor = [center bottom]
			just = [center bottom]
			internal_just = [center center]
			isvertical = false
			position_children = true
			fit_major = `fit content if larger`
			fit_minor = `keep dims`
			spacing_between = 10
			z_priority = <z>
		}
	endif
	params_struct = {
		helper_description_text = <text>
		helper_pill_rgba = $user_control_pill_color
		helper_description_rgba = $user_control_pill_text_color
		tags = {
			button = <button>
		}
	}
	extendcrc <button> '_helper_pill_ID' out = helper_pill_id
	if (<button> != none)
		user_control_helper_get_buttonchar <...> button = <button>
		addparam structure_name = params_struct name = helper_button_text value = <buttonchar>
	endif
	parent = user_control_container
	if gotparam \{override_parent}
		parent = <override_parent>
	endif
	if (<0x9b2729dd> = true)
		if NOT ((scriptisrunning 0x65330e0b) || (scriptisrunning 0xaf72357f))
			if gotparam \{controller}
				user_control_container :obj_spawnscriptnow 0x65330e0b params = {controller = (<controller>)}
			else
				user_control_container :obj_spawnscriptnow \{0x65330e0b
					params = {
						controller = $primary_controller
					}}
			endif
		endif
	endif
	if screenelementexists id = <helper_pill_id>
		destroyscreenelement id = <helper_pill_id>
	endif
	if gotparam \{leader}
		createscreenelement {
			parent = <parent>
			id = <helper_pill_id>
			type = descinterface
			desc = 'helper_pill_leader'
			auto_dims = false
			dims = (0.0, 36.0)
			pos = <pos>
			<params_struct>
		}
	else
		createscreenelement {
			parent = <parent>
			id = <helper_pill_id>
			type = descinterface
			desc = 'helper_pill'
			auto_dims = false
			dims = (0.0, 36.0)
			pos = <pos>
			<params_struct>
		}
	endif
	if (<button> != none)
		if gotparam \{all_buttons}
			if <id> :desc_resolvealias name = alias_helper_button
				<resolved_id> :se_setprops {
					metaremapenable = false
					text = <buttonchar>
				}
			endif
		endif
	endif
	<id> :se_getprops
	<id> :se_setprops {
		helper_pill_body_dims = (((0.6, 0.0) * <helper_pill_menu_dims> [0]) + (0.0, 42.0))
		dims = (((0.6, 0.0) * <helper_pill_menu_dims> [0]) + (64.0, 32.0))
	}
	user_control_container :se_getprops
	user_control_container :se_setprops {
		helper_pill_body_dims = (((1.0, 0.0) * <helper_pill_menu_dims> [0]) + (0.0, 50.0))
	}
	if (<helper_pill_menu_dims> [0] > 950)
		user_control_container :se_setprops scale = (950.0 / <helper_pill_menu_dims> [0])
	endif
	return helper_pill_id = <id>
endscript

script 0xa3509323 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	waitonegameframe
	if NOT screenelementexists \{id = user_control_container}
		return
	endif
	if getscreenelementchildren \{id = user_control_container}
		getarraysize <children>
		if (<array_size> > 0)
			<index> = 0
			begin
			<child> = (<children> [<index>])
			<child> :se_getprops
			<child> :se_setprops {
				helper_pill_body_dims = (((0.6, 0.0) * <helper_pill_menu_dims> [0]) + (0.0, 42.0))
				dims = (((0.6, 0.0) * <helper_pill_menu_dims> [0]) + (64.0, 32.0))
			}
			<index> = (<index> + 1)
			repeat <array_size>
		endif
	endif
endscript

script user_control_helper_change_text 

	extendcrc <button> '_helper_pill_ID' out = helper_pill_id
	if screenelementexists id = <helper_pill_id>
		<helper_pill_id> :se_setprops {
			helper_description_text = <text>
		}
		spawnscript \{0xa3509323}
	else

	endif
endscript

script user_control_destroy_helper 

	extendcrc <button> '_helper_pill_ID' out = helper_pill_id
	if screenelementexists id = <helper_pill_id>
		destroyscreenelement id = <helper_pill_id>
	endif
endscript

script user_control_helper_exists 

	extendcrc <button> '_helper_pill_ID' out = helper_pill_id
	if screenelementexists id = <helper_pill_id>
		return \{true}
	else
		return \{false}
	endif
endscript

script get_diff_completion_text 
	diff_completion_percentage = [0 0 0 0 0]
	diff_completion_score = [0 0 0 0 0]
	diff_completion_text = [qs(0x03ac90f0) qs(0x03ac90f0) qs(0x03ac90f0) qs(0x03ac90f0) qs(0x03ac90f0)]
	get_progression_globals game_mode = ($game_mode) ($current_progression_flag)
	percentage_complete = 0
	difficulty_index = 0
	getarraysize ($difficulty_list)
	diff_size = <array_size>
	begin
	setlist_prefix = ($<tier_global>.prefix)
	songs_completed = 0
	songs_score = 0
	num_songs = 0
	tier_num = 1
	begin
	formattext checksumname = tier 'tier%d' d = <tier_num>
	getarraysize ($<tier_global>.<tier>.songs)
	songlist_size = <array_size>
	song_count = 0
	begin
	format_globaltag_song_checksum part = ($<tier_global>.part) song = ($<tier_global>.<tier>.songs [<song_count>]) difficulty_index = <difficulty_index>
	getglobaltags <song_checksum> params = {stars score}
	if NOT (<stars> = 0)
		<songs_completed> = (<songs_completed> + 1)
		<songs_score> = (<songs_score> + <score>)
	endif
	<num_songs> = (<num_songs> + 1)
	<song_count> = (<song_count> + 1)
	repeat <songlist_size>
	tier_num = (<tier_num> + 1)
	repeat ($<tier_global>.num_tiers)
	formattext textname = diff_completion_string qs(0x18a8b83c) a = <songs_completed> b = <num_songs>
	setarrayelement arrayname = diff_completion_text index = (<difficulty_index>) newvalue = (<diff_completion_string>)
	<percentage_complete> = (<percentage_complete> + (100 * <songs_completed>) / <num_songs>)
	setarrayelement arrayname = diff_completion_percentage index = (<difficulty_index>) newvalue = ((100 * <songs_completed>) / <num_songs>)
	setarrayelement arrayname = diff_completion_score index = (<difficulty_index>) newvalue = <songs_score>
	<difficulty_index> = (<difficulty_index> + 1)
	repeat <diff_size>
	if gotparam \{for_get_diff_completion_percentage}
		return diff_completion_percentage = <diff_completion_percentage> percentage_complete = <percentage_complete> diff_completion_score = <diff_completion_score>
	else
		return diff_completion_text = <diff_completion_text>
	endif
endscript

script dim_screen 
	if screenelementexists \{id = dim_screen}
		destroyscreenelement \{id = dim_screen}
	endif
	if NOT gotparam \{undim}
		createscreenelement \{type = spriteelement
			id = dim_screen
			parent = root_window
			pos = (640.0, 360.0)
			dims = (1280.0, 720.0)
			just = [
				center
				center
			]
			rgba = [
				0
				0
				0
				128
			]
			z_priority = -1000}
	endif
endscript

script displaysprite \{just = [
			left
			top
		]
		rgba = [
			255
			255
			255
			255
		]
		dims = {
		}
		blendmode = {
		}
		internal_just = {
		}
		scale = {
		}
		alpha = 1}
	if gotparam \{rot_angle}
		rot_struct = {rot_angle = <rot_angle>}
	else
		rot_struct = {}
	endif
	createscreenelement {
		type = spriteelement
		id = <id>
		parent = <parent>
		texture = <tex>
		dims = <dims>
		rgba = <rgba>
		pos = <pos>
		just = <just>
		internal_just = <internal_just>
		z_priority = <z>
		scale = <scale>
		<rot_struct>
		blend = <blendmode>
		alpha = <alpha>
	}
	if gotparam \{flip_v}
		<id> :se_setprops flip_v
	endif
	if gotparam \{flip_h}
		<id> :se_setprops flip_h
	endif
	return id = <id>
endscript

script displaytext \{id = {
		}
		just = [
			left
			top
		]
		rgba = [
			210
			130
			0
			250
		]
		font = fontgrid_text_a1
		rot = 0}
	createscreenelement {
		type = textelement
		parent = <parent>
		font = <font>
		scale = <scale>
		rgba = <rgba>
		text = <text>
		id = <id>
		pos = <pos>
		just = <just>
		rot_angle = <rot>
		z_priority = <z>
		font_spacing = <font_spacing>
	}
	if gotparam \{noshadow}
		<id> :se_setprops noshadow
	else
		<id> :se_setprops shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]
	endif
	return id = <id>
endscript
g_num_scrolling_texts = 0

script scroll_ticker_text {
		ticker_text = qs(0x73dbd1ae)
		ticker_space = qs(0x713755f7)
		ticker_pos = (128.0, 598.0)
		ticker_just = [left top]
		ticker_parent = root_window
		ticker_x_scale = 0.6
		ticker_y_scale = 0.6
		ticker_font = fontgrid_text_a1
		ticker_rgba1 = (($g_menu_colors).white230)
		ticker_rgba2 = (($g_menu_colors).white230)
		ticker_alpha = 1.0
		ticker_z_priority = -1
		time = 5
	}
	formattext \{checksumname = ticker_text_id_1
		'scrolling_ticker_text_%i_1'
		i = $g_num_scrolling_texts}
	createscreenelement {
		type = textelement
		just = <ticker_just>
		id = <ticker_text_id_1>
		parent = <ticker_parent>
		pos = <ticker_pos>
		scale = ((<ticker_x_scale> * (1.0, 0.0)) + (<ticker_y_scale> * (0.0, 1.0)))
		font = <ticker_font>
		text = <ticker_text>
		rgba = <ticker_rgba1>
		alpha = <ticker_alpha>
		z_priority = <ticker_z_priority>
	}
	getscreenelementdims id = <ticker_text_id_1>
	if (<width> > 0)
		multi = (1280 / <width>)
	else

	endif
	ticker_text_with_space = (<ticker_text> + <ticker_space>)
	long_ticker_text = <ticker_text_with_space>
	stringlength string = <ticker_text_with_space>
	<ticker_text_with_space_length> = <str_len>
	begin
	stringlength string = <long_ticker_text>
	<long_ticker_text_length> = <str_len>
	if NOT (<long_ticker_text_length> < (127 - <ticker_text_with_space_length>))
		break
	endif
	<long_ticker_text> = (<long_ticker_text> + <ticker_text_with_space>)
	<ticker_text_id_1> :se_setprops text = <long_band_text>
	getscreenelementdims id = <ticker_text_id_1>
	if (<width> > 1280)
		break
	endif
	repeat <multi>
	<ticker_text_id_1> :se_setprops text = <long_ticker_text> pos = <ticker_pos>
	formattext \{checksumname = ticker_text_id_2
		'scrolling_ticker_text_%i_2'
		i = $g_num_scrolling_texts}
	createscreenelement {
		id = <ticker_text_id_2>
		type = textelement
		just = <ticker_just>
		parent = <ticker_parent>
		scale = ((<ticker_x_scale> * (1.0, 0.0)) + (<ticker_y_scale> * (0.0, 1.0)))
		font = <ticker_font>
		text = <long_ticker_text>
		rgba = <ticker_rgba2>
		alpha = <ticker_alpha>
		z_priority = <ticker_z_priority>
	}
	getscreenelementdims id = <ticker_text_id_1>
	<ticker_text_id_2> :se_setprops pos = (((1.0, 0.0) * <width>) + <ticker_pos>)
	change g_num_scrolling_texts = ($g_num_scrolling_texts + 1)
	<first> = 1
	begin
	if (<first>)
		<ticker_text_id_1> :se_setprops pos = (((-1.0, 0.0) * <width>) + <ticker_pos>) time = <time>
		<ticker_text_id_2> :se_setprops pos = <ticker_pos> time = <time>
	else
		<ticker_text_id_2> :se_setprops pos = (((-1.0, 0.0) * <width>) + <ticker_pos>) time = <time>
		<ticker_text_id_1> :se_setprops pos = <ticker_pos> time = <time>
	endif
	wait <time> seconds
	if (<first>)
		<ticker_text_id_1> :se_setprops pos = (((1.0, 0.0) * <width>) + <ticker_pos>)
		<ticker_text_id_2> :se_setprops pos = <ticker_pos>
		<first> = 0
	else
		<ticker_text_id_2> :se_setprops pos = (((1.0, 0.0) * <width>) + <ticker_pos>)
		<ticker_text_id_1> :se_setprops pos = <ticker_pos>
		<first> = 1
	endif
	repeat
endscript

script ui_frazz_something 
	begin
	scale = Random (@*10 (1.0, 1.0) @ (1.1, 0.3) @ (0.9, 1.0) )
	se_setprops scale = <scale> rgba = [255 255 255 255] time = 0.2
	se_waitprops
	se_setprops \{scale = (1.0, 1.0)
		rgba = [
			200
			220
			255
			255
		]}
	se_waitprops
	repeat
endscript

script ui_frazzmatazz \{0xffd05882 = 1.0}
	if getsingletag \{0x45278e0d}
		return
	endif
	settags \{0x45278e0d}
	if (<0xffd05882> > 1.0)
		<0xffd05882> = 1.0
	else
		if (<0xffd05882> < 0.0)
			<0xffd05882> = 0.0
		endif
	endif
	begin
	scale = Random (@*10 (1.0, 1.0) @ (1.2, 1.2) @ (1.1, 1.1) @ (1.15, 1.15) @ (1.05, 1.05) )
	alpha = Random (@ (0.3) @ (0.4) @ (0.5) @ (0.6) @ (0.8) @ (1) )
	se_setprops alpha = (<alpha> * <0xffd05882>) scale = <scale> time = 1
	se_waitprops
	se_setprops \{scale = (1.0, 1.0)}
	se_waitprops
	wait \{1
		gameframe}
	repeat
endscript

script ui_frazzmatazz_02 
	begin
	scale = Random (@*10 (1.0, 1.0) @ (1.05, 1.05) @ (1.1, 1.1) @ (1.05, 1.05) @ (1.03, 1.03) )
	alpha = Random (@ (0.25) @ (0.1) @ (0.2) @ (0.15) @ (0.2) @ (0.1) )
	se_setprops alpha = <alpha> scale = <scale> time = 1
	se_waitprops
	se_setprops \{scale = (1.0, 1.0)}
	se_waitprops
	wait \{1
		gameframe}
	repeat
endscript

script ui_alphaflight 
	begin
	alpha = Random (@*10 (1) @ (0.4) @ (0.5) @ (0.6) @ (0.7) @ (0.8) @ (0.9) )
	se_setprops alpha = <alpha> time = 1
	se_waitprops
	repeat
endscript

script ui_alphablast 
	begin
	alpha = Random (@ (1) @ (0.5) @ (0.25) @ (0.75) @ (0.0) )
	scale = Random (@ (1.0, 1.0) @ (1.0, 1.1) @ (1.0, 1.15) @ (1.0, 1.2) @ (1.0, 1.05) )
	se_setprops alpha = <alpha> time = 0.35000002
	se_waitprops
	repeat
endscript

script ui_herkyjerky 
	begin
	pos = Random (@ (0.0, 0.0) @ (-10.0, -10.0) @ (-30.0, -30.0) @ (-20.0, -20.0) @ (20.0, 20.0) @ (25.0, 25.0) @ (50.0, 50.0) @ (10.0, 10.0) )
	scale = Random (@ (1.0, 1.0) @ (1.2, 1.2) @ (1.1, 1.1) @ (1.15, 1.15) @ (1.05, 1.05) )
	alpha = Random (@*100 (1) @ (0.5) @ (0.6) @ (0.7) @ (0.8) @ (0.9) )
	se_setprops pos = <pos> scale = <scale> alpha = <alpha> time = 0.08
	se_waitprops
	se_setprops \{pos = (0.0, 0.0)
		scale = (1.0, 1.0)}
	r = Random (@ 1 @ 4 @ 5 @ 3 @ 3 )
	wait <r> seconds
	repeat
endscript

script ui_shakey 
	if getsingletag \{0x793d254f}
		return
	endif
	settags \{0x793d254f}
	if gotparam \{0x4d641ae8}
		se_getprops \{pos}
		orig_pos = <pos>
	else
		orig_pos = (0.0, 0.0)
	endif
	begin
	0x2100cff0 = Random (@ (0.0, 0.0) @ (-2.0, -2.0) @ (-3.0, -3.0) @ (-1.0, -1.0) @ (2.5, 2.5) @ (1.0, 1.0) @ (2.0, 1.0) )
	if gotparam \{0xe99089a3}
		0x2100cff0 = (<0x2100cff0> * <0xe99089a3>)
	endif
	0x2100cff0 = (<0x2100cff0> + <orig_pos>)
	se_setprops pos = <0x2100cff0> time = 0.08
	se_waitprops
	wait \{0.08
		seconds}
	repeat
endscript

script ui_shakey_02 
	begin
	pos = Random (@ (0.0, 0.0) @ (-1.0, -1.0) @ (-3.0, -3.0) @ (-1.0, -1.0) @ (2.5, 2.5) @ (-3.0, 1.0) @ (2.0, 1.0) )
	se_setprops pos = <pos> time = 0.15
	se_waitprops
	wait \{0.15
		seconds}
	repeat
endscript

script ui_roto 
	begin
	scale = Random (@*2 (1.0, 1.0) @ (1.05, 1.01) @ (1.03, 1.08) @ (1.03, 1.05) @ (1.09, 1.07) )
	rot_angle = Random (@ 1 @ 2 @ -1 @ -2 )
	se_setprops scale = <scale> rot_angle = <rot_angle> time = 0.05
	se_waitprops
	wait \{0.05
		seconds}
	repeat
endscript

script 0xede0dce9 
	se_getprops \{rot_angle
		alpha}
	0x5e6cd985 = <rot_angle>
	orig_alpha = <alpha>
	begin
	rot_angle = Random (@ 0.2 @ 0.3 @ 0 @ -0.2 @ -0.3 )
	if gotparam \{0x73cf7bd8}
		rand_alpha = <orig_alpha>
	else
		rand_alpha = Random (@ (0.6) @ (0.1) @ (0.2) @ (0.3) @ (0.4) @ (0.5) )
	endif
	se_setprops rot_angle = (<rot_angle> + <0x5e6cd985>) alpha = rand_alpha time = 0.05
	se_waitprops
	wait \{0.05
		seconds}
	repeat
endscript
0xddccbea4 = 0.5
0x52565f88 = 0.5
0x187899ed = 0.75

script 0xa7a510a8 \{0xe99089a3 = 1.0
		0xffd05882 = 1.0}
	if gotparam \{0x4d641ae8}
		obj_spawnscript ui_shakey params = {0x4d641ae8 0xe99089a3 = <0xe99089a3>}
	else
		obj_spawnscript ui_shakey params = {0xe99089a3 = <0xe99089a3>}
	endif
	obj_spawnscript ui_frazzmatazz params = {0xffd05882 = <0xffd05882>}
endscript

script 0xd5b5a21b 
	se_getprops
	orig_pos = <pos>
	begin
	0x2100cff0 = Random (@ (0.0, 0.0) @ (-2.0, -2.0) @ (-3.0, -3.0) @ (-1.0, -1.0) @ (2.5, 2.5) @ (1.0, 1.0) @ (2.0, 1.0) )
	0x2100cff0 = (<orig_pos> + <0x2100cff0>)
	if NOT gotparam \{0xc2c7c0e4}
		glow_alpha = Random (@ 0.6 @ 0.5 @ 0.4 @ 0.3 )
	else
		glow_alpha = Random (@ 0.5 @ 0.4 @ 0.3 )
	endif
	grow_scale = Random (@*7 (1.0, 1.0) @ (1.01, 1.01) @ (1.02, 1.02) @ (1.03, 1.03) )
	pulse_time = Random (@ 0.05 @ 0.08 @ 0.1 )
	0x1c307b19 = Random (@ 0.05 @ 0.08 @ 0.1 )
	se_setprops pos = <0x2100cff0> alpha = <glow_alpha> scale = <grow_scale> time = <pulse_time>
	wait <0x1c307b19> seconds
	repeat
endscript
0xb05be3e9 = 0.1
0x011662b8 = 0.2

script 0xdc864d3a \{0x19aef998 = $0xb05be3e9
		fade_in_time = $0x011662b8}
	se_getprops \{alpha
		scale
		pos}
	if gotparam \{0x82fd4d18}
		orig_pos = <pos>
		0x2100cff0 = Random (@ (-2.0, -2.0) @ (-3.0, -3.0) @ (-1.0, -1.0) @ (2.5, 2.5) @ (1.0, 1.0) @ (2.0, 1.0) )
		0x2100cff0 = (<0x2100cff0> * <0x82fd4d18>)
		se_setprops pos = (<0x2100cff0> + <orig_pos>)
	endif
	orig_alpha = <alpha>
	orig_scale = <scale>
	se_setprops \{alpha = 0.0
		scale = (0.8, 0.05)}
	wait \{0.35000002
		seconds}
	if (<0x19aef998> = <fade_in_time>)
		se_setprops scale = (1.0, 1.0) alpha = <orig_alpha> time = <0x19aef998>
	else
		if (<0x19aef998> < <fade_in_time>)
			0x46eda6fc = (<0x19aef998> / <fade_in_time>)
			0x0e5cc09f = (<0x46eda6fc> * <orig_alpha>)
			0x1ef50fc2 = (<orig_alpha> - <0x0e5cc09f>)
			se_setprops alpha = <0x0e5cc09f> scale = <orig_scale> time = <0x19aef998>
			se_waitprops
			se_setprops alpha = <0x1ef50fc2> time = (<fade_in_time> - <0x19aef998>)
		else
			0x46eda6fc = (<fade_in_time> / <0x19aef998>)
			0x32fadc71 = (<0x46eda6fc> * <orig_scale>)
			0x2253132c = (<orig_scale> - <0x32fadc71>)
			se_setprops alpha = <orig_alpha> scale = <0x32fadc71> time = <fade_in_time>
			se_waitprops
			se_setprops scale = <0x2253132c> time = (<0x19aef998> - <fade_in_time>)
		endif
	endif
	se_waitprops
	if gotparam \{0x82fd4d18}
		se_setprops pos = <orig_pos>
	endif
	if gotparam \{0x4f5d5a3e}
		obj_spawnscript 0xd5b5a21b params = <0x4f5d5a3e>
	endif
endscript
