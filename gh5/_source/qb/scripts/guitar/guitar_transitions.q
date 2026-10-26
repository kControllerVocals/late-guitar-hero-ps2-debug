transition_playing = false
current_playing_transition = none
setlist_selection_tier = 1
Transition_Types = {
	intro = {
		textnl = 'intro'
	}
	fastintro = {
		textnl = 'fastintro'
	}
	fastintrotutorial = {
		textnl = 'fastintrotutorial'
	}
	practice = {
		textnl = 'practice'
	}
	preencore = {
		textnl = 'preencore'
	}
	encore = {
		textnl = 'encore'
	}
	restartencore = {
		textnl = 'restartencore'
	}
	songwon = {
		textnl = 'songwon'
	}
	songdoneattract = {
		textnl = 'songdoneattract'
	}
	songoutro = {
		textnl = 'songoutro'
	}
	songlost = {
		textnl = 'songlost'
	}
	loading = {
		textnl = 'loading'
	}
	loadingintro = {
		textnl = 'loadingintro'
	}
	celebintro = {
		textnl = 'celebintro'
	}
}
Default_Immediate_Transition = {
	time = 0
	ScriptTable = [
	]
}
Common_Immediate_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras'
				changenow
			}
		}
		{
			time = 0
			Scr = play_win_anims
		}
		{
			time = 100
			Scr = Transition_StartRendering
		}
	]
}
Default_FastIntro_Transition = {
	time = 3000
	ScriptTable = [
	]
}
Common_FastIntro_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Transition_StopRendering
		}
		{
			time = 0
			Scr = play_intro_anims
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			Scr = play_intro
			params = {
				Fast
			}
		}
		{
			time = 1
			Scr = Band_PlayTransitionIdles
			params = {
				from_restart = true
			}
		}
		{
			time = 100
			Scr = VenueFastIntro_FX
		}
		{
			time = 100
			Scr = Transition_StartRendering
		}
		{
			time = 100
			Scr = enable_tutorial_pause
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_FastIntroTutorial_Transition = {
	time = 3000
	ScriptTable = [
	]
}
Common_FastIntroTutorial_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Transition_StopRendering
		}
		{
			time = 0
			Scr = BandManager_SetPlayingIntroAnims
		}
		{
			time = 0
			Scr = training_setup_camera
			params = {
				name = CameraCutCam
			}
		}
		{
			time = 0
			Scr = play_intro
			params = {
				Fast
			}
		}
		{
			time = 1
			Scr = Band_PlayTransitionIdles
		}
		{
			time = 100
			Scr = Transition_StartRendering
		}
		{
			time = 100
			Scr = enable_tutorial_pause
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_RestartEncore_Transition = {
	time = 3000
	ScriptTable = [
	]
}
Common_RestartEncore_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Transition_StopRendering
		}
		{
			time = 0
			Scr = BandManager_SetPlayingIntroAnims
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			Scr = play_intro
			params = {
				Fast
			}
		}
		{
			time = 1
			Scr = Band_PlayTransitionIdles
			params = {
				from_restart = true
			}
		}
		{
			time = 100
			Scr = Transition_StartRendering
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_Practice_Transition = {
	time = 5000
	ScriptTable = [
	]
}
Common_Practice_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Transition_StopRendering
		}
		{
			time = 0
			Scr = BandManager_SetPlayingIntroAnims
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			Scr = play_intro
			params = {
				practice
			}
		}
		{
			time = 100
			Scr = Transition_StartRendering
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_Intro_Transition = {
	time = 19500
	ScriptTable = [
	]
}
Common_Intro_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Start_Preloaded_Celeb_Intro_Stream
		}
		{
			time = 0
			Scr = Transition_StopRendering
		}
		{
			time = 0
			Scr = Crowd_AllPlayAnim
			params = {
				Anim = Idle
			}
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				changenow
			}
		}
		{
			time = 0
			Scr = play_intro
			params = {
			}
		}
		{
			time = 1
			Scr = Band_PlayTransitionIdles
		}
		{
			time = 100
			Scr = VenueIntro_FX_Spawn
		}
		{
			time = 100
			Scr = Transition_StartRendering
		}
		{
			time = 100
			Scr = GH_SFX_Intro_WarmUp
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_PreEncore_Transition = {
	time = 10000
	ScriptTable = [
		{
			time = 0
			Scr = Change_Crowd_Looping_SFX
			params = {
				crowd_looping_state = good
			}
		}
	]
}
Common_PreEncore_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = maybe_play_win_anims
			params = {
			}
		}
		{
			time = 0
			Scr = kill_gem_scroller
			params = {
				type = outro
				kill_cameracuts_iterator
			}
		}
		{
			time = 0
			Scr = Crowd_AllPlayAnim
			params = {
				Anim = Idle
			}
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_no_band'
				changenow
			}
		}
		{
			time = 0
			Scr = Change_Crowd_Looping_SFX
			params = {
				crowd_looping_state = good
			}
		}
	]
	EndWithDefaultCamera
}
Default_Encore_Transition = {
	time = 5000
	ScriptTable = [
		{
			time = 0
			Scr = StopEncoreStreamSFX
			params = {
			}
		}
	]
}
Common_Encore_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Crowd_AllPlayAnim
			params = {
				Anim = Idle
			}
		}
		{
			time = 0
			Scr = Start_Preloaded_Encore_Event_Stream
		}
		{
			time = 0
			Scr = Transition_StopRendering
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_encore'
				changenow
			}
		}
		{
			time = 0
			Scr = play_intro
			params = {
			}
		}
		{
			time = 100
			Scr = Transition_StartRendering
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_SongWon_Transition = {
	time = 7000
	ScriptTable = [
	]
}
Common_SongWon_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = maybe_play_win_anims
			params = {
			}
		}
		{
			time = 0
			Scr = kill_gem_scroller
			params = {
				type = outro
				kill_cameracuts_iterator
			}
		}
		{
			time = 0
			Scr = Crowd_AllPlayAnim
			params = {
				Anim = Idle
			}
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_win'
				changenow
			}
		}
	]
	EndWithDefaultCamera
}
Default_SongDoneAttract_Transition = {
	time = 1000
	ScriptTable = [
	]
}
Common_SongDoneAttract_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = kill_gem_scroller
			params = {
				type = outro
				kill_cameracuts_iterator
			}
		}
		{
			time = 0
			Scr = Crowd_AllPlayAnim
			params = {
				Anim = Idle
			}
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_no_band'
				changenow
			}
		}
	]
	EndWithDefaultCamera
}
Default_SongOutro_Transition = {
	time = 60000
	ScriptTable = [
	]
}
Common_SongOutro_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_moments'
				changenow
				name = moment01
			}
		}
		{
			time = 0
			Scr = play_song_outro_anims
			params = {
			}
		}
	]
	EndWithDefaultCamera
}
Default_SongLost_Transition = {
	time = 8000
	ScriptTable = [
	]
}
Common_SongLost_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = maybe_play_lose_anims
			params = {
			}
		}
		{
			time = 0
			Scr = Change_Crowd_Looping_SFX
			params = {
				crowd_looping_state = Bad
			}
		}
		{
			time = 0
			Scr = kill_gem_scroller
			params = {
				type = outro
				kill_cameracuts_iterator
				song_failed_pitch_streams = 1
			}
		}
		{
			time = 0
			Scr = Crowd_AllPlayAnim
			params = {
				Anim = Idle
			}
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_lose'
				changenow
			}
		}
	]
	EndWithDefaultCamera
}
Default_Loading_Transition = {
	time = 12000
	ScriptTable = [
	]
}
Common_Loading_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Crowd_AllPlayAnim
			params = {
				Anim = Idle
			}
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_no_band'
				changenow
			}
		}
		{
			time = 0
			Scr = CreateInVenueLoadingScreen
			params = {
			}
		}
	]
}
Default_LoadingIntro_Transition = {
	time = 12000
	ScriptTable = [
	]
}
Common_LoadingIntro_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Crowd_AllPlayAnim
			params = {
				Anim = Idle
			}
		}
		{
			time = 0
			Scr = BandManager_SetPlayingIntroAnims
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			Scr = play_intro
			params = {
				Fast
			}
		}
		{
			time = 1
			Scr = Band_PlayTransitionIdles
		}
		{
			time = 100
			Scr = Transition_StartRendering
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_CelebIntro_Transition = {
	time = 10000
	ScriptTable = [
	]
}
Common_CelebIntro_Transition = {
	ScriptTable = [
		{
			time = 0
			Scr = Transition_StopRendering
		}
		{
			time = 0
			Scr = Crowd_AllPlayAnim
			params = {
				Anim = Idle
			}
		}
		{
			time = 0
			Scr = Transition_CameraCut
			params = {
				changenow
			}
		}
		{
			time = 0
			Scr = play_intro
			params = {
			}
		}
		{
			time = 1
			Scr = Band_PlayTransitionIdles
		}
		{
			time = 0
			Scr = CelebIntro_FX
		}
		{
			time = 100
			Scr = Start_Preloaded_Celeb_Intro_Stream
		}
		{
			time = 100
			Scr = Transition_StartRendering
		}
		{
			time = 100
			Scr = GH_SFX_Intro_WarmUp
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}

script CreateInVenueLoadingScreen 
	GameMode_GetType
endscript
Add_loading_screen = 0

script PauseInVenueLoadingScreen 
endscript

script Common_Loading_TransitionEnd 

endscript

script Transition_SelectTransition \{practice_intro = 0}
	if ($debug_encore)
		change \{current_transition = encore}
		return
	endif
	if (<practice_intro> = 1)
		return
	endif
	if ($current_transition = debugintro)
		change \{current_transition = intro}
		return
	endif
	if ($current_transition = forcelongintro)
		change \{current_transition = intro}
		return
	endif
	GameMode_GetType
	if (<type> = career)
		GMan_SongTool_GetCurrentSong
		GetPakManCurrent \{map = zones}
		vv_pick_transition zone = <pak> song = <current_song>
		change current_transition = <transition>
		return
	endif
	change \{current_transition = fastintro}
endscript

script Transition_KillAll 
	KillSpawnedScript \{id = Transitions}
	change \{transition_playing = false}
	change \{current_playing_transition = none}
endscript

script Transition_GetPrefix \{type = intro}
	celeb_intro = 0
	if StructureContains Structure = $Transition_Types <type>

		type_textnl = ($Transition_Types.<type>.textnl)
	else
		GetArraySize ($Celeb_Intro_Transitions)
		index = 0
		begin
		FormatText checksumname = transition '%s' s = ($Celeb_Intro_Transitions [<index>].intro)
		if (<type> = <transition>)
			type_textnl = ($Celeb_Intro_Transitions [<index>].intro)
			celeb_intro = 1
			break
		endif
		index = (<index> + 1)
		repeat <array_size>
	endif
	if NOT GotParam \{type_textnl}


	endif
	return type_textnl = <type_textnl> celeb_intro = <celeb_intro>
endscript

script Transition_GetProps 
	Transition_GetPrefix <...>
	GetPakManCurrentName \{map = zones}
	FormatText checksumname = Transition_Props '%s_%p_Transition' p = <type_textnl> s = <pakname>
	if NOT GlobalExists name = <Transition_Props>
		FormatText checksumname = Transition_Props 'default_%p_Transition' p = <type_textnl> s = <pakname>
	endif
	if (<celeb_intro> = 1)
		if NOT GlobalExists name = <Transition_Props>
			Transition_Props = Default_Intro_Transition
		endif
	endif
	FormatText checksumname = Common_Transition_Props 'Common_%p_Transition' p = <type_textnl>
	common_type_textnl = <type_textnl>
	if (<celeb_intro> = 1)
		common_type_textnl = 'intro'
		if NOT GlobalExists name = <Common_Transition_Props>
			Common_Transition_Props = Common_Intro_Transition
		endif
	endif
	return type_textnl = <type_textnl> common_type_textnl = <common_type_textnl> Transition_Props = <Transition_Props> Common_Transition_Props = <Common_Transition_Props>
endscript

script Transition_GetTime \{type = intro}
	Transition_GetProps type = <type>
	return transition_time = ($<Transition_Props>.time)
endscript

script Transition_Play \{type = intro}
	debug_Printf 'Transition_Play type=%t' t = <type>
	Transition_KillAll
	change current_playing_transition = <type>
	Transition_GetProps type = <type>
	GetPakManCurrentName \{map = zones}
	FormatText checksumname = event 'Common_%p_TransitionSetup' p = <common_type_textnl> s = <pakname>
	if ScriptExists <event>
		<event>
	endif
	FormatText checksumname = event '%s_%p_TransitionSetup' p = <type_textnl> s = <pakname>
	if ScriptExists <event>
		spawnscriptnow <event>
	endif
	spawnscriptnow Transition_Play_Spawned id = Transitions params = {<...>}
	FormatText checksumname = event 'GuitarEvent_Transition%s' s = <type_textnl>
	if ScriptExists <event>
		spawnscriptnow <event>
	endif
endscript

script Transition_Play_Spawned 
	change \{transition_playing = true}
	GetPakManCurrentName \{map = zones}
	Transition_GetTime type = <type>
	spawnscriptnow Transition_Play_Iterator id = Transitions params = {<...>}
	spawnscriptnow Transition_Play_Iterator id = Transitions params = {<...> Transition_Props = <Common_Transition_Props>}
	GetSongTimeMs
	time_offset = (0 - <time>)
	begin
	GetSongTimeMs time_offset = <time_offset>
	if (<transition_time> <= <time>)
		change \{transition_playing = false}
		break
	endif
	WaitOneGameFrame
	repeat
	if StructureContains Structure = ($<Common_Transition_Props>) EndWithDefaultCamera
		GMan_SongTool_GetCurrentSong
		if ($game_mode = p2_pro_faceoff || <current_song> = jamsession)
			CameraCuts_EnableChangeCam \{enable = false}
			GetFPS
			delay_ms = (0.0 - $time_input_offset)
			ms_per_frame = (1000.0 / <fps>)
			frames = (<delay_ms> / <ms_per_frame>)
			CastToInteger \{frames}
			Wait <frames> gameframes
			if (<current_song> = jamsession)
				CameraCuts_SetArrayPrefix \{prefix = 'cameras_jam_mode'
					changenow}
			else
				CameraCuts_SetArrayPrefix \{prefix = 'cameras_headtohead'
					changenow}
			endif
		else
			if StructureContains Structure = ($<Common_Transition_Props>) SyncWithNoteCameras
				CameraCuts_GetNextNoteCameraTime
				GetSongTimeMs
				if (<camera_time> >= -200 &&
						<camera_time> - <time> < 2000)
					CameraCuts_EnableChangeCam \{enable = false}
				else
					if NOT ($game_mode = tutorial || $game_mode = practice)
						CameraCuts_SetArrayPrefix \{prefix = 'cameras'
							changenow}
					else
						CameraCuts_EnableChangeCam \{enable = false}
					endif
				endif
			else
				if NOT ($game_mode = tutorial || $game_mode = practice)
					CameraCuts_SetArrayPrefix \{prefix = 'cameras'
						changenow}
				else
					CameraCuts_EnableChangeCam \{enable = false}
				endif
			endif
		endif
	endif
	FormatText checksumname = event 'Common_%p_TransitionEnd' p = <type_textnl> s = <pakname>
	if ScriptExists <event>
		spawnscriptnow <event>
	endif
	FormatText checksumname = event '%s_%p_TransitionEnd' p = <type_textnl> s = <pakname>
	if ScriptExists <event>
		spawnscriptnow <event>
	endif
	change \{current_playing_transition = none}
endscript

script fadePlayingIntro 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	vol = 100
	begin
	if ($playing_intro_stream_id = none)
		return
	endif
	vol = (<vol> -1.0)
	SetStreamParams $playing_intro_stream_id vol = (<vol> / 100.0)
	WaitOneGameFrame
	repeat 99
	if NOT ($playing_intro_stream_id = none)
		StopSoundStream unique_id = ($playing_intro_stream_id)
		change \{playing_intro_stream_id = none}
	endif
endscript

script IsTransitionPlaying 
	if GotParam \{type}
		if (<type> = $current_playing_transition)
			return \{true}
		endif
	else
		if NOT (<type> = none)
			return \{true}
		endif
	endif
	return \{false}
endscript

script Transition_Play_Iterator 
	GetSongTimeMs
	time_offset = (0 - <time>)
	GetArraySize ($<Transition_Props>.ScriptTable)
	if (<array_size> = 0)
		return
	endif
	GetSongTimeMs time_offset = <time_offset>
	array_count = 0
	begin
	begin
	GetSongTimeMs time_offset = <time_offset>
	if ($<Transition_Props>.ScriptTable [<array_count>].time <= <time>)
		break
	endif
	WaitOneGameFrame
	repeat
	if ScriptExists ($<Transition_Props>.ScriptTable [<array_count>].Scr)
		spawnscriptnow ($<Transition_Props>.ScriptTable [<array_count>].Scr) id = Transitions params = {transition_time = <transition_time> ($<Transition_Props>.ScriptTable [<array_count>].params)}
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
endscript

script Transition_Wait 
	begin
	if ($transition_playing = false)
		return
	endif
	WaitOneGameFrame
	repeat
endscript

script ClipPlayDrummerCamera 
	if NOT GotParam \{Anim}

	endif
	if NOT GotParam \{index}

	endif
	if (<index> < 10)
		FormatText checksumname = lock_target 'drummer_mocap_lock_target_0%i' i = <index>
	else
		FormatText checksumname = lock_target 'drummer_mocap_lock_target_%i' i = <index>
	endif
	MomentCamera_PlayAnim {Anim = <Anim> $drumcam_params lock_target = <lock_target>}
endscript

script Transition_SetCamera 
	if NOT GotParam \{note}
		return
	endif
	if GetNoteMapping section = cameras note = <note>
		clip_get_time_and_frame
		spawnscriptnow (<note_data>.Scr) params = {(<note_data>.params) length = <length>}
	else
	endif
endscript

script MomentCamera_PlayAnim \{Cycle = 0
		start = 0.0
		BlendDuration = 0.0}
	if NOT CompositeObjectExists name = <lock_target>

		return
	endif
	SetSearchAllAssetContexts
	GetPakManCurrent \{map = zones}
	GetPakManCurrentName \{map = zones}
	if GotParam \{start_node}
		ExtendCRC <pak> <start_node> out = start_node_id
		GetWaypointPos name = <start_node_id>
		GetWaypointDir name = <start_node_id>
		<lock_target> :Obj_SetPosition position = <pos>
		<lock_target> :Obj_SetOrientation dir = <dir>
	else
		suffix = ('_' + <node>)
		AppendSuffixToChecksum Base = <pak> SuffixString = <suffix>
		if CompositeObjectExists name = <appended_id>
			<appended_id> :Obj_GetPosition
			<lock_target> :Obj_SetPosition position = <pos>
			<appended_id> :Obj_GetOrientation
			dir = ((1.0, 0.0, 0.0) * <x> + (0.0, 1.0, 0.0) * <y> + (0.0, 0.0, 1.0) * <z>)
			<lock_target> :Obj_SetOrientation dir = <dir>
		else

		endif
	endif
	if NOT GotParam \{tempo_anim}
		tempo_anim = <Anim>
	endif
	spawnscriptnow MomentCamera_PlayAnim_Spawned params = {name = <lock_target> Anim = <Anim> TempoAnim = <tempo_anim> Cycle = <Cycle> start = <start> BlendDuration = <BlendDuration>}
	SetSearchAllAssetContexts \{off}
endscript

script MomentCamera_PlayAnim_Spawned \{start = 0.0
		Speed = 1.0
		BlendDuration = -1.0}

	if NOT CompositeObjectExists name = <name>

		return
	endif
	begin
	SetSearchAllAssetContexts
	if NOT GotParam \{Anim}
		<name> :Anim_GetDefaultAnimName
		Anim = <DefaultAnimName>
	endif
	if NOT GotParam \{TempoAnim}
		TempoAnim = Anim
	endif
	<name> :RemoveTags [AnimRequestedFOVRadians]
	<name> :Anim_Enable
	<name> :Anim_Command target = Body command = DegenerateBlend_AddBranch params = {
		Tree = $SpecialCamera_StandardAnimBranch
		BlendDuration = <BlendDuration>
		params = {
			Anim = <Anim>
			Speed = <Speed>
			TimerType = tempo
			start = <start>
			AnimEvents = on
			TempoAnim = <TempoAnim>
			AllowBeatSkipping = true
		}
	}
	<name> :Anim_Command target = BodyTimer command = Timer_WaitAnimComplete
	SetSearchAllAssetContexts \{off}
	if (<Cycle> = 0)
		break
	endif
	repeat
endscript

script SpecialCamera_PlayAnim \{Cycle = 0
		start = 0.0}
	SetSearchAllAssetContexts
	GetPakManCurrent \{map = zones}
	GetPakManCurrentName \{map = zones}
	FormatText TextName = suffix '_%s' s = <obj>
	AppendSuffixToChecksum Base = <pak> SuffixString = <suffix>
	cameraname = (<pakname> + <suffix>)
	if CompositeObjectExists name = <appended_id>
		<appended_id> :Obj_SwitchScript SpecialCamera_PlayAnim_Spawned params = {Anim = <Anim> Cycle = <Cycle> start = <start> BlendDuration = <BlendDuration>}
	else

	endif
	SetSearchAllAssetContexts \{off}
endscript

script SpecialCamera_PlayAnim_Spawned \{start = 0.0
		Speed = 1.0
		BlendDuration = -1.0}
	begin
	SetSearchAllAssetContexts
	if NOT GotParam \{Anim}
		Anim_GetDefaultAnimName
		Anim = <DefaultAnimName>
	endif
	if NOT GotParam \{TempoAnim}
		TempoAnim = Anim
	endif

	RemoveTags \{[
			AnimRequestedFOVRadians
		]}
	Anim_Enable
	Anim_Command target = Body command = DegenerateBlend_AddBranch params = {
		Tree = $SpecialCamera_StandardAnimBranch
		BlendDuration = <BlendDuration>
		params = {
			Anim = <Anim>
			Speed = <Speed>
			TimerType = tempo
			start = <start>
			AnimEvents = on
			TempoAnim = <TempoAnim>
			AllowBeatSkipping = true
		}
	}
	SpecialCamera_WaitAnimFinished
	SetSearchAllAssetContexts \{off}
	if (<Cycle> = 0)
		break
	endif
	repeat
endscript

script SpecialCamera_WaitAnimFinished \{Timer = BodyTimer}
	Anim_Command target = <Timer> command = Timer_WaitAnimComplete
endscript
SpecialCamera_StandardAnimBranch = {
	type = TimerType
	id = BodyTimer
	Anim = Anim
	tempo_anim = TempoAnim
	anim_events = AnimEvents
	allow_beat_skipping = AllowBeatSkipping
	Speed = Speed
	start = start
	[
		{
			type = Source
			Anim = Anim
		}
	]
}

script Transition_PlayAnim \{Cycle = 0}
	<obj> :Obj_SwitchScript Transition_PlayAnim_Spawned params = {Anim = <Anim> Cycle = <Cycle> BlendDuration = <BlendDuration>}
endscript

script Transition_PlayAnim_Spawned 
	begin
	GameObj_PlayAnim Anim = <Anim> BlendDuration = <BlendDuration>
	GameObj_WaitAnimFinished
	if (<Cycle> = 0)
		break
	endif
	repeat
endscript

script Transition_CameraCut 
	if GotParam \{prefix}
		CameraCuts_SetArrayPrefix <...> length = <transition_time>
	else
		if NOT ($current_playing_transition = none)
			Transition_GetPrefix type = ($current_playing_transition)
		else
			Transition_GetPrefix \{type = intro}
		endif
		GetPakManCurrentName \{map = zones}
		FormatText checksumname = Cameras_Array 'default_cameras_%t' t = <type_textnl>
		FormatText TextName = prefix 'cameras_%t' t = <type_textnl>
		if NOT GlobalExists name = <Cameras_Array>
			FormatText checksumname = Cameras_Array '%s_cameras_%t' s = <pakname> t = <type_textnl>
			if NOT GlobalExists name = <Cameras_Array>
				prefix = 'cameras_intro'
			endif
		endif
		CameraCuts_SetArrayPrefix <...> length = <transition_time>
	endif
endscript

script Transition_StopRendering 

	stoprendering
endscript

script Transition_StartRendering 

	startrendering
	change \{is_changing_levels = 0}
	if ($blade_active = 1)
		change \{blade_active = 0}
		gh3_start_pressed \{from_handler}
	endif
endscript

script Transitions_ResetZone 

	GetPakManCurrentName \{map = zones}
	FormatText checksumname = reset_func '%s_ResetTransition' s = <pakname>
	if ScriptExists <reset_func>
		<reset_func>
	endif
	FormatText checksumname = nodearray_checksum '%s_NodeArray' s = <pakname>
	if NOT GlobalExists name = <nodearray_checksum> type = array
		return
	endif
	GetArraySize $<nodearray_checksum>
	array_count = 0
	begin
	resetvalid = true
	if GotParam \{profile}
		resetvalid = false
		if StructureContains Structure = ($<nodearray_checksum> [<array_count>]) profile
			if CompareStructs struct1 = ($<nodearray_checksum> [<array_count>].profile) struct2 = (<profile>)
				resetvalid = true
			endif
		endif
	endif
	if StructureContains Structure = ($<nodearray_checksum> [<array_count>]) CreatedFromVariable
		resetvalid = false
	endif
	if StructureContains Structure = ($<nodearray_checksum> [<array_count>]) CreatedOnProgress
		resetvalid = false
	endif
	if StructureContains Structure = ($<nodearray_checksum> [<array_count>]) Class
		if NOT ($<nodearray_checksum> [<array_count>].Class = GameObject ||
				$<nodearray_checksum> [<array_count>].Class = levelgeometry)
			resetvalid = false
		endif
	else
		resetvalid = false
	endif
	if (<resetvalid> = true)

		kill name = ($<nodearray_checksum> [<array_count>].name)
		if StructureContains Structure = ($<nodearray_checksum> [<array_count>]) CreatedAtStart
			create name = ($<nodearray_checksum> [<array_count>].name)
		endif
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
endscript

script Common_Intro_TransitionSetup 

	Preload_Celeb_Intro_Stream
endscript

script Common_PreEncore_TransitionSetup 
	Change_Crowd_Looping_SFX \{crowd_looping_state = good}
endscript

script Common_PreEncore_TransitionEnd 
endscript

script Common_Encore_TransitionSetup 

	Preload_Encore_Event_Stream
endscript

script Common_Encore_TransitionEnd 
endscript

script Preload_Encore_Bink_Audio \{movie_name = 'z_artdeco_encore_audio'}
endscript

script Common_Loading_TransitionSetup 
endscript
celeb_intro_stream_id = none
playing_intro_stream_id = none

script Preload_Celeb_Intro_Stream 

	Transition_GetPrefix type = ($current_playing_transition)
	if NOT ($celeb_intro_stream_id = none)
		StopSoundStream unique_id = ($celeb_intro_stream_id)
		change \{celeb_intro_stream_id = none}
	endif
	if NOT ($playing_intro_stream_id = none)
		StopSoundStream unique_id = ($playing_intro_stream_id)
		change \{playing_intro_stream_id = none}
	endif
	if ($current_song = jamsession)
		return
	endif
	if ((<celeb_intro> = 0) && ($current_playing_transition != careerintro))
		if NOT ($celeb_intro_stream_id = none)
			StopSoundStream unique_id = ($celeb_intro_stream_id)
			change \{celeb_intro_stream_id = none}
		endif
		GetPakManCurrentName \{map = zones}
		FormatText checksumname = intro_stream_name '%s_intro' s = <pakname> AddToStringLookup = true
		if NOT PreloadSoundStream filename_crc = <intro_stream_name> samplerate = 22050 stereo = true
			return
		endif
		if NOT (<unique_id> = 0x00000000)
			change celeb_intro_stream_id = <unique_id>
		endif
		if NOT ($celeb_intro_stream_id = none)
			begin

			if PreLoadStreamDone <unique_id>
				break
			endif
			Wait \{1
				gameframe}
			repeat
		endif
		return
	endif
	celeb_intro_checksum = ($current_playing_transition)
	if NOT PreloadSoundStream filename_crc = <celeb_intro_checksum> samplerate = 22050 stereo = true
		return
	endif
	if NOT (<unique_id> = 0x00000000)
		change celeb_intro_stream_id = <unique_id>
	endif
	if NOT ($celeb_intro_stream_id = none)
		begin

		if PreLoadStreamDone <unique_id>
			break
		endif
		Wait \{1
			gameframe}
		repeat
	endif
endscript

script Start_Preloaded_Celeb_Intro_Stream 
	if ($current_playing_transition = careerintro)
		return
	endif

	if NOT ($celeb_intro_stream_id = none)
		StartPreloadedStream \{$celeb_intro_stream_id
			buss = Encore_Events
			forcesafepreload = 1
			pitch = 100}
		change playing_intro_stream_id = ($celeb_intro_stream_id)
		change \{celeb_intro_stream_id = none}
	endif
endscript
encore_event_stream_id = none

script Preload_Encore_Event_Stream 

	if NOT ($encore_event_stream_id = none)
		StopSoundStream unique_id = ($encore_event_stream_id)
		change \{encore_event_stream_id = none}
	endif
	if NOT ($playing_intro_stream_id = none)
		StopSoundStream unique_id = ($playing_intro_stream_id)
		change \{playing_intro_stream_id = none}
	endif
	GetPakManCurrentName \{map = zones}
	FormatText checksumname = encore_stream_name '%s_encore' s = <pakname> AddToStringLookup = true
	if NOT PreloadSoundStream filename_crc = <encore_stream_name> samplerate = 22050 stereo = true
		return
	endif
	if NOT (<unique_id> = 0x00000000)
		change encore_event_stream_id = <unique_id>
	endif
	if NOT ($encore_event_stream_id = none)
		begin

		if PreLoadStreamDone <unique_id>
			break
		endif
		Wait \{1
			gameframe}
		repeat
	endif
endscript

script Start_Preloaded_Encore_Event_Stream 

	if NOT ($encore_event_stream_id = none)
		StopSoundEvent \{$Current_Crowd_Encore
			fade_time = 3
			fade_type = linear}

		StartPreloadedStream \{$encore_event_stream_id
			buss = Encore_Events
			forcesafepreload = 1
			pitch = 100}
		change playing_intro_stream_id = ($encore_event_stream_id)
		change \{encore_event_stream_id = none}
	endif
endscript

script Kill_Transition_Preload_Streams 
	KillSpawnedScript \{name = Preload_Encore_Event_Stream}
	KillSpawnedScript \{name = Preload_Celeb_Intro_Stream}
	change \{encore_event_stream_id = none}
	change \{celeb_intro_stream_id = none}
endscript

script should_play_long_venue_intro 
	GetPakManCurrent \{map = zones}
	GetGlobalTags \{venue_intro_flags}
	if StructureContains Structure = <...> <pak>
		<venue_flag> = (<...>.<pak>)
		if (<venue_flag> = 1)

			return \{false}
		endif
	endif

	AddParam name = <pak> value = 1 structure_name = newvalue
	SetGlobalTags venue_intro_flags params = <newvalue>
	return \{true}
endscript
