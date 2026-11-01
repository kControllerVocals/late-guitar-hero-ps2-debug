stream_config = gh1
song_fsb_id = -1
song_fsb_name = 'none'
song_stream_id = null
song_unique_id = null
guitar_player1_stream_id = null
guitar_player1_unique_id = null
guitar_player2_stream_id = null
guitar_player2_unique_id = null
extra_stream_id = null
extra_unique_id = null
reverb_unique_id = null
band_stream_id = null
band_unique_id = null
crowd_stream_id = null
crowd_unique_id = null
crowd_stream_name = null
song_paused = 0

script preload_song \{StartTime = 0
		fadeintime = 0.0}

	change \{song_stream_id = null}
	change \{song_unique_id = null}
	change \{guitar_player1_stream_id = null}
	change \{guitar_player1_unique_id = null}
	change \{guitar_player2_stream_id = null}
	change \{guitar_player2_unique_id = null}
	change \{extra_stream_id = null}
	change \{extra_unique_id = null}
	change \{reverb_unique_id = null}
	change \{band_stream_id = null}
	change \{band_unique_id = null}
	change \{crowd_stream_id = null}
	change \{crowd_unique_id = null}
	change \{crowd_stream_name = null}
	get_song_prefix song = <song_name>
	get_song_struct song = <song_name>
	if StructureContains Structure = <song_struct> streamname
		song_prefix = (<song_struct>.streamname)
	endif
	if ($current_speedfactor = 1.0)
		ps2_song_prefix = <song_prefix>
		if ($game_mode = p2_coop || $game_mode = p2_quickplay ||
				($game_mode = training && ($player1_status.part = rhythm)))
			if StructureContains Structure = <song_struct> use_coop_notetracks
				FormatText TextName = ps2_song_prefix '%s_coop' s = <song_prefix> AddToStringLookup
			endif
		endif
		if NOT SongLoadFSB song_prefix = <ps2_song_prefix>
			DownloadContentLost
			return
		endif
	endif
	stream_config = gh1
	get_song_struct song = <song_name>
	if StructureContains Structure = <song_struct> name = version
		stream_config = (<song_struct>.version)
	endif
	SoundBussUnlock \{Band_Balance}
	SoundBussUnlock \{Guitar_Balance}
	if StructureContains Structure = <song_struct> name = band_playback_volume
		SetSoundBussParams {Band_Balance = {vol = ((<song_struct>.band_playback_volume) - 1.5)}} time = <fadeintime>
	else
		SetSoundBussParams {Band_Balance = {vol = -1.5}} time = <fadeinttime>
	endif
	if StructureContains Structure = <song_struct> name = guitar_playback_volume
		SetSoundBussParams {Guitar_Balance = {vol = ((<song_struct>.guitar_playback_volume) - 1.5)}} time = <fadeintime>
	else
		SetSoundBussParams {Guitar_Balance = {vol = -1.5}} time = <fadeintime>
	endif
	SoundBussLock \{Band_Balance}
	SoundBussLock \{Guitar_Balance}
	change stream_config = <stream_config>
	FormatText checksumname = song_stream '%s_song' s = <song_prefix> AddToStringLookup
	FormatText checksumname = guitar_stream '%s_guitar' s = <song_prefix> AddToStringLookup
	FormatText checksumname = rhythm_stream '%s_rhythm' s = <song_prefix> AddToStringLookup
	FormatText checksumname = crowd_stream '%s_crowd' s = <song_prefix> AddToStringLookup
	FormatText TextName = crowd_stream_text '%s_crowd' s = <song_prefix> AddToStringLookup
	if ($game_mode = p2_coop || $game_mode = p2_quickplay ||
			($game_mode = training && ($player1_status.part = rhythm)))
		if StructureContains Structure = <song_struct> use_coop_notetracks
			FormatText checksumname = song_stream '%s_coop_song' s = <song_prefix> AddToStringLookup
			FormatText checksumname = guitar_stream '%s_coop_guitar' s = <song_prefix> AddToStringLookup
			FormatText checksumname = rhythm_stream '%s_coop_rhythm' s = <song_prefix> AddToStringLookup
		endif
	endif
	if ($current_speedfactor = 1.0)

		change song_stream_id = <song_stream>
		if PreloadStream <song_stream> buss = Master position = <StartTime>
			change song_unique_id = <unique_id>
		else
			ScriptAssert 'Could not load song track for %s' s = <song_prefix>
		endif
	endif
	extra_stream = null
	if (<stream_config> = gh3)
		if ($current_speedfactor = 1.0)
			change crowd_stream_name = <crowd_stream_text>
		endif
		<extra_stream> = <rhythm_stream>
	endif
	if StructureContains Structure = <song_struct> name = extra_stream
		FormatText checksumname = extra_stream '%s_%t' s = <song_prefix> t = (<song_struct>.extra_stream) AddToStringLookup
	endif
	if ($current_num_players = 1)
		change guitar_player1_stream_id = <guitar_stream>
		if ($current_speedfactor = 1.0)
			if (($player1_status.part) = rhythm && (<stream_config> != gh1))
				if NOT PreloadStream <extra_stream> buss = Master allow_dsp = true position = <StartTime>
					ScriptAssert 'Could not load player1 bass track for %s' s = <song_prefix>
				endif
				change guitar_player1_unique_id = <unique_id>
				change reverb_unique_id = <unique_id>
				<extra_stream> = <guitar_stream>
			else
				if NOT PreloadStream <guitar_stream> buss = Master allow_dsp = true position = <StartTime>
					ScriptAssert 'Could not load player1 guitar track for %s' s = <song_prefix>
				endif
				change guitar_player1_unique_id = <unique_id>
				change reverb_unique_id = <unique_id>
				<extra_stream> = <rhythm_stream>
			endif
		else
			if ($current_speedfactor >= 0.75)
				extrapath = '125'
				songrate = 125
			elseif ($current_speedfactor >= 0.6)
				extrapath = '150'
				songrate = 150
			else
				extrapath = '200'
				songrate = 200
			endif
			if (($player1_status.part) = rhythm && (<stream_config> != gh1))
				if NOT PreLoadChecksumStream <extra_stream> buss = Master stereo = false extrapath = <extrapath> songrate = <songrate> samplerate = 11025 allow_dsp = true position = <StartTime> practice = true
					ScriptAssert 'Could not load player1 bass track for %s' s = <song_prefix>
				endif
				change guitar_player1_unique_id = <unique_id>
				<extra_stream> = <guitar_stream>
			else
				if NOT PreLoadChecksumStream <guitar_stream> buss = Master stereo = false extrapath = <extrapath> songrate = <songrate> samplerate = 11025 allow_dsp = true position = <StartTime> practice = true
					ScriptAssert 'Could not load player1 guitar track for %s' s = <song_prefix>
				endif
				change guitar_player1_unique_id = <unique_id>
				<extra_stream> = <rhythm_stream>
			endif
		endif
		if ($current_speedfactor = 1.0)
			if NOT (<extra_stream> = null)
				change extra_stream_id = <extra_stream>
				if PreloadStream <extra_stream> buss = Master position = <StartTime>
					change extra_unique_id = <unique_id>
				endif
			endif
		endif
	else
		if ((<stream_config> != gh1) && (($player1_status.part) != rhythm) && (($player2_status.part) != rhythm))
			change extra_stream_id = <extra_stream>
			PreloadStream <extra_stream> buss = Master position = <StartTime>
			if (<unique_id> != 0)
				change extra_unique_id = <unique_id>
			endif
			PreloadStream <guitar_stream> buss = Master allow_dsp = true position = <StartTime>
			change reverb_unique_id = <unique_id>
			change guitar_player1_stream_id = <guitar_stream>
			change guitar_player1_unique_id = <unique_id>
			change guitar_player2_stream_id = <guitar_stream>
			change guitar_player2_unique_id = <unique_id>
		else
			PreloadStream <extra_stream> buss = Master allow_dsp = true position = <StartTime>
			if (<unique_id> = 0)
				ScriptAssert 'Could not load bass track for %s' s = <song_prefix>
			endif
			if (($player1_status.part) = rhythm)
				change guitar_player1_stream_id = <extra_stream>
				change guitar_player1_unique_id = <unique_id>
			else
				change guitar_player2_stream_id = <extra_stream>
				change guitar_player2_unique_id = <unique_id>
			endif
			PreloadStream <guitar_stream> buss = Master allow_dsp = true position = <StartTime>
			if (<unique_id> = 0)
				ScriptAssert 'Could not load guitar track for %s' s = <song_prefix>
			endif
			change reverb_unique_id = <unique_id>
			if (($player1_status.part) = rhythm)
				change guitar_player2_stream_id = <guitar_stream>
				change guitar_player2_unique_id = <unique_id>
			else
				change guitar_player1_stream_id = <guitar_stream>
				change guitar_player1_unique_id = <unique_id>
			endif
		endif
	endif
	waitforpreload_song <...>
	change \{song_paused = 1}
	change \{structurename = player1_status
		last_guitar_volume = 100}
	change \{structurename = player2_status
		last_guitar_volume = 100}
	SetLastGuitarVolume \{player = 1
		last_guitar_volume = 100}
	SetLastGuitarVolume \{player = 2
		last_guitar_volume = 100}
	SetSeekPosition_Song position = <StartTime>
	return adjustedtime = <adjustedtime>
endscript

script SongUnLoadFSBIfDownloaded 
	GetContentFolderIndexFromFile ($song_fsb_name)
	if (<device> = content)
		UnLoadFSB \{fsb_index = $song_fsb_id}
		Downloads_CloseContentFolder content_index = <content_index>
		change \{song_fsb_id = -1}
		change \{song_fsb_name = 'none'}
	endif
endscript

script SongUnLoadFSB 
	SongUnLoadFSBIfDownloaded
	end_song
	change \{structurename = player1_status
		guitar_volume = 100}
	change \{structurename = player2_status
		guitar_volume = 100}
endscript

script SongLoadFSB 
	FormatText keep_case TextName = filename '%n.fsb' n = <song_prefix>
	SongUnLoadFSB
	FormatText keep_case TextName = fsbfilename '%n' n = <song_prefix>
	GetContentFolderIndexFromFile <filename>
	if (<device> = content)
		if NOT Downloads_OpenContentFolder content_index = <content_index>
			return \{false}
		endif
	else
		FormatText keep_case TextName = fsbfilename 'music/%n' n = <song_prefix>
	endif
	if NOT LoadFSB filename = <fsbfilename> numstreams = 5 encryptionkey = '5atu6w4zaw' device = <device>
		return \{false}
	endif
	if (<fsb_index> = -1)
		change \{song_fsb_id = -1}
		change \{song_fsb_name = 'none'}
		ScriptAssert 'could not load FSB for: %s' s = <song_prefix>
	else
		change song_fsb_id = <fsb_index>
		change song_fsb_name = <filename>
	endif
	return \{true}
endscript

script waitforpreload_song 
	waitforpreload_stream \{stream = extra_unique_id}
	waitforpreload_stream \{stream = song_unique_id}
	waitforpreload_stream \{stream = crowd_unique_id}
	waitforpreload_stream \{stream = guitar_player1_unique_id}
	waitforpreload_stream \{stream = guitar_player2_unique_id}
endscript

script waitforpreload_stream \{stream = none}
	if NOT ($<stream> = null)
		begin
		if PreLoadStreamDone $<stream>
			break
		endif
		Wait \{1
			gameframe}
		repeat
	endif
endscript

script waitforseek_song 
	Wait \{15
		gameframe}
	return
endscript
slomoSongPause = 0

script setslomo_song 
	if ((<slomo> = 1.0) && ($slomoSongPause = 1))
		UnPausePS2Music
		change \{slomoSongPause = 0}
	endif
	if (<slomo> = 0.0)
		PausePS2Music
		change \{slomoSongPause = 1}
	endif
	if NOT ($song_unique_id = null)
		SetSoundParams unique_id = $song_unique_id pitch = (<slomo> * 100)
	endif
	if NOT ($guitar_player1_unique_id = null)
		SetSoundParams unique_id = $guitar_player1_unique_id pitch = (<slomo> * 100)
	endif
	if NOT ($extra_unique_id = null)
		SetSoundParams unique_id = $extra_unique_id pitch = (<slomo> * 100)
	endif
	if NOT ($crowd_unique_id = null)
		SetSoundParams unique_id = $crowd_unique_id pitch = (<slomo> * 100)
	endif
	if NOT ($guitar_player2_unique_id = null)
		SetSoundParams unique_id = $guitar_player2_unique_id pitch = (<slomo> * 100)
	endif
endscript
Player1Effects = {
	effect = $PitchShiftEffect1
}
Player2Effects = {
	effect = $PitchShiftEffect2
}
PitchShiftEffect1 = {
	effect = PitchShift
	name = Guitar1PitchShift
	pitch = 1.0
	fftsize = 2048
	overlap = 4
	maxchannels = 0
}
PitchShiftEffect2 = {
	effect = PitchShift
	name = Guitar2PitchShift
	pitch = 1.0
	fftsize = 2048
	overlap = 4
	maxchannels = 0
}
Player1PracticeEffects = {
	effect = $PitchShiftSlow1
	effect2 = $PitchShiftEffect1
}
PitchShiftSlow1 = {
	effect = PitchShift
	name = SlowGuitar1PitchShift
	pitch = 1.0
	maxchannels = 2
	fftsize = 2048
}

script startpreloadpaused_song 
	both_players_lead = 0
	if (($player1_status.part) = ($player2_status.part))
		both_players_lead = 1
	endif
	if ($current_num_players = 1)
		if ($game_mode = training && $in_menu_choose_practice_section = 0)
			StartPreloadedStream $guitar_player1_unique_id startpaused = 1 buss = First_Player_Lead_Playback pitch = ($current_speedfactor * 100) $Player1Effects
		else
			StartPreloadedStream $guitar_player1_unique_id startpaused = 1 buss = First_Player_Lead_Playback pitch = ($current_speedfactor * 100) $Player1Effects
		endif
	else
		if (<both_players_lead> = 1)
			StartPreloadedStream $guitar_player1_unique_id startpaused = 1 buss = First_Player_Lead_Playback pitch = ($current_speedfactor * 100) $Player1Effects $Player1Pan volL = 100 volR = 0 dsp_channel = left
			StartPreloadedStream $guitar_player2_unique_id startpaused = 1 buss = Second_Player_Lead_Playback pitch = ($current_speedfactor * 100) $Player2Effects $Player2Pan volL = 0 volR = 100 dsp_channel = right
		else
			StartPreloadedStream $guitar_player1_unique_id startpaused = 1 buss = First_Player_Lead_Playback pitch = ($current_speedfactor * 100) $Player1Effects
			StartPreloadedStream $guitar_player2_unique_id startpaused = 1 buss = Second_Player_Rhythm_Playback pitch = ($current_speedfactor * 100) $Player2Effects
		endif
	endif
	StartPreloadedStream $song_unique_id startpaused = 1 buss = Band_Playback pitch = ($current_speedfactor * 100)
	if NOT ($game_mode = training && $in_menu_choose_practice_section = 0)
		if NOT ($extra_stream_id = null)
			StartPreloadedStream $extra_unique_id startpaused = 1 buss = Single_Player_Rhythm_Playback pitch = ($current_speedfactor * 100)
		endif
		if NOT ($crowd_unique_id = null)
			StartPreloadedStream $crowd_unique_id startpaused = 1 buss = Crowd_Singalong pan1x = -1 pan1y = -0.5 pan2x = 1 pan2y = -0.5 pitch = ($current_speedfactor * 100)
		endif
	endif
endscript

script begin_song \{Pause = 0}
	startpreloadpaused_song
	update_guitar_volume_cfunc
endscript

script SetSeekPosition_Song \{position = 0}
	if NOT ($song_unique_id = null)
		SetSoundSeekPosition unique_id = $song_unique_id position = <position>
	endif
	if NOT ($guitar_player1_unique_id = null)
		if ($game_mode = training && $in_menu_choose_practice_section = 0)
			SetSoundSeekPosition unique_id = $guitar_player1_unique_id position = (<position> - ($default_practice_mode_pitchshift_offset_song))
		else
			SetSoundSeekPosition unique_id = $guitar_player1_unique_id position = <position>
		endif
	endif
	if NOT ($extra_unique_id = null)
		SetSoundSeekPosition unique_id = $extra_unique_id position = <position>
	endif
	if NOT ($crowd_unique_id = null)
		SetSoundSeekPosition unique_id = $crowd_unique_id position = <position>
	endif
	if NOT ($guitar_player2_unique_id = null)
		SetSoundSeekPosition unique_id = $guitar_player2_unique_id position = <position>
	endif
endscript
Waiting_For_Pitching = 0

script Failed_Song_Pitch_Down 
	SoundBussUnlock \{Guitar_Balance}
	SoundBussUnlock \{Band_Balance}
	SetSoundBussParams \{Band_Balance = {
			vol = -20
			pitch = -8
		}
		time = 3}
	SetSoundBussParams \{Guitar_Balance = {
			vol = -20
			pitch = -8
		}
		time = 3}
	change \{Waiting_For_Pitching = 1}
	SoundBussLock \{Band_Balance}
	SoundBussLock \{Guitar_Balance}
	pitch = 1.0
	volume = 100.0
	begin
	pitch = (<pitch> -0.004)
	volume = (<volume> -0.4)
	if NOT ($guitar_player1_unique_id = null)
		SetStreamParams $guitar_player1_unique_id pitch = <pitch>
		SetSoundParams unique_id = $guitar_player1_unique_id vol = <volume>
	endif
	if NOT ($song_unique_id = null)
		SetStreamParams $song_unique_id pitch = <pitch>
		SetSoundParams unique_id = $song_unique_id vol = <volume>
	endif
	Wait \{1
		gameframe}
	repeat 180
	spawnscriptnow \{end_song
		params = {
			song_failed_pitch_streams = 0
		}}
endscript

script end_song \{song_failed_pitch_streams = 0}
	if ((isps2) && $current_speedfactor != 1.0)
		if NOT ($guitar_player1_unique_id = null)
			StopSoundStream \{unique_id = $guitar_player1_unique_id}
		endif
	else
		if NOT (<song_failed_pitch_streams> = 1)
			KillSpawnedScript \{name = Failed_Song_Pitch_Down}
			if ($Waiting_For_Pitching = 1)
				change \{Waiting_For_Pitching = 0}
				SoundBussUnlock \{Guitar_Balance}
				SoundBussUnlock \{Band_Balance}
				SetSoundBussParams {Band_Balance = {vol = (($Default_BussSet.Band_Balance.vol) - 2.5) pitch = ($Default_BussSet.Band_Balance.pitch)}}
				SetSoundBussParams {Guitar_Balance = {vol = (($Default_BussSet.Guitar_Balance.vol) - 2.5) pitch = ($Default_BussSet.Guitar_Balance.pitch)}}
				SoundBussLock \{Band_Balance}
				SoundBussLock \{Guitar_Balance}
			endif
			if NOT ($song_unique_id = null)
				StopStream \{unique_id = $song_unique_id}
				change \{song_unique_id = null}
			endif
			if NOT ($guitar_player1_unique_id = null)
				StopStream \{unique_id = $guitar_player1_unique_id}
				change \{guitar_player1_unique_id = null}
			endif
		else

			spawnscriptnow \{Failed_Song_Pitch_Down}
		endif
	endif
	if NOT ($extra_unique_id = null)
		StopStream \{unique_id = $extra_unique_id}
		change \{extra_unique_id = null}
	endif
	if NOT ($crowd_unique_id = null)
		StopStream \{unique_id = $crowd_unique_id}
		change \{crowd_unique_id = null}
	endif
	if NOT ($guitar_player2_unique_id = null)
		StopStream \{unique_id = $guitar_player2_unique_id}
		change \{guitar_player2_unique_id = null}
	endif
	if NOT (<song_failed_pitch_streams> = 1)
		if NOT ($song_fsb_id = -1)
			UnLoadFSB \{fsb_index = $song_fsb_id}
			change \{song_fsb_id = -1}
			change \{song_fsb_name = 'none'}
		endif
	endif
	change \{song_paused = 0}
endscript
p1_whammy_control = 0.0

script set_whammy_pitchshift 
	if ($<player_status>.player = 1)
		setsoundbusseffects effect = {effect = PitchShift name = Guitar1PitchShift pitch = (1 - (<control> * 0.057))}
		change p1_whammy_control = <control>
	else
		setsoundbusseffects effect = {effect = PitchShift name = Guitar2PitchShift pitch = (1 - (<control> * 0.057))}
	endif
endscript

script PauseGh3Sounds 
	lockdsp
	PauseSoundsByBuss \{Master}
	unlockdsp
endscript

script UnpauseGh3Sounds 
	lockdsp
	if ($slomoSongPause = 1)
		PausePS2Music
	endif
	if ($song_paused = 0)
		UnpauseSoundsByBuss \{Master}
	else
		UnpauseSoundsByBuss \{ui}
		UnpauseSoundsByBuss \{Crowd_One_Shots}
		UnpauseSoundsByBuss \{Crowd_One_Shots_Negative}
		UnpauseSoundsByBuss \{Crowd_Beds}
		UnpauseSoundsByBuss \{Crowd_Cheers}
		UnpauseSoundsByBuss \{Crowd_Boos}
		UnpauseSoundsByBuss \{Crowd_Nuetral}
		UnpauseSoundsByBuss \{`default`}
		UnpauseSoundsByBuss \{Test_Tones}
		UnpauseSoundsByBuss \{Practice_Band_Playback}
		UnpauseSoundsByBuss \{Test_Tones_DSP}
		UnpauseSoundsByBuss \{Right_Notes_Player2}
		UnpauseSoundsByBuss \{Wrong_Notes_Player1}
		UnpauseSoundsByBuss \{Wrong_Notes_Player2}
		UnpauseSoundsByBuss \{User_Vocal}
		UnpauseSoundsByBuss \{User_Music}
		UnpauseSoundsByBuss \{Encore_Events}
		UnpauseSoundsByBuss \{binkcutscenes}
	endif
	unlockdsp
endscript

script PausePS2Music 
	GetPlatform
	if (<platform> = Ps2)
		if ($stream_config = gh1)
			PauseStreamNum \{$song_stream_id
				Pause = 1}
			PauseStreamNum \{$guitar_stream_id
				Pause = 1}
			PauseStreamID \{$song_unique_id
				Pause = 1}
			PauseStreamID \{$guitar_player1_unique_id
				Pause = 1}
		else
			PauseStreamNum \{$band_stream_id
				Pause = 1}
			PauseStreamNum \{$crowd_stream_id
				Pause = 1}
			PauseStreamNum \{$guitar_player1_stream_id
				Pause = 1}
			PauseStreamNum \{$guitar_player2_stream_id
				Pause = 1}
			PauseStreamNum \{$extra_stream_id
				Pause = 1}
			PauseStreamID \{$song_unique_id
				Pause = 1}
			PauseStreamID \{$band_unique_id
				Pause = 1}
			PauseStreamID \{$crowd_unique_id
				Pause = 1}
			PauseStreamID \{$extra_unique_id
				Pause = 1}
			PauseStreamID \{$guitar_player2_unique_id
				Pause = 1}
			PauseStreamID \{$guitar_player1_unique_id
				Pause = 1}
		endif
	endif
endscript

script UnPausePS2Music 
	GetPlatform
	if (<platform> = Ps2)
		if ($stream_config = gh1)
			PauseStreamNum \{$song_stream_id
				Pause = 0}
			PauseStreamNum \{$guitar_stream_id
				Pause = 0}
			PauseStreamID \{$song_unique_id
				Pause = 0}
			PauseStreamID \{$guitar_player1_unique_id
				Pause = 0}
		else
			PauseStreamNum \{$band_stream_id
				Pause = 0}
			PauseStreamNum \{$crowd_stream_id
				Pause = 0}
			PauseStreamNum \{$guitar_player1_stream_id
				Pause = 0}
			PauseStreamNum \{$guitar_player2_stream_id
				Pause = 0}
			PauseStreamNum \{$extra_stream_id
				Pause = 0}
			PauseStreamID \{$song_unique_id
				Pause = 0}
			PauseStreamID \{$band_unique_id
				Pause = 0}
			PauseStreamID \{$crowd_unique_id
				Pause = 0}
			PauseStreamID \{$extra_unique_id
				Pause = 0}
			PauseStreamID \{$guitar_player2_unique_id
				Pause = 0}
			PauseStreamID \{$guitar_player1_unique_id
				Pause = 0}
		endif
	endif
endscript
