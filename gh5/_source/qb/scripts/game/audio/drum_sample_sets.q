drum_sample_test = 0
drum_input_current_cymbal = null
drum_input_current_hihat = null
drum_input_current_kick = null
drum_input_current_snare = null
drum_input_current_tom = null
drum_pads = [
	{
		id = snare
		string_id = 'snare'
		name_text = qs("Snare")
	}
	{
		id = kick
		string_id = 'kick'
		name_text = qs("Kick")
	}
	{
		id = tom1
		string_id = 'tom1'
		name_text = qs("Tom1")
	}
	{
		id = tom2
		string_id = 'tom2'
		name_text = qs("Tom2")
	}
	{
		id = hihat
		string_id = 'hihat'
		name_text = qs("Hi-Hat")
	}
	{
		id = cymbal
		string_id = 'cymbal'
		name_text = qs("cymbal")
	}
]
drum_kits = [
	{
		id = heavyrock
		string_id = 'heavyrock'
		name_text = qs("\LHeavy Rock")
		percussion_id = rockpercussion
		percussion_string_id = 'heavyrock'
	}
]

script play_drum_sample 
	if ($game_mode = practice)
		if NOT ($current_speedfactor = 1.0)
			if NOT PlayerInfoEquals \{1
					part = drum}
				if ($current_time * 1000 < $current_starttime)
					return
				endif
			endif
		endif
	endif
	PlayDrumSample_CFunc <...>
	return drum_sample = <drum_sample>
endscript

script play_drum_sample_unoptimized \{drum_set = heavyrock
		pad = snare
		velocity = 127
		second_pedal_position = 127
		buss = Drums_InGame
		scale_volume = 5
		loop_pitch = 0
		pan_left = -1.0
		pan_right = 1.0
		pan_mono = 0.0}
	drum_set = heavyrock
	slot = 7
	if ((<buss> = Drums_InGame) || (<buss> = Drums_InGame_Kick) || (<buss> = Drums_InGame_Toms) || (<buss> = Drums_InGame_Hats) || (<buss> = Drums_InGame_Cymbals) || (<buss> = Drums_InGame_Snare))
		slot = 2
	endif
	if (<buss> = PracticeMode_Drums)
		return
	endif
	CastToInteger \{velocity}
	if (<velocity> < 0)
		<velocity> = 0
	endif
	if (<velocity> > 127)
		<velocity> = 127
	endif
	if IsTrue \{$DebugSoundFX}



	endif
	if (<velocity> < 0 || <velocity> > 127)

		return
	endif
	if NOT GotParam \{drum_checksum}
		if NOT GotParam \{drum_kit_string}
			GetArraySize \{$drum_kits}
			index = ($jam_current_drum_kit)
			drum_kit_string = ''
			<drum_kit_string> = ($drum_kits [<index>].string_id)
		endif
		if (<drum_kit_string> = '')

			return
		endif
		GetArraySize \{$drum_pads}
		index = 0
		pad_string = ''
		begin
		if (($drum_pads [<index>].id) = <pad>)
			<pad_string> = ($drum_pads [<index>].string_id)
		endif
		<index> = (<index> + 1)
		repeat <array_size>
		if (<pad_string> = '')

			return
		endif
		FormatText checksumname = drum_sampleset_array '%a_%b_sampleset' a = <drum_kit_string> b = <pad_string>
	else
		drum_sampleset_array = <drum_checksum>
	endif
	GetArraySize ($<drum_sampleset_array>)
	if NOT GlobalExists name = <drum_sampleset_array> type = array

		return
	endif
	index = 0
	velocity_cutoff_low = 0.0
	velocity_cutoff_high = 0.0
	begin
	if (($<drum_sampleset_array> [<index>].velocity_cutoff) > <velocity>)
		<velocity_cutoff_high> = (1.0 * ($<drum_sampleset_array> [<index>].velocity_cutoff))
		break
	endif
	<velocity_cutoff_low> = (1.0 * ($<drum_sampleset_array> [<index>].velocity_cutoff))
	<velocity_index> = <index>
	<index> = (<index> + 1)
	if (<index> >= <array_size>)
		<velocity_cutoff_high> = 127.0
		break
	endif
	repeat
	adjusted_volume = 0.0
	adjusted_pitch = 0.0
	volume_low = ($<drum_sampleset_array> [<velocity_index>].volume_low)
	volume_high = ($<drum_sampleset_array> [<velocity_index>].volume_high)
	pitch_low = ($<drum_sampleset_array> [<velocity_index>].pitch_low)
	pitch_high = ($<drum_sampleset_array> [<velocity_index>].pitch_high)
	<adjusted_volume> = (((<volume_high> - <volume_low>) * ((<velocity> - <velocity_cutoff_low>) / (<velocity_cutoff_high> - <velocity_cutoff_low>))) + <volume_low>)
	<adjusted_pitch> = (((<pitch_high> - <pitch_low>) * ((<velocity> - <velocity_cutoff_low>) / (<velocity_cutoff_high> - <velocity_cutoff_low>))) + <pitch_low>)
	GetArraySize ($<drum_sampleset_array> [<velocity_index>].sample_array)
	GetRandomValue name = random_sample_index Integer a = 0 b = (<array_size> -1)
	random_sample = ($<drum_sampleset_array> [<velocity_index>].sample_array [<random_sample_index>])
	if ($drum_sample_test = 1)
		<random_sample> = Drum_Snare5
	endif
	if IsTrue \{$DebugSoundFX}
		<print_struct> = 1
	endif
	if ($jam_reverb = 1)
		if StructureContains Structure = ($<drum_sampleset_array> [<velocity_index>]) pan_left
			pan_left = ($<drum_sampleset_array> [<velocity_index>].pan_left)
			pan_right = ($<drum_sampleset_array> [<velocity_index>].pan_right)
			PlaySound print_struct = <print_struct> <random_sample> vol = (<adjusted_volume> + <scale_volume>) pitch = (<adjusted_pitch> + <loop_pitch>) pan1x = <pan_left> pan1y = 1.0 pan2x = <pan_right> pan2y = 1.0 buss = <buss> send_vol2 = -9 slot = <slot>
		elseif StructureContains Structure = ($<drum_sampleset_array> [<velocity_index>]) pan_mono
			pan_mono = ($<drum_sampleset_array> [<velocity_index>].pan_mono)
			PlaySound print_struct = <print_struct> <random_sample> vol = (<adjusted_volume> + <scale_volume>) pitch = (<adjusted_pitch> + <loop_pitch>) pan1x = <pan_mono> pan1y = 1.0 buss = <buss> send_vol2 = -9 slot = <slot>
		else
			PlaySound print_struct = <print_struct> <random_sample> vol = (<adjusted_volume> + <scale_volume>) pitch = (<adjusted_pitch> + <loop_pitch>) buss = <buss> send_vol2 = -9 slot = <slot>
		endif
	else
		if StructureContains Structure = ($<drum_sampleset_array> [<velocity_index>]) pan_left
			pan_left = ($<drum_sampleset_array> [<velocity_index>].pan_left)
			pan_right = ($<drum_sampleset_array> [<velocity_index>].pan_right)
			PlaySound print_struct = <print_struct> <random_sample> vol = (<adjusted_volume> + <scale_volume>) pitch = (<adjusted_pitch> + <loop_pitch>) pan1x = <pan_left> pan1y = 1.0 pan2x = <pan_right> pan2y = 1.0 buss = <buss> slot = <slot>
		elseif StructureContains Structure = ($<drum_sampleset_array> [<velocity_index>]) pan_mono
			pan_mono = ($<drum_sampleset_array> [<velocity_index>].pan_mono)
			PlaySound print_struct = <print_struct> <random_sample> vol = (<adjusted_volume> + <scale_volume>) pitch = (<adjusted_pitch> + <loop_pitch>) pan1x = <pan_mono> pan1y = 1.0 buss = <buss> slot = <slot>
		else
			PlaySound print_struct = <print_struct> <random_sample> vol = (<adjusted_volume> + <scale_volume>) pitch = (<adjusted_pitch> + <loop_pitch>) buss = <buss> slot = <slot>
		endif
	endif
	if IsTrue \{$DebugSoundFX}



	endif
	return drum_sample = <drum_sampleset_array>
endscript
LoadedDrumKitPaks_cymbal = 'none'
LoadedDrumKitPaks_floortom = 'none'
LoadedDrumKitPaks_hihat = 'none'
LoadedDrumKitPaks_hitom = 'none'
LoadedDrumKitPaks_kick = 'none'
LoadedDrumKitPaks_snare = 'none'
LoadedDrumKitPaks_cymbal_percussion = 'none'
LoadedDrumKitPaks_floortom_percussion = 'none'
LoadedDrumKitPaks_hihat_percussion = 'none'
LoadedDrumKitPaks_hitom_percussion = 'none'
LoadedDrumKitPaks_kick_percussion = 'none'
LoadedDrumKitPaks_snare_percussion = 'none'
DrumKitParts = {
	cymbal = 'cymbal'
	floortom = 'floortom'
	hihat = 'hihat'
	hitom = 'hitom'
	kick = 'kick'
	cymbal = 'cymbal'
	snare = 'snare'
}
last_drum_kit_loaded = 'none'

script LoadDrumKitAll \{drum_kit = 'heavyrock'
		async = 1
		reset_percussion = 1
		heap = heap_bottom_up}
	if (<reset_percussion> = 1)
		change \{is_percussion_kit = 0}
	endif
	return
	if (<drum_kit> = $last_drum_kit_loaded)
		if GotParam \{percussion_kit}
			if (<percussion_kit> = $last_percussion_kit_loaded)

				return
			endif
		else

			return
		endif
	endif
	UnLoadDrumKitAll
	if NOT GotParam \{heap}
		<heap> = heap_bottom_up
	endif
	LoadDrumKit type = cymbal drum_kit = <drum_kit> async = <async> heap = <heap>
	LoadDrumKit type = floortom drum_kit = <drum_kit> async = <async> heap = <heap>
	LoadDrumKit type = hihat drum_kit = <drum_kit> async = <async> heap = <heap>
	LoadDrumKit type = hitom drum_kit = <drum_kit> async = <async> heap = <heap>
	LoadDrumKit type = kick drum_kit = <drum_kit> async = <async> heap = <heap>
	LoadDrumKit type = snare drum_kit = <drum_kit> async = <async> heap = <heap>
	change last_drum_kit_loaded = <drum_kit>
	change last_drum_kit_set = <drum_kit>
	if GotParam \{percussion_kit}
		LoadDrumKit type = cymbal drum_kit = <percussion_kit> async = <async> percussion heap = <heap>
		LoadDrumKit type = floortom drum_kit = <percussion_kit> async = <async> percussion heap = <heap>
		LoadDrumKit type = hihat drum_kit = <percussion_kit> async = <async> percussion heap = <heap>
		LoadDrumKit type = hitom drum_kit = <percussion_kit> async = <async> percussion heap = <heap>
		LoadDrumKit type = kick drum_kit = <percussion_kit> async = <async> percussion heap = <heap>
		LoadDrumKit type = snare drum_kit = <percussion_kit> async = <async> percussion heap = <heap>
		change last_percussion_kit_loaded = <percussion_kit>
		change last_percussion_kit_set = <percussion_kit>
	endif
endscript

script LoadDrumKit \{type = snare
		drum_kit = 'heavyrock'
		async = 1
		heap = heap_bottom_up}
	return
endscript

script UnLoadDrumKitAll 
	return
endscript

script UnLoadDrumKit \{type = snare}
	return
endscript
