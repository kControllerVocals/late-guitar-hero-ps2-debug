
script ui_create_options_data 
	change \{ui_options_from_submenu = 1}
	make_generic_stripe_submenu \{pad_back_script = ui_options_check_settings
		pad_back_params = {
			no_loading_screen
		}}
	add_generic_stripe_menu_item \{parent = current_submenu
		option_left
		text = qs("SAVE GAME")
		option_texture
		pad_choose_script = generic_event_replace
		pad_choose_params = {
			state = uistate_memcard
			data = {
				type = save
			}
		}}
	add_generic_stripe_menu_item \{parent = current_submenu
		option_left
		text = qs("LOAD GAME")
		option_texture
		pad_choose_script = generic_event_replace
		pad_choose_params = {
			state = uistate_memcard
			data = {
				type = load
			}
		}}
	add_generic_stripe_menu_item \{parent = current_submenu
		option_left
		text = qs("RESET PROGRESS")
		option_texture
		pad_choose_script = generic_event_replace
		pad_choose_params = {
			state = uistate_options_data_delete
		}}
	add_generic_stripe_menu_item \{parent = current_submenu
		option_left
		text = qs("AUTOSAVE")
		option_checkbox
		pad_choose_script = ui_options_data_toggle_autosave
		pad_choose_params = {
			state = uistate_options_data_delete
		}}
	GetGlobalTags \{user_options}
	if (<autosave> = 1)
		<check_alpha> = 1
		<cross_alpha> = 0
	else
		<check_alpha> = 0
		<cross_alpha> = 1
	endif
	<item_id> :SE_SetProps {
		check_alpha = <check_alpha>
		cross_alpha = <cross_alpha>
	}
	ui_options_set_settings
endscript

script ui_destroy_options_data 
	destroy_generic_stripe_submenu
endscript

script ui_options_data_toggle_autosave \{time = 0.075}
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	GetTags
	Obj_GetID
	GetGlobalTags \{user_options}
	if (<autosave> = 1)
		SoundEvent \{event = Box_UnCheck_SFX}
		<autosave> = 0
		<ObjID> :SE_SetProps check_alpha = 0
		<ObjID> :SE_SetProps cross_alpha = 1
	else
		SoundEvent \{event = Box_Check_SFX}
		<autosave> = 1
		<ObjID> :SE_SetProps check_alpha = 1
		<ObjID> :SE_SetProps cross_alpha = 0
	endif
	SetGlobalTags user_options params = {autosave = <autosave>}
endscript
