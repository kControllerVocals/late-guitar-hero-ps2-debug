
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
	spawnscriptnow task_menu_default_anim_in params = {base_name = <cam_name> do_not_hide}
	resolvebodyspecificpartinappearance part = <part>
	if NOT gotparam \{surrogate_part}
		surrogate_part = <part>
	endif
	current_part = 0
	get_part_current_desc_id part = <surrogate_part>
	if part_has_swatch_list part = <surrogate_part> desc_id = <current_desc_id>
		current_parent_swatch = <parent_swatch>
	endif
	swatch_editable_icon = style_icon
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
			if gotparam \{current_parent_swatch}
				if (((($<part>) [<i>]).desc_id) = <current_parent_swatch>)
					current_part = <num_parts_added>
				endif
			elseif (((($<part>) [<i>]).desc_id) = <current_desc_id>)
				current_part = <num_parts_added>
			endif
			if part_has_swatch_list part = <surrogate_part> desc_id = ((($<part>) [<i>]).desc_id)
				if NOT (<parent_swatch> = ((($<part>) [<i>]).desc_id))
					hide_item = 1
				endif
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
						editable_icon = colorwheel_tiny
					endif
					pad_option2_params = {index = <i> part = <part> surrogate_part = <surrogate_part> color_wheel = <color_wheel> num_icons = <num_icons> icon = <hist_tex> cam_name = <cam_name> camera_list = <camera_list> zoom_camera = <zoom_camera> no_rotate = <no_rotate> no_zoom = <no_zoom> pull_back_distance = <pull_back_distance> stance = <stance> additional_deinit_script = <additional_deinit_script> return_stance = <return_stance> target_desc_id = ((($<part>) [<i>]).desc_id)}
				elseif part_has_swatch_list part = <surrogate_part> desc_id = ((($<part>) [<i>]).desc_id)
					if gotparam \{choose_script}
						pad_option2_script = <choose_script>
					else
						pad_option2_script = popout_select_part_decide_action
						show_swatches = 1
						editable = {editable}
						editable_icon = <swatch_editable_icon>
					endif
					pad_option2_params = {
						part = <surrogate_part>
						target_desc_id = ((($<part>) [<i>]).desc_id)
						num_icons = <num_icons>
						icon = <hist_tex>
						cam_name = <cam_name>
						camera_list = <camera_list>
						zoom_camera = <zoom_camera>
						no_rotate = <no_rotate>
						no_zoom = <no_zoom>
						pull_back_distance = <pull_back_distance>
						stance = <stance>
						additional_deinit_script = <additional_deinit_script>
						return_stance = <return_stance>
					}
				endif
				add_list_item {
					text = ((($<part>) [<i>]).frontend_desc)
					pad_choose_script = 0x65be7e33
					pad_choose_params = {part = <part> nosound}
					camera_list = <camera_list>
					zoom_camera = <zoom_camera>
					additional_focus_script = select_part_focus_change
					additional_focus_params = {part = <part>
						index = <i>
						play_current_anim = <play_current_anim>
						disable_rotation_zoom = <disable_rotation_zoom>
						show_purchasable = <show_purchasable>
						show_editable = <show_editable>
						show_swatches = <show_swatches>
						surrogate_part = <surrogate_part>
						force_update = <force_update>
					}
					price = <price>
					pad_choose_dialogue = <pad_choose_dialogue>
					pad_option2_script = <pad_option2_script>
					pad_option2_params = <pad_option2_params>
					<editable>
					editable_icon = <editable_icon>
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
			if gotparam \{show_swatches}
				removeparameter \{show_swatches}
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
	menu_finish \{car_helper_text_cancel}
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

script 0x65be7e33 
	if screenelementexists \{id = create_popout_select_part_vmenu}
		launchevent \{type = unfocus
			target = create_popout_select_part_vmenu}
	endif
	cas_queue_wait
	begin
	if NOT scriptisrunning \{select_part_focus_change_spawned}
		break
	endif
	waitonegameframe
	repeat
	generic_event_back <...>
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
	0x8dbdaee4 qs(0xfa37c1e0) a = <target_desc_id> b = <current_desc_id>
	0x3ec5e6e4 = 0
	if (<target_desc_id> = <current_desc_id>)
		0x3ec5e6e4 = 1
	elseif part_has_swatch_list part = <surrogate_part> desc_id = <current_desc_id>
		if (<parent_swatch> = <target_desc_id>)
			0x3ec5e6e4 = 1
		endif
	endif
	if (<0x3ec5e6e4> = 1)
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
	elseif getcaspartswatches part = <surrogate_part>
		ui_event event = menu_replace data = {
			state = uistate_cas_select_part_swatches
			part = <surrogate_part>
			part_swatches = <part_swatches>
			current_swatch_desc_id = <current_swatch_desc_id>
			frontend_desc = <frontend_desc>
			hist_tex = menu_history_color_edit
			num_icons = <num_icons>
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

	current_parent_swatch = null
	if part_has_swatch_list part = <surrogate_part> desc_id = <current_desc_id>
		current_parent_swatch = <parent_swatch>
	endif
	if (((($<part>) [<index>]).desc_id) != <current_desc_id>)
		if (<current_parent_swatch> != ((($<part>) [<index>]).desc_id))
			new_part = (($<part>) [<index>])
			cas_part_will_conflict part_name = <surrogate_part> part_desc_id = ($<part> [<index>].desc_id)
			if gotparam \{change_parts}
				getarraysize \{change_parts}
				if (<array_size> > 0)
					i = 0
					begin
					cas_add_item_to_appearance part = (<change_parts> [<i>].part) desc_id = (<change_parts> [<i>].desc_id) no_rebuild
					i = (<i> + 1)
					repeat <array_size>
				endif
			endif
			cas_add_item_to_appearance {
				part = <surrogate_part>
				desc_id = (($<part>) [<index>].desc_id)
				no_rebuild
			}
			if gotparam \{finishable}
				if 0x1e74398a 0x868a8862 = <inclusion> part = <finishable>
					editcasappearance target = setpart targetparams = {part = <finishable> desc_id = (<valid_array> [0])}
				endif
			endif
			if gotparam \{detailable}
				if 0x1e74398a 0x868a8862 = <inclusion> part = <detailable>
					editcasappearance target = setpart targetparams = {part = <detailable> desc_id = (<valid_array> [0])}
				endif
			endif
			if gotparam \{logoable}
				if 0x1e74398a 0x868a8862 = <inclusion> part = <logoable>
					editcasappearance target = setpart targetparams = {part = <logoable> desc_id = (<valid_array> [0])}
				endif
			endif
			if gotparam \{fadeable}
				if 0x1e74398a 0x868a8862 = <inclusion> part = <fadeable>
					editcasappearance target = setpart targetparams = {part = <fadeable> desc_id = (<valid_array> [0])}
				endif
			endif
			if gotparam \{0x07f0881d}
				getarraysize <0x07f0881d>
				i = 0
				begin
				0x51fd3b4e = (<0x07f0881d> [<i>])
				editcasappearance target = setpart targetparams = {part = (<0x51fd3b4e>.part) desc_id = (<0x51fd3b4e>.desc_id)}
				i = (<i> + 1)
				repeat <array_size>
			endif
			if (<surrogate_part> = 0x197f6b46)
				generatecagtexture single_texture = (<new_part>.with1)
			endif
			if NOT (gotparam play_current_anim)
				spawnscriptnow trigger_cas_rebuild_loop params = {<...>}
			endif
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
		elseif gotparam \{show_swatches}
			car_helper_text = {car_helper_text_swatches}
		else
			car_helper_text = {car_helper_text_cancel}
		endif
		menu_finish <car_helper_text> <no_rotate_zoom_text>
	endif
	if gotparam \{force_update}
		if (<force_update> = 1)
			getcurrentcasobject
			<cas_object> :hide
			cancel_all_cas_loads
			cas_queue_wait
			trigger_cas_rebuild_loop params = {<...>}
			waitonegameframe
			cas_queue_wait
			bandmanager_changestance name = <cas_object> stance = stance_select_head no_wait
			<cas_object> :unhide
		endif
	endif
endscript
