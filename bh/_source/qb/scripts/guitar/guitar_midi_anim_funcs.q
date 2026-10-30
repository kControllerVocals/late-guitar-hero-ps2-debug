
script transition_playsimpleanim 
	band_playsimpleanim <...>
	bandmanager_setplayingintroanims name = <name>
endscript

script play_facial_anim_on_character \{name = guitarist}
	if compositeobjectexists name = <name>
		<name> :obj_killspawnedscript name = play_special_facial_anim
		<name> :obj_spawnscriptnow play_special_facial_anim params = {anim = <anim>}
	endif
endscript

script band_playfacialanim \{name = guitarist}
	gamemode_gettype
	switch <type>
		case training
		case practice
		case tutorial
		return \{false}
	endswitch
	if gotparam \{name}
		get_musician_id name = <name>
		play_facial_anim_on_character name = <name> anim = <anim>
		if (<name> = vocalist)
			play_facial_anim_on_character name = vocalist2 anim = <anim>
		endif
	elseif gotparam \{part}
		if ($guitarist_info.part = <part>)
			play_facial_anim_on_character name = guitarist anim = <anim>
		endif
		if ($bassist_info.part = <part>)
			play_facial_anim_on_character name = bassist anim = <anim>
		endif
		if ($vocalist_info.part = <part>)
			play_facial_anim_on_character name = vocalist anim = <anim>
		endif
		if ($drummer_info.part = <part>)
			play_facial_anim_on_character name = drummer anim = <anim>
		endif
	endif
endscript

script band_playrockinfacialanim \{name = guitarist}
	get_musician_id name = <name>
	if compositeobjectexists name = <name>
		<name> :obj_killspawnedscript name = play_special_facial_anim
		if band_isfemale name = <name>

			<name> :obj_spawnscriptnow play_special_facial_anim params = {anim = gh_rocker_female_hardrockface_4}
		else

			<name> :obj_spawnscriptnow play_special_facial_anim params = {anim = gh_rocker_male_hardrockface_4}
		endif
	endif
endscript

script band_changefacialanims \{name = guitarist
		blend_duration = 0.3}
	get_musician_id name = <name>

	if compositeobjectexists name = <name>

		extendcrc <name> '_Info' out = info_struct
		if ((gotparam ff_anims) || (gotparam mf_anims))
			if band_isfemale name = <name>
				if gotparam \{ff_anims}

					change structurename = <info_struct> facial_anims = <ff_anims>
				endif
			else
				if gotparam \{mf_anims}

					change structurename = <info_struct> facial_anims = <mf_anims>
				endif
			endif
		else
			fa_default = ($<info_struct>.facial_anims_default)
			if gotparam \{fa_type}
				extendcrc <fa_default> <fa_type> out = fa_anims

			else
				fa_anims = <fa_default>
			endif
			change structurename = <info_struct> facial_anims = <fa_anims>
		endif
		<name> :obj_killspawnedscript name = play_special_facial_anim
		<name> :obj_killspawnedscript name = facial_anim_loop
		<name> :obj_spawnscriptnow facial_anim_loop params = {blend_duration = <blend_duration>}
	else

	endif
endscript

script ae_changefacialanims \{blend_duration = 0.3}
	obj_getid
	if NOT ((gotparam ff_anims) || (gotparam mf_anims) || (gotparam fa_type))

	endif
	band_changefacialanims name = <objid> blend_duration = <blend_duration> <...>
endscript

script band_stopstrumming \{name = guitarist}
	band_setstrumstyle name = <name> male_type = none female_type = none
endscript

script band_enableautostrums 
	band_enableautostrums_cfunc name = <name>
endscript

script band_disableautostrums 
	band_disableautostrums_cfunc name = <name>
endscript

script band_enableautofret 
	band_enableautofret_cfunc name = <name>
endscript

script band_disableautofret 
	band_disableautofret_cfunc name = <name>
endscript

script band_enableautochords 
	band_enableautochords_cfunc name = <name>
endscript

script band_disableautochords 
	band_disableautochords_cfunc name = <name>
endscript

script band_setikchain 
	if (<chain> = guitar)
		band_setikchaintarget name = <name> index = 0 target = bone_ik_hand_guitar_r
		band_setikchaintarget name = <name> index = 1 target = bone_ik_hand_guitar_l
		band_enableautofret name = <name>
		band_enableautochords name = <name>
		band_enableautostrums name = <name>
		bandmanager_setikchainstrength name = <name> chain = bone_ik_hand_guitar_l strength = 1
		bandmanager_setikchainstrength name = <name> chain = bone_ik_hand_guitar_r strength = 1
	elseif (<chain> = slave)
		band_setikchaintarget name = <name> index = 0 target = bone_ik_hand_slave_r
		band_setikchaintarget name = <name> index = 1 target = bone_ik_hand_slave_l
		band_disableautofret name = <name>
		band_disableautochords name = <name>
		band_disableautostrums name = <name>
		bandmanager_setikchainstrength name = <name> chain = bone_ik_hand_slave_l strength = 1
		bandmanager_setikchainstrength name = <name> chain = bone_ik_hand_slave_r strength = 1
	elseif (<chain> = fk)
		bandmanager_setikchainstrength name = <name> chain = bone_ik_hand_guitar_l strength = 0
		bandmanager_setikchainstrength name = <name> chain = bone_ik_hand_guitar_r strength = 0
		bandmanager_setikchainstrength name = <name> chain = bone_ik_hand_slave_l strength = 0
		bandmanager_setikchainstrength name = <name> chain = bone_ik_hand_slave_r strength = 0
	else
		band_setikchaintarget name = <name> index = 0 target = bone_ik_hand_slave_r
		band_setikchaintarget name = <name> index = 1 target = bone_ik_hand_slave_l
		band_disableautofret name = <name>
		band_disableautochords name = <name>
		band_disableautostrums name = <name>
	endif
endscript

script ae_setik_guitarl_off 
	obj_getid
	band_disableautochords name = <objid>
endscript

script ae_setik_guitarr_off 
	obj_getid
	band_disableautostrums name = <objid>
endscript

script ae_setik_slavel_off 
endscript

script ae_setik_slaver_off 
endscript

script ae_setik_guitarl_on 
	obj_getid
	band_setikchaintarget name = <objid> index = 1 target = bone_ik_hand_guitar_l blendduration = 0.3
	band_enableautochords name = <objid>
endscript

script ae_setik_guitarr_on 
	obj_getid
	band_setikchaintarget name = <objid> index = 0 target = bone_ik_hand_guitar_r blendduration = 0.3
	band_enableautostrums name = <objid>
endscript

script ae_setik_slavel_on 
	obj_getid
	band_setikchaintarget name = <objid> index = 1 target = bone_ik_hand_slave_l blendduration = 0.3
	band_disableautochords name = <objid>
endscript

script ae_setik_slaver_on 
	obj_getid
	band_setikchaintarget name = <objid> index = 0 target = bone_ik_hand_slave_r blendduration = 0.3
	band_disableautostrums name = <objid>
endscript

script ae_setik_guitarl_on_stranglehold 
	obj_getid
	band_setikchaintarget name = <objid> index = 1 target = bone_ik_hand_guitar_l blendduration = 0.3
endscript

script ae_setik_guitarr_on_stranglehold 
	obj_getid
	band_setikchaintarget name = <objid> index = 0 target = bone_ik_hand_guitar_r blendduration = 0.3
endscript

script ae_setik_slavel_on_stranglehold 
	obj_getid
	band_setikchaintarget name = <objid> index = 1 target = bone_ik_hand_slave_l blendduration = 0.3
endscript

script ae_setik_slaver_on_stranglehold 
	obj_getid
	band_setikchaintarget name = <objid> index = 0 target = bone_ik_hand_slave_r blendduration = 0.3
endscript

script ae_setik_slaves_on_jimi 
	if ($game_mode = p2_pro_faceoff)
		obj_getid
		band_setikchaintarget name = <objid> index = 0 target = bone_ik_hand_slave_r blendduration = 0
		band_setikchaintarget name = <objid> index = 1 target = bone_ik_hand_slave_l blendduration = 0
	endif
endscript

script ae_setik_to_fk_l 
	obj_getid
	bandmanager_setikchainstrength name = <objid> chain = bone_ik_hand_guitar_l strength = 0
	bandmanager_setikchainstrength name = <objid> chain = bone_ik_hand_slave_l strength = 0
endscript

script ae_setik_to_fk_r 
	obj_getid
	bandmanager_setikchainstrength name = <objid> chain = bone_ik_hand_guitar_r strength = 0
	bandmanager_setikchainstrength name = <objid> chain = bone_ik_hand_slave_r strength = 0
endscript

script ae_setik_to_ik_l 
	obj_getid
	bandmanager_setikchainstrength name = <objid> chain = bone_ik_hand_guitar_l strength = 1
	bandmanager_setikchainstrength name = <objid> chain = bone_ik_hand_slave_l strength = 1
endscript

script ae_setik_to_ik_r 
	obj_getid
	bandmanager_setikchainstrength name = <objid> chain = bone_ik_hand_guitar_r strength = 1
	bandmanager_setikchainstrength name = <objid> chain = bone_ik_hand_slave_r strength = 1
endscript

script ae_disableautofret 
	obj_getid
	band_disableautofret name = <objid>
endscript

script ae_enableautofret 
	obj_getid
	band_enableautofret name = <objid>
endscript

script ae_disableautostrums 
	obj_getid
	band_disableautostrums name = <objid>
endscript

script ae_enableautostrums 
	obj_getid
	band_enableautostrums name = <objid>
endscript

script ae_disableautochords 
	obj_getid
	band_disableautochords name = <objid>
endscript

script ae_enableautochords 
	obj_getid
	band_enableautochords name = <objid>
endscript

script ik_fk_switch_override 
	gman_songtool_getcurrentsong
	if (<current_song> = bandontherun)
		return
	endif
	ae_setik_slaver_on
endscript

script band_setikchaintarget \{blendduration = 0.0}
	band_setikchaintarget_cfunc name = <name> target = <target> index = <index> blendduration = <blendduration>
endscript

script band_movetonode \{allow_in_2player = false}
	band_movetonode_cfunc allow_in_2player = <allow_in_2player> name = <name> node = <node>
endscript

script band_movetostartnode \{allow_in_2player = false}
	band_movetostartnode_cfunc name = <name> allow_in_2player = <allow_in_2player>
endscript

script band_restartidles 
	bandmanager_playidle \{name = guitarist
		all_modes = true
		restart}
	bandmanager_playidle \{name = bassist
		all_modes = true
		restart}
	bandmanager_playidle \{name = vocalist
		all_modes = true
		restart}
	bandmanager_playidle \{name = drummer
		all_modes = true
		restart}
endscript

script band_playtransitionidles \{from_restart = false}

	gman_songtool_getcurrentsong
	band_builder_get_band_global song = <current_song>
	wait \{2
		gameframes}
	bandmanager_turnoffallarmanims
	wait \{1
		gameframes}
	bandmanager_setplayingintroanims
endscript

script bandmanager_turnoffarmanims 
	band_disableautostrums name = <name>
	band_disableautofret name = <name>
	band_disableautochords name = <name>
endscript

script bandmanager_turnoffallarmanims 
	bandmanager_turnoffarmanims \{name = guitarist}
	bandmanager_turnoffarmanims \{name = guitarist2}
	bandmanager_turnoffarmanims \{name = bassist}
	bandmanager_turnoffarmanims \{name = bassist2}
	bandmanager_turnoffarmanims \{name = vocalist}
	bandmanager_turnoffarmanims \{name = vocalist2}
	band_setdrumkitstate \{name = drummer
		state = off}
	band_setdrumkitstate \{name = drummer2
		state = off}
endscript

script bandmanager_turnonarmanims 
	band_enableautostrums name = <name>
	band_enableautofret name = <name>
	band_enableautochords name = <name>
endscript

script bandmanager_turnonallarmanims 
	bandmanager_turnonarmanims \{name = guitarist}
	bandmanager_turnonarmanims \{name = guitarist2}
	bandmanager_turnonarmanims \{name = bassist}
	bandmanager_turnonarmanims \{name = bassist2}
	bandmanager_turnonarmanims \{name = vocalist}
	bandmanager_turnonarmanims \{name = vocalist2}
	band_setdrumkitstate \{name = drummer
		state = on}
	band_setdrumkitstate \{name = drummer2
		state = on}
endscript

script band_setarmanimstrength 
	band_setarmanimstrength_cfunc name = <name> target = <target> strength = <strength>
endscript

script band_setdrumkitstate 
	if ($test_four_guitarists = true || $test_four_vocalists = true)
		return
	endif
	if compositeobjectexists name = <name>
		if (<state> = on)
		else
		endif
	endif
endscript

script band_playidle 
	bandmanager_playidle <...>
endscript

script band_playloop 
	override_anim = none
	if band_isfemale name = <name>
		if gotparam \{female}
			override_anim = <female>
		endif
	else
		if gotparam \{male}
			override_anim = <male>
		endif
	endif
	getplayerinfo \{1
		current_song_beat_time}
	if NOT (<current_song_beat_time> = 0)
		new_tempo = ((1000.0 / <current_song_beat_time>) * 60.0)
		change tempo_for_anims = <new_tempo>
	else

	endif
	bandmanager_setoverrideloop name = <name> anim = <override_anim>
	bandmanager_restartloop name = <name>
endscript

script band_playclip \{startframe = 0.0
		override_intro = true}
	if NOT gotparam \{allgamemodes}
		if ($game_mode = p2_pro_faceoff)
			return
		endif
	endif
	if NOT should_play_moments
		return
	endif
	if NOT globalexists name = <clip> type = structure

		return
	endif
	clip_get_time_and_frame
	getsongtimems
	casttointeger \{time}
	if structurecontains structure = $<clip> dataformat
		band_playclip_new_cfunc
		newclipformat = true
	else
		band_playclip_cfunc
		newclipformat = false
	endif
	increase_band_bounding_spheres
	if (<newclipformat> = true)
		band_playclip_finish_new_cfunc
	else
		band_playclip_finish_cfunc
	endif

endscript

script 0xa93a70af \{startframe = 0.0
		override_intro = true}
	if NOT gotparam \{allgamemodes}
		if ($game_mode = p2_pro_faceoff)
			return
		endif
	endif
	if NOT should_play_moments
		return
	endif
	clip_get_time_and_frame
	getsongtimems \{time_offset = $time_gem_offset_with_lag}
	casttointeger \{time}
	if structurecontains structure = $<clip> dataformat
		band_playclip_new_cfunc
		newclipformat = true
	else
		band_playclip_cfunc
		newclipformat = false
	endif
	increase_band_bounding_spheres
endscript

script increase_band_bounding_spheres 
	if compositeobjectexists \{name = drummer}
		drummer :obj_setboundingsphere \{10}
	endif
	if compositeobjectexists \{name = vocalist}
		vocalist :obj_setboundingsphere \{10}
	endif
	return
	if compositeobjectexists \{name = musician1}
		musician1 :obj_setboundingsphere \{10}
	endif
	if compositeobjectexists \{name = musician2}
		musician2 :obj_setboundingsphere \{10}
	endif
	if compositeobjectexists \{name = musician3}
		musician3 :obj_setboundingsphere \{10}
	endif
	if compositeobjectexists \{name = musician4}
		musician4 :obj_setboundingsphere \{10}
	endif
endscript

script band_forcetoidle \{all_modes = false}
	if gotparam \{name}
		if compositeobjectexists name = <name>
			bandmanager_changeik name = <name> enabled = true
			bandmanager_playidle name = <name> blendduration = 0.0 all_modes = <all_modes>
		endif
	endif
endscript

script band_forcealltoidle \{all_modes = false}
	band_forcetoidle name = guitarist all_modes = <all_modes> <...>
	band_forcetoidle name = bassist all_modes = <all_modes> <...>
	band_forcetoidle name = vocalist all_modes = <all_modes> <...>
	band_forcetoidle name = drummer all_modes = <all_modes> <...>
endscript

script band_movealltostartnodes 
	band_movetostartnode \{name = guitarist}
	band_movetostartnode \{name = bassist}
	band_movetostartnode \{name = vocalist}
	band_movetostartnode \{name = drummer}
endscript
tempo_for_anims = -1
tempo_for_drum_anims = -1

script band_setanimtempo 
	change tempo_for_anims = <tempo>
	if ($tempo_for_drum_anims = -1)
		change tempo_for_drum_anims = <tempo>
	endif
endscript

script band_setdrumanimtempo 
	change tempo_for_drum_anims = <tempo>
endscript

script band_clearanimtempo 
	change \{tempo_for_anims = -1}
	change \{tempo_for_drum_anims = -1}
endscript

script band_isfemale 
	if NOT gotparam \{name}

		return
	endif
	if NOT compositeobjectexists name = <name>

		return
	endif
	<name> :getsingletag is_female
	if (<is_female> = 1)
		return \{true}
	else
		return \{false}
	endif
endscript

script clip_get_time_and_frame 
	getsongtimems \{time_offset = $time_gem_offset_with_lag}
	seconds = (<time> / 1000.0)
	if (<seconds> < 0)
		seconds = 0
	endif
	minutes = (<seconds> / 60.0)
	casttointeger \{minutes}
	seconds = (<seconds> - (<minutes> * 60))
	seconds_float = <seconds>
	casttointeger \{seconds}
	fps = 30
	fraction_of_second = (<seconds_float> - <seconds>)
	frame = (<fraction_of_second> * <fps>)
	casttointeger \{frame}
	if (<seconds> < 10)
		if (<frame> < 10)
			formattext textname = time_string qs(0x593819d8) a = <minutes> b = <seconds> c = <frame> d = <time>
		else
			formattext textname = time_string qs(0xac471e75) a = <minutes> b = <seconds> c = <frame> d = <time>
		endif
	else
		if (<frame> < 10)
			formattext textname = time_string qs(0x31aec87f) a = <minutes> b = <seconds> c = <frame> d = <time>
		else
			formattext textname = time_string qs(0xcacc8b50) a = <minutes> b = <seconds> c = <frame> d = <time>
		endif
	endif
	formattext textname = time_string qs(0x67b7904f) a = <minutes> b = <seconds> c = <frame> d = <time>
	return time_string = <time_string>
endscript

script band_showmic \{name = guitarist}
	if NOT should_play_moments
		return
	endif
	if ($game_mode = p2_pro_faceoff)
		return
	endif
	if NOT compositeobjectexists name = <name>
		return
	endif
	if ($cheat_airinstruments != 1)
		<name> :show_mic
	endif
endscript

script band_hidemic \{name = guitarist}
	if NOT should_play_moments
		return
	endif
	get_musician_id name = <name>
	if NOT compositeobjectexists name = <name>
		return
	endif
	<name> :hide_mic
endscript

script band_showmic_stand \{name = guitarist}
	if NOT should_play_moments
		return
	endif
	if ($game_mode = p2_pro_faceoff)
		return
	endif
	if NOT compositeobjectexists name = <name>
		return
	endif
	if ($cheat_airinstruments != 1)
		<name> :show_mic_stand
	endif
endscript

script band_hidemic_stand \{name = guitarist}
	if NOT should_play_moments
		return
	endif
	if NOT compositeobjectexists name = <name>
		return
	endif
	<name> :hide_mic_stand
endscript

script band_showmic_microphone \{name = guitarist}
	if NOT should_play_moments
		return
	endif
	if ($game_mode = p2_pro_faceoff)
		return
	endif
	if NOT compositeobjectexists name = <name>
		return
	endif
	if ($cheat_airinstruments != 1)
		<name> :show_mic_microphone
	endif
endscript

script band_hidemic_microphone \{name = guitarist}
	if NOT should_play_moments
		return
	endif
	if NOT compositeobjectexists name = <name>
		return
	endif
	<name> :hide_mic_microphone
endscript

script band_showdrumkit \{name = drummer}
	if NOT compositeobjectexists name = <name>
		return
	endif
	if ($cheat_airinstruments != 1)
		<name> :show_drumkit
	endif
endscript

script band_hidedrumkit \{name = drummer}
	if NOT compositeobjectexists name = <name>
		return
	endif
	<name> :hide_drumkit
endscript

script band_hide 
	if compositeobjectexists name = <name>
		<name> :hide
	endif
	bandmanager_hidestrings name = <name>
endscript

script band_unhide 
	if compositeobjectexists name = <name>
		if ($cheat_invisiblecharacters != 1)
			<name> :unhide
		endif
	endif
	if ($cheat_airinstruments != 1)
		bandmanager_showstrings name = <name>
	endif
endscript
enable_guitarist_camera_swapping = false

script band_enableguitaristcameraswapping 
	change \{enable_guitarist_camera_swapping = true}
endscript

script band_disableguitaristcameraswapping 
	change \{enable_guitarist_camera_swapping = false}
endscript

script transition_changeik 
	bandmanager_changeik <...>
endscript

script bandmanager_stopfacialanims 
	<name> :obj_killspawnedscript name = play_special_facial_anim
	<name> :obj_killspawnedscript name = facial_anim_loop
	<name> :hero_clear_facial_anim
endscript

script bandmanager_startfacialanims 
	if NOT compositeobjectexists name = <name>
		return
	endif
	<name> :obj_killspawnedscript name = play_special_facial_anim
	<name> :obj_killspawnedscript name = facial_anim_loop
	<name> :obj_spawnscriptnow facial_anim_loop
endscript

script bandmanager_startallfacialanims 
	bandmanager_startfacialanims \{name = guitarist}
	bandmanager_startfacialanims \{name = guitarist2}
	bandmanager_startfacialanims \{name = bassist}
	bandmanager_startfacialanims \{name = bassist2}
	bandmanager_startfacialanims \{name = vocalist}
	bandmanager_startfacialanims \{name = vocalist2}
	bandmanager_startfacialanims \{name = drummer}
	bandmanager_startfacialanims \{name = drummer2}
endscript

script bandmanager_airguitarcheat 
	if ($cheat_airinstruments = 1)
		bandmanager_hideallinstruments
	else
		bandmanager_unhideallinstruments
	endif
endscript

script bandmanager_invisiblecharacterscheat 
	if ($cheat_invisiblecharacters = 1)
		bandmanager_hideallmusicians
	else
		bandmanager_unhideallmusicians
	endif
endscript

script bandmanager_hideinstrument 
	if compositeobjectexists <name>
		<name> :hideinstrument
		bandmanager_hidestrings name = <name>
	endif
endscript

script bandmanager_unhideinstrument 
	if compositeobjectexists <name>
		<name> :unhideinstrument
		bandmanager_showstrings name = <name>
	endif
endscript

script bandmanager_hideallinstruments 
	bandmanager_hideinstrument \{name = guitarist}
	bandmanager_hideinstrument \{name = guitarist2}
	bandmanager_hideinstrument \{name = bassist}
	bandmanager_hideinstrument \{name = bassist2}
	bandmanager_hideinstrument \{name = vocalist}
	bandmanager_hideinstrument \{name = vocalist2}
	bandmanager_hideinstrument \{name = drummer}
	bandmanager_hideinstrument \{name = drummer2}
endscript

script bandmanager_unhideallinstruments 
	bandmanager_unhideinstrument \{name = guitarist}
	bandmanager_unhideinstrument \{name = guitarist2}
	bandmanager_unhideinstrument \{name = bassist}
	bandmanager_unhideinstrument \{name = bassist2}
	bandmanager_unhideinstrument \{name = vocalist}
	bandmanager_unhideinstrument \{name = vocalist2}
	bandmanager_unhideinstrument \{name = drummer}
	bandmanager_unhideinstrument \{name = drummer2}
endscript

script bandmanager_hidemusician 
	if compositeobjectexists <name>
		<name> :hidemusician
	endif
endscript

script bandmanager_unhidemusician 
	if compositeobjectexists <name>
		<name> :unhide
	endif
endscript

script bandmanager_hideallmusicians 
	bandmanager_hidemusician \{name = guitarist}
	bandmanager_hidemusician \{name = guitarist2}
	bandmanager_hidemusician \{name = bassist}
	bandmanager_hidemusician \{name = bassist2}
	bandmanager_hidemusician \{name = vocalist}
	bandmanager_hidemusician \{name = vocalist2}
	bandmanager_hidemusician \{name = drummer}
	bandmanager_hidemusician \{name = drummer2}
endscript

script bandmanager_unhideallmusicians 
	bandmanager_unhidemusician \{name = guitarist}
	bandmanager_unhidemusician \{name = guitarist2}
	bandmanager_unhidemusician \{name = bassist}
	bandmanager_unhidemusician \{name = bassist2}
	bandmanager_unhidemusician \{name = vocalist}
	bandmanager_unhidemusician \{name = vocalist2}
	bandmanager_unhidemusician \{name = drummer}
	bandmanager_unhidemusician \{name = drummer2}
endscript

script get_musician_id 
	switch <name>
		case guitarist
		case bassist
		case vocalist
		case drummer
		if compositeobjectexists name = <name>
			<name> :obj_getid
			name = <objid>
		endif
	endswitch
	return name = <name>
endscript

script should_play_moments 
	gman_songtool_getcurrentsong
	get_band_configuration song = <current_song>
	if (<band> = default_band)
		return \{true}
	else
		gamemode_gettype
		if (<type> = career)
			return \{true}
		else
			return \{false}
		endif
	endif
endscript
