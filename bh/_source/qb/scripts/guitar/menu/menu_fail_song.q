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
	soundevent \{event = fail_screen_sfx}
	soundevent \{event = menu_warning_sfx_softer}
	change \{last_start_pressed_device = $primary_controller}
	gman_songtool_getcurrentsong
	completion = 0
	get_song_end_time song = <current_song>
	if (<total_end_time> > 0)
		completion = (100 * $failed_song_time / <total_end_time>)
		if (<completion> > 99)
			completion = 99
		endif
	endif
	casttointeger \{completion}
	get_band_difficulty
	get_difficulty_text_upper difficulty = <band_difficulty>
	get_song_title song = <current_song>
	getuppercasestring <song_title>
	formattext textname = completion_text qs(0x720688b0) d = <completion>
	z = 100.0
	createscreenelement \{type = containerelement
		parent = root_window
		id = fail_song_static_text_container
		internal_just = [
			center
			center
		]
		pos = (0.0, 0.0)
		z_priority = 2}
	title = qs(0x5c9b76c1)
	if NOT ininternetmode
		popup_options = [
			{
				func = fail_song_menu_select_retry_song
				text = qs(0x647b5a84)
			}
		]
	else
		<popup_options> = []
	endif
	gamemode_gettype
	if (<type> = quickplay)
		if NOT ui_event_exists_in_stack \{name = 'jam'}
			if (($num_quickplay_song_list > 1) || ($0xc7e670d7 = 1))
				<quickplay_skip_song_option> = {
					func = quickplay_skip_song
					func_params = {failed_song}
					text = qs(0xef74f7d2)
				}
				addarrayelement array = <popup_options> element = <quickplay_skip_song_option>
				<popup_options> = <array>
			endif
		endif
	endif
	if NOT ((<current_song> = jamsession) || ($is_network_game = 1))
		if NOT gamemode_isbandscoring
			<change_diff_option> = {
				func = fail_song_menu_select_change_diff
				text = qs(0xa717ca5b)
			}
			addarrayelement array = <popup_options> element = <change_diff_option>
			<popup_options> = <array>
		endif
	endif
	change \{is_guitar_controller = 0}
	player_device = ($primary_controller)
	if isguitarcontroller controller = <player_device>
		change \{is_guitar_controller = 1}
	endif
	if NOT (<current_song> = jamsession)
		if (<type> = career || <type> = quickplay)
			if ($current_num_players = 1)
				<practice_option> = {
					func = fail_song_menu_select_practice
					text = qs(0x3ea7dec9)
				}
				addarrayelement array = <popup_options> element = <practice_option>
				<popup_options> = <array>
			endif
		endif
	endif
	if (<type> = career)
		if ($is_network_game = 1)
			if ishost
				<new_song_option> = {
					func = fail_song_menu_select_new_song
					text = qs(0x79e7750b)
				}
			else
				<new_song_option> = {
					func = empty_script
					text = qs(0xf40ad470)
					not_focusable
				}
			endif
		else
			<new_song_option> = {
				func = fail_song_menu_select_new_song
				text = qs(0xe561ef6f)
			}
		endif
	else
		<new_song_option> = {
			func = fail_song_menu_select_new_song
			text = qs(0x3e482764)
		}
	endif
	if gotparam \{new_song_option}
		addarrayelement array = <popup_options> element = <new_song_option>
		<popup_options> = <array>
	endif
	if ($is_network_game = 1)
		<quit_option> = {
			func = select_quit_network_game
			func_params = {from_fail_menu = 1}
			text = qs(0x67d9c56d)
		}
	else
		<quit_option> = {
			func = fail_song_menu_select_quit
			text = qs(0x793e4d21)
		}
	endif
	addarrayelement array = <popup_options> element = <quit_option>
	<popup_options> = <array>
	if (($is_network_game = 1 && $net_popup_active = 0) || ($is_network_game = 0))
		create_dialog_box {
			template = fail_song
			heading_text = <title>
			no_background
			options = <popup_options>
			fail_song_props = {
				song_title = <uppercasestring>
				percent_text = <completion_text>
				difficulty_text = <difficulty_text>
			}
		}
	endif
	disable_pause
endscript

script fail_song_menu_select_tutorial 
	player_device = ($primary_controller)
	if isguitarcontroller controller = <player_device>
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
	0xe9384b7a \{full}
	change \{ps2_gameplay_restart_song = 1}
	gh3_sfx_fail_song_stop_sounds
	if ($is_network_game = 1)
		sendstructure \{callback = net_career_retry_song
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
	gh3_sfx_fail_song_stop_sounds
	if NOT cd
		if ($is_in_debug = 1)
			generic_event_back \{state = uistate_debug}
			return
		endif
	endif
	gman_songtool_getcurrentsong
	if (<current_song> = jamsession)
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
			generic_event_back state = uistate_setlist player = <player>
		endif
	else
		gamemode_gettype
		if (<type> = career)
			if ($is_network_game = 1)
				sendstructure \{callback = net_career_goto_band_lobby
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
	generic_event_choose state = uistate_pausemenu_change_difficulty data = {<...> no_warning}
endscript

script quickplay_skip_song 
	do_gh3_pause
	if NOT gotparam \{no_sound}
		generic_menu_pad_choose_sound
	endif
	gh3_sfx_fail_song_stop_sounds
	if quickplay_set_new_song_in_gig_list
		if ($0xc7e670d7 = 1)
			<current_song> = $current_song
		else
			<current_song> = ($quickplay_song_list [($quickplay_song_list_current) -1])
		endif
		if (<current_song> = jamsession)
			jamsession_unload
		endif
		if ($0xc7e670d7 = 1)
			0x587a82d3
			<next_song> = <0x72fa1922>
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
				generic_event_back \{state = uistate_gameplay
					nosound}
			endif
		endif
	else
		generic_event_back \{state = uistate_setlist
			nosound}
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
