ui_select_venue_info = {
	load_z_rome = {
		polaroid = 0x07ab497c
		info = qs(0xce953563)
	}
	load_z_frankenstrat = {
		polaroid = 0x59a7e7f8
		info = qs(0x74ae6a63)
	}
	load_z_s_stage = {
		polaroid = 0xf65dc3bf
		info = qs(0xed68a4c7)
	}
	load_z_starwood = {
		polaroid = 0x9c9ddcb8
		info = qs(0xdfe6144c)
	}
	load_z_london = {
		polaroid = venue_london
		info = qs(0xe0ce00e0)
	}
	load_z_drum_kit = {
		polaroid = 0xb4e31208
		info = qs(0x39026ace)
	}
	load_z_paris = {
		polaroid = 0xdc7232a8
		info = qs(0x16f5f9d4)
	}
	load_z_la_block_party = {
		polaroid = 0x9f71d371
		info = qs(0x8c456d03)
	}
}

script ui_create_select_venue 
	spawnscriptnow \{turnpreviewsdown_venuemenu}
	get_progression_globals ($current_progression_flag)
	array = []
	getarraysize \{$levelzonearray}
	level_zone_array_size = <array_size>
	index = 0
	begin
	get_levelzonearray_checksum index = <index>
	if NOT structurecontains structure = ($levelzones.<level_checksum>) debug_only
		formattext {
			checksumname = venue_checksum
			'%s_%i'
			s = ($levelzones.<level_checksum>.name)
			i = ($instrument_list.($<tier_global>.part).text_nl)
			addtostringlookup = true
		}
		getglobaltags <venue_checksum> param = unlocked

		add_venue = 0
		if (<unlocked> = 1)
			add_venue = 1
		endif
		if ($cheat_unlockattballpark = 1)
			if (<level_checksum> = load_z_ballpark)
				add_venue = 1
			endif
		endif
		if (<add_venue> = 1)
			addarrayelement array = <array> element = <level_checksum>
		endif
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	getarraysize <array>
	index = 0
	i = 0
	begin
	if (<level> = <array> [<i>])
		index = <i>
	endif
	i = (<i> + 1)
	repeat <array_size>
	createscreenelement {
		type = descinterface
		parent = root_window
		id = current_menu_anchor
		desc = 'venue_selection'
		exclusive_device = ($primary_controller)
		tags = {
			index = <index>
			level_array = <array>
			array_size = <array_size>
			tier_num = <tier_num>
		}
	}
	assignalias \{id = current_menu_anchor
		alias = current_menu}
	current_menu :se_setprops {
		event_handlers = [
			{pad_back 0xff2e2991}
			{pad_up ui_select_venue_scroll params = {up}}
			{pad_down ui_select_venue_scroll params = {down}}
			{pad_choose ui_select_venue_choose params = {song = <song>}}
		]
		venue_name_text = ($levelzones.(<array> [<index>]).title)
		venue_information_text = ($levelzones.(<array> [<index>]).title)
	}
	current_menu :se_setprops \{venue_screenshot_texture = black}
	current_menu :obj_spawnscript \{ui_select_venue_update}
	current_menu :obj_spawnscript \{highlight_motion}
	menu_finish
	fadetoblack \{off
		no_wait
		id = 0xd85094d9}
endscript

script ui_destroy_select_venue 
	generic_ui_destroy
	fadetoblack \{off
		time = 0
		no_wait}
endscript

script ui_select_venue_scroll 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	if scriptisrunning \{ui_select_venue_update}
		return
	endif
	gettags
	if gotparam \{down}
		generic_menu_up_or_down_sound \{params = {
				down
			}}
		index = (<index> + 1)
		if (<index> >= <array_size>)
			index = 0
		endif
	else
		generic_menu_up_or_down_sound \{params = {
				up
			}}
		index = (<index> - 1)
		if (<index> < 0)
			index = (<array_size> - 1)
		endif
	endif
	settags index = <index>
	obj_spawnscript ui_select_venue_update params = <...>
endscript

script ui_select_venue_update 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	gettags
	se_setprops venue_name_text = ($levelzones.(<level_array> [<index>]).title)
	if structurecontains structure = ($ui_select_venue_info) (<level_array> [<index>])
		if structurecontains structure = ($ui_select_venue_info.(<level_array> [<index>])) polaroid
			if desc_resolvealias \{name = alias_venue_screenshot}
				0x7132f759 = ''
				<resolved_id> :getsingletag 0x7132f759
				if NOT (<0x7132f759> = ($ui_select_venue_info.(<level_array> [<index>]).polaroid))
					destroyscreenelement \{id = 0x8d91ba57}
					se_setprops \{venue_screenshot_texture = black}
					<resolved_id> :se_getprops

					createscreenelement {
						type = spriteelement
						parent = <resolved_id>
						id = 0x8d91ba57
						dims = <dims>
						just = [center center]
						pos_anchor = [center center]
						pos = (3.0, 0.0)
						textureslot = 1
						texturepri = 1000
						no_hold
						texture = ($ui_select_venue_info.(<level_array> [<index>]).polaroid)
						z_priority = 15.0
					}

					<resolved_id> :settags 0x7132f759 = ($ui_select_venue_info.(<level_array> [<index>]).polaroid)
				endif
			endif
		else
			destroyscreenelement \{id = 0x8d91ba57}
			se_setprops \{venue_screenshot_texture = black}
		endif
		if structurecontains structure = ($ui_select_venue_info.(<level_array> [<index>])) info
			se_setprops venue_information_text = ($ui_select_venue_info.(<level_array> [<index>]).info)
		else
			se_setprops \{venue_information_text = qs(0x03ac90f0)}
		endif
	else
		destroyscreenelement \{id = 0x8d91ba57}
		se_setprops \{venue_screenshot_texture = black
			venue_information_text = qs(0x03ac90f0)}
	endif
	if gotparam \{down}
		se_setprops \{arrow_down_scale = 1.5
			time = 0.1}
	else
		se_setprops \{arrow_up_scale = 1.5
			time = 0.1}
	endif
	se_waitprops
	se_setprops \{arrow_down_scale = 1.0
		arrow_up_scale = 1.0
		time = 0.1}
endscript

script ui_select_venue_choose 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	se_setprops \{block_events}
	gettags
	destroyscreenelement \{id = 0x8d91ba57}
	if ((<level_array> [<index>]) = load_z_stone)
		getplayerinfo \{1
			part}
		if ($current_num_players > 1)
			part = band
		endif
		if NOT ui_select_venue_check_stone_movie_played part = <part>
			wait \{5
				gameframe}
			clean_up_user_control_helpers
			ui_gig_posters_play_movie \{movie = 'stone_intro'}
			ui_select_venue_set_stone_movie_played part = <part>
			if (($signin_change_happening = 1) || ($invite_controller > -1))
				return
			endif
		endif
	endif
	venue_select_play_song <...> selected_level = (<level_array> [<index>])
endscript

script venue_select_play_song 

	stoprendering
	destroy_menu \{menu_id = gigboardvenueselectinterface}
	soundevent \{event = song_affirmation}
	change current_song = <song>
	change current_gig_number = <tier_num>
	generic_event_replace no_sound state = uistate_play_song data = {<...>}
endscript

script ui_select_venue_check_stone_movie_played \{part = band}
	get_current_band_info
	getglobaltags <band_info>
	switch (<part>)
		case guitar
		check = <career_guitar_stone_movie_played>
		case bass
		check = <career_bass_stone_movie_played>
		case drum
		check = <career_drum_stone_movie_played>
		case vocals
		check = <career_vocals_stone_movie_played>
		case band
		check = <career_band_stone_movie_played>
	endswitch
	if (<check> = 1)
		return \{true}
	endif
	return \{false}
endscript

script ui_select_venue_set_stone_movie_played \{part = band}
	get_current_band_info
	getglobaltags <band_info>
	switch (<part>)
		case guitar
		setglobaltags <band_info> params = {career_guitar_stone_movie_played = 1}
		case bass
		setglobaltags <band_info> params = {career_bass_stone_movie_played = 1}
		case drum
		setglobaltags <band_info> params = {career_drum_stone_movie_played = 1}
		case vocals
		setglobaltags <band_info> params = {career_vocals_stone_movie_played = 1}
		case band
		setglobaltags <band_info> params = {career_band_stone_movie_played = 1}
	endswitch
endscript

script 0xff2e2991 
	fadetoblack \{on
		time = 0
		alpha = 1.0
		z_priority = 100011
		id = 0x0f8154a6}
	generic_event_back
endscript
