intro_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 135.0)
	song_artist_pos = (255.0, 150.0)
	song_title_start_time = -6500
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -2000
	highway_move_time = 2000
	button_ripple_start_time = -800
	button_ripple_per_button_time = 100
	hud_start_time = 0
	hud_move_time = 200
}
fastintro_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 135.0)
	song_artist_pos = (255.0, 150.0)
	song_title_start_time = -6700
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -2000
	highway_move_time = 2000
	button_ripple_start_time = -800
	button_ripple_per_button_time = 100
	hud_start_time = 0
	hud_move_time = 200
}
practice_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 135.0)
	song_artist_pos = (255.0, 150.0)
	song_title_start_time = -6500
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -3000
	highway_move_time = 2000
	button_ripple_start_time = -1800
	button_ripple_per_button_time = 100
	hud_start_time = -1400
	hud_move_time = 200
}
immediate_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 135.0)
	song_artist_pos = (255.0, 150.0)
	song_title_start_time = 0
	song_title_fade_time = 700
	song_title_on_time = 0
	highway_start_time = 0
	highway_move_time = 0
	button_ripple_start_time = 0
	button_ripple_per_button_time = 0
	hud_start_time = 0
	hud_move_time = 0
}
current_intro = $fast_intro_sequence_props
g_playing_intro = 0

script play_intro 
	0x1ab37dde
	if ($g_playing_intro)

		return
	endif
	change \{g_playing_intro = 1}
	player = 1
	begin
	<player_status> = ($0x2994109a [<player>])
	enableinput off controller = ($<player_status>.controller)
	player = (<player> + 1)
	repeat $current_num_players
	killspawnedscript \{name = loading_screen_crowd_swell}
	killspawnedscript \{name = crowd_loading_whistle}

	start_drummer_cameras
	gamemode_getnumplayersshown
	if ($is_attract_mode = 1)
		disable_bg_viewport
		return
	endif
	killspawnedscript \{name = guitarevent_songfailed_spawned}
	if gotparam \{fast}
		change \{current_intro = $fastintro_sequence_props}
	elseif gotparam \{practice}
		change \{current_intro = $practice_sequence_props}
	else
		change \{current_intro = $intro_sequence_props}
	endif
	show_song_info = 1
	if ($g_in_tutorial = 1)
		show_song_info = 0
	endif
	if (<show_song_info> = 1)
		spawnscriptnow \{intro_song_info
			id = intro_scripts}
	endif
	if NOT ($cheat_performancemode = 1 && $is_network_game = 0)
		spawnscriptnow \{intro_highway_move
			id = intro_scripts}
	endif
	if (<num_players_shown> > 0)
		player = 1
		begin
		<player_status> = ($0x2994109a [<player>])
		<player_text> = ($0x57e22f28 [<player>])
		spawnscriptnow intro_buttonup_ripple params = <...> id = intro_scripts
		player = (<player> + 1)
		repeat <num_players_shown>
	endif
	if (($tutorial_disable_hud = 0) && ($end_credits = 0))
		spawnscriptnow \{intro_hud_move
			id = intro_scripts}
	endif
	bandmanager_setplayingintroanims
endscript

script destroy_intro 
	killspawnedscript \{id = intro_scripts}
	killspawnedscript \{name = song_intro_kick_sfx_waiting}
	killspawnedscript \{name = song_intro_highway_up_sfx_waiting}
	killspawnedscript \{name = intro_buttonup_ripple}
	killspawnedscript \{name = intro_hud_move}
	destroyscreenelement \{id = intro_container}
	<num_players> = $current_num_players
	if (<num_players> > 0)
		player = 1
		begin
		<player_status> = ($0x2994109a [<player>])
		enableinput controller = ($<player_status>.controller)
		player = (<player> + 1)
		repeat <num_players>
	endif
	change \{g_playing_intro = 0}
endscript

script intro_buttonup_ripple 
	enableinput off controller = ($<player_status>.controller)
	begin
	getsongtimems
	if ($current_intro.button_ripple_start_time + $current_starttime < <time>)
		break
	endif
	waitonegameframe
	repeat
	if ($current_intro.button_ripple_per_button_time = 0)
		enableinput controller = ($<player_status>.controller)
		return
	endif
	getarraysize \{$gem_colors}
	all_vocals = 1
	<num_players> = $current_num_players
	if (<num_players> > 0)
		player = 1
		begin
		<current_player_status> = ($0x2994109a [<player>])
		if NOT ($<current_player_status>.part = vocals)
			all_vocals = 0
			break
		endif
		player = (<player> + 1)
		repeat <num_players>
	endif
	if (<all_vocals> = 0)
		soundevent \{event = notes_ripple_up_sfx}
	endif
	extendcrc button_up_pixel_array ($<player_status>.text) out = pixel_array
	buttonup_count = 0
	begin
	wait ($current_intro.button_ripple_per_button_time / 1000.0) seconds
	array_count = 0
	begin
	color = ($gem_colors [<array_count>])
	if (<array_count> = <buttonup_count>)
		setarrayelement arrayname = <pixel_array> globalarray index = <array_count> newvalue = $button_up_pixels
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
	buttonup_count = (<buttonup_count> + 1)
	repeat (<array_size> + 1)
	enableinput controller = ($<player_status>.controller)
endscript

script intro_song_info 
	begin
	getsongtimems
	if ($current_intro.song_title_start_time + $current_starttime < <time>)
		break
	endif
	waitonegameframe
	repeat
	if ($current_intro.song_title_on_time = 0)
		return
	endif
	if ($transition_playing = true)
		if ($current_playing_transition = careerintro)
			return
		endif
	endif
	disable_pause
	if screenelementexists \{id = intro_container}
		destroyscreenelement \{id = intro_container}
	endif
	<current_song> = $current_song
	get_song_title song = <current_song>
	get_song_artist_text song = <current_song>
	get_song_artist song = <current_song>
	if (<current_song> = jamsession)
		year = 2008
		if ui_event_exists_in_stack \{name = 'setlist'}
			current_song_jam_index = ($temp_jamsession_song_list [($quickplay_song_list_current)])
			getarraysize ($jam_curr_directory_listing) param = directory_size
			if (<current_song_jam_index> > 0 && <current_song_jam_index> < <directory_size>)
				<year> = ($jam_curr_directory_listing [<current_song_jam_index>].year)
			endif
		elseif ui_event_exists_in_stack \{name = 'jam'}
			jam_struct = ($jamsession_songlist_props.jamsession)
			year = (<jam_struct>.year_num)
		endif
		if NOT gotparam \{song_artist}
			get_savegame_from_controller controller = ($primary_controller)
			get_current_band_info
			getglobaltags savegame = <savegame> <band_info>
			song_artist = qs(0xbf9c7a91)
			if gotparam \{name}
				if (<name> != qs(0x03ac90f0))
					song_artist = <name>
				endif
			endif
			formattext textname = year_text qs(0x06d54ab3) d = <year>
			song_artist = (<song_artist> + <year_text>)
		endif
	endif
	createscreenelement {
		parent = root_window
		id = intro_container
		type = descinterface
		desc = 'song_intro'
		alpha = 0
		z_priority = 500
		intro_artist_text = <song_artist>
		intro_title_text = <song_title>
		intro_performed_text = <song_artist_text>
	}
	fade_time = ($current_intro.song_title_fade_time / 1000.0)
	intro_container :se_setprops alpha = 1 time = <fade_time>
	intro_container :se_waitprops
	wait ($current_intro.song_title_on_time / 1000.0) seconds
	intro_container :se_setprops alpha = 0 time = <fade_time>
	intro_container :se_waitprops
	destroyscreenelement \{id = intro_container}
	enable_pause
endscript

script intro_highway_move 
	killspawnedscript \{name = oneshotsbetweensongs}
	killspawnedscript \{name = surgebetweensongs}
	begin
	getsongtimems
	if ($current_intro.highway_start_time + $current_starttime < <time>)
		break
	endif
	waitonegameframe
	repeat
	all_vocals = 1
	<num_players> = $current_num_players
	if (<num_players> > 0)
		player = 1
		begin
		<player_status> = ($0x2994109a [<player>])
		if NOT ($<player_status>.part = vocals)
			all_vocals = 0
			break
		endif
		player = (<player> + 1)
		repeat <num_players>
	endif
	if (<all_vocals> = 0)
		spawnscriptnow \{song_intro_highway_up_sfx_waiting}
	else
		spawnscriptnow \{song_intro_highway_up_vocals_sfx_waiting}
	endif
	gamemode_getnumplayersshown
	if (<num_players_shown> > 0)
		player = 1
		begin
		<player_status> = ($0x2994109a [<player>])
		<player_text> = ($0x57e22f28 [<player>])
		vocals_highway_slide_in player = <player>
		move_highway_camera_to_default <...> time = ($current_intro.highway_move_time / 1000.0)
		player = (<player> + 1)
		repeat <num_players_shown>
	endif
endscript

script intro_hud_move 
	begin
	getsongtimems
	if ($current_intro.hud_start_time + $current_starttime < <time>)
		break
	endif
	waitonegameframe
	repeat
	gamemode_getnumplayersshown
	if (<num_players_shown> > 0)
		player = 1
		begin
		<player_status> = ($0x2994109a [<player>])
		<player_text> = ($0x57e22f28 [<player>])
		move_hud_to_default time = ($current_intro.hud_move_time / 1000.0)
		player = (<player> + 1)
		repeat <num_players_shown>
	endif
	all_vocals = 1
	<num_players> = $current_num_players
	if (<num_players> > 0)
		player = 1
		begin
		<player_status> = ($0x2994109a [<player>])
		if NOT ($<player_status>.part = vocals)
			all_vocals = 0
			break
		endif
		player = (<player> + 1)
		repeat <num_players>
	endif
	spawnscriptnow \{song_intro_kick_sfx_waiting}
endscript

script intro_check_for_celeb_intro_ui 
	0x93d8d5cf \{'celebrity intros should be done from zone transition'}
	return
	transition_getprefix type = ($current_playing_transition)
	if (<type_textnl> = 'celebintro')
		spawnscriptnow intro_celeb_ui params = {celeb_intro = <type_textnl>}
	endif
endscript

script intro_celeb_ui 
	switch <celeb_intro>
		case intro_bellamy
		<start_delay> = 7.8
		<duration> = 3.0
		case intro_cobain
		<start_delay> = 6.0
		<duration> = 3.2
		case intro_manson
		<start_delay> = 7.5
		<duration> = 3.5
		case intro_santana
		<start_delay> = 4.0
		<duration> = 3.0
		default
		<start_delay> = 2.0
		<duration> = 4.0
	endswitch
	wait <start_delay> seconds
	if screenelementexists \{id = celeb_intro_ui_cont}
		0x93d8d5cf \{'a celebrity intro ui is already up!'}
	endif
	createscreenelement \{type = containerelement
		id = celeb_intro_ui_cont
		parent = root_window
		pos = (0.0, 0.0)
		z_priority = 100}
	setsearchallassetcontexts
	createscreenelement \{parent = celeb_intro_ui_cont
		id = celeb_intro_ui
		type = descinterface
		desc = 'celeb_intro'}
	celeb_intro_ui :se_setprops {
		firstname_text = <firstname>
	}
	setsearchallassetcontexts \{off}
	celeb_intro_ui :desc_resolvealias \{name = alias_frame_anim}
	assignalias id = <resolved_id> alias = frame_anim
	frame_anim :se_getprops \{pos}
	<frame_anim_pos> = <pos>
	celeb_intro_ui :desc_resolvealias \{name = alias_frame_container}
	assignalias id = <resolved_id> alias = frame_container
	frame_container :se_setprops \{alpha = 1}
	frame_container :se_getprops \{pos}
	<frame_container> = <pos>
	frame_anim :se_waitprops
	frame_anim :se_waitprops
	<time_between_bounces> = 0.01
	wait (<duration> - <time_between_bounces>) seconds
	frame_anim :se_waitprops
	frame_anim :se_waitprops
	frame_anim :se_waitprops
	frame_anim :se_waitprops
	frame_anim :se_setprops \{alpha = 0
		time = 0.1}
	frame_anim :se_waitprops
	destroyscreenelement \{id = celeb_intro_ui_cont}
endscript

script intro_celeb_ui_bounce 
	<zoom_in_time> = 0.05
	<first_bounce_time> = 0.02
	<settle_in_time> = 0.01
	<id> :se_setprops scale = 3.0 pos = (<starting_pos> + (0.0, 200.0))
	<id> :se_setprops scale = 0.8 alpha = 1.0 pos = (<starting_pos>) motion = ease_in time = <zoom_in_time>
	<id> :se_waitprops
	<id> :se_setprops scale = 0.9 pos = (<starting_pos> + (0.0, 5.0)) moion = ease_out time = <first_bounce_time>
	<id> :se_waitprops
	<id> :se_setprops scale = 0.8 pos = (<starting_pos>) motion = ease_in time = <settle_in_time>
endscript

script kill_intro_celeb_ui 
	if scriptisrunning \{intro_celeb_ui}
		killspawnedscript \{name = intro_celeb_ui}
		if screenelementexists \{id = celeb_intro_ui_cont}
			destroyscreenelement \{id = celeb_intro_ui_cont}
		endif
	endif
endscript

script 0x1ab37dde 
endscript
