
script ui_create_boot_legal 
	spawnscriptnow \{ui_boot_legal_wait}
endscript

script ui_destroy_boot_legal 
	fadetoblack \{on
		alpha = 1.0
		time = 0.0
		z_priority = 100
		no_wait}
	Hideloadingscreen
endscript

script ui_boot_legal_wait 
	ui_event_wait \{event = menu_replace
		data = {
			state = UIstate_boot_movie_atvi
		}}
endscript

script ui_create_boot_movie_ATVI 
	spawnscriptnow \{ui_boot_movie_wait
		params = {
			movie = 'atvi'
			state = UIstate_boot_movie_red_octane
		}}
endscript

script ui_create_boot_movie_red_octane 
	spawnscriptnow \{ui_boot_movie_wait
		params = {
			movie = 'ro_logo'
			state = UIstate_boot_movie_neversoft
		}}
endscript

script ui_create_boot_movie_neversoft 
	spawnscriptnow \{ui_boot_movie_wait
		params = {
			movie = 'ns_logo'
			state = UIstate_boot_movie_intro
		}}
endscript

script ui_create_boot_movie_intro 
	spawnscriptnow \{ui_boot_movie_wait
		params = {
			movie = 'GHM_Movie_Intro'
			state = UIstate_boot_iis
		}}
endscript
SkipMovies = 0

script ui_boot_movie_wait 
	PushVideoVenues
	PlayMovieAndWait \{movie = 'intro_finalanimatic_0209'
		noblack}
	PopVideoVenues
	ui_event_wait \{event = menu_replace
		data = {
			state = UIstate_boot_iis
		}}
endscript
