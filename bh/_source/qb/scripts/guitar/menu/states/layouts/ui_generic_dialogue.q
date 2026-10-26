
script ui_create_generic_dialogue \{choose_yes_func = nullscript
		choose_no_func = generic_event_back}
	create_dialog_box {
		heading_text = <title>
		body_text = <text>
		options = [
			{
				func = <choose_no_func>
				func_params = <choose_no_params>
				text = qs("No")
			}
			{
				func = <choose_yes_func>
				func_params = <choose_yes_params>
				text = qs("Yes")
			}
		]
		back_button_script = generic_event_back
	}
	clean_up_user_control_helpers
	if GotParam \{highlight_no}
		LaunchEvent \{type = unfocus
			target = dialog_box_vmenu}
		LaunchEvent \{type = focus
			target = dialog_box_vmenu
			data = {
				child_index = 0
			}}
	endif
	add_user_control_helper \{text = qs("SELECT")
		button = green
		z = 100000
		all_buttons}
	add_user_control_helper \{text = qs("BACK")
		button = red
		z = 100000}
	SoundEvent \{Generic_Menu_Select_SFX}
endscript

script ui_destroy_generic_dialogue 
	destroy_dialog_box
endscript
