stream_config = gh1
0x84acfb5b = null
song_is_waiting_to_start = 0

script preload_song \{starttime = 0
		fadeintime = 0.0
		seek = 1}
	adjustedtime = <starttime>

	get_song_prefix song = <song_name>
	get_song_struct song = <song_name>
	if structurecontains structure = <song_struct> dlc_stream_name
		song_prefix = (<song_struct>.dlc_stream_name)
	endif
	if NOT ($current_song = jamsession)
		if NOT gotparam \{0x22b8afbb}
			0x22b8afbb = $current_speedfactor
		endif
		if NOT songload filename = <song_prefix> content_index = <content_index> position = <starttime> 0x22b8afbb = <0x22b8afbb>
			if NOT cd

			endif
			destroy_loading_screen
			downloadcontentlost
			return \{false}
		endif
	endif
	change \{song_is_waiting_to_start = 1}
	if (<seek> = 1)

		setseekposition_song position = <starttime>
	else

	endif
	if NOT ($current_song = jamsession)
		if NOT ($game_mode = training)
			createeffectsendstack slot = ($starpower_sendeffect_slot) effects = [{$starpower_echo} {$starpower_reverb} {$highpass_starpower}]
		endif
	endif
	songsetcrowdpan pan1x = ($crowd_singalong_pan1x) pan1y = ($crowd_singalong_pan1y) pan2x = ($crowd_singalong_pan2x) pan2y = ($crowd_singalong_pan2y)
	if structurecontains structure = <song_struct> overall_song_volume
		songsetmastervolume vol = (<song_struct>.overall_song_volume)
	endif
	return adjustedtime = <adjustedtime>
endscript

script setupsongdspnetworks 
	get_song_prefix song = <song_name>
	get_song_struct song = <song_name>
	mode = $game_mode
	if ($boss_battle = 1)
		mode = boss_battle
	endif
	if ($is_attract_mode = 1)
		mode = attract_mode
	endif
	if ui_event_exists_in_stack \{name = 'metallifacts'}
		mode = attract_mode
	endif
	num_players = $current_num_players
	gamemode_getnumplayersshown
	if (<num_players_shown> < <num_players>)
		<num_players> = <num_players_shown>
	endif
	player1_part = ($player1_status.part)
	player2_part = ($player2_status.part)
	player3_part = ($player3_status.part)
	player4_part = ($player4_status.part)
	getplayerinfo \{1
		highway_position}
	p1_highway_position = <highway_position>
	getplayerinfo \{2
		highway_position}
	p2_highway_position = <highway_position>
	getplayerinfo \{3
		highway_position}
	p3_highway_position = <highway_position>
	getplayerinfo \{4
		highway_position}
	p4_highway_position = <highway_position>
	mono_drums = 0
	if structurecontains structure = <song_struct> mono_drums
		mono_drums = (<song_struct>.mono_drums)
	endif
	speed = ($current_speedfactor)
	songsetupplayerparts <...>
	songsetplayereqsettings
	getpakmancurrentname \{map = zones}

	formattext checksumname = reverbparams 'Reverb_Crowd_Buss_%t' t = <pakname> donotresolve
	if globalexists name = <reverbparams> type = structure

		songsetcrowdreverbparams ($<reverbparams>)
	else

	endif
endscript

script songsetplayereqsettings 
	primary_profile = 1
	player = 1
	begin
	getplayerinfo <player> controller
	if ((<controller>) = ($primary_controller))
		primary_profile = <player>
	endif
	player = (<player> + 1)
	repeat $current_num_players

	getplayerinfo <primary_profile> part
	active_profile_part = <part>

	getglobaltags \{user_options
		attract_mode_fix = 1}
endscript

script waitforseek_song 
	wait \{15
		gameframe}
	return
endscript

script setslomo_song 
	songsetpitch pitch_percent = (<slomo> * 100.0)
endscript

script begin_jam_song \{pause = 0}
	getsongtimems
	casttointeger \{time}

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

script begin_song \{pause = 0
		0xb49e19e9 = 0}
	spawnscriptlater \{0xc5a6b981}
	if NOT ($current_song_qpak = jamsession)
		if (<pause> = 0)
			songunpause 0xb49e19e9 = <0xb49e19e9>
		else
			songpause
		endif
	endif
	broadcastevent \{type = song_started}
	change \{song_is_waiting_to_start = 0}
endscript

script setseekposition_song \{position = 0}
	songseek time = <position>
endscript
waiting_for_pitching = 0

script failed_song_pitch_down 
	songsetpitch \{pitch = -8
		time = 3}
	songsetmastervolume \{vol = -20
		time = 3}
	change \{waiting_for_pitching = 1}
	wait \{3
		seconds}
	spawnscriptnow \{end_song}
endscript

script end_song \{song_failed_pitch_streams = 0}
	if NOT (<song_failed_pitch_streams> = 1)
		killspawnedscript \{name = failed_song_pitch_down}
		if ($waiting_for_pitching = 1)
			change \{waiting_for_pitching = 0}
		endif
		destroyeffectsendstack slot = ($starpower_sendeffect_slot)
		0x05924e09
		songstop
	else

		spawnscriptnow \{failed_song_pitch_down}
	endif
	change \{song_is_waiting_to_start = 0}
endscript

script set_whammy_pitchshift 
	songsetplayerwhammy player = ($<player_status>.player) whammy_value = (1 - (<control> * 0.057))
endscript

script pausegh3sounds 
	songpause
	muteeffectsend slot = ($starpower_sendeffect_slot)
	vocaldspsetparams \{mute_all}
	pausesoundsbybuss \{master}
	if ($drum_solo_songtime_paused = 1)
		return
	endif
endscript

script unpausegh3sounds 
	if ($drum_solo_songtime_paused = 1)
		return
	endif
	unmuteeffectsend slot = ($starpower_sendeffect_slot)
	vocaldspsetparams \{unmute_all}
	if ($song_is_waiting_to_start = 0)
		if ($0xd441408d = 0)
			songunpause
		endif
	endif
	unpausesoundsbybuss \{master}
endscript
