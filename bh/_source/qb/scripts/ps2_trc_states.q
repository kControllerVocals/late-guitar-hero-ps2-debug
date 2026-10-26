HACK_ps2_saveload_successor = {
	create = stop_flow_manager_and_return_to_ui_state_machine
}
string_ps2_CAUTION = qs(0xb3d16ef9)
string_ps2_MEMORY_CARD_ERROR = qs("ERROR")
string_ps2_SAVE_NOT_FOUND = qs(0xaf217c7b)
string_ps2_SUCCESS = qs(0x14d209cb)
string_ps2_FORMATTING = qs(0xaf23ce9b)
ps2_memcard_autosave_warning_boot_fs = {
	create = ps2_memcard_message
	create_params = {
		header = $string_ps2_CAUTION
		message = boot_autosave_warning
	}
	actions = [
		{
			action = continue
			flow_state = ps2_memcard_load_check_status_boot_fs
		}
	]
}
ps2_memcard_load_check_status_boot_fs = {
	create = ps2_memcard_load_check_status
	create_params = {
		header = qs("CHECKING...")
		message = check_memcard
	}
	actions = [
		{
			action = no_memcard
			flow_state_func = ps2_memcard_load_error_boot
			flow_state_func_params = {
				message = no_memcard_boot
			}
		}
		{
			action = insufficient_space
			flow_state_func = ps2_memcard_load_error_boot
			flow_state_func_params = {
				message = insufficient_space_boot
			}
		}
		{
			action = no_save
			flow_state = ps2_memcard_load_no_save_boot_fs
		}
		{
			action = status_ok
			flow_state = ps2_memcard_load_boot_fs
		}
	]
}
ps2_memcard_load_boot_fs = {
	create = ps2_memcard_load
	create_params = {
		header = qs("LOADING...")
		message = loading
	}
	actions = [
		{
			action = no_memcard
			flow_state_func = ps2_memcard_load_error_boot
			flow_state_func_params = {
				message = no_memcard_boot
			}
		}
		{
			action = load_complete
			flow_state = ps2_memcard_load_complete_boot_fs
		}
		{
			action = corrupt_save
			flow_state = ps2_memcard_load_corrupt_boot_fs
		}
		{
			action = no_save
			flow_state = ps2_memcard_load_no_save_boot_fs
		}
	]
}
ps2_memcard_load_error_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = $loadErrorMessage
		option1_text = qs("RETRY")
		option1_action = retry_load
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = disable_autosave
	}
	actions = [
		{
			action = disable_autosave
			flow_state = ps2_memcard_disable_autosave_boot_fs
		}
		{
			action = retry_load
			flow_state = ps2_memcard_load_check_status_boot_fs
		}
	]
}
ps2_memcard_load_no_save_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_SAVE_NOT_FOUND
		message = no_save_boot
		option1_text = qs(0xc08e8aaf)
		option1_action = save
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = dont_save
	}
	actions = [
		{
			action = save
			flow_state_func = ps2_memcard_set_save_mode
			flow_state_func_params = {
				mode = save
				flow_state = ps2_memcard_save_check_status_boot_fs
			}
		}
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_boot_fs
		}
	]
}
ps2_memcard_load_corrupt_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = corrupt_boot
		option1_text = qs("OVERWRITE")
		option1_action = confirm_overwrite
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = dont_save
	}
	actions = [
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_boot_fs
		}
		{
			action = confirm_overwrite
			flow_state_func = ps2_memcard_set_save_mode
			flow_state_func_params = {
				mode = overwrite
				flow_state = ps2_memcard_save_check_status_boot_fs
			}
		}
	]
}
ps2_memcard_load_complete_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_SUCCESS
		message = load_successful
		seconds_before_continue = 1
	}
	actions = [
		{
			action = continue
			flow_state_func = ps2_get_saveload_successor
		}
	]
}
ps2_memcard_insufficient_space_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = insufficient_space_boot
		option1_text = qs("RETRY")
		option1_action = load
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = dont_save
	}
	actions = [
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_boot_fs
		}
		{
			action = load
			flow_state = ps2_memcard_load_check_status_boot_fs
		}
	]
}
ps2_memcard_save_check_status_boot_fs = {
	create = ps2_memcard_save_check_status
	create_params = {
		header = qs("CHECKING...")
		message = check_memcard
	}
	actions = [
		{
			action = no_memcard
			flow_state = ps2_memcard_save_no_card_boot_fs
		}
		{
			action = not_formatted
			flow_state = ps2_memcard_attempt_format_boot_fs
		}
		{
			action = status_ok
			flow_state = ps2_memcard_save_boot_fs
		}
		{
			action = new_memcard
			flow_state = ps2_memcard_save_new_card_boot_fs
		}
		{
			action = existing_save
			flow_state_func = ps2_memcard_existing_save_successor_overwrite
		}
	]
}
ps2_memcard_save_boot_fs = {
	create = ps2_memcard_save
	create_params = {
		save = {
			header = qs("SAVING...")
			message = Saving
		}
		overwrite = {
			header = qs("OVERWRITING...")
			message = overwriting
		}
	}
	actions = [
		{
			action = save_complete
			flow_state = ps2_memcard_save_complete_boot_fs
		}
		{
			action = error
			flow_state = ps2_memcard_save_error_boot_fs
		}
		{
			action = insufficient_space
			flow_state = ps2_memcard_insufficient_space_boot_fs
		}
	]
}
ps2_memcard_save_no_card_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = no_memcard
		option1_text = qs(0xf9ea2606)
		option1_action = retry_save
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = disable_autosave
	}
	actions = [
		{
			action = retry_save
			flow_state_func = ps2_memcard_set_save_mode
			flow_state_func_params = {
				mode = save
				flow_state = ps2_memcard_save_check_status_boot_fs
			}
		}
		{
			action = disable_autosave
			flow_state = ps2_memcard_disable_autosave_boot_fs
		}
	]
}
ps2_memcard_save_new_card_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = new_memcard
		option1_text = qs("SAVE")
		option1_action = save
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = disable_autosave
	}
	actions = [
		{
			action = save
			flow_state_func = ps2_memcard_set_save_mode
			flow_state_func_params = {
				mode = save
				flow_state = ps2_memcard_save_check_status_boot_fs
			}
		}
		{
			action = disable_autosave
			flow_state = ps2_memcard_disable_autosave_boot_fs
		}
	]
}
ps2_memcard_save_error_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		save = {
			message = save_failed
			option1_text = qs(0xf9ea2606)
		}
		overwrite = {
			message = overwrite_failed
			option1_text = qs(0xf929226b)
		}
		option1_action = retry
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = dont_save
	}
	actions = [
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_boot_fs
		}
		{
			action = retry
			flow_state = ps2_memcard_save_check_status_boot_fs
		}
	]
}
ps2_memcard_save_complete_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_SUCCESS
		save = {
			message = save_successful
		}
		overwrite = {
			message = overwrite_successful
		}
		seconds_before_continue = 1
	}
	actions = [
		{
			action = continue
			flow_state_func = ps2_get_saveload_successor
		}
	]
}
ps2_memcard_attempt_format_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_CAUTION
		message = attempt_format
		option1_text = qs("NO")
		option1_action = load
		option2_text = qs("YES")
		option2_action = format
	}
	actions = [
		{
			action = load
			flow_state = ps2_memcard_load_check_status_boot_fs
		}
		{
			action = format
			flow_state = ps2_memcard_attempt_format_confirm_boot_fs
		}
	]
}
ps2_memcard_attempt_format_confirm_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_CAUTION
		message = confirm_format
		option1_text = qs("NO")
		option1_action = abort_format
		option2_text = qs("YES")
		option2_action = format
	}
	actions = [
		{
			action = abort_format
			flow_state = ps2_memcard_load_check_status_boot_fs
		}
		{
			action = format
			flow_state = ps2_memcard_format_check_status_boot_fs
		}
	]
}
ps2_memcard_format_check_status_boot_fs = {
	create = ps2_memcard_format_check_status
	create_params = {
		header = qs("CHECKING...")
		message = check_memcard
	}
	actions = [
		{
			action = no_memcard
			flow_state_func = ps2_memcard_format_error_boot
			flow_state_func_params = {
				message = no_memcard
			}
		}
		{
			action = status_ok
			flow_state = ps2_memcard_format_boot_fs
		}
		{
			action = is_formatted
			flow_state_func = ps2_memcard_format_error_boot
			flow_state_func_params = {
				message = is_formatted
			}
		}
		{
			action = new_memcard
			flow_state_func = ps2_memcard_format_error_boot
			flow_state_func_params = {
				message = new_memcard_format_boot
			}
		}
	]
}
ps2_memcard_format_boot_fs = {
	create = ps2_memcard_format
	create_params = {
		header = $string_ps2_FORMATTING
		message = formatting
	}
	actions = [
		{
			action = success
			flow_state = ps2_memcard_format_complete_boot_fs
		}
		{
			action = error
			flow_state_func = ps2_memcard_format_error_boot
			flow_state_func_params = {
				message = format_failed
			}
		}
	]
}
ps2_memcard_format_error_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = $formatErrorMessage
		option1_text = qs("RETRY")
		option1_action = load
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = dont_save
	}
	actions = [
		{
			action = load
			flow_state = ps2_memcard_load_check_status_boot_fs
		}
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_boot_fs
		}
	]
}
ps2_memcard_format_complete_boot_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_SUCCESS
		message = format_successful
		seconds_before_continue = 1
	}
	actions = [
		{
			action = continue
			flow_state_func = ps2_memcard_set_save_mode
			flow_state_func_params = {
				mode = save
				flow_state = ps2_memcard_save_check_status_boot_fs
			}
		}
	]
}
ps2_memcard_disable_autosave_boot_fs = {
	create = ps2_disable_autosave
	create_params = {
		header = $string_ps2_CAUTION
		message = disable_autosave
	}
	actions = [
		{
			action = continue
			flow_state_func = ps2_get_saveload_successor
		}
	]
}
ps2_memcard_save_start_ingame_fs = {
	create = ps2_memcard_save_start
	actions = [
		{
			action = continue
			flow_state = ps2_memcard_save_check_status_ingame_fs
		}
	]
}
ps2_memcard_save_check_status_ingame_fs = {
	create = ps2_memcard_save_check_status
	create_params = {
		header = qs("CHECKING...")
		message = check_memcard
	}
	actions = [
		{
			action = no_memcard
			flow_state = ps2_memcard_save_no_card_ingame_fs
		}
		{
			action = not_formatted
			flow_state = ps2_memcard_attempt_format_ingame_fs
		}
		{
			action = status_ok
			flow_state = ps2_memcard_save_ingame_fs
		}
		{
			action = new_memcard
			flow_state = ps2_memcard_save_new_card_ingame_fs
		}
		{
			action = existing_save
			flow_state_func = ps2_memcard_existing_save_successor
		}
	]
}
ps2_memcard_save_ingame_fs = {
	create = ps2_memcard_save
	create_params = {
		save = {
			header = qs("SAVING...")
			message = Saving
		}
		autosave = {
			header = qs(0xede50683)
			message = autosaving
		}
		overwrite = {
			header = qs("OVERWRITING...")
			message = overwriting
		}
	}
	actions = [
		{
			action = error
			flow_state = ps2_memcard_save_error_ingame_fs
		}
		{
			action = insufficient_space
			flow_state = ps2_memcard_insufficient_space_ingame_fs
		}
		{
			action = save_complete
			flow_state = ps2_memcard_save_complete_ingame_fs
		}
	]
}
ps2_memcard_insufficient_space_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = insufficient_space_ingame
		option1_text = qs(0xf9ea2606)
		option1_action = save
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = dont_save
	}
	actions = [
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_ingame_fs
		}
		{
			action = save
			flow_state = ps2_memcard_save_check_status_ingame_fs
		}
	]
}
ps2_memcard_save_new_card_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = new_memcard
		option1_text = qs("SAVE")
		option1_action = save
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = disable_autosave
	}
	actions = [
		{
			action = save
			flow_state_func = ps2_memcard_set_save_mode
			flow_state_func_params = {
				mode = save
				flow_state = ps2_memcard_save_check_status_ingame_fs
			}
		}
		{
			action = disable_autosave
			flow_state = ps2_memcard_disable_autosave_ingame_fs
		}
	]
}
ps2_memcard_overwrite_confirm_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_CAUTION
		message = confirm_overwrite
		option1_text = qs("CONTINUE WITHOUT SAVING")
		option1_action = dont_save
		option2_text = qs("OVERWRITE")
		option2_action = overwrite
	}
	actions = [
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_ingame_fs
		}
		{
			action = overwrite
			flow_state_func = ps2_memcard_set_save_mode
			flow_state_func_params = {
				mode = overwrite
				flow_state = ps2_memcard_save_check_status_ingame_fs
			}
		}
	]
}
ps2_memcard_save_error_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		save = {
			message = save_failed
			option1_text = qs(0xf9ea2606)
		}
		autosave = {
			message = save_failed
			option1_text = qs(0xf9ea2606)
		}
		overwrite = {
			message = overwrite_failed
			option1_text = qs(0xf929226b)
		}
		option1_action = save
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = dont_save
	}
	actions = [
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_ingame_fs
		}
		{
			action = save
			flow_state = ps2_memcard_save_check_status_ingame_fs
		}
	]
}
ps2_memcard_save_no_card_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = no_memcard
		option1_text = qs(0xf9ea2606)
		option1_action = save
		option2_text = qs("CONTINUE WITHOUT SAVING")
		option2_action = dont_save
	}
	actions = [
		{
			action = save
			flow_state_func = ps2_memcard_set_save_mode
			flow_state_func_params = {
				mode = save
				flow_state = ps2_memcard_save_check_status_ingame_fs
			}
		}
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_ingame_fs
		}
	]
}
ps2_memcard_save_complete_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_SUCCESS
		save = {
			message = save_successful
		}
		autosave = {
			message = save_successful
		}
		overwrite = {
			message = overwrite_successful
		}
		seconds_before_continue = 1
	}
	actions = [
		{
			action = continue
			flow_state_func = ps2_get_saveload_successor
		}
	]
}
ps2_memcard_disable_autosave_ingame_fs = {
	create = ps2_disable_autosave
	create_params = {
		header = $string_ps2_CAUTION
		message = disable_autosave
	}
	actions = [
		{
			action = continue
			flow_state_func = ps2_get_saveload_successor
		}
	]
}
ps2_memcard_attempt_format_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_CAUTION
		message = attempt_format
		option1_text = qs("CONTINUE WITHOUT SAVING")
		option1_action = dont_save
		option2_text = qs("YES")
		option2_action = format
	}
	actions = [
		{
			action = format
			flow_state = ps2_memcard_attempt_format_confirm_ingame_fs
		}
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_ingame_fs
		}
	]
}
ps2_memcard_attempt_format_confirm_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_CAUTION
		message = confirm_format
		option1_text = qs("CONTINUE WITHOUT SAVING")
		option1_action = abort_format
		option2_text = qs(0x113952f8)
		option2_action = format
	}
	actions = [
		{
			action = format
			flow_state = ps2_memcard_format_check_status_ingame_fs
		}
		{
			action = abort_format
			flow_state = ps2_memcard_disable_autosave_ingame_fs
		}
	]
}
ps2_memcard_format_check_status_ingame_fs = {
	create = ps2_memcard_format_check_status
	create_params = {
		header = qs("CHECKING...")
		message = check_memcard
	}
	actions = [
		{
			action = no_memcard
			flow_state = ps2_memcard_retry_format_ingame_fs
		}
		{
			action = status_ok
			flow_state = ps2_memcard_format_ingame_fs
		}
		{
			action = is_formatted
			flow_state = ps2_memcard_save_new_card_ingame_fs
		}
		{
			action = new_memcard
			flow_state = ps2_memcard_save_new_card_ingame_fs
		}
	]
}
ps2_memcard_format_ingame_fs = {
	create = ps2_memcard_format
	create_params = {
		header = $string_ps2_FORMATTING
		message = formatting
	}
	actions = [
		{
			action = success
			flow_state = ps2_memcard_format_complete_ingame_fs
		}
		{
			action = error
			flow_state = ps2_memcard_retry_format_ingame_fs
		}
	]
}
ps2_memcard_retry_format_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = format_failed
		option1_text = qs("CONTINUE WITHOUT SAVING")
		option1_action = dont_save
		option2_text = qs(0x664fb590)
		option2_action = format
	}
	actions = [
		{
			action = format
			flow_state = ps2_memcard_format_check_status_ingame_fs
		}
		{
			action = dont_save
			flow_state = ps2_memcard_disable_autosave_ingame_fs
		}
	]
}
ps2_memcard_format_complete_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_SUCCESS
		message = format_successful
		seconds_before_continue = 1
	}
	actions = [
		{
			action = continue
			flow_state = ps2_memcard_save_check_status_ingame_fs
		}
	]
}
ps2_memcard_load_check_status_ingame_fs = {
	create = ps2_memcard_load_check_status
	create_params = {
		header = qs("CHECKING...")
		message = check_memcard
		check_insufficient_space = 0
	}
	actions = [
		{
			action = no_memcard
			flow_state_func = ps2_memcard_load_error_ingame
			flow_state_func_params = {
				message = no_memcard
			}
		}
		{
			action = no_save
			flow_state_func = ps2_memcard_load_error_ingame
			flow_state_func_params = {
				message = no_save_ingame
			}
		}
		{
			action = status_ok
			flow_state = ps2_memcard_load_ingame_fs
		}
	]
}
ps2_memcard_load_error_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = $loadErrorMessage
		option1_text = qs(0x9e92cce5)
		option1_action = disable_autosave
		option2_text = qs(0xb2ae3a96)
		option2_action = load
	}
	actions = [
		{
			action = disable_autosave
			flow_state = ps2_memcard_disable_autosave_ingame_fs
		}
		{
			action = load
			flow_state = ps2_memcard_load_check_status_ingame_fs
		}
	]
}
ps2_memcard_load_ingame_fs = {
	create = ps2_memcard_load
	create_params = {
		header = qs("LOADING...")
		message = loading
	}
	actions = [
		{
			action = load_complete
			flow_state = ps2_memcard_load_complete_ingame_fs
		}
		{
			action = no_memcard
			flow_state_func = ps2_memcard_load_error_ingame
			flow_state_func_params = {
				message = no_memcard
			}
		}
		{
			action = no_save
			flow_state_func = ps2_memcard_load_error_ingame
			flow_state_func_params = {
				message = no_save_ingame
			}
		}
		{
			action = corrupt_save
			flow_state_func = ps2_memcard_load_error_ingame
			flow_state_func_params = {
				message = corrupt_ingame
			}
		}
	]
}
ps2_memcard_load_complete_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_SUCCESS
		message = load_successful
		seconds_before_continue = 1
	}
	actions = [
		{
			action = continue
			flow_state_func = ps2_get_saveload_successor
		}
	]
}
ps2_memcard_load_jam_list_check_status_ingame_fs = {
	create = ps2_memcard_load_jam_list_check_status
	create_params = {
		header = qs("CHECKING...")
		message = check_memcard
		check_insufficient_space = 0
	}
	actions = [
		{
			action = no_memcard
			flow_state_func = ps2_memcard_load_jam_list_error_ingame
			flow_state_func_params = {
				message = no_memcard
			}
		}
		{
			action = status_ok
			flow_state = ps2_memcard_load_ingame_fs
		}
	]
}
ps2_memcard_load_jam_list_ingame_fs = {
	create = ps2_memcard_load_jam_list
	create_params = {
		header = qs("LOADING...")
		message = loading_jams
	}
	actions = [
		{
			action = error
			flow_state_func = ps2_memcard_load_jam_list_error_ingame
			flow_state_func_params = {
				message = directory_list_error
			}
		}
		{
			action = status_ok
			flow_state = ps2_memcard_load_ingame_fs
		}
	]
}
ps2_memcard_load_jam_list_error_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = $loadErrorMessage
		option1_text = qs(0x9e92cce5)
		option1_action = disable_autosave
		option2_text = qs(0xb2ae3a96)
		option2_action = load
	}
	actions = [
		{
			action = disable_autosave
			flow_state = ps2_memcard_disable_autosave_ingame_fs
		}
		{
			action = load
			flow_state = ps2_memcard_load_jam_list_check_status_ingame_fs
		}
	]
}
ps2_memcard_delete_check_status_ingame_fs = {
	create = ps2_memcard_delete_check_status
	create_params = {
		header = qs("CHECKING...")
		message = check_memcard
	}
	actions = [
		{
			action = no_memcard
			flow_state_func = ps2_memcard_load_error_ingame
			flow_state_func_params = {
				message = no_memcard
			}
		}
		{
			action = no_save
			flow_state_func = ps2_memcard_load_error_ingame
			flow_state_func_params = {
				message = no_save
			}
		}
		{
			action = status_ok
			flow_state = ps2_memcard_delete_ingame_fs
		}
	]
}
ps2_memcard_delete_error_ingame_fs = {
	create = refresh_ps2_trc_menu
	create_params = {
		header = $string_ps2_MEMORY_CARD_ERROR
		message = $deleteErrorMessage
		option1_text = qs(0x5919baae)
		option1_action = leave_saveload_flow
		option2_text = qs(0x2c2a9e0f)
		option2_action = retry
	}
	actions = [
		{
			action = leave_saveload_flow
			flow_state_func = ps2_get_saveload_successor
		}
		{
			action = retry
			flow_state = ps2_memcard_delete_check_status_ingame_fs
		}
	]
}
ps2_memcard_delete_ingame_fs = {
	create = ps2_memcard_delete
	create_params = {
		header = qs("DELETING...")
		message = deleting
	}
	actions = [
		{
			action = delete_complete
			flow_state = ps2_memcard_delete_complete_ingame_fs
		}
		{
			action = no_memcard
			flow_state_func = ps2_memcard_load_error_ingame
			flow_state_func_params = {
				message = no_memcard
			}
		}
		{
			action = no_save
			flow_state_func = ps2_memcard_load_error_ingame
			flow_state_func_params = {
				message = no_save
			}
		}
	]
}
ps2_memcard_delete_complete_ingame_fs = {
	create = ps2_memcard_delete_complete
	create_params = {
		header = $string_ps2_SUCCESS
		message = delete_successful
	}
	actions = [
		{
			action = leave_saveload_flow
			flow_state_func = ps2_get_saveload_successor
		}
		{
			action = load_jam_list
			flow_state = ps2_memcard_load_jam_list_ingame_fs
		}
	]
}
