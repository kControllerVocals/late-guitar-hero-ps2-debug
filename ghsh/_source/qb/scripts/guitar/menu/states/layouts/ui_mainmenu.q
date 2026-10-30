
script ui_create_mainmenu 
	spawnscriptnow ui_create_mainmenu_spawned params = <...>
endscript

script ui_create_mainmenu_spawned 
	onexitrun \{0xf00f29a9}
	0x79db87d7
	randomize
	setscriptcannotpause
	if scriptisrunning \{handle_signin_changed}
		mark_safe_for_shutdown
		return
	endif
	load_frontend_anim_paks
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
			frontend_load_soundcheck \{loadingscreen}
			wait \{2
				gameframe}
			create_main_menu_elements
		endif
		create_main_menu
		add_user_control_helper \{text = qs(0xc18d5e76)
			button = green
			z = 100
			all_buttons}
		if screenelementexists \{id = current_menu}
			current_menu :obj_spawnscriptnow \{create_motd}
			launchevent type = focus target = current_menu data = {child_index = <selected_index>}
		endif
		destroy_loading_screen
	else

		reset_quickplay_song_list
		unpausegame
		frontend_load_soundcheck \{loadingscreen
			async = 0}
		destroy_band
		destroy_bandname_viewport
	endif
endscript
initial_main_menu_anim = 1

script ui_mainmenu_anim_in 
	if NOT ($invite_controller = -1)
		return
	endif
	if ($initial_main_menu_anim = 1)
		begin
		if screenelementexists \{id = current_menu_anchor}
			break
		endif
		wait \{1
			gameframe}
		repeat
		change \{initial_main_menu_anim = 0}
	else
		menu_transition_in \{menu = current_menu_anchor}
	endif
endscript
0xa3535721 = (1.0, 1.0)
0xdf0fad32 = (1.0, 1.0)

script ui_mainmenu_anim_in_spawned 
	se_getprops \{main_menu_bg_scale}
	<org_scale> = <main_menu_bg_scale>
	se_getprops \{main_menu_bg_pos}
	<org_pos> = <main_menu_bg_pos>
	wait \{0.0
		seconds}
	ui_fx_set_blur \{amount = 0.8
		time = 0.0}
	se_setprops \{main_menu_bg_scale = 1.4}
	wait \{0.08
		seconds}
	se_setprops main_menu_bg_pos = (<org_pos> + (50.0, 20.0))
	wait \{0.08
		seconds}
	se_setprops \{main_menu_bg_scale = 1.2}
	wait \{0.08
		seconds}
	se_setprops main_menu_bg_scale = <org_scale>
	se_setprops main_menu_bg_pos = <org_pos>
	ui_fx_set_blur \{amount = 0.0
		time = 0.4}
endscript

script bg_swap 
	setscriptcannotpause
	begin
	se_setprops \{main_menu_bg_2_alpha = 0}
	wait \{0.7
		seconds
		ignoreslomo}
	se_setprops \{main_menu_bg_2_alpha = 1}
	wait \{0.7
		seconds
		ignoreslomo}
	repeat
endscript

script ui_mainmenu_anim_in_spawned_cleanup 
	ui_fx_set_blur \{amount = 0.0
		time = 0.0}
endscript

script ui_mainmenu_anim_out 
	menu_transition_out \{menu = current_menu_anchor}
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

script 0x768a0243 
	clean_up_user_control_helpers
	0x7ab6609c
	current_menu :obj_spawnscript \{0xedb53378}
	add_user_control_helper \{text = qs(0xc18d5e76)
		button = green
		z = 100
		all_buttons}
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
	setplayerinfo <player> controller = (<0x56444e32> [<i>])
	player = (<player> + 1)
	if (<player> = 5)
		break
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript
