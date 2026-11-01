
script PlaySubtitledMovie 
	if NOT GotParam \{SubbedMovie}

		return
	endif
	if ScreenElementExists \{id = play_subtitled_movie_container}

		return
	endif
	if NOT (StructureContains Structure = SubbedMovie name = movie_params)

		return
	endif
	if NOT (StructureContains Structure = SubbedMovie name = events)

		return
	endif
	<container_params> = {}
	<helper_params> = {}
	<skip_helper_params> = {}
	<exit_param> = {}
	if (StructureContains Structure = SubbedMovie name = container_params)
		<container_params> = (<SubbedMovie>.container_params)
	endif
	if (StructureContains Structure = SubbedMovie name = helper_params)
		<helper_params> = (<SubbedMovie>.helper_params)
	endif
	if (StructureContains Structure = SubbedMovie name = skip_helper_params)
		<skip_helper_params> = (<SubbedMovie>.skip_helper_params)
	endif
	if (StructureContains Structure = SubbedMovie name = exit_script)
		<exit_params> = {exit_script = (<SubbedMovie>.exit_script)}
		if (StructureContains Structure = SubbedMovie name = exit_script_params)
			<exit_params> = {<exit_params> exit_script_params = (<SubbedMovie>.exit_script_params)}
		endif
	endif
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = play_subtitled_movie_main_container
		dims = (1280.0, 702.0)
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	if NOT (StructureContains Structure = SubbedMovie name = no_skip)
		SetScreenElementProps {
			id = play_subtitled_movie_main_container
			event_handlers = [
				{pad_back nullscript}
				{pad_choose KillSubtitledMovie params = {<exit_params>}}
			]
		}
		CreateScreenElement {
			rgba = [128 128 128 255]
			text = 'skip movie \\m0'
			just = [right center]
			pos = (1150.0, 620.0)
			alpha = 1.0
			scale = (0.8, 0.8)
			<skip_helper_params>
			type = TextElement
			parent = play_subtitled_movie_main_container
			id = play_subtitled_skip_helper
			font = text_a1
			z_priority = 1010
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
		}
	endif
	LaunchEvent \{type = focus
		target = play_subtitled_movie_main_container}
	CreateScreenElement {
		<container_params>
		type = ContainerElement
		parent = play_subtitled_movie_main_container
		id = play_subtitled_movie_container
	}

	CreateScreenElement {
		text = 'press \\m1 to continue'
		just = [center center]
		alpha = 0.0
		scale = (0.8, 0.8)
		<helper_params>
		type = TextElement
		parent = play_subtitled_movie_container
		id = play_subtitled_movie_helper
		font = text_a1
		z_priority = 1010
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
	}

	<default_create_element> = {}
	<default_fade_in_params> = {}
	<default_fade_out_params> = {}
	if (StructureContains Structure = SubbedMovie name = default_create_element)
		<default_create_element> = (<SubbedMovie>.default_create_element)
	endif
	if (StructureContains Structure = SubbedMovie name = default_fade_in_params)
		<default_fade_in_params> = (<SubbedMovie>.default_fade_in_params)
	endif
	if (StructureContains Structure = SubbedMovie name = default_fade_out_params)
		<default_fade_out_params> = (<SubbedMovie>.default_fade_out_params)
	endif
	PushSoundBussParams
	if (StructureContains Structure = SubbedMovie name = no_music)
		EnableUserMusic \{disable}
		SetSoundBussParams \{$No_Music_At_All_BussSet
			time = 0.3}
	endif

	RunScriptOnScreenElement id = play_subtitled_movie_container SubtitleMovie params = {
		movie_params = (<SubbedMovie>.movie_params)
		events = (<SubbedMovie>.events)
		default_create_element = <default_create_element>
		default_fade_in_params = <default_fade_in_params>
		default_fade_out_params = <default_fade_out_params>
		exit_params = <exit_params>
	}
endscript

script KillSubtitledMovie \{exit_script = nullscript
		exit_params = {
		}}
	spawnscriptnow <exit_script> params = <exit_params>
	if ScreenElementExists \{id = play_subtitled_movie_main_container}
		EnableUserMusic
		PopSoundBussParams
		DestroyScreenElement \{id = play_subtitled_movie_main_container}
		LaunchEvent \{broadcast
			type = subtitled_movie_killed}

	else

	endif
endscript

script SubtitleMovie_PressToContinue 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	LaunchEvent \{broadcast
		type = movie_text_press_to_continue}
endscript

script SubtitleMovie 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}

	KillAllMovies \{blocking}
	<movie> = (<movie_params>.movie)
	if (StructureContains Structure = movie_params name = movie_ps3)
		if IsPs3
			<movie> = (<movie_params>.movie_ps3)
			if (StructureContains Structure = movie_params name = movie_ps3x)
				GetEnterButtonAssignment
				if (<assignment> = circle)
					<movie> = (<movie_params>.movie_ps3x)
				endif
			endif
		endif
	endif
	CreateScreenElement {
		scale = (1280.0, 720.0)
		<movie_params>
		movie = <movie>
		type = MovieElement
		parent = play_subtitled_movie_container
		id = play_subtitled_movie
		TextureSlot = 0
		z_priority = 1000
		start_frame = (<movie_params>.start_frame)
		loop_start = (<movie_params>.start_frame)
		loop_end = (<movie_params>.end_frame)
	}
	RemoveParameter \{movie}
	RemoveParameter \{movie_params}
	Wait \{1
		gameframes}
	begin
	if (IsMoviePlaying TextureSlot = 0)

		break
	endif
	Wait \{1
		gameframes}
	repeat
	GetNextArrayElement <events>
	begin
	if NOT GotParam \{element}

		break
	endif
	if NOT IsMoviePlaying \{TextureSlot = 0}

		KillSubtitledMovie <exit_params>
		return
	endif
	GetMovieFrame \{TextureSlot = 0}

	if (<frame> >= (<element>.frame))

		if (StructureContains Structure = element name = destroy_element)
			if GotParam \{curr_element}
				<fade_out_params> = {}
				if (StructureContains Structure = element name = fade_out_params)
					<fade_out_params> = (<element>.fade_out_params)
				endif
				RunScriptOnScreenElement id = <curr_element> DestroySubtitledMovieElement params = {
					default_fade_out_params = <default_fade_out_params>
					fade_out_params = <fade_out_params>
				}
				RemoveParameter \{curr_element}
			endif
		endif
		if (StructureContains Structure = element name = create_element)
			if GotParam \{curr_element}
				RunScriptOnScreenElement id = <curr_element> DestroySubtitledMovieElement
			endif
			<create_element> = (<element>.create_element)
			if (StructureContains Structure = element name = create_element_ps3)
				if IsPs3
					<create_element> = (<element>.create_element_ps3)
				endif
			endif
			CreateScreenElement {
				<default_create_element>
				<create_element>
				parent = play_subtitled_movie_container
				z_priority = 1005
			}
			RemoveParameter \{create_element}

			<curr_element> = <id>
			if (StructureContains Structure = element name = fade_in_params)
				doScreenElementMorph {
					<default_fade_in_params>
					(<element>.fade_in_params)
					id = <curr_element>
				}
			endif
		endif
		if (StructureContains Structure = element name = event_script)
			event_script_params = {}
			if (StructureContains Structure = element name = event_script_params)
				event_script_params = (<element>.event_script_params)
			endif
			RunScriptOnScreenElement id = play_subtitled_movie_container (<element>.event_script) params = <event_script_params>
		endif
		if (StructureContains Structure = element name = wait_for_input)
			PauseMovie \{TextureSlot = 0}

			doScreenElementMorph \{id = play_subtitled_movie_helper
				alpha = 1.0
				time = 0.5}
			SetScreenElementProps \{id = play_subtitled_movie_main_container
				event_handlers = [
					{
						pad_back
						SubtitleMovie_PressToContinue
					}
				]
				replace_handlers}
			Block \{type = movie_text_press_to_continue}

			doScreenElementMorph \{id = play_subtitled_movie_helper
				alpha = 0.0
				time = 0.5}
			SetScreenElementProps \{id = play_subtitled_movie_main_container
				event_handlers = [
					{
						pad_back
						nullscript
					}
				]
				replace_handlers}
			ResumeMovie \{TextureSlot = 0}

		endif
		if (StructureContains Structure = element name = wait_time)
			PauseMovie \{TextureSlot = 0}

			Wait (<element>.wait_time) seconds ignoreslomo

			ResumeMovie \{TextureSlot = 0}

		endif
		RemoveParameter \{element}
		GetNextArrayElement <events>
	endif
	Wait \{1
		gameframe}
	repeat
	WaitForMovieLoop \{TextureSlot = 0}

	PauseMovie \{TextureSlot = 0}

	KillSubtitledMovie <exit_params>
endscript

script DestroySubtitledMovieElement \{fade_out_params = {
		}}
	DoMorph {
		<default_fade_out_params>
		<fade_out_params>
	}
	Die

endscript
