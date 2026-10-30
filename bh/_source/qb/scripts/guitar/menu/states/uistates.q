
script registeruistates 

	mempushcontext \{frontendheap}
	registerstate \{name = uistate_null
		task = {
			name = task_menu
			params = {
				base_name = 'null'
			}
		}}
	registeruistates_boot
	registeruistates_options
	registeruistates_frontend
	registeruistates_debug
	registeruistates_profile
	registeruistates_career
	registeruistates_outro
	registeruistates_character
	registeruistates_pause
	registeruistates_practice
	registeruistates_jam
	registeruistates_select_rocker
	registeruistates_outfit
	registeruistates_cap
	registeruistates_cag
	registeruistates_online
	registeruistates_cadrm
	registerstate \{name = uistate_sing_a_long
		task = {
			name = task_menu
			params = {
				base_name = 'sing_a_long'
			}
		}}
	mempopcontext
endscript

script registeruistates_boot 
	registerstate \{name = uistate_boot_legal
		task = {
			name = task_menu
			params = {
				base_name = 'boot_legal'
			}
		}}
	registerstate \{name = uistate_boot_movie_atvi
		task = {
			name = task_menu
			params = {
				base_name = 'boot_movie_ATVI'
			}
		}}
	registerstate \{name = uistate_boot_movie_red_octane
		task = {
			name = task_menu
			params = {
				base_name = 'boot_movie_red_octane'
			}
		}}
	registerstate \{name = uistate_boot_movie_neversoft
		task = {
			name = task_menu
			params = {
				base_name = 'boot_movie_neversoft'
			}
		}}
	registerstate \{name = 0x54fc36ed
		task = {
			name = task_menu
			params = {
				base_name = 'boot_movie_budcat'
			}
		}}
	registerstate \{name = uistate_boot_movie_intro
		task = {
			name = task_menu
			params = {
				base_name = 'boot_movie_intro'
			}
		}}
	registerstate \{name = uistate_boot_iis
		task = {
			name = task_menu
			params = {
				base_name = 'boot_iis'
				do_not_hide
			}
		}}
	registerstate \{name = uistate_boot_attract
		task = {
			name = task_menu
			params = {
				base_name = 'boot_attract'
				0x1a6af6b1 = full
				0x38d47d6e = full
			}
		}}
	registerstate \{name = uistate_boot_guitar
		task = {
			name = task_menu
			params = {
				base_name = 'boot_guitar'
			}
		}}
	registerstate \{name = uistate_boot_download_scan
		task = {
			name = task_menu
			params = {
				base_name = 'boot_download_scan'
			}
		}}
endscript

script registeruistates_profile 
	registerstate \{name = uistate_signin
		task = {
			name = task_menu
			params = {
				base_name = 'signin'
			}
		}}
	registerstate \{name = uistate_signin_warning
		task = {
			name = task_menu
			params = {
				base_name = 'signin_warning'
			}
		}}
	registerstate \{name = uistate_signin_complete
		task = {
			name = task_menu
			params = {
				base_name = 'signin_complete'
			}
		}}
	registerstate \{name = uistate_memcard
		task = {
			name = task_menu
			params = {
				base_name = 'memcard'
				type = boot
			}
		}}
	registerstate \{name = uistate_signin_changed
		task = {
			name = task_menu
			params = {
				base_name = 'signin_changed'
			}
		}}
	registerstate \{name = uistate_connection_loss
		task = {
			name = task_menu
			params = {
				base_name = 'connection_loss'
			}
		}}
endscript

script registeruistates_frontend 
	registerstate \{name = uistate_mainmenu
		task = {
			name = task_menu
			params = {
				base_name = 'mainmenu'
			}
		}}
	registerstate \{name = uistate_mainmenu_intro
		task = {
			name = task_menu
			params = {
				base_name = 'mainmenu_intro'
			}
		}}
	registerstate \{name = uistate_motd
		task = {
			name = task_menu
			params = {
				base_name = 'motd'
				pakname = 'motd'
			}
		}}
	registerstate \{name = uistate_select_difficulty
		task = {
			name = task_menu
			params = {
				base_name = 'select_difficulty'
				anim_in_script = ui_select_difficulty_anim_in
				anim_out_script = ui_select_difficulty_anim_out
			}
		}}
	registerstate \{name = uistate_band_difficulty
		task = {
			name = task_menu
			params = {
				base_name = 'band_difficulty'
				pakname = 'band_mode'
			}
		}}
	registerstate \{name = uistate_setlist
		task = {
			name = task_menu
			params = {
				base_name = 'setlist'
				pakname = 'setlist'
				focus_id = none
				0x1a6af6b1 = full
			}
		}}
	registerstate \{name = uistate_setlist_prompt
		task = {
			name = task_menu
			params = {
				base_name = 'setlist_prompt'
			}
		}}
	registerstate \{name = uistate_select_instrument_warning
		task = {
			name = task_menu
			params = {
				base_name = 'select_instrument_warning'
			}
		}}
	registerstate \{name = uistate_setlist_quit_warning
		task = {
			name = task_menu
			params = {
				base_name = 'setlist_quit_warning'
			}
		}}
	registerstate \{name = uistate_generic_dialogue
		task = {
			name = task_menu
			params = {
				base_name = 'generic_dialogue'
				focus_id = dialog_box_vmenu
			}
		}}
	registerstate \{name = uistate_generic_alert_popup
		task = {
			name = task_menu
			params = {
				base_name = 'generic_alert_popup'
				focus_id = dialog_box_vmenu
			}
		}}
	registerstate \{name = uistate_helper_dialogue
		task = {
			name = task_menu
			params = {
				base_name = 'helper_dialogue'
				focus_id = helper_root
			}
		}}
	registerstate \{name = uistate_dialog_box
		task = {
			name = task_menu
			params = {
				base_name = 'dialog_box'
			}
		}}
	registerstate \{name = uistate_double_bass_popup
		task = {
			name = task_menu
			params = {
				base_name = 'double_bass_popup'
			}
		}}
	registerstate \{name = uistate_new_song_info_popup
		task = {
			name = task_menu
			params = {
				base_name = 'new_song_info_popup'
			}
		}}
	registerstate \{name = uistate_soundboard
		task = {
			name = task_menu
			params = {
				base_name = 'soundboard'
				pakname = 'soundboard'
			}
		}}
	registerstate \{name = uistate_song_extras
		task = {
			name = task_menu
			params = {
				base_name = 'song_extras'
				pakname = 'setlist'
			}
		}}
endscript

script registeruistates_options 
	registerstate \{name = uistate_options
		task = {
			name = task_menu
			params = {
				base_name = 'options'
				pakname = 'options'
				anim_in_script = ui_options_anim_in
				anim_out_script = ui_options_anim_out
			}
		}}
	registerstate \{name = uistate_options_audio
		task = {
			name = task_menu
			params = {
				base_name = 'options_audio'
				pakname = 'options_audio'
			}
		}}
	registerstate \{name = uistate_options_calibrate_lag
		task = {
			name = task_menu
			params = {
				base_name = 'options_calibrate_lag'
				pakname = 'options_calibrate_lag'
			}
		}}
	registerstate \{name = uistate_options_calibrate_lag_warning
		task = {
			name = task_menu
			params = {
				base_name = 'options_calibrate_lag_warning'
				pakname = 'options_calibrate_lag_warning'
			}
		}}
	registerstate \{name = uistate_failed_three_times_warning
		task = {
			name = task_menu
			params = {
				base_name = 'failed_three_times_warning'
			}
		}}
	registerstate \{name = uistate_options_controller
		task = {
			name = task_menu
			params = {
				base_name = 'options_controller'
			}
		}}
	registerstate \{name = uistate_options_controller_whammy
		task = {
			name = task_menu
			params = {
				base_name = 'options_controller_whammy'
			}
		}}
	registerstate \{name = uistate_bonus_videos
		task = {
			name = task_menu
			params = {
				base_name = 'bonus_videos'
				pakname = 'bonus_videos'
				anim_in_script = ui_bonus_videos_anim_in
				anim_out_script = ui_bonus_videos_anim_out
			}
		}}
	registerstate \{name = uistate_gallery
		task = {
			name = task_menu
			params = {
				base_name = 'gallery'
				anim_in_script = ui_gallery_anim_in
				anim_out_script = ui_gallery_anim_out
			}
		}}
	registerstate \{name = uistate_bonus_videos_credits
		task = {
			name = task_menu
			params = {
				base_name = 'bonus_videos_credits'
				pakname = 'bonus_videos_credits'
			}
		}}
	registerstate \{name = uistate_options_cheats
		task = {
			name = task_menu
			params = {
				base_name = 'options_cheats'
				pakname = 'options_cheats'
				anim_out_script = ui_options_cheats_anim_out
			}
		}}
	registerstate \{name = uistate_options_cheats_new
		task = {
			name = task_menu
			params = {
				base_name = 'options_cheats_new'
				pakname = 'options_cheats_new'
				anim_out_script = ui_options_cheats_new_anim_out
			}
		}}
	registerstate \{name = uistate_options_cheats_warning
		task = {
			name = task_menu
			params = {
				base_name = 'options_cheats_warning'
			}
		}}
	registerstate \{name = uistate_top_rockers_mode
		task = {
			name = task_menu
			params = {
				base_name = 'top_rockers_mode'
			}
		}}
	registerstate \{name = uistate_options_data
		task = {
			name = task_menu
			params = {
				base_name = 'options_data'
				focus_id = current_submenu
			}
		}}
	registerstate \{name = uistate_options_data_delete
		task = {
			name = task_menu
			params = {
				base_name = 'options_data_delete'
			}
		}}
	registerstate \{name = uistate_options_manage_band
		task = {
			name = task_menu
			params = {
				base_name = 'options_manage_band'
			}
		}}
	registerstate \{name = uistate_options_manage_band_logo
		task = {
			name = task_menu
			params = {
				base_name = 'options_manage_band_logo'
				no_animate_in
			}
		}}
	registerstate \{name = uistate_options_delete_band
		task = {
			name = task_menu
			params = {
				base_name = 'options_delete_band'
			}
		}}
	registerstate \{name = uistate_options_controller_star_power
		task = {
			name = task_menu
			params = {
				base_name = 'options_controller_star_power'
			}
		}}
	registerstate \{name = uistate_options_settings
		task = {
			name = task_menu
			params = {
				base_name = 'options_settings'
				focus_id = current_submenu
			}
		}}
	registerstate \{name = uistate_options_settings_lefty_warning
		task = {
			name = task_menu
			params = {
				base_name = 'options_settings_lefty_warning'
				focus_id = dialog_box_vmenu
			}
		}}
	registerstate \{name = uistate_options_calibrate
		task = {
			name = task_menu
			params = {
				base_name = 'options_calibrate'
			}
		}}
	registerstate \{name = uistate_options_manage_band_font
		task = {
			name = task_menu
			params = {
				base_name = 'options_manage_band_font'
				focus_id = current_list_menu
			}
		}}
	registerstate \{name = uistate_band_logo_choose
		task = {
			name = task_menu
			params = {
				base_name = 'band_logo_choose'
			}
		}}
	registerstate \{name = uistate_band_name_logo
		task = {
			name = task_menu
			params = {
				base_name = 'band_name_logo'
				focus_id = band_name_menu
			}
		}}
	registerstate \{name = uistate_downloads
		task = {
			name = task_menu
			params = {
				base_name = 'downloads'
			}
		}}
	registerstate \{name = uistate_options_vocals_view_warning
		task = {
			name = task_menu
			params = {
				base_name = 'options_vocals_view_warning'
			}
		}}
	registerstate \{name = uistate_guitarhero_com
		task = {
			name = task_menu
			params = {
				base_name = 'guitarhero_com'
				pakname = 'guitarhero_com'
			}
		}}
	registerstate \{name = 0x1e965d1c
		task = {
			name = task_menu
			params = {
				base_name = 'progressive_scan_warning'
				focus_id = dialog_box_vmenu
			}
		}}
endscript

script registeruistates_debug 
	registerstate \{name = uistate_debug
		task = {
			name = task_menu
			params = {
				base_name = 'debug'
			}
		}}
	registerstate \{name = uistate_debug_color_calibration
		task = {
			name = task_menu
			params = {
				base_name = 'debug_color_calibration'
			}
		}}
	registerstate \{name = uistate_viewport_test
		task = {
			name = task_menu
			params = {
				base_name = 'viewport_test'
			}
		}}
	registerstate \{name = uistate_atom_unlock
		task = {
			name = task_menu
			params = {
				base_name = 'atom_unlock'
			}
		}}
	registerstate \{name = uistate_test
		task = {
			name = task_menu
			params = {
				base_name = 'test'
				pakname = 'testpak'
			}
		}}
	registerstate \{name = uistate_autotest_next_test
		task = {
			name = task_menu
			params = {
				base_name = 'autotest_next_test'
			}
		}}
endscript

script registeruistates_career 
	registerstate \{name = uistate_play_song
		task = {
			name = task_menu
			params = {
				base_name = 'play_song'
				0x1a6af6b1 = full
				0x38d47d6e = full
			}
		}}
	registerstate \{name = uistate_gameplay
		task = {
			name = task_menu
			params = {
				base_name = 'gameplay'
				0x1a6af6b1 = sustain
				0x38d47d6e = freeze
			}
		}}
	registerstate \{name = uistate_game_mode
		task = {
			name = task_menu
			params = {
				base_name = 'game_mode'
				anim_in_script = game_mode_anim_in
				anim_out_script = game_mode_anim_out
			}
		}}
	registerstate \{name = uistate_select_instrument
		task = {
			name = task_menu
			params = {
				base_name = 'select_instrument'
				anim_in_script = select_instrument_anim_in
				anim_out_script = select_instrument_anim_out
			}
		}}
	registerstate \{name = uistate_band_name_enter
		task = {
			name = task_menu
			params = {
				base_name = 'band_name_enter'
			}
		}}
	registerstate \{name = uistate_band_choose
		task = {
			name = task_menu
			params = {
				base_name = 'band_choose'
			}
		}}
	registerstate \{name = uistate_select_controller
		task = {
			name = task_menu
			params = {
				base_name = 'select_controller'
				pakname = 'select_controller'
			}
			anim_in_script = ui_select_controller_anim_in
			anim_out_script = ui_select_controller_anim_out
		}}
	registerstate \{name = uistate_select_mp_mode
		task = {
			name = task_menu
			params = {
				base_name = 'select_mp_mode'
			}
		}}
	registerstate \{name = uistate_fail_song
		task = {
			name = task_menu
			params = {
				base_name = 'fail_song'
				pakname = 'fail_song'
			}
		}}
	registerstate \{name = uistate_band_mode
		task = {
			name = task_menu
			params = {
				base_name = 'band_mode'
				focus_id = band_mode_menu
				pakname = 'band_mode'
			}
		}}
	registerstate \{name = uistate_choose_part
		task = {
			name = task_menu
			params = {
				base_name = 'choose_part'
			}
		}}
	registerstate \{name = uistate_controller_disconnect
		task = {
			name = task_menu
			params = {
				base_name = 'controller_disconnect'
			}
		}}
	registerstate \{name = uistate_encore_confirmation
		task = {
			name = task_menu
			params = {
				base_name = 'encore_confirmation'
			}
		}}
	registerstate \{name = uistate_beat_game
		task = {
			name = task_menu
			params = {
				base_name = 'beat_game'
			}
		}}
	registerstate \{name = uistate_gig_posters
		task = {
			name = task_menu
			params = {
				base_name = 'gig_posters'
				focus_id = setlist_menu
			}
		}}
	registerstate \{name = uistate_group_play
		task = {
			name = task_menu
			params = {
				base_name = 'group_play'
				focu_id = group_play
			}
		}}
	registerstate \{name = uistate_song_breakdown
		task = {
			name = task_menu
			params = {
				base_name = 'song_breakdown'
				pakname = 'song_breakdown'
				anim_in_script = ui_song_breakdown_anim_in_script
				anim_out_script = ui_song_breakdown_anim_out_script
			}
		}}
endscript

script registeruistates_character 
	registerstate \{name = uistate_character_hub
		task = {
			name = task_menu
			params = {
				base_name = 'character_hub'
				pakname = 'band_mode'
			}
		}}
	registerstate \{name = uistate_singleplayer_character_hub
		task = {
			name = task_menu
			params = {
				base_name = 'singleplayer_character_hub'
			}
		}}
	registerstate \{name = uistate_character_select
		task = {
			name = task_menu
			params = {
				base_name = 'character_select'
				pakname = 'characterselect'
			}
		}}
	registerstate \{name = uistate_select_outfit
		task = {
			name = task_menu
			params = {
				base_name = 'select_outfit'
			}
		}}
	registerstate \{name = uistate_select_outfit_style
		task = {
			name = task_menu
			params = {
				base_name = 'select_outfit_style'
			}
		}}
	registerstate \{name = uistate_select_guitar
		task = {
			name = task_menu
			params = {
				base_name = 'select_guitar'
			}
		}}
	registerstate \{name = uistate_select_venue
		task = {
			name = task_menu
			params = {
				base_name = 'career_venue_select'
				pakname = 'select_venue'
			}
		}}
endscript

script registeruistates_pause 
	registerstate \{name = uistate_pausemenu
		task = {
			name = task_menu
			params = {
				base_name = 'pausemenu'
				0x1a6af6b1 = sustain
				0x38d47d6e = sustain
			}
		}}
	registerstate \{name = uistate_pause_options
		task = {
			name = task_menu
			params = {
				base_name = 'pause_options'
				0x1a6af6b1 = freeze
				0x38d47d6e = freeze
			}
		}}
	registerstate \{name = uistate_pausemenu_restart_warning
		task = {
			name = task_menu
			params = {
				base_name = 'pausemenu_restart_warning'
			}
		}}
	registerstate \{name = uistate_pausemenu_change_difficulty
		task = {
			name = task_menu
			params = {
				base_name = 'pausemenu_change_difficulty'
			}
		}}
	registerstate \{name = uistate_pausemenu_change_difficulty_warning
		task = {
			name = task_menu
			params = {
				base_name = 'pausemenu_change_difficulty_warning'
			}
		}}
	registerstate \{name = uistate_pausemenu_change_difficulty_confirm
		task = {
			name = task_menu
			params = {
				base_name = 'pausemenu_change_difficulty_confirm'
			}
		}}
	registerstate \{name = uistate_pausemenu_lefty_flip_warning
		task = {
			name = task_menu
			params = {
				base_name = 'pausemenu_lefty_flip_warning'
			}
		}}
	registerstate \{name = uistate_pausemenu_quit_warning
		task = {
			name = task_menu
			params = {
				base_name = 'pausemenu_quit_warning'
			}
		}}
	registerstate \{name = uistate_pausemenu_song_ended
		task = {
			name = task_menu
			params = {
				base_name = 'pausemenu_song_ended'
				pakname = 'fail_song'
			}
		}}
	registerstate \{name = uistate_song_unpause
		task = {
			name = task_menu
			params = {
				base_name = 'song_unpause'
				pakname = 'gameplay'
				0x1a6af6b1 = sustain
				0x38d47d6e = sustain
			}
		}}
endscript

script registeruistates_outro 
	registerstate \{name = uistate_win_song
		task = {
			name = task_menu
			params = {
				base_name = 'win_song'
				pakname = 'win_song'
			}
		}}
	registerstate \{name = uistate_song_statistic
		task = {
			name = task_menu
			params = {
				base_name = 'song_statistic'
				pakname = 'song_statistic'
			}
		}}
	registerstate \{name = uistate_song_summary
		task = {
			name = task_menu
			params = {
				base_name = 'song_summary'
				pakname = 'song_summary'
			}
		}}
	registerstate \{name = uistate_detailed_stats
		task = {
			name = task_menu
			params = {
				base_name = 'detailed_stats'
			}
		}}
	registerstate \{name = uistate_top_rockers
		task = {
			name = task_menu
			params = {
				base_name = 'top_rockers'
				pakname = 'top_rockers'
			}
		}}
	registerstate \{name = uistate_unlock
		task = {
			name = task_menu
			params = {
				base_name = 'unlock'
			}
		}}
	registerstate \{name = uistate_rewards
		task = {
			name = task_menu
			params = {
				base_name = 'rewards'
				pakname = 'rewards'
			}
		}}
	registerstate \{name = uistate_song_summary_details
		task = {
			name = task_menu
			params = {
				base_name = 'song_summary_details'
				pakname = 'song_summary_details'
				anim_in_script = ui_song_summary_details_anim_in
				anim_out_script = ui_song_summary_details_anim_out
			}
		}}
	registerstate \{name = uistate_top_5_rockers
		task = {
			name = task_menu
			params = {
				base_name = 'top_5_rockers'
			}
		}}
endscript

script registeruistates_practice 
	registerstate \{name = uistate_select_practice_mode
		task = {
			name = task_menu
			params = {
				base_name = 'select_practice_mode'
			}
		}}
	registerstate \{name = uistate_select_tutorial
		task = {
			name = task_menu
			params = {
				base_name = 'select_tutorial'
			}
		}}
	registerstate \{name = uistate_play_tutorial
		task = {
			name = task_menu
			params = {
				base_name = 'play_tutorial'
				pakname = 'guitar_tutorials'
				anim_out_script = ui_play_tutorial_anim_out
			}
		}}
	registerstate \{name = 0xffbe0317
		task = {
			name = task_menu
			params = {
				base_name = 'play_tutorial_advanced_techniques'
				anim_out_script = ui_play_tutorial_anim_out
			}
		}}
	registerstate \{name = 0xf0cc6786
		task = {
			name = task_menu
			params = {
				base_name = 'play_tutorial_band'
				anim_out_script = ui_play_tutorial_anim_out
			}
		}}
	registerstate \{name = 0x71c094fe
		task = {
			name = task_menu
			params = {
				base_name = 'play_tutorial_basic'
				anim_out_script = ui_play_tutorial_anim_out
			}
		}}
	registerstate \{name = 0xed3d20c7
		task = {
			name = task_menu
			params = {
				base_name = 'play_tutorial_drum_basic'
				anim_out_script = ui_play_tutorial_anim_out
			}
		}}
	registerstate \{name = 0xd37e5db6
		task = {
			name = task_menu
			params = {
				base_name = 'play_tutorial_drum_int'
				anim_out_script = ui_play_tutorial_anim_out
			}
		}}
	registerstate \{name = 0xedb5b9f0
		task = {
			name = task_menu
			params = {
				base_name = 'play_tutorial_new_features'
				anim_out_script = ui_play_tutorial_anim_out
			}
		}}
	registerstate \{name = 0x09c164d9
		task = {
			name = task_menu
			params = {
				base_name = 'play_tutorial_star_power'
				anim_out_script = ui_play_tutorial_anim_out
			}
		}}
	registerstate \{name = 0x4b2a2d50
		task = {
			name = task_menu
			params = {
				base_name = 'play_tutorial_versus'
				anim_out_script = ui_play_tutorial_anim_out
			}
		}}
	registerstate \{name = uistate_play_tutorial_vocals
		task = {
			name = task_menu
			params = {
				base_name = 'play_tutorial_vocals'
				anim_out_script = ui_play_tutorial_anim_out
			}
		}}
	registerstate \{name = uistate_practice_select_part
		task = {
			name = task_menu
			params = {
				base_name = 'practice_select_part'
			}
		}}
	registerstate \{name = uistate_select_song_section
		task = {
			name = task_menu
			params = {
				base_name = 'select_song_section'
				pakname = 'select_song_section'
			}
		}}
	registerstate \{name = uistate_practice_select_speed
		task = {
			name = task_menu
			params = {
				base_name = 'practice_select_speed'
				anim_in_script = ui_select_difficulty_anim_in
				anim_out_script = ui_select_difficulty_anim_out
			}
		}}
	registerstate \{name = uistate_practice_warning
		task = {
			name = task_menu
			params = {
				base_name = 'practice_warning'
			}
		}}
	registerstate \{name = uistate_practice_select_difficulty
		task = {
			name = task_menu
			params = {
				base_name = 'practice_select_difficulty'
				anim_in_script = ui_select_difficulty_anim_in
				anim_out_script = ui_select_difficulty_anim_out
			}
		}}
	registerstate \{name = uistate_tutorial_prompt
		task = {
			name = task_menu
			params = {
				base_name = 'tutorial_prompt'
				focus_id = dialog_box_vmenu
			}
		}}
	registerstate \{name = uistate_tutorial_prompt_easy
		task = {
			name = task_menu
			params = {
				base_name = 'tutorial_prompt_easy'
				focus_id = dialog_box_vmenu
			}
		}}
endscript

script registeruistates_jam 
	registerstate \{name = uistate_jam
		task = {
			name = task_menu
			params = {
				base_name = 'jam'
				pakname = 'jam'
				anim_in_script = nullscript
				anim_out_script = nullscript
			}
		}}
	registerstate \{name = uistate_jam_select_song
		task = {
			name = task_menu
			params = {
				base_name = 'jam_select_song'
				pakname = 'jam'
			}
		}}
	registerstate \{name = uistate_jam_song_wizard
		task = {
			name = task_menu
			params = {
				base_name = 'jam_song_wizard'
				pakname = 'jam_wizard'
			}
		}}
	registerstate \{name = uistate_jam_band
		task = {
			name = task_menu
			params = {
				base_name = 'jam_band'
				pakname = 'jam_band'
			}
		}}
	registerstate \{name = 0x564a9cd3
		task = {
			name = task_menu
			params = {
				base_name = 'jam_band_tut'
				pakname = 'jam_band'
			}
		}}
	registerstate \{name = uistate_recording
		task = {
			name = task_menu
			params = {
				base_name = 'recording'
				pakname = 'jam_advanced'
			}
		}}
	registerstate \{name = uistate_recording_disconnect
		task = {
			name = task_menu
			params = {
				base_name = 'recording_disconnect'
			}
		}}
	registerstate \{name = uistate_jam_publish_song
		task = {
			name = task_menu
			params = {
				base_name = 'jam_publish_song'
				pakname = 'jam_ghtunes'
			}
		}}
	registerstate \{name = uistate_jam_publish_genre
		task = {
			name = task_menu
			params = {
				base_name = 'jam_publish_genre'
				pakname = 'jam_ghtunes'
			}
		}}
	registerstate \{name = uistate_jam_publish_track_select
		task = {
			name = task_menu
			params = {
				base_name = 'jam_publish_track_select'
				pakname = 'jam_ghtunes'
			}
		}}
	registerstate \{name = uistate_jam_publish_slot
		task = {
			name = task_menu
			params = {
				base_name = 'jam_publish_slot'
				pakname = 'jam_ghtunes'
			}
		}}
	registerstate \{name = uistate_jam_download_slot
		task = {
			name = task_menu
			params = {
				base_name = 'jam_download_slot'
				pakname = 'jam_ghtunes'
			}
		}}
	registerstate \{name = uistate_jam_publish_title_entry
		task = {
			name = task_menu
			params = {
				base_name = 'jam_publish_title_entry'
				pakname = 'jam_ghtunes'
			}
		}}
	registerstate \{name = uistate_jam_publish_update_fileid
		task = {
			name = task_menu
			params = {
				base_name = 'jam_publish_update_fileid'
				pakname = 'jam_ghtunes'
			}
		}}
	registerstate \{name = uistate_jam_publish_signin
		task = {
			name = task_menu
			params = {
				base_name = 'jam_publish_signin'
				pakname = 'jam'
			}
		}}
	registerstate \{name = uistate_jam_ghtunes
		task = {
			name = task_menu
			params = {
				base_name = 'jam_ghtunes'
				pakname = 'jam_ghtunes'
			}
		}}
	registerstate \{name = uistate_gh_tunes_share
		task = {
			name = task_menu
			params = {
				base_name = 'gh_tunes_share'
				pakname = 'gh_tunes_share'
			}
		}}
	registerstate \{name = uistate_jam_ratesong
		task = {
			name = task_menu
			params = {
				base_name = 'jam_ratesong'
				pakname = 'jam'
			}
		}}
	registerstate \{name = uistate_jam_songwriter_event
		task = {
			name = task_menu
			params = {
				base_name = 'jam_songwriter_event'
				pakname = 'jam_songwriter'
			}
		}}
	registerstate \{name = uistate_jam_quickplay_event
		task = {
			name = task_menu
			params = {
				base_name = 'jam_quickplay_event'
			}
		}}
	registerstate \{name = uistate_jam_tutorials
		task = {
			name = task_menu
			params = {
				base_name = 'jam_tutorials'
			}
		}}
endscript

script registeruistates_select_rocker 
	registerstate \{name = uistate_character_selection
		task = {
			name = task_menu
			params = {
				base_name = 'character_selection'
			}
		}}
	registerstate \{name = uistate_character_purchase
		task = {
			name = task_menu
			params = {
				base_name = 'character_purchase'
				focus_id = character_purchase_menu
			}
		}}
	registerstate \{name = uistate_customize_character
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character'
				hist_tex = icon_editcharacter
			}
		}}
	registerstate \{name = uistate_customize_character_head
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_head'
				hist_tex = icon_head
			}
		}}
	registerstate \{name = uistate_customize_character_body
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_body'
				hist_tex = icon_body
			}
		}}
	registerstate \{name = uistate_customize_character_proportions
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_proportions'
				hist_tex = icon_size
			}
		}}
	registerstate \{name = uistate_customize_character_body_art
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_body_art'
				hist_tex = icon_graphics
			}
		}}
	registerstate \{name = uistate_customize_character_sub_sections
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_sub_sections'
				hist_tex = icon_graphics
			}
		}}
	registerstate \{name = uistate_customize_character_stage_presence
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_stage_presence'
				hist_tex = icon_presence
			}
		}}
	registerstate \{name = uistate_character_face_deformation
		task = {
			name = task_menu
			params = {
				base_name = 'character_face_deformation'
				hist_tex = icon_face
			}
		}}
	registerstate \{name = uistate_character_face_deformation_options
		task = {
			name = task_menu
			params = {
				base_name = 'character_face_deformation_options'
			}
		}}
	registerstate \{name = uistate_cas_color_edit
		task = {
			name = task_menu
			params = {
				base_name = 'cas_color_edit'
			}
		}}
	registerstate \{name = uistate_save_changes_dialogue
		task = {
			name = task_menu
			params = {
				base_name = 'save_changes_dialogue'
				focus_id = dialog_box_vmenu
			}
		}}
	registerstate \{name = uistate_customize_character_genre
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_genre'
			}
		}}
	registerstate \{name = uistate_customize_character_gender
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_gender'
			}
		}}
	registerstate \{name = uistate_create_character_gender
		task = {
			name = task_menu
			params = {
				base_name = 'create_character_gender'
			}
		}}
	registerstate \{name = uistate_create_character_genre
		task = {
			name = task_menu
			params = {
				base_name = 'create_character_genre'
			}
		}}
	registerstate \{name = uistate_cas_discard_changes
		task = {
			name = task_menu
			params = {
				base_name = 'cas_discard_changes'
				focus_id = dialog_box_vmenu
			}
		}}
	registerstate \{name = uistate_customize_character_mic
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_mic'
				hist_tex = icon_mic_2
				pakname = 'cag_main'
			}
		}}
	registerstate \{name = uistate_customize_character_mic_main
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_mic_main'
				hist_tex = icon_customize
				pakname = 'cag_main'
			}
		}}
	registerstate \{name = uistate_cas_select_part
		task = {
			name = task_menu
			params = {
				base_name = 'cas_select_part'
			}
		}}
	registerstate \{name = uistate_cas_select_part_options
		task = {
			name = task_menu
			params = {
				base_name = 'cas_select_part_options'
			}
		}}
	registerstate \{name = uistate_popout_select_part
		task = {
			name = task_menu
			params = {
				base_name = 'popout_select_part'
				focus_id = current_list_menu
			}
		}}
	registerstate \{name = uistate_cas_select_part_color_options
		task = {
			name = task_menu
			params = {
				base_name = 'cas_select_part_color_options'
			}
		}}
	registerstate \{name = uistate_cas_select_part_swatches
		task = {
			name = task_menu
			params = {
				base_name = 'cas_select_part_swatches'
			}
		}}
	registerstate \{name = uistate_cas_text_entry
		task = {
			name = task_menu
			params = {
				base_name = 'cas_text_entry'
				hist_tex = icon_name
			}
		}}
	registerstate \{name = uistate_end_credits
		task = {
			name = task_menu
			params = {
				base_name = 'end_credits'
			}
		}}
endscript

script registeruistates_cap 
	registerstate \{name = uistate_cagr
		taks = {
			name = task_menu
			params = {
				base_name = 'cagr'
			}
		}}
	registerstate \{name = uistate_cap_main
		task = {
			name = task_menu
			params = {
				base_name = 'cagr'
				anim_out_script = ui_cap_main_anim_out
			}
		}}
	registerstate \{name = uistate_cap_layers_list
		task = {
			name = task_menu
			params = {
				base_name = 'cap_layers_list'
				hist_tex = icon_current
			}
		}}
	registerstate \{name = uistate_cap_shape_list
		task = {
			name = task_menu
			params = {
				base_name = 'cap_shape_list'
				hist_tex = category
			}
		}}
	registerstate \{name = uistate_cap_shape_list_subset
		task = {
			name = task_menu
			params = {
				base_name = 'cap_shape_list_subset'
				focus_id = current_list_menu
			}
		}}
	registerstate \{name = uistate_cap_color_wheel
		task = {
			name = task_menu
			params = {
				base_name = 'cap_color_wheel'
				hist_tex = menu_history_color_edit
			}
		}}
	registerstate \{name = uistate_cap_shape_edit
		task = {
			name = task_menu
			params = {
				base_name = 'cap_shape_edit'
				anim_in_script = nullscript
				hist_tex = menu_history_color_edit
			}
		}}
	registerstate \{name = uistate_cap_artist_layer
		task = {
			name = task_menu
			params = {
				base_name = 'cap_artist_layer'
			}
		}}
	registerstate \{name = uistate_cap_layers_options
		task = {
			name = task_menu
			params = {
				base_name = 'cap_layers_options'
				focus_id = layers_options_vmenu
			}
		}}
	registerstate \{name = uistate_cap_artist_layer_options
		task = {
			name = task_menu
			params = {
				base_name = 'cap_artist_layer_options'
				hist_tex = menu_history_color_edit
			}
		}}
	registerstate \{name = uistate_cap_artist_layer_popout
		task = {
			name = task_menu
			params = {
				base_name = 'cap_artist_layer_popout'
				focus_id = current_list_menu
			}
		}}
	registerstate \{name = uistate_cas_save_slots
		task = {
			name = task_menu
			params = {
				base_name = 'cas_save_slots'
			}
		}}
endscript

script registeruistates_outfit 
	registerstate \{name = uistate_customize_character_outfit
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_outfit'
				hist_tex = icon_outfit
			}
		}}
	registerstate \{name = uistate_customize_character_outfit_accessories
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_outfit_accessories'
				hist_tex = accessories
			}
		}}
endscript

script registeruistates_cag 
	registerstate \{name = uistate_customize_character_instrument
		task = {
			name = task_menu
			params = {
				base_name = 'customize_character_instrument'
				hist_tex = icon_instrument
			}
		}}
	registerstate \{name = uistate_cag_main
		task = {
			name = task_menu
			params = {
				base_name = 'cag_main'
			}
		}}
	registerstate \{name = uistate_cag_custom
		task = {
			name = task_menu
			params = {
				base_name = 'cag_custom'
				hist_tex = icon_customize
				pakname = 'cag_main'
			}
		}}
	registerstate \{name = uistate_cag_custom_body
		task = {
			name = task_menu
			params = {
				base_name = 'cag_custom_body'
				hist_tex = icon_cag_body
				pakname = 'cag_main'
			}
		}}
	registerstate \{name = uistate_cag_custom_body_types
		task = {
			name = task_menu
			params = {
				base_name = 'cag_custom_body_types'
				focus_id = current_list_menu
				hist_tex = icon_cag_type
				pakname = 'cag_main'
			}
		}}
	registerstate \{name = uistate_cag_select_part_inclusion
		task = {
			name = task_menu
			params = {
				base_name = 'cag_select_part_inclusion'
				focus_id = current_list_menu
			}
		}}
	registerstate \{name = uistate_cag_select_part_inclusion_options
		task = {
			name = task_menu
			params = {
				base_name = 'cag_select_part_inclusion_options'
			}
		}}
	registerstate \{name = uistate_cag_metallica_presets
		task = {
			name = task_menu
			params = {
				base_name = 'cag_metallica_presets'
				focus_id = current_list_menu
			}
		}}
	registerstate \{name = uistate_cag_custom_hardware
		task = {
			name = task_menu
			params = {
				base_name = 'cag_custom_hardware'
				hist_tex = icon_cag_hardware
				pakname = 'cag_main'
			}
		}}
	registerstate \{name = uistate_cag_custom_head
		task = {
			name = task_menu
			params = {
				base_name = 'cag_custom_head'
				hist_tex = icon_cag_head
				pakname = 'cag_main'
			}
		}}
	registerstate \{name = uistate_cag_custom_strings
		task = {
			name = task_menu
			params = {
				base_name = 'cag_custom_strings'
				focus_id = current_list_menu
				hist_tex = icon_cag_strings
				pakname = 'cas_ui'
			}
		}}
endscript

script registeruistates_online 
	registerstate \{name = uistate_online
		task = {
			name = task_menu
			params = {
				base_name = 'online'
				pakname = 'online_lobby'
			}
		}}
	registerstate \{name = uistate_net_setlist
		task = {
			name = task_menu
			params = {
				base_name = 'net_setlist'
			}
		}}
	registerstate \{name = uistate_net_custom_search
		task = {
			name = task_menu
			params = {
				base_name = 'net_custom_search'
			}
		}}
	registerstate \{name = uistate_net_serverlist
		task = {
			name = task_menu
			params = {
				base_name = 'net_serverlist'
			}
		}}
	registerstate \{name = uistate_net_joining
		task = {
			name = task_menu
			params = {
				base_name = 'net_joining'
			}
		}}
	registerstate \{name = uistate_net_debug_lobby
		task = {
			name = task_menu
			params = {
				base_name = 'net_debug_lobby'
			}
		}}
	registerstate \{name = uistate_net_debug_lobby_join
		task = {
			name = task_menu
			params = {
				base_name = 'net_debug_lobby_join'
			}
		}}
	registerstate \{name = uistate_net_signin_popup
		task = {
			name = task_menu
			params = {
				base_name = 'net_signin_popup'
				focus_id = net_signin_popup
			}
		}}
	registerstate \{name = uistate_net_career_join_popup
		task = {
			name = task_menu
			params = {
				base_name = 'net_career_join_popup'
				focus_id = career_join_popup
			}
		}}
	registerstate \{name = uistate_leaderboard
		task = {
			name = task_menu
			params = {
				base_name = 'leaderboard'
				pakname = 'leaderboard'
			}
		}}
	registerstate \{name = uistate_leaderboard_groups
		task = {
			name = task_menu
			params = {
				base_name = 'leaderboard_groups'
			}
		}}
	registerstate \{name = uistate_leaderboard_list
		task = {
			name = task_menu
			params = {
				base_name = 'leaderboard_list'
			}
		}}
	registerstate \{name = uistate_leaderboard_load
		task = {
			name = task_menu
			params = {
				base_name = 'leaderboard_load'
				pakname = 'leaderboard'
				focus_id = leaderboard_load
			}
		}}
	registerstate \{name = uistate_leaderboard_filter
		task = {
			name = task_menu
			params = {
				base_name = 'leaderboard_filter'
				pakname = 'leaderboard'
				focus_id = filter_menu
				anim_in_script = ui_leaderboard_popup_anim_in
				anim_out_script = ui_leaderboard_popup_anim_out
			}
		}}
	registerstate \{name = uistate_leaderboard_me
		task = {
			name = task_menu
			params = {
				base_name = 'leaderboard_me'
				pakname = 'leaderboard'
				focus_id = leaderboard_popup
				anim_in_script = ui_leaderboard_popup_anim_in
				anim_out_script = ui_leaderboard_popup_anim_out
			}
		}}
	registerstate \{name = uistate_leaderboard_instrument
		task = {
			name = task_menu
			params = {
				base_name = 'leaderboard_instrument'
			}
		}}
	registerstate \{name = uistate_leaderboard_timeout
		task = {
			name = task_menu
			params = {
				base_name = 'leaderboard_timeout'
			}
		}}
	registerstate \{name = uistate_leaderboard_empty
		task = {
			name = task_menu
			params = {
				base_name = 'leaderboard_empty'
			}
		}}
	registerstate \{name = uistate_net_zero_search_results_popup
		task = {
			name = task_menu
			params = {
				base_name = 'net_zero_search_results_popup'
				focus_id = net_zero_popup
			}
		}}
	registerstate \{name = uistate_friends_list
		task = {
			name = task_menu
			params = {
				base_name = 'friends_list'
				focus_id = friends_list_popup
			}
		}}
	registerstate \{name = uistate_net_preferences
		task = {
			name = task_menu
			params = {
				base_name = 'net_preferences'
				focus_id = net_preferences_popup
			}
		}}
	registerstate \{name = uistate_online_post_game_lobby
		task = {
			name = task_menu
			params = {
				base_name = 'online_post_game_lobby'
				pakname = 'online_lobby'
			}
		}}
	registerstate \{name = uistate_net_setup
		task = {
			name = task_menu
			params = {
				base_name = 'net_setup'
			}
		}}
	registerstate \{name = uistate_online_quit_warning
		task = {
			name = task_menu
			params = {
				base_name = 'online_quit_warning'
				focus_id = online_quit_menu
			}
		}}
endscript

script registeruistates_cadrm 
	registerstate \{name = uistate_cadrm_main
		task = {
			name = task_menu
			params = {
				base_name = 'cadrm_main'
				hist_tex = icon_cadrm_drum
				pakname = 'cag_main'
			}
		}}
	registerstate \{name = uistate_cadrm_hub
		task = {
			name = task_menu
			params = {
				base_name = 'cadrm_hub'
				hist_tex = icon_customize
				pakname = 'cag_main'
			}
		}}
endscript
