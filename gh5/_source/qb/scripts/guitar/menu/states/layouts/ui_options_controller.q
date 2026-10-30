
script ui_create_options_controller 
	ui_options_get_controller_type
	make_menu_frontend \{screen = guitarist
		title = qs(0x8627f83e)}
	menu_finish
endscript

script ui_destroy_options_controller 
	generic_ui_destroy
endscript

script ui_options_controller_choose_lefty_flip \{popup = 0
		player_device = $primary_controller}
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	player = 1
	i = 1
	begin
	getplayerinfo <i> controller
	if (<controller> = <player_device>)
		player = <i>
		break
	endif
	i = (<i> + 1)
	repeat ($current_num_players)
	if (<popup>)
		generic_event_choose state = uistate_pausemenu_lefty_flip_warning data = {player = <player>}
	else
		gettags
		obj_getid
		0x978e7147 player = <player>
		if (<new_flip> = 0)
			soundevent \{event = checkbox_sfx}
			<objid> :se_setprops check_alpha = 0
			<objid> :se_setprops cross_alpha = 1
		else
			soundevent \{event = checkbox_check_sfx}
			<objid> :se_setprops check_alpha = 1
			<objid> :se_setprops cross_alpha = 0
		endif
		setglobaltags savegame = <savegame> user_options params = {lefty_flip_save = <new_flip>}
	endif
endscript
