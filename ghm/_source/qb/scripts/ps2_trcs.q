restartmenumusic = 0
0xafe47fe2 = 0x00000000
0xeb206b72 = 0x00000000
0xe674201a = 0x00000000
0x5e74f644 = 0x00000000
ps2_memcard_autosave = 0

script ps2_memcard_set_autosave 
	change ps2_memcard_autosave = <autosave>
endscript

script stop_flow_manager_and_return_to_ui_state_machine 
	0x8dbdaee4 \{qs(0x075f70e6)}
	wait \{5
		gameframe}
	destroy_ps2_saveload_screen
	if ($restartmenumusic = 1)
		change \{restartmenumusic = 0}
		if ($menu_music_on_flag = 1)
			menu_music_off
		endif
		spawnscriptnow \{menu_music_on}
	endif
	shut_down_flow_manager
	memcard_sequence_quit
endscript

script ps2_memcard_load_check_status \{0x76001281 = 1}
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
	if ($0x64fa86d1 = progress)
		memcard_check_for_existing_save
		if (<found> = 0)
			0x80d82aa7 \{progress}
			getmemcardspaceavailable

			if cardisinslot
				if ((<0x76001281> = 1) && (<spacerequired> > <spaceavailable>))
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
	setsavefilename \{filetype = $0x64fa86d1}
	getglobaltags \{globaltag_checksum
		params = globaltag_checksum}
	oldglobaltag_checksum = <globaltag_checksum>
	unload_songqpak
	mempushcontext \{heap_song}
	if loadfrommemorycard \{filetype = $0x64fa86d1}
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

script 0x29eee292 \{0x76001281 = 1}
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
	endif
	0x80d82aa7 \{jamsession}
	getmemcardspaceavailable
	if ((<0x76001281> = 1) && (<spacerequired> > <spaceavailable>))
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

script 0x4dc01ebe 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	wait \{5
		gameframe}
	if getmemcarddirectorylisting \{filetype = jamsession}
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
	wait \{3
		seconds}
	if NOT cardisinslot
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	endif
	if NOT ($0x64fa86d1 = jamsession)

	endif
	if memcardfileexists \{type = jamsession
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
	wait \{5
		gameframe}
	setsavefilename \{filetype = $0x64fa86d1}
	if deletememcardfile \{filetype = $0x64fa86d1}

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
	if ($0x64fa86d1 = jamsession)
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = 0xddf6d24c
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
	wait \{5
		gameframe}
	if screenelementexists \{id = gh3c_fade_box}
		destroyscreenelement \{id = gh3c_fade_box}
	endif
	if cardisnew
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = new_memcard
			}}
		return
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
	if ($0x64fa86d1 = progress)
		if NOT ($0xafe47fe2 = overwrite)
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
	setsavefilename \{filetype = $0x64fa86d1}
	memcard_pre_save_progress
	write_globals_to_global_tags
	if savetomemorycard \{filetype = $0x64fa86d1}
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
	if ($0x64fa86d1 = jamsession)
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
	0x57874f22
	if gotparam \{0x8790b8d7}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = new_memcard
			}}
	elseif gotparam \{0x6036448f}
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
	elseif gotparam \{0xd14ac53c}
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
	wait \{5
		gameframe}
	if NOT formatcard
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
	wait \{3
		seconds}
	setglobaltags \{user_options
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
	if (<message> = boot_autosave_warning)
		0x40dc204d
	endif
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

script 0x785d4cd3 
	if (($ps2_memcard_autosave) = 1)
		change \{0xafe47fe2 = autosave}
	else
		change \{0xafe47fe2 = save}
	endif
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = continue
		}}
endscript

script ps2_memcard_existing_save_successor 
	if ($0xafe47fe2 = save)
		return \{flow_state = ps2_memcard_overwrite_confirm_ingame_fs}
	else
		return \{flow_state = ps2_memcard_save_ingame_fs}
	endif
endscript

script 0xdfb56609 

	change 0xafe47fe2 = <mode>
	return flow_state = <flow_state>
endscript

script 0xf321b8b3 

	change 0xeb206b72 = <message>
	return \{flow_state = 0x3a26f17e}
endscript

script 0x7497975c 

	change 0xe674201a = <message>
endscript

script 0xb391c092 
	0x7497975c <...>
	return \{flow_state = 0x2f2e9d9b}
endscript

script 0xbd668983 
	0x7497975c <...>
	return \{flow_state = 0x30a8c721}
endscript

script 0x0b6c2529 
	0x7497975c <...>
	return \{flow_state = 0x062005da}
endscript

script 0xa028e4da 

	change 0x5e74f644 = <message>
	return \{flow_state = 0x12f2ab7e}
endscript

script ps2_get_saveload_successor 
	return \{flow_state = hack_ps2_saveload_successor}
endscript
