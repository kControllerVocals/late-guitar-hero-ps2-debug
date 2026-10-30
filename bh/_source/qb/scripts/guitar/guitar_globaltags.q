debug_saves = 0
globaltag_checksum = empty

script reset_globaltags savegame = ($primary_controller)
	globaltag_checksum = initial_v037
	lockglobaltags \{off}
	clearglobaltags savegame = <savegame>
	stars

	stars

	setglobaltags savegame = <savegame> last_singleplayer_character params = {last_singleplayer_character = none}
	setglobaltags savegame = <savegame> last_band_characters params = {
		last_band_characters = [none none none none]
	}
	setglobaltags savegame = <savegame> last_h2h_characters params = {
		last_h2h_characters = [none none]
	}
	setupsongtags savegame = <savegame> globaltag_checksum = <globaltag_checksum> part = 'guitar'
	setupsongtags savegame = <savegame> globaltag_checksum = <globaltag_checksum> part = 'bass'
	setupsongtags savegame = <savegame> globaltag_checksum = <globaltag_checksum> part = 'drum'
	setupsongtags savegame = <savegame> globaltag_checksum = <globaltag_checksum> part = 'vocals' topscores = ($vocals_topscores)
	setupsongtags savegame = <savegame> globaltag_checksum = <globaltag_checksum> part = 'band'
	setup_venuetags savegame = <savegame> globaltag_checksum = <globaltag_checksum>
	get_progression_globals \{career_guitar}
	setup_gigtags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = guitar
	get_progression_globals \{career_bass}
	setup_gigtags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = bass
	get_progression_globals \{career_drum}
	setup_gigtags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = drum
	get_progression_globals \{career_vocals}
	setup_gigtags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = vocals
	get_progression_globals \{career_band}
	setup_gigtags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = band
	get_progression_globals \{career_guitar}
	setup_setlisttags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = guitar
	get_progression_globals \{career_bass}
	setup_setlisttags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = bass
	get_progression_globals \{career_drum}
	setup_setlisttags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = drum
	get_progression_globals \{career_vocals}
	setup_setlisttags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = vocals
	get_progression_globals \{career_band}
	setup_setlisttags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = band
	setup_quickplay_song_tags savegame = <savegame> allsongs
	get_progression_globals \{career_guitar}
	setup_quickplay_song_tags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = guitar
	get_progression_globals \{career_bass}
	setup_quickplay_song_tags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = bass
	get_progression_globals \{career_drum}
	setup_quickplay_song_tags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = drum
	get_progression_globals \{career_vocals}
	setup_quickplay_song_tags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = vocals
	get_progression_globals \{career_band}
	setup_quickplay_song_tags savegame = <savegame> setlist_songs = <tier_global> globaltag_checksum = <globaltag_checksum> part = band
	setup_bandtags savegame = <savegame> globaltag_checksum = <globaltag_checksum>
	setup_user_option_tags savegame = <savegame> globaltag_checksum = <globaltag_checksum>
	setup_training_tags savegame = <savegame> globaltag_checksum = <globaltag_checksum>
	setup_unlocks savegame = <savegame> globaltag_checksum = <globaltag_checksum>
	setup_custom_character_tags savegame = <savegame> globaltag_checksum = <globaltag_checksum>
	reset_transient_tags savegame = <savegame>
	setup_cas_helper_tags savegame = <savegame> globaltag_checksum = <globaltag_checksum>
	setup_saved_instrument_tags savegame = <savegame> globaltag_checksum = <globaltag_checksum>
	restore_globals_from_global_tags savegame = <savegame> callmonitorcontrollerstates = 0
	setglobaltags savegame = <savegame> globaltag_checksum params = {globaltag_checksum = <globaltag_checksum>}
	change globaltag_checksum = <globaltag_checksum>
	setglobaltags savegame = <savegame> check_guid params = {user_id0 = -1 user_id1 = -1}
	setarrayelement arrayname = globaltags_to_invalidate globalarray index = <savegame> newvalue = 0
	lockglobaltags
endscript

script reset_globaltags_all 
	reset_globaltags \{savegame = 0}
	get_num_globaltag_sets
	if (<num_globaltag_sets> > 1)
		savegame = 1
		begin

		clearglobaltags savegame = <savegame>
		copyglobaltags from = 0 to = <savegame>
		jam_reset_controller_directory_listing savegame = <savegame>
		setarrayelement arrayname = globaltags_to_invalidate globalarray index = <savegame> newvalue = 0
		<savegame> = (<savegame> + 1)
		repeat (<num_globaltag_sets> - 1)
	endif
endscript

script init_globaltags 
	max_globaltag_structs = 8000
	pushmemprofile \{'globaltags'}
	getarraysize ($instrument_progression_list)
	instrument_size = <array_size>
	initglobaltags max_sets = <globaltag_sets> max_structs = <max_globaltag_structs> max_cars = ($max_num_create_a_rockers)
	popmemprofile
endscript

script get_num_globaltag_sets 
	getmaxplayers
	if ((isps3) || (isps2) || (isngc))
		return \{num_globaltag_sets = 1}
	else
		return num_globaltag_sets = <max_players>
	endif
endscript
globaltags_to_invalidate = [
	0
	0
	0
	0
]

script mark_globaltags_to_invalidate \{savegame = 0}
	setarrayelement arrayname = globaltags_to_invalidate globalarray index = <savegame> newvalue = 1
endscript

script invalidate_globaltags 
	savegame = 0
	begin
	if ($globaltags_to_invalidate [<savegame>])
		reset_globaltags savegame = <savegame>
	endif
	savegame = (<savegame> + 1)
	repeat 4
endscript
default_topscores = [
	{
		scores = [
			19737
			18164
			17809
		]
	}
	{
		scores = [
			19737
			18164
			17809
		]
	}
	{
		scores = [
			46322
			41217
			39989
		]
	}
	{
		scores = [
			54046
			49787
			41256
		]
	}
	{
		scores = [
			64289
			61986
			55423
		]
	}
]
vocals_topscores = [
	{
		scores = [
			5239
			3782
			2457
		]
	}
	{
		scores = [
			11363
			8744
			5521
		]
	}
	{
		scores = [
			16963
			12634
			8628
		]
	}
	{
		scores = [
			22008
			17523
			12241
		]
	}
	{
		scores = [
			25326
			20546
			15136
		]
	}
]
default_songtags = {
}
default_songtags_with_difficulty = {
	tr_stars = [
		0
		0
		0
	]
	bestscore = 0
	beststars = 0
	tr_percent100 = 0
	tr_double_bass_complete = 0
	double_bass_complete = 0
	stars = 0
	score = 0
	percent100 = 0
	unlocked = 1
}

script setup_custom_character_tags 
	globaltag_createarray globaltag_checksum = <globaltag_checksum> savegame = <savegame> array_name = custom_profiles max_size = ($max_num_create_a_rockers) packtype = createarocker
	getarraysize \{$preset_musician_profiles_modifiable}
	globaltag_createarray globaltag_checksum = <globaltag_checksum> savegame = <savegame> array_name = preset_profiles max_size = <array_size> packtype = presetcars start_full
	i = 0
	begin
	globaltag_set_preset_musician savegame = <savegame> index = <i> appearance = ($preset_musician_profiles_modifiable [<i>].appearance)
	globaltag_checksum = (<globaltag_checksum> + ($preset_musician_profiles_modifiable [<i>].name))
	i = (<i> + 1)
	repeat <array_size>
	return globaltag_checksum = <globaltag_checksum>
endscript

script get_formatted_songname \{part = 'guitar'}
	formattext checksumname = songname '%s%p%d' s = (<song_prefix>) p = <part> d = <difficulty_text_nl> addtostringlookup = true
	return songname = <songname>
endscript

script get_formatted_songname_for_jam_mode 
	if NOT gotparam \{part}
		part = 'guitar'
	endif
	formattext textname = songname '%s_%p_%d_quickplay' s = (<song_prefix>) p = <part> d = <difficulty_text_nl> addtostringlookup = true
	formattext checksumname = songname2 '%s' s = <songname> addtostringlookup = true
	return songname = <songname2>
endscript
default_venuetags = {
	unlocked = 0
}
cheat_venuetags = {
	unlocked = 1
}

script setup_venuetags 
	setup_generalvenuetags savegame = <savegame>
	getarraysize \{$levelzonearray}
	level_zone_array_size = <array_size>
	index = 0
	begin
	getarraysize \{$instrument_progression_list}
	instrument_size = <array_size>
	instrument_index = 0
	begin
	if gotparam \{cheat}
		venue_tags = $cheat_venuetags
	else
		venue_tags = $default_venuetags
	endif
	get_levelzonearray_checksum index = <index>
	if NOT structurecontains structure = ($levelzones.<level_checksum>) debug_only
		get_progression_globals ($instrument_progression_list [<instrument_index>])
		formattext {
			checksumname = venue_checksum
			'%s_%i'
			s = ($levelzones.<level_checksum>.name)
			i = ($instrument_list.($<tier_global>.part).text_nl)
			addtostringlookup = true
		}
		getarraysize ($0xd659dea8.unlocked_levels)
		if (<array_size> > 0)
			if NOT (<level_checksum> = load_z_tushino)
				i = 0
				begin
				if (($0xd659dea8.unlocked_levels [<i>]) = <level_checksum>)
					venue_tags = {<venue_tags> unlocked = 1}
					break
				endif
				i = (<i> + 1)
				repeat <array_size>
			endif
		endif
		setglobaltags savegame = <savegame> <venue_checksum> params = {(<venue_tags>)} packtype = unlockedtags
		if gotparam \{globaltag_checksum}
			<globaltag_checksum> = (<globaltag_checksum> + <venue_checksum>)
		endif
	endif
	<instrument_index> = (<instrument_index> + 1)
	repeat <instrument_size>
	<index> = (<index> + 1)
	repeat <level_zone_array_size>
	k = 0
	begin
	switch <k>
		case 0
		tier_global = gh4_career_guitar_songs
		case 1
		tier_global = gh4_career_bass_songs
		case 2
		tier_global = gh4_career_drum_songs
		case 3
		tier_global = gh4_career_vocals_songs
		case 4
		tier_global = gh4_career_band_songs
	endswitch
	e = 0
	begin
	num_gigs = ($<tier_global>.num_tiers)
	i = 0
	begin
	formattext checksumname = tier 'tier%n' n = (<i> + 1)
	if structurecontains structure = ($<tier_global>.<tier>) 0x29c8d5a6
		getarraysize ($<tier_global>.<tier>.0x29c8d5a6)
		j = 0
		begin
		format_globaltag_song_checksum part = ($<tier_global>.part) song = ($<tier_global>.<tier>.0x29c8d5a6 [<j>]) difficulty = ($difficulty_list [<e>])
		setglobaltags <song_checksum> all_active_players = 1 params = {unlocked = 0}
		<j> = (<j> + 1)
		repeat <array_size>
	endif
	if structurecontains structure = ($<tier_global>.<tier>) songs
		getarraysize ($<tier_global>.<tier>.songs)
		h = 0
		begin
		format_globaltag_song_checksum part = ($<tier_global>.part) song = ($<tier_global>.<tier>.songs [<h>]) difficulty = ($difficulty_list [<e>])
		setglobaltags <song_checksum> all_active_players = 1 params = {unlocked = 1}
		<h> = (<h> + 1)
		repeat <array_size>
	endif
	<i> = (<i> + 1)
	repeat <num_gigs>
	<e> = (<e> + 1)
	repeat 5
	<k> = (<k> + 1)
	repeat 5
	if gotparam \{globaltag_checksum}
		return globaltag_checksum = <globaltag_checksum>
	endif
endscript

script setup_generalvenuetags 
	get_levelzonearray_size
	level_size = <array_size>
	array_count = 0
	begin
	get_levelzonearray_checksum index = <array_count>
	if NOT structurecontains structure = ($levelzones.<level_checksum>) debug_only
		unlocked = 1
		formattext checksumname = venue_checksum 'venue_%s' s = ($levelzones.<level_checksum>.name) addtostringlookup = true
		getarraysize ($0xd659dea8.unlocked_levels)
		if (<array_size> > 0)
			i = 0
			begin
			if (($0xd659dea8.unlocked_levels [<i>]) = <level_checksum>)
				unlocked = 1
				break
			endif
			i = (<i> + 1)
			repeat <array_size>
		endif
		if NOT getglobaltags savegame = <savegame> <venue_checksum> noassert = 1
			setglobaltags savegame = <savegame> <venue_checksum> params = {($default_venuetags) unlocked = <unlocked>} packtype = unlockedtags
		endif
	endif
	array_count = (<array_count> + 1)
	repeat <level_size>
endscript
default_charactertags = {
	unlocked = 0
	unlocked_on_other_client = 0
	available_on_other_client = 0
}
default_songsetlisttags = {
	stars = 0
	score = 0
	percent100 = 0
	unlocked = 0
	new_song_info = 0
}

script setup_setlisttags \{globaltag_checksum = none
		force = 0
		songlist = gh5_songlist
		download = 0}
	if (<download> = 1)
		return globaltag_checksum = <globaltag_checksum>
	endif
	if gotparam \{setlist_songs}
		tier_count = 1
		begin
		formattext checksumname = tier 'tier%d' d = <tier_count>
		defaultunlocked = 0
		unlockall = 0
		if structurecontains structure = ($<setlist_songs>.<tier>) defaultunlocked
			<defaultunlocked> = 1
		elseif structurecontains structure = ($<setlist_songs>.<tier>) unlockall
			<unlockall> = 1
		endif
		if (<defaultunlocked> = 1 || <unlockall> = 1)
			tier_song_count = 0
			getarraysize ($<setlist_songs>.<tier>.songs)
			tier_song_size = <array_size>
			if (<tier_song_size> > 0)
				begin
				if (<defaultunlocked> = 1)
					unlock_size = ($<setlist_songs>.<tier>.defaultunlocked)
				else (<unlockall> = 1)
					unlock_size = -1
				endif
				if (<tier_song_count> < <unlock_size> || <unlock_size> = -1)
					difficulty_index = 0
					getarraysize \{$difficulty_list}
					difficulty_size = <array_size>
					begin
					format_globaltag_song_checksum part = <part> song = ($<setlist_songs>.<tier>.songs [<tier_song_count>]) difficulty_index = <difficulty_index>
					setglobaltags savegame = <savegame> <song_checksum> params = {unlocked = 1}
					<difficulty_index> = (<difficulty_index> + 1)
					repeat <difficulty_size>
				endif
				<tier_song_count> = (<tier_song_count> + 1)
				repeat <tier_song_size>
			endif
		endif
		<tier_count> = (<tier_count> + 1)
		repeat ($<setlist_songs>.num_tiers)
	endif
	return globaltag_checksum = <globaltag_checksum>
endscript
default_bandtags = {
	cash = 100000
	career_earnings = 100
	name = qs(0x03ac90f0)
	font = fontgrid_text_a6
	save_created = 0
	first_play = 1
	first_venue_movie_played = 0
	first_quickplay_setlist = 1
	first_career_setlist = 1
	first_setlist_drum = 1
	finalbandintro_transition_played_band = 0
	finalbandintro_transition_played_bass = 0
	finalbandintro_transition_played_drum = 0
	finalbandintro_transition_played_guitar = 0
	finalbandintro_transition_played_vocals = 0
	first_instrument_career_guitar = 0
	first_instrument_career_bass = 0
	first_instrument_career_drum = 0
	first_instrument_career_vocals = 0
	career_intro_guitar_complete = 0
	career_intro_bass_complete = 0
	career_intro_drum_complete = 0
	career_intro_vocals_complete = 0
	career_intro_band_complete = 0
	career_credits_guitar_complete = 0
	career_credits_bass_complete = 0
	career_credits_drum_complete = 0
	career_credits_vocals_complete = 0
	career_credits_band_complete = 0
	career_guitar_movies_played = 0
	career_bass_movies_played = 0
	career_drum_movies_played = 0
	career_vocals_movies_played = 0
	career_band_movies_played = 0
	career_guitar_ice_movie_played = 0
	career_bass_ice_movie_played = 0
	career_drum_ice_movie_played = 0
	career_vocals_ice_movie_played = 0
	career_band_ice_movie_played = 0
	career_guitar_stone_movie_played = 0
	career_bass_stone_movie_played = 0
	career_drum_stone_movie_played = 0
	career_vocals_stone_movie_played = 0
	career_band_stone_movie_played = 0
	career_guitar_prev_total_songs = 0
	career_bass_prev_total_songs = 0
	career_drum_prev_total_songs = 0
	career_vocals_prev_total_songs = 0
	career_band_prev_total_songs = 0
	band_unique_id = non_existent_checksum
	band_logo = [
	]
	purchased_profiles = [
	]
	got_sponsored_band_t1 = 0
	got_sponsored_band_t2 = 0
	got_sponsored_band_t3 = 0
	got_sponsored_band_t4 = 0
	got_sponsored_band_t5 = 0
	got_sponsored_band_t6 = 0
	got_sponsored_band_t7 = 0
	got_sponsored_band_t8 = 0
	got_sponsored_band_t9 = 0
	got_sponsored_band_t10 = 0
	got_sponsored_band_t11 = 0
	got_sponsored_band_t12 = 0
	got_sponsored_guitar_t1 = 0
	got_sponsored_guitar_t2 = 1
	got_sponsored_guitar_t3 = 0
	got_sponsored_guitar_t4 = 1
	got_sponsored_guitar_t5 = 0
	got_sponsored_guitar_t6 = 0
	got_sponsored_guitar_t7 = 1
	got_sponsored_guitar_t8 = 0
	got_sponsored_guitar_t9 = 1
	got_sponsored_guitar_t10 = 0
	got_sponsored_guitar_t11 = 1
	got_sponsored_guitar_t12 = 1
	got_sponsored_bass_t1 = 0
	got_sponsored_bass_t2 = 1
	got_sponsored_bass_t3 = 0
	got_sponsored_bass_t4 = 1
	got_sponsored_bass_t5 = 0
	got_sponsored_bass_t6 = 0
	got_sponsored_bass_t7 = 1
	got_sponsored_bass_t8 = 0
	got_sponsored_bass_t9 = 1
	got_sponsored_bass_t10 = 0
	got_sponsored_bass_t11 = 1
	got_sponsored_bass_t12 = 1
	got_sponsored_drum_t1 = 0
	got_sponsored_drum_t2 = 0
	got_sponsored_drum_t3 = 0
	got_sponsored_drum_t4 = 1
	got_sponsored_drum_t5 = 1
	got_sponsored_drum_t6 = 0
	got_sponsored_drum_t7 = 1
	got_sponsored_drum_t8 = 0
	got_sponsored_drum_t9 = 1
	got_sponsored_drum_t10 = 0
	got_sponsored_drum_t11 = 1
	got_sponsored_drum_t12 = 1
	got_sponsored_vocals_t1 = 0
	got_sponsored_vocals_t2 = 1
	got_sponsored_vocals_t3 = 1
	got_sponsored_vocals_t4 = 1
	got_sponsored_vocals_t5 = 1
	got_sponsored_vocals_t6 = 0
	got_sponsored_vocals_t7 = 1
	got_sponsored_vocals_t8 = 1
	got_sponsored_vocals_t9 = 1
	got_sponsored_vocals_t10 = 1
	got_sponsored_vocals_t11 = 1
	got_sponsored_vocals_t12 = 1
	att_ballpark_band = 0
	att_ballpark_guitar = 0
	att_ballpark_bass = 0
	att_ballpark_drum = 0
	att_ballpark_vocals = 0
	load_z_meadowlands = 0
	load_z_justice = 0
	load_z_mop = 0
	load_z_donnington = 0
	load_z_forum = 0
	load_z_tushino = 0
	load_z_stone = 0
	load_z_icecave = 0
	load_z_studio2 = 0
	load_z_soundcheck2 = 0
}
default_progressiontags = {
	current_difficulty = easy
	current_tier = 1
	current_song_count = 0
	encore_song = none
	career_play_song_and_end = 0
	career_using_createagig = 0
}

script setup_bandtags 
	if ($num_career_bands > 1)
		band_count = 0
		begin
		get_band_info band_index = (<band_count> + 1)
		setglobaltags savegame = <savegame> <band_info> params = {($default_bandtags)}
		<band_count> = (<band_count> + 1)
		repeat ($num_career_bands + 1)
	else
		get_band_info
		setglobaltags savegame = <savegame> <band_info> params = {($default_bandtags)}
	endif
	setglobaltags savegame = <savegame> progression params = {$default_progressiontags}
endscript
override_audio_lag = -1
override_video_lag = -1

script setup_user_option_tags 
	setglobaltags savegame = <savegame> user_options params = {
		volumes = {
			guitar = {
				mic = {vol = 7 comp = 1 rev = 2}
				vocals = {vol = 7}
				backup = {vol = 7}
				guitar = {vol = 7 eq = 2}
				bass = {vol = 7 eq = 2}
				drum = {vol = 7 eq = 2}
				crowd = {vol = 7}
				sfx = {vol = 7}
				band = {vol = 7}
			}
		}
		dolby_digital = 0
		autosave = 1
		ps2_stereo_sound = 1
		ps2_widescreen = 1
		lefty_flip_save = 0
		use_tilt_for_starpower_save = 1
		enable_touch_strip_save = 1
		lefty_flip_p1 = 0
		lefty_flip_p2 = 0
		lefty_flip_p3 = 0
		lefty_flip_p4 = 0
		hyperspeed_guitar = 1.0
		hyperspeed_bass = 1.0
		hyperspeed_drum = 1.0
		airinstruments = 0
		invisiblecharacters = 0
		gem_set = standard_gems
		fx_set = standard_fx
		star_set = standard_stars
		unpause_count = 1
		lag_calibration = 0.0
		has_calibrated = 0
		resting_whammy_position_device_0 = -0.76
		resting_whammy_position_device_1 = -0.76
		resting_whammy_position_device_2 = -0.76
		resting_whammy_position_device_3 = -0.76
		resting_whammy_position_device_4 = -0.76
		resting_whammy_position_device_5 = -0.76
		resting_whammy_position_device_6 = -0.76
		star_power_position_device_0 = -1.0
		star_power_position_device_1 = -1.0
		star_power_position_device_2 = -1.0
		star_power_position_device_3 = -1.0
		star_power_position_device_4 = -1.0
		star_power_position_device_5 = -1.0
		star_power_position_device_6 = -1.0
		gamma_brightness = 5
		vocals_highway_view_save = scrolling
		vocals_sp_clap_save = 1
		ghtunes_num_songs_rated = 0
		unlock_cheat_contestwinner1 = 0
		unlock_cheat_alwaysslide = 0
		unlock_cheat_airinstruments = 0
		unlock_cheat_invisiblecharacters = 0
		unlock_cheat_snobcrowd = 0
		unlock_cheat_performancemode = 0
		unlock_cheat_hyperspeed = 1
		unlock_cheat_autokick = 0
		unlock_cheat_freedrum = 1
		unlock_cheat_gemcolor = 0
		unlock_cheat_flamecolor = 0
		unlock_cheat_starcolor = 0
		unlock_cheat_vocalfireball = 0
		unlock_cheat_unlockallcharacters = 0
		unlock_cheat_invincible = 1
		unlock_cheat_allhopos = 0
		unlock_cheat_focusmode = 0
		unlock_cheat_hudfreemode = 0
		cheat_index0 = 0
		cheat_index1 = 0
		cheat_index2 = 0
		cheat_index3 = 0
		cheat_index4 = 0
		cheat_index5 = 0
		cheat_index6 = 0
		cheat_index7 = 0
		cheat_index8 = 0
		cheat_index9 = 0
		cheat_index10 = 0
		cheat_index11 = 0
		cheat_index12 = 0
		cheat_index13 = 0
		cheat_index14 = 0
		cheat_index15 = 0
		cheat_index16 = 0
		cheat_index17 = 0
		cheat_index18 = 0
		cheat_index19 = 0
		cheat_index20 = 0
		cheat_index21 = 0
		cheat_index22 = 0
		cheat_index23 = 0
		cheat_index24 = 0
		cheat_index25 = 0
		cheat_index26 = 0
		cheat_index27 = 0
		cheat_index28 = 0
		cheat_index29 = 0
		cheat_index30 = 0
	}
	if NOT ($override_audio_lag = -1 || $override_video_lag = -1)
		if ($override_audio_lag > 200)
			change \{override_audio_lag = 200}
		endif
		if ($override_video_lag > 200)
			change \{override_video_lag = 200}
		endif
		lag_calibration = (($override_audio_lag * 1000) + 1000)
		setglobaltags savegame = <savegame> user_options params = {lag_calibration = <lag_calibration>}
		setglobaltags savegame = <savegame> user_options params = {lag_calibration = (<lag_calibration> + $override_video_lag)}
	endif
endscript

script setup_training_tags 
	setglobaltags savegame = <savegame> practice params = {basic_lesson = not_complete
		star_power_lesson = not_complete
		advanced_techniques_lesson = not_complete
		new_features_lesson = not_complete
		drum_basic_lesson = not_complete
		drum_int_lesson = not_complete
		vocals_lesson = not_complete
		band_lesson = not_complete
		versus_lesson = not_complete
		has_prompt_guitar_tutorial = not_complete
		has_prompt_bass_tutorial = not_complete
		has_prompt_drum_tutorial = not_complete
		has_prompt_vocal_tutorial = not_complete
		rs_introduction_lesson = not_complete
		rs_lead_and_bass_lesson = not_complete
		rs_rhythm_lesson = not_complete
		rs_drums_lesson = not_complete
		rs_melody_lesson = not_complete
		rs_recording_lesson = not_complete
		rs_pro_guitar_lesson = not_complete
		rs_advanced_tools_lesson = not_complete
		rs_ghmix_editing_lesson = not_complete
		rs_ghmix_pro_techniques_tools_lesson = not_complete
	}
endscript

script write_globals_to_global_tags 
endscript

script globaltag_set_preset_musician 

	dest_appearance = {}
	cascopyselectiveparts \{src_appearance_name = appearance
		dest_appearance_name = dest_appearance
		part_array_name = modifiable_preset_musician_parts
		0xb1ce14d5}
	cascopyselectiveparts \{src_appearance_name = appearance
		dest_appearance_name = dest_appearance
		part_array_name = modifiable_preset_musician_instrument_parts
		0xb1ce14d5}
	globaltag_setarrayelement savegame = <savegame> array_name = preset_profiles index = <index> element = <dest_appearance>
endscript

script globaltag_get_preset_musician 

	globaltag_getarrayelement savegame = <savegame> array_name = preset_profiles index = <index>
	dest_appearance = (<profile_struct>.appearance)
	cascopyselectiveparts \{src_appearance_name = element
		dest_appearance_name = dest_appearance
		part_array_name = modifiable_preset_musician_parts}
	cascopyselectiveparts \{src_appearance_name = element
		dest_appearance_name = dest_appearance
		part_array_name = modifiable_preset_musician_instrument_parts}
	return profile_struct = {<profile_struct> appearance = <dest_appearance>}
endscript

script get_checksum_of_modified_appearance 

	dest_appearance = {}
	cascopyselectiveparts \{src_appearance_name = appearance
		dest_appearance_name = dest_appearance
		part_array_name = modifiable_preset_musician_parts}
	cascopyselectiveparts \{src_appearance_name = appearance
		dest_appearance_name = dest_appearance
		part_array_name = modifiable_preset_musician_instrument_parts}
	generatechecksumfromstruct struct = <dest_appearance>
	return checksum = <structure_checksum>
endscript

script globaltag_check_preset_musician_modified 

	get_checksum_of_modified_appearance appearance = (($preset_musician_profiles_modifiable [<index>]).appearance)
	original_checksum = <checksum>
	globaltag_get_preset_musician savegame = <savegame> profile_struct = ($preset_musician_profiles_modifiable [<index>]) index = <index>
	get_checksum_of_modified_appearance appearance = (<profile_struct>.appearance)
	if (<original_checksum> = <checksum>)
		return \{false}
	endif
	return \{true}
endscript

script restore_globals_from_global_tags \{callmonitorcontrollerstates = 1}
	if gotparam \{savegame}
		savegame_to_reset = <savegame>
	else
		savegame_to_reset = -1
	endif
	<i> = 1
	begin
	getplayerinfo player = <i> controller
	get_savegame_from_controller controller = <controller>
	getglobaltags savegame = <savegame> user_options
	<player_status> = ($0x2994109a [<i>])
	change structurename = <player_status> lefty_flip = <lefty_flip_save>
	change structurename = <player_status> vocals_highway_view = <vocals_highway_view_save>
	change structurename = <player_status> vocals_sp_clap = <vocals_sp_clap_save>
	change structurename = <player_status> use_tilt_for_starpower = <use_tilt_for_starpower_save>
	change structurename = <player_status> enable_touch_strip = <enable_touch_strip_save>
	if (<i> = 1)
		if (<ps2_stereo_sound> = 1)
			0xf2b96a22 \{1}
		else
			0xf2b96a22 \{0}
		endif
	endif
	<i> = (<i> + 1)
	repeat 4
	getglobaltags \{user_options}
	if (<callmonitorcontrollerstates> = 1)
		monitorcontrollerstates
	endif
endscript

script reset_transient_tags 
	setglobaltags savegame = <savegame> venue_intro_flags params = {
		z_meadowlands = 0
		z_justice = 0
		z_mop = 0
		z_donnington = 0
		z_forum = 0
		z_tushino = 0
		z_stone = 0
		z_icecave = 0
		z_studio2 = 0
		z_studio = 0
		z_soundcheck2 = 0
	}
endscript

script setup_unlocks \{globaltag_checksum = none}
	getarraysize ($bonus_videos)
	index = 0
	begin
	unlocked = 1
	if NOT structurecontains structure = ($bonus_videos [<index>]) unlocked
		unlocked = 0
	endif
	video_checksum = ($bonus_videos [<index>].id)
	setglobaltags savegame = <savegame> <video_checksum> params = {unlocked = <unlocked>} packtype = unlockedtags
	globaltag_checksum = (<globaltag_checksum> + <video_checksum>)
	<index> = (<index> + 1)
	repeat <array_size>
	return globaltag_checksum = <globaltag_checksum>
endscript

script globaltags_unlockall songs_only = 0 difficulty = ($player1_status.difficulty)
	get_savegame_from_controller controller = ($primary_controller)
	if NOT (<songs_only> = 1)
		array_count = 0
		getarraysize \{$preset_musician_profiles_locked}
		if (<array_size>)
			begin
			if structurecontains structure = ($preset_musician_profiles_locked [<array_count>]) locked
				unlock_profile id = ($preset_musician_profiles_locked [<array_count>].name) savegame = <savegame>
			endif
			array_count = (<array_count> + 1)
			repeat <array_size>
		endif
		array_count = 0
		getarraysize \{$bonus_videos}
		if (<array_size>)
			begin
			setglobaltags savegame = <savegame> ($bonus_videos [<array_count>].id) params = {unlocked = 1}
			array_count = (<array_count> + 1)
			repeat <array_size>
		endif
	endif
	array_count = 0
	begin
	setlist_prefix = ($<songlist>.prefix)
	formattext checksumname = tiername '%ptier%i' p = <setlist_prefix> i = (<array_count> + 1)
	formattext checksumname = tier_checksum 'tier%s' s = (<array_count> + 1)
	if NOT globalexists name = <songlist> type = structure

	endif
	if NOT structurecontains structure = ($<songlist>) <tier_checksum>

	endif
	if NOT structurecontains structure = ($<songlist>.<tier_checksum>) songs

	endif
	getarraysize ($<songlist>.<tier_checksum>.songs)
	song_count = 0
	begin
	setlist_prefix = ($<songlist>.prefix)
	format_globaltag_song_checksum part = ($<songlist>.part) song = ($<songlist>.<tier_checksum>.songs [<song_count>]) difficulty = <difficulty>
	stars = 5
	if (<song_count> = <array_size> - 1)
		if structurecontains structure = ($<songlist>.<tier_checksum>) end_with_credits
			stars = 0
		endif
	endif
	if (<songs_only> = 1)
		setglobaltags savegame = <savegame> <song_checksum> params = {unlocked = 1}
	else
		setglobaltags savegame = <savegame> <song_checksum> params = {stars = <stars>
			score = 1000000
			unlocked = 1}
		get_difficulty_text_nl difficulty = <difficulty>
		get_song_prefix song = ($<songlist>.<tier_checksum>.songs [<song_count>])
		get_formatted_songname song_prefix = <song_prefix> difficulty_text_nl = <difficulty_text_nl>
	endif
	song_count = (<song_count> + 1)
	repeat <array_size>
	if structurecontains structure = ($<songlist>.<tier_checksum>) 0x29c8d5a6
		getarraysize ($<songlist>.<tier_checksum>.0x29c8d5a6)
		<song_count> = 0
		begin
		setlist_prefix = ($<songlist>.prefix)
		format_globaltag_song_checksum part = ($<songlist>.part) song = ($<songlist>.<tier_checksum>.0x29c8d5a6 [<song_count>]) difficulty = <difficulty>
		stars = 5
		if (<song_count> = <array_size> - 1)
			if structurecontains structure = ($<songlist>.<tier_checksum>) end_with_credits
				stars = 0
			endif
		endif
		if (<songs_only> = 1)
			setglobaltags savegame = <savegame> <song_checksum> params = {unlocked = 1}
		else
			setglobaltags savegame = <savegame> <song_checksum> params = {stars = <stars>
				score = 1000000
				unlocked = 1}
			get_difficulty_text_nl difficulty = <difficulty>
			get_song_prefix song = ($<songlist>.<tier_checksum>.0x29c8d5a6 [<song_count>])
			get_formatted_songname song_prefix = <song_prefix> difficulty_text_nl = <difficulty_text_nl>
		endif
		song_count = (<song_count> + 1)
		repeat <array_size>
	endif
	array_count = (<array_count> + 1)
	repeat ($<songlist>.num_tiers)
	setup_venuetags \{cheat}
endscript
instrument_progression_list = [
	career_guitar
	career_bass
	career_drum
	career_vocals
	career_band
]
instrument_progression_list_nl_strings = {
	career_guitar = 'guitar'
	career_bass = 'bass'
	career_drum = 'drum'
	career_vocals = 'vocals'
	career_band = 'band'
}
unlock_order_list = [
	gh4_career_guitar_progression_unlock_order
	gh4_career_bass_progression_unlock_order
	gh4_career_drum_progression_unlock_order
	gh4_career_vocals_progression_unlock_order
	gh4_career_band_progression_unlock_order
]

script get_minimum_difficulty \{difficulty1 = easy
		difficulty2 = easy}
	if (<difficulty1> = <difficulty2>)
		return minimum_difficulty = <difficulty1>
	else
		switch <difficulty1>
			case easy
			return \{minimum_difficulty = easy}
			case medium
			if (<difficulty2> = easy)
				return \{minimum_difficulty = easy}
			else
				return \{minimum_difficulty = medium}
			endif
			case hard
			switch <difficulty2>
				case easy
				return \{minimum_difficulty = easy}
				case medium
				return \{minimum_difficulty = medium}
				case expert
				return \{minimum_difficulty = hard}
			endswitch
			case expert
			switch <difficulty2>
				case easy
				return \{minimum_difficulty = easy}
				case medium
				return \{minimum_difficulty = medium}
				case hard
				return \{minimum_difficulty = hard}
			endswitch
		endswitch
	endif
endscript

script get_game_mode_ui_string 
	if NOT gotparam \{game_mode}

		return
	endif
	return ui_string = ($game_mode_ui_strings.<game_mode>)
endscript
game_mode_ui_strings = {
	gh4_p1_career = qs(0x5a4f279f)
	gh4_p2_career = qs(0x5a4f279f)
	p1_quickplay = qs(0x388d2deb)
	p2_quickplay = qs(0x330c43bc)
	p2_pro_faceoff = qs(0x4bf74995)
}

script get_difficulty_ui_string 
	if NOT gotparam \{difficulty}

		return
	endif
	return ui_string = ($game_difficulty_ui_strings.<difficulty>)
endscript
game_difficulty_ui_strings = {
	easy = qs(0xbf7ffd2d)
	medium = qs(0xeac0f52d)
	hard = qs(0x63aae385)
	expert = qs(0xb778e780)
}
game_mode_names = {
	gh4_p1_career = 'gh4_p1_career'
	gh4_p2_career = 'gh4_p2_career'
	p1_quickplay = 'p1_quickplay'
	p2_quickplay = 'p2_quickplay'
	p2_pro_faceoff = 'p2_pro_faceoff'
	p4_pro_faceoff = 'p4_pro_faceoff'
	p8_pro_faceoff = 'p8_pro_faceoff'
	p4_quickplay = 'p4_quickplay'
	practice = 'practice'
	tutorial = 'tutorial'
}

script get_band_game_mode_name 
	game_mode_name = ($game_mode_names.gh4_p1_career)
	return game_mode_name = <game_mode_name>
endscript

script get_game_mode_name 
	return game_mode_name = ($game_mode_names.$game_mode)
endscript

script get_band_info \{band_index = 1}
	if ($num_career_bands > 1)
		formattext checksumname = band_info 'band%i_info' i = <band_index> addtostringlookup = true
		return band_info = <band_info>
	else
		return \{band_info = band_info}
	endif
endscript

script get_current_band_info 
	get_band_info band_index = ($current_band)
	return band_info = <band_info>
endscript

script get_band_checksum \{band_index = 1}
	if ($num_career_bands > 1)
		formattext checksumname = band_checksum 'career_band%i' i = <band_index> addtostringlookup = true
		return band_checksum = <band_checksum>
	else
		return \{band_checksum = career_band}
	endif
endscript

script get_current_band_checksum 
	get_band_checksum band_index = ($current_band)
	return band_checksum = <band_checksum>
endscript

script set_current_band_part_flags 

	if gotparam \{unlocked}
		flag = {unlocked}
	endif
	if gotparam \{purchased}
		flag = {purchased}
	endif
	get_current_band_info
	getglobaltags <band_info> savegame = <savegame>
	if NOT gotparam \{unlock_purchased}
		initilize_current_band_unlock_purchase
	endif
	if NOT structurecontains structure = <unlock_purchased> <part>

	endif
	unlock_purchased_struct = (<unlock_purchased>.<part>)
	getarraysize \{unlock_purchased_struct}
	if (<array_size> > 0)
		i = 0
		begin
		if (((<unlock_purchased_struct> [<i>]).desc_id) = <desc_id>)
			setarrayelement arrayname = unlock_purchased_struct index = <i> newvalue = {(<unlock_purchased_struct> [<i>]) desc_id = <desc_id> <flag>}
			addparam name = <part> structure_name = new_entry value = <unlock_purchased_struct>
			unlock_purchased = {<unlock_purchased> <new_entry>}
			lockglobaltags \{off}
			setglobaltags <band_info> params = {unlock_purchased = <unlock_purchased>} savegame = <savegame>
			lockglobaltags
			return
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	addarrayelement array = <unlock_purchased_struct> element = {desc_id = <desc_id> <flag>}
	addparam name = <part> structure_name = new_entry value = <array>
	unlock_purchased = {<unlock_purchased> <new_entry>}
	lockglobaltags \{off}
	setglobaltags <band_info> params = {unlock_purchased = <unlock_purchased>} savegame = <savegame>
	lockglobaltags
	return
endscript

script initilize_current_band_unlock_purchase 
	getarraysize ($master_editable_list)
	i = 0
	begin
	addparam name = ((($master_editable_list) [<i>]).part) value = []
	i = (<i> + 1)
	repeat <array_size>
	removeparameter \{i}
	removeparameter \{array_size}
	unlock_purchased = {<...>}
	return unlock_purchased = <unlock_purchased>
endscript

script unlock_purchase_all_cas_parts 
	getarraysize ($master_editable_list)
	master_list_size = <array_size>
	i = 0
	begin
	part = ((($master_editable_list) [<i>]).part)
	getarraysize ($<part>)
	if (<array_size> > 0)
		j = 0
		begin
		if structurecontains structure = (($<part>) [<j>]) locked
			set_current_band_part_flags part = <part> desc_id = ((($<part>) [<j>]).desc_id) unlocked
		endif
		if structurecontains structure = (($<part>) [<j>]) price
			set_current_band_part_flags part = <part> desc_id = ((($<part>) [<j>]).desc_id) purchased
		endif
		j = (<j> + 1)
		repeat <array_size>
	endif
	i = (<i> + 1)
	repeat <master_list_size>
endscript

script get_current_band_part_flags 

	get_current_band_info
	getglobaltags <band_info> savegame = <savegame>
	if NOT gotparam \{unlock_purchased}
		return
	endif
	if NOT structurecontains structure = <unlock_purchased> <part>

	endif
	unlock_purchased_struct = (<unlock_purchased>.<part>)
	getarraysize \{unlock_purchased_struct}
	if (<array_size> > 0)
		i = 0
		begin
		if (((<unlock_purchased_struct> [<i>]).desc_id) = <desc_id>)
			return part_flags = (<unlock_purchased_struct> [<i>])
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
endscript

script get_current_band_name 
	get_current_band_info
	getglobaltags <band_info>
	return band_name = <name>
endscript

script setup_cas_helper_tags 
	setglobaltags savegame = <savegame> cas_helper_dialogue params = {
		visit_cag = 0
		visit_cap = 0
		visit_cadrm = 0
		visit_deformation = 0
		visit_outfit = 0
		guitar_category = gh
		bass_category = gh
	}
endscript
default_gig_tags = {
	unlocked = 0
	first_time_unlocked = 0
	completed = 0
	started = 0
	encore_unlocked = 0
	cash_earned = 0
}
cheat_gig_tags = {
	unlocked = 1
	first_time_unlocked = 0
	completed = 1
	started = 0
	encore_unlocked = 0
}

script setup_gigtags \{globaltag_checksum = none
		use_cheat_tags = 0}
	if NOT gotparam \{unlock_order}
		unlock_order = gh4_career_band_progression_unlock_order
		if (<part> = guitar)
			unlock_order = gh4_career_guitar_progression_unlock_order
		elseif (<part> = drum)
			unlock_order = gh4_career_drum_progression_unlock_order
		elseif (<part> = bass)
			unlock_order = gh4_career_bass_progression_unlock_order
		elseif (<part> = vocals)
			unlock_order = gh4_career_vocals_progression_unlock_order
		endif
	endif
	setlist_prefix = ($<unlock_order>.name)
	cheat_tags = {}
	if (<use_cheat_tags> = 1)
		<cheat_tags> = {unlocked = 1 encore_unlocked = 1 started = 1}
	endif
	free_gig = 1
	begin
	formattext checksumname = gignum 'gig%d' d = <free_gig>
	if NOT structurecontains structure = ($<unlock_order>.freegigs) <gignum>
		break
	endif
	gig = ($<unlock_order>.freegigs.<gignum>.name)
	format_globaltag_gigname setlist_prefix = <setlist_prefix> gig = <gig>
	additional_tags = {}
	if structurecontains structure = ($<unlock_order>.freegigs.<gignum>) debug_dont_unlock
		<additional_tags> = {completed = -1}
	endif
	setglobaltags {
		savegame = <savegame>
		<gig_name>
		params = {($default_gig_tags) <additional_tags> unlocked = 1}
		packtype = gigtags
	}
	globaltag_checksum = (<globaltag_checksum> + <gig_name>)
	formattext checksumname = tier 'tier%d' d = ($<unlock_order>.freegigs.<gignum>.num)
	song_count = 0
	getarraysize ($<setlist_songs>.<tier>.songs)
	begin
	setglobaltags savegame = <savegame> ($<setlist_songs>.<tier>.songs [<song_count>]) params = {unlocked = 1}
	<song_count> = (<song_count> + 1)
	repeat <array_size>
	<free_gig> = (<free_gig> + 1)
	repeat
	set_num = 1
	begin
	formattext checksumname = setnum 'unlockset%d' d = <set_num>
	if NOT structurecontains structure = $<unlock_order> <setnum>
		break
	endif
	if structurecontains structure = ($<unlock_order>.<setnum>) none
		format_globaltag_gigname setlist_prefix = <setlist_prefix> gig = ($<unlock_order>.<setnum>.none)
		setglobaltags {
			savegame = <savegame>
			<gig_name>
			params = {($default_gig_tags) <cheat_tags>}
			packtype = gigtags
		}
		globaltag_checksum = (<globaltag_checksum> + <gig_name>)
	endif
	gig_num = 1
	begin
	formattext checksumname = gignum 'gig%d' d = <gig_num>
	if NOT structurecontains structure = ($<unlock_order>.<setnum>) <gignum>
		break
	endif
	gig = ($<unlock_order>.<setnum>.<gignum>.name)
	format_globaltag_gigname setlist_prefix = <setlist_prefix> gig = <gig>
	setglobaltags {
		savegame = <savegame>
		<gig_name>
		params = {($default_gig_tags) <cheat_tags>}
		packtype = gigtags
	}
	globaltag_checksum = (<globaltag_checksum> + <gig_name>)
	<gig_num> = (<gig_num> + 1)
	repeat
	<set_num> = (<set_num> + 1)
	repeat
	if structurecontains structure = $<unlock_order> freegigs_last
		free_gig = 1
		begin
		formattext checksumname = gignum 'gig%d' d = <free_gig>
		if NOT structurecontains structure = ($<unlock_order>.freegigs_last) <gignum>
			break
		endif
		gig = ($<unlock_order>.freegigs_last.<gignum>.name)
		format_globaltag_gigname setlist_prefix = <setlist_prefix> gig = <gig>
		additional_tags = {}
		if structurecontains structure = ($<unlock_order>.freegigs_last.<gignum>) debug_dont_unlock
			<additional_tags> = {completed = -1}
		endif
		setglobaltags {
			savegame = <savegame>
			<gig_name>
			params = {($default_gig_tags) <additional_tags>}
			packtype = gigtags
		}
		globaltag_checksum = (<globaltag_checksum> + <gig_name>)
		<free_gig> = (<free_gig> + 1)
		repeat
	endif
	return globaltag_checksum = <globaltag_checksum>
endscript

script format_globaltag_song_checksum difficulty = ($player1_status.difficulty)
	if gotparam \{song}
		get_song_name song = <song>
	endif
	if gotparam \{difficulty_index}
		get_difficulty_text_nl index = <difficulty_index>
	else
		if NOT gotparam \{difficulty_text_nl}
			get_difficulty_text_nl difficulty = <difficulty>
		endif
	endif
	if NOT gotparam \{part}
		part = guitar
	endif
	if NOT gotparam \{part_text}
		part_text = ($instrument_list.<part>.text_nl)
	endif
	formattext checksumname = song_checksum '%s%p%d' s = <song_name> p = <part_text> d = <difficulty_text_nl> addtostringlookup = true
	return song_checksum = <song_checksum>
endscript

script format_globaltag_gigname 

	if gotparam \{gignum}
		formattext textname = gig 'gig%g' g = (<gignum>)
	endif

	formattext checksumname = gig_name '%s_%g' s = <setlist_prefix> g = <gig> addtostringlookup = true
	return gig_name = <gig_name>
endscript

script setup_quickplay_song_tags 
	if gotparam \{allsongs}
		return
	endif
	if NOT gotparam \{unlock_order}
		unlock_order = gh4_career_band_progression_unlock_order
		if (<part> = guitar)
			unlock_order = gh4_career_guitar_progression_unlock_order
		elseif (<part> = drum)
			unlock_order = gh4_career_drum_progression_unlock_order
		elseif (<part> = bass)
			unlock_order = gh4_career_bass_progression_unlock_order
		elseif (<part> = vocals)
			unlock_order = gh4_career_vocals_progression_unlock_order
		endif
	endif
	free_gig = 1
	begin
	formattext checksumname = gignum 'gig%d' d = <free_gig>
	if NOT structurecontains structure = ($<unlock_order>.freegigs) <gignum>
		break
	endif
	formattext checksumname = tier 'tier%d' d = ($<unlock_order>.freegigs.<gignum>.num)
	song_count = 0
	getarraysize ($<setlist_songs>.<tier>.songs)
	begin
	setglobaltags savegame = <savegame> ($<setlist_songs>.<tier>.songs [<song_count>]) params = {unlocked = 1}
	<globaltag_checksum> = (<globaltag_checksum> + ($<setlist_songs>.<tier>.songs [<song_count>]))
	<song_count> = (<song_count> + 1)
	repeat <array_size>
	<free_gig> = (<free_gig> + 1)
	repeat
	return globaltag_checksum = <globaltag_checksum>
endscript

script set_band_character_id_globaltag 
	if band_builder_is_random character_id = <character_id>
		return
	endif
	if (($is_network_game = 0) && ($game_mode = p2_pro_faceoff))

		player_index = (<player> -1)

		getglobaltags savegame = <savegame> last_h2h_characters
		setarrayelement arrayname = last_h2h_characters index = <player_index> newvalue = <character_id>
		setglobaltags savegame = <savegame> last_h2h_characters params = {last_h2h_characters = <last_h2h_characters>}
		return
	endif
	if (($band_mode_mode = career) || ($is_network_game = 1))


		if (<controller> >= 4)
			return
		endif
		getglobaltags savegame = <savegame> last_band_characters
		setarrayelement arrayname = last_band_characters index = <controller> newvalue = <character_id>
		setglobaltags savegame = <savegame> last_band_characters params = {last_band_characters = <last_band_characters>}
	endif
endscript

script get_last_band_character_recorded 

	<player_status> = ($0x2994109a [<player>])
	controller = ($<player_status>.controller)
	if gotparam \{no_band_leader_grab}
		get_savegame_from_player_status player_status = <player_status>
	else
		get_savegame_from_player_status band_character_select player_status = <player_status>
	endif
	if (($is_network_game = 0) && ($game_mode = p2_pro_faceoff))
		if NOT gotparam \{character_id}
			player_index = (<player> -1)
			if (<player_index> >= 2)
				return \{character_id = none}
			endif
			getglobaltags savegame = <savegame> last_h2h_characters
			character_id = (<last_h2h_characters> [<player_index>])
		endif
	else
		if NOT gotparam \{character_id}
			if (<controller> >= 4)
				return \{character_id = none}
			endif
			if (<controller> < 0)
				<controller> = 0
			endif
			getglobaltags savegame = <savegame> last_band_characters
			character_id = (<last_band_characters> [<controller>])
		endif
	endif
	if NOT profile_exists id = <character_id> savegame = <savegame>
		character_id = none
	else
		get_musician_profile_struct_by_id id = <character_id> savegame = <savegame> dont_assert
		if NOT is_allowed_part profile_struct = <profile_struct> part = <part>

			character_id = none
		endif
	endif
	return character_id = <character_id> borrowed_from_band_leader = <borrowed_from_band_leader>
endscript

script setup_saved_instrument_tags 
	globaltag_createarray globaltag_checksum = <globaltag_checksum> savegame = <savegame> array_name = player_created_graphics_save max_size = ($max_num_logo_saves) packtype = logos
	globaltag_createarray globaltag_checksum = <globaltag_checksum> savegame = <savegame> array_name = player_guitar_save max_size = ($max_num_instrument_saves) packtype = guitars
	globaltag_createarray globaltag_checksum = <globaltag_checksum> savegame = <savegame> array_name = player_bass_save max_size = ($max_num_instrument_saves) packtype = basses
	globaltag_createarray globaltag_checksum = <globaltag_checksum> savegame = <savegame> array_name = player_drum_save max_size = ($max_num_instrument_saves) packtype = drums
	globaltag_createarray globaltag_checksum = <globaltag_checksum> savegame = <savegame> array_name = player_mic_save max_size = ($max_num_instrument_saves) packtype = vocals
	return globaltag_checksum = <globaltag_checksum>
endscript

script globaltag_createarray 

	setglobaltags savegame = <savegame> <array_name> params = {valid_entries = [] max_size = <max_size>}
	i = 0
	begin
	formattext textname = arrayappend '_array%d' d = <i>
	extendcrc <array_name> <arrayappend> out = arrayid
	setglobaltags savegame = <savegame> <arrayid> params = {contents = {}} packtype = <packtype>
	globaltag_checksum = (<globaltag_checksum> + <arrayid>)
	i = (<i> + 1)
	repeat <max_size>
	if gotparam \{start_full}
		i = 0
		begin
		globaltag_addarrayelement savegame = <savegame> array_name = <array_name> element = {}
		i = (<i> + 1)
		repeat <max_size>
	endif
	return globaltag_checksum = <globaltag_checksum>
endscript

script globaltag_getarraysize 

	getglobaltags savegame = <savegame> <array_name>
	getarraysize <valid_entries>
	return array_size = <array_size>
endscript

script globaltag_getarrayelement 

	getglobaltags savegame = <savegame> <array_name>
	getarraysize <valid_entries>
	if (<index> < <array_size>)
		getglobaltags savegame = <savegame> (<valid_entries> [<index>])
		return true element = <contents>
	endif
	return \{false}
endscript

script globaltag_setarrayelement 

	getglobaltags savegame = <savegame> <array_name>
	getarraysize <valid_entries>
	if (<index> < <array_size>)
		setglobaltags savegame = <savegame> (<valid_entries> [<index>]) params = {contents = <element>}
		return \{true}
	endif
	return \{false}
endscript

script globaltag_addarrayelement 

	getglobaltags savegame = <savegame> <array_name>
	getarraysize <valid_entries>
	if (<array_size> < <max_size>)
		i = 0
		begin
		formattext textname = arrayappend '_array%d' d = <i>
		extendcrc <array_name> <arrayappend> out = arrayid
		if NOT arraycontains array = <valid_entries> contains = <arrayid>
			addarrayelement array = <valid_entries> element = <arrayid>
			setglobaltags savegame = <savegame> <array_name> params = {valid_entries = <array> max_size = <max_size>}
			setglobaltags savegame = <savegame> <arrayid> params = {contents = <element>}
			return \{true}
		endif
		i = (<i> + 1)
		repeat (<array_size> + 1)
	endif
	return \{false}
endscript

script globaltag_removearrayelement 

	getglobaltags savegame = <savegame> <array_name>
	getarraysize <valid_entries>
	if (<array_size> <= <max_size>)
		removearrayelement array = <valid_entries> index = <index>
		setglobaltags savegame = <savegame> <array_name> params = {valid_entries = <array> max_size = <max_size>}
		return \{true}
	endif
	return \{false}
endscript

script globaltag_getarraychecksum 

	array_checksum = arse
	globaltag_getarraysize savegame = <savegame> array_name = <array_name>
	if (<array_size> > 0)
		i = 0
		begin
		globaltag_getarrayelement savegame = <savegame> array_name = <array_name> index = <i>
		generatechecksumfromstruct \{structname = element}
		array_checksum = (<array_checksum> + <structure_checksum>)
		i = (<i> + 1)
		repeat <array_size>
	endif
	return array_checksum = <array_checksum>
endscript
neversoft_hiscore_names = [
	qs(0xef227354)
	qs(0x5f4f2e1b)
	qs(0xac2998a7)
	qs(0x7f75d0d2)
	qs(0x7e83439b)
	qs(0x36dd790b)
	qs(0xc8d66d50)
	qs(0x3f002d40)
]
