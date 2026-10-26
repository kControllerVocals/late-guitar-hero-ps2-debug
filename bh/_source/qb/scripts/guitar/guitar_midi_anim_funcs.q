
script Transition_PlaySimpleAnim 
	Band_PlaysimpleAnim <...>
	BandManager_SetPlayingIntroAnims name = <name>
endscript

script play_facial_anim_on_character \{name = Guitarist}
	if CompositeObjectExists name = <name>
		<name> :Obj_KillSpawnedScript name = play_special_facial_anim
		<name> :Obj_SpawnScriptNow play_special_facial_anim params = {Anim = <Anim>}
	endif
endscript

script Band_PlayFacialAnim \{name = Guitarist}
	GameMode_GetType
	switch <type>
		case training
		case practice
		case tutorial
		return \{false}
	endswitch
	if GotParam \{name}
		get_musician_id name = <name>
		play_facial_anim_on_character name = <name> Anim = <Anim>
		if (<name> = vocalist)
			play_facial_anim_on_character name = vocalist2 Anim = <Anim>
		endif
	elseif GotParam \{part}
		if ($guitarist_info.part = <part>)
			play_facial_anim_on_character name = Guitarist Anim = <Anim>
		endif
		if ($bassist_info.part = <part>)
			play_facial_anim_on_character name = bassist Anim = <Anim>
		endif
		if ($vocalist_info.part = <part>)
			play_facial_anim_on_character name = vocalist Anim = <Anim>
		endif
		if ($drummer_info.part = <part>)
			play_facial_anim_on_character name = Drummer Anim = <Anim>
		endif
	endif
endscript

script Band_PlayRockinFacialAnim \{name = Guitarist}
	get_musician_id name = <name>
	if CompositeObjectExists name = <name>
		<name> :Obj_KillSpawnedScript name = play_special_facial_anim
		if Band_IsFemale name = <name>

			<name> :Obj_SpawnScriptNow play_special_facial_anim params = {Anim = gh_rocker_female_hardrockface_4}
		else

			<name> :Obj_SpawnScriptNow play_special_facial_anim params = {Anim = gh_rocker_male_hardrockface_4}
		endif
	endif
endscript

script Band_ChangeFacialAnims \{name = Guitarist
		blend_duration = 0.3}
	get_musician_id name = <name>

	if CompositeObjectExists name = <name>

		ExtendCRC <name> '_Info' out = info_struct
		if ((GotParam ff_anims) || (GotParam Mf_anims))
			if Band_IsFemale name = <name>
				if GotParam \{ff_anims}

					change structurename = <info_struct> facial_anims = <ff_anims>
				endif
			else
				if GotParam \{Mf_anims}

					change structurename = <info_struct> facial_anims = <Mf_anims>
				endif
			endif
		else
			fa_default = ($<info_struct>.facial_anims_default)
			if GotParam \{fa_type}
				ExtendCRC <fa_default> <fa_type> out = fa_anims

			else
				fa_anims = <fa_default>
			endif
			change structurename = <info_struct> facial_anims = <fa_anims>
		endif
		<name> :Obj_KillSpawnedScript name = play_special_facial_anim
		<name> :Obj_KillSpawnedScript name = facial_anim_loop
		<name> :Obj_SpawnScriptNow facial_anim_loop params = {blend_duration = <blend_duration>}
	else

	endif
endscript

script AE_ChangeFacialAnims \{blend_duration = 0.3}
	Obj_GetID
	if NOT ((GotParam ff_anims) || (GotParam Mf_anims) || (GotParam fa_type))

	endif
	Band_ChangeFacialAnims name = <ObjID> blend_duration = <blend_duration> <...>
endscript

script Band_StopStrumming \{name = Guitarist}
	Band_SetStrumStyle name = <name> male_type = none female_type = none
endscript

script Band_EnableAutoStrums 
	Band_EnableAutoStrums_CFunc name = <name>
endscript

script Band_DisableAutoStrums 
	Band_DisableAutoStrums_CFunc name = <name>
endscript

script Band_EnableAutoFret 
	Band_EnableAutoFret_CFunc name = <name>
endscript

script Band_DisableAutoFret 
	Band_DisableAutoFret_CFunc name = <name>
endscript

script Band_EnableAutoChords 
	Band_EnableAutoChords_CFunc name = <name>
endscript

script Band_DisableAutoChords 
	Band_DisableAutoChords_CFunc name = <name>
endscript

script Band_SetIKChain 
	if (<chain> = guitar)
		Band_SetIKChainTarget name = <name> index = 0 target = Bone_IK_Hand_Guitar_R
		Band_SetIKChainTarget name = <name> index = 1 target = Bone_IK_Hand_Guitar_L
		Band_EnableAutoFret name = <name>
		Band_EnableAutoChords name = <name>
		Band_EnableAutoStrums name = <name>
		Bandmanager_setIKchainStrength name = <name> chain = Bone_IK_Hand_Guitar_L strength = 1
		Bandmanager_setIKchainStrength name = <name> chain = Bone_IK_Hand_Guitar_R strength = 1
	elseif (<chain> = slave)
		Band_SetIKChainTarget name = <name> index = 0 target = Bone_IK_Hand_Slave_R
		Band_SetIKChainTarget name = <name> index = 1 target = Bone_IK_Hand_Slave_L
		Band_DisableAutoFret name = <name>
		Band_DisableAutoChords name = <name>
		Band_DisableAutoStrums name = <name>
		Bandmanager_setIKchainStrength name = <name> chain = Bone_IK_Hand_Slave_L strength = 1
		Bandmanager_setIKchainStrength name = <name> chain = Bone_IK_Hand_Slave_R strength = 1
	elseif (<chain> = fk)
		Bandmanager_setIKchainStrength name = <name> chain = Bone_IK_Hand_Guitar_L strength = 0
		Bandmanager_setIKchainStrength name = <name> chain = Bone_IK_Hand_Guitar_R strength = 0
		Bandmanager_setIKchainStrength name = <name> chain = Bone_IK_Hand_Slave_L strength = 0
		Bandmanager_setIKchainStrength name = <name> chain = Bone_IK_Hand_Slave_R strength = 0
	else
		Band_SetIKChainTarget name = <name> index = 0 target = Bone_IK_Hand_Slave_R
		Band_SetIKChainTarget name = <name> index = 1 target = Bone_IK_Hand_Slave_L
		Band_DisableAutoFret name = <name>
		Band_DisableAutoChords name = <name>
		Band_DisableAutoStrums name = <name>
	endif
endscript

script AE_SetIK_GuitarL_Off 
	Obj_GetID
	Band_DisableAutoChords name = <ObjID>
endscript

script AE_SetIK_GuitarR_Off 
	Obj_GetID
	Band_DisableAutoStrums name = <ObjID>
endscript

script AE_SetIK_SlaveL_Off 
endscript

script AE_SetIK_SlaveR_Off 
endscript

script AE_SetIK_GuitarL_On 
	Obj_GetID
	Band_SetIKChainTarget name = <ObjID> index = 1 target = Bone_IK_Hand_Guitar_L BlendDuration = 0.3
	Band_EnableAutoChords name = <ObjID>
endscript

script AE_SetIK_GuitarR_On 
	Obj_GetID
	Band_SetIKChainTarget name = <ObjID> index = 0 target = Bone_IK_Hand_Guitar_R BlendDuration = 0.3
	Band_EnableAutoStrums name = <ObjID>
endscript

script AE_SetIK_SlaveL_On 
	Obj_GetID
	Band_SetIKChainTarget name = <ObjID> index = 1 target = Bone_IK_Hand_Slave_L BlendDuration = 0.3
	Band_DisableAutoChords name = <ObjID>
endscript

script AE_SetIK_SlaveR_On 
	Obj_GetID
	Band_SetIKChainTarget name = <ObjID> index = 0 target = Bone_IK_Hand_Slave_R BlendDuration = 0.3
	Band_DisableAutoStrums name = <ObjID>
endscript

script AE_SetIK_GuitarL_On_STRANGLEHOLD 
	Obj_GetID
	Band_SetIKChainTarget name = <ObjID> index = 1 target = Bone_IK_Hand_Guitar_L BlendDuration = 0.3
endscript

script AE_SetIK_GuitarR_On_STRANGLEHOLD 
	Obj_GetID
	Band_SetIKChainTarget name = <ObjID> index = 0 target = Bone_IK_Hand_Guitar_R BlendDuration = 0.3
endscript

script AE_SetIK_SlaveL_On_STRANGLEHOLD 
	Obj_GetID
	Band_SetIKChainTarget name = <ObjID> index = 1 target = Bone_IK_Hand_Slave_L BlendDuration = 0.3
endscript

script AE_SetIK_SlaveR_On_STRANGLEHOLD 
	Obj_GetID
	Band_SetIKChainTarget name = <ObjID> index = 0 target = Bone_IK_Hand_Slave_R BlendDuration = 0.3
endscript

script AE_SetIK_Slaves_On_Jimi 
	if ($game_mode = p2_pro_faceoff)
		Obj_GetID
		Band_SetIKChainTarget name = <ObjID> index = 0 target = Bone_IK_Hand_Slave_R BlendDuration = 0
		Band_SetIKChainTarget name = <ObjID> index = 1 target = Bone_IK_Hand_Slave_L BlendDuration = 0
	endif
endscript

script AE_SetIK_to_FK_L 
	Obj_GetID
	Bandmanager_setIKchainStrength name = <ObjID> chain = Bone_IK_Hand_Guitar_L strength = 0
	Bandmanager_setIKchainStrength name = <ObjID> chain = Bone_IK_Hand_Slave_L strength = 0
endscript

script AE_SetIK_to_FK_R 
	Obj_GetID
	Bandmanager_setIKchainStrength name = <ObjID> chain = Bone_IK_Hand_Guitar_R strength = 0
	Bandmanager_setIKchainStrength name = <ObjID> chain = Bone_IK_Hand_Slave_R strength = 0
endscript

script AE_SetIK_to_IK_L 
	Obj_GetID
	Bandmanager_setIKchainStrength name = <ObjID> chain = Bone_IK_Hand_Guitar_L strength = 1
	Bandmanager_setIKchainStrength name = <ObjID> chain = Bone_IK_Hand_Slave_L strength = 1
endscript

script AE_SetIK_to_IK_R 
	Obj_GetID
	Bandmanager_setIKchainStrength name = <ObjID> chain = Bone_IK_Hand_Guitar_R strength = 1
	Bandmanager_setIKchainStrength name = <ObjID> chain = Bone_IK_Hand_Slave_R strength = 1
endscript

script AE_DisableAutoFret 
	Obj_GetID
	Band_DisableAutoFret name = <ObjID>
endscript

script AE_EnableAutofret 
	Obj_GetID
	Band_EnableAutoFret name = <ObjID>
endscript

script AE_DisableAutoStrums 
	Obj_GetID
	Band_DisableAutoStrums name = <ObjID>
endscript

script AE_EnableAutoStrums 
	Obj_GetID
	Band_EnableAutoStrums name = <ObjID>
endscript

script AE_DisableAutoChords 
	Obj_GetID
	Band_DisableAutoChords name = <ObjID>
endscript

script AE_EnableAutoChords 
	Obj_GetID
	Band_EnableAutoChords name = <ObjID>
endscript

script IK_FK_Switch_Override 
	GMan_SongTool_GetCurrentSong
	if (<current_song> = BandOnTheRun)
		return
	endif
	AE_SetIK_SlaveR_On
endscript

script Band_SetIKChainTarget \{BlendDuration = 0.0}
	Band_SetIKChainTarget_CFunc name = <name> target = <target> index = <index> BlendDuration = <BlendDuration>
endscript

script Band_MoveToNode \{allow_in_2player = false}
	Band_MoveToNode_CFunc allow_in_2player = <allow_in_2player> name = <name> node = <node>
endscript

script Band_MoveToStartNode \{allow_in_2player = false}
	Band_MoveToStartNode_CFunc name = <name> allow_in_2player = <allow_in_2player>
endscript

script Band_RestartIdles 
	BandManager_PlayIdle \{name = Guitarist
		all_modes = true
		restart}
	BandManager_PlayIdle \{name = bassist
		all_modes = true
		restart}
	BandManager_PlayIdle \{name = vocalist
		all_modes = true
		restart}
	BandManager_PlayIdle \{name = Drummer
		all_modes = true
		restart}
endscript

script Band_PlayTransitionIdles \{from_restart = false}

	GMan_SongTool_GetCurrentSong
	band_builder_get_band_global song = <current_song>
	Wait \{2
		gameframes}
	BandManager_TurnOffAllArmAnims
	Wait \{1
		gameframes}
	BandManager_SetPlayingIntroAnims
endscript

script BandManager_TurnOffArmAnims 
	Band_DisableAutoStrums name = <name>
	Band_DisableAutoFret name = <name>
	Band_DisableAutoChords name = <name>
endscript

script BandManager_TurnOffAllArmAnims 
	BandManager_TurnOffArmAnims \{name = Guitarist}
	BandManager_TurnOffArmAnims \{name = guitarist2}
	BandManager_TurnOffArmAnims \{name = bassist}
	BandManager_TurnOffArmAnims \{name = bassist2}
	BandManager_TurnOffArmAnims \{name = vocalist}
	BandManager_TurnOffArmAnims \{name = vocalist2}
	Band_SetDrumKitState \{name = Drummer
		state = off}
	Band_SetDrumKitState \{name = drummer2
		state = off}
endscript

script BandManager_TurnOnArmAnims 
	Band_EnableAutoStrums name = <name>
	Band_EnableAutoFret name = <name>
	Band_EnableAutoChords name = <name>
endscript

script BandManager_TurnOnAllArmAnims 
	BandManager_TurnOnArmAnims \{name = Guitarist}
	BandManager_TurnOnArmAnims \{name = guitarist2}
	BandManager_TurnOnArmAnims \{name = bassist}
	BandManager_TurnOnArmAnims \{name = bassist2}
	BandManager_TurnOnArmAnims \{name = vocalist}
	BandManager_TurnOnArmAnims \{name = vocalist2}
	Band_SetDrumKitState \{name = Drummer
		state = on}
	Band_SetDrumKitState \{name = drummer2
		state = on}
endscript

script Band_SetArmAnimStrength 
	Band_SetArmAnimStrength_CFunc name = <name> target = <target> strength = <strength>
endscript

script Band_SetDrumKitState 
	if ($test_four_guitarists = true || $test_four_vocalists = true)
		return
	endif
	if CompositeObjectExists name = <name>
		if (<state> = on)
		else
		endif
	endif
endscript

script band_playidle 
	BandManager_PlayIdle <...>
endscript

script Band_PlayLoop 
	override_anim = none
	if Band_IsFemale name = <name>
		if GotParam \{Female}
			override_anim = <Female>
		endif
	else
		if GotParam \{Male}
			override_anim = <Male>
		endif
	endif
	GetPlayerInfo \{1
		current_song_beat_time}
	if NOT (<current_song_beat_time> = 0)
		new_tempo = ((1000.0 / <current_song_beat_time>) * 60.0)
		change tempo_for_anims = <new_tempo>
	else

	endif
	BandManager_SetOverrideLoop name = <name> Anim = <override_anim>
	BandManager_RestartLoop name = <name>
endscript

script band_playclip \{startFrame = 0.0
		override_intro = true}
	if NOT GotParam \{AllGameModes}
		if ($game_mode = p2_pro_faceoff)
			return
		endif
	endif
	if NOT should_play_moments
		return
	endif
	if NOT GlobalExists name = <clip> type = Structure

		return
	endif
	clip_get_time_and_frame
	GetSongTimeMs
	CastToInteger \{time}
	if StructureContains Structure = $<clip> dataformat
		Band_PlayClip_New_CFunc
		newclipformat = true
	else
		Band_PlayClip_CFunc
		newclipformat = false
	endif
	increase_band_bounding_spheres
	if (<newclipformat> = true)
		Band_PlayClip_Finish_New_CFunc
	else
		Band_PlayClip_Finish_CFunc
	endif

endscript

script Band_Alternate_PlayClip \{startFrame = 0.0
		override_intro = true}
	if NOT GotParam \{AllGameModes}
		if ($game_mode = p2_pro_faceoff)
			return
		endif
	endif
	if NOT should_play_moments
		return
	endif
	clip_get_time_and_frame
	GetSongTimeMs \{time_offset = $time_gem_offset_with_lag}
	CastToInteger \{time}
	if StructureContains Structure = $<clip> dataformat
		Band_PlayClip_New_CFunc
		newclipformat = true
	else
		Band_PlayClip_CFunc
		newclipformat = false
	endif
	increase_band_bounding_spheres
endscript

script increase_band_bounding_spheres 
	if CompositeObjectExists \{name = Drummer}
		Drummer :Obj_SetBoundingSphere \{10}
	endif
	if CompositeObjectExists \{name = vocalist}
		vocalist :Obj_SetBoundingSphere \{10}
	endif
	return
	if CompositeObjectExists \{name = musician1}
		musician1 :Obj_SetBoundingSphere \{10}
	endif
	if CompositeObjectExists \{name = musician2}
		musician2 :Obj_SetBoundingSphere \{10}
	endif
	if CompositeObjectExists \{name = musician3}
		musician3 :Obj_SetBoundingSphere \{10}
	endif
	if CompositeObjectExists \{name = musician4}
		musician4 :Obj_SetBoundingSphere \{10}
	endif
endscript

script Band_ForceToIdle \{all_modes = false}
	if GotParam \{name}
		if CompositeObjectExists name = <name>
			BandManager_ChangeIK name = <name> enabled = true
			BandManager_PlayIdle name = <name> BlendDuration = 0.0 all_modes = <all_modes>
		endif
	endif
endscript

script Band_ForceAllToIdle \{all_modes = false}
	Band_ForceToIdle name = Guitarist all_modes = <all_modes> <...>
	Band_ForceToIdle name = bassist all_modes = <all_modes> <...>
	Band_ForceToIdle name = vocalist all_modes = <all_modes> <...>
	Band_ForceToIdle name = Drummer all_modes = <all_modes> <...>
endscript

script Band_MoveAllToStartNodes 
	Band_MoveToStartNode \{name = Guitarist}
	Band_MoveToStartNode \{name = bassist}
	Band_MoveToStartNode \{name = vocalist}
	Band_MoveToStartNode \{name = Drummer}
endscript
tempo_for_anims = -1
tempo_for_drum_anims = -1

script Band_SetAnimTempo 
	change tempo_for_anims = <tempo>
	if ($tempo_for_drum_anims = -1)
		change tempo_for_drum_anims = <tempo>
	endif
endscript

script Band_SetDrumAnimTempo 
	change tempo_for_drum_anims = <tempo>
endscript

script Band_ClearAnimTempo 
	change \{tempo_for_anims = -1}
	change \{tempo_for_drum_anims = -1}
endscript

script Band_IsFemale 
	if NOT GotParam \{name}

		return
	endif
	if NOT CompositeObjectExists name = <name>

		return
	endif
	<name> :GetSingleTag is_female
	if (<is_female> = 1)
		return \{true}
	else
		return \{false}
	endif
endscript

script clip_get_time_and_frame 
	GetSongTimeMs \{time_offset = $time_gem_offset_with_lag}
	seconds = (<time> / 1000.0)
	if (<seconds> < 0)
		seconds = 0
	endif
	minutes = (<seconds> / 60.0)
	CastToInteger \{minutes}
	seconds = (<seconds> - (<minutes> * 60))
	seconds_float = <seconds>
	CastToInteger \{seconds}
	fps = 30
	fraction_of_second = (<seconds_float> - <seconds>)
	frame = (<fraction_of_second> * <fps>)
	CastToInteger \{frame}
	if (<seconds> < 10)
		if (<frame> < 10)
			FormatText TextName = time_string qs("\L%a:0%b:0%c ") a = <minutes> b = <seconds> c = <frame> d = <time>
		else
			FormatText TextName = time_string qs("\L%a:0%b:%c ") a = <minutes> b = <seconds> c = <frame> d = <time>
		endif
	else
		if (<frame> < 10)
			FormatText TextName = time_string qs("\L%a:%b:0%c ") a = <minutes> b = <seconds> c = <frame> d = <time>
		else
			FormatText TextName = time_string qs("\L%a:%b:%c ") a = <minutes> b = <seconds> c = <frame> d = <time>
		endif
	endif
	FormatText TextName = time_string qs("\L[%d]%a:%b:%c ") a = <minutes> b = <seconds> c = <frame> d = <time>
	return time_string = <time_string>
endscript

script Band_ShowMic \{name = Guitarist}
	if NOT should_play_moments
		return
	endif
	if ($game_mode = p2_pro_faceoff)
		return
	endif
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if ($Cheat_AirInstruments != 1)
		<name> :show_mic
	endif
endscript

script Band_HideMic \{name = Guitarist}
	if NOT should_play_moments
		return
	endif
	get_musician_id name = <name>
	if NOT CompositeObjectExists name = <name>
		return
	endif
	<name> :hide_mic
endscript

script Band_ShowMic_Stand \{name = Guitarist}
	if NOT should_play_moments
		return
	endif
	if ($game_mode = p2_pro_faceoff)
		return
	endif
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if ($Cheat_AirInstruments != 1)
		<name> :show_mic_stand
	endif
endscript

script Band_HideMic_stand \{name = Guitarist}
	if NOT should_play_moments
		return
	endif
	if NOT CompositeObjectExists name = <name>
		return
	endif
	<name> :hide_mic_stand
endscript

script Band_ShowMic_microphone \{name = Guitarist}
	if NOT should_play_moments
		return
	endif
	if ($game_mode = p2_pro_faceoff)
		return
	endif
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if ($Cheat_AirInstruments != 1)
		<name> :show_mic_microphone
	endif
endscript

script Band_HideMic_microphone \{name = Guitarist}
	if NOT should_play_moments
		return
	endif
	if NOT CompositeObjectExists name = <name>
		return
	endif
	<name> :hide_mic_microphone
endscript

script Band_ShowDrumkit \{name = Drummer}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	if ($Cheat_AirInstruments != 1)
		<name> :show_Drumkit
	endif
endscript

script Band_HideDrumkit \{name = Drummer}
	if NOT CompositeObjectExists name = <name>
		return
	endif
	<name> :hide_Drumkit
endscript

script Band_Hide 
	if CompositeObjectExists name = <name>
		<name> :hide
	endif
	BandManager_HideStrings name = <name>
endscript

script Band_UnHide 
	if CompositeObjectExists name = <name>
		if ($Cheat_InvisibleCharacters != 1)
			<name> :unhide
		endif
	endif
	if ($Cheat_AirInstruments != 1)
		BandManager_ShowStrings name = <name>
	endif
endscript
enable_guitarist_camera_swapping = false

script Band_EnableGuitaristCameraSwapping 
	change \{enable_guitarist_camera_swapping = true}
endscript

script Band_DisableGuitaristCameraSwapping 
	change \{enable_guitarist_camera_swapping = false}
endscript

script Transition_ChangeIK 
	BandManager_ChangeIK <...>
endscript

script BandManager_StopFacialAnims 
	<name> :Obj_KillSpawnedScript name = play_special_facial_anim
	<name> :Obj_KillSpawnedScript name = facial_anim_loop
	<name> :hero_clear_facial_anim
endscript

script BandManager_StartFacialAnims 
	if NOT CompositeObjectExists name = <name>
		return
	endif
	<name> :Obj_KillSpawnedScript name = play_special_facial_anim
	<name> :Obj_KillSpawnedScript name = facial_anim_loop
	<name> :Obj_SpawnScriptNow facial_anim_loop
endscript

script BandManager_StartAllFacialAnims 
	BandManager_StartFacialAnims \{name = Guitarist}
	BandManager_StartFacialAnims \{name = guitarist2}
	BandManager_StartFacialAnims \{name = bassist}
	BandManager_StartFacialAnims \{name = bassist2}
	BandManager_StartFacialAnims \{name = vocalist}
	BandManager_StartFacialAnims \{name = vocalist2}
	BandManager_StartFacialAnims \{name = Drummer}
	BandManager_StartFacialAnims \{name = drummer2}
endscript

script BandManager_AirGuitarCheat 
	if ($Cheat_AirInstruments = 1)
		BandManager_HideAllInstruments
	else
		BandManager_UnHideAllInstruments
	endif
endscript

script BandManager_InvisibleCharactersCheat 
	if ($Cheat_InvisibleCharacters = 1)
		BandManager_HideAllMusicians
	else
		BandManager_UnHideAllMusicians
	endif
endscript

script BandManager_HideInstrument 
	if CompositeObjectExists <name>
		<name> :HideInstrument
		BandManager_HideStrings name = <name>
	endif
endscript

script BandManager_UnHideInstrument 
	if CompositeObjectExists <name>
		<name> :UnHideInstrument
		BandManager_ShowStrings name = <name>
	endif
endscript

script BandManager_HideAllInstruments 
	BandManager_HideInstrument \{name = Guitarist}
	BandManager_HideInstrument \{name = guitarist2}
	BandManager_HideInstrument \{name = bassist}
	BandManager_HideInstrument \{name = bassist2}
	BandManager_HideInstrument \{name = vocalist}
	BandManager_HideInstrument \{name = vocalist2}
	BandManager_HideInstrument \{name = Drummer}
	BandManager_HideInstrument \{name = drummer2}
endscript

script BandManager_UnHideAllInstruments 
	BandManager_UnHideInstrument \{name = Guitarist}
	BandManager_UnHideInstrument \{name = guitarist2}
	BandManager_UnHideInstrument \{name = bassist}
	BandManager_UnHideInstrument \{name = bassist2}
	BandManager_UnHideInstrument \{name = vocalist}
	BandManager_UnHideInstrument \{name = vocalist2}
	BandManager_UnHideInstrument \{name = Drummer}
	BandManager_UnHideInstrument \{name = drummer2}
endscript

script BandManager_HideMusician 
	if CompositeObjectExists <name>
		<name> :HideMusician
	endif
endscript

script BandManager_UnHideMusician 
	if CompositeObjectExists <name>
		<name> :unhide
	endif
endscript

script BandManager_HideAllMusicians 
	BandManager_HideMusician \{name = Guitarist}
	BandManager_HideMusician \{name = guitarist2}
	BandManager_HideMusician \{name = bassist}
	BandManager_HideMusician \{name = bassist2}
	BandManager_HideMusician \{name = vocalist}
	BandManager_HideMusician \{name = vocalist2}
	BandManager_HideMusician \{name = Drummer}
	BandManager_HideMusician \{name = drummer2}
endscript

script BandManager_UnHideAllMusicians 
	BandManager_UnHideMusician \{name = Guitarist}
	BandManager_UnHideMusician \{name = guitarist2}
	BandManager_UnHideMusician \{name = bassist}
	BandManager_UnHideMusician \{name = bassist2}
	BandManager_UnHideMusician \{name = vocalist}
	BandManager_UnHideMusician \{name = vocalist2}
	BandManager_UnHideMusician \{name = Drummer}
	BandManager_UnHideMusician \{name = drummer2}
endscript

script get_musician_id 
	switch <name>
		case Guitarist
		case bassist
		case vocalist
		case Drummer
		if CompositeObjectExists name = <name>
			<name> :Obj_GetID
			name = <ObjID>
		endif
	endswitch
	return name = <name>
endscript

script should_play_moments 
	GMan_SongTool_GetCurrentSong
	get_band_configuration song = <current_song>
	if (<Band> = default_band)
		return \{true}
	else
		GameMode_GetType
		if (<type> = career)
			return \{true}
		else
			return \{false}
		endif
	endif
endscript
