setlist_sorts = [
	{
		name = title_alphabetical
		title = qs(0x73063505)
	}
	{
		name = artist_alphabetical
		title = qs(0x68455dfd)
	}
	{
		name = career_order
		title = qs(0xda629fb0)
	}
]
setlist_sort_index = 0
sort_restore_selections = 0
refresh_from_sort = 0
temp_quickplay_song_list = [
	null
	null
	null
	null
	null
	null
]
temp_jamsession_song_list = [
	-1
	-1
	-1
	-1
	-1
	-1
]
ui_setlist_skip_helpers = 1

script reset_temp_quickplay_song_list 
	getarraysize \{$temp_quickplay_song_list}
	i = 0
	begin
	setarrayelement arrayname = temp_quickplay_song_list globalarray index = <i> newvalue = null
	<i> = (<i> + 1)
	repeat <array_size>
endscript

script reset_temp_jamsession_song_list 
	getarraysize \{$temp_jamsession_song_list}
	i = 0
	begin
	setarrayelement arrayname = temp_jamsession_song_list globalarray index = <i> newvalue = -1
	<i> = (<i> + 1)
	repeat <array_size>
endscript

script song_is_in_temp_quickplay_song_list 
	getarraysize \{$temp_quickplay_song_list}
	<i> = 0
	begin
	if (<song> = ($temp_quickplay_song_list [<i>]))
		return \{true}
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script song_is_in_temp_jamsession_song_list 
	getarraysize \{$temp_jamsession_song_list}
	<i> = 0
	begin
	if (<jam_song> = ($temp_jamsession_song_list [<i>]))
		return \{true}
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script get_song_index_from_temp_quickplay_song_list 
	getarraysize \{$temp_quickplay_song_list}
	<i> = 0
	begin
	if (<song> = ($temp_quickplay_song_list [<i>]))
		return quickplay_index = <i>
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	return \{quickplay_index = -1}
endscript

script get_song_index_from_temp_jamsession_song_list 
	getarraysize \{$temp_jamsession_song_list}
	<i> = 0
	begin
	if (<jam_song> = ($temp_jamsession_song_list [<i>]))
		return jamsession_index = <i>
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	return \{jamsession_index = -1}
endscript

script ui_create_setlist 
	change menu_flow_locked = ($menu_flow_locked + 1)
	if ($quickplay_song_list_current = -1)
		change \{quickplay_song_list_current = 0}
	endif
	0x79db87d7
	killspawnedscript \{name = loading_screen_crowd_swell}
	killspawnedscript \{name = crowd_loading_whistle}
	killspawnedscript \{name = oneshotsbetweensongs}
	killspawnedscript \{name = surgebetweensongs}
	if NOT ($game_mode = practice || $game_mode = practice)
		spawnscriptnow \{skate8_sfx_backgrounds_new_area
			params = {
				bg_sfx_area = frontend_menu_music
			}}
	endif
	if ($is_network_game = 1)
		spawn_player_drop_listeners \{drop_player_script = setlist_drop_player
			end_game_script = setlist_end_game}
	endif
	if (($game_mode = p2_pro_faceoff) || ($game_mode = p2_quickplay) || ($game_mode = p3_quickplay) || ($game_mode = p4_quickplay))
		if NOT gotparam \{from_leaderboard}
			spawnscriptnow \{task_menu_default_anim_in
				params = {
					base_name = 'character_hub'
				}}
		endif
	endif
	spawnscriptnow ui_create_setlist_spawned params = <...>
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_create_setlist_spawned \{for_custom_setlist = 1
		last_focused_song = none}
	change menu_flow_locked = ($menu_flow_locked + 1)
	if NOT gotparam \{from_leaderboard}
		change \{rich_presence_context = presence_gigboard_and_setlist}
	endif
	ui_fx_set_blur \{amount = 0.0
		time = 0.0}
	stoprendering
	if ($is_network_game = 1)
		<for_custom_setlist> = 0
	endif
	if ($game_mode = practice || $game_mode = tutorial)
		<for_custom_setlist> = 0
	endif
	if ($game_mode = p2_pro_faceoff)
		<for_custom_setlist> = 0
	endif
	allow_jammode = 0
	0xb17a28cd \{condition = {
			0xdffcb66f
		}}
	show_quit_warning = 1
	if (<for_custom_setlist> = 1)
		if ($sort_restore_selections = 0)
			if gotparam \{keep_setlist}
				change \{sort_restore_selections = 1}
			else
				reset_temp_quickplay_song_list
				reset_temp_jamsession_song_list
			endif
		endif
	else
		show_quit_warning = 0
	endif
	if NOT gotparam \{keep_current_level}
		if NOT ($game_mode = practice)
			startrendering
			frontend_load_soundcheck \{loadingscreen}
			stoprendering
		endif
	endif
	for_createagig = 0
	if gotparam \{createagig}
		<for_createagig> = 1
	endif
	if gotparam \{no_jamsession}
		allow_jammode = 0
	endif
	if gotparam \{from_top_rocker}
		<for_custom_setlist> = 0
		<allow_jammode> = 0
		for_createagig = 0
		show_quit_warning = 0
	endif
	if gotparam \{from_leaderboard}
		<for_custom_setlist> = 0
		<allow_jammode> = 0
		for_createagig = 0
	endif
	menu_music_off
	gig_posters_song_focus
	gamemode_getnumplayers
	player_idx = 1
	begin
	getplayerinfo <player_idx> part
	if (<part> = drum)
		if usefourlanehighway player = <player_idx> reset
			setplayerinfo <player_idx> four_lane_highway = 1
		else
			setplayerinfo <player_idx> four_lane_highway = 0
		endif
		change \{unknown_drum_type = 0}
	endif
	player_idx = (<player_idx> + 1)
	repeat <num_players>
	if gotparam \{use_all_controllers}
		get_all_exclusive_devices
	else
		<exclusive_device> = ($primary_controller)
		if ($is_network_game = 1)
			if local_player_is_choosing_song
				player_idx = 1
				gamemode_getnumplayers
				begin
				getplayerinfo <player_idx> is_local_client
				if (<is_local_client> = 1)
					getplayerinfo <player_idx> net_obj_id
					if ($online_song_choice_id = <net_obj_id>)
						getplayerinfo <player_idx> controller
						<exclusive_device> = <controller>
						break
					endif
				endif
				<player_idx> = (<player_idx> + 1)
				repeat <num_players>
			endif
		endif
	endif
	update_ingame_controllers controller = <exclusive_device>
	createscreenelement {
		parent = root_window
		id = setlistinterface
		type = descinterface
		desc = 'setlist_b'
		exclusive_device = <exclusive_device>
	}
	if NOT gotparam \{use_all_controllers}
		setlistinterface :obj_spawnscript 0x8ed8c79c params = {from_top_rocker = <from_top_rocker>}
		if gotparam \{from_top_rocker}
			setlistinterface :settags {from_top_rocker = <from_top_rocker>}
		endif
	endif
	if setlistinterface :desc_resolvealias \{name = alias_setlist_menu}
		assignalias id = <resolved_id> alias = setlist_menu
		setlist_menu :se_setprops {
			tags = {
				from_top_rocker = <from_top_rocker>
				from_leaderboard = <from_leaderboard>
				for_custom_setlist = 0
				current_section = 1
				last_focused_song = <last_focused_song>
				custom_setlist_num_id_1 = null
				custom_setlist_num_id_2 = null
				custom_setlist_num_id_3 = null
				custom_setlist_num_id_4 = null
				custom_setlist_num_id_5 = null
				custom_setlist_num_id_6 = null
				section_breaker_index_1 = 99999
				section_breaker_index_2 = 99999
				section_breaker_index_3 = 99999
			}
		}
	endif
	ui_event_remove_params \{param = last_focused_song}
	if gotparam \{next_state}
		setlist_menu :settags next_state = <next_state>
	endif
	if gotparam \{for_custom_setlist}
		setlist_menu :settags for_custom_setlist = <for_custom_setlist>
	endif
	setlist_menu :se_setprops {
		event_handlers = [
			{pad_option setlist_jump_down_section params = {for_custom_setlist = <for_custom_setlist>}}
		]
	}
	createscreenelement \{parent = setlist_menu
		type = descinterface
		desc = 'setlist_b_head_desc'
		auto_dims = false
		dims = (0.0, 300.0)
		just = [
			center
			center
		]
		setlist_b_head_text_text = qs(0xa01b0e62)
		not_focusable}
	if ($band_mode_mode = quickplay)
		part = band
	else
		getplayerinfo \{1
			part}
	endif
	final_array = [gh5_songlist jammode_songs]
	final_array_text = [qs(0x1f7addb6) qs(0x25f4338c)]
	final_array_index = 0
	getarraysize <final_array>
	final_array_size = <array_size>
	<allow_jammode> = 0
	if (<allow_jammode> = 0)
		<final_array_size> = (<final_array_size> - 1)
	endif
	if (<for_custom_setlist> = 1)
		setlistinterface :se_setprops \{number_of_stars_alpha = 0}
		createscreenelement \{type = containerelement
			parent = root_window
			id = custom_setlist_helper_container
			pos = (640.0, 600.0)
			z_priority = 100000}
		createscreenelement \{type = spriteelement
			parent = custom_setlist_helper_container
			texture = pill_128_fill
			dims = (192.0, 38.0)
			pos = (400.0, 0.0)
			just = [
				center
				top
			]
			rgba = [
				20
				20
				20
				255
			]
			z_priority = 10}
		sprite_params = {
			type = spriteelement
			texture = setlist_custom_circle_sm_empty
			parent = custom_setlist_helper_container
			dims = (32.0, 32.0)
			just = [center top]
			rgba = [255 255 255 255]
			z_priority = 200000
		}
		text_params = {
			type = textelement
			font = fontgrid_text_a8
			scale = (0.65000004, 0.65000004)
			just = [center top]
			rgba = [0 0 0 255]
			z_priority = 300000
		}
		circle_num = 1
		circle_pos = (331.0, 3.0)
		begin
		createscreenelement <sprite_params> pos = <circle_pos> z_priority = 13
		formattext checksumname = circle_full_id 'cs_dot_helper_circle_%d' d = <circle_num>
		createscreenelement <sprite_params> pos = <circle_pos> texture = setlist_custom_circle_sm id = <circle_full_id> z_priority = 12
		formattext textname = num_text qs(0x76b3fda7) d = <circle_num>
		text_pos = (16.0, 0.0)
		if (<circle_num> = 1)
			text_pos = (<text_pos> + (-2.0, 0.0))
		endif
		createscreenelement <text_params> pos = <text_pos> text = <num_text> parent = <id> z_priority = 15
		<circle_pos> = (<circle_pos> + (28.0, 0.0))
		<circle_num> = (<circle_num> + 1)
		repeat 6
		setup_custom_setlist_helpers
	else
		setlistinterface :se_setprops \{number_of_stars_alpha = 1}
	endif
	gamemode_gettype
	<game_mode_type> = <type>
	if ($current_progression_flag = career_band && $is_network_game = 0)
		getsavegamefromcontroller controller = ($band_mode_current_leader)
	else
		getsavegamefromcontroller controller = ($primary_controller)
	endif
	final_num_songs = 0
	begin
	createscreenelement {
		parent = setlist_menu
		type = descinterface
		desc = 'setlist_b_divider_desc'
		auto_dims = false
		dims = (0.0, 50.0)
		setlist_divider_title_text = (<final_array_text> [<final_array_index>])
		not_focusable
	}
	wait \{1
		gameframe}
	if <id> :desc_resolvealias name = alias_setlist_divider
		assignalias id = <resolved_id> alias = setlist_divider_menu
		getscreenelementdims \{id = setlist_divider_menu}
		<id> :se_getprops
		if gotparam \{setlist_divider_title_dims}
			container_width = 1080
			divider_width = ((<container_width> - (<setlist_divider_title_dims>.(1.0, 0.0))) / 2)
			divider_bar_dims = (<divider_width> * (1.0, 0.0) + (<setlist_list_divider_l_dims>.(0.0, 1.0) * (0.0, 1.0)))
			<id> :se_setprops setlist_list_divider_l_dims = <divider_bar_dims> setlist_list_divider_r_dims = <divider_bar_dims>
		endif
	endif
	song_array = (<final_array> [<final_array_index>])
	if (<for_createagig> = 1)
		get_songs_available_for_create_a_setlist
		getarraysize <unlocked_songs_array>
	else
		getarraysize $<song_array>
	endif
	total_songs = <array_size>
	if (<total_songs> > 0)
		if (<final_array_index> = 0)
			setlist_menu :settags {section_breaker_index_1 = (<final_num_songs> + 1)}
		elseif (<final_array_index> = 1)
			setlist_menu :settags {section_breaker_index_2 = (<final_num_songs> + 2)}
		endif
		sortable_songlist = []
		i = 0
		begin
		if (<for_createagig> = 1)
			song = (<unlocked_songs_array> [<i>])
		else
			song = ($<song_array> [<i>])
		endif
		get_song_title song = <song>
		getuppercasestring <song_title>
		<song_title> = <uppercasestring>
		get_song_artist song = <song>
		if NOT gotparam \{song_artist}
			song_artist = qs(0xbf9c7a91)
		endif
		getuppercasestring <song_artist>
		<song_artist> = <uppercasestring>
		if ((gotparam from_top_rocker) || (gotparam from_leaderboard))
			if NOT structurecontains structure = ($gh_songlist_props.<song>) never_show_in_setlist
				get_song_saved_in_globaltags song = <song>
				get_song_allowed_in_quickplay song = <song>
				no_vocals = 0
				if structurecontains structure = ($gh_songlist_props.<song>) doesnt_support_vocals
					if gotparam \{from_leaderboard}
						if (($current_leaderboard_instrument) = mic)
							no_vocals = 1
						endif
					elseif gotparam \{from_top_rocker}
						getplayerinfo \{1
							part}
						if (<part> = vocals)
							no_vocals = 1
						endif
					endif
				endif
				if ((<saved_in_globaltags> = 1) && (<allowed_in_quickplay> = 1) && (<no_vocals> = 0))
					element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
					addarrayelement array = <sortable_songlist> element = <element_to_add>
					sortable_songlist = <array>
				endif
			endif
		else
			if issingleplayergame
				getplayerinfo \{1
					part}
				if (<part> = vocals)
					if NOT structurecontains structure = ($gh_songlist_props.<song>) doesnt_support_vocals
						element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
						addarrayelement array = <sortable_songlist> element = <element_to_add>
						sortable_songlist = <array>
					endif
				else
					element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
					addarrayelement array = <sortable_songlist> element = <element_to_add>
					sortable_songlist = <array>
				endif
			else
				element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
				addarrayelement array = <sortable_songlist> element = <element_to_add>
				sortable_songlist = <array>
			endif
		endif
		i = (<i> + 1)
		repeat <total_songs>
		if (<final_array_index> = 1)
			sortandbuildsonglist songlist = <sortable_songlist> sortby = career_order
		elseif ((<song_array> = gh4_download_songlist) && ($setlist_sorts [$setlist_sort_index].name = career_order))
			sortandbuildsonglist songlist = <sortable_songlist> sortby = artist_alphabetical
		else
			sortandbuildsonglist songlist = <sortable_songlist> sortby = ($setlist_sorts [$setlist_sort_index].name)
		endif
		getarraysize <sorted_songlist>
		total_songs = <array_size>
		if (<total_songs> = 0)
			<id> :die
		endif
		if (<total_songs> > 0)
			i = 0
			begin
			song = (<sorted_songlist> [<i>])
			get_song_prefix song = <song>
			beginner_skull_alpha = 1
			easy_skull_alpha = 1
			medium_skull_alpha = 1
			hard_skull_alpha = 1
			expert_skull_alpha = 1
			ghost_skull_alpha = 1
			beginner_text_alpha = 1
			easy_text_alpha = 1
			medium_text_alpha = 1
			hard_text_alpha = 1
			expert_text_alpha = 1
			ghost_text_alpha = 0
			highest_difficulty_texture = icon_difficulty_beginner
			highest_difficulty_alpha = 0
			get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'beginner' part = ($part_list_props.<part>.text_nl)
			formattext textname = score_beginner_text qs(0x4d4555da) s = <score>
			if (<score> = 0)
				<beginner_skull_alpha> = <ghost_skull_alpha>
				<beginner_text_alpha> = <ghost_text_alpha>
			else
				<highest_difficulty_texture> = icon_difficulty_beginner
				<highest_difficulty_alpha> = 1
			endif
			get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'easy' part = ($part_list_props.<part>.text_nl)
			formattext textname = score_easy_text qs(0x4d4555da) s = <score>
			if (<score> = 0)
				<easy_skull_alpha> = <ghost_skull_alpha>
				<easy_text_alpha> = <ghost_text_alpha>
			else
				<highest_difficulty_texture> = icon_difficulty_easy
				<highest_difficulty_alpha> = 1
			endif
			get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'medium' part = ($part_list_props.<part>.text_nl)
			formattext textname = score_medium_text qs(0x4d4555da) s = <score>
			if (<score> = 0)
				<medium_skull_alpha> = <ghost_skull_alpha>
				<medium_text_alpha> = <ghost_text_alpha>
			else
				<highest_difficulty_texture> = icon_difficulty_medium
				<highest_difficulty_alpha> = 1
			endif
			get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'hard' part = ($part_list_props.<part>.text_nl)
			formattext textname = score_hard_text qs(0x4d4555da) s = <score>
			if (<score> = 0)
				<hard_skull_alpha> = <ghost_skull_alpha>
				<hard_text_alpha> = <ghost_text_alpha>
			else
				<highest_difficulty_texture> = icon_difficulty_hard
				<highest_difficulty_alpha> = 1
			endif
			<expert_plus_icon_alpha> = 0
			get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'expert' part = ($part_list_props.<part>.text_nl)
			formattext textname = score_expert_text qs(0x4d4555da) s = <score>
			if (<score> = 0)
				<expert_skull_alpha> = <ghost_skull_alpha>
				<expert_text_alpha> = <ghost_text_alpha>
			else
				<highest_difficulty_texture> = icon_difficulty_expert
				<highest_difficulty_alpha> = 1
				get_formatted_songname song_prefix = <song_prefix> difficulty_text_nl = 'expert' part = ($part_list_props.<part>.text_nl)
				getglobaltags <songname> param = tr_double_bass_complete
				if (<tr_double_bass_complete> = 1)
					<expert_plus_icon_alpha> = 1
					<highest_difficulty_alpha> = 0
				endif
			endif
			gamemode_gettype
			if (<type> = pro_faceoff)
				<highest_difficulty_alpha> = 0
			endif
			get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'beginner' part = ($part_list_props.<part>.text_nl)
			beginner_stars = <stars>
			beginner_percent100 = <percent100>
			get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'easy' part = ($part_list_props.<part>.text_nl)
			easy_stars = <stars>
			easy_percent100 = <percent100>
			get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'medium' part = ($part_list_props.<part>.text_nl)
			medium_stars = <stars>
			medium_percent100 = <percent100>
			get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'hard' part = ($part_list_props.<part>.text_nl)
			hard_stars = <stars>
			hard_percent100 = <percent100>
			get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'expert' part = ($part_list_props.<part>.text_nl)
			expert_stars = <stars>
			expert_percent100 = <percent100>
			score_text = {
				score_beginner_text = <score_beginner_text>
				score_easy_text = <score_easy_text>
				score_medium_text = <score_medium_text>
				score_hard_text = <score_hard_text>
				score_expert_text = <score_expert_text>
				icon_difficulty_beginner_alpha = <beginner_skull_alpha>
				icon_difficulty_easy_alpha = <easy_skull_alpha>
				icon_difficulty_medium_alpha = <medium_skull_alpha>
				icon_difficulty_hard_alpha = <hard_skull_alpha>
				icon_difficulty_expert_alpha = <expert_skull_alpha>
				score_beginner_alpha = <beginner_text_alpha>
				score_easy_alpha = <easy_text_alpha>
				score_medium_alpha = <medium_text_alpha>
				score_hard_alpha = <hard_text_alpha>
				score_expert_alpha = <expert_text_alpha>
			}
			skull_tags = {
				icon_difficulty_texture = <highest_difficulty_texture>
				icon_difficulty_alpha = 0
				icon_difficulty_expert_plus_alpha = 0
			}
			get_song_title song = <song>
			getuppercasestring <song_title>
			<song_title> = <uppercasestring>
			get_song_artist song = <song>
			getuppercasestring <song_artist>
			<song_artist> = <uppercasestring>
			formattext textname = song_text qs(0x90e80fb9) a = <song_artist> t = <song_title>
			<double_kick_alpha> = 0
			if (<song> != jamsession)
				if structurecontains structure = ($permanent_songlist_props.<song>) double_kick
					if (($permanent_songlist_props.<song>.double_kick) = 1)
						<double_kick_alpha> = 1
					endif
				endif
			endif
			format_globaltag_song_checksum song = <song> part_text = ($part_list_props.<part>.text_nl)
			getglobaltags <song_checksum> param = tr_double_bass_complete
			createscreenelement {
				parent = setlist_menu
				type = descinterface
				desc = 'setlist_b_listing_desc'
				auto_dims = false
				dims = (0.0, 50.0)
				double_kick_alpha = <double_kick_alpha>
				event_handlers = [
					{focus ui_setlist_focus_song params = {for_custom_setlist = <for_custom_setlist>}}
					{unfocus ui_setlist_unfocus_song}
				]
				tags = {
					custom_setlist_num = 0
					song_title = <song_title>
					song_artist = <song_artist>
					score_text = <score_text>
					skull_tags = <skull_tags>
					song = <song>
					index = <final_num_songs>
					beginner_stars = <beginner_stars>
					easy_stars = <easy_stars>
					medium_stars = <medium_stars>
					hard_stars = <hard_stars>
					expert_stars = <expert_stars>
					beginner_percent100 = <beginner_percent100>
					easy_percent100 = <easy_percent100>
					medium_percent100 = <medium_percent100>
					hard_percent100 = <hard_percent100>
					expert_percent100 = <expert_percent100>
					double_bass_complete = <tr_double_bass_complete>
				}
				just = [center center]
				listing_text = <song_text>
				<skull_tags>
			}
			if (<last_focused_song> = <song>)
				selected_index = (<final_num_songs> + 2 + <final_array_index>)
			endif
			if ($is_network_game = 1)
				if local_player_is_choosing_song
					<id> :se_setprops event_handlers = [{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist>}}]
				endif
			else
				<id> :se_setprops event_handlers = [{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist>}}]
			endif
			if <id> :desc_resolvealias name = alias_listing
				getscreenelementchildren id = <resolved_id>
				getscreenelementposition id = <resolved_id> summed
				<text_pos> = <screenelementpos>
				getscreenelementprops id = (<children> [0]) force_update
				<width> = (<dims>.(1.0, 0.0) * <scale>.(1.0, 0.0))
				<double_kick_offset> = ((1.0, 0.0) * ((<width> / 2) - 25) + (0.0, 12.0))
				<new_pos> = (<double_kick_offset> + (0.0, 12.0))
				<id> :se_setprops double_kick_pos = <new_pos>
				<icon_difficulty_offset> = ((1.0, 0.0) * ((<width> / 2) - 25) + (0.0, 12.0))
				<new_pos> = (<text_pos> + <icon_difficulty_offset>)
				<id> :se_setprops icon_difficulty_pos = <new_pos>
				<id> :se_setprops icon_difficulty_expert_plus_pos = <new_pos>
			endif
			final_num_songs = (<final_num_songs> + 1)
			if ($sort_restore_selections = 1)
				get_song_index_from_temp_quickplay_song_list song = <song>
				if (<quickplay_index> != -1)
					<id> :ui_setlist_choose_song for_custom_setlist = <for_custom_setlist> song = <song> custom_index = <quickplay_index> no_sound
				endif
			endif
			i = (<i> + 1)
			repeat <total_songs>
		endif
		<jam_song> = 0
	endif
	<final_array_index> = (<final_array_index> + 1)
	repeat <final_array_size>
	destroy_loading_screen
	startrendering
	setlist_menu :settags total_songs = <final_num_songs> prev_index = 0
	if ($is_network_game = 1)
		if local_player_is_choosing_song
			menu_finish
		else
			add_user_control_helper \{text = qs(0xaf4d5dd2)
				button = red
				z = 100}
		endif
	else
		add_user_control_helper \{text = qs(0x562b9e24)
			button = green
			z = 100
			all_buttons}
		add_user_control_helper \{text = qs(0xaf4d5dd2)
			button = red
			z = 100}
		setlist_show_sort_helper_text
		setlist_show_jump_helper_text
	endif
	spawnscriptnow \{0xb20ce9b6}
	if ($is_network_game = 0)
		spawnscriptnow \{0x1e464d15}
	endif
	if resolvescreenelementid id = {setlist_menu child = <selected_index>}
		if ($is_network_game = 0)
			<resolved_id> :obj_spawnscript ui_setlist_focus_song params = {time = 0.0 for_custom_setlist = <for_custom_setlist>}
		endif
	endif
	if ($is_network_game = 0)
		launchevent type = focus target = setlist_menu data = {child_index = <selected_index>}
		setlist_menu :obj_spawnscript \{wait_and_render_setlist_menu}
	else
		launchevent type = focus target = setlist_menu data = {child_index = <selected_index>}
		startrendering
	endif
	if ($is_network_game = 1)
		setlistinterface :se_setprops \{scribble_lower_alpha = 1}
		setlistinterface :se_setprops \{number_of_stars_text = qs(0xbee5bf02)}
		if ($g_disable_song_chooser_spinner = 1)
			create_net_setlist_ui \{parent_element = setlistinterface}
			launchevent type = focus target = setlist_menu data = {child_index = <selected_index>}
		else
			if ($refresh_from_sort = 0)
				launchevent type = focus target = setlist_menu data = {child_index = <selected_index>}
				wait \{1
					gameframes}
				create_song_chooser_spinner selected_index = <selected_index>
			else
				spawnscriptnow \{0x1e464d15}
				create_net_setlist_ui \{parent_element = setlistinterface}
			endif
		endif
	endif
	change \{sort_restore_selections = 0}
	change \{refresh_from_sort = 0}
	destroy_loading_screen
	wait \{1
		second}
	if setlistinterface :desc_resolvealias \{name = alias_setlist_menu}
		assignalias id = <resolved_id> alias = setlist_menu
	endif
	change menu_flow_locked = ($menu_flow_locked - 1)
	spawnscriptlater 0xfd42e87c params = {show_quit_warning = <show_quit_warning> for_custom_setlist = <for_custom_setlist>}
endscript

script 0xfd42e87c 
	wait \{30
		gameframes}
	setlist_menu :se_setprops {
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back ui_setlist_back params = {show_quit_warning = <show_quit_warning>}}
			{pad_option2 setlist_switch_sort params = {for_custom_setlist = <for_custom_setlist>}}
		]
	}
	if (<for_custom_setlist> = 1)
		setlist_menu :se_setprops {
			event_handlers = [
				{pad_start ui_setlist_compact_and_continue}
				{pad_l1 ui_setlist_custom_remove_all params = {for_custom_setlist = <for_custom_setlist>}}
				{0x8c1fa032 ui_setlist_custom_remove_all params = {for_custom_setlist = <for_custom_setlist>}}
			]
		}
	endif
	disable_pause
	0xf00f29a9
endscript

script wait_and_render_setlist_menu 
	wait \{3
		gameframes}
	startrendering
endscript

script ui_destroy_setlist 
	change menu_flow_locked = ($menu_flow_locked + 1)
	killspawnedscript \{name = ui_create_setlist_spawned}
	spawnscriptnow \{0xb20ce9b6}
	if NOT ($game_mode = practice || $game_mode = practice ||
			($top_rockers_enabled) || (gotparam from_leaderboard))
		menu_music_on
	endif
	if screenelementexists \{id = setlistinterface}
		setlistinterface :die
	endif
	change \{user_control_pill_color = [
			20
			20
			20
			155
		]}
	change \{user_control_pill_text_color = [
			220
			220
			220
			255
		]}
	generic_ui_destroy
	destroy_menu \{menu_id = custom_setlist_helper_container}
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_deinit_setlist 
	change menu_flow_locked = ($menu_flow_locked + 1)
	killspawnedscript \{name = ui_create_setlist_spawned}
	spawnscriptnow \{0xb20ce9b6}
	menu_music_on
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script setup_custom_setlist_helpers 
	clean_up_user_control_helpers
	set_user_control_color \{text_rgba = [
			0
			0
			0
			255
		]
		bg_rgba = [
			200
			200
			200
			200
		]}
	set_num_songs_in_quickplay_list
	if ($game_mode = p2_pro_faceoff || $game_mode = practice)
		num_songs = 0
	endif
	setlist_menu :getsingletag \{from_top_rocker}
	if gotparam \{from_top_rocker}
		num_songs = 0
	endif
	setlist_menu :getsingletag \{from_leaderboard}
	if gotparam \{from_leaderboard}
		menu_finish
		return
	endif
	<controller> = ($primary_controller)
	if NOT (($menu_over_ride_exclusive_device) = -1)
		<controller> = ($menu_over_ride_exclusive_device)
	endif
	if ((isguitarcontroller controller = <controller>) || (isdrumcontroller controller = <controller>))
		<clear_button> = orange
	else
		<clear_button> = lb
	endif
	<selected_song_highlighted> = false
	if gotparam \{song}
		if song_is_in_temp_quickplay_song_list song = <song>
			<selected_song_highlighted> = true
			if gotparam \{jam_song}
				if NOT song_is_in_temp_jamsession_song_list jam_song = <jam_song>
					<selected_song_highlighted> = false
				endif
			endif
		endif
	endif
	setlist_menu :getsingletag \{for_custom_setlist}
	if (<for_custom_setlist> = 1)
		<pick_song_text> = qs(0x562b9e24)
	else
		<pick_song_text> = qs(0x4d9ad28f)
	endif
	if (<num_songs> = 0)
		add_user_control_helper text = <pick_song_text> button = green z = 100000
		destroyscreenelement \{id = custom_setlist_continue_pill}
	elseif (<num_songs> = 6)
		if (<selected_song_highlighted> = true)
			add_user_control_helper \{text = qs(0x0307b55c)
				button = green
				z = 100000}
		endif
	else
		if (<selected_song_highlighted> = true)
			add_user_control_helper \{text = qs(0x0307b55c)
				button = green
				z = 100000}
		else
			add_user_control_helper text = <pick_song_text> button = green z = 100000
		endif
	endif
	add_user_control_helper \{text = qs(0xaf4d5dd2)
		button = red
		z = 100000}
	setlist_show_sort_helper_text
	setlist_show_jump_helper_text
	if (<num_songs> != 0)
		add_user_control_helper text = qs(0x22f2d0e7) button = <clear_button> z = 100000
		user_control_helper_get_buttonchar \{button = start}
		add_user_control_helper \{text = qs(0x182f0173)
			button = start
			z = 100000}
	endif
endscript

script setlist_show_sort_helper_text 
	<next_sort_index> = ($setlist_sort_index + 1)
	getarraysize \{$setlist_sorts}
	if (<next_sort_index> >= <array_size>)
		<next_sort_index> = 0
	endif
	<sort_text> = (($setlist_sorts [<next_sort_index>]).title)
	add_user_control_helper text = <sort_text> button = yellow z = 100000
endscript

script setlist_show_jump_helper_text 
	if setlist_get_next_section
		switch <next_section>
			case 1
			add_user_control_helper \{text = qs(0x3c1b3ab6)
				button = blue
				z = 100000}
			case 2
			case 3
			add_user_control_helper \{text = qs(0xa1a26014)
				button = blue
				z = 100000}
		endswitch
	endif
endscript

script setlist_get_next_section 
	setlist_menu :getsingletag \{current_section}
	<new_section> = <current_section>
	begin
	<new_section> = (<new_section> + 1)
	if (<new_section> = 4)
		<new_section> = 1
	endif
	if setlist_is_section_valid section = <new_section>

		break
	endif
	repeat 3
	if NOT (<new_section> = <current_section>)
		return {true next_section = <new_section>}
	endif
	return \{false}
endscript

script setlist_is_section_valid 
	setlist_menu :gettags
	switch <section>
		case 1
		if NOT (<section_breaker_index_1> = 99999)
			return \{true}
		endif
		case 2
		if NOT (<section_breaker_index_2> = 99999)
			return \{true}
		endif
		case 3
		if NOT (<section_breaker_index_3> = 99999)
			return \{true}
		endif
	endswitch
	return \{false}
endscript

script setlist_jump_down_section 
	setlist_menu :gettags
	if NOT setlist_get_next_section
		return
	endif
	soundevent \{enter_band_name_back
		vol = -3
		buss = front_end}
	switch <next_section>
		case 1
		focus_index = <section_breaker_index_1>
		case 2
		focus_index = <section_breaker_index_2>
		case 3
		focus_index = <section_breaker_index_3>
	endswitch
	if resolvescreenelementid id = {setlist_menu child = <focus_index>}
		<resolved_id> :obj_spawnscript ui_setlist_focus_song params = {time = 0.0}
	endif
	launchevent type = unfocus target = setlist_menu data = {child_index = <tag_selected_index>}
	wait \{3
		gameframe}
	launchevent type = focus target = setlist_menu data = {child_index = <focus_index>}
endscript

script setlist_update_current_section 
	setlist_menu :gettags
	if (<index> >= <section_breaker_index_3>)
		<current_section> = 3
	elseif (<tag_selected_index> >= <section_breaker_index_2>)
		<current_section> = 2
	elseif (<tag_selected_index> >= <section_breaker_index_1>)
		<current_section> = 1
	endif

	setlist_menu :settags current_section = <current_section>
	if ($ui_setlist_skip_helpers = 1)
		return
	endif
	if (<for_custom_setlist> = 1)
		setup_custom_setlist_helpers song = <song> jam_song = <jam_song>
	else
		clean_up_user_control_helpers
		if ($is_network_game = 1)
			if local_player_is_choosing_song
				add_user_control_helper \{text = qs(0x4d9ad28f)
					button = green
					z = 100
					all_buttons}
			endif
		else
			add_user_control_helper \{text = qs(0x562b9e24)
				button = green
				z = 100
				all_buttons}
		endif
		add_user_control_helper \{text = qs(0xaf4d5dd2)
			button = red
			z = 100}
		setlist_show_sort_helper_text
		setlist_show_jump_helper_text
		if ($game_mode = gh4_p1_career ||
				$game_mode = gh4_p2_career ||
				$game_mode = gh4_p3_career ||
				$game_mode = gh4_p4_career)
			if ($enable_button_cheats = 1)
				add_user_control_helper \{text = qs(0x91fff11f)
					button = rb
					z = 100000}
			endif
		endif
	endif
endscript

script ui_return_setlist_unblock_spawned 
	wait \{1
		gameframe}
	se_setprops \{unblock_events}
endscript

script ui_return_setlist 
	setlistinterface :getsingletag \{from_top_rocker}
	setlistinterface :obj_spawnscript 0x8ed8c79c params = {from_top_rocker = <from_top_rocker>}
	clean_up_user_control_helpers
	if ($is_network_game = 0)
		add_user_control_helper \{text = qs(0x562b9e24)
			button = green
			z = 100000
			all_buttons}
		add_user_control_helper \{text = qs(0xaf4d5dd2)
			button = red
			z = 100000}
		setlist_show_sort_helper_text
		setlist_show_jump_helper_text
	endif
	if setlistinterface :desc_resolvealias \{name = alias_setlist_menu}
		assignalias id = <resolved_id> alias = setlist_menu
		setlist_menu :obj_spawnscript \{ui_return_setlist_unblock_spawned}
		if ($is_network_game = 1)
			if local_player_is_choosing_song
				add_user_control_helper \{text = qs(0x4d9ad28f)
					button = green
					z = 100
					all_buttons}
			endif
			add_user_control_helper \{text = qs(0xaf4d5dd2)
				button = red
				z = 100}
			setlist_show_sort_helper_text
			setlist_show_jump_helper_text
		endif
		setlistinterface :gettags
	endif
	setlist_menu :gettags
	if (<for_custom_setlist> = 1)
		setup_custom_setlist_helpers song = <last_focused_song>
	endif
	if gotparam \{from_top_rocker}
		setup_custom_setlist_helpers song = <last_focused_song>
	endif
	spawnscriptnow \{0x1e464d15}
endscript

script ui_setlist_highlight_motion 
	setspawninstancelimits \{max = 1
		management = kill_oldest}
	if desc_resolvealias \{name = alias_highlight}
		if getscreenelementchildren id = <resolved_id>
			(<children> [1]) :obj_spawnscript 0xd5b5a21b
		endif
	endif
endscript

script ui_setlist_focus_song \{time = 0.1}
	gettags

	if NOT gotparam \{index}
		return
	endif
	se_getparentid
	<parent_id> :gettags
	if (<prev_index> > <index>)
		pos_move = (0.0, -10.0)
	else
		pos_move = (0.0, 10.0)
	endif
	<selected_song_highlighted> = false
	if (<for_custom_setlist> = 1)
		if song_is_in_temp_quickplay_song_list song = <song>
			<selected_song_highlighted> = true
			if gotparam \{jam_song}
				if (<example_songs> = 1)
					<jam_song> = (<jam_song> + 1000)
				endif
				if NOT song_is_in_temp_jamsession_song_list jam_song = <jam_song>
					<selected_song_highlighted> = false
				endif
			endif
		endif
	endif
	<should_update_pad_choose> = 0
	if ($is_network_game = 1)
		if local_player_is_choosing_song
			<should_update_pad_choose> = 1
		endif
	else
		<should_update_pad_choose> = 1
	endif
	if (<should_update_pad_choose> = 1)
		if (<selected_song_highlighted> = true)
			se_setprops {
				event_handlers = [
					{pad_choose ui_setlist_custom_remove params = {song = <song> for_custom_setlist = <for_custom_setlist>}}
				]
				replace_handlers
			}
		else
			<pad_choose_params> = {song = <song> for_custom_setlist = <for_custom_setlist>}
			if (<song> = jamsession)
				<pad_choose_params> = {song = <song> for_custom_setlist = <for_custom_setlist> jam_song = <jam_song> example_songs = <example_songs>}
			endif
			se_setprops {
				event_handlers = [
					{pad_choose ui_setlist_choose_song params = <pad_choose_params>}
				]
				replace_handlers
			}
		endif
	endif
	setlist_menu :settags last_focused_song = <song>
	if NOT gotparam \{jam_song}
		setlist_update_current_section index = <tag_selected_index> song = <song>
	else
		setlist_update_current_section index = <tag_selected_index> song = <song> jam_song = <jam_song>
	endif
	<info_scores_container_alpha> = 1.0
	<instrument_icons_alpha> = 0.0
	if ($game_mode = p2_pro_faceoff)
		<info_scores_container_alpha> = 0.0
		<instrument_icons_alpha> = 0.0
	endif
	if NOT (<tag_selected_index> < <section_breaker_index_3>)
		<info_scores_container_alpha> = 0.0
		<instrument_icons_alpha> = 1.0
		setlist_get_jammode_playback_tracks jam_song = <jam_song> example_songs = <example_songs>
		icon_no_instrument_guitar_alpha = 1
		icon_no_instrument_bass_alpha = 1
		icon_no_instrument_drums_alpha = 1
		icon_no_instrument_mic_alpha = 1
		if gotparam \{playback_track1}
			if (<playback_track1> > -1)
				icon_no_instrument_guitar_alpha = 0
			endif
		endif
		if gotparam \{playback_track2}
			if (<playback_track2> > -1)
				icon_no_instrument_bass_alpha = 0
			endif
		endif
		if gotparam \{playback_track_drums}
			if (<playback_track_drums> > 0)
				icon_no_instrument_drums_alpha = 0
			endif
		endif
		if gotparam \{playback_track_vocals}
			if (<playback_track_vocals> > 0)
				icon_no_instrument_mic_alpha = 0
			endif
		endif
	endif
	formattext textname = song_text qs(0x90e80fb9) a = <song_artist> t = <song_title>
	stringtochararray string = <song_text>
	getarraysize <char_array>
	<double_kick_alpha> = 0
	if (<song> != jamsession)
		if structurecontains structure = ($permanent_songlist_props.<song>) double_kick
			if (($permanent_songlist_props.<song>.double_kick) = 1)
				<double_kick_alpha> = 1
			endif
		endif
	endif
	icon_difficulty_expert_alpha = 1
	icon_difficulty_expert_plus_alpha = 0
	if (<song> != jamsession)
		if (<double_bass_complete> = 1)
			<icon_difficulty_expert_alpha> = 0
			<icon_difficulty_expert_plus_alpha> = 1
		endif
	endif
	se_setprops {
		desc = 'setlist_b_info_desc'
		auto_dims = false
		dims = (0.0, 150.0)
		setlist_info_title_artist_text = <song_text>
		setlist_info_title_artist_pos = {<pos_move> relative}
		<score_text>
		info_scores_container_alpha = <info_scores_container_alpha>
		instrument_icons_alpha = <instrument_icons_alpha>
		icon_no_instrument_guitar_alpha = <icon_no_instrument_guitar_alpha>
		icon_no_instrument_bass_alpha = <icon_no_instrument_bass_alpha>
		icon_no_instrument_drums_alpha = <icon_no_instrument_drums_alpha>
		icon_no_instrument_mic_alpha = <icon_no_instrument_mic_alpha>
		double_kick_alpha = <double_kick_alpha>
		icon_difficulty_expert_alpha = <icon_difficulty_expert_alpha>
		icon_difficulty_expert_plus_alpha = <icon_difficulty_expert_plus_alpha>
	}
	obj_getid
	percent_index = 0
	percent_diffs = ['beginner' 'easy' 'medium' 'hard' 'expert']
	percent_aliases = [
		alias_setlist_b_stars_beginner
		alias_setlist_b_stars_easy
		alias_setlist_b_stars_medium
		alias_setlist_b_stars_hard
		alias_setlist_b_stars_expert
	]
	star_diffs = [
		beginner_stars
		easy_stars
		medium_stars
		hard_stars
		expert_stars
	]
	begin
	formattext checksumname = percent100 '%s_percent100' s = (<percent_diffs> [<percent_index>])
	if gotparam <percent100>
		if <objid> :desc_resolvealias name = (<percent_aliases> [<percent_index>])
			if (<...>.<percent100> = 1)
				<resolved_id> :se_setprops star_rgba = [255 255 255 255]
			endif
			if <resolved_id> :desc_resolvealias name = alias_stars
				getscreenelementchildren id = <resolved_id>
				num_stars = (<...>.(<star_diffs> [<percent_index>]))
				if (<num_stars> = 0)
					<resolved_id> :se_setprops alpha = 0
				else
					getarraysize <children>
					stars_left = <array_size>
					if (<num_stars> < 5 && <stars_left> = 5)
						if screenelementexists id = (<children> [0])
							destroyscreenelement id = (<children> [0])
							stars_left = (<stars_left> - 1)
						endif
					endif
					if (<num_stars> < 4 && <stars_left> = 4)
						if screenelementexists id = (<children> [1])
							destroyscreenelement id = (<children> [1])
						endif
					endif
				endif
			endif
		endif
	endif
	percent_index = (<percent_index> + 1)
	repeat 5
	se_setprops {
		setlist_info_title_artist_pos = {(<pos_move> * -1) relative}
		time = <time>
	}
	if <objid> :desc_resolvealias name = alias_setlist_info_text
		getscreenelementchildren id = <resolved_id>
		getscreenelementchildren id = (<children> [2])
		getscreenelementprops id = (<children> [0]) force_update
		<width> = (<dims>.(1.0, 0.0) * <scale>.(1.0, 0.0))
		<double_kick_offset> = ((1.0, 0.0) * ((<width> / 2) + 12))
		<new_pos> = (<double_kick_offset> + (0.0, 12.0))
		<objid> :se_setprops double_kick_pos = <new_pos>
	endif
	<ratio> = (<index> / (<total_songs> * 1.0))
	pos = ((0.0, 1.0) * ((<ratio> * 365) - 207))
	bg_pos = ((0.0, -1.0) * (<ratio> * (4400 - 720)))
	bg_runnerc_pos = ((0.0, -1.0) * (<ratio> * (2200 - 720)))
	bg_runnerl_pos = (((0.0, -1.0) * (<ratio> * (2200 - 720))) + (-640.0, 0.0))
	<overlap> = -1.5
	setlistinterface :se_setprops {
		setlist_b_scrollthumb_pos = <pos>
		setlist_b_bg_pos = <bg_pos>
		setlist_b_bg_runnerl_pos = <bg_runnerl_pos>
		0x514c85e6 = (<bg_runnerl_pos> + ((0.0, 1.0) * (512 + (1 * <overlap>))))
		0x6c2cac56 = (<bg_runnerl_pos> + ((0.0, 1.0) * (1024 + (2 * <overlap>))))
		0xde0c7046 = (<bg_runnerl_pos> + ((0.0, 1.0) * (1536 + (3 * <overlap>))))
		time = 0.0
	}
	<parent_id> :settags prev_index = <index>
	obj_getid
	create_custom_setlist_circle id = <objid>
	if (<tag_selected_index> < <section_breaker_index_3>)
		gig_posters_song_focus song = <song>
	else
		gig_posters_song_focus
	endif
	<objid> :obj_spawnscriptnow ui_setlist_highlight_motion
	setup_custom_setlist_helpers song = <song>
endscript

script ui_setlist_unfocus_song 
	gettags
	formattext textname = song_text qs(0x90e80fb9) a = <song_artist> t = <song_title>
	<double_kick_alpha> = 0
	if (<song> != jamsession)
		if structurecontains structure = ($permanent_songlist_props.<song>) double_kick
			if (($permanent_songlist_props.<song>.double_kick) = 1)
				<double_kick_alpha> = 1
			endif
		endif
	endif
	se_setprops {
		desc = 'setlist_b_listing_desc'
		auto_dims = false
		dims = (0.0, 50.0)
		listing_text = <song_text>
		double_kick_alpha = <double_kick_alpha>
		<skull_tags>
	}
	if desc_resolvealias \{name = alias_listing}
		getscreenelementchildren id = <resolved_id>
		getscreenelementposition id = <resolved_id> summed
		<text_pos> = <screenelementpos>
		getscreenelementprops id = (<children> [0]) force_update
		<width> = (<dims>.(1.0, 0.0) * <scale>.(1.0, 0.0))
		<double_kick_offset> = ((1.0, 0.0) * ((<width> / 2) - 25) + (0.0, 12.0))
		<new_pos> = (<double_kick_offset> + (0.0, 12.0))
		se_setprops double_kick_pos = <new_pos>
		<icon_difficulty_offset> = ((1.0, 0.0) * ((<width> / 2) - 25) + (0.0, 12.0))
		<new_pos> = (<text_pos> + <icon_difficulty_offset>)
		se_setprops icon_difficulty_pos = <new_pos>
		se_setprops icon_difficulty_expert_plus_pos = <new_pos>
	endif
	obj_getid
	create_custom_setlist_circle id = <objid> use_small_circle
	setup_custom_setlist_helpers song = <song>
endscript

script ui_setlist_get_next_custom_index 
	getarraysize \{$temp_quickplay_song_list}
	i = 0
	begin
	if ($temp_quickplay_song_list [<i>] = null)
		return custom_index = <i> index_max = <array_size>
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	return custom_index = <array_size> index_max = <array_size>
endscript

script set_num_songs_in_quickplay_list 
	getarraysize \{$temp_quickplay_song_list}
	i = 0
	num_songs = 0
	begin
	if NOT ($temp_quickplay_song_list [<i>] = null)
		<num_songs> = (<num_songs> + 1)
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	change num_quickplay_song_list = <num_songs>
	return num_songs = <num_songs>
endscript

script ui_setlist_custom_remove 
	generic_menu_pad_choose_sound
	setlist_menu :gettags
	obj_getid
	<objid> :getsingletag custom_setlist_num
	if (<custom_setlist_num> > 0)
		if <objid> :desc_resolvealias name = alias_custom_setlist_container
			if getscreenelementchildren id = <resolved_id>
				getarraysize <children>
				if (<array_size> > 0)
					destroy_menu menu_id = (<children> [0])
				endif
			endif
		endif
		setarrayelement arrayname = temp_quickplay_song_list globalarray index = (<custom_setlist_num> - 1) newvalue = null
		setarrayelement arrayname = temp_jamsession_song_list globalarray index = (<custom_setlist_num> - 1) newvalue = -1
		set_num_songs_in_quickplay_list
		formattext checksumname = circle_full_id 'cs_dot_helper_circle_%d' d = <custom_setlist_num>
		setscreenelementprops id = <circle_full_id> alpha = 1
		<objid> :settags custom_setlist_num = 0
		switch (<custom_setlist_num>)
			case 1
			setlist_menu :settags \{custom_setlist_num_id_1 = null}
			soundevent \{event = quickplay_remove_song}
			case 2
			setlist_menu :settags \{custom_setlist_num_id_2 = null}
			soundevent \{event = quickplay_remove_song}
			case 3
			setlist_menu :settags \{custom_setlist_num_id_3 = null}
			soundevent \{event = quickplay_remove_song}
			case 4
			setlist_menu :settags \{custom_setlist_num_id_4 = null}
			soundevent \{event = quickplay_remove_song}
			case 5
			setlist_menu :settags \{custom_setlist_num_id_5 = null}
			soundevent \{event = quickplay_remove_song}
			case 6
			setlist_menu :settags \{custom_setlist_num_id_6 = null}
			soundevent \{event = quickplay_remove_song}
		endswitch
		se_setprops {
			event_handlers = [
				{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist>}}
			]
			replace_handlers
		}
		setup_custom_setlist_helpers
	endif
endscript

script ui_setlist_custom_remove_all 
	setlist_menu :gettags
	index = 0
	begin
	formattext checksumname = custom_setlist_num_id 'custom_setlist_num_id_%d' d = (<index> + 1)
	obj_id = (<...>.<custom_setlist_num_id>)
	if (<obj_id> != null)
		if <obj_id> :desc_resolvealias name = alias_custom_setlist_container
			if getscreenelementchildren id = <resolved_id>
				getarraysize <children>
				soundevent \{event = quickplay_remove_all_songs}
				if (<array_size> > 0)
					destroy_menu menu_id = (<children> [0])
				endif
			endif
			<obj_id> :getsingletag song
			<obj_id> :se_setprops {
				event_handlers = [
					{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist>}}
				]
				replace_handlers
			}
		endif
		setarrayelement arrayname = temp_quickplay_song_list globalarray index = <index> newvalue = null
		formattext checksumname = circle_full_id 'cs_dot_helper_circle_%d' d = (<index> + 1)
		setscreenelementprops id = <circle_full_id> alpha = 1
		<obj_id> :settags custom_setlist_num = 0
	endif
	<index> = (<index> + 1)
	repeat 6
	setlist_menu :settags \{custom_setlist_num_id_1 = null
		custom_setlist_num_id_2 = null
		custom_setlist_num_id_3 = null
		custom_setlist_num_id_4 = null
		custom_setlist_num_id_5 = null
		custom_setlist_num_id_6 = null}
	reset_temp_jamsession_song_list
	set_num_songs_in_quickplay_list
	setup_custom_setlist_helpers
endscript

script create_custom_setlist_circle 
	if screenelementexists id = <id>
		<id> :gettags
		if gotparam \{custom_setlist_num}
			if (<custom_setlist_num> > 0)
				if <id> :desc_resolvealias name = alias_custom_setlist_container
					if getscreenelementchildren id = <resolved_id>
						getarraysize <children>
						if (<array_size> > 0)
							destroy_menu menu_id = (<children> [0])
						endif
					endif
					createscreenelement {
						type = containerelement
						parent = <resolved_id>
					}
					cs_container = <id>
					dims = (75.0, 75.0)
					highlight_dims = (160.0, 160.0)
					text_scale = 1.5
					text_pos = (0.0, 0.0)
					if gotparam \{use_small_circle}
						highlight_dims = (106.0, 106.0)
						dims = (50.0, 50.0)
						text_scale = 1.0
					endif
					createscreenelement {
						type = spriteelement
						parent = <cs_container>
						texture = setlist_custom_circle_lg
						dims = <dims>
						just = [center center]
						z_priority = 5
					}
					formattext textname = text qs(0x76b3fda7) d = <custom_setlist_num>
					createscreenelement {
						type = textelement
						parent = <cs_container>
						font = fontgrid_text_a8
						text = <text>
						pos = <text_pos>
						scale = <text_scale>
						rgba = [0 0 0 255]
						just = [center center]
						z_priority = 21
					}
					if gotparam \{use_small_circle}
						<cs_container> :se_setprops pos = {relative (-30.0, 0.0)}
					else
						<cs_container> :se_setprops pos = {relative (-50.0, 0.0)}
					endif
				endif
			endif
		endif
	endif
endscript

script ui_setlist_choose_song \{device_num = 0}
	if (<for_custom_setlist> = 1)
		generic_menu_pad_choose_sound
		setlist_menu :gettags
		if ($sort_restore_selections = 0)
			ui_setlist_get_next_custom_index
		else
			getarraysize \{$temp_quickplay_song_list}
			<index_max> = <array_size>
		endif
		if (<custom_index> < <index_max>)
			obj_getid
			<objid> :getsingletag custom_setlist_num
			<objid> :getsingletag jam_song
			<objid> :getsingletag example_songs
			if (<custom_setlist_num> <= 0)
				if ($sort_restore_selections = 0)
					setarrayelement arrayname = temp_quickplay_song_list globalarray index = <custom_index> newvalue = <song>
					if gotparam \{jam_song}
						if (<example_songs> = 1)
							setarrayelement arrayname = temp_jamsession_song_list globalarray index = <custom_index> newvalue = (1000 + <jam_song>)
						else
							setarrayelement arrayname = temp_jamsession_song_list globalarray index = <custom_index> newvalue = <jam_song>
						endif
					endif
				endif
				set_num_songs_in_quickplay_list
				<objid> :settags custom_setlist_num = (<custom_index> + 1)
				if ($sort_restore_selections = 1)
					create_custom_setlist_circle id = <objid> use_small_circle = 1
				else
					create_custom_setlist_circle id = <objid>
				endif
				switch (<custom_index> + 1)
					case 1
					setlist_menu :settags custom_setlist_num_id_1 = <objid>
					if NOT gotparam \{no_sound}
						soundevent \{event = quickplay_select_song}
					endif
					case 2
					setlist_menu :settags custom_setlist_num_id_2 = <objid>
					if NOT gotparam \{no_sound}
						soundevent \{event = quickplay_select_song}
					endif
					case 3
					setlist_menu :settags custom_setlist_num_id_3 = <objid>
					if NOT gotparam \{no_sound}
						soundevent \{event = quickplay_select_song}
					endif
					case 4
					setlist_menu :settags custom_setlist_num_id_4 = <objid>
					if NOT gotparam \{no_sound}
						soundevent \{event = quickplay_select_song}
					endif
					case 5
					setlist_menu :settags custom_setlist_num_id_5 = <objid>
					if NOT gotparam \{no_sound}
						soundevent \{event = quickplay_select_song}
					endif
					case 6
					setlist_menu :settags custom_setlist_num_id_6 = <objid>
					if NOT gotparam \{no_sound}
						soundevent \{event = quickplay_select_song}
					endif
				endswitch
				se_setprops {
					event_handlers = [
						{pad_choose ui_setlist_custom_remove params = {song = <song> for_custom_setlist = <for_custom_setlist>}}
					]
					replace_handlers
				}
				formattext checksumname = circle_full_id 'cs_dot_helper_circle_%d' d = (<custom_index> + 1)
				setscreenelementprops id = <circle_full_id> alpha = 0
				if NOT gotparam \{example_songs}
					setup_custom_setlist_helpers song = <song>
				else
					if (<example_songs> = 1)
						<jam_song> = (<jam_song> + 1000)
					endif
					setup_custom_setlist_helpers song = <song> jam_song = <jam_song>
				endif
			endif
		endif
	else
		obj_getid
		<objid> :getsingletag jam_song
		<objid> :getsingletag example_songs
		setarrayelement arrayname = temp_quickplay_song_list globalarray index = 0 newvalue = <song>
		if gotparam \{jam_song}
			if (<example_songs> = 1)
				setarrayelement arrayname = temp_jamsession_song_list globalarray index = 0 newvalue = (1000 + <jam_song>)
			else
				setarrayelement arrayname = temp_jamsession_song_list globalarray index = 0 newvalue = <jam_song>
			endif
		else
			setarrayelement \{arrayname = temp_jamsession_song_list
				globalarray
				index = 0
				newvalue = -1}
		endif
		ui_setlist_continue <...>
	endif
endscript

script ui_setlist_compact_and_continue 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	reset_quickplay_song_list
	change \{quickplay_song_list_current = 0}
	outer_index = 0
	inner_index = 0
	begin
	if ($temp_quickplay_song_list [<inner_index>] != null)
		setarrayelement arrayname = quickplay_song_list globalarray index = <outer_index> newvalue = ($temp_quickplay_song_list [<inner_index>])
		<outer_index> = (<outer_index> + 1)
	endif
	<inner_index> = (<inner_index> + 1)
	repeat 6
	ui_setlist_continue device_num = <device_num> song = ($quickplay_song_list [0])
endscript

script ui_setlist_continue 
	if screenelementexists \{id = setlist_menu}
		setlist_menu :menu_getselectedindex
		ui_event_add_params selected_index = <selected_index>
	endif
	if (<song> != null)
		setlist_menu :se_setprops \{block_events}
		change current_song = <song>
		change track_last_song = <song>
		setlist_menu :getsingletag \{from_leaderboard}
		if gotparam \{from_leaderboard}
			generic_menu_pad_choose_sound
			ui_leaderboard_list_select song_checksum = <song> device_num = <device_num>
			return
		endif
		if ($is_network_game = 1)

			quickplay_choose_random_venue online_song = <song>
			if search_for_tool_in_quickplay_list song = <song>
				change \{current_level = load_z_tool}
			endif
			if ($net_new_matchmaking_ui_flag = 1)
				get_player_num_from_controller controller_index = <device_num>
				getplayerinfo <player_num> net_obj_id
				if (<net_obj_id> = $online_song_choice_id)
					soundevent \{event = song_affirmation}
					spawnscriptnow \{0xb20ce9b6}

					net_request_song
				else

					return
				endif
			else
				soundevent \{event = song_affirmation}
				spawnscriptnow \{0xb20ce9b6}

				net_request_song
			endif
		else
			if search_for_tool_in_quickplay_list song = <song>
				change \{current_level = load_z_tool}
				can_change_level = 0
			else
				change \{current_level = $g_last_venue_selected}
				can_change_level = 1
			endif
			if ($practice_enabled)
				practice_check_song_for_parts
			else
				includes_double_kick = 0
				getarraysize ($quickplay_song_list)
				<i> = 0
				begin
				song_entry = ($quickplay_song_list [<i>])
				if (<song_entry> != jamsession && <song_entry> != null)
					if structurecontains structure = ($permanent_songlist_props.<song>) double_kick
						if ($permanent_songlist_props.<song_entry>.double_kick = 1)
							<includes_double_kick> = 1
							break
						endif
					endif
				endif
				<i> = (<i> + 1)
				repeat <array_size>
				spawnscriptnow \{0xb20ce9b6}
				if ($current_num_players = 1)
					change player1_device = <device_num>
				endif
				switch ($game_mode)
					case p2_coop
					case p2_pro_faceoff
					generic_event_choose state = uistate_band_difficulty data = {p2 = 1 continue_data = {state = uistate_play_song <...>}}
					case p1_quickplay
					obj_getid
					setlistinterface :settags current_id = <objid>
					setlist_menu :se_setprops \{block_events}
					generic_menu_pad_choose_sound
					generic_event_choose state = uistate_select_difficulty data = {is_popup includes_double_kick = <includes_double_kick> from_setlist = 1 ignore_camera can_change_level = <can_change_level>}
					case p2_quickplay
					case p3_quickplay
					case p4_quickplay
					setlist_menu :getsingletag \{from_top_rocker}
					if gotparam \{from_top_rocker}
						generic_event_choose state = uistate_select_difficulty data = {is_popup includes_double_kick = <includes_double_kick> from_setlist = 1 ignore_camera can_change_level = <can_change_level>}
						return
					endif
					generic_event_choose state = uistate_band_difficulty data = {continue_data = {state = uistate_play_song <...>}}
					default
					destroy_band
					setlist_menu :gettags
					if gotparam \{next_state}
						if search_for_tool_in_quickplay_list
							generic_event_choose \{state = uistate_play_song
								data = {
									selected_level = load_z_tool
									can_change_level = 0
								}}
						else
							generic_event_choose state = <next_state>
						endif
					else
						generic_event_choose \{state = uistate_play_song}
					endif
				endswitch
			endif
		endif
	endif
endscript

script ui_setlist_back 
	gamemode_gettype
	if (<show_quit_warning> = 1 || <type> = pro_faceoff)
		set_num_songs_in_quickplay_list
		if (<num_songs> > 0 || <type> = pro_faceoff)
			killspawnedscript \{name = 0x8ed8c79c}
			setlist_menu :se_setprops \{block_events}
			change \{menu_focus_color = [
					255
					255
					255
					255
				]}
			generic_event_choose \{state = uistate_setlist_quit_warning
				data = {
					is_popup
				}}
			return
		endif
	endif
	change \{sort_restore_selections = 0}
	ui_setlist_go_back
endscript

script ui_setlist_go_back 
	0xe9384b7a \{0x9fe16047}
	spawnscriptnow \{0xb20ce9b6}
	if ($is_network_game = 1)
		if ($net_song_countdown = 0)
			obj_getid
			setlistinterface :settags current_id = <objid>
			setlist_menu :se_setprops \{block_events}
			generic_menu_pad_back_sound
			generic_event_choose \{state = uistate_online_quit_warning
				data = {
					is_popup
				}
				no_sound}
		endif
	else
		additional_data = {}
		if ui_event_exists_in_stack \{name = 'gig_posters'}
			additional_data = {ignore_camera = 1}
		endif
		generic_event_back data = {num_states = <num_states> came_from_setlist = 1 <additional_data>}
	endif
endscript

script setlist_switch_sort 
	if ($is_network_game = 0 || $net_song_countdown = 0)
		0x79db87d7
		if (<for_custom_setlist> = 1)
			change \{sort_restore_selections = 1}
		endif
		change \{refresh_from_sort = 1}
		generic_menu_pad_choose_sound
		getarraysize \{$setlist_sorts}
		change setlist_sort_index = ($setlist_sort_index + 1)
		if ($setlist_sort_index >= <array_size>)
			change \{setlist_sort_index = 0}
		endif
		0xb20ce9b6
		setlist_menu :gettags \{last_focused_song}
		create_loading_screen
		wait \{15
			gameframes}
		ui_event event = menu_refresh data = {last_focused_song = <last_focused_song> for_custom_setlist = <for_custom_setlist>}
		0xf00f29a9
	endif
endscript

script setlist_create_jammode_songs 
	setlist_add_jammode_songs_list songlist = ($jam_curr_directory_listing) <...> sorted = 1
	setlist_add_jammode_songs_list songlist = ($jam_song_assets) <...> example_songs = 1 sorted = 1
	return final_num_songs = <final_num_songs>
endscript

script setlist_add_jammode_songs_list \{example_songs = 0
		sorted = 0}
	getarraysize <songlist>
	if (<array_size> = 0)
		return
	endif
	total_songs = <array_size>
	if (<sorted> = 1)
		<sortable_songlist> = []
		<i> = 0
		begin
		<jam_song_data> = (<songlist> [<i>])
		formattext checksumname = song 'jamsong_%i' i = <i>
		addarrayelement array = <sortable_songlist> element = {song_checksum = <song> song_title = (<jam_song_data>.filename) song_artist = (<jam_song_data>.artist)}
		<sortable_songlist> = <array>
		<i> = (<i> + 1)
		repeat <total_songs>
		<sortby> = ($setlist_sorts [$setlist_sort_index].name)
		if NOT ((<sortby> = title_alphabetical) || (<sortby> = artist_alphabetical))
			<sortby> = title_alphabetical
		endif
		sortandbuildsonglist songlist = <sortable_songlist> sortby = <sortby> output_indices
	else
		createindexarray <total_songs>
		<sorted_songlist_indices> = <index_array>
	endif
	get_player_num_from_controller controller_index = ($primary_controller)
	if (<player_num> >= 1)
		getplayerinfo <player_num> part
	else

		part = guitar
	endif
	i = 0
	song_index = 0
	begin
	<skip> = 1
	song_index = (<sorted_songlist_indices> [<i>])
	if NOT gotparam \{num_band_players}
		filter_songs_for_single song_struct = (<songlist> [<song_index>]) part = <part>
	else
		filter_songs_for_band song_struct = (<songlist> [<song_index>]) band_controller_types = <band_controller_types> num_band_players = <num_band_players>
	endif
	if (<skip> = 0)
		song_title = (<songlist> [<song_index>].filename)
		if structurecontains structure = (<songlist> [<song_index>]) artist
			song_artist = (<songlist> [<song_index>].artist)
		else
			song_artist = qs(0x00000000)
		endif
		song = jamsession
		beginner_skull_alpha = 1
		easy_skull_alpha = 1
		medium_skull_alpha = 1
		hard_skull_alpha = 1
		expert_skull_alpha = 1
		ghost_skull_alpha = 1
		beginner_text_alpha = 1
		easy_text_alpha = 1
		medium_text_alpha = 1
		hard_text_alpha = 1
		expert_text_alpha = 1
		ghost_text_alpha = 0
		highest_difficulty_texture = icon_difficulty_beginner
		highest_difficulty_alpha = 0
		score = 0
		get_difficulty_text_nl \{difficulty = beginner}
		get_formatted_songname_for_jam_mode song_prefix = <song_title> difficulty_text_nl = <difficulty_text_nl> part = ($part_list_props.<part>.text_nl)
		getglobaltags <songname> params = score noassert = 1
		formattext textname = score_beginner_text qs(0x4d4555da) s = <score>
		if (<score> = 0)
			<beginner_skull_alpha> = <ghost_skull_alpha>
			<beginner_text_alpha> = <ghost_text_alpha>
		else
			<highest_difficulty_texture> = icon_difficulty_beginner
			<highest_difficulty_alpha> = 1
		endif
		score = 0
		get_difficulty_text_nl \{difficulty = easy}
		get_formatted_songname_for_jam_mode song_prefix = <song_title> difficulty_text_nl = <difficulty_text_nl> part = ($part_list_props.<part>.text_nl)
		getglobaltags <songname> params = score noassert = 1
		formattext textname = score_easy_text qs(0x4d4555da) s = <score>
		if (<score> = 0)
			<easy_skull_alpha> = <ghost_skull_alpha>
			<easy_text_alpha> = <ghost_text_alpha>
		else
			<highest_difficulty_texture> = icon_difficulty_easy
			<highest_difficulty_alpha> = 1
		endif
		score = 0
		get_difficulty_text_nl \{difficulty = medium}
		get_formatted_songname_for_jam_mode song_prefix = <song_title> difficulty_text_nl = <difficulty_text_nl> part = ($part_list_props.<part>.text_nl)
		getglobaltags <songname> params = score noassert = 1
		formattext textname = score_medium_text qs(0x4d4555da) s = <score>
		if (<score> = 0)
			<medium_skull_alpha> = <ghost_skull_alpha>
			<medium_text_alpha> = <ghost_text_alpha>
		else
			<highest_difficulty_texture> = icon_difficulty_medium
			<highest_difficulty_alpha> = 1
		endif
		score = 0
		get_difficulty_text_nl \{difficulty = hard}
		get_formatted_songname_for_jam_mode song_prefix = <song_title> difficulty_text_nl = <difficulty_text_nl> part = ($part_list_props.<part>.text_nl)
		getglobaltags <songname> params = score noassert = 1
		formattext textname = score_hard_text qs(0x4d4555da) s = <score>
		if (<score> = 0)
			<hard_skull_alpha> = <ghost_skull_alpha>
			<hard_text_alpha> = <ghost_text_alpha>
		else
			<highest_difficulty_texture> = icon_difficulty_hard
			<highest_difficulty_alpha> = 1
		endif
		score = 0
		<expert_plus_icon_alpha> = 0
		get_difficulty_text_nl \{difficulty = expert}
		get_formatted_songname_for_jam_mode song_prefix = <song_title> difficulty_text_nl = <difficulty_text_nl> part = ($part_list_props.<part>.text_nl)
		getglobaltags <songname> params = score noassert = 1
		formattext textname = score_expert_text qs(0x4d4555da) s = <score>
		if (<score> = 0)
			<expert_skull_alpha> = <ghost_skull_alpha>
			<expert_text_alpha> = <ghost_text_alpha>
		else
			<highest_difficulty_texture> = icon_difficulty_expert
			<highest_difficulty_alpha> = 1
			get_formatted_songname song_prefix = <song_prefix> difficulty_text_nl = 'expert' part = ($part_list_props.<part>.text_nl)
			getglobaltags <songname> param = tr_double_bass_complete
			if (<tr_double_bass_complete> = 1)
				<expert_plus_icon_alpha> = 1
				<highest_difficulty_alpha> = 0
			endif
		endif
		gamemode_gettype
		if (<type> = pro_faceoff)
			<highest_difficulty_alpha> = 0
		endif
		score_text = {
			score_beginner_text = <score_beginner_text>
			score_easy_text = <score_easy_text>
			score_medium_text = <score_medium_text>
			score_hard_text = <score_hard_text>
			score_expert_text = <score_expert_text>
			icon_difficulty_beginner_alpha = <beginner_skull_alpha>
			icon_difficulty_easy_alpha = <easy_skull_alpha>
			icon_difficulty_medium_alpha = <medium_skull_alpha>
			icon_difficulty_hard_alpha = <hard_skull_alpha>
			icon_difficulty_expert_alpha = <expert_skull_alpha>
			score_beginner_alpha = <beginner_text_alpha>
			score_easy_alpha = <easy_text_alpha>
			score_medium_alpha = <medium_text_alpha>
			score_hard_alpha = <hard_text_alpha>
			score_expert_alpha = <expert_text_alpha>
		}
		skull_tags = {
			icon_difficulty_texture = <highest_difficulty_texture>
			icon_difficulty_alpha = <highest_difficulty_alpha>
		}
		formattext textname = song_text qs(0x90e80fb9) a = <song_artist> t = <song_title>
		createscreenelement {
			parent = setlist_menu
			type = descinterface
			desc = 'setlist_b_listing_desc'
			auto_dims = false
			dims = (0.0, 50.0)
			event_handlers = [
				{focus ui_setlist_focus_song params = {for_custom_setlist = <for_custom_setlist>}}
				{unfocus ui_setlist_unfocus_song}
			]
			tags = {
				custom_setlist_num = 0
				song_title = <song_title>
				song_artist = <song_artist>
				score_text = <score_text>
				skull_tags = <skull_tags>
				song = jamsession
				index = <final_num_songs>
				jam_song = <song_index>
				example_songs = <example_songs>
			}
			just = [center center]
			listing_text = <song_text>
			<skull_tags>
		}
		if ($is_network_game = 1)
			if local_player_is_choosing_song
				<id> :se_setprops event_handlers = [{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist> jam_song = <song_index> example_songs = <example_songs>}}]
			endif
		else
			<id> :se_setprops event_handlers = [{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist> jam_song = <song_index> example_songs = <example_songs>}}]
		endif
		if ($sort_restore_selections = 1)
			if (<example_songs> = 1)
				<song_index> = (<song_index> + 1000)
			endif
			get_song_index_from_temp_jamsession_song_list jam_song = <song_index>
			if (<jamsession_index> != -1)
				<id> :ui_setlist_choose_song {
					for_custom_setlist = <for_custom_setlist>
					song = <song>
					custom_index = <jamsession_index>
					no_sound
				}
			endif
		endif
		<final_num_songs> = (<final_num_songs> + 1)
	endif
	i = (<i> + 1)
	repeat <total_songs>
	return final_num_songs = <final_num_songs>
endscript

script filter_songs_for_single 
	if structurecontains structure = <song_struct> no_qp
		return \{skip = 1}
	endif
	<skip_it> = 0
	<playback_value> = 0
	if structurecontains structure = <song_struct> playback_track1
		if (<part> = guitar)
			<playback_value> = (<song_struct>.playback_track1)
			if (<playback_value> = -1)
				<skip_it> = 1
			endif
		elseif (<part> = bass)
			<playback_value> = (<song_struct>.playback_track2)
			if (<playback_value> = -1)
				<skip_it> = 1
			endif
		elseif (<part> = drum)
			<playback_value> = (<song_struct>.playback_track_drums)
			if (<playback_value> = 0)
				<skip_it> = 1
			endif
		elseif (<part> = vocals)
			<playback_value> = (<song_struct>.playback_track_vocals)
			if (<playback_value> = 0)
				<skip_it> = 1
			endif
		endif
	endif
	return skip = <skip_it>
endscript

script filter_songs_for_band 
	if structurecontains structure = <song_struct> no_qp
		return \{skip = 1}
	endif
	i = 0
	track1_used = 0
	begin
	<player_controller> = (<band_controller_types> [<i>])
	switch (<player_controller>)
		case 1
		satisfied = 0
		if ((<song_struct>.playback_track1) > -1)
			if (<track1_used> = 0)
				satisfied = 1
				track1_used = 1
			endif
		endif
		if (<satisfied> = 0)
			if ((<song_struct>.playback_track2) > -1)
				satisfied = 1
			endif
		endif
		if (<satisfied> = 0)

			return \{skip = 1}
		endif
		case 2
		if ((<song_struct>.playback_track_drums) = 0)

			return \{skip = 1}
		endif
		case 3
		if ((<song_struct>.playback_track_vocals) = 0)

			return \{skip = 1}
		endif
	endswitch
	<i> = (<i> + 1)
	repeat 4
	return \{skip = 0}
endscript

script search_for_tool_in_quickplay_list \{song = null}
	getarraysize \{$quickplay_song_list}
	i = 0
	begin
	if ($quickplay_song_list [<i>] = parabola || <song> = parabola)
		return \{true}
	endif
	if ($quickplay_song_list [<i>] = schism || <song> = schism)
		return \{true}
	endif
	if ($quickplay_song_list [<i>] = vicarious || <song> = vicarious)
		return \{true}
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script setlist_drop_player 

endscript

script setlist_end_game 


	if ((<is_game_over> = 1) && ($net_popup_active = 0))
		wait_for_safe_shutdown
		if screenelementexists \{id = setlist_menu}
			launchevent \{type = unfocus
				target = setlist_menu}
		endif
		if screenelementexists \{id = net_setlist_popup_container}
			destroyscreenelement \{id = net_setlist_popup_container}
		endif
		if screenelementexists \{id = net_setlist_spinner}
			destroyscreenelement \{id = net_setlist_spinner}
		endif
		create_net_popup \{title = qs(0x5ca2c535)
			popup_text = qs(0x32f94482)}
		if screenelementexists \{id = dialog_box_desc_id}
			dialog_box_desc_id :obj_spawnscriptnow \{setlist_end_game_spawned
				id = not_ui_player_drop_scripts}
		endif
	endif
endscript

script setlist_end_game_spawned 
	wait \{3
		seconds}
	destroy_net_popup
	onexitrun \{destroy_flaming_wait}
	wait \{1
		gameframe}
	net_clear_all_remote_player_status
	quit_network_game
	generic_event_back \{state = uistate_online}
endscript

script setlist_get_jammode_playback_tracks 
	if (<example_songs> = 1)
		if (<jam_song> >= 1000)
			<jam_song> = (<jam_song> - 1000)
		endif
		<song_array> = ($jam_song_assets)
	else
		<song_array> = ($jam_curr_directory_listing)
	endif
	getarraysize <song_array>
	if NOT (<jam_song> < <array_size>)


		return
	endif
	return (<song_array> [<jam_song>])
endscript

script ui_setlist_popups 

	change \{ui_setlist_skip_helpers = 0}
	if ((gotparam from_top_rocker) || (gotparam from_leaderboard))
		return
	endif
	get_current_band_info
	getglobaltags <band_info>
	if (<first_quickplay_setlist> = 1 && $is_network_game = 0)
		if ($game_mode != p1_quickplay &&
				$game_mode != p2_quickplay &&
				$game_mode != p3_quickplay &&
				$game_mode != p4_quickplay)
			return
		endif
		change \{ui_setlist_skip_helpers = 1}
		ui_event_wait \{state = uistate_setlist_prompt
			data = {
				is_popup
			}}
		setglobaltags <band_info> params = {first_quickplay_setlist = 0}
	else
		show_doublekick = 0
		i = 1
		begin
		getplayerinfo <i> controller
		getplayerinfo <i> part
		if isdrumcontroller controller = <controller>
			part = drum
		endif
		if (<part> = drum)
			gamemode_gettype
			if (<type> = career)
				getplayerinfo <i> double_kick_drum
				show_doublekick = <double_kick_drum>
			else
				show_doublekick = 1
			endif
			break
		endif
		i = (<i> + 1)
		repeat ($current_num_players)
		if (<show_doublekick> = 1)
			getglobaltags <band_info> params = {first_setlist_drum}
			if (<first_setlist_drum> = 1 && (<first_career_setlist> = 0 || <first_quickplay_setlist> = 0))
				change \{ui_gig_posters_skip_helpers = 1}
				ui_event_wait \{state = uistate_double_bass_popup
					data = {
						is_popup
					}}
				setglobaltags <band_info> params = {first_setlist_drum = 0}
			endif
		endif
	endif
endscript

script 0x5f22ab77 
	create_loading_screen
	wait \{15
		gameframes}
endscript

script 0x53c4b886 
	return
	if ($game_mode = gh4_p1_career || $game_mode = gh4_p2_career ||
			$game_mode = gh4_p3_career || $game_mode = gh4_p4_career)
		add_user_control_helper \{text = qs(0xd9242d03)
			button = blue
			z = 100}
	endif
endscript

script 0x8ed8c79c 
	0x3781e6f3 \{1
		gameframes}
	if NOT gotparam \{from_top_rocker}
		j = 1
		begin
		removeparameter \{controller}
		getplayerinfo <j> controller
		if (<controller> = ($primary_controller))
			getplayerinfo <j> part
			break
		endif
		j = (<j> + 1)
		repeat ($current_num_players)
		if (<part> = bass)
			0x107666a2 = guitar
		else
			0x107666a2 = <part>
		endif
	else
		getcontrollertype controller = ($primary_controller)
		0x107666a2 = <controller_type>
	endif
	begin
	getactivecontrollers
	<is_active_controller> = (<active_controllers> [($primary_controller)])
	getcontrollertype controller = ($primary_controller)
	if NOT (<is_active_controller> = 1)
		wait \{1
			gameframe}
		getactivecontrollers
		<is_active_controller> = (<active_controllers> [($primary_controller)])
	endif
	0x663ef430 = 0
	if NOT (<is_active_controller> = 1)
		0x663ef430 = 1
	elseif NOT (<controller_type> = <0x107666a2>)
		0x663ef430 = 1
		if (<0x107666a2> = vocals)
			0x663ef430 = 0
		endif
	endif
	if (<0x663ef430> = 1)
		if NOT gotparam \{0xb5b8c63e}
			0x0d7f1010 match_type = <0x107666a2> 0x481c5af8 = <0x481c5af8> from_top_rocker = <from_top_rocker>
		else
			generic_event_back \{data = {
					num_states = 1
					came_from_setlist = 1
				}}
		endif
	endif
	wait \{5
		gameframes}
	repeat
endscript

script 0x53a2de7f 
	change \{rocking_out_too_hard = 0}
endscript

script 0xd5f49235 

	getactivecontrollers
	is_active_controller = (<active_controllers> [($primary_controller)])
	getcontrollertype controller = ($primary_controller)
	if NOT ((<is_active_controller> = 1) && (<match_type> = <controller_type>))
		return \{false}
	endif
	if gotparam \{0xbca1f0dc}
		destroy_dialog_box
	endif
	if ispakloaded \{'pak/ui/controller_disconnect.pak'
			heap = bottomupheap}
		unloadpak \{'pak/ui/controller_disconnect.pak'
			heap = bottomupheap}
	endif
	0xbd6424fc
	return \{true}
endscript

script 0x0d7f1010 
	0x79db87d7
	onexitrun \{0xf00f29a9}
	begin
	if NOT screenelementexists \{id = dialog_box_container}
		break
	endif
	waitonegameframe
	repeat
	if 0xd5f49235 match_type = <match_type>
		return
	endif
	0x1621ea7b
	loadpak \{'pak/ui/controller_disconnect.pak'
		heap = bottomupheap}
	begin
	if ispakloaded \{'pak/ui/controller_disconnect.pak'
			heap = bottomupheap}
		break
	endif
	wait \{5
		gameframes}
	repeat
	if 0xd5f49235 match_type = <match_type>
		return
	endif
	0x4982f585 text = qs(0xfbc815c6) from_top_rocker = <from_top_rocker>
	create_dialog_box {
		heading_text = qs(0xaa163738)
		body_text = <text>
		dlg_z_priority = ($ps3_fade_overlay_z + 100)
		template = no_options
		0x481c5af8
	}
	begin
	if 0xd5f49235 match_type = <match_type> 0xbca1f0dc
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
		return
	endif
	wait \{5
		gameframes}
	repeat
endscript

script 0x4982f585 \{text = qs(0x00000000)}
	j = 1
	begin
	removeparameter \{controller}
	getplayerinfo <j> controller
	if (<controller> = ($primary_controller))
		getplayerinfo <j> part
		break
	endif
	j = (<j> + 1)
	repeat ($current_num_players)
	if (gotparam from_top_rocker)
		part = $0x50e507a2
		if NOT ((<part> = guitar) || (<part> = drum) || (part = vocals))
			0xee45d8be qs(0x6d0b0be3) t = <part>
		endif
	endif
	if ($vocal_mic_invalid_dist = 0)
		if ((<part> = guitar) || (<part> = bass))
			formattext textname = text qs(0x2e301f7d) t = <text> j = <j>
		endif
		if (<part> = drum)
			if (($unknown_drum_type) = 1)
				formattext textname = text qs(0x91d2ab93) t = <text> j = <j>
				usefourlanehighway player = <j> reset
			else
				getplayerinfo <j> four_lane_highway
				if (<four_lane_highway> = 1)
					formattext textname = text qs(0x43606ed7) t = <text> j = <j>
				elseif (<four_lane_highway> = 0)
					formattext textname = text qs(0x35c306d4) t = <text> j = <j>
				else
					formattext textname = text qs(0x91d2ab93) t = <text> j = <j>
					change \{unknown_drum_type = 1}
					usefourlanehighway player = <j> reset
				endif
			endif
		endif
	endif
	if (<part> = vocals)
		getplayerinfo <j> mic_connected
		switch <mic_connected>
			case mic_disconnected
			formattext textname = text qs(0xa8485a04) t = <text> j = <j>
			case both_disconnected
			formattext textname = text qs(0x79b97466) t = <text> j = <j>
			case controller_disconnected
			default
			formattext textname = text qs(0xda0aedbd) t = <text> j = <j>
		endswitch
	endif
	return text = <text>
endscript
