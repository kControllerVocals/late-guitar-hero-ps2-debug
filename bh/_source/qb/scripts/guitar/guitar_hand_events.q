guitar_hand_event_time_offset = -100

script WatchForStartPlaying_iterator 
	begin
	GetSongTimeMs time_offset = <time_offset>
	if (<time> >= 0)
		wait_for_next_even_frame
		Wait \{1
			gameframe}
		BandManager_EndIntroAnims
		BandManager_StartAllFacialAnims
		Crowd_AllPlayAnim \{Anim = Idle}
		return
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script Drumkit_anim_iterator 
	return
endscript

script drumkit_input_playanim 
endscript

script AE_DrumKit_play_hiHat 
endscript

script AE_DrumKit_play_Snare 
endscript

script AE_DrumKit_play_Crash1 
endscript

script AE_DrumKit_play_Crash2 
endscript

script AE_DrumKit_play_Tom1 
endscript

script AE_DrumKit_play_tom2 
endscript

script AE_DrumKit_play_Ride 
endscript

script AE_DrumKit_Stop_Crash1 
endscript

script AE_DrumKit_Stop_Crash2 
endscript

script handle_change_stance \{Speed = 1.0}
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	display_debug_info = false
	if (should_display_debug_info)
		display_debug_info = true
	endif
	if GotParam \{no_wait}
		anim_set = ($<info_struct>.anim_set)
		old_stance = ($<info_struct>.stance)
		if play_stance_transition_cfunc anim_set = <anim_set> old_stance = <old_stance> new_stance = <stance>
			hero_play_anim Anim = <anim_to_run> Speed = <Speed>
			hero_wait_until_anim_finished
		else
		endif
		change structurename = <info_struct> stance = <stance>
		change structurename = <info_struct> next_stance = <stance>
		if (<display_debug_info> = true)

		endif
		if (<ObjID> = Guitarist || <ObjID> = bassist)
			if (<stance> = intro || <stance> = intro_smstg || <stance> = stance_frontend || <stance> = stance_frontend_guitar)
				change structurename = <info_struct> disable_arms = 2
				change structurename = <info_struct> next_anim_disable_arms = 2
			else
				change structurename = <info_struct> disable_arms = 0
				change structurename = <info_struct> next_anim_disable_arms = 0
			endif
			Obj_SwitchScript \{guitarist_idle}
		else
			Obj_SwitchScript \{BandMember_Idle}
		endif
	else
		if (<display_debug_info> = true)

		endif
		change structurename = <info_struct> next_stance = <stance>
		if (<ObjID> = Guitarist || <ObjID> = bassist)
			if (<stance> = intro || <stance> = intro_smstg || <stance> = stance_frontend || <stance> = stance_frontend_guitar)
				change structurename = <info_struct> next_anim_disable_arms = 2
			else
				change structurename = <info_struct> next_anim_disable_arms = 0
			endif
		endif
	endif
	return
endscript

script Output_Camera_Sync_Warnings 
	GMan_SongTool_GetCurrentSong


	GMan_SongTool_GetCurrentSong
	get_song_prefix song = <current_song>
	FormatText checksumname = event_array '%s_cameras_notes' s = <song_prefix> AddToStringLookup = true
	Sync_Cameras_To_Performance song_name = <current_song> Camera_Array = <event_array> output_results = 1
endscript

script Print_Camera_Sync_Warning 
	if NOT GotParam \{output_results}
		return
	endif
	if (<output_results> = 1)
		TextOutput text = <warning>
	endif

endscript

script Show_PlayClip_Time 
	if (<playclip_time_displayed> = 1)
		return
	endif
	if (<end_frame> = -1)
		FormatText TextName = warning qs("\L%a: Band_PlayClip") a = <next_anim_time>
	else
		length_in_frames = (<end_frame> - <start_frame>)
		FormatText TextName = warning qs("\L%a: Band_PlayClip start-%b end-%c (length %d)  ") a = <next_anim_time> b = <start_frame> c = <end_frame> d = <length_in_frames>
	endif
	Print_Camera_Sync_Warning <...>
	return \{playclip_time_displayed = 1}
endscript

script Sync_Cameras_To_Performance \{output_results = 0}
endscript
Short_Strum = 800
Short_Pick = 666
Init_Blend_Curve = [
	1.0
	0.9936329
	0.97541296
	0.94665694
	0.908686
	0.862818
	0.81037295
	0.75266796
	0.691025
	0.626761
	0.561195
	0.495648
	0.431438
	0.36988303
	0.312304
	0.260019
	0.214348
	0.176609
	0.14523199
	0.117623
	0.0935624
	0.072831795
	0.055212397
	0.0404852
	0.028431498
	0.0188325
	0.0114694005
	0.0061233295
	0.0025756303
	0.000607445
	0.0
]
Idle_Blend_Curve = [
	1.0
	0.9916719
	0.967925
	0.9302049
	0.879517
	0.816499
	0.741457
	0.65434504
	0.557258
	0.472638
	0.401996
	0.342054
	0.290639
	0.246221
	0.20767501
	0.17414398
	0.144956
	0.119572
	0.0975515
	0.0785257
	0.062184203
	0.048259903
	0.0365202
	0.026759999
	0.0187951
	0.012458201
	0.0075944406
	0.0040576695
	0.0017067901
	0.000401919
	0.0
]

script fire_off_Idle 
	if (<idletype> = rest)
		Idle = 'Strum_Idle_Rest'
	endif
	GetRandomFloat \{a = 0.0
		b = 1.0}
	startanim = <random_float>
	ExtendCRC <strum_base> <Idle> out = Strumanim
	ExtendCRC <strum_base> <LastBasePose> out = baseanim
	Anim_Command target = Dynamic_strums command = DegenerateBlend_AddBranch params = {
		BlendDuration = <blend>
		blendcurve = $Idle_Blend_Curve
		Tree = $Dynamic_Strum_Idle_Branch
		params = {
			startanim = <startanim>
			baseanim = <baseanim>
			Strumanim = <Strumanim>
		}
	}
endscript
