
script get_quickplay_song_score 
	if NOT GotParam \{difficulty_text_nl}
		if ($game_mode = p2_quickplay)
			get_difficulty_text_nl difficulty = ($current_difficulty_coop)
		else
			get_difficulty_text_nl difficulty = ($player1_status.difficulty)
		endif
	endif
	if NOT GotParam \{part}
		part = 'guitar'
	endif
	get_formatted_songname song_prefix = <song> difficulty_text_nl = <difficulty_text_nl> part = <part>
	GetGlobalTags <songname>
	return score = <bestscore>
endscript

script get_quickplay_song_stars 
	if NOT GotParam \{part}
		part = 'guitar'
	endif
	get_formatted_songname song_prefix = <song> difficulty_text_nl = <difficulty_text_nl> part = <part>
	GetGlobalTags <songname>
	return stars = <beststars> percent100 = <tr_percent100>
endscript
setlist_random_bg_images = ASSERT_ON_USE
setlist_solid_lines = ASSERT_ON_USE
setlist_dotted_lines = ASSERT_ON_USE
setlist_loop_stars = ASSERT_ON_USE
setlist_event_handlers = ASSERT_ON_USE
set_song_icon = ASSERT_ON_USE
get_tier_from_song = ASSERT_ON_USE
clear_setlist_clip_and_art = ASSERT_ON_USE
setlist_go_back = ASSERT_ON_USE
create_setlist_menu = ASSERT_ON_USE
create_setlist_scrolling_menu = ASSERT_ON_USE
destroy_setlist_scrolling_menu = ASSERT_ON_USE
destroy_setlist_songpreview_monitor = ASSERT_ON_USE
destroy_setlist_menu = ASSERT_ON_USE
setlist_choose_song = ASSERT_ON_USE
setlist_debug_completesong = ASSERT_ON_USE
setlist_debug_unlockall = ASSERT_ON_USE
setlist_scroll = ASSERT_ON_USE
setlist_display_random_bg_image = ASSERT_ON_USE
change_tab = ASSERT_ON_USE
reset_vars = ASSERT_ON_USE
create_sl_assets = ASSERT_ON_USE
setlist_show_helperbar = ASSERT_ON_USE
setlist_return_to_2p_hub = ASSERT_ON_USE
