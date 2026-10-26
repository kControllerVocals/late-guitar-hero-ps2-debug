unloadpak_lock = 0
loadpak_lock = 0
loadpak_done = 0
loadpak_failed = 0
character_pak_loadpak_fired = 1

script SmartUnloadPak 
	if GotParam \{all}
		pass_params = {all}
	elseif GotParam \{pak_id}
		pass_params = {pak_id = <pak_id>}
	elseif GotParam \{pak_name}
		pass_params = {pak_name = <pak_name>}
	elseif GotParam \{tags}
		pass_params = {tags = <tags>}
	else

		return
	endif
	begin
	if NOT SmartPak_Unload <pass_params>
		return
	endif
	repeat
endscript

script SmartLoadPakman \{async = 1}

	if NOT IsChecksum <pak_name>

	endif
	if SmartPak_IsPakLoaded pak_name = <pak_name> pak_id = <pak_id>

		SmartPak_Load pak_name = <pak_name> pak_id = <pak_id> tags = {map = <map> <tags>}
		return \{true}
	endif
	if GetPakManNumFreeSlots map = <map>
		slot = <firstfreeslot>
		debug_Printf qs(0xa095962a) i = <slot>
	else
		debug_Printf \{qs(0x404d6310)}
		SmartFlushPak async = <async> single tags = {map = <map>}
		if NOT GetPakManNumFreeSlots map = <map>
			SmartPak_Dump

		endif
		slot = <firstfreeslot>
	endif

	if NOT LoadPakManAsync map = <map> pak_name = <pak_name> async = <async> slot = <slot>
		return \{false}
	endif
	SmartPak_Load new pak_name = <pak_name> pak_id = <pak_id> map = <map> slot = <slot> tags = {map = <map> <tags>}
	return \{true}
endscript

script SmartLoadPak \{async = 1}

	if IsChecksum <pak_name>

	endif
	if SmartPak_IsPakLoaded pak_name = <pak_name> pak_id = <pak_id>

		SmartPak_Load pak_name = <pak_name> pak_id = <pak_id> tags = {heap = <heap> <tags>}
		return \{true}
	endif
	SmartFlushPak async = <async> tags = {heap = <heap>}
	if NOT LoadPakAsync pak_name = <pak_name> async = <async> heap = <heap> is_raw = <is_raw> no_vram = <no_vram>
		return \{false}
	endif

	SmartPak_Load new pak_name = <pak_name> pak_id = <pak_id> tags = {heap = <heap> <tags>}
	return \{true}
endscript

script SmartFlushPak \{async = 1}

	if GotParam \{all}
		pass_params = {all}
	elseif GotParam \{pak_id}
		pass_params = {pak_id = <pak_id>}
	elseif GotParam \{pak_name}
		pass_params = {pak_name = <pak_name>}
	elseif GotParam \{tags}
		pass_params = {tags = <tags>}
	else

		return
	endif
	SmartPak_Dump
	begin
	if NOT SmartPak_Flush <pass_params>
		return
	endif
	if GotParam \{flushed_map}

		LoadPakManAsync async = <async> pak_name = none map = <flushed_map> slot = <flushed_slot>
	else

		UnloadPakAsync async = <async> checksum_pak_name = <flushed_pak> pak_name = <flushed_pak>
	endif
	RemoveParameter \{flushed_map}
	RemoveParameter \{flushed_slot}
	RemoveParameter \{flushed_pak}
	if GotParam \{single}
		return
	endif
	repeat
endscript

script LoadPakManAsync \{slot = 0}

	SetScriptCannotPause

	begin
	if ($loadpak_lock = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	change \{loadpak_lock = 1}
	change \{loadpak_done = 0}
	OnExitRun \{check_loadpak_lock}
	device = `default`
	if (<pak_name> != none)
		GetContentFolderIndexFromFile <pak_filename>
		if (<device> = content)
			if NOT Downloads_OpenContentFolder content_index = <content_index>

				change \{loadpak_lock = 0}
				change \{loadpak_done = 0}
				return \{false}
			endif
		endif
	endif
	SetPakManCurrentBlock map = <map> pak = <pak_name> block_scripts = (1 - <async>) slot = <slot>
	if (<device> = content)
		Downloads_CloseContentFolder content_index = <content_index>
	endif
	change \{loadpak_lock = 0}
	change \{loadpak_done = 0}
	return \{true}
endscript

script UnloadPakAsync \{async = 1}

	SetScriptCannotPause

	begin
	if ($unloadpak_lock = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	change \{unloadpak_lock = 1}
	OnExitRun \{check_unloadpak_lock}
	if GotParam \{checksum_pak_name}
		unload_params = {pak_name = <checksum_pak_name>}
	else
		unload_params = {<pak_name>}
	endif
	UnloadPak <unload_params>
	if (<async> = 1)
		begin
		if WaitUnloadPak <unload_params> noblock
			break
		endif
		Wait \{1
			gameframe}
		repeat
	else
		WaitUnloadPak <pak_name> Block
	endif
	change \{unloadpak_lock = 0}
endscript

script check_unloadpak_lock 
	if ($unloadpak_lock = 1)

	endif
endscript

script LoadPakAsync \{async = 1
		is_raw = 0}

	SetScriptCannotPause

	if (<is_raw> = 1)
		is_raw_flag = {is_raw}
	endif
	begin
	if ($loadpak_lock = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	change \{loadpak_lock = 1}
	change \{loadpak_done = 0}
	change \{loadpak_failed = 0}
	OnExitRun \{check_loadpak_lock}
	change \{character_pak_loadpak_fired = 0}
	GetContentFolderIndexFromFile <pak_name>
	if (<device> = content)
		if NOT Downloads_OpenContentFolder content_index = <content_index>

			change \{loadpak_lock = 0}
			change \{loadpak_done = 0}
			return \{false}
		endif
	endif
	if (<async> = 0)
		if (GotParam no_vram)
			if NOT LoadPak <pak_name> heap = <heap> device = <device> <is_raw_flag> content_id = <content_id> no_vram
				change \{loadpak_failed = 1}
			endif
		else
			if NOT LoadPak <pak_name> heap = <heap> device = <device> <is_raw_flag> content_id = <content_id>
				change \{loadpak_failed = 1}
			endif
		endif
		change \{loadpak_done = 1}
	else
		if (GotParam no_vram)
			LoadPak <pak_name> heap = <heap> load_callback = LoadPakAsync_callback callback_data = none device = <device> content_id = <content_id> <is_raw_flag> no_vram
		else
			LoadPak <pak_name> heap = <heap> load_callback = LoadPakAsync_callback callback_data = none device = <device> content_id = <content_id> <is_raw_flag>
		endif
	endif
	begin
	if ($loadpak_done = 1)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	if (<device> = content)
		Downloads_CloseContentFolder content_index = <content_index>
		if ($loadpak_failed = 1)
			change \{loadpak_lock = 0}
			change \{loadpak_done = 0}
			return \{false}
		endif
	endif
	change \{loadpak_lock = 0}
	change \{loadpak_done = 0}
	return \{true}
endscript

script check_loadpak_lock 
	if ($loadpak_lock = 1)

	endif
endscript

script LoadPakAsync_callback 
	if NOT (<result> = 0)
		change \{loadpak_done = 1}
		change \{loadpak_failed = 1}
	endif
	if GotParam \{end}
		change \{loadpak_done = 1}
	endif
endscript
