guitar_events = [
	{
		type = call
		event = missed_note
		scr = guitarevent_missednote
	}
	{
		type = call
		event = unnecessary_note
		scr = guitarevent_unnecessarynote
	}
	{
		type = call
		event = hit_notes
		scr = guitarevent_hitnotes
	}
	{
		type = call
		event = hit_note
		scr = guitarevent_hitnote
	}
	{
		type = call
		event = drumfill_hit
		scr = guitarevent_drumfillhit
	}
	{
		type = call
		event = star_power_on
		scr = guitarevent_starpoweron
	}
	{
		type = call
		event = star_power_off
		scr = guitarevent_starpoweroff
	}
	{
		type = spawn
		event = song_failed
		scr = guitarevent_songfailed
	}
	{
		type = spawn
		event = song_won
		scr = guitarevent_songwon
	}
	{
		type = spawn
		event = star_sequence_bonus
		scr = guitarevent_starsequencebonus
	}
	{
		type = call
		event = whammy_on
		scr = guitarevent_whammyon
	}
	{
		type = call
		event = whammy_off
		scr = guitarevent_whammyoff
	}
	{
		type = call
		event = ext_whammy_off
		scr = guitarevent_whammyoff
	}
	{
		type = call
		event = firstnote_window_open
		scr = guitarevent_firstnote_window_open
	}
]

script create_guitar_events 

	getarraysize \{$guitar_events}
	array_entry = 0
	begin

	event = ($guitar_events [<array_entry>].event)
	type = ($guitar_events [<array_entry>].type)
	extendcrc <event> <player_text> out = event
	seteventhandler response = call_script event = <event> scr = event_spawner params = {event_spawned = <array_entry>}
	array_entry = (<array_entry> + 1)
	repeat <array_size>
	block
endscript

script event_spawner 
	spawnscriptnow ($guitar_events [<event_spawned>].scr) params = {<...>} id = song_event_scripts
endscript

script event_iterator 

	get_song_prefix song = <song_name>
	formattext checksumname = song '%s_%e' s = <song_prefix> e = <event_string> addtostringlookup = true
	array_entry = 0
	if NOT globalexists name = <song> type = array
		return
	endif
	getarraysize $<song>
	if (<array_size> = 0)
		return
	endif
	getsongtimems time_offset = <time_offset>
	begin
	if ((<time> - <skipleadin>) < (($<song> [<array_entry>]).time))
		break
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	array_size = (<array_size> - <array_entry>)
	if (<array_size> = 0)
		return
	endif
	begin
	scriptname = ($<song> [<array_entry>].scr)
	if (<scriptname> = band_playloop || <scriptname> = band_playidle)
		timemarkerreached_setparams time_offset = (<time_offset> -2 * 16.667) array = <song> array_entry = <array_entry> arrayofstructures
	else
		timemarkerreached_setparams time_offset = <time_offset> array = <song> array_entry = <array_entry> arrayofstructures
	endif
	begin
	if timemarkerreached
		getsongtimems time_offset = <time_offset>
		break
	endif
	waitonegameframe
	repeat
	timemarkerreached_clearparams
	scriptname = ($<song> [<array_entry>].scr)
	if (<scriptname> = band_playclip)
		nullscript
	elseif (<scriptname> = band_playloop)
		0x3fac2d4f index = <array_entry>
	elseif (<scriptname> = band_playidle)
		0x3fac2d4f index = <array_entry>
	elseif (<scriptname> = band_forcealltoidle)
		nullscript
	elseif (<scriptname> = band_movetonode)
		nullscript
	elseif scriptexists <scriptname>
		spawnscriptnow <scriptname> params = {time = <time> event_time = (($<song> [<array_entry>]).time) ($<song> [<array_entry>].params)} id = song_event_scripts
	elseif symboliscfunc <scriptname>
		<scriptname> {time = <time> event_time = (($<song> [<array_entry>]).time) ($<song> [<array_entry>].params)}
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
endscript

script guitarevent_missednote \{extended_miss = 0}
	0x8a941e36 = 0
	if (<bum_note> = 1)
		guitar_wrong_note_sound_logic <...>
	endif
	if ($is_network_game && ($<player_status>.is_local_client = 0))
		if (<silent_miss> = 1)
			spawnscriptnow highway_pulse_black params = {player_text = ($<player_status>.text) player_status = <player_status>}
		endif
	else
		if NOT (($<player_status>.part) = drum)
			playergetvolume player_status = <player_status>
			if NOT (<volume> = 0)
				if (<silent_miss> = 1)
					spawnscriptnow highway_pulse_black params = {player_text = ($<player_status>.text) player_status = <player_status>}
				else
					if NOT (<extended_miss> = 1)
						playersetvolume player_status = <player_status> volume = 0
						updateguitarvolume
						jam_update_volume volume = 0 player = ($<player_status>.player)
					endif
				endif
			endif
		endif
	endif
	if ($always_strum = false)
		if ($disable_band = 0)
			if compositeobjectexists name = ($<player_status>.band_member)
				if ($<player_status>.part = guitar || $<player_status>.part = bass)
					bandmanager_missednote name = ($<player_status>.band_member)
				endif
			endif
		endif
	endif
	inputarraygetelement name = <song> index = <array_entry>
endscript

script highway_pulse_black 
	<half_time> = ($highway_pulse_time / 2.0)
	formattext checksumname = highway 'Highway_2D%p' p = <player_text> addtostringlookup = true
	legacydoscreenelementmorph id = <highway> rgba = ($highway_pulse) time = <half_time>
	wait <half_time> seconds
	if ($<player_status>.star_power_used = 1)
		legacydoscreenelementmorph id = <highway> rgba = ($highway_starpower) time = <half_time>
	else
		legacydoscreenelementmorph id = <highway> rgba = ($highway_normal) time = <half_time>
	endif
endscript

script guitarevent_unnecessarynote 
	guitar_wrong_note_sound_logic <...>
	if NOT ($is_network_game && ($<player_status>.is_local_client = 0))
		playersetvolume player_status = <player_status> volume = 0
		updateguitarvolume
		jam_update_volume volume = 0 player = ($<player_status>.player)
	endif
	if ($always_strum = false)
		if ($disable_band = 0)
			if compositeobjectexists name = ($<player_status>.band_member)
				if ($<player_status>.part = guitar || $<player_status>.part = bass)
					launchevent type = anim_missednote target = ($<player_status>.band_member)
				endif
			endif
		endif
	endif
endscript

script guitarevent_hitnotes 
	if (<updatevolume> = true)
		updateguitarvolume
	endif
endscript

script guitarevent_hitnote 
	spawnscriptnow guitarevent_hitnote_spawned params = {<...>}
endscript

script guitarevent_hitnote_spawned 
	if gotparam \{kick}
		guitarevent_kick_drum_hit_note player = <player> player_text = <player_text>
	elseif gotparam \{open_note}
		guitarevent_hit_open_note player = <player> player_text = <player_text>
	elseif gotparam \{beginner_note}
		guitarevent_hit_beginner_note player_text = <player_text>
	else
		waitonegameframe
		scale = (2.0, 2.0)
		<scale> = (1.0, 1.0)
		if gotparam \{kick}
			<scale> = (7.0, 0.5)
		elseif gotparam \{open_note}
			<scale> = (7.0, 0.5)
		elseif gotparam \{beginner_note}
			<scale> = (7.0, 0.5)
		endif
		star = ($<player_status>.star_power_used)
		name = <fx_id>
		notefx scale = <scale>
		wait \{6
			gameframes}
		wait \{10
			gameframes}
		if screenelementexists id = <fx_id>
			destroyscreenelement id = <fx_id>
		endif
	endif
endscript

script guitarevent_drumfillhit 
	if gotparam \{kick}
		guitarevent_hitnote <...>
	endif
endscript
hit_particle_params = {
	z_priority = 8.0
	material = sys_particle_spark01_sys_particle_spark01
	start_color = [
		255
		128
		0
		255
	]
	end_color = [
		255
		0
		0
		0
	]
	start_scale = (2.0, 2.0)
	end_scale = (1.0, 1.0)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 0.0
	emit_radius = 1.0
	emit_rate = 0.02
	emit_dir = 0.0
	emit_spread = 160.0
	velocity = 10.0
	friction = (0.0, 50.0)
	time = 0.25
}
star_hit_particle_params = {
	z_priority = 8.0
	material = sys_particle_spark01_sys_particle_spark01
	start_color = [
		0
		255
		255
		255
	]
	end_color = [
		0
		255
		255
		0
	]
	start_scale = (2.0, 2.0)
	end_scale = (1.0, 1.0)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 0.0
	emit_radius = 1.0
	emit_rate = 0.02
	emit_dir = 0.0
	emit_spread = 160.0
	velocity = 10.0
	friction = (0.0, 50.0)
	time = 0.25
}
whammy_particle_params = {
	z_priority = 8.0
	material = sys_particle_spark01_sys_particle_spark01
	start_color = [
		255
		128
		0
		255
	]
	end_color = [
		255
		0
		0
		0
	]
	start_scale = (1.0, 1.0)
	end_scale = (0.5, 0.5)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 0.0
	emit_radius = 1.0
	emit_rate = 0.02
	emit_dir = 0.0
	emit_spread = 160.0
	velocity = 10.0
	friction = (0.0, 50.0)
	time = 0.5
}

script guitarevent_starpoweron 
	killspawnedscript \{name = highway_pulse_black}
	if ($drum_solo_songtime_paused = 0)
		gh_star_power_verb_on player = <player>
	endif
	starpoweron player = <player>
	if ($current_num_players = 4)
		if (all_players_using_starpower)
			spawnscriptnow \{play_group_star_power_animation}
		endif
	endif
	hud_meter_glow_blue
endscript

script guitarevent_starpoweroff 
	killspawnedscript \{name = highway_pulse_black}
	if issingleplayergame
		soundevent \{event = star_power_release_center_gh4}
		soundevent \{event = star_power_release_front_gh4}
	else
		spawnscriptnow star_power_release_sfx_multiplayer params = {player = ($<player_status>.player)}
	endif
	gh_star_power_verb_off player = ($<player_status>.player)
	spawnscriptnow rock_meter_star_power_off params = {player_text = <player_text>}
	spawnscriptlater kill_starpower_stagefx params = {<...>}
	formattext checksumname = cont 'starpower_container_left%p' p = <player_text> addtostringlookup = true
	if screenelementexists id = <cont>
		legacydoscreenelementmorph id = <cont> alpha = 0
	endif
	formattext checksumname = cont 'starpower_container_right%p' p = <player_text> addtostringlookup = true
	if screenelementexists id = <cont>
		legacydoscreenelementmorph id = <cont> alpha = 0
	endif
	formattext checksumname = highway 'Highway_2D%p' p = <player_text> addtostringlookup = true
	if screenelementexists id = <highway>
		setscreenelementprops id = <highway> rgba = ($0x57e04d77)
	endif
	spawnscriptnow \{kill_starpower_camera}
	hud_meter_glow_hide_blue
endscript

script 0x9c2773ec 
	getpakmancurrentname \{map = zones}
	if ((<pakname> = 'z_tool'))
		return
	endif
	voll = 0.0
	volr = 0.0
	if (($star_clap_normal = 1) || ($star_clap_leftcenterright = 1) || ($star_clap_middle = 1) || ($star_clap_left) || ($star_clap_left_middle))
		voll = 118
	endif
	if (($star_clap_normal = 1) || ($star_clap_leftcenterright = 1) || ($star_clap_middle = 1) || ($star_clap_right) || ($star_clap_right_middle))
		volr = 118
	endif
	getrandomvalue \{a = 0
		b = 2
		name = 0x1e1afcc0
		integer}
	sample = crowd_group_clap_01
	switch <0x1e1afcc0>
		case 0
		sample = crowd_group_clap_01
		case 1
		sample = crowd_group_clap_02
		case 2
		sample = crowd_group_clap_03
	endswitch

	playsound <sample> voll_percent = (<voll> * $0x389366b2) volr_percent = (<volr> * $0x389366b2) buss = crowd_star_power
endscript

script guitarevent_prefretbar 
	spawnscriptnow \{gh_audible_metronome}
	waittime = 0.18
	wait <waittime> seconds
	spawnscriptnow clapping_logic params = {<...>}
endscript

script gh_audible_metronome 
	if ($debug_audible_metronome = 1)
		wait ((0.25 + (($default_lag_settings.xenon.input_lag_ms) * 0.001)) - 0.008333) seconds
		soundevent \{event = gh_sfx_beatsoundevent}
	endif
endscript

script guitarevent_fretbar 
	guitarevent_fretbar_cfunc
endscript

script guitarevent_fretbar_early 
endscript

script guitarevent_fretbar_late 
endscript

script check_first_note_formed 
	getsongtime
	<starttime> = (<songtime> - 0.0167)
	duration = ($<player_status>.check_time_early + $<player_status>.check_time_late)
	begin
	getheldpattern controller = ($<player_status>.controller) player = ($<player_status>.player) player_status = <player_status>
	if (<strum> = <hold_pattern>)
		playersetvolume player_status = <player_status> volume = 100
		updateguitarvolume
		jam_update_volume volume = 100 player = ($<player_status>.player)
	endif
	waitonegameframe
	getsongtime
	if ((<songtime> - <starttime>) >= <duration>)
		break
	endif
	repeat
endscript

script guitarevent_firstnote_window_open 
	if isguitarcontroller controller = ($<player_status>.controller)
		getstrumpattern entry = 0 song = <song>
		spawnscriptnow check_first_note_formed params = {strum = <strum> player_status = <player_status>}
	else
		playersetvolume player_status = <player_status> volume = 100
		updateguitarvolume
		jam_update_volume volume = 100 player = ($<player_status>.player)
	endif
endscript
bluewhammyfxid01p1 = jow_nil
bluewhammyfxid02p1 = jow_nil
greenwhammyfxid01p1 = jow_nil
greenwhammyfxid02p1 = jow_nil
orangewhammyfxid01p1 = jow_nil
orangewhammyfxid02p1 = jow_nil
redwhammyfxid01p1 = jow_nil
redwhammyfxid02p1 = jow_nil
yellowwhammyfxid01p1 = jow_nil
yellowwhammyfxid02p1 = jow_nil
bluewhammyfxid01p2 = jow_nil
bluewhammyfxid02p2 = jow_nil
greenwhammyfxid01p2 = jow_nil
greenwhammyfxid02p2 = jow_nil
orangewhammyfxid01p2 = jow_nil
orangewhammyfxid02p2 = jow_nil
redwhammyfxid01p2 = jow_nil
redwhammyfxid02p2 = jow_nil
yellowwhammyfxid01p2 = jow_nil
yellowwhammyfxid02p2 = jow_nil

script destroy_allwhammyfx 
	whammyfxoffall \{player_status = player1_status}
	whammyfxoffall \{player_status = player2_status}
endscript

script guitarevent_whammyon 
	if (<player> = 1)
		lock = whammyon_lockp1
	else
		lock = whammyon_lockp2
	endif
	change globalname = <lock> newvalue = 1
	whammyfxon <...>
	change globalname = <lock> newvalue = 0
endscript

script guitarevent_whammyoff 
	if (<player> = 1)
		lock = whammyon_lockp1
	else
		lock = whammyon_lockp2
	endif
	begin
	if NOT ($<lock>)
		break
	endif
	wait \{1
		gameframe}
	repeat
	whammyfxoff <...>
endscript

script guitarevent_songfailed 
	setscriptcannotpause
	0x79db87d7
	onexitrun \{0xf00f29a9}
	ui_event_wait_for_safe
	ui_event_get_top
	if NOT (<base_name> = 'gameplay')
		if ui_event_exists_in_stack \{name = 'gameplay'}
			ui_event_block \{event = menu_back
				data = {
					state = uistate_gameplay
				}}
		endif
	endif
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	if ($failed_song = 1)
		return
	endif
	if ($cheat_invincible = 1)
		return
	endif
	if ($playing_song_for_real = 0)
		return
	endif
	change \{playing_song_for_real = 0}
	if ($game_mode = practice || $game_mode = tutorial)
		return
	endif
	restore_player_part_settings
	if ($is_network_game)
		online_fail_song
	else
		killspawnedscript \{name = guitar_jam_playback_recording}
		killspawnedscript \{name = guitar_jam_drum_playback}
		killspawnedscript \{name = jam_input_whammy_spawned}
		jam_stop_all_samples
		jam_deinit_reverb
		spawnscriptnow \{guitarevent_songfailed_spawned}
	endif
endscript

script guitarevent_songfailed_spawned 
	if ($is_attract_mode = 1)

		return
	endif
	disable_highway_prepass
	disable_bg_viewport
	lightshow_songfailed
	getsongtimems
	change failed_song_time = <time>
	pausegame
	progression_songfailed
	unpausegame
	soundevent \{event = crowd_fail_song_sfx}
	soundevent \{event = gh_sfx_you_lose_single_player}
	disable_pause
	song_failed_show_highways
	playlossvideo
	transition_play \{type = songlost}
	transition_wait
	change \{current_transition = none}
	ui_event_wait_for_safe
	ui_event_get_top
	if NOT (<base_name> = 'gameplay')
		ui_event_block \{event = menu_back
			data = {
				state = uistate_gameplay
			}}
	endif
	pausegame
	show_calibration = 0
	getglobaltags \{user_options
		param = has_calibrated}
	if (<has_calibrated> = 0)
	endif
	gamemode_gettype
	if ($is_network_game = 0)
		ui_event_wait_for_safe
		wait \{1
			gameframe}
		if ui_event_exists_in_stack \{name = 'pausemenu'
				above = 'gameplay'}
			ui_event_block \{event = menu_back
				data = {
					state = uistate_gameplay
				}}
		elseif ui_event_exists_in_stack \{name = 'song_unpause'
				above = 'gameplay'}
			ui_event_block \{event = menu_back
				data = {
					state = uistate_gameplay
				}}
		endif
		if (<show_calibration> = 1)
			setglobaltags \{user_options
				params = {
					has_calibrated = 1
				}}
			body = qs(0x24b45119)
			spawnscriptnow {
				ui_event {
					params = {
						event = menu_change
						data = {
							state = uistate_options_calibrate_lag_warning
							body = <body>
							cancel_script = menu_replace_to_fail_song
							yes_func_params = {go_back_script = menu_replace_to_fail_song}
						}
					}
				}
			}
		else
			spawnscriptnow \{ui_event
				params = {
					event = menu_change
					data = {
						state = uistate_fail_song
					}
				}}
		endif
	endif
	if ($current_num_players = 1)
		soundevent \{event = crowd_fail_song_sfx}
		bg_crowd_front_end_silence \{immediate = 1}
	else
	endif
	killspawnedscript \{name = create_exploding_text}
	destroy_exploding_text \{parent = 'you_rock_physics'}
endscript
song_failed_x = 1

script song_failed_show_highways 
	if ($song_failed_x = 0)
		return
	endif
	if ($current_num_players = 1)
		return
	endif
	if ($game_mode = p2_pro_faceoff)
		return
	endif
	songunload
	pausegame
	wait \{0.5
		second}
	player = 1
	begin
	getplayerinfo <player> current_health
	if (<current_health> < $health_poor_medium)
		song_failed_highway_x {player = <player>}
	endif
	player = (<player> + 1)
	repeat $current_num_players
	soundevent \{event = band_failed_x_sfx}
	if NOT ($band1_status.star_power_active)
		if ($band1_status.star_power_amount > (100.0 / 6.0))
			wait \{0.3
				seconds}
			createscreenelement \{type = textblockelement
				id = 0x567f64ac
				parent = hud_root
				text = qs(0xdb96ac31)
				font = fontgrid_text_a8
				just = [
					center
					center
				]
				internal_just = [
					center
					center
				]
				z_priority = 400
				scale = 0.7
				pos = (600.0, 360.0)
				rgba = [
					0
					200
					200
					255
				]
				dims = (1280.0, 720.0)}
		endif
	endif
	wait \{2.2
		seconds}
	unpausegame
endscript

script song_failed_highway_x 
	getplayerinfo <player> hud_parent
	getplayerinfo <player> part
	pos = (80.0, 40.0)
	switch <part>
		case vocals
		icon = band_hud_microphone2
		pos = (550.0, 80.0)
		case guitar
		icon = band_hud_guitar2
		case bass
		icon = band_hud_bass2
		case drum
		icon = band_hud_drums2
	endswitch
	if hud_root :desc_resolvealias name = <hud_parent> param = parent_id
		if screenelementexists id = <parent_id>
			createscreenelement {
				type = spriteelement
				parent = <parent_id>
				texture = <icon>
				just = [center center]
				z_priority = 400
				scale = 2
				pos = <pos>
				rgba = [255 0 0 255]
			}
		endif
	endif
endscript
gpulog_outputfilename = 'none'

script guitarevent_songwon 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	setscriptcannotpause
	0x79db87d7
	onexitrun \{0xf00f29a9}
	ui_event_wait_for_safe
	ui_event_get_top
	if NOT (<base_name> = 'gameplay')
		if ui_event_exists_in_stack \{name = 'gameplay'}
			ui_event_block \{event = menu_back
				data = {
					state = uistate_gameplay
				}}
		endif
	endif
	change \{playing_song_for_real = 0}
	if ($output_gpu_log = 1)
		if isps3
			formattext \{textname = filename
				'%s_gpu_ps3'
				s = $current_level
				dontassertforchecksums}
		else
			formattext \{textname = filename
				'%s_gpu'
				s = $current_level
				dontassertforchecksums}
		endif
		if NOT stringequals \{a = $gpulog_outputfilename
				b = 'none'}
			<filename> = $gpulog_outputfilename
		endif
		textoutputend output_text filename = <filename>
	endif
	if ($output_song_stats = 1)
		formattext \{textname = filename
			'%s_stats'
			s = $current_song
			dontassertforchecksums}
		textoutputstart
		textoutput \{text = qs(0x3f02a90c)}
		formattext textname = text qs(0xfccb1331) s = ($player1_status.score) dontassertforchecksums
		textoutput text = <text>
		formattext textname = text qs(0x26c27108) n = ($player1_status.notes_hit) t = ($player1_status.total_notes) dontassertforchecksums
		textoutput text = <text>
		formattext textname = text qs(0xd67d4308) r = ($player1_status.best_run) dontassertforchecksums
		textoutput text = <text>
		formattext textname = text qs(0x6bb1c560) m = ($player1_status.max_notes) dontassertforchecksums
		textoutput text = <text>
		formattext textname = text qs(0x26a9ba16) b = ($player1_status.base_score) dontassertforchecksums
		textoutput text = <text>
		if (($player1_status.base_score) = 0)
			formattext \{textname = text
				qs(0x30357c57)}
		else
			formattext textname = text qs(0xbcc2e990) s = (($player1_status.score) / ($player1_status.base_score)) dontassertforchecksums
		endif
		textoutput text = <text>
		if (($player1_status.total_notes) = 0)
			formattext \{textname = text
				qs(0xc8e34ec5)}
		else
			formattext textname = text qs(0x2b87036c) s = ((($player1_status.notes_hit) / ($player1_status.total_notes)) * 100.0) dontassertforchecksums
		endif
		textoutput text = <text>
		textoutputend output_text filename = <filename>
	endif
	if ($current_num_players = 2)
		getsongtimems
		if ($last_time_in_lead_player = 0)
			change structurename = player1_status time_in_lead = ($player1_status.time_in_lead + <time> - $last_time_in_lead)
		elseif ($last_time_in_lead_player = 1)
			change structurename = player2_status time_in_lead = ($player2_status.time_in_lead + <time> - $last_time_in_lead)
		endif
		change \{last_time_in_lead_player = -1}
	endif
	restore_player_part_settings
	killspawnedscript \{name = guitar_jam_playback_recording}
	killspawnedscript \{name = guitar_jam_drum_playback}
	killspawnedscript \{name = jam_input_whammy_spawned}
	jam_stop_all_samples
	jam_deinit_reverb
	spawnscriptnow \{guitarevent_songwon_spawned}
endscript

script guitarevent_songwon_spawned 
	if ($is_attract_mode = 1)
		ui_event \{event = menu_back}
		return
	endif
	if ($autotest_on = 1 && $autotest_turbo_mode = 1)
		setslomo \{10.0}
	endif
	change track_last_song = ($current_song)
	change \{calibrate_lag_failed_num = 0}
	change \{last_song_failed = none}
	change \{current_song_failed_num = 0}
	if ($game_mode = practice)
		return
	elseif ($game_mode = tutorial)
		return
	elseif ($0xc7e670d7 = 1 || $0x9b2cba3f = 1)
		quickplay_skip_song
		return
	endif
	progression_endcredits_done
	pausegame
	disable_pause
	ui_event_wait_for_safe
	ui_event_get_top
	if NOT (<base_name> = 'gameplay')
		ui_event_block \{event = menu_back
			data = {
				state = uistate_gameplay
			}}
	endif
	if ($game_mode = gh4_p1_career || $game_mode = gh4_p2_career || $game_mode = p2_coop || $game_mode = p1_quickplay || $game_mode = p2_quickplay || $game_mode = gh4_p3_career || $game_mode = gh4_p4_career || $game_mode = p3_quickplay || $game_mode = p4_quickplay)
		spawnscriptnow \{cheer_before_explosion}
	endif

	skate8_sfx_backgrounds_new_area \{bg_sfx_area = $current_crowd_looping_bg_area_good}
	crowd_surge_and_sustain_at_end_of_song
	spawnscriptnow \{you_rock_waiting_crowd_sfx}
	tie = false
	if ($game_mode = p2_pro_faceoff)
		p1_score = ($player1_status.score)
		p2_score = ($player2_status.score)
		if (<p2_score> > <p1_score>)
			winner = qs(0xcdaffbf0)
		elseif (<p1_score> > <p2_score>)
			winner = qs(0x7340f937)
		else
			<tie> = true
		endif
		if (<tie> = true)
			winner_text = qs(0x43b33be2)
			winner_space_between = (15.0, 0.0)
			winner_scale = 0.5
			fit_dims = (100.0, 0.0)
		else
			formattext textname = winner_text qs(0xe3029fec) s = <winner>
			winner_space_between = (50.0, 0.0)
			winner_scale = 1.5
		endif
	else
		winner_text = Random (@ qs(0xebdedfc6) @ qs(0xebdedfc6) )
		winner_space_between = (45.0, 0.0)
		fit_dims = (350.0, 0.0)
		winner_scale = 1.0
	endif
	spawnscriptnow \{waitandkillhighway}
	killspawnedscript \{name = jiggle_text_array_elements}
	spawnscriptnow \{wait_and_play_you_rock_movie}
	create_mushroomcloudhand text = <winner_text>
	spawnscriptnow \{you_rock_sfx_end}
	change \{old_song = none}
	progression_songwon
	if ($current_transition = preencore)
		end_song
		unpausegame
		transition_play \{type = preencore}
		transition_wait
		change \{current_transition = none}
		pausegame
		ui_event_get_top
		if (<base_name> = 'controller_disconnect' || <base_name> = 'pausemenu_quit_warning')
			ui_event \{event = menu_replace
				data = {
					state = uistate_song_breakdown
					encore_transition = 1
					no_sound
				}}
		else
			generic_event_choose \{no_sound
				state = uistate_song_breakdown
				data = {
					encore_transition = 1
				}}
		endif
		encore_transition = 1
	else
		unpausegame
		if ($is_network_game = 0)
			transition_play \{type = songwon}
		else
			if ($game_mode = p4_pro_faceoff || $game_mode = p8_pro_faceoff)
				opponent_score = ($band2_status.score)
				our_score = ($band1_status.score)
				if (<opponent_score> > <our_score>)
					transition_play \{type = songlost}
				else
					transition_play \{type = songwon}
				endif
			else
				transition_play \{type = songwon}
			endif
		endif
		transition_wait
		change \{current_transition = none}
		pausegame
	endif
	killspawnedscript \{name = create_exploding_text}
	if ($end_credits = 1 && $current_song = $final_credits_song)
		destroy_exploding_text \{parent = 'you_rock_physics'}
		destroy_exploding_text \{parent = 'you_rock_2_physics'}
		change \{end_credits = 0}
		career_song_ended_select_quit \{for_credits_venue = 1}
		get_progression_globals ($current_progression_flag)
		ui_memcard_autosave \{event = menu_back
			state = uistate_gig_posters
			data = {
				all_active_players = true
				0x6d221ff1
			}}
	else
		destroy_all_exploding_text
		if ($autotest_on = 1)
			ui_event \{event = menu_change
				data = {
					state = uistate_autotest_next_test
				}}
		endif
		if NOT gotparam \{encore_transition}
			if ($progression_beat_game_last_song = 1)
				ui_event \{event = menu_change
					data = {
						state = uistate_beat_game
					}}
			else
				loading_transition = 0
				gamemode_gettype
				if (<type> = career)
					stats_song_checksum = ($current_song)
					if progression_set_new_song_in_gig_list
						loading_transition = 1
					endif
				elseif (<type> = quickplay)
					stats_song_checksum = ($current_song)
					if quickplay_set_new_song_in_gig_list
						loading_transition = 1
						if ($current_song = jamsession && $track_last_song = jamsession)
							loading_transition = 0
						endif
					endif
				endif
				if (<loading_transition> = 1)
					if (<type> = quickplay)
						data = {state = uistate_song_breakdown 0xaabed717}
					else
						data = {state = uistate_song_breakdown encore_transition}
					endif
					ui_event_get_top
					if (<base_name> = 'controller_disconnect' || <base_name> = 'pausemenu_quit_warning')
						ui_event event = menu_replace data = {<data> no_sound}
					else
						generic_event_choose no_sound data = <data>
					endif
				else
					if ($is_network_game = 1 && <type> != career)
						ui_event_get_top
						if (<base_name> = 'controller_disconnect' || <base_name> = 'pausemenu_quit_warning')
							ui_event \{event = menu_replace
								data = {
									state = uistate_online_post_game_lobby
								}}
						else
							ui_event \{event = menu_change
								data = {
									state = uistate_online_post_game_lobby
								}}
						endif
					else
						ui_event_get_top
						if (<base_name> = 'controller_disconnect' || <base_name> = 'pausemenu_quit_warning')
							ui_event \{event = menu_replace
								data = {
									state = uistate_song_breakdown
									gig_complete = 1
									end_of_setlist_transition
								}}
						else
							ui_event \{event = menu_change
								data = {
									state = uistate_song_breakdown
									gig_complete = 1
									end_of_setlist_transition
								}}
						endif
					endif
				endif
			endif
		endif
	endif
endscript

script kill_you_rock_movie 
	killmovie \{textureslot = 1}
endscript
g_you_rock_movie = none

script create_you_rock_effect \{player_status = player1_status}

	switch ($g_you_rock_movie)
		case player1_wins
		case player2_wins
		case fret_flames
		case golden_guitar
		default
	endswitch
endscript

script wait_and_play_you_rock_movie 
	create_you_rock_effect
endscript

script waitandkillhighway 
	wait \{0.5
		seconds}
	disable_bg_viewport
endscript
current_song_time = -1
time_to_next_beat = -1
next_beat_time = -1
time_to_next_beat2 = -1
next_beat_time2 = -1
tempo_iterator_offset = 0
time_offset = 0

script tempo_matching_iterator 

	change time_offset = <time_offset>
	band_enabletempoiterator
endscript
measure_callback = nullscript
beat_callback = nullscript

script setmeasurecallback 
	if gotparam \{callback}
		change measure_callback = <callback>
	else
	endif
endscript

script clearmeasurecallbacks 
	change \{measure_callback = nullscript}
endscript

script setbeatcallback 
	if gotparam \{callback}
		change beat_callback = <callback>
	else
	endif
endscript

script gettimetonextbeat 
	getsongtimems \{time_offset = $tempo_iterator_offset}
	return time_to_next_beat = ($next_beat_time - <time>)
endscript

script clearbeatcallbacks 
	change \{beat_callback = nullscript}
endscript

script spawn_measure_callbacks 
	spawnscriptnow \{$measure_callback}
endscript

script spawn_beat_callbacks 
	spawnscriptnow $beat_callback params = {time_to_next_beat = <time_to_next_beat>}
endscript

script beat_test_script 

endscript
0x0c3d9dcf = {
	id = blank
	parent = blank
	pos = (0.0, 0.0)
	rot_angle = 0.0
	type = spriteelement
	material = 0xabd58364
	rgba = [
		255
		255
		255
		255
	]
	scale = $star_power_bolt_scale
	just = [
		center
		bottom
	]
	z_priority = 6
	blend = add
	use_animated_uvs = true
	top_down_v
	frame_length = 0.005
	num_uv_frames = (8.0, 1.0)
}

script guitarevent_starsequencebonus 
	if 0x964e4eb6
		return
	endif
	0x1f1f4e73
	begin
	if 0x2dbc17fa
		break
	endif
	waitonegameframe
	repeat
	0x43a998b4
	0x0f471f0c
	wait \{$star_power_bolt_time
		seconds}
	0x1f1f4e73
	begin
	if 0x2dbc17fa
		break
	endif
	waitonegameframe
	repeat
	0x43a998b4
endscript

script destroy_big_bolt 
	gem_count = 0
	getarraysize \{$gem_colors}
	begin
	<note> = (<gem_array> [(<gem_count> + 1)])
	if (<note> > 0)
		formattext checksumname = name 'big_bolt%p%e' p = ($<player_status>.text) e = <gem_count> addtostringlookup = true
		destroyscreenelement id = <name>
	endif
	gem_count = (<gem_count> + 1)
	repeat <array_size>
endscript

script guitarevent_multiplier4xoff 
	soundevent \{event = ui_sfx_lose_multiplier_4x}
	soundevent \{event = lose_multiplier_crowd}
	spawnscriptnow highway_pulse_multiplier_loss params = {player = ($<player_status>.player) player_text = ($<player_status>.text) multiplier = 4}
endscript

script guitarevent_multiplier3xoff 
	soundevent \{event = ui_sfx_lose_multiplier_3x}
	spawnscriptnow highway_pulse_multiplier_loss params = {player = ($<player_status>.player) player_text = ($<player_status>.text) multiplier = 3}
endscript

script guitarevent_multiplier2xoff 
	soundevent \{event = ui_sfx_lose_multiplier_2x}
	spawnscriptnow highway_pulse_multiplier_loss params = {player = ($<player_status>.player) player_text = ($<player_status>.text) multiplier = 2}
endscript

script guitarevent_killsong \{loadingtransition = 0}
	gh3_sfx_stop_sounds_for_killsong <...> loading_transition = <loading_transition>
endscript

script guitarevent_entervenue 
	getpakmancurrentname \{map = zones}
	formattext checksumname = echo_params 'Echo_Crowd_Buss_%s' s = <pakname>
	formattext checksumname = reverb_params 'Reverb_Crowd_Buss_%s' s = <pakname>
	if NOT globalexists name = <echo_params>
		echo_params = echo_crowd_buss_default
	endif
	if NOT globalexists name = <reverb_params>
		reverb_params = reverb_crowd_buss_default
	endif
	setsoundbusseffects effects = [{$<echo_params>}]
	setsoundbusseffects effects = [{$<reverb_params>}]
endscript

script guitarevent_exitvenue 
	setsoundbusseffects \{effects = [
			{
				$echo_crowd_buss
			}
		]}
	setsoundbusseffects \{effects = [
			{
				$reverb_crowd_buss
			}
		]}
endscript

script guitarevent_gemstarpoweron 
endscript

script guitarevent_transitionintro 
endscript

script guitarevent_transitionfastintro 
endscript

script guitarevent_transitionpreencore 
endscript

script guitarevent_transitionencore 
endscript

script kick_fade_effect 
	obj_getid
	<objid> :se_setprops alpha = 0 time = <t2> anim = fast_out rgba = [200 , 70 , 255 , 255]
	<objid> :se_waitprops
	destroyscreenelement id = <objid>
endscript

script kick_grow_effect 
	obj_getid
	<objid> :se_setprops scale = <scale> time = 0.25 anim = fast_out
endscript
kick_index = 0
kick_fx_index = 0
kick_fx_scale = 1.0
kick_fx_scale_3p = 1.2
kick_fx_scale_end = (1.25, 0.0)

script guitarevent_kick_drum_hit_note \{player = 1}
	formattext checksumname = container_id 'gem_container%p' p = <player_text> addtostringlookup = true
	change kick_index = ($kick_index + 1)
	if ($kick_index > 1024)
		change \{kick_index = 0}
	endif
	<highway_info> = ($highway_pos_table [<player> -1])
	if (<highway_info>.nowbar_scale_x < 1.3)
		<x_scale> = (<highway_info>.nowbar_scale_x * ($kick_fx_scale_3p))
	else
		<x_scale> = (<highway_info>.nowbar_scale_x * ($kick_fx_scale))
	endif
	<particle_pos> = (640.0, 640.0)
	formattext checksumname = fx_id 'kick_fx_%p_i%d' p = <player> d = ($kick_fx_index)
	destroyscreenelement id = <fx_id>
	createscreenelement {
		type = containerelement
		id = <fx_id>
		parent = <container_id>
		pos = <particle_pos>
		z_priority = 8.0
		just = [center center]
		pos_anchor = [center center]
		alpha = 1.0
	}
	createscreenelement {
		type = containerelement
		local_id = grow_container
		parent = <fx_id>
		pos = (0.0, 0.0)
		just = [center center]
		pos_anchor = [center center]
	}
	<grow_id> = <id>
	<start_scale> = (<x_scale> * (1.0, 0.0) + (0.0, 1.0))
	<end_scale> = (<x_scale> * ($kick_fx_scale_end) + (0.0, 2.5))
	createscreenelement {
		type = spriteelement
		local_id = top_wave
		pos = (0.0, 0.0)
		texture = 0x06c143ed
		parent = <grow_id>
		rgba = [255 255 255 255]
		blend = add
		scale = <start_scale>
		alpha = 1.0
	}
	runscriptonscreenelement id = <fx_id> kick_fade_effect params = {t1 = 0.15 t2 = 0.25}
	runscriptonscreenelement id = <grow_id> kick_grow_effect params = {scale = <end_scale>}
	change kick_fx_index = (($kick_fx_index) + 1)
	if (($kick_fx_index) = 10)
		change \{kick_fx_index = 0}
	endif
endscript

script guitarevent_hit_open_note 
	guitarevent_kick_drum_hit_note player = <player> player_text = <player_text>
endscript

script guitarevent_hit_beginner_note 
	guitarevent_kick_drum_hit_note player_text = <player_text>
endscript

script playersetvolume 
	if gotparam \{volume}
		if (($<player_status>.part) = drum)
			if gotparam \{drum}
				switch <drum>
					case 1
					change structurename = <player_status> drum_volume1 = <volume>
					case 2
					change structurename = <player_status> drum_volume2 = <volume>
					case 3
					change structurename = <player_status> drum_volume3 = <volume>
					case 4
					change structurename = <player_status> drum_volume4 = <volume>
				endswitch
				return
			endif
		endif
		change structurename = <player_status> guitar_volume = <volume>
	endif
endscript

script playergetvolume 
	if (($<player_status>.part) = drum)
		if gotparam \{drum}
			switch <drum>
				case 1
				return volume = ($<player_status>.drum_volume1)
				case 2
				return volume = ($<player_status>.drum_volume2)
				case 3
				return volume = ($<player_status>.drum_volume3)
				case 4
				return volume = ($<player_status>.drum_volume4)
			endswitch
		endif
	endif
	return volume = ($<player_status>.guitar_volume)
endscript

script create_mushroomcloudhand \{text = qs(0x6f6d143d)}
	destroy_all_exploding_text
	spawnscriptnow create_exploding_text params = {text = <text>}
	if screenelementexists \{id = mushroomcloudhand}
		destroyscreenelement \{id = mushroomcloudhand}
	endif
	createscreenelement \{parent = root_window
		id = mushroomcloudhand
		type = descinterface
		desc = 'you_rock_gh5'
		z_priority = 0}
	spawnscriptnow \{handofgod_fx_01}
	spawnscriptnow \{handofgod_fx_02}
	destroyscreenelement \{id = mushroomcloudhand}
endscript

script hot_start_achieved \{band = 0
		combo = 0}
	gamemode_gettype
	if (<type> = practice)
		return
	endif
	if ($is_attract_mode = 1)
		return
	endif
	if (<player> = 1)

		if issingleplayergame
			pos = (640.0, 211.0)
			<base_scale> = 1.0
			spawnscriptnow gh_sfx_hotstart_singleplayer params = {combo = <combo>}
		elseif ($game_mode = gh4_p2_career || $game_mode = p2_quickplay)
			pos = (640.0, 170.0)
			<base_scale> = 1.0
			spawnscriptnow gh_sfx_hotstart_p1 params = {combo = <combo>}
		elseif ($is_network_game && $game_mode = p2_coop)
			pos = (640.0, 170.0)
			<base_scale> = 1.0
			spawnscriptnow gh_sfx_hotstart_p1 params = {combo = <combo>}
		else
			<s> = 0.35000002
			pos = (415.0, 170.0)
			spawnscriptnow gh_sfx_note_streak_p1 params = {combo = <combo>}
		endif
	else

		if ($game_mode = gh4_p2_career || $game_mode = p2_quickplay)
			pos = (640.0, 170.0)
			<base_scale> = 1.0
			spawnscriptnow gh_sfx_note_streak_p2 params = {combo = <combo>}
		elseif ($is_network_game && $game_mode = p2_coop)
			pos = (640.0, 170.0)
			<base_scale> = 1.0
			spawnscriptnow gh_sfx_note_streak_p2 params = {combo = <combo>}
		else
			<s> = 0.35000002
			pos = (865.0, 170.0)
			spawnscriptnow gh_sfx_note_streak_p2 params = {combo = <combo>}
		endif
	endif
	if NOT gamemode_isbandscoring
		getplayerinfo <player> part
		if (<part> = vocals)
			vocals_message_delayed {player = <player> text = qs(0x09a07a71) rgba = [255 172 64 255]}
		else
			hud_create_message player = <player> text = qs(0x09a07a71)
		endif
	elseif (<band> = 1)
		if gotparam \{players}
			hud_create_message band text = qs(0x09a07a71) style_script = hud_message_band_streak_style style_script_params = {players = <players>}
		else
			hud_create_message \{band
				text = qs(0x09a07a71)
				style_script = hud_message_band_streak_style
				style_script_params = {
					players = [
						1
						1
						1
						1
					]
				}}
		endif
	endif
endscript
