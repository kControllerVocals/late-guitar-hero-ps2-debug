
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

script test_smoothRingMenu 
	<menu_id> = test_MARKW
	DestroyScreenElement \{id = current_menu}
	DestroyScreenElement \{id = test_MARKW_Window}
	CreateSmoothLoopingMenu {
		id = test_MARKW_Window
		parent = root_window
		menu_id = <menu_id>
		dims = (800.0, 150.0)
		pos = (150.0, 450.0)
		type = HMenu
		morph_time = 0.5
	}
	<i> = 1
	begin
	CreateScreenElement {
		type = ContainerElement
		parent = <menu_id>
		dims = (175.0, 45.0)
		just = [center center]
		internal_just = [center center]
		pos_anchor = [center center]
		event_handlers = [
			{focus test_smoothFocus params = {focus = 1}}
			{unfocus test_smoothFocus params = {focus = 0}}
		]
	}
	FormatText TextName = itemName qs("\LITEM %i") i = <i>
	CreateScreenElement {
		local_id = text
		type = TextBlockElement
		parent = <id>
		pos = (0.0, 0.0)
		dims = (200.0, 50.0)
		font = fontgrid_text_a1
		rgba = [192 192 192 255]
		internal_scale = 0.5
		text = <itemName>
		just = [center center]
		internal_just = [center center]
		pos_anchor = [center center]
	}
	<i> = (<i> + 1)
	repeat 5
	LaunchEvent type = focus target = <menu_id>
endscript

script test_smoothFocus 
	Obj_GetID
	ResolveScreenElementId id = {<ObjID> child = text}
	if (<focus> = 1)
		<resolved_id> :SE_SetProps rgba = [192 255 255 255] relative_scale scale = 1.5 time = 0.2
	else
		Wait \{0.1
			second}
		<resolved_id> :SE_SetProps rgba = [192 192 192 255] relative_scale scale = 1.0 time = 0.2
	endif
endscript
