loading_screen_tips = [
	qs(0xc9b742d3)
	qs(0xc9b742d3)
	qs(0x55128c42)
	qs(0x55128c42)
	qs(0x1b249d67)
	qs(0x1b249d67)
	qs(0xc2870c9f)
	qs(0xaba1c872)
	qs(0xbbd1accf)
	qs(0x3ae22a18)
	qs(0x4b04862b)
	qs(0x95c81309)
]
loading_screen_tips_guitar = [
	qs(0x5b00d2a3)
	qs(0x3fbe71a3)
	qs(0x72a1a04b)
	qs(0x68314f9c)
	qs(0xf1b5a49c)
	qs(0x61524e4f)
]
loading_screen_tips_drum = [
	qs(0xbb46c108)
	qs(0x066bfa3d)
	qs(0x2957d847)
	qs(0x02ffd37d)
	qs(0xad313cae)
	qs(0x713f15be)
	qs(0xcccdd663)
]
loading_screen_tips_vocals = [
	qs(0xf074447f)
	qs(0x63dc2c6a)
	qs(0xdb4cd2d0)
	qs(0x7490e0eb)
	qs(0x6f12a948)
	qs(0x2f945279)
]
loading_screen_tips_bass = [
	qs(0xf87cba75)
	qs(0x5b00d2a3)
	qs(0x3fbe71a3)
]
loading_screen_tips_band = [
	qs(0x118abab2)
	qs(0x25ed2967)
	qs(0x268feb71)
	qs(0x8dd90fa9)
]
loading_screen_tips_jam = [
	qs(0xc91035c7)
	qs(0xaeb20c39)
	qs(0x10950ffe)
	qs(0xc39546e9)
]
loading_screen_tips_leaderboard = [
	qs(0xd65e620a)
	qs(0xe32a76ac)
	qs(0x91158596)
	qs(0x2bd8629d)
]
loading_screen_destroy_state = 'none'

script create_loading_screen \{mode = play_song
		jam_mode = 0}

	setbuttoneventmappings \{block_menu_input}
	menu_music_off
	songstoppreview
	songstop
	disable_pause
	if ($is_changing_levels = 1)
		return
	endif
	change \{is_changing_levels = 1}
	if ($guitar_motion_enable_test = 1)
		return
	endif
	if screenelementexists \{id = loading_screen_container}
		return
	endif
	mark_unsafe_for_shutdown
	desc = 'loading'
	loading_text = qs(0xfab8f6e7)
	getrandomvalue \{name = global_or_not
		a = 0
		b = 2
		integer}
	if (<global_or_not> = 1)
		<tips_array> = ($loading_screen_tips)
	else
		if (<jam_mode> = 1)
			<tips_array> = ($loading_screen_tips_jam)
		elseif gotparam \{leaderboard}
			<tips_array> = ($loading_screen_tips_leaderboard)
		elseif ($current_num_players = 1)
			<part> = ($player1_status.part)
			switch <part>
				case guitar
				<tips_array> = ($loading_screen_tips_guitar)
				case drum
				<tips_array> = ($loading_screen_tips_drum)
				case vocals
				<tips_array> = ($loading_screen_tips_vocals)
				case bass
				<tips_array> = ($loading_screen_tips_bass)
				default
				<tips_array> = ($loading_screen_tips_guitar)
			endswitch
		else
			if (($game_mode = p2_battle) || ($game_mode = p2_faceoff) || ($game_mode = p2_pro_faceoff))
				<tips_array> = ($loading_screen_tips)
			else
				<tips_array> = ($loading_screen_tips_band)
			endif
		endif
	endif
	if gotparam \{leaderboard}
		loading_text = qs(0x10ce7efd)
	endif
	getarraysize <tips_array>
	getrandomvalue name = rand_num a = 0 b = (<array_size> - 1) integer
	rand_tip = (<tips_array> [<rand_num>])
	createscreenelement {
		type = descinterface
		parent = root_window
		desc = <desc>
		id = loading_screen_container
		z_priority = 500000
		loading_text = qs(0x03ac90f0)
		tip_text = qs(0x03ac90f0)
	}
	if gotparam \{destroy_state}
		change loading_screen_destroy_state = <destroy_state>
	else
		change \{loading_screen_destroy_state = 'none'}
	endif
	if gotparam \{spawn}
		loading_screen_container :obj_spawnscript create_loading_screen_spawned params = {tip_text = <rand_tip> loading_text = <loading_text>}
	else
		create_loading_screen_spawned tip_text = <rand_tip> loading_text = <loading_text>
	endif
endscript

script create_loading_screen_spawned 
	loadpak \{'pak/loading_screen/loading_screen.pak'}
	createscreenelement \{type = spriteelement
		parent = loading_screen_container
		id = loading_screen_background
		texture = loading_background
		pos = (640.0, 360.0)
		just = [
			center
			center
		]
		dims = (1280.0, 720.0)
		z_priority = 4000}
	createscreenelement {
		type = textblockelement
		font = fontgrid_text_a6
		text = <tip_text>
		parent = loading_screen_container
		id = tip_text
		pos = (375.0, 325.0)
		scale = 0.55
		dims = (800.0, 400.0)
		just = [center center]
		internal_just = [center center]
		z_priority = 5000
		rgba = [128 64 64 250]
		single_line = false
		fit_width = wrap
		fit_height = `scale down if larger`
		scale_mode = proportional
	}
	createscreenelement {
		type = textblockelement
		font = text_a4
		text = <loading_text>
		parent = loading_screen_container
		id = loading_text
		pos = (320.0, 620.0)
		scale = 0.7
		dims = (200.0, 200.0)
		just = [top left]
		z_priority = 5000
		rgba = [10 10 10 250]
	}
	wait \{4
		gameframes}
	displayloadingscreen \{no_back
		animate}
	if screenelementexists \{id = loading_screen_background}
		destroyscreenelement \{id = loading_screen_background}
	endif
	unloadpak \{'pak/loading_screen/loading_screen.pak'}
endscript

script create_loading_screen_empty \{mode = play_song
		jam_mode = 0}

	mark_unsafe_for_shutdown
	stoprendering
	disable_pause
	if ($is_changing_levels = 1)
		return
	endif
	change \{is_changing_levels = 1}
	if ($guitar_motion_enable_test = 1)
		return
	endif
	if screenelementexists \{id = loading_screen_container}
		return
	endif
	if gotparam \{destroy_state}
		change loading_screen_destroy_state = <destroy_state>
	else
		change \{loading_screen_destroy_state = 'none'}
	endif
endscript

script destroy_loading_screen \{force = 0}

	if (<force> = 0)
		if NOT ($loading_screen_destroy_state = 'none')
			ui_event_get_top
			if NOT ($loading_screen_destroy_state = <base_name>)
				return
			endif
		endif
	endif
	if screenelementexists \{id = loading_screen_container}

		if NOT scriptisrunning \{destroy_loading_screen_spawned}
			loading_screen_container :obj_spawnscript destroy_loading_screen_spawned params = <...>
		endif
	endif
	hideloadingscreen
	if ($playing_song = 0 || $end_credits = 1)
		change \{is_changing_levels = 0}
	endif
	change \{is_changing_levels = 0}
	mark_safe_for_shutdown
	setbuttoneventmappings \{unblock_menu_input}
endscript

script destroy_loading_screen_spawned \{time = 0.1}
	gettags
	stoprendering \{reason = loading_screen}
	se_setprops \{alpha = 0}
	startrendering \{reason = loading_screen}
	die
endscript

script refresh_screen 
	destroy_loading_screen
	begin
	if NOT screenelementexists \{id = loading_screen_container}
		break
	endif
	wait \{1
		gameframe}
	repeat
	create_loading_screen
endscript
