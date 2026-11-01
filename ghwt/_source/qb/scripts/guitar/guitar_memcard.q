max_memcard_filename_length = 15
savingorloading = saving
memcard_using_new_save_system = 0
memcard_default_title = 'Guitar Hero World Tour'
memcard_content_name = qs(0x7235ca15)
memcard_content_jamsession_name = qs(0xcf50afcb)
save_data_dirty = 0
memcard_file_types = [
	{
		name = progress
		version = 57
		fixed_size = 2097152
		use_temp_pools = false
		is_binary_file = true
		num_bytes_per_frame = 102400
	}
	{
		name = jamsession
		version = 80
		fixed_size = 1150976
		use_temp_pools = false
		is_binary_file = false
		num_bytes_per_frame = 102400
	}
]
memcard_file_types_ps2 = [
	{
		name = progress
		file_name = 'GH4Progress'
		suffix = 'Progress'
		folder_name = 'GH World Tour'
		icon = 'memcard\\cas.png'
		version = 54
		fixed_size = 409600
		menu_text = 'Game Progress'
		menu_icon = logo_cas
	}
	{
		name = jamsession
		file_name = 'GH4JamSession'
		suffix = '-jam'
		folder_name = 'GH World Tour'
		icon = 'memcard\\cas.png'
		version = 80
		fixed_size = 122880
		menu_text = 'JAM SESSION'
		menu_icon = thpg
	}
]
memcard_folder_desc = {
	guitarcontent = {
		icon_xen = 'memcard\\gh.png'
		icon_ps3 = 'memcard\\ICON0.PNG'
		file_types = [
			{
				name = progress
				slots_reserve = 1
			}
		]
	}
	jamsessionscontent = {
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
memcarddonescript = nullscript
memcardretryscript = nullscript
memcardsavingorloading = saving
memcardsuccess = false
memcardcontroller = $primary_controller
memcardinitialboot = false
memcardjamordefault = `default`

script memcard_check_for_existing_save 
	if ($memcard_using_new_save_system = 0)
		if isps3
			return \{found = 0}
		endif
		memcard_choose_storage_device
		getmemcarddirectorylisting filetype = (($memcard_file_types_ps2 [$savefiletypeindex]).name)
		if (<totalthps4filesoncard> = 1)

			return \{found = 1
				corrupt = 0}
		endif
	else
		memcard_enum_folders
		mc_waitasyncopsfinished
		memcard_check_for_card
		if mc_folderexists \{foldername = $memcard_content_name}
			mc_setactivefolder \{foldername = $memcard_content_name}
			mc_loadtocinactivefolder
			if (<result> = false)
				return \{found = 1
					corrupt = 1}
			endif
			if memcardfileexists \{filename = $memcard_file_name
					filetype = progress}
				return \{found = 1
					corrupt = 0}
			else
				return \{found = 1
					corrupt = 1}
			endif
		endif
	endif
	return \{found = 0
		corrupt = 0}
endscript

script memcard_wait_for_timer \{time = 3.0}
	begin
	if timegreaterthan <time>
		break
	endif
	waitonegameframe
	repeat
endscript

script is_autosave_on 

	getglobaltags user_options savegame = <savegame>
	if (<autosave> = 1)
		return \{true}
	endif
	return \{false}
endscript

script memcard_pre_save_progress 
endscript

script memcard_post_load_progress 
	if (($primary_controller) = $memcardcontroller)
		restore_globals_from_global_tags
	endif
	scan_globaltag_downloads
endscript

script memcard_cleanup_messages 
	destroy_popup_warning_menu
endscript

script memcard_sequence_generic_done 
	if ($memcardsavingorloading = saving)
		if ($memcardsuccess = true)

			ui_memcard_finish success = save controller = ($memcardcontroller)
		else

			mc_setactivefolder \{folderindex = -1}
			ui_memcard_finish failed = save controller = ($memcardcontroller)
		endif
	else
		if ($memcardsuccess = true)

			ui_memcard_finish success = load controller = ($memcardcontroller)
		else

			mc_setactivefolder \{folderindex = -1}
			ui_memcard_finish failed = load controller = ($memcardcontroller)
		endif
	endif
	if ($savefiletypeindex = $jamsessionfiletypeindex)
		change \{jam_selected_song = $memcard_jamsession_file_name}
	endif
endscript

script memcard_sequence_retry 

	mc_waitasyncopsfinished
	goto $memcardretryscript params = {<...> controller = ($memcardcontroller)}
endscript

script memcard_disable_saves_and_quit 
	get_savegame_from_controller controller = ($memcardcontroller)
	setglobaltags user_options savegame = <savegame> params = {autosave = 0}
	memcard_sequence_quit
endscript

script memcard_sequence_quit 

	mark_safe_for_shutdown
	goto $memcarddonescript params = <...>
endscript

script memcard_check_for_card 
	if NOT cardisinslot
		goto create_storagedevice_warning_menu params = <...>
	endif
endscript

script memcard_error 


	memcard_check_for_card
	goto <error> params = <params>
endscript

script memcard_sequence_cleanup_generic 
	if isps2
		if ($restartmenumusic = 1)
			change \{restartmenumusic = 0}

			if ($menu_music_on_flag = 1)
				menu_music_off
			endif
			spawnscriptnow \{menu_music_on}
		endif
		change \{memcarddonescript = nullscript}
		return
	endif
	mc_waitasyncopsfinished
	memcard_cleanup_messages
	change \{memcarddonescript = nullscript}
	change \{memcardretryscript = nullscript}
	change \{memcardcontroller = $primary_controller}
	mc_setactiveplayer \{querydefault}
endscript

script memcard_sequence_begin_bootup 
	spawnscriptnow memcard_sequence_begin_bootup_logic params = <...>
endscript

script memcard_sequence_begin_save 
	spawnscriptnow memcard_sequence_begin_save_logic params = <...>
endscript

script 0x57db8579 
	waitonegameframe
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


	mc_waitasyncopsfinished
	mark_unsafe_for_shutdown
	change \{memcarddonescript = memcard_sequence_generic_done}
	change \{memcardretryscript = memcard_sequence_begin_bootup_logic}
	change \{memcardsavingorloading = saving}
	change \{memcardsuccess = false}
	change memcardcontroller = <controller>
	change \{memcardinitialboot = true}
	change \{memcardjamordefault = `default`}
	change \{savefiletypeindex = $progressfiletypeindex}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_load_check_status_boot_fs
		}}
	return
	memcard_validate_card_data storageselectorforce = <storageselectorforce> validateprev = 0
	if (<found> = 1)
		goto \{memcard_load_file
			params = {
				loadconfirmed = 1
			}}
	else
		if ($memcard_initial_boot = 0)
			goto \{memcard_save_file}
		else
			goto \{$memcarddonescript}
		endif
	endif
endscript

script memcard_sequence_begin_save_logic \{storageselectorforce = 1
		controller = $primary_controller}
	mark_unsafe_for_shutdown
	mc_waitasyncopsfinished
	change \{memcarddonescript = memcard_sequence_generic_done}
	change \{memcardretryscript = memcard_sequence_begin_save_logic}
	change \{memcardsavingorloading = saving}
	change \{memcardsuccess = false}
	change memcardcontroller = <controller>
	change \{memcardinitialboot = false}
	change \{memcardjamordefault = `default`}
	ps2_memcard_set_autosave \{autosave = 0}
	change \{savefiletypeindex = $progressfiletypeindex}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_save_check_status_ingame_fs
		}}
	return
	memcard_validate_card_data storageselectorforce = <storageselectorforce> validateprev = 0
	goto \{memcard_save_file}
endscript

script memcard_sequence_begin_autosave_logic \{controller = $primary_controller}
	mark_unsafe_for_shutdown
	mc_waitasyncopsfinished
	disable_pause
	change \{memcarddonescript = memcard_sequence_generic_done}
	change \{memcardretryscript = memcard_sequence_begin_save_logic}
	change \{memcardsavingorloading = saving}
	change \{memcardsuccess = false}
	change memcardcontroller = <controller>
	change \{memcardinitialboot = false}
	change \{memcardjamordefault = `default`}
	get_savegame_from_controller controller = <controller>
	getglobaltags user_options savegame = <savegame>
	if (<autosave> = 0 && <requested_autosave> = 0)

		goto \{memcard_sequence_quit}
	endif
	if (<requested_autosave> = 1)
		ps2_memcard_set_autosave \{autosave = 0}
	else
		ps2_memcard_set_autosave \{autosave = 1}
	endif
	change \{savefiletypeindex = $progressfiletypeindex}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_save_check_status_ingame_fs
		}}
	return
	mc_setactiveplayer userid = <controller>
	if NOT cardisinslot
		goto \{create_storagedevice_warning_menu}
	endif
	memcard_validate_card_data \{storageselectorforce = 0
		validateprev = 1}
	if (<found> = 1)
		goto \{memcard_save_file
			params = {
				overwriteconfirmed = 1
			}}
	else
		memcard_sequence_retry
	endif
endscript

script memcard_sequence_begin_load_logic \{storageselectorforce = 1
		controller = $primary_controller}
	mark_unsafe_for_shutdown
	mc_waitasyncopsfinished
	change \{memcarddonescript = memcard_sequence_generic_done}
	change \{memcardretryscript = memcard_sequence_begin_load_logic}
	change \{memcardsavingorloading = loading}
	change \{memcardsuccess = false}
	change memcardcontroller = <controller>
	change \{memcardinitialboot = false}
	change \{memcardjamordefault = `default`}
	change \{savefiletypeindex = $progressfiletypeindex}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_load_check_status_ingame_fs
		}}
	return
	memcard_validate_card_data storageselectorforce = <storageselectorforce> validateprev = 0
	goto \{memcard_load_file}
endscript

script jam_memcard_validate_card_data \{storageselectorforce = 0}
	memcard_validate_card_data storageselectorforce = <storageselectorforce> validateprev = 1 filetype = jamsession
	return <...>
endscript

script memcard_sequence_begin_save_jam_logic \{storageselectorforce = 0
		controller = $primary_controller}

	mark_unsafe_for_shutdown
	mc_waitasyncopsfinished
	change \{memcarddonescript = memcard_sequence_generic_done}
	change \{memcardretryscript = memcard_sequence_begin_save_jam_logic}
	change \{memcardsavingorloading = saving}
	change \{memcardsuccess = false}
	change memcardcontroller = <controller>
	change \{memcardinitialboot = false}
	change \{memcardjamordefault = jam}
	jam_publish_update_playback_track \{guitar_num = 1}
	jam_publish_update_playback_track \{guitar_num = 2}
	jam_publish_update_playback_drumvocal_track
	downloaded = 0
	getsonginfo
	change memcard_jamsession_song_version = <song_version>
	change memcard_jamsession_downloaded = <downloaded>
	if gotparam \{file_id}
		change memcard_jamsession_fileid = <file_id>
	endif
	change memcard_jamsession_playback_track1 = <playback_track1>
	change memcard_jamsession_playback_track2 = <playback_track2>
	change memcard_jamsession_playback_track_drums = <playback_track_drums>
	change memcard_jamsession_playback_track_vocals = <playback_track_vocals>
	ps2_memcard_set_autosave \{autosave = 0}
	change \{savefiletypeindex = $jamsessionfiletypeindex}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_save_check_status_ingame_fs
		}}
	return
	<card_was_in_slot> = false
	if cardisinslot
		<card_was_in_slot> = true
	endif
	jam_memcard_validate_card_data <...>
	if (<corrupt> = 0)
		goto memcard_save_jam params = {card_was_in_slot = <card_was_in_slot>}
	endif
endscript

script memcard_sequence_begin_load_jam_logic \{storageselectorforce = 0
		controller = $primary_controller}

	mark_unsafe_for_shutdown
	mc_waitasyncopsfinished
	change \{memcarddonescript = memcard_sequence_generic_done}
	change \{memcardretryscript = memcard_sequence_begin_load_jam_logic}
	change \{memcardsavingorloading = loading}
	change \{memcardsuccess = false}
	change memcardcontroller = <controller>
	change \{memcardinitialboot = false}
	change \{memcardjamordefault = jam}
	change \{savefiletypeindex = $jamsessionfiletypeindex}
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
	mc_waitasyncopsfinished
	change \{memcarddonescript = memcard_sequence_generic_done}
	change \{memcardretryscript = memcard_sequence_begin_delete_jam_logic}
	change \{memcardsavingorloading = saving}
	change \{memcardsuccess = false}
	change memcardcontroller = <controller>
	change \{memcardinitialboot = false}
	change \{memcardjamordefault = jam}
	change \{savefiletypeindex = $jamsessionfiletypeindex}
	spawnscriptnow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_delete_check_status_ingame_fs
		}}
	return
	jam_memcard_validate_card_data <...>
	goto \{memcard_delete_jam}
endscript

script guitar_memcard_save_success_sound 
	soundevent \{event = save_confirmed_sfx}
endscript

script dim_save_option_for_guest 
endscript
