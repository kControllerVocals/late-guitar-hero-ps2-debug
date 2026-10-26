
script ui_create_band_logo_choose 
	SpawnScriptLater ui_create_band_logo_choose_spawned params = {<...>}
endscript

script ui_create_band_logo_choose_spawned 
	change \{cas_heap_state = in_cas}
	cas_destroy_all_characters
	generate_random_appearance \{is_female = 1
		genre = mixed
		new_car_character}
	EditCASAppearance \{target = SetPart
		targetParams = {
			part = CAS_Torso
			desc_id = F_Torso_Band_Logo_Tee
		}}
	if current_band_has_band_logo
		edit_graphic_load_data_from_global
	else
		randomize_band_logo
	endif
	change \{cas_current_instrument = none}
	cas_queue_add_request appearance = ($cas_current_appearance) instrument = none player = ($cas_current_player)
	cas_queue_wait
	GetCurrentCASObject
	BandManager_ChangeStance name = <cas_object> stance = Stance_Select_Torso no_wait
	GetCurrentCASObject
	cas_set_object_node_pos player = ($cas_current_player) node = Z_SoundCheck_TRG_Waypoint_CAR_Start
	<cas_object> :Obj_SetOrientation Quat = (0.0, -0.13, 0.0)
	<cas_object> :Obj_GetPosition
	cam_pos = (<pos> + (-0.3, 1.4499999, 1.0))
	PlayIGCCam {
		name = ui_band_logo_choose_camera
		viewport = bg_viewport
		pos = <cam_pos>
		Quat = (0.0, -1.0, 0.0)
		Play_hold = 1
		interrupt_current
	}
	change \{rich_presence_context = presence_band_logo_edit_and_instrument_edit}
	pad_back_script = nullscript
	menu_create_script = make_generic_menu
	item_add_script = add_generic_menu_text_item
	if ui_event_exists_in_stack \{name = 'mainmenu'}
		pad_back_script = generic_event_back
	endif
	cam_name = 'options_manage_band_logo'
	if GotParam \{from_band_info}
		<menu_create_script> {
			title = qs("BAND INFO")
			item_scale = 1.3
			pad_back_script = <pad_back_script>
		}
		get_savegame_from_controller controller = <device_num>
		get_current_band_info
		bandname_id = <band_info>
		GetGlobalTags <bandname_id> param = name savegame = <savegame>
		CreateScreenElement {
			type = TextBlockElement
			parent = generic_menu
			text = <name>
			pos = (315.0, 145.0)
			font = fontgrid_text_a6_fire
			dims = (260.0, 35.0)
			just = [center , top]
			rgba = (($default_color_scheme).text_color)
			fit_height = `scale down if larger`
			fit_width = `scale each line if larger`
		}
		<item_add_script> {
			text = qs(0x7716d78c)
			choose_state = uistate_band_name_enter
			choose_state_data = {from_band_logo = 1}
		}
	else
		if Spanish
			<menu_create_script> {
				title = qs(0x410e2d9f)
				title_dims = (350.0, 50.0)
				shift = (-50.0, 0.0)
				item_scale = 1.3
				pad_back_script = nullscript
				pad_back_sound = null
			}
		elseif Italian
			<menu_create_script> {
				title = qs(0x410e2d9f)
				title_dims = (350.0, 50.0)
				shift = (-50.0, 0.0)
				item_scale = 1.3
				pad_back_script = nullscript
				pad_back_sound = null
			}
		elseif German
			<menu_create_script> {
				title = qs(0x410e2d9f)
				title_dims = (300.0, 50.0)
				shift = (-30.0, 0.0)
				item_scale = 1.3
				pad_back_script = nullscript
				pad_back_sound = null
			}
		elseif French
			<menu_create_script> {
				title = qs(0x410e2d9f)
				title_dims = (300.0, 50.0)
				shift = (-30.0, 0.0)
				item_scale = 1.3
				pad_back_script = nullscript
				pad_back_sound = null
			}
		else
			<menu_create_script> {
				title = qs(0x410e2d9f)
				item_scale = 1.3
				pad_back_script = nullscript
				pad_back_sound = null
			}
		endif
	endif
	<item_add_script> {
		text = qs("Continue")
		pad_choose_script = band_logo_choose_continue
		pad_choose_params = {event_params = <event_params> from_band_info = <from_band_info>}
	}
	get_savegame_from_controller controller = ($primary_controller)
	<item_add_script> {
		text = qs("Edit")
		choose_state = UIstate_cap_main
	}
	<item_add_script> {
		text = qs("Randomize")
		pad_choose_script = randomize_band_logo
	}
	add_user_control_helper \{text = qs("SELECT")
		button = green
		z = 100000
		all_buttons}
	if GotParam \{pad_back_script}
		if GotParam \{from_band_info}
			add_user_control_helper \{text = qs("BACK")
				button = red
				z = 100000}
		endif
	endif
	LaunchEvent \{type = focus
		target = current_menu}
	destroy_loading_screen
endscript

script ui_destroy_band_logo_choose 
	cas_destroy_all_characters
	generic_ui_destroy
	destroy_generic_menu
endscript

script ui_init_band_logo_choose controller = ($primary_controller)
	init_band_logo controller = <controller>
endscript

script ui_deinit_band_logo_choose 
	KillCamAnim \{name = ui_band_logo_choose_camera}
	change \{cas_override_object = none}
	BandLogoObject :SwitchOffAtomic \{CAS_Band_Logo}
	cas_free_resources \{no_bink
		no_loading_screen
		band_logo}
endscript

script randomize_band_logo 
	if cas_queue_is_busy \{in_queue_too}
		return
	endif
	GetArraySize ($edit_graphic_preset_logos)
	if (<array_size> <= 0)
		debug_ScriptAssert \{qs(0x1bcaf0b6)}
	endif
	GetRandomValue name = rand_index a = 0 b = (<array_size> -1) Integer
	random_logo = (($edit_graphic_preset_logos) [<rand_index>])
	change edit_graphic_layer_infos = <random_logo>
	edit_graphic_load_data data = (<random_logo>)
	edit_graphic_save_data_to_global
	if GetCurrentCASObject
		RebuildCurrentCASModel
	endif
endscript

script band_logo_choose_continue 
	begin
	if NOT ScriptIsRunning \{trigger_CAS_rebuild_loop}
		break
	endif
	Wait \{1
		gameframe}
	repeat
	cas_queue_wait
	GetCASAppearancePart \{part = CAS_Band_Logo}
	if GotParam \{cap}
		get_savegame_from_controller controller = <device_num>
		get_current_band_info
		SetGlobalTags savegame = <savegame> <band_info> params = {band_logo = <cap>}
	endif
	GetCASAppearancePart \{part = CAS_Select_A_Logo}
	if GotParam \{desc_id}
		get_savegame_from_controller controller = <device_num>
		get_current_band_info
		SetGlobalTags savegame = <savegame> <band_info> params = {band_logo = <desc_id>}
	else

	endif
	if GotParam \{from_band_info}
		generic_event_back
	else
		next_state = UIstate_singleplayer_character_hub
		if ($current_num_players > 1)
			next_state = uistate_gig_posters
		endif
		generic_event_replace state = <next_state> data = {event_params = <event_params>}
	endif
endscript

script current_band_has_band_logo controller = ($primary_controller)
	get_savegame_from_controller controller = <controller>
	get_current_band_info
	GetGlobalTags savegame = <savegame> <band_info>
	if GotParam \{band_logo}
		GetArraySize <band_logo>
		if (<array_size> > 0)
			return \{true}
		else
			return \{false}
		endif
	else
		return \{false}
	endif
endscript

script current_band_has_band_name controller = ($primary_controller)
	get_savegame_from_controller controller = <controller>
	get_current_band_info
	GetGlobalTags savegame = <savegame> <band_info>
	if GotParam \{name}
		if (<name> = qs("\L"))
			return \{false}
		else
			return \{true}
		endif
	else
		return \{false}
	endif
endscript

script current_band_save_created controller = ($primary_controller)
	get_savegame_from_controller controller = <controller>
	get_current_band_info
	GetGlobalTags savegame = <savegame> <band_info>
	if GotParam \{save_created}
		if (<save_created> = 0)
			return \{false}
		else
			return \{true}
		endif
	else
		return \{false}
	endif
endscript

script SetBandLogoToCASAppearance 
	get_savegame_from_controller controller = <controller>
	get_current_band_info
	GetGlobalTags savegame = <savegame> <band_info>
	if GotParam \{band_logo}
		if IsChecksum <band_logo>
			EditCASAppearance target = SetPart targetParams = {part = CAS_Select_A_Logo desc_id = <band_logo>}
		endif
	endif
endscript

script ui_return_band_logo_choose 
	add_user_control_helper \{text = qs("SELECT")
		button = green
		z = 100000
		all_buttons}
	if GotParam \{from_band_info}
		add_user_control_helper \{text = qs("BACK")
			button = red
			z = 100000}
	endif
endscript
