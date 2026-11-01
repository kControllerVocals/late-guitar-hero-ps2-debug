
script ui_create_double_bass_popup 
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs(0x182f0173)
		button = green
		z = 100000}
	createscreenelement \{type = descinterface
		desc = 'setlist_b_db_pop'
		parent = root_window
		id = double_bass_popup
		event_handlers = [
			{
				pad_choose
				ui_setlist_go_back
			}
		]}
	spawnscriptnow \{ui_double_bass_wait_and_focus}
endscript

script ui_double_bass_wait_and_focus 
	wait \{2
		gameframes}
	launchevent \{type = focus
		target = double_bass_popup}
	setlist_menu :se_setprops \{block_events}
endscript

script ui_destroy_double_bass_popup 
	if screenelementexists \{id = double_bass_popup}
		destroyscreenelement \{id = double_bass_popup}
	endif
	setlist_menu :se_setprops \{unblock_events}
endscript
