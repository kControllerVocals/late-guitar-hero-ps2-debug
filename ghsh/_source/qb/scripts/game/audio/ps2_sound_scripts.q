0xf7bea20b = none

script 0x8882d576 
	getpakmancurrent \{map = zones}
	switch <pak>
		case z_amazon
		return \{venuesize = 'Medium_EXT'}
		case z_atlantis
		return \{venuesize = 'Large_EXT'}
		case z_canyon
		return \{venuesize = 'Large_EXT'}
		case z_greatwall
		return \{venuesize = 'Medium_EXT'}
		case z_london
		return \{venuesize = 'Medium_EXT'}
		case z_sphinx
		return \{venuesize = 'Medium_EXT'}
		case z_icecap
		return \{venuesize = 'Large_EXT'}
		case z_quebec
		return \{venuesize = 'Large_EXT'}
		case z_ballpark
		return \{venuesize = 'Medium_EXT'}
		case z_bayou
		return \{venuesize = 'Small_INT'}
		case z_castle
		return \{venuesize = 'Medium_EXT'}
		case z_cathedral
		return \{venuesize = 'Medium_EXT'}
		case z_fairgrounds
		return \{venuesize = 'Medium_EXT'}
		case z_frathouse
		return \{venuesize = 'Small_INT'}
		case z_goth
		return \{venuesize = 'Medium_EXT'}
		case z_harbor
		return \{venuesize = 'Medium_EXT'}
		case z_hotel
		return \{venuesize = 'Small_INT'}
		case z_metalfest
		return \{venuesize = 'Large_EXT'}
		case z_military
		return \{venuesize = 'Medium_EXT'}
		case z_newyork
		return \{venuesize = 'Large_EXT'}
		case z_recordstore
		return \{venuesize = 'Small_INT'}
		case z_tool
		return \{venuesize = 'z_TOOL'}
		default
		return \{venuesize = 'Medium_EXT'}
	endswitch
endscript

script 0xf6523eff \{sound = 'none'}
	training_get_language_prefix
	formattext textname = 0xaa5c3627 '_%a' a = <language_prefix>
	extendcrc <sound> <0xaa5c3627> out = sound_id
	loadsound <sound_id>
endscript
0x27707361 = none
0x1d401155 = none
0x417433a6 = [
	'sg_b_pk_a4_s6_f5_01'
	'sg_b_pk_ab3_s1_f16_01'
	'sg_b_pk_ab5_s6_f16_01'
	'sg_b_pk_b4_s4_f16_01'
	'sg_b_pk_c4_s4_f5_01'
	'sg_b_pk_d3_s2_f5_01'
	'sg_b_pk_db4_s2_f16_01'
	'sg_b_pk_e4_s5_f5_01'
	'sg_b_pk_eb5_s5_f16_01'
	'sg_b_pk_g3_s3_f5_01'
	'sg_b_pk_gb4_s3_f16_01'
	'sg_b_pm_a2_s1_f5_01'
	'sg_b_pm_a4_s6_f5_01'
	'sg_b_pm_ab3_s1_f16_01'
	'sg_b_pm_ab5_s6_f16_01'
	'sg_b_pm_b4_s4_f16_01'
	'sg_b_pm_c4_s4_f5_01'
	'sg_b_pm_d3_s2_f5_01'
	'sg_b_pm_db4_s2_f16_01'
	'sg_b_pm_e4_s5_f5_01'
	'sg_b_pm_eb5_s5_f16_01'
	'sg_b_pm_g3_s3_f5_01'
	'sg_b_pm_gb4_s3_f16_01'
]
0x06de2cd8 = [
	'sg_b_chrd_down_c5_s2_f3_01'
	'sg_b_chrd_down_g5_s1_f3_01'
	'sg_b_chrd_down_gb5_s2_f9_01'
	'sg_b_chrd_down_cmaj_s2_f3_01'
	'sg_b_chrd_down_gmaj_s1_f3_01'
	'sg_b_chrd_down_gbmaj_s2_f9_01'
	'sg_b_chrd_down_cmin_s2_f3_01'
	'sg_b_chrd_down_gmin_s1_f3_01'
	'sg_b_chrd_down_gbmin_s2_f9_01'
	'sg_b_divebomb_down'
	'sg_b_divebomb_updown'
	'sg_b_fingerslide'
	'sg_b_hrm_s1_f12'
	'sg_b_hrm_s2_f12'
	'sg_b_hrm_s3_f12'
	'sg_b_hrm_s4_f12'
	'sg_b_hrm_s5_f12'
	'sg_b_hrm_s6_f12'
	'sg_b_pkslidefast'
	'sg_b_pkslideslow'
	'sg_b_stringmute_down'
]

script 0xd53de9cc 
	loadsound \{heavyrockcrash_lvl_10_01}
	loadsound \{heavyrockcrash_lvl_8_01}
	loadsound \{heavyrockfltom_lvl_10_01}
	loadsound \{heavyrockfltom_lvl_4_01}
	loadsound \{heavyrockfltom_lvl_6_01}
	loadsound \{heavyrockfltom_lvl_8_01}
	loadsound \{heavyrockhhclosed_lvl_4_01}
	loadsound \{heavyrockhhclosed_lvl_6_01}
	loadsound \{heavyrockhhclosed_lvl_8_01}
	loadsound \{heavyrockhhclosed_lvl_10_01}
	loadsound \{heavyrockhhopen_lvl_10_01}
	loadsound \{heavyrockhhopen_lvl_9_01}
	loadsound \{heavyrockhhopen_lvl_6_01}
	loadsound \{heavyrockhhopen_lvl_2_01}
	loadsound \{heavyrockhitom_lvl_10_01}
	loadsound \{heavyrockhitom_lvl_4_01}
	loadsound \{heavyrockhitom_lvl_6_01}
	loadsound \{heavyrockhitom_lvl_8_01}
	loadsound \{heavyrockkick_lvl_10_01}
	loadsound \{heavyrockride_lvl_10_01}
	loadsound \{heavyrocksnare_lvl_10_01}
	loadsound \{heavyrocksnare_lvl_12_03}
	loadsound \{heavyrocksnare_lvl_2_01}
	loadsound \{heavyrocksnare_lvl_4_01}
	loadsound \{heavyrocksnare_lvl_6_01}
	loadsound \{heavyrocksnare_lvl_8_01}
endscript

script 0x1baed16a 
endscript

script 0xeb3a43f7 
endscript

script 0xf7b44917 
	return
endscript

script 0xf301e1c3 
	randomize
	change 0xf7bea20b = Random (@ menu_intro_lick_01 @ menu_intro_lick_02 @ menu_intro_lick_03 @ menu_intro_lick_04 @ menu_intro_lick_05 @ menu_intro_lick_06 @ menu_intro_lick_07 )
	loadsound ($0xf7bea20b)
endscript

script 0xc1c4e84c \{mode = 0xae92eddf
		0xd607e2e6 = 0
		force = 0
		tutorial = 0}
	if (($game_mode = training) && (<mode> = jammode))
		return
	endif
	if NOT (<0xd607e2e6> = 1)
		0xbea8f580
		getglobaltags \{user_options}
		guitar_volume = (<volumes>.guitar.guitar.vol)
		band_volume = (<volumes>.guitar.band.vol)
		sfx_volume = (<volumes>.guitar.sfx.vol)
	endif
	if NOT (<force> = 1)
		if ($0x27707361 = <mode>)
			return
		endif
	endif
	change 0x27707361 = <mode>
	0xc48cfd3c
	if ((<mode> = jammode) || ((<mode> = tutorials) && (<tutorial> = jam)))
		0x41f1a09d
	endif
	change \{0x1d401155 = 0x1d401155}
	if ($0x27707361 = none)
		return
	endif
	loadsound \{gh3_beat_sound}
	loadsound \{ui_sound_05}
	loadsound \{ui_sound_09}
	loadsound \{menu_scroll_down}
	loadsound \{menu_scroll_up}
	loadsound \{menu_select_negative}
	switch <mode>
		case 0xae92eddf

		loadsound \{bad_note1}
		loadsound \{bad_note2}
		loadsound \{bad_note4}
		loadsound \{bad_note6}
		loadsound \{bad_note_bass2}
		loadsound \{bad_note_bass4}
		loadsound \{bad_note_bass6}
		loadsound \{bad_note_tom1}
		loadsound \{bad_note_hihat1}
		loadsound \{bad_note_kick1}
		loadsound \{star_available}
		loadsound \{sp_available1}
		loadsound \{sp_awarded1}
		loadsound \{sp_deployed}
		loadsound \{star_meter_gain}
		loadsound \{sp_cheer1}
		loadsound \{notes_ripple_up_01}
		loadsound \{you_rock}
		loadsound \{crowd_fail_song}
		loadsound \{highway_rise}
		loadsound \{ui_song_intro_kick}
		loadsound \{songcomplete_out}
		loadsound \{songcomplete_in}
		loadsound \{crowd_group_clap_01}
		loadsound \{crowd_group_clap_02}
		loadsound \{crowd_group_clap_03}
		loadsound \{gh3_sudden_death}
		loadsound \{stickclicklarge}
		loadsound \{stickclickmed}
		loadsound \{stickclicksmall}
		loadsound \{hihatclosed01}
		loadsound \{ui_lose_multiplier}
		loadsound \{ui_sfx_100_note_streak}
		loadsound \{ui_sfx_50_note_streak}
		loadsound \{guitar_smash_large_gh4_01}
		loadsound \{guitar_smash_medium_gh4_01}
		loadsound \{guitar_smash_small_gh4_01}
		loadsound \{checkbox_check_sfx}
		loadsound \{menu_into_pausemenu}
		loadsound \{menu_outof_pausemenu}
		loadsound \{soundoptions_menu_reset}
		loadsound \{menu_options_sound_fader_move}
		loadsound \{menu_options_sound_select}
		loadsound \{menu_options_sound_back}
		0xd53de9cc
		case 0x07071941

		loadsound \{gigcomplete_unlock_item_text_appear}
		loadsound \{gigcomplete_unlock_new_item}
		loadsound \{gig_complete_magazine_in}
		loadsound \{gig_complete_magazine_out}
		loadsound \{checkbox_check_sfx}
		loadsound \{menu_entername_select}
		loadsound \{menu_entername_scroll_1}
		loadsound \{0xa676c493}
		loadsound \{menu_entername_back}
		loadsound \{menu_entername_caps}
		loadsound \{cash}
		loadsound \{purchase_item}
		return
		case 0x68721771

		loadsound \{bad_note1}
		loadsound \{bad_note2}
		loadsound \{bad_note4}
		loadsound \{bad_note6}
		loadsound \{bad_note_bass2}
		loadsound \{bad_note_bass4}
		loadsound \{bad_note_bass6}
		loadsound \{bad_note_tom1}
		loadsound \{bad_note_hihat1}
		loadsound \{bad_note_kick1}
		loadsound \{star_available}
		loadsound \{sp_available1}
		loadsound \{sp_awarded1}
		loadsound \{sp_deployed}
		loadsound \{star_meter_gain}
		loadsound \{sp_cheer1}
		loadsound \{notes_ripple_up_01}
		loadsound \{multiplayer_win_screen}
		loadsound \{crowd_fail_song}
		loadsound \{highway_rise}
		loadsound \{ui_song_intro_kick}
		loadsound \{crowd_group_clap_01}
		loadsound \{crowd_group_clap_02}
		loadsound \{crowd_group_clap_03}
		loadsound \{you_rock}
		loadsound \{gh3_sudden_death}
		loadsound \{stickclicklarge}
		loadsound \{stickclickmed}
		loadsound \{stickclicksmall}
		loadsound \{hihatclosed01}
		loadsound \{ui_lose_multiplier}
		loadsound \{ui_sfx_100_note_streak}
		loadsound \{ui_sfx_50_note_streak}
		loadsound \{guitar_smash_large_gh4_01}
		loadsound \{guitar_smash_medium_gh4_01}
		loadsound \{guitar_smash_small_gh4_01}
		loadsound \{checkbox_check_sfx}
		loadsound \{menu_into_pausemenu}
		loadsound \{menu_outof_pausemenu}
		loadsound \{songcomplete_out}
		loadsound \{songcomplete_in}
		loadsound \{soundoptions_menu_reset}
		loadsound \{menu_options_sound_fader_move}
		0xd53de9cc
		case tutorials

		loadsound \{notes_ripple_up_01}
		loadsound \{highway_rise}
		loadsound \{ui_song_intro_kick}
		loadsound \{finish_chord}
		loadsound \{star_available}
		loadsound \{menu_into_pausemenu}
		loadsound \{menu_outof_pausemenu}
		if (<tutorial> != jam)
			loadsound \{bad_note1}
			loadsound \{bad_note2}
			loadsound \{bad_note4}
			loadsound \{bad_note6}
			loadsound \{bad_note_bass2}
			loadsound \{bad_note_bass4}
			loadsound \{bad_note_bass6}
		endif
		if (<tutorial> = 1)
			0xf6523eff \{sound = 0xf99f0cb6}
		endif
		if ((<tutorial> = 1) || (<tutorial> = 4))
			0xf6523eff \{sound = 0xdd4e9f6b}
			0xf6523eff \{sound = 0x9aeee5bb}
			0xf6523eff \{sound = 0xa78ecc0b}
			0xf6523eff \{sound = 0x15ae101b}
			0xf6523eff \{sound = 0x28ce39ab}
			0xf6523eff \{sound = 0x6f6e437b}
			0xf6523eff \{sound = 0x520e6acb}
			0xf6523eff \{sound = 0xd05efd1a}
			if (<tutorial> = 4)
				loadsound \{tutorial_string_1_strum_free}
				loadsound \{tutorial_string_3_strum_free}
				loadsound \{tutorial_string_1_hopo_free}
				loadsound \{tutorial_string_2_hopo_free}
				loadsound \{tutorial_string_3_hopo_free}
			endif
		elseif ((<tutorial> = 0xbf7e526d) || (<tutorial> = 6))
			if (<tutorial> = 0xbf7e526d)
				0xd53de9cc
			endif
			loadsound \{bad_note_tom1}
			loadsound \{bad_note_hihat1}
			loadsound \{bad_note_kick1}
			0xf6523eff \{sound = 0x89e2cd26}
			0xf6523eff \{sound = 0xce42b7f6}
			0xf6523eff \{sound = 0xf3229e46}
			0xf6523eff \{sound = 0x41024256}
			0xf6523eff \{sound = 0x7c626be6}
			0xf6523eff \{sound = 0x3bc21136}
			0xf6523eff \{sound = 0x06a23886}
			0xf6523eff \{sound = 0x84f2af57}
		elseif (<tutorial> = battle)
			loadsound \{gh3_battle_difficultyrampup}
			loadsound \{gh3_battlemode_attack_over}
			loadsound \{gh3_battlemode_doublenoteattack}
			loadsound \{gh3_battlemode_lightning}
			loadsound \{gh3_battlemode_stringbreakattack}
			loadsound \{gh3_battlemode_stringtune_2}
			loadsound \{sp_awarded1}
		endif
		0x8c8c96bf
		return
		case battle

		loadsound \{bad_note1}
		loadsound \{bad_note2}
		loadsound \{bad_note4}
		loadsound \{bad_note6}
		loadsound \{bad_note_bass2}
		loadsound \{bad_note_bass4}
		loadsound \{bad_note_bass6}
		loadsound \{bad_note_tom1}
		loadsound \{bad_note_hihat1}
		loadsound \{bad_note_kick1}
		loadsound \{notes_ripple_up_01}
		loadsound \{battle_mineattack_explode}
		loadsound \{battle_mineattack_release}
		loadsound \{gh3_battle_difficultyrampup}
		loadsound \{gh3_battlemode_attack_over}
		loadsound \{gh3_battlemode_doublenoteattack}
		loadsound \{gh3_battlemode_leftyattack}
		loadsound \{gh3_battlemode_lightning}
		loadsound \{gh3_battlemode_stealpowerup}
		loadsound \{gh3_battlemode_stringbreakattack}
		loadsound \{gh3_battlemode_whammyattack}
		loadsound \{gh3_sudden_death}
		loadsound \{highway_rise}
		loadsound \{gh3_battlemode_stringtune_2}
		loadsound \{ui_song_intro_kick}
		loadsound \{ui_lose_multiplier}
		loadsound \{ui_sfx_100_note_streak}
		loadsound \{ui_sfx_50_note_streak}
		loadsound \{multiplayer_win_screen}
		loadsound \{stickclickmed}
		loadsound \{you_rock}
		loadsound \{sp_awarded1}
		loadsound \{checkbox_check_sfx}
		loadsound \{doordie}
		loadsound \{menu_into_pausemenu}
		loadsound \{menu_outof_pausemenu}
		loadsound \{songcomplete_out}
		loadsound \{songcomplete_in}
		loadsound \{soundoptions_menu_reset}
		loadsound \{menu_options_sound_fader_move}
		case 0x64912155

		loadsound \{fly_in_whoosh}
		loadsound \{checkbox_check_sfx}
		loadsound \{checkbox_sfx}
		loadsound \{cash}
		loadsound \{purchase_item}
		loadsound \{menu_quickplay_removesong}
		loadsound \{menu_warning_01}
		loadsound \{menu_zoomin_career}
		loadsound \{menu_zoomout_career}
		loadsound \{menu_zoomin_options}
		loadsound \{menu_zoomout_options}
		loadsound \{menu_zoomin_headtohead}
		loadsound \{menu_zoomout_headtohead}
		loadsound \{menu_options_sound_select}
		loadsound \{menu_options_sound_back}
		loadsound \{menu_options_sound_fader_move}
		loadsound \{menu_options_sound_dolbydigitaldisable}
		loadsound \{menu_options_sound_dolbydigitalenable}
		loadsound \{menu_entername_select}
		loadsound \{menu_entername_scroll_1}
		loadsound \{0xa676c493}
		loadsound \{menu_entername_back}
		loadsound \{menu_entername_caps}
		loadsound \{menu_colorwheel_gradientselect}
		loadsound \{menu_colorwheel_rotate}
		loadsound \{menu_colorwheel_highlight_up_down_3}
		loadsound \{menu_colorwheel_deselect_piepiece}
		loadsound \{menu_colorwheel_selectpie}
		loadsound \{guitar_select_affirmation_1}
		loadsound \{drum_select_affirmation_01}
		loadsound \{bass_select_affirmation_02}
		loadsound \{mic_select_affirmation_01}
		loadsound \{band_leader_affirmation}
		loadsound \{song_affirmation_01}
		loadsound \{song_affirmation_02}
		loadsound \{song_affirmation_03}
		loadsound \{song_affirmation_04}
		loadsound \{song_affirmation_05}
		loadsound \{song_affirmation_06}
		loadsound \{menu_cheat_red}
		loadsound \{menu_cheat_yellow}
		loadsound \{menu_cheat_blue}
		loadsound \{menu_cheat_green}
		loadsound \{gig_complete_sponsor}
		loadsound \{gigcomplete_unlock_item_text_appear}
		loadsound \{gigcomplete_unlock_new_item}
		loadsound \{gig_complete_magazine_in}
		loadsound \{gig_complete_magazine_out}
		loadsound \{gig_unlock}
		loadsound \{ui_gigboard_scroll}
		loadsound \{0x4df25d31}
		loadsound \{soundoptions_menu_reset}
		loadsound \{heavyrocksnare_lvl_12_03}
		loadsound \{menu_gigboard_camerapan_right}
		loadsound \{menu_gigboard_camerapan_left}
		loadsound \{menu_restore_defaults}
		loadsound \{crowd_group_clap_03}
		loadsound \{bad_note2}
		0xf301e1c3
		change \{0x27707361 = frontend}
		return
		case frontend

		loadsound \{fly_in_whoosh}
		loadsound \{checkbox_check_sfx}
		loadsound \{checkbox_sfx}
		loadsound \{cash}
		loadsound \{purchase_item}
		loadsound \{menu_quickplay_removesong}
		loadsound \{menu_warning_01}
		loadsound \{menu_zoomin_career}
		loadsound \{menu_zoomout_career}
		loadsound \{menu_zoomin_options}
		loadsound \{menu_zoomout_options}
		loadsound \{menu_zoomin_headtohead}
		loadsound \{menu_zoomout_headtohead}
		loadsound \{menu_options_sound_select}
		loadsound \{menu_options_sound_back}
		loadsound \{menu_options_sound_fader_move}
		loadsound \{menu_options_sound_dolbydigitaldisable}
		loadsound \{menu_options_sound_dolbydigitalenable}
		loadsound \{menu_entername_select}
		loadsound \{menu_entername_scroll_1}
		loadsound \{0xa676c493}
		loadsound \{menu_entername_back}
		loadsound \{menu_entername_caps}
		loadsound \{menu_colorwheel_gradientselect}
		loadsound \{menu_colorwheel_rotate}
		loadsound \{menu_colorwheel_highlight_up_down_3}
		loadsound \{menu_colorwheel_deselect_piepiece}
		loadsound \{menu_colorwheel_selectpie}
		loadsound \{menu_main_intro}
		loadsound \{guitar_select_affirmation_1}
		loadsound \{drum_select_affirmation_01}
		loadsound \{bass_select_affirmation_02}
		loadsound \{mic_select_affirmation_01}
		loadsound \{band_leader_affirmation}
		loadsound \{song_affirmation_01}
		loadsound \{song_affirmation_02}
		loadsound \{song_affirmation_03}
		loadsound \{song_affirmation_04}
		loadsound \{song_affirmation_05}
		loadsound \{song_affirmation_06}
		loadsound \{menu_cheat_red}
		loadsound \{menu_cheat_yellow}
		loadsound \{menu_cheat_blue}
		loadsound \{menu_cheat_green}
		loadsound \{gig_complete_sponsor}
		loadsound \{gigcomplete_unlock_item_text_appear}
		loadsound \{gigcomplete_unlock_new_item}
		loadsound \{gig_complete_magazine_in}
		loadsound \{gig_complete_magazine_out}
		loadsound \{gig_unlock}
		loadsound \{ui_gigboard_scroll}
		loadsound \{0x4df25d31}
		loadsound \{soundoptions_menu_reset}
		loadsound \{heavyrocksnare_lvl_12_03}
		loadsound \{menu_gigboard_camerapan_right}
		loadsound \{menu_gigboard_camerapan_left}
		loadsound \{menu_restore_defaults}
		loadsound \{crowd_group_clap_03}
		loadsound \{bad_note2}
		if ($menu_music_on_flag = 1)
			0xdaee51ef
			return
		endif
		return
		case soundboard

		loadsound \{sb_hello}
		loadsound \{sb_hey}
		loadsound \{sb_metallica}
		loadsound \{sb_question}
		loadsound \{sb_killemall}
		loadsound \{sb_feelinggood}
		loadsound \{sb_havingfun}
		loadsound \{sb_youfeelit}
		loadsound \{sb_more1}
		loadsound \{sb_more2}
		loadsound \{sb_more3}
		loadsound \{sb_outthere}
		loadsound \{sb_whatdyousay}
		loadsound \{sb_areyousure1}
		loadsound \{sb_areyousure2}
		loadsound \{sb_ohyeah1}
		loadsound \{sb_ohyeah2}
		loadsound \{sb_ohyeah3}
		loadsound \{sb_yeah1}
		loadsound \{sb_yeah2}
		loadsound \{sb_yeah3}
		loadsound \{sb_yeah4}
		loadsound \{sb_no1}
		loadsound \{sb_no2}
		loadsound \{sb_no3}
		loadsound \{sb_no4}
		loadsound \{sb_goodtohear}
		loadsound \{sb_thatsright}
		return
		default







	endswitch
	getpakmancurrent \{map = zones}
	if (<pak> != z_studio && <pak> != z_studio2 && <pak> != z_tool && <pak> != z_credits && <pak> != z_icecave)
		0x8882d576
		switch <venuesize>
			case 'Small_INT'

			loadsound \{0x7b6ab35c}
			loadsound \{0x52ff2c70}
			loadsound \{0x29f7db07}
			loadsound \{0x9f2b0ce3}
			loadsound \{sm_crowd_neutral_to_good_03}
			loadsound \{sm_crowd_good_to_neutral_03}
			loadsound \{sm_crowd_neutral_to_bad_03}
			loadsound \{sm_crowd_bad_to_neutral_01}
			0x8c8c96bf
			loadsound \{int_sm_crowd_bad_loop}
			loadsound \{int_sm_crowd_good_loop}
			loadsound \{int_sm_crowd_neutral_loop}
			case 'Medium_EXT'

			loadsound \{0x92adc9ae}
			loadsound \{0xcc3f6614}
			loadsound \{0xc030a1f5}
			loadsound \{md_crowd_neutral_to_good_01}
			loadsound \{md_crowd_good_to_neutral_01}
			loadsound \{md_crowd_neutral_to_bad_02}
			loadsound \{md_crowd_bad_to_neutral_01}
			0x8c8c96bf
			loadsound \{ext_md_crowd_bad_loop}
			loadsound \{ext_md_crowd_good_loop}
			loadsound \{ext_md_crowd_neutral_loop}
			case 'Large_EXT'

			loadsound \{0xcd9525fb}
			loadsound \{0x0a0edbfb}
			loadsound \{0x9f084da0}
			loadsound \{lg_crowd_neutral_to_good_01}
			loadsound \{lg_crowd_good_to_neutral_01}
			loadsound \{lg_crowd_neutral_to_bad_01}
			loadsound \{lg_crowd_bad_to_neutral_01}
			0x8c8c96bf
			loadsound \{ext_lg_crowd_bad_loop}
			loadsound \{ext_lg_crowd_good_loop}
			loadsound \{ext_lg_crowd_neutral_loop}
			case 'z_TOOL'

			return
			default

			loadsound \{0x92adc9ae}
			loadsound \{0xcc3f6614}
			loadsound \{0xc030a1f5}
			loadsound \{0xefe527ab}
			loadsound \{md_crowd_neutral_to_good_01}
			loadsound \{md_crowd_good_to_neutral_01}
			loadsound \{md_crowd_neutral_to_bad_02}
			loadsound \{md_crowd_bad_to_neutral_01}
			0x8c8c96bf
			loadsound \{ext_md_crowd_bad_loop}
			loadsound \{ext_md_crowd_good_loop}
			loadsound \{ext_md_crowd_neutral_loop}
		endswitch
	endif
endscript

script 0x4de05aff \{mode = none}
	if ($0x27707361 = jammode)
		0xc1c4e84c \{mode = tutorials
			tutorial = jam}
	elseif ($0x27707361 = battle)
		0xc1c4e84c \{mode = tutorials
			tutorial = battle
			0xd607e2e6 = 1}
	elseif ($0x27707361 != tutorials)
		0xc1c4e84c \{mode = tutorials
			tutorial = 0}
	endif
	if ($0x1d401155 = <mode>)
		return
	endif
	0x113e29bb
	switch <mode>
		case 0xe1bd391d
		0xf6523eff \{sound = 0xc5e020e5}
		0xf6523eff \{sound = 0x82405a35}
		0xf6523eff \{sound = 0xbf207385}
		0xf6523eff \{sound = 0xc8f04294}
		0xf6523eff \{sound = 0xf5906b24}
		0xf6523eff \{sound = 0x33dcdaf0}
		case 0xc5e57ba5
		0xf6523eff \{sound = 0xb3d93626}
		0xf6523eff \{sound = 0xf4794cf6}
		0xf6523eff \{sound = 0xc9196546}
		0xf6523eff \{sound = 0x7b39b956}
		0xf6523eff \{sound = 0x465990e6}
		0xf6523eff \{sound = 0x45e5cc33}
		loadsound \{a_tuning}
		loadsound \{a_string}
		loadsound \{b_tuning}
		loadsound \{b_string}
		loadsound \{d_tuning}
		loadsound \{d_string}
		loadsound \{g_tuning}
		loadsound \{g_string}
		loadsound \{e_tuning}
		loadsound \{e_string}
		case tut_gtr_playnotes
		0xf6523eff \{sound = 0x0fa3f6a3}
		0xf6523eff \{sound = 0x48038c73}
		0xf6523eff \{sound = 0x7563a5c3}
		0xf6523eff \{sound = 0xc74379d3}
		0xf6523eff \{sound = 0xfa235063}
		0xf6523eff \{sound = 0xbe3f7666}
		case 0xc0729a33
		0xf6523eff \{sound = 0xf058a25c}
		0xf6523eff \{sound = 0xb7f8d88c}
		0xf6523eff \{sound = 0x8a98f13c}
		0xf6523eff \{sound = 0x38b82d2c}
		0xf6523eff \{sound = 0x05d8049c}
		0xf6523eff \{sound = 0x41c42299}
		0xf6523eff \{sound = 0x3b0471f9}
		case tut_gtr_diffnotes
		0xf6523eff \{sound = 0xf888e31e}
		0xf6523eff \{sound = 0xbf2899ce}
		0xf6523eff \{sound = 0x8248b07e}
		0xf6523eff \{sound = 0x33d430bb}
		case tut_gtr_longnotes
		0xf6523eff \{sound = 0x47ae6f10}
		0xf6523eff \{sound = 0x000e15c0}
		0xf6523eff \{sound = 0x3d6e3c70}
		0xf6523eff \{sound = 0xf632efd5}
		0xf6523eff \{sound = 0x8cf2bcb5}
		case tut_gtr_chords
		0xf6523eff \{sound = 0xfdba97f4}
		0xf6523eff \{sound = 0xba1aed24}
		0xf6523eff \{sound = 0x877ac494}
		0xf6523eff \{sound = 0x355a1884}
		0xf6523eff \{sound = 0x71463e81}
		case 0x7d371efd
		0xf6523eff \{sound = 0x9650513a}
		0xf6523eff \{sound = 0xd1f02bea}
		0xf6523eff \{sound = 0xec90025a}
		0xf6523eff \{sound = 0x5eb0de4a}
		0xf6523eff \{sound = 0x63d0f7fa}
		0xf6523eff \{sound = 0x24708d2a}
		0xf6523eff \{sound = 0x1910a49a}
		0xf6523eff \{sound = 0x9b40334b}
		0xf6523eff \{sound = 0xa6201afb}
		case 0x24066473
		0xf6523eff \{sound = 0x88fd2b45}
		0xf6523eff \{sound = 0xcf5d5195}
		0xf6523eff \{sound = 0xf23d7825}
		0xf6523eff \{sound = 0x401da435}
		0xf6523eff \{sound = 0x7d7d8d85}
		0xf6523eff \{sound = 0x3addf755}
		0xf6523eff \{sound = 0x07bddee5}
		case 0x96b07169
		0xf6523eff \{sound = 0x30b40048}
		0xf6523eff \{sound = 0x77147a98}
		0xf6523eff \{sound = 0x4a745328}
		0xf6523eff \{sound = 0xf8548f38}
		0xf6523eff \{sound = 0xc534a688}
		0xf6523eff \{sound = 0x8294dc58}
		0xf6523eff \{sound = 0xbff4f5e8}
		0xf6523eff \{sound = 0x0e68752d}
		case 0xe0cd6a6e
		0xf6523eff \{sound = 0xd31417a0}
		0xf6523eff \{sound = 0x94b46d70}
		0xf6523eff \{sound = 0xa9d444c0}
		0xf6523eff \{sound = 0x1bf498d0}
		0xf6523eff \{sound = 0xde0475d1}
		0xf6523eff \{sound = 0xe3645c61}
		case 0xd86aec42
		0xf6523eff \{sound = 0xe4782045}
		0xf6523eff \{sound = 0xa3d85a95}
		0xf6523eff \{sound = 0x9eb87325}
		0xf6523eff \{sound = 0x2c98af35}
		0xf6523eff \{sound = 0x11f88685}
		0xf6523eff \{sound = 0x5658fc55}
		case 0xb90822e3
		0xf6523eff \{sound = 0x4e2e3310}
		0xf6523eff \{sound = 0x098e49c0}
		0xf6523eff \{sound = 0x34ee6070}
		0xf6523eff \{sound = 0x86cebc60}
		0xf6523eff \{sound = 0xbbae95d0}
		0xf6523eff \{sound = 0xfc0eef00}
		0xf6523eff \{sound = 0xc16ec6b0}
		0xf6523eff \{sound = 0x433e5161}
		0xf6523eff \{sound = 0x70f24675}
		case 0xeb8a725d
		0xf6523eff \{sound = 0x98c82bc1}
		0xf6523eff \{sound = 0xdf685111}
		0xf6523eff \{sound = 0x6ef4d1d4}
		case 0x1656087d
		0xf6523eff \{sound = 0xc5c560d8}
		0xf6523eff \{sound = 0x82651a08}
		0xf6523eff \{sound = 0xbf0533b8}
		0xf6523eff \{sound = 0x0d25efa8}
		0xf6523eff \{sound = 0x3045c618}
		0xf6523eff \{sound = 0x77e5bcc8}
		0xf6523eff \{sound = 0x4a859578}
		0xf6523eff \{sound = 0xc8d502a9}
		0xf6523eff \{sound = 0xfb1915bd}
		case 0x59d709ec
		0xf6523eff \{sound = 0x08d71fbc}
		0xf6523eff \{sound = 0x38a7547d}
		case 0x5612d804
		0xf6523eff \{sound = 0x986c4fbb}
		0xf6523eff \{sound = 0xdfcc356b}
		0xf6523eff \{sound = 0xe2ac1cdb}
		0xf6523eff \{sound = 0x508cc0cb}
		0xf6523eff \{sound = 0x29f0cf7e}
		0xf6523eff \{sound = 0x218ae1ee}
		case 0xef6f6ccd
		0xf6523eff \{sound = 0x662a9b3e}
		0xf6523eff \{sound = 0x5b4ab28e}
		0xf6523eff \{sound = 0xe96a6e9e}
		0xf6523eff \{sound = 0xd40a472e}
		0xf6523eff \{sound = 0x93aa3dfe}
		0xf6523eff \{sound = 0xaeca144e}
		0xf6523eff \{sound = 0x2236bd3b}
		0xf6523eff \{sound = 0x1f56948b}
		0xf6523eff \{sound = 0x6596c7eb}
		0xf6523eff \{sound = 0xe7c6503a}
		case 0x78072e40
		0xf6523eff \{sound = 0xda1a3000}
		0xf6523eff \{sound = 0x9dba4ad0}
		0xf6523eff \{sound = 0xa0da6360}
		case 0x2c406cea
		0xf6523eff \{sound = 0xd5ed0beb}
		0xf6523eff \{sound = 0x924d713b}
		0xf6523eff \{sound = 0xaf2d588b}
		0xf6523eff \{sound = 0x1d0d849b}
		0xf6523eff \{sound = 0x206dad2b}
		0xf6523eff \{sound = 0x67cdd7fb}
		0xf6523eff \{sound = 0x5aadfe4b}
		0xf6523eff \{sound = 0xd8fd699a}
		case 0xc215adf7
		0xf6523eff \{sound = 0xcf034d44}
		0xf6523eff \{sound = 0x88a33794}
		0xf6523eff \{sound = 0xb5c31e24}
		0xf6523eff \{sound = 0x07e3c234}
		0xf6523eff \{sound = 0x3a83eb84}
		0xf6523eff \{sound = 0x7d239154}
		0xf6523eff \{sound = 0x4043b8e4}
		0xf6523eff \{sound = 0xc2132f35}
		0xf6523eff \{sound = 0x43ffe431}
		case 0x981b8592
		0xf6523eff \{sound = 0xe6f2f8fa}
		0xf6523eff \{sound = 0xa152822a}
		0xf6523eff \{sound = 0x9c32ab9a}
		0xf6523eff \{sound = 0x2e12778a}
		0xf6523eff \{sound = 0x54d224ea}
		0xf6523eff \{sound = 0x69b20d5a}
		0xf6523eff \{sound = 0xebe29a8b}
		case 0xf3943b1d
		0xf6523eff \{sound = 0x67fd47a5}
		0xf6523eff \{sound = 0x205d3d75}
		0xf6523eff \{sound = 0x1d3d14c5}
		0xf6523eff \{sound = 0xaf1dc8d5}
		0xf6523eff \{sound = 0x927de165}
		0xf6523eff \{sound = 0xd5dd9bb5}
		case 0x21e432f9
		0xf6523eff \{sound = 0xc29205b4}
		0xf6523eff \{sound = 0x85327f64}
		case 0x552293db
		0xf6523eff \{sound = 0xcaf8c5fa}
		0xf6523eff \{sound = 0x8d58bf2a}
		0xf6523eff \{sound = 0xb85256d4}
		0xf6523eff \{sound = 0x13725e3a}
		case 0xe934a14a
		0xf6523eff \{sound = 0x72f18dd4}
		0xf6523eff \{sound = 0x3551f704}
		0xf6523eff \{sound = 0x0831deb4}
		0xf6523eff \{sound = 0xba1102a4}
		0xf6523eff \{sound = 0x87712b14}
		0xf6523eff \{sound = 0xc0d151c4}
		0xf6523eff \{sound = 0xfdb17874}
		case 0x6b3cd028
		0xf6523eff \{sound = 0xd9863b0d}
		0xf6523eff \{sound = 0x9e2641dd}
		0xf6523eff \{sound = 0xa346686d}
		0xf6523eff \{sound = 0x1166b47d}
		0xf6523eff \{sound = 0x2c069dcd}
		0xf6523eff \{sound = 0x6ba6e71d}
		case 0x20c93262
		0xf6523eff \{sound = 0xaeb0aba2}
		0xf6523eff \{sound = 0xe910d172}
		0xf6523eff \{sound = 0xd470f8c2}
		0xf6523eff \{sound = 0x665024d2}
		0xf6523eff \{sound = 0x5b300d62}
		0xf6523eff \{sound = 0x1c9077b2}
		0xf6523eff \{sound = 0x21f05e02}
		case 0x8a8d0dd3
		0xf6523eff \{sound = 0x523b5d26}
		0xf6523eff \{sound = 0x159b27f6}
		0xf6523eff \{sound = 0x28fb0e46}
		0xf6523eff \{sound = 0x9adbd256}
		case 0x376641f6
		0xf6523eff \{sound = 0x0738e183}
		0xf6523eff \{sound = 0x40989b53}
		0xf6523eff \{sound = 0x7df8b2e3}
		0xf6523eff \{sound = 0xcfd86ef3}
		0xf6523eff \{sound = 0xf2b84743}
		0xf6523eff \{sound = 0xb5183d93}
		case 0x457c8934
		0xf6523eff \{sound = 0x4a6714cc}
		0xf6523eff \{sound = 0x0dc76e1c}
		0xf6523eff \{sound = 0x30a747ac}
		0xf6523eff \{sound = 0x82879bbc}
		0xf6523eff \{sound = 0xbfe7b20c}
		0xf6523eff \{sound = 0xf847c8dc}
		0xf6523eff \{sound = 0x477776bd}
		0xf6523eff \{sound = 0x7a175f0d}
		case 0x207d9aa0
		0xf6523eff \{sound = 0xe53a1857}
		0xf6523eff \{sound = 0xa29a6287}
		0xf6523eff \{sound = 0x9ffa4b37}
		0xf6523eff \{sound = 0x2dda9727}
		0xf6523eff \{sound = 0x10babe97}
		0xf6523eff \{sound = 0x571ac447}
		0xf6523eff \{sound = 0x6a7aedf7}
		0xf6523eff \{sound = 0xd54a5396}
		case 0x44c1bb24
		0xf6523eff \{sound = 0xb9f37a8d}
		0xf6523eff \{sound = 0xfe53005d}
		0xf6523eff \{sound = 0xc33329ed}
		case 0x49c7cf70
		0xf6523eff \{sound = 0x83f0d583}
		0xf6523eff \{sound = 0xc450af53}
		0xf6523eff \{sound = 0xf93086e3}
		0xf6523eff \{sound = 0x76707343}
		0xf6523eff \{sound = 0x31d00993}
		0xf6523eff \{sound = 0x0cb02023}
		case tut_vox_hitnotes
		0xf6523eff \{sound = 0xa66dc7b3}
		0xf6523eff \{sound = 0xe1cdbd63}
		0xf6523eff \{sound = 0xdcad94d3}
		0xf6523eff \{sound = 0x6e8d48c3}
		0xf6523eff \{sound = 0x53ed6173}
		0xf6523eff \{sound = 0x144d1ba3}
		0xf6523eff \{sound = 0x292d3213}
		0xf6523eff \{sound = 0xab7da5c2}
		0xf6523eff \{sound = 0x961d8c72}
		0xf6523eff \{sound = 0x50513da6}
		0xf6523eff \{sound = 0x6d311416}
		case 0x00c572aa
		0xf6523eff \{sound = 0xb6cbcdf4}
		0xf6523eff \{sound = 0xf16bb724}
		0xf6523eff \{sound = 0xcc0b9e94}
		0xf6523eff \{sound = 0x7e2b4284}
		case 0x2fb96088
		0xf6523eff \{sound = 0x6484f477}
		0xf6523eff \{sound = 0x23248ea7}
		0xf6523eff \{sound = 0x1e44a717}
		0xf6523eff \{sound = 0xac647b07}
		0xf6523eff \{sound = 0x910452b7}
		0xf6523eff \{sound = 0xd6a42867}
		0xf6523eff \{sound = 0xebc401d7}
		0xf6523eff \{sound = 0x69949606}
		0xf6523eff \{sound = 0x54f4bfb6}
		0xf6523eff \{sound = 0x92b80e62}
		0xf6523eff \{sound = 0xafd827d2}
		case tut_vox_freeform
		0xf6523eff \{sound = 0x7f044b2d}
		0xf6523eff \{sound = 0x38a431fd}
		0xf6523eff \{sound = 0x05c4184d}
		0xf6523eff \{sound = 0xb7e4c45d}
		0xf6523eff \{sound = 0x8a84eded}
		0xf6523eff \{sound = 0xcd24973d}
		0xf6523eff \{sound = 0xf044be8d}
		0xf6523eff \{sound = 0x7214295c}
		0xf6523eff \{sound = 0x4f7400ec}
		0xf6523eff \{sound = 0x8938b138}
		case 0xd2b20a5a
		0xf6523eff \{sound = 0xb5cb4f9c}
		0xf6523eff \{sound = 0x88ab662c}
		0xf6523eff \{sound = 0x3a8bba3c}
		0xf6523eff \{sound = 0x07eb938c}
		0xf6523eff \{sound = 0x404be95c}
		0xf6523eff \{sound = 0x7d2bc0ec}
		0xf6523eff \{sound = 0xff7b573d}
		0xf6523eff \{sound = 0xc21b7e8d}
		0xf6523eff \{sound = 0x0457cf59}
		case 0xa882b65d
		0xf6523eff \{sound = 0xed19df18}
		case 0x257026e0
		0xf6523eff \{sound = 0x9c1a8ae0}
		0xf6523eff \{sound = 0xdbbaf030}
		0xf6523eff \{sound = 0xe6dad980}
		0xf6523eff \{sound = 0x54fa0590}
		case 0xe66ba6da
		0xf6523eff \{sound = 0xfd71835f}
		0xf6523eff \{sound = 0xbad1f98f}
		0xf6523eff \{sound = 0x87b1d03f}
		0xf6523eff \{sound = 0x35910c2f}
		case 0x6607dbe4
		0xf6523eff \{sound = 0x030a6f38}
		0xf6523eff \{sound = 0x44aa15e8}
		0xf6523eff \{sound = 0x79ca3c58}
		0xf6523eff \{sound = 0xcbeae048}
		case 0x83280698
		0xf6523eff \{sound = 0x2452d349}
		0xf6523eff \{sound = 0x63f2a999}
		0xf6523eff \{sound = 0x5e928029}
		0xf6523eff \{sound = 0xecb25c39}
		case 0xee3694eb
		0xf6523eff \{sound = 0xbfe0a88a}
		0xf6523eff \{sound = 0xf840d25a}
		case 0x921f760a
		0xf6523eff \{sound = 0xac83edf1}
		0xf6523eff \{sound = 0xeb239721}
		0xf6523eff \{sound = 0xd643be91}
		case 0xb33bf552
		0xf6523eff \{sound = 0x08526dc8}
		0xf6523eff \{sound = 0x4ff21718}
		case 0xd37d8f70
		0xf6523eff \{sound = 0x165c3130}
		case 0x442f0bde
		0xf6523eff \{sound = 0xe6ad8a7b}
		0xf6523eff \{sound = 0xa10df0ab}
		0xf6523eff \{sound = 0x9c6dd91b}
		0xf6523eff \{sound = 0x2e4d050b}
		0xf6523eff \{sound = 0x132d2cbb}
		0xf6523eff \{sound = 0x548d566b}
		0xf6523eff \{sound = 0x69ed7fdb}
		0xf6523eff \{sound = 0xebbde80a}
		0xf6523eff \{sound = 0xd6ddc1ba}
		0xf6523eff \{sound = 0x1091706e}
		case 0x71e4ed3d
		0xf6523eff \{sound = 0x4dc81f37}
		case 0xf63b22a3
		0xf6523eff \{sound = 0x69aad83d}
		0xf6523eff \{sound = 0x2e0aa2ed}
		0xf6523eff \{sound = 0x136a8b5d}
		0xf6523eff \{sound = 0xa14a574d}
		0xf6523eff \{sound = 0x9c2a7efd}
		0xf6523eff \{sound = 0xdb8a042d}
		0xf6523eff \{sound = 0xe6ea2d9d}
		0xf6523eff \{sound = 0x64baba4c}
		case 0x0c4d5976
		0xf6523eff \{sound = 0x6efdea71}
		0xf6523eff \{sound = 0x295d90a1}
		0xf6523eff \{sound = 0x143db911}
		case 0xbfb45464
		0xf6523eff \{sound = 0x68c1a710}
		0xf6523eff \{sound = 0x2f61ddc0}
		0xf6523eff \{sound = 0x1201f470}
		0xf6523eff \{sound = 0x3b0471f9}
		case 0x9a13e20f
		0xf6523eff \{sound = 0x780853ed}
		0xf6523eff \{sound = 0x3fa8293d}
		0xf6523eff \{sound = 0x02c8008d}
		0xf6523eff \{sound = 0xb0e8dc9d}
		0xf6523eff \{sound = 0x8d88f52d}
		case 0xd7192c28
		0xf6523eff \{sound = 0x7a3eb37a}
		0xf6523eff \{sound = 0x3d9ec9aa}
		0xf6523eff \{sound = 0x00fee01a}
		0xf6523eff \{sound = 0xb2de3c0a}
		0xf6523eff \{sound = 0x8fbe15ba}
		case 0x2d9c02d7
		0xf6523eff \{sound = 0x4573542d}
		0xf6523eff \{sound = 0x02d32efd}
		0xf6523eff \{sound = 0x3fb3074d}
		0xf6523eff \{sound = 0x8d93db5d}
		0xf6523eff \{sound = 0xb0f3f2ed}
		case 0xd4a54e93
		0xf6523eff \{sound = 0xdaf24c8a}
		0xf6523eff \{sound = 0x9d52365a}
		0xf6523eff \{sound = 0xa0321fea}
		0xf6523eff \{sound = 0x1212c3fa}
		0xf6523eff \{sound = 0x2f72ea4a}
		0xf6523eff \{sound = 0x68d2909a}
		0xf6523eff \{sound = 0x55b2b92a}
		0xf6523eff \{sound = 0xff6a9007}
		case 0x569616db
		0xf6523eff \{sound = 0xec1a41e8}
		0xf6523eff \{sound = 0xabba3b38}
		0xf6523eff \{sound = 0x96da1288}
		0xf6523eff \{sound = 0x24face98}
		0xf6523eff \{sound = 0x199ae728}
		0xf6523eff \{sound = 0x5e3a9df8}
		0xf6523eff \{sound = 0x635ab448}
		0xf6523eff \{sound = 0xe10a2399}
		0xf6523eff \{sound = 0xdc6a0a29}
		0xf6523eff \{sound = 0x1a26bbfd}
		0xf6523eff \{sound = 0x2746924d}
		0xf6523eff \{sound = 0x60e6e89d}
		0xf6523eff \{sound = 0x5d86c12d}
		0xf6523eff \{sound = 0xefa61d3d}
		0xf6523eff \{sound = 0xd2c6348d}
		case 0xe6570665
		0xf6523eff \{sound = 0x5681f87f}
		0xf6523eff \{sound = 0x112182af}
		0xf6523eff \{sound = 0x2c41ab1f}
		case 0x332a7f73
		0xf6523eff \{sound = 0x6e6a6057}
		0xf6523eff \{sound = 0x29ca1a87}
		0xf6523eff \{sound = 0xa826d183}
		0xf6523eff \{sound = 0x98569a42}
		0xf6523eff \{sound = 0x2a764652}
		0xf6523eff \{sound = 0xa68aef27}
		0xf6523eff \{sound = 0x9beac697}
		0xf6523eff \{sound = 0x9546f833}
		0xf6523eff \{sound = 0x1ec2e8ec}
		0xf6523eff \{sound = 0x23a2c15c}
		0xf6523eff \{sound = 0x6dd63c82}
		0xf6523eff \{sound = 0xe296c922}
		0xf6523eff \{sound = 0xe12a95f7}
		0xf6523eff \{sound = 0x637a0226}
		0xf6523eff \{sound = 0x5e1a2b96}
		0xf6523eff \{sound = 0x6402bb8c}
		0xf6523eff \{sound = 0xa536b3f2}
		0xf6523eff \{sound = 0xdff6e092}
		0xf6523eff \{sound = 0x50b61532}
		0xf6523eff \{sound = 0x17166fe2}
		0xf6523eff \{sound = 0x0f867562}
		case 0x68081df4
		0xf6523eff \{sound = 0xc1eaeebd}
		0xf6523eff \{sound = 0x864a946d}
		0xf6523eff \{sound = 0xbb2abddd}
		0xf6523eff \{sound = 0x090a61cd}
		case 0x4052c234
		0xf6523eff \{sound = 0xf9ba8f77}
		0xf6523eff \{sound = 0xbe1af5a7}
		0xf6523eff \{sound = 0x837adc17}
		0xf6523eff \{sound = 0x315a0007}
		0xf6523eff \{sound = 0x0c3a29b7}
		0xf6523eff \{sound = 0x4b9a5367}
		0xf6523eff \{sound = 0x76fa7ad7}
		0xf6523eff \{sound = 0xf4aaed06}
		0xf6523eff \{sound = 0xc9cac4b6}
		0xf6523eff \{sound = 0x0f867562}
		0xf6523eff \{sound = 0x32e65cd2}
		0xf6523eff \{sound = 0x75462602}
		0xf6523eff \{sound = 0x48260fb2}
		0xf6523eff \{sound = 0xfa06d3a2}
		0xf6523eff \{sound = 0xc766fa12}
		case 0x4abe0535
		0xf6523eff \{sound = 0xd1b96075}
		0xf6523eff \{sound = 0x96191aa5}
		0xf6523eff \{sound = 0xab793315}
		0xf6523eff \{sound = 0x24face98}
		case 0x70420994
		0xf6523eff \{sound = 0x55f5dd4d}
		0xf6523eff \{sound = 0x1255a79d}
		0xf6523eff \{sound = 0x2f358e2d}
		0xf6523eff \{sound = 0x76fa7ad7}
		0xf6523eff \{sound = 0x0f867562}
		case 0xcf1935b4
		0xf6523eff \{sound = 0xe3228311}
		0xf6523eff \{sound = 0xa482f9c1}
		case 0x8301d424
		0xf6523eff \{sound = 0x50a006cc}
		0xf6523eff \{sound = 0x17007c1c}
		0xf6523eff \{sound = 0x984089bc}
		case 0xed5863b9
		0xf6523eff \{sound = 0x378a1f77}
		0xf6523eff \{sound = 0x702a65a7}
		0xf6523eff \{sound = 0x4d4a4c17}
		0xf6523eff \{sound = 0xc20ab9b7}
		case 0xdcc2ca89
		0xf6523eff \{sound = 0x72db5a76}
		0xf6523eff \{sound = 0x357b20a6}
		0xf6523eff \{sound = 0x081b0916}
		0xf6523eff \{sound = 0x984089bc}
		case 0xcb56d0e4
		0xf6523eff \{sound = 0xd3bfb858}
		0xf6523eff \{sound = 0x941fc288}
		0xf6523eff \{sound = 0xa97feb38}
		0xf6523eff \{sound = 0x1b5f3728}
		case 0x27b37688
		0xf6523eff \{sound = 0x2c71da15}
		0xf6523eff \{sound = 0x6bd1a0c5}
		0xf6523eff \{sound = 0x56b18975}
		case 0x922ea25f
		0xf6523eff \{sound = 0xc880e4ee}
		0xf6523eff \{sound = 0x8f209e3e}
	endswitch
	change 0x1d401155 = <mode>
endscript

script 0xb1ba908a 
	getpakmancurrent \{map = zones}
	0x8882d576
	switch <venuesize>
		case 'Small_INT'
		loadsound \{small_int_encore_crowd}
		loadsound \{0x7b6ab35c}
		loadsound \{int_sm_crowd_good_loop}
		loadsound \{encore_pulsate_neon_loop}
		case 'Medium_EXT'
		loadsound \{medium_ext_encore_crowd}
		loadsound \{0x92adc9ae}
		loadsound \{0xcc3f6614}
		loadsound \{ext_md_crowd_good_loop}
		loadsound \{encore_pulsate_neon_loop}
		case 'Large_EXT'
		loadsound \{large_ext_encore_crowd}
		loadsound \{0xcd9525fb}
		loadsound \{ext_lg_crowd_good_loop}
		loadsound \{encore_pulsate_neon_loop}
	endswitch
endscript
