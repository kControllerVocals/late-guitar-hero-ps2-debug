menu_pos = (150.0, 100.0)
0xbba7b735 = 0

script create_debug_backdrop 
	destroy_debug_backdrop
	createscreenelement \{type = spriteelement
		parent = root_window
		id = debug_backdrop
		pos = (640.0, 0.0)
		dims = (640.0, 720.0)
		just = [
			left
			top
		]
		rgba = [
			0
			0
			0
			255
		]
		z_priority = 1}
endscript

script destroy_debug_backdrop 
	destroy_menu \{menu_id = debug_backdrop}
endscript

script create_debugging_menu 
	safe_create_gh3_pause_menu
	ui_fx_set_blur \{amount = 0.0
		time = 0.0}
	createscreenelement \{type = vscrollingmenu
		parent = pause_menu
		id = debug_scrolling_menu
		just = [
			left
			top
		]
		dims = (400.0, 480.0)
		pos = $menu_pos}
	createscreenelement \{type = vmenu
		parent = debug_scrolling_menu
		id = debug_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				back_to_retail_menu
			}
		]}
	disable_pause
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = toggle_botp1_menuitem
		font = text_a1
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x0573c378)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_botp1
			}
		]}
	toggle_botp1_setprop
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = toggle_botp2_menuitem
		font = text_a1
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x2e5e90bb)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_botp2
			}
		]}
	toggle_botp2_setprop
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = 0x937569a0
		font = text_a1
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3745a1fa)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_botp3
			}
		]}
	toggle_botp3_setprop
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = 0x71a972d9
		font = text_a1
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x7804373d)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_botp4
			}
		]}
	toggle_botp4_setprop
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x627d1426)
		z_priority = 100.0
		just = [
			left
			top
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				playday_unlockall
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = 0x4b78eec8
		font = text_a1
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		just = [
			left
			top
		]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_aspect_ratio
			}
		]}
	getglobaltags \{user_options}
	if (<ps2_widescreen> = 0)
		setscreenelementprops \{id = 0x4b78eec8
			text = qs(0x1d1f28ae)}
	else
		setscreenelementprops \{id = 0x4b78eec8
			text = qs(0x97cccfc3)}
	endif
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = 0x2c140bc5
		font = text_a1
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		just = [
			left
			top
		]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_progressive_scan
			}
		]}
	if ($ps2_progressivescan = 0)
		setscreenelementprops \{id = 0x2c140bc5
			text = qs(0xc3953146)}
	else
		setscreenelementprops \{id = 0x2c140bc5
			text = qs(0x7e6fcd6d)}
	endif
	createscreenelement {
		type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0xbeef52ab)
		z_priority = 100.0
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose select_start_song params = {uselaststarttime forceintro from_gameplay = <from_gameplay>}}
		]
	}
	createscreenelement {
		type = textelement
		parent = debug_vmenu
		id = toggle_playermode_menuitem
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x51f6e6c3)
		z_priority = 100.0
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_left toggle_playermode_left}
			{pad_right toggle_playermode_right}
			{pad_choose select_playermode params = {from_gameplay = <from_gameplay>}}
		]
	}
	toggle_playermode_setprop
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3eee694e)
		z_priority = 100.0
		just = [
			left
			top
		]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_settings_menu
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = 0x7471cfe8
		font = text_a1
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		just = [
			left
			top
		]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_on_audible_hitnote
			}
		]}
	if ($debug_audible_hitnote = 1)
		setscreenelementprops \{id = 0x7471cfe8
			text = qs(0x93c0f15c)}
	else
		setscreenelementprops \{id = 0x7471cfe8
			text = qs(0xbf23837e)}
	endif
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x79aee6c5)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_checkcasassets
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xbc1f222f)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_dumpheaps
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xd37611a5)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_character_viewer_menu
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x72718c0c)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_playcredits
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x7b0ed426)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_toggle_changelist
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = toggle_rolandkit_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x7e35767a)
		z_priority = 100.0
		just = [
			left
			top
		]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_rolandkit
			}
			{
				pad_left
				toggle_rolandkit
			}
			{
				pad_right
				toggle_rolandkit
			}
		]}
	toggle_rolandkit_setprop
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = toggle_lsinfo_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3fd0ccc7)
		z_priority = 100.0
		just = [
			left
			top
		]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				lightshow_toggledebuginfo
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xdb091893)
		z_priority = 100.0
		just = [
			left
			top
		]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				generic_event_choose
				params = {
					state = uistate_debug_color_calibration
				}
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xc939b12e)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_ui_physics_test
				params = {
					debug
				}
			}
		]}
	createscreenelement {
		type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x04a9d108)
		z_priority = 100.0
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose select_start_song params = {uselaststarttime forceintro from_gameplay = <from_gameplay>}}
		]
	}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = toggle_intro_select
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x5f5a1f13)
		z_priority = 100.0
		just = [
			left
			top
		]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_left
				toggle_intro_select_left
			}
			{
				pad_right
				toggle_intro_select_right
			}
			{
				pad_choose
				start_song_with_intro
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x8f190e86)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				increase_band_money_by_100000
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xbd0b859f)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				bankrupt_band
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x84494418)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				togglefps
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x8cb71f71)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_menu_rockstarcreator
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xb481179d)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_menu_rockstarcreatorobjviewer
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x323fca95)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				skipcareerintros
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x63a19b9e)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debugcareerintros
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x05d65352)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				select_debug_menu_loop
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xe883e62d)
		just = [
			left
			top
		]
		z_priority = 100.0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				lightshow_debugcycle
			}
		]}
	createscreenelement \{type = textelement
		parent = debug_vmenu
		id = 0x9d49def0
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xef39ff43)
		z_priority = 100.0
		just = [
			left
			top
		]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				0xd0d754bc
			}
		]}
	0x5bcab44e
	launchevent \{type = focus
		target = debug_vmenu}
endscript

script destroy_debugging_menu 
	if screenelementexists \{id = debug_scrolling_menu}
		destroyscreenelement \{id = debug_scrolling_menu}
	endif
	destroy_menu_backdrop
	destroy_debug_backdrop
endscript

script back_to_debug_menu 
	destroy_all_debug_menus
	ui_event \{event = menu_refresh}
endscript

script destroy_all_debug_menus 
	destroy_replay_menu
	destroy_song_menu
	destroy_settings_menu
	destroy_character_viewer_menu
	destroy_changeguitarist_menu
	destroy_skipintosong_menu
	destroy_cameracut_menu
	destroy_difficulty_menu
	destroy_part_menu
	destroy_skipbytime_menu
	destroy_skipbymarker_menu
	destroy_skipbymeasure_menu
	destroy_looppoint_menu
	destroy_autotest_menu
	destroy_debugging_menu
	destroy_bot_menu
endscript
debug_playcredits_active = 0

script debug_playcredits 
	menu_music_off
	kill_gem_scroller
	destroy_debugging_menu
	reset_score \{player_status = player1_status}
	change \{end_credits = 1}
	change \{debug_playcredits_active = 1}
	change \{game_mode = gh4_p1_career}
	progression_endcredits
endscript

script debug_quitcredits 
	generic_event_back \{state = uistate_debug}
	band_unload_anim_paks
endscript

script debug_difficulty_analyzer 
	ui_menu_select_sfx
	destroy_difficulty_menu
	destroy_debugging_menu
	create_debug_backdrop
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	x_pos = 500
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = song_scrolling_menu
		just = [left top]
		dims = (400.0, 500.0)
		pos = ($menu_pos - (520.0, 0.0) + (<x_pos> * (1.0, 0.0)))
	}
	createscreenelement \{type = vmenu
		parent = song_scrolling_menu
		id = song_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				difficulty_analyzer_back
			}
		]}
	<sorted_songlist> = $gh5_songlist
	get_songlist_size
	array_entry = 0
	begin
	song_checksum = (<sorted_songlist> [<array_entry>])
	get_song_struct song = <song_checksum>
	get_song_title song = <song_checksum>
	createscreenelement {
		type = textelement
		parent = song_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = <song_title>
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{focus wait_for_diff_analyzer params = {<...>}}
			{pad_choose killspawnedscript params = {name = wait_for_diff_analyzer_spawned}}
			{pad_choose create_difficulty_analyzer_instrument_menu params = {song_name = <song_checksum>}}
		]
	}
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	createscreenelement {
		type = textelement
		parent = song_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x2c1db66a)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{focus wait_for_diff_analyzer params = {<...>}}
			{focus killspawnedscript params = {name = wait_for_diff_analyzer_spawned}}
			{pad_choose create_difficulty_analyzer_instrument_menu params = {difficulty = all song_name = debug_output}}
		]
	}
	launchevent \{type = focus
		target = song_vmenu}
endscript

script difficulty_analyzer_back 
	killspawnedscript \{name = wait_for_diff_analyzer_spawned}
	destroy_difficulty_analyzer
	generic_menu_pad_back \{callback = back_to_debug_menu}
endscript

script destroy_difficulty_analyzer_menu 
	if screenelementexists \{id = song_scrolling_menu}
		destroyscreenelement \{id = song_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script wait_for_diff_analyzer 
	killspawnedscript \{name = wait_for_diff_analyzer_spawned}
	spawnscriptnow wait_for_diff_analyzer_spawned params = {<...>}
endscript

script wait_for_diff_analyzer_spawned 
	wait \{0.5
		seconds}
	difficulty_analyzer_show instrument = guitar difficulty = all song_name = <song_checksum>
endscript

script create_difficulty_analyzer_instrument_menu 

	destroy_difficulty_analyzer_menu
	destroy_difficulty_menu
	create_debug_backdrop
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = difficulty_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos + (70.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = difficulty_menu
		id = difficulty_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = debug_difficulty_analyzer
				}
			}
		]}
	array_entry = 0
	getarraysize \{$instrument_checksums}
	begin
	instrument = ($instrument_text [<array_entry>])
	<events> = [
		{focus menu_focus}
		{unfocus menu_unfocus}
		{pad_choose create_difficulty_analyzer_difficulty_menu params = {instrument = ($instrument_checksums [<array_entry>]) song_name = <song_name>}}
	]
	if (<song_name> = debug_output)
		<events> = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_difficulty_analyzer_difficulty_menu params = {instrument = ($instrument_checksums [<array_entry>]) song_name = <song_name>}}
		]
	endif
	createscreenelement {
		type = textelement
		parent = difficulty_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = <instrument>
		just = [left top]
		z_priority = 100.0
		event_handlers = <events>
	}
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	if (<song_name> = debug_output)
		<events> = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_difficulty_analyzer_difficulty_menu params = {all instrument = all song_name = <song_name>}}
		]
		createscreenelement {
			type = textelement
			parent = difficulty_vmenu
			font = debug
			scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x886518a8)
			just = [left top]
			z_priority = 100.0
			event_handlers = <events>
		}
	endif
	launchevent \{type = focus
		target = difficulty_vmenu}
endscript

script create_difficulty_analyzer_difficulty_menu 
	destroy_difficulty_analyzer_menu
	destroy_difficulty_menu
	create_debug_backdrop
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = difficulty_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos + (70.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = difficulty_menu
		id = difficulty_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = debug_difficulty_analyzer
				}
			}
		]}
	array_entry = 0
	getarraysize \{$difficulty_list}
	begin
	difficulty_count = ($difficulty_list [<array_entry>])
	get_difficulty_text difficulty = <difficulty_count>
	<events> = [
		{focus menu_focus}
		{unfocus menu_unfocus}
		{focus difficulty_analyzer_show params = {instrument = <instrument> difficulty = ($difficulty_list [<array_entry>]) song_name = <song_name>}}
	]
	if (<song_name> = debug_output)
		<events> = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose output_diff_scores params = {instrument = <instrument> ($difficulty_list [<array_entry>])}}
		]
	endif
	createscreenelement {
		type = textelement
		parent = difficulty_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = <difficulty_text>
		just = [left top]
		z_priority = 100.0
		event_handlers = <events>
	}
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	if (<song_name> = debug_output)
		<events> = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose output_diff_scores params = {all instrument = <instrument>}}
		]
		createscreenelement {
			type = textelement
			parent = difficulty_vmenu
			font = debug
			scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x886518a8)
			just = [left top]
			z_priority = 100.0
			event_handlers = <events>
		}
	endif
	launchevent \{type = focus
		target = difficulty_vmenu}
endscript

script sort_songlist_metallica_first 
	getarraysize \{$gh5_songlist}
	sortable_songlist = []
	i = 0
	begin
	song = ($gh5_songlist [<i>])
	get_song_title song = <song>
	get_song_artist song = <song> with_year = 0
	if ((<song_artist> = qs(0x0d03c6a5)) || (<song_artist> = qs(0x4b58f1d4)))
		song_artist = qs(0xc2c0b7e6)
	endif

	element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
	addarrayelement array = <sortable_songlist> element = <element_to_add>
	sortable_songlist = <array>
	i = (<i> + 1)
	repeat (<array_size>)
	if globalexists \{name = gh4_download_songlist
			type = array}
		getarraysize \{$gh4_download_songlist}
		if (<array_size> > 0)
			i = 0
			begin
			song = ($gh4_download_songlist [<i>])
			get_song_title song = <song>
			get_song_artist song = <song> with_year = 0
			if ((<song_artist> = qs(0x0d03c6a5)) || (<song_artist> = qs(0x4b58f1d4)))
				song_artist = qs(0xc2c0b7e6)
			endif
			element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
			addarrayelement array = <sortable_songlist> element = <element_to_add>
			sortable_songlist = <array>
			i = (<i> + 1)
			repeat (<array_size>)
		endif
	endif
	sortandbuildsonglist songlist = <sortable_songlist> sortby = artist_alphabetical
	return {sorted_songlist = <sorted_songlist>}
endscript

script create_song_menu \{version = gh3}
	ui_menu_select_sfx
	destroy_all_debug_menus
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = song_scrolling_menu
		just = [left top]
		dims = (400.0, 550.0)
		pos = ($menu_pos - (200.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = song_scrolling_menu
		id = song_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	<sorted_songlist> = $gh5_songlist
	get_songlist_size
	array_entry = 0
	begin
	song_checksum = (<sorted_songlist> [<array_entry>])
	get_song_struct song = <song_checksum>
	get_song_version song = <song_checksum>
	<available> = 1
	if structurecontains structure = <song_struct> dlc_stream_name
		if NOT songcheckifdownloaded filename = (<song_struct>.dlc_stream_name)
			<available> = 0
		endif
	endif
	if (<available> = 1)
		if (<song_version> = <version>)
			get_song_artist song = <song_checksum> with_year = 0
			get_song_title song = <song_checksum>
			createscreenelement {
				type = textelement
				parent = song_vmenu
				font = debug
				scale = 0.75
				rgba = [210 210 210 250]
				text = <song_title>
				just = [left top]
				z_priority = 100.0
				event_handlers = [
					{focus menu_focus}
					{unfocus menu_unfocus}
					{pad_choose create_part_menu params = {song_name = <song_checksum> version = <version> player = 1 from_gameplay = <from_gameplay>}}
				]
			}
		endif
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	launchevent \{type = focus
		target = song_vmenu}
endscript

script back_to_song_menu 
	destroy_part_menu
	create_song_menu version = ($current_song_version) from_gameplay = <from_gameplay>
endscript

script back_to_part_menu 
	destroy_difficulty_menu
	if ($current_num_players = 4)
		back_to_song_menu
	else
		create_part_menu version = <version>
	endif
endscript

script destroy_song_menu 
	if screenelementexists \{id = song_scrolling_menu}
		destroyscreenelement \{id = song_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_difficulty_menu \{player = 1}
	destroy_all_debug_menus
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = difficulty_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos + (70.0, 0.0))
	}
	formattext textname = title qs(0x5c5cedaa) p = <player>
	createscreenelement {
		type = textelement
		parent = difficulty_menu
		pos = (-200.0, 0.0)
		font = fontgrid_text_a8
		text = <title>
	}
	createscreenelement {
		type = vmenu
		parent = difficulty_menu
		id = difficulty_vmenu
		pos = (0.0, 0.0)
		just = [left top]
		event_handlers = [{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back generic_menu_pad_back params = {callback = back_to_part_menu version = <version>}}
		]
	}
	array_entry = 0
	getarraysize \{$difficulty_list}
	num_diffs = <array_size>
	getplayerinfo <player> part
	if (<part> = drum)
		num_diffs = (<array_size> + 1)
	endif
	begin
	if (<array_entry> = <array_size>)
		difficulty_text = qs(0x7a19b5f7)
		current_difficulty = ($difficulty_list [<array_size> -1])
		double_kick = 1
	else
		difficulty_count = ($difficulty_list [<array_entry>])
		get_difficulty_text difficulty = <difficulty_count>
		current_difficulty = ($difficulty_list [<array_entry>])
		double_kick = 0
	endif
	if (<player> = $current_num_players)
		<choose_params> = {callback = create_bot_menu double_kick = <double_kick> player = <player> difficulty = <current_difficulty> callback_params = {song_name = <song_name> player = 1 from_gameplay = <from_gameplay>}}
	else
		<choose_params> = {callback = create_difficulty_menu double_kick = <double_kick> player = <player> difficulty = <current_difficulty> callback_params = {song_name = <song_name> version = <version> player = (<player> + 1) from_gameplay = <from_gameplay>}}
	endif
	createscreenelement {
		type = textelement
		parent = difficulty_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = <difficulty_text>
		z_priority = 100.0
		just = [left top]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose debug_menu_set_double_kick params = <choose_params>}
		]
	}
	<array_entry> = (<array_entry> + 1)
	repeat <num_diffs>
	if (<player> = 1 && $current_num_players = 4)
		createscreenelement {
			type = textelement
			parent = difficulty_vmenu
			font = debug
			scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x720df1fc)
			z_priority = 100.0
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose debug_quick_bot_band params = {difficulty = easy callback = select_start_song callback_params = {song_name = <song_name> from_gameplay = <from_gameplay>}}}
			]
		}
		createscreenelement {
			type = textelement
			parent = difficulty_vmenu
			font = debug
			scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x7f19da59)
			z_priority = 100.0
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose debug_quick_bot_band params = {difficulty = expert callback = select_start_song callback_params = {song_name = <song_name> from_gameplay = <from_gameplay>}}}
			]
		}
	endif
	launchevent \{type = focus
		target = difficulty_vmenu}
endscript

script debug_menu_set_double_kick 
	setplayerinfo <player> difficulty = <difficulty>
	setplayerinfo <player> double_kick_drum = <double_kick>
	<callback> <callback_params>
endscript

script debug_quick_bot_band \{difficulty = expert}
	setplayerinfo 1 difficulty = <difficulty>
	setplayerinfo 2 difficulty = <difficulty>
	setplayerinfo 3 difficulty = <difficulty>
	setplayerinfo 4 difficulty = <difficulty>
	setplayerinfo \{1
		bot_play = 1}
	setplayerinfo \{2
		bot_play = 1}
	setplayerinfo \{3
		bot_play = 1}
	setplayerinfo \{4
		bot_play = 1}
	<callback> <callback_params>
endscript

script destroy_difficulty_menu 
	if screenelementexists \{id = difficulty_menu}
		destroyscreenelement \{id = difficulty_menu}
	endif
	destroy_menu_backdrop
endscript

script create_bot_menu \{player = 1}
	destroy_all_debug_menus
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = bot_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos + (70.0, 0.0))
	}
	formattext textname = title qs(0x5c5cedaa) p = <player>
	createscreenelement {
		type = textelement
		parent = bot_menu
		pos = (-200.0, 0.0)
		font = fontgrid_text_a8
		text = <title>
	}
	createscreenelement {
		type = vmenu
		parent = bot_menu
		id = bot_vmenu
		pos = (0.0, 0.0)
		just = [left top]
		event_handlers = [{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back generic_menu_pad_back params = {callback = back_to_difficulty_menu version = <version>}}
		]
	}
	if (<player> = $current_num_players)
		<choose_params> = {callback = select_start_song double_kick = <double_kick> player = <player> callback_params = {song_name = <song_name> from_gameplay = <from_gameplay>}}
	else
		<choose_params> = {callback = create_bot_menu double_kick = <double_kick> player = <player> callback_params = {song_name = <song_name> version = <version> player = (<player> + 1) from_gameplay = <from_gameplay>}}
	endif
	createscreenelement {
		type = textelement
		parent = bot_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x5217670b)
		z_priority = 100.0
		just = [left top]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose debug_menu_set_bot params = {<choose_params> bot = 0}}
		]
	}
	createscreenelement {
		type = textelement
		parent = bot_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x24bbae9c)
		z_priority = 100.0
		just = [left top]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose debug_menu_set_bot params = {<choose_params> bot = 1}}
		]
	}
	launchevent \{type = focus
		target = bot_vmenu}
endscript

script debug_menu_set_bot 
	setplayerinfo <player> bot_play = <bot>
	<callback> <callback_params>
endscript

script destroy_bot_menu 
	if screenelementexists \{id = bot_menu}
		destroyscreenelement \{id = bot_menu}
	endif
	destroy_menu_backdrop
endscript

script back_to_difficulty_menu 
	destroy_bot_menu
	create_difficulty_menu version = <version>
endscript
part_list = [
	guitar
	drum
	bass
	vocals
]
part_list_props = {
	guitar = {
		index = 0
		text_nl = 'guitar'
		text = qs(0x11355666)
		text_upper = qs(0x9504b94a)
	}
	drum = {
		index = 1
		text_nl = 'drum'
		text = qs(0xfd52050f)
		text_upper = qs(0xcf488ba5)
	}
	bass = {
		index = 2
		text_nl = 'bass'
		text = qs(0x4f551cbe)
		text_upper = qs(0x7d4f9214)
	}
	vocals = {
		index = 3
		text_nl = 'vocals'
		text = qs(0x9fae80a8)
		text_upper = qs(0x1b9f6f84)
	}
	band = {
		index = 3
		text_nl = 'band'
		text = qs(0xe8a5176a)
		text_upper = qs(0xdabf99c0)
	}
}

script get_part_text \{part = guitar}
	return part_text = ($part_list_props.<part>.text)
endscript

script get_part_text_nl 
	return part_text = ($part_list_props.<part>.text_nl)
endscript

script create_part_menu \{player = 1}
	if ($current_num_players = 4)
		setplayerinfo \{1
			part = guitar}
		setplayerinfo \{2
			part = bass}
		setplayerinfo \{3
			part = drum}
		setplayerinfo \{4
			part = vocals}
		create_difficulty_menu {song_name = <song_name> version = <version> player = 1 from_gameplay = <from_gameplay>}
		return
	endif
	destroy_all_debug_menus
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = part_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos + (70.0, 0.0))
	}
	formattext textname = title qs(0x5c5cedaa) p = <player>
	createscreenelement {
		type = textelement
		parent = part_menu
		pos = (-200.0, 0.0)
		font = fontgrid_text_a8
		text = <title>
	}
	createscreenelement {
		type = vmenu
		parent = part_menu
		id = part_vmenu
		pos = (0.0, 0.0)
		just = [left top]
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back generic_menu_pad_back params = {callback = back_to_song_menu version = <version>}}
		]
	}
	array_entry = 0
	getarraysize \{$part_list}
	begin
	part_count = ($part_list [<array_entry>])
	get_part_text part = <part_count>
	if (<player> = $current_num_players)
		createscreenelement {
			type = textelement
			parent = part_vmenu
			font = debug
			scale = 0.75
			rgba = [210 210 210 250]
			text = <part_text>
			z_priority = 100.0
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose debug_menu_set_part params = {callback = create_difficulty_menu player = <player> part = ($part_list [<array_entry>]) callback_params = {song_name = <song_name> version = <version> player = 1 from_gameplay = <from_gameplay>}}}
			]
		}
	else
		createscreenelement {
			type = textelement
			parent = part_vmenu
			font = debug
			scale = 0.75
			rgba = [210 210 210 250]
			text = <part_text>
			just = [left top]
			z_priority = 100.0
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose debug_menu_set_part params = {callback = create_part_menu player = <player> part = ($part_list [<array_entry>]) callback_params = {song_name = <song_name> version = <version> player = (<player> + 1) from_gameplay = <from_gameplay>}}}
			]
		}
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	launchevent \{type = focus
		target = part_vmenu}
endscript

script debug_menu_set_part 
	setplayerinfo <player> part = <part>
	<callback> <callback_params>
endscript

script destroy_part_menu 
	if screenelementexists \{id = part_menu}
		destroyscreenelement \{id = part_menu}
	endif
	destroy_menu_backdrop
endscript

script create_settings_menu 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = settings_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos - (30.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = settings_scrolling_menu
		id = settings_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_allowcontroller_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x5bdead88)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_allowcontroller
			}
		]}
	toggle_allowcontroller_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x0606bdb8)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_changevenue_menu
			}
		]}
	createscreenelement \{type = textelement
		parent = settings_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x7a2d9b63)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_changeguitar_menu
				params = {
					type = guitar
				}
			}
		]}
	createscreenelement \{type = textelement
		parent = settings_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x4f76321c)
		just = [
			left
			top
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_changeguitar_menu
				params = {
					type = bass
				}
			}
		]}
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_visibility_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x4bf88204)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_togglevisibility_menu
			}
		]}
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = select_slomo_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xb124b270)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				select_slomo
			}
		]}
	select_slomo_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_showmeasures_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x680492d0)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_showmeasures
			}
		]}
	toggle_showmeasures_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_showsongstars_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xdae59d1c)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_showsongstars
			}
		]}
	toggle_showsongstars_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = 0x9c3673da
		font = text_a1
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		just = [
			left
			top
		]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				0xdb79f598
			}
		]}
	0x22729eb0
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_showsongtime_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xba249053)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_showsongtime
			}
		]}
	toggle_showsongtime_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_showcameraname_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3630af7e)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_showcameraname
			}
		]}
	toggle_showcameraname_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_inputlog_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x32db050e)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_inputlog
			}
		]}
	toggle_inputlog_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_rockmeterdebug_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x0979628f)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_rockmeterdebug
			}
		]}
	toggle_rockmeterdebug_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_viewvolumesonscreen_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xe280d18b)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_viewvolumesonscreen
			}
		]}
	toggle_viewvolumesonscreen_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_lagtestpart1_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xa596cd4e)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_lagtestpart1
			}
		]}
	toggle_lagtestpart1_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_lagtestpart2_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x8ebb9e8d)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_lagtestpart2
			}
		]}
	toggle_lagtestpart2_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_lagtestpart3_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x97a0afcc)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_lagtestpart3
			}
		]}
	toggle_lagtestpart3_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = edit_inputlagvalue_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3cf0ba39)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_left
				edit_inputlagvalue_left
			}
			{
				pad_right
				edit_inputlagvalue_right
			}
		]}
	edit_inputlagvalue_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = edit_gemlagvalue_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xce5672c6)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_left
				edit_gemlagvalue_left
			}
			{
				pad_right
				edit_gemlagvalue_right
			}
		]}
	edit_gemlagvalue_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = edit_audiolagvalue_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xd949c36e)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_left
				edit_audiolagvalue_left
			}
			{
				pad_right
				edit_audiolagvalue_right
			}
		]}
	edit_audiolagvalue_setprop
	player = 1
	begin
	formattext checksumname = togglebot 'toggle_botp%d_menuitem' d = <player>
	createscreenelement {
		type = textelement
		parent = settings_vmenu
		id = <togglebot>
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0xbf872413)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose toggle_bot params = {player = <player>}}
		]
	}
	toggle_bot_setprop player = <player>
	player = (<player> + 1)
	repeat 4
	player = 1
	begin
	formattext checksumname = togglestar 'toggle_starp%d_menuitem' d = <player>
	createscreenelement {
		type = textelement
		parent = settings_vmenu
		id = <togglestar>
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0xdfaad110)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose toggle_star params = {player = <player>}}
		]
	}
	toggle_star_setprop player = <player>
	player = (<player> + 1)
	repeat 4
	player = 1
	begin
	formattext checksumname = togglehyperspeed 'toggle_hyperspeedp%d_menuitem' d = <player>
	createscreenelement {
		type = textelement
		parent = settings_vmenu
		id = <togglehyperspeed>
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x1a66c532)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_left toggle_hyperspeed_left params = {player = <player>}}
			{pad_right toggle_hyperspeed_right params = {player = <player>}}
		]
	}
	toggle_hyperspeed_setprop player = <player>
	player = (<player> + 1)
	repeat 4
	player = 1
	begin
	formattext checksumname = togglekick 'toggle_kickp%d_menuitem' d = <player>
	createscreenelement {
		type = textelement
		parent = settings_vmenu
		id = <togglekick>
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x25dba15f)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose toggle_double_kick params = {player = <player>}}
		]
	}
	toggle_double_kick_setprop player = <player>
	player = (<player> + 1)
	repeat 4
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = edit_inputlog_lines_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x5ad98d77)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_left
				edit_inputlog_lines_left
			}
			{
				pad_right
				edit_inputlog_lines_right
			}
		]}
	edit_inputlog_lines_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_tilt_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x32db050e)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_tilt
			}
		]}
	toggle_tilt_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_leftyflip_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x8b8321bb)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_leftyflip
			}
		]}
	toggle_leftyflip_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = create_cameracut_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xa6526c61)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_cameracut_group_menu
			}
		]}
	createscreenelement \{type = textelement
		parent = settings_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xf8c4f04f)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_global
				params = {
					global_toggle = show_gpu_time
				}
			}
		]}
	createscreenelement \{type = textelement
		parent = settings_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x2cf5bcc8)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_global
				params = {
					global_toggle = show_cpu_time
				}
			}
		]}
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_forcescore_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xd7f64bb0)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_forcescore
			}
		]}
	toggle_forcescore_setprop
	createscreenelement \{type = textelement
		parent = settings_vmenu
		id = toggle_vocalsfreeform_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x1af80ceb)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_vocalsfreeform
			}
		]}
	toggle_vocalsfreeform_setprop
	launchevent \{type = focus
		target = settings_vmenu}
endscript

script toggle_aspect_ratio 
	getglobaltags \{user_options}
	if (<ps2_widescreen> = 1)
		setscreenelementprops \{id = 0x4b78eec8
			text = qs(0x1d1f28ae)}
		setglobaltags \{user_options
			params = {
				ps2_widescreen = 0
			}}
		setscreen \{widescreen = 0}
	else
		setscreenelementprops \{id = 0x4b78eec8
			text = qs(0x97cccfc3)}
		setglobaltags \{user_options
			params = {
				ps2_widescreen = 1
			}}
		setscreen \{widescreen = 1}
	endif
endscript

script toggle_progressive_scan 
	if ($ps2_progressivescan = 1)
		setscreenelementprops \{id = 0x2c140bc5
			text = qs(0xc3953146)}
		change \{ps2_progressivescan = 0}
		setprogressive \{on = 0}
	else
		setscreenelementprops \{id = 0x2c140bc5
			text = qs(0x7e6fcd6d)}
		change \{ps2_progressivescan = 1}
		setprogressive \{on = 1}
	endif
endscript

script toggle_on_audible_hitnote 
	if ($debug_audible_hitnote = 1)
		change \{debug_audible_hitnote = 0}
		setscreenelementprops \{id = 0x7471cfe8
			text = qs(0x576b2a3b)}
	else
		change \{debug_audible_hitnote = 1}
		setscreenelementprops \{id = 0x7471cfe8
			text = qs(0x93c0f15c)}
	endif
endscript

script 0xdb79f598 
	getglobaltags \{user_options}
	if (<ps2_stereo_sound> = 1)
		setglobaltags \{user_options
			params = {
				ps2_stereo_sound = 0
			}}
		0xf2b96a22 \{0}
	else
		setglobaltags \{user_options
			params = {
				ps2_stereo_sound = 1
			}}
		0xf2b96a22 \{1}
	endif
	0x22729eb0
endscript

script playday_unlockall 
	difficulties = [easy medium hard expert]
	getarraysize <difficulties>
	diff_size = <array_size>
	menu_music_off
	getarraysize ($gh5_songlist)
	i = 0
	begin
	song = ($gh5_songlist [<i>])
	get_song_saved_in_globaltags song = <song>
	if (<saved_in_globaltags> = 1)
		setglobaltags <song> params = {unlocked = 1}
	endif
	i = (<i> + 1)
	repeat <array_size>
	get_current_band_info
	setglobaltags <band_info> params = {career_guitar_prev_total_songs = <array_size>}
	setglobaltags <band_info> params = {career_bass_prev_total_songs = <array_size>}
	setglobaltags <band_info> params = {career_drum_prev_total_songs = <array_size>}
	setglobaltags <band_info> params = {career_vocals_prev_total_songs = <array_size>}
	setglobaltags <band_info> params = {career_band_prev_total_songs = <array_size>}
	getarraysize ($instrument_progression_list)
	instrument_size = <array_size>
	instrument_index = 0
	begin
	diff_index = 0
	begin
	get_progression_globals ($instrument_progression_list [<instrument_index>])
	globaltags_unlockall songlist = <tier_global> difficulty = (<difficulties> [<diff_index>])
	<diff_index> = (<diff_index> + 1)
	repeat <diff_size>
	get_progression_globals ($instrument_progression_list [<instrument_index>])
	setup_gigtags setlist_songs = <tier_global> unlock_order = ($unlock_order_list [<instrument_index>]) use_cheat_tags = 1
	<instrument_index> = (<instrument_index> + 1)
	repeat <instrument_size>
	i = 0
	getarraysize ($bonus_videos)
	begin
	video_checksum = ($bonus_videos [<i>].id)
	setglobaltags <video_checksum> params = {unlocked = 1}
	<i> = (<i> + 1)
	repeat <array_size>
	get_levelzonearray_size
	index = 0
	begin
	get_levelzonearray_checksum index = <index>
	formattext checksumname = venue_checksum 'venue_%s' s = ($levelzones.<level_checksum>.name)
	if NOT structurecontains structure = ($levelzones.<level_checksum>) debug_only
		setglobaltags <venue_checksum> params = {unlocked = 1}
	endif
	index = (<index> + 1)
	repeat <array_size>
	change \{structurename = player1_status
		new_cash = 0}
	change \{progression_play_completion_movie = 0}
	change \{progression_unlock_tier_last_song = 0}
	if globalexists \{name = debug_bypass_intro}
		setglobaltags <band_info> params = {
			career_intro_guitar_complete = 1
			career_intro_bass_complete = 1
			career_intro_drum_complete = 1
			career_intro_vocals_complete = 1
			career_intro_band_complete = 1
		}
	endif
	unlock_all_profiles
	purchase_all_profiles
	unlock_purchase_all_cas_parts
	spawnscriptnow \{menu_music_on}
	change \{0xbba7b735 = 1}
endscript

script hide_band_members 
	guitarist :hide
	bassist :hide
	vocalist :hide
	drummer :hide
endscript

script show_band_members 
	guitarist :unhide
	bassist :unhide
	vocalist :unhide
	drummer :unhide
endscript

script back_to_settings_menu 
	destroy_changevenue_menu
	destroy_changehighway_menu
	destroy_changeguitar_menu
	destroy_togglevisibility_menu
	destroy_cameracut_group_menu
	create_settings_menu
endscript

script back_to_cameracut_group_menu 
	destroy_cameracut_menu
	create_cameracut_group_menu
endscript

script destroy_settings_menu 
	if screenelementexists \{id = settings_scrolling_menu}
		destroyscreenelement \{id = settings_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript
cameracutprefixarray = [
	'cameras'
	'cameras_guitarist'
	'cameras_singer'
	'cameras_drummer'
	'cameras_bassist'
	'cameras_moments'
	'cameras_headtohead'
	'cameras_single'
	'cameras_solo'
	'cameras_guitar_closeup'
	'cameras_closeup'
	'cameras_closeups'
	'cameras_orbit'
	'cameras_pan'
	'cameras_dolly'
	'cameras_zoom_slow'
	'cameras_zoom_fast'
	'cameras_zoom_out'
	'cameras_zoom'
	'cameras_spotlight'
	'cameras_audience'
	'cameras_Side_A'
	'cameras_Side_B'
	'cameras_Side_C'
	'cameras_Side_D'
	'cameras_Orbit_Low'
	'cameras_Orbit_High'
	'cameras_vert_drummer'
	'cameras_vert_guitarist'
	'cameras_vert_stagerear'
	'cameras_vert_stagefront'
	'cameras_intro'
	'cameras_fastintro'
	'cameras_boss'
	'cameras_encore'
	'cameras_walk'
	'cameras_starpower'
	'cameras_special'
	'cameras_stagedive'
	'cameras_win'
	'cameras_lose'
	'cameras_preencore'
	'cameras_preboss'
	'cameras_2p'
	'cameras_boss_closeup_2p'
	'cameras_player_closeup_2p'
	'cameras_solo_2p'
	'cameras_guitar_closeup_2p'
	'cameras_drummer_2p'
	'cameras_singer_2p'
	'cameras_singer_closeup_2p'
	'cameras_bassist_2p'
	'cameras_orbit_2p'
	'cameras_pan_2p'
	'cameras_intro_2p'
	'cameras_fastintro_2p'
	'cameras_starpower_2p'
	'cameras_win_2p'
	'cameras_lose_2p'
	'cameras_Side_A'
	'cameras_Side_B'
	'cameras_Side_C'
	'cameras_Side_D'
	'cameras_Orbits'
]

script create_cameracut_group_menu 
	ui_menu_select_sfx
	destroy_settings_menu
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = selectcameracut_scrolling_group_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos - (30.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = selectcameracut_scrolling_group_menu
		id = selectcameracut_group_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = back_to_settings_menu
				}
			}
		]}
	createscreenelement \{type = textelement
		parent = selectcameracut_group_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x1527ff9c)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				select_cameracut
				params = {
					camera_array_pakname = none
					camera_array = none
					array_count = none
				}
			}
		]}
	getpakmancurrentname \{map = zones}
	camera_count = 0
	getarraysize \{$cameracutprefixarray}
	camera_array_size = <array_size>
	begin
	formattext checksumname = camera_array '%s_%p' s = <pakname> p = ($cameracutprefixarray [<camera_count>])
	if globalexists name = <camera_array>
		getarraysize $<camera_array>
		if (<array_size>)
			formattext textname = camera_group qs(0x581d2af2) p = ($cameracutprefixarray [<camera_count>])
			createscreenelement {
				type = textelement
				parent = selectcameracut_group_vmenu
				font = debug
				scale = 0.75
				rgba = [210 210 210 250]
				text = <camera_group>
				z_priority = 100.0
				just = [left top]
				event_handlers = [
					{focus menu_focus}
					{unfocus menu_unfocus}
					{pad_choose create_cameracut_menu params = {camera_count = <camera_count>}}
					{pad_square create_cameracut_menu params = {camera_count = <camera_count>}}
				]
			}
		endif
	endif
	camera_count = (<camera_count> + 1)
	repeat <camera_array_size>
	launchevent \{type = focus
		target = selectcameracut_group_vmenu}
endscript

script create_cameracut_menu 
	if NOT gotparam \{camera_count}
		create_cameracut_group_menu
		return
	endif
	ui_menu_select_sfx
	destroy_cameracut_group_menu
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = selectcameracut_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos - (30.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = selectcameracut_scrolling_menu
		id = selectcameracut_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = back_to_cameracut_group_menu
				}
			}
		]}
	getpakmancurrentname \{map = zones}
	formattext checksumname = camera_array '%s_%p' s = <pakname> p = ($cameracutprefixarray [<camera_count>])
	if globalexists name = <camera_array>
		getarraysize $<camera_array>
		array_count = 0
		begin
		formattext textname = camera_name qs(0x3efec28c) s = <pakname> p = ($cameracutprefixarray [<camera_count>]) i = <array_count>
		if structurecontains structure = ($<camera_array> [<array_count>]) name
			formattext textname = camera_name qs(0x73307931) s = ($<camera_array> [<array_count>].name) dontassertforchecksums
		elseif structurecontains structure = ($<camera_array> [<array_count>]) params
			if structurecontains structure = ($<camera_array> [<array_count>].params) name
				formattext textname = camera_name qs(0x73307931) s = ($<camera_array> [<array_count>].params.name) dontassertforchecksums
			endif
		endif
		createscreenelement {
			type = textelement
			parent = selectcameracut_vmenu
			font = debug
			scale = 0.75
			rgba = [210 210 210 250]
			text = <camera_name>
			z_priority = 100.0
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose select_cameracut params = {camera_array_pakname = <pakname> camera_array = ($cameracutprefixarray [<camera_count>]) array_count = <array_count>}}
				{pad_square select_cameracut params = {camera_array_pakname = <pakname> camera_array = ($cameracutprefixarray [<camera_count>]) array_count = <array_count> jumptoviewer}}
				{pad_option2 select_cameracut_video params = {camera_array_pakname = <pakname> camera_array = ($cameracutprefixarray [<camera_count>]) array_count = <array_count> name = <camera_name>}}
			]
		}
		<array_count> = (<array_count> + 1)
		repeat <array_size>
	endif
	launchevent \{type = focus
		target = selectcameracut_vmenu}
endscript

script back_to_cameracut_menu 
	create_cameracut_menu
endscript

script destroy_cameracut_menu 
	if screenelementexists \{id = selectcameracut_scrolling_menu}
		destroyscreenelement \{id = selectcameracut_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script destroy_cameracut_group_menu 
	if screenelementexists \{id = selectcameracut_scrolling_group_menu}
		destroyscreenelement \{id = selectcameracut_scrolling_group_menu}
	endif
	destroy_menu_backdrop
endscript
debug_camera_array = none
debug_camera_array_pakname = none
debug_camera_array_count = 0

script select_cameracut 
	ui_menu_select_sfx
	change debug_camera_array = <camera_array>
	change debug_camera_array_pakname = <camera_array_pakname>
	change debug_camera_array_count = <array_count>
	destroy_cameracuts
	wait \{3
		gameframes}
	create_cameracuts
	if gotparam \{jumptoviewer}
		destroy_all_debug_menus
		unpausegh3
		enable_pause
		change \{viewer_buttons_enabled = 1}
		toggleviewmode
	endif
endscript

script select_cameracut_video 
	ui_menu_select_sfx

	formattext textname = file_name qs(0x7ded7b88) a = <camera_array> i = <array_count>
	if globalexists \{name = capture_file_name}
		change capture_file_name = <file_name>
	endif
	change debug_camera_array = <camera_array>
	change debug_camera_array_pakname = <camera_array_pakname>
	change debug_camera_array_count = <array_count>
	destroy_cameracuts
	hide_band_members
	wait \{3
		gameframes}
	create_cameracuts
	unpausegh3
	root_window :legacydomorph \{alpha = 0}
	change \{select_cameracut_video_end_enable = 1}
endscript
select_cameracut_video_end_enable = 0
capture_frame_count = 0

script select_cameracut_video_end 

	root_window :legacydomorph \{alpha = 1}
	if ($capture_frame_count = 0)
		if ($select_cameracut_video_end_enable = 1)
			pausegh3
			change \{select_cameracut_video_end_enable = 0}
			show_band_members
			if globalexists \{name = is_video_capture_session}
				if ($is_video_capture_session = 1)
					video_capture_session_end
				endif
			endif
		endif
	endif
endscript

script create_character_viewer_menu 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = character_viewer_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos - (30.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = character_viewer_scrolling_menu
		id = character_viewer_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	createscreenelement \{type = textelement
		parent = character_viewer_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3eaa1c82)
		z_priority = 100.0
		just = [
			left
			top
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_changeguitarist_menu
			}
		]}
	launchevent \{type = focus
		target = character_viewer_vmenu}
endscript

script back_to_character_viewer_menu 
	destroy_changeguitarist_menu
	destroy_changebassist_menu
	destroy_changevocalist_menu
	destroy_changedrummer_menu
	create_character_viewer_menu
endscript

script destroy_character_viewer_menu 
	if screenelementexists \{id = character_viewer_scrolling_menu}
		destroyscreenelement \{id = character_viewer_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_changeguitarist_menu 
	ui_menu_select_sfx
	destroy_character_viewer_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = changeguitarist_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos + (70.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = changeguitarist_scrolling_menu
		id = changeguitarist_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = back_to_character_viewer_menu
				}
			}
		]}
	get_savegame_from_controller controller = ($primary_controller)
	get_musician_profile_size savegame = <savegame>
	index = 0
	begin
	get_musician_profile_struct_by_index index = <index> savegame = <savegame>
	createscreenelement {
		type = textelement
		parent = changeguitarist_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = (<profile_struct>.fullname)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose debug_menu_choose_guitarist params = {index = <index>}}
		]
	}
	index = (<index> + 1)
	repeat <array_size>
	launchevent \{type = focus
		target = changeguitarist_vmenu}
endscript

script destroy_changeguitarist_menu 
	if screenelementexists \{id = changeguitarist_scrolling_menu}
		destroyscreenelement \{id = changeguitarist_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script debug_menu_choose_guitarist 
	destroy_changeguitarist_menu
	kill_gem_scroller
	get_savegame_from_controller controller = ($primary_controller)
	get_musician_profile_struct_by_index index = <index> savegame = <savegame>
	guitarist_id = (<profile_struct>.name)
	change structurename = player1_status character_id = <guitarist_id>
	if NOT create_guitarist \{useoldpos
			player_status = player1_status
			savegame = 0}
		downloadcontentlost
	endif
	restart_gem_scroller song_name = ($current_song) difficulty = ($player1_status.difficulty) difficulty2 = ($player2_status.difficulty) starttime = ($current_starttime) device_num = <device_num>
	generic_event_choose \{state = uistate_gameplay}
endscript

script create_changebassist_menu 
endscript

script destroy_changebassist_menu 
endscript

script create_changevocalist_menu 
endscript

script destroy_changevocalist_menu 
endscript

script create_changedrummer_menu 
endscript

script destroy_changedrummer_menu 
endscript

script select_playermode 
	change player1_device = <device_num>
	translate_gamemode
	create_song_menu version = ($current_song_version) from_gameplay = <from_gameplay>
endscript
debug_with_rhythm = 0
force_coop = 0

script translate_gamemode 
	switch $game_mode
		case p1_quickplay
		case gh4_p1_career
		case p1_boss
		case practice
		change \{current_num_players = 1}
		case p2_quickplay
		case gh4_p2_career
		case p2_pro_faceoff
		change \{current_num_players = 2}
		case p3_quickplay
		case gh4_p3_career
		change \{current_num_players = 3}
		case p4_quickplay
		case gh4_p4_career
		change \{current_num_players = 4}
	endswitch
endscript

script toggle_hyperspeed_left 
	ui_menu_select_sfx
	kill_debug_elements
	<player_status> = ($0x2994109a [<player>])
	<new_value> = (($<player_status>.hyperspeed) - 0.01)
	if (<new_value> > $hyperspeed_slowest)
		<new_value> = $hyperspeed_slowest
	endif
	if (<new_value> < $hyperspeed_fastest)
		<new_value> = $hyperspeed_fastest
	endif
	change structurename = <player_status> hyperspeed = <new_value>
	toggle_hyperspeed_setprop player = <player>
endscript

script toggle_hyperspeed_right 
	ui_menu_select_sfx
	kill_debug_elements
	<player_status> = ($0x2994109a [<player>])
	<new_value> = (($<player_status>.hyperspeed) + 0.01)
	if (<new_value> > $hyperspeed_slowest)
		<new_value> = $hyperspeed_slowest
	endif
	if (<new_value> < $hyperspeed_fastest)
		<new_value> = $hyperspeed_fastest
	endif
	change structurename = <player_status> hyperspeed = <new_value>
	toggle_hyperspeed_setprop player = <player>
endscript

script toggle_playermode_left 
	switch $game_mode
		case p1_quickplay
		change \{game_mode = practice}
		case p2_quickplay
		change \{game_mode = p1_quickplay}
		case p3_quickplay
		change \{game_mode = p2_quickplay}
		case p4_quickplay
		change \{game_mode = p3_quickplay}
		case gh4_p1_career
		change \{game_mode = p4_quickplay}
		case gh4_p2_career
		change \{game_mode = gh4_p1_career}
		case gh4_p3_career
		change \{game_mode = gh4_p2_career}
		case gh4_p4_career
		change \{game_mode = gh4_p3_career}
		case p2_pro_faceoff
		change \{game_mode = gh4_p4_career}
		case practice
		change \{game_mode = p2_pro_faceoff}
	endswitch
	toggle_playermode_setprop
endscript

script toggle_playermode_right 
	switch $game_mode
		case p1_quickplay
		change \{game_mode = p2_quickplay}
		case p2_quickplay
		change \{game_mode = p3_quickplay}
		case p3_quickplay
		change \{game_mode = p4_quickplay}
		case p4_quickplay
		change \{game_mode = gh4_p1_career}
		case gh4_p1_career
		change \{game_mode = gh4_p2_career}
		case gh4_p2_career
		change \{game_mode = gh4_p3_career}
		case gh4_p3_career
		change \{game_mode = gh4_p4_career}
		case gh4_p4_career
		change \{game_mode = p2_pro_faceoff}
		case p2_pro_faceoff
		change \{game_mode = practice}
		case practice
		change \{game_mode = p1_quickplay}
	endswitch
	toggle_playermode_setprop
endscript

script toggle_playermode_setprop 
	switch $game_mode
		case p1_quickplay
		text = qs(0x2b693e56)
		case p2_quickplay
		text = qs(0x12119316)
		case p3_quickplay
		text = qs(0x0539f7d6)
		case p4_quickplay
		text = qs(0x60e0c996)
		case gh4_p1_career
		text = qs(0x71f5fc56)
		case gh4_p2_career
		text = qs(0x583d48a4)
		case gh4_p3_career
		text = qs(0xf655d935)
		case gh4_p4_career
		text = qs(0x0bac2140)
		case p2_pro_faceoff
		text = qs(0x290eb588)
		case practice
		text = qs(0xeb45639d)
	endswitch
	toggle_playermode_menuitem :se_setprops text = <text>
endscript

script toggle_rolandkit 
	if ($roland_drumkit = 1)
		change \{roland_drumkit = 0}
	else
		change \{roland_drumkit = 1}
	endif
	toggle_rolandkit_setprop
endscript

script toggle_rolandkit_setprop 
	if ($roland_drumkit = 1)
		toggle_rolandkit_menuitem :se_setprops \{text = qs(0x7c5f597d)}
	else
		toggle_rolandkit_menuitem :se_setprops \{text = qs(0x7e35767a)}
	endif
endscript

script toggle_guitar_touch_test 
	if scriptisrunning \{touch_sensor_spawned}
		end_touch_sensor_test
	else
		start_touch_sensor_test
	endif
	toggle_guitar_touch_test_setprop
endscript

script toggle_guitar_touch_test_setprop 
	if scriptisrunning \{touch_sensor_spawned}
		toggle_guitar_touch_test_menuitem :se_setprops \{text = qs(0x9748009f)}
	else
		toggle_guitar_touch_test_menuitem :se_setprops \{text = qs(0x00cae553)}
	endif
endscript

script select_slomo 
	ui_menu_select_sfx
	speedfactor = ($current_speedfactor * 10.0)
	speedfactor = (<speedfactor> + 1.0)
	if (<speedfactor> > 30.0)
		speedfactor = 1.0
	endif
	if (<speedfactor> < 1.0)
		speedfactor = 1.0
	endif
	change current_speedfactor = (<speedfactor> / 10.0)
	update_slomo
	select_slomo_setprop
endscript

script update_slomo 
	setslomo \{$current_speedfactor}
	setslomo_song \{slomo = $current_speedfactor}
	player = 1
	begin
	<player_status> = ($0x2994109a [<player>])
	change structurename = <player_status> check_time_early = ($check_time_early * $current_speedfactor)
	change structurename = <player_status> check_time_late = ($check_time_late * $current_speedfactor)
	player = (<player> + 1)
	repeat $current_num_players
endscript

script select_slomo_setprop 
	formattext \{textname = slomo_text
		qs(0xe4465fdd)
		s = $current_speedfactor}
	select_slomo_menuitem :se_setprops text = <slomo_text>
endscript
debug_showmeasures = off

script toggle_showmeasures 
	ui_menu_select_sfx
	if screenelementexists \{id = debug_measures_text}
		destroyscreenelement \{id = debug_measures_text}
	endif
	if ($debug_showmeasures = off)
		change \{debug_showmeasures = on}
		createscreenelement \{type = textelement
			parent = root_window
			id = debug_measures_text
			font = debug
			text = qs(0xaa4c0def)
			scale = 1
			pos = (850.0, 400.0)
			rgba = [
				255
				187
				0
				255
			]
			just = [
				left
				top
			]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [
				0
				0
				0
				255
			]
			hide
			z_priority = 1000}
		if ($playing_song = 1)
			debug_measures_text :se_setprops \{unhide}
		endif
	else
		change \{debug_showmeasures = off}
	endif
	if NOT gotparam \{for_autolaunch}
		toggle_showmeasures_setprop
	endif
endscript

script toggle_showmeasures_setprop 
	if ($debug_showmeasures = off)
		toggle_showmeasures_menuitem :se_setprops \{text = qs(0x79498c91)}
	else
		toggle_showmeasures_menuitem :se_setprops \{text = qs(0x43a601a6)}
	endif
endscript

script print_measures_text \{channel = drum_starpower_attempts}
	if screenelementexists \{id = debug_measures_text}
		debug_measures_text :se_getprops \{text}

	endif
endscript
debug_showsongstars = off

script toggle_showsongstars 
	ui_menu_select_sfx
	if screenelementexists \{id = debug_songstars_text}
		destroyscreenelement \{id = debug_songstars_text}
	endif
	if ($debug_showsongstars = off)
		change \{debug_showsongstars = on}
		createscreenelement \{type = textelement
			parent = root_window
			id = debug_songstars_text
			font = debug
			text = qs(0xfbf320c8)
			scale = 1
			pos = (850.0, 300.0)
			rgba = [
				255
				187
				0
				255
			]
			just = [
				left
				top
			]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [
				0
				0
				0
				255
			]
			hide
			z_priority = 1000}
		if ($playing_song = 1)
			debug_songstars_text :se_setprops \{unhide}
		endif
	else
		change \{debug_showsongstars = off}
	endif
	toggle_showsongstars_setprop
endscript

script toggle_showsongstars_setprop 
	if NOT screenelementexists \{id = toggle_showsongstars_menuitem}
		return
	endif
	if ($debug_showsongstars = off)
		toggle_showsongstars_menuitem :se_setprops \{text = qs(0x01ad6392)}
	else
		toggle_showsongstars_menuitem :se_setprops \{text = qs(0x060c5b2e)}
	endif
endscript

script 0x22729eb0 
	getglobaltags \{user_options}
	if (<ps2_stereo_sound> = 1)
		setscreenelementprops \{id = 0x9c3673da
			text = qs(0x315f9c01)}
	else
		setscreenelementprops \{id = 0x9c3673da
			text = qs(0x83351f1d)}
	endif
endscript
debug_showsongtime = off

script toggle_showsongtime 
	ui_menu_select_sfx
	if screenelementexists \{id = debug_songtime_text}
		destroyscreenelement \{id = debug_songtime_text}
	endif
	if ($debug_showsongtime = off)
		change \{debug_showsongtime = on}
		createscreenelement \{type = textelement
			parent = root_window
			id = debug_songtime_text
			font = debug
			text = qs(0xecafd78a)
			scale = 1
			pos = (850.0, 350.0)
			rgba = [
				255
				187
				0
				255
			]
			just = [
				left
				top
			]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [
				0
				0
				0
				255
			]
			hide
			z_priority = 1000}
		if ($playing_song = 1)
			debug_songtime_text :se_setprops \{unhide}
		endif
	else
		change \{debug_showsongtime = off}
	endif
	toggle_showsongtime_setprop
endscript

script toggle_showsongtime_setprop 
	if NOT screenelementexists \{id = toggle_showsongtime_menuitem}
		return
	endif
	if ($debug_showsongtime = off)
		toggle_showsongtime_menuitem :se_setprops \{text = qs(0x43d0e22f)}
	else
		toggle_showsongtime_menuitem :se_setprops \{text = qs(0xa548eb18)}
	endif
endscript
debug_showcameraname = off

script toggle_showcameraname 
	ui_menu_select_sfx
	if screenelementexists \{id = debug_camera_name_text}
		destroyscreenelement \{id = debug_camera_name_text}
	endif
	if screenelementexists \{id = debug_camera_name_text2}
		destroyscreenelement \{id = debug_camera_name_text2}
	endif
	if ($debug_showcameraname = off)
		change \{debug_showcameraname = on}
		cameracuts_updatedebugcameraname
	else
		change \{debug_showcameraname = off}
	endif
	toggle_showcameraname_setprop
endscript

script toggle_inputlog 
	ui_menu_select_sfx
	kill_debug_elements
	if ($show_play_log = 0)
		change \{show_play_log = 1}
	else
		change \{show_play_log = 0}
	endif
	toggle_inputlog_setprop
	init_play_log
endscript

script toggle_rockmeterdebug 
	ui_menu_select_sfx
	kill_debug_elements
	if ($rock_meter_debug = 0)
		change \{rock_meter_debug = 1}
	else
		change \{rock_meter_debug = 0}
	endif
	toggle_rockmeterdebug_setprop
endscript

script toggle_botp1 
	toggle_bot \{player = 1}
endscript

script toggle_botp2 
	toggle_bot \{player = 2}
endscript

script toggle_botp3 
	toggle_bot \{player = 3}
endscript

script toggle_botp4 
	toggle_bot \{player = 4}
endscript

script toggle_lagtestpart1 
	ui_menu_select_sfx
	kill_debug_elements
	if ($lagtestpart1 = 0)
		change \{lagtestpart1 = 1}
		change \{debug_audible_hitnote = 1}
	else
		change \{lagtestpart1 = 0}
		change \{debug_audible_hitnote = 0}
	endif
	toggle_lagtestpart1_setprop
endscript

script toggle_lagtestpart2 
	ui_menu_select_sfx
	kill_debug_elements
	if ($lagtestpart2 = 0)
		change \{lagtestpart2 = 1}
		change \{show_play_log = 1}
	else
		change \{lagtestpart2 = 0}
		change \{show_play_log = 0}
	endif
	toggle_lagtestpart2_setprop
endscript

script toggle_lagtestpart3 
	ui_menu_select_sfx
	kill_debug_elements
	if ($lagtestpart3 = 0)
		change \{lagtestpart3 = 1}
		change \{debug_audible_open = 1}
	else
		change \{lagtestpart3 = 0}
		change \{debug_audible_open = 0}
	endif
	toggle_lagtestpart3_setprop
endscript

script edit_inputlagvalue_left 
	ui_menu_select_sfx
	kill_debug_elements
	getplatform
	switch <platform>
		case ps2
		ps2_props = ($default_lag_settings.ps2)
		ps2_props = {<ps2_props> input_lag_ms = (<ps2_props>.input_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) ps2 = <ps2_props>}
		case ps3
		ps3_props = ($default_lag_settings.ps3)
		ps3_props = {<ps3_props> input_lag_ms = (<ps3_props>.input_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) ps3 = <ps3_props>}
		case xenon
		xenon_props = ($default_lag_settings.xenon)
		xenon_props = {<xenon_props> input_lag_ms = (<xenon_props>.input_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> input_lag_ms = (<wii_props>.input_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default

	endswitch
	edit_inputlagvalue_setprop
endscript

script edit_inputlagvalue_right 
	ui_menu_select_sfx
	kill_debug_elements
	getplatform
	switch <platform>
		case ps2
		ps2_props = ($default_lag_settings.ps2)
		ps2_props = {<ps2_props> input_lag_ms = (<ps2_props>.input_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) ps2 = <ps2_props>}
		case ps3
		ps3_props = ($default_lag_settings.ps3)
		ps3_props = {<ps3_props> input_lag_ms = (<ps3_props>.input_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) ps3 = <ps3_props>}
		case xenon
		xenon_props = ($default_lag_settings.xenon)
		xenon_props = {<xenon_props> input_lag_ms = (<xenon_props>.input_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> input_lag_ms = (<wii_props>.input_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default

	endswitch
	edit_inputlagvalue_setprop
endscript

script edit_gemlagvalue_left 
	ui_menu_select_sfx
	kill_debug_elements
	getplatform
	switch <platform>
		case ps2
		ps2_props = ($default_lag_settings.ps2)
		ps2_props = {<ps2_props> gem_lag_ms = (<ps2_props>.gem_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) ps2 = <ps2_props>}
		case ps3
		ps3_props = ($default_lag_settings.ps3)
		ps3_props = {<ps3_props> gem_lag_ms = (<ps3_props>.gem_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) ps3 = <ps3_props>}
		case xenon
		xenon_props = ($default_lag_settings.xenon)
		xenon_props = {<xenon_props> gem_lag_ms = (<xenon_props>.gem_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> gem_lag_ms = (<wii_props>.gem_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default

	endswitch
	edit_gemlagvalue_setprop
endscript

script edit_gemlagvalue_right 
	ui_menu_select_sfx
	kill_debug_elements
	getplatform
	switch <platform>
		case ps2
		ps2_props = ($default_lag_settings.ps2)
		ps2_props = {<ps2_props> gem_lag_ms = (<ps2_props>.gem_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) ps2 = <ps2_props>}
		case ps3
		ps3_props = ($default_lag_settings.ps3)
		ps3_props = {<ps3_props> gem_lag_ms = (<ps3_props>.gem_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) ps3 = <ps3_props>}
		case xenon
		xenon_props = ($default_lag_settings.xenon)
		xenon_props = {<xenon_props> gem_lag_ms = (<xenon_props>.gem_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> gem_lag_ms = (<wii_props>.gem_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default

	endswitch
	edit_gemlagvalue_setprop
endscript

script edit_audiolagvalue_left 

	ui_menu_select_sfx
	kill_debug_elements
	getplatform
	switch <platform>
		case ps2
		ps2_props = ($default_lag_settings.ps2)
		ps2_props = {<ps2_props> audio_lag_ms = (<ps2_props>.audio_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) ps2 = <ps2_props>}
		case ps3
		ps3_props = ($default_lag_settings.ps3)
		ps3_props = {<ps3_props> audio_lag_ms = (<ps3_props>.audio_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) ps3 = <ps3_props>}
		case xenon
		xenon_props = ($default_lag_settings.xenon)
		xenon_props = {<xenon_props> audio_lag_ms = (<xenon_props>.audio_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> audio_lag_ms = (<wii_props>.audio_lag_ms - 1)}
		change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default

	endswitch
	edit_audiolagvalue_setprop
endscript

script edit_audiolagvalue_right 

	ui_menu_select_sfx
	kill_debug_elements
	getplatform
	switch <platform>
		case ps2
		ps2_props = ($default_lag_settings.ps2)
		ps2_props = {<ps2_props> audio_lag_ms = (<ps2_props>.audio_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) ps2 = <ps2_props>}
		case ps3
		ps3_props = ($default_lag_settings.ps3)
		ps3_props = {<ps3_props> audio_lag_ms = (<ps3_props>.audio_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) ps3 = <ps3_props>}
		case xenon
		xenon_props = ($default_lag_settings.xenon)
		xenon_props = {<xenon_props> audio_lag_ms = (<xenon_props>.audio_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> audio_lag_ms = (<wii_props>.audio_lag_ms + 1)}
		change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default

	endswitch
	edit_audiolagvalue_setprop
endscript

script toggle_bot \{player = 1}
	ui_menu_select_sfx
	kill_debug_elements
	<player_status> = ($0x2994109a [<player>])
	change structurename = <player_status> bot_play = (1 - ($<player_status>.bot_play))
	toggle_bot_setprop player = <player>
endscript

script toggle_double_kick \{player = 1}
	ui_menu_select_sfx
	kill_debug_elements
	<player_status> = ($0x2994109a [<player>])
	change structurename = <player_status> double_kick_drum = (1 - ($<player_status>.double_kick_drum))
	toggle_double_kick_setprop player = <player>
endscript

script toggle_star \{player = 1}
	ui_menu_select_sfx
	kill_debug_elements
	<player_status> = ($0x2994109a [<player>])
	<new_value> = (($<player_status>.star_power_debug_mode) + 1)
	if (<new_value> > 3)
		<new_value> = 0
	endif
	if (<new_value> < 0)
		<new_value> = 3
	endif
	change structurename = <player_status> star_power_debug_mode = <new_value>
	toggle_star_setprop player = <player>
endscript

script edit_inputlog_lines_left 
	ui_menu_select_sfx
	kill_debug_elements
	change play_log_lines = ($play_log_lines -1)
	if ($play_log_lines < 1)
		change \{play_log_lines = 1}
	endif
	edit_inputlog_lines_setprop
	init_play_log
endscript

script edit_inputlog_lines_right 
	ui_menu_select_sfx
	kill_debug_elements
	change play_log_lines = ($play_log_lines + 1)
	if ($play_log_lines > 10)
		change \{play_log_lines = 10}
	endif
	edit_inputlog_lines_setprop
	init_play_log
endscript

script toggle_tilt 
	ui_menu_select_sfx
	kill_debug_elements
	if ($show_guitar_tilt = 0)
		change \{show_guitar_tilt = 1}
	else
		change \{show_guitar_tilt = 0}
	endif
	toggle_tilt_setprop
	init_play_log
endscript

script toggle_showcameraname_setprop 
	if ($debug_showcameraname = off)
		toggle_showcameraname_menuitem :se_setprops \{text = qs(0xd0f8552a)}
	else
		toggle_showcameraname_menuitem :se_setprops \{text = qs(0x5924d32c)}
	endif
endscript

script toggle_inputlog_setprop 
	if ($show_play_log = 0)
		toggle_inputlog_menuitem :se_setprops \{text = qs(0x758e9198)}
	else
		toggle_inputlog_menuitem :se_setprops \{text = qs(0xf41243e2)}
	endif
endscript

script toggle_rockmeterdebug_setprop 
	if ($rock_meter_debug = 0)
		toggle_rockmeterdebug_menuitem :se_setprops \{text = qs(0xf6cab54f)}
	else
		toggle_rockmeterdebug_menuitem :se_setprops \{text = qs(0x87dbdce9)}
	endif
endscript

script toggle_botp1_setprop 
	toggle_bot_setprop \{player = 1}
endscript

script toggle_botp2_setprop 
	toggle_bot_setprop \{player = 2}
endscript

script toggle_botp3_setprop 
	toggle_bot_setprop \{player = 3}
endscript

script toggle_botp4_setprop 
	toggle_bot_setprop \{player = 4}
endscript

script toggle_viewvolumesonscreen_setprop 
	if ($viewvolumesonscreen = 0)
		toggle_viewvolumesonscreen_menuitem :se_setprops \{text = qs(0xc341e7e7)}
	else
		toggle_viewvolumesonscreen_menuitem :se_setprops \{text = qs(0x13fe2f0e)}
	endif
endscript

script toggle_lagtestpart1_setprop 
	if ($lagtestpart1 = 0)
		toggle_lagtestpart1_menuitem :se_setprops \{text = qs(0x9b3748ba)}
	else
		toggle_lagtestpart1_menuitem :se_setprops \{text = qs(0xf1407a9c)}
	endif
endscript

script toggle_lagtestpart2_setprop 
	if ($lagtestpart2 = 0)
		toggle_lagtestpart2_menuitem :se_setprops \{text = qs(0xe7566d61)}
	else
		toggle_lagtestpart2_menuitem :se_setprops \{text = qs(0x86dea86c)}
	endif
endscript

script toggle_lagtestpart3_setprop 
	if ($lagtestpart3 = 0)
		toggle_lagtestpart3_menuitem :se_setprops \{text = qs(0x7a598c17)}
	else
		toggle_lagtestpart3_menuitem :se_setprops \{text = qs(0x1d7be403)}
	endif
endscript

script edit_inputlagvalue_setprop 
	getplatform
	switch <platform>
		case ps2
		formattext textname = text qs(0x519b5d83) l = ($default_lag_settings.ps2.input_lag_ms)
		edit_inputlagvalue_menuitem :se_setprops text = <text>
		case ps3
		formattext textname = text qs(0x503ef435) l = ($default_lag_settings.ps3.input_lag_ms)
		edit_inputlagvalue_menuitem :se_setprops text = <text>
		case xenon
		formattext textname = text qs(0x6bb70bb2) l = ($default_lag_settings.xenon.input_lag_ms)
		edit_inputlagvalue_menuitem :se_setprops text = <text>
		case wii
		formattext textname = text qs(0xd3aec0f4) l = ($default_lag_settings.wii.input_lag_ms)
		edit_inputlagvalue_menuitem :se_setprops text = <text>
		default

	endswitch
endscript

script edit_gemlagvalue_setprop 
	getplatform
	switch <platform>
		case ps2
		formattext textname = text qs(0x97202262) l = ($default_lag_settings.ps2.gem_lag_ms)
		edit_gemlagvalue_menuitem :se_setprops text = <text>
		case ps3
		formattext textname = text qs(0x1aa8df80) l = ($default_lag_settings.ps3.gem_lag_ms)
		edit_gemlagvalue_menuitem :se_setprops text = <text>
		case xenon
		formattext textname = text qs(0x353caad1) l = ($default_lag_settings.xenon.gem_lag_ms)
		edit_gemlagvalue_menuitem :se_setprops text = <text>
		case wii
		formattext textname = text qs(0x8bdedff2) l = ($default_lag_settings.wii.gem_lag_ms)
		edit_gemlagvalue_menuitem :se_setprops text = <text>
		default

	endswitch
endscript

script edit_audiolagvalue_setprop 

	getplatform
	switch <platform>
		case ps2
		formattext textname = text qs(0xf30d4cd4) l = ($default_lag_settings.ps2.audio_lag_ms)
		edit_audiolagvalue_menuitem :se_setprops text = <text>
		case ps3
		formattext textname = text qs(0x5234c83a) l = ($default_lag_settings.ps3.audio_lag_ms)
		edit_audiolagvalue_menuitem :se_setprops text = <text>
		case xenon
		formattext textname = text qs(0xcd437801) l = ($default_lag_settings.xenon.audio_lag_ms)
		edit_audiolagvalue_menuitem :se_setprops text = <text>
		case wii
		formattext textname = text qs(0x6d6fdd8f) l = ($default_lag_settings.wii.audio_lag_ms)
		edit_audiolagvalue_menuitem :se_setprops text = <text>
		default

	endswitch
endscript

script toggle_bot_setprop \{player = 1}
	<player_status> = ($0x2994109a [<player>])
	formattext textname = toggletext_off qs(0x4ced8e4f) d = <player>
	formattext textname = toggletext_on qs(0xe889757d) d = <player>
	formattext checksumname = togglebot 'toggle_botp%d_menuitem' d = <player>
	if (($<player_status>.bot_play) = 0)
		<togglebot> :se_setprops text = <toggletext_off>
	else
		<togglebot> :se_setprops text = <toggletext_on>
	endif
endscript

script toggle_double_kick_setprop \{player = 1}
	<player_status> = ($0x2994109a [<player>])
	formattext textname = toggletext_off qs(0xa62aa90f) d = <player>
	formattext textname = toggletext_on qs(0x3f19a124) d = <player>
	formattext checksumname = togglekick 'toggle_kickp%d_menuitem' d = <player>
	if (($<player_status>.double_kick_drum) = 0)
		<togglekick> :se_setprops text = <toggletext_off>
	else
		<togglekick> :se_setprops text = <toggletext_on>
	endif
endscript

script toggle_star_setprop \{player = 1}
	<player_status> = ($0x2994109a [<player>])
	formattext checksumname = togglestar 'toggle_starp%d_menuitem' d = <player>
	switch ($<player_status>.star_power_debug_mode)
		case 0
		formattext textname = toggletext qs(0x77b03841) d = <player>
		case 1
		formattext textname = toggletext qs(0x319bbd50) d = <player>
		case 2
		formattext textname = toggletext qs(0x61b3e268) d = <player>
		case 3
		formattext textname = toggletext qs(0x6b7bdf66) d = <player>
		default
		formattext textname = toggletext qs(0xa1ee93b5) d = <player>
	endswitch
	<togglestar> :se_setprops text = <toggletext>
endscript

script toggle_hyperspeed_setprop \{player = 1}
	<player_status> = ($0x2994109a [<player>])
	formattext checksumname = togglehyperspeed 'toggle_hyperspeedp%d_menuitem' d = <player>
	formattext textname = toggletext qs(0x81671d3d) p = <player> d = ($<player_status>.hyperspeed)
	<togglehyperspeed> :se_setprops text = <toggletext>
endscript

script edit_inputlog_lines_setprop 
	formattext textname = text qs(0x45c3b812) l = ($play_log_lines)
	edit_inputlog_lines_menuitem :se_setprops text = <text>
endscript

script toggle_tilt_setprop 
	if ($show_guitar_tilt = 0)
		toggle_tilt_menuitem :se_setprops \{text = qs(0x86f42ef4)}
	else
		toggle_tilt_menuitem :se_setprops \{text = qs(0x36b8f01f)}
	endif
endscript

script toggle_leftyflip 
	ui_menu_select_sfx
	getglobaltags \{user_options}
	if (<lefty_flip_p1> = 0)
		setglobaltags \{user_options
			params = {
				lefty_flip_p1 = 1
			}}
	else
		setglobaltags \{user_options
			params = {
				lefty_flip_p1 = 0
			}}
	endif
	getglobaltags \{user_options}
	change structurename = <player_status> lefthanded_gems = <lefty_flip_p1>
	change structurename = <player_status> lefthanded_button_ups = <lefty_flip_p1>
	toggle_leftyflip_setprop
endscript

script toggle_leftyflip_setprop 
	getglobaltags \{user_options}
	if (<lefty_flip_p1> = 0)
		toggle_leftyflip_menuitem :se_setprops \{text = qs(0xc0ad14be)}
	else
		toggle_leftyflip_menuitem :se_setprops \{text = qs(0x0774b6f0)}
	endif
endscript
debug_forcescore = off
debug_forcescore_dir = up

script toggle_forcescore 
	ui_menu_select_sfx
	switch $debug_forcescore
		case off
		change \{debug_forcescore = poor}
		case poor
		change \{debug_forcescore = medium}
		case medium
		change \{debug_forcescore = good}
		case good
		change \{debug_forcescore = off}
		default
		change \{debug_forcescore = off}
	endswitch
	crowdincrease \{player_status = player1_status}
	toggle_forcescore_setprop
endscript

script toggle_forcescore_setprop 
	switch $debug_forcescore
		case off
		toggle_forcescore_menuitem :se_setprops \{text = qs(0xa66d654f)}
		case poor
		toggle_forcescore_menuitem :se_setprops \{text = qs(0xa8ac46c1)}
		case medium
		toggle_forcescore_menuitem :se_setprops \{text = qs(0x5d0577bf)}
		case good
		toggle_forcescore_menuitem :se_setprops \{text = qs(0xc24acb24)}
		default
		toggle_forcescore_menuitem :se_setprops \{text = qs(0xa66d654f)}
	endswitch
endscript

script toggle_vocalsfreeform 
	ui_menu_select_sfx
	if ($vocal_enable_freeform_always = 1)
		change \{vocal_enable_freeform_always = 0}
	else
		change \{vocal_enable_freeform_always = 1}
	endif
	toggle_vocalsfreeform_setprop
endscript

script toggle_vocalsfreeform_setprop 
	if ($vocal_enable_freeform_always = 1)
		toggle_vocalsfreeform_menuitem :se_setprops \{text = qs(0x125927d8)}
	else
		toggle_vocalsfreeform_menuitem :se_setprops \{text = qs(0x1af80ceb)}
	endif
endscript

script toggle_allowcontroller 
	if ($allow_controller_for_all_instruments = 1)
		change \{allow_controller_for_all_instruments = 0}
	else
		change \{allow_controller_for_all_instruments = 1}
	endif
	toggle_allowcontroller_setprop
endscript

script toggle_allowcontroller_setprop 
	if ($allow_controller_for_all_instruments = 1)
		toggle_allowcontroller_menuitem :se_setprops \{text = qs(0x5de37df9)}
	else
		toggle_allowcontroller_menuitem :se_setprops \{text = qs(0x1dd9ee58)}
	endif
endscript

script create_changevenue_menu 
	ui_menu_select_sfx
	destroy_settings_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = changevenue_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos + (70.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = changevenue_scrolling_menu
		id = changevenue_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = back_to_settings_menu
				}
			}
		]}
	get_levelzonearray_size
	array_count = 0
	begin
	get_levelzonearray_checksum index = <array_count>
	createscreenelement {
		type = textelement
		parent = changevenue_vmenu
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = ($levelzones.<level_checksum>.title)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose select_venue params = {level = <level_checksum> norestart}}
		]
	}
	<array_count> = (<array_count> + 1)
	repeat <array_size>
	launchevent \{type = focus
		target = changevenue_vmenu}
endscript

script back_to_changevenue_menu 
	create_changevenue_menu
endscript

script destroy_changevenue_menu 
	if screenelementexists \{id = changevenue_scrolling_menu}
		destroyscreenelement \{id = changevenue_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script select_venue 
	ui_menu_select_sfx
	kill_gem_scroller
	if gotparam \{level}
		change current_level = <level>
	endif
	setpakmancurrentblock \{map = zones
		pak = none
		block_scripts = 1}
	changenodeflag \{ls_3_5_pre
		1}
	changenodeflag \{ls_3_5_post
		0}
	changenodeflag \{ls_encore_pre
		1}
	changenodeflag \{ls_encore_post
		0}
	changenodeflag \{ls_encore_post2
		0}
	mempushcontext \{heap_zones}
	createpakmanmap \{map = zones
		links = ghzones
		folder = 'zones/'
		uselinkslots}
	mempopcontext
	load_venue \{block_scripts = 1}
	setup_bg_viewport
	restore_dummy_bg_camera
	disable_bg_viewport_properties
	create_movie_viewport
	enable_pause
	if gotparam \{norestart}
		gh_start_pressed
		restart_gem_scroller song_name = ($current_song) difficulty = ($player1_status.difficulty) difficulty2 = ($player2_status.difficulty) starttime = ($current_starttime) device_num = <device_num>
	else
		toggleviewmode \{viewerreload}
		toggleviewmode \{viewerreload}
	endif
	destroy_changevenue_menu
	generic_event_choose \{state = uistate_gameplay}
endscript

script testlevel_debug 
	begin
	if controllermake \{circle
			0}
		next_peds
	endif
	if controllermake \{circle
			1}
		next_peds
	endif
	waitonegameframe
	repeat
endscript
debug_ped_row = 0

script next_peds 
	kill \{prefix = z_testlevel_peds_row0}
	kill \{prefix = z_testlevel_peds_row1}
	kill \{prefix = z_testlevel_peds_row2}
	kill \{prefix = z_testlevel_peds_row3}
	kill \{prefix = z_testlevel_peds_row4}
	kill \{prefix = z_testlevel_peds_row5}
	kill \{prefix = z_testlevel_peds_row6}
	kill \{prefix = z_testlevel_peds_row7}
	waitonegameframe
	begin
	change debug_ped_row = ($debug_ped_row + 1)
	formattext checksumname = row 'Z_TestLevel_Peds_row%r' r = ($debug_ped_row)
	create prefix = <row>
	if isalive prefix = <row>
		break
	else
		change \{debug_ped_row = -1}
	endif
	repeat
endscript

script destroy_changehighway_menu 
	if screenelementexists \{id = changehighway_scrolling_menu}
		destroyscreenelement \{id = changehighway_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_changeguitar_menu \{type = guitar}
	ui_menu_select_sfx
	destroy_settings_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = changeguitar_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos + (70.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = changeguitar_scrolling_menu
		id = changeguitar_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = back_to_settings_menu
				}
			}
		]}
	get_musician_instrument_size
	array_count = 0
	begin
	get_musician_instrument_struct index = <array_count>
	if (<type> = (<info_struct>.type))

		createscreenelement {
			type = textelement
			parent = changeguitar_vmenu
			font = debug
			scale = 0.75
			rgba = [210 210 210 250]
			text = (<info_struct>.name)
			just = [left top]
			z_priority = 100.0
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose select_guitar params = {guitar = <array_count> type = <type>}}
			]
		}
	endif
	<array_count> = (<array_count> + 1)
	repeat <array_size>
	launchevent \{type = focus
		target = changeguitar_vmenu}
endscript

script back_to_changeguitar_menu 
	create_changeguitar_menu
endscript

script destroy_changeguitar_menu 
	if screenelementexists \{id = changeguitar_scrolling_menu}
		destroyscreenelement \{id = changeguitar_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script select_guitar \{type = guitar}
	ui_menu_select_sfx
	kill_gem_scroller
	select_start_song
endscript
hidebytype_list = [
	'guitarist'
	'bassist'
	'vocalist'
	'drummer'
]

script create_togglevisibility_menu 
	ui_menu_select_sfx
	destroy_settings_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	createscreenelement {
		type = vscrollingmenu
		parent = pause_menu
		id = togglevisibility_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		pos = ($menu_pos + (70.0, 0.0))
	}
	createscreenelement \{type = vmenu
		parent = togglevisibility_scrolling_menu
		id = togglevisibility_vmenu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
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
				generic_menu_pad_back
				params = {
					callback = back_to_settings_menu
				}
			}
		]}
	getarraysize \{$hidebytype_list}
	array_count = 0
	begin
	formattext checksumname = type_checksum '%s' s = ($hidebytype_list [<array_count>])
	formattext checksumname = menuitem_checksum 'toggle_hidebytype_menuitem_%s' s = ($hidebytype_list [<array_count>])
	createscreenelement {
		type = textelement
		parent = togglevisibility_vmenu
		id = <menuitem_checksum>
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x00000000)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose toggle_hidebytype params = {type = type_checksum array_count = <array_count>}}
		]
	}
	array_count = (<array_count> + 1)
	repeat <array_size>
	toggle_hidebytype_setprop
	createscreenelement \{type = textelement
		parent = togglevisibility_vmenu
		id = toggle_highway_menuitem
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xc36d1281)
		z_priority = 100.0
		just = [
			left
			top
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_highway
			}
		]}
	toggle_highway_setprop
	createscreenelement \{type = textelement
		parent = togglevisibility_vmenu
		font = debug
		scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x398f3ab9)
		z_priority = 100.0
		just = [
			left
			top
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				hideobjectbytype
				params = {
					type = crowd
				}
			}
		]}
	launchevent \{type = focus
		target = togglevisibility_vmenu}
endscript

script back_to_togglevisibility_menu 
	create_togglevisibility_menu
endscript

script destroy_togglevisibility_menu 
	if screenelementexists \{id = togglevisibility_scrolling_menu}
		destroyscreenelement \{id = togglevisibility_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript
highwayvisible = on

script toggle_highway 
	ui_menu_select_sfx
	if ($highwayvisible = off)
		if screenelementexists \{id = gem_containerp1}
			legacydoscreenelementmorph \{id = gem_containerp1
				alpha = 1}
		endif
		if screenelementexists \{id = gem_containerp2}
			legacydoscreenelementmorph \{id = gem_containerp2
				alpha = 1}
		endif
		if screenelementexists \{id = gem_containerp3}
			legacydoscreenelementmorph \{id = gem_containerp3
				alpha = 1}
		endif
		if screenelementexists \{id = gem_containerp4}
			legacydoscreenelementmorph \{id = gem_containerp4
				alpha = 1}
		endif
		if screenelementexists \{id = vocals_highway_p1}
			legacydoscreenelementmorph \{id = vocals_highway_p1
				alpha = 1}
		endif
		if screenelementexists \{id = vocals_highway_p2}
			legacydoscreenelementmorph \{id = vocals_highway_p2
				alpha = 1}
		endif
		enable_highway_prepass
		change \{highwayvisible = on}
		show_hud
	else
		if screenelementexists \{id = gem_containerp1}
			legacydoscreenelementmorph \{id = gem_containerp1
				alpha = 0}
		endif
		if screenelementexists \{id = gem_containerp2}
			legacydoscreenelementmorph \{id = gem_containerp2
				alpha = 0}
		endif
		if screenelementexists \{id = gem_containerp3}
			legacydoscreenelementmorph \{id = gem_containerp3
				alpha = 0}
		endif
		if screenelementexists \{id = gem_containerp4}
			legacydoscreenelementmorph \{id = gem_containerp4
				alpha = 0}
		endif
		if screenelementexists \{id = vocals_highway_p1}
			legacydoscreenelementmorph \{id = vocals_highway_p1
				alpha = 0}
		endif
		if screenelementexists \{id = vocals_highway_p2}
			legacydoscreenelementmorph \{id = vocals_highway_p2
				alpha = 0}
		endif
		disable_highway_prepass
		change \{highwayvisible = off}
		hide_hud
	endif
	toggle_highway_setprop
endscript

script toggle_highway_setprop 
	if screenelementexists \{id = toggle_highway_menuitem}
		if ($highwayvisible = off)
			toggle_highway_menuitem :se_setprops \{text = qs(0xe2759ce6)}
		else
			toggle_highway_menuitem :se_setprops \{text = qs(0xf92dd09b)}
		endif
	endif
endscript
bandvisible = on

script toggle_bandvisible 
	ui_menu_select_sfx
	if ($bandvisible = off)
		change \{bandvisible = on}
	else
		change \{bandvisible = off}
	endif
	set_bandvisible
	toggle_bandvisible_setprop
endscript

script set_bandvisible 
	if ($bandvisible = off)
		if compositeobjectexists \{guitarist}
			guitarist :hide
		endif
		if compositeobjectexists \{vocalist}
			vocalist :hide
		endif
		if compositeobjectexists \{bassist}
			bassist :hide
		endif
		if compositeobjectexists \{rhythm}
			rhythm :hide
		endif
		if compositeobjectexists \{drummer}
			drummer :hide
		endif
	else
		if compositeobjectexists \{guitarist}
			guitarist :unhide
		endif
		if compositeobjectexists \{vocalist}
			vocalist :unhide
		endif
		if compositeobjectexists \{bassist}
			bassist :unhide
		endif
		if compositeobjectexists \{rhythm}
			rhythm :unhide
		endif
		if compositeobjectexists \{drummer}
			drummer :unhide
		endif
	endif
endscript

script toggle_bandvisible_setprop 
	if ($bandvisible = off)
		toggle_bandvisible_menuitem :se_setprops \{text = qs(0x7fd280d2)}
	else
		toggle_bandvisible_menuitem :se_setprops \{text = qs(0xf815c959)}
	endif
endscript

script toggle_hidebytype 
	ui_menu_select_sfx
	formattext checksumname = objname ($hidebytype_list [<array_count>])
	if compositeobjectexists <objname>
		if <objname> :ishidden
			<objname> :unhide
			bandmanager_showstrings name = <objname>
		else
			<objname> :hide
			bandmanager_hidestrings name = <objname>
		endif
	endif
	toggle_hidebytype_setprop
endscript

script toggle_hidebytype_setprop 
	getarraysize \{$hidebytype_list}
	array_count = 0
	begin
	formattext checksumname = objname ($hidebytype_list [<array_count>])
	if compositeobjectexists <objname>
		if <objname> :ishidden
			formattext textname = menutext qs(0x792a4ad8) s = ($hidebytype_list [<array_count>])
		else
			formattext textname = menutext qs(0x8383d8bb) s = ($hidebytype_list [<array_count>])
		endif
	else
		formattext textname = menutext qs(0x93590b29) s = ($hidebytype_list [<array_count>])
	endif
	formattext checksumname = menuitem_checksum 'toggle_hidebytype_menuitem_%s' s = ($hidebytype_list [<array_count>])
	<menuitem_checksum> :se_setprops text = <menutext>
	array_count = (<array_count> + 1)
	repeat <array_size>
endscript

script select_start_song 
	if gotparam \{forceintro}
		change \{current_transition = forceintro}
	endif
	if gotparam \{song_name}
		change current_song = <song_name>
	endif
	if gotparam \{starttime}
		change current_starttime = <starttime>
	endif
	if gotparam \{from_gameplay}
		restart_warning_select_restart \{dont_save_song_data}
	else
		change \{quickplay_song_list_current = 0}
		generic_event_choose data = {state = uistate_play_song starttime = <starttime> uselaststarttime = <uselaststarttime>}
	endif
	vocals_distribute_mics
	destroy_all_debug_menus
endscript

script start_song_with_intro 
	skipcareerintros
	change \{game_mode = gh4_p1_career}
	if ($selected_intro = -1)

		select_start_song uselaststarttime from_gameplay = <from_gameplay>
		return
	endif
	song_name = ($celeb_intro_transitions [$selected_intro].song)
	venue = ($celeb_intro_transitions [$selected_intro].debug_preview_in_venue)
	intro = ($celeb_intro_transitions [$selected_intro].intro)


	formattext checksumname = transition '%s' s = <intro>
	change current_transition = <transition>
	change current_song = <song_name>
	change current_level = <venue>
	change \{current_starttime = 0}
	select_venue level = <venue>
endscript
selected_intro = 0

script toggle_intro_select_left 
	change selected_intro = ($selected_intro - 1)
	if ($selected_intro < 0)
		getarraysize \{$celeb_intro_transitions}
		change selected_intro = (<array_size> - 1)
	endif
	toggle_intro_select_setprop
endscript

script toggle_intro_select_right 
	change selected_intro = ($selected_intro + 1)
	getarraysize \{$celeb_intro_transitions}
	if ($selected_intro >= <array_size>)
		change \{selected_intro = 0}
	endif
	toggle_intro_select_setprop
endscript

script toggle_intro_select_setprop 
	if ($selected_intro = -1)
		toggle_intro_select :se_setprops \{text = qs(0x04a9d108)}
		return
	endif
	intro_name = ($celeb_intro_transitions [$selected_intro].intro)

	formattext textname = select_string qs(0xf2a04fcf) a = <intro_name>
	toggle_intro_select :se_setprops text = <select_string>
endscript

script ui_menu_scroll_sfx 
	soundevent \{event = ui_sfx_scroll_down}
endscript

script ui_menu_select_sfx 
	soundevent \{0x5ea1b4e0}
endscript

script menu_focus 
	obj_getid
	<id> = <objid>

	setscreenelementprops id = <id> rgba = [210 130 0 250]
endscript

script menu_unfocus 
	obj_getid
	<id> = <objid>
	setscreenelementprops id = <id> rgba = [210 210 210 250]
endscript
debug_menu_mode = 1

script back_to_retail_menu 
	generic_event_back
endscript

script toggle_global 

	if gotparam \{global_toggle}
		if ($<global_toggle> = 1)
			change globalname = <global_toggle> newvalue = 0
		else
			change globalname = <global_toggle> newvalue = 1
		endif
	endif
endscript

script debug_checkcasassets 
	verify_cas_budgets \{textures
		profiles}
endscript

script debug_dumpheaps 
	finalbuildmemreport
endscript
toggled_fps_on = 0
framerate_warning = 57.5

script togglefps 
	if ($toggled_fps_on = 1)
		change \{toggled_fps_on = 0}
		killspawnedscript \{name = refreshfpsdisplay}
		wait \{0.2
			seconds}
		if objectexists \{id = fps_anchor}
			destroyscreenelement \{id = fps_anchor}
		endif
	else
		change \{toggled_fps_on = 1}
		setscreenelementlock \{id = root_window
			off}
		if objectexists \{id = fps_anchor}
			destroyscreenelement \{id = fps_anchor}
		endif
		createscreenelement \{type = containerelement
			parent = root_window
			id = fps_anchor
			pos = (30.0, 140.0)
			just = [
				center
				center
			]
			internal_just = [
				left
				center
			]}
		createscreenelement \{type = textelement
			parent = fps_anchor
			id = fps_text
			pos = (20.0, -15.0)
			text = qs(0x5059e4e6)
			font = debug
			rgba = [
				120
				120
				200
				200
			]
			just = [
				left
				center
			]
			scale = 0.75
			z_priority = 100}
		createscreenelement \{type = spriteelement
			parent = fps_anchor
			pos = (16.0, -34.0)
			texture = white2
			rgba = [
				10
				10
				10
				180
			]
			just = [
				left
				top
			]
			scale = (2.55, 0.6)
			z_priority = 99}
		setscreenelementlock \{id = root_window
			on}
		spawnscriptlater \{refreshfpsdisplay}
	endif
endscript

script debug_menu_rockstarcreator 
	change \{autolaunch_cas_artist = 0}
	change \{objviewer_light_test = 0}
	main_menu_select_cas device_num = <device_num>
endscript

script debug_menu_rockstarcreatorobjviewer 
	change \{autolaunch_cas_artist = 1}
	change \{objviewer_light_test = 1}
	main_menu_select_cas device_num = <device_num>
endscript
fps_display_hold_red = 0

script refreshfpsdisplay \{interval = 0.1}
	begin
	if objectexists \{id = fps_anchor}
		formattext textname = fps qs(0xcb9020de) d = ($framerate_value)
		setscreenelementprops id = fps_text text = <fps>
		if (($framerate_value) < $framerate_warning)
			change \{fps_display_hold_red = 60}
			setscreenelementprops \{id = fps_text
				rgba = [
					160
					20
					20
					255
				]}
		elseif ($fps_display_hold_red > 0)
			setscreenelementprops \{id = fps_text
				rgba = [
					160
					20
					20
					255
				]}
			change fps_display_hold_red = ($fps_display_hold_red - 1)
		else
			setscreenelementprops \{id = fps_text
				rgba = [
					100
					100
					100
					255
				]}
		endif
	else
		killspawnedscript \{id = refreshfpsdisplay}
		change \{toggled_fps_on = 0}
	endif
	wait \{1
		frame}
	repeat
endscript

script skipcareerintros 
	get_current_band_info
	getglobaltags <band_info>
	setglobaltags <band_info> params = {career_intro_guitar_complete = 1}
	setglobaltags <band_info> params = {career_intro_bass_complete = 1}
	setglobaltags <band_info> params = {career_intro_drum_complete = 1}
	setglobaltags <band_info> params = {career_intro_vocals_complete = 1}
	setglobaltags <band_info> params = {career_intro_band_complete = 1}
endscript

script debugcareerintros 
	get_current_band_info
	getglobaltags <band_info>
	setglobaltags <band_info> params = {career_intro_guitar_complete = 0}
	setglobaltags <band_info> params = {career_intro_bass_complete = 0}
	setglobaltags <band_info> params = {career_intro_drum_complete = 0}
	setglobaltags <band_info> params = {career_intro_vocals_complete = 0}
	setglobaltags <band_info> params = {career_intro_band_complete = 0}
	change \{game_mode = gh4_p1_career}
	setplayerinfo \{1
		part = guitar}
	setplayerinfo \{1
		difficulty = expert}
	change \{current_progression_flag = career_guitar}
	spawnscriptnow \{debugcareerintros_spawned}
endscript

script debugcareerintros_spawned 
	event = menu_change
	if ui_event_exists_in_stack \{name = 'gameplay'}
		ui_event_block \{event = menu_back
			data = {
				state = uistate_gameplay
			}}
		event = menu_replace
	endif
	generic_event_choose event = <event> state = uistate_play_song data = {progression_flag = ($current_progression_flag) gig_num = 1}
endscript

script select_debug_menu_loop 
	killspawnedscript \{name = setlist_quit_song_menu_input}
	spawnscriptnow \{setlist_quit_song_menu_input}
endscript
0x1fac9708 = none

script 0x5bcab44e 
	0x9d49def0 :setprops \{text = qs(0xdd18ba9c)}
	if ($0x1fac9708 = none)
		0x9d49def0 :setprops \{text = qs(0x164f9d15)}
	elseif ($0x1fac9708 = load_z_subway)
		0x9d49def0 :setprops \{text = qs(0x7ebd6119)}
	elseif ($0x1fac9708 = load_z_lhc)
		0x9d49def0 :setprops \{text = qs(0xe3f12cff)}
	elseif ($0x1fac9708 = load_z_freakshow)
		0x9d49def0 :setprops \{text = qs(0xe1caf0b7)}
	elseif ($0x1fac9708 = load_z_neworleans)
		0x9d49def0 :setprops \{text = qs(0x216bae93)}
	elseif ($0x1fac9708 = load_z_dublin)
		0x9d49def0 :setprops \{text = qs(0xaf1b3b4b)}
	elseif ($0x1fac9708 = load_z_dragrace)
		0x9d49def0 :setprops \{text = qs(0x80597bce)}
	elseif ($0x1fac9708 = load_z_carhenge)
		0x9d49def0 :setprops \{text = qs(0xe5b4e33d)}
	elseif ($0x1fac9708 = load_z_vegas)
		0x9d49def0 :setprops \{text = qs(0x6c6626fe)}
	elseif ($0x1fac9708 = load_z_nashville)
		0x9d49def0 :setprops \{text = qs(0xf456230c)}
	elseif ($0x1fac9708 = load_z_mexicocity)
		0x9d49def0 :setprops \{text = qs(0x6b1701de)}
	elseif ($0x1fac9708 = load_z_cairo)
		0x9d49def0 :setprops \{text = qs(0xb77aa6f4)}
	elseif ($0x1fac9708 = load_z_sanfrancisco)
		0x9d49def0 :setprops \{text = qs(0x4c40cb21)}
	elseif ($0x1fac9708 = load_z_norway)
		0x9d49def0 :setprops \{text = qs(0xa03dad01)}
	elseif ($0x1fac9708 = load_z_cube)
		0x9d49def0 :setprops \{text = qs(0x67a2890e)}
	else
		0x9d49def0 :setprops \{text = qs(0x0d6d5453)}
	endif
endscript

script 0xd0d754bc 
	if ($0x1fac9708 = none)
		change \{0x1fac9708 = load_z_subway}
	elseif ($0x1fac9708 = load_z_subway)
		change \{0x1fac9708 = load_z_lhc}
	elseif ($0x1fac9708 = load_z_lhc)
		change \{0x1fac9708 = load_z_freakshow}
	elseif ($0x1fac9708 = load_z_freakshow)
		change \{0x1fac9708 = load_z_neworleans}
	elseif ($0x1fac9708 = load_z_neworleans)
		change \{0x1fac9708 = load_z_dublin}
	elseif ($0x1fac9708 = load_z_dublin)
		change \{0x1fac9708 = load_z_dragrace}
	elseif ($0x1fac9708 = load_z_dragrace)
		change \{0x1fac9708 = load_z_carhenge}
	elseif ($0x1fac9708 = load_z_carhenge)
		change \{0x1fac9708 = load_z_vegas}
	elseif ($0x1fac9708 = load_z_vegas)
		change \{0x1fac9708 = load_z_nashville}
	elseif ($0x1fac9708 = load_z_nashville)
		change \{0x1fac9708 = load_z_mexicocity}
	elseif ($0x1fac9708 = load_z_mexicocity)
		change \{0x1fac9708 = load_z_cairo}
	elseif ($0x1fac9708 = load_z_cairo)
		change \{0x1fac9708 = load_z_sanfrancisco}
	elseif ($0x1fac9708 = load_z_sanfrancisco)
		change \{0x1fac9708 = load_z_norway}
	elseif ($0x1fac9708 = load_z_norway)
		change \{0x1fac9708 = load_z_cube}
	else
		change \{0x1fac9708 = none}
	endif
	0x5bcab44e
endscript
