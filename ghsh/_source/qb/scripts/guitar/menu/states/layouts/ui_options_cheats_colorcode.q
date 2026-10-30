
script ui_create_options_cheats_colorcode 

	createscreenelement \{parent = root_window
		id = ntsc_colorscreen
		type = containerelement
		just = [
			left
			top
		]
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		event_handlers = [
			{
				pad_choose
				generic_event_back
				state = uistate_options_cheats
			}
			{
				pad_back
				generic_event_back
				state = uistate_options_cheats
			}
			{
				pad_option
				generic_event_back
				state = uistate_options_cheats
			}
			{
				pad_option2
				generic_event_back
				state = uistate_options_cheats
			}
		]}
	createscreenelement \{parent = ntsc_colorscreen
		id = ntsc_colorscreen_img
		type = spriteelement
		texture = ntsc_colorscreen
		just = [
			left
			top
		]
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)}
	launchevent \{type = focus
		target = ntsc_colorscreen}
	clean_up_user_control_helpers
endscript

script qwertyuiopf 

endscript

script ui_destroy_options_cheats_colorcode 
	destroyscreenelement \{id = ntsc_colorscreen}

endscript

script ui_options_cheats_colorcode_back 

endscript
