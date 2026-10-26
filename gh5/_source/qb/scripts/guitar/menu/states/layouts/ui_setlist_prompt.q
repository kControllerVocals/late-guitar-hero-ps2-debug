
script ui_create_setlist_prompt 
	CreateScreenElement \{type = DescInterface
		desc = 'setlist_b_set_pop'
		parent = root_window
		id = set_popup
		event_handlers = [
			{
				pad_choose
				setlist_prompt_continue
			}
		]}
	SoundEvent \{event = Enter_Band_Name_Finish}
	spawnscriptnow \{destroy_songpreview}
	spawnscriptnow \{ui_set_popup_wait_and_focus}
endscript

script ui_set_popup_wait_and_focus 
	Wait \{2
		gameframes}
	LaunchEvent \{type = focus
		target = set_popup}
	setlist_menu :SE_SetProps \{block_events}
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs("CONTINUE")
		button = green
		z = 100000
		all_buttons}
endscript

script ui_destroy_setlist_prompt 
	if ScreenElementExists \{id = set_popup}
		DestroyScreenElement \{id = set_popup}
	endif
	setlist_menu :SE_SetProps \{unblock_events}
	spawnscriptnow \{create_songpreview}
endscript

script setlist_prompt_continue 
	SE_SetProps \{block_events}
	get_current_band_info
	GetGlobalTags <band_info>
	show_doublekick = 0
	i = 1
	begin
	GetPlayerInfo <i> controller
	GetPlayerInfo <i> part
	if IsDrumController controller = <controller>
		part = drum
	endif
	if (<part> = drum)
		GameMode_GetType
		if (<type> = career)
			GetPlayerInfo <i> double_kick_drum
			show_doublekick = <double_kick_drum>
		else
			show_doublekick = 1
		endif
		break
	endif
	i = (<i> + 1)
	repeat ($current_num_players)
	if (<show_doublekick> = 1)
		GetGlobalTags <band_info> params = {first_setlist_drum}
		if (<first_setlist_drum> = 1 && (<first_career_setlist> = 0 || <first_quickplay_setlist> = 0))
			change \{ui_gig_posters_skip_helpers = 1}
			generic_event_replace \{state = UIstate_double_bass_popup
				data = {
					is_popup
				}}
			SetGlobalTags <band_info> params = {first_setlist_drum = 0}
			return
		endif
	endif
	ui_setlist_go_back
endscript
