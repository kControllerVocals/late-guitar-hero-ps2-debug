
script ui_create_select_instrument 
	ui_select_instrument_continue <...>
endscript

script ui_destroy_select_instrument 
	KillSpawnedScript \{name = career_menu_jaw_anim}
	generic_ui_destroy
endscript
instrument_list = {
	guitar = {
		text = qs("GUITAR")
		text_nl = 'guitar'
	}
	Bass = {
		text = qs("BASS")
		text_nl = 'bass'
	}
	drum = {
		text = qs("DRUM")
		text_nl = 'drum'
	}
	Vocals = {
		text = qs("VOCALS")
		text_nl = 'vocals'
	}
	Band = {
		text = qs("BAND")
		text_nl = 'band'
	}
}

script ui_select_instrument_continue 
	change menu_flow_locked = ($menu_flow_locked + 1)
	if GotParam \{from_hub}
		title = qs("CHANGE INSTRUMENT")
	else
		title = qs("INSTRUMENT")
	endif
	if GotParam \{from_top_rocker}
		screen = Guitarist
	else
		screen = Drummer
	endif
	GameMode_GetNumPlayers
	if (<num_players> = 1)
		clear_exclusive_devices
		add_exclusive_device device = ($primary_controller)
	endif
	make_menu_frontend screen = <screen> title = <title> pad_back_script = ui_select_instrument_back
	if <desc_id> :Desc_ResolveAlias name = alias_projection param = projection_id
		<projection_id> :SE_SetProps pos = (1000.0, 350.0)
		<projection_id> :SE_SetProps dims = (800.0, 650.0)
		<projection_id> :SE_SetProps alpha = 0.48000002
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_projection_glow param = projection_glow_id
		<projection_glow_id> :SE_SetProps pos = (1000.0, 350.0)
		<projection_glow_id> :SE_SetProps dims = (800.0, 650.0)
		<projection_glow_id> :obj_spawnscript ui_flicker_highlight
	else

	endif
	allow_guitar = 0
	allow_drum = 0
	allow_vocal = 0
	if GotParam \{from_top_rocker}
		allow_guitar = 1
		allow_drum = 1
		allow_vocal = 1
	endif
	ui_get_controller_parts_allowed controller = ($primary_controller)
	if StructureContains Structure = <allowed> guitar
		allow_guitar = 1
	endif
	if StructureContains Structure = <allowed> drum
		allow_drum = 1
	endif
	if StructureContains Structure = <allowed> Vocals
		allow_vocal = 1
	endif
	if (<allow_guitar> = 1)
		add_menu_frontend_item {
			text = ($band_mode_available_text.Instruments [0])
			pad_choose_script = ui_select_instrument_done
			pad_choose_params = {instrument = guitar from_hub = <from_hub> from_top_rocker = <from_top_rocker>}
		}
		add_menu_frontend_item {
			text = ($band_mode_available_text.Instruments [1])
			pad_choose_script = ui_select_instrument_done
			pad_choose_params = {instrument = Bass from_hub = <from_hub> from_top_rocker = <from_top_rocker>}
		}
	else
		add_menu_frontend_item {
			text = ($band_mode_available_text.Instruments [0])
			choose_state = uistate_select_instrument_warning
			choose_state_data = {instrument = guitar controller = ($primary_controller)}
			rgba = [140 140 140 255]
		}
		add_menu_frontend_item {
			text = ($band_mode_available_text.Instruments [1])
			choose_state = uistate_select_instrument_warning
			choose_state_data = {instrument = Bass controller = ($primary_controller)}
			rgba = [140 140 140 255]
		}
	endif
	if ((($allow_controller_for_all_instruments) = 1) || (GotParam from_top_rocker))
		if (<allow_drum> = 1)
			add_menu_frontend_item {
				text = ($band_mode_available_text.Instruments [2])
				pad_choose_script = ui_select_instrument_done
				pad_choose_params = {instrument = drum from_hub = <from_hub> from_top_rocker = <from_top_rocker>}
			}
		else
			add_menu_frontend_item {
				text = ($band_mode_available_text.Instruments [2])
				choose_state = uistate_select_instrument_warning
				choose_state_data = {instrument = drum controller = ($primary_controller)}
				rgba = [140 140 140 255]
			}
		endif
		if (<allow_vocal> = 1)
			add_menu_frontend_item {
				text = ($band_mode_available_text.Instruments [3])
				pad_choose_script = ui_select_instrument_done
				pad_choose_params = {instrument = Vocals from_hub = <from_hub> from_top_rocker = <from_top_rocker>}
			}
		else
			add_menu_frontend_item {
				text = ($band_mode_available_text.Instruments [3])
				pad_choose_script = ui_select_instrument_done
				pad_choose_params = {instrument = Vocals from_hub = <from_hub> from_top_rocker = <from_top_rocker>}
				rgba = [140 140 140 255]
			}
		endif
	endif
	if GotParam \{from_top_rocker}
		add_menu_frontend_item {
			text = qs("BAND")
			pad_choose_script = ui_select_instrument_done
			pad_choose_params = {instrument = Band from_hub = <from_hub> from_top_rocker = <from_top_rocker>}
		}
	else
		current_menu :obj_spawnscript ui_select_instrument_check_controllers params = {from_hub = <from_hub> from_top_rocker = <from_top_rocker>}
	endif
	if NOT GotParam \{old_base_name}
		if NOT GotParam \{from_top_rocker}
			initial_focus = 0
			if IsGuitarController controller = ($primary_controler)
				<initial_focus> = 0
			elseif IsDrumController controller = ($primary_controller)
				<initial_focus> = 2
			else
				if (<allow_guitar> = 0)
					if (<allow_drum> = 0)
						<initial_focus> = 3
					else
						<initial_focus> = 2
					endif
				endif
			endif
			LaunchEvent type = focus target = current_menu data = {child_index = (<initial_focus> + 1)}
		endif
	endif
	menu_finish
	destroy_loading_screen
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script select_instrument_anim_in 
	menu_transition_in \{menu = current_menu_anchor}
endscript

script select_instrument_anim_out 
	menu_transition_out \{menu = current_menu_anchor}
endscript
career_last_chosen_part = guitar

script ui_select_instrument_done \{player = 1
		event = menu_change}
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	begin
	if NOT Is_ui_event_running
		break
	endif
	Wait \{1
		gameframe}
	repeat
	if GotParam \{from_top_rocker}
		if (<instrument> = Band)
			change \{game_mode = p1_quickplay}
		else
			change \{game_mode = p1_quickplay}
		endif
	endif
	if (<instrument> = Vocals)
		allow_vocal = 0
		if GotParam \{from_top_rocker}
			allow_vocal = 1
		else
		endif
		ui_get_controller_parts_allowed controller = ($primary_controller)
		if StructureContains Structure = <allowed> Vocals
			allow_vocal = 1
		endif
		if (<allow_vocal> = 0)
			generic_event_choose state = uistate_select_instrument_warning data = {instrument = Vocals controller = ($primary_controller)}
			return
		endif
	else
		ui_get_controller_parts_allowed controller = ($primary_controller)
		if NOT GotParam \{from_top_rocker}
			if NOT StructureContains Structure = <allowed> <instrument>
				generic_event_choose state = uistate_select_instrument_warning data = {instrument = <instrument> controller = ($primary_controller)}
			endif
		endif
	endif
	change player1_device = ($primary_controller)
	SetPlayerInfo <player> part = <instrument>
	change career_last_chosen_part = <instrument>
	SetPlayerInfo <player> controller = ($primary_controller)
	if GotParam \{from_top_rocker}
		get_controller_part controller = ($primary_controller)
		change top_rocker_active_controller = <controller_part>
	else
		change \{top_rocker_active_controller = none}
	endif
	vocals_distribute_mics
	if ($is_partyplay_mode = 1)
		generic_event_choose \{state = uistate_select_difficulty}
	endif
	if ($game_mode = gh4_p1_career)
		player_status = player1_status
		get_current_band_info
		GetGlobalTags <band_info>
		switch <instrument>
			case guitar
			change \{current_progression_flag = Career_Guitar}
			change structurename = <player_status> part = guitar
			case Bass
			change \{current_progression_flag = Career_Bass}
			change structurename = <player_status> part = Bass
			case drum
			change \{current_progression_flag = Career_Drum}
			change structurename = <player_status> part = drum
			case Vocals
			change \{current_progression_flag = Career_Vocals}
			change structurename = <player_status> part = Vocals
		endswitch
		register_new_progression_atoms ($current_progression_flag)
	endif
	if ($practice_enabled)
		vocals_distribute_mics
		generic_event_choose \{state = uistate_setlist
			data = {
				no_jamsession
			}}
		return
	endif
	switch ($game_mode)
		case p1_quickplay
		if NOT GotParam \{skip}
			generic_event_choose event = <event> state = uistate_setlist data = {from_top_rocker = <from_top_rocker>}
		else
			set_primary_controller device_num = <device_num> event = <event> state = uistate_setlist data = {from_top_rocker = <from_top_rocker>}
		endif
		case p2_pro_faceoff
		SetPlayerInfo 1 part = <instrument>
		SetPlayerInfo 2 part = <instrument>
		generic_event_choose event = <event> state = uistate_select_difficulty
		default
		if GotParam \{from_top_rocker}
			generic_event_choose event = <event> state = uistate_setlist data = {from_top_rocker = <from_top_rocker>}
		endif
		if GotParam \{from_hub}
			generic_event_back \{state = UIstate_singleplayer_character_hub}
		else
			if NOT GotParam \{skip}
				generic_event_choose event = <event> state = uistate_select_difficulty
			else
				set_primary_controller device_num = <device_num> event = <event> event = <event> state = uistate_select_difficulty
			endif
		endif
	endswitch
endscript

script ui_select_instrument_check_controllers 
	Obj_GetID
	begin
	ui_get_controller_parts_allowed controller = ($primary_controller)
	if GotParam \{allowed}
		<ObjID> :Menu_GetSelectedIndex
		if StructureContains Structure = <allowed> guitar
			if NOT (<selected_index> = 1)
				SetScreenElementProps {
					id = {<ObjID> child = 1}
					rgba = [255 255 255 255]
					use_shadow = false
					event_handlers = [
						{pad_choose ui_select_instrument_done params = {instrument = guitar from_hub = <from_hub> from_top_rocker = <from_top_rocker>}}
					]
					replace_handlers
				}
			else
				SetScreenElementProps {
					id = {<ObjID> child = 1}
					rgba = [0 0 0 255]
					use_shadow = false
					event_handlers = [
						{pad_choose ui_select_instrument_done params = {instrument = guitar from_hub = <from_hub> from_top_rocker = <from_top_rocker>}}
					]
					replace_handlers
				}
			endif
			if NOT (<selected_index> = 2)
				SetScreenElementProps {
					id = {<ObjID> child = 2}
					rgba = [255 255 255 255]
					use_shadow = false
					event_handlers = [
						{pad_choose ui_select_instrument_done params = {instrument = Bass from_hub = <from_hub> from_top_rocker = <from_top_rocker>}}
					]
					replace_handlers
				}
			else
				SetScreenElementProps {
					id = {<ObjID> child = 2}
					rgba = [0 0 0 255]
					use_shadow = false
					event_handlers = [
						{pad_choose ui_select_instrument_done params = {instrument = Bass from_hub = <from_hub> from_top_rocker = <from_top_rocker>}}
					]
					replace_handlers
				}
			endif
		else
			if NOT (<selected_index> = 1)
				SetScreenElementProps {
					id = {<ObjID> child = 1}
					rgba = [125 125 125 255]
					use_shadow = false
					event_handlers = [
						{pad_choose generic_event_choose params = {state = uistate_select_instrument_warning data = {instrument = guitar controller = ($primary_controller)}}}
					]
					replace_handlers
				}
			else
				SetScreenElementProps {
					id = {<ObjID> child = 1}
					rgba = [125 125 125 255]
					use_shadow = true
					shadow_rgba = [0 0 0 255]
					event_handlers = [
						{pad_choose generic_event_choose params = {state = uistate_select_instrument_warning data = {instrument = guitar controller = ($primary_controller)}}}
					]
					replace_handlers
				}
			endif
			if NOT (<selected_index> = 2)
				SetScreenElementProps {
					id = {<ObjID> child = 2}
					rgba = [125 125 125 255]
					use_shadow = false
					event_handlers = [
						{pad_choose generic_event_choose params = {state = uistate_select_instrument_warning data = {instrument = guitar controller = ($primary_controller)}}}
					]
					replace_handlers
				}
			else
				SetScreenElementProps {
					id = {<ObjID> child = 2}
					rgba = [125 125 125 255]
					use_shadow = true
					shadow_rgba = [0 0 0 255]
					event_handlers = [
						{pad_choose generic_event_choose params = {state = uistate_select_instrument_warning data = {instrument = guitar controller = ($primary_controller)}}}
					]
					replace_handlers
				}
			endif
		endif
		if (($allow_controller_for_all_instruments) = 1)
			if StructureContains Structure = <allowed> drum
				if NOT (<selected_index> = 3)
					SetScreenElementProps {
						id = {<ObjID> child = 3}
						rgba = [255 255 255 255]
						use_shadow = false
						event_handlers = [
							{pad_choose ui_select_instrument_done params = {instrument = drum from_hub = <from_hub> from_top_rocker = <from_top_rocker>}}
						]
						replace_handlers
					}
				else
					SetScreenElementProps {
						id = {<ObjID> child = 3}
						rgba = [0 0 0 255]
						use_shadow = false
						event_handlers = [
							{pad_choose ui_select_instrument_done params = {instrument = drum from_hub = <from_hub> from_top_rocker = <from_top_rocker>}}
						]
						replace_handlers
					}
				endif
			else
				if NOT (<selected_index> = 3)
					SetScreenElementProps {
						id = {<ObjID> child = 3}
						rgba = [125 125 125 255]
						use_shadow = false
						event_handlers = [
							{pad_choose generic_event_choose params = {state = uistate_select_instrument_warning data = {instrument = drum controller = ($primary_controller)}}}
						]
						replace_handlers
					}
				else
					SetScreenElementProps {
						id = {<ObjID> child = 3}
						rgba = [125 125 125 255]
						use_shadow = true
						shadow_rgba = [0 0 0 255]
						event_handlers = [
							{pad_choose generic_event_choose params = {state = uistate_select_instrument_warning data = {instrument = drum controller = ($primary_controller)}}}
						]
						replace_handlers
					}
				endif
			endif
			if StructureContains Structure = <allowed> Vocals
				if NOT (<selected_index> = 4)
					SetScreenElementProps {
						id = {<ObjID> child = 4}
						rgba = [255 255 255 255]
						use_shadow = false
					}
				else
					SetScreenElementProps {
						id = {<ObjID> child = 4}
						rgba = [0 0 0 255]
						use_shadow = false
					}
				endif
			else
				if NOT (<selected_index> = 4)
					SetScreenElementProps {
						id = {<ObjID> child = 4}
						rgba = [125 125 125 255]
						use_shadow = false
					}
				else
					SetScreenElementProps {
						id = {<ObjID> child = 4}
						rgba = [125 125 125 255]
						use_shadow = true
						shadow_rgba = [0 0 0 255]
					}
				endif
			endif
		endif
	endif
	RemoveParameter \{allowed}
	Wait \{1
		gameframe}
	repeat
endscript

script ui_select_instrument_back 
	change \{top_rockers_enabled = 0}
	generic_event_back
endscript
