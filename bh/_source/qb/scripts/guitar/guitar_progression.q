current_progression_savegame = 0
progression_beat_game_last_song = 0
progression_unlock_tier_last_song = 0
progression_play_completion_movie = 0
progression_completion_tier = 1
progression_unlocked_guitar = -1
progression_unlocked_guitar2 = -1
progression_unlocked_type = guitar
progression_total_stars_unlocked = 0
Cash_System_rules = [
	{
		diff = beginner
		newstars = 3
		oldstars = 0
		Cash = 35
	}
	{
		diff = beginner
		newstars = 4
		oldstars = 0
		Cash = 85
	}
	{
		diff = beginner
		newstars = 5
		oldstars = 0
		Cash = 150
	}
	{
		diff = beginner
		newstars = 4
		oldstars = 3
		Cash = 50
	}
	{
		diff = beginner
		newstars = 5
		oldstars = 3
		Cash = 115
	}
	{
		diff = beginner
		newstars = 5
		oldstars = 4
		Cash = 65
	}
	{
		diff = easy
		newstars = 3
		oldstars = 0
		Cash = 75
	}
	{
		diff = easy
		newstars = 4
		oldstars = 0
		Cash = 175
	}
	{
		diff = easy
		newstars = 5
		oldstars = 0
		Cash = 300
	}
	{
		diff = easy
		newstars = 4
		oldstars = 3
		Cash = 100
	}
	{
		diff = easy
		newstars = 5
		oldstars = 3
		Cash = 225
	}
	{
		diff = easy
		newstars = 5
		oldstars = 4
		Cash = 125
	}
	{
		diff = medium
		newstars = 3
		oldstars = 0
		Cash = 150
	}
	{
		diff = medium
		newstars = 4
		oldstars = 0
		Cash = 350
	}
	{
		diff = medium
		newstars = 5
		oldstars = 0
		Cash = 600
	}
	{
		diff = medium
		newstars = 4
		oldstars = 3
		Cash = 200
	}
	{
		diff = medium
		newstars = 5
		oldstars = 3
		Cash = 450
	}
	{
		diff = medium
		newstars = 5
		oldstars = 4
		Cash = 250
	}
	{
		diff = hard
		newstars = 3
		oldstars = 0
		Cash = 300
	}
	{
		diff = hard
		newstars = 4
		oldstars = 0
		Cash = 700
	}
	{
		diff = hard
		newstars = 5
		oldstars = 0
		Cash = 1200
	}
	{
		diff = hard
		newstars = 4
		oldstars = 3
		Cash = 400
	}
	{
		diff = hard
		newstars = 5
		oldstars = 3
		Cash = 900
	}
	{
		diff = hard
		newstars = 5
		oldstars = 4
		Cash = 500
	}
	{
		diff = expert
		newstars = 3
		oldstars = 0
		Cash = 450
	}
	{
		diff = expert
		newstars = 4
		oldstars = 0
		Cash = 1050
	}
	{
		diff = expert
		newstars = 5
		oldstars = 0
		Cash = 1800
	}
	{
		diff = expert
		newstars = 4
		oldstars = 3
		Cash = 600
	}
	{
		diff = expert
		newstars = 5
		oldstars = 3
		Cash = 1350
	}
	{
		diff = expert
		newstars = 5
		oldstars = 4
		Cash = 750
	}
]
Songs_Implemented = {
}

script Progression_CheckSong5Star 

	get_progression_globals game_mode = ($game_mode)
	songlist = <tier_global>
	tier = 1
	begin
	setlist_prefix = ($<songlist>.prefix)
	FormatText checksumname = tiername '%ptier%i' p = <setlist_prefix> i = <tier>
	FormatText checksumname = tier_checksum 'tier%s' s = <tier>
	GetArraySize ($<songlist>.<tier_checksum>.songs)
	unlocked = 0
	format_globaltag_gigname setlist_prefix = <setlist_prefix> gignum = <tier>
	GetGlobalTags <gig_name>
	if (<unlocked> = 0 && <completed> = 0)
		return \{false}
	endif
	array_count = 0
	begin
	if ($current_progression_flag = Career_Band)
		get_band_difficulty
		format_globaltag_song_checksum part = ($<songlist>.part) song = ($<songlist>.<tier_checksum>.songs [<array_count>]) difficulty = <band_difficulty>
	else
		format_globaltag_song_checksum part = ($<songlist>.part) song = ($<songlist>.<tier_checksum>.songs [<array_count>])
	endif
	GetGlobalTags <song_checksum> param = unlocked
	GetGlobalTags <song_checksum> param = stars
	if NOT (<stars> = 5)
		return \{false}
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
	tier = (<tier> + 1)
	repeat ($<songlist>.num_tiers)
	return \{true}
endscript

script Progression_CheckDiff 

	Progression_GetDifficulty
	if NOT (<diff> = <difficulty>)
		return \{false}
	endif
	if GotParam \{mode}
		if NOT ($game_mode = <mode>)
			return \{false}
		endif
	endif
	return \{true}
endscript

script Progression_SongWon 

	additional_cash = 0
	change \{progression_beat_game_last_song = 0}
	change \{progression_unlock_tier_last_song = 0}
	change \{progression_play_completion_movie = 0}
	disable_because_of_cheats
	update_song_star_rating
	if isSinglePlayerGame
		GetPlayerInfo \{1
			part}
	else
		part = Band
	endif
	get_band_difficulty
	get_difficulty_text_nl difficulty = <band_difficulty>
	get_song_prefix song = ($current_song)
	get_formatted_songname song_prefix = (<song_prefix>) difficulty_text_nl = <difficulty_text_nl> part = ($instrument_list.<part>.text_nl)
	if ($current_song != jamsession)
		if isSinglePlayerGame
			get_player_percent_accuracy \{player_index = 1}
		else
			GameMode_GetNumPlayersShown
			if (<num_players_shown> > 0)
				p = 1
				gold_stars = 1
				begin
				get_player_percent_accuracy player_index = <p>
				if (<percent_notes_hit> != 100)
					gold_stars = 0
				endif
				p = (<p> + 1)
				repeat <num_players_shown>
			endif
			if (<gold_stars> = 1)
				<percent_notes_hit> = 100
			else
				<percent_notes_hit> = 0
			endif
		endif
		if (<cheat_disable> = 0)
			if (<percent_notes_hit> = 100)
				if ($game_mode = p1_quickplay || $game_mode = p2_quickplay)
					SetGlobalTags <songname> params = {tr_percent100 = 1}
				endif
			endif
		endif
	endif
	GameMode_GetType
	if (<type> = career && $end_credits = 0)
		vocals_destroy_highway \{player = 1}
		vocals_destroy_highway \{player = 2}
		vocals_destroy_highway \{player = 3}
		vocals_destroy_highway \{player = 4}
		destroy_band_hud
		Wait \{2.0
			seconds}
		if NOT ($current_song = jamsession)
			if GlobalTagExists \{$current_song
					noassert = 1}
				SetGlobalTags \{$current_song
					all_active_players = 1
					params = {
						unlocked = 1
					}}
				progression_set_unlocked_for_all_diff game_mode = ($game_mode) ($current_progression_flag) song = ($current_song)
			endif
			FormatText {
				checksumname = venue_checksum
				'%s_%i'
				s = ($LevelZones.($current_level).name)
				i = ($instrument_list.<part>.text_nl)
				AddToStringLookup = true
			}
			if GlobalTagExists <venue_checksum> noassert = 1
				SetGlobalTags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
			endif
			FormatText checksumname = venue_checksum 'venue_%s' s = ($LevelZones.($current_level).name)
			if GlobalTagExists <venue_checksum> noassert = 1
				SetGlobalTags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
			endif
		endif
		get_progression_globals ($current_progression_flag) game_mode = ($game_mode) use_current_tab = 1
		songlist = <tier_global>
		get_current_band_info
		bandname_id = <band_info>
		SetGlobalTags <bandname_id> params = {first_play = 0} all_active_players = 1
		GetGlobalTags \{Progression
			params = current_tier}
		GetGlobalTags \{Progression
			params = current_song_count}
		GetGlobalTags \{Progression
			params = career_using_createagig}
		song_count = <current_song_count>
		if GotParam \{current_tier}
			setlist_prefix = ($<songlist>.prefix)
			FormatText checksumname = tier_checksum 'tier%s' s = <current_tier>
			if (<career_using_createagig> = 1)
				if ($current_progression_flag = Career_Band)
					get_band_difficulty
					format_globaltag_song_checksum part = ($<tier_global>.part) song = ($current_song) difficulty = <band_difficulty>
				else
					format_globaltag_song_checksum part = ($<tier_global>.part) song = ($current_song)
				endif
			else
				if ($current_progression_flag = Career_Band)
					get_band_difficulty
					format_globaltag_song_checksum part = ($<tier_global>.part) song = ($current_song) difficulty = <band_difficulty>
				else
					format_globaltag_song_checksum part = ($<tier_global>.part) song = ($current_song)
				endif
			endif
			if isSinglePlayerGame
				GetPlayerInfo \{1
					stars}
				new_stars = <stars>
				GetPlayerInfo \{1
					score}
				new_score = <score>
			else
				new_stars = ($band1_status.stars)
				new_score = ($band1_status.score)
			endif
			if isSinglePlayerGame
				get_player_percent_accuracy \{player_index = 1}
			else
				GameMode_GetNumPlayersShown
				p = 1
				gold_stars = 1
				begin
				get_player_percent_accuracy player_index = <p>
				if (<percent_notes_hit> != 100)
					gold_stars = 0
				endif
				p = (<p> + 1)
				repeat <num_players_shown>
				if (<gold_stars> = 1)
					<percent_notes_hit> = 100
				else
					<percent_notes_hit> = 0
				endif
			endif
			if (<cheat_disable> = 0)
				if (<percent_notes_hit> = 100)
					SetGlobalTags <song_checksum> params = {percent100 = 1} all_active_players = 1
				endif
			endif
			if (<cheat_disable> = 0)
				GameMode_GetNumPlayersShown
				if (<num_players_shown> > 0)
					<player> = 1
					begin
					GetPlayerInfo <player> is_local_client
					if (<is_local_client> = 1)
						GetPlayerInfo <player> controller
						GetSavegameFromController controller = <controller>
						GetGlobalTags <song_checksum> savegame = <savegame> param = stars
						old_stars = <stars>
						GetGlobalTags <song_checksum> savegame = <savegame> param = score
						old_score = <score>
						if StructureContains Structure = ($permanent_songlist_props.($current_song)) double_kick
							if (($permanent_songlist_props.($current_song).double_kick) = 1)
								GetPlayerInfo <player> double_kick_drum
								if (<double_kick_drum> = 1)
									SetGlobalTags <song_checksum> savegame = <savegame> params = {double_bass_complete = 1}
								endif
							endif
						endif
						if (<new_stars> > <old_stars>)
							SetGlobalTags <song_checksum> savegame = <savegame> params = {stars = <new_stars>}
							if ($primary_controller = <controller>)
								if ($current_tab = tab_setlist)
									if NOT StructureContains Structure = ($<tier_global>.<tier_checksum>) nocash
										Progression_AwardCash old_stars = <stars> new_stars = <new_stars>
									endif
								endif
							endif
						endif
						if (<new_score> > <old_score>)
							CastToInteger \{new_score}
							SetGlobalTags <song_checksum> savegame = <savegame> params = {score = <new_score>}
						endif
					endif
					player = (<player> + 1)
					repeat <num_players_shown>
				endif
			endif
			setup_encore = 1
			GetGlobalTags \{Progression
				params = career_play_song_and_end
				noassert = 1}
			if GotParam \{career_play_song_and_end}
				if (<career_play_song_and_end> = 1)
					setup_encore = 0
				endif
			endif
			if (<career_using_createagig> = 1)
				setup_encore = 0
			endif
			progression_get_total_stars
			if (<setup_encore> = 1)
				if NOT progression_check_intro_complete
					GetArraySize ($<tier_global>.<tier_checksum>.songs)
					if StructureContains Structure = ($<tier_global>.<tier_checksum>) encore_stars
						if (($<tier_global>.<tier_checksum>.encore_stars) = 0)
							if (($<tier_global>.<tier_checksum>.encore_stars) <= <total_stars>)
								encore = ($<tier_global>.<tier_checksum>.songs [(<array_size> - 1)])
								if ($current_progression_flag = Career_Band)
									get_band_difficulty
									format_globaltag_song_checksum part = ($<tier_global>.part) song = <encore> difficulty = <band_difficulty>
								else
									format_globaltag_song_checksum part = ($<tier_global>.part) song = <encore>
								endif
								GetGlobalTags <song_checksum> param = unlocked
								if (<unlocked> = 0)
									change \{current_transition = preencore}
									next_song_to_force = ($<tier_global>.<tier_checksum>.songs [(<array_size> - 1)])
									if ($debug_encore = 0)
										SetGlobalTags Progression params = {encore_song = <next_song_to_force>}
									endif
								else
									if NOT progression_check_intro_complete
										progression_set_intro_complete
									endif
								endif
							endif
						endif
					endif
				endif
			endif
			if ($is_network_game = 0)
				format_globaltag_gigname setlist_prefix = ($<tier_global>.prefix) gignum = ($current_gig_number)
				GetGlobalTags <gig_name> param = completed
				if (<completed> = 0)
					if StructureContains Structure = ($<tier_global>.<tier_checksum>) end_with_credits
						if Progression_Career_Check_Gig_Complete ($current_progression_flag) gig = ($current_gig_number)
							change \{end_credits = 1}
						endif
					endif
				endif
			endif
		endif
	endif
	Progression_UpdateDetailedStatsForGig
	if ($debug_encore = 0)
		if GotParam \{next_song_to_force}
			change current_song = <next_song_to_force>
		endif
	endif
endscript

script Progression_SongFailed 

	if ($coop_dlc_active = 1)
		return
	endif
	if ($game_mode = gh4_p1_career ||
			$game_mode = gh4_p2_career)
		UpdateAtoms \{name = Progression}
	endif
endscript

script update_song_star_rating 
	GameMode_GetNumPlayersShown
	<num_players> = $current_num_players
	player = 1
	if (<num_players> > 0)
		begin
		<player_status> = ($player_status_array [<player>])
		<stars> = ($<player_status>.projected_song_stars)
		CastToInteger \{stars}
		if (<stars> < 3)
			<stars> = 3
		endif
		change structurename = <player_status> stars = <stars>
		player = (<player> + 1)
		repeat <num_players>
	endif
	<stars> = ($band1_status.projected_song_stars)
	CastToInteger \{stars}
	if (<stars> < 3)
		<stars> = 3
	endif
	change structurename = band1_status stars = <stars>
endscript

script get_player_percent_accuracy 

	if NOT PlayerInfoEquals <player_index> part = Vocals
		GetPlayerInfo <player_index> notes_hit
		GetPlayerInfo <player_index> max_notes
		if (<max_notes> > 0)
			<percent_notes_hit> = (((<notes_hit> * 1.0) / <max_notes>) * 100.0)
		else
			<percent_notes_hit> = 0
		endif
	else
		GetPlayerInfo <player_index> vocal_phrase_quality
		GetPlayerInfo <player_index> vocal_phrase_max_qual
		if (<vocal_phrase_max_qual> > 0)
			<percent_notes_hit> = (((<vocal_phrase_quality> * 1.0) / <vocal_phrase_max_qual>) * 100.0)
		else
			<percent_notes_hit> = 0
		endif
	endif
	adjust_percent_for_display percent = <percent_notes_hit>
	<percent_notes_hit> = <adjusted_percent>
	return percent_notes_hit = <percent_notes_hit>
endscript
end_credits = 0

script Progression_EndCredits 

	change \{current_level = $final_credits_venue}
	change \{current_song = $final_credits_song}
	Load_Venue
	restart_gem_scroller song_name = ($current_song) difficulty = ($player1_status.difficulty) difficulty2 = ($player2_status.difficulty) StartTime = 0 end_credits_restart = 1
	generic_event_choose \{state = uistate_play_song}
	spawnscriptnow \{scrolling_list_begin_credits}
endscript

script Progression_EndCredits_Done 
	destroy_credits_menu
endscript

script Progression_AwardCash 

	additional_cash = 0
	get_current_band_info
	GetGlobalTags <band_info>
	GetGlobalTags \{Progression
		params = current_song_count}
	get_progression_globals ($current_progression_flag)
	format_globaltag_gigname setlist_prefix = ($<tier_global>.prefix) gignum = ($current_gig_number)
	GetGlobalTags <gig_name> param = cash_earned
	SetGlobalTags <gig_name> params = {cash_earned = (<cash_earned> + <additional_cash>)}
	GetGlobalTags \{Progression
		params = current_song_count}
	return additional_cash = <additional_cash>
endscript

script Progression_CountCompletedSongsInCurrentTier 
	completed_songs = 0
	tier_size = 0
	get_progression_globals game_mode = ($game_mode) ($current_progression_flag)
	if NOT (<tier_global> = 0 || $current_gig_number = 0)
		Progression_GetNumTierSong tier_global = <tier_global> tier = ($current_gig_number) all
		song_count = 0
		begin
		Progression_GetTierSong tier_global = <tier_global> tier = ($current_gig_number) song_count = <song_count>
		GetGlobalTags <song_checksum> param = stars
		if NOT (<stars> = 0)
			completed_songs = (<completed_songs> + 1)
		endif
		song_count = (<song_count> + 1)
		repeat <tier_size>
	endif
	return {completed_songs = <completed_songs> total_songs = <tier_size>}
endscript

script Progression_GetTierSong 
	setlist_prefix = ($<tier_global>.prefix)
	FormatText checksumname = tier_checksum 'tier%s' s = <tier>
	GetArraySize ($<tier_global>.<tier_checksum>.songs)
	if ((<song_count> + 1) > <array_size>)
		if StructureContains Structure = ($<tier_global>.<tier_checksum>) unlockable_songs
			song = ($<tier_global>.<tier_checksum>.unlockable_songs [(<song_count> - <array_size>)])
		else
			debug_ScriptAssert \{'Either a bad index was provided or a progression array is incorrect. Tell Bryan to fix this.'}
		endif
	else
		song = ($<tier_global>.<tier_checksum>.songs [<song_count>])
	endif
	format_globaltag_song_checksum part = ($<tier_global>.part) song = <song>
	return song = <song> song_checksum = <song_checksum>
endscript

script Progression_GetNumTierSong 
	FormatText checksumname = tier_checksum 'tier%s' s = <tier>
	GetArraySize ($<tier_global>.<tier_checksum>.songs)
	tier_size = <array_size>
	if NOT GotParam \{all}
		return tier_size = <tier_size>
	else
		if StructureContains Structure = ($<tier_global>.<tier_checksum>) unlockable_songs
			GetArraySize ($<tier_global>.<tier_checksum>.unlockable_songs)
			<tier_size> = (<tier_size> + <array_size>)
		endif
		return tier_size = <tier_size>
	endif
endscript

script Progression_GetEncoreSong \{type = any}
	setlist_prefix = ($<tier_global>.prefix)
	FormatText checksumname = tier_checksum 'tier%s' s = <tier>
	if (<type> = any)
		if NOT StructureContains Structure = ($<tier_global>.<tier_checksum>) encorep1
			if NOT StructureContains Structure = ($<tier_global>.<tier_checksum>) encorep2
				return \{song_count = -1
					song = none
					song_checksum = none}
			endif
		endif
	endif
	if (<type> = p1)
		if StructureContains Structure = ($<tier_global>.<tier_checksum>) encore_stars
		elseif StructureContains Structure = ($<tier_global>.<tier_checksum>) encorep1
		elseif NOT StructureContains Structure = ($<tier_global>.<tier_checksum>) encore_stars
			return \{song_count = -1
				song = none
				song_checksum = none}
		elseif NOT StructureContains Structure = ($<tier_global>.<tier_checksum>) encorep1
			return \{song_count = -1
				song = none
				song_checksum = none}
		endif
	endif
	if (<type> = p2)
		if NOT StructureContains Structure = ($<tier_global>.<tier_checksum>) encorep2
			return \{song_count = -1
				song = none
				song_checksum = none}
		endif
	endif
	GetArraySize ($<tier_global>.<tier_checksum>.songs)
	array_count = (<array_size> - 1)
	if (<type> = p1)
		if StructureContains Structure = ($<tier_global>.<tier_checksum>) encorep2
			array_count = (<array_count> - 1)
		endif
	endif
	song = ($<tier_global>.<tier_checksum>.songs [<array_count>])
	if ($current_progression_flag = Career_Band)
		get_band_difficulty
		format_globaltag_song_checksum part = ($<tier_global>.part) song = <song> difficulty = <band_difficulty>
	else
		format_globaltag_song_checksum part = ($<tier_global>.part) song = <song>
	endif
	return song_count = <array_count> song = <song> song_checksum = <song_checksum>
endscript

script Progression_IsEncoreSong 
	return \{false}
	query_song = <song>
	get_progression_globals ($current_progression_flag) game_mode = ($game_mode) use_current_tab = 1
	Progression_GetEncoreSong <...> type = p1

	if (<song> = <query_song>)
		return \{true}
	endif
	Progression_GetEncoreSong <...> type = p2

	if (<song> = <query_song>)
		return \{true}
	endif
	return \{false}
endscript

script Progression_ShouldPlaySongSpecificVO 
	if ($game_mode = gh4_p1_career ||
			$game_mode = gh4_p2_career ||
			$game_mode = gh4_p3_career ||
			$game_mode = gh4_p4_career)
		if ($current_progression_flag = Career_Band)
			get_band_difficulty
			format_globaltag_song_checksum part = ($<tier_global>.part) song = <song> difficulty = <band_difficulty>
		else
			format_globaltag_song_checksum part = ($<tier_global>.part) song = <song>
		endif
		GetGlobalTags <song_checksum> param = unlocked
		if (<unlocked> = 0)
			return \{true}
		endif
	endif
	return \{false}
endscript

script Progression_UnlockSong \{encore = 0
		unlocked = 0}
	setlist_prefix = ($<tier_global>.prefix)
	tier = 1
	begin
	FormatText checksumname = tiername '%ptier%i' p = <setlist_prefix> i = <tier>
	FormatText checksumname = tier_checksum 'tier%s' s = <tier>
	GetArraySize ($<tier_global>.<tier_checksum>.songs)
	array_count = 0
	begin
	if ($<tier_global>.<tier_checksum>.songs [<array_count>] = <song>)
		if ($current_progression_flag = Career_Band)
			get_band_difficulty
			format_globaltag_song_checksum part = ($<tier_global>.part) song = ($<tier_global>.<tier_checksum>.songs [<array_count>]) difficulty = <band_difficulty>
		else
			format_globaltag_song_checksum part = ($<tier_global>.part) song = ($<tier_global>.<tier_checksum>.songs [<array_count>])
		endif
		SetGlobalTags <song_checksum> params = {unlocked = 1}
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
	tier = (<tier> + 1)
	repeat ($<tier_global>.num_tiers)
endscript

script Progression_GetDifficulty 
	difficulty = ($player1_status.difficulty)
	if ($game_mode = gh4_p2_career)
		get_minimum_difficulty difficulty1 = ($player1_status.difficulty) difficulty2 = ($player2_status.difficulty)
		difficulty = <minimum_difficulty>
	endif
	return difficulty = <difficulty>
endscript

script Progression_SetProgressionNodeFlags 
	ChangeNodeFlag \{LS_ALWAYS
		1}
	ls_encore = 0
	ls_3_5 = 0
	get_progression_globals ($current_progression_flag) game_mode = ($game_mode)
	tier = ($current_gig_number)
	if ($coop_dlc_active = 0)
		if ($game_mode = gh4_p1_career ||
				$game_mode = gh4_p2_career ||
				$game_mode = gh4_p3_career ||
				$game_mode = gh4_p4_career)
			if Progression_IsEncoreSong tier_global = <tier_global> tier = <tier> song = ($current_song)
				ls_encore = 1
			endif
			Progression_GetDifficulty
			Progression_CountCompletedSongsInCurrentTier
			if (<completed_songs> >= (<total_songs> - 1))
				ls_3_5 = 1
			endif
		endif
	endif
	if ($debug_encore)
		<ls_encore> = 1
	endif
	ChangeNodeFlag \{LS_BAND_GENERIC
		1}
	ChangeNodeFlag \{LS_BAND_NODOUBT
		0}
	ChangeNodeFlag \{LS_SONG_DONTSPEAK
		0}
	ChangeNodeFlag \{LS_SONG_LOVESTORY
		0}
	ChangeNodeFlag \{LS_SONG_PICTURETOBURN
		0}
	ChangeNodeFlag \{LS_SONG_YOUBELONGWITHME
		0}
	current_song = $current_song
	switch (<current_song>)
		case DontSpeak
		ChangeNodeFlag \{LS_BAND_GENERIC
			0}
		ChangeNodeFlag \{LS_BAND_NODOUBT
			1}
		ChangeNodeFlag \{LS_SONG_DONTSPEAK
			1}
		case JustaGirl
		ChangeNodeFlag \{LS_BAND_GENERIC
			0}
		ChangeNodeFlag \{LS_BAND_NODOUBT
			1}
		case LoveStory
		ChangeNodeFlag \{LS_SONG_LOVESTORY
			1}
		case PictureToBurn
		ChangeNodeFlag \{LS_SONG_PICTURETOBURN
			1}
		case YouBelongWithMe
		ChangeNodeFlag \{LS_SONG_YOUBELONGWITHME
			1}
	endswitch

	if (<ls_encore> = 1)
		ChangeNodeFlag \{LS_3_5_PRE
			0}
		ChangeNodeFlag \{LS_3_5_POST
			1}
		ChangeNodeFlag \{LS_ENCORE_PRE
			0}
		ChangeNodeFlag \{LS_ENCORE_POST
			1}
	elseif (<ls_3_5> = 1)
		ChangeNodeFlag \{LS_3_5_PRE
			0}
		ChangeNodeFlag \{LS_3_5_POST
			1}
		ChangeNodeFlag \{LS_ENCORE_PRE
			1}
		ChangeNodeFlag \{LS_ENCORE_POST
			0}
	else
		ChangeNodeFlag \{LS_3_5_PRE
			1}
		ChangeNodeFlag \{LS_3_5_POST
			0}
		ChangeNodeFlag \{LS_ENCORE_PRE
			1}
		ChangeNodeFlag \{LS_ENCORE_POST
			0}
	endif
	GetPakManCurrentName \{map = zones}
	if GotParam \{pakname}
		FormatText checksumname = zone_setup '%s_SetupNodeflags' s = <pakname>
		if ScriptExists <zone_setup>
			spawnscriptnow <zone_setup>
		endif
	endif
endscript
GH4_Demo_Songs = {
	prefix = 'demo'
	num_tiers = 4
	tier1 = {
		songs = [
			beatit
			rebelyell
		]
		level = load_z_goth
		defaultunlocked = 2
	}
	tier2 = {
		songs = [
			crazytrain
		]
		level = load_z_fairgrounds
		defaultunlocked = 1
	}
	tier3 = {
		songs = [
			americanwoman
		]
		level = load_z_fairgrounds
		defaultunlocked = 1
	}
	tier4 = {
		songs = [
			everlong
		]
		level = load_z_military
		defaultunlocked = 1
	}
}
Bonus_progression = {
	tier_global = Bonus_Songs
	progression_global = none
}
Demo_progression = {
	tier_global = GH4_Demo_Songs
	progression_global = none
}
Career_Guitar_progression = {
	tier_global = GH4_Career_Guitar_Songs
	progression_global = GH4_Career_Guitar_Progression
}
Career_Bass_progression = {
	tier_global = GH4_Career_Bass_Songs
	progression_global = GH4_Career_Bass_Progression
}
Career_Drum_progression = {
	tier_global = GH4_Career_Drum_Songs
	progression_global = GH4_Career_Drum_Progression
}
Career_Vocals_progression = {
	tier_global = GH4_Career_Vocals_Songs
	progression_global = GH4_Career_Vocals_Progression
}
Career_Band_progression = {
	tier_global = GH4_Career_Band_Songs
	progression_global = GH4_Career_Band_Progression
}

script get_progression_globals \{use_current_tab = 0}
	if NOT GotParam \{game_mode}
		game_mode = ($game_mode)
	endif
	if (<use_current_tab> = 1)
		if ($current_tab = tab_bonus)
			Bonus = 1
		endif
	endif
	if ($is_demo_mode = 1)
		if GotParam \{Bonus}
			AddParams ($Bonus_progression)
		elseif (<game_mode> = gh4_p1_career)
			AddParams ($Demo_progression_Career)
		elseif (<game_mode> = p1_quickplay)
			AddParams ($Demo_progression_Quickplay)
		else
			AddParams ($Demo_progression_Multiplayer)
		endif
		return tier_global = <tier_global> progression_global = <progression_global>
	endif
	if GotParam \{Career_Band}
		AddParams ($Career_Band_progression)
	elseif GotParam \{Career_Guitar}
		AddParams ($Career_Guitar_progression)
	elseif GotParam \{Career_Bass}
		AddParams ($Career_Bass_progression)
	elseif GotParam \{Career_Drum}
		AddParams ($Career_Drum_progression)
	elseif GotParam \{Career_Vocals}
		AddParams ($Career_Vocals_progression)
	elseif GotParam \{Bonus}
		AddParams ($Bonus_progression)
	elseif ($band_mode_mode = career)
		AddParams ($Career_Band_progression)
	elseif ($band_mode_mode = quickplay)
		AddParams ($Career_Band_progression)
	elseif (<game_mode> = gh4_p1_career)
		AddParams ($Career_Guitar_progression)
	elseif (<game_mode> = gh4_p2_career)
		AddParams ($Career_Band_progression)
	elseif (<game_mode> = p1_quickplay)
		AddParams ($Career_Guitar_progression)
	elseif (<game_mode> = p2_quickplay)
		AddParams ($Career_Band_progression)
	else
		AddParams ($Career_Band_progression)
	endif
	return tier_global = <tier_global> progression_global = <progression_global>
endscript

script progression_set_new_song_in_gig_list 


	get_progression_globals ($current_progression_flag)
	setlist_prefix = ($<tier_global>.prefix)
	FormatText \{checksumname = tiername
		'tier%d'
		d = $current_gig_number}
	song_num = 0
	GetArraySize ($<tier_global>.<tiername>.songs)
	song_size = <array_size>
	GetGlobalTags \{Progression}
	if (<career_using_createagig> = 0)
		format_globaltag_gigname setlist_prefix = ($<tier_global>.prefix) gignum = ($current_gig_number)
		SetGlobalTags <gig_name> params = {started = 1} all_active_players = 1
		if GotParam \{career_play_song_and_end}
			if (<career_play_song_and_end> = 1)
				progression_patch_up_gig_completion <...>
				return \{false}
			endif
		endif
	endif
	if ($quickplay_song_list_current != -1)
		if quickplay_set_new_song_in_gig_list
			return \{true}
		endif
	else
		if progression_check_intro_complete
			UpdateAtoms \{name = Progression}
			return \{false}
		endif
	endif
	updated_progression = 0
	if (<career_using_createagig> = 0)
		disable_because_of_cheats
		if (<cheat_disable> = 0)
			GameMode_GetNumPlayersShown
			if (<num_players_shown> > 0)
				player_index = 0
				begin
				GetPlayerInfo (<player_index> + 1) is_local_client
				if (<is_local_client> != 0)
					GetPlayerInfo (<player_index> + 1) controller
					GetSavegameFromController controller = <controller>
					GetGlobalTags <gig_name> savegame = <savegame> params = completed
					if (<completed> = 0)
						SetGlobalTags <gig_name> params = {completed = 1} savegame = <savegame>
						if NOT ($game_mode = gh4_p1_career)
							change \{allow_career_progression_check = 1}
							change current_progression_savegame = <savegame>
							register_new_progression_atoms ($current_progression_flag) keep_current_savegame
							updated_progression = 1
							change \{allow_career_progression_check = 0}
						endif
					elseif (<completed> = -1)
						SetGlobalTags <gig_name> params = {completed = 2} savegame = <savegame>
					endif
				endif
				player_index = (<player_index> + 1)
				repeat <num_players_shown>
			endif
		endif
		if ($current_level != $final_credits_zone)
			FormatText {
				checksumname = venue_checksum
				'%s_%i'
				s = ($LevelZones.($current_level).name)
				i = ($instrument_list.($<tier_global>.part).text_nl)
				AddToStringLookup = true
			}
			SetGlobalTags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
			FormatText checksumname = venue_checksum 'venue_%s' s = ($LevelZones.($current_level).name)
			SetGlobalTags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
		endif
	endif
	if (<updated_progression> = 0)
		UpdateAtoms \{name = Progression}
	endif
	if IsHost
		SendStructure \{callback = SaveGigComplete
			data_to_send = {
				none
			}}
	endif
	return \{false}
endscript

script SaveGigComplete 
	get_progression_globals ($current_progression_flag)
	setlist_prefix = ($<tier_global>.prefix)
	FormatText \{checksumname = tiername
		'tier%d'
		d = $current_gig_number}
	song_num = 0
	GetArraySize ($<tier_global>.<tiername>.songs)
	song_size = <array_size>
	format_globaltag_gigname setlist_prefix = ($<tier_global>.prefix) gignum = ($current_gig_number)
	SetGlobalTags <gig_name> params = {started = 1}
	GetGlobalTags <gig_name> params = completed
	if (<completed> = 0)
		SetGlobalTags <gig_name> params = {completed = 1}
		change \{allow_career_progression_check = 1}
	elseif (<completed> = -1)
		SetGlobalTags <gig_name> params = {completed = 2}
	endif
	FormatText {
		checksumname = venue_checksum
		'%s_%i'
		s = ($LevelZones.($current_level).name)
		i = ($instrument_list.($<tier_global>.part).text_nl)
		AddToStringLookup = true
	}
	SetGlobalTags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
	FormatText checksumname = venue_checksum 'venue_%s' s = ($LevelZones.($current_level).name)
	SetGlobalTags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
	UpdateAtoms \{name = Progression}
	change \{allow_career_progression_check = 0}
endscript

script quickplay_set_new_song_in_gig_list 
	if ($is_partyplay_mode = 1)
		return \{true}
	endif
	if ($quickplay_song_list_current = -1)
		return \{false}
	endif
	if ($quickplay_song_list_current >= $num_quickplay_song_list)
		return \{false}
	endif
	change quickplay_song_list_current = ($quickplay_song_list_current + 1)
	if ($quickplay_song_list_current >= $num_quickplay_song_list)
		return \{false}
	else
		change current_song = ($quickplay_song_list [($quickplay_song_list_current)])
		return \{true}
	endif
endscript

script quickplay_end_of_gig_list 
	if ($quickplay_song_list_current >= $num_quickplay_song_list)
		return \{true}
	endif
	<quickplay_song_list_current> = ($quickplay_song_list_current + 1)
	if (<quickplay_song_list_current> >= $num_quickplay_song_list)
		return \{true}
	else
		return \{false}
	endif
endscript
progression_check_for_gig_end = ASSERT_ON_USE

script debug_unlock_next_gig \{part = Band}
	temp = $allow_career_progression_check
	change \{allow_career_progression_check = 1}
	progression_flag = Career_Band
	unlock_order = GH4_Career_Band_Progression_Unlock_Order
	if (<part> = guitar)
		<progression_flag> = Career_Guitar
		<unlock_order> = GH4_Career_Guitar_Progression_Unlock_Order
	elseif (<part> = Bass)
		<progression_flag> = Career_Bass
		<unlock_order> = GH4_Career_Bass_Progression_Unlock_Order
	elseif (<part> = drum)
		<progression_flag> = Career_Drum
		<unlock_order> = GH4_Career_Drum_Progression_Unlock_Order
	elseif (<part> = Vocals)
		<progression_flag> = Career_Vocals
		<unlock_order> = GH4_Career_Vocals_Progression_Unlock_Order
	endif
	Progression_Career_Gig_Complete <...> (<progression_flag>)
	change allow_career_progression_check = <temp>
endscript

script register_new_progression_atoms 
	index = ($difficulty_list_props.($player1_status.difficulty).index)
	SetProgressionDifficulty difficulty = <index>
	DeRegisterAtoms
	if NOT GotParam \{keep_current_savegame}
		GetSavegameFromController controller = ($primary_controller)
		change current_progression_savegame = <savegame>
	endif
	get_progression_globals game_mode = ($game_mode) <...>
	if NOT (<progression_global> = none)
		setup_unlock_atoms <...>
		array = $<progression_global>
		GetArraySize \{$Unlock_Atoms}
		if (<array_size> > 0)
			i = 0
			begin
			AddArrayElement array = <array> element = ($Unlock_Atoms [<i>])
			i = (<i> + 1)
			repeat <array_size>
		endif
		RegisterAtoms name = Progression <array>
		UpdateAtoms \{name = Progression}
	endif
endscript

script Progression_Career_Check_Challenge_Complete 
	get_progression_globals game_mode = ($game_mode) ($current_progression_flag)
	format_globaltag_gigname setlist_prefix = ($<tier_global>.prefix) gignum = <gig_num>
	FormatText checksumname = challenge_crc 'challenge%d_completed' d = <challenge_num>
	GetGlobalTags <gig_name>
	if ((<...>.<challenge_crc>) = 1)
		return \{true}
	endif
	return \{false}
endscript

script Check_Gig_Completed_Quick 
	get_progression_globals game_mode = ($game_mode) ($current_progression_flag)
	format_globaltag_gigname setlist_prefix = ($<tier_global>.prefix) gignum = <gig_num>
	GetGlobalTags <gig_name>
	if (<completed> = 1 || <completed> = 2)
		return \{true}
	endif
	return \{false}
endscript

script Progression_Career_Check_Gig_Complete savegame = ($current_progression_savegame)

	get_progression_globals <...>
	setlist_prefix = ($<tier_global>.prefix)
	if GotParam \{gig}
		FormatText checksumname = tier 'tier%d' d = <gig>
		GetArraySize ($<tier_global>.<tier>.songs)
		num_required = <array_size>
		array_entry = 0
		begin
		diff_index = 0
		begin
		format_globaltag_song_checksum part = ($<tier_global>.part) song = ($<tier_global>.<tier>.songs [<array_entry>]) difficulty_index = <diff_index>
		GetGlobalTags <song_checksum> savegame = <savegame> params = stars
		if (<stars> > 2)
			<num_required> = (<num_required> - 1)
			break
		endif
		diff_index = (<diff_index> + 1)
		repeat 5
		<array_entry> = (<array_entry> + 1)
		repeat <array_size>
		if StructureContains Structure = ($<tier_global>.<tier>) unlockable_songs
			GetArraySize ($<tier_global>.<tier>.unlockable_songs)
			num_required = (<num_required> + <array_size>)
			array_entry = 0
			begin
			diff_index = 0
			begin
			format_globaltag_song_checksum part = ($<tier_global>.part) song = ($<tier_global>.<tier>.unlockable_songs [<array_entry>]) difficulty_index = <diff_index>
			GetGlobalTags <song_checksum> savegame = <savegame> params = stars
			if (<stars> > 2)
				<num_required> = (<num_required> - 1)
				break
			endif
			diff_index = (<diff_index> + 1)
			repeat 5
			<array_entry> = (<array_entry> + 1)
			repeat <array_size>
		endif
		if (<num_required> <= 0)
			return \{true}
		endif
	endif
	return \{false}
endscript
allow_career_progression_check = 0

script Progression_Career_Gig_Complete savegame = ($current_progression_savegame)
	if ($allow_career_progression_check = 0)
		return
	endif
	change \{allow_career_progression_check = 0}
	get_progression_globals <...>
	setlist_prefix = ($<tier_global>.prefix)
	set_got_unlocked = 0
	set_num = 1
	begin
	FormatText checksumname = setnum 'unlockset%d' d = <set_num>
	if NOT StructureContains Structure = $<unlock_order> <setnum>
		break
	endif
	set_has_none = 0
	if StructureContains Structure = ($<unlock_order>.<setnum>) none
		set_has_none = 1
		format_globaltag_gigname setlist_prefix = <setlist_prefix> gig = ($<unlock_order>.<setnum>.none)
		GetGlobalTags <gig_name> savegame = <savegame>
		if (<unlocked> = 0)
			SetGlobalTags <gig_name> savegame = <savegame> params = {unlocked = 1 first_time_unlocked = 1}
			return
		endif
	endif
	if (<set_has_none> = 0)
		gig_num = 1
		begin
		FormatText checksumname = gignum 'gig%d' d = <gig_num>
		if NOT StructureContains Structure = ($<unlock_order>.<setnum>) <gignum>
			break
		endif
		gig = ($<unlock_order>.<setnum>.<gignum>.name)
		gig_number = ($<unlock_order>.<setnum>.<gignum>.num)
		format_globaltag_gigname setlist_prefix = <setlist_prefix> gig = <gig>
		GetGlobalTags <gig_name> savegame = <savegame> noassert = 1
		if (<unlocked> = 0)
			SetGlobalTags <gig_name> savegame = <savegame> params = {unlocked = 1 first_time_unlocked = 1}
			<set_got_unlocked> = 1
			FormatText checksumname = tiername 'tier%d' d = <gig_number>
			GetArraySize ($<tier_global>.<tiername>.songs)
			song_index = 0
			begin
			SetGlobalTags ($<tier_global>.<tiername>.songs [<song_index>]) savegame = <savegame> params = {unlocked = 1}
			song_index = (<song_index> + 1)
			repeat <array_size>
		endif
		<gig_num> = (<gig_num> + 1)
		repeat
		if (<set_got_unlocked> = 1)
			return
		endif
	endif
	<set_num> = (<set_num> + 1)
	repeat
endscript

script Progression_ClearDetailedStatsForGig 
	change \{gig_detailed_stats = [
			[
			]
			[
			]
			[
			]
			[
			]
		]}
	change \{gig_detailed_stats_band = {
		}}
endscript

script Progression_UpdateDetailedStatsForGig 
	Progression_ClearDetailedStatsForGig
	<default_song_stats> = {
		song = ($current_song)
	}
	GameMode_GetNumPlayersShown
	if (<num_players_shown> > 0)
		<player_idx> = 0
		begin
		<player> = (<player_idx> + 1)
		GetPlayerInfo <player> is_local_client
		if (<is_local_client> = 1)
			GetPlayerInfo <player> score
			CastToInteger \{score}
			GetPlayerInfo <player> cash_rank_up
			GetPlayerInfo <player> new_cash
			GetPlayerInfo <player> career_earnings
			GetPlayerInfo <player> stars
			GetPlayerInfo <player> notes_hit
			GetPlayerInfo <player> total_notes
			GetPlayerInfo <player> sp_phrases_hit
			GetPlayerInfo <player> sp_phrases_total
			GetPlayerInfo <player> best_run
			GetPlayerInfo <player> max_notes
			GetPlayerInfo <player> vocal_streak_phrases
			GetPlayerInfo <player> vocal_phrase_quality
			GetPlayerInfo <player> vocal_phrase_max_qual
			get_average_multiplier player = <player>
			<avg_multiplier> = <average_multiplier>
			get_song_section_arrays_for_player player = <player>
			<curr_song_stats> = {
				<default_song_stats>
				score = <score>
				stars = <stars>
				notes_hit = <notes_hit>
				best_run = <best_run>
				max_notes = <max_notes>
				total_notes = <total_notes>
				sp_phrases_hit = <sp_phrases_hit>
				sp_phrases_total = <sp_phrases_total>
				avg_multiplier = <avg_multiplier>
				cash_rank_up = <cash_rank_up>
				new_cash = <new_cash>
				career_earnings = <career_earnings>
				vocal_streak_phrases = <vocal_streak_phrases>
				vocal_phrase_quality = <vocal_phrase_quality>
				vocal_phrase_max_qual = <vocal_phrase_max_qual>
				detailed_stats = <detailed_stats>
				detailed_stats_max = <detailed_stats_max>
				section_names = <section_names>
			}
			GetArraySize \{$gig_detailed_stats}
			if (<array_size> < 10)
				<stats_all> = ($gig_detailed_stats)
				<old_stats_player> = (<stats_all> [<player_idx>])
				AddArrayElement array = <old_stats_player> element = <curr_song_stats>
				SetArrayElement ArrayName = stats_all index = <player_idx> newvalue = <array>
				change globalname = gig_detailed_stats newvalue = <stats_all>
			else

			endif
		endif
		<player_idx> = (<player_idx> + 1)
		repeat <num_players_shown>
	endif
	if (($current_num_players) > 1)
		current_band_stats = {
			stars = ($band1_status.stars)
			score = ($band1_status.score)
			high_mult = ($band1_status.high_mult)
			high_2p_streak = ($band1_status.high_2p_streak)
			high_3p_streak = ($band1_status.high_3p_streak)
			high_4p_streak = ($band1_status.high_4p_streak)
		}
		change gig_detailed_stats_band = <current_band_stats>
	endif
endscript

script get_song_section_arrays_for_player 

	<detailed_stats> = []
	<detailed_stats_max> = []
	<section_names> = []
	FormatText checksumname = last_song_stats 'p%p_last_song_detailed_stats' p = <player> AddToStringLookup = true
	FormatText checksumname = last_song_stats_max 'p%p_last_song_detailed_stats_max' p = <player> AddToStringLookup = true
	get_song_section_array player = <player>
	GetArraySize <song_section_array>
	if (<array_size> > 0)
		<detailed_stats> = ($<last_song_stats>)
		<detailed_stats_max> = ($<last_song_stats_max>)
		i = 0
		begin
		FormatText TextName = marker_text qs("\L%s") s = ((<song_section_array> [<i>]).marker)
		AddArrayElement array = <section_names> element = <marker_text>
		<section_names> = <array>
		i = (<i> + 1)
		repeat <array_size>
	endif
	return detailed_stats = <detailed_stats> detailed_stats_max = <detailed_stats_max> section_names = <section_names>
endscript

script progression_gig_get_highest_difficulty_completed 
	get_progression_globals <...> ($current_progression_flag)
	setlist_prefix = ($<tier_global>.prefix)
	highest_diff_completed = 'none'
	highest_diff_index = 4
	if GotParam \{gig}
		FormatText checksumname = tier 'tier%d' d = <gig>
		GetArraySize ($<tier_global>.<tier>.songs)
		num_required = <array_size>
		array_entry = 0
		begin
		song = ($<tier_global>.<tier>.songs [<array_entry>])
		progression_song_get_highest_difficulty_completed song = <song> ($current_progression_flag)
		if (<diff_index> != -1)
			num_required = (<num_required> - 1)
			if (<diff_index> < <highest_diff_index>)
				highest_diff_index = <diff_index>
			endif
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <array_size>
		if (<num_required> <= 0)
			get_difficulty_text_nl difficulty = ($difficulty_list [<highest_diff_index>])
			<highest_diff_completed> = <difficulty_text_nl>
		endif
	endif
	return highest_diff_completed = <highest_diff_completed>
endscript

script progression_song_get_highest_difficulty_completed 
	get_progression_globals <...>
	setlist_prefix = ($<tier_global>.prefix)
	highest_diff_completed = 'none'
	highest_diff_index = -1
	if GotParam \{song}
		diff_index = 0
		GetArraySize \{$difficulty_list}
		diff_size = <array_size>
		begin
		format_globaltag_song_checksum part = ($<tier_global>.part) song = <song> difficulty = ($difficulty_list [<diff_index>])
		GetGlobalTags <song_checksum> params = stars
		if (<stars> > 2)
			get_difficulty_text_nl difficulty = ($difficulty_list [<diff_index>])
			<highest_diff_completed> = <difficulty_text_nl>
			<highest_diff_index> = <diff_index>
		endif
		<diff_index> = (<diff_index> + 1)
		repeat <diff_size>
	endif
	return highest_diff_completed = <highest_diff_completed> diff_index = <highest_diff_index>
endscript

script progression_set_unlocked_for_all_diff 
	get_progression_globals <...>
	setlist_prefix = ($<tier_global>.prefix)
	if GotParam \{song}
		diff_index = 0
		GetArraySize \{$difficulty_list}
		diff_size = <array_size>
		begin
		format_globaltag_song_checksum part = ($<tier_global>.part) song = <song> difficulty = ($difficulty_list [<diff_index>])
		SetGlobalTags <song_checksum> params = {unlocked = 1}
		<diff_index> = (<diff_index> + 1)
		repeat <diff_size>
	endif
endscript

script progression_song_get_best_difficulty_completed 
	get_progression_globals <...>
	setlist_prefix = ($<tier_global>.prefix)
	best_stars = 0
	if GotParam \{song}
		diff_index = 0
		GetArraySize \{$difficulty_list}
		diff_size = <array_size>
		begin
		format_globaltag_song_checksum part = ($<tier_global>.part) song = <song> difficulty = ($difficulty_list [<diff_index>])
		GetGlobalTags <song_checksum> params = stars
		GetGlobalTags <song_checksum> param = unlocked
		if (<stars> > <best_stars>)
			best_stars = <stars>
		endif
		<diff_index> = (<diff_index> + 1)
		repeat <diff_size>
	endif
	return {stars = <best_stars> song_checksum = <song_checksum>}
endscript

script progression_get_total_stars 
	get_progression_globals game_mode = ($game_mode) ($current_progression_flag)
	songlist = <tier_global>
	total_stars = 0
	tier = 1
	begin
	setlist_prefix = ($<songlist>.prefix)
	FormatText checksumname = tiername '%ptier%i' p = <setlist_prefix> i = <tier>
	FormatText checksumname = tier_checksum 'tier%s' s = <tier>
	GetArraySize ($<songlist>.<tier_checksum>.songs)
	unlocked = 0
	format_globaltag_gigname setlist_prefix = <setlist_prefix> gignum = <tier>
	GetGlobalTags <gig_name>
	array_count = 0
	begin
	RemoveParameter \{stars}
	RemoveParameter \{unlocked}
	progression_song_get_best_difficulty_completed song = ($<songlist>.<tier_checksum>.songs [<array_count>]) game_mode = ($game_mode) ($current_progression_flag)
	total_stars = (<total_stars> + <stars>)
	array_count = (<array_count> + 1)
	repeat <array_size>
	if StructureContains Structure = ($<songlist>.<tier_checksum>) unlockable_songs
		GetArraySize ($<songlist>.<tier_checksum>.unlockable_songs)
		array_count = 0
		begin
		RemoveParameter \{stars}
		RemoveParameter \{unlocked}
		progression_song_get_best_difficulty_completed song = ($<songlist>.<tier_checksum>.unlockable_songs [<array_count>]) game_mode = ($game_mode) ($current_progression_flag)
		total_stars = (<total_stars> + <stars>)
		array_count = (<array_count> + 1)
		repeat <array_size>
	endif
	tier = (<tier> + 1)
	repeat ($<songlist>.num_tiers)
	return {total_stars = <total_stars>}
endscript

script progression_check_intro_complete 
	return \{true}
	get_current_band_info
	GetGlobalTags <band_info>
	GetPlayerInfo \{1
		part}
	if ($current_num_players > 1)
		part = Band
		if ($band_mode_active = 0)
			return \{false}
		endif
	endif
	switch <part>
		case guitar
		check = <career_intro_guitar_complete>
		case Bass
		check = <career_intro_bass_complete>
		case drum
		check = <career_intro_drum_complete>
		case Vocals
		check = <career_intro_vocals_complete>
		case Band
		check = <career_intro_band_complete>
	endswitch
	if (<check> = 0)
		return \{false}
	endif
	return \{true}
endscript

script progression_set_intro_complete 
	get_current_band_info
	GetGlobalTags <band_info>
	GetPlayerInfo \{1
		part}
	if ($current_num_players > 1)
		part = Band
	endif
	switch <part>
		case guitar
		SetGlobalTags <band_info> params = {career_intro_guitar_complete = 1}
		case Bass
		SetGlobalTags <band_info> params = {career_intro_bass_complete = 1}
		case drum
		SetGlobalTags <band_info> params = {career_intro_drum_complete = 1}
		case Vocals
		SetGlobalTags <band_info> params = {career_intro_vocals_complete = 1}
		case Band
		SetGlobalTags <band_info> params = {career_intro_band_complete = 1}
	endswitch
endscript

script progression_should_show_credits 
	if (($debug_unlock_all) = 1)
		return \{false}
	endif
	get_current_band_info
	GetGlobalTags <band_info>
	GetPlayerInfo \{1
		part}
	if ($current_num_players > 1)
		part = Band
		if ($band_mode_active = 0)
			return \{false}
		endif
	endif
	switch <part>
		case guitar
		check = <career_credits_guitar_complete>
		case Bass
		check = <career_credits_bass_complete>
		case drum
		check = <career_credits_drum_complete>
		case Vocals
		check = <career_credits_vocals_complete>
		case Band
		check = <career_credits_band_complete>
	endswitch
	if (<check> = 0)
		if progression_check_final_song_complete part = <part>
			change \{end_credits = 1}
			return \{true}
		endif
	endif
	return \{false}
endscript

script progression_set_credits_complete 
	get_current_band_info
	GetGlobalTags <band_info>
	GetPlayerInfo \{1
		part}
	if ($current_num_players > 1)
		part = Band
	endif
	switch <part>
		case guitar
		SetGlobalTags <band_info> params = {career_credits_guitar_complete = 1}
		case Bass
		SetGlobalTags <band_info> params = {career_credits_bass_complete = 1}
		case drum
		SetGlobalTags <band_info> params = {career_credits_drum_complete = 1}
		case Vocals
		SetGlobalTags <band_info> params = {career_credits_vocals_complete = 1}
		case Band
		SetGlobalTags <band_info> params = {career_credits_band_complete = 1}
	endswitch
endscript

script progression_check_final_song_complete 

	switch (<part>)
		case Band
		progression_array = GH4_Career_Band_Songs
		case guitar
		progression_array = GH4_Career_Guitar_Songs
		case Bass
		progression_array = GH4_Career_Bass_Songs
		case drum
		progression_array = GH4_Career_Drum_Songs
		case Vocals
		progression_array = GH4_Career_Vocals_Songs
	endswitch
	<tier_num> = ($<progression_array>.num_tiers - 1)
	if (<tier_num> < 1)
		return \{false}
	endif
	FormatText checksumname = tier 'tier%s' s = <tier_num>
	if StructureContains Structure = ($<progression_array>.<tier>) unlockable_songs
		GetArraySize ($<progression_array>.<tier>.unlockable_songs)
		song = ($<progression_array>.<tier>.unlockable_songs [(<array_size> - 1)])
	else
		return \{false}
	endif
	diff_index = 0
	begin
	format_globaltag_song_checksum part = <part> song = <song> difficulty_index = <diff_index>
	GetGlobalTags <song_checksum> params = stars
	if (<stars> > 2)
		return \{true}
	endif
	diff_index = (<diff_index> + 1)
	repeat 5
	return \{false}
endscript

script progression_check_all_songs_complete 

	progression_flag = Career_Guitar
	switch (<part>)
		case Bass
		progression_flag = Career_Bass
		case drum
		progression_flag = Career_Drum
		case Vocals
		progression_flag = Career_Vocals
		case Band
		progression_flag = Career_Band
	endswitch
	get_progression_globals (<progression_flag>)

	total_songs = 0
	completed_songs = 0
	num_tiers = ($<tier_global>.num_tiers)
	tier_num = 1
	begin
	FormatText checksumname = tiername 'tier%d' d = <tier_num>
	go_through_songs = 1
	if StructureContains Structure = ($<tier_global>.<tiername>) debug_gig
		go_through_songs = 0
	endif
	if StructureContains Structure = ($<tier_global>.<tiername>) createagig
		go_through_songs = 0
	endif
	if (<go_through_songs> = 1)
		GetArraySize ($<tier_global>.<tiername>.songs)
		song_index = 0
		begin
		song = ($<tier_global>.<tiername>.songs [<song_index>])
		diff_index = 0
		begin
		format_globaltag_song_checksum part = ($<tier_global>.part) song = <song> difficulty_index = <diff_index>
		GetGlobalTags <song_checksum> params = stars
		if (<stars> > 2)
			completed_songs = (<completed_songs> + 1)
			break
		endif
		diff_index = (<diff_index> + 1)
		repeat 5
		total_songs = (<total_songs> + 1)
		song_index = (<song_index> + 1)
		repeat <array_size>
		if StructureContains Structure = ($<tier_global>.<tiername>) unlockable_songs
			GetArraySize ($<tier_global>.<tiername>.unlockable_songs)
			song_index = 0
			begin
			song = ($<tier_global>.<tiername>.unlockable_songs [<song_index>])
			diff_index = 0
			begin
			format_globaltag_song_checksum part = ($<tier_global>.part) song = <song> difficulty_index = <diff_index>
			GetGlobalTags <song_checksum> params = stars
			if (<stars> > 2)
				completed_songs = (<completed_songs> + 1)
				break
			endif
			diff_index = (<diff_index> + 1)
			repeat 5
			total_songs = (<total_songs> + 1)
			song_index = (<song_index> + 1)
			repeat <array_size>
		endif
	endif
	tier_num = (<tier_num> + 1)
	repeat <num_tiers>
	if (<total_songs> = <completed_songs>)
		return \{true}
	else
		return \{false}
	endif
endscript
