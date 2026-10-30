0x2c0a2ab0 = ''
0xa45fc02e = 0
0x4071e1a6 = false
0x92287416 = false
0xebafbcc5 = 0
loading_screen_tips = [
	qs(0x77af5d27)
	qs(0x77af5d27)
	qs(0xb2745572)
	qs(0xb2745572)
	qs(0xf426c70a)
	qs(0xf426c70a)
	qs(0xc2870c9f)
	qs(0x1b9926de)
	qs(0x1ef685be)
	qs(0x7f5357ce)
	qs(0x95c81309)
]
loading_screen_tips_guitar = [
	qs(0x13ab031d)
	qs(0x5e9a9d78)
	qs(0xb6c99b04)
	qs(0xa77f9cce)
	qs(0x9b610367)
	qs(0x857ed25c)
]
loading_screen_tips_drum = [
	qs(0xbb46c108)
	qs(0x066bfa3d)
	qs(0x16d807d3)
	qs(0x02ffd37d)
	qs(0x8004c308)
	qs(0x713f15be)
	qs(0x335dacbc)
]
loading_screen_tips_vocals = [
	qs(0xf4fbec9b)
	qs(0x63dc2c6a)
	qs(0xdb4cd2d0)
	qs(0xbd3a4bb8)
	qs(0x6f12a948)
	qs(0x2db53122)
]
loading_screen_tips_bass = [
	qs(0xcbbfb327)
	qs(0x13ab031d)
	qs(0x5e9a9d78)
]
loading_screen_tips_band = [
	qs(0xa971b033)
	qs(0x25ed2967)
	qs(0x268feb71)
	qs(0x697a4956)
]
loading_screen_tips_jam = [
]
loading_screen_tips_leaderboard = [
	qs(0xbcd6a2dd)
	qs(0xe32a76ac)
	qs(0x91158596)
	qs(0x2bd8629d)
]
loading_screen_destroy_state = 'none'

script create_loading_screen \{mode = play_song
		jam_mode = 0}
	0xf7e0f992 <...>
endscript

script 0xf7e0f992 \{mode = play_song
		jam_mode = 0
		force_predisplay = 1
		0x166cbf04 = 0
		heap = heap_bink}
	if gotparam \{wait}
		onexitrun \{0xf00f29a9}
		0x79db87d7
	endif

	setbuttoneventmappings \{block_menu_input}
	if NOT gotparam \{0xdf3c5641}
		menu_music_off
	endif
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
	if ($0x100b6016 = true)
		return
	endif
	change \{0x4071e1a6 = true}
	if screenelementexists \{id = loading_screen_container}
		return
	endif
	if ($0x92287416 = false)
		change \{0x92287416 = true}
		0x79db87d7
		0x6f5e5f74
	endif
	mark_unsafe_for_shutdown
	desc = 'loading'
	change \{0x2c0a2ab0 = 'pak/ui/loading_screen.pak'}
	loading_text = qs(0xfab8f6e7)
	if NOT (($invite_controller > -1) || ($signin_change_happening = 1))
		if (($game_mode) = p1_career)
			progression_get_total_stars
			if (<total_stars> = 0)
				<part> = ($player1_status.part)
				switch <part>
					case guitar
					case bass
					desc = 'instruction_loading_guitar'
					change \{0x2c0a2ab0 = 'pak/ui/instruction_loading_screen_guitar.pak'}
					case drum
					desc = 'instruction_loading_drums'
					change \{0x2c0a2ab0 = 'pak/ui/instruction_loading_screen_drums.pak'}
					case vocals
					desc = 'instruction_loading_vocals'
					change \{0x2c0a2ab0 = 'pak/ui/instruction_loading_screen_vocals.pak'}
				endswitch
			endif
		elseif ((($game_mode) = p2_career) || (($game_mode) = p3_career) || (($game_mode) = p4_career))
			progression_get_total_stars
			if (<total_stars> = 0)
				desc = 'instruction_loading_band'
				change \{0x2c0a2ab0 = 'pak/ui/instruction_loading_screen_band.pak'}
			endif
		endif
	endif
	if gotparam \{bx_useloadingscreenwithnotext}
		if (<bx_useloadingscreenwithnotext> = 1)
			movie = 'BG_Flip'
			movie_path = ('movies\\bik\\' + <movie> + '.bik.xen')
		endif
	endif
	green_text = qs(0x494b4d7f)
	red_text = qs(0x9d57d378)
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
	if screenelementexists \{id = loading_screen_container}
		destroyscreenelement \{id = loading_screen_container}
	endif
	loadpak \{$0x2c0a2ab0
		heap = topdownheap}
	change \{0xa45fc02e = 1}
	createscreenelement {
		type = descinterface
		parent = root_window
		desc = <desc>
		id = loading_screen_container
		z_priority = 100025
		tip_text = <rand_tip>
	}
	if gotparam \{destroy_state}
		change loading_screen_destroy_state = <destroy_state>
	else
		change \{loading_screen_destroy_state = 'none'}
	endif
	if gotparam \{spawn}
		loading_screen_container :obj_spawnscript \{create_loading_screen_spawned
			params = {
			}}
	else
		create_loading_screen_spawned
	endif
	if gotparam \{wait}
		begin
		if NOT scriptisrunning \{create_loading_screen_spawned}
			break
		endif
		waitonegameframe
		repeat
		wait \{2
			gameframe}
	endif
endscript

script create_loading_screen_spawned 
	clean_up_user_control_helpers
	wait \{4
		gameframes}
	0xb61d5c0c \{destroy = 0}
	if (<abort> = true)
		return
	endif
	progression_get_total_stars
	if (<total_stars> = 0)
		0xfa49b57f = false
	else
		0xfa49b57f = true
	endif
	if ((($game_mode) = p1_career) && (<0xfa49b57f> = false))
		displayloadingscreen \{no_back
			animate
			0x91f64d92 = 5
			0x2374ff6a = [
				'LoadingScreens/instruction_loading_animation%d'
			]
			x = [
				[
					123
				]
			]
			y = [
				[
					320
				]
			]
			w = [
				[
					75
				]
			]
			h = [
				[
					95
				]
			]}
	elseif (((($game_mode) = p2_career) || (($game_mode) = p3_career) || (($game_mode) = p4_career)) && (<0xfa49b57f> = false))
		displayloadingscreen \{no_back
			animate
			0x91f64d92 = 5
			0x2374ff6a = [
				'LoadingScreens/instruction_loading_animation%d'
			]
			x = [
				[
					171
				]
			]
			y = [
				[
					315
				]
			]
			w = [
				[
					95
				]
			]
			h = [
				[
					115
				]
			]}
	else
		displayloadingscreen \{no_back
			animate
			0x91f64d92 = 8
			0x2374ff6a = [
				'LoadingScreens/loading_animation%d'
			]
			0x82a3e599
			x = [
				[
					290
				]
			]
			y = [
				[
					163
				]
			]
			w = [
				[
					120
				]
			]
			h = [
				[
					173
				]
			]}
	endif
endscript

script destroy_loading_screen \{force = 0}
	0x7bd2b51d <...>
endscript

script 0x7bd2b51d \{force = 0}

	change \{0x4071e1a6 = false}
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
	else
		if ($0xebafbcc5 = 1)
			startrendering \{reason = loading_screen}
		endif
	endif
	change \{0xebafbcc5 = 0}
	if ($playing_song = 0 || $end_credits = 1)
		change \{is_changing_levels = 0}
	endif
	change \{is_changing_levels = 0}
	mark_safe_for_shutdown
	setbuttoneventmappings \{unblock_menu_input}
	if ($0x92287416 = true)
		change \{0x92287416 = false}
		0xe68af10a
		0xf00f29a9
	endif
endscript

script destroy_loading_screen_spawned \{time = 0.1}
	0xb61d5c0c \{destroy = 1}
	if (<abort> = true)
		return
	endif
	hideloadingscreen
	unloadpak \{$0x2c0a2ab0}
	change \{0x2c0a2ab0 = ''}
	gettags
	stoprendering \{reason = loading_screen}
	se_setprops \{alpha = 0}
	startrendering \{reason = loading_screen}
	if NOT (gameispaused)
		if NOT ($current_playing_transition = none)
			0x3bbee89e
		endif
	endif
	die
	change \{0xa45fc02e = 0}
endscript

script 0x928a98c9 
	begin
	if 0xcbca19f9
		0x7bd2b51d \{force = 1}
	elseif 0x16cc1b60
		0xd8bd876f
	else
		break
	endif
	waitonegameframe
	repeat
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

script 0x8658e568 
	if 0xcbca19f9
		return \{true}
	endif
	return \{false}
endscript

script 0xcbca19f9 
	if screenelementexists \{id = loading_screen_container}
		return \{true}
	endif
	return \{false}
endscript

script 0x18954ab6 
	if 0xcbca19f9
		return \{true}
	endif
	if 0x16cc1b60
		return \{true}
	endif
	return \{false}
endscript

script 0xb61d5c0c 
	0xfea69e6a = 0
	begin
	if NOT screenelementexists \{id = loading_screen_container}
		return \{abort = true}
	endif
	if ($0x4071e1a6 = false)
		if (<destroy> = 0)
			return \{abort = true}
		endif
	endif
	if ($0x4071e1a6 = true)
		if (<destroy> != 0)
			return \{abort = true}
		endif
	endif
	if 0x1241d2ae destroy = <destroy>
		0xfea69e6a = (<0xfea69e6a> + 1)
		if (<0xfea69e6a> > 2)
			return \{abort = false}
		endif
	else
		<0xfea69e6a> = 0
	endif
	wait \{1
		gameframe}
	repeat
endscript

script 0x1241d2ae 
	if (<destroy> = 0)
		if 0x81324b6d
			return \{true}
		endif
	else
		if 0x7c9efae5
			return \{true}
		endif
	endif
	return \{false}
endscript
