
script ui_create_options_data_delete 
	if NOT GotParam \{really}
		create_dialog_box \{body_text = qs("Are you sure you want to reset your progress and overwrite your current save??")
			options = [
				{
					func = generic_event_back
					text = qs("CANCEL")
				}
				{
					func = generic_event_replace
					func_params = {
						state = uistate_options_data_delete
						data = {
							really = 1
						}
					}
					text = qs("I'M SURE")
				}
			]}
	elseif NOT GotParam \{confirm}
		create_dialog_box \{body_text = qs("Are you really sure you want to reset your progress and overwrite your current save?  All career progress, cash earned, items unlocked, rock stars created, etc. will be lost!")
			options = [
				{
					func = generic_event_back
					text = qs("CANCEL")
				}
				{
					func = generic_event_replace
					func_params = {
						state = uistate_options_data_delete
						data = {
							really = 1
							confirm = 1
						}
					}
					text = qs("I'M REALLY SURE")
				}
			]}
	else
		spawnscriptnow \{ui_options_data_delete}
		Menu_Music_Off
	endif
endscript

script ui_destroy_options_data_delete 
	destroy_dialog_box
endscript

script ui_options_data_delete 
	create_dialog_box \{body_text = qs(0xbddbef0d)}
	Wait \{1
		second}
	get_savegame_from_controller controller = ($primary_controller)
	GetGlobalTags \{user_options
		params = {
			autosave
		}}
	reset_globaltags savegame = <savegame>
	SetGlobalTags \{user_options
		params = {
			autosave = 1
		}}
	ui_event_wait_for_safe
	ui_memcard_autosave \{event = menu_change
		state = UIstate_boot_iis
		data = {
			clear_previous_stack
		}}
endscript
