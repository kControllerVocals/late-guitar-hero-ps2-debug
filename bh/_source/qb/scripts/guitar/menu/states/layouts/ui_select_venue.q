
script ui_init_career_venue_select 
	change \{respond_to_signin_changed_func = ui_signin_changed_func}
endscript

script ui_create_career_venue_select 
	menu_music_on
	initial_venue_index = 0
	if gotparam \{venue_index}
		initial_venue_index = <venue_index>
	elseif gotparam \{gig_index}
		initial_venue_index = (<gig_index> - 1)
	endif
	createscreenelement \{parent = root_window
		id = career_venue_select_screen_id
		type = descinterface
		desc = 'venue_select'
		pos = (280.0, 140.0)
		slider_nub_cont_pos = (0.0, 24.0)
		z_priority = 5.0}
	career_venue_select_screen_id :obj_spawnscript \{0x8ed8c79c}
	song_breakdown_check_bot_play
	if (<bot_play> = 0)
		exclusive_device = $primary_controller
		career_venue_select_screen_id :se_setprops {
			exclusive_device = <exclusive_device>
		}
	endif
	if ininternetmode
		event_handlers = [
			{pad_back net_career_venue_select_back_to_band_lobby params = {no_quit_warning = 0}}
			{pad_option2 net_career_venue_select_show_players_list}
		]
	else
		event_handlers = [
			{pad_back career_venue_select_back_to_band_lobby}
		]
	endif
	career_venue_select_screen_id :se_setprops {
		event_handlers = <event_handlers>
		replace_handlers
	}
	get_savegame_from_controller controller = ($primary_controller)
	ui_career_venue_select_set_total_progression_text screen_id = career_venue_select_screen_id savegame = <savegame>
	ui_career_venue_select_populate_venues_menu venue_index = <initial_venue_index> bot_play = <bot_play> controller = <exclusive_device>
	if gotparam \{venue_menu_id}
		if gotparam \{load_venue_checksum}
			ui_career_venue_select_highlight_venue load_venue_chksum = <load_venue_checksum> menu_id = <venue_menu_id>
		endif
		assignalias id = <venue_menu_id> alias = current_menu
	endif
	launchevent \{type = focus
		target = career_venue_select_screen_id}
	if career_venue_select_screen_id :desc_resolvealias \{name = alias_poster_anim
			param = poster_anim_id}
		<poster_anim_id> :obj_spawnscript ui_shakey_02
	else

	endif
	if career_venue_select_screen_id :desc_resolvealias \{name = alias_poster_anim
			param = poster_anim_id}
		<poster_anim_id> :obj_spawnscript ui_frazzmatazz_02
	else

	endif
	if career_venue_select_screen_id :desc_resolvealias \{name = alias_title_banner_anim
			param = title_banner_id}
		<title_banner_id> :obj_spawnscript ui_shakey
	else

	endif
	if career_venue_select_screen_id :desc_resolvealias \{name = alias_title_banner_anim
			param = title_banner_id}
		<title_banner_id> :obj_spawnscript ui_frazzmatazz
	else

	endif
	if career_venue_select_screen_id :desc_resolvealias \{name = alias_bg_anim_left
			param = bg_anim_left_id}
		<bg_anim_left_id> :obj_spawnscript ui_shakey_02
	else

	endif
	if career_venue_select_screen_id :desc_resolvealias \{name = alias_bg_anim_left
			param = bg_anim_left_id}
		<bg_anim_left_id> :obj_spawnscript ui_frazzmatazz
	else

	endif
	if career_venue_select_screen_id :desc_resolvealias \{name = alias_bg_anim_right
			param = bg_anim_right_id}
		<bg_anim_right_id> :obj_spawnscript ui_shakey_02
	else

	endif
	if career_venue_select_screen_id :desc_resolvealias \{name = alias_bg_anim_right
			param = bg_anim_right_id}
		<bg_anim_right_id> :obj_spawnscript ui_frazzmatazz
	else

	endif
endscript

script ui_destroy_career_venue_select 
	clean_up_user_control_helpers
	if screenelementexists \{id = career_venue_select_screen_id}
		destroyscreenelement \{id = career_venue_select_screen_id}
	endif
endscript

script ui_return_career_venue_select 
	if screenelementexists \{id = career_venue_select_screen_id}
		if NOT isscreenelementinfocus \{id = career_venue_select_screen_id}
			launchevent \{type = focus
				target = career_venue_select_screen_id}
		endif
		if (($g_suppress_anim_in) = 1)
			change \{g_suppress_anim_in = 0}
		endif
	endif
endscript

script ui_career_venue_select_populate_venues_menu 

	if screenelementexists \{id = career_venue_select_screen_id}
		get_progression_globals ($current_progression_flag)
		get_savegame_from_controller controller = ($primary_controller)
		num_tiers = (($<tier_global>).num_tiers)
		if (<num_tiers> > 0)
			if career_venue_select_screen_id :desc_resolvealias \{name = alias_venue_select_menu
					param = venue_menu}
				i = 0
				begin
				formattext checksumname = tier 'tier%n' n = (<i> + 1)
				venue_checksum = ($<tier_global>.<tier>.level)
				formattext checksumname = load_venue_checksum 'venue_%s' s = ($levelzones.<venue_checksum>.name)
				getglobaltags savegame = <savegame> <load_venue_checksum>
				get_progression_globals ($current_progression_flag)
				formattext {
					checksumname = 0x40e386eb
					'%s_%i'
					s = ($levelzones.<venue_checksum>.name)
					i = ($instrument_list.($<tier_global>.part).text_nl)
					addtostringlookup = true
				}
				getglobaltags <0x40e386eb> param = unlocked
				if (<unlocked> = 1)
					<venue_title> = ($levelzones.<venue_checksum>.title)
					createscreenelement {
						parent = <venue_menu>
						type = descinterface
						desc = 'venue_select_item'
						venue_text_text = <venue_title>
						venue_text_rgba = [255 255 255 255]
						light_bar_alpha = 0
						icon_lock_alpha = 0
						autosizedims = true
						tags = {
							venue_index = <i>
							num_venues = <num_tiers>
							load_venue_checksum = <load_venue_checksum>
							total_venue_stars = <venue_stars>
						}
						event_handlers = [
							{focus ui_career_venue_select_focus_venue params = {unlocked = <unlocked> stars_to_unlock = -1}}
							{unfocus ui_career_venue_select_unfocus_venue}
							{pad_choose career_venue_select_set_venue_and_continue_to_gig_select params = {unlocked = <unlocked>}}
						]
					}
					if ininternetmode
						<id> :se_setprops {
							{pad_option2 net_career_venue_select_show_players_list}
						}
					endif
				else
					career_venue_select_get_stars_to_unlock venue_checksum = <venue_checksum> savegame = <savegame>
					formattext \{textname = venue_title
						qs(0x8fcd256a)}
					createscreenelement {
						parent = <venue_menu>
						type = descinterface
						desc = 'venue_select_item'
						venue_text_text = <venue_title>
						venue_text_rgba = [255 255 255 255]
						light_bar_alpha = 0
						icon_lock_alpha = 1
						autosizedims = true
						tags = {
							venue_index = <i>
							num_venues = <num_tiers>
							load_venue_checksum = <load_venue_checksum>
							total_venue_stars = <venue_stars>
						}
						event_handlers = [
							{focus ui_career_venue_select_focus_venue params = {unlocked = <unlocked> stars_to_unlock = <stars_to_unlock>}}
							{unfocus ui_career_venue_select_unfocus_venue}
						]
					}
				endif
				if (<bot_play> = 0)
					<id> :se_setprops {
						exclusive_device = <controller>
					}
				endif
				create_2d_spring_system desc_id = <id> num_springs = 2 stiffness = 50 rest_length = 1
				<i> = (<i> + 1)
				repeat <num_tiers>
				if (<bot_play> = 0)
					<venue_menu> :se_setprops {
						exclusive_device = <controller>
					}
				endif
				<venue_menu> :se_setprops {
					event_handlers = [
						{pad_up generic_menu_up_or_down_sound up}
						{pad_down generic_menu_up_or_down_sound down}
					]
				}
				0x8dbdaee4 qs(0xafd0459e) i = <venue_index>
				launchevent type = focus target = <venue_menu> data = {child_index = <venue_index>}
				return venue_menu_id = <venue_menu>
			endif
		endif
	endif
endscript

script career_venue_select_set_venue_and_continue_to_gig_select 

	obj_getid
	<objid> :getsingletag venue_index
	if (<unlocked> = 1)
		change \{0xc5b91820 = 0}
		generic_menu_pad_choose_sound
		career_venue_select_screen_id :se_setprops \{block_events}
		career_venue_select_screen_id :obj_killallspawnedscripts
		0xe5a305c6
		0xe6b0b505 venue_index = <venue_index>
		0xd3f993c8 \{full}
		generic_event_replace state = uistate_gig_posters data = {gig_index = (<venue_index> + 1)} no_sound
	endif
endscript

script ui_career_venue_select_focus_venue 

	get_progression_globals ($current_progression_flag)
	if screenelementexists \{id = career_venue_select_screen_id}
		obj_getid
		<objid> :gettags
		<objid> :se_setprops {
			venue_text_rgba = [0 0 0 255]
			light_bar_alpha = 1
		}
		formattext checksumname = tier 'tier%s' s = (<venue_index> + 1)
		venue_checksum = ($<tier_global>.<tier>.level)
		formattext checksumname = load_venue_checksum 'venue_%s' s = ($levelzones.<venue_checksum>.name)
		getglobaltags savegame = <savegame> <load_venue_checksum>
		get_progression_globals ($current_progression_flag)
		formattext {
			checksumname = 0x40e386eb
			'%s_%i'
			s = ($levelzones.<venue_checksum>.name)
			i = ($instrument_list.($<tier_global>.part).text_nl)
			addtostringlookup = true
		}
		getglobaltags <0x40e386eb> param = unlocked
		if (<unlocked> = 1)
			get_local_in_game_player_num_from_controller controller_index = ($primary_controller)
			getarraysize ($<tier_global>.<tier>.songs)
			venue_max_stars = (<array_size> * 5)
			venue_stars = 0
			i = 0
			begin
			progression_song_get_best_difficulty_completed song = ($<tier_global>.<tier>.songs [<i>]) game_mode = ($game_mode) ($current_progression_flag)
			<venue_stars> = (<venue_stars> + <stars>)
			i = (<i> + 1)
			repeat <array_size>
			if structurecontains structure = ($<tier_global>.<tier>) 0x29c8d5a6
				getarraysize ($<tier_global>.<tier>.0x29c8d5a6)
				venue_max_stars = (<venue_max_stars> + (<array_size> * 5))
				i = 0
				begin
				progression_song_get_best_difficulty_completed song = ($<tier_global>.<tier>.0x29c8d5a6 [<i>]) game_mode = ($game_mode) ($current_progression_flag)
				<venue_stars> = (<venue_stars> + <stars>)
				i = (<i> + 1)
				repeat <array_size>
			endif
			formattext textname = venue_stars_text qs(0x555fff68) x = <venue_stars> y = <venue_max_stars>
			career_venue_select_screen_id :se_setprops {
				venue_poster_gh5_alpha = 1
				venue_poster_gh5_texture = ($levelzones.<venue_checksum>.poster)
				venue_unlock_menu_alpha = 0
				last_venue_unlock_alpha = 0
				venue_star_menu_alpha = 1
				venue_stars_text = <venue_stars_text>
			}
		else
			if (<stars_to_unlock> < 0)
				career_venue_select_screen_id :se_setprops \{venue_poster_gh5_alpha = 1
					venue_poster_gh5_texture = venue_poster_locked
					venue_unlock_menu_alpha = 0
					venue_star_menu_alpha = 0
					last_venue_unlock_alpha = 1}
			else
				formattext textname = stars_to_unlock_text qs(0x73307931) s = <stars_to_unlock>
				career_venue_select_screen_id :se_setprops {
					venue_poster_gh5_alpha = 1
					venue_poster_gh5_texture = venue_poster_locked
					venue_unlock_menu_alpha = 1
					venue_unlock_stars_text = <stars_to_unlock_text>
					venue_star_menu_alpha = 0
					last_venue_unlock_alpha = 0
				}
			endif
		endif
		ui_career_venue_select_update_scroll_bar venue_index = <venue_index> num_venues = <num_venues>
		ui_career_venue_select_update_helper_pills allow_choose = <unlocked>
	endif
endscript

script ui_career_venue_select_unfocus_venue 
	obj_getid
	<objid> :se_setprops {
		venue_text_rgba = [255 255 255 255]
		light_bar_alpha = 0
	}
endscript

script ui_career_venue_select_update_scroll_bar 

	if (<num_venues> < 2)
		<num_venues> = 2
	endif
	if screenelementexists \{id = career_venue_select_screen_id}
		<0xdbf7c6c0> = (1.0 * <venue_index>)
		scroll_perc = (<0xdbf7c6c0> / (<num_venues> - 1))
		scroll_len = 375
		scroll_pos = (((<scroll_perc> * <scroll_len>) * (0.0, 1.0)) + (0.0, 22.0))
		career_venue_select_screen_id :se_setprops scrollbar_thumb_pos = <scroll_pos> time = 0.08
	endif
endscript

script ui_career_venue_select_highlight_venue 

	getscreenelementchildren id = <menu_id>
	getarraysize <children>
	if (<array_size> > 0)
		i = 0
		begin
		if (<children> [<i>]) :getsingletag load_venue_checksum
			if (<load_venue_checksum> = <load_venue_chksum>)
				(<children> [<i>]) :se_setprops rgba = gh5_gold_md
				break
			endif
		endif
		<i> = (<i> + 1)
		repeat <array_size>
	endif
endscript

script ui_career_venue_select_update_helper_pills 

	clean_up_user_control_helpers
	if (<allow_choose> = 1)
		add_user_control_helper \{text = qs(0xc18d5e76)
			button = green
			z = 100000}
	endif
	add_user_control_helper \{text = qs(0xaf4d5dd2)
		button = red
		z = 100000}
	if ininternetmode
		add_user_control_helper \{text = qs(0xa83061c6)
			button = yellow
			z = 100000}
	endif
endscript

script ui_career_venue_select_set_total_progression_text 

	if screenelementexists id = <screen_id>
		get_current_progression_stars savegame = <savegame>
		progression_get_total_stars
		formattext textname = stars_num_text qs(0x73307931) s = <total_stars>
		<screen_id> :se_setprops {
			career_stars_text = <stars_num_text>
		}
	endif
endscript

script career_venue_select_back_to_band_lobby 
	generic_event_back
endscript

script career_venue_select_get_stars_to_unlock 

	get_progression_globals ($current_progression_flag)
	num_tiers = ($<tier_global>.num_tiers)
	if (<num_tiers> > 0)
		progression_get_total_stars
		i = 0
		begin
		formattext checksumname = tier 'tier%s' s = (<i> + 1)
		if (<venue_checksum> = ($<tier_global>.<tier>.level))
			return stars_to_unlock = (($<tier_global>.<tier>.stars) - <total_stars>)
		endif
		<i> = (<i> + 1)
		repeat <num_tiers>
	endif
	return \{stars_to_unlock = -1}
endscript

script net_career_venue_select_back_to_band_lobby 

	career_venue_select_back_to_band_lobby no_quit_warning = <no_quit_warning>
endscript

script net_career_venue_select_show_players_list 

	if (<device_num> = ($primary_controller))
		launchevent \{type = unfocus
			target = career_venue_select_screen_id}
		if career_venue_select_screen_id :desc_resolvealias \{name = alias_venue_select_menu}
			launchevent type = unfocus target = <resolved_id>
		endif
		band_lobby_create_popup_menu_players_list \{list_type = matchmaking_done}
		if current_menu :getsingletag \{desc_id}
			current_menu :se_setprops {
				event_handlers = [
					{pad_back net_career_venue_select_destroy_players_list params = {players_list_id = <desc_id>}}
				]
			}
			launchevent \{type = focus
				target = current_menu}
			clean_up_user_control_helpers
			add_user_control_helper \{text = qs(0xc18d5e76)
				button = green
				z = 100000}
			add_user_control_helper \{text = qs(0xaf4d5dd2)
				button = red
				z = 100000}
		endif
	endif
endscript

script net_career_venue_select_destroy_players_list 

	destroyscreenelement id = <players_list_id>
	launchevent \{type = focus
		target = career_venue_select_screen_id}
	if career_venue_select_screen_id :desc_resolvealias \{name = alias_venue_select_menu}
		launchevent type = focus target = <resolved_id>
	endif
	clean_up_user_control_helpers
	ui_career_venue_select_update_helper_pills \{allow_choose = 1}
endscript
