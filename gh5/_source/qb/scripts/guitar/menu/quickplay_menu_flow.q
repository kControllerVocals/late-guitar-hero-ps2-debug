
script set_random_partyplay_song 
	begin
	GetRandomArrayElement \{$gh5_songlist}
	<current_song> = <element>
	if ($current_song != <current_song>)
		if IsSongAvailable song = <current_song>
			break
		endif
	endif
	repeat
	change current_song = <current_song>
	get_song_struct song = ($current_song)
	if StructureContains Structure = <song_struct> name = venue_set
		venue_set = (<song_struct>.venue_set)
		level_checksum = ($current_level)
		FormatText checksumname = venue_checksum 'load_%s' s = ($LevelZones.<level_checksum>.name)
		if NOT ArrayContains array = $<venue_set> contains = <venue_checksum>
			quickplay_choose_random_venue
		endif
	endif
	return new_partyplay_song = <current_song>
endscript

script quickplay_go_to_practice_setup 
	change \{came_to_practice_from = quickplay}
	change came_to_practice_difficulty = ($player1_status.difficulty)
	kill_gem_scroller
	change \{game_mode = practice}
endscript

script quickplay_song_select_quit 
	GH3_SFX_fail_song_stop_sounds
	kill_gem_scroller
endscript

script get_total_num_venues 

	array_entry = 0
	begin
	if NOT get_valid_venue_index venue_index = <array_entry>
		break
	endif
	get_LevelZoneArray_checksum index = <index>

	<array_entry> = (<array_entry> + 1)
	repeat
	return num_venues = <array_entry>
endscript

script get_valid_venue_index 
	get_LevelZoneArray_size
	index = 0
	begin
	get_LevelZoneArray_checksum index = <index>
	valid = 1
	FormatText checksumname = venue_checksum 'venue_%s' s = ($LevelZones.<level_checksum>.name)
	GetGlobalTags <venue_checksum>
	if NOT (<unlocked> = 1)
		valid = 0
	endif
	if (<valid> = 1)
		if (<venue_index> = 0)
			return index = <index> true
		endif
		venue_index = (<venue_index> - 1)
	endif
	index = (<index> + 1)
	repeat <array_size>
	return \{false}
endscript
force_quickplay_guitarist = none

script quickplay_start_song \{device_num = 0}

	if (($current_num_players) = 1)
		change \{structurename = player1_status
			character_id = RandomCharacter}
		if NOT ($force_quickplay_guitarist = none)
			change structurename = player1_status character_id = ($force_quickplay_guitarist)
		endif
	endif
	if ($autolaunch_startnow = 0 &&
			$end_credits = 0)
		get_progression_globals game_mode = ($game_mode)
		songlist = <tier_global>
		if ($band_mode_mode = none && $current_num_players = 1)
			set_random_single_player_quickplay
		endif
		quickplay_choose_random_venue <...>
	endif
	start_song {device_num = <device_num> StartTime = <StartTime> uselaststarttime = <uselaststarttime>}
endscript

script set_random_single_player_quickplay 
	if (($current_num_players) > 1)

	endif
	cas_reset_random_human_picking
	i = 0
	begin
	<player_status> = ($player_status_array [<i> + 1])
	choice = Random (@ 0 @ 1 @ 2 )
	controller = ($<player_status>.controller)
	part = ($<player_status>.part)
	get_savegame_from_controller controller = <controller>
	if ((<choice> = 0) || (<part> = Vocals))
		character_id = RandomCharacter
	elseif (<choice> = 1)
		if NOT cas_get_random_car savegame = <savegame> controller = <controller>
			cas_get_random_preset_character savegame = <savegame> controller = <controller> part = <part>
		endif
	else
		cas_get_random_preset_character savegame = <savegame> controller = <controller> part = <part>
	endif
	change structurename = <player_status> character_id = <character_id>
	i = (<i> + 1)
	repeat $current_num_players
	cas_reset_random_human_picking
endscript
g_levels_to_remove_from_random_rotation = {
}

script quickplay_choose_random_venue 
	if NOT GotParam \{can_change_level}
		can_change_level = 1
	endif
	if ($current_song = jamsession)
		change \{current_level = load_z_studio}
	else
		if ($bc_forced_quickplay_venue != none)
			debug_Printf \{qs(0xb84deb68)}
			change current_level = ($bc_forced_quickplay_venue)
		else
			get_song_struct song = ($current_song)
			if StructureContains Structure = <song_struct> name = venue_set
				venue_set = (<song_struct>.venue_set)
				GetArraySize $<venue_set>
				GetRandomValue a = 0 b = (<array_size> -1) name = random_venue_index Integer
				change current_level = (($<venue_set>) [<random_venue_index>])
				song = ($current_song)
				begin
				level_checksum = ($current_level)
				FormatText checksumname = venue_checksum 'venue_%s' s = ($LevelZones.<level_checksum>.name)
				GetGlobalTags <venue_checksum> param = unlocked
				if (<unlocked> = 1)
					break
				endif
				GetArraySize $<venue_set>
				GetRandomValue a = 0 b = (<array_size> -1) name = random_venue_index Integer
				change current_level = (($<venue_set>) [<random_venue_index>])
				repeat
			else
				change \{current_level = load_Z_Subway}
			endif
		endif
	endif
endscript
