debug_allow_modify_preset_characters = 0
has_entered_CAR_before = 1

script ui_create_customize_character 
	spawnscriptnow \{change_cas_to_guitar}
	ui_state_enable_enable_mini_loading_screen \{false}
	change \{rich_presence_context = presence_rockstar_creator}
	set_cas_loading_setup \{setup = single}
	get_frontend_venue_player_start_checksums
	cas_set_object_node_pos player = ($cas_current_player) node = <Drum_Start>
	KillSkaterCamAnim \{all}
	make_generic_menu \{vmenu_id = create_customize_character_vmenu
		pad_back_script = customize_character_save_prompt
		title = qs(0x131c0c64)
		show_history
		num_icons = 0}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
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
		if is_ghrocker id = ($cas_current_profile)
			ghrocker = 1
		endif
		focusable_flags = {not_focusable}
	endif
	if is_from_singleplayer_hub
		add_generic_menu_text_item \{text = qs("READY TO ROCK")
			pad_choose_script = return_to_singleplayer_hub}
	endif
	add_generic_menu_text_item {
		text = ($cas_current_fullname)
		choose_state = UIstate_cas_text_entry
		choose_state_data = {choose_script = name_entry_choose_script text = ($cas_current_fullname) num_icons = 1 cam_name = 'customize_character'}
		<focusable_flags>
		text_case = Original
	}
	if ((GotParam custom_musician) || ($debug_allow_modify_preset_characters = 1))
		add_generic_menu_text_item \{text = qs("HEAD")
			choose_state = UIstate_customize_character_head}
		add_generic_menu_text_item \{text = qs("BODY")
			choose_state = UIstate_customize_character_body}
		add_generic_menu_text_item {
			text = qs("HAIR")
			choose_state = UIstate_popout_select_part
			choose_state_data = {
				text = qs("SELECT HAIR STYLE")
				cam_name = 'customize_character_hair'
				camera_list = ['customize_character_hair' 'customize_character_hair_R' 'customize_character_hair_B' 'customize_character_hair_L']
				zoom_camera = 'customize_character_Zoom'
				part = CAS_Hair
				num_icons = 1
				color_wheel = ($hair_colorwheel)
				hist_tex = icon_hair
				is_popup
				stance = Stance_Select_Hair
			}
		}
	endif
	if GotParam \{ghrocker}
		get_ghrocker_outfit_count part = CAS_Full_Body ghrocker = ($cas_current_profile)
		if (<outfit_count> > 1)
			add_generic_menu_text_item {
				icon = icon_outfit
				text = qs("OUTFIT")
				choose_state = UIstate_popout_select_part
				choose_state_data = {
					text = qs("SELECT OUTFIT")
					cam_name = 'customize_character_outfit'
					camera_list = ['customize_character_outfit' 'customize_character_R' 'customize_character_B' 'customize_character_L']
					zoom_camera = 'customize_character_Zoom'
					part = CAS_Full_Body
					num_icons = 1
					hist_tex = icon_outfit
					is_popup
					stance = Stance_Select_Torso
					ghrocker = ($cas_current_profile)
				}
			}
		endif
	else
		add_generic_menu_text_item \{text = qs("OUTFIT")
			choose_state = UIstate_customize_character_outfit}
	endif
	add_generic_menu_text_item \{text = qs("INSTRUMENT")
		choose_state = UIstate_customize_character_instrument}
	menu_finish \{car_helper_text}
	if is_from_singleplayer_hub
		LaunchEvent \{type = focus
			target = create_customize_character_vmenu
			data = {
				child_index = 0
			}}
	else
		LaunchEvent type = focus target = create_customize_character_vmenu data = {child_index = <selected_index>}
	endif
	if (($has_entered_CAR_before) = 0)
		generic_event_choose \{state = UIstate_helper_dialogue
			data = {
				is_popup
			}}
		change \{has_entered_CAR_before = 1}
	endif
endscript

script change_cas_to_guitar 
	cas_queue_wait
	change \{cas_current_instrument = guitar}
	RebuildCurrentCASModel \{instrument = guitar}
	cas_queue_wait
	GetCurrentCASObject
	if GotParam \{cas_object}
		BandManager_ChangeStance name = <cas_object> stance = stance_frontend no_wait
	endif
endscript

script ui_return_customize_character 
	menu_finish \{car_helper_text}
	if GotParam \{text}
		change cas_current_fullname = <text>
	endif
endscript

script ui_destroy_customize_character 
	destroy_generic_menu
endscript

script ui_init_customize_character 
	get_musician_profile_struct_by_id id = ($cas_current_profile) savegame = ($cas_current_savegame)
	change cas_current_fullname = (<profile_struct>.fullname)
	load_part_desc_pak_list part_list = ($part_def_clusters.ui_customize_character)
	GetArraySize <parts_loaded>
	if (<array_size> > 0)
		ui_event_add_params part_unload_list = <parts_loaded>
	endif
	edit_graphic_load_data_from_global
endscript

script ui_deinit_customize_character 
	if ($cas_heap_state = in_game)
	else
		if ($shutdown_game_for_signin_change_flag = 1)
			cas_free_resources \{spawn
				block_scripts = 1}
		else
			spawnscriptnow \{cas_free_resources}
		endif
	endif
	if ($invite_controller = -1)
		change \{cas_current_savegame = -1}
		change \{cas_current_profile = none}
	elseif NOT ui_event_exists_in_stack \{name = 'create_character_gender'}
		change \{cas_current_savegame = -1}
		change \{cas_current_profile = none}
	endif
	if GotParam \{part_unload_list}
		unload_part_desc_pak_list part_list = <part_unload_list>
	endif
endscript

script name_entry_choose_script 
	change cas_current_fullname = <text>
	ui_event \{event = menu_back}
endscript

script get_genre_name 
	GetArraySize ($Genre_List)
	i = 0
	begin
	if ((($Genre_List) [<i>].desc_id) = <genre>)
		return genre_name = (($Genre_List) [<i>].frontend_desc)
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script ui_return 
	ui_event \{event = menu_back}
endscript

script customize_character_save_prompt 
	ui_state_enable_enable_mini_loading_screen \{true}
	get_musician_profile_struct_by_id id = ($cas_current_profile) savegame = ($cas_current_savegame)
	struct1 = (<profile_struct>.appearance)
	struct2 = ($cas_current_appearance)
	made_changes = 0
	if (($cas_editing_new_character) = true)
		made_changes = 1
	endif
	if NOT CompareStructs struct1 = <struct1> struct2 = <struct2>
		made_changes = 1
	endif
	debug_Printf qs(0x776f4948) n = (<profile_struct>.fullname) m = ($cas_current_fullname)
	if ((<profile_struct>.fullname) != ($cas_current_fullname))
		made_changes = 1
	endif
	if (<made_changes> = 0)
		exit_discard_changes \{no_changes}
	else
		ui_event \{event = menu_change
			data = {
				state = UIstate_save_changes_dialogue
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
	ui_state_enable_enable_mini_loading_screen \{true}
	get_musician_profile_struct_by_id id = ($cas_current_profile) savegame = ($cas_current_savegame)
	change \{first_character_hub_enter = 0}
	struct1 = (<profile_struct>.appearance)
	struct2 = ($cas_current_appearance)
	if (($cas_editing_new_character) = false && CompareStructs struct1 = <struct1> struct2 = <struct2>)
		exit_skip_save \{readytorock = 1}
	else
		if NOT is_autosave_on savegame = ($cas_current_savegame)
			customize_character_save_prompt
		else
			cas_get_player_status
			if isXenon
				if CheckForSignIn local controller_index = ($<player_status>.controller)
					exit_save_changes \{not_replace
						readytorock = 1}
				else
					exit_skip_save \{readytorock = 1}
				endif
			else
				exit_save_changes \{not_replace
					readytorock = 1
					need_loading_screen}
			endif
		endif
	endif
endscript

script get_ghrocker_outfit_count 
	GetArraySize ($<part>)
	outfit_count = 0
	i = 0
	begin
	if cas_item_is_visible part = <part> part_index = <i>
		if is_part_unlocked part = <part> desc_id = ((($<part>) [<i>]).desc_id) savegame = ($cas_current_savegame)
			if ghrocker_body_matches matcheswith = <ghrocker> part = <part> desc_id = ((($<part>) [<i>]).desc_id)
				outfit_count = (<outfit_count> + 1)
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	return outfit_count = <outfit_count>
endscript
