
script ui_create_options_calibrate_lag_warning 
	fadetoblack \{off
		no_wait}
	if gotparam \{dialog}
		create_calibrate_lag_dialog_menu <...>
		return
	endif
	create_calibrate_lag_warning_menu <...>
endscript

script ui_destroy_options_calibrate_lag_warning \{complete_script = nullscript}
	if ui_event_exists_in_stack \{name = 'options_calibrate_lag'}
		fadetoblack \{on
			time = 0
			alpha = 1.0
			z_priority = 100011}
	endif
	if gotparam \{dialog}

		<complete_script>
		destroy_calibrate_lag_dialog_menu <...>
		return
	endif
	destroy_calibrate_lag_warning_menu
endscript
