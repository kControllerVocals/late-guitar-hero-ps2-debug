0x2c0a2ab0 = ''
0xa45fc02e = 0
0x4071e1a6 = false
0x92287416 = false
0xebafbcc5 = 0
loading_screen_tips = [
	qs(0x713ae349)
	qs(0x713ae349)
	qs(0x55128c42)
	qs(0x55128c42)
	qs(0x1b249d67)
	qs(0x1b249d67)
	qs(0xc2870c9f)
	qs(0xaba1c872)
	qs(0xeac388b2)
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
	0xf7e0f992 <...>
endscript

script 0xf7e0f992 \{mode = play_song
		jam_mode = 0}
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
			if NOT progression_check_intro_complete
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
				green_text = qs(0x494b4d7f)
				red_text = qs(0x9d57d378)
			endif
		elseif ((($game_mode) = p2_career) || (($game_mode) = p3_career) || (($game_mode) = p4_career))
			if NOT progression_check_intro_complete
				desc = 'instruction_loading_band'
				change \{0x2c0a2ab0 = 'pak/ui/instruction_loading_screen_band.pak'}
			endif
		endif
	endif
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
		z_priority = 500000
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
	endif
endscript

script create_loading_screen_spawned 
	wait \{4
		gameframes}
	0xb61d5c0c \{destroy = 0}
	if (<abort> = true)
		return
	endif
	if progression_check_intro_complete
		0xfa49b57f = true
	else
		0xfa49b57f = false
	endif
	if ((($game_mode) = p1_career) && (<0xfa49b57f> = false))
		displayloadingscreen \{no_back
			animate
			0x91f64d92 = 5
			0x2374ff6a = [
				'LoadingScreens/instruction_loading_animation%d'
			]
			0x474e8a34 = [
				'LoadingScreens/instruction_loading_erase%d'
			]
			x = [
				[
					68.5
					123.5
					178.5
					233.5
					283.5
				]
			]
			y = [
				[
					315.5
					318.5
					321.5
					324.5
					327.5
				]
			]
			w = [
				[
					33
					33
					33
					33
					33
				]
			]
			h = [
				[
					41
					41
					41
					41
					41
				]
			]}
	elseif (((($game_mode) = p2_career) || (($game_mode) = p3_career) || (($game_mode) = p4_career)) && (<0xfa49b57f> = false))
		displayloadingscreen \{no_back
			animate
			0x91f64d92 = 4
			0x2374ff6a = [
				'LoadingScreens/instruction_band_guitar_animation%d'
				'LoadingScreens/instruction_band_drums_animation%d'
				'LoadingScreens/instruction_band_vocals_animation%d'
			]
			x = [
				[
					151.5
				]
				[
					371.0
				]
				[
					532.0
				]
			]
			y = [
				[
					293.678
				]
				[
					284.346
				]
				[
					309.856
				]
			]
			w = [
				[
					60.5
				]
				[
					60.5
				]
				[
					60.5
				]
			]
			h = [
				[
					75.908005
				]
				[
					75.908005
				]
				[
					75.908005
				]
			]}
	else
		displayloadingscreen \{no_back
			animate
			0x91f64d92 = 8
			0x2374ff6a = [
				'LoadingScreens/loading_animation%d'
			]
			x = [
				[
					24.25
				]
			]
			y = [
				[
					64.450005
				]
			]
			w = [
				[
					262.5
				]
			]
			h = [
				[
					362.7
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
