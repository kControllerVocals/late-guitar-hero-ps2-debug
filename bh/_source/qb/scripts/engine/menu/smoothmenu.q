
script CreateSmoothLoopingMenu \{id = smooth_looping_menu_parent
		menu_id = smooth_looping_menu_id
		parent = root_window
		type = VMenu
		dims = (250.0, 200.0)
		pos = (0.0, 0.0)
		morph_time = 0.2}
	CreateScreenElement {
		type = WindowElement
		parent = <parent>
		id = <id>
		pos = <pos>
		dims = <dims>
		just = [left top]
		tags = {debug_me}
	}
	if (<type> = VMenu)
		event_handlers = [
			{pad_up SmoothMenuScroll params = {dir = -1 isVertical = true}}
			{pad_down SmoothMenuScroll params = {dir = 1 isVertical = true}}
		]
	else
		event_handlers = [
			{pad_left SmoothMenuScroll params = {dir = -1 isVertical = false}}
			{pad_right SmoothMenuScroll params = {dir = 1 isVertical = false}}
		]
	endif
	CreateScreenElement {
		type = <type>
		parent = <id>
		id = <menu_id>
		pos = (0.0, 0.0)
		pos_anchor = [center center]
		just = [center center]
		internal_just = [center center]
		loop_view = true
		loop_center = true
		dims = <dims>
		disable_pad_handling
		event_handlers = <event_handlers>
		tags = {smooth_morph_time = <morph_time>}
	}
endscript

script SmoothMenuScroll 
	GetSingleTag \{smooth_morph_time}
	SetSpawnedScriptNoRepeatFor time = (<smooth_morph_time> + 0.05)
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}

	Obj_GetID
	if CountScreenElementChildren id = <ObjID>
		LaunchEvent type = unfocus target = <ObjID>
		change \{generic_menu_block_input = 1}
		GetScreenElementDims id = <ObjID>
		if (<isVertical> = true)
			<shift> = ((<Height> / <num_children>) * (0.0, 1.0))
		else
			<shift> = ((<width> / <num_children>) * (1.0, 0.0))
		endif
		if (<dir> = -1)
			SE_SetProps pos = {<shift> relative} time = <smooth_morph_time>
			SE_WaitProps
			Menu_ChangeSelection \{up}
			SE_SetProps pos = {(<shift> * -1) relative} time = 0.0
			SE_WaitProps
		else
			SE_SetProps pos = {(<shift> * -1) relative} time = <smooth_morph_time>
			SE_WaitProps
			Menu_ChangeSelection \{down}
			SE_SetProps pos = {<shift> relative} time = 0.0
			SE_WaitProps
		endif
		Wait \{0.05
			seconds
			ignoreslomo}
		change \{generic_menu_block_input = 0}
		LaunchEvent type = focus target = <ObjID>
	endif
endscript
