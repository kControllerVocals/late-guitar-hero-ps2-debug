guitar_hand_event_time_offset = -100

script watchforstartplaying_iterator 
	begin
	getsongtimems time_offset = <time_offset>
	if (<time> >= 0)
		wait \{1
			gameframe}
		bandmanager_endintroanims
		bandmanager_startallfacialanims
		return
	endif
	wait \{1
		gameframe}
	repeat
endscript

script faceoff_anim_iterator \{song_name = qs(0x7b277b30)
		difficulty = qs(0xe50976de)
		array_type = qs(0x13e59f9f)
		part = ''}
	if NOT gotparam \{player}

		return
	endif
	get_song_prefix song = <song_name>
	get_notetrack_part_text player_status = <player_status> song_name = <song_name>
	formattext checksumname = event_array '%s_%ifaceoff%p' s = <song_prefix> i = <part> p = <player_text> addtostringlookup
	array_entry = 0
	getarraysize $<event_array>
	if (<array_size> = 0)
		return
	endif
	getsongtimems time_offset = <time_offset>
	begin
	if ((<time> - <skipleadin>) < ($<event_array> [<array_entry>]) [0])
		break
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	array_size = (<array_size> - <array_entry>)
	if (<array_size> = 0)
		return
	endif
	if ($player1_status.part = vocals)
		is_singing = true
	else
		is_singing = false
	endif
	target = ($<player_status>.band_member)
	extendcrc <target> '_Info' out = info_struct
	change structurename = <info_struct> playing = false
	begin
	begin
	getsongtimems time_offset = <time_offset>
	if (<time> >= $<event_array> [<array_entry>] [0])
		break
	endif
	wait \{1
		gameframe}
	repeat
	change structurename = <info_struct> playing = true
	if (<is_singing> = true)
	else
		band_changefacialanims name = <target> ff_anims = facial_anims_female_rocker_rocking mf_anims = facial_anims_male_rocker_rocking
	endif
	play_time = ($<event_array> [<array_entry>] [1])
	stop_playing_time = (($<event_array> [<array_entry>] [0]) + ($<event_array> [<array_entry>] [1]))
	begin
	getsongtimems time_offset = <time_offset>
	if (<time> >= <stop_playing_time>)
		break
	endif
	wait \{1
		gameframe}
	repeat
	change structurename = <info_struct> playing = false
	if (<is_singing> = true)
	else
		band_changefacialanims name = <target> ff_anims = facial_anims_female_rocker mf_anims = facial_anims_male_rocker
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
endscript
0xee436ef5 = {
	anims = [
		gh_drum_tom_1
		gh_drum_tom_2
		gh_drum_snare
		gh_drum_cymbal_1
		gh_drum_cymbal_2
		gh_drum_cymbal_3
		gh_drum_cymbal_4
		gh_drum_kick
		gh_drum_cymbal_hh_open
		gh_drum_cymbal_hh_closed
	]
	hold_list = [
		gh_drum_cymbal_hh_closed
	]
}

script drumkit_anim_iterator 
	if ($game_mode = training || $game_mode = tutorial || $game_mode = practice)
		return
	endif
	if NOT 0xc9a8bb77
		return
	endif
	begin
	if 0xdad5ae43
		break
	endif
	waitonegameframe
	repeat
	0xea128d94
endscript
lars_drumkit_snare_ignore_songs = [
	orion
	dyerseve
	mercyfulfate
	thatwasjustyourlife
	theendoftheline
	brokenbeatandscarred
	thedaythatnevercomes
	allnightmarelong
	cyanide
	theunforgiveniii
	thejudaskiss
	0xbb6d772a
	0xfa7d3c82
	myapocalypse
]

script ignore_snare_for_lars_drumkit 
	if is_current_band_metallica
		getarraysize \{$lars_drumkit_snare_ignore_songs}
		index = 0
		begin
		if ($current_song = $lars_drumkit_snare_ignore_songs [<index>])
			return \{true}
			break
		endif
		index = (<index> + 1)
		repeat <array_size>
	endif
	return \{false}
endscript

script drumkit_input_playanim 
	if is_current_band_metallica
		if (<drum_index> = 1)
			return
		endif
	endif
	if ($game_mode = tutorial)
		return
	endif
	switch <drum_index>
		case 0
		anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [2]) blend_period = $drum_kit_blend_time}
		case 1
		anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [4]) blend_period = $drum_kit_blend_time}
		case 2
		anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [6]) blend_period = $drum_kit_blend_time}
		case 3
		anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [3]) blend_period = $drum_kit_blend_time}
		case 4
		anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [9]) blend_period = $drum_kit_blend_time}
	endswitch
endscript

script ae_drumkit_play_hihat 
	drummer :anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [5]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_snare 
endscript

script ae_drumkit_play_crash1 
	drummer :anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [8]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_crash2 
	drummer :anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [9]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_tom1 
	drummer :anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [3]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_tom2 
	drummer :anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [2]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_ride 
	drummer :anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [7]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_stop_crash1 
	drummer :anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [10]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_stop_crash2 
	drummer :anim_command target = drumkit command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [11]) blend_period = $drum_kit_blend_time}
endscript

script handle_strum_event 
	obj_getid
	0x0666218b id = <objid>
	obj_killspawnedscript \{name = hero_strum_guitar}
	obj_spawnscriptnow hero_strum_guitar params = {note_length = <note_length>}
endscript

script handle_missed_strum_event 
	obj_killspawnedscript \{name = hero_strum_guitar}
	obj_spawnscriptnow hero_strum_guitar params = {note_length = <note_length>}
endscript

script handle_start_playing 
	obj_getid
	extendcrc <objid> '_Info' out = info_struct
	if (<info_struct>.stance = intro || <info_struct>.stance = intro_smstg)
		handle_change_stance \{stance = stance_a}
	endif
endscript

script handle_fret_event 
	obj_getid
	0x0666218b id = <objid>
	handle_fret_event_cfunc note = <note>
endscript

script handle_finger_event 
	obj_getid
	0x0666218b id = <objid>
	hero_play_chord chord = <chord>
endscript

script handle_missed_note 
	obj_getid
	extendcrc <objid> '_Info' out = info_struct
	if ($<info_struct>.playing_missed_note = false)
		change structurename = <info_struct> playing_missed_note = true
	endif
endscript

script handle_hit_note 
	obj_getid
	handle_hit_note_cfunc
endscript

script handle_change_stance \{speed = 1.0}
	obj_getid
	0x0666218b id = <objid>
	extendcrc <objid> '_Info' out = info_struct
	display_debug_info = false
	if (should_display_debug_info)
		display_debug_info = true
	endif
	if gotparam \{no_wait}
		anim_set = ($<info_struct>.anim_set)
		old_stance = ($<info_struct>.stance)
		if play_stance_transition_cfunc anim_set = <anim_set> old_stance = <old_stance> new_stance = <stance>
			hero_play_anim anim = <anim_to_run> speed = <speed>
			hero_wait_until_anim_finished
		else
		endif
		change structurename = <info_struct> stance = <stance>
		change structurename = <info_struct> next_stance = <stance>
		if (<display_debug_info> = true)

		endif
		if (<objid> = guitarist || <objid> = bassist)
			if (<stance> = intro || <stance> = intro_smstg || <stance> = stance_frontend || <stance> = stance_frontend_guitar)
				change structurename = <info_struct> disable_arms = 2
				change structurename = <info_struct> next_anim_disable_arms = 2
			else
				change structurename = <info_struct> disable_arms = 0
				change structurename = <info_struct> next_anim_disable_arms = 0
			endif
			obj_switchscript \{guitarist_idle}
		else
			obj_switchscript \{bandmember_idle}
		endif
	else
		if (<display_debug_info> = true)

		endif
		change structurename = <info_struct> next_stance = <stance>
		if (<objid> = guitarist || <objid> = bassist)
			if (<stance> = intro || <stance> = intro_smstg || <stance> = stance_frontend || <stance> = stance_frontend_guitar)
				change structurename = <info_struct> next_anim_disable_arms = 2
			else
				change structurename = <info_struct> next_anim_disable_arms = 0
			endif
		endif
	endif
	return
endscript

script queue_change_stance 
	obj_getid
	extendcrc <objid> '_Info' out = info_struct
	change structurename = <info_struct> next_stance = <stance>
endscript

script handle_play_anim \{blend_time = 0.2}
	obj_getid
	0x0666218b id = <objid>
	extendcrc <objid> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	stance = ($<info_struct>.stance)
	display_debug_info = false
	if (should_display_debug_info)
		display_debug_info = true
	endif
	if gotparam \{no_wait}
		if (<display_debug_info> = true)

		endif
		change structurename = <info_struct> current_anim = <anim>
		change structurename = <info_struct> next_anim = none
		if gotparam \{repeat_count}
			change structurename = <info_struct> anim_repeat_count = <repeat_count>
		else
			change structurename = <info_struct> anim_repeat_count = 1
		endif
		if gotparam \{cycle}
			change structurename = <info_struct> cycle_anim = true
		else
			change structurename = <info_struct> cycle_anim = false
		endif
		if (<name> = guitarist || <name> = bassist)
			if gotparam \{disable_auto_arms}
				change structurename = <info_struct> disable_arms = 2
			elseif gotparam \{disable_auto_strum}
				change structurename = <info_struct> disable_arms = 1
			else
				change structurename = <info_struct> disable_arms = 0
			endif
		endif
		obj_killspawnedscript \{name = hero_play_adjusting_random_anims}
		obj_spawnscriptnow hero_play_adjusting_random_anims params = {anim = <anim> blend_time = <blend_time>}
	else
		if (<display_debug_info> = true)
			if (<info_struct>.next_anim != none)

			else

			endif
		endif
		change structurename = <info_struct> next_anim = <anim>
		if gotparam \{repeat_count}
			change structurename = <info_struct> next_anim_repeat_count = <repeat_count>
		else
			change structurename = <info_struct> next_anim_repeat_count = 1
		endif
		if gotparam \{cycle}
			change structurename = <info_struct> cycle_next_anim = true
		else
			change structurename = <info_struct> cycle_next_anim = false
		endif
		if (<name> = guitarist || <name> = bassist)
			if gotparam \{disable_auto_arms}
				change structurename = <info_struct> next_anim_disable_arms = 2
			elseif gotparam \{disable_auto_strum}
				change structurename = <info_struct> next_anim_disable_arms = 1
			else
				change structurename = <info_struct> next_anim_disable_arms = 0
			endif
		endif
	endif
endscript

script output_camera_sync_warnings 


	get_song_prefix song = ($current_song)
	formattext checksumname = event_array '%s_cameras_notes' s = <song_prefix> addtostringlookup
	sync_cameras_to_performance song_name = ($current_song) camera_array = <event_array> output_results = 1
endscript

script print_camera_sync_warning 
	if NOT gotparam \{output_results}
		return
	endif
	if (<output_results> = 1)
		textoutput text = <warning>
	endif

endscript

script show_playclip_time 
	if (<playclip_time_displayed> = 1)
		return
	endif
	if (<end_frame> = -1)
		formattext textname = warning qs(0x7ed36967) a = <next_anim_time>
	else
		length_in_frames = (<end_frame> - <start_frame>)
		formattext textname = warning qs(0x73ea14fe) a = <next_anim_time> b = <start_frame> c = <end_frame> d = <length_in_frames>
	endif
	print_camera_sync_warning <...>
	return \{playclip_time_displayed = 1}
endscript

script show_camera_warnings_found 
	if (<warnings> = 0)
		text = qs(0x383ac615)
		if (<output_results> = 1)
			textoutput text = <text>
		endif

	endif
endscript

script sync_cameras_to_performance \{output_results = 0}
endscript

script check_for_short_anims_in_clip 
	if NOT globalexists name = <clip> type = structure
		return
	endif
	if NOT structurecontains structure = $<clip> name = anims
		return
	endif
	found_problem = false
	check_anim_length clip = <clip> name = guitarist endtime = <endtime> <...>
	check_anim_length clip = <clip> name = bassist endtime = <endtime> <...>
	check_anim_length clip = <clip> name = vocalist endtime = <endtime> <...>
	check_anim_length clip = <clip> name = drummer endtime = <endtime> <...>
	if (<found_problem> = true)
		return \{true}
	endif
	return \{false}
endscript

script check_anim_length 
	if structurecontains structure = ($<clip>.anims) name = <name>
		anim = ($<clip>.anims.<name>)
		if anim_animexists anim = <anim>
			anim_getanimlength anim = <anim>
			if (<length> < <endtime>)
				show_playclip_time {
					output_results = <output_results>
					playclip_time_displayed = <playclip_time_displayed>
					start_frame = <start_frame>
					end_frame = <end_frame>
					next_anim_time = <next_anim_time>
				}
				formattext textname = warning qs(0xd2acb46c) a = <anim> b = <length> c = <endtime>
				print_camera_sync_warning warning = <warning> output_results = <output_results>
				found_problem = true
			endif
		endif
	endif
	return found_problem = <found_problem>
endscript
