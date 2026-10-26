
script ui_create_save_changes_dialogue 
	prompt_for_save_or_confirm = save
	cas_get_player_status
	if isXenon
		if NetSessionFunc func = XenonIsGuest params = {controller_index = ($<player_status>.controller)}
			prompt_for_save_or_confirm = confirm
		endif
		if NOT CheckForSignIn local controller_index = ($<player_status>.controller)
			prompt_for_save_or_confirm = confirm
		endif
	endif
	GetGlobalTags \{user_options}
	if (<autosave> = 0)
		prompt_for_save_or_confirm = confirm
	endif
	switch <prompt_for_save_or_confirm>
		case save
		confirm_title_text = qs("Save Changes?")
		confirm_option_text = qs("SAVE")
		confirm_func = exit_save_changes
		confirm_dialog_text = qs("Do you want to save the changes made to your appearance? Selecting DISCARD will cause all unsaved appearance changes to be lost.")
		case confirm
		confirm_title_text = qs("Retain Changes?")
		confirm_option_text = qs("RETAIN")
		confirm_func = exit_skip_save
		confirm_dialog_text = qs("Do you want to retain the changes made to your appearance? Selecting DISCARD will cause all unsaved appearance changes to be lost.")
	endswitch
	create_dialog_box {
		heading_text = <confirm_title_text>
		body_text = <confirm_dialog_text>
		no_barrel
		no_background
		options = [
			{
				func = <confirm_func>
				text = <confirm_option_text>
			}
			{
				func = exit_discard_changes
				text = qs("DISCARD")
			}
			{
				func = generic_event_back
				text = qs("CANCEL")
			}
		]
		back_button_script = generic_event_back
	}
	if NOT (($menu_over_ride_exclusive_device) = -1)
		controller = ($menu_over_ride_exclusive_device)
	endif
	generic_barrel_menu :SE_SetProps \{pos = (510.0, 338.0)}
endscript

script ui_destroy_save_changes_dialogue 
	destroy_dialog_box
endscript

script exit_save_changes 
	DestroyScreenElement \{id = dialog_box_vmenu
		preserve_parent}
	if is_completely_custom_musician id = ($cas_current_profile) savegame = ($cas_current_savegame)
		cas_save_photo_of_car character_name = ($cas_current_profile) savegame = ($cas_current_savegame) readytorock = <readytorock>
	endif
	destroy_dialog_box
	clean_up_menu_history_screen_elements
	GetCASAppearance
	modify_custom_profile_appearance id = ($cas_current_profile) appearance = <appearance> savegame = ($cas_current_savegame)
	modify_custom_profile_fullname id = ($cas_current_profile) fullname = ($cas_current_fullname) savegame = ($cas_current_savegame)
	cas_get_player_status
	change structurename = <player_status> character_id = ($cas_current_profile)
	if is_from_singleplayer_hub
		SetGlobalTags savegame = ($cas_current_savegame) last_singleplayer_character params = {last_singleplayer_character = ($cas_current_profile)}
	endif
	if ($Achievements_creating_character = 1)
		Achievements_DISPOSABLE_HEROES controller = ($primary_controller)
	endif
	if ($cas_from_main_menu = 1)
		cas_destroy_all_characters
	endif
	ui_event_get_stack
	data = {savegame = ($cas_current_savegame) requested_autosave = 1}
	autosave_type = ui_memcard_autosave_replace
	if GotParam \{not_replace}
		autosave_type = ui_memcard_autosave
	endif
	data = {<data> need_loading_screen}
	get_frontend_venue_player_start_checksums
	i = 0
	begin
	if ((<stack> [<i>].base_name) = 'character_hub')
		cas_set_object_node_pos player = ($cas_current_player) node = <player1_start>
		if NOT current_band_has_band_name
			<autosave_type> event = menu_replace data = {state = uistate_band_name_logo event_params = {event = menu_back data = {state = uistate_character_hub <data>}} from_save = 1 controller = $primary_controller}
			return
		endif
		<autosave_type> event = menu_back state = uistate_character_hub data = <data>
		return
	elseif ((<stack> [<i>].base_name) = 'singleplayer_character_hub')
		cas_set_object_node_pos player = ($cas_current_player) node = <player1_start>
		if NOT current_band_has_band_name
			<autosave_type> event = menu_replace data = {state = uistate_band_name_logo event_params = {event = menu_back data = {state = UIstate_singleplayer_character_hub <data>}} from_save = 1 controller = $primary_controller}
			return
		endif
		<autosave_type> event = menu_back state = UIstate_singleplayer_character_hub data = <data>
		return
	elseif ((<stack> [<i>].base_name) = 'band_mode')
		<autosave_type> event = menu_back state = UIstate_band_mode data = <data>
		return
	endif
	i = (<i> + 1)
	repeat <stack_size>

	<autosave_type> event = menu_back state = uistate_character_selection data = <data>
endscript

script exit_discard_changes 
	destroy_dialog_box
	clean_up_menu_history_screen_elements
	cas_get_player_status
	if (($cas_editing_new_character) = true)
		cas_destroy_all_characters
		delete_custom_profile id = ($cas_current_profile) savegame = ($cas_current_savegame)
		cas_get_player_status
		if NOT get_musician_profile_struct_by_id dont_assert id = ($charselect_previous_character_id) savegame = ($cas_current_savegame)
			change structurename = <player_status> character_id = axel
		else
			change structurename = <player_status> character_id = ($charselect_previous_character_id)
		endif
	else
		if GotParam \{no_changes}
			if ($cas_from_main_menu = 1)
				cas_destroy_all_characters
			endif
		else
			cas_destroy_all_characters
			if ($cas_from_main_menu = 0)
				cas_queue_new_character_profile id = ($charselect_previous_character_id) player = ($cas_current_player) savegame = ($cas_current_savegame) force_update = 1 hide_old_character = 1
			endif
		endif
		change structurename = <player_status> character_id = ($charselect_previous_character_id)
	endif
	ui_event_get_stack
	get_frontend_venue_player_start_checksums
	i = 0
	begin
	if ((<stack> [<i>].base_name) = 'character_hub')
		cas_set_object_node_pos player = ($cas_current_player) node = <player1_start>
		generic_event_back \{state = uistate_character_hub}
		return
	elseif ((<stack> [<i>].base_name) = 'singleplayer_character_hub')
		cas_set_object_node_pos player = ($cas_current_player) node = <player1_start>
		generic_event_back \{state = UIstate_singleplayer_character_hub}
		return
	elseif ((<stack> [<i>].base_name) = 'band_mode')
		generic_event_back \{state = UIstate_band_mode}
		return
	endif
	i = (<i> + 1)
	repeat <stack_size>

	generic_event_back \{state = uistate_character_selection}
endscript

script exit_skip_save 
	DestroyScreenElement \{id = dialog_box_vmenu
		preserve_parent}
	if is_completely_custom_musician id = ($cas_current_profile) savegame = ($cas_current_savegame)
		cas_save_photo_of_car character_name = ($cas_current_profile) savegame = ($cas_current_savegame) readytorock = <readytorock>
	endif
	destroy_dialog_box
	clean_up_menu_history_screen_elements
	GetCASAppearance
	modify_custom_profile_appearance id = ($cas_current_profile) appearance = <appearance> savegame = ($cas_current_savegame)
	modify_custom_profile_fullname id = ($cas_current_profile) fullname = ($cas_current_fullname) savegame = ($cas_current_savegame)
	cas_get_player_status
	change structurename = <player_status> character_id = ($cas_current_profile)
	if is_from_singleplayer_hub
		SetGlobalTags savegame = ($cas_current_savegame) last_singleplayer_character params = {last_singleplayer_character = ($cas_current_profile)}
	endif
	if ($cas_from_main_menu = 1)
		cas_destroy_all_characters
	endif
	ui_event_get_stack
	get_frontend_venue_player_start_checksums
	i = 0
	begin
	if ((<stack> [<i>].base_name) = 'character_hub')
		cas_set_object_node_pos player = ($cas_current_player) node = <player1_start>
		generic_event_back \{state = uistate_character_hub}
		return
	elseif ((<stack> [<i>].base_name) = 'singleplayer_character_hub')
		cas_set_object_node_pos player = ($cas_current_player) node = <player1_start>
		generic_event_back \{state = UIstate_singleplayer_character_hub}
		return
	elseif ((<stack> [<i>].base_name) = 'band_mode')
		generic_event_back \{state = UIstate_band_mode}
		return
	endif
	i = (<i> + 1)
	repeat <stack_size>
	generic_event_back \{state = uistate_character_selection}
endscript
