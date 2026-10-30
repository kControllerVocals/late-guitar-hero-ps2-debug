
script create_song_ended_menu \{player = 1}
	gman_songtool_getcurrentsong
	stopsoundsbybuss \{encore_events}
	if ismovieplaying \{textureslot = 1}
		pausemovie \{textureslot = 1}
	endif
	disable_pause
	completion = 0
	get_song_end_time song = <current_song>
	getsongtimems
	if (<time> < 0)
		time = 0
	elseif (<time> > <total_end_time>)
		time = <total_end_time>
	endif
	if ($game_mode = practice)
		get_player_num_from_controller controller_index = ($primary_controller)
		if NOT playerinfoequals <player_num> part = vocals
			getplayerinfo <player_num> total_notes
			getplayerinfo <player_num> notes_hit

			if (<total_notes> > 0)
				completion = (((<notes_hit> * 1.0) / <total_notes>) * 100.0)
			else
				completion = 0
			endif
		else
			getplayerinfo <player_num> vocal_phrase_quality
			getplayerinfo <player_num> vocal_phrase_max_qual
			if (<vocal_phrase_max_qual> > 0)
				completion = (((<vocal_phrase_quality>) / <vocal_phrase_max_qual>) * 100.0)
			else
				completion = 0
			endif
		endif
	else
		if (<total_end_time> > 0)
			completion = (100.0 * <time> / <total_end_time>)
		endif
	endif
	casttointeger \{completion}
	if (($player1_status.double_kick_drum) = 1)
		difficulty_text = qs(0x7a19b5f7)
	else
		get_difficulty_text_upper difficulty = ($player1_status.difficulty)
	endif
	gamemode_gettype
	if (<type> = pro_faceoff)
		difficulty_text = ''
		0x8d1f5266 = qs(0x56d53de7)
	endif
	get_song_title song = <current_song>
	getuppercasestring <song_title>
	formattext textname = completion_text qs(0x76b3fda7) d = <completion>
	<title> = qs(0x1c640654)
	if ($game_mode = practice)
		<text> = qs(0x3ba0fbb3)
	else
		<text> = qs(0x647b5a84)
	endif
	if NOT ininternetmode
		popup_options = [
			{
				func = fail_song_menu_select_retry_song
				text = <text>
			}
		]
	else
		popup_options = []
	endif
	if ($game_mode = practice)
		if ($came_to_practice_from = main_menu)
			<new_song_option> = {
				func = song_ended_menu_select_new_song
				text = qs(0x3e482764)
			}
			addarrayelement array = <popup_options> element = <new_song_option>
			<popup_options> = <array>
		else
			if ($came_to_practice_from = p1_quickplay)
				<new_song_option> = {
					func = song_ended_menu_select_back_to_game
					text = qs(0x0a96ac96)
				}
				addarrayelement array = <popup_options> element = <new_song_option>
				<popup_options> = <array>
			else
				<new_song_option> = {
					func = song_ended_menu_select_back_to_game
					text = qs(0xb435bc8c)
				}
				addarrayelement array = <popup_options> element = <new_song_option>
				<popup_options> = <array>
			endif
		endif
	else
		if (<type> = career)
			<new_song_option> = {
				func = song_ended_menu_select_new_song
				text = qs(0xe561ef6f)
			}
		else
			<new_song_option> = {
				func = song_ended_menu_select_new_song
				text = qs(0x3e482764)
			}
		endif
		addarrayelement array = <popup_options> element = <new_song_option>
		<popup_options> = <array>
	endif
	gamemode_gettype
	if (<type> = quickplay)
		if NOT ui_event_exists_in_stack \{name = 'jam'}
			if (($num_quickplay_song_list > 1) || ($0xc7e670d7 = 1))
				<skip_song_option> = {
					func = quickplay_skip_song
					text = qs(0xef74f7d2)
				}
				addarrayelement array = <popup_options> element = <skip_song_option>
				<popup_options> = <array>
			endif
		endif
	endif
	<quit_option> = {
		func = song_ended_menu_select_quit
		text = qs(0x793e4d21)
	}
	addarrayelement array = <popup_options> element = <quit_option>
	<popup_options> = <array>
	get_all_exclusive_devices
	if ($game_mode = practice)
		create_dialog_box {
			template = fail_song
			heading_text = <title>
			player_device = ($primary_controller)
			no_background
			options = <popup_options>
			fail_song_props_prac = {
				song_title = <uppercasestring>
				percent_text = <completion_text>
				difficulty_text = <difficulty_text>
			}
		}
	else
		create_dialog_box {
			template = fail_song
			heading_text = <title>
			player_device = <exclusive_device>
			no_background
			options = <popup_options>
			fail_song_props = {
				song_title = <uppercasestring>
				percent_text = <completion_text>
				difficulty_text = <difficulty_text>
				0x8d1f5266 = <0x8d1f5266>
			}
		}
	endif
endscript

script destroy_song_ended_menu 
	stopallsounds
	gh3_sfx_fail_song_stop_sounds
	if ismovieplaying \{textureslot = 1}
		resumemovie \{textureslot = 1}
	endif
	destroy_dialog_box
endscript

script song_ended_menu_select_retry_song 
	0xe9384b7a \{full}
	change \{ps2_gameplay_restart_song = 1}
	generic_event_back \{state = uistate_gameplay}
	spawnscriptnow \{restart_song}
endscript

script song_ended_menu_select_new_song 
	0xe9384b7a \{full}
	if ($practice_enabled = 1)
		generic_event_back state = uistate_setlist player = <player>
		return
	endif
	if ($current_song = jamsession)
		if ui_event_exists_in_stack \{name = 'jam'}
			if NOT ($jam_view_cam_created = 1)
				destroy_bg_viewport
				setup_bg_viewport
				playigccam \{name = jam_view_cam
					viewport = bg_viewport
					controlscript = jam_camera_script
					params = {
						start_camera = jam_song_select
					}
					play_hold = 1}
				change \{jam_view_cam_created = 1}
				change \{target_jam_camera_prop = failed_song_cam}
			endif
			generic_event_back state = uistate_jam_select_song player = <player> data = {show_popup = 0}
		elseif ui_event_exists_in_stack \{name = 'setlist'}
			create_loading_screen
			generic_event_back state = uistate_setlist player = <player>
		endif
	else
		if ui_event_exists_in_stack \{name = 'setlist'}
			generic_event_back state = uistate_setlist player = <player>
			return
		endif
		ui_memcard_autosave \{state = uistate_gig_posters
			data = {
				all_active_players = true
				0x6d221ff1
			}}
	endif
endscript

script song_ended_menu_select_quit 
	0xe9384b7a \{full}
	change \{should_reset_gig_posters_selection = 1}
	if ($game_mode = practice)
		change \{practice_enabled = 0}
		change game_mode = ($came_to_practice_from)
		if NOT ($came_to_practice_from_progression = none)
			change current_progression_flag = ($came_to_practice_from_progression)
		endif
		if NOT ($came_to_practice_character_id = emptyguy)
			setplayerinfo 1 character_id = ($came_to_practice_character_id)
		endif
		change \{current_num_players = 1}
		gamemode_updatenumplayers \{num_players = 1}
		unload_song_anims
		destroy_band
		create_loading_screen
		generic_event_back \{state = uistate_mainmenu}
		return
	endif
	if ($is_network_game = 1)
		quit_network_game
	endif
	gamemode_gettype
	if (<type> = career)
		career_song_ended_select_quit
	endif
	bg_crowd_front_end_silence \{immediate = 1}
	ui_memcard_autosave_replace \{state = uistate_mainmenu
		data = {
			all_active_players = true
			0x6d221ff1
		}}
endscript

script song_ended_menu_select_back_to_game 
	0xe9384b7a \{full}
	change \{practice_enabled = 0}
	change game_mode = ($came_to_practice_from)
	change \{current_num_players = 1}
	gamemode_updatenumplayers \{num_players = 1}
	unload_song_anims
	destroy_band
	ui_event_wait_for_safe
	end_practice_song
	spawnscriptnow \{return_to_quickplay_from_practice}
endscript
