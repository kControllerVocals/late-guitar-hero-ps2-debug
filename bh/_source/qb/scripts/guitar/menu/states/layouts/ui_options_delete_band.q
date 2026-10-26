
script ui_create_options_delete_band 
	text = [
		qs("You are about to permanently delete the selected band. ")
		qs("All progress associated with that band will be lost. ")
		qs("Are you sure you want to continue?")
	]
	create_dialog_box {
		body_text = <text>
		back_button_script = generic_event_back
		options = [
			{
				func = menu_confirm_band_delete_select_yes
				text = qs("DELETE")
			}
			{
				func = generic_event_back
				text = qs("CANCEL")
			}
		]
	}
endscript

script ui_destroy_options_delete_band 
	destroy_dialog_box
endscript
