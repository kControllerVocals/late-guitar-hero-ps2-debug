
script create_movie_viewport 
endscript

script destroy_movie_viewport 
endscript

script PauseFullScreenMovie 
	if IsMoviePlaying \{TextureSlot = 0}
		PauseMovie \{TextureSlot = 0}
	endif
endscript

script UnPauseFullScreenMovie 
	if IsMoviePlaying \{TextureSlot = 0}
		ResumeMovie \{TextureSlot = 0}
	endif
endscript
g_skip_remaining_movies = 0

script PlayMovieAndWait \{need_loading_screen = false}
	if Is_ui_event_running
		debug_Printf \{'Warning: Directly calling PlayMovieAndWait while a UI event is occurring.'}
	elseif loading_screen_exists
		debug_Printf \{'Warning: Calling PlayMovieAndWait while a loading screen is up.'}
	endif
	change \{g_skip_remaining_movies = 0}
	ScreenFX_ClearFXInstances \{viewport = bg_viewport}
	if NotCD
		if ($show_movies = 0)
			return
		endif
	endif
	mark_unsafe_for_shutdown

	RenderVideoOnly \{Only = 1}
	PushVideoVenues
	LoadVenueVideo \{pn = movies}
	fadetoblack \{off
		time = 0}
	FormatText checksumname = moviechecksum '%m' m = <movie>
	PlayVideo video = <moviechecksum>
	Wait \{2
		gameframes}
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = movie_handler
		event_handlers = [
			{pad_start EndMovie params = {skip_remaining_movies need_loading_screen = <need_loading_screen>}}
			{pad_choose EndMovie params = {need_loading_screen = <need_loading_screen>}}
		]
	}
	if GotParam \{focus}
		ui_event_block \{event = menu_unfocus}
	endif
	LaunchEvent \{type = focus
		target = movie_handler}
	begin
	if NOT IsVideoPlaying
		break
	endif
	WaitOneGameFrame
	repeat
	push_loading_screen \{freeze}
	OnExitRun \{pop_loading_screen}
	spawnscriptnow EndMovie params = {need_loading_screen = <need_loading_screen>}
	begin
	if NOT ScreenElementExists \{id = movie_handler}
		break
	endif
	WaitOneGameFrame
	repeat
	PopVideoVenues
	RenderVideoOnly \{Only = 0}
	WaitOneGameFrame
	fadetoblack \{off
		time = 0}
	mark_safe_for_shutdown
	if GotParam \{focus}
		ui_event_block \{event = menu_focus}
	endif
endscript

script EndMovie \{need_loading_screen = false}
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	fadetoblack \{on
		time = 0
		alpha = 1.0
		z_priority = -100}
	if GotParam \{skip_remaining_movies}
		change \{g_skip_remaining_movies = 1}
	endif
	if IsVideoPlaying
		StopVideo
	endif
	if ScreenElementExists \{id = movie_handler}
		LaunchEvent \{type = unfocus
			target = movie_handler}
		movie_handler :Die
		if (<need_loading_screen> = true)
			create_loading_screen
		endif
	endif
endscript
