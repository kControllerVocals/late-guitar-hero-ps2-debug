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
	wait_for_safe_intro
	if ($g_playing_intro)

		return
	endif
	change \{g_playing_intro = 1}
	player = 1
	begin
	<player_status> = ($player_status_array [<player>])
	EnableInput off controller = ($<player_status>.controller)
	player = (<player> + 1)
	repeat $current_num_players
	KillSpawnedScript \{name = Loading_Screen_Crowd_Swell}
	KillSpawnedScript \{name = Crowd_Loading_Whistle}

	start_drummer_cameras
	GameMode_GetNumPlayersShown
	if ($is_attract_mode = 1)
		disable_bg_viewport
		return
	endif
	KillSpawnedScript \{name = GuitarEvent_SongFailed_Spawned}
	if GotParam \{Fast}
		change \{current_intro = $fastintro_sequence_props}
	elseif GotParam \{practice}
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
	if NOT ($Cheat_PerformanceMode = 1 && $is_network_game = 0)
		spawnscriptnow \{intro_highway_move
			id = intro_scripts}
	endif
	if (<num_players_shown> > 0)
		player = 1
		begin
		<player_status> = ($player_status_array [<player>])
		<player_text> = ($player_text_array [<player>])
		spawnscriptnow intro_buttonup_ripple params = <...> id = intro_scripts
		player = (<player> + 1)
		repeat <num_players_shown>
	endif
	if (($tutorial_disable_hud = 0) && ($end_credits = 0))
		spawnscriptnow \{intro_hud_move
			id = intro_scripts}
	endif
	BandManager_SetPlayingIntroAnims
endscript

script destroy_intro 
	KillSpawnedScript \{id = intro_scripts}
	KillSpawnedScript \{name = Song_Intro_Kick_SFX_Waiting}
	KillSpawnedScript \{name = Song_Intro_Highway_Up_SFX_Waiting}
	KillSpawnedScript \{name = intro_buttonup_ripple}
	KillSpawnedScript \{name = intro_hud_move}
	DestroyScreenElement \{id = intro_container}
	<num_players> = $current_num_players
	if (<num_players> > 0)
		player = 1
		begin
		<player_status> = ($player_status_array [<player>])
		EnableInput controller = ($<player_status>.controller)
		player = (<player> + 1)
		repeat <num_players>
	endif
	change \{g_playing_intro = 0}
endscript

script intro_buttonup_ripple 
	EnableInput off controller = ($<player_status>.controller)
	begin
	GetSongTimeMs
	if ($current_intro.button_ripple_start_time + $current_starttime < <time>)
		break
	endif
	WaitOneGameFrame
	repeat
	if ($current_intro.button_ripple_per_button_time = 0)
		EnableInput controller = ($<player_status>.controller)
		return
	endif
	GetArraySize \{$gem_colors}
	all_vocals = 1
	<num_players> = $current_num_players
	if (<num_players> > 0)
		player = 1
		begin
		<current_player_status> = ($player_status_array [<player>])
		if NOT ($<current_player_status>.part = Vocals)
			all_vocals = 0
			break
		endif
		player = (<player> + 1)
		repeat <num_players>
	endif
	if (<all_vocals> = 0)
		SoundEvent \{event = Notes_Ripple_Up_SFX}
	endif
	ExtendCRC button_up_pixel_array ($<player_status>.text) out = pixel_array
	buttonup_count = 0
	begin
	Wait ($current_intro.button_ripple_per_button_time / 1000.0) seconds
	array_count = 0
	begin
	color = ($gem_colors [<array_count>])
	if (<array_count> = <buttonup_count>)
		SetArrayElement ArrayName = <pixel_array> GlobalArray index = <array_count> newvalue = $button_up_pixels
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
	buttonup_count = (<buttonup_count> + 1)
	repeat (<array_size> + 1)
	EnableInput controller = ($<player_status>.controller)
endscript

script intro_song_info 
	begin
	GetSongTimeMs
	if ($current_intro.song_title_start_time + $current_starttime < <time>)
		break
	endif
	WaitOneGameFrame
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
	if ScreenElementExists \{id = intro_container}
		DestroyScreenElement \{id = intro_container}
	endif
	<current_song> = $current_song
	get_song_title song = <current_song>
	get_song_artist_text song = <current_song>
	get_song_artist song = <current_song>
	if (<current_song> = jamsession)
		year = 2008
		if ui_event_exists_in_stack \{name = 'setlist'}
			current_song_jam_index = ($temp_jamsession_song_list [($quickplay_song_list_current)])
			GetArraySize ($jam_curr_directory_listing) param = directory_size
			if (<current_song_jam_index> > 0 && <current_song_jam_index> < <directory_size>)
				<year> = ($jam_curr_directory_listing [<current_song_jam_index>].year)
			endif
		elseif ui_event_exists_in_stack \{name = 'jam'}
			jam_struct = ($jamsession_songlist_props.jamsession)
			year = (<jam_struct>.year_num)
		endif
		if NOT GotParam \{song_artist}
			get_savegame_from_controller controller = ($primary_controller)
			get_current_band_info
			GetGlobalTags savegame = <savegame> <band_info>
			song_artist = qs(0xbf9c7a91)
			if GotParam \{name}
				if (<name> != qs("\L"))
					song_artist = <name>
				endif
			endif
			FormatText TextName = year_text qs("\L, %d") d = <year>
			song_artist = (<song_artist> + <year_text>)
		endif
	endif
	CreateScreenElement {
		parent = root_window
		id = intro_container
		type = DescInterface
		desc = 'song_intro'
		alpha = 0
		z_priority = 500
		intro_artist_text = <song_artist>
		intro_title_text = <song_title>
		intro_performed_text = <song_artist_text>
	}
	fade_time = ($current_intro.song_title_fade_time / 1000.0)
	intro_container :SE_SetProps alpha = 1 time = <fade_time>
	intro_container :SE_WaitProps
	Wait ($current_intro.song_title_on_time / 1000.0) seconds
	intro_container :SE_SetProps alpha = 0 time = <fade_time>
	intro_container :SE_WaitProps
	DestroyScreenElement \{id = intro_container}
	enable_pause
endscript

script intro_highway_move 
	KillSpawnedScript \{name = OneShotsBetweenSongs}
	KillSpawnedScript \{name = SurgeBetweenSongs}
	begin
	GetSongTimeMs
	if ($current_intro.highway_start_time + $current_starttime < <time>)
		break
	endif
	WaitOneGameFrame
	repeat
	all_vocals = 1
	<num_players> = $current_num_players
	if (<num_players> > 0)
		player = 1
		begin
		<player_status> = ($player_status_array [<player>])
		if NOT ($<player_status>.part = Vocals)
			all_vocals = 0
			break
		endif
		player = (<player> + 1)
		repeat <num_players>
	endif
	if (<all_vocals> = 0)
		spawnscriptnow \{Song_Intro_Highway_Up_SFX_Waiting}
	else
		spawnscriptnow \{Song_Intro_Highway_Up_Vocals_SFX_Waiting}
	endif
	GameMode_GetNumPlayersShown
	if (<num_players_shown> > 0)
		player = 1
		begin
		<player_status> = ($player_status_array [<player>])
		<player_text> = ($player_text_array [<player>])
		vocals_highway_slide_in player = <player>
		move_highway_camera_to_default <...> time = ($current_intro.highway_move_time / 1000.0)
		player = (<player> + 1)
		repeat <num_players_shown>
	endif
endscript

script intro_hud_move 
	begin
	GetSongTimeMs
	if ($current_intro.hud_start_time + $current_starttime < <time>)
		break
	endif
	WaitOneGameFrame
	repeat
	GameMode_GetNumPlayersShown
	if (<num_players_shown> > 0)
		player = 1
		begin
		<player_status> = ($player_status_array [<player>])
		<player_text> = ($player_text_array [<player>])
		move_hud_to_default time = ($current_intro.hud_move_time / 1000.0)
		player = (<player> + 1)
		repeat <num_players_shown>
	endif
	all_vocals = 1
	<num_players> = $current_num_players
	if (<num_players> > 0)
		player = 1
		begin
		<player_status> = ($player_status_array [<player>])
		if NOT ($<player_status>.part = Vocals)
			all_vocals = 0
			break
		endif
		player = (<player> + 1)
		repeat <num_players>
	endif
	spawnscriptnow \{Song_Intro_Kick_SFX_Waiting}
endscript

script intro_check_for_celeb_intro_ui 
	debug_ScriptAssert \{'celebrity intros should be done from zone transition'}
	return
	Transition_GetPrefix type = ($current_playing_transition)
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
	Wait <start_delay> seconds
	if ScreenElementExists \{id = celeb_intro_ui_cont}
		debug_ScriptAssert \{'a celebrity intro ui is already up!'}
	endif
	CreateScreenElement \{type = ContainerElement
		id = celeb_intro_ui_cont
		parent = root_window
		pos = (0.0, 0.0)
		z_priority = 100}
	SetSearchAllAssetContexts
	CreateScreenElement \{parent = celeb_intro_ui_cont
		id = celeb_intro_ui
		type = DescInterface
		desc = 'celeb_intro'}
	celeb_intro_ui :SE_SetProps {
		firstname_text = <firstname>
	}
	SetSearchAllAssetContexts \{off}
	celeb_intro_ui :Desc_ResolveAlias \{name = alias_frame_anim}
	AssignAlias id = <resolved_id> alias = frame_anim
	frame_anim :SE_GetProps \{pos}
	<frame_anim_pos> = <pos>
	celeb_intro_ui :Desc_ResolveAlias \{name = alias_frame_container}
	AssignAlias id = <resolved_id> alias = frame_container
	frame_container :SE_SetProps \{alpha = 1}
	frame_container :SE_GetProps \{pos}
	<frame_container> = <pos>
	frame_anim :SE_WaitProps
	frame_anim :SE_WaitProps
	<time_between_bounces> = 0.01
	Wait (<duration> - <time_between_bounces>) seconds
	frame_anim :SE_WaitProps
	frame_anim :SE_WaitProps
	frame_anim :SE_WaitProps
	frame_anim :SE_WaitProps
	frame_anim :SE_SetProps \{alpha = 0
		time = 0.1}
	frame_anim :SE_WaitProps
	DestroyScreenElement \{id = celeb_intro_ui_cont}
endscript

script intro_celeb_ui_bounce 
	<zoom_in_time> = 0.05
	<first_bounce_time> = 0.02
	<settle_in_time> = 0.01
	<id> :SE_SetProps scale = 3.0 pos = (<starting_pos> + (0.0, 200.0))
	<id> :SE_SetProps scale = 0.8 alpha = 1.0 pos = (<starting_pos>) motion = ease_in time = <zoom_in_time>
	<id> :SE_WaitProps
	<id> :SE_SetProps scale = 0.9 pos = (<starting_pos> + (0.0, 5.0)) moion = ease_out time = <first_bounce_time>
	<id> :SE_WaitProps
	<id> :SE_SetProps scale = 0.8 pos = (<starting_pos>) motion = ease_in time = <settle_in_time>
endscript

script kill_intro_celeb_ui 
	if ScriptIsRunning \{intro_celeb_ui}
		KillSpawnedScript \{name = intro_celeb_ui}
		if ScreenElementExists \{id = celeb_intro_ui_cont}
			DestroyScreenElement \{id = celeb_intro_ui_cont}
		endif
	endif
endscript

script wait_for_safe_intro 
endscript
