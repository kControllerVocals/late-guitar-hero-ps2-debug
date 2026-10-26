
script ui_create_cag_custom 
	if cag_custom_is_new_category is_esp = <is_esp>
		cag_randomize part = (<instrument_info>.body_part)
	endif
	title = qs("AXE SMITH")
	if (<is_esp>)
		<title> = qs("ESP CUSTOM SHOP")
	endif
	make_generic_menu {
		vmenu_id = create_cag_custom_vmenu
		title = <title>
		show_history
		cai_bg = 1
		smaller_menu
	}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	setup_cas_menu_handlers \{vmenu_id = create_cag_custom_vmenu
		camera_list = [
			'cag_main'
			'cag_main_R'
			'cag_main_B'
			'cag_main_L'
		]
		zoom_camera = 'customize_cag_Zoom'}
	add_generic_menu_text_item {
		text = qs("BODY")
		choose_state = UIstate_cag_custom_body
		choose_state_data = {instrument_info = <instrument_info> is_esp = <is_esp>}
	}
	add_generic_menu_text_item {
		text = qs("FRET BOARD")
		choose_state = UIstate_cag_select_part_inclusion
		choose_state_data = {
			part = (<instrument_info>.neck_part)
			body_part = (<instrument_info>.body_part)
			text = qs("NECK")
			cam_name = 'DrumStart'
			is_popup
			hist_tex = icon_cag_neck
			cam_name = 'cag_select_fretboard'
			no_edit
			camera_list = ['cag_select_fretboard' 'cag_select_fretboard_R' 'cag_select_fretboard_B' 'cag_select_fretboard_L']
			zoom_camera = 'cag_select_fretboard_Zoom'
			is_esp = <is_esp>
		}
	}
	if GetCASAppearancePart part = (<instrument_info>.neck_part)
		GetActualCASOptionStruct part = (<instrument_info>.neck_part) desc_id = <desc_id>
		if GotParam \{Finishable}
			add_generic_menu_text_item {
				text = qs("INLAYS")
				choose_state = UIstate_cag_select_part_inclusion
				choose_state_data = {part = (<Finishable>) body_part = (<instrument_info>.neck_part) text = qs("INLAYS") cam_name = 'cag_select_fretboard' camera_list = ['cag_select_fretboard' 'cag_select_fretboard_R' 'cag_select_fretboard_B' 'cag_select_fretboard_L'] zoom_camera = 'cag_select_fretboard_Zoom' container_id = <container_id> is_popup hist_tex = icon_cag_inlay color_wheel = ($guitar_colorwheel)}
			}
		endif
	endif
	add_generic_menu_text_item {
		text = qs("HEADSTOCK")
		choose_state = UIstate_cag_custom_head
		choose_state_data = {part = (<instrument_info>.head_part) body_part = (<instrument_info>.body_part) is_esp = <is_esp>}
	}
	add_generic_menu_text_item {
		text = qs("HARDWARE")
		choose_state = UIstate_cag_custom_hardware
		choose_state_data = {instrument_info = <instrument_info> is_esp = <is_esp>}
	}
	add_generic_menu_text_item {
		text = qs("RANDOM")
		choose_state = UIstate_generic_dialogue
		choose_state_data = {
			title = qs("RANDOM DESIGN?")
			text = qs("By selecting random your old design will be lost. Would you like to continue?")
			choose_yes_func = cag_generate_then_back
			choose_yes_params = {part = (<instrument_info>.body_part)}
		}
	}
	GetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue param = visit_cag
	if (<visit_cag> = 0)
		SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {visit_cag = 1}
		ui_event_wait \{event = menu_change
			data = {
				state = UIstate_helper_dialogue
				is_popup
				life = 30
				text = qs("The CUSTOMIZE option allows you to build a custom axe.  Changing BODY STYLE, FRET BOARD, HEADSTOCK STYLE and PICKGUARD STYLE will undo any changes to the FINISHES that you make.")
			}}
	endif
	menu_finish \{car_helper_text}
	draw_guitar_center_logo
	LaunchEvent type = focus target = create_cag_custom_vmenu data = {child_index = <selected_index>}
endscript

script ui_destroy_cag_custom 
	destroy_generic_menu
endscript

script ui_return_cag_custom 
	spawnscriptnow \{ui_event_block
		params = {
			event = menu_refresh
		}}
endscript

script cag_custom_is_new_category 
	if ($cag_instrument_type = guitar)
		GetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = guitar_category
		<old_category> = <guitar_category>
		if GotParam \{is_esp}
			if (<is_esp> = 1)
				SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {guitar_category = esp}
			else
				SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {guitar_category = gh}
			endif
		else
			SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {guitar_category = gh}
		endif
		GetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = guitar_category
		if (<old_category> != <guitar_category>)
			return \{true}
		endif
	endif
	if ($cag_instrument_type = Bass)
		GetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = bass_category
		<old_category> = <bass_category>
		if GotParam \{is_esp}
			if (<is_esp> = 1)
				SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {bass_category = esp}
			else
				SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {bass_category = gh}
			endif
		else
			SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {bass_category = gh}
		endif
		GetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = bass_category
		if (<old_category> != <bass_category>)
			return \{true}
		endif
	endif
	return \{false}
endscript

script cag_randomize 
	spawnscriptnow cag_randomize_spawned params = {<...>}
endscript

script cag_randomize_spawned 
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	cas_get_is_female \{player = $cas_current_player}
	genre = (($cas_current_appearance).genre)
	cas_start_loading_anim \{player_index = 0}
	if NOT GotParam \{genre}
		genre = Rock
	endif
	if (<part> = CAS_Guitar_Body)
		GetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue param = guitar_category
		cas_merge_in_random_entry entry = ($cas_randomized_instruments.guitar) is_female = <is_female> genre = <genre> category = <guitar_category> skip_part_caching
	elseif (<part> = CAS_Bass_Body)
		GetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {bass_category}
		cas_merge_in_random_entry entry = ($cas_randomized_instruments.Bass) is_female = <is_female> genre = <genre> category = <bass_category> skip_part_caching
	endif
	RebuildCurrentCASModel
	Wait \{1
		second}
endscript

script cag_generate_then_back 
	cag_randomize_spawned <...>
	ui_event \{event = menu_back}
endscript
