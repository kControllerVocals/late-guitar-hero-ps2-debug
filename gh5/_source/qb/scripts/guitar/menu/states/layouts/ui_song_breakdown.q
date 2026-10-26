track_last_song = none
g_leader_player_num = -1
ui_song_breakdown_players_rdy = [
	0
	0
	0
	0
]
ui_song_breakdown_wrote_tr = 0
ui_song_breakdown_pulsate_helper_pill = 0
ui_song_breakdown_helper_params = {
}
g_song_breakdown_noncompetitive_stats_order = [
	{
		career_only = 0
		name = accuracy
		title_text = qs("ACCURACY")
		caption_text = qs("NOTES HIT")
		use_unit_text = 1
		unit_text = qs("\L%")
	}
	{
		career_only = 0
		name = score
		title_text = qs("SCORE")
		caption_text = qs("POINTS")
		use_unit_text = 0
		unit_text = qs("\L")
	}
	{
		career_only = 0
		name = streak
		title_text = qs("NOTE STREAK")
		caption_text = qs("NOTE STREAK")
		use_unit_text = 0
		unit_text = qs("\L")
	}
	{
		career_only = 0
		name = multiplier
		title_text = qs("HIGHEST MULTIPLIER")
		caption_text = qs("MULTIPLIER")
		use_unit_text = 1
		unit_text = qs("\LX")
	}
]

script ui_init_song_breakdown 
	change \{playing_song = 0}
	change \{sb_trans_flag = 0}
	GameMode_GetType
	if (<type> = practice)
		spawnscriptnow \{kill_gem_scroller}
		spawnscriptnow \{task_menu_default_anim_in
			params = {
				base_name = 'select_song_section'
			}}
		return
	endif
	if NOT (<type> = career || <type> = quickplay)
		ui_gig_cash_clear_gig_earnings
	endif
	change \{ui_song_breakdown_wrote_tr = 0}
	if ($is_network_game = 1)
		online_post_game_lobby_change_song_selector
		spawn_player_drop_listeners \{drop_player_script = song_breakdown_drop_player
			end_game_script = song_breakdown_end_game}
	endif
	if (<type> = quickplay)
		if ($track_last_song != jamsession)
			menu_top_rockers_check_for_new_top_score \{nowrite = 1}
			if (<new_score> != -1)
				change \{ui_song_breakdown_pulsate_helper_pill = 1}
			endif
		endif
	endif
endscript

script ui_create_song_breakdown 
	change \{ui_song_breakdown_helper_params = {
		}}
	if should_use_all_buttons
		change \{ui_song_breakdown_helper_params = {
				all_buttons
			}}
	endif
	change \{song_breakdown_busy_flag = 1}
	ui_song_breakdown_clear_ready_up_book_keeping
	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		DestroyScreenElement \{id = song_breakdown_noncompetitive_id}
	endif
	GetGlobalTags \{band_info}
	bandname = <name>
	GMan_SongTool_GetCurrentSong
	my_song = <current_song>
	if NOT ($track_last_song = none)
		my_song = ($track_last_song)
	endif
	get_song_title song = <my_song>
	GameMode_GetType
	if (<type> = practice)
		ui_create_song_breakdown_practice <...>
	else
		ui_create_song_breakdown_normal <...>
	endif
	ui_event_add_params type = <type>
endscript

script ui_destroy_song_breakdown 
	clean_up_user_control_helpers
	change \{song_breakdown_countdown_time = -1}
	KillSpawnedScript \{name = pulsate_helper_pill}
	if (<type> = practice)
		DestroyScreenElement \{id = my_breakdown_practice_id}
	else
		DestroyScreenElement \{id = song_breakdown_noncompetitive_id}
		ui_destroy_encore_confirmation
	endif
endscript

script ui_deinit_song_breakdown 

	if ($track_last_song != jamsession)
		song_breakdown_auto_write_top_rockers
	endif
	ui_song_breakdown_clean_up_highest_multipliers
endscript

script ui_song_breakdown_anim_in_script 
	SetScriptCannotPause
	GameMode_GetType
	if (<type> = practice)
		return
	endif
	stars_alpha = 1.0
	startrendering \{reason = menu_transition}
	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		song_breakdown_noncompetitive_id :SE_SetProps {
			song_complete_stars_alpha = <stars_alpha> time = 0.1 Anim = gentle
		}
		Wait \{0.3
			second}
	endif
	change \{song_breakdown_busy_flag = 0}
endscript

script ui_song_breakdown_anim_out_script 
	SetScriptCannotPause
	GameMode_GetType
	if (<type> = practice)
		return
	endif
	startrendering \{reason = menu_transition}
	clean_up_user_control_helpers
	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		song_breakdown_noncompetitive_id :SE_SetProps \{song_complete_stars_alpha = 0
			time = 0.05
			Anim = gentle}
		Wait \{0.3
			second}
	endif
endscript

script ui_create_song_breakdown_practice 
	disable_pause
	ps2_force_unload_car_part_script
	load_songqpak \{song_name = $current_song}
	Progression_UpdateDetailedStatsForGig \{failed_or_practice}
	ui_song_breakdown_get_basic_player_data
	if NOT PlayerInfoEquals <player_index> part = Vocals
		if (<total_notes> > 0)
			<percent_notes_hit> = (((<notes_hit> * 1.0) / <total_notes>) * 100.0)
		else
			<percent_notes_hit> = 0
		endif
		MathFloor <percent_notes_hit>
		<percent_notes_hit> = <floor>
		FormatText TextName = percent_text qs("\L%p") p = <percent_notes_hit>
	else
		if (<vocal_phrase_max_qual> > 0)
			percent_notes_hit = (((<vocal_phrase_quality> * 1.0) / <vocal_phrase_max_qual>) * 100.0)
			MathFloor <percent_notes_hit>
			<percent_notes_hit> = <floor>
			FormatText TextName = percent_text qs("\L%p") p = <percent_notes_hit> DecimalPlaces = 0
		else
			<percent_text> = qs("\L0")
		endif
	endif
	CreateScreenElement {
		parent = root_window
		id = my_breakdown_practice_id
		type = DescInterface
		desc = 'song_breakdown_practice'
		dlog_title_text = <song_title>
		dlog_continue_notes_entry_text = <percent_text>
		dlog_continue_streak_entry_text = <streak_text>
		icon_difficulty_medium_texture = <diff_texture>
		dlog_fail_song_difficulty_text = <difficulty_text>
		exclusive_device = ($primary_controller)
	}
	my_breakdown_practice_id :Desc_ResolveAlias \{name = alias_dlog_vmenu}
	AssignAlias \{id = my_breakdown_practice_id
		alias = current_menu_anchor}
	SetScreenElementProps {
		id = <resolved_id>
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up = 1}}
			{pad_down generic_menu_up_or_down_sound params = {down = 2}}
		]
	}
	if ($came_to_practice_from = main_menu)
		continue_text = qs("NEW SONG")
	else
		if ($came_to_practice_from = p1_quickplay)
			continue_text = qs("BACK TO QUICKPLAY")
		else
			continue_text = qs("BACK TO CAREER")
		endif
	endif
	CreateScreenElement {
		parent = <resolved_id>
		type = TextElement
		font = fontgrid_text_a1
		text = <continue_text>
		scale = 0.75
		rgba = ($menu_unfocus_color)
		event_handlers = [
			{focus song_breakdown_practice_focus}
			{unfocus song_breakdown_practice_unfocus}
			{pad_choose ui_win_song_continue_next_menu params = {for_practice = 1}}
		]
	}
	CreateScreenElement {
		parent = <resolved_id>
		type = TextElement
		font = fontgrid_text_a1
		text = qs("DETAILED STATS")
		scale = 0.75
		rgba = ($menu_unfocus_color)
		event_handlers = [
			{focus song_breakdown_practice_focus}
			{unfocus song_breakdown_practice_unfocus}
			{pad_choose generic_event_choose params = {state = uistate_song_summary_details}}
		]
	}
	CreateScreenElement {
		parent = <resolved_id>
		type = TextElement
		font = fontgrid_text_a1
		text = qs("REPLAY")
		scale = 0.75
		rgba = ($menu_unfocus_color)
		event_handlers = [
			{focus song_breakdown_practice_focus}
			{unfocus song_breakdown_practice_unfocus}
			{pad_choose practice_restart_song}
		]
	}
	if NOT PlayerInfoEquals \{1
			part = Vocals}
		CreateScreenElement {
			parent = <resolved_id>
			type = TextElement
			font = fontgrid_text_a1
			text = qs("SELECT SPEED")
			scale = 0.75
			rgba = ($menu_unfocus_color)
			event_handlers = [
				{focus song_breakdown_practice_focus}
				{unfocus song_breakdown_practice_unfocus}
				{pad_choose generic_event_choose params = {state = uistate_practice_select_speed data = {from_song_breakdown = 1}}}
			]
		}
	endif
	CreateScreenElement {
		parent = <resolved_id>
		type = TextElement
		font = fontgrid_text_a1
		text = qs("SELECT SECTION")
		scale = 0.75
		rgba = ($menu_unfocus_color)
		event_handlers = [
			{focus song_breakdown_practice_focus}
			{unfocus song_breakdown_practice_unfocus}
			{pad_choose generic_event_back params = {state = uistate_select_song_section}}
		]
	}
	AssignAlias id = <resolved_id> alias = current_menu
	add_user_control_helper ($ui_song_breakdown_helper_params) text = qs("SELECT") button = green z = 100000
	SpawnScript \{highlight_motion}
	unload_songqpak
endscript

script song_breakdown_practice_focus 
	SE_SetProps rgba = ($menu_focus_color)
endscript

script song_breakdown_practice_unfocus 
	SE_SetProps rgba = ($menu_unfocus_color)
endscript

script song_breakdown_is_single_player_game 
	GameMode_GetType
	if (isSinglePlayerGame)
		return \{true}
	elseif (<type> = freeplay)
		freeplay_get_num_active_players
		if (<num_active_players> = 1)
			return \{true}
		endif
	endif
	return \{false}
endscript

script ui_create_song_breakdown_normal 
	display_stats_index = 0
	SoundEvent \{event = Menu_Song_Complete_In}
	star_rgba = [254 204 55 255]
	GameMode_GetNumPlayersShown
	if (<num_players_shown> > 0)
		player = 1
		begin
		get_percent_notes_hit player_index = <player>
		if GotParam \{percent_notes_hit}
			if (<percent_notes_hit> < 100)
				star_rgba = [255 255 255 255]
			endif
		endif
		<player> = (<player> + 1)
		repeat <num_players_shown>
	endif
	GameMode_GetType
	if (<type> = career)
		get_current_band_name
	else
		band_name = ''
	endif
	if song_breakdown_is_single_player_game
		challenge_meter_alpha = 0
		CreateScreenElement {
			parent = root_window
			id = song_breakdown_noncompetitive_id
			type = DescInterface
			desc = 'song_summary_single'
			band_name_text = <band_name>
			song_title_text = <song_title>
			HUD_meter_challenge_alpha = <challenge_meter_alpha>
			tags = {
				display_stats_index = <display_stats_index>
				transition_param = none
			}
		}
	else
		CreateScreenElement {
			parent = root_window
			id = song_breakdown_noncompetitive_id
			type = DescInterface
			desc = 'song_summary_multi'
			band_name_text = <band_name>
			song_title_text = <song_title>
			tags = {
				display_stats_index = <display_stats_index>
				transition_param = none
			}
		}
		ui_song_breakdown_hide_player_data
		song_breakdown_assign_strips_data stats_index = <display_stats_index>
	endif
	song_breakdown_check_bot_play
	if (<bot_play> = 0)
		song_breakdown_get_exclusive_devices
		if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
			song_breakdown_noncompetitive_id :SE_SetProps {
				exclusive_device = <exclusive_devices>
			}
		endif
	endif
	song_breakdown_assign_band_data star_rgba = <star_rgba> song_name = <song_title>
	ui_song_breakdown_setup_handler_scripts <...>
	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		song_breakdown_add_page_counters
		if ($is_network_game = 1)
			if NOT GotParam \{continue_setlist_transition}
				song_breakdown_noncompetitive_id :Obj_SpawnScriptNow net_ui_song_breakdown_start_timer_spawned params = {<...>}
			endif
		endif
	endif
endscript

script ui_song_breakdown_normal_animate_stats 

	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		song_breakdown_noncompetitive_id :SE_SetProps \{song_summary_illo_pos = (-463.0, 138.0)
			relative
			time = 0.4}
		Wait \{0.7
			seconds}
		if (<num_stars> > 0)
			i = 1
			curr_time = 0.0
			if (<num_stars> = 1)
				star_times = [0.4 0.9]
			else
				star_times = [0.25 0.55 1.0 1.3 1.8 2.3]
			endif
			Outro_Stars num_stars = <num_stars>
			begin
			r = RandomInteger (90.0, 360.0)
			time_in = (<star_times> [(<i> - 1)] - <curr_time>)
			song_breakdown_noncompetitive_id :SE_SetProps {
				flying_star_pos = (0.0, 0.0)
				flying_star_rot_angle = <r>
				motion = ease_in
				time = <time_in>
			}
			song_breakdown_noncompetitive_id :SE_WaitProps
			FormatText TextName = stars_text qs("%i") i = <i>
			song_breakdown_noncompetitive_id :SE_SetProps {
				stars_number_text = <stars_text>
				stars_number_scale = 2.0
				song_summary_star_scale = 1.0
				song_summary_star2_scale = 0.7
				star_glow_alpha = 1.0
				star_glow_scale = 1.3
				time = 0
			}
			song_breakdown_noncompetitive_id :SE_WaitProps
			curr_time = (<curr_time> + <time_in>)
			time_out = ((<star_times> [<i>] - <curr_time>) / 2.0)
			song_breakdown_noncompetitive_id :SE_SetProps {
				stars_number_scale = 1.0
				song_summary_star_scale = 0.8
				song_summary_star2_scale = 1.0
				star_glow_alpha = 0
				star_glow_scale = 0.25
				motion = ease_out
				time = <time_out>
			}
			song_breakdown_noncompetitive_id :SE_WaitProps
			if NOT (<i> = <num_stars>)
				song_breakdown_noncompetitive_id :SE_SetProps \{flying_star_pos = (305.0, -405.0)}
			else
				song_breakdown_noncompetitive_id :SE_SetProps \{flying_star_pos = (-1305.0, -405.0)}
			endif
			song_breakdown_noncompetitive_id :SE_WaitProps
			curr_time = (<curr_time> + <time_out>)
			<i> = (<i> + 1)
			repeat <num_stars>
			create_ui_star_particles \{params = {
					parent = song_breakdown_noncompetitive_id
					pos = (0.0, 0.0)
				}}
			song_breakdown_noncompetitive_id :Obj_SpawnScriptNow \{anim_star_wiggle_loop
				params = {
				}}
		else
			FormatText TextName = stars_text qs("%i") i = <num_stars>
			song_breakdown_noncompetitive_id :SE_SetProps {
				stars_number_text = <stars_text>
				flying_star_pos = (-1000.0, 0.0)
			}
		endif
		song_breakdown_noncompetitive_id :SE_SetProps \{center_column_pos = (110.0, 59.0)
			relative
			time = 0.4}
		song_breakdown_noncompetitive_id :SE_WaitProps
		Wait \{0.3
			seconds}
		song_breakdown_noncompetitive_id :SE_SetProps \{right_column_pos = (1022.0, 0.0)
			relative
			time = 0.7}
	endif
endscript

script song_breakdown_add_page_counters 
	GameMode_GetType
	i = 0
	GetArraySize ($g_song_breakdown_noncompetitive_stats_order)
	stats_count = <array_size>
	if (<type> = quickplay || <type> = freeplay)
		stats_count = 0
		begin
		if (($g_song_breakdown_noncompetitive_stats_order [<i>].career_only) = 0)
			<stats_count> = (<stats_count> + 1)
		endif
		<i> = (<i> + 1)
		repeat <array_size>
	endif
	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		if song_breakdown_noncompetitive_id :Desc_ResolveAlias \{name = alias_page_counter}
			GetScreenElementChildren id = <resolved_id>
			GetArraySize <children>
			if (<array_size> < <stats_count>)
				begin
				CreateScreenElement {
					parent = <resolved_id>
					type = SpriteElement
					texture = dot_64
					rgba = black
					alpha = 0.4
					dims = (15.0, 15.0)
					just = [center , center]
					pos_anchor = [left , top]
					z_priority = 4
				}
				repeat (<stats_count> - <array_size>)
			endif
		endif
	endif
endscript

script song_breakdown_assign_strips_data 

	GameMode_GetType
	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		song_breakdown_noncompetitive_id :GetSingleTag \{display_stats_index}
		song_breakdown_noncompetitive_id :SE_SetProps {
			stat_title_text = ($g_song_breakdown_noncompetitive_stats_order [<display_stats_index>].title_text)
		}
		if song_breakdown_noncompetitive_id :Desc_ResolveAlias \{name = alias_page_counter}
			GetScreenElementChildren id = <resolved_id>
			GetArraySize <children>
			if (<array_size> > 0)
				i = 0
				begin
				if (<i> = <display_stats_index>)
					dot_alpha = 1
				else
					dot_alpha = 0.4
				endif
				(<children> [<i>]) :SE_SetProps alpha = <dot_alpha>
				<i> = (<i> + 1)
				repeat <array_size>
			endif
		endif
		if (<type> = freeplay)
			freeplay_get_num_active_players
			num_players_shown = <num_active_players>
		else
			GameMode_GetNumPlayersShown
		endif
		if (<num_players_shown> > 0)
			if (<type> = freeplay)
				freeplay_get_first_active_player
			else
				player = 1
			endif
			<i> = 1
			begin
			FormatText checksumname = player_stats_bg_panel 'alias_song_summary_playerStats_BG_%i' i = <i>
			if song_breakdown_noncompetitive_id :Desc_ResolveAlias name = <player_stats_bg_panel>
				DestroyScreenElement id = <resolved_id> preserve_parent
				GetPlayerInfo <player> part
				ui_song_breakdown_get_player_instrument_texture part = <part>
				song_breakdown_get_stat_value player_num = <player> stat_index = <display_stats_index>
				if (($g_song_breakdown_noncompetitive_stats_order [<display_stats_index>].name) = score)
					stat_desc_name = 'song_summary_player_score'
				else
					stat_desc_name = 'song_summary_player_accuracy'
				endif
				CreateScreenElement {
					parent = <resolved_id>
					type = DescInterface
					desc = <stat_desc_name>
					pos_anchor = [left , top]
					just = [left , top]
					pos = (5.0, -47.0)
					icon_instrument_texture = <icon_texture>
					icon_instrument_rgba = <instrument_rgba>
					accuracy_text = <stat_text>
					accuracy_caption_text = ($g_song_breakdown_noncompetitive_stats_order [<display_stats_index>].caption_text)
					percent_symbol_alpha = (($g_song_breakdown_noncompetitive_stats_order [<display_stats_index>].use_unit_text) * 0.3)
					percent_symbol_text = ($g_song_breakdown_noncompetitive_stats_order [<display_stats_index>].unit_text)
					z_priority = 5
					autoSizeDims = true
				}
				ui_song_breakdown_get_player_display_name player_index = <player>
				FormatText checksumname = player_name_checksum 'p%i_name_text' i = <i>
				AddParam structure_name = player_name name = <player_name_checksum> value = <player_name_text>
				song_breakdown_noncompetitive_id :SE_SetProps {
					<player_name>
				}
				leader_icon_alpha = 0
				if (<player> = ($g_leader_player_num))
					leader_icon_alpha = 1
				endif
				FormatText checksumname = leader_icon_alpha_checksum 'leader_icon_p%i_alpha' i = <i>
				AddParam structure_name = leader_icon name = <leader_icon_alpha_checksum> value = <leader_icon_alpha>
				if (<leader_icon_alpha> = 0)
					FormatText checksumname = leader_icon_dims_checksum 'leader_icon_p%i_dims' i = <i>
					AddParam structure_name = leader_icon name = <leader_icon_dims_checksum> value = (0.0, 0.0)
				endif
				song_breakdown_noncompetitive_id :SE_SetProps {
					<leader_icon>
				}
			endif
			if (<type> = freeplay)
				freeplay_get_next_active_player player = <player>
			else
				<player> = (<player> + 1)
			endif
			<i> = (<i> + 1)
			repeat <num_players_shown>
		endif
	endif
endscript

script song_breakdown_get_stat_value 

	ui_song_breakdown_get_basic_player_data player_index = <player_num> no_units
	switch ($g_song_breakdown_noncompetitive_stats_order [<stat_index>].name)
		case accuracy
		stat_text = <percent_text>
		case score
		stat_text = <score_text>
		case streak
		stat_text = <streak_text>
		case multiplier
		GetPlayerInfo <player_num> highest_multiplier
		FormatText TextName = stat_text qs("%m") m = <highest_multiplier>
		default

	endswitch
	return stat_text = <stat_text>
endscript

script song_breakdown_scroll_stats 

	if NOT ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		return
	endif
	GameMode_GetType
	song_breakdown_noncompetitive_id :GetSingleTag \{display_stats_index}
	new_stat_index_found = 0
	GetArraySize ($g_song_breakdown_noncompetitive_stats_order)
	if ((<direction> = left) || (<direction> = up))
		unit_to_add = -1
	else
		unit_to_add = 1
	endif
	new_display_stats_index = (<display_stats_index> + <unit_to_add>)
	begin
	if (<new_display_stats_index> < 0)
		<new_display_stats_index> = (<array_size> - 1)
	elseif (<new_display_stats_index> >= <array_size>)
		<new_display_stats_index> = 0
	endif
	if (<type> = quickplay || <type> = freeplay)
		if ($g_song_breakdown_noncompetitive_stats_order [<new_display_stats_index>].career_only)
			<new_display_stats_index> = (<new_display_stats_index> + <unit_to_add>)
		else
			<new_stat_index_found> = 1
			break
		endif
	else
		<new_stat_index_found> = 1
		break
	endif
	repeat <array_size>
	if (<new_stat_index_found> = 1)
		song_breakdown_noncompetitive_id :SetTags display_stats_index = <new_display_stats_index>
		song_breakdown_assign_strips_data stats_index = <new_display_stats_index>
	endif
endscript

script song_breakdown_strips_focus 

	<strip_id> :SE_SetProps character_name_rgba = blue2_md
endscript

script song_breakdown_strips_unfocus 

	<strip_id> :SE_SetProps character_name_rgba = [220 122 5 255]
endscript
song_breakdown_countdown_time = -1
song_breakdown_countdown_time_added = 0

script net_ui_song_breakdown_wait_for_timer 

	if ($song_breakdown_countdown_time = -1)
		change song_breakdown_countdown_time = ($net_song_breakdown_countdown_time)
	endif
	<screen_id> :SE_SetProps {
		net_timer_text_alpha = 1
	}
	begin
	FormatText TextName = timer_msg qs(0xb976bc16) d = ($song_breakdown_countdown_time)
	<screen_id> :SE_SetProps {
		net_timer_text_text = <timer_msg>
	}
	if (($song_breakdown_countdown_time) = 0)
		break
	endif
	change song_breakdown_countdown_time = (($song_breakdown_countdown_time) - 1)
	Wait \{1
		second}
	repeat
	Wait \{1
		second}
	<screen_id> :SE_SetProps {
		net_timer_text_alpha = 0
	}
	change \{song_breakdown_countdown_time = -1}
	change \{song_breakdown_countdown_time_added = 0}
endscript

script net_ui_song_breakdown_start_timer_spawned 
	Obj_GetID
	screen_id = <ObjID>
	net_ui_song_breakdown_wait_for_timer screen_id = <screen_id>
	GameMode_GetType
	if ($is_network_game = 1)
		if GotParam \{continue_to_next_song}
			if (<type> = career)
				change \{songtime_paused = 0}
				generic_event_back \{nosound
					state = uistate_gameplay}
			elseif ($game_mode = fest_mode)
				display_competitive_rules_voting \{voting_callback = song_breakdown_back_to_gameplay}
			elseif (<type> = pro_faceoff || <type> = competitive)
				song_breakdown_back_to_gameplay
			else
				change \{songtime_paused = 0}
				GMan_ShutDownGameModeGoal
				GMan_StartGameModeGoal
				generic_event_back \{nosound
					state = uistate_gameplay}
			endif
		elseif (<type> = career)
			if IsHost
				net_ui_song_breakdown_continue_to_next_screen_gig_complete
			endif
		else
			net_ui_song_breakdown_go_to_setlist
		endif
	else
		if ((<type> = career) || (<type> = quickplay))
			net_song_breakdown_end_of_timer_transition_local <...>
		else
			net_song_breakdown_competitive_end_of_timer_transition_local <...>
		endif
	endif
endscript

script net_song_breakdown_add_to_timer 
	if ($song_breakdown_countdown_time_added = 0)
		change song_breakdown_countdown_time = (($song_breakdown_countdown_time) + 30)
		change \{song_breakdown_countdown_time_added = 1}
		if IsHost
			SendStructure \{callback = net_song_breakdown_add_to_timer
				data_to_send = {
					none
				}}
		endif
	endif
endscript

script net_song_breakdown_end_of_timer_transition_local 
	if GotParam \{end_of_setlist_transition}
		ui_song_breakdown_continue_to_next_screen_gig_complete
	elseif GotParam \{encore_transition}
		ui_song_breakdown_continue_to_next_screen_encore
	elseif (GotParam add_setlist_continue_handlers)
		if ((($sb_trans_flag) = 1) || (GotParam add_setlist_continue_handlers))
			ui_song_breakdown_continue_to_next_screen_song_transition
		endif
	endif
endscript

script song_breakdown_assign_band_data 

	challenge_text = qs("\L")
	band_challenge_alpha = 0
	GameMode_GetType
	if song_breakdown_is_single_player_game
		if (<type> = freeplay)
			freeplay_get_first_active_player
		else
			player = 1
		endif
		ui_song_breakdown_get_basic_player_data player_index = <player>
		song_breakdown_noncompetitive_id :SE_SetProps {
			song_title_text = <song_name>
			score_main_text = <score_text>
			accuracy_main_text = <percent_text>
			streak_main_text = <streak_text>
			stars_number_text = qs("\L")
		}
	else
		if (($g_leader_player_num) != -1)
			GetPlayerInfo ($g_leader_player_num) Band
		else
			player = 1

		endif
		b_note_streak = ($gig_detailed_stats_band.high_2p_streak)
		if (($gig_detailed_stats_band.high_3p_streak) > <b_note_streak>)
			b_note_streak = ($gig_detailed_stats_band.high_3p_streak)
		endif
		if (($gig_detailed_stats_band.high_4p_streak) > <b_note_streak>)
			b_note_streak = ($gig_detailed_stats_band.high_4p_streak)
		endif
		score = ($gig_detailed_stats_band.score)
		b_high_mult = ($gig_detailed_stats_band.high_mult)
		CastToInteger \{b_high_mult}
		CastToInteger \{score}
		FormatText TextName = song_text qs("%s") s = <song_name>
		FormatText TextName = band_score_text qs("%n") n = <score> DecimalPlaces = 0 usecommas
		FormatText TextName = band_high_mult_text qs("%nx") n = <b_high_mult>
		FormatText TextName = band_high_note_streak qs("%n") n = <b_note_streak>
		stars = ($gig_detailed_stats_band.stars)
		song_breakdown_noncompetitive_id :SE_SetProps {
			song_title_text = <song_text>
			score_main_text = <band_score_text>
			accuracy_main_text = <band_high_mult_text>
			accuracy_caption_text = qs("BAND MULTIPLIER")
			streak_main_text = <band_high_note_streak>
			streak_caption_text = qs("BAND STREAK")
			stars_number_text = qs("\L")
		}
		if (<type> = pro_faceoff)
			song_breakdown_noncompetitive_id :SE_SetProps \{score_alpha = 0.0
				accuracy_alpha = 0.0
				streak_alpha = 0.0
				stars_number_alpha = 0.0}
			stars = -1
		endif
	endif
	song_breakdown_noncompetitive_id :Obj_SpawnScriptNow ui_song_breakdown_normal_animate_stats params = {num_stars = <stars>}
endscript

script ui_song_breakdown_setup_handler_scripts 
	continue_script = nullscript
	back_script = nullscript
	option_script = nullscript
	option2_script = nullscript
	continue_text = qs("CONTINUE")
	back_text = qs("MORE STATS")
	option_text = qs("TOP ROCKERS")
	option2_text = qs("LEADERBOARD")
	back_params = {}
	transition_param = none
	if GotParam \{playlist_transition}
		continue_script = ui_song_breakdown_continue_playlist
		back_script = song_breakdown_go_to_stats_from_transition
		option_script = song_breakdown_run_top_rockers_from_transition
	elseif GotParam \{end_of_setlist_transition}
		if ($is_network_game = 1)
			continue_script = net_ui_song_breakdown_continue_to_next_screen_gig_complete
		else
			continue_script = ui_song_breakdown_continue_to_next_screen_gig_complete
			back_script = song_breakdown_go_to_stats_from_transition
			GameMode_GetType
			if (<type> = quickplay)
				option_script = song_breakdown_run_top_rockers_from_transition
			endif
		endif
		transition_param = end_of_setlist_transition
	elseif GotParam \{encore_transition}
		continue_script = ui_song_breakdown_continue_to_next_screen_encore
		if ($is_network_game = 0)
			back_script = song_breakdown_go_to_stats_from_transition
		endif
		transition_param = encore_transition
	elseif ((GotParam continue_setlist_transition) || (GotParam add_setlist_continue_handlers))
		if ((($sb_trans_flag) = 1) || (GotParam add_setlist_continue_handlers))
			continue_script = ui_song_breakdown_continue_to_next_screen_song_transition
			back_script = song_breakdown_go_to_stats_from_transition
			GameMode_GetType
			if (<type> = quickplay)
				option_script = song_breakdown_run_top_rockers_from_transition
			endif
			if ($is_network_game = 1)
				song_breakdown_noncompetitive_id :Obj_SpawnScriptNow net_ui_song_breakdown_start_timer_spawned params = {<...>}
			endif
			if GotParam \{continue_setlist_transition}
				transition_param = continue_setlist_transition
			else
				transition_param = add_setlist_continue_handlers
			endif
		endif
	elseif GotParam \{net_transition_not_career}
		continue_script = net_ui_song_breakdown_go_to_setlist
		continue_text = qs("GO TO SETLIST")
		back_script = postgame_lobby_quit
		back_params = {id = song_breakdown_noncompetitive_id}
		back_text = qs("QUIT")
		option_script = nullscript
		option2_script = song_breakdown_go_to_stats_from_transition
		option2_text = qs("MORE STATS")
		transition_param = net_transition_not_career
	else
		debug_ScriptAssert \{'Invalid transition from song breakdown'}
	endif
	if (GotParam no_wait)
		spawnscriptnow ui_song_breakdown_add_handlers_for_next_transition_spawned params = {
			screen_element_id = song_breakdown_noncompetitive_id
			continue_script = <continue_script>
			back_script = <back_script>
			option_script = <option_script>
			option2_script = <option2_script>
			continue_text = <continue_text>
			back_text = <back_text>
			option_text = <option_text>
			option2_text = <option2_text>
			back_params = <back_params>
			transition_param = <transition_param>
			no_wait
		}
	else
		spawnscriptnow ui_song_breakdown_add_handlers_for_next_transition_spawned params = {
			screen_element_id = song_breakdown_noncompetitive_id
			continue_script = <continue_script>
			back_script = <back_script>
			option_script = <option_script>
			option2_script = <option2_script>
			continue_text = <continue_text>
			back_text = <back_text>
			option_text = <option_text>
			option2_text = <option2_text>
			back_params = <back_params>
			transition_param = <transition_param>
		}
	endif
endscript

script net_ui_song_breakdown_focus_player_strips_menu_for_rocker_record 
	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		if IsScreenElementInFocus \{id = song_breakdown_noncompetitive_id}
			LaunchEvent \{type = unfocus
				target = song_breakdown_noncompetitive_id}
		endif
		if song_breakdown_noncompetitive_id :Desc_ResolveAlias \{name = alias_player_stats_element}
			LaunchEvent type = focus target = <resolved_id> data = {child_index = 0}
			clean_up_user_control_helpers
			add_user_control_helper \{text = qs("SELECT")
				button = green
				z = 100000}
			add_user_control_helper \{text = qs("BACK")
				button = red
				z = 100000}
		else

		endif
	endif
endscript

script net_ui_song_breakdown_unfocus_player_strips_menu 
	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		if song_breakdown_noncompetitive_id :Desc_ResolveAlias \{name = alias_player_stats_element}
			if IsScreenElementInFocus id = <resolved_id>
				LaunchEvent type = unfocus target = <resolved_id>
			endif
		endif
		clean_up_user_control_helpers
		ui_song_breakdown_setup_handler_scripts \{net_transition_not_career
			no_wait}
	endif
endscript

script net_ui_song_breakdown_launch_rock_record 

	GetPlayerInfo <player> gamertag
	xuid = [0 0]
	GetPlayerInfo <player> net_id_first
	GetPlayerInfo <player> net_id_second
	SetArrayElement ArrayName = xuid index = 0 newvalue = <net_id_first>
	SetArrayElement ArrayName = xuid index = 1 newvalue = <net_id_second>
	name = $<gamertag>
	clean_up_user_control_helpers
	display_rock_record {
		device_num = <device_num>
		net_id = <xuid>
		player_name = <name>
		unfocus_id = <unfocus_id>
		parent = <parent_id>
	}
endscript

script ui_return_song_breakdown 
	clean_up_user_control_helpers
	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		if song_breakdown_noncompetitive_id :GetSingleTag \{transition_param}
			ui_song_breakdown_setup_handler_scripts <transition_param> no_wait
		endif
	endif
endscript

script ui_song_breakdown_hide_player_data 
	GameMode_GetType
	if (<type> != freeplay)
		GameMode_GetNumPlayersShown
	else
		freeplay_get_num_active_players
		num_players = <num_active_players>
	endif
	if song_breakdown_noncompetitive_id :Desc_ResolveAlias \{name = alias_player_stat_list}
		num_data_strips_to_hide = (4 - <num_players_shown>)
		if (<num_data_strips_to_hide> > 0)
			GetScreenElementChildren id = <resolved_id>
			i = 3
			begin
			(<children> [<i>]) :SE_SetProps alpha = 0
			<i> = (<i> - 1)
			repeat <num_data_strips_to_hide>
		endif
	endif
endscript

script ui_song_breakdown_get_basic_player_data \{player_index = 1}
	GameMode_GetType
	if ((<type> = career || <type> = quickplay || <type> = freeplay) && ($is_network_game = 0))
		getScoreFromDetailedStats player = <player_index>
		getBestRunFromDetailedStats player = <player_index>
		getMaxNotesFromDetailedStats player = <player_index>
		getNotesHitFromDetailedStats player = <player_index>
		getStarsFromDetailedStats player = <player_index>
		getVocalStreakPhrasesFromDetailedStats player = <player_index>
		getVocalPhraseQualityFromDetailedStats player = <player_index>
		getVocalPhraseMaxQualFromDetailedStats player = <player_index>
		getCashRankUpFromDetailedStats player = <player_index>
		getTotalNotesFromDetailedStats player = <player_index>
		getCareerEarningsFromDetailedStats player = <player_index>
	else
		GetPlayerInfo <player_index> best_run
		GetPlayerInfo <player_index> score
		GetPlayerInfo <player_index> max_notes
		GetPlayerInfo <player_index> notes_hit
		GetPlayerInfo <player_index> stars
		GetPlayerInfo <player_index> cash_rank_up
		GetPlayerInfo <player_index> vocal_streak_phrases
		GetPlayerInfo <player_index> vocal_phrase_quality
		GetPlayerInfo <player_index> vocal_phrase_max_qual
		GetPlayerInfo <player_index> total_notes
		GetPlayerInfo <player_index> career_earnings
	endif
	GetPlayerInfo <player_index> part
	GetPlayerInfo <player_index> difficulty
	GetPlayerInfo <player_index> new_cash
	if (<max_notes> = 0)
		max_notes = 1
	endif
	GetPlayerInfo <player_index> difficulty
	get_difficulty_text difficulty = <difficulty>
	GetPlayerInfo <player_index> double_kick_drum
	if (<part> = drum)
		if (<double_kick_drum> = 1)
			<difficulty_text> = qs("EXPERT+")
		endif
	endif
	CastToInteger \{score}
	FormatText TextName = score_text qs("\L%s") s = <score> usecommas
	ui_song_breakdown_get_player_display_name player_index = <player_index>
	if NOT PlayerInfoEquals <player_index> part = Vocals
		if (<type> = practice)
			if (<total_notes> > 0)
				<percent_notes_hit> = (((<notes_hit> * 1.0) / <total_notes>) * 100.0)
			else
				<percent_notes_hit> = 0
			endif
		else
			if (<max_notes> > 0)
				<percent_notes_hit> = (((<notes_hit> * 1.0) / <max_notes>) * 100.0)
			else
				<percent_notes_hit> = 0
			endif
		endif
		MathFloor <percent_notes_hit>
		<percent_notes_hit> = <floor>
		if (<percent_notes_hit> = 0 && <notes_hit> > 0)
			<percent_notes_hit> = 1
		endif
		if GotParam \{no_units}
			FormatText TextName = percent_text qs("\L%p") p = <percent_notes_hit>
		else
			FormatText TextName = percent_text qs("\L%p\%") p = <percent_notes_hit>
		endif
		FormatText TextName = streak_text qs("\L%n") n = <best_run> DecimalPlaces = 0
	else
		if (<vocal_phrase_max_qual> > 0)
			percent_notes_hit = (((<vocal_phrase_quality> * 1.0) / <vocal_phrase_max_qual>) * 100.0)
			MathFloor <percent_notes_hit>
			<percent_notes_hit> = <floor>
			if (<percent_notes_hit> = 0 && <vocal_phrase_quality> > 0)
				<percent_notes_hit> = 1
			endif
			if GotParam \{no_units}
				FormatText TextName = percent_text qs("\L%p") p = <percent_notes_hit> DecimalPlaces = 0
			else
				FormatText TextName = percent_text qs("\L%p\%") p = <percent_notes_hit> DecimalPlaces = 0
			endif
		else
			<percent_text> = qs("NA")
		endif
		FormatText TextName = streak_text qs("\L%n") n = <vocal_streak_phrases> DecimalPlaces = 0
	endif
	FormatText TextName = cash_text qs("\L$%n") n = <new_cash> usecommas
	ui_song_breakdown_get_player_instrument_texture part = <part>
	GetPlayerInfo <player_index> double_kick_drum
	ui_song_breakdown_get_player_difficulty_texture {
		part = <part>
		difficulty = <difficulty>
		double_kick_drum = <double_kick_drum>
	}
	return <...>
endscript

script ui_song_breakdown_get_player_display_name 

	<name> = qs("")
	if ($is_network_game = 1)
		GetPlayerInfo <player_index> gamertag
		name = $<gamertag>
	else
		if isXenon
			GetPlayerInfo <player_index> controller
			if NOT ((<controller> < 0) || (<controller> > 3))
				if GetLocalGamerTag controller = <controller>
					<name> = <gamertag>
				endif
			endif
		endif
	endif
	if (<name> = qs(""))
		GetPlayerInfo <player_index> character_id
		get_savegame_from_player_status player = <player_index>
		get_fullname_of_character id = <character_id> savegame = <savegame> profanity_allowed
		<player_name_text> = <fullname>
	else
		<player_name_text> = <name>
	endif
	return player_name_text = <player_name_text>
endscript

script ui_song_breakdown_get_player_instrument_texture 

	switch (<part>)
		case guitar
		icon_texture = icon_instrument_guitar_top
		case Bass
		icon_texture = icon_instrument_bass_top
		case drum
		icon_texture = icon_instrument_drums_top
		case Vocals
		icon_texture = icon_instrument_vox_top
	endswitch
	return icon_texture = <icon_texture>
endscript

script ui_song_breakdown_get_player_difficulty_texture 

	switch (<difficulty>)
		case beginner
		diff_texture = icon_difficulty_beginner
		case easy
		diff_texture = icon_difficulty_easy
		case medium
		diff_texture = icon_difficulty_medium
		case hard
		diff_texture = icon_difficulty_hard
		case expert
		diff_texture = icon_difficulty_expert
		if (<part> = drum)
			if (<double_kick_drum> = 1)
				diff_texture = icon_difficulty_expert_plus
			endif
		endif
	endswitch
	return diff_texture = <diff_texture>
endscript

script get_percent_notes_hit 
	ui_song_breakdown_get_basic_player_data player_index = <player_index>
	if NOT PlayerInfoEquals <player_index> part = Vocals
		if (<max_notes> > 0)
			<percent_notes_hit> = (((<notes_hit> * 1.0) / <max_notes>) * 100.0)
		else
			<percent_notes_hit> = 0
		endif
		MathFloor <percent_notes_hit>
		<percent_notes_hit> = <floor>
	else
		if (<vocal_phrase_max_qual> > 0)
			<percent_notes_hit> = (((<vocal_phrase_quality> * 1.0) / <vocal_phrase_max_qual>) * 100.0)
		else
			<percent_notes_hit> = 0
		endif
		MathFloor <percent_notes_hit>
		<percent_notes_hit> = <floor>
	endif
	return percent_notes_hit = <percent_notes_hit>
endscript

script ui_song_breakdown_add_handlers_for_next_transition_spawned 

	array = [
		{pad_up song_breakdown_scroll_stats params = {direction = up}}
		{pad_down song_breakdown_scroll_stats params = {direction = down}}
		{pad_left song_breakdown_scroll_stats params = {direction = left}}
		{pad_right song_breakdown_scroll_stats params = {direction = right}}
	]
	if NOT (<continue_script> = nullscript)
		if GotParam \{continue_params}
			AddArrayElement array = <array> element = {pad_choose <continue_script> params = <continue_params>}
		else
			AddArrayElement array = <array> element = {pad_choose <continue_script>}
		endif
		add_user_control_helper ($ui_song_breakdown_helper_params) text = <continue_text> button = green z = 100000
	endif
	if NOT (<back_script> = nullscript)
		if GotParam \{back_params}
			AddArrayElement array = <array> element = {pad_back <back_script> params = <back_params>}
		else
			AddArrayElement array = <array> element = {pad_back <back_script>}
		endif
		add_user_control_helper ($ui_song_breakdown_helper_params) text = <back_text> button = red z = 100000
	endif
	if NOT (<option2_script> = nullscript)
		if GotParam \{option2_params}
			AddArrayElement array = <array> element = {pad_option2 <option2_script> params = <option2_params>}
		else
			AddArrayElement array = <array> element = {pad_option2 <option2_script>}
		endif
		add_user_control_helper ($ui_song_breakdown_helper_params) text = <option2_text> button = Yellow z = 100000
	endif
	if NOT (<option_script> = nullscript)
		if GotParam \{option_params}
			AddArrayElement array = <array> element = {pad_option <option_script> params = <option_params>}
		else
			AddArrayElement array = <array> element = {pad_option <option_script>}
		endif
		add_user_control_helper ($ui_song_breakdown_helper_params) text = <option_text> button = Blue z = 100000
	endif
	<screen_element_id> :SE_SetProps {
		event_handlers = <array>
		replace_handlers
	}
	song_breakdown_check_bot_play
	if (<bot_play> = 0)
		song_breakdown_get_exclusive_devices
		if ScreenElementExists id = <screen_element_id>
			<screen_element_id> :SE_SetProps {
				exclusive_device = <exclusive_devices>
			}
			<screen_element_id> :SetTags transition_param = <transition_param>
		endif
	endif
	if (($sb_trans_flag) = 1)
		change \{sb_trans_flag = 0}
	else
		if NOT (GotParam no_wait)
			Wait \{10
				gameframes}
		endif
	endif
	if (<continue_script> != nullscript)
		if ScreenElementExists id = <screen_element_id>
			if NOT IsScreenElementInFocus id = <screen_element_id>
				LaunchEvent type = focus target = <screen_element_id>
			endif
		endif
	endif
endscript

script song_breakdown_run_top_rockers_from_transition 
	if NOT (($song_breakdown_busy_flag) = 0)
		return
	endif
	change \{sb_trans_flag = 1}
	change \{song_breakdown_busy_flag = 1}
	ui_event_wait_for_safe
	song_breakdown_run_top_rockers
endscript

script song_breakdown_run_top_rockers 

	KillSpawnedScript \{name = net_ui_song_breakdown_start_timer_spawned}
	change \{song_breakdown_countdown_time = -1}
	if (($ui_song_breakdown_wrote_tr) = 0)
		change \{ui_song_breakdown_wrote_tr = 1}
		change \{ui_song_breakdown_pulsate_helper_pill = 0}
		generic_event_choose \{state = uistate_top_rockers}
	else
		generic_event_choose \{state = uistate_top_rockers
			data = {
				for_options = 1
			}}
	endif
endscript

script song_breakdown_auto_write_top_rockers 
	GameMode_GetType
	if (<type> = quickplay)
		if (($ui_song_breakdown_wrote_tr) = 0)
			change \{ui_song_breakdown_wrote_tr = 1}
			change \{ui_song_breakdown_pulsate_helper_pill = 0}

		endif
	endif
endscript

script song_breakdown_anim_band_banner_up 
	SetScreenElementProps \{id = song_breakdown_noncompetitive_id
		band_header_container_pos = {
			(0.0, -30.0)
			relative
		}
		time = 0.08
		Anim = gentle}
endscript

script ui_song_breakdown_continue_to_next_screen_gig_complete 

	ui_win_song_continue_next_menu
endscript

script net_ui_song_breakdown_continue_to_next_screen_gig_complete 
	SoundEvent \{event = Menu_Song_Complete_Out}

	GetPakManCurrent \{map = zones}
	if (<pak> != z_studio && <pak> != z_studio2 && <pak> != z_tool && <pak> != z_credits && <pak> != z_training)
		spawnscriptnow \{Skate8_SFX_Backgrounds_New_Area
			params = {
				BG_SFX_Area = FrontEnd_Menu_Music
			}}
	endif
	if IsHost
		if ($net_breakdown_continue_msg_sent = 0)
			change \{net_breakdown_continue_msg_sent = 1}
		else
			return
		endif
	else
		SendStructure \{callback = net_ui_song_breakdown_continue_to_next_screen_gig_complete
			data_to_send = {
				none
			}}
		return
	endif
	ui_win_song_continue_next_menu
endscript

script ui_song_breakdown_continue_to_next_screen_encore 
	if ($is_network_game = 1)
		if IsHost
			if ($net_encore_msg_start_sent = 0)
				change \{net_encore_msg_start_sent = 1}
				SendStructure \{callback = encore_play
					data_to_send = {
						none
					}}
			else
				return
			endif
		else
			SendStructure \{callback = ui_song_breakdown_continue_to_next_screen_encore
				data_to_send = {
					none
				}}
			SoundEvent \{event = Menu_Song_Complete_Out}
			return
		endif
	endif

	SoundEvent \{event = Menu_Song_Complete_Out}
	encore_play
endscript

script ui_song_breakdown_pause_between_songs 
	ui_song_breakdown_add_components_for_transitions <...>
endscript
sb_trans_flag = 0
song_breakdown_busy_flag = 0

script song_breakdown_go_to_leaderboard_from_transition 
	if isXenon
		change lb_controller = <device_num>
	elseif IsPs3
		get_all_exclusive_devices
		change lb_controller = <exclusive_device>
	endif
	signin_params = {local}
	if IsPs3
		signin_params = {}
	endif
	if NOT (($song_breakdown_busy_flag) = 0)
		return
	endif
	change \{sb_trans_flag = 1}
	change \{song_breakdown_busy_flag = 1}
	KillSpawnedScript \{name = net_ui_song_breakdown_start_timer_spawned}
	change \{song_breakdown_countdown_time = -1}
	ui_event_wait_for_safe
endscript

script song_breakdown_go_to_stats_from_transition 
	if NOT (($song_breakdown_busy_flag) = 0)
		return
	endif
	if ($is_network_game = 1)
		if ($song_breakdown_countdown_time_added = 0)
			if IsHost
				change song_breakdown_countdown_time = (($song_breakdown_countdown_time) + 30)
				change \{song_breakdown_countdown_time_added = 1}
				SendStructure \{callback = net_song_breakdown_add_to_timer
					data_to_send = {
						none
					}}
			else
				SendStructure \{callback = net_song_breakdown_add_to_timer
					data_to_send = {
						none
					}}
			endif
		endif
	else
		KillSpawnedScript \{name = net_ui_song_breakdown_start_timer_spawned}
		change \{song_breakdown_countdown_time = -1}
	endif
	change \{song_breakdown_busy_flag = 1}
	ui_event_wait_for_safe
	change \{sb_trans_flag = 1}
	generic_event_choose \{state = uistate_song_summary_details}
endscript

script ui_song_breakdown_continue_playlist 
	generic_menu_pad_choose_sound
	change \{gameplay_restart_song = 1}
	generic_event_back \{nosound
		state = uistate_gameplay}
endscript

script ui_song_breakdown_continue_to_next_screen_song_transition 

	if NOT (($song_breakdown_busy_flag) = 0)
		return
	endif
	change \{song_breakdown_busy_flag = 1}
	generic_menu_pad_choose_sound
	SoundEvent \{event = Menu_Song_Complete_Out}
	change \{songtime_paused = 0}
	if ($track_last_song = jamsession)
		jam_ratesong_check_for_rating
	else
		GameMode_GetType
		generic_event_back \{nosound
			state = uistate_gameplay}
	endif
endscript

script song_breakdown_check_bot_play 
	bot_play_is_enabled = 0
	GameMode_GetNumPlayersShown
	if (<num_players_shown> > 0)
		player = 1
		begin
		GetPlayerInfo <player> bot_play
		if (<bot_play> = 1)
			bot_play_is_enabled = 1
			break
		endif
		<player> = (<player> + 1)
		repeat <num_players_shown>
	endif
	return bot_play = <bot_play_is_enabled>
endscript

script song_breakdown_get_exclusive_devices 
	exclusive_devices = []
	if GotParam \{band_leader_only}
		GetPlayerInfo ($g_leader_player_num) controller
		AddArrayElement array = <exclusive_devices> element = <controller>
		<exclusive_devices> = <array>
	else
		GameMode_GetNumPlayersShown
		if (<num_players_shown> > 0)
			player = 1
			begin
			GetPlayerInfo <player> controller
			AddArrayElement array = <exclusive_devices> element = <controller>
			<exclusive_devices> = <array>
			<player> = (<player> + 1)
			repeat <num_players_shown>
		endif
	endif
	return exclusive_devices = <exclusive_devices>
endscript

script ui_song_breakdown_should_allow_transition_to_leaderboards 
	GameMode_GetType
	if (<type> = freeplay)
		return \{false}
	endif
	if ui_song_breakdown_someone_signed_in
		return \{true}
	endif
	return \{false}
endscript

script ui_song_breakdown_someone_signed_in 
	signin_params = {local}
	if IsPs3
		signin_params = {}
	endif
	GameMode_GetNumPlayersShown
	if (<num_players_shown> > 0)
		player = 1
		begin
		GetPlayerInfo <player> controller
		if CheckForSignIn <signin_params> controller_index = <controller>
			return \{true}
		endif
		<player> = (<player> + 1)
		repeat <num_players_shown>
	endif
	return \{false}
endscript

script ui_song_breakdown_clean_up_highest_multipliers 
	GameMode_GetNumPlayersShown
	if (<num_players_shown> > 0)
		player = 1
		begin
		SetPlayerInfo <player> highest_multiplier = 1
		<player> = (<player> + 1)
		repeat <num_players_shown>
	endif
endscript

script ui_song_breakdown_clear_ready_up_book_keeping 
	change \{ui_song_breakdown_players_rdy = [
			0
			0
			0
			0
		]}
endscript

script ui_song_breakdown_set_player_ready 
	if song_breakdown_noncompetitive_id :Desc_ResolveAlias \{name = alias_player_stats_element}
		GetScreenElementChildren id = <resolved_id>
		GetScreenElementProps id = (<children> [<dev_num>])
		if (<check_mark_alpha> = 0)
			if (($game_mode = gh4_p1_career) || ($game_mode = practice) || ($game_mode = tutorial) || ($game_mode = p1_quickplay))
				generic_menu_pad_choose_sound
			else
				SoundEvent \{event = Box_Check_SFX}
			endif
		endif
		(<children> [<dev_num>]) :SE_SetProps {
			check_mark_alpha = 1
		}
	endif
endscript

script legacy_ui_song_breakdown_clear_ready_up_book_keeping 
	change \{ui_song_breakdown_players_rdy = [
			0
			0
			0
			0
		]}
endscript

script legacy_ui_song_breakdown_clean_up_highest_multipliers 
	GameMode_GetNumPlayersShown
	player_idx = 1
	begin
	SetPlayerInfo <player_idx> highest_multiplier = 1
	player_idx = (<player_idx> + 1)
	repeat <num_players_shown>
endscript

script getScoreFromDetailedStats \{player = 1}
	score = ($gig_detailed_stats [(<player> - 1)] [0].score)
	return score = <score>
endscript

script getBestRunFromDetailedStats \{player = 1}
	best_run = ($gig_detailed_stats [(<player> - 1)] [0].best_run)
	return best_run = <best_run>
endscript

script getStarsFromDetailedStats \{player = 1}
	stars = ($gig_detailed_stats [(<player> - 1)] [0].stars)
	return stars = <stars>
endscript

script getNotesHitFromDetailedStats \{player = 1}
	notes_hit = ($gig_detailed_stats [(<player> - 1)] [0].notes_hit)
	return notes_hit = <notes_hit>
endscript

script getMaxNotesFromDetailedStats \{player = 1}
	max_notes = ($gig_detailed_stats [(<player> - 1)] [0].max_notes)
	return max_notes = <max_notes>
endscript

script getTotalNotesFromDetailedStats \{player = 1}
	total_notes = ($gig_detailed_stats [(<player> - 1)] [0].total_notes)
	return total_notes = <total_notes>
endscript

script getSpPhrasesHitFromDetailedStats \{player = 1}
	sp_phrases_hit = ($gig_detailed_stats [(<player> - 1)] [0].sp_phrases_hit)
	return sp_phrases_hit = <sp_phrases_hit>
endscript

script getSpPhrasesTotalFromDetailedStats \{player = 1}
	sp_phrases_total = ($gig_detailed_stats [(<player> - 1)] [0].sp_phrases_total)
	return sp_phrases_total = <sp_phrases_total>
endscript

script getAvgMultiplierFromDetailedStats \{player = 1}
	avg_multiplier = ($gig_detailed_stats [(<player> - 1)] [0].avg_multiplier)
	return avg_multiplier = <avg_multiplier>
endscript

script getVocalStreakPhrasesFromDetailedStats \{player = 1}
	vocal_streak_phrases = ($gig_detailed_stats [(<player> - 1)] [0].vocal_streak_phrases)
	return vocal_streak_phrases = <vocal_streak_phrases>
endscript

script getVocalPhraseQualityFromDetailedStats \{player = 1}
	vocal_phrase_quality = ($gig_detailed_stats [(<player> - 1)] [0].vocal_phrase_quality)
	return vocal_phrase_quality = <vocal_phrase_quality>
endscript

script getVocalPhraseMaxQualFromDetailedStats \{player = 1}
	vocal_phrase_max_qual = ($gig_detailed_stats [(<player> - 1)] [0].vocal_phrase_max_qual)
	return vocal_phrase_max_qual = <vocal_phrase_max_qual>
endscript

script getCashRankUpFromDetailedStats \{player = 1}
	cash_rank_up = ($gig_detailed_stats [(<player> - 1)] [0].cash_rank_up)
	return cash_rank_up = <cash_rank_up>
endscript

script getNewCashFromDetailedStats \{player = 1}
	new_cash = ($gig_detailed_stats [(<player> - 1)] [0].new_cash)
	return new_cash = <new_cash>
endscript

script getCareerEarningsFromDetailedStats \{player = 1}
	career_earnings = ($gig_detailed_stats [(<player> - 1)] [0].career_earnings)
	return career_earnings = <career_earnings>
endscript

script song_breakdown_drop_player 


	if (<is_game_over> = 0)
		GameMode_GetType
		if (<type> = career)
			wait_for_safe_shutdown
			spawnscriptnow gameplay_drop_player params = {<...>}
		endif
		sb_kill_timer_remove_handlers
	endif
endscript

script sb_kill_timer_remove_handlers 
	KillSpawnedScript \{name = net_ui_song_breakdown_start_timer_spawned}
	GameMode_GetType
	if (<type> = career || <type> = quickplay)
		screen_id = song_breakdown_noncompetitive_id
	else
		screen_id = song_breakdown_competitive_id
	endif
	if ScreenElementExists id = <screen_id>
		LaunchEvent type = unfocus target = <screen_id>
		<screen_id> :SE_SetProps {
			net_timer_text_alpha = 0
			event_handlers = [
				{pad_choose nullscript}
				{pad_option nullscript}
				{pad_option2 nullscript}
				{pad_l1 nullscript}
				{pad_start nullscript}
			]
			replace_handlers
		}
	endif
endscript

script song_breakdown_end_game 


	destroy_dialog_box
	if ((<is_game_over> = 1) && ($net_popup_active = 0))
		net_disable_pause
		ui_event_get_top
		if (<base_name> = 'online_quit_warning')
			generic_event_back
			ui_event_wait_for_safe
		endif
		switch <drop_reason>
			case net_message_player_quit
			FormatText TextName = first_msg qs("%s has quit.") s = <name_string>
			case net_message_player_dropped
			case net_message_player_timed_out
			FormatText TextName = first_msg qs("Lost connection to %s.") s = <name_string>
			default
			first_msg = qs("")
		endswitch
		FormatText TextName = msg qs("%s\nThere are not enough players to continue.") s = <first_msg>
		ui_event_get_stack
		if ((<stack> [0].base_name) = 'encore_confirmation')
			Transition_KillAll
		endif
		create_net_popup title = qs("GAME OVER") popup_text = <msg>
		if ScreenElementExists \{id = dialog_box_container}
			dialog_box_container :SE_SetProps \{z_priority = 1500.2}
		endif
		if ScreenElementExists \{id = dialog_box_desc_id}
			dialog_box_desc_id :Obj_SpawnScriptNow song_breakdown_end_game_spawned id = not_ui_player_drop_scripts params = {<...>}
		endif
		sb_kill_timer_remove_handlers
	endif
endscript

script song_breakdown_end_game_spawned 
	change \{net_ready_to_start = 1}

	Wait \{3
		seconds}

	destroy_net_popup
	GameMode_GetType
	if (<type> = career || <type> = quickplay)
		screen_id = song_breakdown_noncompetitive_id
	else
		screen_id = song_breakdown_competitive_id
	endif
	if ScreenElementExists id = <screen_id>
		LaunchEvent type = focus target = <screen_id>
		add_user_control_helper ($ui_song_breakdown_helper_params) text = qs("QUIT") button = red z = 100000
	endif
	GameMode_GetType
	if (<type> = career)
		if ($playing_song = 1)
			kill_gem_scroller
		endif
		ui_memcard_autosave \{event = menu_back
			state = uistate_group_play
			data = {
				all_active_players = true
			}}
	endif
endscript

script create_ui_star_particles 
	Destroy2DParticleSystem \{id = sukit}
	Create2DParticleSystem \{id = sukit
		pos = (640.0, 340.0)
		z_priority = 1000
		texture = white
		blend = blend
		parent = song_breakdown_noncompetitive_id
		start_color = [
			255
			255
			255
			255
		]
		end_color = [
			255
			255
			255
			255
		]
		start_scale = (1.55, 1.55)
		end_scale = (1.3499999, 1.3499999)
		start_angle_spread = 360.0
		min_rotation = 0
		max_rotation = 0
		emit_start_radius = 12
		emit_radius = 1
		emit_rate = 0.035
		emit_dir = 0.0
		emit_spread = 44.0
		velocity = 28.0
		friction = (0.0, 88.0)
		time = 1.0}
	Wait \{1
		second}
	Destroy2DParticleSystem \{kill_when_empty
		id = sukit}
endscript

script anim_star_wiggle_loop 
	begin
	my_alpha = Random (@ 1 @ 0.9 @ 0.8 )
	my_alpha2 = Random (@ 1 @ 0.8 )
	my_scale1 = Random (@ (1.03, 0.96999997) @ (0.96999997, 1.03) @*20 (1.0, 1.0) )
	my_scale2 = Random (@ (0.81, 0.78999996) @ (0.78999996, 0.81) @*20 (0.8, 0.8) )
	SE_SetProps {
		song_summary_star2_alpha = <my_alpha>
		song_summary_star_alpha = <my_alpha2>
		motion = ease_out
		time = 0.1
	}
	SE_SetProps {
		song_summary_star_scale = <my_scale2>
		song_summary_star2_scale = <my_scale1>
		motion = ease_out
		time = 0.05
	}
	SE_WaitProps
	repeat
endscript
