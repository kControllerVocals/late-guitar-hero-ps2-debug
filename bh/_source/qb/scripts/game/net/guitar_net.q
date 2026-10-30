
script get_player_num_from_controller 
	if NOT gotparam \{controller_index}

	endif
	num_local_controllers = 4
	player_num = -1
	i = 1
	begin
	getplayerinfo <i> controller
	if (<controller_index> = <controller>)
		player_num = <i>
		break
	endif
	i = (<i> + 1)
	repeat <num_local_controllers>
	if ($0xa53d906e = 1)
		if (<player_num> = -1)
			player_num = (<controller_index> + 1)
		endif
		if (<player_num> = ($0x81bfdc7e + 1))
			<player_num> = ($0xdb92eeef + 1)
		elseif (<player_num> = ($0xdb92eeef + 1))
			<player_num> = ($0x81bfdc7e + 1)
		endif
	endif
	return player_num = <player_num>
endscript

script begin_singleplayer_game 
	if ($is_network_game = 1)
		if ishost
			if netsessionfunc \{obj = session
					func = has_active_session}
				netsessionfunc \{obj = session
					func = begin_singleplayer_game}
			endif
		endif
	else
		if netsessionfunc \{obj = session
				func = has_active_session}
			netsessionfunc \{obj = session
				func = begin_singleplayer_game}
		endif
	endif
endscript

script end_singleplayer_game 
	if netsessionfunc \{obj = session
			func = has_active_session}
		netsessionfunc \{obj = session
			func = end_singleplayer_game}
	endif
endscript

script get_controller_type 
	if NOT gotparam \{controller_index}
		return \{controller_type = controller}
	endif
	getcontrollertype controller = <controller_index>
	return controller_type = <controller_type>
endscript

script scale_element_to_size \{time = 0}
	if NOT gotparam \{id}

		return
	endif
	getscreenelementdims id = <id>
	orig_height = <height>
	orig_width = <width>
	if NOT gotparam \{target_width}
		target_width = <orig_width>
	endif
	if NOT gotparam \{target_height}
		target_height = <orig_height>
	endif
	xscale = (<target_width> / (<orig_width> * 1.0))
	yscale = (<target_height> / (<orig_height> * 1.0))
	<id> :legacydomorph scale = (<xscale> * (1.0, 0.0) + <yscale> * (0.0, 1.0)) time = <time>
endscript
