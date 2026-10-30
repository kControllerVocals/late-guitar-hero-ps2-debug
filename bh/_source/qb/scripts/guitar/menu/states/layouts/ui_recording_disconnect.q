
script ui_create_recording_disconnect \{practice = 0}
	if 0x8658e568
		destroy_loading_screen
	endif
	if (<practice> = 1)
		options = [
			{
				func = ui_recording_disconnect_quit
				func_params = {<...>}
				text = qs(0x67d9c56d)
				sound_func = nullscript
			}
		]
	elseif gotparam \{recording_studio}
		options = [
			{
				func = ui_recording_disconnect_continue
				func_params = {<...>}
				text = qs(0x0e41fe46)
				sound_func = nullscript
			}
		]
	else
		options = [
			{
				func = ui_recording_disconnect_continue
				func_params = {<...>}
				text = qs(0x182f0173)
				sound_func = nullscript
			}
			{
				func = ui_recording_disconnect_quit
				text = qs(0x67d9c56d)
				sound_func = nullscript
			}
		]
	endif
	create_dialog_box {
		heading_text = qs(0xaa163738)
		body_text = qs(0x00000000)
		options = <options>
		player_device = ($primary_controller)
	}
	dialog_box_desc_id :settags \{is_disconnect_warning = true}
	if (<practice> = 1)
		killspawnedscript \{id = jam_tutorial_topic_spawn}
		killspawnedscript \{id = jam_tutorial_spawns}
		training_destroy_narrator_icons
		change \{jam_tutorial_status = inactive}
	endif
	if gotparam \{recording_studio}
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
	0x807481eb
endscript

script ui_recording_disconnect_update \{practice = 0}
	old_text = qs(0x52122f6e)
	getactivecontrollers
	<0xf147d880> = [0 0 0 0 0 0 0 0]
	if (($primary_controller) > 1)
		count = 0
		begin
		setarrayelement arrayname = 0xf147d880 index = <count> newvalue = (<active_controllers> [<count>])
		<count> = (<count> + 1)
		repeat 8
	endif
	begin
	getactivecontrollers
	if ((<active_controllers> [($primary_controller)]) = 0)
		if (($primary_controller) > 1)
			count = 0
			begin
			if (<count> > 1)
				if (<0xf147d880> [<count>] = 0)
					if (<active_controllers> [<count>] = 1)
						ui_recording_disconnect_continue
						set_primary_controller device_num = <count> state = uistate_recording_disconnect
					endif
				endif
			endif
			setarrayelement arrayname = 0xf147d880 index = <count> newvalue = (<active_controllers> [<count>])
			<count> = (<count> + 1)
			repeat 8
		endif
	endif
	text = qs(0x00000000)
	getcontrollertype controller = ($primary_controller)
	getactivecontrollers
	<is_active_controller> = (<active_controllers> [($primary_controller)])
	if (((<controller_type> != guitar) && (<controller_type> != drum)) || <is_active_controller> != 1)
		if (<practice> = 1)
			0x74199ba6 \{0x0921d53f = qs(0x89985c62)}
		else
			0x74199ba6 \{0x0921d53f = qs(0x50744810)}
		endif
	else
		if (<controller_type> = guitar)
			text = (<text> + qs(0x6bb8afcf))
		elseif (<controller_type> = drum)
			if isrbdrum controller = ($primary_controller)
				text = (<text> + qs(0x764e9343))
			else
				text = (<text> + qs(0x16da69a0))
			endif
		endif
	endif
	if NOT (<old_text> = <text>)
		se_setprops {popupbody_text = <text>}
		old_text = <text>
	endif
	wait \{5
		gameframes}
	repeat
endscript

script ui_recording_studio_disconnect_update 
	0x74199ba6
	se_setprops {popupbody_text = <text>}
endscript

script ui_recording_disconnect_continue 
	if NOT gotparam \{recording_studio}
		getcontrollertype controller = ($primary_controller)
		if NOT ((<controller_type> = guitar) || (<controller_type> = drum))
			menu_scroll_end_sound
			return
		endif
	else
		getactivecontrollers
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
		if screenelementexists \{id = training_container}
			destroyscreenelement \{id = training_container}
		endif
		if screenelementexists \{id = jam_band_container}
			destroyscreenelement \{id = jam_band_container}
		endif
		generic_event_back \{state = uistate_jam_tutorials}
	elseif ui_event_exists_in_stack \{name = 'jam_select_song'}
		generic_event_back \{state = uistate_jam_select_song}
	else
		create_loading_screen
		wait \{3
			gameframes}
		generic_event_back \{state = uistate_mainmenu}
	endif
endscript

script 0x74199ba6 \{0x0921d53f = qs(0x4a46ca6d)}
	if ($primary_controller < 0)
		subtext = qs(0x00000000)
	elseif ($primary_controller < 2)
		formattext textname = subtext qs(0x4546f57c) d = (($primary_controller) + 1)
	else
		subtext = qs(0xb294f5a0)
	endif
	formattext textname = text <0x0921d53f> s = <subtext>

	return text = <text>
endscript
