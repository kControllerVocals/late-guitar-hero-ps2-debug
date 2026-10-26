
script ui_create_popout_select_part 
	spawnscriptnow ui_create_popout_select_part_spawned params = {<...>}
endscript

script ui_create_popout_select_part_spawned \{parent = root_window
		list_offset = (0.0, 55.0)}

	cas_queue_wait
	RemoveParameter \{force_update}
	if (<part> = CAS_Base_Torso || <part> = CAS_Male_Base_Torso || <part> = CAS_Female_Base_Torso)
		force_update = 1
	endif
	make_list_menu {
		vmenu_id = create_popout_select_part_vmenu
		pad_back_script = generic_exit_restore
		pad_back_params = {part = <part> force_update = <force_update>}
		pad_back_sound = NullSound
		parent = <parent>
		text_case = <text_case>
		icon = <hist_tex>
		icon_offset = <icon_offset>
		list_offset = <list_offset>
		additional_z_priority = 150
	}
	if NOT GotParam \{disable_rotation_zoom}
		setup_cas_menu_handlers vmenu_id = create_popout_select_part_vmenu camera_list = <camera_list> zoom_camera = <zoom_camera> no_rotate = <no_rotate> no_zoom = <no_zoom> pull_back_distance = <pull_back_distance>
	endif
	ResolveBodySpecificPartInAppearance part = <part>
	if NOT GotParam \{surrogate_part}
		surrogate_part = <part>
	endif
	current_part = 0
	get_part_current_desc_id part = <surrogate_part>
	GetArraySize ($<part>)
	num_parts_added = 0
	i = 0
	begin
	if cas_item_is_visible part = <part> part_index = <i>
		if is_part_unlocked part = <surrogate_part> desc_id = ((($<part>) [<i>]).desc_id) savegame = ($cas_current_savegame)
			hide_item = 0
			if GotParam \{ghrocker}
				if NOT ghrocker_body_matches matcheswith = <ghrocker> part = <part> desc_id = ((($<part>) [<i>]).desc_id)
					hide_item = 1
				endif
			endif
			if (((($<part>) [<i>]).desc_id) = <current_desc_id>)
				current_part = <num_parts_added>
			endif
			if (<hide_item> = 0)
				if NOT is_part_purchased part = <surrogate_part> desc_id = ((($<part>) [<i>]).desc_id) savegame = ($cas_current_savegame)
					if GotParam \{purchase_menu}
						price = ((($<part>) [<i>]).price)
						FormatText TextName = pad_choose_dialogue qs(0x7f837e4d) s = ((($<part>) [<i>]).frontend_desc)
						show_purchasable = 1
					endif
					if is_part_editable part = <surrogate_part> desc_id = ((($<part>) [<i>]).desc_id)
						editable = {editable}
					endif
				elseif is_part_editable part = <surrogate_part> desc_id = ((($<part>) [<i>]).desc_id)
					if GotParam \{choose_script}
						pad_option2_script = <choose_script>
					else
						pad_option2_script = popout_select_part_decide_action
						show_editable = 1
						editable = {editable}
					endif
					pad_option2_params = {index = <i> part = <part> surrogate_part = <surrogate_part> color_wheel = <color_wheel> num_icons = <num_icons> icon = <hist_tex> cam_name = <cam_name> camera_list = <camera_list> zoom_camera = <zoom_camera> no_rotate = <no_rotate> no_zoom = <no_zoom> pull_back_distance = <pull_back_distance> stance = <stance> additional_deinit_script = <additional_deinit_script> return_stance = <return_stance>}
				endif
				add_list_item {
					text = ((($<part>) [<i>]).frontend_desc)
					pad_choose_script = generic_event_back
					pad_choose_params = {part = <part> nosound}
					camera_list = <camera_list>
					zoom_camera = <zoom_camera>
					additional_focus_script = select_part_focus_change
					additional_focus_params = {part = <part> index = <i> play_current_anim = <play_current_anim> disable_rotation_zoom = <disable_rotation_zoom> show_purchasable = <show_purchasable> show_editable = <show_editable> surrogate_part = <surrogate_part> force_update = <force_update>}
					price = <price>
					pad_choose_dialogue = <pad_choose_dialogue>
					pad_option2_script = <pad_option2_script>
					pad_option2_params = <pad_option2_params>
					<editable>
				}
				num_parts_added = (<num_parts_added> + 1)
			endif
			if GotParam \{price}
				RemoveParameter \{price}
			endif
			if GotParam \{pad_choose_dialogue}
				RemoveParameter \{pad_choose_dialogue}
			endif
			if GotParam \{pad_back_dialogue}
				RemoveParameter \{pad_back_dialogue}
			endif
			if GotParam \{show_purchasable}
				RemoveParameter \{show_purchasable}
			endif
			if GotParam \{show_editable}
				RemoveParameter \{show_editable}
			endif
			if GotParam \{pad_option2_script}
				RemoveParameter \{pad_option2_script}
			endif
			if GotParam \{editable}
				RemoveParameter \{editable}
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	clean_up_user_control_helpers
	LaunchEvent type = focus target = create_popout_select_part_vmenu data = {child_index = <current_part>}
	if GotParam \{stance}
		if GetCurrentCASObject
			BandManager_ChangeStance name = <cas_object> stance = <stance> no_wait
			if ((Stance_Select_DrumSticks = <stance>) || (Stance_Select_Drum = <stance>))
				<cas_object> :Anim_Command target = moment_blend command = PartialSwitch_SetState params = {on BlendDuration = 0.0}
				<cas_object> :Anim_Command target = moment_blend_inner command = PartialSwitch_SetState params = {off BlendDuration = 0.0}
			endif
		endif
	endif
	if GotParam \{cam_name}
		change \{generic_menu_block_input = 1}
		task_menu_default_anim_in base_name = <cam_name>
		change \{generic_menu_block_input = 0}
	endif
endscript

script ui_destroy_popout_select_part 
	generic_list_destroy
	destroy_popup_warning_menu
endscript

script ui_init_popout_select_part 

	ui_load_cas_rawpak part = <part>
	if GotParam \{additional_init_script}
		<additional_init_script>
	endif
	if GotParam \{bonemenu_popup}
		cas_bonemenu_exit part = <bonemenu_popup>
	endif
	PushTemporaryCASAppearance
	if NOT GotParam \{surrogate_part}
		ResolveBodySpecificPartInAppearance part = <part>
		surrogate_part = <part>
	endif
	if NOT load_part_desc_pak part_type = <surrogate_part>
		ui_event_add_params unload_desc_pak_type = <surrogate_part>
	endif
endscript

script ui_deinit_popout_select_part 
	FlushAllCompositeTextures
	CASTemporariesFlush
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
	if GotParam \{unload_desc_pak_type}
		unload_part_desc_pak part_type = <unload_desc_pak_type>
	endif
endscript

script popout_select_part_decide_action 
	spawnscriptnow popout_select_part_decide_action_spawned params = {<...>}
endscript

script popout_select_part_decide_action_spawned 
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	Wait \{1
		seconds}
	cas_queue_wait
	wait_for_camera_anim
	if ScriptIsRunning \{select_part_focus_change_spawned}
		KillSpawnedScript \{name = select_part_focus_change_spawned}
	endif

	if NOT GotParam \{surrogate_part}
		surrogate_part = <part>
	endif
	if ScreenElementExists \{id = create_popout_select_part_vmenu}
		LaunchEvent \{type = unfocus
			target = create_popout_select_part_vmenu}
	endif
	begin
	get_part_current_desc_id part = <surrogate_part>
	if (((($<part>) [<index>]).desc_id) = <current_desc_id>)
		if NOT ScriptIsRunning \{trigger_CAS_rebuild_loop}
			break
		endif
	endif
	Wait \{0.5
		seconds}
	repeat
	cas_queue_wait
	if GotParam \{purchase_menu}
	endif
	ui_event_add_params \{skip_deinit_script = 1}
	if is_part_capable part = <surrogate_part>
		if GetCASPartMaterials part = <surrogate_part>
			generic_event_replace data = {
				state = UIstate_cas_select_part_options
				part = <surrogate_part>
				part_materials = <part_materials>
				num_states = 1
				num_icons = <num_icons>
				hist_tex = <icon>
				camera_list = <camera_list>
				zoom_camera = <zoom_camera>
				no_rotate = <no_rotate>
				no_zoom = <no_zoom>
				pull_back_distance = <pull_back_distance>
				stance = <stance>
				additional_deinit_script = <additional_deinit_script>
				return_stance = <return_stance>
				cam_name = <cam_name>
			}
			return
		endif
		get_section_index_from_desc_id part = <surrogate_part> target_desc_id = Finishes
		if GotParam \{section_index}
			generic_event_replace data = {
				state = UIstate_cap_artist_layer
				part = <surrogate_part> text = qs("Finishes")
				section_index = <section_index>
				back_steps = 2
				camera_list = <camera_list>
				zoom_camera = <zoom_camera>
				no_rotate = <no_rotate>
				no_zoom = <no_zoom>
				pull_back_distance = <pull_back_distance>
				stance = <stance>
				additional_deinit_script = <additional_deinit_script>
				return_stance = <return_stance>
				cam_name = <cam_name>
			}
			return
		else
			generic_event_replace data = {
				state = UIstate_cap_main
				savegame = ($cas_current_savegame)
				part = <surrogate_part> text = qs("Design")
				back_steps = 1
				camera_list = <camera_list>
				zoom_camera = <zoom_camera>
				no_rotate = <no_rotate>
				no_zoom = <no_zoom>
				pull_back_distance = <pull_back_distance>
				stance = <stance>
				additional_deinit_script = <additional_deinit_script>
				return_stance = <return_stance>
				cam_name = <cam_name>
			}
			return
		endif
	elseif GetCASPartMaterials part = <surrogate_part>
		GetArraySize <part_materials>
		if (<array_size> > 1)
			ui_event event = menu_replace data = {
				state = UIstate_cas_select_part_color_options
				part = <surrogate_part>
				part_materials = <part_materials>
				hist_tex = menu_history_color_edit
				num_states = 1
				num_icons = <num_icons>
				color_wheel = <color_wheel>
				camera_list = <camera_list>
				zoom_camera = <zoom_camera>
				no_rotate = <no_rotate>
				no_zoom = <no_zoom>
				pull_back_distance = <pull_back_distance>
				stance = <stance>
				additional_deinit_script = <additional_deinit_script>
				return_stance = <return_stance>
				cam_name = <cam_name>
			}
		else
			ui_event event = menu_replace data = {
				state = UIstate_cas_color_edit
				part = <surrogate_part>
				part_materials = <part_materials>
				hist_tex = menu_history_color_edit
				num_states = 1
				num_icons = <num_icons>
				color_wheel = <color_wheel>
				camera_list = <camera_list>
				zoom_camera = <zoom_camera>
				no_rotate = <no_rotate>
				no_zoom = <no_zoom>
				pull_back_distance = <pull_back_distance>
				stance = <stance>
				additional_deinit_script = <additional_deinit_script>
				return_stance = <return_stance>
				cam_name = <cam_name>
			}
		endif
		return
	endif
endscript

script select_part_focus_change 

	spawnscriptnow select_part_focus_change_spawned params = {<...>}
endscript

script select_part_focus_change_spawned 
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	KillSpawnedScript \{name = popout_select_part_decide_action_spawned}
	get_part_current_desc_id part = <part>
	GetActualCASOptionStruct part = <part> desc_id = ($<part> [<index>].desc_id)
	if NOT GotParam \{sponsor_id}
		sponsor_id = no_sponsor
	endif
	draw_sponsor_logo sponsor_id = <sponsor_id>
	Wait \{1
		seconds}
	cas_queue_wait
	KillAllCompositeTextures
	if NOT GotParam \{surrogate_part}
		surrogate_part = <part>
	endif
	get_part_current_desc_id part = <surrogate_part>

	if (((($<part>) [<index>]).desc_id) != <current_desc_id>)
		new_part = (($<part>) [<index>])
		if StructureContains Structure = (<new_part>) Finishable
			EditCASAppearance target = SetPart targetParams = {part = (<new_part>.Finishable) desc_id = none}
		endif
		if StructureContains Structure = (<new_part>) Detailable
			EditCASAppearance target = SetPart targetParams = {part = (<new_part>.Detailable) desc_id = none}
		endif
		if StructureContains Structure = (<new_part>) Logoable
			EditCASAppearance target = SetPart targetParams = {part = (<new_part>.Logoable) desc_id = none}
		endif
		if StructureContains Structure = (<new_part>) Fadeable
			EditCASAppearance target = SetPart targetParams = {part = (<new_part>.Fadeable) desc_id = none}
		endif
		if (<surrogate_part> = CAS_Select_A_Logo)
			GenerateCAGTexture single_texture = (<new_part>.with1)
		endif
		cas_add_item_to_appearance {
			part = <surrogate_part>
			desc_id = (($<part>) [<index>].desc_id)
			no_rebuild
		}
		if NOT (GotParam play_current_anim)
			spawnscriptnow trigger_CAS_rebuild_loop params = {<...>}
		endif
	endif
	if GotParam \{play_current_anim}
		new_part = (($<part>) [<index>])
		if StructureContains Structure = (<new_part>) frontend_anim_name
			GetCurrentCASObject
			Band_PlaysimpleAnim name = <cas_object> Anim = (<new_part>.frontend_anim_name)
		endif
	endif
	show_prompts = 0
	if ScreenElementExists \{id = create_popout_select_part_vmenu}
		show_prompts = 1
	endif
	if ScreenElementExists \{id = create_cag_select_part_inclusion_vmenu}
		show_prompts = 1
	endif
	if (<show_prompts> = 1)
		clean_up_user_control_helpers
		if GotParam \{disable_rotation_zoom}
			no_rotate_zoom_text = {no_rotate_zoom_text}
		endif
		if GotParam \{show_editable}
			car_helper_text = {car_helper_text_alt}
		elseif GotParam \{show_purchasable}
			car_helper_text = {car_helper_text_purchase}
		else
			car_helper_text = {car_helper_text_cancel}
		endif
		menu_finish <car_helper_text> <no_rotate_zoom_text>
	endif
endscript
