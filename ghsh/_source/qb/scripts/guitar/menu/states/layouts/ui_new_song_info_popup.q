
script ui_create_new_song_info_popup 
	player = (($primary_controller) + 1)
	if (<player> > 4)
		part = drum
	else
		getplayerinfo <player> part
	endif
	0x91e66f17 = qs(0x64f07d44)

	if (<part> = vocals)
		0x91e66f17 = qs(0xe368618b)
	elseif (<part> = drum)
		0x91e66f17 = qs(0x8704a48f)
	elseif (<part> = guitar)
		0x91e66f17 = qs(0xbb0b71dd)
	elseif (<part> = bass)
		0x91e66f17 = qs(0xbb0b71dd)
	endif
	formattext textname = popup_text qs(0x4248dd06) a = <0x91e66f17>
	createscreenelement {
		type = descinterface
		desc = 'setlist_b_extras_pop'
		parent = root_window
		id = new_song_info_popup
		event_handlers = [
			{pad_choose setlist_prompt_continue}
		]
		0x7b8f8efa = <popup_text>
	}
	soundevent \{event = enter_band_name_finish}
	spawnscriptnow \{0xb20ce9b6}
	spawnscriptnow \{ui_new_song_info_wait_and_focus}
endscript

script ui_new_song_info_wait_and_focus 
	launchevent \{type = focus
		target = new_song_info_popup}
	setlist_menu :se_setprops \{block_events}
	wait \{2
		gameframes}
	setbuttoneventmappings \{unblock_menu_input}
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs(0x182f0173)
		button = green
		z = 100000}
endscript

script ui_destroy_new_song_info_popup 
	if screenelementexists \{id = new_song_info_popup}
		destroyscreenelement \{id = new_song_info_popup}
	endif
	setlist_menu :se_setprops \{unblock_events}
	spawnscriptnow \{0x1e464d15}
endscript
