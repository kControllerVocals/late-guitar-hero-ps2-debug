
script menu_choose_band_make_selection 
	if gotparam \{from_band_ui}
		if (<from_band_ui> = 1)
			create_loading_screen
			wait \{3
				gameframes}
		endif
	endif
	if gotparam \{0x91dab06d}
		assign_new_primary_controller device_num = <device_num>
	endif
	get_savegame_from_controller controller = <device_num>
	if gotparam \{band_index}
		change current_band = <band_index>
	endif
	get_current_band_info
	getglobaltags <band_info> param = name savegame = <savegame>
	if gotparam \{from_band_ui}
		cancel_all_cas_loads \{kill}
		cas_queue_block
	endif
	if (<name> = qs(0x03ac90f0))
		generic_event_choose \{state = uistate_band_name_logo
			data = {
				from_boot
				skip_destroy
			}}
	else
		cas_update_band_logo
		if gotparam \{from_options}
			generic_event_choose \{no_sound
				state = uistate_band_name_logo
				data = {
					from_band_info = 1
				}}
			if gotparam \{band_info}
				soundevent \{0x5ea1b4e0}
			elseif gotparam \{band_index}
				soundevent \{0x5ea1b4e0}
			endif
		else
			generic_event_choose \{state = uistate_game_mode}
		endif
	endif
endscript
