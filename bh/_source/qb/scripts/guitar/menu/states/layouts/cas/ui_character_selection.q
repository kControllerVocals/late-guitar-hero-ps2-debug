cas_from_main_menu = 0
customize_char_popup = 0
character_select_delete_sound = ui_menu_select_sfx
character_select_reset_sound = ui_menu_select_sfx
character_select_edit_sound = ui_menu_select_sfx

script ui_create_character_selection 
	change \{respond_to_signin_changed = 1}
	set_cas_loading_setup \{setup = single}
	spawnscriptnow ui_create_character_selection_spawned params = {<...>}
endscript

script ui_create_character_selection_spawned 
	change menu_flow_locked = ($menu_flow_locked + 1)
	change \{rich_presence_context = presence_menus}
	change \{Achievements_creating_character = 0}
	change \{respond_to_signin_changed = 1}
	change \{respond_to_signin_changed_func = none}
	LightShow_NotInGamePlay_SetMood \{mood = menu}
	if GotParam \{from_main_menu}
		change \{cas_from_main_menu = 1}
	else
		change \{cas_from_main_menu = 0}
	endif
	push_loading_screen \{full}
	spawnscriptnow \{wait_for_character_load_then_pop_loading_screen}
	cas_free_resources_camera_fix \{base_name = 'character_selection'}
	if ($customize_char_popup = 1)
		change \{customize_char_popup = 0}
		begin
		if NOT ScreenElementExists \{id = dialog_box_container}
			break
		endif
		Wait \{1
			gameframe}
		repeat
	endif
	cas_get_player_status
	get_savegame_from_player_status player_status = <player_status>

	get_frontend_venue_player_start_checksums
	cas_set_object_node_pos player = ($cas_current_player) node = <Drum_Start>

	if NOT (($cas_from_main_menu) || (GotParam from_difficulty))
		current_character_id = ($<player_status>.character_id)
	else
		current_character_id = Quinton
	endif
	focus_index = 0
	make_character_selection_menu {
		pad_back_script = character_select_back_out
		pad_back_params = {from_difficulty = <from_difficulty> savegame = <savegame>}
		vmenu_alias = create_character_selection_vmenu
	}
	menu_index = 0
	globaltag_getarraysize savegame = <savegame> array_name = custom_profiles
	FormatText TextName = num_profiles_text qs(0x00296914) a = <array_size> b = $max_num_create_a_rockers
	<can_create_new_character> = 0
	if (<array_size> < $max_num_create_a_rockers)
		add_character_selection_item {
			name = qs("CREATE NEW")
			bio = (qs(0xddab4399) + <num_profiles_text>)
			pad_choose_script = create_new_custom_character
			pad_choose_params = {savegame = <savegame> from_char_select}
			additional_focus_script = new_custom_char_focus
			additional_focus_params = {savegame = <savegame>}
			additional_unfocus_script = change_character_unfocus
			additional_unfocus_params = {savegame = <savegame>}
		}
		menu_index = 1
		<can_create_new_character> = 1
	endif
	get_musician_profile_size savegame = <savegame>
	i = 0
	begin
	get_musician_profile_struct_by_index index = <i> savegame = <savegame>
	this_id = (<profile_struct>.name)
	choose_script = choose_character_to_play
	if ($cas_from_main_menu)
		if profile_can_be_modified id = <this_id> savegame = <savegame>
			choose_script = choose_character_to_edit
		else
			choose_script = nullscript
		endif
	else
	endif
	if display_character_logic profile_struct = <profile_struct> savegame = <savegame> part = ($<player_status>.part) from_main_menu = <from_main_menu>
		bio = (<profile_struct>.blurb)
		if is_completely_custom_musician id = <this_id> savegame = <savegame>
			get_current_band_name

			get_custom_musician_bio name = (<profile_struct>.fullname) Band = <band_name> genre = ((<profile_struct>.appearance).genre)
		endif
		add_character_selection_item {
			price = <price>
			bio = <bio>
			name = (<profile_struct>.fullname)
			icon = <icon>
			pad_choose_script = <choose_script>
			pad_choose_params = {character_id = <this_id> savegame = <savegame> price = <price>}
			additional_focus_script = change_character_focus
			additional_focus_params = {character_id = <this_id> savegame = <savegame>}
			additional_unfocus_script = change_character_unfocus
			additional_unfocus_params = {character_id = <this_id> savegame = <savegame>}
		}
		if GotParam \{current_character_id}
			if (<this_id> = <current_character_id>)
				focus_index = <menu_index>
			endif
		endif
		menu_index = (<menu_index> + 1)
	endif
	if GotParam \{price}
		RemoveParameter \{price}
	endif
	i = (<i> + 1)
	repeat <array_size>
	generic_barrel_menu_finish \{no_helper_pills = 1}
	current_menu :SetTags \{reload = 1}
	LaunchEvent type = focus target = create_character_selection_vmenu data = {child_index = <focus_index>}
	generic_barrel_vmenu :generic_barrel_menu_set_index index = <focus_index>
	character_selection_animate_in
	SoundEvent \{event = Menu_Character_Bio_Panel}
	if ($autolaunch_cas_soak_test = 1)
		SpawnScriptLater \{cas_soak_test}
	endif
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_return_character_selection 
	current_menu :SetTags \{reload = 0}
endscript

script character_select_back_out_and_fix_cam 
	if GotParam \{from_difficulty}
		change \{first_character_hub_enter = 1}
		generic_event_back \{nosound
			state = uistate_select_difficulty}
	else
		generic_event_back \{nosound}
	endif
endscript

script get_car_photo_icon 


endscript

script cleanup_photo_assets 


endscript

script cleanup_all_photo_assets 
	if isXenon
		i = 0
		begin
		cleanup_photo_assets savegame = <i>
		i = (<i> + 1)
		repeat 4
	else
		cleanup_photo_assets \{savegame = 0}
	endif
endscript

script ui_destroy_character_selection 
	destroy_character_selection_menu
	cleanup_all_photo_assets
endscript

script ui_init_character_selection 
	ps2_load_car_part_script
	edit_graphic_load_data_from_global
	if GotParam \{player}
		change cas_current_player = <player>
		FormatText checksumname = player_name 'cas_player%i' i = <player>
		change cas_current_player_name = <player_name>
	else
		change \{cas_current_player = 1}
		change \{cas_current_player_name = cas_player1}
	endif
	cas_get_player_status
	change charselect_previous_character_id = ($<player_status>.character_id)
	get_savegame_from_player_status player_status = <player_status>
	create_frontend_lock_targets
	if NOT get_musician_profile_struct_by_id dont_assert id = ($charselect_previous_character_id) savegame = <savegame>
		stars

		stars
		change \{charselect_previous_character_id = axel}
	endif
	if (GotParam from_main_menu)
		cas_queue_kill_player player = ($cas_current_player)
	else
		part = ($<player_status>.part)
		GetGlobalTags savegame = <savegame> last_singleplayer_character
		if NOT (<last_singleplayer_character> = none)
			if profile_exists id = <last_singleplayer_character> savegame = <savegame>
				cas_get_player_status
				change structurename = <player_status> character_id = <last_singleplayer_character>
				cas_queue_new_character_profile id = <last_singleplayer_character> player = ($cas_current_player) savegame = <savegame> hide_old_character = 1
			endif
		else
			cas_queue_kill_player player = ($cas_current_player)
		endif
	endif
endscript

script ui_deinit_character_selection 
	cas_stop_loading_anim \{player_index = 0}
	cancel_all_cas_loads
	destroy_character_selection_menu
	if NOT ($cas_heap_state = in_game)
		cas_free_resources \{spawn
			block_scripts = 1}
	endif
	change \{menu_over_ride_exclusive_device = -1}
	destroy_frontend_lock_targets
	change \{customize_char_popup = 0}
endscript

script create_new_custom_character 
	push_loading_screen \{mini}
	if ($cas_heap_state = in_cas)

	endif
	if NOT ($cas_override_object = none)

	endif
	cas_load_and_setup_resources
	new_custom_character_name savegame = <savegame>
	if NOT GotParam \{from_char_select}
		cas_destroy_all_characters
		is_female = Random (@ 0 @ 1 )
		if (<is_female> = 1)
			profile = ($default_custom_musician_profile_female)
		else
			profile = ($default_custom_musician_profile_male)
		endif
		change cas_current_savegame = <savegame>
		generate_random_name is_female = <is_female>
		generate_random_genre
		spawnscriptnow generate_random_character params = {is_female = <is_female> genre = <genre>}
		wait_for_character_generation
		profile = {
			<profile>
			name = <new_character_id>
			fullname = <random_name>
			appearance = ($cas_current_appearance)
		}
	else
		wait_for_character_generation
		get_is_female_from_appearance \{appearance = $cas_current_appearance}
		generate_random_name is_female = <is_female>
		profile = {
			name = <new_character_id>
			fullname = <random_name>
			allowed_parts = [drum Vocals guitar Bass]
			blurb = qs("\L")
			appearance = ($cas_current_appearance)
		}
	endif
	add_new_custom_profile profile = <profile> savegame = <savegame>
	cas_edit_character_profile character_id = <new_character_id> savegame = <savegame>
	change \{cas_editing_new_character = true}
	pop_loading_screen
	load_character_before_state \{state = UIstate_create_character_gender}
endscript

script choose_character_to_edit \{event = menu_change}
	if ($cas_heap_state = in_cas)

	endif
	cas_queue_block
	cas_edit_character_profile character_id = <character_id> savegame = <savegame>
	if NOT ($cas_override_object = none)

	endif
	cas_load_and_setup_resources
	change \{cas_editing_new_character = false}
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	ui_event event = <event> data = {state = UIstate_customize_character}
endscript

script choose_character_to_play \{num_states = 1}
	change \{first_character_hub_enter = 0}
	KillSpawnedScript \{name = change_character_focus_spawned}
	KillSpawnedScript \{name = generate_random_character}
	cancel_all_cas_loads
	cas_queue_wait
	cas_queue_block
	cas_stop_loading_anim \{player_index = 0}
	cas_get_player_status
	change structurename = <player_status> character_id = <character_id>
	SetGlobalTags savegame = <savegame> last_singleplayer_character params = {last_singleplayer_character = <character_id>}
	if NOT current_band_has_band_name
		ui_event_wait event = menu_replace data = {state = uistate_band_name_logo event_params = {event = menu_back data = {num_states = <num_states>}} from_save = 1 controller = $primary_controller}
		return
	endif
	generic_event_back nosound data = {num_states = <num_states>}
endscript

script change_character_focus 

	KillSpawnedScript \{name = change_character_focus_spawned}
	KillSpawnedScript \{name = generate_random_character}
	current_menu :GetTags \{reload}
	if (<reload>)
		cancel_all_cas_loads
	endif
	spawnscriptnow change_character_focus_spawned params = {<...>}
endscript

script change_character_focus_spawned 
	current_menu :GetTags \{reload}
	current_menu :SetTags \{reload = 1}
	cleanup_character_select_handlers \{no_helpers}
	character_selection_focus id = <id>
	get_musician_profile_struct_by_id id = <character_id> savegame = <savegame>
	can_modify = 0
	if profile_can_be_modified id = <character_id> savegame = <savegame> require_purchased = 1
		<can_modify> = 1
	endif
	clean_up_user_control_helpers
	if (<can_modify> || ($cas_from_main_menu = 0))
		add_user_control_helper \{text = qs("SELECT")
			button = green
			z = 100000}
	endif
	add_user_control_helper \{text = qs("BACK")
		button = red
		z = 100000}
	if (<can_modify>)
		if NOT ($cas_from_main_menu)
			SetScreenElementProps {
				id = create_character_selection_vmenu
				event_handlers = [
					{pad_option2 ($character_select_edit_sound)}
					{pad_option2 choose_character_to_edit params = {character_id = <character_id> savegame = <savegame>}}
				]
				replace_handlers
			}
			add_user_control_helper \{text = qs("EDIT")
				button = Yellow
				z = 100000}
			if IsGuitarController controller = ($primary_controller)
				default_button = Orange
			else
				default_button = Blue
			endif
			default_pad = pad_square
		else
			default_button = Yellow
			default_pad = pad_option2
		endif
		if is_completely_custom_musician id = <character_id> savegame = <savegame>
			default_title = qs("Delete Character?")
			default_text = qs("Are you sure you want to delete this character?")
			default_func = delete_character_profile
			default_sound = ($character_select_delete_sound)
			default_option = qs("DELETE")
		else
			default_title = qs(0x77dcbd95)
			default_text = qs("Are you sure you want to reset this character?")
			default_func = reset_preset_character
			default_sound = ($character_select_reset_sound)
			default_option = qs("RESET")
		endif
		SetScreenElementProps {
			id = create_character_selection_vmenu
			event_handlers =
			[
				{<default_pad> character_select_popup_warning
					params = {
						title = <default_title>
						text = <default_text>
						func = <default_func>
						character_id = <character_id>
						savegame = <savegame>
					}
				}
				{<default_pad> <default_sound>}
			]
			replace_handlers
		}
		add_user_control_helper text = <default_option> button = <default_button> z = 100000
	endif
	if (<reload>)
		Wait ($car_wait_before_load) second
		cas_queue_wait
		cas_queue_add_request appearance = (<profile_struct>.appearance) player = ($cas_current_player)
	endif
	wait_for_character_load_then_force_stance \{stance = Stance_Old}
endscript

script character_select_popup_warning 
	cleanup_character_select_handlers \{no_helpers}
	ui_event event = menu_change data = {
		state = UIstate_generic_dialogue
		is_popup
		title = <title>
		text = <text>
		header_dims = (470.0, 120.0)
		choose_yes_func = <func>
		choose_yes_params = {character_id = <character_id> savegame = <savegame>}
	}
endscript

script change_character_unfocus 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}

	character_selection_unfocus id = <id>
endscript

script character_select_back_out 
	cancel_all_cas_loads
	KillSpawnedScript \{name = change_character_focus_spawned}
	KillSpawnedScript \{name = generate_random_character}
	if NOT (($cas_from_main_menu) || (GotParam from_difficulty))
		if profile_exists id = ($charselect_previous_character_id) savegame = <savegame>
			cas_get_player_status
			change structurename = <player_status> character_id = ($charselect_previous_character_id)
			cas_queue_new_character_profile id = ($charselect_previous_character_id) player = ($cas_current_player) savegame = <savegame> hide_old_character = 1
		endif
	else
		cas_destroy_all_characters
	endif
	character_select_back_out_and_fix_cam from_difficulty = <from_difficulty>
endscript

script delete_character_profile 
	cas_destroy_all_characters

	delete_custom_profile id = <character_id> savegame = <savegame>
	cas_get_player_status
	change structurename = <player_status> character_id = ($charselect_previous_character_id)
	ui_memcard_autosave_replace event = menu_back state = uistate_character_selection data = {savegame = <savegame>}
endscript

script reset_preset_character 
	cas_destroy_all_characters

	restore_custom_musician_parts id = <character_id> savegame = <savegame>
	if NOT ($cas_from_main_menu)
		cas_queue_new_character_profile player = ($cas_current_player) id = <character_id> savegame = <savegame>
	endif
	ui_memcard_autosave_replace event = menu_back state = uistate_character_selection data = {savegame = <savegame>}
endscript

script cleanup_character_select_handlers 
	SetScreenElementProps \{id = create_character_selection_vmenu
		event_handlers = [
			{
				pad_option
				nullscript
			}
			{
				pad_l1
				nullscript
			}
			{
				pad_square
				nullscript
			}
			{
				pad_option2
				nullscript
			}
		]
		replace_handlers}
	if NOT GotParam \{no_helpers}
		clean_up_user_control_helpers
		add_user_control_helper \{text = qs("SELECT")
			button = green
			z = 100000}
		add_user_control_helper \{text = qs("BACK")
			button = red
			z = 100000}
	endif
endscript

script new_custom_char_focus 

	KillSpawnedScript \{name = change_character_focus_spawned}
	KillSpawnedScript \{name = generate_random_character}
	cancel_all_cas_loads
	cleanup_character_select_handlers
	change cas_current_savegame = <savegame>
	is_female = Random (@ 0 @ 1 )
	generate_random_genre
	<id> :SE_SetProps character_selection_item_text_alpha = 1.0
	spawnscriptnow generate_random_character params = {is_female = <is_female> genre = <genre> Wait changeStance}
endscript

script display_character_logic 

	if NOT GotParam \{from_main_menu}
		if NOT is_allowed_part profile_struct = <profile_struct> part = <part>
			if GotParam \{bandplay}
				if (<part> = guitar)
					if NOT is_allowed_part profile_struct = <profile_struct> part = Bass
						return \{false}
					endif
				else
					return \{false}
				endif
			else
				return \{false}
			endif
		endif
	endif
	if is_profile_unlocked savegame = <savegame> profile_struct = <profile_struct>
		if is_selectable_profile profile_struct = <profile_struct>
			if GotParam \{only_purchased}
				if is_profile_purchased id = (<profile_struct>.name) savegame = <savegame>
					if NOT GotParam \{from_main_menu}
						return \{true}
					else
						if profile_can_be_modified id = (<profile_struct>.name) savegame = <savegame>
							return \{true}
						else
							return \{false}
						endif
					endif
				endif
			else
				if NOT GotParam \{from_main_menu}
					return \{true}
				else
					if profile_can_be_modified id = (<profile_struct>.name) savegame = <savegame>
						return \{true}
					else
						return \{false}
					endif
				endif
			endif
		else
			return \{false}
		endif
	endif
endscript

script get_custom_musician_bio 

	StringRemoveTrailingWhitespace string = <Band>
	StringToCharArray string = <new_string>
	GetArraySize <char_array>
	if (<array_size> = 0)
		<Band> = qs(0xc40aec34)
	endif
	switch <genre>
		case Rock
		FormatText TextName = blurb qs(0x95fb7acf) n = <name> b = <Band>
		case Punk
		FormatText TextName = blurb qs(0xe94b155b) n = <name> b = <Band>
		case `Heavy Metal`
		FormatText TextName = blurb qs(0xa80688b8) n = <name> b = <Band>
		case `Glam Rock`
		FormatText TextName = blurb qs(0xb93c4ca3) n = <name> b = <Band>
		case `Black Metal`
		FormatText TextName = blurb qs(0x386cc385) n = <name> b = <Band>
		case `Classic Rock`
		FormatText TextName = blurb qs(0xbb95c056) n = <name> b = <Band>
		case Goth
		FormatText TextName = blurb qs(0xb3762de3) n = <name> b = <Band>
		case Pop
		FormatText TextName = blurb qs(0x7e7fa45e) n = <name> b = <Band>
		case any
		FormatText TextName = blurb qs(0xcf4a5442) n = <name> b = <Band>
		default

	endswitch
	return bio = <blurb>
endscript

script external_edit_character 
	change \{cas_from_main_menu = 0}
	if GotParam \{player}
		change cas_current_player = <player>
		FormatText checksumname = player_name 'cas_player%i' i = <player>
		change cas_current_player_name = <player_name>
	else
		change \{cas_current_player = 1}
		change \{cas_current_player_name = cas_player1}
		player = 1
	endif
	cancel_all_cas_loads except = ($cas_current_player)
	cas_get_player_status
	get_savegame_from_player_status player_status = <player_status>
	change charselect_previous_character_id = ($<player_status>.character_id)
	get_frontend_venue_player_start_checksums
	cas_set_object_node_pos player = ($cas_current_player) node = <Drum_Start>
	i = 1
	begin
	if NOT (<i> = <player>)
		cas_queue_kill_player player = <i>
	endif
	i = (<i> + 1)
	repeat 4
	current_character_id = ($<player_status>.character_id)
	change menu_over_ride_exclusive_device = ($<player_status>.controller)
	if GotParam \{editing_controller}
		change menu_over_ride_exclusive_device = <editing_controller>
	endif
	choose_character_to_edit character_id = <current_character_id> savegame = <savegame> no_charsel external_edit
endscript

script wait_for_character_load_then_pop_loading_screen 
	i = 0
	begin
	if cas_queue_is_busy \{in_queue_too}
		break
	endif
	if (<i> > 300)
		break
	endif
	Wait \{1
		gameframe}
	<i> = (<i> + 1)
	repeat
	cas_queue_wait
	pop_loading_screen
endscript

script wait_for_character_load_then_force_stance \{stance = Stance_Old}
	begin
	if cas_queue_is_busy \{in_queue_too}
		break
	endif
	Wait \{1
		gameframe}
	repeat
	cas_queue_wait
	if GetCurrentCASObject
		<cas_object> :hide
	endif
	if GetCurrentCASObject
		BandManager_ChangeStance name = <cas_object> stance = <stance> no_wait
	endif
	if GetCurrentCASObject
		<cas_object> :unhide
	endif
endscript
