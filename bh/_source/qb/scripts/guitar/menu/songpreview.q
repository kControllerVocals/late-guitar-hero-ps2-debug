
script create_songpreview 
	SetScriptCannotPause
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	KillSpawnedScript \{name = destroy_songpreview}
	begin
	if songpreview_is_safe
		break
	endif
	WaitOneGameFrame
	repeat
	if NOT ScriptIsRunning \{songpreview_monitor}
		spawnscriptnow \{songpreview_monitor}
	endif
endscript

script destroy_songpreview 
	SetScriptCannotPause
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	KillSpawnedScript \{name = create_songpreview}
	begin
	if songpreview_is_safe
		break
	endif
	WaitOneGameFrame
	repeat
	if ScriptIsRunning \{songpreview_monitor}
		KillSpawnedScript \{name = songpreview_monitor}
	endif
endscript

script pause_songpreview 
	change \{songpreview_paused = 1}
endscript

script unpause_songpreview 
	change \{songpreview_paused = 0}
endscript

script set_songpreview 

	change target_songpreview = <song>
endscript

script get_songpreview 
	return \{song = $target_songpreview}
endscript

script reset_songpreview 
	set_songpreview \{song = none}
endscript

script songpreview_is_safe 
	if NOT (($songpreview_locked) && (num_waiting_for_songpreview_lock = 0))
		return \{true}
	else
		return \{false}
	endif
endscript
songpreview_paused = 0
target_songpreview = none
current_songpreview = none
num_waiting_for_songpreview_lock = 0
songpreview_locked = 0

script increment_songpreview_lock_wait 
	change num_waiting_for_songpreview_lock = ($num_waiting_for_songpreview_lock + 1)
endscript

script decrement_songpreview_lock_wait 
	if ($num_waiting_for_songpreview_lock = 0)
		debug_ScriptAssert \{'Attempted to decriment songpreview lock wait count when it was already zero.'}
	endif
	change num_waiting_for_songpreview_lock = ($num_waiting_for_songpreview_lock - 1)
endscript

script songpreview_acquire_lock 
	OnExitRun \{decrement_songpreview_lock_wait}
	increment_songpreview_lock_wait
	if GotParam \{assert_available}
		if ($songpreview_locked = 1)
			debug_ScriptAssert \{'Expected songpreview lock to be free, but another script has already acquired it.'}
		endif
		change \{songpreview_locked = 1}
		return
	endif
	begin
	if NOT ($songpreview_locked = 1)
		change \{songpreview_locked = 1}
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script songpreview_release_lock 
	if NOT ($songpreview_locked)
		debug_ScriptAssert \{'Attempted to release songpreview lock, but it wasn\'t acquired.'}
	endif
	change \{songpreview_locked = 0}
endscript

script songpreview_monitor 
	SetScriptCannotPause
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request
		CheckWholeCallstack}
	OnExitRun \{deinit_songpreview_monitor}
	init_songpreview_monitor
	begin
	songpreview_update_song
	songpreview_play_song
	WaitOneGameFrame
	repeat
endscript

script init_songpreview_monitor 
	debug_Printf \{'init_songpreview_monitor'}
	SetScriptCannotPause
	OnExitRun \{songpreview_release_lock}
	songpreview_acquire_lock \{assert_available}
	SongStopPreview
endscript

script deinit_songpreview_monitor 
	debug_Printf \{'deinit_songpreview_monitor'}
	SetScriptCannotPause
	OnExitRun \{songpreview_release_lock}
	songpreview_acquire_lock \{assert_available}
	if NOT ($current_songpreview = none)
		SongStopPreview
		change \{current_songpreview = none}
	endif
endscript

script songpreview_update_song 
	OnExitRun \{songpreview_release_lock}
	songpreview_acquire_lock \{assert_available}
	target = ($target_songpreview)
	if (<target> = $current_songpreview)
		return
	endif
	if ($current_songpreview != none)
		SongStopPreview
		change \{current_songpreview = none}
	endif
	begin
	Wait \{0.5
		seconds}
	if ((<target>) = ($target_songpreview))
		break
	else
		<target> = ($target_songpreview)
	endif
	repeat
	change current_songpreview = <target>
endscript

script songpreview_get_song_data 

	if (<song> = none)
		debug_ScriptAssert \{'Attempted to get filename for \'none\'.'}
	endif
	get_song_prefix song = <song>
	get_song_struct song = <song>
	if StructureContains Structure = <song_struct> dlc_stream_name
		song_prefix = (<song_struct>.dlc_stream_name)
	endif
	return song_prefix = <song_prefix> song_struct = <song_struct>
endscript

script songpreview_play_song 
	OnExitRun \{songpreview_release_lock}
	songpreview_acquire_lock \{assert_available}
	if ($current_songpreview = none)
		return
	endif
	if SongIsPreviewPlaying
		if ($songpreview_paused = 1)
			SongStopPreview
		endif
		return
	endif
	if ($songpreview_paused = 1)
		return
	endif
	song = ($current_songpreview)
	debug_Printf 'Starting to play preview for %s.' s = <song>
	songpreview_get_song_data song = <song>
	debug_RequireParams \{[
			song_prefix
			song_struct
		]
		all}
	if is_song_downloaded song_checksum = <song>
		if NOT SongPlayPreview filename = <song_prefix> content_index = <content_index>
			DownloadContentLost
			return
		endif
	endif
endscript
