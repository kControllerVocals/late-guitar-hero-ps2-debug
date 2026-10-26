
script ui_create_cag_metallica_presets \{stance = Stance_Select_Guitar}
	spawnscriptnow ui_create_cag_metallica_presets_spawned params = {<...>}
endscript

script ui_create_cag_metallica_presets_spawned 
	make_list_menu {
		vmenu_id = create_cag_metallica_vmenu
		pad_back_script = list_exit_restore
		icon = <hist_tex>
	}
	setup_cas_menu_handlers vmenu_id = create_cag_metallica_vmenu camera_list = <camera_list> zoom_camera = <zoom_camera>
	get_part_current_desc_id part = <part>
	current_body_id = <current_desc_id>
	<current_part> = 0
	<num_parts_added> = 0
	if (<part> = CAS_Guitar_Body)
		<cas_presets> = CAS_Preset_Metallica_Guitars
		finish_part = CAS_Guitar_Finish
		detail_part = CAS_Guitar_Body_Detail
		get_part_current_desc_id \{part = CAS_Guitar_Finish}
		current_finish_id = <current_desc_id>
		get_part_current_desc_id \{part = CAS_Guitar_Body_Detail}
		current_detail_id = <current_desc_id>
	elseif (<part> = CAS_Bass_Body)
		<cas_presets> = CAS_Preset_Metallica_Basses
		finish_part = CAS_Bass_Finish
		detail_part = CAS_Bass_Body_Detail
		get_part_current_desc_id \{part = CAS_Bass_Finish}
		current_finish_id = <current_desc_id>
		get_part_current_desc_id \{part = CAS_Bass_Body_Detail}
		current_detail_id = <current_desc_id>
	endif
	GetArraySize ($<cas_presets>)
	<num_presets> = <array_size>
	<i> = 0
	begin
	<desc_id> = ($<cas_presets> [<i>].<part>.desc_id)
	finish_id = none
	if StructureContains Structure = ($<cas_presets> [<i>]) (<finish_part>)
		finish_id = ($<cas_presets> [<i>].<finish_part>.desc_id)
	endif
	detail_id = none
	if StructureContains Structure = ($<cas_presets> [<i>]) (<detail_part>)
		detail_id = ($<cas_presets> [<i>].<detail_part>.desc_id)
	endif
	if (<desc_id> = <current_body_id>)
		if (<finish_id> = <current_finish_id>)
			if (<detail_id> = <current_detail_id>)
				<current_part> = <num_parts_added>
			endif
		endif
	endif
	item_text = qs("\LNone")
	if StructureContains Structure = ($<cas_presets> [<i>]) Preset_Name
		item_text = ($<cas_presets> [<i>].Preset_Name)
	endif
	add_item = 1
	if StructureContains Structure = ($<cas_presets> [<i>]) CAS_Unlockable_Presets
		GetArraySize ($CAS_Unlockable_Presets)
		<num_bodies> = <array_size>
		<j> = 0
		begin
		preset_lock_part = ($<cas_presets> [<i>].CAS_Unlockable_Presets.desc_id)
		if ($CAS_Unlockable_Presets [<j>].desc_id = <preset_lock_part>)
			if is_part_unlocked part = CAS_Unlockable_Presets desc_id = <preset_lock_part> savegame = ($cas_current_savegame)
				if NOT is_part_purchased part = CAS_Unlockable_Presets desc_id = <preset_lock_part> savegame = ($cas_current_savegame)
					price = (($CAS_Unlockable_Presets [<j>].price))
					FormatText TextName = pad_choose_dialogue qs("Would you like to purchase this %s?") s = (<item_text>)
					show_purchasable = 1
					pad_back_script = generic_event_back
				endif
			else
				add_item = 0
			endif
			if StructureContains Structure = ($CAS_Unlockable_Presets [<j>]) exclusive
				add_item = 0
			endif
			break
		endif
		<j> = (<j> + 1)
		repeat <num_bodies>
	endif
	if (<add_item> = 1)
		add_list_item {
			text = <item_text>
			pad_choose_script = cag_metallica_presets_choose
			pad_choose_params = {part = {desc_id = <preset_lock_part>} is_preset = 1 presets = CAS_Unlockable_Presets}
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
			additional_focus_script = cag_metallica_presets_update
			additional_focus_params = {cas_presets = <cas_presets> part = <part> index = <i> disable_rotation_zoom = <disable_rotation_zoom>
				show_purchasable = <show_purchasable>}
			price = <price>
			pad_choose_dialogue = <pad_choose_dialogue>
		}
		<num_parts_added> = (<num_parts_added> + 1)
	endif
	if GotParam \{price}
		RemoveParameter \{price}
	endif
	if GotParam \{pad_choose_dialogue}
		RemoveParameter \{pad_choose_dialogue}
	endif
	if GotParam \{show_purchasable}
		RemoveParameter \{show_purchasable}
	endif
	<i> = (<i> + 1)
	repeat <num_presets>
	clean_up_user_control_helpers
	menu_finish \{car_helper_text}
	LaunchEvent type = focus target = create_cag_metallica_vmenu data = {child_index = <current_part>}
endscript

script cag_metallica_presets_update 
	<preset> = ($<cas_presets> [<index>])
	if (<part> = CAS_Guitar_Body)
		cag_metallica_presets_update_guitar preset = <preset>
	elseif (<part> = CAS_Bass_Body)
		cag_metallica_presets_update_bass preset = <preset>
	endif
	spawnscriptnow \{trigger_CAS_rebuild_loop}
endscript

script ui_destroy_cag_metallica_presets 
	generic_list_destroy
	menu_finish \{car_helper_text}
endscript

script ui_init_cag_metallica_presets 
	PushTemporaryCASAppearance
	ui_load_cas_rawpak part = <part>
endscript

script ui_deinit_cag_metallica_presets 
	PopTemporaryCASAppearance
	cleanup_cas_menu_handlers
endscript

script cag_metallica_presets_update_guitar 
	guitar_parts = ($instrument_part_sets.guitar)
	i = 0
	GetArraySize (<guitar_parts>)
	begin
	part_slot = (<guitar_parts> [(<i>)])
	if StructureContains Structure = <preset> <part_slot>
		update_part_cap preset = <preset> part = <part_slot>
	else
		EditCASAppearance target = ClearPart targetParams = {part = <part_slot>}
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script cag_metallica_presets_update_bass 
	guitar_parts = ($instrument_part_sets.Bass)
	i = 0
	GetArraySize (<guitar_parts>)
	begin
	part_slot = (<guitar_parts> [(<i>)])
	if StructureContains Structure = <preset> <part_slot>
		update_part_cap preset = <preset> part = <part_slot>
	else
		EditCASAppearance target = ClearPart targetParams = {part = <part_slot>}
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script update_part_cap 
	EditCASAppearance target = SetPart targetParams = {part = <part> desc_id = (<preset>.<part>.desc_id)}
	if StructureContains Structure = (<preset>.<part>) cap
		<CAP_array> = (<preset>.<part>.cap)
		SetCASAppearanceCAP part = <part> cap = <CAP_array>
	endif
	if StructureContains Structure = (<preset>.<part>) chosen_materials
		<chosen_materials> = (<preset>.<part>.chosen_materials)
		SetCASAppearanceMaterial part = <part> material = material1 value = (<chosen_materials>.material1)
	endif
endscript

script cag_metallica_presets_choose 
	if ($cag_instrument_type = guitar)
		SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {guitar_category = metallica}
	elseif ($cag_instrument_type = Bass)
		SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {bass_category = metallica}
	endif
	generic_event_back
endscript
