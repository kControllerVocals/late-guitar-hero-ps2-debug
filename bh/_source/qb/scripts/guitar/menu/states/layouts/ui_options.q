ui_options_from_submenu = 0

script ui_create_options 
	startrendering
	change \{rich_presence_context = presence_menus}
	change \{respond_to_signin_changed = 1}
	change \{respond_to_signin_changed_func = none}
	change \{top_rockers_enabled = 0}
	change \{memcard_after_func = none}
	update_ingame_controllers controller = ($primary_controller)
	make_generic_stripe_menu \{title = qs("OPTIONS")
		option_arrows}
	add_generic_stripe_menu_item \{text = qs("CHEATS")
		choose_state = uistate_options_cheats}
	if NOT current_band_has_band_name
		add_generic_stripe_menu_item \{text = qs("BAND INFO")
			pad_choose_script = nullscript
			pad_choose_sound = ui_bonus_videos_negative_sfx
			focus_rgba = [
				160
				150
				140
				175
			]
			unfocus_rgba = [
				160
				150
				140
				175
			]}
	else
		add_generic_stripe_menu_item {
			text = qs("BAND INFO")
			pad_choose_script = menu_choose_band_make_selection
			pad_choose_params = {from_options = 1 device_num = ($primary_controller) event_params = {event = menu_back}}
		}
	endif
	add_generic_stripe_menu_item \{text = qs("SAVE/LOAD")
		pad_choose_script = ui_options_continue_to_data_submenu
		pad_choose_params = {
			is_popup
		}}
	add_generic_stripe_menu_item \{text = qs("CALIBRATE LAG")
		choose_state = UIstate_options_calibrate_lag}
	add_generic_stripe_menu_item \{text = qs("AUDIO MIXER")
		choose_state = uistate_options_audio}
	add_generic_stripe_menu_item \{text = qs("FUNCTIONAL OPTIONS")
		pad_choose_script = ui_options_continue_to_settings_submenu
		pad_choose_params = {
			is_popup
		}}
	add_generic_stripe_menu_item \{text = qs("VIDEOS")
		choose_state = uistate_bonus_videos}
	if GetScreenElementChildren \{id = current_menu}
		GetArraySize <children>
		i = 0
		begin
		curr_id = (<children> [<i>])
		<curr_id> :SE_SetProps {
			tags = {index = <i>}
		}
		i = (<i> + 1)
		repeat <array_size>
	endif
	clean_up_user_control_helpers
	menu_finish
endscript

script ui_return_options 
	clean_up_user_control_helpers
	menu_finish
endscript

script ui_options_anim_in 
	if NOT ($ui_options_from_submenu)
		menu_transition_in \{menu = current_menu_anchor}
	else
		change \{ui_options_from_submenu = 0}
	endif
	current_menu_anchor :SE_SetProps \{highlight_alpha = 1}
	current_menu :obj_spawnscript \{highlight_motion}
endscript

script ui_options_anim_out 
	menu_transition_out \{menu = current_menu_anchor}
endscript

script ui_destroy_options 
	if ScreenElementExists \{id = current_menu_anchor}
		DestroyScreenElement \{id = current_menu_anchor}
	endif
endscript

script ui_options_get_controller_type controller = ($primary_controller)
	type = guitar
	text = qs("GUITAR")
	if NOT IsGuitarController controller = <controller>
		type = Drums
		text = qs("DRUM")
		if NOT IsDrumController controller = <controller>
			type = Vocals
			text = qs("VOCAL")
		endif
	endif
	return {type = <type> text = <text>}
endscript

script ui_options_set_settings 
	if ScreenElementExists \{id = current_menu}
		GetGlobalTags \{user_options}
		current_menu :SetTags {user_options = <...>}
	endif
endscript

script ui_options_check_settings 
	RemoveParameter \{event}
	RemoveParameter \{controller}
	if NOT ($playing_song)
		RemoveParameter \{device_num}
		if ScreenElementExists \{id = current_menu}
			GetGlobalTags \{user_options}
			new_user_options = <...>
			current_menu :GetSingleTag \{user_options}
			if GotParam \{user_options}
				if GotParam \{no_loading_screen}
					RemoveParameter \{no_loading_screen
						struct_name = new_user_options}
				endif
				if NOT CompareStructs struct1 = <new_user_options> struct2 = <user_options>
					generic_menu_pad_back_sound
					spawnscriptnow \{ui_memcard_autosave_replace}
					return
				endif
			endif
		endif
	endif
	generic_event_back
endscript

script ui_options_continue_to_settings_submenu 
	if Is_ui_event_running
		return \{false}
	endif
	ui_event_block event = menu_change data = {state = uistate_options_settings <...>}
endscript

script ui_options_continue_to_data_submenu 
	if Is_ui_event_running
		return \{false}
	endif
	ui_event_block event = menu_change data = {state = uistate_options_data <...>}
endscript
