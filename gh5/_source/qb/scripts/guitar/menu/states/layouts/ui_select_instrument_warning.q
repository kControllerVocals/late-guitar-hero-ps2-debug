
script ui_create_select_instrument_warning controller = ($primary_controller)
	set_focus_color
	set_unfocus_color
	switch (<instrument>)
		case guitar
		case Bass
		text = qs("You must use a Guitar Controller to continue.")
		case drum
		text = qs("You must use a Drum Controller to continue.")
		case Vocals
		if isXenon
			text = qs("You must connect a microphone or Xbox 360 Headset to continue.")
		else
			text = qs("You must plug in a microphone with your controller to continue.")
		endif
	endswitch
	create_dialog_box {
		body_text = <text>
		options = [
			{
				func = generic_event_back
				text = qs("GO BACK")
			}
			{
				func = generic_event_back
				func_params = {state = UIstate_mainmenu}
				text = qs("RETURN TO MAIN MENU")
			}
		]
	}
endscript

script ui_destroy_select_instrument_warning 
	destroy_dialog_box
	set_unfocus_color \{rgba = [
			255
			255
			255
			255
		]}
	set_focus_color \{rgba = [
			0
			0
			0
			255
		]}
endscript
