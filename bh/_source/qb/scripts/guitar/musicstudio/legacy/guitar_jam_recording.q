
script jam_update_volume \{volume = 0}
	update_volume = <volume>
	if NOT ($current_song_qpak = jamsession)
		return
	endif
	if (<volume> = 0)
		<new_vol> = 100
	endif
	GetSongInfo
	GetPlayerInfo <player> part
	if (<part> = guitar)
		inst = <playback_track1>
	elseif (<part> = Bass)
		inst = <playback_track2>
	else
		return
	endif
	if ((<inst> < 0) || (<inst> > 4))
		return
	endif
	GetTrackInfo track = ($jam_tracks [<inst>].id)
	new_vol = ((10 - <volume>) * 2)
	vocals_get_num_vocalists
	if (<num_vocalists> > 0 && <inst> = 4)
		return
	endif
	switch <inst>
		case 0
		if (<update_volume> = 0)
			HackSetSlotMute \{slot = 4}
		else
			HackSetSlotMute \{slot = 4
				muted = 0}
			change jam_rhythm_volume = (<volume> * 10)
		endif
		case 1
		if (<update_volume> = 0)
			HackSetSlotMute \{slot = 5}
		else
			HackSetSlotMute \{slot = 5
				muted = 0}
			change jam_lead_volume = (<volume> * 10)
		endif
		case 2
		if (<update_volume> = 0)
			HackSetSlotMute \{slot = 6}
		else
			HackSetSlotMute \{slot = 6
				muted = 0}
			change jam_bass_volume = (<volume> * 10)
		endif
		case 4
		if (<update_volume> = 0)
			HackSetSlotMute \{slot = 8}
		else
			HackSetSlotMute \{slot = 8
				muted = 0}
			change jam_key_volume = (<volume> * 10)
		endif
	endswitch
endscript
