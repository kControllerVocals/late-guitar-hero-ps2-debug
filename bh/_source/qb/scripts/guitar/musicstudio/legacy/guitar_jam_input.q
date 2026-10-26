
script jam_update_guitar_tilt \{chromatic = 0}


	if NOT GuitarGetAnalogueInfo controller = <controller>
		return \{false}
	endif
	if GotParam \{rhythm}
		if (<chromatic> = 0)
			return
		endif
		four_tilts = 0
	else
		four_tilts = <chromatic>
	endif
	<spc_v_dist> = <RightY>
	jam_calc_line_rot player = <player> spc_v_dist = <spc_v_dist>
	if NOT (<four_tilts> = 1)
		if (<line_rot> <= 30)
			new_tilt = 0
		else
			new_tilt = 1
		endif
	else
		if (<line_rot> <= 1)
			new_tilt = 0
		elseif (<line_rot> > 1 && <line_rot> < 40)
			new_tilt = 1
		elseif (<line_rot> >= 40 && <line_rot> < 80)
			new_tilt = 2
		else
			new_tilt = 3
		endif
	endif
	if GotParam \{melody}
		change jam_tilt_melody = <new_tilt>
	elseif GotParam \{rhythm}
		change jam_tilt_rhythm = <new_tilt>
	elseif GotParam \{lead}
		change jam_tilt_lead = <new_tilt>
	else

		change jam_tilt_bass = <new_tilt>
	endif
	return \{true}
endscript
