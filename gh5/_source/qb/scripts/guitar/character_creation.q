
script create_band_member \{name = Guitarist
		lightgroup = Band
		async = 0
		pos = (0.0, 0.0, 0.0)
		dir = (0.0, 0.0, 1.0)}
	if ($Cheat_FocusMode = 1)
		highway_pak = highway_judy
		highway_texture = highway_judy
		SmartLoadPakman map = highways pak_name = <highway_pak> async = <async> tags = {highway_for = <name>}
		return
	endif
	RemoveParameter \{profile_struct}
	ps2_get_musician_context_data name = <name>
	create_band_member_wait_for_lock
	with_mic = 0
	band_builder_get_band_global
	if has_singing_guitarist Band = <Band>
		if (<name> = vocalist)
			with_mic = 1
			instrument = guitar
		endif
	elseif (<name> = vocalist)
		if (<instrument> = guitar || <instrument> = Bass)
			with_mic = 1
		endif
	endif

	pos = (0.0, 0.0, 0.0)
	dir = (0.0, 0.0, 1.0)
	if GotParam \{start_node}
		if DoesWayPointExist name = <start_node>
			GetWaypointPos name = <start_node>
			GetWaypointDir name = <start_node>
		endif
	endif
	if CompositeObjectExists <name>

	endif
	if ($ps2_gameplay_restart_song = 1)
		GenerateChecksumFromStruct struct = (<profile>.appearance)
		profile_app_cksum = <structure_checksum>
		GenerateChecksumFromStruct struct = ($<bandmember_appearance>)
		if (<profile_app_cksum> = <structure_checksum>)
			no_appearance_pak_load = 1
		endif
	endif
	temp_instrument = <instrument>
	if GotParam \{no_instrument_pak_load}
		temp_instrument = none
	endif
	if NOT GotParam \{no_appearance_pak_load}
		unload_paks_in_heap_context context = <asset_heap>
		change globalname = <bandmember_appearance> newvalue = {}
	endif
	if NOT GotParam \{asset_heap}
		asset_heap = heap_musician_anim
	endif
	anim_asset_context = <asset_heap>
	if get_key_from_appearance key = anim_struct appearance = (<profile>.appearance)
		if GotParam \{loading_into_song}
			get_anim_struct_member anim_struct = <anim_struct> loading_into_song = <loading_into_song> member = <instrument>
		endif
		if NOT StructureContains Structure = ($<anim_struct>) anim_asset_context

		endif
		anim_asset_context = (($<anim_struct>).anim_asset_context)
	else

	endif
	RemoveParameter \{highway_texture}
	if GotParam \{loading_into_song}
		if GotParam \{player_status}
			if NOT (($<player_status>.part) = Vocals)
				if NOT get_highway_struct_from_appearance part = ($<player_status>.part) appearance = (<profile>.appearance)

				endif
				if (($is_attract_mode = 1) || ((<profile>.name) = EmptyGuy))
					highway_pak = highway_axel
					highway_texture = highway_axel
				endif
				highway_pak = highway_judy
				highway_texture = highway_judy
				SmartLoadPakman map = highways pak_name = <highway_pak> async = <async> tags = {highway_for = <name>}
			endif
		endif
	endif
	cas_get_lightgroup name = <name>
	ik_params = Hero_Ik_params
	if GotParam \{player_status}
		if GotParam \{highway_texture}
			change structurename = <player_status> highway_texture = <highway_texture>
		endif
		change structurename = <player_status> band_member = <name>
	endif
	get_is_female_from_appearance appearance = (<profile>.appearance)
	switch (<instrument>)
		case drum
		if get_key_from_appearance key = drummer_skeleton appearance = (<profile>.appearance)
			FormatText TextName = skeleton_pak_name 'pak\\skeletons\\skeleton_%a.pak' a = <drummer_skeleton>
			FormatText checksumname = skeleton '%a' a = <drummer_skeleton>
		elseif (<is_female> = 1)
			FormatText TextName = skeleton_pak_name 'pak\\skeletons\\drummer_skeleton%af.pak' a = <asset_slot_num>
			FormatText checksumname = skeleton 'drummer_skeleton%af' a = <asset_slot_num>
		else
			FormatText TextName = skeleton_pak_name 'pak\\skeletons\\drummer_skeleton%am.pak' a = <asset_slot_num>
			FormatText checksumname = skeleton 'drummer_skeleton%am' a = <asset_slot_num>
		endif
		default
		if get_key_from_appearance key = rocker_skeleton appearance = (<profile>.appearance)
			FormatText TextName = skeleton_pak_name 'pak\\skeletons\\skeleton_%a.pak' a = <rocker_skeleton>
			FormatText checksumname = skeleton '%a' a = <rocker_skeleton>
		elseif (<is_female> = 1)
			FormatText TextName = skeleton_pak_name 'pak\\skeletons\\guitarist_skeleton%af.pak' a = <asset_slot_num>
			FormatText checksumname = skeleton 'guitarist_skeleton%af' a = <asset_slot_num>
		else
			FormatText TextName = skeleton_pak_name 'pak\\skeletons\\guitarist_skeleton%am.pak' a = <asset_slot_num>
			FormatText checksumname = skeleton 'guitarist_skeleton%am' a = <asset_slot_num>
		endif
	endswitch
	PushAssetContext context = <asset_heap>
	LoadPak <skeleton_pak_name> heap = <asset_heap>
	PopAssetContext
	if GotParam \{loading_into_song}
		maybe_use_song_or_venue_specific_instrument {song = $current_song venue = $current_level appearance = (<profile>.appearance) name = (<profile>.name)}
	else
		appearance = (<profile>.appearance)
	endif
	change globalname = <bandmember_appearance> newvalue = <appearance>
	if NOT GotParam \{no_appearance_pak_load}
		LoadAppearancePaks appearance = <appearance> heap = (<asset_heap>) instrument = <temp_instrument> asset_context = <asset_heap> async = 1
	endif
	shadow_models = []
	if NOT (<instrument> = drum)
		if get_key_from_appearance key = shadow_models appearance = (<profile>.appearance)
			FormatText checksumname = shadow '%a' a = (<shadow_models> [0])
			PushAssetContext context = <asset_heap>
			begin
			if IsAssetLoaded name = <shadow>
				break
			endif
			Wait \{1
				gameframe}
			repeat
			PopAssetContext
		endif
	endif
	if ($ps2_cas_load_canceled = 1)
		change \{ps2_cas_load_canceled = 0}
		currgen_unload_skeleton appearance = (<profile>.appearance)
		create_band_member_unlock
		return \{false}
	endif
	PushAssetContext context = <asset_heap>
	CreateCompositeObject {
		Components = [
			{
				Component = skeleton
				SkeletonName = <skeleton>
				allow_reset
			}
			{
				Component = SetDisplayMatrix
			}
			{
				Component = AnimTree
				SkeletonName = <skeleton>
			}
			{
				Component = Model
				lightgroup = <lightgroup>
			}
			{
				Component = motion
			}
			{
				Component = ModelBuilder
			}
			{
				Component = shadow
				ShadowType = volume
				ShadowVolumeModels = <shadow_models>
				assetcontext = <asset_heap>
			}
			{
				Component = AnimPreview
				active_value_source_list = $drummer_active_values
			}
			{
				Component = AnimInfo
				active_value_set = preview
			}
		]
		params = {
			<profile>
			pos = <pos>
			assetcontext = <asset_heap>
			object_type = bandmember
			profilebudget = 800
			name = <name>
		}
	}
	PopAssetContext
	<name> :Obj_SetOrientation dir = <dir>
	get_body_checksum_from_appearance appearance = (<profile>.appearance)
	get_is_female_from_appearance appearance = (<profile>.appearance)
	get_is_lefty_from_appearance appearance = (<profile>.appearance)
	get_has_large_hands_from_appearance appearance = (<profile>.appearance)
	if NOT (GotParam is_female)
		is_female = 0
	endif
	<name> :SetTags {
		asset_heap = <asset_heap>
		body_checksum = <body_checksum>
		is_female = <is_female>
		lefty = <lefty>
		large_hands = <large_hands>
	}
	if GotParam \{anim_struct_member}
		<name> :SetTags anim_struct = (<anim_struct_member>.anim_set)
	endif
	GenerateChecksumFromStruct struct = (<profile>.appearance)
	<name> :SetTags appearance_checksum = <structure_checksum>
	<name> :SetTags geom_heap = <asset_heap>
	<name> :SetTags current_instrument = <temp_instrument>
	switch (<instrument>)
		case Vocals
		desired_tree = vocalist_static_tree
		case drum
		desired_tree = drummer_static_tree
		default
		desired_tree = guitarist_static_tree
	endswitch
	if (<lefty>)
		desired_tree = lefty_guitarist_static_tree
		ik_params = lefty_IK_Params
	endif
	if (<instrument> = drum)
		node_ids = $drumdroid_animnode_ids
	else
		node_ids = $nondrummer_anim_node_ids
	endif
	elbow_bone_chord = Bone_Forearm_L
	elbow_bone_strum = Bone_Forearm_R
	negate_rolls = 1
	if (<lefty> = 1)
		elbow_bone_chord = Bone_Forearm_R
		elbow_bone_strum = Bone_Forearm_L
		negate_rolls = 0
	endif
	if NOT GotParam \{loading_into_song}
		node_ids = $nondrummer_anim_node_ids
		desired_tree = frontend_static_tree
	endif
	<name> :Anim_InitTree {
		Tree = $<desired_tree>
		NodeIdDeclaration = <node_ids>
		params = {
			ik_params = <ik_params>
			elbow_bone_chord = <elbow_bone_chord>
			elbow_bone_strum = <elbow_bone_strum>
			negate_rolls = <negate_rolls>
		}
	}
	if (<instrument> = drum)
		if (<is_female> = 1)
			<name> :Anim_Command target = FemaleDiff command = ApplyFemaleDrummerDifference_SetAnim params = {Anim = GH_Rocker_Female_Drummer_D}
			<name> :Anim_Command target = FemaleDiff_droid command = ApplyFemaleDrummerDifference_SetAnim params = {Anim = GH_Rocker_Female_Drummer_D}
		endif
		if ((<skeleton> = gh_drummer_lars_1))
			<name> :Anim_Command target = FemaleDiff command = ApplyFemaleDrummerDifference_SetAnim params = {Anim = GH_Rocker_Lars_Drummer_D}
		endif
		if ((<skeleton> = gh_drummer_axel_1) || (<skeleton> = gh_drummer_rocktopus))
			<name> :Anim_Command target = FemaleDiff command = ApplyFemaleDrummerDifference_SetAnim params = {Anim = GH_Rocker_Axel_Drummer_D}
		endif
	endif
	<name> :cas_reset_bones
	ExtendCRC <name> '_Info' out = info_struct
	change structurename = <info_struct> part = <instrument>
	change structurename = <info_struct> playing = true
	if (<with_mic> = 1)
		LoadPartPak appearance = (<profile>.appearance) part = CAS_Mic_Stand heap = (<asset_heap>) instrument = Vocals asset_context = <asset_heap> async = 0
		LoadPartPak appearance = (<profile>.appearance) part = CAS_Mic heap = (<asset_heap>) instrument = Vocals asset_context = <asset_heap> async = 0
	endif
	if NOT <name> :build_band_member_from_appearance {
			name = (<profile>.name)
			appearance = (<profile>.appearance)
			lightgroup = <lightgroup>
			async = <async>
			instrument = <instrument>
			loading_into_song = <loading_into_song>
			with_mic = <with_mic>
			geom_heap = <asset_heap>
			assetcontext = <asset_heap>
		}
		cancelled = 1
	endif
	if get_key_from_appearance key = animated_texture_list appearance = (<profile>.appearance)
		if get_key_from_appearance key = animated_texture_material appearance = (<profile>.appearance)
			<name> :Obj_SpawnScriptNow character_animated_texture_loop params = {animated_texture_material = <animated_texture_material> animated_texture_list = <animated_texture_list>}
		endif
	endif

	if (<instrument> = drum)
		<name> :cas_drum_stick_bake_transforms part = cas_drums_sticks_l SkeletonName = <skeleton> material_index = 0
		<name> :cas_drum_stick_bake_transforms part = cas_drums_sticks_r SkeletonName = <skeleton> material_index = 1
	endif
	create_band_member_unlock
	if NOT GotParam \{loading_into_song}
		if NOT (<instrument> = drum)
			if ((<skeleton> = gh_rocker_axel_1) || (<skeleton> = gh_rocker_rocktopus))
				<name> :cas_apply_bone_transforms bone_info = {bone = Bone_IK_Hand_Slave_L translation = {value = (0.0, 0.038, 0.0)}}
			endif
		endif
	endif
	if GotParam \{cancelled}
		return \{false}
	endif
	return \{true}
endscript

script cas_get_lightgroup 

	GetPakManCurrent \{map = zones}
	switch <pak>
		case z_viewer
		lightgroup = none
		default
		switch <name>
			case Drummer
			case drummer2
			lightgroup = [Band Drummer]
			case bassist
			lightgroup = [Band Alt_Band bassist]
			case Guitarist
			case guitarist2
			lightgroup = [Band Alt_Band Guitarist]
			case vocalist
			case vocalist2
			lightgroup = [Band Alt_Band vocalist]
			default
			lightgroup = [Band Alt_Band]
		endswitch
	endswitch
endscript

script get_body_checksum_from_appearance 
	if StructureContains Structure = <appearance> CAS_Body
		return body_checksum = ((<appearance>.CAS_Body).desc_id)
	endif
	if StructureContains Structure = <appearance> musician_body
		return body_checksum = ((<appearance>.musician_body).desc_id)
	endif
	if StructureContains Structure = <appearance> CAS_Full_Body
		return body_checksum = ((<appearance>.CAS_Full_Body).desc_id)
	endif


endscript

script get_is_female_from_appearance 
	if StructureContains Structure = <appearance> CAS_Body
		GetActualCASOptionStruct part = CAS_Body desc_id = ((<appearance>.CAS_Body).desc_id)
	endif
	if StructureContains Structure = <appearance> CAS_Full_Body
		unload_pak_after = 0
		if NOT load_part_desc_pak \{part_type = CAS_Full_Body}
			unload_pak_after = 1
		endif
		GetActualCASOptionStruct part = CAS_Full_Body desc_id = ((<appearance>.CAS_Full_Body).desc_id)
		if (<unload_pak_after> = 1)
			unload_part_desc_pak \{part_type = CAS_Full_Body}
		endif
	endif
	if NOT GotParam \{is_female}

		<is_female> = 0
	endif
	return is_female = <is_female>
endscript

script get_is_lefty_from_appearance 
	if StructureContains Structure = <appearance> CAS_Body
		GetActualCASOptionStruct part = CAS_Body desc_id = ((<appearance>.CAS_Body).desc_id)
	endif
	if StructureContains Structure = <appearance> CAS_Full_Body
		GetActualCASOptionStruct part = CAS_Full_Body desc_id = ((<appearance>.CAS_Full_Body).desc_id)
	endif
	if NOT GotParam \{lefty}
		return \{false
			lefty = 0}
	endif
	return true lefty = <lefty>
endscript

script get_has_large_hands_from_appearance 
	if StructureContains Structure = <appearance> CAS_Body
		GetActualCASOptionStruct part = CAS_Body desc_id = ((<appearance>.CAS_Body).desc_id)
	endif
	if StructureContains Structure = <appearance> CAS_Full_Body
		GetActualCASOptionStruct part = CAS_Full_Body desc_id = ((<appearance>.CAS_Full_Body).desc_id)
	endif
	if NOT GotParam \{large_hands}
		return \{false
			large_hands = 0}
	endif
	return true large_hands = <large_hands>
endscript

script build_band_member_from_appearance \{instrument = guitar
		with_mic = 0}
	if GotParam \{loading_into_song}
		maybe_use_song_or_venue_specific_instrument {song = $current_song venue = $current_level appearance = <appearance> name = <name>}
	endif
	if (<with_mic> = 1)
		if (<instrument> = guitar)
			instrument = Guitar_And_Vocals
		elseif (<instrument> = Bass)
			instrument = Bass_And_Vocals
		elseif (<instrument> = Vocals)
			instrument = Guitar_And_Vocals
		endif
	endif
	if ($Cheat_AirInstruments = 1)
		instrument = none
	endif
	get_hat_hair_choice appearance = <appearance>
	buildscriptparams = {
		lightgroup = <lightgroup>
		temporary_heap = heap_cas
		instrument = <instrument>
		hat_hair_choice = <hat_hair_choice>
	}
	ModelBuilder_Preload {
		<...>
		geom_heap = <geom_heap>
		assetcontext = <assetcontext>
		appearance = <appearance>
		buildscriptparams = <buildscriptparams>
	}
	if NOT GotParam \{cancelled}
		Obj_GetID
		if (<with_mic> = 1 && <ObjID> != vocalist)
			if NOT (<instrument> = Vocals)
				hide_mic
			endif
		endif
		return \{true}
	endif
	return \{false}
endscript
create_band_member_lock_queue = 0
create_band_member_lock = 0
guitarist_appearance = {
}
bassist_appearance = {
}
vocalist_appearance = {
}
drummer_appearance = {
}

script create_band_member_unlock 
	change \{create_band_member_lock = 0}
endscript

script create_band_member_wait_for_lock 
	begin
	if ($create_band_member_lock_queue = 0)
		break
	endif
	WaitOneGameFrame
	repeat
	change \{create_band_member_lock_queue = 1}
	begin
	if ($create_band_member_lock = 0)
		break
	endif
	WaitOneGameFrame
	repeat
	change \{create_band_member_lock_queue = 0}
	change \{create_band_member_lock = 1}
endscript

script destroy_band 
	if ($in_tutorial_mode = 1)

	endif
	cas_destroy_all_characters
	Drummer_Kill_Spawnscripts
	band_stop_anims
	destroy_band_member \{name = Guitarist}
	destroy_band_member \{name = guitarist2}
	destroy_band_member \{name = bassist}
	destroy_band_member \{name = bassist2}
	destroy_band_member \{name = Drummer}
	destroy_band_member \{name = drummer2}
	destroy_band_member \{name = vocalist}
	destroy_band_member \{name = vocalist2}
	band_unload_anim_paks
endscript

script destroy_band_member 
	ps2_get_musician_context_data name = <name>
	if CompositeObjectExists name = <name>
		<name> :GetTags current_instrument
		<name> :Obj_ResetBones
		BandManager_RemoveCharacter name = <name>
		<name> :Die
		FlushDeadObjects
		SmartUnloadPak async = 0 tags = {highway_for = <name>}
		FlushDeadObjects
		currgen_unload_skeleton appearance = ($<bandmember_appearance>) asset_slot_num = <asset_slot_num> asset_heap = <asset_heap>
		if ($ps2_gameplay_restart_song = 1)
			no_appearance_pak_unload = 1
		endif
		if NOT GotParam \{no_appearance_pak_unload}
			UnloadAppearancePaks appearance = ($<bandmember_appearance>) instrument = <current_instrument> no_wait asset_context = <asset_heap>
			change globalname = <bandmember_appearance> newvalue = {}
		endif
	endif
endscript

script currgen_unload_skeleton appearance = ($cas_current_appearance) asset_slot_num = 0 asset_heap = heap_musician1
	skeletons_found = 0
	if get_key_from_appearance key = drummer_skeleton appearance = <appearance>
		FormatText TextName = skeleton_pak_name 'pak\\skeletons\\skeleton_%a.pak' a = <drummer_skeleton>
		PushAssetContext context = <asset_heap>
		UnloadPak <skeleton_pak_name> heap = <asset_heap> SameHeaps
		PopAssetContext
		skeletons_found = (<skeletons_found> + 1)
	endif
	if get_key_from_appearance key = rocker_skeleton appearance = <appearance>
		FormatText TextName = skeleton_pak_name 'pak\\skeletons\\skeleton_%a.pak' a = <rocker_skeleton>
		PushAssetContext context = <asset_heap>
		UnloadPak <skeleton_pak_name> heap = <asset_heap> SameHeaps
		PopAssetContext
		skeletons_found = (<skeletons_found> + 1)
	endif
	if (<skeletons_found> < 2)
		get_is_female_from_appearance appearance = <appearance>
		if (<is_female> = 1)
			FormatText TextName = skeleton_pak_name 'pak\\skeletons\\drummer_skeleton%af.pak' a = <asset_slot_num>
			if IsPakLoaded <skeleton_pak_name> heap = <asset_heap>
				PushAssetContext context = <asset_heap>
				UnloadPak <skeleton_pak_name> heap = <asset_heap> SameHeaps
				PopAssetContext
			else
				FormatText TextName = skeleton_pak_name 'pak\\skeletons\\guitarist_skeleton%af.pak' a = <asset_slot_num>
				PushAssetContext context = <asset_heap>
				UnloadPak <skeleton_pak_name> heap = <asset_heap> SameHeaps
				PopAssetContext
			endif
		else
			FormatText TextName = skeleton_pak_name 'pak\\skeletons\\drummer_skeleton%am.pak' a = <asset_slot_num>
			if IsPakLoaded <skeleton_pak_name> heap = <asset_heap>
				PushAssetContext context = <asset_heap>
				UnloadPak <skeleton_pak_name> heap = <asset_heap> SameHeaps
				PopAssetContext
			else
				FormatText TextName = skeleton_pak_name 'pak\\skeletons\\guitarist_skeleton%am.pak' a = <asset_slot_num>
				PushAssetContext context = <asset_heap>
				UnloadPak <skeleton_pak_name> heap = <asset_heap> SameHeaps
				PopAssetContext
			endif
		endif
	endif
endscript

script kill_character_scripts 

	if CompositeObjectExists \{name = Guitarist}
		Guitarist :Obj_SwitchScript \{EmptyScript}
	endif
	if CompositeObjectExists \{name = bassist}
		bassist :Obj_SwitchScript \{EmptyScript}
	endif
	if CompositeObjectExists \{name = vocalist}
		vocalist :Obj_SwitchScript \{EmptyScript}
	endif
	if CompositeObjectExists \{name = Drummer}
		Drummer :Obj_SwitchScript \{EmptyScript}
	endif
endscript

script preload_band_member \{name = Guitarist
		async = 0}
	create_band_member_wait_for_lock
	filename_crc = none
	instrument_crc = none
	create_band_member_unlock
	return filename_crc = <filename_crc> instrument_crc = <instrument_crc> true
endscript

script preload_band_member_finish \{name = Guitarist
		async = 0}
	create_band_member_wait_for_lock
	create_band_member_unlock
endscript

script character_animated_texture_loop 
	src_mat = (<animated_texture_material>.material)
	src_pass = (<animated_texture_material>.pass)
	GetArraySize <animated_texture_list>
	i = 0
	begin
	next_struct = (<animated_texture_list> [<i>])
	Obj_SetUVOffset material = <src_mat> pass = <src_pass> u = (<next_struct>.u) v = (<next_struct>.v)
	Wait (<next_struct>.seconds) seconds
	i = (<i> + 1)
	if (<i> = <array_size>)
		i = 0
	endif
	repeat
endscript
