
script ui_create_practice_select_part \{rhythm_track = 0}
	change menu_flow_locked = ($menu_flow_locked + 1)
	destroy_loading_screen
	ui_get_controller_parts_allowed controller = ($primary_controller)
	make_menu_frontend \{title = qs("INSTRUMENT")}
	GMan_SongTool_GetCurrentSong
	get_song_rhythm_track song = <current_song>
	<parts> = [
		{text = qs("GUITAR")
			rhythm_text = qs("LEAD")
			id = cpp_guitar
			part = guitar
		}
		{text = qs("BASS")
			rhythm_text = qs("RHYTHM")
			id = cpp_bass
			part = Bass
		}
		{text = qs("DRUMS")
			id = cpp_drum
			part = drum
		}
		{text = qs("VOCALS")
			id = cpp_vocals
			part = Vocals
		}
	]
	<num_not_focusable> = 0
	GetArraySize <parts>
	<i> = 0
	begin
	<part_struct> = (<parts> [<i>])
	focus = {}
	if NOT StructureContains Structure = <allowed> (<part_struct>.part)
		focus = {not_focusable}
		<num_not_focusable> = (<num_not_focusable> + 1)
	endif
	if (<rhythm_track> = 1)
		<part_text> = (<part_struct>.rhythm_text)
	else
		<part_text> = (<part_struct>.text)
	endif
	add_menu_frontend_item {
		text = <part_text>
		pad_choose_script = ui_practice_select_part
		pad_choose_params = {part = (<part_struct>.part)}
		<focus>
	}
	i = (<i> + 1)
	repeat <array_size>
	menu_finish
	if (<num_not_focusable> = 4)
		if isXenon
			warning_text = qs("You must connect a microphone or Xbox 360 Headset to continue.")
		else
			warning_text = qs("You must plug in a microphone with your controller to continue.")
		endif
		create_dialog_box {
			body_text = <warning_text>
			player_device = ($primary_controller)
			options = [
				{
					func = generic_event_back
					text = qs("GO BACK")
					no_sound
				}
			]
			no_background
		}
	endif
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_practice_select_part 
	change menu_flow_locked = ($menu_flow_locked + 1)
	if ScreenElementExists \{id = dialog_box_container}
		destroy_dialog_box
	endif
	generic_ui_destroy
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_deinit_practice_select_part 
	change \{practice_enabled = 0}
endscript

script ui_practice_select_part 
	ui_get_controller_parts_allowed controller = ($primary_controller)
	if NOT StructureContains Structure = <allowed> <part>
		generic_event_choose state = uistate_select_instrument_warning data = {instrument = <part> controller = ($primary_controller)}
	endif
	change structurename = player1_status part = <part>
	vocals_distribute_mics
	set_song_section_array \{player = 1}
	generic_event_choose \{state = uistate_practice_select_difficulty}
endscript
