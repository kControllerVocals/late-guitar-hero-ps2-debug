start_animations = 1
band_builder_anims = {
}

script band_anim_reset_loading 

	change \{band_builder_anims = {
		}}
endscript

script band_anim_set_star_power_anim 

	change band_builder_anims = {($band_builder_anims) starpower = <star_power_anim>}
endscript

script band_anim_check_star_power_anim 
	if StructureContains \{Structure = $band_builder_anims
			starpower}
		return true star_power_anim = (($band_builder_anims).starpower)
	endif
	return \{false}
endscript

script band_anim_set_appearance 

	struct = ($band_builder_anims)
	AddParam name = <info_struct> structure_name = struct value = <appearance_checksum>
	change band_builder_anims = <struct>
endscript

script band_anim_check_appearance 

	if StructureContains Structure = $band_builder_anims <info_struct>
		if (<appearance_checksum> = (($band_builder_anims).<info_struct>))
			return \{true}
		endif
	endif
	return \{false}
endscript

script band_load_anim_paks \{song = none}
	is_training = 0
	anim_paks_set_state state = ingame async = <async>
	GetArraySize \{$band_builder_current_setup}
	if (<array_size> > 0)
		i = 0
		begin
		RemoveParameter \{player_status}
		if StructureContains Structure = ($band_builder_current_setup [<i>]) player_status
			player_status = (($band_builder_current_setup [<i>]).player_status)
		endif
		band_load_single_anim_pak {
			character_id = (($band_builder_current_setup [<i>]).character_id)
			part = (($band_builder_current_setup [<i>]).real_part)
			name = (($band_builder_current_setup [<i>]).name)
			savegame = (($band_builder_current_setup [<i>]).savegame)
			async = <async>
			player_status = <player_status>
		}
		if ((($band_builder_current_setup [<i>]).character_id) = EmptyGuy)
			is_training = 1
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	if (($is_attract_mode = 1) || (<is_training> = 1))
		change \{group_starpower = none}
		return
	endif
	change \{group_starpower = none}
endscript
group_starpower = none

script band_load_single_anim_pak 
	if ($game_mode = practice)
		return
	endif
	get_musician_profile_struct_by_id id = <character_id> savegame = <savegame>
	ExtendCRC <name> '_Info' out = info_struct
	if get_body_key_from_appearance key = anim_struct appearance = (<profile_struct>.appearance)
		if get_anim_struct_member anim_struct = <anim_struct> loading_into_song = ($current_song) member = <part>
			if StructureContains Structure = <anim_struct_member> pak
				pakname = (<anim_struct_member>.pak)
				map = loop_anims
				SmartLoadPakman map = <map> pak_name = <pakname> async = <async> tags = {type = looppak part = <part> song = <song>}
			else

			endif
		endif
	endif
	GenerateChecksumFromStruct struct = (<profile_struct>.appearance)
	appearance_checksum = <structure_checksum>
	if NOT band_anim_check_appearance appearance_checksum = <appearance_checksum> info_struct = <info_struct>


		win_anim_name = none
		lose_anim_name = none
		intro_anim_name = none
		if (<part> = vocals_and_guitar)
			part = guitar
		endif
		get_is_female_from_appearance appearance = (<profile_struct>.appearance)
		if (<is_female> = 1)
			gender = Female
		else
			gender = Male
		endif
		GetArraySize ($Win_Anims.<gender>.<part>)
		GetRandomValue name = win_index a = 0 b = (<array_size> -1) Integer
		win_anim_name = ($Win_Anims.<gender>.<part> [<win_index>])
		GetArraySize ($Lose_Anims.<gender>.<part>)
		GetRandomValue name = lose_index a = 0 b = (<array_size> -1) Integer
		lose_anim_name = ($Lose_Anims.<gender>.<part> [<lose_index>])
		switch <part>
			case guitar
			intro_anim_name = guit_greg_notempo_01
			case Bass
			intro_anim_name = Guit_Greg_NoTempo_02
			case Vocals
			intro_anim_name = sing_greg_notempo
		endswitch
		if (($is_attract_mode = 1) || (<character_id> = EmptyGuy))
			win_anim_name = none
			lose_anim_name = none
			if (<character_id> = EmptyGuy)
				intro_anim_name = none
			endif
		endif
		if StructureContains Structure = <profile_struct> intro_anims
			intro_anims = (<profile_struct>.intro_anims)
			GetArraySize <intro_anims>
			GetRandomValue name = index a = 0 b = (<array_size> -1) Integer
			intro_anim_name = (<intro_anims> [<index>])
		endif
		if StructureContains Structure = <profile_struct> Win_Anims
			win_array = (<profile_struct>.Win_Anims)
			GetArraySize (<win_array>)
			GetRandomValue name = win_index a = 0 b = (<array_size> -1) Integer
			win_anim_name = (<win_array> [<win_index>])
		endif
		if StructureContains Structure = <profile_struct> Lose_Anims
			lose_array = (<profile_struct>.Lose_Anims)
			GetArraySize (<lose_array>)
			GetRandomValue name = lose_index a = 0 b = (<array_size> -1) Integer
			lose_anim_name = (<lose_array> [<lose_index>])
		endif
		change structurename = <info_struct> intro_anim_name = <intro_anim_name>
		change structurename = <info_struct> win_anim_name = <win_anim_name>
		change structurename = <info_struct> lose_anim_name = <lose_anim_name>
		band_anim_set_appearance appearance_checksum = <appearance_checksum> info_struct = <info_struct>
	else

		win_anim_name = ($<info_struct>.win_anim_name)
		lose_anim_name = ($<info_struct>.lose_anim_name)
		intro_anim_name = ($<info_struct>.intro_anim_name)
	endif



	if NOT (<win_anim_name> = none)
		SmartLoadPakman map = Win_Anims pak_name = <win_anim_name> async = <async> tags = {type = animpak part = <part>}
	endif
	if NOT (<lose_anim_name> = none)
		SmartLoadPakman map = Lose_Anims pak_name = <lose_anim_name> async = <async> tags = {type = animpak part = <part>}
	endif
endscript

script prepare_for_pending_animpaks 


	SmartUnloadPak async = <async> tags = {type = looppak}

	SmartUnloadPak async = <async> tags = {type = nextsongpak}
endscript

script band_start_anims 
	if ($game_mode = practice)
		return
	endif
	GetArraySize \{$band_builder_current_setup}
	if (<array_size> > 0)
		i = 0
		begin
		part = (($band_builder_current_setup [<i>]).part)
		real_part = (($band_builder_current_setup [<i>]).real_part)
		name = (($band_builder_current_setup [<i>]).name)
		character_id = (($band_builder_current_setup [<i>]).character_id)
		savegame = (($band_builder_current_setup [<i>]).savegame)
		get_musician_profile_struct_by_id id = <character_id> savegame = <savegame>
		params = {
			name = <name>
			character_id = <character_id>
			instrument = <real_part>
			loading_into_song = ($current_song)
			savegame = <savegame>
			profile_struct = <profile_struct>
		}
		start_anims = ($band_builder_part_constants.<real_part>.start_anims)

		<start_anims> <params>
		i = (<i> + 1)
		repeat <array_size>
	endif
	Band_RestartIdles
endscript

script band_stop_anims 
	GetArraySize \{$band_builder_current_setup}
	if (<array_size> > 0)
		i = 0
		begin
		name = (($band_builder_current_setup [<i>]).name)
		if CompositeObjectExists name = <name>
			<name> :obj_killallspawnedscripts
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	BandManager_RemoveAllCharacters
endscript

script band_unload_anim_paks \{async = 1}
	SmartUnloadPak async = <async> tags = {type = animpak}
endscript

script band_unload_song_anim_paks \{async = 1}
	SmartUnloadPak async = <async> tags = {type = looppak}
endscript

script band_clear_invalid_durations 
	BandManager_PlayIdle \{name = Guitarist
		restart}
	BandManager_PlayIdle \{name = vocalist
		restart}
	BandManager_PlayIdle \{name = bassist
		restart}
	intro_anim = ($drummer_info.intro_anim_name)
	if (<intro_anim> = none)
		Drummer :Anim_Command \{target = moment_blend
			command = Switch_SetState
			params = {
				off
			}}
		Drummer :Anim_Command \{target = moment_blend_inner
			command = Switch_SetState
			params = {
				on
			}}
		Drummer :Anim_Command \{target = moment_branch
			command = DegenerateBlend_AddBranch
			params = {
				Tree = $hero_empty_branch
				BlendDuration = 0.0
			}}
	else
		Band_PlaysimpleAnim {name = Drummer Anim = <intro_anim> BlendDuration = 0.3}
		Band_SetIKChain \{name = Drummer
			chain = slave}
	endif
endscript
