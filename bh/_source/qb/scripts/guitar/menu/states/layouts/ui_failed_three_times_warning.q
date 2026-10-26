
script ui_create_failed_three_times_warning 
	SoundEvent \{event = Fail_Screen_SFX}
	SoundEvent \{event = Menu_Warning_SFX_softer}
	disable_pause
	if NOT GotParam \{controller}
		<controller> = $primary_controller
	endif
	create_dialog_box {
		body_text = qs("Failed 3 times in a row.")
		player_device = <controller>
		no_background
		options = [
			{
				func = failed_3_times_retry
				text = qs("Retry")
				screenelementprops = {menurow_txt_item_dims = (800.0, 50.0) menurow_just = [center center] menurow_internal_just = [center centeer]}
			}
			{
				func = failed_3_times_skip_never_pass
				text = qs("Skip Song - I Will never be able to pass")
				screenelementprops = {menurow_txt_item_dims = (800.0, 50.0) menurow_just = [center center] menurow_internal_just = [center centeer]}
				focus_script_params = {grow_scale = 1.0}
			}
			{
				func = failed_3_times_skip_maybe_pass
				text = qs("Skip Song - I Can probably pass with practice")
				screenelementprops = {menurow_txt_item_dims = (800.0, 50.0) menurow_just = [center center] menurow_internal_just = [center centeer]}
				focus_script_params = {grow_scale = 1.0}
			}
		]
	}
endscript

script ui_destroy_failed_three_times_warning 
	destroy_dialog_box
	enable_pause
endscript

script failed_3_times_skip_never_pass 
	if isXenon
		if NOT ($current_song = jamsession)
			WriteSongDataToFile \{failed = 1
				failed_3_times_option_chose = qs("\LNP")}
		endif
	endif
	failed_3_times_skip
endscript

script failed_3_times_skip_maybe_pass 
	if isXenon
		if NOT ($current_song = jamsession)
			WriteSongDataToFile \{failed = 1
				failed_3_times_option_chose = qs("\LCP")}
		endif
	endif
	failed_3_times_skip
endscript

script failed_3_times_skip 
	GameMode_GetType
	if (<type> = quickplay)
		quickplay_skip_song
	elseif (<type> = career)
		generic_event_back \{state = uistate_gig_posters}
	endif
endscript

script failed_3_times_retry 
	if isXenon
		if NOT ($current_song = jamsession)
			WriteSongDataToFile \{failed = 1}
		endif
	endif
	fail_song_menu_select_retry_song
endscript
