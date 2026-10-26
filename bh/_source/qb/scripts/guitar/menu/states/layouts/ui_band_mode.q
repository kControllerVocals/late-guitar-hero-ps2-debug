
script ui_init_band_mode 
	push_num_players \{num = 0}
endscript

script ui_deinit_band_mode 
	pop_num_players
endscript

script ui_create_band_mode 
	change_num_players \{num = 0}
	GameMode_GetType
	if (<type> = career)
		register_new_progression_atoms \{Career_Band}
	endif
	spawnscriptnow \{qi_initialize
		params = {
			mode = band_mode
		}}
endscript

script ui_destroy_band_mode 
	KillSkaterCamAnim \{name = Bandmode_camera}
	qi_destroy
endscript

script sanity_check_fix_deleted_characters 
	fix_deleted_character_player_status \{player = 1}
	fix_deleted_character_player_status \{player = 2}
	fix_deleted_character_player_status \{player = 3}
	fix_deleted_character_player_status \{player = 4}
endscript

script fix_deleted_character_player_status 
	<player_status> = ($player_status_array [<player>])
	get_savegame_from_player_status player_status = <player_status>
	if NOT profile_exists id = ($<player_status>.character_id) savegame = <savegame>
		change structurename = <player_status> character_id = judy
	endif
endscript

script ui_get_controller_parts_allowed 

	if (($allow_controller_for_all_instruments) = 0)
		allowed = {}
		if IsGuitarController controller = <controller>
			allowed = {guitar Bass}
		elseif IsDrumController controller = <controller>
			allowed = {drum}
		elseif IsMicrophonePluggedIn
			allowed = {Vocals}
		endif
	else
		allowed = {guitar Bass drum Vocals}
		if IsGuitarController controller = <controller>
			allowed = {guitar Bass}
		elseif IsDrumController controller = <controller>
			allowed = {drum}
		elseif IsMicrophonePluggedIn
			allowed = {guitar Bass drum Vocals}
		endif
	endif
	if is_regular_controller controller = <controller>
		if controller_has_headset controller = <controller>
			allowed = {<allowed> Vocals}
		endif
	endif
	if GotParam \{filter_by_character}
		filter_allowed_parts_by_character_type allowed = <allowed> controller = <controller>
	endif
	return allowed = <allowed>
endscript

script get_controller_part 

	if IsGuitarController controller = <controller>
		return \{controller_part = guitar}
	elseif IsDrumController controller = <controller>
		return \{controller_part = drum}
	else
		return \{controller_part = Vocals}
	endif
endscript

script ui_band_mode_highlight_motion 
	if Desc_ResolveAlias \{name = alias_highlight}
		if GetScreenElementChildren id = <resolved_id>
			GetArraySize <children>
			prev = 0
			curr = 1
			begin
			prev_id = (<children> [<prev>])
			curr_id = (<children> [<curr>])
			<prev_id> :SE_SetProps alpha = 0.0
			<curr_id> :SE_SetProps alpha = 1
			prev = <curr>
			next = RandomInteger (0.0, 2.0)
			if (<next> = <prev>)
				curr = (<curr> + 1)
			else
				curr = <next>
			endif
			if (<curr> >= <array_size>)
				curr = 0
			endif
			rand = Random (@ 0 @ 1 )
			if (<rand> = 1)
				<curr_id> :SE_SetProps flip_v = true
			else
				<curr_id> :SE_SetProps flip_v = false
			endif
			rand = Random (@ 0 @ 1 )
			if (<rand> = 1)
				<curr_id> :SE_SetProps flip_h = true
			else
				<curr_id> :SE_SetProps flip_h = false
			endif
			Wait \{0.1
				second}
			repeat
		endif
	endif
endscript

script ui_band_mode_focus \{offset = (0.0, 34.0)
		start_pos = (0.0, -120.0)}
	retail_menu_focus
	Obj_GetID
	<ObjID> :SE_GetParentId
	<parent_id> :GetTags
	MyInterfaceElement :GetTags
	if GotParam \{descs}
		current_desc = (<descs> [<index>])
		if <current_desc> :Desc_ResolveAlias name = alias_highlight
			GetScreenElementDims id = <ObjID>
			scale = (((0.9, 0.0) * (((<width> + 100.0) / 256.0))) + (0.0, 1.0))
			screenelementpos = (<start_pos> + (<offset> * <tag_selected_index>))
			<resolved_id> :SE_SetProps pos = <screenelementpos> scale = <scale>
			<resolved_id> :SE_WaitProps
			<resolved_id> :SE_SetProps pos = (<screenelementpos> + (0.0, -10.0)) time = 0.05
			<resolved_id> :SE_WaitProps
			<resolved_id> :SE_SetProps pos = <screenelementpos> scale = <scale> time = 0.05
			<resolved_id> :SE_WaitProps
		endif
	endif
endscript
