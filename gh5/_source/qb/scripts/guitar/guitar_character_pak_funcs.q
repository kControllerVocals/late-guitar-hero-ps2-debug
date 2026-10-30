unloadpak_lock = 0
loadpak_lock = 0
loadpak_done = 0
loadpak_failed = 0
0x652da952 = 1

script smartunloadpak 
	if gotparam \{all}
		pass_params = {all}
	elseif gotparam \{pak_id}
		pass_params = {pak_id = <pak_id>}
	elseif gotparam \{pak_name}
		pass_params = {pak_name = <pak_name>}
	elseif gotparam \{tags}
		pass_params = {tags = <tags>}
	else

		return
	endif
	begin
	if NOT smartpak_unload <pass_params>
		return
	endif
	repeat
endscript

script smartloadpakman \{async = 1}

	if NOT ischecksum <pak_name>

	endif
	if smartpak_ispakloaded pak_name = <pak_name> pak_id = <pak_id>

		smartpak_load pak_name = <pak_name> pak_id = <pak_id> tags = {map = <map> <tags>}
		return \{true}
	endif
	if getpakmannumfreeslots map = <map>
		slot = <firstfreeslot>
		0x8dbdaee4 qs(0xa095962a) i = <slot>
	else
		0x8dbdaee4 \{qs(0x404d6310)}
		smartflushpak async = <async> single tags = {map = <map>}
		if NOT getpakmannumfreeslots map = <map>
			smartpak_dump

		endif
		slot = <firstfreeslot>
	endif

	if NOT loadpakmanasync map = <map> pak_name = <pak_name> async = <async> slot = <slot>
		return \{false}
	endif
	smartpak_load new pak_name = <pak_name> pak_id = <pak_id> map = <map> slot = <slot> tags = {map = <map> <tags>}
	return \{true}
endscript

script smartloadpak \{async = 1}

	if ischecksum <pak_name>

	endif
	if smartpak_ispakloaded pak_name = <pak_name> pak_id = <pak_id>

		smartpak_load pak_name = <pak_name> pak_id = <pak_id> tags = {heap = <heap> <tags>}
		return \{true}
	endif
	smartflushpak async = <async> tags = {heap = <heap>}
	if NOT loadpakasync pak_name = <pak_name> async = <async> heap = <heap> is_raw = <is_raw> no_vram = <no_vram>
		return \{false}
	endif

	smartpak_load new pak_name = <pak_name> pak_id = <pak_id> tags = {heap = <heap> <tags>}
	return \{true}
endscript

script smartflushpak \{async = 1}

	if gotparam \{all}
		pass_params = {all}
	elseif gotparam \{pak_id}
		pass_params = {pak_id = <pak_id>}
	elseif gotparam \{pak_name}
		pass_params = {pak_name = <pak_name>}
	elseif gotparam \{tags}
		pass_params = {tags = <tags>}
	else

		return
	endif
	smartpak_dump
	begin
	if NOT smartpak_flush <pass_params>
		return
	endif
	if gotparam \{flushed_map}

		loadpakmanasync async = <async> pak_name = none map = <flushed_map> slot = <flushed_slot>
	else

		unloadpakasync async = <async> checksum_pak_name = <flushed_pak> pak_name = <flushed_pak>
	endif
	removeparameter \{flushed_map}
	removeparameter \{flushed_slot}
	removeparameter \{flushed_pak}
	if gotparam \{single}
		return
	endif
	repeat
endscript

script loadpakmanasync \{slot = 0}

	setscriptcannotpause

	begin
	if ($loadpak_lock = 0)
		break
	endif
	wait \{1
		gameframe}
	repeat
	change \{loadpak_lock = 1}
	change \{loadpak_done = 0}
	onexitrun \{check_loadpak_lock}
	device = `default`
	if (<pak_name> != none)
		getcontentfolderindexfromfile <pak_filename>
		if (<device> = content)
			if NOT downloads_opencontentfolder content_index = <content_index>

				change \{loadpak_lock = 0}
				change \{loadpak_done = 0}
				return \{false}
			endif
		endif
	endif
	setpakmancurrentblock map = <map> pak = <pak_name> block_scripts = (1 - <async>) slot = <slot>
	if (<device> = content)
		downloads_closecontentfolder content_index = <content_index>
	endif
	change \{loadpak_lock = 0}
	change \{loadpak_done = 0}
	return \{true}
endscript

script unloadpakasync \{async = 1}

	setscriptcannotpause

	begin
	if ($unloadpak_lock = 0)
		break
	endif
	wait \{1
		gameframe}
	repeat
	change \{unloadpak_lock = 1}
	onexitrun \{check_unloadpak_lock}
	if gotparam \{checksum_pak_name}
		unload_params = {pak_name = <checksum_pak_name>}
	else
		unload_params = {<pak_name>}
	endif
	unloadpak <unload_params>
	if (<async> = 1)
		begin
		if waitunloadpak <unload_params> noblock
			break
		endif
		wait \{1
			gameframe}
		repeat
	else
		waitunloadpak <pak_name> block
	endif
	change \{unloadpak_lock = 0}
endscript

script check_unloadpak_lock 
	if ($unloadpak_lock = 1)

	endif
endscript

script loadpakasync \{async = 1
		is_raw = 0}

	setscriptcannotpause

	if (<is_raw> = 1)
		is_raw_flag = {is_raw}
	endif
	begin
	if ($loadpak_lock = 0)
		break
	endif
	wait \{1
		gameframe}
	repeat
	change \{loadpak_lock = 1}
	change \{loadpak_done = 0}
	change \{loadpak_failed = 0}
	onexitrun \{check_loadpak_lock}
	change \{0x652da952 = 0}
	getcontentfolderindexfromfile <pak_name>
	if (<device> = content)
		if NOT downloads_opencontentfolder content_index = <content_index>

			change \{loadpak_lock = 0}
			change \{loadpak_done = 0}
			return \{false}
		endif
	endif
	if (<async> = 0)
		if (gotparam no_vram)
			if NOT loadpak <pak_name> heap = <heap> device = <device> <is_raw_flag> content_id = <content_id> no_vram
				change \{loadpak_failed = 1}
			endif
		else
			if NOT loadpak <pak_name> heap = <heap> device = <device> <is_raw_flag> content_id = <content_id>
				change \{loadpak_failed = 1}
			endif
		endif
		change \{loadpak_done = 1}
	else
		if (gotparam no_vram)
			loadpak <pak_name> heap = <heap> load_callback = loadpakasync_callback callback_data = none device = <device> content_id = <content_id> <is_raw_flag> no_vram
		else
			loadpak <pak_name> heap = <heap> load_callback = loadpakasync_callback callback_data = none device = <device> content_id = <content_id> <is_raw_flag>
		endif
	endif
	begin
	if ($loadpak_done = 1)
		break
	endif
	wait \{1
		gameframe}
	repeat
	if (<device> = content)
		downloads_closecontentfolder content_index = <content_index>
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

script loadpakasync_callback 
	if NOT (<result> = 0)
		change \{loadpak_done = 1}
		change \{loadpak_failed = 1}
	endif
	if gotparam \{end}
		change \{loadpak_done = 1}
	endif
endscript
