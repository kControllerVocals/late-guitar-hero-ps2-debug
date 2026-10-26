
script ui_init_setlist_quit_warning 
	pause_songpreview
endscript

script ui_deinit_setlist_quit_warning 
	unpause_songpreview
endscript

script ui_create_setlist_quit_warning 
	SetlistInterface :obj_spawnscript \{setlist_controller_response
		params = {
			in_setlist_quit_warning
		}}
	GameMode_GetType
	if (<type> = pro_faceoff)
		body_text = qs(0x22e09b86)
	else
		body_text = qs("Are you sure you want to exit the set list? Any songs you have selected will be reset.")
	endif
	create_dialog_box {
		body_text = <body_text>
		use_all_controllers
		options = [
			{
				func = setlist_quit_warning_select_no
				text = qs("CANCEL")
			}
			{
				func = setlist_quit_warning_select_yes
				text = qs("EXIT")
			}
		]
	}
endscript

script ui_destroy_setlist_quit_warning 
	KillSpawnedScript \{name = setlist_controller_response}
	destroy_dialog_box
endscript

script setlist_quit_warning_select_no 
	ui_setlist_go_back
endscript

script setlist_quit_warning_select_yes 
	GameMode_GetType
	if (<type> = pro_faceoff)
		ui_setlist_go_back \{num_states = 4}
	else
		ui_setlist_go_back \{num_states = 2}
	endif
endscript
