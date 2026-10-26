gender_create_script_done = 0

script ui_create_create_character_gender 
	change \{gender_create_script_done = 0}
	change \{Achievements_creating_character = 1}
	KillSkaterCamAnim \{all}
	get_frontend_venue_player_start_checksums
	cas_set_object_node_pos player = ($cas_current_player) node = <Drum_Start>
	make_generic_menu \{title = qs("SELECT GENDER")
		vmenu_id = create_create_character_gender_vmenu
		pad_back_script = exit_gender_cleanup}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	ResolveBodySpecificPartInAppearance \{part = CAS_Body}
	current_part = 0
	GetArraySize ($CAS_Body)
	i = 0
	begin
	get_part_current_desc_id \{part = CAS_Body}
	if GotParam \{current_desc_id}
		if (((($CAS_Body) [<i>]).desc_id) = <current_desc_id>)
			current_part = <i>
		endif
	endif
	if cas_item_is_visible part = CAS_Body part_index = <i>
		add_generic_menu_text_item {
			text = ((($CAS_Body) [<i>]).frontend_desc)
			pad_choose_script = load_character_before_state
			pad_choose_params = {state = UIstate_create_character_genre unfocus_menu = create_create_character_gender_vmenu}
			additional_focus_script = cas_gender_focus_change
			additional_focus_params = {part = CAS_Body new_desc_id = (($CAS_Body) [<i>].desc_id) price = (($CAS_Body) [<i>].price)}
		}
	endif
	i = (<i> + 1)
	repeat <array_size>
	menu_finish \{no_rotate_zoom_text}
	LaunchEvent type = focus target = create_create_character_gender_vmenu data = {child_index = <current_part>}
	change \{gender_create_script_done = 1}
	cas_get_is_female player = ($cas_current_player)
	change cas_current_is_female = <is_female>
	if ($autolaunch_cas_artist = 1)
		Z_ObjViewer_TRG_01 :hide
	endif
	if GetCurrentCASObject
		BandManager_ChangeStance name = <cas_object> stance = Stance_Old no_wait
	endif
endscript

script load_character_before_state 
	push_loading_screen \{mini}
	wait_for_character_generation
	cas_queue_wait
	pop_loading_screen
	ui_event_block event = menu_change data = {state = <state>}
endscript

script ui_destroy_create_character_gender 
	destroy_generic_menu
endscript

script ui_deinit_create_character_gender 
	KillSpawnedScript \{name = cas_gender_focus_change_spawned}
	if NOT (($invite_controller) = -1)
		exit_discard_changes
		change \{cas_current_savegame = -1}
		change \{cas_current_profile = none}
	endif
endscript

script exit_gender_cleanup 
	KillSpawnedScript \{name = generate_random_character}
	destroy_generic_menu
	if Is_ui_event_running
		return \{false}
	endif
	if ($cas_heap_state = in_game)

	endif
	cas_free_resources
	exit_discard_changes
	change \{cas_current_savegame = -1}
	change \{cas_current_profile = none}
endscript

script cas_gender_focus_change 
	if ($gender_create_script_done = 0)
		return
	endif
	if (<new_desc_id> = GH4_CAR_Female)
		if ($cas_current_is_female = 1)
			return
		endif
	else
		if ($cas_current_is_female = 0)
			return
		endif
	endif
	cancel_all_cas_loads
	KillSpawnedScript \{name = generate_random_character}
	if (<new_desc_id> = GH4_CAR_Female)
		change \{cas_current_is_female = 1}
	else
		change \{cas_current_is_female = 0}
	endif
	generate_random_genre
	spawnscriptnow generate_random_character params = {is_female = ($cas_current_is_female) genre = <genre> Wait changeStance}
endscript

script generate_random_character 
	if GotParam \{Wait}
		Wait ($car_wait_before_load) second
	endif
	cas_start_loading_anim \{player_index = 0}
	wanted_is_female = <is_female>
	if GotParam \{genre_select}
		cas_flag = {in_cas}
	endif
	cas_queue_wait
	cas_get_is_female player = ($cas_current_player)
	if (<wanted_is_female> = <is_female>)
		generate_random_appearance is_female = <is_female> genre = <genre> new_car_character
		cas_queue_add_request appearance = ($cas_current_appearance) player = ($cas_current_player) <cas_flag>
	else
		cas_change_current_character_gender is_female = <wanted_is_female> genre = <genre>
	endif
	if GotParam \{Anim}
		cas_queue_wait
		if GetCurrentCASObject
			Band_PlayAnim name = <cas_object> Anim = <Anim> no_wait
		endif
	endif
	if GotParam \{changeStance}
		wait_for_character_load_then_force_stance \{stance = Stance_Old}
	endif
endscript

script wait_for_character_generation 
	begin
	if NOT ScriptIsRunning \{generate_random_character}
		break
	endif
	WaitOneGameFrame
	repeat
endscript
