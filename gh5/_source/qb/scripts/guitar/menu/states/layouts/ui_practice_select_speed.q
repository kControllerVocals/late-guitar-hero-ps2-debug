
script ui_create_practice_select_speed 
	change menu_flow_locked = ($menu_flow_locked + 1)
	getplayerinfo \{1
		part}
	if (<part> = vocals && $game_mode = practice)
		spawnscriptlater \{menu_choose_practice_speed_auto_go_to_gameplay_for_vocals}
		change menu_flow_locked = ($menu_flow_locked - 1)
		return
	endif
	if gotparam \{from_pause}
		make_generic_menu {
			title = qs(0x452d8770)
			exclusive_device = <player_device>
			centered
			extra_z = 1000
			bg_pos = (200.0, 0.0)
			title_bg_pos = (620.0, 50.0)
		}
	else
		make_menu_frontend \{title = qs(0x452d8770)}
	endif
	<speeds> = [
		{
			text = qs(0x9c71754c)
			speed = full
		}
		{
			text = qs(0x3d7913f6)
			speed = slow
		}
		{
			text = qs(0x52bac34b)
			speed = slower
		}
		{
			text = qs(0xe20f8ce9)
			speed = slowest
		}
	]
	getplayerinfo \{1
		part}
	getarraysize <speeds>
	i = 0
	begin
	if (<part> = vocals && (<speeds> [<i>].speed) != full)
		focusable = {not_focusable}
	else
		removeparameter \{focusable}
	endif
	add_menu_frontend_item {
		text = (<speeds> [<i>].text)
		pad_choose_script = menu_choose_practice_speed_set_speed
		pad_choose_params = {speed = (<speeds> [<i>].speed) from_pause = <from_pause> from_song_breakdown = <from_song_breakdown>}
		<focusable>
	}
	i = (<i> + 1)
	repeat <array_size>
	if <desc_id> :desc_resolvealias name = 0xa954edbf param = 0xa1309942
		<0xa1309942> :se_setprops dims = (685.04926, 670.0)
		<0xa1309942> :se_setprops pos = (950.0, 325.0)
	else

	endif
	if <desc_id> :desc_resolvealias name = 0xd389b1ff param = 0xb9ea5094
		<0xb9ea5094> :se_setprops dims = (685.04926, 670.0)
		<0xb9ea5094> :se_setprops pos = (950.0, 325.0)
		<0xb9ea5094> :obj_spawnscript 0xd5b5a21b params = {0xc2c7c0e4}
	else

	endif
	menu_finish
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_practice_select_speed 
	change menu_flow_locked = ($menu_flow_locked + 1)
	generic_ui_destroy
	killspawnedscript \{name = career_menu_jaw_anim}
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script menu_choose_practice_speed_set_speed \{speed = full}
	switch <speed>
		case full
		change \{current_speedfactor = 1.0}
		case slow
		change \{current_speedfactor = 0.8}
		case slower
		change \{current_speedfactor = 0.66666675}
		case slowest
		change \{current_speedfactor = 0.5}
	endswitch
	if gotparam \{from_song_breakdown}
		practice_restart_song
		generic_event_back \{state = uistate_gameplay}
	elseif NOT gotparam \{from_pause}
		generic_event_choose \{state = uistate_play_song}
	else
		restart_warning_select_restart \{dont_save_song_data}
	endif
endscript

script menu_choose_practice_speed_auto_go_to_gameplay_for_vocals 
	ui_event_wait_for_safe
	generic_event_choose \{state = uistate_play_song}
endscript
