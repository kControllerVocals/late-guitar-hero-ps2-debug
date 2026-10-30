
script create_band_member \{name = guitarist
		lightgroup = band
		async = 0
		pos = (0.0, 0.0, 0.0)
		dir = (0.0, 0.0, 1.0)}
	if ($cheat_focusmode = 1)
		highway_pak = highway_judy
		highway_texture = highway_judy
		return
	endif
	removeparameter \{profile_struct}
	ps2_get_musician_context_data name = <name>
	create_band_member_wait_for_lock
	with_mic = 0
	band_builder_get_band_global
	if has_singing_guitarist band = <band>
		if (<name> = vocalist)
			with_mic = 1
			instrument = guitar
		endif
	elseif (<name> = vocalist)
		if (<instrument> = guitar || <instrument> = bass)
			with_mic = 1
		endif
	endif

	pos = (0.0, 0.0, 0.0)
	dir = (0.0, 0.0, 1.0)
	if gotparam \{start_node}
		if doeswaypointexist name = <start_node>
			getwaypointpos name = <start_node>
			getwaypointdir name = <start_node>
		endif
	endif
	if compositeobjectexists <name>

	endif
	if ($ps2_gameplay_restart_song = 1)
		generatechecksumfromstruct struct = (<profile>.appearance)
		0x56d85794 = <structure_checksum>
		generatechecksumfromstruct struct = ($<bandmember_appearance>)
		if (<0x56d85794> = <structure_checksum>)
			no_appearance_pak_load = 1
		endif
	endif
	temp_instrument = <instrument>
	if gotparam \{no_instrument_pak_load}
		temp_instrument = none
	endif
	if NOT gotparam \{no_appearance_pak_load}
		0x6aa93fce context = <asset_heap>
		change globalname = <bandmember_appearance> newvalue = {}
	endif
	if NOT gotparam \{asset_heap}
		asset_heap = heap_musician_anim
	endif
	anim_asset_context = <asset_heap>
	if get_key_from_appearance key = anim_struct appearance = (<profile>.appearance)
		if gotparam \{loading_into_song}
			get_anim_struct_member anim_struct = <anim_struct> loading_into_song = <loading_into_song> member = <instrument>
		endif
		if NOT structurecontains structure = ($<anim_struct>) anim_asset_context

		endif
		anim_asset_context = (($<anim_struct>).anim_asset_context)
	else

	endif
	cas_get_lightgroup name = <name>
	ik_params = hero_ik_params
	if gotparam \{player_status}
		change structurename = <player_status> band_member = <name>
		if NOT (($<player_status>.part) = vocals)
			change structurename = <player_status> highway_texture = highway_judy
		endif
	endif
	get_is_female_from_appearance appearance = (<profile>.appearance)
	switch (<instrument>)
		case drum
		if get_key_from_appearance key = drummer_skeleton appearance = (<profile>.appearance)
			formattext textname = skeleton_pak_name 'pak\\skeletons\\skeleton_%a.pak' a = <drummer_skeleton>
			formattext checksumname = skeleton '%a' a = <drummer_skeleton>
		elseif (<is_female> = 1)
			formattext textname = skeleton_pak_name 'pak\\skeletons\\drummer_skeleton%af.pak' a = <asset_slot_num>
			formattext checksumname = skeleton 'drummer_skeleton%af' a = <asset_slot_num>
		else
			formattext textname = skeleton_pak_name 'pak\\skeletons\\drummer_skeleton%am.pak' a = <asset_slot_num>
			formattext checksumname = skeleton 'drummer_skeleton%am' a = <asset_slot_num>
		endif
		default
		if get_key_from_appearance key = rocker_skeleton appearance = (<profile>.appearance)
			formattext textname = skeleton_pak_name 'pak\\skeletons\\skeleton_%a.pak' a = <rocker_skeleton>
			formattext checksumname = skeleton '%a' a = <rocker_skeleton>
		elseif (<is_female> = 1)
			formattext textname = skeleton_pak_name 'pak\\skeletons\\guitarist_skeleton%af.pak' a = <asset_slot_num>
			formattext checksumname = skeleton 'guitarist_skeleton%af' a = <asset_slot_num>
		else
			formattext textname = skeleton_pak_name 'pak\\skeletons\\guitarist_skeleton%am.pak' a = <asset_slot_num>
			formattext checksumname = skeleton 'guitarist_skeleton%am' a = <asset_slot_num>
		endif
	endswitch
	pushassetcontext context = <asset_heap>
	loadpak <skeleton_pak_name> heap = <asset_heap>
	popassetcontext
	if gotparam \{loading_into_song}
		maybe_use_song_or_venue_specific_instrument {song = $current_song venue = $current_level appearance = (<profile>.appearance) name = (<profile>.name)}
	else
		appearance = (<profile>.appearance)
	endif
	change globalname = <bandmember_appearance> newvalue = <appearance>
	if NOT gotparam \{no_appearance_pak_load}
		loadappearancepaks appearance = <appearance> heap = (<asset_heap>) instrument = <temp_instrument> asset_context = <asset_heap> async = 1
	endif
	shadow_models = []
	if NOT gotparam \{loading_into_song}
		if NOT (<instrument> = drum)
			if get_key_from_appearance key = shadow_models appearance = (<profile>.appearance)
				formattext checksumname = shadow '%a' a = (<shadow_models> [0])
				pushassetcontext context = <asset_heap>
				begin
				if isassetloaded name = <shadow>
					break
				endif
				if ($ps2_cas_load_canceled = 1)
					break
				endif
				wait \{1
					gameframe}
				repeat
				popassetcontext
			endif
		endif
	endif
	0xd1e7ae62 = no_shadow
	0xa0f5eb04 = 0xff2a743e
	if NOT gotparam \{loading_into_song}
		switch (<instrument>)
			case guitar
			case bass
			0xd1e7ae62 = 'car_guitar_shadow01'
			0xa0f5eb04 = 'pak/models/shadows/car_guitar_shadow01.pak'
			case vocals
			0xd1e7ae62 = 'car_mic_shadow01'
			0xa0f5eb04 = 'pak/models/shadows/car_mic_shadow01.pak'
			case drum
			default
			0xd1e7ae62 = no_shadow
			0xa0f5eb04 = 0xff2a743e
		endswitch
	endif
	if NOT (<0xd1e7ae62> = no_shadow)
		pushassetcontext context = <asset_heap>
		loadpak (<0xa0f5eb04>) heap = <asset_heap>
		formattext checksumname = shadow '%a' a = (<0xd1e7ae62>)
		begin
		if isassetloaded name = <shadow>
			break
		endif
		if ($ps2_cas_load_canceled = 1)
			break
		endif
		wait \{1
			gameframe}
		repeat
		popassetcontext
		addarrayelement array = <shadow_models> element = (<0xd1e7ae62>)
		shadow_models = <array>
	endif
	if ($ps2_cas_load_canceled = 1)
		change \{ps2_cas_load_canceled = 0}
		0x239b2ee5 appearance = (<profile>.appearance)
		create_band_member_unlock
		return \{false}
	endif
	pushassetcontext context = <asset_heap>
	createcompositeobject {
		components = [
			{
				component = skeleton
				skeletonname = <skeleton>
				allow_reset
			}
			{
				component = setdisplaymatrix
			}
			{
				component = animtree
				skeletonname = <skeleton>
			}
			{
				component = model
				lightgroup = <lightgroup>
			}
			{
				component = motion
			}
			{
				component = modelbuilder
			}
			{
				component = shadow
				shadowtype = volume
				shadowvolumemodels = <shadow_models>
				assetcontext = <asset_heap>
			}
			{
				component = animpreview
				active_value_source_list = $drummer_active_values
			}
			{
				component = animinfo
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
	popassetcontext
	<name> :obj_setorientation dir = <dir>
	get_body_checksum_from_appearance appearance = (<profile>.appearance)
	get_is_female_from_appearance appearance = (<profile>.appearance)
	get_is_lefty_from_appearance appearance = (<profile>.appearance)
	get_has_large_hands_from_appearance appearance = (<profile>.appearance)
	if NOT (gotparam is_female)
		is_female = 0
	endif
	<name> :settags {
		asset_heap = <asset_heap>
		body_checksum = <body_checksum>
		is_female = <is_female>
		lefty = <lefty>
		large_hands = <large_hands>
	}
	if gotparam \{anim_struct_member}
		<name> :settags anim_struct = (<anim_struct_member>.anim_set)
	endif
	generatechecksumfromstruct struct = (<profile>.appearance)
	<name> :settags appearance_checksum = <structure_checksum>
	<name> :settags geom_heap = <asset_heap>
	<name> :settags current_instrument = <temp_instrument>
	switch (<instrument>)
		case vocals
		desired_tree = vocalist_static_tree
		case drum
		desired_tree = drummer_static_tree
		default
		desired_tree = guitarist_static_tree
	endswitch
	if (<lefty>)
		desired_tree = 0xb67a972f
		ik_params = 0xf56342fc
	endif
	if (<instrument> = drum)
		node_ids = $drumdroid_animnode_ids
	else
		node_ids = $nondrummer_anim_node_ids
	endif
	elbow_bone_chord = bone_forearm_l
	elbow_bone_strum = bone_forearm_r
	negate_rolls = 1
	if (<lefty> = 1)
		elbow_bone_chord = bone_forearm_r
		elbow_bone_strum = bone_forearm_l
		negate_rolls = 0
	endif
	if NOT gotparam \{loading_into_song}
		node_ids = $nondrummer_anim_node_ids
		desired_tree = frontend_static_tree
	endif
	0xf6e941dd = gh_rocker_male_empty_d
	if (<body_checksum> = 0xa2de9ea8)
		0xf6e941dd = 0x64ec3628
	endif
	<name> :anim_inittree {
		tree = $<desired_tree>
		nodeiddeclaration = <node_ids>
		params = {
			0xd432622d = <0xf6e941dd>
			ik_params = <ik_params>
			elbow_bone_chord = <elbow_bone_chord>
			elbow_bone_strum = <elbow_bone_strum>
			negate_rolls = <negate_rolls>
		}
	}
	if (<instrument> = drum)
		if (<is_female> = 1)
			<name> :anim_command target = femalediff command = applyfemaledrummerdifference_setanim params = {anim = gh_rocker_female_drummer_d}
			<name> :anim_command target = 0xd7adf5e7 command = applyfemaledrummerdifference_setanim params = {anim = gh_rocker_female_drummer_d}
		endif
		if ((<skeleton> = gh_drummer_lars_1))
			<name> :anim_command target = femalediff command = applyfemaledrummerdifference_setanim params = {anim = gh_rocker_lars_drummer_d}
		endif
		if ((<skeleton> = gh_drummer_axel_1) || (<skeleton> = 0xd0ef43ee))
			<name> :anim_command target = femalediff command = applyfemaledrummerdifference_setanim params = {anim = gh_rocker_axel_drummer_d}
		endif
	endif
	<name> :cas_reset_bones
	extendcrc <name> '_Info' out = info_struct
	change structurename = <info_struct> part = <instrument>
	change structurename = <info_struct> playing = true
	if (<with_mic> = 1)
		loadpartpak appearance = (<profile>.appearance) part = cas_mic_stand heap = (<asset_heap>) instrument = vocals asset_context = <asset_heap> async = 0
		loadpartpak appearance = (<profile>.appearance) part = cas_mic heap = (<asset_heap>) instrument = vocals asset_context = <asset_heap> async = 0
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
	if get_key_from_appearance key = 0xb6d2786b appearance = (<profile>.appearance)
		if get_key_from_appearance key = 0x26dbd790 appearance = (<profile>.appearance)
			<name> :obj_spawnscriptnow 0x24cfe7d0 params = {0x26dbd790 = <0x26dbd790> 0xb6d2786b = <0xb6d2786b>}
		endif
	endif
	if (<body_checksum> = 0xa2de9ea8 && <instrument> != drum)
		<name> :obj_spawnscriptnow 0x64ec3628
	endif

	if (<instrument> = drum)
		<name> :cas_drum_stick_bake_transforms part = cas_drums_sticks_l skeletonname = <skeleton> material_index = 0
		<name> :cas_drum_stick_bake_transforms part = cas_drums_sticks_r skeletonname = <skeleton> material_index = 1
	endif
	create_band_member_unlock
	if NOT gotparam \{loading_into_song}
		if NOT (<instrument> = drum)
			if ((<skeleton> = gh_rocker_axel_1) || (<skeleton> = 0xde4de899))
				<name> :cas_apply_bone_transforms bone_info = {bone = bone_ik_hand_slave_l translation = {value = (0.0, 0.038, 0.0)}}
			endif
		endif
	endif
	if gotparam \{cancelled}
		return \{false}
	endif
	return \{true}
endscript

script cas_get_lightgroup 

	getpakmancurrent \{map = zones}
	switch <pak>
		case z_viewer
		lightgroup = none
		default
		switch <name>
			case drummer
			case drummer2
			lightgroup = [band drummer]
			case bassist
			lightgroup = [band alt_band bassist]
			case guitarist
			case guitarist2
			lightgroup = [band alt_band guitarist]
			case vocalist
			case vocalist2
			lightgroup = [band alt_band vocalist]
			default
			lightgroup = [band alt_band]
		endswitch
	endswitch
endscript

script get_body_checksum_from_appearance 
	if structurecontains structure = <appearance> cas_body
		return body_checksum = ((<appearance>.cas_body).desc_id)
	endif
	if structurecontains structure = <appearance> musician_body
		return body_checksum = ((<appearance>.musician_body).desc_id)
	endif
	if structurecontains structure = <appearance> cas_full_body
		return body_checksum = ((<appearance>.cas_full_body).desc_id)
	endif


endscript

script get_is_female_from_appearance 
	if structurecontains structure = <appearance> cas_body
		getactualcasoptionstruct part = cas_body desc_id = ((<appearance>.cas_body).desc_id)
	endif
	if structurecontains structure = <appearance> cas_full_body
		0x5a95f6d5 = 0
		if NOT load_part_desc_pak \{part_type = cas_full_body}
			0x5a95f6d5 = 1
		endif
		getactualcasoptionstruct part = cas_full_body desc_id = ((<appearance>.cas_full_body).desc_id)
		if (<0x5a95f6d5> = 1)
			unload_part_desc_pak \{part_type = cas_full_body}
		endif
	endif
	if NOT gotparam \{is_female}

		<is_female> = 0
	endif
	return is_female = <is_female>
endscript

script get_is_lefty_from_appearance 
	if structurecontains structure = <appearance> cas_body
		getactualcasoptionstruct part = cas_body desc_id = ((<appearance>.cas_body).desc_id)
	endif
	if structurecontains structure = <appearance> cas_full_body
		getactualcasoptionstruct part = cas_full_body desc_id = ((<appearance>.cas_full_body).desc_id)
	endif
	if NOT gotparam \{lefty}
		return \{false
			lefty = 0}
	endif
	return true lefty = <lefty>
endscript

script get_has_large_hands_from_appearance 
	if structurecontains structure = <appearance> cas_body
		getactualcasoptionstruct part = cas_body desc_id = ((<appearance>.cas_body).desc_id)
	endif
	if structurecontains structure = <appearance> cas_full_body
		getactualcasoptionstruct part = cas_full_body desc_id = ((<appearance>.cas_full_body).desc_id)
	endif
	if NOT gotparam \{large_hands}
		return \{false
			large_hands = 0}
	endif
	return true large_hands = <large_hands>
endscript
0x21556355 = 0

script build_band_member_from_appearance \{instrument = guitar
		with_mic = 0}
	if gotparam \{loading_into_song}
		maybe_use_song_or_venue_specific_instrument {song = $current_song venue = $current_level appearance = <appearance> name = <name>}
	endif
	if (<with_mic> = 1)
		if (<instrument> = guitar)
			instrument = guitar_and_vocals
		elseif (<instrument> = bass)
			instrument = bass_and_vocals
		elseif (<instrument> = vocals)
			instrument = guitar_and_vocals
		endif
	endif
	change \{0x21556355 = 0}
	if ($cheat_airinstruments = 1)
		if gotparam \{loading_into_song}
			change \{0x21556355 = 1}
		endif
	endif
	get_hat_hair_choice appearance = <appearance>
	buildscriptparams = {
		lightgroup = <lightgroup>
		temporary_heap = heap_cas
		instrument = <instrument>
		hat_hair_choice = <hat_hair_choice>
	}
	modelbuilder_preload {
		<...>
		geom_heap = <geom_heap>
		assetcontext = <assetcontext>
		appearance = <appearance>
		buildscriptparams = <buildscriptparams>
	}
	if NOT gotparam \{cancelled}
		obj_getid
		if (<with_mic> = 1 && <objid> != vocalist)
			if NOT (<instrument> = vocals)
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
	waitonegameframe
	repeat
	change \{create_band_member_lock_queue = 1}
	begin
	if ($create_band_member_lock = 0)
		break
	endif
	waitonegameframe
	repeat
	change \{create_band_member_lock_queue = 0}
	change \{create_band_member_lock = 1}
endscript

script destroy_band 
	if ($in_tutorial_mode = 1)

	endif
	cas_destroy_all_characters
	drummer_kill_spawnscripts
	band_stop_anims
	destroy_band_member \{name = guitarist}
	destroy_band_member \{name = guitarist2}
	destroy_band_member \{name = bassist}
	destroy_band_member \{name = bassist2}
	destroy_band_member \{name = drummer}
	destroy_band_member \{name = drummer2}
	destroy_band_member \{name = vocalist}
	destroy_band_member \{name = vocalist2}
	band_unload_anim_paks
endscript

script destroy_band_member 
	ps2_get_musician_context_data name = <name>
	if compositeobjectexists name = <name>
		<name> :gettags current_instrument
		<name> :obj_resetbones
		bandmanager_removecharacter name = <name>
		<name> :die
		flushdeadobjects
		smartunloadpak async = 0 tags = {highway_for = <name>}
		flushdeadobjects
		0x239b2ee5 appearance = ($<bandmember_appearance>) asset_slot_num = <asset_slot_num> asset_heap = <asset_heap>
		if ($ps2_gameplay_restart_song = 1)
			no_appearance_pak_unload = 1
		endif
		if NOT gotparam \{no_appearance_pak_unload}
			unloadappearancepaks appearance = ($<bandmember_appearance>) instrument = <current_instrument> no_wait asset_context = <asset_heap>
			change globalname = <bandmember_appearance> newvalue = {}
		endif
	endif
endscript

script 0x239b2ee5 appearance = ($cas_current_appearance) asset_slot_num = 0 asset_heap = heap_musician1
	0xec020f56 = 0
	if get_key_from_appearance key = drummer_skeleton appearance = <appearance>
		formattext textname = skeleton_pak_name 'pak\\skeletons\\skeleton_%a.pak' a = <drummer_skeleton>
		pushassetcontext context = <asset_heap>
		unloadpak <skeleton_pak_name> heap = <asset_heap> sameheaps
		popassetcontext
		0xec020f56 = (<0xec020f56> + 1)
	endif
	if get_key_from_appearance key = rocker_skeleton appearance = <appearance>
		formattext textname = skeleton_pak_name 'pak\\skeletons\\skeleton_%a.pak' a = <rocker_skeleton>
		pushassetcontext context = <asset_heap>
		unloadpak <skeleton_pak_name> heap = <asset_heap> sameheaps
		popassetcontext
		0xec020f56 = (<0xec020f56> + 1)
	endif
	if (<0xec020f56> < 2)
		get_is_female_from_appearance appearance = <appearance>
		if (<is_female> = 1)
			formattext textname = skeleton_pak_name 'pak\\skeletons\\drummer_skeleton%af.pak' a = <asset_slot_num>
			if ispakloaded <skeleton_pak_name> heap = <asset_heap>
				pushassetcontext context = <asset_heap>
				unloadpak <skeleton_pak_name> heap = <asset_heap> sameheaps
				popassetcontext
			else
				formattext textname = skeleton_pak_name 'pak\\skeletons\\guitarist_skeleton%af.pak' a = <asset_slot_num>
				pushassetcontext context = <asset_heap>
				unloadpak <skeleton_pak_name> heap = <asset_heap> sameheaps
				popassetcontext
			endif
		else
			formattext textname = skeleton_pak_name 'pak\\skeletons\\drummer_skeleton%am.pak' a = <asset_slot_num>
			if ispakloaded <skeleton_pak_name> heap = <asset_heap>
				pushassetcontext context = <asset_heap>
				unloadpak <skeleton_pak_name> heap = <asset_heap> sameheaps
				popassetcontext
			else
				formattext textname = skeleton_pak_name 'pak\\skeletons\\guitarist_skeleton%am.pak' a = <asset_slot_num>
				pushassetcontext context = <asset_heap>
				unloadpak <skeleton_pak_name> heap = <asset_heap> sameheaps
				popassetcontext
			endif
		endif
	endif
endscript

script kill_character_scripts 

	if compositeobjectexists \{name = guitarist}
		guitarist :obj_switchscript \{emptyscript}
	endif
	if compositeobjectexists \{name = bassist}
		bassist :obj_switchscript \{emptyscript}
	endif
	if compositeobjectexists \{name = vocalist}
		vocalist :obj_switchscript \{emptyscript}
	endif
	if compositeobjectexists \{name = drummer}
		drummer :obj_switchscript \{emptyscript}
	endif
endscript

script preload_band_member \{name = guitarist
		async = 0}
	create_band_member_wait_for_lock
	filename_crc = none
	instrument_crc = none
	create_band_member_unlock
	return filename_crc = <filename_crc> instrument_crc = <instrument_crc> true
endscript

script preload_band_member_finish \{name = guitarist
		async = 0}
	create_band_member_wait_for_lock
	create_band_member_unlock
endscript

script 0x24cfe7d0 
	0xdf84e324 = (<0x26dbd790>.material)
	0x18e25931 = (<0x26dbd790>.pass)
	getarraysize <0xb6d2786b>
	i = 0
	begin
	next_struct = (<0xb6d2786b> [<i>])
	0x57eb306e material = <0xdf84e324> pass = <0x18e25931> u = (<next_struct>.u) v = (<next_struct>.v)
	wait (<next_struct>.seconds) seconds
	i = (<i> + 1)
	if (<i> = <array_size>)
		i = 0
	endif
	repeat
endscript
