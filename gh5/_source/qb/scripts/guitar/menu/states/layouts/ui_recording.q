
script ui_create_recording 
	spawnscriptnow create_jam_recording_menu params = {<...>}
endscript

script ui_return_recording 
	jam_recording_refresh_user_control_helpers
endscript

script ui_destroy_recording 
	destroy_jam_recording_menu
	jam_force_kill_tutorial \{status = force_exit}
	DestroyScreenElement \{id = training_container}
endscript

script ui_deinit_recording 
	change \{select_shift = 1}
	change \{debug_show_analog_options = 1}
endscript
