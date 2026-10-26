
script ui_init_pausemenu 
	if ($is_network_game)
		EnableAllInput \{off}
	endif
	if ScreenElementExists \{id = celeb_intro_ui_cont}
		celeb_intro_ui_cont :SE_SetProps \{alpha = 0.0
			time = 0.1}
	endif
endscript

script ui_create_pausemenu \{for_practice = 0
		extra_z = 0}
	if ($is_network_game = 1)
		spawn_player_drop_listeners \{drop_player_script = pause_drop_player
			end_game_script = pause_end_game}
	endif
	enable_pause
	reset_focus_colors
	player_device = ($last_start_pressed_device)
	player = 1
	i = 1
	begin
	GetPlayerInfo <i> controller
	if (<controller> = <player_device>)
		player = <i>
		break
	endif
	i = (<i> + 1)
	repeat ($current_num_players)
	SoundEvent \{Pause_Menu_SFX}
	vocals_mute_all_mics \{mute = true}
	if ($in_sing_a_long = true)
		pos = (1152.0, 630.0)
	else
		pos = (1152.0, 554.0)
	endif
	if ($pause_menu_no_bg = 0)
		if ($g_in_tutorial = 1)
			title_text = <tutorial_pause_title>
		else
			title_text = qs("PAUSED")
		endif
		if NOT isSinglePlayerGame
			if NOT ($game_mode = practice)
				FormatText TextName = title_text qs("P%p PAUSED") p = <player>
			endif
		endif
		if ($g_in_tutorial = 1)
			if (<tutorial_failed> = 0)
				<pad_back_script> = tutorial_resume
			else
				<pad_back_script> = nullscript
				<pad_back_sound> = nullscript
			endif
		else
			<pad_back_script> = ui_pausemenu_exit
		endif
		if ($in_tutorial_mode = 1)
			if (<tutorial_failed> = 1)
				title_text = qs("TUTORIAL FAILED")
			else
				title_text = qs("TUTORIAL PAUSED")
			endif
		endif
		ui_pausemenu_create_bg title_text = <title_text> extra_z = <extra_z>
		if pausemenu_bg :Desc_ResolveAlias \{name = alias_menu}
			<parent> = <resolved_id>
		endif
		make_generic_barrel_menu {
			title = <title_text>
			pad_back_script = <pad_back_script>
			pad_back_sound = <pad_back_sound>
			pad_back_params = <pad_back_params>
			exclusive_device = <player_device>
			z_priority = (600 + <extra_z>)
			no_highlight_bar
			pos = <pos>
		}
	else
		make_generic_barrel_menu {
			title = <title_text>
			pad_back_script = ui_pausemenu_exit
			exclusive_device = <player_device>
			z_priority = (600 + <extra_z>)
			no_highlight_bar
			pos = <pos>
		}
	endif
	if ($g_in_tutorial = 1)
		if (<tutorial_failed> = 1)
			add_generic_barrel_menu_text_item \{text = qs("RETRY")
				pad_choose_script = tutorial_restart
				text_internal_just = [
					center
					center
				]}
			add_generic_barrel_menu_text_item \{text = qs("SKIP LESSON")
				pad_choose_script = tutorial_skip_lesson
				text_internal_just = [
					center
					center
				]}
		else
			add_generic_barrel_menu_text_item \{text = qs("RESUME")
				pad_choose_script = tutorial_resume
				text_internal_just = [
					center
					center
				]}
			add_generic_barrel_menu_text_item \{text = qs("RESTART")
				pad_choose_script = tutorial_restart_warning
				text_internal_just = [
					center
					center
				]}
			add_generic_barrel_menu_text_item \{text = qs("SKIP LESSON")
				pad_choose_script = tutorial_skip_warning
				text_internal_just = [
					center
					center
				]}
		endif
	else
		add_generic_barrel_menu_text_item \{text = qs("RESUME")
			pad_choose_script = ui_pausemenu_exit
			text_internal_just = [
				center
				center
			]}
		if (($is_network_game = 0) && ($in_sing_a_long = false))
			if ($end_credits = 0)
				add_generic_barrel_menu_text_item \{text = qs("RESTART")
					choose_state = uistate_pausemenu_restart_warning
					text_internal_just = [
						center
						center
					]}
			endif
		endif
	endif
	if (<for_practice> = 1 || $game_mode = practice)
		if NOT PlayerInfoEquals <player> part = Vocals
			add_generic_barrel_menu_text_item \{text = qs("CHANGE SPEED")
				choose_state = uistate_pausemenu_quit_warning
				choose_state_data = {
					option2_text = qs("CHANGE SPEED")
					option2_func = quit_warning_select_quit
					option2_func_params = {
						callback = generic_event_back
						data = {
							state = uistate_practice_select_speed
						}
					}
				}
				text_internal_just = [
					center
					center
				]}
		endif
		add_generic_barrel_menu_text_item \{text = qs("CHANGE SECTION")
			choose_state = uistate_pausemenu_quit_warning
			choose_state_data = {
				option2_text = qs("CHANGE SECTION")
				option2_func = quit_warning_select_quit
				option2_func_params = {
					callback = generic_event_back
					data = {
						state = uistate_select_song_section
					}
				}
			}
			text_internal_just = [
				center
				center
			]}
		if ($came_to_practice_from = main_menu)
			add_generic_barrel_menu_text_item \{text = qs("NEW SONG")
				choose_state = uistate_pausemenu_quit_warning
				choose_state_data = {
					option2_text = qs("NEW SONG")
					option2_func = quit_warning_select_quit
					option2_func_params = {
						callback = song_ended_menu_select_new_song
					}
				}
				text_internal_just = [
					center
					center
				]}
		endif
		add_generic_barrel_menu_text_item {
			text = qs("OPTIONS")
			choose_state = uistate_pause_options
			choose_state_data = {player_device = <player_device> player = <player>}
			text_internal_just = [center center]
		}
	elseif NOT ($g_in_tutorial = 1)
		if ($is_network_game = 0)
			GameMode_GetType
			if ($current_song = jamsession)
				if NOT ui_event_exists_in_stack \{name = 'jam'}
					if (<type> = quickplay)
						if (($num_quickplay_song_list > 1) || ($is_partyplay_mode = 1))
							add_generic_barrel_menu_text_item \{choose_state = uistate_pausemenu_quit_warning
								choose_state_data = {
									skip_song = true
									failed_song
								}
								text = qs("SKIP SONG")
								text_internal_just = [
									center
									center
								]}
						endif
					endif
				endif
			else
				if NOT (($game_mode = p2_pro_faceoff) || ($in_sing_a_long = true))
					if ($end_credits = 0)
						if ui_event_exists_in_stack \{name = 'band_difficulty'}
							choose_state = UIstate_pausemenu_change_difficulty_warning
							choose_state_data = {player_device = <player_device> player = <player> band_mode = 1}
						else
							choose_state = UIstate_pausemenu_change_difficulty
							choose_state_data = {player_device = <player_device> player = <player>}
						endif
						add_generic_barrel_menu_text_item {
							text = qs("DIFFICULTY")
							text_internal_just = [center center]
							choose_state = <choose_state>
							choose_state_data = <choose_state_data>
						}
					endif
				endif
				if (<type> = quickplay)
					if (($num_quickplay_song_list > 1) || ($is_partyplay_mode = 1))
						add_generic_barrel_menu_text_item \{choose_state = uistate_pausemenu_quit_warning
							choose_state_data = {
								skip_song = true
								failed_song
							}
							text = qs("SKIP SONG")
							text_internal_just = [
								center
								center
							]}
					endif
				endif
				if game_is_scored
					if ($current_num_players = 1)
						if ($end_credits = 0)
							add_generic_barrel_menu_text_item \{text = qs("PRACTICE")
								choose_state = uistate_practice_warning
								text_internal_just = [
									center
									center
								]}
						endif
					endif
				endif
			endif
			if (($in_sing_a_long = false) && ($end_credits = 0))
				add_generic_barrel_menu_text_item {
					text = qs("OPTIONS")
					choose_state = uistate_pause_options
					choose_state_data = {player_device = <player_device> player = <player>}
					text_internal_just = [center center]
				}
			endif
		endif
	endif
	if ($in_sing_a_long = true)
		add_generic_barrel_menu_text_item \{text = qs("NEW SONG")
			choose_state = uistate_pausemenu_quit_warning
			choose_state_data = {
				option2_text = qs("NEW SONG")
				option2_func = quit_warning_select_quit
				option2_func_params = {
					callback = song_ended_menu_select_new_song
				}
			}
			text_internal_just = [
				center
				center
			]}
	endif
	quit_script = generic_event_choose no_sound = no_sound
	quit_script_params = {state = uistate_pausemenu_quit_warning}
	if (($is_partyplay_mode = 1) || ($in_sing_a_long = true))
		quit_script_params = {
			state = uistate_pausemenu_quit_warning
			data = {
				option2_func = quit_warning_select_quit
				option2_func_params = {
					callback = generic_event_back
					data = {state = UIstate_mainmenu}
				}
			}
		}
	elseif ($is_freeplay_mode = 1)
		quit_script_params = {
			state = uistate_pausemenu_quit_warning
			data = {
				option2_func = quit_warning_select_quit
				option2_func_params = {
					callback = generic_event_back
					data = {state = uistate_setlist}
				}
			}
		}
	elseif ($is_in_debug)
		if ($end_credits = 1)
			quit_script = debug_quitcredits
			quit_script_params = {}
		else
			quit_script = generic_event_back
			quit_script_params = {state = uistate_debug}
		endif
	elseif ($is_network_game = 1)
		quit_script = select_quit_network_game
		quit_script_params = {}
	elseif ($g_in_tutorial = 1)
		quit_script = tutorial_quit_warning
		quit_script_params = {}
	endif
	if ($end_credits = 0)
		add_generic_barrel_menu_text_item {
			text = qs("QUIT")
			pad_choose_script = <quit_script>
			pad_choose_params = <quit_script_params>
			text_internal_just = [center center]
		}
	endif
	if (($enable_button_cheats = 1) && ($in_sing_a_long = false))
		add_generic_barrel_menu_text_item \{text = qs("\LDebug Menu")
			choose_state = uistate_debug
			choose_state_data = {
				from_gameplay = 1
			}
			scale = (0.4, 0.36)
			text_internal_just = [
				center
				center
			]}
	endif
	if ($g_in_tutorial = 1)
		if (<tutorial_failed> = 0)
			<event_handlers> = [{pad_start tutorial_resume}]
			generic_barrel_vmenu :SE_SetProps event_handlers = <event_handlers>
		else
			generic_barrel_menu_finish \{no_back_button}
			return
		endif
	endif
	generic_barrel_menu_finish
	if NOT ($g_in_tutorial = 1)
		clean_up_user_control_helpers
		add_user_control_helper controller = <controller> text = qs("SELECT") button = green z = 100000
		add_user_control_helper controller = <controller> text = qs("BACK") button = red z = 100000
	endif
	BroadcastEvent \{type = pause_menu_created}
	destroy_loading_screen
endscript

script ui_destroy_pausemenu 
	destroy_generic_barrel_menu
	generic_ui_destroy
	ui_pausemenu_destroy_bg
	if ScreenElementExists \{id = celeb_intro_ui_cont}
		celeb_intro_ui_cont :SE_SetProps \{alpha = 1.0
			time = 0.1}
	endif
endscript

script ui_deinit_pausemenu 
	if ($is_network_game)
		EnableAllInput
	endif
endscript

script ui_pausemenu_exit 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	if Is_ui_event_running
		return
	endif
	spawnscriptnow \{unpausegh3
		params = {
			from_handler
		}}
	Block
endscript

script ui_pausemenu_create_bg 
	CreateScreenElement {
		parent = root_window
		id = pausemenu_bg
		type = DescInterface
		desc = 'pause_menu'
		title_text = <title_text>
		z_priority = <extra_z>
	}
	if (($in_sing_a_long = true) || GotParam no_arrows)
		if <id> :Desc_ResolveAlias name = alias_options_up_arrow param = options_up_arrow_id
			SetScreenElementProps {id = <options_up_arrow_id> alpha = 0.0}
		endif
		if <id> :Desc_ResolveAlias name = alias_options_down_arrow param = options_down_arrow_id
			SetScreenElementProps {id = <options_down_arrow_id> alpha = 0.0}
		endif
	endif
	if ($g_in_tutorial = 1)
		<song_title> = qs(0xcafa41cf)
	else
		get_song_title \{song = $current_song}
	endif
	pausemenu_bg :SE_SetProps {song_name_text = <song_title>}
	ui_create_particle_circle \{z_offset = 7000.0}
endscript

script ui_pausemenu_destroy_bg 
	if ScreenElementExists \{id = pausemenu_bg}
		pausemenu_bg :Die
	endif
	ui_destroy_particle_circle
endscript

script ui_pausemenu_animate_in 
	if ScreenElementExists \{id = pausemenu_bg}
		pausemenu_bg :SE_GetProps \{menu_scale}
		<org_menu_scale> = <menu_scale>
		pausemenu_bg :SE_SetProps \{menu_scale = 0}
		pausemenu_bg :SE_GetProps \{ninjastar_rot_angle}
		<org_ninjastar_rot_angle> = <ninjastar_rot_angle>
		pausemenu_bg :SE_SetProps \{ninjastar_rot_angle = 0}
		pausemenu_bg :SE_GetProps \{bottom_pos}
		<org_bottom_pos> = <bottom_pos>
		pausemenu_bg :SE_SetProps bottom_pos = (<bottom_pos> + (800.0, 700.0))
		pausemenu_bg :SE_GetProps \{left_pos}
		<org_left_pos> = <left_pos>
		pausemenu_bg :SE_SetProps left_pos = (<left_pos> + (-700.0, 800.0))
		pausemenu_bg :SE_GetProps \{top_pos}
		<org_top_pos> = <top_pos>
		pausemenu_bg :SE_SetProps top_pos = (<top_pos> + (-800.0, -700.0))
		pausemenu_bg :SE_GetProps \{right_pos}
		<org_right_pos> = <right_pos>
		pausemenu_bg :SE_SetProps right_pos = (<right_pos> + (700.0, -800.0))
		pausemenu_bg :SE_GetProps \{center_scale}
		<org_center_scale> = <center_scale>
		pausemenu_bg :SE_SetProps \{center_scale = 0}
		<anim_time> = 0.120000005
		pausemenu_bg :SE_SetProps bottom_pos = <org_bottom_pos> time = <anim_time> motion = linear
		pausemenu_bg :SE_SetProps left_pos = <org_left_pos> time = <anim_time> motion = linear
		pausemenu_bg :SE_SetProps top_pos = <org_top_pos> time = <anim_time> motion = linear
		pausemenu_bg :SE_SetProps right_pos = <org_right_pos> time = <anim_time> motion = linear
		pausemenu_bg :SE_SetProps center_scale = <org_center_scale> time = <anim_time> motion = linear
		pausemenu_bg :SE_SetProps menu_scale = <org_menu_scale> time = <anim_time> motion = linear
		pausemenu_bg :SE_WaitProps
		pausemenu_bg :SE_SetProps ninjastar_rot_angle = <org_ninjastar_rot_angle> time = 0.05 motion = linear
	endif
endscript

script EnableAllInput 
	i = 1
	begin
	GetPlayerInfo <i> controller
	if GotParam \{off}
		EnableInput controller = <controller> off
	else
		EnableInput controller = <controller>
	endif
	i = (<i> + 1)
	repeat $current_num_players
endscript

script ui_return_pausemenu 
	if ($is_network_game)
		add_gamertag_helper \{exclusive_device = $last_start_pressed_device}
		menu_finish
	endif
endscript

script pause_drop_player 

	spawnscriptnow unpause_and_drop_player params = <...>
endscript

script unpause_and_drop_player 
	OnExitRun \{InputHandlerPermit}
	InputHandlerForbid
	gameplay_drop_player <...>
endscript

script pause_end_game 

	spawnscriptnow unpause_and_endgame params = <...>
endscript

script unpause_and_endgame 
	OnExitRun \{InputHandlerPermit}
	InputHandlerForbid
	ui_pausemenu_exit
	gameplay_end_game <...>
endscript
