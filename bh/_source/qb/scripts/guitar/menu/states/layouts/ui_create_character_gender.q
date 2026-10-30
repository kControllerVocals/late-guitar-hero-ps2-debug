gender_create_script_done = 0

script ui_create_create_character_gender 
	change \{gender_create_script_done = 0}
	change \{achievements_creating_character = 1}
	killskatercamanim \{all}
	0xce0505af
	cas_set_object_node_pos player = ($cas_current_player) node = <0xb07e72b1>
	make_generic_menu \{title = qs(0x021bbbb3)
		vmenu_id = create_create_character_gender_vmenu
		pad_back_script = exit_gender_cleanup}
	if <desc_id> :desc_resolvealias name = 0x44475582 param = 0x7363d093
		<0x7363d093> :obj_spawnscript 0xa7a510a8 params = {0x4d641ae8 0xe99089a3 = $0x187899ed 0xffd05882 = $0xddccbea4}
	else

	endif
	if <desc_id> :desc_resolvealias name = 0xf313b252 param = 0x7c09a415
		<0x7c09a415> :obj_spawnscript 0xa7a510a8 params = {0x4d641ae8 0xe99089a3 = $0x52565f88 0xffd05882 = $0xddccbea4}
	else

	endif
	resolvebodyspecificpartinappearance \{part = cas_body}
	current_part = 0
	getarraysize ($cas_body)
	i = 0
	begin
	get_part_current_desc_id \{part = cas_body}
	if gotparam \{current_desc_id}
		if (((($cas_body) [<i>]).desc_id) = <current_desc_id>)
			current_part = <i>
		endif
	endif
	if cas_item_is_visible part = cas_body part_index = <i>
		add_generic_menu_text_item {
			text = ((($cas_body) [<i>]).frontend_desc)
			pad_choose_script = 0xea169d59
			pad_choose_params = {state = uistate_create_character_genre 0xeec2d226 = create_create_character_gender_vmenu}
			additional_focus_script = cas_gender_focus_change
			additional_focus_params = {part = cas_body new_desc_id = (($cas_body) [<i>].desc_id) price = (($cas_body) [<i>].price)}
		}
	endif
	i = (<i> + 1)
	repeat <array_size>
	menu_finish \{no_rotate_zoom_text}
	launchevent type = focus target = create_create_character_gender_vmenu data = {child_index = <current_part>}
	change \{gender_create_script_done = 1}
	cas_get_is_female player = ($cas_current_player)
	change cas_current_is_female = <is_female>
	if ($autolaunch_cas_artist = 1)
		z_objviewer_trg_01 :hide
	endif
	if getcurrentcasobject
		bandmanager_changestance name = <cas_object> stance = stance_old no_wait
	endif
endscript

script 0xea169d59 
	0xd3f993c8 \{0x9fe16047}
	0x40cc48b1
	cas_queue_wait
	0xe5a305c6
	ui_event_block event = menu_change data = {state = <state>}
endscript

script ui_destroy_create_character_gender 
	destroy_generic_menu
endscript

script ui_deinit_create_character_gender 
	killspawnedscript \{name = 0xb38c95de}
	if NOT (($invite_controller) = -1)
		exit_discard_changes
		change \{cas_current_savegame = -1}
		change \{cas_current_profile = none}
	endif
endscript

script exit_gender_cleanup 
	killspawnedscript \{name = 0x4ec30caf}
	destroy_generic_menu
	if is_ui_event_running
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
	if (<new_desc_id> = gh4_car_female)
		if ($cas_current_is_female = 1)
			return
		endif
	else
		if ($cas_current_is_female = 0)
			return
		endif
	endif
	cancel_all_cas_loads
	killspawnedscript \{name = 0x4ec30caf}
	if (<new_desc_id> = gh4_car_female)
		change \{cas_current_is_female = 1}
	else
		change \{cas_current_is_female = 0}
	endif
	generate_random_genre
	spawnscriptnow 0x4ec30caf params = {is_female = ($cas_current_is_female) genre = <genre> wait 0xabeaed12}
endscript

script 0x4ec30caf 
	if gotparam \{wait}
		wait ($0xc7b81333) second
	endif
	cas_start_loading_anim \{player_index = 0}
	wanted_is_female = <is_female>
	if gotparam \{genre_select}
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
	if gotparam \{anim}
		cas_queue_wait
		if getcurrentcasobject
			band_playanim name = <cas_object> anim = <anim> no_wait
		endif
	endif
	if gotparam \{0xabeaed12}
		0x361b76b3 \{stance = stance_old}
	endif
endscript

script 0x40cc48b1 
	begin
	if NOT scriptisrunning \{0x4ec30caf}
		break
	endif
	waitonegameframe
	repeat
endscript
