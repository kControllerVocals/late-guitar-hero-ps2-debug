
script ui_init_song_unpause 
	disable_pause
endscript

script ui_create_song_unpause 
	if ($transition_playing = true)
		debug_ScriptAssert \{'Attempted to put up unpause countdown when a transition was playing.'}
		spawnscriptnow \{unpausegh3}
		return
	endif
	CreateScreenElement \{parent = root_window
		id = song_unpause
		type = DescInterface
		desc = 'song_unpause'
		z_priority = 10000
		alpha = 0.0}
	if song_unpause :Desc_ResolveAlias \{name = alias_dude_container
			param = resume_dude_id}
		<resume_dude_id> :obj_spawnscript ui_shakey
		<resume_dude_id> :obj_spawnscript ui_frazzmatazz
	endif
	if song_unpause :Desc_ResolveAlias \{name = alias_dude2_container
			param = resume_dude2_id}
		<resume_dude_id> :obj_spawnscript ui_shakey
	endif
	if song_unpause :Desc_ResolveAlias \{name = alias_flame_dude_container
			param = flame_dude_id}
		<flame_dude_id> :obj_spawnscript ui_roto
	endif
	song_unpause :obj_spawnscript \{ui_song_unpause}
	LaunchEvent \{type = focus
		target = song_unpause}
endscript

script ui_destroy_song_unpause 
	DestroyScreenElement \{id = song_unpause}
	if ($calibrate_lag_enabled = 1)
		setup_pause \{pad_start_script = calibrate_hit_pause}
	endif
endscript

script ui_song_unpause 
	GMan_SongTool_GetCurrentSong
	SetScriptCannotPause
	get_song_title song = <current_song>
	FormatText TextName = title_text qs("Get Ready!\n\cD%s\c0 will resume in...") s = <song_title>
	SE_SetProps title_text = <title_text> number_text = qs("4")
	ui_event_wait_for_safe
	GetSongTime
	SongFileManager func = get_song_end_time song_name = <current_song>

	if ((<songtime> < 0.0) || ((<songtime> * 1000) >= <total_end_time>))
		ui_song_unpause_done
		return
	endif
	songtime = (<songtime> * 1000)
	SongFileManager func = get_num_fretbar_notes song_name = <current_song>
	i = 0
	begin
	SongFileManager func = get_fretbar_note song_name = <current_song> index = <i>
	if (<songtime> < <fretbar_time>)
		i = (<i> - 1)
		break
	endif
	i = (<i> + 1)
	repeat <num_fretbar_notes>
	if (<i> < 4)
		i = 4
	endif
	song_unpause :SE_SetProps \{alpha = 1.0}
	times = [0.0 0.0 0.0 0.0]
	SongFileManager func = get_fretbar_note song_name = <current_song> index = (<i> + 1)
	<time> = <fretbar_time>
	j = 0
	begin
	SongFileManager func = get_fretbar_note song_name = <current_song> index = (<i> - <j>)
	SetArrayElement ArrayName = times index = (3 - <j>) newvalue = (<time> - <fretbar_time>)
	time = <fretbar_time>
	j = (<j> + 1)
	repeat 4
	SoundEvent \{event = Countoff_SFX_Sticks_Normal_Hard}
	Wait ((<times> [0]) / 1000.0) seconds ignoreslomo
	i = 3
	begin
	if (<i> = 1)
		disable_time = ((<times> [(4 - <i>)]) / 1000.0 + 0.1)
		spawnscriptnow ps2_block_input_interval params = {time = <disable_time>}
	endif
	FormatText TextName = number_text qs("\L%i") i = <i>
	SE_SetProps number_text = <number_text>
	SoundEvent \{event = Countoff_SFX_Sticks_Normal_Hard}
	Wait ((<times> [(4 - <i>)]) / 1000.0) seconds ignoreslomo
	i = (<i> - 1)
	repeat 3
	ui_song_unpause_done
endscript

script ui_song_unpause_done 
	push_loading_screen \{sustain}
	OnExitRun \{pop_loading_screen}
	SetScriptCannotPause
	ui_event_wait_for_safe
	spawnscriptnow \{unpausegh3}
	Block
endscript

script ui_song_unpause_repause 
	SetScriptCannotPause
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	disable_pause
	KillSpawnedScript \{name = ui_song_unpause}
	ui_event_wait event = menu_replace state = UIstate_pausemenu data = {device_num = <device_num>} wait_for_statechange
endscript

script ps2_block_input_interval \{time = 1.0}
	SetButtonEventMappings \{block_menu_input}
	Wait <time> seconds ignoreslomo
	SetButtonEventMappings \{unblock_menu_input}
endscript
