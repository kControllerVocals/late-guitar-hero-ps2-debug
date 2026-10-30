
script create_movie_viewport 
endscript

script destroy_movie_viewport 
endscript

script pausefullscreenmovie 
	if ismovieplaying \{textureslot = 0}
		pausemovie \{textureslot = 0}
	endif
endscript

script unpausefullscreenmovie 
	if ismovieplaying \{textureslot = 0}
		resumemovie \{textureslot = 0}
	endif
endscript
g_skip_remaining_movies = 0

script playmovieandwait \{0x6d221ff1 = false}
	change \{g_skip_remaining_movies = 0}
	screenfx_clearfxinstances \{viewport = bg_viewport}
	if notcd
		if ($show_movies = 0)
			return
		endif
	endif
	mark_unsafe_for_shutdown

	0x33d46327 \{only = 1}
	0x622f875f
	loadvenuevideo \{pn = 0x39e112cf}
	if gotparam \{destroy_loading_screen}
		destroy_loading_screen
	endif
	fadetoblack \{off
		time = 0}
	formattext checksumname = 0x754e8336 '%m' m = <movie>
	0xd518ab19 video = <0x754e8336>
	wait \{2
		gameframes}
	createscreenelement {
		type = containerelement
		parent = root_window
		id = movie_handler
		event_handlers = [
			{pad_start endmovie params = {skip_remaining_movies 0x6d221ff1 = <0x6d221ff1>}}
			{pad_choose endmovie params = {0x6d221ff1 = <0x6d221ff1>}}
		]
	}
	launchevent \{type = focus
		target = movie_handler}
	begin
	if NOT 0x62b954d8
		break
	endif
	waitonegameframe
	repeat
	spawnscriptnow endmovie params = {0x6d221ff1 = <0x6d221ff1>}
	begin
	if NOT screenelementexists \{id = movie_handler}
		break
	endif
	waitonegameframe
	repeat
	popvideovenues
	0x33d46327 \{only = 0}
	waitonegameframe
	fadetoblack \{off
		time = 0}
	mark_safe_for_shutdown
endscript

script endmovie \{0x6d221ff1 = false}
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	fadetoblack \{on
		time = 0
		alpha = 1.0
		z_priority = -100}
	if gotparam \{skip_remaining_movies}
		change \{g_skip_remaining_movies = 1}
	endif
	if 0x62b954d8
		0x34fb97d7
	endif
	if screenelementexists \{id = movie_handler}
		movie_handler :die
		if (<0x6d221ff1> = true)
			create_loading_screen
		endif
	endif
endscript
