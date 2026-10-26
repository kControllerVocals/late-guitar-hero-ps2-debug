
script ui_init_cas_select_part_swatches 

	ui_cas_precache part = <part>
	if GotParam \{additional_init_script}
		<additional_init_script>
	endif
	if GotParam \{bonemenu_popup}
		cas_bonemenu_exit part = <bonemenu_popup>
	endif
	PushTemporaryCASAppearance
endscript

script ui_create_cas_select_part_swatches 
	ui_event_add_params hist_tex = <hist_tex>

	make_generic_menu {
		vmenu_id = create_cas_swatch_select_vmenu
		title = qs("CHANGE STYLE")
		num_icons = <num_icons>
		show_history
		exclusive_device = <state_device>
	}
	setup_cas_menu_handlers vmenu_id = create_cas_swatch_select_vmenu camera_list = <camera_list> zoom_camera = <zoom_camera>
	if GotParam \{cam_name}
		spawnscriptnow task_menu_default_anim_in params = {base_name = <cam_name>}
	endif
	ResolveBodySpecificPartInAppearance part = <part>
	GetArraySize <part_swatches>
	if (<array_size> = 0)

	endif
	create_swatch_wheel {
		scale = 20
		pad_choose_script = select_part_swatches_exit_accept
		pad_choose_params = {
			part = <part>
			part_swatches = <part_swatches>
		}
		part = <part>
		part_swatches = <part_swatches>
		frontend_desc = <frontend_desc>
		current_swatch_desc_id = <current_swatch_desc_id>
		special_exit_script = select_part_swatches_restore_previous
	}
	swatch_area_desc_id :Obj_SpawnScriptNow load_swatch_textures params = {
		part = <part>
		part_swatches = <part_swatches>
	}
	add_user_control_helper controller = <state_device> text = qs("SELECT") button = green z = 100000
	add_user_control_helper controller = <state_device> text = qs("CANCEL") button = red z = 100000
	menu_finish_rotate_zoom
	LaunchEvent \{type = focus
		target = create_cas_swatch_select_vmenu
		data = {
			child_index = 0
		}}
	LaunchEvent \{type = pad_choose}
	if ScreenElementExists \{id = swatch_wheel_menu_item}
		setup_cas_menu_handlers vmenu_id = swatch_wheel_menu_item no_zoom = <no_zoom> camera_list = <camera_list> zoom_camera = <zoom_camera>
	endif
endscript

script ui_destroy_cas_select_part_swatches 
	if ScreenElementExists \{id = swatch_wheel_menu_item}
		swatch_area_desc_id :Obj_KillSpawnedScript \{name = load_swatch_textures}
	endif
	destroy_generic_menu
	load_swatch_textures_cleanup <...>
endscript

script ui_deinit_cas_select_part_swatches 
	FlushAllCompositeTextures
	PopTemporaryCASAppearance
	if NOT GotParam \{skip_deinit_script}
		if GotParam \{additional_deinit_script}
			<additional_deinit_script>
		endif
		if GetCurrentCASObject
			if GotParam \{return_stance}
				BandManager_ChangeStance name = <cas_object> stance = <return_stance> no_wait
			else
				BandManager_ChangeStance name = <cas_object> stance = stance_frontend no_wait
			endif
		endif
	else
		ui_event_remove_params \{param = skip_deinit_script}
	endif
	cleanup_cas_menu_handlers
	if GotParam \{bonemenu_popup}
		cas_bonemenu_begin part = <bonemenu_popup>
	endif
endscript

script select_part_swatches_restore_previous 
	RestoreTopTemporaryCASAppearance
	generic_event_back
endscript

script select_part_swatches_exit_accept 
	generic_event_back
endscript

script GetCASPartSwatches 
	if NOT GetCASAppearancePart part = <part>
		return \{false}
	endif
	if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>
		return \{false}
	endif
	current_swatch_desc_id = <desc_id>
	if GotParam \{swatch_for}
		if NOT GetActualCASOptionStruct part = <part> desc_id = <swatch_for>
			return \{false}
		endif
	endif
	if GotParam \{swatch_list}
		GetArraySize <swatch_list>
		if (<array_size> > 0)
			array = []
			AddArrayElement array = <array> element = {desc_id = <desc_id>}
			i = 0
			begin
			AddArrayElement array = <array> element = {desc_id = (<swatch_list> [<i>])}
			i = (<i> + 1)
			repeat <array_size>
			return true part_swatches = <array> frontend_desc = <frontend_desc> current_swatch_desc_id = <current_swatch_desc_id>
		endif
	endif
	return \{false}
endscript

script part_has_swatch_list 

	if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>
		return \{false}
	endif
	if GotParam \{swatch_list}
		return true parent_swatch = <desc_id>
	endif
	if GotParam \{swatch_for}
		return true parent_swatch = <swatch_for>
	endif
	return \{false}
endscript
