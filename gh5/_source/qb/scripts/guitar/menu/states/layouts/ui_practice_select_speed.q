
script ui_create_practice_select_speed 
	change menu_flow_locked = ($menu_flow_locked + 1)
	GetPlayerInfo \{1
		part}
	if (<part> = Vocals && $game_mode = practice)
		SpawnScriptLater \{menu_choose_practice_speed_auto_go_to_gameplay_for_vocals}
		change menu_flow_locked = ($menu_flow_locked - 1)
		return
	endif
	if GotParam \{from_pause}
		make_generic_menu {
			title = qs("PRACTICE SPEED")
			exclusive_device = <player_device>
			centered
			extra_z = 1000
			bg_pos = (200.0, 0.0)
			title_bg_pos = (620.0, 50.0)
		}
	else
		make_menu_frontend \{title = qs("PRACTICE SPEED")}
	endif
	<speeds> = [
		{
			text = qs(0x9c71754c)
			Speed = full
		}
		{
			text = qs("Slow")
			Speed = Slow
		}
		{
			text = qs(0x52bac34b)
			Speed = slower
		}
		{
			text = qs(0xe20f8ce9)
			Speed = slowest
		}
	]
	GetPlayerInfo \{1
		part}
	GetArraySize <speeds>
	i = 0
	begin
	if (<part> = Vocals && (<speeds> [<i>].Speed) != full)
		focusable = {not_focusable}
	else
		RemoveParameter \{focusable}
	endif
	add_menu_frontend_item {
		text = (<speeds> [<i>].text)
		pad_choose_script = menu_choose_practice_speed_set_speed
		pad_choose_params = {Speed = (<speeds> [<i>].Speed) from_pause = <from_pause> from_song_breakdown = <from_song_breakdown>}
		<focusable>
	}
	i = (<i> + 1)
	repeat <array_size>
	if <desc_id> :Desc_ResolveAlias name = alias_projection param = projection_id
		<projection_id> :SE_SetProps dims = (685.04926, 670.0)
		<projection_id> :SE_SetProps pos = (950.0, 325.0)
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_projection_glow param = projection_glow_id
		<projection_glow_id> :SE_SetProps dims = (685.04926, 670.0)
		<projection_glow_id> :SE_SetProps pos = (950.0, 325.0)
		<projection_glow_id> :obj_spawnscript ui_flicker_highlight params = {glow_dimly}
	else

	endif
	menu_finish
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_practice_select_speed 
	change menu_flow_locked = ($menu_flow_locked + 1)
	generic_ui_destroy
	KillSpawnedScript \{name = career_menu_jaw_anim}
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script menu_choose_practice_speed_set_speed \{Speed = full}
	switch <Speed>
		case full
		change \{current_speedfactor = 1.0}
		case Slow
		change \{current_speedfactor = 0.8}
		case slower
		change \{current_speedfactor = 0.66666675}
		case slowest
		change \{current_speedfactor = 0.5}
	endswitch
	if GotParam \{from_song_breakdown}
		practice_restart_song
		generic_event_back \{state = uistate_gameplay}
	elseif NOT GotParam \{from_pause}
		generic_event_choose \{state = uistate_play_song}
	else
		restart_warning_select_restart \{dont_save_song_data}
	endif
endscript

script menu_choose_practice_speed_auto_go_to_gameplay_for_vocals 
	ui_event_wait_for_safe
	generic_event_choose \{state = uistate_play_song}
endscript
