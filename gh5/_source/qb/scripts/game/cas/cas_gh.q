max_num_create_a_rockers = 8
max_num_instrument_saves = 8
max_num_logo_saves = 10
cas_current_player = 1
cas_current_player_name = cas_player1
cas_editing_new_character = false
charselect_previous_character_id = judy
cas_node_name = z_soundcheck_trg_waypoint_car_start
cas_empty_heap_score = 0.25

script get_section_index_from_desc_id 

	if NOT getcasappearancepart part = <part>

	endif
	if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>

	endif
	if gotparam \{sections}
		getarraysize \{sections}
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

	getarraysize <deform_bones> globalarray
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
	setcasappearancebones part = <part> bones = {}
	updatecurrentcasmodel \{buildscript = reskin_model_from_appearance}
endscript

script reset_additional_bone_deform_info 
	setcasappearanceadditionalbones part = <part> additional_bone_transforms = []
	updatecurrentcasmodel \{buildscript = reskin_model_from_appearance}
endscript

script exit_to_customize_character 
	ui_event \{event = menu_change
		data = {
			state = uistate_customize_character
		}}
endscript

script verify_genre_data 
	if NOT cd
		foreachin \{$master_editable_list
			do = verify_genre_data_foreach}
	endif
endscript

script verify_genre_data_foreach 
	if globalexists name = <part> type = array
		foreachin ($<part>) do = verify_genre_data_foreach_part
	endif
endscript

script verify_genre_data_foreach_part 
	if gotparam \{genre}
		if NOT isarray (<genre>)

		else
			foreachin <genre> do = verify_genre_data_foreach_part_genre params = {piece = <desc_id>}
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
	getarraysize ($genre_list)
	begin
	if (((($genre_list) [<i>]).desc_id) = <genre>)
		found = 1
		break
	endif
	i = (<i> + 1)
	repeat <array_size>
	if NOT gotparam \{found}
		if NOT gotparam \{piece}
			piece = none
		endif

	endif
endscript

script create_cas_cache_pak \{heap = heap_cas}
	if NOT compositeobjectexists \{name = global_cas_cache}
		createcompositeobject \{components = [
				{
					component = modelbuilder
					create_cache
				}
			]
			params = {
				name = global_cas_cache
			}}
		global_cas_cache :modelbuilder_createdynamicpak heap = <heap> size = <size> vram_size = <vram_size>
	else

	endif
endscript

script free_cas_cache_pak 
	if compositeobjectexists \{name = global_cas_cache}
		cascancelloading
		global_cas_cache :die
		flushdeadobjects
	endif
endscript

script cascacheflushvram 
	if compositeobjectexists \{name = global_cas_cache}
		global_cas_cache :modelbuilder_flushdynamicpakvram
	endif
endscript

script cascachemodel async = 0 object_name = ($cas_current_object)
	(<object_name>) :obj_cleargeoms
	if (<async> = 1)
		killspawnedscript \{name = ps2_cas_model_caching}
		spawnscriptlater ps2_cas_model_caching params = {heap = heap_musician1 asset_context = heap_musician1 <...>}
	else
		unloadappearancepaks asset_context = heap_musician1 appearance = <appearance>
		loadappearancepaks appearance = <appearance> heap = heap_musician1 asset_context = heap_musician1
		<callback> {<callbackparams> appearance = <appearance>}
	endif
endscript

script ps2_cas_model_caching 
	wait \{1
		seconds}
	unloadappearancepaks async = 1 <...>
	loadappearancepaks async = 1 <...>
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
	if NOT cd
		if casartist
			if NOT ($cas_heap_state = in_game)
				stars

				stars
				flush_cas_cache
				cas_rawpak_clear
				disablecasarchive
				cascancelloading
				casblockforcomposite
				casblockforloading
				cas_queue_wait
				getcurrentcasobject
				<cas_object> :obj_cleargeoms
				finishrendering
				<cas_object> :modelbuilder_unload
				rebuildcurrentcasmodel
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
	setcasappearance appearance = (<profile_struct>.appearance)
	change cas_current_profile = <character_id>
	change cas_current_savegame = <savegame>
endscript

script cas_get_player_status 
	<player_status> = ($0x2994109a [$cas_current_player])
	return player_status = <player_status>
endscript

script cas_fix_cameras_for_game 
	killcamanim \{all}
	destroy_bg_viewport
	setup_bg_viewport
	restore_dummy_bg_camera
endscript

script cas_load_and_setup_resources 
	mark_unsafe_for_shutdown
	caswaitforunloads \{block}
	finishrendering
	if NOT ((gotparam album_art) || (gotparam band_logo))
		getpakmancurrent \{map = zones}
		if checksumequals a = <pak> b = z_soundcheck
			if ($autolaunch_cas_artist = 1)
				setpakmancurrentblock \{map = zones
					pak = z_objviewer_cas
					block_scripts = 1}
				lightshow_initeventmappings \{force_pakname = 'z_objviewer'}
				lightshow_dummyloop
			else
				setpakmancurrentblock \{map = zones
					pak = z_soundcheck_cas
					block_scripts = 1}
			endif
		else

		endif
		set_cas_heap_state \{state = in_cas}
	endif
	setshadowrenderingflags \{enable = 'true'
		object = 'skin'}
	setshadowmapparams \{far = 16.0}
	if NOT gotparam \{no_cam}
		destroy_bg_viewport
		setup_bg_viewport
		restore_dummy_bg_camera
		if NOT gotparam \{album_art}
			playigccam \{id = cas_view_cam_id
				name = cas_view_cam
				viewport = bg_viewport
				lockto = world
				pos = (2.028921, 0.879576, -0.059630997)
				quat = (-0.000911, 0.9990699, 0.027344998)
				fov = 72.0
				play_hold = 1
				interrupt_current}
		else
			playigccam \{id = cas_view_cam_id
				name = cas_view_cam
				viewport = bg_viewport
				lockto = world
				pos = (-0.536864, 2.1043458, 15.148574)
				quat = (0.0052940003, 0.02768, -0.000218)
				fov = 72.0
				play_hold = 1
				interrupt_current}
		endif
	endif
	if NOT ((gotparam album_art) || (gotparam band_logo))
		cas_rawpak_setup
	endif
	mark_safe_for_shutdown
endscript

script cas_free_resources \{block_scripts = 0}
	setscriptcannotpause
	mark_unsafe_for_shutdown
	finishrendering
	casblockforloading
	killallcompositetextures
	castemporariesflush
	caswaitforunloads \{block}
	cas_rawpak_free
	set_cas_heap_state \{state = in_game}
	if ($shutdown_game_for_signin_change_flag = 0)

		if NOT pakfilesarecached
			destroy_loading_screen
		endif
	endif
	if NOT gotparam \{no_fix_camera}
		cas_fix_cameras_for_game
	endif
	mark_safe_for_shutdown
	change \{cas_free_cam_active = 0}
endscript

script refreshcasprofile 
	if cd
		return
	endif
	if NOT casartist
		stars

		stars
		return
	endif
	if ($cas_heap_state = in_game)

	endif
	if NOT getcurrentcasobject

	endif
	cas_queue_new_character_profile id = ($cas_current_profile) player = ($cas_current_player) savegame = ($cas_current_savegame)
	get_musician_profile_struct_by_id id = ($cas_current_profile) savegame = ($cas_current_savegame)
	setcasappearance appearance = (<profile_struct>.appearance)
endscript

script createassetstoragefrombudgetblock 
	if NOT gotparam \{slopheap}
		slopheap = <name>
	endif
	if NOT gotparam \{assetcontext}
		assetcontext = <name>
	endif
	cassetupassetstorage name = <name> params = {
		allocator = budget
		blockname = <name>
		assetcontext = <assetcontext>
		slopheap = <slopheap>
	}
endscript

script set_new_car_preset_physique 
	if NOT getcasappearancepart \{part = cas_physique}

	endif
	if NOT getactualcasoptionstruct part = cas_physique desc_id = <desc_id>

	endif
	if NOT gotparam \{preset_builds}

	endif
	if NOT gotparam \{default_car_preset_build_index}

	endif
	chosen = (<preset_builds> [<default_car_preset_build_index>])
	setcasappearanceadditionalbones part = cas_physique additional_bone_transforms = (<chosen>.additional_bone_transforms)
	return preset_physique_index = <default_car_preset_build_index>
endscript

script generate_random_appearance 

	if gotparam \{new_car_character}
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
		getrandomarrayelement ($gh_random_car_female_names)
	else
		getrandomarrayelement ($gh_random_car_male_names)
	endif
	return random_name = <element>
endscript

script generate_random_genre 
	takeaway = 2
	if gotparam \{allow_mixed}
		takeaway = 1
	endif
	getarraysize \{$genre_list}
	getrandomvalue a = 0 b = (<array_size> - <takeaway>) name = genre_index integer
	return genre = ($genre_list [<genre_index>].desc_id)
endscript

script cas_change_current_character_gender 
	if NOT gotparam \{genre}
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
highway_instrument_map = {
	guitar = cas_guitar_highway
	bass = cas_bass_highway
	drum = cas_drums_highway
}

script get_highway_struct_from_appearance 
	if structurecontains structure = ($highway_instrument_map) <part>
		highway_part = ($highway_instrument_map.<part>)

		if structurecontains structure = <appearance> <highway_part>
			getactualcasoptionstruct part = <highway_part> desc_id = (<appearance>.<highway_part>.desc_id)
		else
			getactualcasoptionstruct part = <highway_part> desc_id = axelhighway
		endif
		return true frontend_img = <frontend_img> highway_pak = <highway_pak> highway_texture = <highway_texture>
	else

		return \{false}
	endif
endscript

script cas_free_resources_camera_fix 
	if scriptisrunning \{cas_free_resources}
		begin
		if NOT scriptisrunning \{cas_free_resources}
			break
		endif
		wait \{1
			gameframe}
		repeat
		spawnscriptnow task_menu_default_anim_in params = {base_name = <base_name>}
	elseif gotparam \{alwaysfix}
		spawnscriptnow task_menu_default_anim_in params = {base_name = <base_name>}
	endif
endscript

script is_part_editable 

	getactualcasoptionstruct part = <part> desc_id = <desc_id>
	if part_has_sections part = <part> desc_id = <desc_id>
		return \{true}
	elseif part_has_materials part = <part> desc_id = <desc_id>
		return \{true}
	else
		if ((gotparam color_all_materials) || (gotparam materials))
			return \{true}
		endif
		return \{false}
	endif
endscript

script part_has_sections 

	getactualcasoptionstruct part = <part> desc_id = <desc_id>
	if gotparam \{sections}
		return \{true}
	endif
	return \{false}
endscript

script part_has_materials 

	if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>
		return \{false}
	endif
	if gotparam \{materials}
		getarraysize <materials>
		if (<array_size> > 0)
			return \{true}
		endif
	else
		if gotparam \{material_groups}
			getarraysize <material_groups>
			if (<array_size> > 0)
				return \{true}
			endif
		else
			if gotparam \{modify_all_materials}
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script cas_drum_stick_bake_transforms 



	switch <skeletonname>
		case drummer_skeleton0m
		case drummer_skeleton1m
		case drummer_skeleton2m
		case drummer_skeleton3m
		if (<material_index> = 0)
			pos = (0.0, 0.0, 0.0)
			orientation = (0.0, 0.0, 0.0)
		else
			pos = (0.0, 0.0, 0.0)
			orientation = (0.0, 0.0, 0.0)
		endif
		case drummer_skeleton0f
		case drummer_skeleton1f
		case drummer_skeleton2f
		case drummer_skeleton3f

		if (<material_index> = 0)

			pos = (-0.09081, 0.09465001, 0.014779999)
			orientation = (0.0, 0.0, 0.0)
		else

			pos = (0.09079, 0.09463001, 0.014779999)
			orientation = (0.0, 0.0, 0.0)
		endif
		case 0xd0ef43ee
		case gh_drummer_axel_1
		axel_drumstick_offset <...>
		case gh_drummer_casey_1
		casey_drumstick_offset <...>
		case gh_drummer_clive_1
		clive_drumstick_offset <...>
		case gh_drummer_eddie_1
		eddie_drumstick_offset <...>
		case gh_drummer_izzy_1
		izzy_drumstick_offset <...>
		case gh_drummer_johnny_1
		johnny_drumstick_offset <...>
		case 0x239025b6
		johnnycash_drumstick_offset <...>
		case gh_drummer_shirleymanson_1
		shirleymanson_drumstick_offset <...>
		case gh_drummer_judy_1
		judy_drumstick_offset <...>
		case gh_drummer_lars_1
		lars_drumstick_offset <...>
		case gh_drummer_midori_1
		midori_drumstick_offset <...>
		case gh_drummer_pandora_1
		pandora_drumstick_offset <...>
		case gh_drummer_frankenrocker_1
		frankenrocker_drumstick_offset <...>
		default
		if (<material_index> = 0)
			pos = (0.0, 0.0, 0.0)
			orientation = (0.0, 0.0, 0.0)
		else
			pos = (0.0, 0.0, 0.0)
			orientation = (0.0, 0.0, 0.0)
		endif
	endswitch
	obj_baketransform geom = <part> pos = <pos>
endscript

script axel_drumstick_offset 

	if (<material_index> = 0)
		pos = (0.159723, -0.021472, 0.0023196302)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (-0.159739, -0.0214857, 0.0023173501)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script casey_drumstick_offset 

	if (<material_index> = 0)
		pos = (-0.09135061, 0.093663804, -0.0147257)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0913313, 0.09364941, -0.0147287)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script clive_drumstick_offset 

	if (<material_index> = 0)
		pos = (0.0, 0.0, 0.0)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0, 0.0, 0.0)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script eddie_drumstick_offset 

	if (<material_index> = 0)
		pos = (0.0, 0.0, 0.0)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0, 0.0, 0.0)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script izzy_drumstick_offset 

	if (<material_index> = 0)
		pos = (0.0, 0.0, 0.0)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0, 0.0, 0.0)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script johnny_drumstick_offset 

	if (<material_index> = 0)
		pos = (0.0, 0.0, 0.0)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0, 0.0, 0.0)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script johnnycash_drumstick_offset 

	if (<material_index> = 0)
		pos = (0.029867599, -0.00027984398, 0.000767075)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (-0.0298582, -0.00026875702, 0.00076712697)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script shirleymanson_drumstick_offset 

	if (<material_index> = 0)
		pos = (-0.091300905, 0.09368741, -0.014790599)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0912823, 0.0936723, -0.014792499)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script judy_drumstick_offset 

	if (<material_index> = 0)
		pos = (-0.09135061, 0.093663804, -0.0147257)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.0913313, 0.09364941, -0.0147287)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script lars_drumstick_offset 

	if (<material_index> = 0)
		pos = (0.12968501, -0.0029761803, 0.0201722)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (-0.129701, -0.0029930503, 0.0201723)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script midori_drumstick_offset 

	if (<material_index> = 0)
		pos = (-0.091301, 0.09368741, -0.014790599)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.091282204, 0.0936726, -0.014792499)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script pandora_drumstick_offset 

	if (<material_index> = 0)
		pos = (-0.091301, 0.09368741, -0.014790599)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.091282204, 0.0936726, -0.014792499)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script frankenrocker_drumstick_offset 

	if (<material_index> = 0)
		pos = (0.159723, -0.021472, 0.0023196603)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (-0.159739, -0.0214857, 0.0023173601)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript

script avatar_drumstick_offset 
	if (<material_index> = 0)
		pos = (-0.023487, 0.0465757, 0.0336008)
		orientation = (0.0, 0.0, 0.0)
	else
		pos = (0.014034899, 0.051011495, 0.024354799)
		orientation = (0.0, 0.0, 0.0)
	endif
	return <...>
endscript
