
script ui_create_popout_select_part 
	spawnscriptnow ui_create_popout_select_part_spawned params = {<...>}
endscript

script ui_create_popout_select_part_spawned \{parent = root_window
		list_offset = (0.0, 55.0)}

	cas_queue_wait
	removeparameter \{force_update}
	if (<part> = cas_base_torso || <part> = cas_male_base_torso || <part> = cas_female_base_torso)
		force_update = 1
	endif
	make_list_menu {
		vmenu_id = create_popout_select_part_vmenu
		pad_back_script = generic_exit_restore
		pad_back_params = {part = <part> force_update = <force_update>}
		pad_back_sound = nullsound
		parent = <parent>
		text_case = <text_case>
		icon = <hist_tex>
		icon_offset = <icon_offset>
		list_offset = <list_offset>
		additional_z_priority = 150
	}
	if NOT gotparam \{disable_rotation_zoom}
		setup_cas_menu_handlers vmenu_id = create_popout_select_part_vmenu camera_list = <camera_list> zoom_camera = <zoom_camera> no_rotate = <no_rotate> no_zoom = <no_zoom> pull_back_distance = <pull_back_distance>
	endif
	resolvebodyspecificpartinappearance part = <part>
	if NOT gotparam \{surrogate_part}
		surrogate_part = <part>
	endif
	current_part = 0
	get_part_current_desc_id part = <surrogate_part>
	getarraysize ($<part>)
	num_parts_added = 0
	i = 0
	begin
	if cas_item_is_visible part = <part> part_index = <i>
		if is_part_unlocked part = <surrogate_part> desc_id = ((($<part>) [<i>]).desc_id) savegame = ($cas_current_savegame)
			hide_item = 0
			if gotparam \{ghrocker}
				if NOT ghrocker_body_matches matcheswith = <ghrocker> part = <part> desc_id = ((($<part>) [<i>]).desc_id)
					hide_item = 1
				endif
			endif
			if (((($<part>) [<i>]).desc_id) = <current_desc_id>)
				current_part = <num_parts_added>
			endif
			if (<hide_item> = 0)
				if NOT is_part_purchased part = <surrogate_part> desc_id = ((($<part>) [<i>]).desc_id) savegame = ($cas_current_savegame)
					if gotparam \{purchase_menu}
						price = ((($<part>) [<i>]).price)
						formattext textname = pad_choose_dialogue qs(0x7f837e4d) s = ((($<part>) [<i>]).frontend_desc)
						show_purchasable = 1
					endif
					if is_part_editable part = <surrogate_part> desc_id = ((($<part>) [<i>]).desc_id)
						editable = {editable}
					endif
				elseif is_part_editable part = <surrogate_part> desc_id = ((($<part>) [<i>]).desc_id)
					if gotparam \{choose_script}
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
			if gotparam \{price}
				removeparameter \{price}
			endif
			if gotparam \{pad_choose_dialogue}
				removeparameter \{pad_choose_dialogue}
			endif
			if gotparam \{pad_back_dialogue}
				removeparameter \{pad_back_dialogue}
			endif
			if gotparam \{show_purchasable}
				removeparameter \{show_purchasable}
			endif
			if gotparam \{show_editable}
				removeparameter \{show_editable}
			endif
			if gotparam \{pad_option2_script}
				removeparameter \{pad_option2_script}
			endif
			if gotparam \{editable}
				removeparameter \{editable}
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	clean_up_user_control_helpers
	launchevent type = focus target = create_popout_select_part_vmenu data = {child_index = <current_part>}
	if gotparam \{stance}
		if getcurrentcasobject
			bandmanager_changestance name = <cas_object> stance = <stance> no_wait
			if ((stance_select_drumsticks = <stance>) || (stance_select_drum = <stance>))
				<cas_object> :anim_command target = moment_blend command = partialswitch_setstate params = {on blendduration = 0.0}
				<cas_object> :anim_command target = moment_blend_inner command = partialswitch_setstate params = {off blendduration = 0.0}
			endif
		endif
	endif
	if gotparam \{cam_name}
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
	if gotparam \{additional_init_script}
		<additional_init_script>
	endif
	if gotparam \{bonemenu_popup}
		cas_bonemenu_exit part = <bonemenu_popup>
	endif
	pushtemporarycasappearance
	if NOT gotparam \{surrogate_part}
		resolvebodyspecificpartinappearance part = <part>
		surrogate_part = <part>
	endif
	if NOT load_part_desc_pak part_type = <surrogate_part>
		ui_event_add_params unload_desc_pak_type = <surrogate_part>
	endif
endscript

script ui_deinit_popout_select_part 
	flushallcompositetextures
	castemporariesflush
	poptemporarycasappearance
	if NOT gotparam \{skip_deinit_script}
		if gotparam \{additional_deinit_script}
			<additional_deinit_script>
		endif
		if getcurrentcasobject
			if gotparam \{return_stance}
				bandmanager_changestance name = <cas_object> stance = <return_stance> no_wait
			else
				bandmanager_changestance name = <cas_object> stance = stance_frontend no_wait
			endif
		endif
	else
		ui_event_remove_params \{param = skip_deinit_script}
	endif
	cleanup_cas_menu_handlers
	if gotparam \{bonemenu_popup}
		cas_bonemenu_begin part = <bonemenu_popup>
	endif
	if gotparam \{unload_desc_pak_type}
		unload_part_desc_pak part_type = <unload_desc_pak_type>
	endif
endscript

script popout_select_part_decide_action 
	spawnscriptnow 0x05a7401a params = {<...>}
endscript

script 0x05a7401a 
	setspawninstancelimits \{max = 1
		management = kill_oldest}
	wait \{1
		seconds}
	cas_queue_wait
	wait_for_camera_anim
	if scriptisrunning \{select_part_focus_change_spawned}
		killspawnedscript \{name = select_part_focus_change_spawned}
	endif

	if NOT gotparam \{surrogate_part}
		surrogate_part = <part>
	endif
	if screenelementexists \{id = create_popout_select_part_vmenu}
		launchevent \{type = unfocus
			target = create_popout_select_part_vmenu}
	endif
	begin
	get_part_current_desc_id part = <surrogate_part>
	if (((($<part>) [<index>]).desc_id) = <current_desc_id>)
		if NOT scriptisrunning \{trigger_cas_rebuild_loop}
			break
		endif
	endif
	wait \{0.5
		seconds}
	repeat
	cas_queue_wait
	if gotparam \{purchase_menu}
	endif
	ui_event_add_params \{skip_deinit_script = 1}
	if is_part_capable part = <surrogate_part>
		if getcaspartmaterials part = <surrogate_part>
			generic_event_replace data = {
				state = uistate_cas_select_part_options
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
		get_section_index_from_desc_id part = <surrogate_part> target_desc_id = finishes
		if gotparam \{section_index}
			generic_event_replace data = {
				state = uistate_cap_artist_layer
				part = <surrogate_part> text = qs(0x6e23fd31)
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
				state = uistate_cap_main
				savegame = ($cas_current_savegame)
				part = <surrogate_part> text = qs(0xd02a3b59)
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
	elseif getcaspartmaterials part = <surrogate_part>
		getarraysize <part_materials>
		if (<array_size> > 1)
			ui_event event = menu_replace data = {
				state = uistate_cas_select_part_color_options
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
				state = uistate_cas_color_edit
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
	setspawninstancelimits \{max = 1
		management = kill_oldest}
	killspawnedscript \{name = 0x05a7401a}
	get_part_current_desc_id part = <part>
	getactualcasoptionstruct part = <part> desc_id = ($<part> [<index>].desc_id)
	if NOT gotparam \{sponsor_id}
		sponsor_id = 0xc0671aff
	endif
	0x4b5f92af sponsor_id = <sponsor_id>
	wait \{1
		seconds}
	cas_queue_wait
	killallcompositetextures
	if NOT gotparam \{surrogate_part}
		surrogate_part = <part>
	endif
	get_part_current_desc_id part = <surrogate_part>

	if (((($<part>) [<index>]).desc_id) != <current_desc_id>)
		new_part = (($<part>) [<index>])
		if structurecontains structure = (<new_part>) finishable
			editcasappearance target = setpart targetparams = {part = (<new_part>.finishable) desc_id = none}
		endif
		if structurecontains structure = (<new_part>) detailable
			editcasappearance target = setpart targetparams = {part = (<new_part>.detailable) desc_id = none}
		endif
		if structurecontains structure = (<new_part>) logoable
			editcasappearance target = setpart targetparams = {part = (<new_part>.logoable) desc_id = none}
		endif
		if structurecontains structure = (<new_part>) fadeable
			editcasappearance target = setpart targetparams = {part = (<new_part>.fadeable) desc_id = none}
		endif
		if (<surrogate_part> = 0x197f6b46)
			generatecagtexture single_texture = (<new_part>.with1)
		endif
		cas_add_item_to_appearance {
			part = <surrogate_part>
			desc_id = (($<part>) [<index>].desc_id)
			no_rebuild
		}
		if NOT (gotparam play_current_anim)
			spawnscriptnow trigger_cas_rebuild_loop params = {<...>}
		endif
	endif
	if gotparam \{play_current_anim}
		new_part = (($<part>) [<index>])
		if structurecontains structure = (<new_part>) frontend_anim_name
			getcurrentcasobject
			band_playsimpleanim name = <cas_object> anim = (<new_part>.frontend_anim_name)
		endif
	endif
	0xabc34ae5 = 0
	if screenelementexists \{id = create_popout_select_part_vmenu}
		0xabc34ae5 = 1
	endif
	if screenelementexists \{id = create_cag_select_part_inclusion_vmenu}
		0xabc34ae5 = 1
	endif
	if (<0xabc34ae5> = 1)
		clean_up_user_control_helpers
		if gotparam \{disable_rotation_zoom}
			no_rotate_zoom_text = {no_rotate_zoom_text}
		endif
		if gotparam \{show_editable}
			car_helper_text = {car_helper_text_alt}
		elseif gotparam \{show_purchasable}
			car_helper_text = {car_helper_text_purchase}
		else
			car_helper_text = {car_helper_text_cancel}
		endif
		menu_finish <car_helper_text> <no_rotate_zoom_text>
	endif
endscript
