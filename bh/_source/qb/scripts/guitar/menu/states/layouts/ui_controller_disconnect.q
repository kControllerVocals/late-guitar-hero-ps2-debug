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

script reset_no_controller_array 
	player = 0
	begin
	SetArrayElement ArrayName = player_has_no_controller GlobalArray index = <player> newvalue = 0
	player = (<player> + 1)
	repeat 4
	print_no_controller_array
endscript

script print_no_controller_array 
	player = 0
	begin
	player = (<player> + 1)
	repeat 4
endscript

script ui_init_controller_disconnect 
	vocals_mute_all_mics \{mute = true}
	spawnscriptnow \{ps2_pause_and_load_cd_pak}
endscript
ps2_cd_waiting_for_pak_load = 0

script ps2_pause_and_load_cd_pak 
	SetScriptCannotPause
	change \{ps2_cd_waiting_for_pak_load = 1}
	LoadPak \{'pak/ui/controller_disconnect.pak'
		heap = BottomUpHeap}
	begin
	if IsPakLoaded \{'pak/ui/controller_disconnect.pak'
			heap = BottomUpHeap}
		change \{ps2_cd_waiting_for_pak_load = 0}
		break
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script ps2_get_vocalist_without_controller 
	player = 0
	begin
	if ($player_has_no_controller [<player>])
		return vocalist_without_controller = <player>
	endif
	player = (<player> + 1)
	repeat ($current_num_players)
	return \{vocalist_without_controller = -1}
endscript

script ui_create_controller_disconnect 
	spawnscriptnow \{ui_create_controller_disconnect_spawned}
endscript

script ui_create_controller_disconnect_spawned 
	if ScreenElementExists \{id = exploding_particle_container}
		DestroyScreenElement \{id = exploding_particle_container}
	endif
	begin
	if ($ps2_cd_waiting_for_pak_load = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	disable_pause
	device_array = []
	i = 1
	begin
	GetPlayerInfo <i> controller
	AddArrayElement array = <device_array> element = <controller>
	<device_array> = <array>
	i = (<i> + 1)
	repeat ($current_num_players)
	<continue_text> = qs("CONTINUE")
	if ($g_in_tutorial = 1)
		<continue_text> = qs("RESTART LESSON")
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
		if ScreenElementExists \{id = dialog_box_container}
			destroy_dialog_box
		endif
	endif
	if ($end_credits = 0)
		<element> = {
			func = ui_controller_disconnect_return_to_main_menu
			text = qs("QUIT")
			sound_func = nullscript
		}
		AddArrayElement array = <options_array> element = <element>
		<options_array> = <array>
	endif
	text = qs("")
	create_dialog_box {
		Template = large_body
		no_background
		heading_text = qs("WARNING")
		body_text = <text>
		options = <options_array>
		dlg_z_priority = ($ps3_fade_overlay_z + 100)
		player_device = <device_array>
	}
	dialog_box_vmenu :obj_spawnscript \{ui_controller_disconnect_pause}
	dialog_box_desc_id :obj_spawnscript \{ui_controller_disconnect_update}
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs("SELECT")
		button = green
		z = 1000000
		all_buttons}
endscript

script ui_destroy_controller_disconnect 
	destroy_dialog_box
	KillSpawnedScript \{name = ui_create_controller_disconnect_spawned}
	UnloadPak \{'pak/ui/controller_disconnect.pak'
		heap = BottomUpHeap}
endscript

script ui_deinit_controller_disconnect 
	vocals_mute_all_mics \{mute = false}
	if ($is_network_game)
		EnableAllInput
	endif
endscript

script ui_controller_disconnect_pause 
	change \{control_dis_paused = 0}
	ui_event_wait_for_safe
	if NOT GameIsPaused
		if NOT ($is_network_game)
			do_gh3_pause
		endif
		change \{control_dis_paused = 1}
	endif
endscript

script ui_controller_disconnect_update 
	SetScriptCannotPause
	if ScreenElementExists \{id = menu_tutorial}
		LaunchEvent \{type = unfocus
			target = menu_tutorial}
	endif
	old_text = qs("\L")
	begin
	RemoveParameter \{array_size}
	GetArraySize \{$sysnotify_paused_controllers}
	if (<array_size> > 0)
		text = qs("Disconnected controllers:")
		i = 0
		begin
		RemoveParameter \{part}
		j = 1
		begin
		RemoveParameter \{controller}
		GetPlayerInfo <j> controller
		if (<controller> = ($sysnotify_paused_controllers [<i>]))
			GetPlayerInfo <j> part
			break
		endif
		j = (<j> + 1)
		repeat ($current_num_players)
		if GotParam \{part}
			if ($vocal_mic_invalid_dist = 0)
				if ((<part> = guitar) || (<part> = Bass))
					FormatText TextName = text qs("%t\nPlayer %j's Guitar Controller") t = <text> j = <j>
				endif
				if (<part> = drum)
					if (($unknown_drum_type) = 1)
						FormatText TextName = text qs("%t\nPlayer %j's Drum Controller") t = <text> j = <j>
						UseFourLaneHighway player = <j> reset
					else
						GetPlayerInfo <j> four_lane_highway
						if (<four_lane_highway> = 1)
							FormatText TextName = text qs("%t\nPlayer %j's Four Pad Drum Controller") t = <text> j = <j>
						elseif (<four_lane_highway> = 0)
							FormatText TextName = text qs("%t\nPlayer %j's Drum Controller") t = <text> j = <j>
						else
							FormatText TextName = text qs("%t\nPlayer %j's Drum Controller") t = <text> j = <j>
							change \{unknown_drum_type = 1}
							UseFourLaneHighway player = <j> reset
						endif
					endif
				endif
			endif
			if (<part> = Vocals)
				GetPlayerInfo <j> mic_connected
				if isXenon
					GetPlayerInfo <j> mic_type
					switch <mic_connected>
						case mic_disconnected
						if (<mic_type> = headset)
							FormatText TextName = text qs("%t\nPlayer %j's Xbox 360 Headset") t = <text> j = <j>
						else
							FormatText TextName = text qs("%t\nPlayer %j's microphone") t = <text> j = <j>
						endif
						case both_disconnected
						if (<mic_type> = headset)
							FormatText TextName = text qs("%t\nPlayer %j's Xbox 360 Controller\nPlayer %j's Xbox 360 Headset") t = <text> j = <j>
						else
							FormatText TextName = text qs("%t\nPlayer %j's Xbox 360 Controller\nPlayer %j's microphone") t = <text> j = <j>
						endif
						case controller_disconnected
						default
						FormatText TextName = text qs("%t\nPlayer %j's Xbox 360 Controller") t = <text> j = <j>
					endswitch
				else
					switch <mic_connected>
						case mic_disconnected
						FormatText TextName = text qs("%t\nPlayer %j's microphone") t = <text> j = <j>
						case both_disconnected
						FormatText TextName = text qs(0x79b97466) t = <text> j = <j>
						case controller_disconnected
						default
						FormatText TextName = text qs(0xda0aedbd) t = <text> j = <j>
					endswitch
				endif
			endif
		endif
		i = (<i> + 1)
		repeat <array_size>
	else
		if ($in_tutorial_mode = 1)
			GetPlayerInfo \{1
				part}
			GetPlayerInfo \{1
				controller}
			GetPlayerInfo \{1
				mic_connected}
			if (<part> = Vocals && ($current_training_script = training_vocals_tutorial_script || $current_training_script = training_band_tutorial_script))
				has_mic = 0
				if IsMicrophonePluggedIn \{number = 0}
					<has_mic> = 1
				endif
				if IsMicrophonePluggedIn \{number = 1}
					<has_mic> = 1
				endif
				text = qs("Disconnected controllers:")
				switch <mic_connected>
					case mic_disconnected
					FormatText TextName = text qs("%t\nPlayer 1's microphone") t = <text>
					case both_disconnected
					FormatText TextName = text qs(0x7cda3d79) t = <text>
					case controller_disconnected
					FormatText TextName = text qs(0x99e399f7) t = <text>
					default
					text = qs("All controllers are connected!")
				endswitch
			else
				text = qs("All controllers are connected!")
			endif
		else
			text = qs("All controllers are connected!")
		endif
	endif
	if NOT GotParam \{no_text}
		if NOT (<old_text> = <text>)
			SE_SetProps {dlog_body_text = <text>}
			old_text = <text>
		endif
	else
		break
	endif
	Wait \{1
		gameframe}
	if ($g_in_tutorial = 1)
		j = 1
		GetActiveControllers
		begin
		RemoveParameter \{controller}
		GetPlayerInfo <j> controller
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
		GetArraySize \{$sysnotify_paused_controllers}
		if NOT (<array_size> = 0)
			menu_scroll_end_sound
			return
		endif
		if ($in_tutorial_mode = 1)
			GetPlayerInfo \{1
				part}
			GetPlayerInfo \{1
				controller}
			if (<part> = Vocals && $current_training_script = training_vocals_tutorial_script)
				has_mic = 0
				if controller_has_headset controller = <controller>
					<has_mic> = 1
				endif
				if IsMicrophonePluggedIn \{number = 0}
					<has_mic> = 1
				endif
				if IsMicrophonePluggedIn \{number = 1}
					<has_mic> = 1
				endif
				GetPlayerInfo \{1
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
		if ScreenElementExists \{id = training_container}
			DestroyScreenElement \{id = training_container}
		endif
		if ScreenElementExists \{id = jam_band_container}
			DestroyScreenElement \{id = jam_band_container}
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

	KillSpawnedScript \{name = Loading_Screen_Crowd_Swell}
	KillSpawnedScript \{name = Crowd_Loading_Whistle}
	KillSpawnedScript \{name = OneShotsBetweenSongs}
	KillSpawnedScript \{name = SurgeBetweenSongs}
	StopSoundsByBuss \{Crowd_One_Shots}
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	kill_intro_celeb_ui
	SE_SetProps \{block_events}
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
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	SE_SetProps \{block_events}
	generic_event_replace \{state = uistate_controller_disconnect
		data = {
			is_popup
		}}
endscript
