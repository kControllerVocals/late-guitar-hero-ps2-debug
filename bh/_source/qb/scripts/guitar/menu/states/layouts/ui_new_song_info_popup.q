
script ui_create_new_song_info_popup 
	CreateScreenElement \{type = DescInterface
		desc = 'setlist_b_extras_pop'
		parent = root_window
		id = new_song_info_popup
		event_handlers = [
			{
				pad_choose
				setlist_prompt_continue
			}
		]}
	SoundEvent \{event = Enter_Band_Name_Finish}
	spawnscriptnow \{destroy_songpreview}
	spawnscriptnow \{ui_new_song_info_wait_and_focus}
endscript

script ui_new_song_info_wait_and_focus 
	LaunchEvent \{type = focus
		target = new_song_info_popup}
	setlist_menu :SE_SetProps \{block_events}
	Wait \{2
		gameframes}
	SetButtonEventMappings \{unblock_menu_input}
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs("CONTINUE")
		button = green
		z = 100000}
endscript

script ui_destroy_new_song_info_popup 
	if ScreenElementExists \{id = new_song_info_popup}
		DestroyScreenElement \{id = new_song_info_popup}
	endif
	setlist_menu :SE_SetProps \{unblock_events}
	spawnscriptnow \{create_songpreview}
endscript
