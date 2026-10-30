
script ui_init_mainmenu 
	mainmenu_populate_menu_options_global
endscript

script ui_create_mainmenu 
	spawnscriptnow ui_create_mainmenu_spawned params = <...>
endscript

script ui_create_mainmenu_spawned 
	randomize
	reset_focus_colors
	setscriptcannotpause
	if scriptisrunning \{handle_signin_changed}
		mark_safe_for_shutdown
		return
	endif
	anim_paks_set_state \{state = frontend
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
		if NOT screenelementexists \{id = current_menu}
			create_main_menu_elements
		endif
		create_main_menu
		0x7ab6609c
		current_menu :obj_spawnscript \{0xedb53378}
		add_user_control_helper \{text = qs(0xc18d5e76)
			button = green
			z = 100
			all_buttons}
		add_user_control_helper \{text = qs(0x8a778398)
			button = yellow
			z = 100
			all_buttons}
		if screenelementexists \{id = current_menu}
			current_menu :obj_spawnscriptnow \{create_motd}
			launchevent type = focus target = current_menu data = {child_index = <selected_index>}
			current_menu_anchor :obj_spawnscriptnow \{ui_mainmenu_anim_in_spawned}
		endif
		destroy_loading_screen
	else

		reset_quickplay_song_list
		unpausegame
		destroy_band
		destroy_bandname_viewport
	endif
endscript

script ui_destroy_mainmenu 
	spawnscriptnow \{destroy_main_menu}
	killspawnedscript \{name = ui_mainmenu_anim_in_spawned}
	ui_fx_set_blur \{amount = 0.0
		time = 0.0}
	if screenelementexists \{id = current_menu_anchor}
		current_menu_anchor :se_setprops \{main_menu_bg_scale = $0xa3535721}
		current_menu_anchor :se_setprops \{main_menu_bg_pos = $0xdf0fad32}
	endif
endscript

script main_menu_signin_changed 

	removecontentfiles playerid = <controller>
	reset_globaltags savegame = <controller>
	cheat_turnoffalllocked
	monitorcontrollerstates
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

script 0xedb53378 
	getactivecontrollers
	0x3ee68127 = <active_controllers>
	begin
	getactivecontrollers
	if NOT 0xf7f68612 array1 = <active_controllers> array2 = <0x3ee68127>
		0x7ab6609c
		0x3ee68127 = <active_controllers>
	endif
	wait \{3
		gameframes}
	repeat
endscript

script 0x7ab6609c 
	getactivecontrollers
	getarraysize <active_controllers>
	if ($primary_controller < <array_size> && $primary_controller > 0)
		setarrayelement arrayname = active_controllers index = ($primary_controller) newvalue = 0
	endif
	0x30a3fc6b = [0 0 0 0]
	player = 2
	begin
	getplayerinfo <player> controller
	if ((<controller> >= 0) && (<controller> < 8))
		if ((<active_controllers> [<controller>]) = 1)
			setarrayelement arrayname = active_controllers index = <controller> newvalue = 0
			setarrayelement arrayname = 0x30a3fc6b index = (<player> - 1) newvalue = 1
		endif
	endif
	player = (<player> + 1)
	repeat 3
	0x56444e32 = []
	i = 0
	begin
	if ((<active_controllers> [<i>]) = 1)
		addarrayelement array = <0x56444e32> element = <i>
		<0x56444e32> = <array>
	endif
	i = (<i> + 1)
	repeat <array_size>

	getarraysize <0x56444e32>
	if (<array_size> = 0)
		return
	endif
	player = 2
	i = 0
	begin
	if ((<0x30a3fc6b> [(<player> - 1)]) = 0)
		setplayerinfo <player> controller = (<0x56444e32> [<i>])
		i = (<i> + 1)
	endif
	player = (<player> + 1)
	if (<i> >= <array_size>)
		break
	endif
	repeat 3
endscript

script 0x768a0243 
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs(0xc18d5e76)
		button = green
		z = 100
		all_buttons}
	add_user_control_helper \{text = qs(0x8a778398)
		button = yellow
		z = 100
		all_buttons}
endscript
