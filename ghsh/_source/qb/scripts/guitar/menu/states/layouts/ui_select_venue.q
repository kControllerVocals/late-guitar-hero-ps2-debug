ui_select_venue_screenshots = {
	load_z_amazon = 'Venue_Amazon'
	load_z_canyon = 'Venue_Canyon'
	load_z_icecap = 'Venue_Icecap'
	load_z_london = 'Venue_London'
	load_z_sphinx = 'Venue_Sphinx'
	load_z_greatwall = 'Venue_GreatWall'
	load_z_atlantis = 'Venue_Atlantis'
	load_z_quebec = 'Venue_Quebec'
}
0x84b93ea7 = 0

script ui_create_select_venue 
	spawnscriptnow \{turnpreviewsdown_venuemenu}
	get_progression_globals ($current_progression_flag)
	if structurecontains structure = ($permanent_songlist_props.<song>) in_the_round
		if (($permanent_songlist_props.<song>.in_the_round) = 1)
			round_only = 1
		endif
	endif
	if NOT (ispakloaded 'pak\\ui\\Select_venue_all.pak' heap = bottomupheap)
		loadpak \{'pak\\ui\\Select_venue_all.pak'
			heap = bottomupheap}
	endif
	array = []
	getarraysize \{$levelcareerarray}
	level_zone_array_size = <array_size>
	index = 0
	begin
	get_levelcareerarray_checksum index = <index>
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
			{pad_back generic_event_back}
			{pad_up choose_venue_menu_up_or_down_sound params = {up}}
			{pad_down choose_venue_menu_up_or_down_sound params = {down}}
			{pad_up ui_select_venue_scroll params = {up}}
			{pad_down ui_select_venue_scroll params = {down}}
			{pad_choose ui_select_venue_choose params = {song = <song>}}
		]
		venue_name_text = ($levelzones.(<array> [<index>]).title)
		venue_information_text = ($levelzones.(<array> [<index>]).text)
	}
	if structurecontains structure = ($ui_select_venue_screenshots) (<array> [<index>])
		formattext checksumname = 0xe6600e12 '%d' d = ($ui_select_venue_screenshots.(<array> [<index>]))
		current_menu :se_setprops venue_screenshot_texture = <0xe6600e12>
	else
		current_menu :se_setprops \{venue_screenshot_texture = black}
	endif
	current_menu :obj_spawnscript \{bg_swap}
	menu_finish
endscript
choose_venue_props_loading_sound_flag = 0

script choose_venue_menu_up_or_down_sound 

	if NOT ($choose_venue_props_loading_sound_flag = 1)
		if ($disable_menu_sounds = 0)
			if gotparam \{down}
				soundevent \{event = ui_sfx_scroll_down}
			else
				soundevent \{event = ui_sfx_scroll_up}
			endif
		endif
	endif
endscript

script ui_destroy_select_venue 
	unloadpak \{'pak\\ui\\Select_venue_all.pak'
		heap = bottomupheap}
	generic_ui_destroy
	fadetoblack \{off
		time = 0
		no_wait}
endscript

script ui_select_venue_scroll 
	change \{choose_venue_props_loading_sound_flag = 1}
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	gettags
	prev_index = <index>
	if gotparam \{down}
		index = (<index> + 1)
		if (<index> >= <array_size>)
			index = 0
		endif
	else
		index = (<index> - 1)
		if (<index> < 0)
			index = (<array_size> - 1)
		endif
	endif
	settags index = <index>
	formattext checksumname = 0xe6600e12 '%d' d = ($ui_select_venue_screenshots.(<level_array> [<index>]))
	current_menu :se_setprops venue_name_text = ($levelzones.(<level_array> [<index>]).title) venue_information_text = ($levelzones.(<level_array> [<index>]).text)
	if structurecontains structure = ($ui_select_venue_screenshots) (<level_array> [<index>])
		current_menu :se_setprops venue_screenshot_texture = <0xe6600e12>
	else
		current_menu :se_setprops \{venue_screenshot_texture = black}
	endif
	if gotparam \{down}
		current_menu :se_setprops \{arrow_down_scale = 1.5
			time = 0.1}
	else
		current_menu :se_setprops \{arrow_up_scale = 1.5
			time = 0.1}
	endif
	se_waitprops
	se_setprops \{arrow_down_scale = 1.0
		arrow_up_scale = 1.0
		time = 0.1}
	change \{choose_venue_props_loading_sound_flag = 0}
endscript

script ui_select_venue_choose 
	gettags
	venue_select_play_song <...> selected_level = (<level_array> [<index>])
endscript

script venue_select_play_song 

	soundevent \{event = song_affirmation}
	change current_song = <song>
	change current_gig_number = <tier_num>
	part = band
	if (($current_num_players = 1) && ($is_network_game = 0))
		getplayerinfo \{1
			part}
	endif
	ui_gig_posters_check_movies_played part = <part>
	if (<selected_level> = load_z_icecap)
		if (<movies_played> = 1)
			if screenelementexists \{id = current_menu}
				current_menu :se_setprops \{block_events}
			endif
			spawnscriptnow \{black_overlay_on_spawned}
			ui_gig_posters_play_movie \{movie = 'GHGH_Movie1'}
			ui_gig_posters_set_movies_played part = <part> value = 2
		endif
	elseif (<selected_level> = load_z_london)
		if (<movies_played> = 2)
			if screenelementexists \{id = current_menu}
				current_menu :se_setprops \{block_events}
			endif
			spawnscriptnow \{black_overlay_on_spawned}
			ui_gig_posters_play_movie \{movie = 'GHGH_Movie2'}
			ui_gig_posters_set_movies_played part = <part> value = 3
		endif
	elseif (<selected_level> = load_z_greatwall)
		if (<movies_played> = 3)
			if screenelementexists \{id = current_menu}
				current_menu :se_setprops \{block_events}
			endif
			spawnscriptnow \{black_overlay_on_spawned}
			ui_gig_posters_play_movie \{movie = 'GHGH_Movie3'}
			ui_gig_posters_set_movies_played part = <part> value = 4
		endif
	elseif (<selected_level> = load_z_atlantis)
		if (<movies_played> = 4)
			if screenelementexists \{id = current_menu}
				current_menu :se_setprops \{block_events}
			endif
			spawnscriptnow \{black_overlay_on_spawned}
			ui_gig_posters_play_movie \{movie = 'GHGH_Movie4'}
			ui_gig_posters_set_movies_played part = <part> value = 5
		endif
	elseif (<selected_level> = load_z_quebec)
		if (<movies_played> = 5)
			if screenelementexists \{id = current_menu}
				current_menu :se_setprops \{block_events}
			endif
			spawnscriptnow \{black_overlay_on_spawned}
			ui_gig_posters_play_movie \{movie = 'GHGH_Movie_Outro'}
			ui_gig_posters_set_movies_played part = <part> value = 6
		endif
	endif
	generic_event_replace no_sound state = uistate_play_song data = {<...>}
	spawnscriptlater \{black_overlay_off_spawned}
endscript
