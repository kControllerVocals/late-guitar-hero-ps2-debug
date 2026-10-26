
script menu_choose_band_make_selection 
	if GotParam \{from_band_ui}
		if (<from_band_ui> = 1)
			create_loading_screen
			Wait \{3
				gameframes}
		endif
	endif
	if GotParam \{assign_new_primary}
		assign_new_primary_controller device_num = <device_num>
	endif
	get_savegame_from_controller controller = <device_num>
	if GotParam \{band_index}
		change current_band = <band_index>
	endif
	get_current_band_info
	GetGlobalTags <band_info> param = name savegame = <savegame>
	if GotParam \{from_band_ui}
		cancel_all_cas_loads \{kill}
		cas_queue_block
	endif
	if (<name> = qs("\L"))
		generic_event_choose \{state = uistate_band_name_logo
			data = {
				from_boot
				skip_destroy
			}}
	else
		cas_update_band_logo
		if GotParam \{from_options}
			generic_event_choose \{no_sound
				state = uistate_band_name_logo
				data = {
					from_band_info = 1
				}}
			if GotParam \{band_info}
				SoundEvent \{Generic_Menu_Select_SFX}
			elseif GotParam \{band_index}
				SoundEvent \{Generic_Menu_Select_SFX}
			endif
		else
			generic_event_choose \{state = uistate_game_mode}
		endif
	endif
endscript
