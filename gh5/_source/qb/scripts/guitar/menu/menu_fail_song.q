is_guitar_controller = 0

script menu_replace_to_fail_song 
	spawnscriptnow \{ui_event
		params = {
			event = menu_replace
			data = {
				state = uistate_fail_song
			}
		}}
endscript

script create_fail_song_menu 
	SoundEvent \{event = Fail_Screen_SFX}
	SoundEvent \{event = Menu_Warning_SFX_softer}
	change \{last_start_pressed_device = $primary_controller}
	menu_font = fontgrid_title_a1
	<menu_pos> = (640.0, 420.0)
	GMan_SongTool_GetCurrentSong
	completion = 0
	get_song_end_time song = <current_song>
	if (<total_end_time> > 0)
		completion = (100 * $failed_song_time / <total_end_time>)
		if (<completion> > 99)
			completion = 99
		endif
	endif
	CastToInteger \{completion}
	<menu_pos> = (<menu_pos> + (0.0, 45.0))
	if ($game_mode = gh4_p2_career || $game_mode = p2_coop || $game_mode = p2_quickplay)
		GetPlayerInfo \{1
			difficulty
			out = difficulty1}
		GetPlayerInfo \{2
			difficulty
			out = difficulty2}
		min = ($difficulty_list_props.<difficulty1>.index)
		MathMin a = <min> b = ($difficulty_list_props.<difficulty2>.index)
		CastToInteger \{min}
		difficulty_index = <min>
		get_difficulty_text_upper difficulty = ($difficulty_list [<difficulty_index>])
	else
		if (($player1_status.double_kick_drum) = 1)
			if StructureContains Structure = ($permanent_songlist_props.($current_song)) double_kick
				if ($permanent_songlist_props.($current_song).double_kick = 1)
					difficulty_text = qs("EXPERT+")
				else
					difficulty_text = qs("EXPERT")
				endif
			endif
		else
			GetPlayerInfo \{1
				difficulty
				out = difficulty1}
			get_difficulty_text_upper difficulty = <difficulty1>
		endif
	endif
	get_song_title song = <current_song>
	GetUpperCaseString <song_title>
	FormatText TextName = completion_text qs("\L%d") d = <completion>
	z = 100.0
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = fail_song_static_text_container
		internal_just = [
			center
			center
		]
		pos = (0.0, 0.0)
		z_priority = 2}
	title = qs("FAILED")
	if NOT InInternetMode
		popup_options = [
			{
				func = fail_song_menu_select_retry_song
				text = qs("RETRY SONG")
			}
		]
	else
		<popup_options> = []
	endif
	<song_title_scale> = 1.65
	set_focus_color \{color = reddish_grey}
	set_unfocus_color \{color = black}
	text_scale = (0.9, 0.95)
	if NOT English
		text_scale = (0.9, 0.85)
	endif
	if NOT GotParam \{exclusive_device}
		exclusive_device = ($primary_controller)
	endif
	demo_mode_disable = {}
	GameMode_GetType
	if (<type> = quickplay)
		if NOT ui_event_exists_in_stack \{name = 'jam'}
			if (($num_quickplay_song_list > 1) || ($is_partyplay_mode = 1))
				<quickplay_skip_song_option> = {
					func = quickplay_skip_song
					func_params = {failed_song}
					text = qs("SKIP SONG")
				}
				AddArrayElement array = <popup_options> element = <quickplay_skip_song_option>
				<popup_options> = <array>
			endif
		endif
	endif
	if NOT ((<current_song> = jamsession) || ($is_network_game = 1))
		if NOT GameMode_IsBandScoring
			<change_diff_option> = {
				func = fail_song_menu_select_change_diff
				text = qs("CHANGE DIFFICULTY")
			}
			AddArrayElement array = <popup_options> element = <change_diff_option>
			<popup_options> = <array>
		endif
	endif
	change \{is_guitar_controller = 0}
	player_device = ($primary_controller)
	if IsGuitarController controller = <player_device>
		change \{is_guitar_controller = 1}
	endif
	GameMode_GetType
	if NOT (<current_song> = jamsession)
		if (<type> = career || <type> = quickplay)
			if ($current_num_players = 1)
				<practice_option> = {
					func = fail_song_menu_select_practice
					text = qs("PRACTICE")
				}
				AddArrayElement array = <popup_options> element = <practice_option>
				<popup_options> = <array>
			endif
		endif
	endif
	GameMode_GetType
	if (<type> = career)
		if ($is_network_game = 1)
			if IsHost
				<new_song_option> = {
					func = fail_song_menu_select_new_song
					text = qs("QUIT GIG")
				}
			else
				<new_song_option> = {
					func = empty_script
					text = qs("WAITING FOR BAND LEADER")
					not_focusable
				}
			endif
		else
			<new_song_option> = {
				func = fail_song_menu_select_new_song
				text = qs("NEW GIG")
			}
		endif
	else
		<new_song_option> = {
			func = fail_song_menu_select_new_song
			text = qs("NEW SONG")
		}
	endif
	if GotParam \{new_song_option}
		AddArrayElement array = <popup_options> element = <new_song_option>
		<popup_options> = <array>
	endif
	if ($is_network_game = 1)
		<quit_option> = {
			func = select_quit_network_game
			func_params = {from_fail_menu = 1}
			text = qs("QUIT")
		}
	else
		<quit_option> = {
			func = fail_song_menu_select_quit
			text = qs("MAIN MENU")
		}
	endif
	AddArrayElement array = <popup_options> element = <quit_option>
	<popup_options> = <array>
	if (($is_network_game = 1 && $net_popup_active = 0) || ($is_network_game = 0))
		create_dialog_box {
			Template = fail_song
			heading_text = <title>
			no_background
			options = <popup_options>
			fail_song_props = {
				song_title = <UpperCaseString>
				percent_text = <completion_text>
				difficulty_text = <difficulty_text>
			}
		}
	endif
	disable_pause
endscript

script fail_song_menu_select_tutorial 
	player_device = ($primary_controller)
	if IsGuitarController controller = <player_device>
		kill_gem_scroller
		generic_event_choose \{state = uistate_select_practice_mode}
	endif
endscript

script destroy_fail_song_menu 
	destroy_menu \{menu_id = fail_song_scrolling_menu}
	destroy_menu \{menu_id = fail_song_static_text_container}
	destroy_dialog_box
endscript

script fail_song_menu_select_practice 
	generic_event_choose \{state = uistate_practice_warning}
endscript

script fail_song_menu_select_retry_song 
	set_loading_screen \{full}
	change \{ps2_gameplay_restart_song = 1}
	GH3_SFX_fail_song_stop_sounds
	if ($is_network_game = 1)
		SendStructure \{callback = net_career_retry_song
			data_to_send = {
				none
			}}
		net_career_retry_song
	else
		if NOT ($game_mode = practice)
			change \{gameplay_restart_song = 1}
		else
			practice_restart_song
		endif
		generic_event_back \{state = uistate_gameplay}
	endif
endscript

script fail_song_menu_select_new_song 
	GH3_SFX_fail_song_stop_sounds
	if CD
		if ($is_in_debug = 1)
			generic_event_back \{state = uistate_debug}
			return
		endif
	endif
	GMan_SongTool_GetCurrentSong
	if (<current_song> = jamsession)
		if ui_event_exists_in_stack \{name = 'jam'}
			if NOT ($jam_view_cam_created = 1)
				destroy_bg_viewport
				setup_bg_viewport
				PlayIGCCam \{name = jam_view_cam
					viewport = bg_viewport
					controlscript = jam_camera_script
					params = {
						start_camera = jam_song_select
					}
					Play_hold = 1}
				change \{jam_view_cam_created = 1}
				change \{target_jam_camera_prop = failed_song_cam}
			endif
			generic_event_back state = UIstate_jam_select_song player = <player> data = {show_popup = 0}
		elseif ui_event_exists_in_stack \{name = 'setlist'}
			generic_event_back state = uistate_setlist player = <player>
		endif
	else
		GameMode_GetType
		if (<type> = career)
			if ($is_network_game = 1)
				SendStructure \{callback = net_career_goto_band_lobby
					data_to_send = {
						none
					}}
				net_career_goto_band_lobby
			else
				generic_event_back state = uistate_gig_posters player = <player>
			endif
		else
			generic_event_back state = uistate_setlist player = <player>
		endif
	endif
endscript

script fail_song_menu_select_quit 
	generic_event_choose \{state = uistate_pausemenu_quit_warning
		data = {
			option2_func = song_ended_menu_select_quit
			option2_func_params = {
				quit_career_confirm
			}
		}
		no_sound}
endscript

script fail_song_menu_select_change_diff 
	generic_event_choose state = UIstate_pausemenu_change_difficulty data = {<...> no_warning}
endscript

script quickplay_skip_song 
	do_gh3_pause
	GH3_SFX_fail_song_stop_sounds
	if quickplay_set_new_song_in_gig_list
		if ($is_partyplay_mode = 1)
			<current_song> = $current_song
		else
			<current_song> = ($quickplay_song_list [($quickplay_song_list_current) -1])
		endif
		if (<current_song> = jamsession)
			jamsession_unload
		endif
		if ($is_partyplay_mode = 1)
			set_random_partyplay_song
			<next_song> = <new_partyplay_song>
		else
			<next_song> = ($quickplay_song_list [($quickplay_song_list_current)])
		endif
		if (<next_song> = jamsession)
			jam_quickplay_get_and_start_song
		else
			change \{gameplay_restart_song = 1}
			ui_event_wait_for_safe
			ui_event_get_top
			if (<base_name> = 'gameplay')
				ui_event \{event = menu_refresh}
			else
				generic_event_back \{state = uistate_gameplay}
			endif
		endif
	else
		generic_event_back \{state = uistate_setlist}
	endif
endscript

script net_career_retry_song 
	change \{gameplay_restart_song = 1}
	change \{net_ready_to_start = 0}
	($default_loading_screen.create)
	ui_event \{event = menu_back
		data = {
			state = uistate_gameplay
		}}
endscript
