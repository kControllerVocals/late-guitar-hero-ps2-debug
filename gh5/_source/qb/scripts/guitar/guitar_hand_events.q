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

script check_for_short_anims_in_clip 
	if NOT GlobalExists name = <clip> type = Structure
		return
	endif
	if NOT StructureContains Structure = $<clip> name = anims
		return
	endif
	found_problem = false
	check_anim_length clip = <clip> name = Guitarist endtime = <endtime> <...>
	check_anim_length clip = <clip> name = bassist endtime = <endtime> <...>
	check_anim_length clip = <clip> name = vocalist endtime = <endtime> <...>
	check_anim_length clip = <clip> name = Drummer endtime = <endtime> <...>
	if (<found_problem> = true)
		return \{true}
	endif
	return \{false}
endscript

script check_anim_length 
	if StructureContains Structure = ($<clip>.anims) name = <name>
		Anim = ($<clip>.anims.<name>)
		if Anim_AnimExists Anim = <Anim>
			anim_Getanimlength Anim = <Anim>
			if (<length> < <endtime>)
				Show_PlayClip_Time {
					output_results = <output_results>
					playclip_time_displayed = <playclip_time_displayed>
					start_frame = <start_frame>
					end_frame = <end_frame>
					next_anim_time = <next_anim_time>
				}
				FormatText TextName = warning qs("  Am anim has a length %b which is shorter than clip length %c ") a = <Anim> b = <length> c = <endtime>
				Print_Camera_Sync_Warning warning = <warning> output_results = <output_results>
				found_problem = true
			endif
		endif
	endif
	return found_problem = <found_problem>
endscript
use_guitar_strum_script = true
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

script handle_guitar_strum 
	Obj_KillSpawnedScript \{name = fire_off_Idle}
	Obj_GetID
	<ObjID> :GetSingleTag is_female
	<ObjID> :GetSingleTag large_hands
	<ObjID> :GetSingleTag lefty
	ExtendCRC <ObjID> '_Info' out = info_struct
	part = ($<info_struct>.part)
	if (<is_female> = 1)
		gender = 'GH_Female'
	elseif (<large_hands> = 1)
		gender = 'GH_Large'
	else
		gender = 'GH_Male'
	endif
	if (<part> = guitar)
		strumtype = 'G'
	elseif (<part> = Bass)
		strumtype = 'B'
	else
		return
	endif
	if (<lefty> = 1)
		gender = 'GH_Male'
		strumtype = 'GL'
	endif
	<ObjID> :GetTags LastBasePose
	<ObjID> :GetTags LastType
	<ObjID> :GetTags LastNoteValue
	switch (<color_combo>)
		case green
		type = pick
		newbaseanim = 'Strum_String_1'
		noteValue = 1
		case red
		type = pick
		newbaseanim = 'Strum_String_2'
		noteValue = 2
		case Yellow
		type = pick
		newbaseanim = 'Strum_String_3'
		noteValue = 3
		case Blue
		type = pick
		newbaseanim = 'Strum_String_4'
		noteValue = 4
		case Orange
		type = pick
		newbaseanim = 'Strum_String_5'
		noteValue = 5
		default
		type = strum
	endswitch
	if (<type> = pick)
		if (<time_to_next_note> < $Short_Pick)
			if (<LastNoteValue> > <noteValue>)
				type = upPick
			elseif (<LastNoteValue> = <noteValue>)
				if (<LastType> = pick)
					type = upPick
				endif
			endif
		endif
	else
		if (<time_to_next_note> < $Short_Strum)
			if (<LastNoteValue> > 4)
				type = upstrum
			endif
		endif
	endif
	switch <type>
		case pick
		Init_Length = 1.0
		total_length = 1.7666659
		NewStrumanim = Random (@ 'Pick1' @ 'Pick2' )
		case upPick
		Init_Length = 1.0
		total_length = 1.7666659
		NewStrumanim = Random (@ 'upPick1' @ 'upPick2' )
		case strum
		Init_Length = 1.0
		total_length = 2.333333
		NewStrumanim = Random (@ 'Strum1' @ 'Strum2' )
		newbaseanim = 'Strum_String_1'
		noteValue = 6
		case upstrum
		Init_Length = 1.0
		total_length = 2.333333
		NewStrumanim = Random (@ 'UpStrum1' @ 'UpStrum2' )
		newbaseanim = 'Strum_String_5'
		noteValue = 0
		default
		Init_Length = 1.0
		total_length = 2.333333
		NewStrumanim = 'Blank'
		noteValue = 666
	endswitch
	switch <LastType>
		case pick
		Wait_For_Idle = 0.3
		Idle_Blend_Time = 0.7
		case upPick
		Wait_For_Idle = 0.3
		Idle_Blend_Time = 0.7
		case strum
		Wait_For_Idle = 0.8
		Idle_Blend_Time = 0.7
		case upstrum
		Wait_For_Idle = 0.8
		Idle_Blend_Time = 0.7
		default
		Wait_For_Idle = 0.0
		Idle_Blend_Time = 0.0
	endswitch
	if ((<time_to_next_note> / 1000.0) > <Init_Length>)
		startanim = 0.0
		blend = (<Init_Length> * 0.8)
		waittime = ((<time_to_next_note> / 1000.0) - <Init_Length>)
	else
		blend = (<time_to_next_note> / 1000.0)
		startanim = ((1 - ((<time_to_next_note> / 1000.0) / <Init_Length>)) * (<Init_Length> / <total_length>))
		waittime = 0.0
	endif
	if (<Wait_For_Idle> < <waittime>)
		Wait <Wait_For_Idle> seconds
		Obj_SpawnScriptNow fire_off_Idle params = {idletype = rest waittime = <Wait_For_Idle> LastBasePose = <LastBasePose> blend = <Idle_Blend_Time> gender = <gender> strumtype = <strumtype>}
		waittime = (<waittime> - <Wait_For_Idle>)
	endif
	Wait <waittime> seconds
	FormatText checksumname = baseanim '%a_%b_%c' a = <gender> b = <strumtype> c = <newbaseanim>
	FormatText checksumname = Strumanim '%a_%b_%c' a = <gender> b = <strumtype> c = <NewStrumanim>
	Anim_Command target = Dynamic_strums command = DegenerateBlend_AddBranch params = {
		BlendDuration = <blend>
		blendcurve = $Init_Blend_Curve
		Tree = $Dynamic_Strum_Branch
		params = {
			startanim = <startanim>
			baseanim = <baseanim>
			Strumanim = <Strumanim>
		}
	}
	<ObjID> :SetTags LastBasePose = <newbaseanim>
	<ObjID> :SetTags LastType = <type>
	<ObjID> :SetTags LastNoteValue = <noteValue>
endscript

script fire_off_Idle 
	if (<idletype> = rest)
		Idle = 'Strum_Idle_Rest'
	endif
	GetRandomFloat \{a = 0.0
		b = 1.0}
	startanim = <random_float>
	FormatText checksumname = Strumanim '%a_%b_%c' a = <gender> b = <strumtype> c = <Idle>
	FormatText checksumname = baseanim '%a_%b_%c' a = <gender> b = <strumtype> c = <LastBasePose>
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
