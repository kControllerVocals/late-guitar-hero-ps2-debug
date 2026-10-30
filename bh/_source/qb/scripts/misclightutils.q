
script safecreate 
	if isinnodearray <nodename>
		if NOT iscreated <nodename>
			create name = <nodename>
		endif
	endif
endscript

script safekill 
	if iscreated <nodename>
		kill name = <nodename>
	endif
endscript

script screenflash \{time = 1}
	killspawnedscript \{id = screenflash}
	spawnscriptlater screenflashon id = screenflash params = {time = <time>}
endscript

script screenflashon 
	if NOT screenfx_fxinstanceexists \{viewport = bg_viewport
			name = flashbs}
		screenfx_addfxinstance {
			viewport = bg_viewport
			name = flashbs
			($screenflash_tod_manager.screen_fx [0])
		}
	else
		screenfx_updatefxinstanceparams {
			viewport = bg_viewport
			name = flashbs
			($screenflash_tod_manager.screen_fx [0])
		}
	endif
	wait (0.1 * <time>) seconds
	if screenfx_fxinstanceexists \{viewport = bg_viewport
			name = flashbs}
		screenfx_updatefxinstanceparams {
			viewport = bg_viewport
			name = flashbs
			time = <time>
			($screenflash_tod_manager.screen_fx [0])
			contrast = 1
			brightness = 1.5
		}
	endif
	wait <time> seconds
	spawnscriptlater \{screenflashoff
		id = screenflash}
endscript

script screenflashoff 
	if viewportexists \{id = bg_viewport}
		if screenfx_fxinstanceexists \{viewport = bg_viewport
				name = flashbs}
			screenfx_removefxinstance \{viewport = bg_viewport
				name = flashbs}
		endif
	endif
endscript
