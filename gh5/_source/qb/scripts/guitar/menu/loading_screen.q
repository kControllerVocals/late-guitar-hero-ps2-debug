0x0d66a1df = 0
0xe7982f25 = 0
loading_screen_type = 0

script 0xe9384b7a 
	if ($0xe7982f25 = 0)
		0x93d8d5cf \{'Attempted to change loading screen type when the loading screen was inactive.'}
		return
	endif
	if gotparam \{sustain}
		return
	elseif gotparam \{freeze}
		<0xd0043535> = 1
	elseif gotparam \{0x9fe16047}
		<0xd0043535> = 2
	elseif gotparam \{full}
		<0xd0043535> = 3
	else
		0x93d8d5cf \{'Unknown loading screen type requested.'}
	endif
	if (<0xd0043535> > $loading_screen_type)
		change loading_screen_type = <0xd0043535>
		if 0x8658e568
			0x5bb8b848
		endif
	endif
	if NOT 0x8658e568
		0x22db5e43
	endif
endscript

script 0xd3f993c8 
	0x79db87d7
	change 0xe7982f25 = ($0xe7982f25 + 1)
	0xe9384b7a <...>
endscript

script 0xe5a305c6 
	if ($0xe7982f25 <= 0)
		0x93d8d5cf \{'Called pop_loading_screen without a matching push.'}
		return
	endif
	spawnscriptnow \{0x24966d1f}
endscript

script 0x24966d1f 
	setscriptcannotpause
	onexitrun \{0xf00f29a9}
	waitonegameframe
	if ($0xe7982f25 <= 0)
		0x93d8d5cf \{'_pop_loading_screen_wait woke with nothing left to pop.'}
		return
	endif
	change 0xe7982f25 = ($0xe7982f25 - 1)
	if ($0xe7982f25 = 0)
		if 0x8658e568
			0x5bb8b848
		endif
	endif
endscript

script 0x22db5e43 
	if scriptisrunning \{guitar_startup}
		return
	endif
	if 0x8658e568
		0x93d8d5cf \{'Attempted to recreate loading screen.'}
		return
	endif
	if scriptisrunning \{0xc4ae5a29}
		killspawnedscript \{name = 0xc4ae5a29}
	else
		stoprendering_c
	endif
	0x79db87d7
	change \{0x0d66a1df = 1}
	disable_pause
	mark_unsafe_for_shutdown
	switch ($loading_screen_type)
		case 1
		displayloadingscreen \{freeze}
		case 2
		displayloadingscreen \{freeze
			animate
			0x91f64d92 = 8
			0x2374ff6a = [
				'LoadingScreens/loading_star'
			]
			x = [
				[
					10.0
				]
			]
			y = [
				[
					10.0
				]
			]
			w = [
				[
					64.0
				]
			]
			h = [
				[
					64.0
				]
			]}
		case 3
		if NOT ispal
			displayloadingscreen \{'loading_splash'
				0x9e685e61
				animate
				localized
				0x91f64d92 = 8
				0x2374ff6a = [
					'LoadingScreens/loading_star'
				]
				x = [
					[
						167.0
					]
				]
				y = [
					[
						87.0
					]
				]
				w = [
					[
						28.0
					]
				]
				h = [
					[
						40.0
					]
				]}
		else
			displayloadingscreen \{'loading_splash'
				0x9e685e61
				animate
				localized
				0x91f64d92 = 8
				0x2374ff6a = [
					'LoadingScreens/loading_star'
				]
				x = [
					[
						162.0
					]
				]
				y = [
					[
						87.0
					]
				]
				w = [
					[
						40.0
					]
				]
				h = [
					[
						40.0
					]
				]}
		endif
		default
		0x93d8d5cf \{'Unknown loading screen type requested.'}
	endswitch
endscript

script 0x5bb8b848 
	if NOT 0x8658e568
		0x93d8d5cf \{'Attempted to destroy loading screen when it does not exist.'}
		return
	endif
	mark_safe_for_shutdown
	change \{is_changing_levels = 0}
	hideloadingscreen
	change \{0x0d66a1df = 0}
	spawnscriptnow \{0xc4ae5a29}
endscript

script 0xc4ae5a29 
	setscriptcannotpause
	onexitrun \{0xf00f29a9}
	waitonegameframe
	startrendering_c
	waitonegameframe
	change \{loading_screen_type = 0}
endscript

script 0x8658e568 
	if ($0x0d66a1df = 1)
		return \{true}
	else
		return \{false}
	endif
endscript
0xa45fc02e = 0

script 0x3781e6f3 
	begin
	wait <...>
	if NOT 0x8658e568
		break
	endif
	repeat
endscript
