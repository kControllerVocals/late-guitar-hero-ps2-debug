
script ui_create_recording_disconnect \{practice = 0}
	if loading_screen_exists
		destroy_loading_screen
	endif
	if (<practice> = 1)
		options = [
			{
				func = ui_recording_disconnect_quit
				func_params = {<...>}
				text = qs("QUIT")
				sound_func = nullscript
			}
		]
	elseif GotParam \{recording_studio}
		options = [
			{
				func = ui_recording_disconnect_continue
				func_params = {<...>}
				text = qs("OK")
				sound_func = nullscript
			}
		]
	else
		options = [
			{
				func = ui_recording_disconnect_continue
				func_params = {<...>}
				text = qs("CONTINUE")
				sound_func = nullscript
			}
			{
				func = ui_recording_disconnect_quit
				text = qs("QUIT")
				sound_func = nullscript
			}
		]
	endif
	create_dialog_box {
		heading_text = qs("WARNING")
		body_text = qs("")
		options = <options>
		player_device = ($primary_controller)
	}
	dialog_box_desc_id :SetTags \{is_disconnect_warning = true}
	if (<practice> = 1)
		KillSpawnedScript \{id = jam_tutorial_topic_spawn}
		KillSpawnedScript \{id = jam_tutorial_spawns}
		training_destroy_narrator_icons
		change \{jam_tutorial_status = inactive}
	endif
	if GotParam \{recording_studio}
		if (<practice> = 1)
			dialog_box_desc_id :obj_spawnscript ui_recording_disconnect_update params = {practice = <practice>}
		else
			dialog_box_desc_id :obj_spawnscript \{ui_recording_disconnect_update}
		endif
	else
		dialog_box_desc_id :obj_spawnscript \{ui_recording_disconnect_update}
	endif
endscript

script ui_destroy_recording_disconnect 
	destroy_dialog_box
	set_recording_disconnect_inactive
endscript

script ui_recording_disconnect_update \{practice = 0}
	old_text = qs("YOU ARE ROCKING OUT A BIT TOO HARD!")
	GetActiveControllers
	<previous_active_controllers> = [0 0 0 0 0 0 0 0]
	if (($primary_controller) > 1)
		count = 0
		begin
		SetArrayElement ArrayName = previous_active_controllers index = <count> newvalue = (<active_controllers> [<count>])
		<count> = (<count> + 1)
		repeat 8
	endif
	begin
	GetActiveControllers
	if ((<active_controllers> [($primary_controller)]) = 0)
		if (($primary_controller) > 1)
			count = 0
			begin
			if (<count> > 1)
				if (<previous_active_controllers> [<count>] = 0)
					if (<active_controllers> [<count>] = 1)
						ui_recording_disconnect_continue
						set_primary_controller device_num = <count> state = UIstate_recording_disconnect
					endif
				endif
			endif
			SetArrayElement ArrayName = previous_active_controllers index = <count> newvalue = (<active_controllers> [<count>])
			<count> = (<count> + 1)
			repeat 8
		endif
	endif
	text = qs("")
	GetControllerType controller = ($primary_controller)
	GetActiveControllers
	<is_active_controller> = (<active_controllers> [($primary_controller)])
	if (((<controller_type> != guitar) && (<controller_type> != drum)) || <is_active_controller> != 1)
		if (<practice> = 1)
			ps2_get_recording_disconnect_text \{base_string = qs("YOU ARE ROCKING OUT A BIT TOO HARD!\n\nYou must connect either a Guitar or Drum Controller to continue.")}
		else
			ps2_get_recording_disconnect_text \{base_string = qs("YOU ARE ROCKING OUT A BIT TOO HARD!\n\nYou must connect either a Guitar or Drum Controller to continue recording.")}
		endif
	else
		if (<controller_type> = guitar)
			text = (<text> + qs("Your Guitar Controller is connected!"))
		elseif (<controller_type> = drum)
			if isRBDrum controller = ($primary_controller)
				text = (<text> + qs("Your Four Pad Drum Controller is connected!"))
			else
				text = (<text> + qs("Your Guitar Hero Drum Controller is connected!"))
			endif
		endif
	endif
	if NOT (<old_text> = <text>)
		SE_SetProps {PopupBody_text = <text>}
		old_text = <text>
	endif
	Wait \{5
		gameframes}
	repeat
endscript

script ui_recording_studio_disconnect_update 
	ps2_get_recording_disconnect_text
	SE_SetProps {PopupBody_text = <text>}
endscript

script ui_recording_disconnect_continue 
	if NOT GotParam \{recording_studio}
		GetControllerType controller = ($primary_controller)
		if NOT ((<controller_type> = guitar) || (<controller_type> = drum))
			menu_scroll_end_sound
			return
		endif
	else
		GetActiveControllers
		<is_active_controller> = (<active_controllers> [($primary_controller)])
		if (<is_active_controller> != 1)
			menu_scroll_end_sound
			return
		endif
	endif
	if ui_event_exists_in_stack \{name = 'jam_tutorials'}
		generic_event_back \{state = uistate_jam_tutorials}
	else
		generic_event_back \{data = {
				editing = 1
			}}
	endif
endscript

script ui_recording_disconnect_quit 
	if ui_event_exists_in_stack \{name = 'jam_tutorials'}
		if ScreenElementExists \{id = training_container}
			DestroyScreenElement \{id = training_container}
		endif
		if ScreenElementExists \{id = jam_band_container}
			DestroyScreenElement \{id = jam_band_container}
		endif
		generic_event_back \{state = uistate_jam_tutorials}
	elseif ui_event_exists_in_stack \{name = 'jam_select_song'}
		generic_event_back \{state = UIstate_jam_select_song}
	else
		create_loading_screen
		Wait \{3
			gameframes}
		generic_event_back \{state = UIstate_mainmenu}
	endif
endscript

script ps2_get_recording_disconnect_text \{base_string = qs(0x4a46ca6d)}
	if ($primary_controller < 0)
		subtext = qs("")
	elseif ($primary_controller < 2)
		FormatText TextName = subtext qs(0x4546f57c) d = (($primary_controller) + 1)
	else
		subtext = qs(0xb294f5a0)
	endif
	FormatText TextName = text <base_string> s = <subtext>

	return text = <text>
endscript
