career_intro_exists = 0
qi_focus_color = [
	0
	0
	0
	255
]
qi_unfocus_color = [
	255
	255
	255
	255
]
qi_enable_color = [
	255
	255
	255
	255
]
qi_disable_color = [
	150
	150
	150
	255
]
menu_in_select_character = [
	false
	false
	false
	false
]

script qi_initialize 
	push_loading_screen \{full}
	frontend_load_soundcheck
	qi_initialize_main_menu
	qi_initialize_characters
	qi_animate_all_highlights
	qi_initialize_object mode = <mode>
	KillSkaterCamAnim \{all}
	get_frontend_venue_player_start_checksums
	GetWaypointPos name = <Microphone_Start>
	PlayIGCCam {
		name = Bandmode_camera
		viewport = bg_viewport
		pos = (<pos> + (0.0, 1.0, 4.5))
		Quat = (0.0, 1.0, 0.0)
		FOV = 43.0
		Play_hold = 1
		interrupt_current
	}
	pop_loading_screen
	SpawnScriptLater \{qi_attach_event_handlers}
	return
endscript

script qi_attach_event_handlers 
	Wait \{1
		gameframe}
	qi_main_menu :SetProps \{replace_handlers
		event_handlers = [
			{
				pad_up
				QI_SendInputEvent
				params = {
					event_id = 1
				}
			}
			{
				pad_down
				QI_SendInputEvent
				params = {
					event_id = 2
				}
			}
			{
				pad_choose
				QI_SendInputEvent
				params = {
					event_id = 3
				}
			}
			{
				pad_back
				QI_SendInputEvent
				params = {
					event_id = 4
				}
			}
			{
				pad_option2
				QI_SendInputEvent
				params = {
					event_id = 5
				}
			}
			{
				pad_option
				QI_SendInputEvent
				params = {
					event_id = 6
				}
			}
			{
				pad_start
				QI_SendInputEvent
				params = {
					event_id = 8
				}
			}
		]}
endscript

script qi_destroy 
	qi_set_control_helper
	if GotParam \{kill_rocker}
		cas_destroy_all_characters
	endif
	if ScreenElementExists \{id = qi_main_menu}
		qi_main_menu :GetSingleTag \{menus}
		GetArraySize <menus>
		i = 0
		begin
		if NOT GotParam \{kill_rocker}
			qi_get_rocker_id menu_index = <i>
			if (<rocker_id> = none)
				cas_queue_kill_player player = (<i> + 1)
			else
				get_musician_profile_struct_by_id id = <rocker_id> savegame = 0
				cas_queue_add_request appearance = (<profile_struct>.appearance) player = (<i> + 1) instrument = guitar
			endif
		endif
		i = (<i> + 1)
		repeat <array_size>
		i = 0
		begin
		qi_create_menu menu_index = <i>
		i = (<i> + 1)
		repeat <array_size>
		qi_main_menu :Die
	endif
	generic_ui_destroy
endscript

script qi_initialize_characters 
	get_frontend_venue_player_start_checksums
	cas_set_object_node_pos player = 1 node = <player1_start>
	cas_set_object_node_pos player = 2 node = <player2_start>
	cas_set_object_node_pos player = 3 node = <player3_start>
	cas_set_object_node_pos player = 4 node = <player4_start>
	GameMode_GetType
	if (<type> = pro_faceoff)
		cas_set_object_node_pos player = 2 node = <player4_start>
	endif
endscript

script qi_initialize_main_menu 
	if NOT ScreenElementExists \{id = qi_main_menu}
		SetScreenElementProps \{id = root_window
			event_handlers = [
			]
			replace_handlers}
		CreateScreenElement \{id = qi_main_menu
			type = DescInterface
			parent = root_window
			desc = 'band_play'}
		LaunchEvent \{type = focus
			target = qi_main_menu}
		menu_array = []
		desc_array = []
		if NOT qi_main_menu :Desc_ResolveAlias \{name = alias_hmenu}
			debug_ScriptAssert \{'Unable to find the hmenu structure within the band_play ui descriptor'}
		endif
		band_hmenu = <resolved_id>
		i = 0
		begin
		ResolveScreenElementId id = [
			{id = <band_hmenu>}
			{index = <i>}
		]
		<resolved_id> :SE_SetProps reposition_pos = (0.0, 500.0)
		<resolved_id> :SE_WaitProps
		AddArrayElement array = <desc_array> element = <resolved_id>
		desc_array = <array>
		if NOT <resolved_id> :Desc_ResolveAlias name = alias_menu
			debug_ScriptAssert \{'Unable to find the alias_menu structure within the band_hmenu ui descriptor'}
		endif
		<resolved_id> :SetTags {
			menu = join
			current_rocker_id = none
		}
		AddArrayElement array = <menu_array> element = <resolved_id>
		menu_array = <array>
		i = (<i> + 1)
		repeat 4
		qi_get_valid_rocker_list \{part = guitar}
		GetArraySize \{valid_rocker_list}
		qi_main_menu :SetTags {
			menus = <menu_array>
			descs = <desc_array>
			headtohead = 0
			valid_rocker_list = <valid_rocker_list>
			valid_rocker_list_size = <array_size>
		}
	endif
	return
endscript

script qi_initialize_head_to_head 
	if NOT ScreenElementExists \{id = qi_main_menu}
		debug_ScriptAssert \{'qi must be initialized'}
	endif
	if NOT qi_main_menu :GetSingleTag \{headtohead}
		debug_ScriptAssert \{'cant find flag: headtohead.  is qi initialized?'}
	endif
	if (<headtohead> != 0)
		debug_ScriptAssert \{'is head to head already initialized?'}
	endif
	if NOT qi_main_menu :Desc_ResolveAlias \{name = alias_hmenu}
		debug_ScriptAssert \{'cant find description alias: alias_hmenu'}
	endif
	band_hmenu = <resolved_id>
	<band_hmenu> :SE_SetProps spacing_between = 400
	i = 3
	begin
	ResolveScreenElementId id = [
		{id = <band_hmenu>}
		{index = <i>}
	]
	<resolved_id> :Die
	i = (<i> - 1)
	repeat 2
	Wait \{2
		gameframes}
	menu_array = []
	desc_array = []
	i = 0
	begin
	ResolveScreenElementId id = [
		{id = <band_hmenu>}
		{index = <i>}
	]
	AddArrayElement array = <desc_array> element = <resolved_id>
	desc_array = <array>
	if NOT <resolved_id> :Desc_ResolveAlias name = alias_menu
		debug_ScriptAssert \{'Unable to find the alias_menu structure within the band_hmenu ui descriptor'}
	endif
	<resolved_id> :SetTags {
		menu = join
		current_rocker_id = none
	}
	AddArrayElement array = <menu_array> element = <resolved_id>
	menu_array = <array>
	i = (<i> + 1)
	repeat 2
	qi_main_menu :SetTags {
		menus = <menu_array>
		descs = <desc_array>
		headtohead = 1
	}
endscript

script qi_create_menu 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'qi_create_menu needs argument: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{menus}
	GetArraySize <menus>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_menu = (<menus> [<menu_index>])
	qi_focus_element menu_index = <menu_index>
	qi_scroll_arrows menu_index = <menu_index> hide_arrows
	if NOT GotParam \{preserve_ready}
		qi_destroy_ready_menu menu_index = <menu_index>
	endif
	<current_menu> :Obj_SpawnScriptNow qi_create_menu_elements params = {menu_definition = <menu_definition>}
	return
endscript

script qi_create_menu_elements 
	Obj_GetID
	DestroyScreenElement id = <ObjID> preserve_parent
	if GotParam \{menu_definition}
		if NOT StructureContains Structure = <menu_definition> name = menu_name
			return
			debug_ScriptAssert \{'menu_definition argument must contain: menu_name'}
		endif
		if NOT StructureContains Structure = <menu_definition> name = menu_elements
			return
			debug_ScriptAssert \{'menu_definition argument must contain an array of elements (menu_elements)'}
		endif
		menu_name = (<menu_definition>.menu_name)
		menu_elements = (<menu_definition>.menu_elements)
		GetArraySize <menu_elements>
		i = 0
		begin
		current_element = (<menu_elements> [<i>])
		if NOT StructureContains Structure = <current_element> name = text
			debug_ScriptAssert 'current_element (%i) must contain a text element' i = <i>
		endif
		element_text = (<current_element>.text)
		FormatText TextName = element_id '%n%i' n = <menu_name> i = <i>
		CreateScreenElement {
			id = <element_id>
			type = TextBlockElement
			fit_width = `scale each line if larger`
			fit_height = `scale down if larger`
			parent = <ObjID>
			text = <element_text>
			font = fontgrid_text_a8
			dims = (190.0, 30.0)
			rgba = $qi_unfocus_color
			internal_scale = 0.6
			just = [center bottom]
			internal_just = [center center]
			allow_expansion
		}
		i = (<i> + 1)
		repeat <array_size>
		<ObjID> :SetTags {menu_name = <menu_name>}
	endif
	return
endscript

script qi_animate_all_highlights 
	if NOT ScreenElementExists \{id = qi_main_menu}
		return
		debug_ScriptAssert \{'qi must be initialized'}
	endif
	qi_main_menu :GetSingleTag \{descs}
	index = 0
	begin
	current_desc = (<descs> [<index>])
	<current_desc> :obj_spawnscript highlight_motion params = {menu_id = <current_desc>}
	<current_desc> :obj_spawnscript qi_animate_single_ready_banner
	index = (<index> + 1)
	repeat 4
	return
endscript

script qi_animate_single_highlight 
	if NOT Desc_ResolveAlias \{name = alias_highlight}
		return
		debug_ScriptAssert \{'Cant find alias_highlight.'}
	endif
	if NOT GetScreenElementChildren id = <resolved_id>
		return
		debug_ScriptAssert \{'No children found?  Highlight needs children to animate.'}
	endif
	scale = (1.0, 1.0)
	screenelementpos = (0.0, 300.0)
	<resolved_id> :SE_SetProps pos = <screenelementpos> scale = <scale>
	<resolved_id> :SE_WaitProps
	<resolved_id> :SE_SetProps rgba = [0 0 0 255]
	<resolved_id> :SE_WaitProps
	GetArraySize <children>
	current_index = 0
	begin
	(<children> [(<current_index>)]) :SE_SetProps alpha = 0.0
	GetRandomValue name = random_number a = 0 b = (<array_size> - 2) Integer
	Mod a = (<current_index> + <random_number> + 1) b = <array_size>
	current_index = <Mod>
	current_highlight = (<children> [<Mod>])
	<current_highlight> :SE_SetProps alpha = 1.0
	Wait \{0.1
		second}
	repeat
endscript

script qi_animate_single_ready_banner 
	if NOT Desc_ResolveAlias \{name = alias_ready_banner}
		return
		debug_ScriptAssert \{'Cant find alias_ready_banner.'}
	endif
	if NOT GetScreenElementChildren id = <resolved_id>
		return
		debug_ScriptAssert \{'No children found?  Highlight needs children to animate.'}
	endif
	GetArraySize <children>
	current_index = 0
	begin
	(<children> [(<current_index>)]) :SE_SetProps alpha = 0.0
	GetRandomValue name = random_number a = 0 b = (<array_size> - 2) Integer
	Mod a = (<current_index> + <random_number> + 1) b = <array_size>
	current_index = <Mod>
	current_highlight = (<children> [<Mod>])
	<current_highlight> :SE_SetProps alpha = 1.0
	Wait \{0.1
		second}
	repeat
endscript

script qi_create_ready_menu 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize <descs>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_desc = (<descs> [<menu_index>])
	qi_create_menu menu_index = <menu_index>
	<current_desc> :Obj_KillSpawnedScript name = qi_animate_ready
	<current_desc> :Obj_KillSpawnedScript name = qi_animate_unready
	<current_desc> :Obj_SpawnScriptNow qi_animate_ready
endscript

script qi_destroy_ready_menu 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize <descs>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_desc = (<descs> [<menu_index>])
	<current_desc> :Obj_KillSpawnedScript name = qi_animate_ready
	<current_desc> :Obj_KillSpawnedScript name = qi_animate_unready
	<current_desc> :Obj_SpawnScriptNow qi_animate_unready
endscript

script qi_animate_ready 
	Obj_GetID
	<ObjID> :SE_SetProps ready_banner_pos = (0.0, -80.0) time = 0.1 motion = ease_out
	<ObjID> :SE_WaitProps
	Wait \{0.1
		second}
	<ObjID> :SE_SetProps ready_banner_scale = 1.2 time = 0.1 motion = ease_out
	<ObjID> :SE_WaitProps
	<ObjID> :SE_SetProps ready_banner_scale = 0.9 time = 0.1 motion = ease_in
	<ObjID> :SE_WaitProps
	<ObjID> :SE_SetProps ready_banner_scale = 1.1 time = 0.1 motion = ease_out
	<ObjID> :SE_WaitProps
	<ObjID> :SE_SetProps ready_banner_scale = 1.0 time = 0.1 motion = ease_in
endscript

script qi_animate_unready 
	Obj_GetID
	<ObjID> :SE_SetProps ready_banner_pos = (0.0, 500.0) time = 0.1 motion = ease_in
	<ObjID> :SE_WaitProps
endscript

script qi_show_card 
	debug_Printf 'showing card in menu: %i' i = <menu_index>
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize <descs>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_desc = (<descs> [<menu_index>])
	<current_desc> :Obj_KillSpawnedScript name = qi_animate_card
	<current_desc> :Obj_SpawnScriptNow qi_animate_card
endscript

script qi_hide_card 
	debug_Printf 'hiding card in menu: %i' i = <menu_index>
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize <descs>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_desc = (<descs> [<menu_index>])
	<current_desc> :Obj_KillSpawnedScript name = qi_animate_card
	<current_desc> :Obj_SpawnScriptNow qi_animate_card params = {hide}
endscript

script qi_animate_card 
	Obj_GetID
	if GotParam \{hide}
		debug_Printf \{'HIDING'}
		<ObjID> :SE_SetProps reposition_pos = (0.0, 500.0) time = 0.1 motion = ease_in
	else
		debug_Printf \{'SHOWING'}
		<ObjID> :SE_SetProps reposition_pos = (0.0, 0.0) time = 0.1 motion = ease_out
	endif
	<ObjID> :SE_WaitProps
endscript

script qi_set_join_text 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize <descs>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_desc = (<descs> [<menu_index>])
	if GotParam \{show}
		buttonchar = qs("\L\m0")
		switch <menu_index>
			case 0
			case 1
			buttonchar = qs("\L\b4")
			case 2
			case 3
			default
			buttonchar = qs("\L\b3")
		endswitch
		join_text = (<buttonchar> + qs(0x0b91bdc8))
		<current_desc> :SE_SetProps join_text = <join_text>
	else
		<current_desc> :SE_SetProps join_text = qs("\L")
	endif
endscript

script qi_menu_element 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'Cant find param: menu_index'}
	endif
	if NOT GotParam \{element_index}
		return
		debug_ScriptAssert \{'Cant find param: element_index'}
	endif
	qi_main_menu :GetSingleTag \{menus}
	GetArraySize <menus>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index (menus): %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_menu = (<menus> [<menu_index>])
	GetScreenElementChildren id = <current_menu>
	if NOT GotParam \{children}
		return
		debug_ScriptAssert 'Trying to manipulate child (%e) when no children exist!' e = <element_index>
	endif
	GetArraySize <children>
	if (<element_index> < 0 || <element_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <element_index> s = <array_size>
	endif
	current_element = (<children> [<element_index>])
	if GotParam \{disable}
		<current_element> :SetProps rgba = $qi_disable_color
	else
		<current_element> :SetProps rgba = $qi_enable_color
	endif
	return
endscript

script qi_animate_focus_element \{offset = (0.0, 23.0)
		start_pos = (0.0, -122.0)
		element_index = -1}
	Wait \{1
		gameframes}
	Obj_GetID
	if NOT GotParam \{ObjID}
		return
		debug_ScriptAssert \{'cant find the calling object?'}
	endif
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'Cant find param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{menus}
	GetArraySize <menus>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index (menus): %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_menu = (<menus> [<menu_index>])
	if (<element_index> = -1)
		<ObjID> :SE_SetProps pos = (0.0, 300.0)
	else
		GetScreenElementChildren id = <current_menu>
		if NOT GotParam \{children}
			return
			debug_ScriptAssert 'Trying to focus child (%e) when no children exist!' e = <element_index>
		endif
		GetArraySize <children>
		if (<element_index> < 0 || <element_index> >= <array_size>)
			return
			debug_ScriptAssert 'Illegal menu_index (elements): %i  array_size: %s' i = <element_index> s = <array_size>
		endif
		current_element = (<children> [<element_index>])
		GetScreenElementDims id = <current_element>
		scale = (((0.9, 0.0) * (((<width> + 100.0) / 256.0))) + (0.0, 1.0))
		screenelementpos = (<start_pos> + (<offset> * <element_index>))
		<ObjID> :SE_SetProps pos = <screenelementpos> scale = <scale>
		<ObjID> :SE_WaitProps
		<ObjID> :SE_SetProps pos = (<screenelementpos> + (0.0, -10.0)) time = 0.05
		<ObjID> :SE_WaitProps
		<ObjID> :SE_SetProps pos = <screenelementpos> scale = <scale> time = 0.05
		<ObjID> :SE_WaitProps
	endif
endscript

script qi_focus_element 
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize <descs>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index (descs): %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_desc = (<descs> [<menu_index>])
	<current_desc> :Desc_ResolveAlias name = alias_highlight
	<resolved_id> :Obj_KillSpawnedScript name = qi_animate_focus_element
	<resolved_id> :Obj_SpawnScriptNow qi_animate_focus_element params = {menu_index = <menu_index> element_index = <element_index>}
	return
endscript

script qi_band_leader 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize \{descs}
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	if GotParam \{hide}
		(<descs> [<menu_index>]) :SE_SetProps leader_indicator_alpha = 0.0
	else
		(<descs> [<menu_index>]) :SE_SetProps leader_indicator_alpha = 1.0
	endif
endscript

script qi_set_instrument \{instrument = -1}
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'Must have param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize \{descs}
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index (%i) for array_size (%s)' i = <menu_index> s = <array_size>
	endif
	switch <instrument>
		case 3
		instrument_checksum = logo_vocal
		case 2
		instrument_checksum = logo_drum
		case 1
		instrument_checksum = logo_bass
		case 0
		default
		instrument_checksum = logo_guitar
	endswitch
	if (<instrument> >= 0 && <instrument> < 4)
		instrument_alpha = 1.0
	else
		instrument_alpha = 0.0
	endif
	(<descs> [<menu_index>]) :SE_SetProps instrument_alpha = <instrument_alpha> instrument_texture = <instrument_checksum>
	return
endscript

script qi_set_character_name 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	if NOT GotParam \{qi_character_name}
		qi_character_name = qs("")
	endif
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize \{descs}
	if ((<menu_index> < 0) || (<menu_index> >= <array_size>))
		return
		debug_ScriptAssert 'illegal menu_index (%i) in array size (%s)' i = <menu_index> s = <array_size>
	endif
	if ((($menu_in_select_character) [<menu_index>]) = true)
		name_offset = (0.0, 70.0)
	else
		name_offset = (0.0, 20.0)
	endif
	current_desc = (<descs> [<menu_index>])
	<current_desc> :SE_GetProps
	if (<name_text> != <qi_character_name>)
		<current_desc> :Obj_KillSpawnedScript name = qi_character_name_scroll
		<current_desc> :SE_SetProps name_text = <qi_character_name> name_dims = (0.0, 40.0) nameMenu_dims = (0.0, 40.0)
		<current_desc> :SE_GetProps
		x = ((248 - (<name_dims> [0])) / 2)
		<current_desc> :SE_SetProps name_pos = (<name_offset> + ((1.0, 0.0) * <x>))
		if ((<name_dims> [0]) >= 248)
			<current_desc> :Obj_SpawnScriptNow qi_character_name_scroll
		endif
	endif
	return
endscript

script qi_character_name_scroll 
	Wait \{2
		gameframes}
	SE_GetProps
	width = ((<nameMenu_dims> [0]) + 100.0)
	pos = ((0.5, 0.0) * <width>)
	time = (2.0 * (<width> / 500.0))
	begin
	SE_SetProps name_pos = {(-1.0 * <pos>) relative} time = <time>
	Wait <time> seconds ignoreslomo
	SE_SetProps name_pos = {<pos> relative}
	repeat
endscript

script qi_set_gamertag 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	if NOT GotParam \{qi_gamertag}
		qi_gamertag = qs("")
	endif
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize \{descs}
	if ((<menu_index> < 0) || (<menu_index> >= <array_size>))
		return
		debug_ScriptAssert 'illegal menu_index (%i) in array size (%s)' i = <menu_index> s = <array_size>
	endif
	current_desc = (<descs> [<menu_index>])
	<current_desc> :SE_GetProps
	if (<gamertag_text> != <qi_gamertag>)
		<current_desc> :Obj_KillSpawnedScript name = qi_gamertag_scroll
		<current_desc> :SE_SetProps gamertag_text = <qi_gamertag> gamertag_dims = (0.0, 40.0) gamertagMenu_dims = (0.0, 40.0)
		<current_desc> :SE_GetProps
		x = ((248 - (<gamertag_dims> [0])) / 2)
		<current_desc> :SE_SetProps GamerTag_pos = ((0.0, -20.0) + ((1.0, 0.0) * <x>))
		if ((<gamertag_dims> [0]) >= 248)
			<current_desc> :Obj_SpawnScriptNow qi_gamertag_scroll
		endif
	endif
	return
endscript

script qi_gamertag_scroll 
	Wait \{2
		gameframes}
	SE_GetProps
	width = ((<gamertagMenu_dims> [0]) + 100)
	pos = ((0.5, 0.0) * <width>)
	time = (2.0 * (<width> / 500.0))
	begin
	SE_SetProps GamerTag_pos = {(-1.0 * <pos>) relative} time = <time>
	Wait <time> seconds ignoreslomo
	SE_SetProps GamerTag_pos = {<pos> relative}
	repeat
endscript

script qi_set_control_helper controller = ($primary_controller)
	if (<controller> < 0)
		RemoveParameter \{controller}
	endif
	clean_up_user_control_helpers
	if GotParam \{select}
		add_user_control_helper all_buttons text = qs("SELECT") button = green controller = <controller> z = 100000
	endif
	if GotParam \{back}
		add_user_control_helper all_buttons text = qs("BACK") button = red controller = <controller> z = 100000
	endif
	if GotParam \{band_leader}
		add_user_control_helper all_buttons text = qs("BAND LEADER") button = Blue controller = <controller> z = 100000
	endif
	if GotParam \{continue}
		add_user_control_helper all_buttons text = qs("CONTINUE") button = start controller = <controller> z = 100000
	endif
	return
endscript

script qi_ticker_display_message_helper \{delay = 2}
	if NOT GotParam \{message}
		return
		debug_ScriptAssert \{'Missing param: message'}
	endif
	ResolveScreenElementId \{id = [
			{
				id = qi_main_menu
			}
			{
				local_id = band_menu_container
			}
			{
				local_id = online_ticker_window_element
			}
			{
				local_id = online_ticker_vert_text
			}
		]}
	if NOT GotParam \{resolved_id}
		return
		debug_ScriptAssert \{'Cant find ticker'}
	endif
	<resolved_id> :SE_GetProps
	if (<text> != <message>)
		qi_main_menu :SE_SetProps \{online_ticker_window_element_alpha = 0.0
			time = 0.5}
		qi_main_menu :SE_WaitProps
		<resolved_id> :SE_SetProps text = <message> alpha = 1.0
		<resolved_id> :SE_WaitProps
	endif
	qi_main_menu :SE_SetProps \{online_ticker_window_element_alpha = 1.0
		time = 0.5}
	qi_main_menu :SE_WaitProps
	Wait <delay> second
	qi_main_menu :SE_SetProps \{online_ticker_window_element_alpha = 0.0
		time = 0.5}
	qi_main_menu :SE_WaitProps
	return
endscript

script qi_get_ticker_message \{index = 0}
	ticker_message = qs("")
	switch (<message_id>)
		case mic_needed
		ticker_message = qs(0xd35f811b)
		case only_band_leader
		ticker_message = qs("Only the band leader can select to continue.")
		case start_to_proceed
		user_control_helper_get_buttonchar button = start controller = <index>
		FormatText TextName = ticker_message qs("Press %b to proceed.") b = <buttonchar>
		case more_players_needed
		ticker_message = qs("More players are needed for band play.")
		case everyone_needs_ready
		ticker_message = qs(0xc8cc661c)
		case player1_controls_vocalist
		FormatText \{TextName = ticker_message
			qs(0x3220c43e)}
		case player2_controls_vocalist
		FormatText \{TextName = ticker_message
			qs(0x149ff047)}
		case player3_controls_vocalist
		FormatText \{TextName = ticker_message
			qs(0x090ae390)}
		case player4_controls_vocalist
		FormatText \{TextName = ticker_message
			qs(0x59e198b5)}
		case has_guitar
		ticker_message = qs(0x2edd6d41)
		case has_drum
		ticker_message = qs(0x5b210181)
		case has_vocals
		ticker_message = qs(0xd679f884)
		case illegal_setup
		ticker_message = qs("The current instrument setup is not supported for this game mode.")
		default
	endswitch
	return ticker_message = <ticker_message>
endscript

script qi_ticker_display_message 
	qi_get_ticker_message message_id = <message_id> index = <index>
	qi_main_menu :Obj_KillSpawnedScript \{name = qi_ticker_display_message_helper}
	qi_main_menu :Obj_SpawnScriptNow qi_ticker_display_message_helper params = {message = <ticker_message> delay = <delay>}
	return
endscript

script qi_select_character_menu 
	spawnscriptnow qi_update_character_icon params = {menu_index = <menu_index>}
endscript

script qi_update_character_icon 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_create_menu menu_index = <menu_index>
	qi_main_menu :GetSingleTag \{menus}
	GetArraySize <menus>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_menu = (<menus> [<menu_index>])
	<current_menu> :GetSingleTag current_rocker_id
	if GotParam \{rocker_id}
		current_rocker_id = <rocker_id>
	endif
	get_musician_profile_size \{savegame = 0}
	get_musician_profile_struct_by_id id = <current_rocker_id> savegame = 0
	character_id = (<profile_struct>.name)
	get_car_photo_icon profile_struct = <profile_struct> character_id = <character_id> savegame = 0
	qi_scroll_arrows menu_index = <menu_index> show_arrows
	return
endscript

script qi_set_special_rocker 
	if NOT GotParam \{rocker_id}
		return
		debug_ScriptAssert \{'need param: rocker_id'}
	endif
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	get_musician_profile_struct_by_id id = <rocker_id> savegame = 0
	if NOT GotParam \{profile_struct}
		return
		debug_ScriptAssert 'unable to find rocker with rocker id: %r' r = <rocker_id>
	endif
	qi_set_rocker_id_helper rocker_id = <rocker_id> menu_index = <menu_index>
	qi_main_menu :GetSingleTag \{menus}
	GetArraySize <menus>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_menu = (<menus> [<menu_index>])
	<current_menu> :Obj_KillSpawnedScript name = qi_spawn_rocker_delay
	<current_menu> :Obj_SpawnScriptNow qi_spawn_rocker_delay params = {delay = 0 appearance = (<profile_struct>.appearance) player = (<menu_index> + 1)}
endscript

script qi_spawn_rocker_delay \{delay = 1}
	if NOT GotParam \{appearance}
		return
		debug_ScriptAssert \{'need param: appearance'}
	endif
	if NOT GotParam \{player}
		return
		debug_ScriptAssert \{'need param: player'}
	endif
	Wait <delay> second
	cas_queue_wait
	cas_queue_add_request appearance = <appearance> player = <player> instrument = guitar
endscript

script qi_set_rocker_id_helper 
	if NOT GotParam \{rocker_id}
		return
		debug_ScriptAssert \{'need param: rocker_id'}
	endif
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{menus}
	GetArraySize <menus>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_menu = (<menus> [<menu_index>])
	<current_menu> :SetTags {current_rocker_id = <rocker_id>}
endscript

script qi_get_rocker_id 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{menus}
	GetArraySize <menus>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_menu = (<menus> [<menu_index>])
	<current_menu> :GetSingleTag current_rocker_id
	if NOT GotParam \{current_rocker_id}
		return
		debug_ScriptAssert \{'cant find param: current_rocker_id  in current menu'}
	endif
	return rocker_id = <current_rocker_id>
endscript

script qi_set_rocker_id \{rocker_id = none
		delay = 0}
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{menus}
	GetArraySize <menus>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_menu = (<menus> [<menu_index>])
	<current_menu> :GetSingleTag current_rocker_id
	if (<current_rocker_id> != <rocker_id>)
		<current_menu> :Obj_KillSpawnedScript name = qi_spawn_rocker_delay
		if (<rocker_id> = none)
			cas_queue_kill_player player = (<menu_index> + 1)
		endif
		qi_set_character_name menu_index = <menu_index>
		qi_set_rocker_id_helper rocker_id = none menu_index = <menu_index>
	endif
	if (<rocker_id> != none)
		get_musician_profile_struct_by_id id = <rocker_id> savegame = 0
		if NOT GotParam \{profile_struct}
			return
			debug_ScriptAssert 'rocker: %t  not found' t = <rocker_id>
		endif
		character_full_name = (<profile_struct>.fullname)
		qi_set_character_name menu_index = <menu_index> qi_character_name = <character_full_name>
		qi_set_rocker_id_helper rocker_id = <rocker_id> menu_index = <menu_index>
		<current_menu> :Obj_KillSpawnedScript name = qi_spawn_rocker_delay
		<current_menu> :Obj_SpawnScriptNow qi_spawn_rocker_delay params = {delay = <delay> appearance = (<profile_struct>.appearance) player = (<menu_index> + 1)}
	endif
endscript

script qi_get_valid_rocker_list 
	if NOT GotParam \{part}
		debug_ScriptAssert \{'need param: part'}
	endif
	get_musician_profile_size \{savegame = 0}
	valid_rockers = []
	range = 0
	i = 0
	begin
	get_musician_profile_struct_by_index index = <i> savegame = 0
	if display_character_logic profile_struct = <profile_struct> savegame = 0 part = <part> bandplay only_purchased
		range = (<range> + 1)
		AddArrayElement array = <valid_rockers> element = (<profile_struct>.name)
		valid_rockers = <array>
	endif
	i = (<i> + 1)
	repeat <array_size>
	debug_Printf '%i unlocked, valid rockers to choose from' i = <range>
	return valid_rocker_list = <valid_rockers>
endscript

script qi_get_next_rocker 
	if NOT GotParam \{menu_index}
		return \{next_rocker_id = none}
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	if NOT GotParam \{current_rocker_id}
		return \{next_rocker_id = none}
		debug_ScriptAssert \{'need param: current_rocker_id'}
	endif
	if NOT GotParam \{part}
		return \{next_rocker_id = none}
		debug_ScriptAssert \{'need param: part'}
	endif
	qi_main_menu :GetSingleTag \{valid_rocker_list}
	qi_main_menu :GetSingleTag \{valid_rocker_list_size}
	i = 0
	begin
	if (<current_rocker_id> = (<valid_rocker_list> [<i>]))
		break
	endif
	i = (<i> + 1)
	repeat <valid_rocker_list_size>
	if (<i> < 0 || <i> >= <valid_rocker_list_size>)
		return \{next_rocker_id = none}
		debug_ScriptAssert 'profile not found in the array of selectable characters.  index: %i  valid_rocker_list_size: %s' i = <i> s = <valid_rocker_list_size>
	endif
	next_rocker_index = <i>
	if GotParam \{Increment}
		next_rocker_index = (<next_rocker_index> + 1)
		Mod a = (<valid_rocker_list_size> + <next_rocker_index>) b = <valid_rocker_list_size>
		next_rocker_index = <Mod>
		qi_scroll_arrows params = {menu_index = <menu_index> down}
	elseif GotParam \{decrement}
		next_rocker_index = (<next_rocker_index> - 1)
		Mod a = (<valid_rocker_list_size> + <next_rocker_index>) b = <valid_rocker_list_size>
		next_rocker_index = <Mod>
		qi_scroll_arrows params = {menu_index = <menu_index> up}
	else
		return \{next_rocker_id = none}
		debug_ScriptAssert \{'unhandled increment/decrement'}
	endif
	if (<next_rocker_index> < 0 || <next_rocker_index> >= <valid_rocker_list_size>)
		return \{next_rocker_id = none}
		debug_ScriptAssert 'Illegal next_rocker_index: %i  valid_rocker_list_size: %s' i = <next_rocker_index> s = <valid_rocker_list_size>
	endif
	get_musician_profile_struct_by_id id = (<valid_rocker_list> [<next_rocker_index>]) savegame = 0
	next_rocker = (<profile_struct>.name)
	qi_update_character_icon menu_index = <menu_index> rocker_id = <next_rocker>
	return next_rocker_id = <next_rocker>
endscript

script qi_get_random_rocker_id 
	if NOT GotParam \{menu_index}
		return \{random_rocker_id = none}
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	if NOT GotParam \{exclude_id}
		return \{random_rocker_id = none}
		debug_ScriptAssert \{'need param: exclude_id'}
	endif
	if NOT GotParam \{part}
		return \{random_rocker_id = none}
		debug_ScriptAssert \{'need param: part'}
	endif
	qi_main_menu :GetSingleTag \{valid_rocker_list}
	qi_main_menu :GetSingleTag \{valid_rocker_list_size}
	excluded_list_pos = -1
	i = 0
	begin
	rocker_iter = (<valid_rocker_list> [<i>])
	if (<rocker_iter> = <exclude_id>)
		excluded_list_pos = <i>
	endif
	i = (<i> + 1)
	repeat <valid_rocker_list_size>
	if (<valid_rocker_list_size> < 2)
		return \{random_rocker_id = none}
		debug_ScriptAssert \{'rocker list is hella tiny (handle it)'}
	endif
	range = (<valid_rocker_list_size> - 1)
	GetRandomValue name = rocker_index a = 0 b = <range> Integer
	rocker_id = (<valid_rocker_list> [<rocker_index>])
	if (<exclude_id> = <rocker_id>)
		rocker_index = (<rocker_index> + 1)
		if (<rocker_index> > <range>)
			rocker_index = 0
		endif
		rocker_id = (<valid_rocker_list> [<rocker_index>])
	endif
	return random_rocker_id = <rocker_id>
endscript

script qi_scroll_arrows 
	if NOT GotParam \{menu_index}
		return
		debug_ScriptAssert \{'need param: menu_index'}
	endif
	qi_main_menu :GetSingleTag \{descs}
	GetArraySize <descs>
	if (<menu_index> < 0 || <menu_index> >= <array_size>)
		return
		debug_ScriptAssert 'Illegal menu_index: %i  array_size: %s' i = <menu_index> s = <array_size>
	endif
	current_desc = (<descs> [<menu_index>])
	<current_desc> :Obj_KillSpawnedScript name = qi_scroll_arrows_helper
	<current_desc> :Obj_SpawnScriptNow qi_scroll_arrows_helper params = {<...>}
endscript

script qi_scroll_arrows_helper 
	Obj_GetID
	<current_desc> :SE_GetProps
	if GotParam \{show_arrows}
		<ObjID> :SE_SetProps scroll_arrow_alpha = 1.0
		SetArrayElement ArrayName = menu_in_select_character GlobalArray index = <menu_index> newvalue = true
		qi_set_character_name menu_index = <menu_index>
		qi_set_character_name menu_index = <menu_index> qi_character_name = <name_text>
	elseif GotParam \{hide_arrows}
		<ObjID> :SE_SetProps scroll_arrow_alpha = 0.0
		SetArrayElement ArrayName = menu_in_select_character GlobalArray index = <menu_index> newvalue = false
		qi_set_character_name menu_index = <menu_index>
		qi_set_character_name menu_index = <menu_index> qi_character_name = <name_text>
	endif
	arrow_is_animating = 0
	if GotParam \{up}
		<ObjID> :SE_SetProps name_arrow_up_scale = 1.0 time = 0.1
		arrow_is_animating = 1
	endif
	if GotParam \{down}
		<ObjID> :SE_SetProps name_arrow_down_scale = 1.0 time = 0.1
		arrow_is_animating = 1
	endif
	if (<arrow_is_animating> = 1)
		Wait \{0.1
			second
			ignoreslomo}
	endif
	<ObjID> :SE_SetProps name_arrow_up_scale = 0.8 time = 0.1
	<ObjID> :SE_SetProps name_arrow_down_scale = 0.8 time = 0.1
	return
endscript

script qi_create_rocker_menu 
	qi_rocker_menu = {
		menu_name = 'rocker'
		menu_elements = [
			{
				text = qs(0x855fd6b0)
			}
			{
				text = qs("SELECT ROCKER")
			}
			{
				text = qs("READY")
			}
		]
	}
	return menu = <qi_rocker_menu>
endscript

script qi_create_instrument_menu 
	qi_instrument_menu = {
		menu_name = 'instrument'
		menu_elements = [
			{
				text = qs("GUITAR")
			}
			{
				text = qs("BASS")
			}
			{
				text = qs("DRUMS")
			}
			{
				text = qs("VOCALS")
			}
		]
	}
	return menu = <qi_instrument_menu>
endscript

script qi_create_handedness_menu 
	qi_handedness_menu = {
		menu_name = 'handedness'
		menu_elements = [
			{
				text = qs("STANDARD")
			}
			{
				text = qs("LEFTY FLIP")
			}
		]
	}
	return menu = <qi_handedness_menu>
endscript

script qi_create_vocaltext_menu 
	qi_vocaltext_menu = {
		menu_name = 'vocaltext'
		menu_elements = [
			{
				text = qs("STATIC")
			}
			{
				text = qs("SCROLLING")
			}
		]
	}
	return menu = <qi_vocaltext_menu>
endscript

script qi_create_difficulty_menu 
	qi_difficulty_menu = {
		menu_name = 'difficulty'
		menu_elements = [
			{
				text = qs("BEGINNER")
			}
			{
				text = qs("EASY")
			}
			{
				text = qs("MEDIUM")
			}
			{
				text = qs("HARD")
			}
			{
				text = qs("EXPERT")
			}
		]
	}
	return menu = <qi_difficulty_menu>
endscript

script qi_create_difficulty_plus_menu 
	qi_difficulty_plus_menu = {
		menu_name = 'difficulty_plus'
		menu_elements = [
			{
				text = qs("BEGINNER")
			}
			{
				text = qs("EASY")
			}
			{
				text = qs("MEDIUM")
			}
			{
				text = qs("HARD")
			}
			{
				text = qs("EXPERT")
			}
			{
				text = qs("EXPERT+")
			}
		]
	}
	return menu = <qi_difficulty_plus_menu>
endscript

script qi_create_add_vocalist_menu 
	if NOT GotParam \{controller}
		debug_ScriptAssert \{'need param: controller'}
	endif
	user_control_helper_get_buttonchar button = Yellow controller = <controller>
	qi_add_vocalist_menu = {
		menu_name = 'add_vocalist'
		menu_elements = [
			{
				text = qs("")
			}
			{
				text = qs("")
			}
			{
				text = qs("")
			}
			{
				text = qs("")
			}
			{
				text = qs("")
			}
			{
				text = (<buttonchar> + qs(0xcc207794))
			}
		]
	}
	menu = <qi_add_vocalist_menu>
endscript

script qi_create_disconnect_menu 
	controller_text = qs(0x8bcc0ba3)
	if GotParam \{guitar}
		controller_text = qs("GUITAR")
	elseif GotParam \{drum}
		controller_text = qs("DRUMS")
	endif
	qi_disconnect_menu = {
		menu_name = 'disconnect'
		menu_elements = [
			{
				text = qs(0xcd188afe)
			}
			{
				text = qs(0x9691b59e)
			}
			{
				text = <controller_text>
			}
		]
	}
	return menu = <qi_disconnect_menu>
endscript

script qi_initialize_object 
	if NOT GotParam \{mode}
		debug_ScriptAssert \{'need param: mode'}
	endif
	GameMode_GetType
	switch <type>
		case pro_faceoff
		if (<mode> = character_hub)
			qi_path_headtohead_a \{direction = enter}
		elseif (<mode> = band_difficulty)
			qi_path_headtohead_b \{direction = enter}
		else
			debug_ScriptAssert \{'illegal mode'}
		endif
		case quickplay
		if (<mode> = band_mode)
			qi_path_quickplay_a \{direction = enter}
		elseif (<mode> = band_difficulty)
			qi_path_quickplay_b \{direction = enter}
		else
			debug_ScriptAssert \{'illegal mode'}
		endif
		case career
		if qi_is_career_intro_beaten
			if (<mode> = band_mode)
				qi_path_career_post_intro_a \{direction = enter}
			elseif (<mode> = band_difficulty)
				qi_path_career_post_intro_b \{direction = enter}
			else
				debug_ScriptAssert \{'illegal mode'}
			endif
		else
			if (<mode> = band_mode)
				qi_path_career_pre_intro_a \{direction = enter}
			elseif (<mode> = band_difficulty)
				qi_path_career_pre_intro_b \{direction = enter}
			else
				debug_ScriptAssert \{'illegal mode'}
			endif
		endif
		default
		debug_ScriptAssert \{'illegal game type'}
	endswitch
endscript

script qi_path_back_out 
	qi_path_wait_for_cas
	if GotParam \{kill_rocker}
		cas_destroy_all_characters
	endif
	generic_event_back
endscript

script qi_path_wait_for_cas 
	if cas_queue_is_busy
		create_loading_screen
		cas_queue_wait
	endif
endscript

script qi_path_quickplay_a 
	if NOT GotParam \{direction}
		debug_ScriptAssert \{'need param: direction'}
	endif
	switch <direction>
		case enter
		debug_Printf \{'QUICKPLAY: A ~ ENTER'}
		QI_SendScreenStateEvent \{state_id = 0}
		QI_SendScreenStateEvent \{state_id = 1}
		case next
		debug_Printf \{'QUICKPLAY: A ~ NEXT'}
		QI_SendScreenStateEvent \{state_id = 2}
		QI_SendScreenStateEvent \{state_id = 3}
		qi_destroy
		spawnscriptnow qi_path_quick_play_a_advance params = {num_ready = <num_ready>}
		case back
		debug_Printf \{'QUICKPLAY: A ~ BACK'}
		QI_SendScreenStateEvent \{state_id = 2}
		QI_SendScreenStateEvent \{state_id = 3}
		qi_destroy \{kill_rocker}
		spawnscriptnow \{qi_path_back_out
			params = {
				kill_rocker
			}}
		default
		debug_ScriptAssert \{'illegal direction'}
	endswitch
	return
endscript

script qi_path_quick_play_a_advance 
	qi_path_wait_for_cas
	change_num_players num = <num_ready>
	if ($is_partyplay_mode = 1)
		generic_event_choose no_sound state = uistate_band_difficulty data = {continue_data = {state = uistate_play_song <...>}}
	else
		generic_event_choose no_sound state = uistate_setlist data = {use_all_controllers num_band_players = <num_ready> band_controller_types = <band_controller_types>}
	endif
endscript

script qi_path_quickplay_b 
	if NOT GotParam \{direction}
		debug_ScriptAssert \{'need param: direction'}
	endif
	switch <direction>
		case enter
		debug_Printf \{'QUICKPLAY: B ~ ENTER'}
		QI_SendScreenStateEvent \{state_id = 4}
		QI_SendScreenStateEvent \{state_id = 5}
		case next
		debug_Printf \{'QUICKPLAY: B ~ NEXT'}
		QI_SendScreenStateEvent \{state_id = 6}
		QI_SendScreenStateEvent \{state_id = 7}
		qi_destroy
		spawnscriptnow \{qi_path_quick_play_b_advance}
		case back
		debug_Printf \{'QUICKPLAY: B ~ BACK'}
		QI_SendScreenStateEvent \{state_id = 6}
		QI_SendScreenStateEvent \{state_id = 7}
		qi_destroy
		spawnscriptnow \{qi_path_back_out}
		default
		debug_ScriptAssert \{'illegal direction'}
	endswitch
	return
endscript

script qi_path_quick_play_b_advance 
	create_loading_screen
	qi_path_wait_for_cas
	generic_event_choose \{state = uistate_play_song}
endscript

script qi_path_headtohead_a 
	if NOT GotParam \{direction}
		debug_ScriptAssert \{'need param: direction'}
	endif
	switch <direction>
		case enter
		debug_Printf \{'HEADTOHEAD: A ~ ENTER'}
		qi_initialize_head_to_head
		QI_SendScreenStateEvent \{state_id = 0}
		QI_SendScreenStateEvent \{state_id = 1}
		case next
		debug_Printf \{'HEADTOHEAD: A ~ NEXT'}
		QI_SendScreenStateEvent \{state_id = 2}
		QI_SendScreenStateEvent \{state_id = 3}
		qi_destroy
		spawnscriptnow \{qi_path_headtohead_a_advance}
		case back
		debug_Printf \{'HEADTOHEAD: A ~ BACK'}
		QI_SendScreenStateEvent \{state_id = 2}
		QI_SendScreenStateEvent \{state_id = 3}
		qi_destroy \{kill_rocker}
		spawnscriptnow \{qi_path_back_out
			params = {
				kill_rocker
			}}
		default
		debug_ScriptAssert \{'illegal direction'}
	endswitch
	return
endscript

script qi_path_headtohead_a_advance 
	qi_path_wait_for_cas
	generic_event_choose \{no_sound
		state = uistate_setlist
		data = {
			no_jamsession
			use_all_controllers
		}}
endscript

script qi_path_headtohead_b 
	if NOT GotParam \{direction}
		debug_ScriptAssert \{'need param: direction'}
	endif
	switch <direction>
		case enter
		debug_Printf \{'HEADTOHEAD: B ~ ENTER'}
		qi_initialize_head_to_head
		QI_SendScreenStateEvent \{state_id = 4}
		QI_SendScreenStateEvent \{state_id = 5}
		case next
		debug_Printf \{'HEADTOHEAD: B ~ NEXT'}
		QI_SendScreenStateEvent \{state_id = 6}
		QI_SendScreenStateEvent \{state_id = 7}
		qi_destroy
		spawnscriptnow \{qi_path_headtohead_b_advance}
		case back
		debug_Printf \{'HEADTOHEAD: B ~ BACK'}
		QI_SendScreenStateEvent \{state_id = 6}
		QI_SendScreenStateEvent \{state_id = 7}
		qi_destroy
		spawnscriptnow \{qi_path_back_out}
		default
		debug_ScriptAssert \{'illegal direction'}
	endswitch
	return
endscript

script qi_path_headtohead_b_advance 
	create_loading_screen
	qi_path_wait_for_cas
	generic_event_choose \{state = uistate_play_song}
endscript

script qi_path_career_pre_intro_a 
	if NOT GotParam \{direction}
		debug_ScriptAssert \{'need param: direction'}
	endif
	switch <direction>
		case enter
		debug_Printf \{'CAREER PRE-INTRO: A ~ ENTER'}
		QI_SendScreenStateEvent \{state_id = 0}
		QI_SendScreenStateEvent \{state_id = 1}
		case next
		debug_Printf \{'CAREER PRE-INTRO: A ~ NEXT'}
		QI_SendScreenStateEvent \{state_id = 2}
		QI_SendScreenStateEvent \{state_id = 3}
		qi_destroy
		spawnscriptnow \{qi_path_career_pre_intro_a_advance}
		case back
		debug_Printf \{'CAREER PRE-INTRO: A ~ BACK'}
		QI_SendScreenStateEvent \{state_id = 2}
		QI_SendScreenStateEvent \{state_id = 3}
		qi_destroy \{kill_rocker}
		spawnscriptnow \{qi_path_back_out
			params = {
				kill_rocker
			}}
		default
		debug_ScriptAssert \{'illegal direction'}
	endswitch
	return
endscript

script qi_path_career_pre_intro_a_advance 
	qi_path_wait_for_cas
	generic_event_choose \{state = uistate_band_difficulty}
endscript

script qi_path_career_pre_intro_b 
	if NOT GotParam \{direction}
		debug_ScriptAssert \{'need param: direction'}
	endif
	switch <direction>
		case enter
		debug_Printf \{'CAREER PRE-INTRO: B ~ ENTER'}
		QI_SendScreenStateEvent \{state_id = 4}
		QI_SendScreenStateEvent \{state_id = 5}
		case next
		debug_Printf \{'CAREER PRE-INTRO: B ~ NEXT'}
		get_band_difficulty
		get_progression_globals ($current_progression_flag) game_mode = ($game_mode)
		format_globaltag_song_checksum part = ($<tier_global>.part) song = ($<tier_global>.tier1.songs [0]) difficulty = <band_difficulty>
		GetGlobalTags <song_checksum> param = unlocked
		if (<unlocked> = 0)
			QI_SendScreenStateEvent \{state_id = 6}
			QI_SendScreenStateEvent \{state_id = 7}
			qi_destroy
			spawnscriptnow \{qi_path_career_pre_intro_b_advance}
		else
			GetArraySize ($gh4_1_intro_tier.songs)
			change current_song = ($gh4_1_intro_tier.songs [(<array_size> - 1)])
			change current_level = ($gh4_1_intro_tier.level)
			QI_SendScreenStateEvent \{state_id = 6}
			QI_SendScreenStateEvent \{state_id = 7}
			qi_destroy
			spawnscriptnow \{qi_path_career_pre_intro_b_advance
				params = {
					unlocked
				}}
		endif
		case back
		debug_Printf \{'CAREER PRE-INTRO: B ~ BACK'}
		QI_SendScreenStateEvent \{state_id = 6}
		QI_SendScreenStateEvent \{state_id = 7}
		qi_destroy \{kill_rocker}
		spawnscriptnow \{qi_path_back_out
			params = {
				kill_rocker
			}}
		default
		debug_ScriptAssert \{'illegal direction'}
	endswitch
	return
endscript

script qi_path_career_pre_intro_b_advance 
	create_loading_screen
	qi_path_wait_for_cas
	if GotParam \{unlocked}
		generic_event_choose state = uistate_play_song data = {selected_level = ($gh4_1_intro_tier.level)}
	else
		generic_event_choose state = uistate_play_song data = {progression_flag = ($current_progression_flag) gig_num = 1}
	endif
endscript

script qi_path_career_post_intro_a 
	if NOT GotParam \{direction}
		debug_ScriptAssert \{'need param: direction'}
	endif
	switch <direction>
		case enter
		debug_Printf \{'CAREER POST-INTRO: A ~ ENTER'}
		QI_SendScreenStateEvent \{state_id = 0}
		QI_SendScreenStateEvent \{state_id = 1}
		case next
		debug_Printf \{'CAREER POST-INTRO: A ~ NEXT'}
		QI_SendScreenStateEvent \{state_id = 2}
		QI_SendScreenStateEvent \{state_id = 3}
		qi_destroy
		spawnscriptnow \{qi_path_career_post_intro_a_advance}
		case back
		debug_Printf \{'CAREER POST-INTRO: A ~ BACK'}
		QI_SendScreenStateEvent \{state_id = 2}
		QI_SendScreenStateEvent \{state_id = 3}
		qi_destroy \{kill_rocker}
		spawnscriptnow \{qi_path_back_out
			params = {
				kill_rocker
			}}
		default
		debug_ScriptAssert \{'illegal direction'}
	endswitch
	return
endscript

script qi_path_career_post_intro_a_advance 
	qi_path_wait_for_cas
	generic_event_choose \{state = uistate_band_difficulty}
endscript

script qi_path_career_post_intro_b 
	if NOT GotParam \{direction}
		debug_ScriptAssert \{'need param: direction'}
	endif
	switch <direction>
		case enter
		debug_Printf \{'CAREER POST-INTRO: B ~ ENTER'}
		QI_SendScreenStateEvent \{state_id = 4}
		QI_SendScreenStateEvent \{state_id = 5}
		case next
		debug_Printf \{'CAREER POST-INTRO: B ~ NEXT'}
		QI_SendScreenStateEvent \{state_id = 6}
		QI_SendScreenStateEvent \{state_id = 7}
		qi_destroy
		spawnscriptnow \{qi_path_career_post_intro_b_advance}
		case back
		debug_Printf \{'CAREER POST-INTRO: B ~ BACK'}
		QI_SendScreenStateEvent \{state_id = 6}
		QI_SendScreenStateEvent \{state_id = 7}
		qi_destroy \{kill_rocker}
		spawnscriptnow \{qi_path_back_out
			params = {
				kill_rocker
			}}
		default
		debug_ScriptAssert \{'illegal direction'}
	endswitch
	return
endscript

script qi_path_career_post_intro_b_advance 
	if NOT current_band_has_band_name
		generic_event_choose \{state = uistate_band_name_logo
			data = {
				from_career_progression
			}}
	else
		create_loading_screen
		qi_path_wait_for_cas
		generic_event_choose \{state = uistate_select_venue}
	endif
endscript

script qi_clear_object 
	QI_SendScreenStateEvent \{state_id = 100}
endscript

script qi_is_career_intro_beaten 
	if NOT ($career_intro_exists)
		return \{true}
	endif
	get_current_band_info
	GetGlobalTags <band_info>
	if (<career_intro_band_complete> = 1)
		debug_Printf \{'CAREER INTRO BEATEN'}
		return \{true}
	endif
	debug_Printf \{'CAREER INTRO NOT BEATEN'}
	return \{false}
endscript

script qi_is_headtohead 
	is_headtohead = false
	if ScreenElementExists \{id = qi_main_menu}
		qi_main_menu :GetSingleTag \{headtohead}
		if NOT GotParam \{headtohead}
			debug_ScriptAssert \{'qi_main_menu doesnt have param: headtohead'}
		endif
		if (<headtohead> = 1)
			is_headtohead = true
		endif
	endif
	return <is_headtohead>
endscript

script qi_print_globals 
	get_current_band_info
	GetGlobalTags <band_info>
	debug_Printf \{'*******************************'}
	debug_Printf \{'**** PRINTING SOME GLOBALS ****'}
	debug_Printf \{'*******************************'}
	debug_Printf \{''}
	debug_PrintStruct <...>
	qi_print_struct \{globalname = band_mode_menu_tags}
	qi_print_struct \{globalname = band_mode_actual_devices}
	qi_print_struct \{globalname = player_status_array}
	qi_print_struct \{globalname = player_status}
	qi_print_struct \{globalname = band_mode_menu_tags_instrument}
	qi_print_struct \{globalname = net_band_mode_menu}
	qi_print_struct \{globalname = net_band_members}
	qi_print_struct \{globalname = net_career_selected_song}
	qi_print_struct \{globalname = players_in_uistate}
	qi_print_struct \{globalname = band_info}
	qi_print_struct \{globalname = player_has_no_controller}
	qi_print_struct \{globalname = num_quickplay_song_list}
	qi_print_struct \{globalname = quickplay_song_list}
	qi_print_struct \{globalname = quickplay_song_list_current}
	qi_print_struct \{globalname = jam_curr_directory_listing}
	qi_print_struct \{globalname = jam_song_assets}
	i = 1
	begin
	GetPlayerInfo (<i>)
	debug_PrintStruct <playerinfo>
	i = (<i> + 1)
	repeat 4
	debug_Printf \{'*** DUMPING PLAYER STATUS ARRAY ***'}
	i = 1
	begin
	<player_status> = ($player_status_array [<i>])
	debug_Printf '** PLAYER %i **' i = <i>
	debug_PrintStruct ($<player_status>)
	i = (<i> + 1)
	repeat 8
	debug_Printf \{''}
	debug_Printf \{'*******************************'}
	debug_Printf \{'*******************************'}
endscript

script qi_print_struct 
	if (GlobalExists name = <globalname>)
		debug_Printf '%i:' i = <globalname> DoNotResolve
		debug_PrintStruct ($<globalname>)
	else
		debug_Printf '%i not found' i = <globalname> DoNotResolve
	endif
	debug_Printf \{''}
	debug_Printf \{'***************'}
	debug_Printf \{''}
endscript
