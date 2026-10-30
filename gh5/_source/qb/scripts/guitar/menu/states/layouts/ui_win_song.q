
script ui_init_win_song 
	spawnscriptnow \{kill_gem_scroller}
endscript

script ui_create_win_song 
	set_focus_color
	set_unfocus_color
	createscreenelement \{parent = root_window
		id = myinterfaceelement
		type = descinterface
		desc = 'win_song'}
	myinterfaceelement :desc_checkversion \{desired = 3
		assertif = mismatch}
	myinterfaceelement :se_getprops
	my_song = ($current_song)
	if NOT ($old_song = none)
		my_song = ($old_song)
		change \{old_song = none}
	endif
	get_song_title song = <my_song>
	get_song_artist song = <my_song>
	get_difficulty_text difficulty = ($player1_status.difficulty)
	score = ($player1_status.score)
	casttointeger \{score}
	formattext textname = score_text qs(0x73307931) s = <score> decimalplaces = 0 usecommas
	myinterfaceelement :setprops {
		song_name_text = <song_title>
		band_name_text = <song_artist>
		difficulty_text = <difficulty_text>
		score_text = <score_text>
	}
	if ($game_mode = p1_quickplay)
		menu_top_rockers_check_for_new_top_score \{nowrite = 1}
	endif
	stars = ($player1_status.stars)
	if (<stars> < 3)
		stars = 3
	endif
	resolvescreenelementid \{id = {
			myinterfaceelement
			child = {
				win_container
				child = star_container
			}
		}}
	destroyscreenelement id = <resolved_id> preserve_parent
	i = 0
	begin
	rgba2 = [200 200 200 255]
	rgba = [0 0 0 255]
	if (<i> >= <stars>)
		rgba2 = [64 64 64 255]
		rgba = [32 32 32 255]
	endif
	createscreenelement {
		type = containerelement
		parent = <resolved_id>
		dims = (50.0, 50.0)
		just = [center center]
		child_anchor = [center center]
	}
	container = <id>
	rot_angle = RandomInteger (0.0, 360.0)
	createscreenelement {
		type = spriteelement
		parent = <container>
		texture = song_summary_score_star
		rot_angle = <rot_angle>
		rgba = <rgba>
	}
	createscreenelement {
		type = spriteelement
		parent = <container>
		texture = song_summary_score_star
		rot_angle = <rot_angle>
		scale = 2.0
		rgba = <rgba2>
	}
	i = (<i> + 1)
	repeat 5
	i = 0
	p = 1
	begin
	resolvescreenelementid id = {myinterfaceelement child = {win_container child = {note_streak_container child = <i>}}}
	if (<i> >= ($current_num_players))
		<resolved_id> :die
	else
		<status> = ($0x2994109a [<p>])
		max_notes = ($<status>.max_notes)
		if (<max_notes> = 0)
			max_notes = 1.0
		endif
		formattext textname = streak_text qs(0x73307931) s = ($<status>.best_run)
		if ($<status>.<part> = vocals)
			vocal_phrase_max_qual = $<status>.vocal_phrase_max_qual
			vocal_phrase_quality = $<status>.vocal_phrase_quality
			vocal_phrase_pct = 0
			if (<vocal_phrase_max_qual> > 0)
				vocal_phrase_pct = (((<vocal_phrase_quality>) / <vocal_phrase_max_qual>) * 100.0)
				formattext textname = percent_text qs(0x49412198) p = <vocal_phrase_pct> decimalplaces = 0
			else
				<percent_text> = qs(0x4c1271a9)
			endif
		else
			formattext textname = percent_text qs(0x49412198) p = ((($<status>.notes_hit) / (<max_notes> * 1.0)) * 100.0) decimalplaces = 0
		endif
		switch ($<status>.part)
			case guitar
			instrument_text = qs(0x11355666)
			case bass
			instrument_text = qs(0x4f551cbe)
			case drum
			instrument_text = qs(0xf3e03f27)
			case vocals
			instrument_text = qs(0x9fae80a8)
		endswitch
		setscreenelementprops id = {<resolved_id> child = 0} text = <instrument_text>
		setscreenelementprops id = {<resolved_id> child = 1} text = <streak_text>
		setscreenelementprops id = {<resolved_id> child = 2} text = <percent_text>
		i = (<i> + 1)
	endif
	p = (<p> + 1)
	repeat 4
	resolvescreenelementid \{id = {
			myinterfaceelement
			child = {
				win_container
				child = menu
			}
		}}
	continue_script = ui_win_song_career_continue
	gamemode_gettype
	if ((gotparam for_practice) || <type> = quickplay)
		<continue_script> = ui_win_song_continue
	endif
	if ($game_mode = p2_pro_faceoff)
		<continue_script> = ui_win_song_continue
	endif
	if ($came_to_practice_from = main_menu)
		text = qs(0x3e482764)
	else
		if ($came_to_practice_from = gh4_p1_career)
			<text> = qs(0xb435bc8c)
		else
			<text> = qs(0x0a96ac96)
		endif
	endif
	createscreenelement {
		parent = <resolved_id>
		type = textelement
		font = fontgrid_text_a8
		text = <text>
		rgba = ($menu_unfocus_color)
		event_handlers = [
			{focus retail_menu_focus}
			{unfocus retail_menu_unfocus}
			{pad_choose <continue_script>}
		]
	}
	if (($is_network_game = 1) && ($net_new_matchmaking_ui_flag = 0))
		if NOT (ishost)
			<id> :se_setprops not_focusable
		endif
	endif
	createscreenelement {
		parent = <resolved_id>
		type = textelement
		font = fontgrid_text_a8
		text = qs(0xcbd10828)
		rgba = ($menu_unfocus_color)
		event_handlers = [
			{focus retail_menu_focus}
			{unfocus retail_menu_unfocus}
			{pad_choose generic_event_choose params = {state = uistate_detailed_stats}}
		]
	}
	if ($is_network_game = 1)
		<id> :se_setprops not_focusable
	endif
	if gotparam \{for_practice}
		createscreenelement {
			parent = <resolved_id>
			type = textelement
			font = fontgrid_text_a8
			text = qs(0x0c711699)
			rgba = ($menu_unfocus_color)
			event_handlers = [
				{focus retail_menu_focus}
				{unfocus retail_menu_unfocus}
				{pad_choose practice_restart_song}
			]
		}
		createscreenelement {
			parent = <resolved_id>
			type = textelement
			font = fontgrid_text_a8
			text = qs(0x4a1f8323)
			rgba = ($menu_unfocus_color)
			event_handlers = [
				{focus retail_menu_focus}
				{unfocus retail_menu_unfocus}
				{pad_choose generic_event_back params = {state = uistate_practice_select_speed}}
			]
		}
		createscreenelement {
			parent = <resolved_id>
			type = textelement
			font = fontgrid_text_a8
			text = qs(0x07b66aa5)
			rgba = ($menu_unfocus_color)
			event_handlers = [
				{focus retail_menu_focus}
				{unfocus retail_menu_unfocus}
				{pad_choose generic_event_back params = {state = uistate_select_song_section}}
			]
		}
	else
		createscreenelement {
			parent = <resolved_id>
			type = textelement
			font = fontgrid_text_a8
			text = qs(0x0c711699)
			rgba = ($menu_unfocus_color)
			event_handlers = [
				{focus retail_menu_focus}
				{unfocus retail_menu_unfocus}
				{pad_choose restart_warning_select_restart}
			]
		}
		if ($is_network_game = 1)
			<id> :se_setprops not_focusable
		endif
	endif
	assignalias id = <resolved_id> alias = current_menu
	current_menu :obj_spawnscript \{menu_music_on}
	if ((($is_network_game = 1) && ishost) || ($is_network_game = 0))
		add_user_control_helper \{text = qs(0xc18d5e76)
			button = green
			z = 100000
			all_buttons}
	endif
endscript

script ui_destroy_win_song 
	if screenelementexists \{id = myinterfaceelement}
		myinterfaceelement :die
	endif
	clean_up_user_control_helpers
endscript

script ui_create_win_song_spawn 
	wait \{1
		seconds}
	create_newspaper_menu <...>
	launchevent \{target = current_menu
		type = focus}
endscript

script ui_win_song_continue 
	spawnscriptnow ui_win_song_continue_spawned params = <...>
endscript

script ui_win_song_continue_spawned 
	if cd
		ui_event_get_stack
		i = 0
		begin
		if ((<stack> [<i>].base_name) = 'debug')
			generic_event_back state = uistate_debug player = <player>
			return
		endif
		i = (<i> + 1)
		repeat <stack_size>
	endif
	ui_win_song_continue_next_menu
endscript

script ui_win_song_continue_next_menu 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	if isobjectscript
		se_setprops \{block_events}
	endif
	switch ($game_mode)
		case p1_quickplay
		case p2_quickplay
		case p3_quickplay
		case p4_quickplay
		if ($current_song = jamsession)
			if NOT gotparam \{no_sound}
				generic_menu_pad_choose_sound
			endif
			generic_menu_pad_choose_sound
			jam_ratesong_check_for_rating
		else
			if NOT gotparam \{no_sound}
				generic_menu_pad_choose_sound
			endif
			ui_memcard_autosave \{state = uistate_setlist
				data = {
					all_active_players = true
					0x6d221ff1
				}}
		endif
		case gh4_p1_career
		case gh4_p2_career
		case gh4_p3_career
		case gh4_p4_career
		ui_win_song_career_continue
		case p2_pro_faceoff
		case p2_coop
		generic_event_back \{state = uistate_setlist
			data = {
				no_jamsession
			}}
		case practice
		if ($came_to_practice_from = main_menu)
			generic_event_back \{state = uistate_setlist}
		else
			song_ended_menu_select_back_to_game
		endif
	endswitch
endscript

script ui_win_song_career_continue 
	spawnscriptnow \{ui_win_song_career_continue_spawned}
endscript

script ui_win_song_career_continue_spawned 

	unlock_guitar = ($progression_unlocked_guitar)
	unlock_guitar2 = ($progression_unlocked_guitar2)
	progression_get_new_unlocks
	getarraysize <new_unlocks>
	if cd
		if ($is_in_debug = 1)
			generic_event_back \{state = uistate_debug}
			return
		endif
	endif
	if NOT (<unlock_guitar2> = -1)
		generic_event_choose \{data = {
				state = uistate_unlock
				num_guitars_unlocked = 2
			}}
	elseif NOT (<unlock_guitar> = -1)
		generic_event_choose \{data = {
				state = uistate_unlock
				num_guitars_unlocked = 1
			}}
	elseif (<array_size> > 0)
		generic_event_choose \{state = uistate_rewards}
	elseif progression_should_show_credits
		venue = load_z_cube
		part = band
		if ($current_num_players = 1)
			getplayerinfo \{1
				part}
		endif
		formattext checksumname = venue_checksum '%s_%i' s = ($levelzones.<venue>.name) i = ($instrument_list.<part>.text_nl)
		setglobaltags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
		spawnscript \{0x194e3e36}
	else
		if NOT ($current_gig_number = 0)
			if progression_set_new_song_in_gig_list
				change \{gameplay_restart_song = 1}
				generic_menu_pad_choose_sound
				ui_memcard_autosave \{event = menu_back
					state = uistate_gameplay
					data = {
						all_active_players = true
						0x6d221ff1
					}}
			else
				generic_menu_pad_choose_sound
				ui_memcard_autosave \{event = menu_back
					state = uistate_gig_posters
					data = {
						all_active_players = true
						0x6d221ff1
					}}
			endif
		else
			generic_menu_pad_choose_sound
			ui_memcard_autosave \{event = menu_back
				state = uistate_setlist
				data = {
					all_active_players = true
					0x6d221ff1
				}}
		endif
	endif
endscript

script 0x194e3e36 
	ui_event_wait_for_safe
	menu_music_off
	playmovieandwait \{movie = 'career_ending'
		noblack
		0x138ae921}
	get_movie_id_by_name \{movie = 'career_ending'}
	setglobaltags <id> params = {unlocked = 1} all_active_players = 1
	menu_music_on
	ui_memcard_autosave \{event = menu_change
		state = uistate_end_credits
		data = {
			all_active_players = true
			0x6d221ff1
		}}
endscript

script net_career_next_song 

	getglobaltags \{user_options}
	if progression_set_new_song_in_gig_list
		ui_memcard_autosave \{event = menu_back
			state = uistate_gameplay
			data = {
				all_active_players = true
			}}
		change \{gameplay_restart_song = 1}
		change \{net_ready_to_start = 0}
		($default_loading_screen.create)
		load_and_sync_timing
	else

	endif
endscript
