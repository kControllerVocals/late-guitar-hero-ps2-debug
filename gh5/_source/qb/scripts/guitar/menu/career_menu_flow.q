
script career_enter_band_name_flow_state_func 
	get_current_first_play
	if (<first_play>)
		return \{flow_state = main_menu_fs}
	else
		return \{flow_state = career_choose_band_fs}
	endif
endscript

script get_current_first_play 
	get_band_game_mode_name
	get_current_band_info
	bandname_id = <band_info>
	getglobaltags <bandname_id>
	return first_play = <first_play>
endscript

script career_select_difficulty_flow_state_func 
	get_current_first_play
	generic_event_choose \{data = {
			state = uistate_singleplayer_character_hub
			player = 1
		}}
endscript

script 0x978e7147 
	getplayerinfo <player> lefty_flip
	0xaab272cc = <lefty_flip>
	if (<0xaab272cc> = 1)
		new_flip = 0
	else
		new_flip = 1
	endif
	<player_status> = ($0x2994109a [<player>])
	change structurename = <player_status> lefty_flip = <new_flip>
	change structurename = <player_status> lefthanded_gems = <new_flip>
	change structurename = <player_status> lefthanded_gems_flip_save = <new_flip>
	change structurename = <player_status> lefthanded_button_ups = <new_flip>
	change structurename = <player_status> lefthanded_button_ups_flip_save = <new_flip>
	setplayerinfo <player> lefty_flip = <new_flip>
	getplayerinfo player = <player> controller
	if (<controller> = $primary_controller)
		if (<new_flip> = 1)
			change \{pad_event_up_inversion = true}
		else
			change \{pad_event_up_inversion = false}
		endif
	endif
	return new_flip = <new_flip>
endscript

script lefty_flip_func 
	if ($game_mode = practice)
		practice_restart_song
	else
		career_restart_song
	endif
endscript

script career_restart_song 
	if ($0xc7e670d7 = 1)
		change \{gameplay_restart_song = 1}
		generic_event_back \{state = uistate_gameplay}
		return
	endif
	killspawnedscript \{name = guitarevent_songwon_spawned}
	destroy_menu \{menu_id = yourock_text}
	destroy_menu \{menu_id = yourock_text_2}
	destroy_menu \{menu_id = yourock_text_legend}
	restart_song
endscript

script career_song_ended_select_quit 
	if ($debug_playcredits_active = 1)
		change \{debug_playcredits_active = 0}
	endif
	kill_gem_scroller <...>
endscript

script start_encore 

	getglobaltags \{progression
		params = encore_song}
	setglobaltags progression params = {current_tier = <next_tier>}
	setglobaltags progression params = {current_song_count = <next_song_count>}
	if ($is_network_game = 1)
		change current_song = <encore_song>
		change \{net_ready_to_start = 0}
	else
		change current_song = <encore_song>
	endif
endscript
default_loading_screen = {
	create = create_loading_screen
	destroy = destroy_loading_screen
}
