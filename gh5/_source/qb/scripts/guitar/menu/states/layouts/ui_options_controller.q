
script ui_create_options_controller 
	ui_options_get_controller_type
	make_menu_frontend \{screen = Guitarist
		title = qs("Controller Settings")}
	menu_finish
endscript

script ui_destroy_options_controller 
	generic_ui_destroy
endscript

script ui_options_controller_choose_lefty_flip \{popup = 0
		player_device = $primary_controller}
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	player = 1
	i = 1
	begin
	GetPlayerInfo <i> controller
	if (<controller> = <player_device>)
		player = <i>
		break
	endif
	i = (<i> + 1)
	repeat ($current_num_players)
	if (<popup>)
		generic_event_choose state = uistate_pausemenu_lefty_flip_warning data = {player = <player>}
	else
		GetTags
		Obj_GetID
		toggle_lefty_flip player = <player>
		if (<new_flip> = 0)
			SoundEvent \{event = checkbox_sfx}
			<ObjID> :SE_SetProps check_alpha = 0
			<ObjID> :SE_SetProps cross_alpha = 1
		else
			SoundEvent \{event = CheckBox_Check_SFX}
			<ObjID> :SE_SetProps check_alpha = 1
			<ObjID> :SE_SetProps cross_alpha = 0
		endif
		SetGlobalTags savegame = <savegame> user_options params = {lefty_flip_save = <new_flip>}
	endif
endscript
