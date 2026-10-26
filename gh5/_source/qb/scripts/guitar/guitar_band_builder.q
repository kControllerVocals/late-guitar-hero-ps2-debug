band_builder_current_setup = [
]
band_builder_current_gig_genre = none
use_worst_band = 0
band_builder_part_constants = {
	guitar = {
		default_name = Guitarist
		create_func = create_guitarist
		start_anims = guitarist_start_anims
	}
	vocals_and_guitar = {
		default_name = vocalist
		create_func = create_guitarist
		start_anims = guitarist_start_anims
	}
	rhythm = {
		default_name = Guitarist
		create_func = create_guitarist
		start_anims = guitarist_start_anims
	}
	Bass = {
		default_name = bassist
		create_func = create_bassist
		start_anims = bassist_start_anims
	}
	drum = {
		default_name = Drummer
		create_func = create_drummer
		start_anims = drummer_start_anims
	}
	Vocals = {
		default_name = vocalist
		create_func = create_vocalist
		start_anims = vocalist_start_anims
	}
}

script band_builder_clear_setup 
	change \{band_builder_current_setup = [
		]}
endscript

script band_builder_clear_random_appearances 
	if GotParam \{cpu_only}
		i = 0
		GetArraySize \{$band_builder_random_appearances}
		if (<array_size> > 0)
			begin
			RemoveParameter \{delete}
			if NOT StructureContains Structure = ($band_builder_random_appearances [<i>]) player_status
				delete = 1
			elseif NOT GotParam \{cpu_only}
				delete = 1
			endif
			if GotParam \{delete}
				remove_random_character_from_player_status random_id = (($band_builder_random_appearances [<i>]).character_id)
				RemoveArrayElement array = ($band_builder_random_appearances) index = <i>
				change band_builder_random_appearances = <array>
				RemoveParameter \{array}
			else
				i = (<i> + 1)
			endif
			repeat <array_size>
		endif
	else
		change \{band_builder_random_appearances = [
			]}
	endif
endscript

script remove_random_character_from_player_status 
	GetMaxPlayers
	player = 1
	begin
	GetPlayerInfo <player> character_id
	if (<character_id> = <random_id>)
		if band_builder_is_finalized_random character_id = <character_id>
			SetPlayerInfo <player> character_id = judy

		endif
	endif
	player = (<player> + 1)
	repeat <max_players>
endscript

script band_builder_check_valid_part 
	if ((<part> = Bass) || (<part> = rhythm) || (<part> = guitar) || (<part> = drum) || (<part> = Vocals))
		return
	endif

endscript

script band_builder_has_part 
	band_builder_check_valid_part part = <part>
	i = 0
	GetArraySize \{$band_builder_current_setup}
	if (<array_size> > 0)
		begin
		if StructureContains Structure = (($band_builder_current_setup) [<i>]) part
			if ((($band_builder_current_setup) [<i>]).part = <part>)
				return \{true}
			endif
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
endscript

script band_builder_get_num_each_gender 
	females = 0
	males = 0
	GetArraySize \{$band_builder_current_setup}
	if (<array_size> > 0)
		i = 0
		begin
		character_id = (($band_builder_current_setup [<i>]).character_id)
		if band_builder_is_finalized_character character_id = <character_id>
			savegame = (($band_builder_current_setup [<i>]).savegame)
			get_musician_profile_struct_by_id id = <character_id> savegame = <savegame>
			get_is_female_from_appearance appearance = (<profile_struct>.appearance)
			if (<is_female> = 1)
				females = (<females> + 1)
			else
				males = (<males> + 1)
			endif
		else
			if (<character_id> = RandomFemale)
				females = (<females> + 1)
			elseif (<character_id> = RandomMale)
				males = (<males> + 1)
			endif
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	return females = <females> males = <males>
endscript

script band_builder_add_member 

	if NOT GotParam \{real_part}
		real_part = <part>
	endif
	band_builder_check_valid_part part = <part>
	band_builder_check_valid_part part = <real_part>
	if band_builder_is_full

	endif
	name = ($band_builder_part_constants.<part>.default_name)
	create_func = ($band_builder_part_constants.<real_part>.create_func)

	if band_builder_has_part part = <part>
		ExtendCRC <name> '2' out = name
	endif
	if GotParam \{song_struct}
		if StructureContains Structure = <song_struct> Band
			band_struct = (<song_struct>.Band)
			if StructureContains Structure = <band_struct> name
				specified_character_id = ($<band_struct>.<name>)
				if (<specified_character_id> != RandomCharacter)
					character_id = <specified_character_id>

				endif
			endif
		else

		endif
	endif
	if ($game_mode = practice || $game_mode = tutorial)
		character_id = EmptyGuy
	endif
	if GotParam \{player_status}
		if ($<player_status>.is_local_client = 1)
			get_savegame_from_player_status player_status = <player_status>
		else
			get_savegame_from_controller controller = ($primary_controller)
		endif
	else
		get_savegame_from_controller controller = ($primary_controller)
	endif
	if NOT band_builder_is_random character_id = <character_id>
		if NOT profile_exists id = <character_id> savegame = <savegame>

			cas_get_random_preset_character savegame = <savegame> part = <part>

			if GotParam \{player_status}
				change structurename = <player_status> character_id = <character_id>
			endif
		endif
	endif
	if (<part> = drum)
		if NOT fix_disallowed_character_choice character_id = <character_id> savegame = <savegame> part = <part>

			if GotParam \{player_status}
				change structurename = <player_status> character_id = <character_id>
			endif
		endif
	endif
	entry = {
		part = <part>
		real_part = <real_part>
		name = <name>
		create_func = <create_func>
		character_id = <character_id>
		player_status = <player_status>
		savegame = <savegame>
	}
	AddArrayElement array = ($band_builder_current_setup) element = <entry>
	change band_builder_current_setup = <array>
endscript

script fix_disallowed_character_choice 

	if NOT band_builder_is_random character_id = <character_id>
		get_musician_profile_struct_by_id id = <character_id> savegame = <savegame>
		if NOT is_allowed_part profile_struct = <profile_struct> part = <part>

			cas_get_random_preset_character savegame = <savegame> part = <part>

			return false character_id = <character_id>
		endif
	endif
	return true character_id = <character_id>
endscript

script band_builder_is_full 
	GetArraySize \{$band_builder_current_setup}
	if (<array_size> = 4)
		return \{true}
	endif
	return \{false}
endscript

script get_band_member_player_status \{part = guitar}
	GameMode_GetNumPlayersShown
	i = 1
	begin
	<player_status> = ($player_status_array [<i>])
	if (($<player_status>.part) = <part>)
		return band_member_player_status = <player_status>
	endif
	i = (<i> + 1)
	repeat <num_players_shown>
endscript

script band_builder_add_players 
	band_builder_get_band_global

	GameMode_GetNumPlayersShown


	i = 0
	begin
	<player_status> = ($player_status_array [<i> + 1])
	character_id = ($<player_status>.character_id)
	get_player_part <...>
	if NOT (<part> = none)
		if NOT ($<player_status>.part = drum || $<player_status>.part = Vocals)
			if ($game_mode = p2_pro_faceoff)
				if (<i> = 0)
					part = guitar
				elseif (<i> = 1)
					part = Bass
				endif
			endif
		endif
		if (<part> = Vocals)
			if has_singing_guitarist <...>
				real_part = vocals_and_guitar
			else
				real_part = Vocals
			endif
		else
			real_part = <part>
		endif
		if band_builder_has_part \{part = guitar}
			if (<part> = guitar)
				part = Bass
			endif
		endif
		if band_builder_has_part \{part = Bass}
			if (<part> = Bass)
				part = guitar
			endif
		endif
		if NOT ($use_worst_band = 0)
			if ($use_worst_band = Male)
				globalworstname = worst_male_band
			else
				globalworstname = worst_female_band
			endif
			switch <part>
				case rhythm
				case Bass
				character_id = ($<globalworstname>.bassist)
				case drum
				character_id = ($<globalworstname>.Drummer)
				case Vocals
				character_id = ($<globalworstname>.vocalist)
				case guitar
				character_id = ($<globalworstname>.Guitarist)
			endswitch
		endif
		if (<part> = Vocals)
			if ($game_mode = p1_quickplay)
			endif
			if (<character_id> = RandomCharacter)
				if band_builder_get_cpu_singer_id \{always_random = true}
					character_id = <singer_id>
				endif
			endif
		endif

		band_builder_add_member {
			part = <part>
			real_part = <real_part>
			character_id = <character_id>
			player_status = <player_status>
		}
	endif
	i = (<i> + 1)
	repeat <num_players_shown>
endscript

script get_player_part 
	part = ($<player_status>.part)
	real_part = <part>
	GameMode_GetNumPlayersShown
	if (<num_players_shown> > 1)
		if (<part> = Vocals)
			get_song_struct \{song = $current_song}
			if StructureContains Structure = <song_struct> singer
				singer = (<song_struct>.singer)
				if (<singer> = none)
					return \{part = none
						real_part = none}
				endif
			endif
		endif
		is_head_to_head = false
		switch $game_mode
			case p2_pro_faceoff
			is_head_to_head = true
		endswitch
		if (<Band> = default_band)
			return part = <part> real_part = <real_part>
		endif
		if (<is_head_to_head> = true)
			return part = <part> real_part = <real_part>
		endif
	endif

	switch <part>
		case rhythm
		case Bass
		character_replacing_id = ($<Band>.bassist)
		case drum
		character_replacing_id = ($<Band>.Drummer)
		case Vocals
		character_replacing_id = ($<Band>.vocalist)
		case guitar
		character_replacing_id = ($<Band>.Guitarist)
	endswitch
	if (<character_replacing_id> != RandomCharacter)
		replace_with_celeb = true
		return part = <part> real_part = <real_part> character_id = <character_replacing_id>
	endif

	return part = <part> real_part = <real_part> character_id = <character_id>
endscript

script band_builder_add_cpu_characters 
	band_builder_get_band_global
	GameMode_GetNumPlayersShown
	if NOT band_builder_is_full
		if NOT band_builder_has_part \{part = drum}
			band_builder_add_member {
				part = drum
				real_part = drum
				character_id = ($<Band>.Drummer)
			}

		endif
	endif
	if ($game_mode = p2_pro_faceoff)
		return
	endif
	added_cpu_vocalist = false
	if NOT band_builder_is_full
		if NOT band_builder_has_part \{part = Vocals}
			if has_singing_guitarist <...>
				real_part = vocals_and_guitar
			elseif has_singing_bassist <...>
				real_part = Bass
			else
				real_part = Vocals
			endif
			if ($jam_mode_band = 1)
				real_part = guitar
			endif
			if band_builder_get_cpu_singer_id
				band_builder_add_member {
					part = Vocals
					real_part = <real_part>
					character_id = <singer_id>
				}

				added_cpu_vocalist = true
			endif
		endif
	endif
	if NOT band_builder_is_full
		if NOT band_builder_has_part \{part = Bass}
			random_bassist = false
			if has_singing_bassist <...>
				if (<num_players_shown> = 1)
					if ($player1_status.part != Vocals)
						random_bassist = true
					endif
				elseif (<added_cpu_vocalist> = true)
					random_bassist = true
				endif
			endif
			if (<random_bassist> = true)
				bassist_id = RandomCharacter
			else
				bassist_id = ($<Band>.bassist)
			endif
			band_builder_add_member {
				part = Bass
				real_part = Bass
				character_id = <bassist_id>
			}

		endif
	endif
	if NOT band_builder_is_full
		if NOT band_builder_has_part \{part = guitar}
			random_guitarist = false
			if has_singing_guitarist <...>
				if ($<Band>.Guitarist = Jimi)
					if ($current_transition = intro_jimi)
						random_guitarist = true
					else
						return
					endif
				else
					if GotParam \{singer_id}
						if (<singer_id> = ($<Band>.Guitarist))
							random_guitarist = true
						endif
					endif
				endif
			endif
			if (<random_guitarist> = true)
				guitarist_id = RandomCharacter
			else
				guitarist_id = ($<Band>.Guitarist)
			endif
			band_builder_add_member {
				part = guitar
				real_part = guitar
				character_id = <guitarist_id>
			}

		endif
	endif
endscript

script has_singing_guitarist 
	Guitarist = ($<Band>.Guitarist)
	vocalist = ($<Band>.vocalist)
	GameMode_GetType
	if NOT (<type> = career)
		return \{false}
	endif
	if StructureContains Structure = $<Band> vocalist_has_guitar
		return \{true}
	endif
	if (<Guitarist> != <vocalist>)
		return \{false}
	endif
	if (<Guitarist> = RandomCharacter || <Guitarist> = RandomMale || <Guitarist> = RandomFemale)
		return \{false}
	endif
	if (<vocalist> = RandomCharacter || <vocalist> = RandomMale || <vocalist> = RandomFemale)
		return \{false}
	endif
	return \{true}
endscript

script has_singing_bassist 
	bassist = ($<Band>.bassist)
	vocalist = ($<Band>.vocalist)
	if (<vocalist> = Lemmy)
		return \{true}
	endif
	if (<bassist> != <vocalist>)
		return \{false}
	endif
	if (<bassist> = RandomCharacter || <bassist> = RandomMale || <bassist> = RandomFemale)
		return \{false}
	endif
	if (<vocalist> = RandomCharacter || <vocalist> = RandomMale || <vocalist> = RandomFemale)
		return \{false}
	endif
	return \{true}
endscript

script is_current_band_metallica 
	if NOT GotParam \{Band}
		get_band_name song = ($current_song)
	endif
	switch <Band>
		case Band_Metallica
		case band_metallica_alt
		case band_metallica_zomb
		return \{true}
	endswitch
	return \{false}
endscript

script band_builder_get_band_global 
	if ($jam_mode_band = 1)
		return \{Band = jam_mode_band_profiles}
	endif
	if NOT ($use_worst_band = 0)
		if ($use_worst_band = Male)
			return \{Band = worst_male_band}
		else
			return \{Band = worst_female_band}
		endif
	endif
	GameMode_GetType
	if NOT (<type> = career)
		return \{Band = default_band}
	else
		get_band_name song = ($current_song)
		return Band = <Band>
	endif
endscript

script get_band_name 
	get_song_struct song = <song>
	if StructureContains Structure = <song_struct> Band
		if ($game_mode = p2_pro_faceoff)
			Band = default_band
			return Band = <Band>
		else
			Band = (<song_struct>.Band)
			return Band = <Band>
		endif
	else
		return \{Band = default_band}
	endif
endscript

script band_builder_get_cpu_singer_id \{always_random = false}
	get_song_struct song = ($current_song)
	band_builder_get_band_global
	singer = Male
	if StructureContains Structure = <song_struct> singer
		singer = (<song_struct>.singer)
	endif
	if (<singer> = none)
		return \{false}
	endif
	singer_id = ($<Band>.vocalist)
	if (<singer_id> = none)
		return \{false}
	endif
	if ((<singer_id> = RandomCharacter) || (<always_random> = true))
		if (<singer> = Male)
			singer_id = RandomMale
		elseif (<singer> = Female)
			singer_id = RandomFemale
		endif
	endif
	return true singer_id = <singer_id>
endscript

script band_builder_create_band \{async = 0}
	GetStartTime
	band_builder_clear_setup
	band_builder_add_players
	band_builder_fixup_random_human_player_names
	band_builder_add_cpu_characters
	band_builder_fill_in_random_characters

	GetArraySize \{$band_builder_current_setup}
	if (<array_size> > 0)
		i = 0
		begin
		band_builder_create_character index = <i> async = <async>
		i = (<i> + 1)
		repeat <array_size>
	endif
	band_load_anim_paks async = <async>
	GetElapsedTime StartTime = <StartTime>
	ElapsedTime = (<ElapsedTime> / 1000.0)

	if (<async> = 1)
		if GotParam \{min_time}
			timeleft = (<min_time> - <ElapsedTime>)
			if (<timeleft> > 0.0)

				Wait <timeleft> seconds
			endif
		endif
	endif
	band_start_anims
	change \{finished_gig_band_rebuild = 1}
endscript

script band_builder_create_character \{async = 0}
	create_func = (($band_builder_current_setup [<index>]).create_func)
	character_id = (($band_builder_current_setup [<index>]).character_id)
	name = (($band_builder_current_setup [<index>]).name)
	ps2_get_musician_context_data name = <name>
	savegame = (($band_builder_current_setup [<index>]).savegame)
	if StructureContains Structure = ($band_builder_current_setup [<index>]) player_status
		player_status = (($band_builder_current_setup [<index>]).player_status)
	else
		RemoveParameter \{player_status}
	endif
	if GotParam \{player_status}
		change structurename = <player_status> band_member = <name>
	endif

	<create_func> {
		name = <name>
		profile_id = <character_id>
		player_status = <player_status>
		async = <async>
		loading_into_song = ($current_song)
		asset_heap = <asset_heap>
		savegame = <savegame>
	}
endscript

script band_get_human_players 
	array = []
	GetArraySize \{$band_builder_current_setup}
	if (<array_size> > 0)
		i = 0
		begin
		if StructureContains Structure = ($band_builder_current_setup [<i>]) player_status
			AddArrayElement array = <array> element = (($band_builder_current_setup [<i>]).part)
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	return human_players = <array>
endscript

script maybe_use_song_or_venue_specific_instrument 
	return appearance = <appearance>
endscript
