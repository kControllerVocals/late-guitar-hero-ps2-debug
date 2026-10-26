
script ui_create_play_song \{type = quickplay
		can_clear_milestones = true}

	Menu_Music_Off
	change \{unknown_drum_type = 0}
	i = 1
	begin
	UseFourLaneHighway {player = <i> reset}
	i = (<i> + 1)
	repeat ($current_num_players)
	change \{band_builder_current_gig_genre = none}
	band_anim_reset_loading
	if GotParam \{progression_flag}
		change current_progression_flag = <progression_flag>
		change current_gig_number = <gig_num>
		get_progression_globals <progression_flag>
		FormatText checksumname = tiername 'tier%d' d = <gig_num>
		if GotParam \{song_checksum}
			SetGlobalTags Progression params = {current_tier = <gig_num> current_song_count = <song_index>}
			change current_song = <song_checksum>
		else
			SetGlobalTags Progression params = {current_tier = <gig_num> current_song_count = 0}
			change current_song = ($<tier_global>.<tiername>.songs [0])
		endif
		if GotParam \{selected_level}
			change current_level = <selected_level>
		else
			change current_level = ($<tier_global>.<tiername>.level)
		endif

		if StructureContains Structure = ($<tier_global>.<tiername>) genre
			change band_builder_current_gig_genre = ($<tier_global>.<tiername>.genre)
		endif
		if (<can_clear_milestones> = true)
			Progression_ClearDetailedStatsForGig
			progression_reset_new_unlocks
			ui_gig_cash_clear_gig_earnings
		endif
	else
		if GotParam \{selected_level}
			change current_level = <selected_level>
		else
			if ($end_credits = 0)
				if ($current_song = jamsession)
					change \{current_level = load_z_studio}
				else
					get_song_struct song = ($current_song)
					if StructureContains Structure = <song_struct> name = venue_set
						venue_set = (<song_struct>.venue_set)
						GetArraySize $<venue_set>
						GetRandomValue a = 0 b = (<array_size> -1) name = random_venue_index Integer
						change current_level = (($<venue_set>) [<random_venue_index>])
					else
						change \{current_level = load_Z_Subway}
					endif
				endif
			endif
		endif
		if (<can_clear_milestones> = true)
			ui_gig_cash_clear_gig_earnings
		endif
		GameMode_GetType
		if (<type> = pro_faceoff)
			refresh_career_earnings
		endif
	endif
	spawnscriptnow ui_create_play_song_spawned params = <...>
endscript

script ui_destroy_play_song 
	if ($is_network_game = 0)
		($default_loading_screen.destroy)
	endif
endscript

script ui_create_play_song_spawned 
	startrendering
	($default_loading_screen.create)
	if ($practice_enabled)
		practice_start_song <...>
	else
		if ($is_network_game)
			load_and_sync_timing
		else
			switch ($game_mode)
				case p1_quickplay
				case p2_quickplay
				case p3_quickplay
				case p4_quickplay
				if ($is_partyplay_mode = 1)
					set_random_partyplay_song
					<current_song> = <new_partyplay_song>
				else
					<current_song> = ($temp_quickplay_song_list [($quickplay_song_list_current)])
				endif
				if (<current_song> = jamsession)
					<jam_directory_index> = ($temp_jamsession_song_list [($quickplay_song_list_current)])
					<example_song> = 0
					if (<jam_directory_index> >= 1000)
						<jam_directory_index> = (<jam_directory_index> - 1000)
						<example_song> = 1
						<filename> = (($jam_song_assets) [<jam_directory_index>].filename)
					else
						<filename> = ($jam_curr_directory_listing [<jam_directory_index>].filename)
					endif
					quickplay_choose_random_venue <...>
					($default_loading_screen.destroy)
					jam_start_song_from_quickplay <...>
					return
				else
					quickplay_start_song <...>
				endif
				case p2_pro_faceoff
				quickplay_choose_random_venue <...>
				start_song <...>
				case gh4_p1_career
				default
				start_song <...>
			endswitch
		endif
	endif
	if ($is_network_game = 0)
		($default_loading_screen.destroy)
		ui_event_wait \{event = menu_replace
			data = {
				state = uistate_gameplay
			}}
	endif
	if ($is_network_game = 1)
		set_rich_presence_game_mode \{online = 1}
	endif
endscript
