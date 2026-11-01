ps2_saveload_successor = null_flow_state
ps2_saveload_successor_action_state = {
}
gh4progressiconspacerequired = 74
gh4jamsessioniconspacerequired = 74
restartmenumusic = 0
savefiletypeindex = 0
progressfiletypeindex = 0
jamsessionfiletypeindex = 1

script ps2_leave_saveload_flow 
	wait \{5
		gameframe}
	destroy_ps2_trc_menu
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = leave_saveload_flow
		}}
	if ($restartmenumusic = 1)
		change \{restartmenumusic = 0}
		if ($menu_music_on_flag = 1)
			menu_music_off
		endif
		spawnscriptnow \{menu_music_on}
	endif
endscript

script ps2_memcard_load_check_status 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	wait \{3
		seconds}
	0x57874f22
	if gotparam \{0x6036448f}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	elseif gotparam \{0xd14ac53c}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_save
			}}
		return
	endif
	getmemcarddirectorylisting \{filetype = jamsession}
	change jam_curr_directory_listing = <directorylisting>

	if ($savefiletypeindex = $progressfiletypeindex)
		memcard_check_for_existing_save
		if (<found> = 0)
			0x80d82aa7 (($memcard_file_types_ps2 [$savefiletypeindex]).name)
			getmemcardspaceavailable

			if cardisinslot
				if (<spacerequired> > <spaceavailable>)
					spawnscriptnow \{ui_flow_manager_respond_to_action
						params = {
							action = insufficient_space
						}}
				else
					change \{memcardsavingorloading = saving}
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
			change \{memcardsavingorloading = loading}
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
	wait \{5
		gameframe}
	setsavefilename filetype = (($memcard_file_types_ps2 [$savefiletypeindex]).name) name = ($memcard_file_types_ps2 [$savefiletypeindex].file_name)
	getglobaltags \{globaltag_checksum
		params = globaltag_checksum}
	oldglobaltag_checksum = <globaltag_checksum>
	unload_songqpak
	mempushcontext \{heap_song}
	if loadfrommemorycard filetype = (($memcard_file_types_ps2 [$savefiletypeindex]).name)
		mempopcontext
		memcard_post_load_progress
		change \{memcardsuccess = true}
	else
		mempopcontext
		if NOT cardisinslot
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = no_memcard
				}}
			return
		elseif gotparam \{corrupteddata}
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
	getglobaltags \{globaltag_checksum
		params = globaltag_checksum
		noassert = 1}
	if NOT (<globaltag_checksum> = <oldglobaltag_checksum>)

		clearglobaltags
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

script ps2_memcard_delete_check_status 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	wait \{3
		seconds}
	if NOT cardisinslot
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	endif
	if NOT ($savefiletypeindex = $jamsessionfiletypeindex)

	endif
	if memcardfileexists \{type = jamsession
			name = $memcard_jamsession_ps2_file_name}
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
	wait \{5
		gameframe}
	setsavefilename filetype = (($memcard_file_types_ps2 [$savefiletypeindex]).name) name = ($memcard_file_types_ps2 [$savefiletypeindex].file_name)
	if deletememcardfile filetype = (($memcard_file_types_ps2 [$savefiletypeindex]).name)

		change \{memcardsuccess = true}
	else
		if NOT cardisinslot
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
	wait \{1
		second}
	if ($savefiletypeindex = $jamsessionfiletypeindex)
		getmemcarddirectorylisting \{filetype = jamsession}
		change jam_curr_directory_listing = <directorylisting>

	endif
	ps2_leave_saveload_flow
endscript

script ps2_memcard_save_check_status \{no_check = 0
		check_for_existing = 0}
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	wait \{5
		gameframe}
	if screenelementexists \{id = gh3c_fade_box}
		destroyscreenelement \{id = gh3c_fade_box}
	endif
	if (<no_check> = 0)
		if cardisnew
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = new_memcard
				}}
			return
		endif
	endif
	0x57874f22
	if gotparam \{0x6036448f}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	elseif gotparam \{0xd14ac53c}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = not_formatted
			}}
		return
	endif
	if ($savefiletypeindex = $progressfiletypeindex)
		if (<check_for_existing> = 1)
			memcard_check_for_existing_save
			if NOT (<found> = 0)
				if NOT cardisinslot
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
	wait \{5
		gameframe}
	if ($progression_pop_count = 1)
		pop_later = 1
		progression_push_current
	else
		pop_later = 0
	endif
	setsavefilename filetype = (($memcard_file_types_ps2 [$savefiletypeindex]).name) name = (($memcard_file_types_ps2 [$savefiletypeindex]).file_name)
	memcard_pre_save_progress
	write_globals_to_global_tags
	if savetomemorycard filetype = (($memcard_file_types_ps2 [$savefiletypeindex]).name)
		change \{memcardsuccess = true}
	else

		if savefailedduetoinsufficientspace
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
	if ($savefiletypeindex = $jamsessionfiletypeindex)
		getmemcarddirectorylisting \{filetype = jamsession}
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
	wait \{5
		gameframe}
	if cardisnew
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = new_memcard
			}}
		return
	endif
	if cardisformatted
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = is_formatted
			}}
		return
	endif
	wait \{5
		gameframe}
	if cardisformatted
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = is_formatted
			}}
		return
	endif
	if NOT cardisinslot
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	endif
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = status_ok
		}}
endscript

script ps2_memcard_format 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	wait \{5
		gameframe}
	if NOT formatcard
		if NOT cardisinslot
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = no_memcard
				}}
			return
		else

		endif
	endif
	destroy_ps2_saveload_screen
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = success
		}}
endscript

script ps2_replace_file 
	clearglobaltags
	setup_globaltags
	deletememcardfile filetype = (($memcard_file_types_ps2 [$savefiletypeindex]).name)
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = 0x5b5fc631
		}}
endscript

script ps2_disable_autosave 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	wait \{3
		seconds}
	setglobaltags \{user_options
		params = {
			autosave = 0
		}}
	ps2_leave_saveload_flow
endscript

script ps2_set_saveload_successor 
	get_flow_manager_action_state \{action = continue}
	change ps2_saveload_successor = <state>
	hack_ps2_set_saveload_successor_checksum <state>
endscript

script ps2_get_saveload_successor 
	return \{flow_state = hack_ps2_saveload_successor}
endscript

script ps2_memcard_set_options_as_successor 
	ps2_memcard_set_autosave \{autosave = 0}
	change \{ps2_saveload_successor = options_data_settings_fs}
	hack_ps2_set_saveload_successor_checksum \{options_data_settings_fs}
endscript

script ps2_memcard_saveload_complete 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	wait \{1
		second}
	ps2_leave_saveload_flow
endscript

script ps2_memcard_format_complete 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	wait \{1
		second}
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = continue
		}}
endscript

script ps2_memcard_message 
	change \{check_for_unplugged_controllers = 1}
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	add_user_control_helper \{text = qs(0x182f0173)
		button = green
		z = 1006}
	createscreenelement \{type = spriteelement
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
	launchevent type = focus target = <id>
endscript
ps2_memcard_autosave = 0

script ps2_memcard_set_autosave 
	change ps2_memcard_autosave = <autosave>
endscript

script ps2_memcard_save_successor 
	if (($ps2_memcard_autosave) = 0)
		return \{flow_state = ps2_memcard_save_ingame_fs}
	else
		return \{flow_state = ps2_memcard_autosave_ingame_fs}
	endif
endscript

script ps2_memcard_existing_save_successor 
	if (($ps2_memcard_autosave) = 0)
		return \{flow_state = ps2_memcard_overwrite_confirm_ingame_fs}
	else
		ps2_memcard_save_successor
		return flow_state = <flow_state>
	endif
endscript
