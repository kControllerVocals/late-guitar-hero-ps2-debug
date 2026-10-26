loading_screen_exists_flag = 0
loading_screen_stack = 0
loading_screen_type = 0

script set_loading_screen 
	if ($loading_screen_stack = 0)
		debug_ScriptAssert \{'Attempted to change loading screen type when the loading screen was inactive.'}
		return
	endif
	if GotParam \{sustain}
		return
	elseif GotParam \{freeze}
		<desired_type> = 1
	elseif GotParam \{mini}
		<desired_type> = 2
	elseif GotParam \{full}
		<desired_type> = 3
	else
		debug_ScriptAssert \{'Unknown loading screen type requested.'}
	endif
	if (<desired_type> > $loading_screen_type)
		change loading_screen_type = <desired_type>
		if loading_screen_exists
			_destroy_loading_screen
		endif
	endif
	if NOT loading_screen_exists
		_create_loading_screen
	endif
endscript

script push_loading_screen 
	InputHandlerForbid
	change loading_screen_stack = ($loading_screen_stack + 1)
	set_loading_screen <...>
endscript

script pop_loading_screen 
	if ($loading_screen_stack <= 0)
		debug_ScriptAssert \{'Called pop_loading_screen without a matching push.'}
		return
	endif
	spawnscriptnow \{_pop_loading_screen_wait}
endscript

script _pop_loading_screen_wait 
	SetScriptCannotPause
	OnExitRun \{InputHandlerPermit}
	WaitOneGameFrame
	if ($loading_screen_stack <= 0)
		debug_ScriptAssert \{'_pop_loading_screen_wait woke with nothing left to pop.'}
		return
	endif
	change loading_screen_stack = ($loading_screen_stack - 1)
	if ($loading_screen_stack = 0)
		if loading_screen_exists
			_destroy_loading_screen
		endif
	endif
endscript

script _create_loading_screen 
	if ScriptIsRunning \{guitar_startup}
		return
	endif
	if loading_screen_exists
		debug_ScriptAssert \{'Attempted to recreate loading screen.'}
		return
	endif
	if ScriptIsRunning \{_destroy_loading_screen_wait}
		KillSpawnedScript \{name = _destroy_loading_screen_wait}
	else
		StopRendering_C
	endif
	InputHandlerForbid
	change \{loading_screen_exists_flag = 1}
	disable_pause
	mark_unsafe_for_shutdown
	if IsPAL
		image_x = [[215.0]]
		image_w = [[40]]
	else
		image_x = [[221.0]]
		image_w = [[28]]
	endif
	switch ($loading_screen_type)
		case 1
		DisplayLoadingScreen \{freeze}
		case 2
		DisplayLoadingScreen {
			freeze
			animate
			num_anim_frames = 8
			anim_paths = ['LoadingScreens/loading_star']
			x = [[5.0]]
			y = [[209.0]]
			w = <image_w>
			h = [[40.0]]
		}
		case 3
		DisplayLoadingScreen {
			'loading_splash'
			indexed_color
			animate
			localized
			num_anim_frames = 8
			anim_paths = ['LoadingScreens/loading_star']
			x = <image_x>
			y = [[209.0]]
			w = <image_w>
			h = [[40.0]]
		}
		default
		debug_ScriptAssert \{'Unknown loading screen type requested.'}
	endswitch
endscript

script create_loading_screen 
endscript

script destroy_loading_screen 
endscript

script _destroy_loading_screen 
	if NOT loading_screen_exists
		debug_ScriptAssert \{'Attempted to destroy loading screen when it does not exist.'}
		return
	endif
	mark_safe_for_shutdown
	change \{is_changing_levels = 0}
	Hideloadingscreen
	change \{loading_screen_exists_flag = 0}
	spawnscriptnow \{_destroy_loading_screen_wait}
endscript

script _destroy_loading_screen_wait 
	SetScriptCannotPause
	OnExitRun \{InputHandlerPermit}
	WaitOneGameFrame
	StartRendering_C
	WaitOneGameFrame
	change \{loading_screen_type = 0}
endscript

script loading_screen_exists 
	if ($loading_screen_exists_flag = 1)
		return \{true}
	else
		return \{false}
	endif
endscript
should_disable_VV_hack_that_messes_up_loading_screen = 0

script wait_for_loading_screen 
	begin
	Wait <...>
	if NOT loading_screen_exists
		break
	endif
	repeat
endscript
