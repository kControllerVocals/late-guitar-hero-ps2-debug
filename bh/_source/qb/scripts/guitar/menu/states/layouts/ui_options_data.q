
script ui_create_options_data 
	change \{ui_options_from_submenu = 1}
	0x2ea532a9 \{pad_back_script = ui_options_check_settings
		pad_back_params = {
			no_loading_screen
		}}
	0x9d0992fe \{parent = current_submenu
		0x6d96b274
		text = qs(0x5d22cc45)
		0x656de5f8
		pad_choose_script = generic_event_replace
		pad_choose_params = {
			state = uistate_memcard
			data = {
				type = save
			}
		}}
	0x9d0992fe \{parent = current_submenu
		0x6d96b274
		text = qs(0x3da6185d)
		0x656de5f8
		pad_choose_script = generic_event_replace
		pad_choose_params = {
			state = uistate_memcard
			data = {
				type = load
			}
		}}
	0x9d0992fe \{parent = current_submenu
		0x6d96b274
		text = qs(0x75792198)
		0x656de5f8
		pad_choose_script = generic_event_replace
		pad_choose_params = {
			state = uistate_options_data_delete
		}}
	0x9d0992fe \{parent = current_submenu
		0x6d96b274
		text = qs(0x1cf38dbd)
		0xc1f386b6
		pad_choose_script = ui_options_data_toggle_autosave
		pad_choose_params = {
			state = uistate_options_data_delete
		}}
	getglobaltags \{user_options}
	if (<autosave> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :se_setprops {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	ui_options_set_settings
endscript

script ui_destroy_options_data 
	0x7f9ab085
endscript

script ui_options_data_toggle_autosave \{time = 0.075}
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	gettags
	obj_getid
	getglobaltags \{user_options}
	if (<autosave> = 1)
		soundevent \{event = box_uncheck_sfx}
		<autosave> = 0
		<objid> :se_setprops check_alpha = 0
		<objid> :se_setprops cross_alpha = 1
	else
		soundevent \{event = box_check_sfx}
		<autosave> = 1
		<objid> :se_setprops check_alpha = 1
		<objid> :se_setprops cross_alpha = 0
	endif
	setglobaltags user_options params = {autosave = <autosave>}
endscript
