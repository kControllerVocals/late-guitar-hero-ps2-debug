
script menu_soundevent_in 
	if NOT GotParam \{base_name}
		return
	endif
	switch <base_name>
		case 'setlist'
		change \{crowd_in_Front_End_state = 1}
		case 'gig_posters'
		change \{crowd_in_Front_End_state = 1}
		case 'select_instrument'
		if GotParam \{old_base_name}
			switch <old_base_name>
				case 'setlist_quit_warning'
				case 'setlist'
				spawnscriptnow \{menu_music_on}
			endswitch
		endif
		case 'select_difficulty'
		if GotParam \{old_base_name}
			switch <old_base_name>
				case 'character_selection'
				Menu_Music_Panning_Vol \{reset}
				case 'singleplayer_character_hub'
				Menu_Music_Panning_Vol \{reset}
			endswitch
		endif
		case 'character_selection'
		Menu_Music_Panning_Vol \{panandlowervol}
		case 'singleplayer_character_hub'
		Menu_Music_Panning_Vol \{panandlowervol}
		case 'options_audio'
		menu_music_fade \{out
			volume = 10
			time = 0.5}
		case 'band_mode'
		if GotParam \{old_base_name}
			switch <old_base_name>
				case 'setlist'
				spawnscriptnow \{menu_music_on}
			endswitch
		endif
		case 'character_hub'
		if GotParam \{old_base_name}
			switch <old_base_name>
				case 'setlist'
				spawnscriptnow \{menu_music_on}
			endswitch
		endif
		case 'online'
		if GotParam \{old_base_name}
			switch <old_base_name>
				case 'online_quit_warning'
				spawnscriptnow \{menu_music_on}
			endswitch
		endif
		case 'play_song'
		if NOT ($game_mode = practice || $game_mode = tutorial || $game_mode = practice)
			spawnscriptnow \{Loading_Screen_Crowd_Swell}
		endif
		case 'leaderboard_instrument'
		if GotParam \{old_base_name}
			switch <old_base_name>
				case 'setlist'
				spawnscriptnow \{menu_music_on}
			endswitch
		endif
		default
	endswitch
endscript

script menu_soundevent_out 
	if NOT GotParam \{base_name}
		return
	endif
	switch (<base_name>)
		case 'band_choose'

		return
		case 'main_menu'

		return
		case 'game_mode'

		return
		case 'select_controller'

		return
		case 'options'

		return
		case 'band_name_enter'

		return
		case 'select_instrument'

		return
		case 'select_difficulty'

		if GotParam \{back}
			return
		endif
		ui_event_get_stack
		i = 0
		begin
		if ((<stack> [<i>].base_name) = 'setlist')
			if ($top_rockers_enabled)
				if ($top_rockers_which_mode = p1_quickplay)
					generic_menu_pad_choose_sound
					return
				elseif ($top_rockers_which_mode = p2_quickplay)
					generic_menu_pad_choose_sound
					return
				endif
			else
				Menu_Music_Off
				return
			endif
		endif
		i = (<i> + 1)
		repeat <stack_size>
		case 'character_selection'

		return
		case 'singleplayer_character_hub'

		return
		case 'customize_character'

		return
		case 'customize_character_instrument'

		return
		case 'cag_main'
		if GotParam \{back}
			if (<back> = 1)
				if ((<instrument_info>.desc_id) = guitar)
					SoundEvent \{event = Guitar_Affirmation}
				elseif ((<instrument_info>.desc_id) = Bass)
					SoundEvent \{event = Bass_Affirmation}
				else

				endif
			endif
		endif
		case 'setlist'

		return
		case 'gig_posters'
		if GotParam \{back}
			return
		endif
		Menu_Music_Off
		case 'cadrm_main'
		if GotParam \{back}
			if (<back> = 1)
				SoundEvent \{event = Drum_Affirmation}
			endif
		endif
		case 'customize_character_mic'
		if GotParam \{back}
			if (<back> = 1)
				SoundEvent \{event = Mic_Affirmation}
			endif
		endif
		case 'options_audio'
		menu_music_fade \{in
			options_audio
			time = 1.5}
		default
	endswitch
endscript
