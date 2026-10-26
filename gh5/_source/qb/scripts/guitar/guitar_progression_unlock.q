new_unlockables = [
]
Unlock_Atoms = [
]

script execute_unlock_atoms 
	GameMode_GetNumPlayersShown
	trim_boss_from_num_players_show
	player_idx = 1
	begin
	GetPlayerInfo <player_idx> is_local_client
	if (<is_local_client> = 1)
		<player_status> = ($player_status_array [<player_idx>])
		get_savegame_from_player_status player_status = <player_status>
		change current_progression_savegame = <savegame>
		register_new_progression_atoms ($current_progression_flag) keep_current_savegame
	endif
	player_idx = (<player_idx> + 1)
	repeat <num_players_shown>
endscript

script setup_unlock_atoms 

	progression_get_total_stars
	change progression_total_stars_unlocked = <total_stars>
	change \{Unlock_Atoms = [
		]}
	if GotParam \{Career_Band}
		setup_unlock_atoms_band
	elseif GotParam \{Career_Guitar}
		setup_unlock_atoms_guitar
	elseif GotParam \{Career_Bass}
		setup_unlock_atoms_bass
	elseif GotParam \{Career_Drum}
		setup_unlock_atoms_drums
	elseif GotParam \{Career_Vocals}
		setup_unlock_atoms_vocals
	endif
endscript

script setup_unlock_atoms_generic 

	atoms = ($Unlock_Atoms)
	switch (<part>)
		case 'band'
		bonus_params = {Career_Band}
		tier_global = GH4_Career_Band_Songs
		case 'guitar'
		bonus_params = {Career_Guitar}
		tier_global = GH4_Career_Guitar_Songs
		case 'bass'
		bonus_params = {Career_Bass}
		tier_global = GH4_Career_Bass_Songs
		case 'drum'
		bonus_params = {Career_Drum}
		tier_global = GH4_Career_Drum_Songs
		case 'vocals'
		bonus_params = {Career_Vocals}
		tier_global = GH4_Career_Vocals_Songs
	endswitch
	reward_array = $progression_guitar_rewards
	GetArraySize <reward_array>
	if (<array_size> > 0)
		i = 0
		begin
		current_reward = (<reward_array> [<i>])
		FormatText checksumname = name 'career_%p_reward_%n' p = <part> n = <i> AddToStringLookup = true
		RemoveParameter \{atom}
		if StructureContains Structure = <current_reward> stars
			atom = {
				name = <name>
				type = Scr
				atom_script = progression_add_new_unlocks
				atom_params = {<current_reward> name = <name> part = <part>}
				depends_on = [
					{
						type = Scr
						Scr = progression_check_for_total_stars
						params = {stars = (<current_reward>.stars)}
					}
				]
				permanent = false
			}
		elseif StructureContains Structure = <current_reward> venue_stars
			atom = {
				name = <name>
				type = Scr
				atom_script = progression_add_new_unlocks
				atom_params = {<current_reward> name = <name> part = <part>}
				depends_on = [
					{
						type = Scr
						Scr = progression_check_for_total_venue_stars
						params = {venue_stars = (<current_reward>.venue_stars) tier_index = (<current_reward>.tier_index) part = <part>}
					}
				]
				permanent = false
			}
		elseif StructureContains Structure = <current_reward> song
			atom = {
				name = <name>
				type = Scr
				atom_script = progression_add_new_unlocks
				atom_params = {<current_reward> name = <name> part = <part>}
				depends_on = [
					{
						type = Scr
						Scr = progression_check_for_song_complete
						params = {part = <part> song = (<current_reward>.song)}
					}
				]
				permanent = false
			}
		endif
		if GotParam \{atom}
			AddArrayElement array = <atoms> element = <atom>
			atoms = <array>
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	change Unlock_Atoms = <atoms>
	return {index = <index> bonus_params = <bonus_params> reward_array = <reward_array>}
endscript

script setup_unlock_atoms_band 
	setup_unlock_atoms_generic \{part = 'band'}
	atoms = ($Unlock_Atoms)
	change Unlock_Atoms = <atoms>
endscript

script setup_unlock_atoms_guitar 
	setup_unlock_atoms_generic \{part = 'guitar'}
	atoms = ($Unlock_Atoms)
	change Unlock_Atoms = <atoms>
endscript

script setup_unlock_atoms_bass 
	setup_unlock_atoms_generic \{part = 'bass'}
	atoms = ($Unlock_Atoms)
	change Unlock_Atoms = <atoms>
endscript

script setup_unlock_atoms_drums 
	setup_unlock_atoms_generic \{part = 'drum'}
	atoms = ($Unlock_Atoms)
	change Unlock_Atoms = <atoms>
endscript

script setup_unlock_atoms_vocals 
	setup_unlock_atoms_generic \{part = 'vocals'}
	atoms = ($Unlock_Atoms)
	change Unlock_Atoms = <atoms>
endscript

script progression_add_new_unlocks 


	if ($ps2_car_part_scripts_loaded = 0)
		unload_song_anims
		ps2_load_car_part_script
	endif
	new_unlockables_array = ($new_unlockables)
	if GotParam \{car_pieces}
		GetArraySize <car_pieces>
		my_array = []
		if (<array_size> > 0)
			i = 0
			begin
			if NOT is_part_unlocked part = ((<car_pieces> [<i>]).part) desc_id = ((<car_pieces> [<i>]).desc_id) savegame = ($current_progression_savegame)
				set_current_band_part_flags part = ((<car_pieces> [<i>]).part) desc_id = ((<car_pieces> [<i>]).desc_id) unlocked savegame = ($current_progression_savegame)
				get_savegame_from_controller controller = ($primary_controller)
				if (<savegame> = ($current_progression_savegame))
					AddArrayElement array = <my_array> element = (<car_pieces> [<i>])
					my_array = <array>
				endif
			endif
			i = (<i> + 1)
			repeat <array_size>
		endif
		GetArraySize <my_array>
		if (<array_size> > 0)
			if NOT GotParam \{hidden}
				if NOT GotParam \{unlocking_car_pieces_with_character}
					if GotParam \{unlock_icon}
						AddArrayElement array = <new_unlockables_array> element = {type = car_pieces group_name = <group_name> char_pieces = <my_array> unlock_icon = <unlock_icon>}
					elseif GotParam \{group_name}
						AddArrayElement array = <new_unlockables_array> element = {type = car_pieces group_name = <group_name> char_pieces = <my_array>}
					else
						AddArrayElement array = <new_unlockables_array> element = {type = car_pieces char_pieces = <my_array>}
					endif
					new_unlockables_array = <array>
					changed = 1
				endif
			endif
		endif
	endif
	if GotParam \{character}
		get_musician_profile_struct_by_id id = <character> savegame = ($current_progression_savegame)
		if NOT is_profile_unlocked savegame = ($current_progression_savegame) profile_struct = <profile_struct>
			unlock_profile id = <character> savegame = ($current_progression_savegame)
			get_savegame_from_controller controller = ($primary_controller)
			if (<savegame> = ($current_progression_savegame))
				AddArrayElement array = <new_unlockables_array> element = {type = character item = <character> group_name = <group_name> unlock_icon = <unlock_icon>}
				new_unlockables_array = <array>
				changed = 1
			endif
		endif
	endif
	if GotParam \{unlockable_song}
		difficulties = ['beginner' , 'easy' , 'medium' , 'hard' , 'expert']
		GetArraySize <difficulties>
		song_name = ($permanent_songlist_props.<unlockable_song>.name)
		i = 0
		begin
		FormatText checksumname = song_checksum '%s%p%d' s = <song_name> p = <part> d = (<difficulties> [<i>])
		SetGlobalTags <song_checksum> params = {unlocked = 1}
		<i> = (<i> + 1)
		repeat <array_size>
	endif
	get_savegame_from_controller controller = ($primary_controller)
	if (<savegame> = ($current_progression_savegame))
		if GotParam \{level}
			if GotParam \{stars}
				progression_get_total_stars
				unlock_stars = <stars>
				if isSinglePlayerGame
					GetPlayerInfo \{1
						part}
				else
					part = Band
				endif
				FormatText {
					checksumname = venue_checksum
					'%s_%i'
					s = ($LevelZones.<level>.name)
					i = ($instrument_list.<part>.text_nl)
				}
				if GlobalTagExists <venue_checksum> noassert = 1
					GetGlobalTags <venue_checksum> param = unlocked
					SetGlobalTags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
					if (<unlocked> = 0)
						AddArrayElement array = <new_unlockables_array> element = {type = level item = <level>}
						new_unlockables_array = <array>
						changed = 1
						FormatText checksumname = venue_checksum 'venue_%s' s = ($LevelZones.<level>.name)
						if GlobalTagExists <venue_checksum> noassert = 1
							SetGlobalTags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
						endif
					endif
				endif
			elseif GotParam \{song}
				if isSinglePlayerGame
					GetPlayerInfo \{1
						part}
				else
					part = Band
				endif
				FormatText {
					checksumname = venue_checksum
					'%s_%i'
					s = ($LevelZones.<level>.name)
					i = ($instrument_list.<part>.text_nl)
				}
				if GlobalTagExists <venue_checksum> noassert = 1
					GetGlobalTags <venue_checksum> param = unlocked
					SetGlobalTags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
					if (<unlocked> = 0)
						AddArrayElement array = <new_unlockables_array> element = {type = level item = <level>}
						new_unlockables_array = <array>
						changed = 1
						FormatText checksumname = venue_checksum 'venue_%s' s = ($LevelZones.<level>.name)
						if GlobalTagExists <venue_checksum> noassert = 1
							SetGlobalTags <venue_checksum> all_active_players = 1 params = {unlocked = 1}
						endif
					endif
				endif
			endif
		endif
	endif
	if GotParam \{changed}
		change new_unlockables = <new_unlockables_array>
	endif

endscript

script progression_get_new_unlocks 

	return {new_unlocks = ($new_unlockables)}
endscript

script progression_reset_new_unlocks 

	change \{new_unlockables = [
		]}
endscript

script progression_check_for_5_stars \{part = 'guitar'}
	FormatText checksumname = tier_global 'gh4_career_%p_songs' p = <part>
	setlist_prefix = ($<tier_global>.prefix)
	songs_completed = 0
	num_songs = 0
	tier_num = 1
	begin
	FormatText checksumname = tier 'tier%d' d = <tier_num>
	GetArraySize ($<tier_global>.<tier>.songs)
	songlist_size = <array_size>
	song_count = 0
	begin
	<song> = ($<tier_global>.<tier>.songs [<song_count>])
	if NOT progression_check_for_song_5_stars song = <song> part = <part>
		return \{false}
	endif
	<song_count> = (<song_count> + 1)
	repeat <songlist_size>
	tier_num = (<tier_num> + 1)
	repeat ($<tier_global>.num_tiers)
	return \{true}
endscript

script progression_check_for_song_5_stars 

	if NOT StructureContains Structure = ($gh_songlist_props.<song>) never_show_in_setlist
		get_song_saved_in_globaltags song = <song>
		get_song_allowed_in_quickplay song = <song>
		if NOT ((<saved_in_globaltags> = 1) && (<allowed_in_quickplay> = 1))
			return \{true}
		endif
	else
		return \{true}
	endif
	difficulties = ['Beginner' , 'Easy' , 'Medium' , 'Hard' , 'Expert']
	<song_name> = ($permanent_songlist_props.<song>.name)
	i = 0
	begin
	FormatText checksumname = song_checksum '%s%p%d' s = <song_name> p = <part> d = (<difficulties> [<i>])
	GetGlobalTags <song_checksum> params = {stars} savegame = ($current_progression_savegame)
	if (<stars> = 5)
		return \{true}
	endif
	i = (<i> + 1)
	repeat 5
	return \{false}
endscript

script progression_check_for_song_complete 

	if NOT StructureContains Structure = $permanent_songlist_props <song>
		return \{false}
	endif
	difficulties = ['Beginner' , 'Easy' , 'Medium' , 'Hard' , 'Expert']
	<song_name> = ($permanent_songlist_props.<song>.name)
	i = 0
	begin
	FormatText checksumname = song_checksum '%s%p%d' s = <song_name> p = <part> d = (<difficulties> [<i>])
	GetGlobalTags <song_checksum> params = {stars} savegame = ($current_progression_savegame)
	if (<stars> >= 3)
		return \{true}
	endif
	i = (<i> + 1)
	repeat 5
	return \{false}
endscript

script progression_check_for_total_stars 

	total_stars = ($progression_total_stars_unlocked)

	if (<stars> <= <total_stars>)
		return \{true}
	endif
	return \{false}
endscript

script progression_check_for_total_venue_stars 

	switch (<part>)
		case 'band'
		tier_global = GH4_Career_Band_Songs
		case 'guitar'
		tier_global = GH4_Career_Guitar_Songs
		case 'bass'
		tier_global = GH4_Career_Bass_Songs
		case 'drum'
		tier_global = GH4_Career_Drum_Songs
		case 'vocals'
		tier_global = GH4_Career_Vocals_Songs
	endswitch
	FormatText checksumname = tier 'tier%s' s = <tier_index>
	difficulties = [beginner , easy , medium , hard , expert]
	num_difficulties = 5
	i = 0
	venue_stars_earned = 0
	GetArraySize ($<tier_global>.<tier>.songs)
	begin
	j = 0
	most_stars = 0
	begin
	format_globaltag_song_checksum song = ($<tier_global>.<tier>.songs [<i>]) part_text = <part> difficulty = (<difficulties> [<j>])
	GetGlobalTags <song_checksum> param = stars
	if (<stars> > <most_stars>)
		<most_stars> = <stars>
	endif
	<j> = (<j> + 1)
	repeat <num_difficulties>
	<venue_stars_earned> = (<venue_stars_earned> + <most_stars>)
	<i> = (<i> + 1)
	repeat <array_size>
	if StructureContains Structure = ($<tier_global>.<tier>) unlockable_songs
		<i> = 0
		GetArraySize ($<tier_global>.<tier>.unlockable_songs)
		begin
		j = 0
		most_stars = 0
		begin
		format_globaltag_song_checksum song = ($<tier_global>.<tier>.unlockable_songs [<i>]) part_text = <part> difficulty = (<difficulties> [<j>])
		GetGlobalTags <song_checksum> param = stars
		if (<stars> > <most_stars>)
			<most_stars> = <stars>
		endif
		<j> = (<j> + 1)
		repeat <num_difficulties>
		<venue_stars_earned> = (<venue_stars_earned> + <stars>)
		<i> = (<i> + 1)
		repeat <array_size>
	endif
	if (<venue_stars_earned> >= <venue_stars>)
		return \{true}
	else
		return \{false}
	endif
endscript
