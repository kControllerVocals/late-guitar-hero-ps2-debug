
script ui_init_band_mode 
	push_num_players \{num = 0}
endscript

script ui_deinit_band_mode 
	pop_num_players
endscript

script ui_create_band_mode 
	change_num_players \{num = 0}
	GameMode_GetType
	if (<type> = career)
		register_new_progression_atoms \{Career_Band}
	endif
	spawnscriptnow \{qi_initialize
		params = {
			mode = band_mode
		}}
endscript

script ui_destroy_band_mode 
	KillSkaterCamAnim \{name = Bandmode_camera}
	qi_destroy
endscript

script sanity_check_fix_deleted_characters 
	fix_deleted_character_player_status \{player = 1}
	fix_deleted_character_player_status \{player = 2}
	fix_deleted_character_player_status \{player = 3}
	fix_deleted_character_player_status \{player = 4}
endscript

script fix_deleted_character_player_status 
	<player_status> = ($player_status_array [<player>])
	get_savegame_from_player_status player_status = <player_status>
	if NOT profile_exists id = ($<player_status>.character_id) savegame = <savegame>
		change structurename = <player_status> character_id = judy
	endif
endscript

script ui_get_controller_parts_allowed 

	if (($allow_controller_for_all_instruments) = 0)
		allowed = {}
		if IsGuitarController controller = <controller>
			allowed = {guitar Bass}
		elseif IsDrumController controller = <controller>
			allowed = {drum}
		elseif IsMicrophonePluggedIn
			allowed = {Vocals}
		endif
	else
		allowed = {guitar Bass drum Vocals}
		if IsGuitarController controller = <controller>
			allowed = {guitar Bass}
		elseif IsDrumController controller = <controller>
			allowed = {drum}
		elseif IsMicrophonePluggedIn
			allowed = {guitar Bass drum Vocals}
		endif
	endif
	if is_regular_controller controller = <controller>
		if controller_has_headset controller = <controller>
			allowed = {<allowed> Vocals}
		endif
	endif
	if GotParam \{filter_by_character}
		filter_allowed_parts_by_character_type allowed = <allowed> controller = <controller>
	endif
	return allowed = <allowed>
endscript

script get_controller_part 

	if IsGuitarController controller = <controller>
		return \{controller_part = guitar}
	elseif IsDrumController controller = <controller>
		return \{controller_part = drum}
	else
		return \{controller_part = Vocals}
	endif
endscript

script ui_band_mode_highlight_motion 
	if Desc_ResolveAlias \{name = alias_highlight}
		if GetScreenElementChildren id = <resolved_id>
			GetArraySize <children>
			prev = 0
			curr = 1
			begin
			prev_id = (<children> [<prev>])
			curr_id = (<children> [<curr>])
			<prev_id> :SE_SetProps alpha = 0.0
			<curr_id> :SE_SetProps alpha = 1
			prev = <curr>
			next = RandomInteger (0.0, 2.0)
			if (<next> = <prev>)
				curr = (<curr> + 1)
			else
				curr = <next>
			endif
			if (<curr> >= <array_size>)
				curr = 0
			endif
			rand = Random (@ 0 @ 1 )
			if (<rand> = 1)
				<curr_id> :SE_SetProps flip_v = true
			else
				<curr_id> :SE_SetProps flip_v = false
			endif
			rand = Random (@ 0 @ 1 )
			if (<rand> = 1)
				<curr_id> :SE_SetProps flip_h = true
			else
				<curr_id> :SE_SetProps flip_h = false
			endif
			Wait \{0.1
				second}
			repeat
		endif
	endif
endscript

script ui_band_mode_focus \{offset = (0.0, 34.0)
		start_pos = (0.0, -120.0)}
	retail_menu_focus
	Obj_GetID
	<ObjID> :SE_GetParentId
	<parent_id> :GetTags
	MyInterfaceElement :GetTags
	if GotParam \{descs}
		current_desc = (<descs> [<index>])
		if <current_desc> :Desc_ResolveAlias name = alias_highlight
			GetScreenElementDims id = <ObjID>
			scale = (((0.9, 0.0) * (((<width> + 100.0) / 256.0))) + (0.0, 1.0))
			screenelementpos = (<start_pos> + (<offset> * <tag_selected_index>))
			<resolved_id> :SE_SetProps pos = <screenelementpos> scale = <scale>
			<resolved_id> :SE_WaitProps
			<resolved_id> :SE_SetProps pos = (<screenelementpos> + (0.0, -10.0)) time = 0.05
			<resolved_id> :SE_WaitProps
			<resolved_id> :SE_SetProps pos = <screenelementpos> scale = <scale> time = 0.05
			<resolved_id> :SE_WaitProps
		endif
	endif
endscript

script band_mode_remap_controllers_1_to_4 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_create_band_mode_spawned 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_signin_changed 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_return_band_mode 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script is_band_character_select_up 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_kill_character_select_menus 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_choose_leader 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_update_name 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_mode_has_player_joined 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_menu_occlude_character 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_update_menu 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_show_arrows 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_hide_arrows 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ui_band_mode_quit 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ui_host_quit_lobby 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ui_client_quit_lobby 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script correct_allowed_parts 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script filter_allowed_parts_by_character_type 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_instrument 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_lefty 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_mic_check 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_difficulty 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_ready 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_animate_ready 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_animate_unready 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_ready_motion 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_root 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_save_tags 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_edit_character 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_character 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_character_select_focus 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_character_rename 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_character_name_scroll 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_gamertag_rename 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_gamertag_scroll 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_character_select_unfocus 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_resolve_guest_characters 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_character_select_choose 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_character_select_back_out 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_join 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_net_remote_open 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_net_remote_root 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_net_local_join 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_net_local_root 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_friends_list 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_invite 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_gigs 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_gigs_scroll 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_gigs_choose 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_gigs_blink_arrow 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_gigs_move_poster 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_gigs_focus 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_gigs_unfocus 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_create_menu_gamer_cards 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_show_gamertag 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_choose 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script spawn_net_ui_band_mode_choose 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ui_band_mode_choose 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_back 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script spawn_net_ui_band_mode_back 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ui_band_mode_back 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_continue 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ui_band_mode_continue 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_invite_continue_to_lobby 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script spawn_net_ui_band_mode_countdown_to_gig 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ui_band_mode_countdown_to_gig 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_wait_to_proceed_to_online_play 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_show_character 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script random_band_mode_character 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_random_character 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_kill_character 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_check_menus 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_check_disconnect 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_warning 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_signin 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_helper_text 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script IsAnyControllerSignedIn 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_scroll_sound 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_choose_sound \{ready = 0
		controller = 0}
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_choose_sound_spawned \{ready = 0
		controller = 0}
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_choose_sound_ready 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script proceed_to_band_lobby 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script add_gamertag_to_band_lobby 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_add_player_to_career_ui 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_goto_band_lobby 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_goto_gig_board 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script is_current_state_band_mode 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_setup_band_lobby_ticker 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ticker_msg_loop 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ticker_update_msg 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ticker_vert_scroll 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ticker_horiz_scroll \{scroll_time = 6}
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script scroll_ticker_each_line 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script update_network_ticker 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_get_root_menu_tags 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_get_invite_menu_tags 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script career_update_party_data 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script career_poll_party_data 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script career_poll_party_for_joiners 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_add_party_joiner 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_remove_party_joiner 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script find_party_member_menu 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script get_party_member_status 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script is_new_player 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script is_quitter 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_get_invite_controller_by_user_id 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script cancel_career_search_early 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script career_proceed_with_current_reservations 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script check_num_matchmaking_players_loop 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_update_remote_menu_text 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_change_menu_focus_all 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_ui_band_mode_create_searching_menu 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script cancel_career_search_early_if_possible 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script career_friendslist_callback 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script career_friendslist_scroll 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script career_friendslist_stop_scroll 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_move_invite_player_to_open_menu 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_memcard_drop_player 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script wait_for_net_career_drop_player 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_memcard_end_game 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script wait_for_net_career_end_game 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_drop_player 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_end_game 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script hacky_fix_band_celebrity_character 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_get_band_leader_difficulty 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_wait_until_menu_update_is_done 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_asign_band_leader_icon 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_check_instruments 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_set_instruments 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_ps3_invite_received 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_host_finalize_menu_ui 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_send_to_host_msg_uistate_ready 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script mark_client_as_in_lobby 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_wait_for_clients_uistate_ready 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script net_career_shift_invite_player_status_structs 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script is_party_member_local 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ps2_ui_band_mode_assign_menu_if_possible 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ps2_ui_band_mode_is_controller_mapped 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ps2_ui_band_mode_back_if_not_mapped 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ps2_is_standard_controller_active 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_mode_add_vocalist 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script restore_band_mode_vocalist 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_mode_get_menu_from_desc_index 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script band_mode_get_menu_from_controller 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ps2_ui_band_mode_get_free_guitar_menu_index 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script change_controller_disconnect_scripts_on_all_menus 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script open_band_mode_searching_popup 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ready_up_players_invite_client 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script UpdateNumLocalPlayers 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script create_band_confirm_search_again 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script update_client_searching_timer 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script career_quit_warning_popup 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script quit_career_mode 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script cancel_quit 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_select_friends 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_ready_all 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_friends_match 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_force_ready 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script ui_band_mode_friends_game 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript

script check_num_local_players 
	debug_ScriptAssert \{qs(0x9f538ee9)}
endscript
