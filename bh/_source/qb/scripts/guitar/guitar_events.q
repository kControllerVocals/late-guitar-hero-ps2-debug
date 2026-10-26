guitar_events = [
	{
		type = call
		event = missed_note
		Scr = GuitarEvent_MissedNote
	}
	{
		type = call
		event = unnecessary_note
		Scr = GuitarEvent_UnnecessaryNote
	}
	{
		type = call
		event = hit_notes
		Scr = GuitarEvent_HitNotes
	}
	{
		type = call
		event = hit_note
		Scr = GuitarEvent_HitNote
	}
	{
		type = call
		event = drumfill_hit
		Scr = GuitarEvent_DrumFillHit
	}
	{
		type = call
		event = star_power_on
		Scr = GuitarEvent_StarPowerOn
	}
	{
		type = call
		event = star_power_off
		Scr = GuitarEvent_StarPowerOff
	}
	{
		type = spawn
		event = song_failed
		Scr = GuitarEvent_SongFailed
	}
	{
		type = spawn
		event = song_won
		Scr = GuitarEvent_SongWon
	}
	{
		type = spawn
		event = star_sequence_bonus
		Scr = GuitarEvent_StarSequenceBonus
	}
	{
		type = call
		event = whammy_off
		Scr = GuitarEvent_WhammyOff
	}
	{
		type = call
		event = firstnote_window_open
		Scr = GuitarEvent_FirstNote_Window_Open
	}
]
players_with_starpower = 0

script create_guitar_events 
	change \{players_with_starpower = 0}

	GetArraySize \{$guitar_events}
	array_entry = 0
	begin

	event = ($guitar_events [<array_entry>].event)
	type = ($guitar_events [<array_entry>].type)
	ExtendCRC <event> <player_text> out = event
	SetEventHandler response = call_script event = <event> Scr = event_spawner params = {event_spawned = <array_entry>}
	array_entry = (<array_entry> + 1)
	repeat <array_size>
	Block
endscript

script event_spawner 
	spawnscriptnow ($guitar_events [<event_spawned>].Scr) params = {<...>} id = song_event_scripts
endscript

script event_iterator 

	get_song_prefix song = <song_name>
	FormatText checksumname = song '%s_%e' s = <song_prefix> e = <event_string> AddToStringLookup = true
	array_entry = 0
	if NOT GlobalExists name = <song> type = array
		return
	endif
	GetArraySize $<song>
	if (<array_size> = 0)
		return
	endif
	GetSongTimeMs time_offset = <time_offset>
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
	ScriptName = ($<song> [<array_entry>].Scr)
	if (<ScriptName> = Band_PlayLoop || <ScriptName> = band_playidle)
		TimeMarkerReached_SetParams time_offset = (<time_offset> -2 * 16.667) array = <song> array_entry = <array_entry> ArrayOfStructures
	else
		TimeMarkerReached_SetParams time_offset = <time_offset> array = <song> array_entry = <array_entry> ArrayOfStructures
	endif
	begin
	if TimeMarkerReached
		GetSongTimeMs time_offset = <time_offset>
		break
	endif
	WaitOneGameFrame
	repeat
	TimeMarkerReached_ClearParams
	ScriptName = ($<song> [<array_entry>].Scr)
	if (<ScriptName> = band_playclip)
		nullscript
	elseif (<ScriptName> = Band_PlayLoop)
		video_venue_queue_command index = <array_entry>
	elseif (<ScriptName> = band_playidle)
		video_venue_queue_command index = <array_entry>
	elseif (<ScriptName> = Band_ForceAllToIdle)
		nullscript
	elseif (<ScriptName> = Band_MoveToNode)
		nullscript
	elseif ScriptExists <ScriptName>
		spawnscriptnow <ScriptName> params = {time = <time> event_time = (($<song> [<array_entry>]).time) ($<song> [<array_entry>].params)} id = song_event_scripts
	elseif SymbolIsCFunc <ScriptName>
		<ScriptName> {time = <time> event_time = (($<song> [<array_entry>]).time) ($<song> [<array_entry>].params)}
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
endscript

script GuitarEvent_MissedNote \{extended_miss = 0}
	play_bad_note_sound = 0
	if (<bum_note> = 1)
		Guitar_Wrong_Note_Sound_Logic <...>
	endif
	if NOT (($<player_status>.part) = drum)
		PlayerGetVolume player_status = <player_status>
		if NOT (<volume> = 0)
			if (<silent_miss> = 1)
				spawnscriptnow highway_pulse_black params = {player_text = ($<player_status>.text) player_status = <player_status>}
			elseif NOT (<extended_miss> = 1)
				PlayerSetVolume player_status = <player_status> volume = 0
				UpdateGuitarVolume
			endif
		endif
	endif
	if ($disable_band = 0)
		if CompositeObjectExists name = ($<player_status>.band_member)
			if ($<player_status>.part = guitar || $<player_status>.part = Bass)
				BandManager_MissedNote name = ($<player_status>.band_member)
			endif
		endif
	endif
endscript

script highway_pulse_black 
	<half_time> = ($highway_pulse_time / 2.0)
	FormatText checksumname = highway 'Highway_2D%p' p = <player_text> AddToStringLookup = true
	LegacyDoScreenElementMorph id = <highway> rgba = ($highway_pulse) time = <half_time>
	Wait <half_time> seconds
	if ($<player_status>.star_power_used = 1)
		LegacyDoScreenElementMorph id = <highway> rgba = ($highway_starpower) time = <half_time>
	else
		LegacyDoScreenElementMorph id = <highway> rgba = ($highway_normal) time = <half_time>
	endif
endscript

script GuitarEvent_UnnecessaryNote 
	Guitar_Wrong_Note_Sound_Logic <...>
	if NOT ($is_network_game && ($<player_status>.is_local_client = 0))
		PlayerSetVolume player_status = <player_status> volume = 0
		UpdateGuitarVolume
		jam_update_volume volume = 0 player = ($<player_status>.player)
	endif
	if ($always_strum = false)
		if ($disable_band = 0)
			if CompositeObjectExists name = ($<player_status>.band_member)
				if ($<player_status>.part = guitar || $<player_status>.part = Bass)
					LaunchEvent type = Anim_MissedNote target = ($<player_status>.band_member)
				endif
			endif
		endif
	endif
endscript

script GuitarEvent_HitNotes 
	if (<updatevolume> = true)
		UpdateGuitarVolume
		BandManager_HitNote name = ($<player_status>.band_member)
	endif
endscript

script GuitarEvent_HitNote 
	if GotParam \{kick}
		GuitarEvent_Kick_Drum_Hit_Note player = <player>
	elseif GotParam \{open_note}
		GuitarEvent_Kick_Drum_Hit_Note player = <player>
	elseif GotParam \{beginner_note}
		GuitarEvent_Kick_Drum_Hit_Note player = <player>
	else
		WaitOneGameFrame
		scale = (1.0, 1.0)
		star = ($<player_status>.star_power_used)
		name = <fx_id>
		NoteFX scale = <scale>
		Wait \{16
			gameframes}
		if ScreenElementExists id = <fx_id>
			DestroyScreenElement id = <fx_id>
		endif
	endif
endscript

script GuitarEvent_DrumFillHit 
	if GotParam \{kick}
		GuitarEvent_HitNote <...>
	endif
endscript
hit_particle_params = {
	z_priority = 8.0
	material = sys_Particle_Spark01_sys_Particle_Spark01
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
	material = sys_Particle_Spark01_sys_Particle_Spark01
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
	material = sys_Particle_Spark01_sys_Particle_Spark01
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

script GuitarEvent_StarPowerOn 
	KillSpawnedScript \{name = highway_pulse_black}
	if ($drum_solo_songtime_paused = 0)
		GH_Star_Power_Verb_On player = <player>
	endif
	if ($players_with_starpower = 0)
		ScreenFX_AddFXInstance \{viewport = bg_viewport
			name = Starpower_Tonemap
			scefName = Starpower_Tonemap
			type = Tonemap
			on = 1
			use_simple_version = 1}
	endif
	change players_with_starpower = ($players_with_starpower + 1)
	StarPowerOn player = <player>
	if ($current_num_players = 4)
		if (all_players_using_starpower)
			spawnscriptnow \{play_group_star_power_animation}
		endif
	endif
	HUD_meter_glow_blue
endscript

script GuitarEvent_StarPowerOff 
	KillSpawnedScript \{name = highway_pulse_black}
	change players_with_starpower = ($players_with_starpower - 1)
	if ($players_with_starpower = 0)
		if ScreenFX_FxInstanceExists \{viewport = bg_viewport
				name = Starpower_Tonemap}
			ScreenFX_RemoveFXInstance \{viewport = bg_viewport
				name = Starpower_Tonemap}
		endif
	endif
	if isSinglePlayerGame
		SoundEvent \{event = Star_Power_Release_Center_Gh4}
		SoundEvent \{event = Star_Power_Release_Front_GH4}
	else
		spawnscriptnow Star_Power_Release_SFX_Multiplayer params = {player = ($<player_status>.player)}
	endif
	GH_Star_Power_Verb_Off player = ($<player_status>.player)
	spawnscriptnow rock_meter_star_power_off params = {player_text = <player_text>}
	SpawnScriptLater Kill_StarPower_StageFX params = {<...>}
	FormatText checksumname = cont 'starpower_container_left%p' p = <player_text> AddToStringLookup = true
	if ScreenElementExists id = <cont>
		LegacyDoScreenElementMorph id = <cont> alpha = 0
	endif
	FormatText checksumname = cont 'starpower_container_right%p' p = <player_text> AddToStringLookup = true
	if ScreenElementExists id = <cont>
		LegacyDoScreenElementMorph id = <cont> alpha = 0
	endif
	FormatText checksumname = highway 'Highway_2D%p' p = <player_text> AddToStringLookup = true
	if ScreenElementExists id = <highway>
		SetScreenElementProps id = <highway> rgba = ($highway_normal_x2)
	endif
	spawnscriptnow \{Kill_StarPower_Camera}
	HUD_meter_glow_hide_blue
endscript

script do_a_clap_sfx 
	GetPakManCurrentName \{map = zones}
	if ((<pakname> = 'z_tool'))
		return
	endif
	volL = 0.0
	volR = 0.0
	if (($Star_Clap_Normal = 1) || ($Star_Clap_LeftCenterRight = 1) || ($Star_Clap_Middle = 1) || ($Star_Clap_Left) || ($Star_Clap_Left_Middle))
		volL = 118
	endif
	if (($Star_Clap_Normal = 1) || ($Star_Clap_LeftCenterRight = 1) || ($Star_Clap_Middle = 1) || ($Star_Clap_Right) || ($Star_Clap_Right_Middle))
		volR = 118
	endif
	GetRandomValue \{a = 0
		b = 2
		name = random_sample
		Integer}
	sample = Crowd_Group_Clap_01
	switch <random_sample>
		case 0
		sample = Crowd_Group_Clap_01
		case 1
		sample = Crowd_Group_Clap_02
		case 2
		sample = Crowd_Group_Clap_03
	endswitch

	PlaySound <sample> voll_percent = (<volL> * $Clap_Fade_Vol) volr_percent = (<volR> * $Clap_Fade_Vol) buss = Crowd_Star_Power
endscript

script GuitarEvent_PreFretbar 
	spawnscriptnow \{GH_Audible_Metronome}
	waittime = 0.18
	Wait <waittime> seconds
	spawnscriptnow Clapping_Logic params = {<...>}
endscript

script GH_Audible_Metronome 
	if ($Debug_Audible_Metronome = 1)
		Wait ((0.25 + (($default_lag_settings.xenon.input_lag_ms) * 0.001)) - 0.008333) seconds
		SoundEvent \{event = GH_SFX_BeatSoundEvent}
	endif
endscript

script GuitarEvent_Fretbar 
	GuitarEvent_Fretbar_CFunc
endscript

script GuitarEvent_Fretbar_Early 
endscript

script GuitarEvent_Fretbar_Late 
endscript

script check_first_note_formed 
	GetSongTime
	<StartTime> = (<songtime> - 0.0167)
	duration = ($<player_status>.check_time_early + $<player_status>.check_time_late)
	begin
	GetHeldPattern controller = ($<player_status>.controller) player = ($<player_status>.player) player_status = <player_status>
	if (<strum> = <hold_pattern>)
		PlayerSetVolume player_status = <player_status> volume = 100
		UpdateGuitarVolume
		jam_update_volume volume = 100 player = ($<player_status>.player)
	endif
	WaitOneGameFrame
	GetSongTime
	if ((<songtime> - <StartTime>) >= <duration>)
		break
	endif
	repeat
endscript

script GuitarEvent_FirstNote_Window_Open 
	if IsGuitarController controller = ($<player_status>.controller)
		GetStrumPattern entry = 0 song = <song>
		spawnscriptnow check_first_note_formed params = {strum = <strum> player_status = <player_status>}
	else
		PlayerSetVolume player_status = <player_status> volume = 100
		UpdateGuitarVolume
		jam_update_volume volume = 100 player = ($<player_status>.player)
	endif
endscript
blueWhammyFXID01p1 = JOW_NIL
blueWhammyFXID02p1 = JOW_NIL
greenWhammyFXID02p1 = JOW_NIL
orangeWhammyFXID01p1 = JOW_NIL
orangeWhammyFXID02p1 = JOW_NIL
redWhammyFXID01p1 = JOW_NIL
redWhammyFXID02p1 = JOW_NIL
yellowWhammyFXID01p1 = JOW_NIL
yellowWhammyFXID02p1 = JOW_NIL
blueWhammyFXID01p2 = JOW_NIL
blueWhammyFXID02p2 = JOW_NIL
greenWhammyFXID01p2 = JOW_NIL
greenWhammyFXID02p2 = JOW_NIL
orangeWhammyFXID01p2 = JOW_NIL
orangeWhammyFXID02p2 = JOW_NIL
redWhammyFXID01p2 = JOW_NIL
redWhammyFXID02p2 = JOW_NIL
yellowWhammyFXID01p2 = JOW_NIL
yellowWhammyFXID02p2 = JOW_NIL

script Destroy_AllWhammyFX 
	WhammyFXOffAll \{player_status = player1_status}
	WhammyFXOffAll \{player_status = player2_status}
endscript

script GuitarEvent_WhammyOn 
	WhammyFXOn
endscript

script GuitarEvent_WhammyOff 
	WhammyFXOff
endscript

script GuitarEvent_SongFailed 
	change \{players_with_starpower = 0}
	SetScriptCannotPause
	InputHandlerForbid
	OnExitRun \{InputHandlerPermit}
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
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	if ($failed_song = 1)
		return
	endif
	if ($Cheat_Invincible = 1)
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
		KillSpawnedScript \{name = guitar_jam_playback_recording}
		KillSpawnedScript \{name = guitar_jam_drum_playback}
		KillSpawnedScript \{name = jam_input_whammy_spawned}
		jam_stop_all_samples
		jam_deinit_reverb
		spawnscriptnow \{GuitarEvent_SongFailed_Spawned}
	endif
endscript

script GuitarEvent_SongFailed_Spawned 
	if ($is_attract_mode = 1)

		return
	endif
	disable_highway_prepass
	disable_bg_viewport
	LightShow_SongFailed
	GetSongTimeMs
	change failed_song_time = <time>
	PauseGame
	Progression_SongFailed
	UnPauseGame
	SoundEvent \{event = Crowd_Fail_Song_SFX}
	SoundEvent \{event = GH_SFX_You_Lose_Single_Player}
	disable_pause
	song_failed_show_highways
	PlayLossVideo
	Transition_Play \{type = songlost}
	Transition_Wait
	change \{current_transition = none}
	ui_event_wait_for_safe
	ui_event_get_top
	if NOT (<base_name> = 'gameplay')
		ui_event_block \{event = menu_back
			data = {
				state = uistate_gameplay
			}}
	endif
	PauseGame
	show_calibration = 0
	GetGlobalTags \{user_options
		param = has_calibrated}
	if (<has_calibrated> = 0)
	endif
	GameMode_GetType
	if ($is_network_game = 0)
		ui_event_wait_for_safe
		Wait \{1
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
			SetGlobalTags \{user_options
				params = {
					has_calibrated = 1
				}}
			Body = qs("You seem to be having a hard time hitting the notes. Maybe you'd like to blame it on the lag and calibrate for your TV?")
			spawnscriptnow {
				ui_event {
					params = {
						event = menu_change
						data = {
							state = uistate_options_calibrate_lag_warning
							Body = <Body>
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
		SoundEvent \{event = Crowd_Fail_Song_SFX}
		BG_Crowd_Front_End_Silence \{immediate = 1}
	else
	endif
	KillSpawnedScript \{name = create_exploding_text}
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
	SongUnLoad
	PauseGame
	Wait \{0.5
		second}
	player = 1
	begin
	GetPlayerInfo <player> current_health
	if (<current_health> < $health_poor_medium)
		song_failed_highway_x {player = <player>}
	endif
	player = (<player> + 1)
	repeat $current_num_players
	SoundEvent \{event = Band_Failed_X_SFX}
	if NOT ($band1_status.star_power_active)
		if ($band1_status.star_power_amount > (100.0 / 6.0))
			Wait \{0.3
				seconds}
			CreateScreenElement \{type = TextBlockElement
				id = sp_message
				parent = hud_root
				text = qs("Next time, try using star power to save the band.")
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
	Wait \{2.2
		seconds}
	UnPauseGame
endscript

script song_failed_highway_x 
	GetPlayerInfo <player> hud_parent
	GetPlayerInfo <player> part
	pos = (80.0, 40.0)
	switch <part>
		case Vocals
		icon = band_HUD_microphone2
		pos = (550.0, 80.0)
		case guitar
		icon = band_HUD_guitar2
		case Bass
		icon = band_HUD_bass2
		case drum
		icon = band_HUD_drums2
	endswitch
	if hud_root :Desc_ResolveAlias name = <hud_parent> param = parent_id
		if ScreenElementExists id = <parent_id>
			CreateScreenElement {
				type = SpriteElement
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
GPULog_OutputFilename = 'none'

script GuitarEvent_SongWon 
	change \{players_with_starpower = 0}
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	SetScriptCannotPause
	InputHandlerForbid
	OnExitRun \{InputHandlerPermit}
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
		if IsPs3
			FormatText \{TextName = filename
				'%s_gpu_ps3'
				s = $current_level
				DontAssertForChecksums}
		else
			FormatText \{TextName = filename
				'%s_gpu'
				s = $current_level
				DontAssertForChecksums}
		endif
		if NOT StringEquals \{a = $GPULog_OutputFilename
				b = 'none'}
			<filename> = $GPULog_OutputFilename
		endif
		TextOutputEnd output_text filename = <filename>
	endif
	if ($output_song_stats = 1)
		FormatText \{TextName = filename
			'%s_stats'
			s = $current_song
			DontAssertForChecksums}
		TextOutputStart
		TextOutput \{text = qs("\LPlayer 1")}
		FormatText TextName = text qs("\LScore: %s") s = ($player1_status.score) DontAssertForChecksums
		TextOutput text = <text>
		FormatText TextName = text qs("\LNotes Hit: %n of %t") n = ($player1_status.notes_hit) t = ($player1_status.total_notes) DontAssertForChecksums
		TextOutput text = <text>
		FormatText TextName = text qs("\LBest Run: %r") r = ($player1_status.best_run) DontAssertForChecksums
		TextOutput text = <text>
		FormatText TextName = text qs("\LMax Notes: %m") m = ($player1_status.max_notes) DontAssertForChecksums
		TextOutput text = <text>
		FormatText TextName = text qs("\LBase score: %b") b = ($player1_status.base_score) DontAssertForChecksums
		TextOutput text = <text>
		if (($player1_status.base_score) = 0)
			FormatText \{TextName = text
				qs("\LScore Scale: n/a")}
		else
			FormatText TextName = text qs("\LScore Scale: %s") s = (($player1_status.score) / ($player1_status.base_score)) DontAssertForChecksums
		endif
		TextOutput text = <text>
		if (($player1_status.total_notes) = 0)
			FormatText \{TextName = text
				qs("\LNotes Hit Percentage: n/a")}
		else
			FormatText TextName = text qs("\LNotes Hit Percentage: %s") s = ((($player1_status.notes_hit) / ($player1_status.total_notes)) * 100.0) DontAssertForChecksums
		endif
		TextOutput text = <text>
		TextOutputEnd output_text filename = <filename>
	endif
	if ($current_num_players = 2)
		GetSongTimeMs
		if ($last_time_in_lead_player = 0)
			change structurename = player1_status time_in_lead = ($player1_status.time_in_lead + <time> - $last_time_in_lead)
		elseif ($last_time_in_lead_player = 1)
			change structurename = player2_status time_in_lead = ($player2_status.time_in_lead + <time> - $last_time_in_lead)
		endif
		change \{last_time_in_lead_player = -1}
	endif
	restore_player_part_settings
	KillSpawnedScript \{name = guitar_jam_playback_recording}
	KillSpawnedScript \{name = guitar_jam_drum_playback}
	KillSpawnedScript \{name = jam_input_whammy_spawned}
	jam_stop_all_samples
	jam_deinit_reverb
	spawnscriptnow \{GuitarEvent_SongWon_Spawned}
endscript

script GuitarEvent_SongWon_Spawned 
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
	elseif ($is_partyplay_mode = 1 || $is_freeplay_mode = 1)
		quickplay_skip_song \{no_sound}
		return
	endif
	Progression_EndCredits_Done
	PauseGame
	disable_pause
	ui_event_wait_for_safe
	ui_event_get_top
	if NOT (<base_name> = 'gameplay')
		ui_event_block \{event = menu_back
			data = {
				state = uistate_gameplay
			}}
	endif
	if ($game_mode = gh4_p1_career || $game_mode = gh4_p2_career || $game_mode = p1_quickplay || $game_mode = p2_quickplay || $game_mode = gh4_p3_career || $game_mode = gh4_p4_career || $game_mode = p3_quickplay || $game_mode = p4_quickplay)
		spawnscriptnow \{Cheer_Before_Explosion}
	endif

	Skate8_SFX_Backgrounds_New_Area \{BG_SFX_Area = $Current_Crowd_Looping_BG_Area_Good}
	Crowd_Surge_And_Sustain_At_End_Of_Song
	spawnscriptnow \{You_Rock_Waiting_Crowd_SFX}
	tie = false
	if ($game_mode = p2_pro_faceoff)
		p1_score = ($player1_status.score)
		p2_score = ($player2_status.score)
		if (<p2_score> > <p1_score>)
			winner = qs("Two")
		elseif (<p1_score> > <p2_score>)
			winner = qs("One")
		else
			<tie> = true
		endif
		if (<tie> = true)
			winner_text = qs("TIE!")
			winner_space_between = (15.0, 0.0)
			winner_scale = 0.5
			fit_dims = (100.0, 0.0)
		else
			FormatText TextName = winner_text qs("Player %s Rocks!") s = <winner>
			winner_space_between = (50.0, 0.0)
			winner_scale = 1.5
		endif
	else
		winner_text = Random (@ qs("YOU ROCK!") @ qs("YOU ROCK!") )
		winner_space_between = (45.0, 0.0)
		fit_dims = (350.0, 0.0)
		winner_scale = 1.0
	endif
	spawnscriptnow \{waitAndKillHighway}
	KillSpawnedScript \{name = jiggle_text_array_elements}
	spawnscriptnow \{wait_and_play_you_rock_movie}
	Create_MushroomCloudHand text = <winner_text>
	spawnscriptnow \{You_Rock_SFX_End}
	change \{old_song = none}
	Progression_SongWon
	if ($current_transition = preencore)
		end_song
		UnPauseGame
		Transition_Play \{type = preencore}
		Transition_Wait
		change \{current_transition = none}
		PauseGame
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
		UnPauseGame
		if ($is_network_game = 0)
			Transition_Play \{type = songwon}
		else
			if ($game_mode = p4_pro_faceoff || $game_mode = p8_pro_faceoff)
				opponent_score = ($band2_status.score)
				our_score = ($band1_status.score)
				if (<opponent_score> > <our_score>)
					Transition_Play \{type = songlost}
				else
					Transition_Play \{type = songwon}
				endif
			else
				Transition_Play \{type = songwon}
			endif
		endif
		Transition_Wait
		change \{current_transition = none}
		PauseGame
	endif
	push_loading_screen \{mini}
	OnExitRun \{pop_loading_screen}
	KillSpawnedScript \{name = create_exploding_text}
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
				need_loading_screen
			}}
	else
		destroy_all_exploding_text
		if ($autotest_on = 1)
			ui_event \{event = menu_change
				data = {
					state = UIstate_autotest_next_test
				}}
		endif
		if NOT GotParam \{encore_transition}
			if ($progression_beat_game_last_song = 1)
				ui_event \{event = menu_change
					data = {
						state = uistate_beat_game
					}}
			else
				loading_transition = 0
				GameMode_GetType
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
						data = {state = uistate_song_breakdown playlist_transition}
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
	KillMovie \{TextureSlot = 1}
endscript
g_you_rock_movie = none

script create_you_rock_effect \{player_status = player1_status}

	switch ($g_you_rock_movie)
		case Player1_wins
		case Player2_wins
		case Fret_Flames
		case Golden_Guitar
		default
	endswitch
endscript

script wait_and_play_you_rock_movie 
	create_you_rock_effect
endscript

script waitAndKillHighway 
	Wait \{0.5
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
	Band_EnableTempoIterator
endscript
measure_callback = nullscript
beat_callback = nullscript

script SetMeasureCallback 
	if GotParam \{callback}
		change measure_callback = <callback>
	else
	endif
endscript

script ClearMeasureCallbacks 
	change \{measure_callback = nullscript}
endscript

script SetBeatCallback 
	if GotParam \{callback}
		change beat_callback = <callback>
	else
	endif
endscript

script GetTimeToNextBeat 
	GetSongTimeMs \{time_offset = $tempo_iterator_offset}
	return time_to_next_beat = ($next_beat_time - <time>)
endscript

script ClearBeatCallbacks 
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
GuitarEvent_StarSequenceBonus_BigBoltParams = {
	id = Blank
	parent = Blank
	pos = (0.0, 0.0)
	rot_angle = 0.0
	type = SpriteElement
	material = sys_Big_Bolt01_sys_Big_Bolt01
	rgba = [
		127
		213
		255
		255
	]
	scale = $star_power_bolt_scale
	just = [
		center
		bottom
	]
	z_priority = 6
	blend = Add
	use_animated_uvs = true
	top_down_v
	frame_length = 0.005
	num_uv_frames = (8.0, 1.0)
}

script GuitarEvent_StarSequenceBonus 
	if GuitarEvent_StarSequenceBonus_CFunc_A
		return
	endif
	destroy_big_bolt_cfunc_setup
	begin
	if destroy_big_bolt_cfunc
		break
	endif
	WaitOneGameFrame
	repeat
	destroy_big_bolt_cfunc_cleanup
	GuitarEvent_StarSequenceBonus_CFunc_B
	Wait \{$star_power_bolt_time
		seconds}
	destroy_big_bolt_cfunc_setup
	begin
	if destroy_big_bolt_cfunc
		break
	endif
	WaitOneGameFrame
	repeat
	destroy_big_bolt_cfunc_cleanup
endscript

script destroy_big_bolt 
	gem_count = 0
	GetArraySize \{$gem_colors}
	begin
	<note> = (<gem_array> [(<gem_count> + 1)])
	if (<note> > 0)
		FormatText checksumname = name 'big_bolt%p%e' p = ($<player_status>.text) e = <gem_count> AddToStringLookup = true
		DestroyScreenElement id = <name>
	endif
	gem_count = (<gem_count> + 1)
	repeat <array_size>
endscript

script GuitarEvent_Multiplier4xOff 
	SoundEvent \{event = UI_SFX_Lose_Multiplier_4X}
	SoundEvent \{event = Lose_Multiplier_Crowd}
	spawnscriptnow highway_pulse_multiplier_loss params = {player = ($<player_status>.player) player_text = ($<player_status>.text) multiplier = 4}
endscript

script GuitarEvent_Multiplier3xOff 
	SoundEvent \{event = UI_SFX_Lose_Multiplier_3X}
	spawnscriptnow highway_pulse_multiplier_loss params = {player = ($<player_status>.player) player_text = ($<player_status>.text) multiplier = 3}
endscript

script GuitarEvent_Multiplier2xOff 
	SoundEvent \{event = UI_SFX_Lose_Multiplier_2X}
	spawnscriptnow highway_pulse_multiplier_loss params = {player = ($<player_status>.player) player_text = ($<player_status>.text) multiplier = 2}
endscript

script GuitarEvent_KillSong \{loadingtransition = 0}
	change \{players_with_starpower = 0}
	GH3_SFX_Stop_Sounds_For_KillSong <...> loading_transition = <loading_transition>
endscript

script GuitarEvent_EnterVenue 
	GetPakManCurrentName \{map = zones}
	FormatText checksumname = echo_params 'Echo_Crowd_Buss_%s' s = <pakname>
	FormatText checksumname = reverb_params 'Reverb_Crowd_Buss_%s' s = <pakname>
	if NOT GlobalExists name = <echo_params>
		echo_params = Echo_Crowd_Buss_Default
	endif
	if NOT GlobalExists name = <reverb_params>
		reverb_params = Reverb_Crowd_Buss_Default
	endif
	setsoundbusseffects effects = [{$<echo_params>}]
	setsoundbusseffects effects = [{$<reverb_params>}]
endscript

script GuitarEvent_ExitVenue 
	setsoundbusseffects \{effects = [
			{
				$Echo_Crowd_Buss
			}
		]}
	setsoundbusseffects \{effects = [
			{
				$Reverb_Crowd_Buss
			}
		]}
endscript

script GuitarEvent_GemStarPowerOn 
endscript

script GuitarEvent_TransitionFastIntro 
endscript

script GuitarEvent_TransitionPreEncore 
endscript

script GuitarEvent_TransitionEncore 
endscript

script kick_fade_effect 
	Obj_GetID
	<ObjID> :SE_SetProps alpha = 0 time = <t2> Anim = fast_out rgba = [200 , 70 , 255 , 255]
	<ObjID> :SE_WaitProps
	DestroyScreenElement id = <ObjID>
endscript

script kick_grow_effect 
	Obj_GetID
	<ObjID> :SE_SetProps scale = <scale> time = 0.25 Anim = fast_out
endscript
kick_index = 0
kick_fx_index = 0
kick_fx_scale = 1.0
kick_fx_scale_3p = 1.2
kick_fx_scale_end = (1.25, 0.0)

script GuitarEvent_Kick_Drum_Hit_Note \{player = 1}
	KickFX
endscript

script GuitarEvent_Hit_Open_Note 
	GuitarEvent_Kick_Drum_Hit_Note player = <player> player_text = <player_text>
endscript

script GuitarEvent_Hit_Beginner_Note 
	GuitarEvent_Kick_Drum_Hit_Note player_text = <player_text>
endscript

script PlayerSetVolume 
	if GotParam \{volume}
		if (($<player_status>.part) = drum)
			if GotParam \{drum}
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

script PlayerGetVolume 
	if (($<player_status>.part) = drum)
		if GotParam \{drum}
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

script Create_MushroomCloudHand \{text = qs("You Rock!")}
	destroy_all_exploding_text
	spawnscriptnow create_exploding_text params = {text = <text> scale = 1.8}
	if ScreenElementExists \{id = MushroomCloudHand}
		DestroyScreenElement \{id = MushroomCloudHand}
	endif
	SpawnScriptLater \{YouRock_Explosions_ComboCombo}
endscript

script hot_start_achieved \{Band = 0
		combo = 0}
	GameMode_GetType
	if (<type> = practice)
		return
	endif
	if ($is_attract_mode = 1)
		return
	endif
	if (<player> = 1)

		if isSinglePlayerGame
			pos = (640.0, 211.0)
			<base_scale> = 1.0
			spawnscriptnow GH_SFX_HotStart_SinglePlayer params = {combo = <combo>}
		elseif ($game_mode = gh4_p2_career || $game_mode = p2_quickplay)
			pos = (640.0, 170.0)
			<base_scale> = 1.0
			spawnscriptnow GH_SFX_HotStart_P1 params = {combo = <combo>}
		else
			<s> = 0.35000002
			pos = (415.0, 170.0)
			spawnscriptnow GH_SFX_Note_Streak_P1 params = {combo = <combo>}
		endif
	else

		if ($game_mode = gh4_p2_career || $game_mode = p2_quickplay)
			pos = (640.0, 170.0)
			<base_scale> = 1.0
			spawnscriptnow GH_SFX_Note_Streak_P2 params = {combo = <combo>}
		else
			<s> = 0.35000002
			pos = (865.0, 170.0)
			spawnscriptnow GH_SFX_Note_Streak_P2 params = {combo = <combo>}
		endif
	endif
	if NOT GameMode_IsBandScoring
		GetPlayerInfo <player> part
		if (<part> = Vocals)
			vocals_message_delayed {player = <player> text = qs("Hot Start!") rgba = [255 172 64 255]}
		else
			hud_create_message player = <player> text = qs("Hot Start!")
		endif
	elseif (<Band> = 1)
		if GotParam \{players}
			hud_create_message Band text = qs("Hot Start!") style_script = hud_message_band_streak_style style_script_params = {players = <players>}
		else
			hud_create_message \{Band
				text = qs("Hot Start!")
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
