stream_config = gh1
guitar_unique_bend_id = null
song_is_waiting_to_start = 0

script preload_song \{StartTime = 0
		fadeintime = 0.0
		seek = 1}
	adjustedtime = <StartTime>

	get_song_prefix song = <song_name>
	get_song_struct song = <song_name>
	if StructureContains Structure = <song_struct> dlc_stream_name
		song_prefix = (<song_struct>.dlc_stream_name)
	endif
	if NOT ($current_song = jamsession)
		if NOT GotParam \{songrate}
			songrate = $current_speedfactor
		endif
		if NOT SongLoad filename = <song_prefix> content_index = <content_index> position = <StartTime> songrate = <songrate>
			if NOT CD

			endif
			destroy_loading_screen
			DownloadContentLost
			return \{false}
		endif
	endif
	change \{song_is_waiting_to_start = 1}
	if (<seek> = 1)

		SetSeekPosition_Song position = <StartTime>
	else

	endif
	if NOT ($current_song = jamsession)
		if NOT ($game_mode = practice)
			CreateEffectSendStack slot = ($starpower_sendeffect_slot) effects = [{$Starpower_Echo} {$Starpower_Reverb} {$HighPass_StarPower}]
		endif
	endif
	if StructureContains Structure = <song_struct> overall_song_volume
		SongSetMasterVolume vol = (<song_struct>.overall_song_volume)
	endif
	SongSetCrowdPan pan1x = ($Crowd_Singalong_Pan1x) pan1y = ($Crowd_Singalong_Pan1y) pan2x = ($Crowd_Singalong_Pan2x) pan2y = ($Crowd_Singalong_Pan2y)
	return adjustedtime = <adjustedtime>
endscript

script SetupSongDSPNetworks 
	get_song_prefix song = <song_name>
	get_song_struct song = <song_name>
	mode = $game_mode
	if ($is_attract_mode = 1)
		mode = attract_mode
	endif
	num_players = $current_num_players
	GameMode_GetNumPlayersShown
	if (<num_players_shown> < <num_players>)
		<num_players> = <num_players_shown>
	endif
	player1_part = ($player1_status.part)
	player2_part = ($player2_status.part)
	player3_part = ($player3_status.part)
	player4_part = ($player4_status.part)
	GetPlayerInfo \{1
		highway_position}
	p1_highway_position = <highway_position>
	GetPlayerInfo \{2
		highway_position}
	p2_highway_position = <highway_position>
	GetPlayerInfo \{3
		highway_position}
	p3_highway_position = <highway_position>
	GetPlayerInfo \{4
		highway_position}
	p4_highway_position = <highway_position>
	mono_drums = 0
	if StructureContains Structure = <song_struct> mono_drums
		mono_drums = (<song_struct>.mono_drums)
	endif
	Speed = ($current_speedfactor)
	SongSetupPlayerParts <...>
	SongSetPlayerEQSettings
	GetPakManCurrentName \{map = zones}

	FormatText checksumname = ReverbParams 'Reverb_Crowd_Buss_%t' t = <pakname> DoNotResolve
	if GlobalExists name = <ReverbParams> type = Structure

		SongSetCrowdReverbParams ($<ReverbParams>)
	else

	endif
endscript

script SongSetPlayerEQSettings 
	primary_profile = 1
	player = 1
	begin
	GetPlayerInfo <player> controller
	if ((<controller>) = ($primary_controller))
		primary_profile = <player>
	endif
	player = (<player> + 1)
	repeat $current_num_players

	GetPlayerInfo <primary_profile> part
	active_profile_part = <part>

	GetGlobalTags \{user_options
		attract_mode_fix = 1}
endscript

script waitforseek_song 
	Wait \{15
		gameframe}
	return
endscript

script setslomo_song 
	SongSetPitch pitch_percent = (<slomo> * 100.0)
endscript

script begin_jam_song \{Pause = 0}
	GetSongTimeMs
	CastToInteger \{time}

	spawnscriptnow guitar_jam_playback_recording params = {jam_instrument = 0 start_time = <time> in_game = 1}
	spawnscriptnow guitar_jam_playback_recording params = {jam_instrument = 1 start_time = <time> in_game = 1}
	spawnscriptnow guitar_jam_playback_recording params = {jam_instrument = 2 start_time = <time> in_game = 1}
	spawnscriptnow guitar_jam_playback_recording params = {jam_instrument = 4 start_time = <time> in_game = 1}
	spawnscriptnow guitar_jam_drum_playback params = {start_time = <time> gem_array = ($jam_tracks [3].in_game_gem_array)}
	jam_init_volumes
	jam_init_reverb
	jam_init_pan
	guitar_jam_effects_toggle_active \{jam_instrument = 0
		force_state = on}
	guitar_jam_effects_toggle_active \{jam_instrument = 1
		force_state = on}
	spawnscriptnow \{jam_input_whammy_spawned
		id = jam_input_spawns}
	change \{song_is_waiting_to_start = 0}
endscript

script begin_song \{Pause = 0}
	SpawnScriptLater \{fadePlayingIntro}
	if NOT ($current_song_qpak = jamsession)
		if (<Pause> = 0)
			SongUnPause
		else
			SongPause
		endif
	endif
	BroadcastEvent \{type = song_started}
	change \{song_is_waiting_to_start = 0}
endscript

script SetSeekPosition_Song \{position = 0}
	SongSeek time = <position>
endscript
Waiting_For_Pitching = 0

script Failed_Song_Pitch_Down 
	SongSetPitch \{pitch = -8
		time = 3}
	SongSetMasterVolume \{vol = -20
		time = 3}
	change \{Waiting_For_Pitching = 1}
	Wait \{3
		seconds}
	spawnscriptnow \{end_song}
endscript

script end_song \{song_failed_pitch_streams = 0}
	if NOT (<song_failed_pitch_streams> = 1)
		KillSpawnedScript \{name = Failed_Song_Pitch_Down}
		if ($Waiting_For_Pitching = 1)
			change \{Waiting_For_Pitching = 0}
		endif
		DestroyEffectSendStack slot = ($starpower_sendeffect_slot)
		SongStop
	else

		spawnscriptnow \{Failed_Song_Pitch_Down}
	endif
	change \{song_is_waiting_to_start = 0}
endscript

script set_whammy_pitchshift 
	SongSetPlayerWhammy player = ($<player_status>.player) whammy_value = (1 - (<control> * 0.057))
endscript

script PauseGh3Sounds 
	SongPause
	MuteEffectSend slot = ($starpower_sendeffect_slot)
	VocalDSPSetParams \{mute_all}
	PauseSoundsByBuss \{Master}
	if ($drum_solo_songtime_paused = 1)
		return
	endif
endscript

script UnpauseGh3Sounds 
	if ($drum_solo_songtime_paused = 1)
		return
	endif
	UnMuteEffectSend slot = ($starpower_sendeffect_slot)
	VocalDSPSetParams \{unmute_all}
	if ($song_is_waiting_to_start = 0)
		if ($ps2_training_gem_scroller_paused = 0)
			SongUnPause
		endif
	endif
	UnpauseSoundsByBuss \{Master}
endscript
