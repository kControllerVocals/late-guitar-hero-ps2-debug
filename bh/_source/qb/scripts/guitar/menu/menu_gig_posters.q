current_gig_number = 1
current_progression_flag = none
menu_gp_current_selection = 1
menu_gp_stage = 1
menu_gp_last_gignum = 1
should_reset_gig_posters_selection = 0
g_hack_all_gigs_unlocked = 0

script gig_posters_song_focus \{song = none}
	SetSoundBussParams {Music_Setlist = {vol = ($Default_BussSet.Music_Setlist.vol)}}
	KillSpawnedScript \{name = gigposters_cycle_song_previews_spawned}
	reset_songpreview
	Wait \{2
		gameframes}
	set_songpreview song = <song>
endscript

script get_songs_available_for_create_a_setlist progression_flag = ($current_progression_flag)
	return \{num_songs_available = 0
		unlocked_songs_array = [
		]}
endscript

script wait_for_camera_anim 
	Wait \{5
		gameframes}
	begin
	if is_menu_camera_finished
		break
	endif
	Wait \{1
		gameframe}
	repeat
endscript
gig_posters_choose_next = ASSERT_ON_USE
net_gig_posters_choose_next = ASSERT_ON_USE
create_gig_posters_menu = ASSERT_ON_USE
gig_posters_setup_helpers = ASSERT_ON_USE
gig_posters_back = ASSERT_ON_USE
monitor_gig_poster_selection = ASSERT_ON_USE
gigposters_camera_out = ASSERT_ON_USE
update_gigboard_arrows = ASSERT_ON_USE
destroy_gig_posters_menu = ASSERT_ON_USE
gig_posters_focus_popup = ASSERT_ON_USE
gig_posters_unfocus_popup = ASSERT_ON_USE
gig_posters_move_selection = ASSERT_ON_USE
gig_posters_up = ASSERT_ON_USE
gig_posters_down = ASSERT_ON_USE
create_gig_poster_venue_select = ASSERT_ON_USE
gigposter_venue_focus = ASSERT_ON_USE
gigposter_venue_unfocus = ASSERT_ON_USE
create_gig_poster_setlist = ASSERT_ON_USE
gigposters_setlist_item_focus = ASSERT_ON_USE
gigposters_setlist_item_unfocus = ASSERT_ON_USE
gig_posters_setlist_back = ASSERT_ON_USE
debug_output_gigposter_creation_numbers = ASSERT_ON_USE
reset_gigposter_creation_numbers = ASSERT_ON_USE
setup_gigboard_poster = ASSERT_ON_USE
create_gigboard_poster_with_viewport = ASSERT_ON_USE
create_gig_posters_window = ASSERT_ON_USE
destroy_gig_posters_window = ASSERT_ON_USE
debug_complete_gig_cheat = ASSERT_ON_USE
isGigUnlocked = ASSERT_ON_USE
gigposters_toggle_with_fire = ASSERT_ON_USE
show_setlist_on_gigboard = ASSERT_ON_USE
get_gigboard_section = ASSERT_ON_USE
destroy_gigboard_setlist_viewport = ASSERT_ON_USE
gigposters_cycle_song_previews = ASSERT_ON_USE
gigposters_cycle_song_previews_spawned = ASSERT_ON_USE
toggle_gigposter_difficulty_texture = ASSERT_ON_USE
debug_yuk = ASSERT_ON_USE
debug_gig_start = ASSERT_ON_USE
kill_all_posters = ASSERT_ON_USE
search_for_tool_in_gig = ASSERT_ON_USE
get_gigposter_pos_in_2d = ASSERT_ON_USE
gig_do_hand_animation = ASSERT_ON_USE
wait_and_do_gigboard_hand_animation = ASSERT_ON_USE
get_gigposter_camera_name = ASSERT_ON_USE
get_gigposter_camera_name_section = ASSERT_ON_USE
replace_texture_on_gig_posters = ASSERT_ON_USE
create_small_gig_poster = ASSERT_ON_USE
gigboard_get_exclusive_controller = ASSERT_ON_USE
ui_create_handslapper = ASSERT_ON_USE
Anim_Handslapper = ASSERT_ON_USE
