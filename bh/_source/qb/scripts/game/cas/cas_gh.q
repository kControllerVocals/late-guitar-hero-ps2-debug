max_num_create_a_rockers = 8
max_num_instrument_saves = 8
max_num_logo_saves = 10
cas_current_player = 1
cas_current_player_name = cas_player1
cas_editing_new_character = false
charselect_previous_character_id = judy
CAS_node_name = Z_SoundCheck_TRG_Waypoint_CAR_Start
cas_empty_heap_score = 0.25

script get_section_index_from_desc_id 

	if NOT GetCASAppearancePart part = <part>

	endif
	if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>

	endif
	if GotParam \{sections}
		GetArraySize \{sections}
		i = 0
		begin
		if ((<sections> [<i>].desc_id) = <target_desc_id>)
			return section_index = <i>
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
endscript

script find_bone_deform_info 

	GetArraySize <deform_bones> GlobalArray
	i = 0
	begin
	if (((($<deform_bones>) [<i>]).group_name) = <group_name>)
		return true bone_deform_info = (($<deform_bones>) [<i>])
	endif
	i = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script reset_bone_deform_info 
	SetCASAppearanceBones part = <part> bones = {}
	UpdateCurrentCASModel \{buildScript = reskin_model_from_appearance}
endscript

script reset_additional_bone_deform_info 
	SetCASAppearanceAdditionalBones part = <part> additional_bone_transforms = []
	UpdateCurrentCASModel \{buildScript = reskin_model_from_appearance}
endscript

script exit_to_customize_character 
	ui_event \{event = menu_change
		data = {
			state = UIstate_customize_character
		}}
endscript

script verify_genre_data 
	if NOT CD
		ForEachIn \{$master_editable_list
			do = verify_genre_data_foreach}
	endif
endscript

script verify_genre_data_foreach 
	if GlobalExists name = <part> type = array
		ForEachIn ($<part>) do = verify_genre_data_foreach_part
	endif
endscript

script verify_genre_data_foreach_part 
	if GotParam \{genre}
		if NOT IsArray (<genre>)

		else
			ForEachIn <genre> do = verify_genre_data_foreach_part_genre params = {piece = <desc_id>}
		endif
	endif
endscript

script verify_genre_data_foreach_part_genre 
	if (<checksum> = any)

	endif
	verify_genre genre = <checksum> piece = <piece>
endscript

script verify_genre 
	i = 0
	GetArraySize ($Genre_List)
	begin
	if (((($Genre_List) [<i>]).desc_id) = <genre>)
		found = 1
		break
	endif
	i = (<i> + 1)
	repeat <array_size>
	if NOT GotParam \{found}
		if NOT GotParam \{piece}
			piece = none
		endif

	endif
endscript

script create_cas_cache_pak \{heap = heap_cas}
	if NOT CompositeObjectExists \{name = Global_Cas_Cache}
		CreateCompositeObject \{Components = [
				{
					Component = ModelBuilder
					create_cache
				}
			]
			params = {
				name = Global_Cas_Cache
			}}
		Global_Cas_Cache :ModelBuilder_CreateDynamicPak heap = <heap> size = <size> vram_size = <vram_size>
	else

	endif
endscript

script free_cas_cache_pak 
	if CompositeObjectExists \{name = Global_Cas_Cache}
		CasCancelLoading
		Global_Cas_Cache :Die
		FlushDeadObjects
	endif
endscript

script CASCacheFlushVRAM 
	if CompositeObjectExists \{name = Global_Cas_Cache}
		Global_Cas_Cache :ModelBuilder_FlushDynamicPakVRAM
	endif
endscript

script CASCacheModel async = 0 object_name = ($cas_current_object)
	(<object_name>) :Obj_ClearGeoms
	if (<async> = 1)
		KillSpawnedScript \{name = ps2_cas_model_caching}
		SpawnScriptLater ps2_cas_model_caching params = {heap = heap_musician1 asset_context = heap_musician1 <...>}
	else
		UnloadAppearancePaks asset_context = heap_musician1 appearance = <appearance>
		LoadAppearancePaks appearance = <appearance> heap = heap_musician1 asset_context = heap_musician1
		<callback> {<callbackparams> appearance = <appearance>}
	endif
endscript

script ps2_cas_model_caching 
	Wait \{1
		seconds}
	UnloadAppearancePaks async = 1 <...>
	LoadAppearancePaks async = 1 <...>
	<callback> {<callbackparams> appearance = <appearance>}
endscript

script flush_cas_cache 
	get_heap_sizes
	free_cas_cache_pak
	if ($cas_heap_state = in_game)
		create_cas_cache_pak size = <cas_cache_size> vram_size = <cas_cache_size_vram>
	else
		create_cas_cache_pak size = <cas_cache_size_in_cas> vram_size = <cas_cache_size_vram_in_cas>
	endif
endscript

script cas_artist_flush 
	if NOT CD
		if CasArtist
			if NOT ($cas_heap_state = in_game)
				stars

				stars
				flush_cas_cache
				cas_rawpak_clear
				DisableCASArchive
				CasCancelLoading
				CasBlockForComposite
				CASBlockForLoading
				cas_queue_wait
				GetCurrentCASObject
				<cas_object> :Obj_ClearGeoms
				FinishRendering
				<cas_object> :ModelBuilder_Unload
				RebuildCurrentCASModel
			endif
		else
			stars

			stars
		endif
	endif
endscript

script cas_edit_character_profile 

	change \{cas_current_instrument = none}
	get_musician_profile_struct_by_id id = <character_id> savegame = <savegame>
	SetCASAppearance appearance = (<profile_struct>.appearance)
	change cas_current_profile = <character_id>
	change cas_current_savegame = <savegame>
endscript

script cas_get_player_status 
	<player_status> = ($player_status_array [$cas_current_player])
	return player_status = <player_status>
endscript

script cas_fix_cameras_for_game 
	KillCamAnim \{all}
	destroy_bg_viewport
	setup_bg_viewport
	restore_dummy_bg_camera
endscript

script cas_load_and_setup_resources 
	mark_unsafe_for_shutdown
	CASWaitForUnloads \{Block}
	FinishRendering
	if NOT ((GotParam album_art) || (GotParam band_logo))
		GetPakManCurrent \{map = zones}
		if ChecksumEquals a = <pak> b = z_soundcheck
			if ($autolaunch_cas_artist = 1)
				SetPakManCurrentBlock \{map = zones
					pak = z_objviewer_cas
					block_scripts = 1}
				LightShow_InitEventMappings \{force_pakname = 'z_objviewer'}
				LightShow_DummyLoop
			else
				SetPakManCurrentBlock \{map = zones
					pak = z_soundcheck_cas
					block_scripts = 1}
			endif
		else

		endif
		set_cas_heap_state \{state = in_cas}
	endif
	SetShadowRenderingFlags \{enable = 'true'
		object = 'skin'}
	SetShadowMapParams \{far = 16.0}
	if NOT GotParam \{no_cam}
		destroy_bg_viewport
		setup_bg_viewport
		restore_dummy_bg_camera
		if NOT GotParam \{album_art}
			PlayIGCCam \{id = cas_view_cam_id
				name = cas_view_cam
				viewport = bg_viewport
				LockTo = world
				pos = (2.028921, 0.879576, -0.059630997)
				Quat = (-0.000911, 0.9990699, 0.027344998)
				FOV = 72.0
				Play_hold = 1
				interrupt_current}
		else
			PlayIGCCam \{id = cas_view_cam_id
				name = cas_view_cam
				viewport = bg_viewport
				LockTo = world
				pos = (-0.536864, 2.1043458, 15.148574)
				Quat = (0.0052940003, 0.02768, -0.000218)
				FOV = 72.0
				Play_hold = 1
				interrupt_current}
		endif
	endif
	if NOT ((GotParam album_art) || (GotParam band_logo))
		cas_rawpak_setup
	endif
	mark_safe_for_shutdown
endscript

script cas_free_resources \{block_scripts = 0}
	SetScriptCannotPause
	mark_unsafe_for_shutdown
	FinishRendering
	CASBlockForLoading
	KillAllCompositeTextures
	CASTemporariesFlush
	CASWaitForUnloads \{Block}
	cas_rawpak_free
	set_cas_heap_state \{state = in_game}
	if ($shutdown_game_for_signin_change_flag = 0)

		if NOT PakFilesAreCached
			destroy_loading_screen
		endif
	endif
	if NOT GotParam \{no_fix_camera}
		cas_fix_cameras_for_game
	endif
	mark_safe_for_shutdown
	change \{cas_free_cam_active = 0}
endscript

script RefreshCASProfile 
	if CD
		return
	endif
	if NOT CasArtist
		stars

		stars
		return
	endif
	if ($cas_heap_state = in_game)

	endif
	if NOT GetCurrentCASObject

	endif
	cas_queue_new_character_profile id = ($cas_current_profile) player = ($cas_current_player) savegame = ($cas_current_savegame)
	get_musician_profile_struct_by_id id = ($cas_current_profile) savegame = ($cas_current_savegame)
	SetCASAppearance appearance = (<profile_struct>.appearance)
endscript

script CreateAssetStorageFromBudgetBlock 
	if NOT GotParam \{slopheap}
		slopheap = <name>
	endif
	if NOT GotParam \{assetcontext}
		assetcontext = <name>
	endif
	CASSetupAssetStorage name = <name> params = {
		Allocator = Budget
		blockname = <name>
		assetcontext = <assetcontext>
		slopheap = <slopheap>
	}
endscript

script set_new_car_preset_physique 
	if NOT GetCASAppearancePart \{part = cas_physique}

	endif
	if NOT GetActualCASOptionStruct part = cas_physique desc_id = <desc_id>

	endif
	if NOT GotParam \{preset_builds}

	endif
	if NOT GotParam \{default_car_preset_build_index}

	endif
	chosen = (<preset_builds> [<default_car_preset_build_index>])
	SetCASAppearanceAdditionalBones part = cas_physique additional_bone_transforms = (<chosen>.additional_bone_transforms)
	return preset_physique_index = <default_car_preset_build_index>
endscript

script generate_random_appearance 

	if GotParam \{new_car_character}
		if (<is_female> = 1)
			change cas_current_appearance = ($default_custom_musician_profile_female.appearance)
		else
			change cas_current_appearance = ($default_custom_musician_profile_male.appearance)
		endif
		set_new_car_preset_physique
		new_car_character_flag = {new_car_character random_instruments from_car}
	endif
	cas_set_random_appearance genre = <genre> <new_car_character_flag>
endscript

script generate_random_name 

	if (<is_female> = 1)
		GetRandomArrayElement ($gh_random_car_female_names)
	else
		GetRandomArrayElement ($gh_random_car_male_names)
	endif
	return random_name = <element>
endscript

script generate_random_genre 
	takeaway = 2
	if GotParam \{allow_mixed}
		takeaway = 1
	endif
	GetArraySize \{$Genre_List}
	GetRandomValue a = 0 b = (<array_size> - <takeaway>) name = genre_index Integer
	return genre = ($Genre_List [<genre_index>].desc_id)
endscript

script cas_change_current_character_gender 
	if NOT GotParam \{genre}
		genre = (($cas_current_appearance).genre)
	endif
	generate_random_name is_female = <is_female>
	generate_random_appearance is_female = <is_female> genre = <genre> new_car_character
	modify_custom_profile_fullname id = ($cas_current_profile) fullname = <random_name> savegame = ($cas_current_savegame)
	if (is_female = 0)
		modify_custom_profile_blurb id = ($cas_current_profile) savegame = ($cas_current_savegame) blurb = (($default_custom_musician_profile_male).blurb)
	else
		modify_custom_profile_blurb id = ($cas_current_profile) savegame = ($cas_current_savegame) blurb = (($default_custom_musician_profile_female).blurb)
	endif
	cas_queue_add_request appearance = ($cas_current_appearance) player = ($cas_current_player)
endscript

script ui_load_cas_rawpak \{async = 1}
	return
endscript

script cas_soak_test 
endscript

script cas_free_resources_camera_fix 
	if ScriptIsRunning \{cas_free_resources}
		begin
		if NOT ScriptIsRunning \{cas_free_resources}
			break
		endif
		Wait \{1
			gameframe}
		repeat
		spawnscriptnow task_menu_default_anim_in params = {base_name = <base_name>}
	elseif GotParam \{alwaysfix}
		spawnscriptnow task_menu_default_anim_in params = {base_name = <base_name>}
	endif
endscript

script is_part_editable 

	GetActualCASOptionStruct part = <part> desc_id = <desc_id>
	if part_has_sections part = <part> desc_id = <desc_id>
		return \{true}
	elseif part_has_materials part = <part> desc_id = <desc_id>
		return \{true}
	else
		if ((GotParam color_all_materials) || (GotParam materials))
			return \{true}
		endif
		return \{false}
	endif
endscript

script part_has_sections 

	GetActualCASOptionStruct part = <part> desc_id = <desc_id>
	if GotParam \{sections}
		return \{true}
	endif
	return \{false}
endscript

script part_has_materials 

	if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>
		return \{false}
	endif
	if GotParam \{materials}
		GetArraySize <materials>
		if (<array_size> > 0)
			return \{true}
		endif
	else
		if GotParam \{material_groups}
			GetArraySize <material_groups>
			if (<array_size> > 0)
				return \{true}
			endif
		else
			if GotParam \{modify_all_materials}
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script cas_drum_stick_bake_transforms 



	switch <SkeletonName>
		case drummer_skeleton0m
		case drummer_skeleton1m
		case drummer_skeleton2m
		case drummer_skeleton3m
		if (<material_index> = 0)
			pos = (0.0, 0.0, 0.0)
			Orientation = (0.0, 0.0, 0.0)
		else
			pos = (0.0, 0.0, 0.0)
			Orientation = (0.0, 0.0, 0.0)
		endif
		case drummer_skeleton0f
		case drummer_skeleton1f
		case drummer_skeleton2f
		case drummer_skeleton3f

		if (<material_index> = 0)

			pos = (-0.09081, 0.09465001, 0.014779999)
			Orientation = (0.0, 0.0, 0.0)
		else

			pos = (0.09079, 0.09463001, 0.014779999)
			Orientation = (0.0, 0.0, 0.0)
		endif
		case gh_drummer_rocktopus
		case gh_drummer_axel_1
		Axel_Drumstick_Offset <...>
		case gh_drummer_Casey_1
		Casey_Drumstick_Offset <...>
		case gh_drummer_Clive_1
		Clive_Drumstick_Offset <...>
		case gh_drummer_Eddie_1
		Eddie_Drumstick_Offset <...>
		case gh_drummer_Izzy_1
		Izzy_Drumstick_Offset <...>
		case gh_drummer_Johnny_1
		Johnny_Drumstick_Offset <...>
		case GH_drummer_ShirleyManson_1
		ShirleyManson_Drumstick_Offset <...>
		case gh_drummer_Judy_1
		Judy_Drumstick_Offset <...>
		case gh_drummer_lars_1
		Lars_Drumstick_Offset <...>
		case gh_drummer_Midori_1
		Midori_Drumstick_Offset <...>
		case gh_drummer_Pandora_1
		Pandora_Drumstick_Offset <...>
		case gh_drummer_GwenStefani
		GwenStefani_Drumstick_Offset <...>
		case gh_drummer_TaylorSwift_1
		TaylorSwift_Drumstick_Offset <...>
		default
		if (<material_index> = 0)
			pos = (0.0, 0.0, 0.0)
			Orientation = (0.0, 0.0, 0.0)
		else
			pos = (0.0, 0.0, 0.0)
			Orientation = (0.0, 0.0, 0.0)
		endif
	endswitch
	Obj_BakeTransform geom = <part> pos = <pos>
endscript

script Axel_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (0.159723, -0.021472, 0.0023196302)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (-0.159739, -0.0214857, 0.0023173501)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script Casey_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (-0.09135061, 0.093663804, -0.0147257)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0913313, 0.09364941, -0.0147287)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script Clive_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (0.0, 0.0, 0.0)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0, 0.0, 0.0)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script Eddie_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (0.0298674, -0.000279784, 0.0007670819)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (-0.0298583, -0.00026887702, 0.00076697)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script Izzy_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (0.0, 0.0, 0.0)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0, 0.0, 0.0)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script Johnny_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (0.0, 0.0, 0.0)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0, 0.0, 0.0)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script JohnnyCash_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (0.029867599, -0.00027984398, 0.000767075)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (-0.0298582, -0.00026875702, 0.00076712697)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script ShirleyManson_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (-0.091300905, 0.09368741, -0.014790599)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0912823, 0.0936723, -0.014792499)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script Judy_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (-0.09135061, 0.093663804, -0.0147257)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0913313, 0.09364941, -0.0147287)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script Lars_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (0.12968501, -0.0029761803, 0.0201722)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (-0.129701, -0.0029930503, 0.0201723)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script Midori_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (-0.091301, 0.09368741, -0.014790599)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.091282204, 0.0936726, -0.014792499)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script Pandora_Drumstick_Offset 

	if (<material_index> = 0)
		pos = (-0.091301, 0.09368741, -0.014790599)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.091282204, 0.0936726, -0.014792499)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script GwenStefani_Drumstick_Offset 
	if (<material_index> = 0)
		pos = (-0.091301, 0.09368741, -0.014790599)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.091282204, 0.0936726, -0.014792499)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script TaylorSwift_Drumstick_Offset 
	if (<material_index> = 0)
		pos = (-0.091301, 0.09368741, -0.014790599)
		Orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.091282204, 0.0936726, -0.014792499)
		Orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script boombox_bounce 
	Anim_Command \{target = misc_diff_strength
		command = Modulate_SetStrength
		params = {
			strength = 1.0
		}}
endscript
