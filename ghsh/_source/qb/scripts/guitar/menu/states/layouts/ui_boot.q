
script ui_create_boot_legal 
	spawnscriptnow \{ui_boot_legal_wait}
endscript

script ui_destroy_boot_legal 
	fadetoblack \{on
		alpha = 1.0
		time = 0.0
		z_priority = 100
		no_wait}
	hideloadingscreen
endscript

script ui_boot_legal_wait 
	if not cd
		wait \{6.0
			seconds
			ignoreslomo}
	endif
	ui_event_wait \{event = menu_replace
		data = {
			state = uistate_boot_movie_atvi
		}}
endscript

script ui_create_boot_movie_atvi 
	enableusermusic \{disable}
	spawnscriptnow \{ui_boot_movie_wait
		params = {
			movie = 'atvi'
			state = uistate_boot_movie_red_octane
		}}
endscript

script ui_create_boot_movie_red_octane 
	spawnscriptnow \{ui_boot_movie_wait
		params = {
			movie = 'ro_logo'
			state = uistate_boot_movie_beenox
		}}
endscript

script ui_create_boot_movie_neversoft 
	spawnscriptnow \{ui_boot_movie_wait
		params = {
			movie = 'ns_logo'
			state = uistate_boot_iis
		}}
endscript

script ui_create_boot_movie_beenox 
	spawnscriptnow \{ui_boot_movie_wait
		params = {
			movie = 'bx_logo'
			state = uistate_boot_movie_neversoft
		}}
endscript

script ui_create_boot_movie_intro 
	spawnscriptnow \{ui_boot_movie_wait
		params = {
			movie = 'band_intro'
			state = uistate_boot_iis
		}}
endscript
0x8b2d9143 = 0

script ui_destroy_boot_movie_intro 
	enableusermusic
endscript

script ui_boot_movie_wait 
	0x622f875f
	createscreenelement \{type = spriteelement
		id = black_overlay
		parent = root_window
		texture = black
		rgba = [
			0
			0
			0
			255
		]
		pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [
			center
			center
		]
		z_priority = 150
		alpha = 1}
	playmovieandwait \{movie = 'atvi'
		noblack}
	playmovieandwait \{movie = 'ro_logo'
		noblack}
	playmovieandwait \{movie = 'bx_logo'
		noblack}
	playmovieandwait \{movie = 'budcat'
		noblack}
	playmovieandwait \{movie = 'ns_logo'
		noblack}
	popvideovenues
	ui_event_wait \{event = menu_replace
		data = {
			state = uistate_boot_iis
		}}
endscript
