restartMenuMusic = 0
saveMode = 0x00000000
formatErrorMessage = 0x00000000
loadErrorMessage = 0x00000000
deleteErrorMessage = 0x00000000
ps2_memcard_autosave = 0

script ps2_memcard_set_autosave 
	change ps2_memcard_autosave = <autosave>
endscript

script stop_flow_manager_and_return_to_ui_state_machine 
	debug_Printf \{qs(0x075f70e6)}
	Wait \{5
		gameframe}
	destroy_ps2_saveload_screen
	if ($restartMenuMusic = 1)
		change \{restartMenuMusic = 0}
		if ($Menu_Music_On_Flag = 1)
			Menu_Music_Off
		endif
		spawnscriptnow \{menu_music_on}
	endif
	shut_down_flow_manager
	memcard_sequence_quit
endscript

script ps2_memcard_load_check_status \{check_insufficient_space = 1}
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{3
		seconds}
	GetCardStatus
	if GotParam \{NoMemcard}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	elseif GotParam \{NotFormatted}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_save
			}}
		return
	endif
	if ($current_save_file_type = Progress)
		memcard_check_for_existing_save
		if (<found> = 0)
			GetMemCardSpaceRequired \{Progress}
			GetMemCardSpaceAvailable

			if CardIsInSlot
				if ((<check_insufficient_space> = 1) && (<SpaceRequired> > <SpaceAvailable>))
					spawnscriptnow \{ui_flow_manager_respond_to_action
						params = {
							action = insufficient_space
						}}
				else
					change \{MemcardSavingOrLoading = Saving}
					spawnscriptnow \{ui_flow_manager_respond_to_action
						params = {
							action = no_save
						}}
				endif
			else
				spawnscriptnow \{ui_flow_manager_respond_to_action
					params = {
						action = no_memcard
					}}
			endif
			return
		else
			change \{MemcardSavingOrLoading = loading}
		endif
	endif
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = status_ok
		}}
endscript

script ps2_memcard_load 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	SetSaveFileName \{FileType = $current_save_file_type}
	GetGlobalTags \{globaltag_checksum
		params = globaltag_checksum}
	oldglobaltag_checksum = <globaltag_checksum>
	unload_songqpak
	MemPushContext \{heap_song}
	if LoadFromMemoryCard \{FileType = $current_save_file_type}
		MemPopContext
		memcard_post_load_progress
		change \{MemcardSuccess = true}
	else
		MemPopContext
		if NOT CardIsInSlot
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = no_memcard
				}}
			return
		elseif GotParam \{CorruptedData}
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = corrupt_save
				}}
			return
		else
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = no_save
				}}
			return
		endif
	endif
	globaltag_checksum = invalid
	GetGlobalTags \{globaltag_checksum
		params = globaltag_checksum
		noassert = 1}
	if NOT (<globaltag_checksum> = <oldglobaltag_checksum>)

		ClearGlobalTags
		setup_globaltags
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = corrupt_save
			}}
		return
	endif
	restore_options_from_global_tags
	scan_globaltag_downloads
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = load_complete
		}}
endscript

script ps2_memcard_load_jam_list_check_status \{check_insufficient_space = 1}
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{3
		seconds}
	GetCardStatus
	if GotParam \{NoMemcard}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	endif
	GetMemCardSpaceRequired \{jamsession}
	GetMemCardSpaceAvailable
	if ((<check_insufficient_space> = 1) && (<SpaceRequired> > <SpaceAvailable>))
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = insufficient_space
			}}
	endif
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = status_ok
		}}
endscript

script ps2_memcard_load_jam_list 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	if GetMemCardDirectoryListing \{FileType = jamsession}
		change jam_curr_directory_listing = <directorylisting>

		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = status_ok
			}}
	else
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = error
			}}
	endif
endscript

script ps2_memcard_delete_check_status 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{3
		seconds}
	if NOT CardIsInSlot
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	endif
	if NOT ($current_save_file_type = jamsession)

	endif
	if MemCardFileExists \{type = jamsession
			name = $memcard_jamsession_actual_file_name}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = status_ok
			}}
	else
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_save
			}}
	endif
endscript

script ps2_memcard_delete 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	SetSaveFileName \{FileType = $current_save_file_type}
	if DeleteMemCardFile \{FileType = $current_save_file_type}

		change \{MemcardSuccess = true}
	else
		if NOT CardIsInSlot
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = no_memcard
				}}
			return
		else

			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = corrupt_save
				}}
			return
		endif
	endif
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = delete_complete
		}}
endscript

script ps2_memcard_delete_complete 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{1
		second}
	if ($current_save_file_type = jamsession)
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = load_jam_list
			}}
	endif
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = leave_saveload_flow
		}}
endscript

script ps2_memcard_save_check_status \{check_for_existing = 0}
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	if ScreenElementExists \{id = gh3c_fade_box}
		DestroyScreenElement \{id = gh3c_fade_box}
	endif
	if CardIsNew
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = new_memcard
			}}
		return
	endif
	GetCardStatus
	if GotParam \{NoMemcard}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	elseif GotParam \{NotFormatted}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = not_formatted
			}}
		return
	endif
	if ($current_save_file_type = Progress)
		if NOT ($saveMode = overwrite)
			memcard_check_for_existing_save
			if NOT (<found> = 0)
				if NOT CardIsInSlot
					spawnscriptnow \{ui_flow_manager_respond_to_action
						params = {
							action = no_memcard
						}}
					return
				endif
				spawnscriptnow \{ui_flow_manager_respond_to_action
					params = {
						action = existing_save
					}}
				return
			endif
		endif
	endif
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = status_ok
		}}
endscript

script ps2_memcard_save 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	if ($progression_pop_count = 1)
		pop_later = 1
		progression_push_current
	else
		pop_later = 0
	endif
	SetSaveFileName \{FileType = $current_save_file_type}
	memcard_pre_save_progress
	write_globals_to_global_tags
	if SaveToMemoryCard \{FileType = $current_save_file_type}
		change \{MemcardSuccess = true}
	else

		if SaveFailedDueToInsufficientSpace
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = insufficient_space
				}}
		else
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = error
				}}
		endif
		return
	endif
	if ($current_save_file_type = jamsession)
		GetMemCardDirectoryListing \{FileType = jamsession}
		change jam_curr_directory_listing = <directorylisting>
	endif
	if (<pop_later> = 1)
		progression_pop_current
	endif
	destroy_ps2_saveload_screen
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = save_complete
		}}
endscript

script ps2_memcard_format_check_status 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	GetCardStatus
	if GotParam \{NewMemcard}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = new_memcard
			}}
	elseif GotParam \{NoMemcard}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
	elseif GotParam \{NotFormatted}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = status_ok
			}}
	else
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = is_formatted
			}}
	endif
endscript

script ps2_memcard_format 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	if NOT FormatCard
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = error
			}}
		return
	endif
	destroy_ps2_saveload_screen
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = success
		}}
endscript

script ps2_disable_autosave 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{3
		seconds}
	SetGlobalTags \{user_options
		params = {
			autosave = 0
		}}
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = continue
		}}
endscript

script ps2_memcard_message 
	change \{check_for_unplugged_controllers = 1}
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	add_user_control_helper \{text = qs("CONTINUE")
		button = green
		z = 1006}
	CreateScreenElement \{type = SpriteElement
		parent = ps2_trc_container
		rgba = [
			0
			0
			0
			0
		]
		event_handlers = [
			{
				pad_choose
				ui_flow_manager_respond_to_action
				params = {
					action = continue
				}
			}
		]}
	LaunchEvent type = focus target = <id>
endscript

script ps2_memcard_save_start 
	if (($ps2_memcard_autosave) = 1)
		change \{saveMode = autosave}
	else
		change \{saveMode = save}
	endif
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = continue
		}}
endscript

script ps2_memcard_existing_save_successor 
	if ($saveMode = save)
		return \{flow_state = ps2_memcard_overwrite_confirm_ingame_fs}
	else
		return \{flow_state = ps2_memcard_save_ingame_fs}
	endif
endscript

script ps2_memcard_existing_save_successor_overwrite 
	return \{flow_state = ps2_memcard_load_corrupt_boot_fs}
endscript

script ps2_memcard_set_save_mode 

	change saveMode = <mode>
	return flow_state = <flow_state>
endscript

script ps2_memcard_format_error_boot 

	change formatErrorMessage = <message>
	return \{flow_state = ps2_memcard_format_error_boot_fs}
endscript

script ps2_memcard_load_error 

	change loadErrorMessage = <message>
endscript

script ps2_memcard_load_error_boot 
	ps2_memcard_load_error <...>
	return \{flow_state = ps2_memcard_load_error_boot_fs}
endscript

script ps2_memcard_load_error_ingame 
	ps2_memcard_load_error <...>
	return \{flow_state = ps2_memcard_load_error_ingame_fs}
endscript

script ps2_memcard_load_jam_list_error_ingame 
	ps2_memcard_load_error <...>
	return \{flow_state = ps2_memcard_load_jam_list_error_ingame_fs}
endscript

script ps2_memcard_delete_error_ingame 

	change deleteErrorMessage = <message>
	return \{flow_state = ps2_memcard_delete_error_ingame_fs}
endscript

script ps2_get_saveload_successor 
	return \{flow_state = HACK_ps2_saveload_successor}
endscript
