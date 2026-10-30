
script 0x57ddb8a5 
	disable_pause
endscript

script ui_create_song_unpause 
	if ($transition_playing = true)
		0x93d8d5cf \{'Attempted to put up unpause countdown when a transition was playing.'}
		spawnscriptnow \{unpausegh3}
		return
	endif
	createscreenelement \{parent = root_window
		id = song_unpause
		type = descinterface
		desc = 'song_unpause'
		z_priority = 10000
		alpha = 0.0}
	if song_unpause :desc_resolvealias \{name = alias_dude_container
			param = resume_dude_id}
		<resume_dude_id> :obj_spawnscript ui_shakey
		<resume_dude_id> :obj_spawnscript ui_frazzmatazz
	endif
	if song_unpause :desc_resolvealias \{name = alias_dude2_container
			param = resume_dude2_id}
		<resume_dude_id> :obj_spawnscript ui_shakey
	endif
	if song_unpause :desc_resolvealias \{name = alias_flame_dude_container
			param = flame_dude_id}
		<flame_dude_id> :obj_spawnscript ui_roto
	endif
	song_unpause :obj_spawnscript \{ui_song_unpause}
	launchevent \{type = focus
		target = song_unpause}
endscript

script ui_destroy_song_unpause 
	destroyscreenelement \{id = song_unpause}
	if ($calibrate_lag_enabled = 1)
		setup_pause \{pad_start_script = calibrate_hit_pause}
	endif
endscript

script ui_song_unpause 
	gman_songtool_getcurrentsong
	setscriptcannotpause
	get_song_title song = <current_song>
	formattext textname = title_text qs(0x373caef2) s = <song_title>
	se_setprops title_text = <title_text> number_text = qs(0x050c1ef7)
	ui_event_wait_for_safe
	getsongtime
	songfilemanager func = get_song_end_time song_name = <current_song>

	if ((<songtime> < 0.0) || ((<songtime> * 1000) >= <total_end_time>))
		ui_song_unpause_done
		return
	endif
	songtime = (<songtime> * 1000)
	songfilemanager func = get_num_fretbar_notes song_name = <current_song>
	i = 0
	begin
	songfilemanager func = get_fretbar_note song_name = <current_song> index = <i>
	if (<songtime> < <fretbar_time>)
		i = (<i> - 1)
		break
	endif
	i = (<i> + 1)
	repeat <num_fretbar_notes>
	if (<i> < 4)
		i = 4
	endif
	song_unpause :se_setprops \{alpha = 1.0}
	times = [0.0 0.0 0.0 0.0]
	songfilemanager func = get_fretbar_note song_name = <current_song> index = (<i> + 1)
	<time> = <fretbar_time>
	j = 0
	begin
	songfilemanager func = get_fretbar_note song_name = <current_song> index = (<i> - <j>)
	setarrayelement arrayname = times index = (3 - <j>) newvalue = (<time> - <fretbar_time>)
	time = <fretbar_time>
	j = (<j> + 1)
	repeat 4
	soundevent \{event = countoff_sfx_sticks_normal_hard}
	wait ((<times> [0]) / 1000.0) seconds ignoreslomo
	i = 3
	begin
	if (<i> = 1)
		0xa0f36ddb = ((<times> [(4 - <i>)]) / 1000.0 + 0.1)
		spawnscriptnow 0xc20c8a0d params = {time = <0xa0f36ddb>}
	endif
	formattext textname = number_text qs(0xc31d83ea) i = <i>
	se_setprops number_text = <number_text>
	soundevent \{event = countoff_sfx_sticks_normal_hard}
	wait ((<times> [(4 - <i>)]) / 1000.0) seconds ignoreslomo
	i = (<i> - 1)
	repeat 3
	ui_song_unpause_done
endscript

script ui_song_unpause_done 
	0xd3f993c8 \{sustain}
	onexitrun \{0xe5a305c6}
	setscriptcannotpause
	ui_event_wait_for_safe
	spawnscriptnow \{unpausegh3}
	block
endscript

script ui_song_unpause_repause 
	setscriptcannotpause
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	disable_pause
	killspawnedscript \{name = ui_song_unpause}
	ui_event_wait event = menu_replace state = uistate_pausemenu data = {device_num = <device_num>} 0xd1b494c2
endscript

script 0xc20c8a0d \{time = 1.0}
	setbuttoneventmappings \{block_menu_input}
	wait <time> seconds ignoreslomo
	setbuttoneventmappings \{unblock_menu_input}
endscript
