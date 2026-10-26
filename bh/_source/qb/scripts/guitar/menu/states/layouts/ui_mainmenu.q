
script ui_init_mainmenu 
	mainmenu_populate_menu_options_global
endscript

script ui_create_mainmenu 
	spawnscriptnow ui_create_mainmenu_spawned params = <...>
endscript

script ui_create_mainmenu_spawned 
	Randomize
	reset_focus_colors
	SetScriptCannotPause
	if ScriptIsRunning \{handle_signin_changed}
		mark_safe_for_shutdown
		return
	endif
	anim_paks_set_state \{state = FrontEnd
		async = 0}
	change \{respond_to_signin_changed = 0}
	change \{respond_to_signin_changed_func = main_menu_signin_changed}
	if ($invite_controller = -1)

		spawnscriptnow \{task_menu_default_anim_in
			params = {
				base_name = 'band_hub'
			}}
		change \{in_join_band_screens = 0}
		change \{game_mode = p1_quickplay}
		change \{current_num_players = 1}
		fadetoblack \{off
			alpha = 1.0
			time = 0.1
			z_priority = 100
			no_wait}
		clean_up_user_control_helpers
		if NOT ScreenElementExists \{id = current_menu}
			create_main_menu_elements
		endif
		create_main_menu
		ps2_map_nonprimary_controllers
		current_menu :obj_spawnscript \{ps2_check_for_nonprimary_remap}
		add_user_control_helper \{text = qs("SELECT")
			button = green
			z = 100
			all_buttons}
		add_user_control_helper \{text = qs("PARTY PLAY")
			button = Yellow
			z = 100
			all_buttons}
		if ScreenElementExists \{id = current_menu}
			current_menu :Obj_SpawnScriptNow \{create_motd}
			LaunchEvent type = focus target = current_menu data = {child_index = <selected_index>}
			current_menu_anchor :Obj_SpawnScriptNow \{ui_mainmenu_anim_in_spawned}
		endif
		destroy_loading_screen
	else

		reset_quickplay_song_list
		UnPauseGame
		destroy_band
		destroy_bandname_viewport
	endif
endscript

script ui_destroy_mainmenu 
	spawnscriptnow \{destroy_main_menu}
	KillSpawnedScript \{name = ui_mainmenu_anim_in_spawned}
	ui_fx_set_blur \{amount = 0.0
		time = 0.0}
	if ScreenElementExists \{id = current_menu_anchor}
		current_menu_anchor :SE_SetProps \{main_menu_bg_scale = $saved_main_menu_bg_scale}
		current_menu_anchor :SE_SetProps \{main_menu_bg_pos = $saved_main_menu_bg_pos}
	endif
endscript

script main_menu_signin_changed 

	RemoveContentFiles playerid = <controller>
	reset_globaltags savegame = <controller>
	cheat_turnoffalllocked
	MonitorControllerStates
endscript
main_menu_fs = {
	create = ui_mainmenu_temp
	destroy = destroy_main_menu
	actions = [
		{
			action = select_xbox_live
			flow_state = online_signin_fs
		}
	]
}

script ui_mainmenu_temp 
	ui_event \{event = menu_refresh}
endscript

script ps2_check_for_nonprimary_remap 
	GetActiveControllers
	last_active = <active_controllers>
	begin
	GetActiveControllers
	if NOT CompareArrays array1 = <active_controllers> array2 = <last_active>
		ps2_map_nonprimary_controllers
		last_active = <active_controllers>
	endif
	Wait \{3
		gameframes}
	repeat
endscript

script ps2_map_nonprimary_controllers 
	GetActiveControllers
	GetArraySize <active_controllers>
	if ($primary_controller < <array_size> && $primary_controller > 0)
		SetArrayElement ArrayName = active_controllers index = ($primary_controller) newvalue = 0
	endif
	handled_players = [0 0 0 0]
	player = 2
	begin
	GetPlayerInfo <player> controller
	if ((<controller> >= 0) && (<controller> < 8))
		if ((<active_controllers> [<controller>]) = 1)
			SetArrayElement ArrayName = active_controllers index = <controller> newvalue = 0
			SetArrayElement ArrayName = handled_players index = (<player> - 1) newvalue = 1
		endif
	endif
	player = (<player> + 1)
	repeat 3
	assign_controllers = []
	i = 0
	begin
	if ((<active_controllers> [<i>]) = 1)
		AddArrayElement array = <assign_controllers> element = <i>
		<assign_controllers> = <array>
	endif
	i = (<i> + 1)
	repeat <array_size>

	GetArraySize <assign_controllers>
	if (<array_size> = 0)
		return
	endif
	player = 2
	i = 0
	begin
	if ((<handled_players> [(<player> - 1)]) = 0)
		SetPlayerInfo <player> controller = (<assign_controllers> [<i>])
		i = (<i> + 1)
	endif
	player = (<player> + 1)
	if (<i> >= <array_size>)
		break
	endif
	repeat 3
endscript

script ui_return_mainmenu 
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs("SELECT")
		button = green
		z = 100
		all_buttons}
	add_user_control_helper \{text = qs("PARTY PLAY")
		button = Yellow
		z = 100
		all_buttons}
endscript
