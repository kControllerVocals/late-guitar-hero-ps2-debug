
script ui_create_tutorial_prompt_easy 
	switch ($current_progression_flag)
		case Career_Guitar
		text = qs("You have selected Beginner difficulty. In this difficulty you will need to strum in time for each note, but do not need to hit any fret buttons to succeed.")
		case Career_Bass
		text = qs("You have selected Beginner difficulty. In this difficulty you will need to strum in time for each note, but do not need to hit any fret buttons to succeed.")
		case Career_Drum
		text = qs("You have selected Beginner difficulty. In this difficulty you will need to hit any drum pad in time with each note, but do not need to hit any particular drum to succeed.")
		case Career_Vocals
		text = qs("You have selected Beginner difficulty. In this difficulty you only need to sing in time with the words of the song, but do not need to worry about matching the pitch.")
	endswitch
	create_dialog_box {
		heading_text = qs("Beginner Note:")
		body_text = <text>
		options = [
			{
				func = tutorial_prompt_easy_continue
				text = qs("CONTINUE")
			}
		]
		back_button_script = tutorial_prompt_easy_continue
	}
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs("SELECT")
		button = green
		z = 100000
		all_buttons}
	SetGlobalTags \{practice
		params = {
			has_prompt_easy_tutorial = complete
		}}
endscript

script ui_destroy_tutorial_prompt_easy 
	destroy_dialog_box
endscript

script tutorial_prompt_easy_continue 
	ui_event_wait \{event = menu_replace
		data = {
			state = uistate_gig_posters
		}}
endscript
