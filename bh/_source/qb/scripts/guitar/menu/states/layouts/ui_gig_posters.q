ui_gig_movies_info = [
	{
		movie = 'venue_cut_mall'
		watched_id = venue_cut_mall_watched
	}
	{
		movie = 'venue_cut_montreux'
		watched_id = venue_cut_montreux_watched
	}
	{
		movie = 'venue_cut_cabo'
		watched_id = venue_cut_cabo_watched
	}
	{
		movie = 'venue_cut_centralpark'
		watched_id = venue_cut_centralpark_watched
	}
	{
		movie = 'venue_cut_tokyo'
		watched_id = venue_cut_tokyo_watched
	}
	{
		movie = 'venue_cut_madrid'
		watched_id = venue_cut_madrid_watched
	}
	{
		movie = 'venue_cut_awardshow'
		watched_id = venue_cut_awardshow_watched
	}
	{
		movie = 'venue_cut_gorge'
		watched_id = venue_cut_gorge_watched
	}
	{
		movie = 'venue_cut_paris'
		watched_id = venue_cut_paris_watched
	}
	{
		movie = 'venue_cut_space'
		watched_id = venue_cut_space_watched
	}
]
current_song_info_id = null
ui_gig_posters_skip_helpers = 1
next_selected_song = 1

script ui_init_gig_posters 
	cas_destroy_all_characters
endscript

script ui_create_gig_posters 
	KillSpawnedScript \{name = Loading_Screen_Crowd_Swell}
	KillSpawnedScript \{name = Crowd_Loading_Whistle}
	KillSpawnedScript \{name = OneShotsBetweenSongs}
	KillSpawnedScript \{name = SurgeBetweenSongs}
	spawnscriptnow \{destroy_songpreview}
	if NOT ($game_mode = practice || $game_mode = practice)
		spawnscriptnow \{Skate8_SFX_Backgrounds_New_Area
			params = {
				BG_SFX_Area = FrontEnd_Menu_Music
			}}
	endif
	clean_up_user_control_helpers
	if ($current_num_players = 1)
		exclusive_device = ($primary_controller)
	else
		exclusive_device = $band_mode_current_leader
	endif
	hide_glitch \{num_frames = 3}
	fadetoblack \{on
		alpha = 1.0
		time = 0
		z_priority = 200}
	if ($signin_change_happening = 1)
		return
	endif
	CreateScreenElement {
		parent = root_window
		id = SetlistInterface
		type = DescInterface
		desc = 'setlist_b'
		exclusive_device = <exclusive_device>
	}
	CreateScreenElement \{parent = root_window
		type = DescInterface
		desc = 'setlist_b_head_desc'
		id = setlist_header
		auto_dims = false
		dims = (0.0, 300.0)
		just = [
			center
			center
		]
		setlist_b_head_text_text = qs("GIGS")
		not_focusable}
	if NOT GotParam \{use_all_controllers}
		change \{rocking_out_too_hard = 1}
		SetlistInterface :obj_spawnscript setlist_controller_response params = {from_top_rocker = <from_top_rocker>}
	endif
	spawnscriptnow ui_create_gig_posters_spawned params = <...>
endscript

script ui_create_gig_posters_spawned 
	if NOT GotParam \{gig_index}
		<gig_index> = ($ui_select_venue_info.($current_level).index)
	endif
	change \{rich_presence_context = presence_gigboard_and_setlist}
	get_current_band_info
	GetGlobalTags <band_info>
	tier_global = GH4_Career_Band_Songs
	change \{current_progression_flag = Career_Band}
	part = Band
	check = <career_intro_band_complete>
	if (($current_num_players = 1) && ($is_network_game = 0))
		GetPlayerInfo \{1
			part}
	endif
	if (<part> = guitar)
		tier_global = GH4_Career_Guitar_Songs
		change \{current_progression_flag = Career_Guitar}
	elseif (<part> = Bass)
		tier_global = GH4_Career_Bass_Songs
		change \{current_progression_flag = Career_Bass}
	elseif (<part> = drum)
		tier_global = GH4_Career_Drum_Songs
		change \{current_progression_flag = Career_Drum}
	elseif (<part> = Vocals)
		tier_global = GH4_Career_Vocals_Songs
		change \{current_progression_flag = Career_Vocals}
	endif
	progression_get_total_stars
	ui_gig_posters_check_movies_played part = <part>
	InputHandlerForbid
	get_progression_globals ($current_progression_flag)
	setlist_prefix = ($<tier_global>.prefix)
	if ($current_progression_flag = Career_Band)
		GetSavegameFromController controller = ($band_mode_current_leader)
	else
		GetSavegameFromController controller = ($primary_controller)
	endif
	wait_for \{condition = {
			songpreview_is_safe
		}}
	Menu_Music_Off
	gig_posters_song_focus
	if ($current_num_players = 1)
		update_ingame_controllers controller = <exclusive_device>
	endif
	if SetlistInterface :Desc_ResolveAlias \{name = alias_setlist_menu}
		pad_back_script = generic_event_back
		pad_back_params = {gig_index = <gig_index>}
		if GotParam \{save_on_back}
			pad_back_script = ui_memcard_autosave_replace
			pad_back_params = {<pad_back_params> data = {all_active_players = true}}
		endif
		AssignAlias id = <resolved_id> alias = setlist_menu
		setlist_menu :SE_SetProps {
			event_handlers = [
				{pad_up generic_menu_up_or_down_sound params = {up}}
				{pad_down generic_menu_up_or_down_sound params = {down}}
				{pad_back ui_gig_posters_choose_back params = <pad_back_params>}
				{focus ui_gig_posters_popups}
			]
			tags = {
				from_top_rocker = <from_top_rocker>
				from_leaderboard = <from_leaderboard>
				for_custom_setlist = 0
				current_section = 1
				last_focused_song = none
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
	if GotParam \{next_state}
		setlist_menu :SetTags next_state = <next_state>
	endif
	setlist_menu :SE_SetProps \{event_handlers = [
			{
				pad_option
				setlist_jump_down_section
				params = {
					for_custom_setlist = 0
				}
			}
		]}
	SpawnScriptLater ui_gig_posters_anim_in params = {<...>}
endscript

script ui_gig_posters_anim_in 
	ui_event_wait_for_safe
	menu_index = 1
	last_title_index = 1
	<final_num_songs> = 0
	setlist_menu :SetTags \{highlight = 0}
	SetButtonEventMappings \{block_menu_input}
	i = 1
	FormatText checksumname = tier 'tier%n' n = <gig_index>
	if NOT StructureContains Structure = ($<tier_global>) <tier>
		debug_ScriptAssert \{'Tier does not exist in selected career progression'}
	endif
	if StructureContains Structure = ($<tier_global>.<tier>) stars

		if (($<tier_global>.<tier>.stars) <= <total_stars>)
			get_prev_total_songs part = <part> band_info = <band_info> final_num_songs = <final_num_songs>
			if NOT StructureContains Structure = ($<tier_global>.<tier>) level
				debug_ScriptAssert \{'no level for tier'}
			endif
			title = (($LevelZones).($<tier_global>.<tier>.level).title)
			CreateScreenElement {
				parent = setlist_menu
				type = DescInterface
				desc = 'setlist_b_divider_desc'
				auto_dims = false
				alpha = 0
				dims = (0.0, 50.0)
				setlist_divider_title_text = <title>
				not_focusable
				tags = {
					tier_index = <gig_index>
				}
			}
			<id> :SE_SetProps alpha = 1
			menu_index = (<menu_index> + 1)
			last_title_index = <menu_index>
			if StructureContains Structure = ($<tier_global>.<tier>) songs
				i = 0
				begin
				if (<i> = 0)
					songs = ($<tier_global>.<tier>.songs)
				elseif (<i> = 1)
					if StructureContains Structure = ($<tier_global>.<tier>) unlockable_songs
						songs = ($<tier_global>.<tier>.unlockable_songs)
					else
						break
					endif
				endif
				GetArraySize <songs>
				num_songs = <array_size>
				j = 0
				begin
				song = (<songs> [<j>])
				get_song_title song = <song>
				get_song_artist song = <song>
				ui_gig_posters_get_scores_and_tags song = <song> part = <part> savegame = <savegame>
				GetPlayerInfo \{1
					double_kick_drum}
				<double_kick_alpha> = 0
				format_globaltag_song_checksum part = ($<tier_global>.part) song = <song>
				GetGlobalTags <song_checksum> param = unlocked
				GetGlobalTags <song_checksum> param = double_bass_complete
				GetGlobalTags <song_checksum> param = new_song_info
				event_handlers = [
					{focus ui_gig_posters_focus params = {for_custom_setlist = 0}}
					{unfocus ui_gig_posters_unfocus}
					{pad_choose ui_gig_posters_play_song params = {song = <song> level = ($<tier_global>.<tier>.level) tier_num = <gig_index> unlocked = <unlocked>}}
					{pad_l1 ui_gig_posters_debug_complete params = {song = <song> song_checksum = <song_checksum>}}
				]
				get_song_text unlocked = <unlocked> song_title = <song_title> song_artist = <song_artist>
				CreateScreenElement {
					parent = setlist_menu
					type = DescInterface
					desc = 'setlist_b_listing_desc'
					alpha = 0
					auto_dims = false
					dims = (0.0, 80.0)
					double_kick_alpha = <double_kick_alpha>
					stars_alpha = 1.0
					event_handlers = <event_handlers>
					tags = {
						custom_setlist_num = 0
						song_title = <song_title>
						song_artist = <song_artist>
						score_text = <score_text>
						song = <song>
						part = <part>
						index = <final_num_songs>
						unlocked = <unlocked>
						new_song_info = <new_song_info>
						beginner_stars = (<stars_tags>.beginner_stars)
						easy_stars = (<stars_tags>.easy_stars)
						medium_stars = (<stars_tags>.medium_stars)
						hard_stars = (<stars_tags>.hard_stars)
						expert_stars = (<stars_tags>.expert_stars)
						beginner_percent100 = (<stars_tags>.beginner_percent100)
						easy_percent100 = (<stars_tags>.easy_percent100)
						medium_percent100 = (<stars_tags>.medium_percent100)
						hard_percent100 = (<stars_tags>.hard_percent100)
						expert_percent100 = (<stars_tags>.expert_percent100)
						double_bass_complete = <double_bass_complete>
						icon_difficulty_texture = (<difficulty_tags>.icon_difficulty_texture)
						icon_difficulty_alpha = (<difficulty_tags>.icon_difficulty_alpha)
						highest_stars_difficulty_text = (<difficulty_tags>.highest_stars_difficulty_text)
						highest_stars_difficulty_index = (<difficulty_tags>.highest_stars_difficulty_index)
					}
					just = [center center]
					listing_text = <song_text>
					text_difficulty_text = (<difficulty_tags>.highest_stars_difficulty_text)
				}
				if <id> :Desc_ResolveAlias name = alias_listing
					GetScreenElementChildren id = <resolved_id>
					GetScreenElementPosition id = <resolved_id> summed
					<text_pos> = <screenelementpos>
					GetScreenElementProps id = (<children> [0]) force_update
					<width> = (<dims>.(1.0, 0.0) * <scale>.(1.0, 0.0))
					<double_kick_offset> = ((1.0, 0.0) * ((<width> / 2) + 42) + (0.0, 1.0))
					<new_pos> = (<text_pos> - <double_kick_offset>)
					<id> :SE_SetProps double_kick_pos = <new_pos>
				endif
				percent_diffs = ['beginner' 'easy' 'medium' 'hard' 'expert']
				percent_aliases = [
					alias_Setlist_B_stars_beginner
					alias_Setlist_B_stars_easy
					alias_Setlist_B_stars_medium
					alias_Setlist_B_stars_hard
					alias_Setlist_B_stars_expert
				]
				star_diffs = [
					beginner_stars
					easy_stars
					medium_stars
					hard_stars
					expert_stars
				]
				FormatText checksumname = percent100 '%s_percent100' s = (<percent_diffs> [(<difficulty_tags>.highest_stars_difficulty_index)])
				if <id> :Desc_ResolveAlias name = alias_stars
					percent_param = (<stars_tags>.<percent100>)
					if GotParam \{percent_param}
						if (<percent_param> = 1)
							<id> :SE_SetProps star_rgba = [255 255 255 175]
						endif
					endif
					GetScreenElementChildren id = <resolved_id>
					num_stars = (<stars_tags>.(<star_diffs> [(<difficulty_tags>.highest_stars_difficulty_index)]))
					if (<num_stars> = 0)
						<resolved_id> :SE_SetProps alpha = 0
					else
						GetArraySize <children>
						stars_left = (<array_size> - 1)
						if (<num_stars> < 5 && <stars_left> = 5)
							if ScreenElementExists id = (<children> [(4 + 1)])
								DestroyScreenElement id = (<children> [(4 + 1)])
								stars_left = (<stars_left> - 1)
							endif
						endif
						if (<num_stars> < 4 && <stars_left> = 4)
							if ScreenElementExists id = (<children> [(3 + 1)])
								DestroyScreenElement id = (<children> [(3 + 1)])
							endif
						endif
					endif
				endif
				<final_num_songs> = (<final_num_songs> + 1)
				menu_index = (<menu_index> + 1)
				if GotParam \{last_listing_id}
					<last_listing_id> :SetTags fading_in = 1
					LaunchEvent target = setlist_menu data = {child_id = <last_listing_id>} type = unfocus
				endif
				last_listing_id = <id>
				<id> :SE_SetProps alpha = 1
				j = (<j> + 1)
				repeat <num_songs>
				i = (<i> + 1)
				repeat 2
			endif
		endif
	endif
	SetButtonEventMappings \{unblock_menu_input}
	setlist_menu :SetTags \{highlight = 1}
	set_prev_total_songs part = <part> band_info = <band_info> final_num_songs = <final_num_songs>
	setlist_menu :SetTags total_songs = <final_num_songs> prev_index = 0
	spawnscriptnow \{destroy_songpreview}
	if ($is_network_game = 0)
		spawnscriptnow \{create_songpreview}
	endif
	num_gigs = ($<tier_global>.num_tiers)
	smallest_diff = 999
	i = 0
	begin
	if (<i> >= <gig_index>)
		FormatText checksumname = next_tier 'tier%n' n = (<i> + 1)
		stars_needed = ($<tier_global>.<next_tier>.stars)
		diff = (<stars_needed> - <total_stars>)
		if (<diff> > 0)
			if (<diff> < <smallest_diff>)
				<smallest_diff> = <diff>
			endif
		endif
	endif
	<i> = (<i> + 1)
	repeat <num_gigs>
	FormatText checksumname = next_tier 'tier%n' n = (<gig_index> + 1)
	if NOT (<smallest_diff> = 999)
		if (<smallest_diff> > 1)
			FormatText TextName = stars_to_next_tier qs(0x507aeb0e) n = <smallest_diff>
		else
			FormatText TextName = stars_to_next_tier qs(0xbde57913) n = <smallest_diff>
		endif
		CreateScreenElement {
			parent = setlist_menu
			type = DescInterface
			desc = 'setlist_b_divider_desc'
			auto_dims = false
			dims = (0.0, 50.0)
			setlist_divider_title_text = <stars_to_next_tier>
			setlist_list_divider_L_alpha = 1
			setlist_list_divider_R_alpha = 1
			not_focusable
		}
	endif
	<max_songs> = 0
	<i> = 1
	begin
	FormatText checksumname = tier 'tier%n' n = <i>
	if StructureContains Structure = ($<tier_global>.<tier>) songs
		GetArraySize ($<tier_global>.<tier>.songs)
		<max_songs> = (<max_songs> + <array_size>)
	endif
	if StructureContains Structure = ($<tier_global>.<tier>) unlockable_songs
		GetArraySize ($<tier_global>.<tier>.unlockable_songs)
		<max_songs> = (<max_songs> + <array_size>)
	endif
	<i> = (<i> + 1)
	repeat (($<tier_global>).num_tiers)
	FormatText TextName = number_of_stars_text qs(0xe0694eb8) n = <total_stars> m = (<max_songs> * 5)
	SetlistInterface :SE_SetProps number_of_stars_text = <number_of_stars_text>
	SetlistInterface :SE_SetProps \{scribble_lower_alpha = 1}
	menu_finish
	if ($enable_button_cheats = 1)
		add_user_control_helper \{text = qs("\LBEAT SONG")
			button = LB
			z = 100000}
	endif
	LaunchEvent \{target = setlist_menu
		data = {
			child_index = $next_selected_song
		}
		type = focus}
	fadetoblack \{off
		time = 0}
	InputHandlerPermit
	BroadcastEvent \{type = setlist_created}
endscript

script ui_gig_posters_play_venue_movie 

	GetArraySize \{$ui_gig_movies_info}
	if (<venue_index> >= <array_size>)
		return
	endif
	movie_info = ($ui_gig_movies_info [<venue_index>])
	movie = (<movie_info>.movie)
	watched_id = (<movie_info>.watched_id)
	if NOT GlobalTagExists <watched_id> noassert = 1
		get_movie_id_by_name movie = <movie>
		GetGlobalTags <id> param = unlocked
		if NOT (<unlocked> = 1)
			ui_event_wait_for_safe
			Menu_Music_Off
			PlayMovieAndWait movie = <movie> focus
			menu_music_on
			LockGlobalTags \{off}
			SetGlobalTags <id> params = {unlocked = 1} all_active_players = 1
			LockGlobalTags
		endif
	endif
endscript

script ui_gig_posters_get_scores_and_tags 
	get_song_prefix song = <song>
	beginner_skull_alpha = 0
	easy_skull_alpha = 0
	medium_skull_alpha = 0
	hard_skull_alpha = 0
	expert_skull_alpha = 0
	ghost_skull_alpha = 0
	beginner_text_alpha = 0
	easy_text_alpha = 0
	medium_text_alpha = 0
	hard_text_alpha = 0
	expert_text_alpha = 0
	ghost_text_alpha = 0
	highest_stars_difficulty_texture = icon_difficulty_beginner
	highest_stars_difficulty_alpha = 0
	highest_stars_difficulty_text = qs("Beginner")
	highest_stars_difficulty_index = 0
	highest_stars = 3
	completed = 0
	GameMode_GetType
	<game_mode_type> = <type>
	format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'beginner'
	GetGlobalTags <song_checksum> param = score savegame = <savegame>
	FormatText TextName = score_beginner_text qs("%s") s = <score>
	if (<score> = 0 || $game_mode = practice)
		<beginner_skull_alpha> = <ghost_skull_alpha>
		<beginner_text_alpha> = <ghost_text_alpha>
	else
		<completed> = 1
	endif
	format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'easy'
	GetGlobalTags <song_checksum> param = score savegame = <savegame>
	FormatText TextName = score_easy_text qs("%s") s = <score>
	if (<score> = 0 || $game_mode = practice)
		<easy_skull_alpha> = <ghost_skull_alpha>
		<easy_text_alpha> = <ghost_text_alpha>
	else
		<completed> = 1
	endif
	format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'medium'
	GetGlobalTags <song_checksum> param = score savegame = <savegame>
	FormatText TextName = score_medium_text qs("%s") s = <score>
	if (<score> = 0 || $game_mode = practice)
		<medium_skull_alpha> = <ghost_skull_alpha>
		<medium_text_alpha> = <ghost_text_alpha>
	else
		<completed> = 1
	endif
	format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'hard'
	GetGlobalTags <song_checksum> param = score savegame = <savegame>
	FormatText TextName = score_hard_text qs("%s") s = <score>
	if (<score> = 0 || $game_mode = practice)
		<hard_skull_alpha> = <ghost_skull_alpha>
		<hard_text_alpha> = <ghost_text_alpha>
	else
		<completed> = 1
	endif
	format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'expert'
	GetGlobalTags <song_checksum> param = score savegame = <savegame>
	FormatText TextName = score_expert_text qs("%s") s = <score>
	if (<score> = 0 || $game_mode = practice)
		<expert_skull_alpha> = <ghost_skull_alpha>
		<expert_text_alpha> = <ghost_text_alpha>
	else
		<completed> = 1
	endif
	format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'beginner'
	GetGlobalTags <song_checksum> param = stars savegame = <savegame>
	GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
	if (<stars> >= <highest_stars>)
		<highest_stars_difficulty_texture> = icon_difficulty_beginner
		<highest_stars_difficulty_alpha> = 1
		<highest_stars_difficulty_text> = qs("Beginner")
		<highest_stars_difficulty_index> = 0
		<highest_stars> = <stars>
	endif
	beginner_stars = <stars>
	beginner_percent100 = <percent100>
	format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'easy'
	GetGlobalTags <song_checksum> param = stars savegame = <savegame>
	GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
	if (<stars> >= <highest_stars>)
		<highest_stars_difficulty_texture> = icon_difficulty_easy
		<highest_stars_difficulty_alpha> = 1
		<highest_stars_difficulty_text> = qs("Easy")
		<highest_stars_difficulty_index> = 1
		<highest_stars> = <stars>
	endif
	easy_stars = <stars>
	easy_percent100 = <percent100>
	format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'medium'
	GetGlobalTags <song_checksum> param = stars savegame = <savegame>
	GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
	if (<stars> >= <highest_stars>)
		<highest_stars_difficulty_texture> = icon_difficulty_medium
		<highest_stars_difficulty_alpha> = 1
		<highest_stars_difficulty_text> = qs("Medium")
		<highest_stars_difficulty_index> = 2
		<highest_stars> = <stars>
	endif
	medium_stars = <stars>
	medium_percent100 = <percent100>
	format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'hard'
	GetGlobalTags <song_checksum> param = stars savegame = <savegame>
	GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
	if (<stars> >= <highest_stars>)
		<highest_stars_difficulty_texture> = icon_difficulty_hard
		<highest_stars_difficulty_alpha> = 1
		<highest_stars_difficulty_text> = qs("Hard")
		<highest_stars_difficulty_index> = 3
		<highest_stars> = <stars>
	endif
	hard_stars = <stars>
	hard_percent100 = <percent100>
	format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'expert'
	GetGlobalTags <song_checksum> param = stars savegame = <savegame>
	GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
	if (<stars> >= <highest_stars>)
		<highest_stars_difficulty_texture> = icon_difficulty_expert
		<highest_stars_difficulty_alpha> = 1
		<highest_stars_difficulty_text> = qs("Expert")
		<highest_stars_difficulty_index> = 4
		<highest_stars> = <stars>
	endif
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
	stars_tags = {
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
	}
	difficulty_tags = {
		icon_difficulty_texture = <highest_stars_difficulty_texture>
		icon_difficulty_alpha = <highest_stars_difficulty_alpha>
		highest_stars_difficulty_text = <highest_stars_difficulty_text>
		highest_stars_difficulty_index = <highest_stars_difficulty_index>
	}
	return score_text = <score_text> difficulty_tags = <difficulty_tags> stars_tags = <stars_tags> completed = <completed>
endscript

script ui_gig_posters_highlight_motion 
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	if Desc_ResolveAlias \{name = alias_highlight}
		if GetScreenElementChildren id = <resolved_id>
			(<children> [1]) :obj_spawnscript ui_flicker_highlight
		endif
	endif
endscript

script ui_gig_posters_check_movies_played \{part = Band}
	get_current_band_info
	GetGlobalTags <band_info>
	switch (<part>)
		case guitar
		check = <career_guitar_movies_played>
		case Bass
		check = <career_bass_movies_played>
		case drum
		check = <career_drum_movies_played>
		case Vocals
		check = <career_vocals_movies_played>
		case Band
		check = <career_band_movies_played>
	endswitch
	return {movies_played = <check>}
endscript

script ui_gig_posters_set_movies_played \{part = Band}

	get_current_band_info
	GetGlobalTags <band_info>
	switch (<part>)
		case guitar
		SetGlobalTags <band_info> params = {career_guitar_movies_played = <value>}
		case Bass
		SetGlobalTags <band_info> params = {career_bass_movies_played = <value>}
		case drum
		SetGlobalTags <band_info> params = {career_drum_movies_played = <value>}
		case Vocals
		SetGlobalTags <band_info> params = {career_vocals_movies_played = <value>}
		case Band
		SetGlobalTags <band_info> params = {career_band_movies_played = <value>}
	endswitch
endscript

script ui_select_venue_check_ice_movie_played \{part = Band}
	get_current_band_info
	GetGlobalTags <band_info>
	switch (<part>)
		case guitar
		check = <career_guitar_ice_movie_played>
		case Bass
		check = <career_bass_ice_movie_played>
		case drum
		check = <career_drum_ice_movie_played>
		case Vocals
		check = <career_vocals_ice_movie_played>
		case Band
		check = <career_band_ice_movie_played>
	endswitch
	if (<check> = 1)
		return \{true}
	endif
	return \{false}
endscript

script ui_select_venue_set_ice_movie_played \{part = Band}
	get_current_band_info
	GetGlobalTags <band_info>
	switch (<part>)
		case guitar
		SetGlobalTags <band_info> params = {career_guitar_ice_movie_played = 1}
		case Bass
		SetGlobalTags <band_info> params = {career_bass_ice_movie_played = 1}
		case drum
		SetGlobalTags <band_info> params = {career_drum_ice_movie_played = 1}
		case Vocals
		SetGlobalTags <band_info> params = {career_vocals_ice_movie_played = 1}
		case Band
		SetGlobalTags <band_info> params = {career_band_ice_movie_played = 1}
	endswitch
endscript

script silent_movie_animate 
	begin
	SE_SetProps \{texture = silent_movie_1
		time = 0}
	Wait \{0.1
		seconds}
	SE_SetProps \{texture = silent_movie_2
		time = 0}
	Wait \{0.1
		seconds}
	SE_SetProps \{texture = silent_movie_3
		time = 0}
	Wait \{0.1
		seconds}
	SE_SetProps \{texture = silent_movie_4
		time = 0}
	Wait \{0.1
		seconds}
	SE_SetProps \{texture = silent_movie_5
		time = 0}
	Wait \{0.1
		seconds}
	repeat
endscript

script ui_gig_posters_play_movie 
	return
	SetScriptCannotPause
	clean_up_user_control_helpers
	OnExitRun \{ui_gig_posters_play_movie_destroy}

	Menu_Music_Off
	spawnscriptnow \{destroy_songpreview}
	SetSoundBussParams {Crowd_Balance = {vol = (($Default_BussSet.Crowd_Balance.vol) - 100)} time = 2.0}
	SetSoundBussParams {Music_Setlist = {vol = (($Default_BussSet.Music_Setlist.vol) - 100)} time = 0.5}
	fadetoblack \{on
		time = 0
		alpha = 1.0
		z_priority = 100}
	wait_for \{condition = {
			songpreview_is_safe
		}}
	KillAllMovies
	Wait \{10
		gameframes}
	set_bink_heap_state \{state = big}
	SoundEvent \{event = PreCutscene_Sfx}
	info_text = qs("")
	switch (<movie>)
		case 'GHM_Movie1'
		info_text = qs("Inspired by Metallica, you decide to start a band...")
		case 'GHM_Movie2'
		info_text = qs("On the way to opening act auditions...")
		case 'GHM_Movie3'
		info_text = qs("Sabotage on the road...")
		case 'GHM_Movie4'
		info_text = qs("Welcome to the big time...")
		case 'GHM_Movie_Outro'
		info_text = qs("The Coldest Show on Earth...")
		case 'stone_intro'
		info_text = qs("Old School at The Stone...")
	endswitch
	CreateScreenElement \{type = SpriteElement
		parent = root_window
		id = silent_background
		texture = silent_movie_1
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		just = [
			left
			top
		]
		z_priority = 9001}
	silent_background :SE_SetProps \{alpha = 1.0
		time = 0.1}
	RunScriptOnScreenElement \{silent_movie_animate
		id = silent_background}
	CreateScreenElement {
		type = DescInterface
		parent = root_window
		id = silent_movie
		desc = 'silent_movie'
		info_text = <info_text>
		alpha = 0.0
	}
	silent_movie :SE_SetProps \{alpha = 1.0
		time = 0.1}
	ui_event_wait_for_safe
	guarantee_no_loading_screen
	Wait \{5
		seconds}
	silent_movie :SE_SetProps \{alpha = 0
		time = 0.1}
	silent_background :SE_SetProps \{alpha = 0
		time = 0.1}
	silent_movie :SE_WaitProps
	silent_background :SE_WaitProps
	DestroyScreenElement \{id = silent_movie}
	DestroyScreenElement \{id = silent_background}
	if GotParam \{need_loading_screen}
		PlayMovieAndWait movie = <movie> noblack need_loading_screen = true
	else
		PlayMovieAndWait movie = <movie> noblack
	endif
	get_movie_id_by_name movie = <movie>
	SetGlobalTags <id> params = {unlocked = 1} all_active_players = 1
	menu_music_on
	SetSoundBussParams {Crowd_Balance = {vol = (($Default_BussSet.Crowd_Balance.vol))} time = 2.0}
endscript

script ui_gig_posters_play_movie_destroy 
	DestroyScreenElement \{id = silent_movie}
	DestroyScreenElement \{id = silent_background}
endscript

script ui_gig_posters_play_song 
	if (<unlocked> = 0)
		return
	endif
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	setlist_menu :SE_SetProps \{block_events}
	if setlist_menu :Menu_SelectedIndexIs \{last}
		change \{next_selected_song = 1}
	else
		setlist_menu :Menu_GetSelectedIndex
		change next_selected_song = (<selected_index>)
	endif
	change current_song = <song>
	change current_level = <level>
	change current_gig_number = <tier_num>
	part = Band
	if ($current_num_players = 1)
		GetPlayerInfo \{1
			part}
	endif
	ui_gig_posters_check_movies_played part = <part>
	if (($signin_change_happening = 1) || ($invite_controller > -1))
		return
	endif
	generic_event_choose state = uistate_play_song data = {selected_level = <level>}
endscript

script ui_destroy_gig_posters 
	menu_start_transition
	KillSpawnedScript \{name = ui_create_gig_posters_spawned}
	if NOT (($top_rockers_enabled) || (GotParam from_leaderboard))
		spawnscriptnow \{destroy_songpreview}
	endif
	if ScreenElementExists \{id = SetlistInterface}
		DestroyScreenElement \{id = SetlistInterface}
	endif
	if ScreenElementExists \{id = setlist_header}
		DestroyScreenElement \{id = setlist_header}
	endif
	clean_up_user_control_helpers
	fadetoblack \{off
		time = 0
		no_wait}
endscript

script ui_gig_posters_focus \{time = 0.1}
	if ScriptIsRunning \{ui_create_gig_posters_spawned}
		time = 0.0
	endif
	GetTags

	if NOT GotParam \{index}
		return
	endif
	fadetoblack \{off
		time = 0}
	SE_GetParentId
	<parent_id> :GetTags
	if (<prev_index> > <index>)
		pos_move = (0.0, -1.0)
	else
		pos_move = (0.0, 1.0)
	endif
	if (<total_songs> = 1)
		<ratio> = 0
	else
		<ratio> = (<index> / ((<total_songs> - 1) * 1.0))
	endif
	pos = ((0.0, 1.0) * ((<ratio> * 440) - 180))
	bg_pos = ((0.0, -1.0) * (<ratio> * (4400 - 720)))
	bg_runnerL_pos = (((0.0, -1.0) * (<ratio> * (2200 - 720))) + (-640.0, 0.0))
	overlap = -1.5
	SetlistInterface :SE_SetProps {
		setlist_B_scrollthumb_pos = <pos>
		time = 0.0
	}
	<parent_id> :SetTags prev_index = <index>
	if (<highlight> = 0)
		return
	endif
	<info_scores_container_alpha> = 1.0
	<instrument_icons_alpha> = 0.0
	if ($game_mode = p2_pro_faceoff || <unlocked> = 0)
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
		if GotParam \{playback_track1}
			if (<playback_track1> > -1)
				icon_no_instrument_guitar_alpha = 0
			endif
		endif
		if GotParam \{playback_track2}
			if (<playback_track2> > -1)
				icon_no_instrument_bass_alpha = 0
			endif
		endif
		if GotParam \{playback_track_drums}
			if (<playback_track_drums> > 0)
				icon_no_instrument_drums_alpha = 0
			endif
		endif
		if GotParam \{playback_track_vocals}
			if (<playback_track_vocals> > 0)
				icon_no_instrument_mic_alpha = 0
			endif
		endif
	endif
	get_song_text unlocked = <unlocked> song_title = <song_title> song_artist = <song_artist>
	StringToCharArray string = <song_text>
	GetArraySize <char_array>
	if (<unlocked> = 1)
		GetPlayerInfo \{1
			double_kick_drum}
		<double_kick_alpha> = 0
		if (<double_bass_complete> = 1)
			icon_difficulty_expert_alpha = 0
			icon_difficulty_expert_plus_alpha = 0
			<highest_stars_difficulty_text> = qs("Expert+")
		else
			icon_difficulty_expert_alpha = 0
			icon_difficulty_expert_plus_alpha = 0
		endif
		song_info_icon_alpha = 0
		if (<new_song_info> = 1)
			<song_info_icon_alpha> = 1
		endif
	else
		icon_no_instrument_guitar_alpha = 0
		icon_no_instrument_bass_alpha = 0
		icon_no_instrument_drums_alpha = 0
		icon_no_instrument_mic_alpha = 0
		difficulty_and_stars_alpha = 0
		double_kick_alpha = 0
		song_info_icon_alpha = 0
		icon_difficulty_expert_alpha = 0
		icon_difficulty_expert_plus_alpha = 0
	endif
	SE_SetProps {
		desc = 'setlist_b_info2_desc'
		auto_dims = false
		dims = (0.0, 100.0)
		setlist_info_title_artist_text = <song_text>
		setlist_info_title_artist_pos = {<pos_move> relative}
		icon_difficulty_texture = <icon_difficulty_texture>
		difficulty_and_stars_alpha = <icon_difficulty_alpha>
		text_difficulty_text = <highest_stars_difficulty_text>
		double_kick_alpha = <double_kick_alpha>
		song_info_icon_alpha = <song_info_icon_alpha>
		icon_difficulty_alpha = <icon_difficulty_expert_alpha>
		icon_difficulty_expert_plus_alpha = <icon_difficulty_expert_plus_alpha>
	}
	Obj_GetID
	if (<unlocked> = 0)
		gig_posters_song_focus
		return
	endif
	change current_song_info_id = <ObjID>
	percent_diffs = ['beginner' 'easy' 'medium' 'hard' 'expert']
	percent_aliases = [
		alias_Setlist_B_stars_beginner
		alias_Setlist_B_stars_easy
		alias_Setlist_B_stars_medium
		alias_Setlist_B_stars_hard
		alias_Setlist_B_stars_expert
	]
	star_diffs = [
		beginner_stars
		easy_stars
		medium_stars
		hard_stars
		expert_stars
	]
	FormatText checksumname = percent100 '%s_percent100' s = (<percent_diffs> [<highest_stars_difficulty_index>])
	if GotParam <percent100>
		if <ObjID> :Desc_ResolveAlias name = alias_stars
			if (<...>.<percent100> = 1)
				<resolved_id> :SE_SetProps star_rgba = [255 255 255 255]
			endif
			if <resolved_id> :Desc_ResolveAlias name = alias_stars
				GetScreenElementChildren id = <resolved_id>
				num_stars = (<...>.(<star_diffs> [<highest_stars_difficulty_index>]))
				if (<num_stars> = 0)
					<resolved_id> :SE_SetProps alpha = 0
				else
					GetArraySize <children>
					stars_left = <array_size>
					if (<num_stars> < 5 && <stars_left> = 5)
						if ScreenElementExists id = (<children> [0])
							DestroyScreenElement id = (<children> [0])
							stars_left = (<stars_left> - 1)
						endif
					endif
					if (<num_stars> < 4 && <stars_left> = 4)
						if ScreenElementExists id = (<children> [1])
							DestroyScreenElement id = (<children> [1])
						endif
					endif
				endif
			endif
		endif
	endif
	SE_SetProps {
		setlist_info_title_artist_pos = {(<pos_move> * -1) relative}
		time = <time>
	}
	if <ObjID> :Desc_ResolveAlias name = alias_setlist_info_title_artist
		GetScreenElementChildren id = <resolved_id>
		GetScreenElementProps id = (<children> [0]) force_update
		<width> = (<dims>.(1.0, 0.0) * <scale>.(1.0, 0.0))
		<double_kick_offset> = ((1.0, 0.0) * ((<width> / 2) + 12))
		<new_pos> = ((0.0, -30.0) - <double_kick_offset>)
		<ObjID> :SE_SetProps double_kick_pos = <new_pos>
	endif
	if (<tag_selected_index> < <section_breaker_index_3>)
		gig_posters_song_focus song = <song>
	else
		gig_posters_song_focus
	endif
	if (<new_song_info> = 1)
		<ObjID> :Obj_SpawnScriptNow song_info_icon_motion
		setlist_menu :SetTags \{pulse_song_extras = 1}
	else
		setlist_menu :SetTags \{pulse_song_extras = 0}
	endif
	setlist_menu :SetTags last_focused_song = <song>
	if NOT GotParam \{jam_song}
		ui_gig_posters_update_current_section index = <tag_selected_index> song = <song>
	else
		ui_gig_posters_update_current_section index = <tag_selected_index> song = <song> jam_song = <jam_song>
	endif
endscript

script ui_gig_posters_unfocus 
	GetTags
	get_song_text unlocked = <unlocked> song_title = <song_title> song_artist = <song_artist>
	GetPlayerInfo \{1
		double_kick_drum}
	<double_kick_alpha> = 0
	SE_SetProps {
		desc = 'setlist_b_listing_desc'
		auto_dims = false
		dims = (0.0, 80.0)
		listing_text = <song_text>
		double_kick_alpha = <double_kick_alpha>
		stars_alpha = 1.0
		<difficulty_tags>
		text_difficulty_text = <highest_stars_difficulty_text>
	}
	move_double_kick = 1
	if GotParam \{fading_in}
		if (<fading_in> = 1)
			<move_double_kick> = 0
			SetTags \{fading_in = 0}
		endif
	endif
	if (<move_double_kick> = 1)
		if Desc_ResolveAlias \{name = alias_listing}
			GetScreenElementChildren id = <resolved_id>
			GetScreenElementPosition id = <resolved_id> summed
			<text_pos> = <screenelementpos>
			GetScreenElementProps id = (<children> [0]) force_update
			<width> = (<dims>.(1.0, 0.0) * <scale>.(1.0, 0.0))
			<double_kick_offset> = ((1.0, 0.0) * ((<width> / 2) + 42) + (0.0, 1.0))
			<new_pos> = (<text_pos> - <double_kick_offset>)
			SE_SetProps double_kick_pos = <new_pos>
		endif
	endif
	percent_diffs = ['beginner' 'easy' 'medium' 'hard' 'expert']
	star_diffs = [
		beginner_stars
		easy_stars
		medium_stars
		hard_stars
		expert_stars
	]
	Obj_GetID
	FormatText checksumname = percent100 '%s_percent100' s = (<percent_diffs> [<highest_stars_difficulty_index>])
	if <ObjID> :Desc_ResolveAlias name = alias_stars
		if (<...>.<percent100> = 1)
			<ObjID> :SE_SetProps star_rgba = [255 255 255 175]
		endif
		GetScreenElementChildren id = <resolved_id>
		num_stars = (<...>.(<star_diffs> [<highest_stars_difficulty_index>]))
		if (<num_stars> = 0)
			<resolved_id> :SE_SetProps alpha = 0
		else
			GetArraySize <children>
			stars_left = (<array_size> - 1)
			if (<num_stars> < 5 && <stars_left> = 5)
				if ScreenElementExists id = (<children> [(4 + 1)])
					DestroyScreenElement id = (<children> [(4 + 1)])
					stars_left = (<stars_left> - 1)
				endif
			endif
			if (<num_stars> < 4 && <stars_left> = 4)
				if ScreenElementExists id = (<children> [(3 + 1)])
					DestroyScreenElement id = (<children> [(3 + 1)])
				endif
			endif
		endif
	endif
endscript

script ui_gig_posters_update_current_section 
	setlist_menu :GetTags
	if (<index> >= <section_breaker_index_3>)
		<current_section> = 3
	elseif (<tag_selected_index> >= <section_breaker_index_2>)
		<current_section> = 2
	elseif (<tag_selected_index> >= <section_breaker_index_1>)
		<current_section> = 1
	endif

	setlist_menu :SetTags current_section = <current_section>
	if ($ui_gig_posters_skip_helpers = 1)
		return
	endif
	if (<for_custom_setlist> = 1)
		setup_custom_setlist_helpers song = <song> jam_song = <jam_song>
	else
		clean_up_user_control_helpers
		if ($is_network_game = 1)
			if local_player_is_choosing_song
				add_user_control_helper \{text = qs("SELECT SONG")
					button = green
					z = 100}
				add_user_control_helper \{text = qs("BACK")
					button = red
					z = 100}
			endif
		else
			add_user_control_helper \{text = qs("SELECT SONG")
				button = green
				z = 100}
			add_user_control_helper \{text = qs("BACK")
				button = red
				z = 100}
			if (<pulse_song_extras> = 1)
				spawnscriptnow pulsate_helper_pill params = {id = <helper_pill_ID> time = 0.5 delay_time = 0}
			else
				KillSpawnedScript \{name = pulsate_helper_pill}
			endif
		endif
		setlist_show_jump_helper_text
		if ($game_mode = gh4_p1_career ||
				$game_mode = gh4_p2_career ||
				$game_mode = gh4_p3_career ||
				$game_mode = gh4_p4_career)
			if ($enable_button_cheats = 1)
				add_user_control_helper \{text = qs("\LBEAT SONG")
					button = LB
					z = 100000}
			endif
		endif
	endif
endscript

script ui_gig_posters_debug_complete 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	if ($enable_button_cheats = 0)
		return
	endif
	i = 1
	begin
	GetPlayerInfo <i> part
	GetPlayerInfo <i> controller
	GetSavegameFromController controller = <controller>
	GetGlobalTags <song_checksum> param = stars
	<old_stars> = <stars>
	SetGlobalTags <song_checksum> savegame = <savegame> params = {unlocked = 1 stars = 5 score = 1000}
	SetGlobalTags <song> savegame = <savegame> params = {unlocked = 1}
	if (<part> = drum)
		GetPlayerInfo <i> double_kick_drum
		if (<double_kick_drum> = 1)
			SetGlobalTags <song_checksum> savegame = <savegame> params = {double_bass_complete = 1}
		endif
	endif
	i = (<i> + 1)
	repeat ($current_num_players)
	ui_event \{event = menu_refresh}
endscript

script ui_gig_posters_choose 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	ui_event event = menu_change data = {state = uistate_play_song <...>}
endscript

script song_info_icon_motion 
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	if Desc_ResolveAlias \{name = alias_song_info_icon}
		if GetScreenElementChildren id = <resolved_id>
			GetArraySize <children>
			prev = 0
			curr = 1
			begin
			prev_id = (<children> [<prev>])
			curr_id = (<children> [<curr>])
			if ScreenElementExists id = <prev_id>
				<prev_id> :SE_SetProps alpha = 0.0
			endif
			if ScreenElementExists id = <curr_id>
				<curr_id> :SE_SetProps alpha = 1
			endif
			prev = <curr>
			next = RandomInteger (0.0, 1.0)
			if (<next> = <prev>)
				curr = (<curr> + 1)
			else
				curr = <next>
			endif
			if (<curr> >= <array_size>)
				curr = 0
			endif
			Wait \{0.1
				second}
			repeat
		endif
	endif
endscript

script ui_gig_posters_popups 

	change \{ui_gig_posters_skip_helpers = 0}
	get_current_band_info
	GetGlobalTags <band_info> params = {first_career_setlist}
	GetPlayerInfo \{1
		part}
	GetPlayerInfo \{1
		double_kick_drum}
	if (<part> = drum && <double_kick_drum> = 1)
		GetGlobalTags <band_info> params = {first_setlist_drum}
		if (<first_setlist_drum> = 1 && <first_career_setlist> = 0)
			change \{ui_gig_posters_skip_helpers = 1}
			ui_event_wait \{state = UIstate_double_bass_popup
				data = {
					is_popup
				}}
			SetGlobalTags <band_info> params = {first_setlist_drum = 0}
		endif
	endif
endscript

script get_prev_total_songs 
	switch <part>
		case guitar
		GetGlobalTags <band_info> params = {career_guitar_prev_total_songs = <final_num_songs>}
		return prev_total_songs = <career_guitar_prev_total_songs>
		case Bass
		GetGlobalTags <band_info> params = {career_bass_prev_total_songs = <final_num_songs>}
		return prev_total_songs = <career_bass_prev_total_songs>
		case drum
		GetGlobalTags <band_info> params = {career_drum_prev_total_songs = <final_num_songs>}
		return prev_total_songs = <career_drum_prev_total_songs>
		case Vocals
		GetGlobalTags <band_info> params = {career_vocals_prev_total_songs = <final_num_songs>}
		return prev_total_songs = <career_vocals_prev_total_songs>
		case Band
		GetGlobalTags <band_info> params = {career_band_prev_total_songs = <final_num_songs>}
		return prev_total_songs = <career_band_prev_total_songs>
	endswitch
endscript

script set_prev_total_songs 
	switch <part>
		case guitar
		SetGlobalTags <band_info> params = {career_guitar_prev_total_songs = <final_num_songs>}
		case Bass
		SetGlobalTags <band_info> params = {career_bass_prev_total_songs = <final_num_songs>}
		case drum
		SetGlobalTags <band_info> params = {career_drum_prev_total_songs = <final_num_songs>}
		case Vocals
		SetGlobalTags <band_info> params = {career_vocals_prev_total_songs = <final_num_songs>}
		case Band
		SetGlobalTags <band_info> params = {career_band_prev_total_songs = <final_num_songs>}
	endswitch
endscript

script ui_gig_posters_choose_back 
	generic_event_replace state = uistate_select_venue data = {gig_index = <gig_index>}
endscript

script get_song_text \{unlocked = 1}
	if (<unlocked> = 1)
		FormatText TextName = song_text qs("\L%t: %a") a = <song_artist> t = <song_title>
	else
		song_text = qs(0x3b78ba7f)
	endif
	return song_text = <song_text>
endscript
