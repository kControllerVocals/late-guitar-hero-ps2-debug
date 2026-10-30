
script skate8_sfx_backgrounds_new_area \{immediate = 0
		loading_transition = 0
		restarting = 0}

	change sfx_background_last_area = <bg_sfx_area>
	if (<immediate> = 0)
		waitonegameframe
	endif
	change sfx_background_requested_area = <bg_sfx_area>
	check_for_specific_bgs_in_struct
	spawnscriptnow skate8_sfx_background_play params = {loading_transition = <loading_transition> restarting = <restarting>}
endscript

script skate8_sfx_request_background_area_change 
	change sfx_background_requested_area = <bg_sfx_area>
endscript
sfx_background_last_area = `default`
sfx_background_requested_area = `default`
sfx_background_requested_checksum = `default`
sfx_background_requested_volume = 60
sfx_background_current_area = `default`
sfx_background_current_checksum = `default`
sfx_background_current_volume = 100
sfx_background_previous_area = `default`
sfx_background_previous_checksum = `default`
sfx_background_fadein_area = `default`
sfx_background_fadein_checksum = `default`
sfx_background_fadein_volume_start = 1.0
sfx_background_fadein_volume_target = 100.0
sfx_background_fadein_volume_current = 1.0
sfx_background_fadein_volume_add = 3.0
sfx_background_fadingout_area = `default`
sfx_background_fadingout_checksum = `default`
sfx_background_fadeout_volume_start = 100.0
sfx_background_fadeout_volume_target = 0.0
sfx_background_fadeout_volume_current = 100.0
sfx_background_fadeout_volume_subtract = 3.0
sfx_background_crossfade_time = 0.75
background_crossfade_gameframes = 90
backgrounds_master_volume = 20.0
0xfbaf57a3 = 1.0
pleasedocrossfade = 1
sfx_background_is_crossfading = false
currentlyplayingoneshotsoundevent = donothing_oneshot
currentoneshotwaittime = 15

script check_for_specific_bgs_in_struct 
	setspawninstancelimits \{max = 1
		management = kill_oldest}
	local_var_struct = ($sfx_background_requested_area)
	if structurecontains structure = $skate8_sfx_background_areas_and_states <local_var_struct>
		check_for_tod_bgs_in_struct <...>
	else
	endif
endscript

script check_for_tod_bgs_in_struct 
	<current_time> = day
	this_current_tod_name = <current_time>
	if structurecontains structure = ($skate8_sfx_background_areas_and_states.<local_var_struct>) <this_current_tod_name>
		change sfx_background_requested_checksum = ($skate8_sfx_background_areas_and_states.<local_var_struct>.<this_current_tod_name>)
	else
		if structurecontains structure = ($skate8_sfx_background_areas_and_states.<local_var_struct>) afternoon
			change sfx_background_requested_checksum = ($skate8_sfx_background_areas_and_states.<local_var_struct>.afternoon)
		else
			if structurecontains structure = ($skate8_sfx_background_areas_and_states.<local_var_struct>) `default`
				change sfx_background_requested_checksum = ($skate8_sfx_background_areas_and_states.<local_var_struct>.`default`)
			else
			endif
		endif
	endif
endscript

script skate8_sfx_background_play \{crossfadetime = 0.7
		newvolumepercent = 100
		loading_transition = 0
		restarting = 0}
	setspawninstancelimits \{max = 1
		management = kill_oldest}
	wait \{2
		gameframes}
	if ($sfx_background_is_crossfading = true)
		if NOT issoundplaying \{$sfx_background_fadein_checksum}
			change \{sfx_background_fadein_checksum = none}
		endif
		if ($sfx_background_requested_checksum = ($sfx_background_fadein_checksum))
		else
			if ($sfx_background_requested_checksum = ($sfx_background_fadingout_checksum))
				if ($backgroundsfxdebugprinttoscreen = 1)
					formattext textname = my_text qs(0xc87eafca) n = ($sfx_background_fadingout_checksum) dontassertforchecksums
					create_panel_message {text = <my_text>
						pos = (30.0, 380.0)
						rgba = [144 32 32 100]
						font_face = text_a1
						time = 180000
						just = [left left]
						id = sfx_bg_panel_message
					}
				endif
				skate8_sfx_reverse_background_fading
			else
				skate8_sfx_quick_dip
				if ($backgroundsfxdebugprinttoscreen = 1)
					formattext textname = my_text qs(0xc87eafca) n = ($sfx_background_requested_checksum) dontassertforchecksums
					create_panel_message {text = <my_text>
						pos = (30.0, 380.0)
						rgba = [144 32 32 100]
						font_face = text_a1
						time = 180000
						just = [left left]
						id = sfx_bg_panel_message
					}
				endif
				spawnscriptnow \{skate8_sfx_change_background}
			endif
		endif
	else
		if NOT issoundplaying \{$sfx_background_current_checksum}
			change \{sfx_background_current_checksum = none}
		endif
		if ($sfx_background_requested_checksum = $sfx_background_current_checksum)
		else
			if ($backgroundsfxdebugprinttoscreen = 1)
				formattext textname = my_text qs(0xc87eafca) n = ($sfx_background_requested_checksum) dontassertforchecksums
				create_panel_message {text = <my_text>
					pos = (30.0, 380.0)
					rgba = [144 32 32 100]
					font_face = text_a1
					time = 180000
					just = [left left]
					id = sfx_bg_panel_message
				}
			endif
			spawnscriptnow \{skate8_sfx_change_background}
		endif
	endif
endscript

script skate8_sfx_change_background 
	setspawninstancelimits \{max = 1
		management = kill_oldest}
	change \{sfx_background_is_crossfading = true}
	change sfx_background_fadein_area = ($sfx_background_requested_area)
	change sfx_background_fadein_checksum = ($sfx_background_requested_checksum)
	change sfx_background_fadingout_area = ($sfx_background_current_area)
	change sfx_background_fadingout_checksum = ($sfx_background_current_checksum)
	local_var_struct_fadein_area = ($sfx_background_fadein_area)
	local_var_struct_fadein_checksum = ($sfx_background_fadein_checksum)
	local_var_struct_fadeout_area = ($sfx_background_fadingout_area)
	local_var_struct_fadeout_checksum = ($sfx_background_fadingout_checksum)
	if NOT (gotparam overide_crossfade_time)
		change \{sfx_background_crossfade_time = 0.75}
		if structurecontains structure = ($skate8_sfx_background_areas_and_states.<local_var_struct_fadein_area>) fade_from
			if structurecontains structure = ($skate8_sfx_background_areas_and_states.<local_var_struct_fadein_area>.fade_from) <local_var_struct_fadeout_area>
				change sfx_background_crossfade_time = ($skate8_sfx_background_areas_and_states.<local_var_struct_fadein_area>.fade_from.<local_var_struct_fadeout_area>)
			endif
		endif
	else
		change sfx_background_crossfade_time = <overide_crossfade_time>
	endif
	change \{sfx_background_fadein_volume_target = 100}
	if structurecontains structure = ($skate8_sfx_background_areas_and_states.<local_var_struct_fadein_area>) volume_params
		if structurecontains structure = ($skate8_sfx_background_areas_and_states.<local_var_struct_fadein_area>.volume_params) <local_var_struct_fadein_checksum>
			change sfx_background_fadein_volume_target = ($skate8_sfx_background_areas_and_states.<local_var_struct_fadein_area>.volume_params.<local_var_struct_fadein_checksum>)
		endif
	endif
	if NOT ($sfx_background_crossfade_time = 0)
		temp_a = ($sfx_background_crossfade_time * 30.0)
	else
		stars

		stars
		temp_a = 1
	endif
	if NOT (gotparam overide_fadein_start_vol)
		change \{sfx_background_fadein_volume_start = 1}
	else
		change sfx_background_fadein_volume_start = <overide_fadein_start_vol>
	endif
	if NOT (gotparam overide_fadeout_start_vol)
		change sfx_background_fadeout_volume_start = ($sfx_background_current_volume)
	else
		change sfx_background_fadeout_volume_start = <overide_fadeout_start_vol>
	endif
	change sfx_background_fadein_volume_add = (($sfx_background_fadein_volume_target - $sfx_background_fadein_volume_start) / <temp_a>)
	change sfx_background_fadeout_volume_subtract = ($sfx_background_fadeout_volume_start / <temp_a>)
	casttointeger \{temp_a}
	change background_crossfade_gameframes = <temp_a>
	if ($background_crossfade_gameframes < 1)
		change \{background_crossfade_gameframes = 1}
	endif
	change \{sfx_background_fadein_volume_current = $sfx_background_fadein_volume_start}
	change \{sfx_background_fadeout_volume_current = $sfx_background_fadeout_volume_start}
	if NOT (gotparam overide_yes)
		if ($pleasedocrossfade = 1)
			if isstreamplaying ($sfx_background_fadein_checksum)
				if (isps2)
					stopsound ($sfx_background_fadein_checksum)
				else
					stopstream ($sfx_background_fadein_checksum)
				endif
				waitonegameframe
			endif
			playsound ($sfx_background_fadein_checksum) vol_percent = (($sfx_background_fadein_volume_start * ($backgrounds_master_volume / 100.0)) + 1) num_loops = -1 priority = 105 buss = crowd_beds pan1x = -0.897089 pan1y = 0.1418498 pan2x = 0.88932973 pan2y = 0.15726662 slot = 3
		endif
	endif
	waitonegameframe
	begin
	change sfx_background_fadein_volume_current = ($sfx_background_fadein_volume_current + $sfx_background_fadein_volume_add)
	change sfx_background_fadeout_volume_current = ($sfx_background_fadeout_volume_current - $sfx_background_fadeout_volume_subtract)
	if ($sfx_background_fadein_volume_current > $sfx_background_fadein_volume_target)
		change \{sfx_background_fadein_volume_current = $sfx_background_fadein_volume_target}
	endif
	if isstreamplaying ($sfx_background_fadein_checksum)
		setsoundparams ($sfx_background_fadein_checksum) vol = (($sfx_background_fadein_volume_current * ($backgrounds_master_volume / 100.0)) + 1)
	else
		playsound ($sfx_background_fadein_checksum) vol_percent = (($sfx_background_fadein_volume_current * ($backgrounds_master_volume / 100.0)) + 1) num_loops = -1 priority = 105 buss = crowd_beds pan1x = -0.897089 pan1y = 0.1418498 pan2x = 0.88932973 pan2y = 0.15726662 slot = 3
	endif
	if ($sfx_background_fadeout_volume_current < 0)
		change \{sfx_background_fadeout_volume_current = 0}
	endif
	if isstreamplaying ($sfx_background_fadingout_checksum)
		setsoundparams ($sfx_background_fadingout_checksum) vol = (($sfx_background_fadeout_volume_current * ($backgrounds_master_volume / 100.0)) + 1)
	endif
	waitonegameframe
	repeat $background_crossfade_gameframes
	stopsound ($sfx_background_fadingout_checksum)
	waitonegameframe
	change sfx_background_current_area = ($sfx_background_fadein_area)
	change sfx_background_current_checksum = ($sfx_background_fadein_checksum)
	change sfx_background_current_volume = ($sfx_background_fadein_volume_current)
	change \{sfx_background_fadein_checksum = `default`}
	change \{sfx_background_fadingout_checksum = `default`}
	change \{sfx_background_requested_area = `default`}
	change \{sfx_background_requested_checksum = `default`}
	change \{sfx_background_is_crossfading = false}
endscript

script skate8_sfx_reverse_background_fading 
	killspawnedscript \{name = skate8_sfx_change_background}
	change sfx_background_current_checksum = ($sfx_background_fadein_checksum)
	change sfx_background_requested_checksum = ($sfx_background_fadingout_checksum)
	change sfx_background_requested_area = ($sfx_background_fadingout_area)
	change sfx_background_current_area = ($sfx_background_fadein_area)
	local_overide_calc = ($sfx_background_crossfade_time * ($sfx_background_fadein_volume_current / $sfx_background_fadein_volume_target))
	spawnscriptnow skate8_sfx_change_background params = {overide_yes = 1 overide_crossfade_time = <local_overide_calc> overide_fadeout_start_vol = ($sfx_background_fadein_volume_current) overide_fadein_start_vol = ($sfx_background_fadeout_volume_current)}
endscript

script 0xc9863983 \{vol = 11}
	change backgrounds_master_volume = ((<vol> / 11.0) * 20.0)
	if NOT ($sfx_background_current_checksum = none)
		if ($sfx_background_is_crossfading = false)
			setsoundparams ($sfx_background_current_checksum) vol = ($backgrounds_master_volume)
		endif
	endif
endscript
