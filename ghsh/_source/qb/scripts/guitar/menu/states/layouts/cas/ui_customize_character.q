debug_allow_modify_preset_characters = 0
has_entered_car_before = 1

script ui_create_customize_character 
	0x31956c10 \{false}
	change \{rich_presence_context = presence_rockstar_creator}
	0x7d8b2005
	set_cas_loading_setup \{setup = single}
	cas_set_object_node_pos player = ($cas_current_player) node = z_soundcheck_trg_waypoint_car_start
	killskatercamanim \{all}
	make_generic_menu \{vmenu_id = create_customize_character_vmenu
		pad_back_script = customize_character_save_prompt
		title = qs(0x70a9b711)
		show_history
		num_icons = 0}
	setup_cas_menu_handlers \{vmenu_id = create_customize_character_vmenu
		camera_list = [
			'customize_character_body'
			'customize_character_R'
			'customize_character_B'
			'customize_character_L'
		]
		zoom_camera = 'customize_character_Zoom'}
	get_musician_profile_struct_by_id id = ($cas_current_profile) savegame = ($cas_current_savegame)
	if is_completely_custom_musician id = ($cas_current_profile) savegame = ($cas_current_savegame)
		custom_musician = 1
	else
		focusable_flags = {not_focusable heading}
	endif
	if is_from_singleplayer_hub
		add_generic_menu_text_item \{text = qs(0x7863365c)
			pad_choose_script = return_to_singleplayer_hub}
	endif
	add_generic_menu_text_item {
		text = (<profile_struct>.fullname)
		choose_state = uistate_cas_text_entry
		choose_state_data = {choose_script = name_entry_choose_script text = (<profile_struct>.fullname) num_icons = 1 cam_name = 'customize_character'}
		<focusable_flags>
		text_case = original
		forceautoscale = true
	}
	if ((gotparam custom_musician) || ($debug_allow_modify_preset_characters = 1))
		add_generic_menu_text_item \{text = qs(0x888dd748)
			choose_state = uistate_customize_character_head}
		add_generic_menu_text_item \{text = qs(0x706474c8)
			choose_state = uistate_customize_character_body}
		height = 0
		find_physique_height
		if (<height> > 0)
			if is_female_char
				hair_cam_name = 'customize_character_hair'
			else
				hair_cam_name = 'customize_character_hair'
			endif
		else
			if is_female_char
				hair_cam_name = 'customize_character_hair'
			else
				hair_cam_name = 'customize_character_hair'
			endif
		endif
		if NOT (is_greatestoutfit)
			add_generic_menu_text_item {
				text = qs(0xca300866)
				choose_state = uistate_popout_select_part
				choose_state_data = {
					text = qs(0x8476cb4e)
					cam_name = <hair_cam_name>
					camera_list = ['customize_character_hair' 'customize_character_hair_R' 'customize_character_hair_B' 'customize_character_hair_L']
					zoom_camera = 'customize_character_Zoom'
					part = cas_hair
					num_icons = 1
					color_wheel = ($hair_colorwheel)
					hist_tex = icon_hair
					is_popup
					stance = stance_select_hair
				}
			}
		else
			add_generic_menu_text_item {
				text = qs(0xca300866)
				choose_state = uistate_popout_select_part
				choose_state = uistate_generic_dialogue
				choose_state_data = {
					is_popup
					title = qs(0xf2815345)
					text = qs(0x68416e4d)
					choose_yes_func = {
						resetcharacter
						params = {goto = qs(0xbceb627d)}
					}
				}
				not_focusable = <not_focusable>
			}
		endif
	endif
	<state> = qs(0xde150619)
	if NOT (is_greatestoutfit)
		if customize_outfit_allowed name = (<profile_struct>.name)
			add_generic_menu_text_item \{text = qs(0xa946c7b7)
				choose_state = uistate_customize_character_outfit}
		endif
	else
		add_generic_menu_text_item {
			text = qs(0xa946c7b7)
			choose_state = uistate_generic_dialogue
			choose_state_data = {
				is_popup
				title = qs(0xc133d5e7)
				text = qs(0x68416e4d)
				choose_yes_func = {
					resetcharacter
					params = {goto = qs(0x8810337c)}
				}
			}
			not_focusable = <not_focusable>
		}
	endif
	if customize_outfit_allowed name = (<profile_struct>.name)
		if (is_greatestoutfit)
			add_generic_menu_text_item \{text = qs(0xa8fe99bb)
				choose_state = uistate_customize_character_greatestoutfit}
		else
			getglobaltags savegame = ($cas_current_savegame) cas_helper_dialogue param = visit_greatestoutfit
			if (<visit_greatestoutfit> = 0)
				add_generic_menu_text_item {
					text = qs(0xa8fe99bb)
					choose_state = uistate_helper_dialogue
					choose_state_data = {
						choose_script = greatest_outfit_warning
						is_popup
						life = 30
						text = qs(0xa106453f)
					}
					not_focusable = <not_focusable>
				}
			else
				add_generic_menu_text_item \{text = qs(0xa8fe99bb)
					choose_state = uistate_customize_character_greatestoutfit}
			endif
		endif
	endif
	add_generic_menu_text_item \{text = qs(0x8694014b)
		choose_state = uistate_customize_character_instrument}
	getcurrentcasobject
	if gotparam \{cas_object}
		bandmanager_changestance name = <cas_object> stance = stance_frontend
	endif
	menu_finish \{car_helper_text}
	if is_from_singleplayer_hub
		launchevent \{type = focus
			target = create_customize_character_vmenu
			data = {
				child_index = 0
			}}
	else
		launchevent type = focus target = create_customize_character_vmenu data = {child_index = <selected_index>}
	endif
	if (($has_entered_car_before) = 0)
		generic_event_choose \{state = uistate_helper_dialogue
			data = {
				is_popup
			}}
		change \{has_entered_car_before = 1}
	endif
endscript

script greatest_outfit_warning 

	ui_event \{event = menu_replace
		data = {
			state = uistate_customize_character_greatestoutfit
		}}
endscript

script resetcharacter 
	if is_completely_custom_musician id = ($cas_current_profile) savegame = ($cas_current_savegame)
		<genre> = any
		getarraysize \{$cas_randomized_parts}
		i = 0
		begin
		cas_set_random_appearance_part part_struct = ($cas_randomized_parts [<i>]) genre = <genre>
		i = (<i> + 1)
		repeat <array_size>
		setcasappearancepartinstance \{part = cas_greatest_outfit
			part_instance = {
				desc_id = false
			}}
		rebuildcurrentcasmodel

		if (<goto> = qs(0x8810337c))

			ui_event \{event = menu_replace
				data = {
					state = uistate_customize_character_outfit
				}}
		elseif (<goto> = qs(0xbceb627d))

			destroy_generic_menu
			ui_create_customize_character
			generic_event_back
		endif
	endif
	if NOT is_completely_custom_musician id = ($cas_current_profile) savegame = ($cas_current_savegame)

		getcasappearancepartinstance \{part = cas_character_name}
		name = (<part_instance>.desc_id)

		if (<name> = axel)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat_hair
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_male_hair
				desc_id = m_metl_hair_axel}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_torso
					desc_id = m_metl_torso_axel01
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_legs
					desc_id = m_mtl_legs_axel01
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_shoes
					desc_id = m_mtl_shoes_axel01
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_left
					desc_id = m_punk_acc_lleather
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_right
					desc_id = m_punk_acc_rleather
				}}
		elseif (<name> = casey)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_hat_hair
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_hat
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_female_hair
				desc_id = f_clsc_hair_farah}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_torso
					desc_id = f_fun_torso_bikinitop
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_legs
					desc_id = f_clsc_legs_pvc
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_shoes
					desc_id = f_glam_shoes_velvetbaggyboots01
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_left
					desc_id = f_rock_acc_lstrap
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_right
					desc_id = f_rock_acc_rstrap
				}}
		elseif (<name> = izzy)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat_hair
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_male_hair
				desc_id = m_metl_hair_midhigh}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_torso
					desc_id = m_glam_torso_gold
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_legs
					desc_id = m_glam_legs_chaps
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_shoes
					desc_id = m_glam_shoe_eightysixed
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_left
					desc_id = m_goth_acc_lstraps
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_right
					desc_id = m_punk_acc_rleather
				}}
		elseif (<name> = judy)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_hat_hair
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_ears
					desc_id = f_punk_acc_ring_02
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_hat
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_female_hair
				desc_id = f_punk_hair_judy01}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_torso
					desc_id = f_punk_torso_stripe
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_legs
					desc_id = f_punk_legs_skirt
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_shoes
					desc_id = f_punk_shoe_army
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_left
					desc_id = f_punk_acc_lglvwatch
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_right
					desc_id = f_punk_acc_rbands
				}}
		elseif (<name> = johnny)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat_hair
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_male_hair
				desc_id = m_punk_hair_lspike}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_torso
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_legs
					desc_id = m_punk_legs_johnny1
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_shoes
					desc_id = m_punk_shoes_johnny01
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_left
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_right
					desc_id = none
				}}
		elseif (<name> = lars)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat_hair
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_male_hair
				desc_id = m_bmtl_hair_lars}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_torso
					desc_id = m_bmtl_torso_lars
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_legs
					desc_id = m_bmtl_legs_lars
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_shoes
					desc_id = m_bmtl_shoes_lars
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_left
					desc_id = m_bmtl_acc_llars
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_right
					desc_id = m_bmtl_acc_rlars
				}}
		elseif (<name> = midori)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_hat_hair
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_hat
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_female_hair
				desc_id = f_pop_hair_midori}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_torso
					desc_id = f_bmtl_torso_bat
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_legs
					desc_id = f_punk_legs_cheerskirt
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_shoes
					desc_id = f_clsc_shoe_platboot
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_left
					desc_id = f_goth_acc_lsleeve
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_right
					desc_id = f_clsc_accs_rbracelet
				}}
		elseif (<name> = clive)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_face
					desc_id = m_clsc_shady_rounds
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat_hair
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_male_hair
				desc_id = m_clsc_hair_country}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_facial_hair
					desc_id = m_clsc_fhair_stache01
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_torso
					desc_id = m_clsc_torso_clrdjakt
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_legs
					desc_id = m_clsc_legs_ltjeans
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_shoes
					desc_id = m_clsc_shoe_whtboot
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_left
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_right
					desc_id = none
				}}
		elseif (<name> = pandora)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_hat_hair
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_hat
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_female_hair
				desc_id = f_goth_hair_updo}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_torso
					desc_id = f_goth_torso_frillybodice
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_legs
					desc_id = f_goth_legs_frillydress
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_shoes
					desc_id = f_goth_shoes_maryjanes
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_left
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_right
					desc_id = none
				}}
		elseif (<name> = eddie)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat_hair
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_male_hair
				desc_id = m_pop_hair_pomp}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_torso
					desc_id = m_punk_torso_bowling
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_legs
					desc_id = m_punk_legs_cuff
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_shoes
					desc_id = m_punk_shoes_johnny01
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_left
					desc_id = m_pop_acc_lband
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_right
					desc_id = m_punk_acc_rchain
				}}
		elseif (<name> = matty)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat_hair
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_male_hair
				desc_id = m_rock_hair_drummer}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_torso
					desc_id = m_rock_torso_ripshirt
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_legs
					desc_id = m_mtl_legs_axel01
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_shoes
					desc_id = m_metl_shoes_stubs
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_left
					desc_id = m_rock_acc_lstrap
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_right
					desc_id = m_pop_acc_rglove
				}}
		elseif (<name> = shirley)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_hat_hair
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_hat
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_female_hair
				desc_id = f_rock_hair_bass}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_torso
					desc_id = f_metl_torso_vest01
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_legs
					desc_id = f_goth_legs_strapj
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_shoes
					desc_id = f_metl_shoes_platform
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_left
					desc_id = f_rock_acc_lchainstud
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_female_acc_right
					desc_id = none
				}}
		elseif (<name> = marcus)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat_hair
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_male_hair
				desc_id = m_rock_hair_guitarist}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_torso
					desc_id = m_rock_torso_rolledslvs
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_legs
					desc_id = m_bmtl_legs_plate
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_shoes
					desc_id = m_punk_shoe_buckleb
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_left
					desc_id = m_metl_acc_lzakk
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_right
					desc_id = m_bmtl_acc_rlars
				}}
		elseif (<name> = riki)

			setcasappearancepartinstance \{part = cas_greatest_outfit
				part_instance = {
					desc_id = false
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_face
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_ears
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat
					desc_id = none
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_hat_hair
					desc_id = none
				}}
			cas_add_item_to_appearance \{part = cas_male_hair
				desc_id = m_glam_hair_seagull}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_torso
					desc_id = m_rock_torso_bandana
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_legs
					desc_id = m_punk_legs_bullet
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_shoes
					desc_id = m_clsc_shoe_drkboot
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_left
					desc_id = m_goth_acc_lstraps
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_right
					desc_id = m_rock_acc_rbracelet
				}}
			editcasappearance \{target = setpart
				targetparams = {
					part = cas_male_acc_face
					desc_id = m_clsc_glasses_avtr
				}}
		endif
		rebuildcurrentcasmodel
		if (<goto> = qs(0x8810337c))

			ui_event \{event = menu_replace
				data = {
					state = uistate_customize_character_outfit
				}}
		endif
	endif
endscript

script ui_return_customize_character 
	menu_finish \{car_helper_text}
endscript

script ui_destroy_customize_character 
	destroy_generic_menu
endscript

script ui_init_customize_character 
	if NOT gotparam \{0x10003bba}
		cas_queue_new_character_profile id = ($cas_current_profile) player = ($cas_current_player) savegame = ($cas_current_savegame)
	endif
	0x4e6e9380
	create_band_money_display
endscript

script ui_deinit_customize_character 
	if ($cas_heap_state = in_game)
	else
		if ($shutdown_game_for_signin_change_flag = 1)
			cas_free_resources \{spawn
				block_scripts = 1
				bx_useloadingscreenwithnotext = 1}
		else
			spawnscriptnow \{cas_free_resources
				params = {
					bx_useloadingscreenwithnotext = 1
				}}
		endif
	endif
	destroy_band_money_display
	0xd98b3809
	if ($invite_controller = -1)
		change \{cas_current_savegame = -1}
		change \{cas_current_profile = none}
	elseif NOT ui_event_exists_in_stack \{name = 'create_character_gender'}
		change \{cas_current_savegame = -1}
		change \{cas_current_profile = none}
	endif
endscript

script customize_outfit_allowed 
	switch (<name>)
		case 0x7736ca68
		return \{false}
	endswitch
	switch (<name>)
		case metalhead
		case 0xf650b8fb
		case 0x8536baaa
		return \{false}
	endswitch
	return \{true}
endscript

script name_entry_choose_script 
	modify_custom_profile_fullname id = ($cas_current_profile) fullname = <text> savegame = ($cas_current_savegame)
	ui_event \{event = menu_back}
endscript

script get_genre_name 
	getarraysize ($genre_list)
	i = 0
	begin
	if ((($genre_list) [<i>].desc_id) = <genre>)
		return genre_name = (($genre_list) [<i>].frontend_desc)
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script ui_return 
	ui_event \{event = menu_back}
endscript

script customize_character_save_prompt 
	0x31956c10 \{true}
	get_musician_profile_struct_by_id id = ($cas_current_profile) savegame = ($cas_current_savegame)
	struct1 = (<profile_struct>.appearance)
	struct2 = ($cas_current_appearance)
	if (($cas_editing_new_character) = false && comparestructs struct1 = <struct1> struct2 = <struct2>)
		exit_discard_changes \{no_changes}
	else
		spawnscriptnow \{temporarilydisableinput
			params = {
				time = 250
			}}
		ui_event \{event = menu_change
			data = {
				state = uistate_save_changes_dialogue
				is_popup
			}}
	endif
endscript

script is_from_singleplayer_hub 
	ui_event_get_stack
	i = 0
	begin
	if ((<stack> [<i>].base_name) = 'singleplayer_character_hub')
		return \{true}
	endif
	i = (<i> + 1)
	repeat <stack_size>
	return \{false}
endscript

script return_to_singleplayer_hub 
	0x79db87d7
	wait \{1
		seconds}
	0xf00f29a9
	0x31956c10 \{true}
	get_musician_profile_struct_by_id id = ($cas_current_profile) savegame = ($cas_current_savegame)
	change \{first_character_hub_enter = 0}
	struct1 = (<profile_struct>.appearance)
	struct2 = ($cas_current_appearance)
	if (($cas_editing_new_character) = false && comparestructs struct1 = <struct1> struct2 = <struct2>)
		exit_skip_save \{readytorock = 1}
	else
		if NOT is_autosave_on savegame = ($cas_current_savegame)
			customize_character_save_prompt
		else
			cas_get_player_status
			if isxenon
				if checkforsignin local controller_index = ($<player_status>.controller)
					exit_save_changes \{not_replace
						readytorock = 1}
				else
					exit_skip_save \{readytorock = 1}
				endif
			else
				exit_save_changes \{not_replace
					readytorock = 1
					0x6d221ff1}
			endif
		endif
	endif
endscript
