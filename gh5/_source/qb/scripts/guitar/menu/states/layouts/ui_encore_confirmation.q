
script ui_create_encore_confirmation 
	LoadEncoreBuildSound
	spawnscriptnow ui_create_encore_confirmation_spawned params = {<...>}
	if ($is_network_game = 1)
		spawn_player_drop_listeners \{drop_player_script = song_breakdown_drop_player
			end_game_script = song_breakdown_end_game}
	endif
endscript

script ui_destroy_encore_confirmation 
	StopSound ($Current_Crowd_Encore)
	if ScreenElementExists \{id = EncoreInterface}
		EncoreInterface :Obj_KillSpawnedScript \{name = encore_shake_crossbones}
		EncoreInterface :Obj_KillSpawnedScript \{name = ui_encore_confirmation_anim_in}
	endif
	destroy_ui_encore_confirmation
endscript

script ui_create_encore_confirmation_spawned 
	SoundEvent \{event = $Current_Crowd_Applause_SoundEvent}
	SoundEvent \{event = $Current_Crowd_Encore}
	spawnscriptnow \{metallica_encore_crowd}
	destroy_ui_encore_confirmation
	if isSinglePlayerGame
		getNewCashFromDetailedStats
		stars = ($player1_status.stars)
		score = ($player1_status.score)
		Cash = <new_cash>
	else
		GameMode_GetNumPlayersShown
		total_cash = 0
		p = 1
		begin
		GetPlayerInfo <p> is_local_client
		if (<is_local_client> = 1)
			getNewCashFromDetailedStats player = <p>
			total_cash = (<total_cash> + <new_cash>)
		endif
		p = (<p> + 1)
		repeat <num_players_shown>
		score = ($band1_status.score)
		stars = ($band1_status.stars)
		Cash = <total_cash>
	endif
	CreateScreenElement \{type = DescInterface
		parent = root_window
		id = EncoreInterface
		desc = 'encore'
		encore_master_container_scale = 1.0
		exclusive_device = $primary_controller
		event_handlers = [
			{
				pad_choose
				encore_play
			}
		]}
	if EncoreInterface :Desc_ResolveAlias \{name = alias_stars_stack}
		if GetScreenElementChildren id = <resolved_id>
			GetArraySize <children>
			child_index = 0
			begin
			GetRandomValue \{name = rand_rot
				a = -10
				b = 10}
			SetScreenElementProps id = (<children> [<child_index>]) rot_angle = <rand_rot>
			child_index = (<child_index> + 1)
			repeat <array_size>
			if (<array_size> > 0)
				if (<stars> < 5)
					destroy_menu menu_id = (<children> [0])
				endif
				if (<stars> < 4)
					destroy_menu menu_id = (<children> [1])
				endif
			endif
		endif
	endif
	CastToInteger \{score}
	FormatText TextName = score_text qs("%d") d = <score> usecommas
	EncoreInterface :SE_SetProps encore_score_text = <score_text>
	FormatText TextName = cash_text qs("$%d") d = <Cash> usecommas
	EncoreInterface :SE_SetProps encore_money_text = <cash_text>
	EncoreInterface :Obj_SpawnScriptNow \{ui_encore_confirmation_anim_in}
	mark_encore_started
endscript

script ui_encore_add_components_for_continue 
	array = [
		{pad_choose ui_song_breakdown_continue_to_loading_screen}
	]
	SetScreenElementProps {
		id = EncoreInterface
		event_handlers = <array>
	}
	add_user_control_helper \{text = qs("CONTINUE")
		button = green
		z = 100000}
	AssignAlias \{id = EncoreInterface
		alias = current_menu}
endscript

script mark_encore_started 
	get_progression_globals ($current_progression_flag)
	format_globaltag_gigname setlist_prefix = ($<tier_global>.prefix) gignum = ($current_gig_number)
	SetGlobalTags <gig_name> params = {started = 1 encore_unlocked = 1} all_active_players = 1
	if IsHost
		SendStructure \{callback = mark_encore_started
			data_to_send = {
				none
			}}
	endif
endscript

script destroy_ui_encore_confirmation 
	clean_up_user_control_helpers
	KillSpawnedScript \{name = ui_encore_animate_flashbulbs}
	ui_destroy_encore_flashbulbs
	if ScreenElementExists \{id = EncoreInterface}
		EncoreInterface :Die
	endif
endscript

script ui_destroy_encore_flashbulbs 
	KillSpawnedScript \{name = pulsate_helper_pill}
endscript

script ui_encore_confirmation_anim_in 
	SE_SetProps \{rotation_anchor_rot_angle = -1.5
		time = 0.03
		Anim = slow_out}
	SE_SetProps \{encore_clip_rect_pos = {
			relative
			(0.0, -600.0)
		}}
	SE_SetProps \{encore_roll_pos = {
			relative
			(5.0, -600.0)
		}
		motion = ease_out}
	SE_WaitProps
	SE_SetProps \{encore_clip_rect_pos = {
			relative
			(0.0, 300.0)
		}
		Anim = slow_out}
	SE_SetProps \{encore_roll_pos = {
			relative
			(5.0, 305.0)
		}
		motion = ease_out}
	SE_SetProps \{encore_roll_scale = (1.2, 2.0)}
	Wait \{0.06
		seconds}
	SE_SetProps \{encore_clip_rect_pos = {
			relative
			(0.0, 50.0)
		}
		Anim = slow_out}
	SE_SetProps \{encore_roll_pos = {
			relative
			(2.0, 58.0)
		}
		motion = ease_out}
	SE_SetProps \{encore_roll_scale = (1.2, 1.5)}
	SE_WaitProps
	Wait \{0.04
		seconds}
	SE_SetProps \{encore_clip_rect_pos = {
			relative
			(0.0, 200.0)
		}
		Anim = slow_out}
	SE_SetProps \{encore_roll_pos = {
			relative
			(0.0, 168.0)
		}
		motion = ease_out}
	SE_SetProps \{encore_roll_scale = (1.2, 0.8)}
	SE_WaitProps
	Wait \{0.04
		seconds}
	SE_SetProps \{encore_clip_rect_pos = {
			relative
			(0.0, 50.0)
		}
		Anim = slow_out}
	SE_SetProps \{encore_roll_pos = {
			relative
			(0.0, 45.0)
		}
		motion = ease_out}
	SE_SetProps \{encore_roll_scale = (1.2, 0.0)}
	SE_SetProps \{rotation_anchor_rot_angle = 1.3
		time = 0.1
		Anim = slow_out}
	Wait \{0.1
		seconds}
	EncoreInterface :Obj_SpawnScriptNow \{encore_shake_crossbones}
	SE_SetProps \{rotation_anchor_rot_angle = -1.1
		time = 1.2
		Anim = slow_out}
	SE_WaitProps
	SE_SetProps \{rotation_anchor_rot_angle = 0.5
		time = 0.5
		Anim = fast_out}
	SE_WaitProps
	SE_SetProps \{rotation_anchor_rot_angle = -0.5
		time = 1.8
		Anim = slow_out}
	SE_WaitProps
	SE_SetProps \{rotation_anchor_rot_angle = 0.0
		time = 1.8
		Anim = slow_out}
	SE_WaitProps
endscript

script encore_shake_crossbones 
	begin
	SE_SetProps \{encore_scaryL_arm_r_pos = (-210.9359, -86.79193)
		time = 0.05}
	SE_SetProps \{encore_scaryL_arm_l_pos = (-223.5812, -88.16052)
		time = 0.05}
	SE_SetProps \{encore_scaryR_arm_r_pos = (207.2603, -97.39429)
		time = 0.05}
	SE_SetProps \{encore_scaryR_arm_l_pos = (198.9029, -90.0565)
		time = 0.05}
	SE_WaitProps
	SE_SetProps \{encore_scaryL_arm_r_pos = (-185.2709, -106.62399)
		time = 0.3}
	SE_SetProps \{encore_scaryL_arm_l_pos = (-248.0796, -104.4928)
		time = 0.3}
	SE_SetProps \{encore_scaryR_arm_r_pos = (227.2603, -116.3811)
		time = 0.3}
	SE_SetProps \{encore_scaryR_arm_l_pos = (163.96799, -113.5112)
		time = 0.3}
	SE_WaitProps
	repeat
endscript
