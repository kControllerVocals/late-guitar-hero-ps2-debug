
script ui_create_double_bass_popup 
	CreateScreenElement \{type = DescInterface
		desc = 'setlist_b_db_pop'
		parent = root_window
		id = double_bass_popup
		event_handlers = [
			{
				pad_choose
				ui_setlist_go_back
			}
		]}
	SoundEvent \{event = Enter_Band_Name_Finish}
	spawnscriptnow \{destroy_songpreview}
	spawnscriptnow \{ui_double_bass_wait_and_focus}
endscript

script ui_double_bass_wait_and_focus 
	Wait \{2
		gameframes}
	LaunchEvent \{type = focus
		target = double_bass_popup}
	setlist_menu :SE_SetProps \{block_events}
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs("CONTINUE")
		button = green
		z = 100000}
endscript

script ui_destroy_double_bass_popup 
	if ScreenElementExists \{id = double_bass_popup}
		DestroyScreenElement \{id = double_bass_popup}
	endif
	setlist_menu :SE_SetProps \{unblock_events}
	spawnscriptnow \{create_songpreview}
endscript
