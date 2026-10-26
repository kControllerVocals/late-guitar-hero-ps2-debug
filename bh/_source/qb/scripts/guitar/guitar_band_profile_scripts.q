
script get_musician_profile_size 

	size = 0
	if GotParam \{borrowed_from_band_leader}
		globaltag_getarraysize savegame = <borrowed_from_band_leader> array_name = custom_profiles
		size = (<array_size> + <size>)
	endif
	globaltag_getarraysize savegame = <savegame> array_name = custom_profiles
	size = (<array_size> + <size>)
	GetArraySize \{$Preset_Musician_Profiles_Modifiable}
	size = (<array_size> + <size>)
	GetArraySize \{$Preset_Musician_Profiles_Locked}
	size = (<array_size> + <size>)
	return array_size = <size>
endscript

script get_musician_profile_struct_by_index 

	if GotParam \{borrowed_from_band_leader}
		globaltag_getarraysize savegame = <borrowed_from_band_leader> array_name = custom_profiles
		if (<index> < <array_size>)
			globaltag_getarrayelement savegame = <borrowed_from_band_leader> array_name = custom_profiles index = <index>
			return profile_struct = <element> character_savegame = <borrowed_from_band_leader>
		endif
		index = (<index> - <array_size>)
	endif
	globaltag_getarraysize savegame = <savegame> array_name = custom_profiles
	if (<index> < <array_size>)
		globaltag_getarrayelement savegame = <savegame> array_name = custom_profiles index = <index>
		profile_struct = <element>
	else
		index = (<index> - <array_size>)
		GetArraySize \{$Preset_Musician_Profiles_Modifiable}
		if (<index> < <array_size>)
			profile_struct = ($Preset_Musician_Profiles_Modifiable [<index>])
			globaltag_get_preset_musician savegame = <savegame> profile_struct = <profile_struct> index = <index>
		else
			index = (<index> - <array_size>)
			GetArraySize \{$Preset_Musician_Profiles_Locked}
			if (<index> < <array_size>)
				profile_struct = ($Preset_Musician_Profiles_Locked [<index>])
				resolve_random_appearance profile_struct = <profile_struct>
			else
			endif
		endif
	endif
	if NOT StructureContains Structure = <profile_struct> appearance

	endif
	if NOT StructureContains Structure = <profile_struct> name

	endif
	return profile_struct = <profile_struct> character_savegame = <savegame>
endscript

script get_musician_profile_struct_by_id 

	if SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Locked id = <id>
		profile_struct = ($Preset_Musician_Profiles_Locked [<index>])
		resolve_random_appearance profile_struct = <profile_struct>
		return true profile_struct = <profile_struct>
	endif
	if SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Modifiable id = <id>
		globaltag_get_preset_musician savegame = <savegame> profile_struct = ($Preset_Musician_Profiles_Modifiable [<index>]) index = <index>
		return true profile_struct = <profile_struct>
	endif
	globaltag_getarraysize savegame = <savegame> array_name = custom_profiles
	i = 0
	if (<array_size> > 0)
		begin
		globaltag_getarrayelement savegame = <savegame> array_name = custom_profiles index = <i>
		if (<id> = (<element>.name))
			return true profile_struct = <element>
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	if NOT GotParam \{dont_assert}

	endif
	return \{false}
endscript

script profile_exists 

	if SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Locked id = <id>
		return \{true}
	endif
	if SearchMusicianProfileArray array_name = Net_Musician_Profiles id = <id>
		return \{true}
	endif
	if SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Modifiable id = <id>
		return \{true}
	endif
	globaltag_getarraysize savegame = <savegame> array_name = custom_profiles
	i = 0
	if (<array_size> > 0)
		begin
		globaltag_getarrayelement savegame = <savegame> array_name = custom_profiles index = <i>
		if (<id> = (<element>.name))
			return \{true}
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	return \{false}
endscript

script new_custom_character_name 

	i = 0
	begin
	FormatText checksumname = id_checksum 'custom_character_%d' d = <i> AddToStringLookup = true
	if NOT is_completely_custom_musician id = <id_checksum> savegame = <savegame>
		return new_character_id = <id_checksum>
	endif
	i = (<i> + 1)
	repeat 100

endscript

script profile_can_be_modified 

	if GotParam \{require_purchased}
		if NOT is_profile_purchased id = <id> savegame = <savegame>
			return \{false}
		endif
	endif
	if SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Modifiable id = <id>
		return \{true}
	endif
	if is_completely_custom_musician id = <id> savegame = <savegame>
		return \{true}
	endif
	return \{false}
endscript

script is_completely_custom_musician 

	globaltag_getarraysize savegame = <savegame> array_name = custom_profiles
	i = 0
	if (<array_size> > 0)
		begin
		globaltag_getarrayelement savegame = <savegame> array_name = custom_profiles index = <i>
		if (<id> = (<element>.name))
			return true custom_musician_index = <i>
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	return \{false}
endscript

script is_ghrocker 

	if SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Modifiable id = <id>
		globaltag_get_preset_musician savegame = <savegame> profile_struct = ($Preset_Musician_Profiles_Modifiable [<index>]) index = <index>
		if StructureContains Structure = <profile_struct> ghrocker
			return \{true}
		else
			return \{false}
		endif
	endif
	return \{false}
endscript

script modify_custom_profile_appearance 

	if is_completely_custom_musician id = <id> savegame = <savegame>
		globaltag_getarrayelement savegame = <savegame> array_name = custom_profiles index = <custom_musician_index>
		dest_appearance = {}
		CASCopySelectiveParts \{src_appearance_name = appearance
			dest_appearance_name = dest_appearance
			part_array_name = ps2_custom_musician_save_parts
			ToSave}
		CASCopySelectiveParts \{src_appearance_name = appearance
			dest_appearance_name = dest_appearance
			part_array_name = modifiable_preset_musician_instrument_parts
			ToSave}
		dest_appearance = {<dest_appearance> genre = (<appearance>.genre)}
		globaltag_setarrayelement savegame = <savegame> array_name = custom_profiles index = <custom_musician_index> element = {
			<element>
			appearance = <dest_appearance>
		}
	elseif SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Modifiable id = <id>
		globaltag_set_preset_musician savegame = <savegame> appearance = <appearance> index = <index>
	endif
endscript

script modify_custom_profile_fullname 

	if is_completely_custom_musician id = <id> savegame = <savegame>
		globaltag_getarrayelement savegame = <savegame> array_name = custom_profiles index = <custom_musician_index>
		globaltag_setarrayelement savegame = <savegame> array_name = custom_profiles index = <custom_musician_index> element = {
			<element>
			fullname = <fullname>
		}
	endif
endscript

script modify_custom_profile_blurb 

	if is_completely_custom_musician id = <id> savegame = <savegame>
		globaltag_getarrayelement savegame = <savegame> array_name = custom_profiles index = <custom_musician_index>
		globaltag_setarrayelement savegame = <savegame> array_name = custom_profiles index = <custom_musician_index> element = {
			<element>
			blurb = <blurb>
		}
	endif
endscript

script add_new_custom_profile 

	globaltag_addarrayelement savegame = <savegame> array_name = custom_profiles element = <profile>
endscript

script delete_custom_profile 

	if is_completely_custom_musician id = <id> savegame = <savegame>
		globaltag_removearrayelement savegame = <savegame> array_name = custom_profiles index = <custom_musician_index>
	endif
endscript

script restore_custom_musician_parts 

	if SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Modifiable id = <id>
		globaltag_set_preset_musician savegame = <savegame> index = <index> appearance = ($Preset_Musician_Profiles_Modifiable [<index>].appearance)
	endif
endscript

script get_savegame_from_player_status 
	return \{savegame = 0
		owns_savegame = 1}
endscript

script get_savegame_from_controller 
	return \{savegame = 0
		owns_savegame = 1}
endscript

script resolve_random_appearance 

	if StructureContains Structure = <profile_struct> random_appearance_lookup
		band_builder_get_random_appearance character_id = (<profile_struct>.name)
		profile_struct = {
			<profile_struct>
			appearance = <appearance>
		}
	endif
	return profile_struct = <profile_struct>
endscript

script is_selectable_profile 

	if StructureContains Structure = <profile_struct> selection_not_allowed
		return \{false}
	else
		return \{true}
	endif
endscript

script is_allowed_part 
	if ((<part> = Bass) || (<part> = guitar) || (<part> = drum) || (<part> = Vocals))
		i = 0
		GetArraySize (<profile_struct>.allowed_parts)
		if (<array_size> > 0)
			begin
			if ((<profile_struct>.allowed_parts) [<i>] = <part>)
				return \{true}
			endif
			i = (<i> + 1)
			repeat <array_size>
		endif
		return \{false}
	endif

endscript

script ghrocker_body_matches 

	if (<part> != CAS_Full_Body)

	endif
	if GetActualCASOptionStruct part = <part> desc_id = <desc_id>
		if GotParam \{ghrocker}
			if (<ghrocker> = <matcheswith>)
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script modify_net_appearance 
	if ((<player> < 1) || (<player> > 4))

	endif
	index = (<player> - 1)
	new_entry = {(($Net_Musician_Profiles) [<index>]) appearance = <appearance> fullname = <fullname>}
	SetArrayElement ArrayName = Net_Musician_Profiles GlobalArray index = <index> newvalue = <new_entry>
endscript

script fill_local_appearance_data 


	<player_status> = ($player_status_array [<player_number>])
	if ($<player_status>.is_local_client = 1)
		my_character_id = ($<player_status>.character_id)
		get_savegame_from_player_status player_status = <player_status>
		if isXenon
			get_fullname_of_character id = <my_character_id> savegame = <savegame>
		else
			if get_musician_profile_struct_by_id id = <my_character_id> savegame = <savegame> dont_assert
				if StructureContains Structure = <profile_struct> fullname
					fullname = (<profile_struct>.fullname)
				endif
			endif
			if SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Locked id = <my_character_id>

			elseif SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Modifiable id = <my_character_id>

			else
				fullname = qs("Custom Character")
			endif
		endif
		if NOT get_musician_profile_struct_by_id id = <my_character_id> savegame = <savegame> dont_assert



			if isXenon
				isave = 0
				begin
				globaltag_getarraysize savegame = <isave> array_name = custom_profiles

				isave = (<isave> + 1)
				repeat 4
			else
				globaltag_getarraysize savegame = <savegame> array_name = custom_profiles

			endif
			borrowed_from_band_leader = 666
			get_savegame_from_player_status band_character_select player_status = <player_status>

			dump_player_status \{struct = player1_status}
			dump_player_status \{struct = player2_status}
			dump_player_status \{struct = player3_status}
			dump_player_status \{struct = player4_status}
			dump_player_status \{struct = player5_status}
			dump_player_status \{struct = player6_status}
			dump_player_status \{struct = player7_status}
			dump_player_status \{struct = player8_status}

			change structurename = <player_status> character_id = judy
			get_musician_profile_struct_by_id id = judy savegame = <savegame>
			my_character_id = judy
			id = judy
		endif
		resolve_guest_character_id id = <my_character_id>
		if (($<player_status>.part = drum) || ($<player_status>.part = Vocals))

		endif
		return character_id = <my_character_id> appearance = {(<profile_struct>.appearance) fullname = <fullname> old_character_id = <id>}
	endif
endscript

script dump_player_status 

endscript

script start_song_got_net_appearance 

	if (<netplayer> > 1)
		if (<netplayer> < 5)
			<player_status> = ($player_status_array [<netplayer>])
			appearance_num = <netplayer>
			FormatText checksumname = netappearance_id 'netappearance%d' d = <appearance_num>
			if GotParam \{USERANDOMPLAYER}
				get_savegame_from_controller controller = ($primary_controller)
				cas_get_random_preset_character savegame = <savegame> part = ($<player_status>.part)
				change structurename = <player_status> character_id = <character_id>
			else
				change structurename = <player_status> character_id = <netappearance_id>
				modify_net_appearance player = <appearance_num> appearance = <appearance> fullname = (<appearance>.fullname)
			endif
			ui_event_get_top
			can_continue = 0
			if (<base_name> = 'band_mode')
				can_continue = 1
			elseif (<base_name> = 'net_career_join_popup')
				can_continue = 1
			endif
			if is_current_state_band_mode
				<player_status> = ($player_status_array [<netplayer>])
				get_savegame_from_player_status player_status = <player_status>
				if (<can_continue> = 1)
					if ScreenElementExists \{id = MyInterfaceElement}
						MyInterfaceElement :GetSingleTag \{menus}
						(<menus> [(<netplayer> - 1)]) :obj_spawnscript ui_band_mode_update_menu
					endif
					cas_queue_new_character_profile player = <netplayer> id = ($<player_status>.character_id) savegame = <savegame>
				endif
			endif
		endif
	endif
endscript

script check_for_dupe_profiles \{savegame = 0}
	if CD
		return
	endif
	get_musician_profile_size savegame = <savegame>
	i = 0
	begin
	get_musician_profile_struct_by_index index = <i> savegame = <savegame>
	iname = (<profile_struct>.name)
	if NOT IsChecksum <iname>

	endif
	j = 0
	begin
	if NOT (<i> = <j>)
		get_musician_profile_struct_by_index index = <j> savegame = <savegame>
		jname = (<profile_struct>.name)
		if (<iname> = <jname>)

		endif
	endif
	j = (<j> + 1)
	repeat <array_size>
	i = (<i> + 1)
	repeat <array_size>
endscript

script is_profile_unlocked 

	if NOT StructureContains Structure = <profile_struct> locked
		return \{true}
	else
		get_current_band_info
		GetGlobalTags <band_info> savegame = <savegame>
		if NOT GotParam \{unlocked_profiles}
			return \{false}
		else
			if ArrayContains array = <unlocked_profiles> contains = (<profile_struct>.name)
				return \{true}
			else
				return \{false}
			endif
		endif
	endif
endscript

script unlock_profile 

	get_musician_profile_struct_by_id id = <id> savegame = <savegame>
	if NOT StructureContains Structure = <profile_struct> locked
		return
	else
		get_current_band_info
		GetGlobalTags <band_info> savegame = <savegame>
		if NOT GotParam \{unlocked_profiles}
			AddArrayElement array = [] element = <id>
			LockGlobalTags \{off}
			SetGlobalTags <band_info> params = {unlocked_profiles = <array>} savegame = <savegame>
			LockGlobalTags
		else
			if NOT ArrayContains array = <unlocked_profiles> contains = <id>
				AddArrayElement array = <unlocked_profiles> element = <id>
				LockGlobalTags \{off}
				SetGlobalTags <band_info> params = {unlocked_profiles = <array>} savegame = <savegame>
				LockGlobalTags
			endif
		endif
	endif
endscript

script unlock_all_profiles 
	get_savegame_from_controller controller = ($primary_controller)
	get_musician_profile_size savegame = <savegame>
	i = 0
	begin
	get_musician_profile_struct_by_index index = <i> savegame = <savegame>
	this_id = (<profile_struct>.name)
	if NOT ChecksumEquals a = <this_id> b = Jimi
		unlock_profile id = <this_id> savegame = <savegame>
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script unlock_all_profiles_no_vbot 
	get_savegame_from_controller controller = ($primary_controller)
	get_musician_profile_size savegame = <savegame>
	i = 0
	begin
	get_musician_profile_struct_by_index index = <i> savegame = <savegame>
	this_id = (<profile_struct>.name)
	if NOT ChecksumEquals a = <this_id> b = vbot
		unlock_profile id = <this_id> savegame = <savegame>
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script is_profile_purchased 

	get_musician_profile_struct_by_id id = <id> savegame = <savegame>
	if NOT StructureContains Structure = <profile_struct> price
		return \{true}
	else
		get_current_band_info
		GetGlobalTags <band_info> savegame = <savegame>
		if NOT GotParam \{purchased_profiles}
			return \{false}
		else
			if ArrayContains array = <purchased_profiles> contains = <id>
				return \{true}
			else
				return \{false}
			endif
		endif
	endif
endscript

script purchase_profile 

	get_musician_profile_struct_by_id id = <id> savegame = <savegame>
	if NOT StructureContains Structure = <profile_struct> price
		return
	else
		get_current_band_info
		GetGlobalTags <band_info> savegame = <savegame>
		if NOT GotParam \{purchased_profiles}
			AddArrayElement array = [] element = <id>
			SetGlobalTags <band_info> params = {purchased_profiles = <array>} savegame = <savegame>
		else
			if NOT ArrayContains array = <purchased_profiles> contains = <id>
				AddArrayElement array = <purchased_profiles> element = <id>
				SetGlobalTags <band_info> params = {purchased_profiles = <array>} savegame = <savegame>
			endif
		endif
	endif
endscript

script purchase_all_profiles 
	get_savegame_from_controller controller = ($primary_controller)
	get_musician_profile_size savegame = <savegame>
	i = 0
	begin
	get_musician_profile_struct_by_index index = <i> savegame = <savegame>
	this_id = (<profile_struct>.name)
	purchase_profile id = <this_id> savegame = <savegame>
	i = (<i> + 1)
	repeat <array_size>
endscript

script get_fullname_of_character 

	fullname = qs("Custom Character")
	if band_builder_is_finalized_random character_id = <id>
		if StructureContains Structure = ($guest_character_fullnames) <id>
			fullname = (($guest_character_fullnames).<id>)
		endif
	elseif get_musician_profile_struct_by_id id = <id> savegame = <savegame> dont_assert
		if StructureContains Structure = <profile_struct> fullname
			fullname = (<profile_struct>.fullname)
		endif
	endif
	if SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Locked id = <id>
		return fullname = <fullname>
	endif
	if SearchMusicianProfileArray array_name = Preset_Musician_Profiles_Modifiable id = <id>
		return fullname = <fullname>
	endif
	if NOT GotParam \{profanity_allowed}
		if GotParam \{fullname}
			if NOT IsAcceptableString string = <fullname>
				RemoveParameter \{fullname}
			endif
		endif
	endif
	if NOT GotParam \{fullname}
		fullname = qs("Custom Character")
	endif
	return fullname = <fullname>
endscript

script resolve_guest_character_id 

	if band_builder_is_finalized_random character_id = <id>
		if StructureContains Structure = ($guest_character_names) <id>
			return id = (($guest_character_names).<id>)
		endif
	endif
	return id = <id>
endscript

script get_band_configuration 
	get_song_struct song = <song>
	if StructureContains Structure = <song_struct> Band
		if ($game_mode = p2_pro_faceoff)
			return \{Band = default_band}
		else
			return Band = (<song_struct>.Band)
		endif
	else
		return \{Band = default_band}
	endif
endscript
