
script ui_create_null \{object = 1}
	if CD
		if NOT GotParam \{initing}
			if ScreenElementExists \{id = root_window}
				if (<object> = 1)
					spawnscriptnow \{ui_null_warning_spawned}
				endif
			endif
		endif
	endif
	ui_event_remove_params \{param = initing}
endscript

script ui_destroy_null 
	if CD
		if ScreenElementExists \{id = root_window}
			KillSpawnedScript \{name = ui_null_warning_spawned}
			destroy_dialog_box
		endif
	endif
endscript

script ui_null_warning_spawned 
	Wait \{5
		seconds}
	create_dialog_box \{body_text = qs("\Luistate_null entered. This usually implies menu_back was called on a state that didn't exist in the current stack.")
		options = [
			{
				func = generic_event_choose
				func_params = {
					state = UIstate_mainmenu
					data = {
						clear_previous_stack
					}
				}
				text = qs("\LReturn to main menu")
			}
		]
		use_all_controllers}
endscript
