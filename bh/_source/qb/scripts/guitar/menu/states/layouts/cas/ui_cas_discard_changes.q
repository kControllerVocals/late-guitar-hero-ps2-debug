
script ui_create_cas_discard_changes 
	create_dialog_box \{heading_text = qs("Discard Changes?")
		body_text = qs("Would you like to discard these changes?")
		no_background
		options = [
			{
				func = discard_changes_continue
				text = qs("Yes")
			}
			{
				func = generic_event_back
				text = qs("No")
			}
		]
		back_button_script = generic_event_back}
	setup_cas_menu_handlers \{vmenu_id = dialog_box_vmenu}
endscript

script ui_destroy_cas_discard_changes 
	destroy_dialog_box
endscript

script discard_changes_continue 
	RestoreTopTemporaryCASAppearance
	generic_event_back \{data = {
			num_states = 2
		}}
endscript

script discard_changes_prompt 
	if NOT CompareTopTemporaryCASAppearance
		generic_event_choose \{data = {
				state = UIstate_cas_discard_changes
				is_popup
			}}
	else
		generic_event_back
	endif
endscript
