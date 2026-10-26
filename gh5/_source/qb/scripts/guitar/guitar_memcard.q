max_memcard_filename_length = 15
SavingOrLoading = Saving
memcard_default_title = 'Guitar Hero 5'
memcard_content_name = qs("Progress")
memcard_content_jamsession_name = qs("CustomSongs")
save_data_dirty = 0
current_save_file_type = 0x00000000
memcard_file_types = {
	Progress = {
		file_name = 'GH5Progress'
		suffix = 'Progress'
		folder_name = 'Guitar Hero 5'
		icon = 'memcard\\progress.ico'
		version = 54
		fixed_size = 409600
		menu_text = qs(0x9d87ba69)
	}
	jamsession = {
		file_name = 'GH5JamSession'
		suffix = '-jam'
		folder_name = 'Guitar Hero 5'
		icon = 'memcard\\jam.ico'
		version = 80
		fixed_size = 124928
		menu_text = 'JAM SESSION'
	}
}
memcard_folder_desc = {
	GuitarContent = {
		icon_xen = 'memcard\\gh.png'
		icon_ps3 = 'memcard\\ICON0.PNG'
		file_types = [
			{
				name = Progress
				slots_reserve = 1
			}
		]
	}
	JamSessionsContent = {
		icon_xen = 'memcard\\gh.png'
		icon_ps3 = 'memcard\\ICON0.PNG'
		file_types = [
			{
				name = jamsession
				slots_reserve = 0
			}
		]
	}
}
MemcardDoneScript = nullscript
MemcardRetryScript = nullscript
MemcardSavingOrLoading = Saving
MemcardSuccess = false
MemcardController = $primary_controller
MemcardInitialBoot = false
MemcardJamOrDefault = `default`

script memcard_check_for_existing_save 
	memcard_choose_storage_device
	GetMemCardDirectoryListing \{FileType = $current_save_file_type}
	if (<totalthps4filesoncard> = 1)

		return \{found = 1
			corrupt = 0}
	endif
	return \{found = 0
		corrupt = 0}
endscript

script memcard_wait_for_timer \{time = 3.0}
	begin
	if TimeGreaterThan <time>
		break
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script is_autosave_on 

	GetGlobalTags user_options savegame = <savegame>
	if (<autosave> = 1)
		return \{true}
	endif
	return \{false}
endscript

script memcard_pre_save_progress 
endscript

script memcard_post_load_progress 
	if (($primary_controller) = $MemcardController)
		restore_globals_from_global_tags
	endif
	scan_globaltag_downloads
	refresh_autokick_cheat
	get_savegame_from_controller \{controller = $MemcardController}
	reset_transient_tags savegame = <savegame>
endscript

script refresh_autokick_cheat 
	controller = 0
	max_controllers = 4
	begin
	if CheckForSignIn local controller_index = <controller>
		GetSavegameFromController controller = <controller>
		GetGlobalTags user_options savegame = <savegame>
		if (<unlock_Cheat_AutoKick> = 1 && <cheat_index7> = 1)
			turn_on_autokick = 1
		endif
		if (<unlock_Cheat_AlwaysSlide> = 1 && <cheat_index0> = 1)
			turn_on_autoslide = 1
		endif
		if (<unlock_Cheat_PerformanceMode> = 1 && <cheat_index3> = 1)
			turn_on_preformance = 1
		endif
		if (<unlock_Cheat_FreeDrum> = 1 && <cheat_index16> = 1)
			turn_on_drumfill = 1
		endif
	endif
	controller = (<controller> + 1)
	repeat <max_controllers>
	if GotParam \{turn_on_autokick}
		change \{Cheat_AutoKick = 1}
	else
		change \{Cheat_AutoKick = 2}
	endif
	if GotParam \{turn_on_autoslide}
		change \{Cheat_AlwaysSlide = 1}
	else
		change \{Cheat_AlwaysSlide = 2}
	endif
	if GotParam \{turn_on_preformance}
		change \{Cheat_PerformanceMode = 1}
	else
		change \{Cheat_PerformanceMode = 2}
	endif
	if GotParam \{turn_on_drumfill}
		change \{Cheat_FreeDrum = 1}
	else
		change \{Cheat_FreeDrum = 2}
	endif

endscript

script memcard_cleanup_messages 
	destroy_popup_warning_menu
endscript

script memcard_sequence_generic_done 
	if ($MemcardSavingOrLoading = Saving)
		if ($MemcardSuccess = true)

			ui_memcard_finish success = save controller = ($MemcardController)
		else

			MC_SetActiveFolder \{FolderIndex = -1}
			ui_memcard_finish failed = save controller = ($MemcardController)
		endif
	else
		if ($MemcardSuccess = true)

			ui_memcard_finish success = load controller = ($MemcardController)
		else

			MC_SetActiveFolder \{FolderIndex = -1}
			ui_memcard_finish failed = load controller = ($MemcardController)
		endif
	endif
	if ($current_save_file_type = jamsession)
		change \{jam_selected_song = $memcard_jamsession_file_name}
	endif
endscript

script memcard_sequence_retry 

	MC_WaitAsyncOpsFinished
	goto $MemcardRetryScript params = {<...> controller = ($MemcardController)}
endscript

script memcard_disable_saves_and_quit 
	get_savegame_from_controller controller = ($MemcardController)
	SetGlobalTags user_options savegame = <savegame> params = {autosave = 0}
	memcard_sequence_quit
endscript

script memcard_sequence_quit 

	mark_safe_for_shutdown
	goto $MemcardDoneScript params = <...>
endscript

script memcard_check_for_card 
	if NOT CardIsInSlot
		goto create_storagedevice_warning_menu params = <...>
	endif
endscript

script memcard_error 


	memcard_check_for_card
	goto <error> params = <params>
endscript

script memcard_sequence_cleanup_generic 
	if ($restartMenuMusic = 1)
		change \{restartMenuMusic = 0}

		if ($Menu_Music_On_Flag = 1)
			Menu_Music_Off
		endif
		spawnscriptnow \{menu_music_on}
	endif
	change \{MemcardDoneScript = nullscript}
	return
	MC_WaitAsyncOpsFinished
	memcard_cleanup_messages
	change \{MemcardDoneScript = nullscript}
	change \{MemcardRetryScript = nullscript}
	change \{MemcardController = $primary_controller}
	MC_SetActivePlayer \{QueryDefault}
endscript

script memcard_sequence_begin_bootup 
	spawnscriptnow memcard_sequence_begin_bootup_logic params = <...>
endscript

script memcard_sequence_begin_save 
	spawnscriptnow memcard_sequence_begin_save_logic params = <...>
endscript

script waitandfinishautosave 
	WaitOneGameFrame
	ui_flow_manager_respond_to_action \{action = memcard_sequence_save_success}
endscript

script memcard_sequence_begin_autosave 
	spawnscriptnow memcard_sequence_begin_autosave_logic params = <...>
endscript

script memcard_sequence_begin_load 
	spawnscriptnow memcard_sequence_begin_load_logic params = <...>
endscript

script memcard_sequence_begin_autoload 
	spawnscriptnow memcard_sequence_begin_autoload_logic params = <...>
endscript

script memcard_sequence_begin_save_jam 
	spawnscriptnow memcard_sequence_begin_save_jam_logic params = <...>
endscript

script memcard_sequence_begin_load_jam 
	spawnscriptnow memcard_sequence_begin_load_jam_logic params = <...>
endscript

script memcard_sequence_begin_rename_jam 
	spawnscriptnow memcard_sequence_begin_rename_jam_logic params = <...>
endscript

script memcard_sequence_begin_delete_jam 
	spawnscriptnow memcard_sequence_begin_delete_jam_logic params = <...>
endscript

script memcard_sequence_begin_ss_load 
	spawnscriptnow memcard_sequence_begin_ss_load_logic params = <...>
endscript

script memcard_sequence_begin_bootup_logic \{controller = $primary_controller}

	MC_WaitAsyncOpsFinished
	mark_unsafe_for_shutdown
	change \{MemcardDoneScript = memcard_sequence_generic_done}
	change \{MemcardRetryScript = memcard_sequence_begin_bootup_logic}
	change \{MemcardSavingOrLoading = Saving}
	change \{MemcardSuccess = false}
	change MemcardController = <controller>
	change \{MemcardInitialBoot = true}
	change \{MemcardJamOrDefault = `default`}
	change \{current_save_file_type = Progress}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_autosave_warning_boot_fs
		}}
	return
	memcard_validate_card_data StorageSelectorForce = <StorageSelectorForce> ValidatePrev = 0
	if (<found> = 1)
		goto \{memcard_load_file
			params = {
				LoadConfirmed = 1
			}}
	else
		if ($memcard_initial_boot = 0)
			goto \{memcard_save_file}
		else
			goto \{$MemcardDoneScript}
		endif
	endif
endscript

script memcard_sequence_begin_save_logic \{StorageSelectorForce = 1
		controller = $primary_controller}
	mark_unsafe_for_shutdown
	MC_WaitAsyncOpsFinished
	change \{MemcardDoneScript = memcard_sequence_generic_done}
	change \{MemcardRetryScript = memcard_sequence_begin_save_logic}
	change \{MemcardSavingOrLoading = Saving}
	change \{MemcardSuccess = false}
	change MemcardController = <controller>
	change \{MemcardInitialBoot = false}
	change \{MemcardJamOrDefault = `default`}
	ps2_memcard_set_autosave \{autosave = 0}
	change \{current_save_file_type = Progress}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_save_start_ingame_fs
		}}
	return
	memcard_validate_card_data StorageSelectorForce = <StorageSelectorForce> ValidatePrev = 0
	goto \{memcard_save_file}
endscript

script memcard_sequence_begin_autosave_logic \{controller = $primary_controller}
	mark_unsafe_for_shutdown
	MC_WaitAsyncOpsFinished
	disable_pause
	change \{MemcardDoneScript = memcard_sequence_generic_done}
	change \{MemcardRetryScript = memcard_sequence_begin_save_logic}
	change \{MemcardSavingOrLoading = Saving}
	change \{MemcardSuccess = false}
	change MemcardController = <controller>
	change \{MemcardInitialBoot = false}
	change \{MemcardJamOrDefault = `default`}
	get_savegame_from_controller controller = <controller>
	GetGlobalTags user_options savegame = <savegame>
	if (<autosave> = 0 && <requested_autosave> = 0)

		goto \{memcard_sequence_quit}
	endif
	if (<requested_autosave> = 1)
		ps2_memcard_set_autosave \{autosave = 0}
	else
		ps2_memcard_set_autosave \{autosave = 1}
	endif
	change \{current_save_file_type = Progress}
	destroy_loading_screen
	Wait \{16
		gameframes}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_save_start_ingame_fs
		}}
	return
	MC_SetActivePlayer userid = <controller>
	if NOT CardIsInSlot
		goto \{create_storagedevice_warning_menu}
	endif
	memcard_validate_card_data \{StorageSelectorForce = 0
		ValidatePrev = 1}
	if (<found> = 1)
		goto \{memcard_save_file
			params = {
				OverwriteConfirmed = 1
			}}
	else
		memcard_sequence_retry
	endif
endscript

script memcard_sequence_begin_load_logic \{StorageSelectorForce = 1
		controller = $primary_controller}
	mark_unsafe_for_shutdown
	MC_WaitAsyncOpsFinished
	change \{MemcardDoneScript = memcard_sequence_generic_done}
	change \{MemcardRetryScript = memcard_sequence_begin_load_logic}
	change \{MemcardSavingOrLoading = loading}
	change \{MemcardSuccess = false}
	change MemcardController = <controller>
	change \{MemcardInitialBoot = false}
	change \{MemcardJamOrDefault = `default`}
	change \{current_save_file_type = Progress}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_load_check_status_ingame_fs
		}}
	return
	memcard_validate_card_data StorageSelectorForce = <StorageSelectorForce> ValidatePrev = 0
	goto \{memcard_load_file}
endscript

script jam_memcard_validate_card_data \{StorageSelectorForce = 0}
	memcard_validate_card_data StorageSelectorForce = <StorageSelectorForce> ValidatePrev = 1 FileType = jamsession
	return <...>
endscript

script memcard_sequence_begin_save_jam_logic \{StorageSelectorForce = 0
		controller = $primary_controller}

	mark_unsafe_for_shutdown
	MC_WaitAsyncOpsFinished
	change \{MemcardDoneScript = memcard_sequence_generic_done}
	change \{MemcardRetryScript = memcard_sequence_begin_save_jam_logic}
	change \{MemcardSavingOrLoading = Saving}
	change \{MemcardSuccess = false}
	change MemcardController = <controller>
	change \{MemcardInitialBoot = false}
	change \{MemcardJamOrDefault = jam}
	jam_publish_update_playback_track \{guitar_num = 1}
	jam_publish_update_playback_track \{guitar_num = 2}
	jam_publish_update_playback_drumvocal_track
	downloaded = 0
	GetSongInfo
	change memcard_jamsession_song_version = <song_version>
	change memcard_jamsession_downloaded = <downloaded>
	if GotParam \{file_id}
		change memcard_jamsession_fileid = <file_id>
	endif
	change memcard_jamsession_playback_track1 = <playback_track1>
	change memcard_jamsession_playback_track2 = <playback_track2>
	change memcard_jamsession_playback_track_drums = <playback_track_drums>
	change memcard_jamsession_playback_track_vocals = <playback_track_vocals>
	ps2_memcard_set_autosave \{autosave = 0}
	change \{current_save_file_type = jamsession}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_save_start_ingame_fs
		}}
	return
	<card_was_in_slot> = false
	if CardIsInSlot
		<card_was_in_slot> = true
	endif
	jam_memcard_validate_card_data <...>
	if (<corrupt> = 0)
		goto memcard_save_jam params = {card_was_in_slot = <card_was_in_slot>}
	endif
endscript

script memcard_sequence_begin_load_jam_logic \{StorageSelectorForce = 0
		controller = $primary_controller}

	mark_unsafe_for_shutdown
	MC_WaitAsyncOpsFinished
	change \{MemcardDoneScript = memcard_sequence_generic_done}
	change \{MemcardRetryScript = memcard_sequence_begin_load_jam_logic}
	change \{MemcardSavingOrLoading = loading}
	change \{MemcardSuccess = false}
	change MemcardController = <controller>
	change \{MemcardInitialBoot = false}
	change \{MemcardJamOrDefault = jam}
	change \{current_save_file_type = jamsession}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_load_check_status_ingame_fs
		}}
	return
	jam_memcard_validate_card_data <...>
	goto \{memcard_load_jam}
endscript

script memcard_sequence_begin_delete_jam_logic \{controller = $primary_controller}

	mark_unsafe_for_shutdown
	MC_WaitAsyncOpsFinished
	change \{MemcardDoneScript = memcard_sequence_generic_done}
	change \{MemcardRetryScript = memcard_sequence_begin_delete_jam_logic}
	change \{MemcardSavingOrLoading = Saving}
	change \{MemcardSuccess = false}
	change MemcardController = <controller>
	change \{MemcardInitialBoot = false}
	change \{MemcardJamOrDefault = jam}
	change \{current_save_file_type = jamsession}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_delete_check_status_ingame_fs
		}}
	return
	jam_memcard_validate_card_data <...>
	goto \{memcard_delete_jam}
endscript

script guitar_memcard_save_success_sound 
	SoundEvent \{event = Save_Confirmed_SFX}
endscript

script dim_save_option_for_guest 
endscript
