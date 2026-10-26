
script get_player_num_from_controller 
	if NOT GotParam \{controller_index}

	endif
	num_local_controllers = 4
	player_num = -1
	i = 1
	begin
	GetPlayerInfo <i> controller
	if (<controller_index> = <controller>)
		player_num = <i>
		break
	endif
	i = (<i> + 1)
	repeat <num_local_controllers>
	if ($vocalist_using_guitar = 1)
		if (<player_num> = -1)
			player_num = (<controller_index> + 1)
		endif
		if (<player_num> = ($vocalist_controlling_menu + 1))
			<player_num> = ($band_mode_vocalist_menu + 1)
		elseif (<player_num> = ($band_mode_vocalist_menu + 1))
			<player_num> = ($vocalist_controlling_menu + 1)
		endif
	endif
	return player_num = <player_num>
endscript

script begin_singleplayer_game 
	if ($is_network_game = 1)
		if IsHost
			if NetSessionFunc \{obj = session
					func = has_active_session}
				NetSessionFunc \{obj = session
					func = begin_singleplayer_game}
			endif
		endif
	else
		if NetSessionFunc \{obj = session
				func = has_active_session}
			NetSessionFunc \{obj = session
				func = begin_singleplayer_game}
		endif
	endif
endscript

script end_singleplayer_game 
	if NetSessionFunc \{obj = session
			func = has_active_session}
		NetSessionFunc \{obj = session
			func = end_singleplayer_game}
	endif
endscript

script get_controller_type 
	if NOT GotParam \{controller_index}
		return \{controller_type = controller}
	endif
	GetControllerType controller = <controller_index>
	return controller_type = <controller_type>
endscript

script scale_element_to_size \{time = 0}
	if NOT GotParam \{id}

		return
	endif
	GetScreenElementDims id = <id>
	orig_height = <Height>
	orig_width = <width>
	if NOT GotParam \{target_width}
		target_width = <orig_width>
	endif
	if NOT GotParam \{target_height}
		target_height = <orig_height>
	endif
	xScale = (<target_width> / (<orig_width> * 1.0))
	yScale = (<target_height> / (<orig_height> * 1.0))
	<id> :LegacyDoMorph scale = (<xScale> * (1.0, 0.0) + <yScale> * (0.0, 1.0)) time = <time>
endscript
