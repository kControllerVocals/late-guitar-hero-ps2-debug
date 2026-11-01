gstar_power_triggered = 0
achievement_scripts = [
	achievements_star_fleet_project
	achievements_hamilton_elementary_school
	achievements_beat_it
	achievements_eat_em_and_smile
	achievements_respect_the_wind
	achievements_fender_bender
	achievements_bang_your_gong
	achievements_brown_sound
	achievements_diamond_dave
	achievements_king_arthur
	achievements_rock_me_amadeus
	achievements_you_really_got_me
	achievements_gazzaris
	achievements_cafe_wha
	achievements_whisky_a_gogo
	achievements_starwood
	achievements_walter_mitty
	achievements_where_have_all_the_good_times_gone
	achievements_hot_for_high_scores
	achievements_im_the_one
	achievements_the_broken_combs
	achievements_the_trojan_rubber_company
	achievements_jump
	achievements_unchained
	achievements_genesis
	achievements_the_space_brothers
	achievements_guitar_god
	achievements_diamond_in_the_rough
	achievements_double_bass_master
	achievements_316
	achievements_red_ball_jets
	achievements_mammoth
	achievements_1984_helper
	achievements_the_woodshed
	achievements_5150
]

script achievements_update 
	if ($is_network_game = 1)
		if NOT gamemode_iscooperative
			determine_game_scores_and_winner



			if (<opponent_team_score> > <team_score> || <tie> = true)
				change \{achievements_songwonflag = 0}
			endif
		endif
	endif
	getarraysize \{$achievement_scripts}

	<i> = 0
	begin
	<scr> = ($achievement_scripts [<i>])
	<scr>
	<i> = (<i> + 1)
	repeat <array_size>
endscript
achievements_songwonflag = 0
achievements_newgigwonflag = 0
achievements_2x4_flag = 0
achievements_ride_the_lightning_flag = 0
achievements_super_group_unite_flag = 0
achievements_creating_character = 0
achievements_modified_logo = 0
achievements_ignore_bots = 0

script achievements_resetglobals 
	change \{achievements_songwonflag = 0}
	change \{achievements_newgigwonflag = 0}
	change \{achievements_2x4_flag = 0}
	change \{achievements_ride_the_lightning_flag = 0}
	change \{achievements_super_group_unite_flag = 0}
	change \{achievements_creating_character = 0}
	change \{achievements_modified_logo = 0}
	change \{achievements_ignore_bots = 0}
endscript

script achievements_issongwon 
	if ($achievements_songwonflag = 1)
		return \{true}
	endif

	return \{false}
endscript

script achievements_isnewgigwon 
	if ($achievements_newgigwonflag = 1)
		return \{true}
	endif
	return \{false}
endscript

script is_modern_band_vanhalen 
	if NOT gotparam \{band}
		get_band_name song = ($current_song)
	endif
	switch <band>
		case band_vanhalen
		case band_vanhalen_dlr_guitar
		case band_vanhalen_eddie_drill
		case band_vanhalen_wolf_drill
		return \{true}
	endswitch
	return \{false}
endscript

script is_retro_band_vanhalen 
	if NOT gotparam \{band}
		get_band_name song = ($current_song)
	endif
	switch <band>
		case band_vanhalen_alt
		case band_vanhalen_eddie_alt_drill
		case band_vanhalen_dlr_alt_guitar
		return \{true}
	endswitch
	return \{false}
endscript

script played_all_expertplus_songs 

	getarraysize ($gh_songlist)
	<index> = 0
	begin
	<song> = ($gh_songlist [<index>])
	if structurecontains structure = ($permanent_songlist_props) <song>
		if structurecontains structure = ($permanent_songlist_props.<song>) double_kick
			if (($permanent_songlist_props.<song>.double_kick) = 1)

				format_globaltag_song_checksum song = <song> part_text = 'drum'
				getglobaltags <song_checksum> param = double_bass_complete
				if (<double_bass_complete> = 0)

					return \{false}
				endif
			endif
		endif
	endif
	<index> = (<index> + 1)
	repeat <array_size>
	return \{true}
endscript

script unwindrandomappearance 

	<temp_cid> = <character_id>
	if structurecontains structure = ($guest_character_names) randomappearance0
		if (<character_id> = randomappearance0)
			<temp_cid> = (($guest_character_names).randomappearance0)
		endif
	endif
	if structurecontains structure = ($guest_character_names) randomappearance1
		if (<character_id> = randomappearance1)
			<temp_cid> = (($guest_character_names).randomappearance1)
		endif
	endif
	if structurecontains structure = ($guest_character_names) randomappearance2
		if (<character_id> = randomappearance2)
			<temp_cid> = (($guest_character_names).randomappearance2)
		endif
	endif
	if structurecontains structure = ($guest_character_names) randomappearance3
		if (<character_id> = randomappearance3)
			<temp_cid> = (($guest_character_names).randomappearance3)
		endif
	endif
	if NOT (<temp_cid> = <character_id>)

	endif
	return temp_cid = <temp_cid>
endscript

script achievements_areanygigswon \{part = 'guitar'}
	formattext checksumname = career_part_struct 'gh4_career_%p_songs' p = <part>
	<total_gigs> = ($<career_part_struct>.num_tiers)
	<i> = 1
	begin
	formattext checksumname = career_part_gig 'career_%p_gig%n' p = <part> n = <i>
	getglobaltags <career_part_gig>
	if (<completed> = 1)
		return \{true}
	endif
	<i> = (<i> + 1)
	repeat <total_gigs>
	return \{false}
endscript

script achievements_hasgigbeenwonondiff \{part = 'guitar'
		diff = expert}
	<player_status> = ($0x2994109a [<player>])
	get_savegame_from_controller controller = ($<player_status>.controller)
	formattext checksumname = career_part_struct 'gh4_career_%p_songs' p = <part>
	<total_gigs> = ($<career_part_struct>.num_tiers)
	<num_gigs_won> = 0
	<num_gigs_fived> = 0
	formattext checksumname = career_part_gig 'career_%p_gig%n' p = <part> n = <gignum>
	getglobaltags <career_part_gig> savegame = <savegame>
	formattext checksumname = tier 'tier%n' n = <gignum>
	if NOT structurecontains structure = ($<career_part_struct>.<tier>) paytoplay
		if NOT structurecontains structure = ($<career_part_struct>.<tier>) debug_gig
			if NOT structurecontains structure = ($<career_part_struct>.<tier>) createagig
				getarraysize ($<career_part_struct>.<tier>.songs)
				<num_required> = <array_size>
				<num_five_stars> = <array_size>
				<song_size> = <array_size>
				<array_entry> = 0
				begin
				format_globaltag_song_checksum part = ($<career_part_struct>.part) song = ($<career_part_struct>.<tier>.songs [<array_entry>]) difficulty = <diff>
				getglobaltags <song_checksum> params = stars
				if (<stars> > 2)
					<num_required> = (<num_required> - 1)
				endif
				if (<stars> > 4)
					<num_five_stars> = (<num_five_stars> - 1)
				endif
				<array_entry> = (<array_entry> + 1)
				repeat <song_size>
				if (<num_required> <= 0)
					<num_gigs_won> = (<num_gigs_won> + 1)
				endif
				if (<num_five_stars> <= 0)
					<num_gigs_fived> = (<num_gigs_fived> + 1)
				endif
			endif
		endif
	endif
	return num_gigs_won = <num_gigs_won> num_gigs_fived = <num_gigs_fived>
endscript

script achievements_hasgigbeenwon \{part = 'guitar'}
	<player_status> = ($0x2994109a [<player>])
	get_savegame_from_controller controller = ($<player_status>.controller)
	formattext checksumname = career_part_struct 'gh4_career_%p_songs' p = <part>
	<total_gigs> = ($<career_part_struct>.num_tiers)
	<num_gigs_won> = 0
	<num_gigs_fived> = 0
	formattext checksumname = career_part_gig 'career_%p_gig%n' p = <part> n = <gignum>
	getglobaltags <career_part_gig> savegame = <savegame>
	formattext checksumname = tier 'tier%n' n = <gignum>
	if NOT structurecontains structure = ($<career_part_struct>.<tier>) paytoplay
		if NOT structurecontains structure = ($<career_part_struct>.<tier>) debug_gig
			if NOT structurecontains structure = ($<career_part_struct>.<tier>) createagig
				getarraysize ($<career_part_struct>.<tier>.songs)
				num_required = <array_size>
				num_five_stars = 0
				completed_songs = 0
				<array_entry> = 0
				begin
				diff_index = 0
				begin
				format_globaltag_song_checksum part = ($<career_part_struct>.part) song = ($<career_part_struct>.<tier>.songs [<array_entry>]) difficulty_index = <diff_index>
				getglobaltags <song_checksum> params = stars
				if (<stars> > 4)
					completed_songs = (<completed_songs> + 1)
					num_five_stars = (<num_five_stars> + 1)
					break
				elseif (<stars> > 2)
					completed_songs = (<completed_songs> + 1)
					break
				endif
				diff_index = (<diff_index> + 1)
				repeat 5
				<array_entry> = (<array_entry> + 1)
				repeat <num_required>
				if (<num_required> = <completed_songs>)
					<num_gigs_won> = (<num_gigs_won> + 1)
				endif
				if (<num_five_stars> = <completed_songs>)
					<num_gigs_fived> = (<num_gigs_fived> + 1)
				endif
			endif
		endif
	endif
	return num_gigs_won = <num_gigs_won> num_gigs_fived = <num_gigs_fived>
endscript

script achievements_numgigswonondiff \{part = 'guitar'
		diff = expert}
	<player_status> = ($0x2994109a [<player>])
	get_savegame_from_controller controller = ($<player_status>.controller)
	formattext checksumname = career_part_struct 'gh4_career_%p_songs' p = <part>
	<total_gigs> = ($<career_part_struct>.num_tiers)
	<num_crucial_gigs> = 0
	<num_gigs_won> = 0
	<diff_array> = []
	switch (<diff>)
		case easy
		<diff_array> = [easy medium hard expert]
		case medium
		<diff_array> = [medium hard expert]
		case hard
		<diff_array> = [hard expert]
		case expert
		<diff_array> = [expert]
		default
		<diff_array> = [easy]
	endswitch
	<i> = 1
	begin
	formattext checksumname = career_part_gig 'career_%p_gig%n' p = <part> n = <i>
	getglobaltags <career_part_gig> savegame = <savegame>
	formattext checksumname = tier 'tier%n' n = <i>
	if NOT structurecontains structure = ($<career_part_struct>.<tier>) paytoplay
		if NOT structurecontains structure = ($<career_part_struct>.<tier>) debug_gig
			if NOT structurecontains structure = ($<career_part_struct>.<tier>) createagig
				<num_crucial_gigs> = (<num_crucial_gigs> + 1)
				getarraysize ($<career_part_struct>.<tier>.songs)
				<num_required> = <array_size>
				<song_size> = <array_size>
				<array_entry> = 0
				begin
				getarraysize <diff_array>
				<diff_size> = <array_size>
				<diff_index> = 0
				begin
				<diff> = (<diff_array> [<diff_index>])
				format_globaltag_song_checksum part = ($<career_part_struct>.part) song = ($<career_part_struct>.<tier>.songs [<array_entry>]) difficulty = <diff>
				getglobaltags <song_checksum> params = stars
				if (<stars> > 2)
					<num_required> = (<num_required> - 1)
					break
				endif
				<diff_index> = (<diff_index> + 1)
				repeat <diff_size>
				<array_entry> = (<array_entry> + 1)
				repeat <song_size>
				if (<num_required> <= 0)
					<num_gigs_won> = (<num_gigs_won> + 1)
				endif
			endif
		endif
	endif
	<i> = (<i> + 1)
	repeat <total_gigs>
	return num_gigs_won = <num_gigs_won> total_gigs = <num_crucial_gigs>
endscript

script achievements_getpartstring 
	switch (<part>)
		case guitar
		return \{part_string = 'guitar'}
		case bass
		return \{part_string = 'bass'}
		case drum
		return \{part_string = 'drum'}
		case vocals
		return \{part_string = 'vocals'}
		case none
		return \{part_string = 'none'}
		default
		return \{part_string = 'none'}
	endswitch
endscript

script achievements_awardplayer 
	if ($achievements_ignore_bots = 0)
		getplayerinfo <player> bot_play
		if (<bot_play> = 1)
			return
		endif
	endif
	getplayerinfo <player> part
	if (<part> = vocals && $current_song = orion)
		return
	endif
	<player_status> = ($0x2994109a [<player>])
	<controller> = ($<player_status>.controller)
	writeachievements achievement = <achievement> controller_id = <controller>

endscript

script achievements_awardband 
	gamemode_getnumplayersshown
	<player> = 1
	begin
	achievements_awardplayer achievement = <achievement> player = <player>
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_checkforbandstreak 
	if ($achievements_2x4_flag = 0 && ($game_mode = p4_career || $game_mode = p4_quickplay || $game_mode = p8_pro_faceoff))
		<four_way_streak> = 1
		<player> = 1
		begin
		getplayerinfo <player> current_run
		if (<current_run> < 50)
			<four_way_streak> = 0
			break
		endif
		<player> = (<player> + 1)
		repeat 4
		if (<four_way_streak> = 1)
			change \{achievements_2x4_flag = 1}
		endif
	endif
endscript

script achievements_checkforsupergroupunite 
	if ($achievements_super_group_unite_flag = 0 && ($game_mode = p4_career || $game_mode = p4_quickplay || $game_mode = p8_pro_faceoff))
		<four_way_multiplier> = 1
		<player> = 1
		begin
		<player_status> = ($0x2994109a [<player>])
		get_current_multiplier player_status = <player_status>
		if (<multiplier> < 8)
			<four_way_multiplier> = 0
			break
		endif
		<player> = (<player> + 1)
		repeat 4
		if (<four_way_multiplier> = 1)
			change \{achievements_super_group_unite_flag = 1}
		endif
	endif
endscript

script achievements_ischeatingautokick 
	if ($cheat_autokick = 1 || $cheat_freedrum = 1)
		gamemode_getnumplayersshown
		<player> = 1
		begin
		getplayerinfo <player> part
		if (<part> = drum)

			return \{true}
		endif
		<player> = (<player> + 1)
		repeat <num_players_shown>
	endif
	return \{false}
endscript

script achievements_ischeating 
	if ($cheat_autokick = 1 || $cheat_freedrum = 1)
		gamemode_getnumplayersshown
		<player> = 1
		begin
		getplayerinfo <player> part
		if (<part> = drum)

			return \{true}
		endif
		<player> = (<player> + 1)
		repeat <num_players_shown>
	endif
	if ($cheat_alwaysslide = 1)
		gamemode_getnumplayersshown
		<player> = 1
		begin
		getplayerinfo <player> part
		if (<part> = guitar)

			return \{true}
		endif
		<player> = (<player> + 1)
		repeat <num_players_shown>
	endif
	return \{false}
endscript

script achievements_resetgreenhellflags 
	gamemode_getnumplayersshown

	<player> = 1
	begin
	getplayerinfo <player> controller
	get_savegame_from_controller controller = <controller>
	setglobaltags savegame = <savegame> achievement_info params = {green_note_missed = 0}
	setglobaltags savegame = <savegame> achievement_info params = {green_notes_exist = 0}
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_onlinematchplayed 
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> controller
	get_savegame_from_controller controller = <controller>
	getglobaltags savegame = <savegame> achievement_info param = num_online_matches_played
	<num_online_matches_played> = (<num_online_matches_played> + 1)
	setglobaltags savegame = <savegame> achievement_info params = {num_online_matches_played = <num_online_matches_played>}
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_hamilton_elementary_school 

	gamemode_getnumplayers
	<player> = 1
	begin
	getplayerinfo <player> controller
	get_savegame_from_controller controller = <controller>
	getglobaltags savegame = <savegame> training
	if (<basic_lesson> = complete ||
			<star_power_lesson> = complete ||
			<advanced_techniques_lesson> = complete ||
			<new_features_lesson> = complete ||
			<drum_basic_lesson> = complete ||
			<drum_int_lesson> = complete ||
			<vocals_lesson> = complete ||
			<band_lesson> = complete ||
			<versus_lesson> = complete ||
			<rs_introduction_lesson> = complete ||
			<rs_lead_and_bass_lesson> = complete ||
			<rs_rhythm_lesson> = complete ||
			<rs_drums_lesson> = complete ||
			<rs_melody_lesson> = complete ||
			<rs_recording_lesson> = complete ||
			<rs_pro_guitar_lesson> = complete ||
			<rs_advanced_tools_lesson> = complete ||
			<rs_ghmix_editing_lesson> = complete ||
			<rs_ghmix_pro_techniques_tools_lesson> = complete)

		writeachievements achievement = hamilton_elementary_school controller_id = <controller>
	endif
	<player> = (<player> + 1)
	repeat <num_players>
endscript

script achievements_james_hetfield 

	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	if achievements_ischeating
		return
	endif
	achievements_careercomplete \{part = vocals
		player = 1}
	if (<complete> = 1)
		achievements_awardplayer \{achievement = james_hetfield
			player = 1}
	endif
endscript

script achievements_lars_ulrich 

	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	if achievements_ischeating
		return
	endif
	achievements_careercomplete \{part = drum
		player = 1}
	if (<complete> = 1)
		achievements_awardplayer \{achievement = lars_ulrich
			player = 1}
	endif
endscript

script achievements_kirk_hammet 

	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	if achievements_ischeating
		return
	endif
	achievements_careercomplete \{part = guitar
		player = 1}
	if (<complete> = 1)
		achievements_awardplayer \{achievement = kirk_hammet
			player = 1}
	endif
endscript

script achievements_robert_trujillo 

	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	if achievements_ischeating
		return
	endif
	achievements_careercomplete \{part = bass
		player = 1}
	if (<complete> = 1)
		achievements_awardplayer \{achievement = robert_trujillo
			player = 1}
	endif
endscript

script achievements_holier_than_thou 

	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	if achievements_ischeating
		return
	endif
	achievements_careercomplete \{part = guitar
		player = 1}
	if (<complete> = 0)
		return
	endif
	achievements_careercomplete \{part = bass
		player = 1}
	if (<complete> = 0)
		return
	endif
	achievements_careercomplete \{part = drum
		player = 1}
	if (<complete> = 0)
		return
	endif
	achievements_careercomplete \{part = vocals
		player = 1}
	if (<complete> = 0)
		return
	endif
	achievements_awardplayer \{achievement = holier_than_thou
		player = 1}
endscript

script achievements_one 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($game_mode = tutorial ||
			$game_mode = training ||
			$game_mode = p1_improv ||
			$rich_presence_context = presence_music_studio)
		return
	endif
	achievements_awardband \{achievement = one}
endscript

script achievements_and_justice_for_all 

	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	progression_get_total_stars

	if (<total_stars> > 100)
		achievements_awardplayer \{achievement = and_justice_for_all
			player = 1}
	endif
endscript

script achievements_the_ecstacy_of_gold 

	getglobaltags \{band_info}
	if (<career_earnings> >= 15000)
		achievements_awardband \{achievement = the_ecstacy_of_gold}
	endif
endscript

script achievements_damage_inc 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($game_mode = tutorial ||
			$game_mode = training ||
			$game_mode = p1_improv ||
			$rich_presence_context = presence_music_studio)
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> part
	getplayerinfo <player> controller
	if (<controller> = ($primary_controller) && <part> = drum)
		achievements_awardplayer achievement = damage_inc player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_motorbreath 

	if NOT achievements_issongwon
		return
	endif
	if ($game_mode = tutorial ||
			$game_mode = training ||
			$game_mode = p1_improv ||
			$rich_presence_context = presence_music_studio)
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> part
	getplayerinfo <player> controller
	if (<controller> = ($primary_controller) && <part> = vocals)
		achievements_awardplayer achievement = motorbreath player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_invisible_kid 

	if NOT achievements_issongwon
		return
	endif
	if ($game_mode = tutorial ||
			$game_mode = training ||
			$game_mode = p1_improv ||
			$rich_presence_context = presence_music_studio)
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> part
	getplayerinfo <player> controller
	if (<controller> = ($primary_controller) && <part> = bass)
		achievements_awardplayer achievement = invisible_kid player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_some_kind_of_monster 

	if ($is_network_game = 0)
		if NOT achievements_issongwon
			return
		endif
	endif
	if ($game_mode = tutorial ||
			$game_mode = training ||
			$game_mode = p1_improv ||
			$rich_presence_context = presence_music_studio)
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> part
	getplayerinfo <player> controller
	if (<controller> = ($primary_controller) && <part> = guitar)
		achievements_awardplayer achievement = some_kind_of_monster player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_starwood 

	if NOT ($game_mode = p4_quickplay ||
			$game_mode = p4_career ||
			$game_mode = p8_pro_faceoff)
		return
	endif
	if ($game_mode = tutorial ||
			$game_mode = training ||
			$game_mode = p1_improv ||
			$rich_presence_context = presence_music_studio)
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($achievements_ride_the_lightning_flag = 1)
		achievements_awardband \{achievement = starwood}
		change \{achievements_ride_the_lightning_flag = 0}
	endif
endscript

script achievements_master_of_puppets 

	if NOT achievements_issongwon
		return
	endif
	if NOT ($game_mode = p4_quickplay ||
			$game_mode = p4_career ||
			$game_mode = p8_pro_faceoff)
		return
	endif
	if achievements_ischeating
		return
	endif
	<highest_score> = 0
	<highest_score_player> = -1
	<highest_score_part> = none
	<player> = 1
	begin
	getplayerinfo <player> score
	if (<score> > <highest_score>)
		<highest_score> = <score>
		<highest_score_player> = <player>
	endif
	<player> = (<player> + 1)
	repeat 4
	if (<highest_score_player> > -1)
		achievements_awardplayer achievement = master_of_puppets player = <highest_score_player>
	endif
endscript

script achievements_the_struggle_within 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if NOT ($game_mode = p4_quickplay ||
			$game_mode = p4_career ||
			$game_mode = p8_pro_faceoff)
		return
	endif
	achievements_awardband \{achievement = the_struggle_within}
endscript

script achievements_the_four_horsemen 

	if NOT achievements_issongwon
		return
	endif
	if NOT ($game_mode = p4_quickplay ||
			$game_mode = p4_career ||
			$game_mode = p8_pro_faceoff)
		return
	endif
	if achievements_ischeating
		return
	endif
	<player> = 1
	begin
	getplayerinfo <player> difficulty
	if (<difficulty> != expert)
		return
	endif
	<player> = (<player> + 1)
	repeat 4
	achievements_awardband \{achievement = the_four_horsemen}
endscript

script achievements_nothing_else_matters 

	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	achievements_careercomplete part = band player = <player>
	if (<complete> = 1)
		achievements_awardplayer achievement = nothing_else_matters player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_black 

	if NOT achievements_issongwon

		return
	endif
	if achievements_ischeating
		return
	endif
	if ($game_mode != p2_battle || $is_network_game = 0)

		return
	endif
	getplayerinfo \{1
		final_blow_powerup}
	if (<final_blow_powerup> < 0)

		return
	endif
	<powerup> = ($battlemode_powerups [<final_blow_powerup>].name)

	if (<powerup> = blackout)
		achievements_awardplayer \{achievement = black
			player = 1}
	endif
endscript

script achievements_better_than_you 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($game_mode = p2_pro_faceoff && $is_network_game)
		determine_game_scores_and_winner



		if (<tie> = false)
			achievements_awardband \{achievement = better_than_you}
		endif
	endif
endscript

script achievements_blitzkrieg 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($game_mode = p8_pro_faceoff && $is_network_game)
		achievements_awardband \{achievement = blitzkrieg}
	endif
endscript

script achievements_seek_and_destroy 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($is_network_game = 0)
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> controller
	get_savegame_from_controller controller = <controller>
	getglobaltags savegame = <savegame> achievement_info param = num_online_matches_played

	if (<num_online_matches_played> >= 20)
		achievements_awardplayer achievement = seek_and_destroy player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_the_unforgiven 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($game_mode = p2_faceoff && $is_network_game)
		achievements_awardband \{achievement = the_unforgiven}
	endif
endscript

script achievements_the_unforgiven_ii 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($game_mode = p2_faceoff && $is_network_game)
		determine_game_scores_and_winner
		if (<team_score> >= (<opponent_team_score> + 25000))
			achievements_awardband \{achievement = the_unforgiven_ii}
		endif
	endif
endscript

script achievements_the_unforgiven_iii 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($game_mode = p2_pro_faceoff && $is_network_game)
		determine_game_scores_and_winner
		if (<team_score> >= (<opponent_team_score> + 25000))
			achievements_awardband \{achievement = the_unforgiven_iii}
		endif
	endif
endscript

script achievements_reload 

	if gotparam \{controller}
		writeachievements achievement = reload controller_id = <controller>
	endif
endscript

script achievements_cure 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	<player_status> = ($0x2994109a [<player>])
	if (($<player_status>.lowest_health) < $health_poor_medium)
		if (($<player_status>.current_health) >= $health_poor_medium)
			achievements_awardplayer achievement = cure player = <player>
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_green_hell 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($current_song != bloodandthunder)
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> part
	if (<part> = drum)
		getplayerinfo <player> controller
		get_savegame_from_controller controller = <controller>
		getglobaltags savegame = <savegame> achievement_info param = green_note_missed
		getglobaltags savegame = <savegame> achievement_info param = green_notes_exist
		getplayerinfo <player> current_health



		if (<green_note_missed> = 0 &&
				<green_notes_exist> = 1 &&
				<current_health> > $health_medium_good)
			achievements_awardplayer achievement = green_hell player = <player>
		endif
		break
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_disposable_heroes 

	if gotparam \{controller}
		writeachievements achievement = disposable_heroes controller_id = <controller>
	endif
endscript

script achievements_blackened 

	if gotparam \{controller}
		writeachievements achievement = blackened controller_id = <controller>
	endif
endscript

script achievements_eye_of_the_beholder 

	if ($rich_presence_context = presence_music_studio)
		return
	endif
	if gotparam \{controller}
		writeachievements achievement = eye_of_the_beholder controller_id = <controller>
		change \{achievements_modified_logo = 0}
	endif
endscript

script achievements_fixxxer 

	if gotparam \{controller}
		writeachievements achievement = fixxxer controller_id = <controller>
	endif
endscript

script achievements_hero_of_the_day 

	if ($rich_presence_context = presence_music_studio)
		return
	endif
	if achievements_ischeating
		return
	endif
	if NOT achievements_issongwon
		return
	endif
	if ($current_song = jamsession)
		return
	endif
	if NOT structurecontains structure = ($permanent_songlist_props.($current_song)) double_kick

		return
	endif
	if (($permanent_songlist_props.($current_song)).double_kick = 0)

		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> part
	getplayerinfo <player> double_kick_drum
	if (<part> = drum && <double_kick_drum> = 1)
		achievements_awardplayer achievement = hero_of_the_day player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_the_house_jack_built 

	if NOT achievements_issongwon
		return
	endif
endscript

script achievements_wherever_i_may_roam 

	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> controller
	get_savegame_from_controller controller = <controller>
	getglobaltags savegame = <savegame> achievement_info param = venues_played
	switch ($current_level)
		case load_z_soundcheck2
		<venues_played> = {<venues_played> load_z_soundcheck2 = 1}
		case load_z_studio2
		<venues_played> = {<venues_played> load_z_studio2 = 1}
		case load_z_metalfest
		<venues_played> = {<venues_played> load_z_metalfest = 1}
		case load_z_la_block_party
		<venues_played> = {<venues_played> load_z_la_block_party = 1}
		case load_z_rome
		<venues_played> = {<venues_played> load_z_rome = 1}
		case load_z_london
		<venues_played> = {<venues_played> load_z_london = 1}
		case load_z_drum_kit
		<venues_played> = {<venues_played> load_z_drum_kit = 1}
		case load_z_frankenstrat
		<venues_played> = {<venues_played> load_z_frankenstrat = 1}
		case load_z_starwood
		<venues_played> = {<venues_played> load_z_starwood = 1}
		case load_z_s_stage
		<venues_played> = {<venues_played> load_z_s_stage = 1}
	endswitch
	setglobaltags savegame = <savegame> achievement_info params = {venues_played = <venues_played>}

	<all_played> = 1
	getarraysize ($levelzonearray)
	<i> = 0
	begin
	<venue_name> = (($levelzonearray) [<i>])
	if structurecontains structure = <venues_played> <venue_name>
		if ((<venues_played>.<venue_name>) = 0)
			<all_played> = 0
			break
		endif
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	if (<all_played> = 1)
		achievements_awardplayer achievement = wherever_i_may_roam player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_trapped_under_ice 

	if (($levelzones).($current_level).zone = z_icecave)
		achievements_awardband \{achievement = trapped_under_ice}
	endif
endscript

script achievements_stone_dead_forever 

	if (($levelzones).($current_level).zone = z_stone)
		achievements_awardband \{achievement = stone_dead_forever}
	endif
endscript

script achievements_no_brown_mnms 

	if NOT screenelementexists \{id = metallifacts_container}

		return
	endif
	<controller> = 0
	begin
	writeachievements achievement = no_brown_mnms controller_id = <controller>

	<controller> = (<controller> + 1)
	repeat 4
endscript

script achievements_creeping_death 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	getplayerinfo \{1
		score}
	getplayerinfo \{1
		part}
	if (<score> >= 575000 &&
			<part> = guitar &&
			$current_song = creepingdeath)
		achievements_awardplayer \{achievement = creeping_death
			player = 1}
	endif
endscript

script achievements_dyers_eve 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	getplayerinfo \{1
		score}
	getplayerinfo \{1
		part}
	if (<score> >= 450000 &&
			<part> = drum &&
			$current_song = dyerseve)
		achievements_awardplayer \{achievement = dyers_eve
			player = 1}
	endif
endscript

script achievements_fight_fire_with_fire 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	getplayerinfo \{1
		score}
	getplayerinfo \{1
		part}
	if (<score> >= 340000 &&
			<part> = bass &&
			$current_song = fightfirewithfire)
		achievements_awardplayer \{achievement = fight_fire_with_fire
			player = 1}
	endif
endscript

script achievements_stone_cold_crazy 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	getplayerinfo \{1
		score}
	getplayerinfo \{1
		part}
	if (<score> >= 90000 &&
			<part> = vocals &&
			$current_song = stonecoldcrazy)
		achievements_awardplayer \{achievement = stone_cold_crazy
			player = 1}
	endif
endscript

script achievements_astronomy 

	if NOT achievements_issongwon
		return
	endif
	if ($current_song != orion)
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> sp_phrases_hit
	getplayerinfo <player> sp_phrases_total


	if (<sp_phrases_hit> = <sp_phrases_total>)
		achievements_awardplayer achievement = astronomy player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_star_fleet_project 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($current_song != iwantitall)
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> character_id
	getplayerinfo <player> part
	if (<character_id> = eddie_van_halen2 || <character_id> = eddie_van_halen_alt2)
		if (<part> = guitar)
			achievements_awardplayer achievement = star_fleet_project player = <player>
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_i_have_a_sound_system 
	if gotparam \{name}

		if localizedstringequals a = <name> b = qs(0xc16f6fa0)

			achievements_awardband \{achievement = i_have_a_sound_system}
		endif
	endif
endscript

script achievements_its_alive 

	if achievements_ischeating
		return
	endif
	if gotparam \{player}
		gamemode_getnumplayersshown
		if (<num_players_shown> > 1)
			getplayerinfo <player> controller
			if (<controller> != ($band_mode_current_leader))

				return
			endif
		endif
		if is_part_unlocked part = cas_guitar_body desc_id = guitar_body_vhfstrat savegame = ($current_progression_savegame)

			achievements_awardplayer achievement = its_alive player = <player>
		endif
	endif
endscript

script achievements_beat_it 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if is_vanhalen_song
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> character_id

	if (<character_id> = eddie_van_halen2 || <character_id> = eddie_van_halen_alt2)
		achievements_awardplayer achievement = beat_it player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_eat_em_and_smile 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if is_vanhalen_song
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> character_id

	if (<character_id> = david_lee_roth2 || <character_id> = david_lee_roth_alt2)
		achievements_awardplayer achievement = eat_em_and_smile player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_respect_the_wind 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if is_vanhalen_song
		return
	endif

	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> character_id

	if (<character_id> = alex_van_halen2 || <character_id> = alex_van_halen_alt2)

		achievements_awardplayer achievement = respect_the_wind player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_fender_bender 

	if gotparam \{controller}
		writeachievements achievement = fender_bender controller_id = <controller>
	endif
endscript

script achievements_bang_your_gong 

	if gotparam \{controller}
		writeachievements achievement = bang_your_gong controller_id = <controller>
	endif
endscript

script achievements_ouch 

	if gotparam \{controller}
		writeachievements achievement = ouch controller_id = <controller>
	endif
endscript

script achievements_brown_sound 

	if NOT achievements_issongwon
		return
	endif
	if is_modern_band_vanhalen

		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> character_id
	if (<character_id> = eddie_van_halen_alt2)
		achievements_awardplayer achievement = brown_sound player = <player>
	endif
	if is_retro_band_vanhalen
		getplayerinfo <player> part
		if (<part> = guitar)
			achievements_awardplayer achievement = brown_sound player = <player>
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_diamond_dave 

	if NOT achievements_issongwon
		return
	endif
	if is_modern_band_vanhalen

		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> character_id
	if (<character_id> = david_lee_roth_alt2)
		achievements_awardplayer achievement = diamond_dave player = <player>
	endif
	if is_retro_band_vanhalen
		getplayerinfo <player> part
		if (<part> = vocals)
			achievements_awardplayer achievement = diamond_dave player = <player>
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_king_arthur 

	if NOT achievements_issongwon
		return
	endif
	if is_modern_band_vanhalen

		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> character_id
	if (<character_id> = alex_van_halen_alt2)
		achievements_awardplayer achievement = king_arthur player = <player>
	endif
	if is_retro_band_vanhalen
		getplayerinfo <player> part
		if (<part> = drum)
			achievements_awardplayer achievement = king_arthur player = <player>
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_rock_me_amadeus 

	if NOT achievements_issongwon

		return
	endif
	if is_modern_band_vanhalen

		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> character_id
	if (<character_id> = wolf_van_halen_alt2)

		achievements_awardplayer achievement = rock_me_amadeus player = <player>
	endif
	if is_retro_band_vanhalen
		getplayerinfo <player> part

		if (<part> = bass)
			achievements_awardplayer achievement = rock_me_amadeus player = <player>
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_you_really_got_me 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	if NOT (<num_players_shown> = 3)

		return
	endif
	if is_current_band_vanhalen
		<player> = 1
		begin
		getplayerinfo <player> part
		if (<part> = vocals)
			return
		endif
		<player> = (<player> + 1)
		repeat <num_players_shown>
		<player> = 1
		begin
		achievements_awardplayer achievement = you_really_got_me player = <player>
		<player> = (<player> + 1)
		repeat <num_players_shown>
		return
	endif
	<player> = 1
	<van_halens_found> = 0
	begin
	getplayerinfo <player> character_id
	getplayerinfo <player> part
	getplayerinfo <player> is_local_client
	<temp_cid> = <character_id>
	if (<is_local_client> = 0)
		getarraysize \{$net_musician_profiles}
		<nmp_size> = <array_size>
		<net_index> = 0
		begin
		if (<character_id> = ($net_musician_profiles [<net_index>].name))
			getarraysize \{$preset_musician_profiles_modifiable}
			<translate_index> = 0
			begin
			if (($net_musician_profiles [<net_index>].fullname) = ($preset_musician_profiles_modifiable [<translate_index>].fullname))

				<temp_cid> = ($preset_musician_profiles_modifiable [<translate_index>].name)
				break
			endif
			<translate_index> = (<translate_index> + 1)
			repeat <array_size>
		endif
		<net_index> = (<net_index> + 1)
		repeat <nmp_size>
	else
		unwindrandomappearance character_id = <character_id>
	endif

	if (<part> = drum)
		if (<temp_cid> = alex_van_halen2 || <temp_cid> = alex_van_halen_alt2)
			<van_halens_found> = (<van_halens_found> + 1)
		endif
	elseif (<part> = guitar)
		if (<temp_cid> = eddie_van_halen2 || <temp_cid> = eddie_van_halen_alt2)
			<van_halens_found> = (<van_halens_found> + 1)
		endif
	elseif (<part> = bass)
		if (<temp_cid> = wolf_van_halen2 || <temp_cid> = wolf_van_halen_alt2)
			<van_halens_found> = (<van_halens_found> + 1)
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>

	if (<van_halens_found> = 3)

		<player> = 1
		begin
		achievements_awardplayer achievement = you_really_got_me player = <player>
		<player> = (<player> + 1)
		repeat <num_players_shown>
	endif
endscript

script achievements_intruder 

	if achievements_ischeating
		return
	endif
	if gotparam \{player}

		achievements_awardplayer achievement = intruder player = <player>
	endif
endscript

script achievements_van_halen 

	if achievements_ischeating
		return
	endif
	if gotparam \{player}
		gamemode_getnumplayersshown
		if (<num_players_shown> > 1)
			getplayerinfo <player> controller
			if (<controller> != ($band_mode_current_leader))

				return
			endif
		endif

		achievements_awardplayer achievement = van_halen player = <player>
	endif
endscript

script achievements_gazzaris 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	if NOT (<num_players_shown> = 4)
		return
	endif
	<player> = 1

	begin
	achievements_awardplayer achievement = gazzaris player = <player>
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_cafe_wha 

	if NOT ($game_mode = p4_quickplay ||
			$game_mode = p4_career ||
			$game_mode = p8_pro_faceoff)
		return
	endif
	if ($game_mode = tutorial ||
			$game_mode = training ||
			$game_mode = p1_improv ||
			$rich_presence_context = presence_music_studio)
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($achievements_2x4_flag = 1)
		achievements_awardband \{achievement = cafe_wha}
		change \{achievements_2x4_flag = 0}
	endif
endscript

script achievements_whisky_a_gogo 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	if ($current_song = jamsession)

		return
	endif
	if NOT ($game_mode = p4_quickplay ||
			$game_mode = p4_career ||
			$game_mode = p8_pro_faceoff)

		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> part
	if (<part> != vocals)
		getplayerinfo <player> notes_hit
		getplayerinfo <player> total_notes
		getplayerinfo <player> max_notes
		if ((<notes_hit> < <max_notes>) || (<total_notes> = 0))

			return
		endif
	else
		getplayerinfo <player> vocal_phrase_quality
		getplayerinfo <player> vocal_phrase_max_qual
		if ((<vocal_phrase_quality> < <vocal_phrase_max_qual>) || (<vocal_phrase_quality> = 0))

			return
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
	achievements_awardband \{achievement = whisky_a_gogo}
endscript

script achievements_walter_mitty 

	if NOT ($game_mode = p4_quickplay ||
			$game_mode = p4_career ||
			$game_mode = p8_pro_faceoff)
		return
	endif
	if ($game_mode = tutorial ||
			$game_mode = training ||
			$game_mode = p1_improv ||
			$rich_presence_context = presence_music_studio)
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	<num_eights> = 0
	begin
	getplayerinfo <player> highest_multiplier

	if (<highest_multiplier> >= 7)
		<num_eights> = (<num_eights> + 1)
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>

	if (<num_eights> = 4)

		achievements_awardband \{achievement = walter_mittys_rock_n_roll_emporium}
	elseif ($achievements_super_group_unite_flag)

		change \{achievements_super_group_unite_flag = 0}
		achievements_awardband \{achievement = walter_mittys_rock_n_roll_emporium}
	endif
endscript

script achievements_evh 

	if achievements_ischeating
		return
	endif
	<guitar_array> = [guitar_body_vhbwolf guitar_body_vhfstrat guitar_body_vh2 guitar_body_vhswolf guitar_body_vh4 guitar_body_vhdlr guitar_body_vhshark]
	<bass_array> = [bass_body_style_vhystripe bass_body_style_vhblue]
	if gotparam \{player}
		gamemode_getnumplayersshown
		if (<num_players_shown> > 1)
			getplayerinfo <player> controller
			if (<controller> != ($band_mode_current_leader))

				return
			endif
		endif
		getarraysize <guitar_array>
		<guitar_index> = 0
		<guitars_found> = 0
		begin
		if is_part_unlocked part = cas_guitar_body desc_id = (<guitar_array> [<guitar_index>]) savegame = ($current_progression_savegame)
			<guitars_found> = (<guitars_found> + 1)
		endif
		<guitar_index> = (<guitar_index> + 1)
		repeat <array_size>
		getarraysize <bass_array>
		<bass_index> = 0
		<bass_found> = 0
		begin
		if is_part_unlocked part = cas_bass_body desc_id = (<bass_array> [<bass_index>]) savegame = ($current_progression_savegame)
			<bass_found> = (<bass_found> + 1)
		endif
		<bass_index> = (<bass_index> + 1)
		repeat <array_size>

		if (<guitars_found> = 7 && <bass_found> = 2)
			if is_part_unlocked part = cas_mic desc_id = mic_vhdlr savegame = ($current_progression_savegame)

				achievements_awardplayer achievement = evh player = <player>
			endif
		endif
	endif
endscript

script achievements_where_have_all_the_good_times_gone 

	if ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff || $game_mode = p2_battle)

		return
	endif
	if NOT achievements_issongwon

		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	begin
	getplayerinfo <player> part
	getplayerinfo <player> character_id

	if (<character_id> = eddie_van_halen2 || <character_id> = eddie_van_halen_alt2 ||
			<character_id> = wolf_van_halen2 || <character_id> = wolf_van_halen_alt2 ||
			<character_id> = alex_van_halen2 || <character_id> = alex_van_halen_alt2 ||
			<character_id> = david_lee_roth2 || <character_id> = david_lee_roth_alt2)
		getplayerinfo <player> controller
		getglobaltags savegame = <savegame> achievement_info param = achievement_all_instruments

		switch (<part>)
			case guitar
			if NOT (<achievement_all_instruments> && 1)
				<achievement_all_instruments> = (<achievement_all_instruments> + 1)
			endif
			case bass
			if NOT (<achievement_all_instruments> && 2)
				<achievement_all_instruments> = (<achievement_all_instruments> + 2)
			endif
			case drum
			if NOT (<achievement_all_instruments> && 4)
				<achievement_all_instruments> = (<achievement_all_instruments> + 4)
			endif
			case vocals
			if NOT (<achievement_all_instruments> && 8)
				<achievement_all_instruments> = (<achievement_all_instruments> + 8)
			endif
		endswitch
		setglobaltags savegame = <savegame> achievement_info params = {achievement_all_instruments = <achievement_all_instruments>}

		if (<achievement_all_instruments> = 15)
			achievements_awardplayer achievement = where_have_all_the_good_times_gone player = <player>
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_hot_for_high_scores 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	if (<num_players_shown> != 4)
		return
	endif
	if (($band1_status.score) >= 800000 &&
			$current_song = hotforteacher)
		achievements_awardband \{achievement = hot_for_high_scores}
	endif
endscript

script achievements_im_the_one 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	getplayerinfo \{1
		score}
	getplayerinfo \{1
		part}
	getplayerinfo \{1
		difficulty}
	if (<score> >= 225000 &&
			$current_song = imtheone &&
			<part> = guitar &&
			<difficulty> = expert)
		achievements_awardplayer \{achievement = im_the_one
			player = 1}
	endif
endscript

script achievements_the_broken_combs 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	<gig> = 3
	<part_array> = ['guitar' 'bass' 'drum' 'vocals' 'band']
	begin
	<eligible> = 1
	if (<num_players_shown> > 1)
		getplayerinfo <player> controller
		if (<controller> != ($band_mode_current_leader))
			<eligible> = 0
		endif
	endif
	if (<eligible> = 1)
		<part_index> = 0
		getarraysize <part_array>
		begin
		achievements_hasgigbeenwon player = <player> gignum = <gig> part = (<part_array> [<part_index>])
		if (<num_gigs_won> = 1)

			achievements_awardplayer achievement = the_broken_combs player = <player>
		endif
		<part_index> = (<part_index> + 1)
		repeat <array_size>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_the_trojan_rubber_company 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	<gig> = 7
	<part_array> = ['guitar' 'bass' 'drum' 'vocals' 'band']
	begin
	<eligible> = 1
	if (<num_players_shown> > 1)
		getplayerinfo <player> controller
		if (<controller> != ($band_mode_current_leader))
			<eligible> = 0
		endif
	endif
	if (<eligible> = 1)
		<part_index> = 0
		getarraysize <part_array>
		begin
		achievements_hasgigbeenwon player = <player> gignum = <gig> part = (<part_array> [<part_index>])
		if (<num_gigs_won> = 1)
			achievements_awardplayer achievement = the_trojan_rubber_company player = <player>

		endif
		<part_index> = (<part_index> + 1)
		repeat <array_size>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_van_halen_ii 

	if achievements_ischeating
		return
	endif
	if gotparam \{player}
		gamemode_getnumplayersshown
		if (<num_players_shown> > 1)
			getplayerinfo <player> controller
			if (<controller> != ($band_mode_current_leader))

				return
			endif
		endif

		achievements_awardplayer achievement = van_halen_ii player = <player>
	endif
endscript

script achievements_jump 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	<gig_array> = [1 3 5 7 9 10]
	<part_array> = ['guitar' 'bass' 'drum' 'vocals' 'band']
	begin
	<eligible> = 1
	if (<num_players_shown> > 1)
		getplayerinfo <player> controller
		if (<controller> != ($band_mode_current_leader))
			<eligible> = 0
		endif
	endif
	if (<eligible> = 1)
		<part_index> = 0
		getarraysize <part_array>
		<part_array_size_holder> = <array_size>
		begin
		getarraysize <gig_array>
		<gig_index> = 0
		<win_counter> = 0
		begin
		achievements_hasgigbeenwon player = <player> gignum = (<gig_array> [<gig_index>]) part = (<part_array> [<part_index>])
		if (<num_gigs_won> = 1)
			<win_counter> = (<win_counter> + 1)
		endif
		<gig_index> = (<gig_index> + 1)
		repeat <array_size>

		if (<win_counter> = 6)
			achievements_awardplayer achievement = jump player = <player>
		endif
		<part_index> = (<part_index> + 1)
		repeat <part_array_size_holder>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_unchained 

	if achievements_ischeating
		return
	endif
	<char_array> = [eddie_van_halen_alt2 alex_van_halen_alt2 wolf_van_halen_alt2 david_lee_roth_alt2 eddie_van_halen2 alex_van_halen2 wolf_van_halen2 david_lee_roth2]
	if gotparam \{player}
		gamemode_getnumplayersshown
		if (<num_players_shown> > 1)
			getplayerinfo <player> controller
			if (<controller> != ($band_mode_current_leader))

				return
			endif
		endif
		getarraysize <char_array>
		<char_index> = 0
		<chars_found> = 0
		begin
		get_musician_profile_struct_by_id id = (<char_array> [<char_index>]) savegame = 0
		if is_profile_unlocked savegame = ($current_progression_savegame) profile_struct = <profile_struct>
			<chars_found> = (<chars_found> + 1)
		endif
		<char_index> = (<char_index> + 1)
		repeat <array_size>

		if (<chars_found> = <array_size>)

			achievements_awardplayer achievement = unchained player = <player>
		endif
	endif
endscript

script achievements_genesis 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	<gig_array> = [8 9]
	<part_array> = ['guitar' 'bass' 'drum' 'vocals' 'band']
	begin
	<eligible> = 1
	if (<num_players_shown> > 1)
		getplayerinfo <player> controller
		if (<controller> != ($band_mode_current_leader))
			<eligible> = 0
		endif
	endif
	if (<eligible> = 1)
		<part_index> = 0
		getarraysize <part_array>
		<part_array_size_holder> = <array_size>
		begin
		getarraysize <gig_array>
		<gig_index> = 0
		<win_counter> = 0
		begin
		achievements_hasgigbeenwon player = <player> gignum = (<gig_array> [<gig_index>]) part = (<part_array> [<part_index>])
		if (<num_gigs_won> >= 1)
			<win_counter> = (<win_counter> + 1)
		endif
		<gig_index> = (<gig_index> + 1)
		repeat <array_size>

		if (<win_counter> = 2)
			achievements_awardplayer achievement = genesis player = <player>
		endif
		<part_index> = (<part_index> + 1)
		repeat <part_array_size_holder>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_the_space_brothers 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	<gig_array> = [2 4]
	<part_array> = ['guitar' 'bass' 'drum' 'vocals' 'band']
	begin
	<eligible> = 1
	if (<num_players_shown> > 1)
		getplayerinfo <player> controller
		if (<controller> != ($band_mode_current_leader))
			<eligible> = 0
		endif
	endif
	if (<eligible> = 1)
		<part_index> = 0
		getarraysize <part_array>
		<part_array_size_holder> = <array_size>
		begin
		getarraysize <gig_array>
		<gig_index> = 0
		<win_counter> = 0
		begin
		achievements_hasgigbeenwon player = <player> gignum = (<gig_array> [<gig_index>]) part = (<part_array> [<part_index>])
		if (<num_gigs_won> >= 1)
			<win_counter> = (<win_counter> + 1)
		endif
		<gig_index> = (<gig_index> + 1)
		repeat <array_size>

		if (<win_counter> = 2)

			achievements_awardplayer achievement = the_space_brothers player = <player>
		endif
		<part_index> = (<part_index> + 1)
		repeat <part_array_size_holder>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_women_and_children_first 

	if achievements_ischeating
		return
	endif
	if gotparam \{player}
		gamemode_getnumplayersshown
		if (<num_players_shown> > 1)
			getplayerinfo <player> controller
			if (<controller> != ($band_mode_current_leader))

				return
			endif
		endif

		achievements_awardplayer achievement = women_and_children_first player = <player>
	endif
endscript

script achievements_guitar_god 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	<player> = 1
	<gig_array> = [1 3 5 7 9 10]
	getplayerinfo <player> part
	if (<part> = guitar)
		<total_fived> = 0
		getarraysize <gig_array>
		<gig_index> = 0
		begin
		achievements_hasgigbeenwonondiff player = <player> gignum = (<gig_array> [<gig_index>]) part = 'guitar' diff = expert
		<total_fived> = (<total_fived> + <num_gigs_fived>)
		<gig_index> = (<gig_index> + 1)
		repeat <array_size>

		if (<total_fived> >= 6)
			achievements_awardplayer achievement = guitar_god player = <player>
		endif
	endif
endscript

script achievements_diamond_in_the_rough 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	<player> = 1
	<gig_array> = [1 3 5 7 9 10]
	getplayerinfo <player> part
	if (<part> = vocals)
		<total_fived> = 0
		getarraysize <gig_array>
		<gig_index> = 0
		begin
		achievements_hasgigbeenwonondiff player = <player> gignum = (<gig_array> [<gig_index>]) part = 'vocals' diff = expert
		<total_fived> = (<total_fived> + <num_gigs_fived>)
		<gig_index> = (<gig_index> + 1)
		repeat <array_size>

		if (<total_fived> >= 6)
			achievements_awardplayer achievement = diamond_in_the_rough player = <player>
		endif
	endif
endscript

script achievements_double_bass_master 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	<gig_array> = [1 3 5 7 9 10]
	getplayerinfo \{1
		part}
	if (<part> = drum)
		<total_fived> = 0
		getarraysize <gig_array>
		<gig_index> = 0
		begin
		achievements_hasgigbeenwonondiff player = 1 gignum = (<gig_array> [<gig_index>]) part = 'drum' diff = expert
		<total_fived> = (<total_fived> + <num_gigs_fived>)
		<gig_index> = (<gig_index> + 1)
		repeat <array_size>

		if (<total_fived> >= 6)
			achievements_awardplayer \{achievement = double_bass_master
				player = 1}
		endif
	endif
endscript

script achievements_316 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	<player> = 1
	<gig_array> = [1 3 5 7 9 10]
	getplayerinfo <player> part
	if (<part> = bass)
		<total_fived> = 0
		getarraysize <gig_array>
		<gig_index> = 0
		begin
		achievements_hasgigbeenwonondiff player = <player> gignum = (<gig_array> [<gig_index>]) part = 'bass' diff = expert
		<total_fived> = (<total_fived> + <num_gigs_fived>)
		<gig_index> = (<gig_index> + 1)
		repeat <array_size>

		if (<total_fived> >= 6)

			achievements_awardplayer achievement = threeonesix player = <player>
		endif
	endif
endscript

script achievements_red_ball_jets 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	<gig_array> = [1 2 3 4 5 6 7 8 9 10]
	<part_array> = ['guitar' 'bass' 'drum' 'vocals' 'band']
	begin
	<eligible> = 1
	if (<num_players_shown> > 1)
		getplayerinfo <player> controller
		if (<controller> != ($band_mode_current_leader))
			<eligible> = 0
		endif
	endif
	if (<eligible> = 1)
		<part_index> = 0
		getarraysize <part_array>
		<part_array_size_holder> = <array_size>
		begin
		getarraysize <gig_array>
		<gig_index> = 0
		<num_diffs_won> = 0
		begin
		achievements_hasgigbeenwon player = <player> gignum = (<gig_array> [<gig_index>]) part = (<part_array> [<part_index>])
		<num_diffs_won> = (<num_diffs_won> + <num_gigs_won>)
		<gig_index> = (<gig_index> + 1)
		repeat <array_size>

		if (<num_diffs_won> > 5)
			achievements_awardplayer achievement = red_ball_jets player = <player>

		endif
		<part_index> = (<part_index> + 1)
		repeat <part_array_size_holder>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_fair_warning 

	if achievements_ischeating
		return
	endif
	if gotparam \{player}
		gamemode_getnumplayersshown
		if (<num_players_shown> > 1)
			getplayerinfo <player> controller
			if (<controller> != ($band_mode_current_leader))

				return
			endif
		endif

		achievements_awardplayer achievement = fair_warning player = <player>
	endif
endscript

script achievements_mammoth 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	<gig_array> = [5 6]
	<part_array> = ['guitar' 'bass' 'drum' 'vocals' 'band']
	begin
	<eligible> = 1
	if (<num_players_shown> > 1)
		getplayerinfo <player> controller
		if (<controller> != ($band_mode_current_leader))
			<eligible> = 0
		endif
	endif
	if (<eligible> = 1)
		<part_index> = 0
		getarraysize <part_array>
		<part_array_size_holder> = <array_size>
		begin
		getarraysize <gig_array>
		<gig_index> = 0
		<win_counter> = 0
		begin
		achievements_hasgigbeenwon player = <player> gignum = (<gig_array> [<gig_index>]) part = (<part_array> [<part_index>])
		if (<num_gigs_won> = 1)
			<win_counter> = (<win_counter> + 1)
		endif
		<gig_index> = (<gig_index> + 1)
		repeat <array_size>

		if (<win_counter> = 2)
			achievements_awardplayer achievement = mammoth player = <player>
		endif
		<part_index> = (<part_index> + 1)
		repeat <part_array_size_holder>
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_diver_down 

	if achievements_ischeating
		return
	endif
	if gotparam \{player}
		gamemode_getnumplayersshown
		if (<num_players_shown> > 1)
			getplayerinfo <player> controller
			if (<controller> != ($band_mode_current_leader))

				return
			endif
		endif

		achievements_awardplayer achievement = diver_down player = <player>
	endif
endscript

script achievements_1984 

	if achievements_ischeating
		return
	endif
	if gotparam \{player}
		gamemode_getnumplayersshown
		if (<num_players_shown> > 1)
			getplayerinfo <player> controller
			if (<controller> != ($band_mode_current_leader))

				return
			endif
		endif

		achievements_awardplayer achievement = nineteen84 player = <player>
	endif
endscript

script achievements_1984_helper 

	if NOT achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	get_current_band_info
	getglobaltags <band_info>
	if ($current_num_players > 1)
		if (<career_credits_band_complete> = 0)
			return
		endif
	elseif
		getplayerinfo \{1
			part}
		if NOT (<part> = drum)

			return
		endif
		if (<career_credits_drum_complete> = 0)

			return
		endif
	endif

	gamemode_getnumplayersshown
	<player> = 1
	begin
	<eligible> = 1
	if (<num_players_shown> > 1)
		getplayerinfo <player> controller
		if (<controller> != ($band_mode_current_leader))

			<eligible> = 0
		endif
	endif
	getplayerinfo <player> part

	if (<part> = drum && <eligible> = 1)
		if played_all_expertplus_songs player = <player>

			achievements_awardplayer achievement = nineteen84 player = <player>
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript

script achievements_the_woodshed 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayers
	if (<num_players> > 1)
		return
	endif
	<player> = 1
	<song_array> = [eruption littleguitars cathedral spanishfly]
	begin
	<total_fived> = 0
	getarraysize <song_array>
	<song_index> = 0
	begin
	format_globaltag_song_checksum part = guitar song = (<song_array> [<song_index>]) difficulty = expert
	getglobaltags <song_checksum> params = stars
	getglobaltags <song_checksum> params = beststars
	if (<stars> > 4)
		<total_fived> = (<total_fived> + 1)

	elseif (<beststars> > 4)
		<total_fived> = (<total_fived> + 1)

	endif
	<song_index> = (<song_index> + 1)
	repeat <array_size>

	if (<total_fived> = <array_size>)
		achievements_awardplayer achievement = the_woodshed player = <player>
	endif
	<player> = (<player> + 1)
	repeat <num_players>
endscript

script achievements_5150 

	if achievements_issongwon
		return
	endif
	if achievements_ischeating
		return
	endif
	gamemode_getnumplayersshown
	<player> = 1
	<gig_array> = [1 3 5 7 9 10]
	<part_array> = ['guitar' 'bass' 'drum' 'vocals']
	begin
	<eligible> = 1
	if (<num_players_shown> > 1)
		getplayerinfo <player> controller
		if (<controller> != ($band_mode_current_leader))
			<eligible> = 0
		endif
	endif
	if (<eligible> = 1)
		<part_index> = 0
		getarraysize <part_array>
		<part_array_size_holder> = <array_size>
		<win_counter> = 0
		begin
		getarraysize <gig_array>
		<gig_index> = 0

		begin
		achievements_hasgigbeenwon player = <player> gignum = (<gig_array> [<gig_index>]) part = (<part_array> [<part_index>])
		if (<num_gigs_won> >= 1)
			<win_counter> = (<win_counter> + 1)
		endif
		<gig_index> = (<gig_index> + 1)
		repeat <array_size>
		<part_index> = (<part_index> + 1)
		repeat <part_array_size_holder>

		if (<win_counter> = 24)
			achievements_awardplayer achievement = fiftyonefifty player = <player>
		endif
	endif
	<player> = (<player> + 1)
	repeat <num_players_shown>
endscript
