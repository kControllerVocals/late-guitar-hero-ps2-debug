
script ui_create_singleplayer_character_hub 

	set_cas_loading_setup \{setup = single}
	spawnscriptnow ui_create_singleplayer_character_hub_spawned params = <...>
endscript

script ui_create_singleplayer_character_hub_spawned 
	change menu_flow_locked = ($menu_flow_locked + 1)
	if NOT ($practice_enabled)
		frontend_load_soundcheck \{loadingscreen
			async = 0}
	endif
	change \{rich_presence_context = presence_band_logo_edit_and_instrument_edit}
	cas_free_resources_camera_fix \{base_name = 'singleplayer_character_hub'}
	destroy_loading_screen \{force = 1}
	if init_singleplayer_character_hub pass_to_gigboard = <pass_to_gigboard> ent_player_status = <ent_player_status>
		if NOT current_band_has_band_name
			change menu_flow_locked = ($menu_flow_locked - 1)
			create_loading_screen
			ui_event_wait \{event = menu_change
				data = {
					state = uistate_band_name_logo
					event_params = {
						event = menu_back
					}
					from_save = 1
					controller = $primary_controller
				}}
			return
		endif
		player_status = player1_status
		switch ($<player_status>.part)
			case guitar
			hist_tex = icon_progression_guitar
			case Bass
			hist_tex = icon_progression_bass
			case drum
			hist_tex = icon_progression_drums
			case Vocals
			hist_tex = icon_progression_vocals
		endswitch
		make_generic_menu {
			title = qs("VIP LOUNGE")
			show_history
			num_icons = 0
			hist_tex = <hist_tex>
			vmenu_id = create_singleplayer_character_hub_vmenu
			pad_back_script = generic_event_back_block
		}
		if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
			<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
		else

		endif
		if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
			<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
		else

		endif
		get_frontend_venue_player_start_checksums
		cas_set_object_node_pos player = ($cas_current_player) node = <Drum_Start>
		add_generic_menu_text_item \{text = qs("PLAY SHOW")
			pad_choose_script = singleplayer_player_show}
		add_generic_menu_text_item {
			text = qs("SELECT ROCKER")
			choose_state = uistate_character_selection
			choose_state_data = {object = <player>}
		}
		get_savegame_from_player_status player_status = <player_status>
		if profile_can_be_modified id = ($<player_status>.character_id) savegame = <savegame>
			add_generic_menu_text_item \{text = qs("EDIT ROCKER")
				pad_choose_script = single_player_character_hub_edit_character}
		endif
		add_generic_menu_text_item \{text = qs("VIDEOS")
			choose_state = uistate_bonus_videos}
		add_generic_menu_text_item \{text = qs("BAND INFO")
			choose_state = uistate_band_name_logo
			choose_state_data = {
				from_band_info = 1
			}}
		if IsDrumController controller = ($primary_controller)
			focusable_flags = {not_focusable}
		endif
		menu_finish
		LaunchEvent type = focus target = create_singleplayer_character_hub_vmenu data = {child_index = <selected_index>}
	endif
	startrendering
	menu_music_on
	change menu_flow_locked = ($menu_flow_locked - 1)
	cas_queue_wait
	if GetCurrentCASObject
		BandManager_ChangeStance name = <cas_object> stance = Stance_Old no_wait
	endif
endscript

script single_player_character_hub_edit_character 
	hide_glitch \{num_frames = 20}
	external_edit_character
endscript

script ui_destroy_singleplayer_character_hub 
	destroy_generic_menu
	change \{menu_over_ride_exclusive_device = -1}
endscript

script ui_deinit_singleplayer_character_hub 
	cas_fix_cameras_for_game
endscript
first_character_hub_enter = 0

script init_singleplayer_character_hub \{player = 1}
	<player_status> = ($player_status_array [<player>])
	get_savegame_from_player_status player_status = <player_status>
	GetGlobalTags savegame = <savegame> last_singleplayer_character
	if NOT (<last_singleplayer_character> = none)
		change \{first_character_hub_enter = 0}
		change structurename = <player_status> character_id = <last_singleplayer_character>
	endif
	if GotParam \{pass_to_gigboard}
		spawnscriptnow cleanup_singleplayer_hub_return_tutorials params = {player = <player> Progression = <Progression> ent_player_status = <ent_player_status>}
		return \{false}
	else
		if ($first_character_hub_enter = 0)
			if NOT profile_exists id = ($<player_status>.character_id) savegame = <savegame>
				stars

				stars
				change structurename = <player_status> character_id = judy
			endif
			change \{cas_current_instrument = none}
			cas_queue_new_character_profile id = ($<player_status>.character_id) force_update = 1 player = <player> savegame = <savegame> hide_old_character = 1
		endif
	endif
	if NOT ($game_mode = practice)
		get_current_band_info
		bandname_id = <band_info>
		GetGlobalTags <bandname_id> param = first_venue_movie_played
		if (<first_venue_movie_played> = 0)
			get_progression_globals game_mode = ($game_mode)
			SetGlobalTags <bandname_id> params = {first_venue_movie_played = 1}
		endif
	endif
	if ($first_character_hub_enter = 1)
		spawnscriptnow \{character_hub_continue_to_selection}
		return \{false}
	endif
	return \{true}
endscript

script character_hub_continue_to_selection 
	ui_event_wait \{event = menu_change
		data = {
			state = uistate_character_selection
			from_difficulty = {
				from_difficulty
			}
		}}
endscript

script singleplayer_player_show 
	cas_destroy_all_characters
	cleanup_singleplayer_hub
	player_status = player1_status
	ui_event_add_params ent_player_status = ($<player_status>)
	ui_event_wait \{event = menu_change
		data = {
			state = uistate_select_venue
		}}
endscript

script cleanup_singleplayer_hub 
	KillCamAnim \{name = ch_view_cam}
	KillCamAnim \{name = gs_view_cam}
	destroy_bg_viewport
	disable_pause
endscript

script cleanup_singleplayer_hub_return_tutorials 
	player_status = player1_status
	change globalname = <player_status> newvalue = <ent_player_status>
	switch (<ent_player_status>.part)
		case guitar
		change \{current_progression_flag = Career_Guitar}
		SetPlayerInfo \{1
			part = guitar}
		case Bass
		change \{current_progression_flag = Career_Bass}
		SetPlayerInfo \{1
			part = Bass}
		case drum
		change \{current_progression_flag = Career_Drum}
		SetPlayerInfo \{1
			part = drum}
		case Vocals
		change \{current_progression_flag = Career_Vocals}
		SetPlayerInfo \{1
			part = Vocals}
	endswitch
	ui_event_remove_params \{param = ent_player_status}
	change \{game_mode = gh4_p1_career}
	change \{current_num_players = 1}
	GameMode_UpdateNumPlayers \{num_players = 1}
	create_loading_screen
	destroy_bandname_viewport
	destroy_band
	frontend_load_soundcheck
	<player_status> = ($player_status_array [<player>])
	get_savegame_from_player_status player_status = <player_status>
	cas_fix_cameras_for_game
	destroy_loading_screen
	ui_event_remove_params \{param = pass_to_gigboard}
	singleplayer_player_show \{continue_to_gigs}
endscript
