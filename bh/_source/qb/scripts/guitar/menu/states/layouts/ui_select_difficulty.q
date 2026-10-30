0xd09c05b6 = [
	{
		text = qs(0x74d6a0a0)
		icon = icon_difficulty_beginner
		0xb2c42979 = beginner
		double_kick = 0
	}
	{
		text = qs(0x8d657387)
		icon = icon_difficulty_easy
		0xb2c42979 = easy
		double_kick = 0
	}
	{
		text = qs(0x6ef11a01)
		icon = icon_difficulty_medium
		0xb2c42979 = medium
		double_kick = 0
	}
	{
		text = qs(0x51b06d2f)
		icon = icon_difficulty_hard
		0xb2c42979 = hard
		double_kick = 0
	}
	{
		text = qs(0x334908ac)
		icon = icon_difficulty_expert
		0xb2c42979 = expert
		double_kick = 0
	}
	{
		text = qs(0x7a19b5f7)
		icon = icon_difficulty_expert_plus
		0xb2c42979 = expert
		double_kick = 1
	}
]

script ui_create_select_difficulty 
	spawnscriptnow ui_create_select_difficulty_spawned params = {<...>}
	0xd518ab19 \{video = menu}
endscript

script ui_destroy_select_difficulty 
	change menu_flow_locked = ($menu_flow_locked + 1)
	generic_ui_destroy
	killspawnedscript \{name = career_menu_jaw_anim}
	0xafd96096
	if screenelementexists \{id = difficultyinterface}
		spawnscriptnow \{ui_destroy_select_difficulty_spawned}
	endif
	destroy_viewport_ui
	set_focus_color
	set_unfocus_color
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_select_difficulty_spawned 
	change menu_flow_locked = ($menu_flow_locked + 1)
	destroyscreenelement \{id = difficultyinterface}
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_setlist_scribbles 
	wait \{1
		gameframes}
	props = [highlight_scribble_01_alpha highlight_scribble_02_alpha highlight_scribble_03_alpha]
	getarraysize <props>
	<curhighlight> = 0
	begin
	<curhighlight> = (<curhighlight> + 1)
	if NOT (<curhighlight> < <array_size>)
		<curhighlight> = 0
	endif
	<i> = 0
	begin
	if (<curhighlight> = <i>)
		addparam name = (<props> [<i>]) structure_name = alpha value = 1.0
	else
		addparam name = (<props> [<i>]) structure_name = alpha value = 0.0
	endif
	se_setprops <alpha>
	<i> = (<i> + 1)
	repeat <array_size>
	wait \{0.1
		seconds}
	repeat
endscript

script ui_setlist_diff_focus 
	gettags
	wait \{1
		gameframes}
	getscreenelementposition id = {current_menu child = <index>} summed
	difficultyinterface :se_setprops highlight_pos = {absolute <screenelementpos>}
endscript

script ui_select_difficulty_back_setlist 
	0xb4abccbd
	generic_event_back
endscript
default_difficulty = [
	easy
	easy
	easy
	easy
	easy
	easy
	easy
	easy
]

script ui_create_select_difficulty_spawned \{show_drum_options = 0
		includes_double_kick = 0}
	change menu_flow_locked = ($menu_flow_locked + 1)
	change \{rich_presence_context = presence_menus}
	if NOT gotparam \{can_change_level}
		can_change_level = 1
	endif
	difficulty = ($default_difficulty [$primary_controller])
	focus_index = 2
	if gotparam \{difficulty}
		switch (<difficulty>)
			case easy
			focus_index = 1
			case medium
			focus_index = 2
			case hard
			focus_index = 3
			case expert
			focus_index = 4
		endswitch
	endif
	get_player_num_from_controller \{controller_index = $primary_controller}
	if (<player_num> < 0)
		player_num = 1
	endif
	getplayerinfo <player_num> part
	if (<part> = drum)
		<show_drum_options> = 1
		if (($current_song) != jamsession && ($current_song) != null)
			if structurecontains structure = ($permanent_songlist_props.($current_song)) double_kick
				if ($permanent_songlist_props.($current_song).double_kick = 1)
					<includes_double_kick> = 1
				endif
			endif
		endif
		gamemode_gettype
		if (<type> = career)
			<includes_double_kick> = 1
		endif
	endif
	includes_double_kick = 0
	if (<show_drum_options> = 1)
		getplayerinfo <player_num> double_kick_drum
		if (<focus_index> = 4 && <double_kick_drum> = 1)
			<focus_index> = 5
		endif
	endif
	if NOT ($game_mode = practice)
		spawnscriptnow \{menu_music_fade
			params = {
				in
				time = 0.01
			}}
	endif
	clean_up_user_control_helpers
	getplayerinfo \{1
		part}
	if gotparam \{from_setlist}
		if NOT ($game_mode = practice)
			set_unfocus_color \{rgba = [
					255
					255
					255
					255
				]}
			set_focus_color \{rgba = [
					0
					0
					0
					255
				]}
			if (<show_drum_options> = 1 && <includes_double_kick> = 1)
				<popup_desc> = 'setlist_b_difficulty_desc_plus'
			else
				<popup_desc> = 'setlist_b_difficulty_desc'
			endif
			createscreenelement {
				parent = root_window
				id = difficultyinterface
				type = descinterface
				desc = <popup_desc>
				pos = (0.0, 0.0)
				z_priority = 100
				alpha = 0.0
				exclusive_device = ($primary_controller)
			}
			if difficultyinterface :desc_resolvealias \{name = alias_menu}
				assignalias id = <resolved_id> alias = current_menu
				current_menu :se_setprops \{event_handlers = [
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
							ui_select_difficulty_back_setlist
						}
					]}
				diff_array = [beginner easy medium hard expert]
				i = 0
				begin
				setscreenelementprops {
					id = {current_menu child = <i>}
					event_handlers = [
						{focus retail_menu_focus}
						{focus ui_setlist_diff_focus}
						{unfocus retail_menu_unfocus}
						{pad_choose selected_difficulty params = {diff = (<diff_array> [<i>]) can_change_level = <can_change_level> double_kick = 0}}
					]
					tags = {index = <i>}
				}
				i = (<i> + 1)
				repeat 5
				if (<show_drum_options> = 1 && <includes_double_kick> = 1)
					setscreenelementprops {
						id = {current_menu child = 5}
						event_handlers = [
							{focus retail_menu_focus}
							{focus ui_setlist_diff_focus}
							{unfocus retail_menu_unfocus}
							{pad_choose selected_difficulty params = {diff = (<diff_array> [4]) can_change_level = <can_change_level> double_kick = 1}}
						]
						tags = {index = 5}
					}
				endif
			endif
			0xb4abccbd
			difficultyinterface :obj_spawnscriptnow \{0x9fe0c7eb
				params = {
					dims = (25.0, 25.0)
					0x53924c09 = (62.4, 62.4)
					end_dims = (31.2, 31.2)
				}}
			difficultyinterface :se_setprops \{alpha = 1.0
				time = 0.25}
			menu_finish
			change menu_flow_locked = ($menu_flow_locked - 1)
			launchevent type = focus target = current_menu data = {child_index = <focus_index>}
			return
		endif
	endif
	if ($game_mode = gh4_p1_career)
		get_diff_completion_text
		spacing_between = 25
	endif
	<complete_pos> = (0.0, 15.0)
	0x5e1a3a04 \{pad_back_script = ui_game_mode_back
		title = qs(0x9f281c76)
		use_all_controllers}
	if ($practice_enabled)
		current_menu :se_setprops \{event_handlers = [
				{
					pad_back
					menu_start_transition
				}
			]}
	endif
	0x4946edb7 = [0.0 0.0]
	i = 0
	getarraysize ($0xd09c05b6)
	num_difficulty = <array_size>
	max_width = 0
	array = []
	begin
	diff = (($0xd09c05b6) [<i>])
	if ((<diff>.double_kick) != 1 || (<show_drum_options> = 1 && <includes_double_kick> = 1))
		0x9d0992fe {
			text = (<diff>.text)
			texture = (<diff>.icon)
			pad_choose_script = selected_difficulty
			pad_choose_params = {diff = (<diff>.0xb2c42979) double_kick = (<diff>.double_kick)}
		}
		getscreenelementdims id = <item_container_id>
		if (<width> > <max_width>)
			max_width = <width>
		endif
		<item_container_id> :settags {diff_index = <i>}
		addarrayelement array = <array> element = <item_container_id>
	endif
	i = (<i> + 1)
	repeat <num_difficulty>
	if (($game_mode != practice) && ($game_mode != p2_pro_faceoff) && ($0xc7e670d7 = 0))
		get_completed_percentage part = <part>
		formattext textname = completed_songs_text qs(0x57ad7095) a = <completed_percentage>
		0x9d0992fe {
			text = <completed_songs_text>
			rgba = [235 187 50 255]
			font = fontgrid_text_a8
			scale = (0.5, 0.5)
			not_focusable
		}
	endif
	0x87679bf6 \{z_offset = 200.0}
	menu_finish
	change menu_flow_locked = ($menu_flow_locked - 1)
	launchevent type = focus target = current_menu data = {child_index = (<focus_index>)}
	destroy_loading_screen
endscript

script select_difficulty_show_movie 
	if ($game_mode = gh4_p1_career)
		getplayerinfo \{1
			part}
		get_current_band_info
		bandname_id = <band_info>
		formattext checksumname = first_time_played_part 'first_instrument_career_%s' s = ($instrument_list.<part>.text_nl)
		getglobaltags <bandname_id> param = <first_time_played_part>
		if ((<...>.<first_time_played_part>) = 0)
			switch (<part>)
				case guitar
				card_text = qs(0x3b4ed016)
				case bass
				card_text = qs(0x631c643d)
				case drum
				card_text = qs(0x3cceae0a)
				case vocals
				card_text = qs(0xcad0be81)
			endswitch
			createscreenelement \{type = spriteelement
				parent = root_window
				id = instrument_movie_bg
				texture = white
				rgba = [
					0
					0
					0
					255
				]
				pos = (640.0, 360.0)
				dims = (1280.0, 720.0)
				just = [
					center
					center
				]
				z_priority = 100}
			createscreenelement {
				type = textblockelement
				parent = instrument_movie_bg
				text = <card_text>
				font = ($test_menu_font)
				scale = 1.2
				dims = (600.0, 400.0)
				rgba = [200 200 200 255]
				pos = (640.0, 400.0)
				just = [center center]
				internal_just = [center center]
				z_priority = 101
			}
			menu_music_fade \{out
				time = 2}
			wait \{1
				seconds}
			fadetoblack \{on
				alpha = 1.0
				time = 1
				z_priority = 999}
			wait \{1
				seconds}
			destroy_menu \{menu_id = instrument_movie_bg}
			formattext checksumname = progression_flag 'Career_%s' s = ($instrument_list.<part>.text_nl)
			change current_progression_flag = (<progression_flag>)
			get_progression_globals game_mode = ($game_mode) ($current_progression_flag)
			if structurecontains structure = ($<tier_global>) initial_movie
				menu_music_off
				killmovie \{textureslot = 0}
				i = 1
				get_movie_id_by_name movie = ($<tier_global>.initial_movie)
				begin
				getplayerinfo <i> controller
				get_savegame_from_controller controller = <controller>
				setglobaltags <id> params = {unlocked = 1} savegame = <savegame>
				i = (<i> + 1)
				repeat ($current_num_players)
				playmovieandwait movie = ($<tier_global>.initial_movie) noblack
				spawnscriptnow \{menu_music_on}
			endif
			switch (<part>)
				case guitar
				setglobaltags <bandname_id> params = {first_instrument_career_guitar = 1}
				case bass
				setglobaltags <bandname_id> params = {first_instrument_career_bass = 1}
				case drum
				setglobaltags <bandname_id> params = {first_instrument_career_drum = 1}
				case vocals
				setglobaltags <bandname_id> params = {first_instrument_career_vocals = 1}
			endswitch
			fadetoblack \{off
				time = 0.5
				no_wait}
		endif
	endif
	spawnscriptnow ui_create_select_difficulty_spawned params = {<...>}
endscript

script get_completed_percentage 

	progression_flag = career_guitar
	switch (<part>)
		case bass
		progression_flag = career_bass
		case drum
		progression_flag = career_drum
		case vocals
		progression_flag = career_vocals
		case band
		progression_flag = career_band
	endswitch
	get_progression_globals (<progression_flag>)

	total_songs = 0.0
	completed_songs = 0.0
	num_tiers = ($<tier_global>.num_tiers)
	if NOT is_song_downloaded \{song_checksum = thatwasjustyourlife}
		num_tiers = (<num_tiers> - 1)
	endif
	tier_num = 1
	begin
	formattext checksumname = tiername 'tier%d' d = <tier_num>
	go_through_songs = 1
	if structurecontains structure = ($<tier_global>.<tiername>) debug_gig
		go_through_songs = 0
	endif
	if structurecontains structure = ($<tier_global>.<tiername>) createagig
		go_through_songs = 0
	endif
	if (<go_through_songs> = 1)
		getarraysize ($<tier_global>.<tiername>.songs)
		song_index = 0
		begin
		song = ($<tier_global>.<tiername>.songs [<song_index>])
		diff_index = 0
		begin
		format_globaltag_song_checksum part = ($<tier_global>.part) song = <song> difficulty_index = <diff_index>
		getglobaltags <song_checksum> params = stars
		if (<stars> > 2)
			completed_songs = (<completed_songs> + 1)
			break
		endif
		diff_index = (<diff_index> + 1)
		repeat 5
		total_songs = (<total_songs> + 1)
		song_index = (<song_index> + 1)
		repeat <array_size>
		if structurecontains structure = ($<tier_global>.<tiername>) 0x29c8d5a6
			getarraysize ($<tier_global>.<tiername>.0x29c8d5a6)
			song_index = 0
			begin
			song = ($<tier_global>.<tiername>.0x29c8d5a6 [<song_index>])
			diff_index = 0
			begin
			format_globaltag_song_checksum part = ($<tier_global>.part) song = <song> difficulty_index = <diff_index>
			getglobaltags <song_checksum> params = stars
			if (<stars> > 2)
				completed_songs = (<completed_songs> + 1)
				break
			endif
			diff_index = (<diff_index> + 1)
			repeat 5
			total_songs = (<total_songs> + 1)
			song_index = (<song_index> + 1)
			repeat <array_size>
		endif
	endif
	tier_num = (<tier_num> + 1)
	repeat <num_tiers>
	completed_percentage = ((<completed_songs> / <total_songs>) * 100)
	if ((<completed_percentage> > 0.0) && (<completed_percentage> < 1.0))
		completed_percentage = 1.0
	endif
	casttointeger \{completed_percentage}

	return completed_percentage = <completed_percentage>
endscript

script ui_select_difficulty_anim_in 
	if NOT gotparam \{from_setlist}
		menu_transition_in \{menu = current_menu_anchor}
	endif
endscript

script ui_select_difficulty_anim_out 
	if NOT gotparam \{from_setlist}
		menu_transition_out \{menu = current_menu_anchor}
	endif
endscript
