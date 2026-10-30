controller_unplugged_frame_count = 1
control_dis_paused = 0
unknown_drum_type = 0
band_mode_added_vocalist = 0
player_has_no_controller = [
	0
	0
	0
	0
]

script 0x55214850 
	player = 0
	begin
	setarrayelement arrayname = player_has_no_controller globalarray index = <player> newvalue = 0
	player = (<player> + 1)
	repeat 4
	0xe752bb84
endscript

script 0xe752bb84 
	player = 0
	begin
	player = (<player> + 1)
	repeat 4
endscript

script ui_init_controller_disconnect 
	vocals_mute_all_mics \{mute = true}
	spawnscriptnow \{0x226ec8f8}
endscript
0xf8507843 = 0

script 0x226ec8f8 
	setscriptcannotpause
	change \{0xf8507843 = 1}
	loadpak \{'pak/ui/controller_disconnect.pak'
		heap = bottomupheap}
	begin
	if ispakloaded \{'pak/ui/controller_disconnect.pak'
			heap = bottomupheap}
		change \{0xf8507843 = 0}
		break
	endif
	wait \{1
		gameframe}
	repeat
endscript

script 0x79c6d425 
	player = 0
	begin
	if ($player_has_no_controller [<player>])
		return 0x3e8a7a4d = <player>
	endif
	player = (<player> + 1)
	repeat ($current_num_players)
	return \{0x3e8a7a4d = -1}
endscript

script ui_create_controller_disconnect 
	spawnscriptnow \{0xcbdb5862}
endscript

script 0xcbdb5862 
	if screenelementexists \{id = exploding_particle_container}
		destroyscreenelement \{id = exploding_particle_container}
	endif
	begin
	if ($0xf8507843 = 0)
		break
	endif
	wait \{1
		gameframe}
	repeat
	disable_pause
	device_array = []
	i = 1
	begin
	getplayerinfo <i> controller
	addarrayelement array = <device_array> element = <controller>
	<device_array> = <array>
	i = (<i> + 1)
	repeat ($current_num_players)
	<continue_text> = qs(0x182f0173)
	if ($g_in_tutorial = 1)
		<continue_text> = qs(0x9c8bd769)
	endif
	continue_enabled = 1
	if ($is_network_game = 1)
		ui_controller_disconnect_update \{no_text}
		if ($unknown_drum_type = 1)
			<continue_enabled> = 0
		endif
	endif
	if (<continue_enabled> = 1)
		<options_array> = [
			{
				func = ui_controller_disconnect_continue
				text = <continue_text>
				sound_func = nullscript
			}
		]
	else
		<options_array> = []
	endif
	if ($g_in_tutorial = 1)
		if screenelementexists \{id = dialog_box_container}
			destroy_dialog_box
		endif
	endif
	if ($end_credits = 0)
		<element> = {
			func = ui_controller_disconnect_return_to_main_menu
			text = qs(0x67d9c56d)
			sound_func = nullscript
		}
		addarrayelement array = <options_array> element = <element>
		<options_array> = <array>
	endif
	text = qs(0x00000000)
	create_dialog_box {
		template = large_body
		no_background
		heading_text = qs(0xaa163738)
		body_text = <text>
		options = <options_array>
		dlg_z_priority = ($ps3_fade_overlay_z + 100)
		player_device = <device_array>
	}
	dialog_box_vmenu :obj_spawnscript \{ui_controller_disconnect_pause}
	dialog_box_desc_id :obj_spawnscript \{ui_controller_disconnect_update}
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs(0xc18d5e76)
		button = green
		z = 1000000
		all_buttons}
endscript

script ui_destroy_controller_disconnect 
	destroy_dialog_box
	killspawnedscript \{name = 0xcbdb5862}
	unloadpak \{'pak/ui/controller_disconnect.pak'
		heap = bottomupheap}
endscript

script ui_deinit_controller_disconnect 
	vocals_mute_all_mics \{mute = false}
	if ($is_network_game)
		enableallinput
	endif
endscript

script ui_controller_disconnect_pause 
	change \{control_dis_paused = 0}
	ui_event_wait_for_safe
	if NOT gameispaused
		if NOT ($is_network_game)
			do_gh3_pause
		endif
		change \{control_dis_paused = 1}
	endif
endscript

script ui_controller_disconnect_update 
	setscriptcannotpause
	if screenelementexists \{id = menu_tutorial}
		launchevent \{type = unfocus
			target = menu_tutorial}
	endif
	old_text = qs(0x03ac90f0)
	begin
	removeparameter \{array_size}
	getarraysize \{$sysnotify_paused_controllers}
	if (<array_size> > 0)
		text = qs(0xfbc815c6)
		i = 0
		begin
		removeparameter \{part}
		j = 1
		begin
		removeparameter \{controller}
		getplayerinfo <j> controller
		if (<controller> = ($sysnotify_paused_controllers [<i>]))
			getplayerinfo <j> part
			break
		endif
		j = (<j> + 1)
		repeat ($current_num_players)
		if gotparam \{part}
			if ($vocal_mic_invalid_dist = 0)
				if ((<part> = guitar) || (<part> = bass))
					formattext textname = text qs(0x2e301f7d) t = <text> j = <j>
				endif
				if (<part> = drum)
					if (($unknown_drum_type) = 1)
						formattext textname = text qs(0x91d2ab93) t = <text> j = <j>
						usefourlanehighway player = <j> reset
					else
						getplayerinfo <j> four_lane_highway
						if (<four_lane_highway> = 1)
							formattext textname = text qs(0x43606ed7) t = <text> j = <j>
						elseif (<four_lane_highway> = 0)
							formattext textname = text qs(0x91d2ab93) t = <text> j = <j>
						else
							formattext textname = text qs(0x91d2ab93) t = <text> j = <j>
							change \{unknown_drum_type = 1}
							usefourlanehighway player = <j> reset
						endif
					endif
				endif
			endif
			if (<part> = vocals)
				getplayerinfo <j> mic_connected
				if isxenon
					getplayerinfo <j> mic_type
					switch <mic_connected>
						case mic_disconnected
						if (<mic_type> = headset)
							formattext textname = text qs(0x27139544) t = <text> j = <j>
						else
							formattext textname = text qs(0xa8485a04) t = <text> j = <j>
						endif
						case both_disconnected
						if (<mic_type> = headset)
							formattext textname = text qs(0x21036be5) t = <text> j = <j>
						else
							formattext textname = text qs(0x0a21e4b1) t = <text> j = <j>
						endif
						case controller_disconnected
						default
						formattext textname = text qs(0x773068f3) t = <text> j = <j>
					endswitch
				else
					switch <mic_connected>
						case mic_disconnected
						formattext textname = text qs(0xa8485a04) t = <text> j = <j>
						case both_disconnected
						formattext textname = text qs(0x79b97466) t = <text> j = <j>
						case controller_disconnected
						default
						formattext textname = text qs(0xda0aedbd) t = <text> j = <j>
					endswitch
				endif
			endif
		endif
		i = (<i> + 1)
		repeat <array_size>
	else
		if ($in_tutorial_mode = 1)
			getplayerinfo \{1
				part}
			getplayerinfo \{1
				controller}
			getplayerinfo \{1
				mic_connected}
			if (<part> = vocals && ($current_training_script = training_vocals_tutorial_script || $current_training_script = training_band_tutorial_script))
				has_mic = 0
				if ismicrophonepluggedin \{number = 0}
					<has_mic> = 1
				endif
				if ismicrophonepluggedin \{number = 1}
					<has_mic> = 1
				endif
				text = qs(0xfbc815c6)
				switch <mic_connected>
					case mic_disconnected
					formattext textname = text qs(0xeba12e4e) t = <text>
					case both_disconnected
					formattext textname = text qs(0x7cda3d79) t = <text>
					case controller_disconnected
					formattext textname = text qs(0x99e399f7) t = <text>
					default
					text = qs(0x6c92395c)
				endswitch
			else
				text = qs(0x6c92395c)
			endif
		else
			text = qs(0x6c92395c)
		endif
	endif
	if NOT gotparam \{no_text}
		if NOT (<old_text> = <text>)
			se_setprops {dlog_body_text = <text>}
			old_text = <text>
		endif
	else
		break
	endif
	wait \{1
		gameframe}
	if ($g_in_tutorial = 1)
		j = 1
		getactivecontrollers
		begin
		removeparameter \{controller}
		getplayerinfo <j> controller
		if ((<controller> >= 0) && (<controller> < 8))
			if NOT (<active_controllers> [(<controller>)])
				sysnotify_handle_pause_controller device_num = <controller>
			else
				sysnotify_handle_unpause_controller device_num = <controller>
			endif
		endif
		j = (<j> + 1)
		repeat ($current_num_players)
	endif
	repeat
endscript

script ui_controller_disconnect_continue 
	if ($vocal_mic_invalid_dist = 0)
		getarraysize \{$sysnotify_paused_controllers}
		if NOT (<array_size> = 0)
			menu_scroll_end_sound
			return
		endif
		if ($in_tutorial_mode = 1)
			getplayerinfo \{1
				part}
			getplayerinfo \{1
				controller}
			if (<part> = vocals && $current_training_script = training_vocals_tutorial_script)
				has_mic = 0
				if controller_has_headset controller = <controller>
					<has_mic> = 1
				endif
				if ismicrophonepluggedin \{number = 0}
					<has_mic> = 1
				endif
				if ismicrophonepluggedin \{number = 1}
					<has_mic> = 1
				endif
				getplayerinfo \{1
					mic_connected}
				switch <mic_connected>
					case mic_disconnected
					case both_disconnected
					case controller_disconnected
					<has_mic> = 0
					default
					<has_mic> = 1
				endswitch
				if (<has_mic> = 0)
					menu_scroll_end_sound
					return
				endif
			endif
		endif
	else
		vocals_distribute_mics
		change \{vocal_mic_invalid_dist = 1}
		if NOT vocals_mic_distribution_is_valid
			menu_scroll_end_sound
			return
		endif
	endif
	change \{check_for_unplugged_controllers = 1}
	vocals_set_mics_to_user_volumes
	if ($g_in_tutorial = 1)
		do_gh3_unpause
		if screenelementexists \{id = training_container}
			destroyscreenelement \{id = training_container}
		endif
		if screenelementexists \{id = jam_band_container}
			destroyscreenelement \{id = jam_band_container}
		endif
		generic_event_back
		tutorial_restart
	else
		if ($control_dis_paused = 1)
			if ($playing_song = 0)
				do_gh3_unpause
			endif
			change \{control_dis_paused = 0}
		endif
		if ($playing_song = 1)
			if ($vocal_mic_invalid_dist > 0)
				if ($is_network_game)
					ui_controller_disconnect_return_to_main_menu device_num = <device_num>
				else
					generic_event_replace \{state = uistate_pausemenu_restart_warning
						data = {
							is_popup
							cancel_func = generic_event_replace
							cancel_func_params = {
								state = uistate_controller_disconnect
								data = {
									is_popup
								}
							}
						}}
				endif
			elseif ($unknown_drum_type = 1)
				if ($is_network_game)
					ui_controller_disconnect_return_to_main_menu device_num = <device_num>
				else
					generic_event_replace \{state = uistate_pausemenu_restart_warning
						data = {
							is_popup
							cancel_func = generic_event_replace
							cancel_func_params = {
								state = uistate_controller_disconnect
								data = {
									is_popup
								}
							}
						}}
				endif
			elseif ui_event_exists_in_stack \{above = 'gameplay'
					name = 'pausemenu'}
				generic_event_back
			else
				spawnscriptnow \{unpausegh3
					params = {
						from_handler
					}}
			endif
		else
			generic_event_back
		endif
	endif
endscript

script ui_controller_disconnect_return_to_main_menu 

	killspawnedscript \{name = loading_screen_crowd_swell}
	killspawnedscript \{name = crowd_loading_whistle}
	killspawnedscript \{name = oneshotsbetweensongs}
	killspawnedscript \{name = surgebetweensongs}
	stopsoundsbybuss \{crowd_one_shots}
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	kill_intro_celeb_ui
	se_setprops \{block_events}
	change last_start_pressed_device = <device_num>
	if ($g_in_tutorial = 1)
		tutorial_quit \{state = uistate_select_tutorial}
		startrendering
	elseif ($is_network_game)
		generic_event_replace state = uistate_online_quit_warning data = {
			is_popup
			player_device = <device_num>
			quit_script = ui_controller_disconnect_return_to_menu
		}
	else
		generic_event_replace \{state = uistate_pausemenu_quit_warning
			data = {
				option1_func = ui_controller_disconnect_return_to_menu
				option2_func = song_ended_menu_select_quit
				is_popup
			}}
	endif
endscript

script ui_controller_disconnect_return_to_menu 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	se_setprops \{block_events}
	generic_event_replace \{state = uistate_controller_disconnect
		data = {
			is_popup
		}}
endscript
