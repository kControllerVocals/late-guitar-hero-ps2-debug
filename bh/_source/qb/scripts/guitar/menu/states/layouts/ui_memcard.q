ps3_autosave_warning_shown = 0
memcard_state_active = 0

script ui_init_memcard 
	memcard_controller_reset
	if (<type> = autosave)
		if GotParam \{event_params}
			if StructureContains Structure = <event_params> data
				if StructureContains Structure = (<event_params>.data) requested_autosave
					requested_autosave = (<event_params>.data.requested_autosave)
				endif
			endif
		endif
		stars
		if IsPs3

			memcard_controller_add controller = ($primary_controller) requested_autosave = <requested_autosave>
		else
			if GotParam \{event_params}
				if StructureContains Structure = <event_params> data
					if StructureContains Structure = (<event_params>.data) savegame

						memcard_controller_add controller = ((<event_params>.data).savegame) requested_autosave = <requested_autosave>
						done_something = 1
					elseif StructureContains Structure = (<event_params>.data) all_active_players
						memcard_controller_add_signed_in_and_valid
						done_something = 1
					endif
				endif
			endif
			if NOT GotParam \{done_something}

				memcard_controller_add controller = ($primary_controller)
			endif
		endif
		stars
	endif
endscript
memcard_after_func = none

script ui_create_memcard \{event_params = {
			event = menu_back
		}}
	spawnscriptnow ui_create_memcard_spawned params = {<...>}
endscript

script ui_create_memcard_spawned 
	ui_print_states

	change \{memcard_state_active = 1}
	if ($is_network_game = 1)
		original_type = <type>
		GameMode_GetType
		if (<type> = career)
			spawn_player_drop_listeners \{drop_player_script = net_career_memcard_drop_player
				end_game_script = net_career_memcard_end_game}
		endif
		type = <original_type>
	endif
	startrendering
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = current_menu
		pos = (0.0, 0.0)
		just = [left center]
		z_priority = 0
		tags = {
			type = <type>
			event_params = <event_params>
			signin_changed = ($respond_to_signin_changed)
		}
	}
	change \{respond_to_signin_changed = 1}
	finished_with_ui_stack = 0
	switch <type>
		case boot
		call = memcard_sequence_begin_bootup
		StorageSelectorForce = 1
		case autosave
		call = memcard_sequence_begin_autosave
		requested_autosave = 0
		if GotParam \{event_params}
			if StructureContains \{Structure = event_params
					data}
				requested_autosave = (<event_params>.data.requested_autosave)
			endif
		endif
		case autoload
		call = memcard_sequence_begin_autoload
		case save
		call = memcard_sequence_begin_save
		case load
		call = memcard_sequence_begin_load
		case save_jam
		call = memcard_sequence_begin_save_jam
		case load_jam
		call = memcard_sequence_begin_load_jam
		case delete_jam
		call = memcard_sequence_begin_delete_jam
		case rename_jam
		call = memcard_sequence_begin_rename_jam
		case secondary_signin_load

		call = memcard_sequence_begin_ss_load
		default

	endswitch
	if (<type> = autosave)
		if NOT memcard_controller_get_next
			if StructureContains Structure = <event_params> data
				if StructureContains Structure = (<event_params>.data) need_loading_screen
					ui_event_wait <event_params>
					return
				endif
				if StructureContains Structure = (<event_params>.data) force_memcard_after_func
					if ($memcard_after_func != none)
						spawnscriptnow ($memcard_after_func) params = {success}
						change \{memcard_after_func = none}
					endif
				endif
			endif
			hide_glitch \{num_frames = 4}
			if (<finished_with_ui_stack> = 0)
				ui_memcard_finish <...> success
			else
				ui_memcard_finish <...> success already_cleared_ui_stack
			endif
			return
		endif
	endif
	if isXenon
		if NetSessionFunc func = XenonIsGuest params = {controller_index = <controller>}

			ui_event_wait <event_params>
			return
		endif
		if NOT CheckForSignIn local controller_index = <controller>

			ui_event_wait <event_params>
			return
		endif
	endif
	if IsPs3
		if is_autosave_on \{savegame = 0}
			if ($ps3_autosave_warning_shown = 0)
				change \{ps3_autosave_warning_shown = 1}
				do_ps3_memcard_warning func = <call> func_params = <...>
				return
			endif
		endif
	endif
	<call> <...>
endscript

script ui_destroy_memcard 
	if ScreenElementExists \{id = current_menu}
		current_menu :Die
	endif
	clean_up_user_control_helpers
	spawnscriptnow \{memcard_sequence_cleanup_generic}
	change \{memcard_state_active = 0}
endscript

script ui_deinit_memcard 
	ui_options_audio_set_dolby_digital
	update_all_volumes
	refresh_autokick_cheat
endscript

script ui_memcard_finish 
	if GotParam \{need_loading_screen}
		set_loading_screen \{full}
	elseif GotParam \{event_params}
		if StructureContains Structure = <event_params> data
			if StructureContains Structure = (<event_params>.data) need_loading_screen
				set_loading_screen \{full}
			endif
		endif
	endif
	ui_event_get_stack
	if ($shutdown_game_for_signin_change_flag = 1)
		return
	endif
	current_menu :GetTags
	if NOT (<type> = boot)
		change respond_to_signin_changed = <signin_changed>
	endif
	if (<type> = autosave)
		if memcard_controller_has_next
			MC_WaitAsyncOpsFinished
			memcard_cleanup_messages
			if ScreenElementExists \{id = current_menu}
				current_menu :Die
			endif
			ui_create_memcard {
				controller = <controller>
				type = <type>
				event_params = <event_params>
			}
			return
		endif
	endif
	if GotParam \{success}
		if NOT current_band_save_created
			if GotParam \{controller}
				get_savegame_from_controller controller = <controller>
				get_current_band_info
				SetGlobalTags savegame = <savegame> <band_info> params = {save_created = 1}
			else
			endif
		endif
	endif
	switch <type>
		case boot
		if GotParam \{success}
			spawnscriptnow \{ui_event_wait
				params = {
					event = menu_replace
					data = {
						state = uistate_boot_guitar
					}
				}}
		elseif GotParam \{failed}
			ui_event_wait \{event = menu_replace
				data = {
					state = uistate_boot_guitar
				}}
		endif
		case autosave
		if ScriptIsRunning \{handle_signin_changed}
			mark_safe_for_shutdown
			return
		endif
		if NOT GotParam \{already_cleared_ui_stack}
			if GotParam \{success}
				ui_event_wait <event_params>
			elseif GotParam \{failed}
				ui_event_wait <event_params>
			endif
		endif
		case autoload
		if GotParam \{success}
			ui_event_wait event = menu_replace data = {state = uistate_boot_download_scan event_params = <event_params> controller = <controller>}
		elseif GotParam \{failed}
			ui_event_wait <event_params>
		endif
		case save
		if GotParam \{success}
			ui_event_wait <event_params>
		elseif GotParam \{failed}
			ui_event_wait <event_params>
		endif
		case load
		if GotParam \{success}
			ui_event_wait <event_params>
		elseif GotParam \{failed}
			ui_event_wait \{event = menu_back}
		endif
		case save_jam
		if GotParam \{success}
			ui_event <event_params>
		elseif GotParam \{failed}
			ui_event \{event = menu_back}
		endif
		case load_jam
		if GotParam \{success}
			ui_event <event_params>
		elseif GotParam \{failed}
			ui_event \{event = menu_back}
		endif
		case delete_jam
		if GotParam \{success}
			ui_event <event_params>
		elseif GotParam \{failed}
			ui_event \{event = menu_back}
		endif
		case rename_jam
		if GotParam \{success}
			ui_event <event_params>
		elseif GotParam \{failed}
			ui_event \{event = menu_back}
		endif
		case secondary_signin_load

		if GotParam \{success}
			ui_event_wait <event_params>
		elseif GotParam \{failed}
			ui_event_wait \{event = menu_back}
		endif
		default


	endswitch
	if GlobalExists \{name = debug_unlockall}
		if ((<type> = boot) || (<type> = autoload) || (<type> = load))
			playday_unlockall
		endif
	endif
	if ($memcard_after_func != none)
		if GotParam \{success}
			($memcard_after_func) success
		elseif GotParam \{failed}
			($memcard_after_func) failed
		else

		endif
		change \{memcard_after_func = none}
	endif
endscript

script ui_memcard_autosave \{event = menu_back
		data = {
		}}
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	if ScreenElementExists \{id = menu_backdrop_container}
		DestroyScreenElement \{id = menu_backdrop_container}
	endif
	generic_event_choose no_sound state = uistate_memcard data = {type = autosave event_params = {event = <event> data = <data>}}
endscript

script ui_memcard_autosave_replace \{event = menu_back
		data = {
		}}
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	ui_event event = menu_replace data = {state = uistate_memcard type = autosave event_params = {event = <event> data = <data>}}
endscript

script ui_memcard_autoload \{this_event = menu_change
		event = menu_replace
		data = {
		}}
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	generic_event_choose no_sound event = <this_event> state = uistate_memcard data = {type = autoload event_params = {event = <event> data = <data>} controller = <controller>}
endscript

script ui_memcard_save \{event = menu_replace
		data = {
		}}
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	generic_event_choose state = uistate_memcard data = {type = save event_params = {event = <event> data = <data>}}
endscript

script ui_memcard_load \{this_event = menu_change
		event = menu_replace
		data = {
		}}
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	generic_event_choose event = <this_event> state = uistate_memcard data = {type = load event_params = {event = <event> data = <data>}}
endscript
jam_memcard_signin_save_after_func = none

script jam_memcard_signin_load_after_func 
	change \{memcard_after_func = $jam_memcard_signin_save_after_func}
endscript

script ui_memcard_save_jam \{event = menu_replace
		data = {
		}}
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	generic_event_choose no_sound state = uistate_memcard data = {type = save_jam event_params = {event = <event> data = <data>}}
endscript

script ui_memcard_rename_jam \{event = menu_replace
		data = {
		}}
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	generic_event_choose state = uistate_memcard data = {type = rename_jam event_params = {event = <event> data = <data>}}
endscript

script ui_memcard_delete_jam \{event = menu_replace
		data = {
		}}
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	generic_event_choose state = uistate_memcard data = {type = delete_jam event_params = {event = <event> data = <data>}}
endscript

script ui_memcard_secondary_siginin_load \{event = menu_replace
		data = {
		}}

	generic_event_choose state = <state>
endscript
memcard_controller_iterator = 0
memcard_controller_list = [
]

script memcard_controller_reset 
	change \{memcard_controller_iterator = 0}
	change \{memcard_controller_list = [
		]}
endscript

script memcard_controller_add \{requested_autosave = 0}
	if isXenon
		if NOT CheckForSignIn local controller_index = <controller>

			return
		endif
		if NetSessionFunc func = XenonIsGuest params = {controller_index = <controller>}

			return
		endif
	endif
	get_savegame_from_controller controller = <controller>
	GetGlobalTags savegame = <savegame> user_options
	if (<requested_autosave> = 0)
		if (<autosave> = 0)

			return
		endif
	endif
	if NOT ArrayContains array = $memcard_controller_list contains = <controller>
		AddArrayElement array = $memcard_controller_list element = <controller>
		change memcard_controller_list = <array>
	endif
endscript

script memcard_controller_add_signed_in_and_valid 
	memcard_controller_add controller = ($primary_controller)

endscript

script memcard_controller_has_next 
	GetArraySize \{$memcard_controller_list}
	if ($memcard_controller_iterator < <array_size>)
		return \{true}
	endif
	return \{false}
endscript

script memcard_controller_get_next 
	GetArraySize \{$memcard_controller_list}
	if ($memcard_controller_iterator < <array_size>)
		ctl = ($memcard_controller_list [($memcard_controller_iterator)])
		change memcard_controller_iterator = ($memcard_controller_iterator + 1)
		return true controller = <ctl>
	endif
	return \{false}
endscript

script memcard_guest_profile_warning 
	change \{MemcardDoneScript = memcard_sequence_generic_done}
	<options_array> = [
		{
			func = signin_warning_select_signin
			func_params = {allow_back = 1}
			text = qs("SIGN IN")
		}
		{
			func = memcard_disable_saves_and_quit
			text = qs("CONTINUE WITHOUT SAVING")
		}
		{
			func = generic_event_replace
			params = {state = UIstate_boot_iis}
			text = qs("CANCEL")
		}
	]
	create_dialog_box {
		body_text = qs("You are signed in as a guest. Guest profiles cannot save their progress or settings. Do you wish to continue without saving?")
		player_device = ($primary_controller)
		options = <options_array>
	}
endscript
