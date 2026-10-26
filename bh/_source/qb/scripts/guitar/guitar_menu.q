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
	Orange = [
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
	if GotParam \{color}
		if StructureContains Structure = ($g_menu_colors) <color>
			if NOT ($menu_focus_color = (($g_menu_colors).<color>))
				change menu_focus_color = (($g_menu_colors).<color>)
			endif
			return
		else

		endif
	endif
	if GotParam \{rgba}
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
	if GotParam \{color}
		if StructureContains Structure = ($g_menu_colors) <color>
			if NOT ($menu_unfocus_color = (($g_menu_colors).<color>))
				change menu_unfocus_color = (($g_menu_colors).<color>)
			endif
			return
		else

		endif
	endif
	if GotParam \{rgba}
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
	if GotParam \{id}
		if ScreenElementExists id = <id>
			<id> :GetSingleTag old_font
			if NOT GotParam \{old_font}
				<id> :SE_GetProps
				<id> :SetTags old_font = <font>
			endif
			<id> :SE_SetProps rgba = ($menu_focus_color)
		endif
	else
		GetSingleTag \{old_font}
		if NOT GotParam \{old_font}
			SE_GetProps
			SetTags old_font = <font>
		endif
		SetProps rgba = ($menu_focus_color)
	endif
endscript

script retail_menu_unfocus 
	if GotParam \{id}
		if ScreenElementExists id = <id>
			<id> :GetSingleTag old_font
			if NOT GotParam \{old_font}
				<id> :SE_GetProps
				<id> :SetTags old_font = <font>
				<id> :GetSingleTag old_font
			endif
			<id> :SE_SetProps rgba = ($menu_unfocus_color) font = <old_font> material = null
		endif
	else
		GetSingleTag \{old_font}
		if NOT GotParam \{old_font}
			SE_GetProps
			SetTags old_font = <font>
			GetSingleTag \{old_font}
		endif
		SetProps rgba = ($menu_unfocus_color) font = <old_font> material = null
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
	if ScreenElementExists id = <scrollid>

		return
	endif
	if ScreenElementExists id = <vmenuid>

		return
	endif
	CreateScreenElement {
		type = VScrollingMenu
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
	if GotParam \{name}
		CreateScreenElement {
			type = TextElement
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
	CreateScreenElement {
		type = VMenu
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
	if GotParam \{no_wrap}
		SetScreenElementProps id = <vmenuid> allow_wrap = false
	endif
	if GotParam \{text_left}
		SetScreenElementProps id = <vmenuid> internal_just = [left top]
	endif
	if GotParam \{text_right}
		SetScreenElementProps id = <vmenuid> internal_just = [right top]
	endif
	if GotParam \{use_all_controllers}
		RemoveParameter \{exclusive_device}
		get_all_exclusive_devices
	endif
	if NOT GotParam \{exclusive_device}
		exclusive_device = ($primary_controller)
	endif
	if NOT (<exclusive_device> = none)
		SetScreenElementProps {
			id = <scrollid>
			exclusive_device = <exclusive_device>
		}
		SetScreenElementProps {
			id = <vmenuid>
			exclusive_device = <exclusive_device>
		}
	endif
	if GotParam \{tierlist}
		tier = 0
		begin
		<tier> = (<tier> + 1)
		setlist_prefix = (<tierlist>.prefix)
		FormatText checksumname = tiername '%ptier%i' p = <setlist_prefix> i = (<tier>)
		FormatText checksumname = tier_checksum 'tier%s' s = (<tier>)
		<unlocked> = 1
		if ((<unlocked> = 1) || ($is_network_game))
			GetArraySize (<tierlist>.<tier_checksum>.songs)
			song_count = 0
			if (<array_size> > 0)
				begin
				format_globaltag_song_checksum part = (<tierlist>.part) song = (<tierlist>.<tier_checksum>.songs [<song_count>])
				for_bonus = 0
				if ($current_tab = tab_bonus)
					<for_bonus> = 1
				endif
				if IsSongAvailable song_checksum = <song_checksum> song = (<tierlist>.<tier_checksum>.songs [<song_count>]) for_bonus = <for_bonus>
					get_song_title song = (<tierlist>.<tier_checksum>.songs [<song_count>])
					CreateScreenElement {
						type = TextElement
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
	if GotParam \{menu_id}
		if ScreenElementExists id = <menu_id>
			DestroyScreenElement id = <menu_id>
		endif
		destroy_generic_backdrop
	endif
endscript

script add_new_menu_item \{parent = current_menu
		focus_script = retail_menu_focus
		unfocus_script = retail_menu_unfocus}
	if GlobalExists \{name = massive_build}
		if NOT ($massive_build = 0)
			if GotParam \{massive_secret_item}
				return
			endif
		endif
	endif
	if NOT ScreenElementExists id = <parent>

	endif
	CreateScreenElement {
		type = TextElement
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

script guitar_menu_highlighter \{zPri = 50}
	if GotParam \{text_id}
		GetScreenElementDims id = <text_id>
		hilite_dims = (<width> * (1.0, 0.0) + <Height> * (0.0, 0.7) + (20.0, -1.0))
		bookend_dims = (<Height> * (0.5, 0.5))
		hilite_pos = ((<hlInfoList> [<hlIndex>]).posH + (-2.0, 2.0))
		SetScreenElementProps {
			id = <wthlID>
			pos = <hilite_pos>
			dims = <hilite_dims>
			z_priority = <zPri>
		}
		SetScreenElementProps {
			id = <be1ID>
			pos = (<hilite_pos> - <bookend_dims>.(1.0, 0.0) * (0.6, 0.0) + <Height> * (0.0, 0.1))
			dims = <bookend_dims>
			z_priority = <zPri>
		}
		SetScreenElementProps {
			id = <be2ID>
			pos = (<hilite_pos> + (<hilite_dims>.(1.0, 0.0) * (1.0, 0.0)) + <Height> * (0.0, 0.1) - (<bookend_dims>.(1.0, 0.0) * (0.1, 0.0)))
			dims = <bookend_dims>
			z_priority = <zPri>
			flip_h
		}
	else
		SetScreenElementProps {
			id = <be1ID>
			pos = ((<hlInfoList> [<hlIndex>]).posL)
			dims = ((<hlInfoList> [<hlIndex>]).beDims)
			z_priority = <zPri>
		}
		SetScreenElementProps {
			id = <be2ID>
			pos = ((<hlInfoList> [<hlIndex>]).posR)
			dims = ((<hlInfoList> [<hlIndex>]).beDims)
			z_priority = <zPri>
		}
		SetScreenElementProps {
			id = <wthlID>
			pos = ((<hlInfoList> [<hlIndex>]).posH)
			dims = ((<hlInfoList> [<hlIndex>]).hdims)
			z_priority = <zPri>
		}
	endif
endscript

script glow_menu_element \{time = 1}
	if NOT ScreenElementExists id = <id>
		return
	endif
	Wait RandomInteger (0.0, 2.0) seconds
	begin
	<id> :LegacyDoMorph alpha = 1 time = <time> motion = smooth
	<id> :LegacyDoMorph alpha = 0 time = <time> motion = smooth
	repeat
endscript

script create_play_song_menu 
	show_highway
endscript

script destroy_play_song_menu 
	hide_highway
endscript

script isSinglePlayerGame 
	GameMode_GetProperty \{prop = singleplayer}
	return <singleplayer>
endscript

script options_change_vocals_highway_view 

	ResetScoreUpdateReady
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
	if IsObjectScript
		Obj_GetID
		if (<vocals_highway_view> = static)
			SoundEvent \{event = Box_UnCheck_SFX}
			<ObjID> :SE_SetProps check_alpha = 0
			<ObjID> :SE_SetProps cross_alpha = 1
		else
			SoundEvent \{event = Box_Check_SFX}
			<ObjID> :SE_SetProps check_alpha = 1
			<ObjID> :SE_SetProps cross_alpha = 0
		endif
	endif
	if NOT GotParam \{no_restart}
		set_loading_screen \{full}
		GH3_SFX_fail_song_stop_sounds
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

	GetPlayerInfo player = <player> vocals_sp_clap
	if (<vocals_sp_clap> = 1)
		<vocals_sp_clap> = 0
	else
		<vocals_sp_clap> = 1
	endif
	vocals_set_star_power_clap player = <player> clap = <vocals_sp_clap> controller = <device_num>
	if IsObjectScript
		Obj_GetID
		if GotParam \{checkbox_child}
			child = <checkbox_child>
		else
			child = check
		endif
		if (<vocals_sp_clap> = 0)
			SoundEvent \{event = Box_UnCheck_SFX}
			<ObjID> :SE_SetProps check_alpha = 0
			<ObjID> :SE_SetProps cross_alpha = 1
		else
			SoundEvent \{event = Box_Check_SFX}
			<ObjID> :SE_SetProps check_alpha = 1
			<ObjID> :SE_SetProps cross_alpha = 0
		endif
	endif
endscript

script options_change_tilt_star_power 
	GetPlayerInfo <player> use_tilt_for_starpower
	GetPlayerInfo <player> checksum
	get_savegame_from_player_status player_status = <checksum>
	if (<use_tilt_for_starpower> = 1)
		SoundEvent \{event = Box_UnCheck_SFX}
		SetPlayerInfo <player> use_tilt_for_starpower = 0
		SetGlobalTags savegame = <savegame> user_options params = {use_tilt_for_starpower_save = 0}
		<new_texture> = Options_Controller_X
	else
		SoundEvent \{event = Box_Check_SFX}
		SetPlayerInfo <player> use_tilt_for_starpower = 1
		SetGlobalTags savegame = <savegame> user_options params = {use_tilt_for_starpower_save = 1}
		<new_texture> = Options_Controller_Check
	endif
	if IsObjectScript
		Obj_GetID
		if ResolveScreenElementId id = {<ObjID> child = tilt_check}
			<resolved_id> :SetProps texture = <new_texture>
		else
			if (<use_tilt_for_starpower> = 1)
				<use_tilt_for_starpower> = 0
				SoundEvent \{event = Box_UnCheck_SFX}
				if GotParam \{popup}
					<ObjID> :SE_SetProps check_alpha = 0
					<ObjID> :SE_SetProps cross_alpha = 1
				else
					<ObjID> :SE_SetProps check_alpha = 0
					<ObjID> :SE_SetProps cross_alpha = 1
				endif
			else
				<use_tilt_for_starpower> = 1
				SoundEvent \{event = Box_Check_SFX}
				if GotParam \{popup}
					<ObjID> :SE_SetProps check_alpha = 1
					<ObjID> :SE_SetProps cross_alpha = 0
				else
					<ObjID> :SE_SetProps check_alpha = 1
					<ObjID> :SE_SetProps cross_alpha = 0
				endif
			endif
		endif
	endif
endscript

script options_change_touch_strip_option 
	GetPlayerInfo <player> enable_touch_strip
	GetPlayerInfo <player> checksum
	get_savegame_from_player_status player_status = <checksum>
	if (<enable_touch_strip> = 1)
		SoundEvent \{event = Box_UnCheck_SFX}
		SetPlayerInfo <player> enable_touch_strip = 0
		SetGlobalTags savegame = <savegame> user_options params = {enable_touch_strip_save = 0}
		<new_texture> = Options_Controller_X
	else
		SoundEvent \{event = Box_Check_SFX}
		SetPlayerInfo <player> enable_touch_strip = 1
		SetGlobalTags savegame = <savegame> user_options params = {enable_touch_strip_save = 1}
		<new_texture> = Options_Controller_Check
	endif
	if IsObjectScript
		Obj_GetID
		if ResolveScreenElementId id = {<ObjID> child = touch_check}
			<resolved_id> :SetProps texture = <new_texture>
		else
			if (<enable_touch_strip> = 1)
				<enable_touch_strip> = 0
				SoundEvent \{event = Box_UnCheck_SFX}
				if GotParam \{popup}
					<ObjID> :SE_SetProps check_alpha = 0
					<ObjID> :SE_SetProps cross_alpha = 1
				else
					<ObjID> :SE_SetProps check_alpha = 0
					<ObjID> :SE_SetProps cross_alpha = 1
				endif
			else
				<enable_touch_strip> = 1
				SoundEvent \{event = Box_Check_SFX}
				if GotParam \{popup}
					<ObjID> :SE_SetProps check_alpha = 1
					<ObjID> :SE_SetProps cross_alpha = 0
				else
					<ObjID> :SE_SetProps check_alpha = 1
					<ObjID> :SE_SetProps cross_alpha = 0
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
	KillSpawnedScript \{name = animate_bunny_flame}
	if ScreenElementExists \{id = warning_message_container}
		DestroyScreenElement \{id = warning_message_container}
	endif
	if ScreenElementExists \{id = leaving_lobby_dialog_menu}
		DestroyScreenElement \{id = leaving_lobby_dialog_menu}
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
	if ScreenElementExists \{id = menu_backdrop_container}
		DestroyScreenElement \{id = menu_backdrop_container}
	endif
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = menu_backdrop_container
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	CreateScreenElement {
		type = SpriteElement
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
	if ScreenElementExists \{id = menu_backdrop_container}
		DestroyScreenElement \{id = menu_backdrop_container}
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
	CreateScreenElement {
		type = ContainerElement
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
		CreateScreenElement {
			type = WindowElement
			parent = <container_id>
			id = pause_menu_scrolling_bg_01
			pos = (642.0, 360.0)
			dims = ((508.0, 0.0) * <x_scale> + (0.0, 340.0) * <y_scale>)
			just = [center center]
			z_priority = (<z> - 1)
		}
		RunScriptOnScreenElement TileSpriteLoop id = <id> params = {move_x = -2 move_y = -2}
	else
		CreateScreenElement {
			type = SpriteElement
			id = frame_background
			parent = <container_id>
			rgba = [0 0 0 255]
			pos = (640.0, 360.0)
			just = [center center]
			dims = ((520.0, 0.0) * <x_scale> + (0.0, 340.0) * <y_scale>)
			z_priority = (<z> - 1)
		}
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		texture = menu_pause_frame_2
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [bottom right]
		z_priority = (<z> + 2)
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		texture = menu_pause_frame_2
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [top right]
		z_priority = (<z> + 2)
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
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
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		texture = menu_pause_frame_2
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [bottom left]
		z_priority = (<z> + 2)
		flip_h
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [bottom right]
		z_priority = (<z> + 2)
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [top right]
		z_priority = (<z> + 2)
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
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
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [bottom left]
		z_priority = (<z> + 2)
		flip_h
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [bottom right]
		z_priority = (<z> + 2)
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		texture = menu_pause_frame_1
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [top right]
		z_priority = (<z> + 2)
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
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
	CreateScreenElement {
		type = SpriteElement
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
	GetScreenElementProps id = <id>
	return {scale = <scale>}
endscript

script fit_text_convert_legacy_params 
	if (<keep_ar> = 1)
		<preserve_aspect_ratio> = true
	else
		<preserve_aspect_ratio> = false
	endif
	if (<only_if_larger_x> = 1)
		RemoveParameter \{only_if_larger_x}
		<only_if_larger_x> = true
	else
		RemoveParameter \{only_if_larger_x}
		<only_if_larger_x> = false
	endif
	if GotParam \{start_x_scale}
		<factor_start_scale> = true
	elseif GotParam \{start_y_scale}
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
	if NOT GotParam \{id}

	endif
	fit_text_convert_legacy_params <...>
	<id> :SE_FitToDims {
		dims = <dims>
		factor_start_scale = <factor_start_scale>
		preserve_aspect_ratio = <preserve_aspect_ratio>
		only_if_larger_x = <only_if_larger_x>
		only_if_larger_y = false
	}
	if GotParam \{pos}
		SetScreenElementProps id = <id> pos = <pos>
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

script user_control_helper_check_disconnect 
	<up_to_date> = 0
	begin
	GetActiveControllers
	<is_active_controller> = (<active_controllers> [(<controller>)])
	if ((<up_to_date> = 0) && (<is_active_controller> = 1))
		user_control_helper_update controller = <controller>
		<up_to_date> = <updated>
	endif
	if NOT (<is_active_controller> = 1)
		user_control_helper_check_connect controller = <controller>
		SetScreenElementProps \{id = user_control_container
			alpha = 1}
	endif
	Wait \{5
		gameframes}
	repeat
endscript

script user_control_helper_check_connect 
	if (<controller> < 0)
		return
	endif
	begin
	GetActiveControllers
	<is_active_controller> = (<active_controllers> [(<controller>)])
	if (<is_active_controller> = 1)
		user_control_helper_update controller = <controller>
		return
	endif
	Wait \{5
		gameframes}
	repeat
endscript

script user_control_helper_update \{controller = $primary_controller}
	<updated> = 0
	if NOT ScreenElementExists \{id = user_control_container}
		return updated = <updated>
	endif
	if GetScreenElementChildren \{id = user_control_container}
		GetArraySize <children>
		if (<array_size> > 0)
			<index> = 0
			begin
			<child> = (<children> [<index>])
			<child> :GetTags
			if (GotParam button)
				user_control_helper_get_buttonchar button = <button> controller = <controller>
				<child> :SE_SetProps {
					helper_button_text = <button_char>
				}
				<child> :Desc_ResolveAlias name = alias_helper_button
				<resolved_id> :SE_SetProps {
					text = <buttonchar>
				}
			endif
			<index> = (<index> + 1)
			repeat <array_size>
			<updated> = 1
		endif
		SpawnScript \{user_control_helper_button_resize}
	endif
	return updated = <updated>
endscript

script hide_user_control_helpers 
	set_user_control_helper_alpha \{alpha = 0.0}
endscript

script restore_user_control_helpers 
	set_user_control_helper_alpha \{alpha = 1.1}
endscript

script set_user_control_helper_alpha 

	if ScreenElementExists \{id = user_control_container}
		user_control_container :SE_SetProps alpha = <alpha>
	endif
	if ScreenElementExists \{id = custom_setlist_continue_helper}
		custom_setlist_continue_helper :SE_SetProps alpha = <alpha>
	endif
	if ScreenElementExists \{id = custom_setlist_second_continue_helper}
		custom_setlist_second_continue_helper :SE_SetProps alpha = <alpha>
	endif
	if ScreenElementExists \{id = custom_setlist_continue_pill}
		custom_setlist_continue_pill :SE_SetProps alpha = <alpha>
	endif
	if ScreenElementExists \{id = calibrate_highway_user_pills_container}
		calibrate_highway_user_pills_container :SE_SetProps alpha = <alpha>
	endif
endscript

script clean_up_user_control_helpers 
	if ScriptIsRunning \{user_control_helper_check_disconnect}
		KillSpawnedScript \{name = user_control_helper_check_disconnect}
	endif
	if ScriptIsRunning \{user_control_helper_check_connect}
		KillSpawnedScript \{name = user_control_helper_check_connect}
	endif
	if ScreenElementExists \{id = user_control_container}
		DestroyScreenElement \{id = user_control_container}
	endif
	if ScreenElementExists \{id = custom_setlist_continue_helper}
		DestroyScreenElement \{id = custom_setlist_continue_helper}
	endif
	if ScreenElementExists \{id = custom_setlist_second_continue_helper}
		DestroyScreenElement \{id = custom_setlist_second_continue_helper}
	endif
	if ScreenElementExists \{id = custom_setlist_continue_pill}
		DestroyScreenElement \{id = custom_setlist_continue_pill}
	endif
	if ScreenElementExists \{id = calibrate_highway_user_pills_container}
		DestroyScreenElement \{id = calibrate_highway_user_pills_container}
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
	if GotParam \{controller}
		if (<controller> < 0)
			RemoveParameter \{controller}
		endif
	endif
	if NOT GotParam \{controller}
		controller = $primary_controller
		if NOT (<controller> = $last_start_pressed_device)
			controller = $last_start_pressed_device
		endif
	endif
	if NOT (<controller> < 0)
		if NOT ((IsGuitarController controller = <controller>) || (IsDrumController controller = <controller>))
			GetActiveControllers
			GetArraySize <active_controllers>
			if (<controller> < <array_size>)
				if (<active_controllers> [<controller>] = 1)
					standard = 1
				endif
			endif
		elseif IsDrumController controller = <controller>
			drum = 1
			standard = 1
		endif
	endif
	if GotParam \{all_buttons}
		RemoveParameter \{all_buttons}
	endif
	if GotParam \{button}
		switch (<button>)
			case green
			buttonchar = qs("\L\b4")
			if GotParam \{standard}
				buttonchar = qs("\L\b3")
			endif
			if GotParam \{all_buttons}
				buttonchar = qs("\L\b3\b4")
			endif
			case red
			buttonchar = qs(0x893d135f)
			if GotParam \{standard}
				buttonchar = qs("\L\m1")
			endif
			if GotParam \{all_buttons}
				buttonchar = qs("\L\b2\b5")
			endif
			case Yellow
			buttonchar = qs("\L\b6")
			if GotParam \{standard}
				buttonchar = qs(0x64f07d44)
			endif
			if GotParam \{all_buttons}
				buttonchar = qs("\L\b0\b6")
			endif
			case Blue
			buttonchar = qs("\L\b7")
			if GotParam \{standard}
				buttonchar = qs("\L\m3")
			endif
			if GotParam \{all_buttons}
				buttonchar = qs("\L\b1\b7")
			endif
			case Orange
			buttonchar = qs("\L\b8")
			if GotParam \{standard}
				buttonchar = qs("\L\bl")
			endif
			if GotParam \{drum}
				buttonchar = qs("\L\bo")
			endif
			if GotParam \{all_buttons}
				buttonchar = qs("\L\b8\bi\bq")
			endif
			case strumbar
			buttonchar = qs(0x7cc7d8cc)
			if GotParam \{standard}
				buttonchar = qs("\L\md")
			endif
			case back
			buttonchar = qs("\L\b9")
			if GotParam \{standard}
				buttonchar = qs(0x3dbff9db)
			endif
			if GotParam \{all_buttons}
				buttonchar = qs("\L\bo")
			endif
			case start
			buttonchar = qs("\L\ba")
			if GotParam \{drum}
				buttonchar = qs(0x7deb4c05)
			elseif GotParam \{standard}
				buttonchar = qs("\L\mb")
			endif
			if GotParam \{all_buttons}
				buttonchar = qs("\L\bp")
			endif
			case LB
			buttonchar = qs("\L\bi")
			case RB
			buttonchar = qs("\L\bj")
			case LT
			buttonchar = qs("\L\bk")
			case RT
			buttonchar = qs("\L\bl")
			case LBRB
			buttonchar = qs("\L\b7")
			if GotParam \{standard}
				buttonchar = qs("\L\bi\bj")
			endif
			case pad_left
			buttonchar = qs("\L\be")
			case DRUM_GREEN
			buttonchar = qs("\L\br")
		endswitch
	else
		buttonchar = qs("\L")
	endif
	return {buttonchar = <buttonchar> controller_used = <controller>}
endscript

script should_use_all_buttons 
	get_all_exclusive_devices
	if NOT GotParam \{exclusive_device}
		return \{false}
	endif
	<standard_buttons> = false
	<guitar_buttons> = false
	GetArraySize \{exclusive_device}
	if (<array_size> = 0)
		return \{false}
	endif
	<i> = 0
	begin
	if IsGuitarController controller = (<exclusive_device> [<i>])
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

	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	Wait <delay_time> seconds ignoreslomo
	begin
	if ScreenElementExists id = <id>
		<id> :SE_SetProps {
			alpha = 0.5
			time = <time>
		}
		Wait <time> seconds ignoreslomo
		if ScreenElementExists id = <id>
			<id> :SE_SetProps {
				alpha = 1
				time = <time>
			}
			Wait <time> seconds ignoreslomo
		else
			return
		endif
	else
		return
	endif
	repeat
endscript

script add_user_control_helper \{z = 10}
	spawn_disconnect_check = false
	if NOT ScreenElementExists \{id = user_control_container}
		<spawn_disconnect_check> = true
		CreateScreenElement {
			id = user_control_container
			parent = root_window
			type = MenuElement
			dims = (1024.0, 36.0)
			pos = (0.0, -36.0)
			pos_anchor = [center bottom]
			just = [center bottom]
			internal_just = [center center]
			isVertical = false
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
	ExtendCRC <button> '_helper_pill_ID' out = helper_pill_ID
	if (<button> != none)
		user_control_helper_get_buttonchar <...> button = <button>
		AddParam structure_name = params_struct name = helper_button_text value = <buttonchar>
	endif
	parent = user_control_container
	if GotParam \{override_parent}
		parent = <override_parent>
	endif
	if (<spawn_disconnect_check> = true)
		if NOT ((ScriptIsRunning user_control_helper_check_disconnect) || (ScriptIsRunning user_control_helper_check_connect))
			if GotParam \{controller}
				user_control_container :Obj_SpawnScriptNow user_control_helper_check_disconnect params = {controller = (<controller>)}
			else
				user_control_container :Obj_SpawnScriptNow \{user_control_helper_check_disconnect
					params = {
						controller = $primary_controller
					}}
			endif
		endif
	endif
	if ScreenElementExists id = <helper_pill_ID>
		DestroyScreenElement id = <helper_pill_ID>
	endif
	if GotParam \{leader}
		CreateScreenElement {
			parent = <parent>
			id = <helper_pill_ID>
			type = DescInterface
			desc = 'helper_pill_leader'
			auto_dims = false
			dims = (0.0, 36.0)
			pos = <pos>
			<params_struct>
		}
	else
		CreateScreenElement {
			parent = <parent>
			id = <helper_pill_ID>
			type = DescInterface
			desc = 'helper_pill'
			auto_dims = false
			dims = (0.0, 36.0)
			pos = <pos>
			<params_struct>
		}
	endif
	if (<button> != none)
		if GotParam \{all_buttons}
			if <id> :Desc_ResolveAlias name = alias_helper_button
				<resolved_id> :SE_SetProps {
					metaRemapEnable = false
					text = <buttonchar>
				}
			endif
		endif
	endif
	<id> :SE_GetProps
	<id> :SE_SetProps {
		helper_pill_body_dims = (((0.65000004, 0.0) * <helper_pill_menu_dims> [0]) + ((0.0, 1.0) * <helper_pill_body_dims> [1]))
		dims = (((0.65000004, 0.0) * <helper_pill_menu_dims> [0]) + (64.0, 32.0))
	}
	user_control_container :SE_GetProps
	user_control_container :SE_SetProps {
		helper_pill_body_dims = (((1.0, 0.0) * <helper_pill_menu_dims> [0]) + (0.0, 50.0))
	}
	if (<helper_pill_menu_dims> [0] > 950)
		user_control_container :SE_SetProps scale = (950.0 / <helper_pill_menu_dims> [0])
	endif
	return helper_pill_ID = <id>
endscript

script user_control_helper_button_resize 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	WaitOneGameFrame
	if NOT ScreenElementExists \{id = user_control_container}
		return
	endif
	if GetScreenElementChildren \{id = user_control_container}
		GetArraySize <children>
		if (<array_size> > 0)
			<index> = 0
			begin
			<child> = (<children> [<index>])
			<child> :SE_GetProps
			<child> :SE_SetProps {
				helper_pill_body_dims = (((0.65000004, 0.0) * <helper_pill_menu_dims> [0]) + ((0.0, 1.0) * <helper_pill_body_dims> [1]))
				dims = (((0.65000004, 0.0) * <helper_pill_menu_dims> [0]) + (64.0, 32.0))
			}
			<index> = (<index> + 1)
			repeat <array_size>
		endif
	endif
endscript

script user_control_helper_change_text 

	ExtendCRC <button> '_helper_pill_ID' out = helper_pill_ID
	if ScreenElementExists id = <helper_pill_ID>
		<helper_pill_ID> :SE_SetProps {
			helper_description_text = <text>
		}
		SpawnScript \{user_control_helper_button_resize}
	else

	endif
endscript

script user_control_destroy_helper 

	ExtendCRC <button> '_helper_pill_ID' out = helper_pill_ID
	if ScreenElementExists id = <helper_pill_ID>
		DestroyScreenElement id = <helper_pill_ID>
	endif
endscript

script user_control_helper_exists 

	ExtendCRC <button> '_helper_pill_ID' out = helper_pill_ID
	if ScreenElementExists id = <helper_pill_ID>
		return \{true}
	else
		return \{false}
	endif
endscript

script get_diff_completion_text 
	diff_completion_percentage = [0 0 0 0 0]
	diff_completion_score = [0 0 0 0 0]
	diff_completion_text = [qs("\L") qs("\L") qs("\L") qs("\L") qs("\L")]
	get_progression_globals game_mode = ($game_mode) ($current_progression_flag)
	percentage_complete = 0
	difficulty_index = 0
	GetArraySize ($difficulty_list)
	diff_size = <array_size>
	begin
	setlist_prefix = ($<tier_global>.prefix)
	songs_completed = 0
	songs_score = 0
	num_songs = 0
	tier_num = 1
	begin
	FormatText checksumname = tier 'tier%d' d = <tier_num>
	GetArraySize ($<tier_global>.<tier>.songs)
	songlist_size = <array_size>
	song_count = 0
	begin
	format_globaltag_song_checksum part = ($<tier_global>.part) song = ($<tier_global>.<tier>.songs [<song_count>]) difficulty_index = <difficulty_index>
	GetGlobalTags <song_checksum> params = {stars score}
	if NOT (<stars> = 0)
		<songs_completed> = (<songs_completed> + 1)
		<songs_score> = (<songs_score> + <score>)
	endif
	<num_songs> = (<num_songs> + 1)
	<song_count> = (<song_count> + 1)
	repeat <songlist_size>
	tier_num = (<tier_num> + 1)
	repeat ($<tier_global>.num_tiers)
	FormatText TextName = diff_completion_string qs("%a of %b songs completed") a = <songs_completed> b = <num_songs>
	SetArrayElement ArrayName = diff_completion_text index = (<difficulty_index>) newvalue = (<diff_completion_string>)
	<percentage_complete> = (<percentage_complete> + (100 * <songs_completed>) / <num_songs>)
	SetArrayElement ArrayName = diff_completion_percentage index = (<difficulty_index>) newvalue = ((100 * <songs_completed>) / <num_songs>)
	SetArrayElement ArrayName = diff_completion_score index = (<difficulty_index>) newvalue = <songs_score>
	<difficulty_index> = (<difficulty_index> + 1)
	repeat <diff_size>
	if GotParam \{for_get_diff_completion_percentage}
		return diff_completion_percentage = <diff_completion_percentage> percentage_complete = <percentage_complete> diff_completion_score = <diff_completion_score>
	else
		return diff_completion_text = <diff_completion_text>
	endif
endscript

script dim_screen 
	if ScreenElementExists \{id = dim_screen}
		DestroyScreenElement \{id = dim_screen}
	endif
	if NOT GotParam \{undim}
		CreateScreenElement \{type = SpriteElement
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

script displaySprite \{just = [
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
		blendMode = {
		}
		internal_just = {
		}
		scale = {
		}
		alpha = 1}
	if GotParam \{rot_angle}
		rot_struct = {rot_angle = <rot_angle>}
	else
		rot_struct = {}
	endif
	CreateScreenElement {
		type = SpriteElement
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
		blend = <blendMode>
		alpha = <alpha>
	}
	if GotParam \{flip_v}
		<id> :SE_SetProps flip_v
	endif
	if GotParam \{flip_h}
		<id> :SE_SetProps flip_h
	endif
	return id = <id>
endscript

script displayText \{id = {
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
	CreateScreenElement {
		type = TextElement
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
	if GotParam \{noshadow}
		<id> :SE_SetProps noshadow
	else
		<id> :SE_SetProps shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]
	endif
	return id = <id>
endscript
g_num_scrolling_texts = 0

script scroll_ticker_text {
		ticker_text = qs("I NEED TICKER TEXT!")
		ticker_space = qs("\L ")
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
	FormatText \{checksumname = ticker_text_id_1
		'scrolling_ticker_text_%i_1'
		i = $g_num_scrolling_texts}
	CreateScreenElement {
		type = TextElement
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
	GetScreenElementDims id = <ticker_text_id_1>
	if (<width> > 0)
		multi = (1280 / <width>)
	else

	endif
	ticker_text_with_space = (<ticker_text> + <ticker_space>)
	long_ticker_text = <ticker_text_with_space>
	StringLength string = <ticker_text_with_space>
	<ticker_text_with_space_length> = <str_len>
	begin
	StringLength string = <long_ticker_text>
	<long_ticker_text_length> = <str_len>
	if NOT (<long_ticker_text_length> < (127 - <ticker_text_with_space_length>))
		break
	endif
	<long_ticker_text> = (<long_ticker_text> + <ticker_text_with_space>)
	<ticker_text_id_1> :SE_SetProps text = <long_band_text>
	GetScreenElementDims id = <ticker_text_id_1>
	if (<width> > 1280)
		break
	endif
	repeat <multi>
	<ticker_text_id_1> :SE_SetProps text = <long_ticker_text> pos = <ticker_pos>
	FormatText \{checksumname = ticker_text_id_2
		'scrolling_ticker_text_%i_2'
		i = $g_num_scrolling_texts}
	CreateScreenElement {
		id = <ticker_text_id_2>
		type = TextElement
		just = <ticker_just>
		parent = <ticker_parent>
		scale = ((<ticker_x_scale> * (1.0, 0.0)) + (<ticker_y_scale> * (0.0, 1.0)))
		font = <ticker_font>
		text = <long_ticker_text>
		rgba = <ticker_rgba2>
		alpha = <ticker_alpha>
		z_priority = <ticker_z_priority>
	}
	GetScreenElementDims id = <ticker_text_id_1>
	<ticker_text_id_2> :SE_SetProps pos = (((1.0, 0.0) * <width>) + <ticker_pos>)
	change g_num_scrolling_texts = ($g_num_scrolling_texts + 1)
	<first> = 1
	begin
	if (<first>)
		<ticker_text_id_1> :SE_SetProps pos = (((-1.0, 0.0) * <width>) + <ticker_pos>) time = <time>
		<ticker_text_id_2> :SE_SetProps pos = <ticker_pos> time = <time>
	else
		<ticker_text_id_2> :SE_SetProps pos = (((-1.0, 0.0) * <width>) + <ticker_pos>) time = <time>
		<ticker_text_id_1> :SE_SetProps pos = <ticker_pos> time = <time>
	endif
	Wait <time> seconds
	if (<first>)
		<ticker_text_id_1> :SE_SetProps pos = (((1.0, 0.0) * <width>) + <ticker_pos>)
		<ticker_text_id_2> :SE_SetProps pos = <ticker_pos>
		<first> = 0
	else
		<ticker_text_id_2> :SE_SetProps pos = (((1.0, 0.0) * <width>) + <ticker_pos>)
		<ticker_text_id_1> :SE_SetProps pos = <ticker_pos>
		<first> = 1
	endif
	repeat
endscript

script ui_frazz_something 
	begin
	scale = Random (@*10 (1.0, 1.0) @ (1.1, 0.3) @ (0.9, 1.0) )
	SE_SetProps scale = <scale> rgba = [255 255 255 255] time = 0.2
	SE_WaitProps
	SE_SetProps \{scale = (1.0, 1.0)
		rgba = [
			200
			220
			255
			255
		]}
	SE_WaitProps
	repeat
endscript

script ui_frazzmatazz \{glow_brightness = 1.0}
	if GetSingleTag \{frazzmatazz_running}
		return
	endif
	SetTags \{frazzmatazz_running}
	if (<glow_brightness> > 1.0)
		<glow_brightness> = 1.0
	else
		if (<glow_brightness> < 0.0)
			<glow_brightness> = 0.0
		endif
	endif
	begin
	scale = Random (@*10 (1.0, 1.0) @ (1.2, 1.2) @ (1.1, 1.1) @ (1.15, 1.15) @ (1.05, 1.05) )
	alpha = Random (@ (0.3) @ (0.4) @ (0.5) @ (0.6) @ (0.8) @ (1) )
	SE_SetProps alpha = (<alpha> * <glow_brightness>) scale = <scale> time = 1
	SE_WaitProps
	SE_SetProps \{scale = (1.0, 1.0)}
	SE_WaitProps
	Wait \{1
		gameframe}
	repeat
endscript

script ui_frazzmatazz_02 
	begin
	scale = Random (@*10 (1.0, 1.0) @ (1.05, 1.05) @ (1.1, 1.1) @ (1.05, 1.05) @ (1.03, 1.03) )
	alpha = Random (@ (0.25) @ (0.1) @ (0.2) @ (0.15) @ (0.2) @ (0.1) )
	SE_SetProps alpha = <alpha> scale = <scale> time = 1
	SE_WaitProps
	SE_SetProps \{scale = (1.0, 1.0)}
	SE_WaitProps
	Wait \{1
		gameframe}
	repeat
endscript

script ui_alphaflight 
	begin
	alpha = Random (@*10 (1) @ (0.4) @ (0.5) @ (0.6) @ (0.7) @ (0.8) @ (0.9) )
	SE_SetProps alpha = <alpha> time = 1
	SE_WaitProps
	repeat
endscript

script ui_herkyjerky 
	begin
	pos = Random (@ (0.0, 0.0) @ (-10.0, -10.0) @ (-30.0, -30.0) @ (-20.0, -20.0) @ (20.0, 20.0) @ (25.0, 25.0) @ (50.0, 50.0) @ (10.0, 10.0) )
	scale = Random (@ (1.0, 1.0) @ (1.2, 1.2) @ (1.1, 1.1) @ (1.15, 1.15) @ (1.05, 1.05) )
	alpha = Random (@*100 (1) @ (0.5) @ (0.6) @ (0.7) @ (0.8) @ (0.9) )
	SE_SetProps pos = <pos> scale = <scale> alpha = <alpha> time = 0.08
	SE_WaitProps
	SE_SetProps \{pos = (0.0, 0.0)
		scale = (1.0, 1.0)}
	r = Random (@ 1 @ 4 @ 5 @ 3 @ 3 )
	Wait <r> seconds
	repeat
endscript

script ui_shakey 
	if GetSingleTag \{shakey_running}
		return
	endif
	SetTags \{shakey_running}
	if GotParam \{as_offset}
		SE_GetProps \{pos}
		orig_pos = <pos>
	else
		orig_pos = (0.0, 0.0)
	endif
	begin
	shake_pos = Random (@ (0.0, 0.0) @ (-2.0, -2.0) @ (-3.0, -3.0) @ (-1.0, -1.0) @ (2.5, 2.5) @ (1.0, 1.0) @ (2.0, 1.0) )
	if GotParam \{scale_movement}
		shake_pos = (<shake_pos> * <scale_movement>)
	endif
	shake_pos = (<shake_pos> + <orig_pos>)
	SE_SetProps pos = <shake_pos> time = 0.08
	SE_WaitProps
	Wait \{0.08
		seconds}
	repeat
endscript

script ui_shakey_02 
	begin
	pos = Random (@ (0.0, 0.0) @ (-1.0, -1.0) @ (-3.0, -3.0) @ (-1.0, -1.0) @ (2.5, 2.5) @ (-3.0, 1.0) @ (2.0, 1.0) )
	SE_SetProps pos = <pos> time = 0.15
	SE_WaitProps
	Wait \{0.15
		seconds}
	repeat
endscript

script ui_roto 
	begin
	scale = Random (@*2 (1.0, 1.0) @ (1.05, 1.01) @ (1.03, 1.08) @ (1.03, 1.05) @ (1.09, 1.07) )
	rot_angle = Random (@ 1 @ 2 @ -1 @ -2 )
	SE_SetProps scale = <scale> rot_angle = <rot_angle> time = 0.05
	SE_WaitProps
	Wait \{0.05
		seconds}
	repeat
endscript

script ui_roto_02 
	SE_GetProps \{rot_angle
		alpha}
	orig_rot_angle = <rot_angle>
	orig_alpha = <alpha>
	begin
	rot_angle = Random (@ 0.2 @ 0.3 @ 0 @ -0.2 @ -0.3 )
	if GotParam \{change_alpha}
		rand_alpha = <orig_alpha>
	else
		rand_alpha = Random (@ (0.6) @ (0.1) @ (0.2) @ (0.3) @ (0.4) @ (0.5) )
	endif
	SE_SetProps rot_angle = (<rot_angle> + <orig_rot_angle>) alpha = rand_alpha time = 0.05
	SE_WaitProps
	Wait \{0.05
		seconds}
	repeat
endscript
menu_glow = 0.5
skulls_move = 0.5
banner_move = 0.75

script ui_flicker_glow \{scale_movement = 1.0
		glow_brightness = 1.0}
	if GotParam \{as_offset}
		obj_spawnscript ui_shakey params = {as_offset scale_movement = <scale_movement>}
	else
		obj_spawnscript ui_shakey params = {scale_movement = <scale_movement>}
	endif
	obj_spawnscript ui_frazzmatazz params = {glow_brightness = <glow_brightness>}
endscript

script ui_flicker_highlight 
	SE_GetProps
	orig_pos = <pos>
	begin
	shake_pos = Random (@ (0.0, 0.0) @ (-2.0, -2.0) @ (-3.0, -3.0) @ (-1.0, -1.0) @ (2.5, 2.5) @ (1.0, 1.0) @ (2.0, 1.0) )
	shake_pos = (<orig_pos> + <shake_pos>)
	if NOT GotParam \{glow_dimly}
		glow_alpha = Random (@ 0.6 @ 0.5 @ 0.4 @ 0.3 )
	else
		glow_alpha = Random (@ 0.5 @ 0.4 @ 0.3 )
	endif
	grow_scale = Random (@*7 (1.0, 1.0) @ (1.01, 1.01) @ (1.02, 1.02) @ (1.03, 1.03) )
	pulse_time = Random (@ 0.05 @ 0.08 @ 0.1 )
	pulse_wait_time = Random (@ 0.05 @ 0.08 @ 0.1 )
	SE_SetProps pos = <shake_pos> alpha = <glow_alpha> scale = <grow_scale> time = <pulse_time>
	Wait <pulse_wait_time> seconds
	repeat
endscript
projection_power_on_time = 0.1
projection_fade_in_time = 0.2

script ui_projection_power_on \{power_on_time = $projection_power_on_time
		fade_in_time = $projection_fade_in_time}
	SE_GetProps \{alpha
		scale
		pos}
	if GotParam \{randomize_pos}
		orig_pos = <pos>
		shake_pos = Random (@ (-2.0, -2.0) @ (-3.0, -3.0) @ (-1.0, -1.0) @ (2.5, 2.5) @ (1.0, 1.0) @ (2.0, 1.0) )
		shake_pos = (<shake_pos> * <randomize_pos>)
		SE_SetProps pos = (<shake_pos> + <orig_pos>)
	endif
	orig_alpha = <alpha>
	orig_scale = <scale>
	SE_SetProps \{alpha = 0.0
		scale = (0.8, 0.05)}
	Wait \{0.35000002
		seconds}
	if (<power_on_time> = <fade_in_time>)
		SE_SetProps scale = (1.0, 1.0) alpha = <orig_alpha> time = <power_on_time>
	else
		if (<power_on_time> < <fade_in_time>)
			time_ratio = (<power_on_time> / <fade_in_time>)
			first_alpha = (<time_ratio> * <orig_alpha>)
			second_alpha = (<orig_alpha> - <first_alpha>)
			SE_SetProps alpha = <first_alpha> scale = <orig_scale> time = <power_on_time>
			SE_WaitProps
			SE_SetProps alpha = <second_alpha> time = (<fade_in_time> - <power_on_time>)
		else
			time_ratio = (<fade_in_time> / <power_on_time>)
			first_scale = (<time_ratio> * <orig_scale>)
			second_scale = (<orig_scale> - <first_scale>)
			SE_SetProps alpha = <orig_alpha> scale = <first_scale> time = <fade_in_time>
			SE_WaitProps
			SE_SetProps scale = <second_scale> time = (<power_on_time> - <fade_in_time>)
		endif
	endif
	SE_WaitProps
	if GotParam \{randomize_pos}
		SE_SetProps pos = <orig_pos>
	endif
	if GotParam \{spawn_flicker_highlight}
		obj_spawnscript ui_flicker_highlight params = <spawn_flicker_highlight>
	endif
endscript

script ui_rotate_scale 
	begin
	SE_SetProps \{alpha = 0
		scale = 0.1
		rot_angle = 0
		time = 0.5}
	SE_WaitProps
	SE_SetProps \{alpha = 1
		scale = 1.01
		rot_angle = 180
		time = 0.5}
	SE_WaitProps
	SE_SetProps \{alpha = 0
		scale = 0.1
		rot_angle = 360
		time = 0.5}
	SE_WaitProps
	repeat
endscript

script ui_rotate_scale_02 
	begin
	SE_SetProps \{alpha = 0
		scale = 2.0
		rot_angle = 0
		time = 0.8}
	SE_WaitProps
	SE_SetProps \{alpha = 1
		scale = 3.0
		rot_angle = 180
		time = 0.8}
	SE_WaitProps
	SE_SetProps \{alpha = 0
		scale = 2.0
		rot_angle = 360
		time = 0.8}
	SE_WaitProps
	repeat
endscript

script ui_rotate_scale_03 
	begin
	SE_SetProps \{alpha = 0.5
		scale = 1.02
		rot_angle = 180
		time = 1.2}
	SE_WaitProps
	SE_SetProps \{alpha = 1
		scale = 1
		rot_angle = 360
		time = 1.2}
	SE_WaitProps
	SE_SetProps \{alpha = 0.5
		scale = 1
		rot_angle = 540
		time = 1.2}
	SE_WaitProps
	SE_SetProps \{alpha = 1
		scale = 1
		rot_angle = 720
		time = 1.2}
	SE_WaitProps
	SE_SetProps \{alpha = 0.5
		scale = 1
		rot_angle = 900
		time = 1.2}
	SE_WaitProps
	repeat
endscript

script ui_rotate_scale_04 
	begin
	SE_SetProps \{alpha = 0.1
		scale = 1.2
		rot_angle = 180
		time = 1.5}
	SE_WaitProps
	SE_SetProps \{alpha = 0.0
		scale = 1
		rot_angle = 360
		time = 1.5}
	SE_WaitProps
	repeat
endscript

script ui_sparkle_randomly \{xa = 0.0
		xb = 1.0
		ya = 0.0
		yb = 1.0
		time_a = 0.2
		time_b = 1.0}
	begin
	GetRandomFloat a = <xa> b = <xb>
	x = <random_float>
	GetRandomFloat a = <ya> b = <yb>
	y = <random_float>
	GetRandomFloat a = <time_a> b = <time_b>
	time = <random_float>
	pos = {((<x> * (1.0, 0.0)) + (<y> * (0.0, 1.0))) proportional}
	Wait <time> seconds
	SpawnScript ui_start_sparkle params = {parent = <parent> pos = <pos>}
	repeat
endscript

script ui_start_sparkle \{pos = (0.0, 0.0)
		dims = (32.0, 32.0)
		big_dims = (72.0, 72.0)
		end_dims = (40.0, 40.0)
		z_priority = 12
		time = 0.5}
	if NOT GotParam \{parent}
		parent = root_window
	endif
	ui_sparkle_id new pos = <pos> dims = <dims> z_priority = <z_priority> parent = <parent>
	if NOT (<sparkle_id> = 0)
		OnExitRun ui_start_sparkle_exit params = {id = <sparkle_id> dims = <dims>}
		<sparkle_id> :SE_SetProps rot_angle = 90.0 dims = <big_dims> alpha = 1.0 time = (<time> / 2) parent = <parent>
		<sparkle_id> :SE_WaitProps
		<sparkle_id> :SE_SetProps rot_angle = 180.0 dims = <end_dims> alpha = 0.0 time = (<time> / 2) parent = <parent>
		<sparkle_id> :SE_WaitProps
	endif
endscript

script ui_start_sparkle_exit \{dims = (32.0, 32.0)}
	if GotParam \{id}
		if ScreenElementExists id = <id>
			<id> :SE_SetProps rot_angle = 0.0 dims = <dims> alpha = 0.0
		endif
	endif
endscript

script ui_sparkle_id 

	sparkle_id_array = [sparkle_id_0 sparkle_id_1 sparkle_id_2 sparkle_id_3 sparkle_id_4 sparkle_id_5 sparkle_id_6 sparkle_id_7 sparkle_id_8 sparkle_id_9]
	GetArraySize <sparkle_id_array>
	if GotParam \{new}
		i = 0
		begin
		sparkle_id = (<sparkle_id_array> [(<i>)])
		if NOT ScreenElementExists id = <sparkle_id>
			CreateScreenElement {
				id = <sparkle_id>
				type = SpriteElement
				parent = <parent>
				blend = blend
				texture = sparkle
				alpha = 0.0
				dims = <dims>
				just = [center center]
				pos = <pos>
				z_priority = <z_priority>
				rot_angle = 0.0
				rgba = [255 , 255 , 255 , 255]
			}
			return sparkle_id = <sparkle_id>
		elseif NOT <sparkle_id> :SE_IsMorphing
			<sparkle_id> :SE_SetProps pos = <pos> dims = <dims> rgba = <rgba> alpha = 0.0
			return sparkle_id = <sparkle_id>
		endif
		i = (<i> + 1)
		repeat (<array_size>)
		return \{sparkle_id = 0}
	elseif GotParam \{kill_all}
		i = 0
		begin
		sparkle_id = (<sparkle_id_array> [(<i>)])
		if ScreenElementExists id = <sparkle_id>
			<sparkle_id> :Die
		endif
		i = (<i> + 1)
		repeat (<array_size>)
	endif
endscript

script ui_kill_sparkle_scripts 
	KillSpawnedScript \{name = ui_sparkle_randomly}
	KillSpawnedScript \{name = ui_start_sparkle}
	KillSpawnedScript \{name = ui_create_sparkles_parent}
	KillSpawnedScript \{name = ui_sparkle_id}
endscript
