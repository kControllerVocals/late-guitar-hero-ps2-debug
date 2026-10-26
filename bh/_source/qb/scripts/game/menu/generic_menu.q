menu_history_icon_container_dim = (300.0, 100.0)
menu_history_icon_size = 128
generic_menu_ignore_first_line = 0

script make_generic_menu {
		pad_back_sound = generic_menu_pad_back_sound
		pad_back_script = generic_event_back_block
		exclusive_device = ($primary_controller)
		color_scheme = ($car_color_scheme)
		desc = 'generic_menu'
		cai_bg = 0
		ignore_first_line = 0
	}
	destroy_generic_menu
	if NOT GotParam \{title}
		noTitle = 1
	endif
	if GotParam \{use_all_controllers}
		RemoveParameter \{exclusive_device}
		get_all_exclusive_devices
	endif
	if NOT (($menu_over_ride_exclusive_device) = -1)
		exclusive_device = ($menu_over_ride_exclusive_device)
	endif
	update_ingame_controllers controller = <exclusive_device>
	if ScreenElementExists \{id = current_menu_anchor}
		DestroyScreenElement \{id = current_menu_anchor}
	endif
	change generic_menu_ignore_first_line = (<ignore_first_line>)
	CreateScreenElement {
		type = DescInterface
		parent = root_window
		desc = <desc>
		id = generic_menu
		exclusive_device = <exclusive_device>
		generic_menu_title_text_text = <title>
		generic_menu_bg_texture = <generic_menu_bg_texture>
		generic_menu_bg_dims = <generic_menu_bg_dims>
		pos = <pos>
		cai_bg_alpha = <cai_bg>
	}
	if GotParam \{smaller_menu}
		generic_menu :SE_SetProps \{generic_menu_scale = (0.8, 0.8)}
		generic_menu :SetTags \{smaller_menu}
	endif
	if generic_menu :Desc_ResolveAlias \{name = alias_generic_menu_vmenu
			param = generic_smenu}
		AssignAlias id = <generic_smenu> alias = current_menu
		if GotParam \{vmenu_id}
			AssignAlias id = <generic_smenu> alias = <vmenu_id>
		endif
		<generic_smenu> :SetTags {total_length = 0}
	else

	endif
	current_menu :SetTags {color_scheme = <color_scheme>}
	if NOT GotParam \{no_up_down_sound_handlers}
		add_generic_menu_up_down_sound_handlers
	endif
	spawnscriptnow ps2_delay_pad_event_registration params = {<...>}
	if GotParam \{noBG}
		generic_menu :SE_SetProps \{generic_menu_bg_alpha = 0}
	endif
	if GotParam \{noTitle}
		generic_menu :SE_SetProps \{generic_menu_title_alpha = 0}
	elseif GotParam \{noTitleBG}
		generic_menu :SE_SetProps \{generic_menu_title_bg_alpha = 0}
	endif
	title_dims_loc = (225.0, 50.0)
	title_pos = (0.0, 0.0)
	if GotParam \{title_dims}
		<title_dims_loc> = <title_dims>
	endif
	if GotParam \{shift}
		<title_pos> = ((<title_pos>) + (<shift>))
	endif
	return \{desc_id = generic_menu}
endscript

script destroy_generic_menu 
	if ScreenElementExists \{id = generic_menu}
		DestroyScreenElement \{id = generic_menu}
	endif
	cleanup_cas_menu_handlers
	destroy_viewport_ui
	clean_up_user_control_helpers
	KillSpawnedScript \{name = ps2_delay_pad_event_registration}
endscript

script add_generic_menu_up_down_sound_handlers \{parent = current_menu}
	SetScreenElementProps {
		id = <parent>
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up = 1}}
			{pad_down generic_menu_up_or_down_sound params = {down = 2}}
		]
	}
endscript

script add_generic_menu_text_item \{focus_script = focus_generic_menu_text_item
		unfocus_script = unfocus_generic_menu_text_item
		pad_choose_sound = ui_menu_select_sfx
		parent = current_menu
		internal_just = [
			center
			center
		]}
	if ScreenElementExists id = <parent>
		CreateScreenElement {
			type = DescInterface
			parent = <parent>
			desc = 'generic_menu_text_item'
			autoSizeDims = true
			generic_menu_smenu_textitem_text_text = <text>
			generic_menu_smenu_textitem_text_internal_just = <internal_just>
		}
		if NOT <parent> :GetSingleTag color_scheme
			color_scheme = ($default_color_scheme)
		endif
	else

	endif
	if GotParam \{choose_state}
		pad_choose_script = ui_event_block
		pad_choose_params = {event = menu_change data = {state = <choose_state> <choose_state_data> container_id = <id>}}
	endif
	if GotParam \{choose_back}
		pad_choose_script = generic_event_back_block
	endif
	SetScreenElementProps {
		id = <id>
		event_handlers = [
			{focus <focus_script> params = {id = <id> do_not_scroll = <do_not_scroll> additional_focus_script = <additional_focus_script> additional_focus_params = <additional_focus_params>}}
			{unfocus <unfocus_script> params = {id = <id> additional_unfocus_script = <additional_unfocus_script> additional_unfocus_params = <additional_unfocus_params>}}
		]
	}
	spawnscriptnow ps2_add_generic_menu_icon_item_register_events params = {<...>}
	SetScreenElementProps {
		id = <id>
		generic_menu_smenu_textitem_text_rgba = ((<color_scheme>).text_color)
		generic_menu_smenu_textitem_text_font = ((<color_scheme>).text_font)
	}
	if GotParam \{not_focusable}
		if GotParam \{header_text}
			rgba = ((<color_scheme>).title_color)
		else
			rgba = ((<color_scheme>).text_color)
		endif
		SetScreenElementProps {
			id = <id>
			not_focusable
			generic_menu_smenu_textitem_text_rgba = <rgba>
		}
	endif
	if GotParam \{heading}
		SetScreenElementProps {
			id = <id>
			not_focusable
			generic_menu_smenu_textitem_text_rgba = [255 255 255 255]
			textitem_text_use_shadow = true
		}
	endif
	if GotParam \{text_case}
		<id> :SE_SetProps generic_menu_smenu_textitem_text_textcase = <text_case>
	endif
	<parent> :GetTags
	if GotParam \{total_length}
		GetScreenElementDims id = <parent>
		parent_height = <Height>
		GetScreenElementDims id = <id>
		total_length = (<total_length> + <Height>)
		if (<total_length> > <parent_height>)
			generic_menu :SE_SetProps \{generic_menu_scrollbar_alpha = 1.0}
		endif
		<parent> :SetTags {total_length = <total_length>}
	else
		GetScreenElementDims id = <id>
		<parent> :SetTags {total_length = <Height>}
	endif
	return item_container_id = <id>
endscript

script generic_menu_pos_highlight 
	if ScreenElementExists \{id = generic_menu}
		GetTags
		if NOT GotParam \{do_not_scroll}
			set_generic_menu_scrollbar_pos id = <id>
		endif
		if generic_menu :Desc_ResolveAlias \{name = alias_highlight}
			Wait \{2
				gameframes}
			<id> :SE_GetProps rot_angle
			<resolved_id> :SE_SetProps rot_angle = <rot_angle> alpha = 1.0
			GetScreenElementPosition id = <resolved_id> summed
			x_pos = (<screenelementpos> [0])
			GetScreenElementPosition id = <id> summed
			<screenelementpos> = (((1.0, 0.0) * <x_pos>) + ((0.0, 1.0) * (<screenelementpos> [1])))
			<resolved_id> :SE_SetProps pos = {absolute (<screenelementpos>)}
			<resolved_id> :SE_WaitProps
			<resolved_id> :SE_SetProps pos = {absolute ((<screenelementpos>) + (0.0, -10.0))} time = 0.05
			<resolved_id> :SE_WaitProps
			<resolved_id> :SE_SetProps pos = {absolute (<screenelementpos>)} time = 0.05
			<resolved_id> :SE_WaitProps
		endif
	endif
endscript

script focus_generic_menu_text_item 
	Obj_GetID
	if NOT GotParam \{id}
		id = <ObjID>
	endif
	<ObjID> :SE_GetParentId
	if <parent_id> :GetSingleTag color_scheme
		<id> :SE_SetProps generic_menu_smenu_textitem_text_rgba = ((<color_scheme>).text_focus_color)
		<id> :SE_SetProps generic_menu_smenu_textitem_text_font = ((<color_scheme>).text_focus_font)
	endif
	generic_menu_pos_highlight <...>
	if GotParam \{additional_focus_script}
		<additional_focus_script> <additional_focus_params>
	endif
endscript

script unfocus_generic_menu_text_item 
	Obj_GetID
	if NOT GotParam \{id}
		id = <ObjID>
	endif
	<ObjID> :SE_GetParentId
	if <parent_id> :GetSingleTag color_scheme
		<id> :SE_SetProps generic_menu_smenu_textitem_text_rgba = ((<color_scheme>).text_color)
		<id> :SE_SetProps generic_menu_smenu_textitem_text_font = ((<color_scheme>).text_font)
	endif
	<id> :SE_SetProps generic_menu_smenu_textitem_text_material = null
	if GotParam \{additional_unfocus_script}
		<additional_unfocus_script> {id = <id>} <additional_unfocus_params>
	endif
endscript

script add_generic_menu_icon_item \{focus_script = focus_generic_menu_icon_item
		unfocus_script = unfocus_generic_menu_icon_item
		pad_choose_sound = ui_menu_select_sfx
		parent = current_menu
		ui_event_script = ui_event
		desc = 'generic_menu_icon_item'}
	if ScreenElementExists id = <parent>
		CreateScreenElement {
			id = <id>
			type = DescInterface
			parent = <parent>
			desc = <desc>
			autoSizeDims = true
			generic_menu_smenu_iconitem_text_text = <text>
			generic_menu_smenu_iconitem_icon_texture = <icon>
			generic_menu_smenu_iconitem_icon_rot_angle = <icon_rot>
		}
		if NOT <parent> :GetSingleTag color_scheme
			color_scheme = ($default_color_scheme)
		endif
	else

	endif
	if GotParam \{choose_state}
		pad_choose_script = <ui_event_script>
		pad_choose_params = {event = menu_change data = {state = <choose_state> <choose_state_data> container_id = <id>}}
	endif
	if GotParam \{choose_back}
		pad_choose_script = generic_event_back
	endif
	SetScreenElementProps {
		id = <id>
		event_handlers = [
			{focus <focus_script> params = {id = <id> additional_focus_script = <additional_focus_script> additional_focus_params = <additional_focus_params>}}
			{unfocus <unfocus_script> params = {id = <id> additional_unfocus_script = <additional_unfocus_script> additional_unfocus_params = <additional_unfocus_params>}}
		]
	}
	spawnscriptnow ps2_add_generic_menu_icon_item_register_events params = {<...>}
	SetScreenElementProps {
		id = <id>
		generic_menu_smenu_iconitem_text_rgba = ((<color_scheme>).text_color)
		generic_menu_smenu_iconitem_text_font = ((<color_scheme>).text_font)
	}
	if GotParam \{not_focusable}
		if GotParam \{header_text}
			rgba = ((<color_scheme>).title_color)
		else
			rgba = ((<color_scheme>).text_color)
		endif
		if GotParam \{not_focusable_rgba}
			rgba = <not_focusable_rgba>
		endif
		SetScreenElementProps {
			id = <id>
			not_focusable
			generic_menu_smenu_iconitem_text_rgba = <rgba>
		}
	endif
	if GotParam \{text_case}
		<id> :SE_SetProps generic_menu_smenu_iconitem_text_textcase = <text_case>
	endif
	<parent> :GetTags
	if GotParam \{total_length}
		GetScreenElementDims id = <parent>
		parent_height = <Height>
		GetScreenElementDims id = <id>
		total_length = (<total_length> + <Height>)
		if (<total_length> > <parent_height>)
			generic_menu :SE_SetProps \{generic_menu_scrollbar_alpha = 1.0}
		endif
		<parent> :SetTags {total_length = <total_length>}
		set_generic_menu_scrollbar_pos id = <id>
	else
		GetScreenElementDims id = <id>
		<parent> :SetTags {total_length = <Height>}
	endif
	return item_container_id = <id>
endscript

script focus_generic_menu_icon_item 
	Obj_GetID
	if StructureContains Structure = <additional_focus_params> no_highlight_bar
		<id> :SE_SetProps generic_menu_smenu_iconitem_highlight_alpha = 1 time = 0.1 Anim = fast_in
	endif
	<ObjID> :SE_GetParentId
	if <parent_id> :GetSingleTag color_scheme
		<id> :SE_SetProps generic_menu_smenu_iconitem_text_rgba = ((<color_scheme>).text_focus_color)
		<id> :SE_SetProps generic_menu_smenu_iconitem_text_font = ((<color_scheme>).text_focus_font)
	endif
	generic_menu_pos_highlight <...>
	if GotParam \{additional_focus_script}
		<additional_focus_script> <additional_focus_params>
	endif
endscript

script unfocus_generic_menu_icon_item 
	Obj_GetID
	<ObjID> :SE_GetParentId
	if <parent_id> :GetSingleTag color_scheme
		<id> :SE_SetProps generic_menu_smenu_iconitem_text_rgba = ((<color_scheme>).text_color)
		<id> :SE_SetProps generic_menu_smenu_iconitem_text_font = ((<color_scheme>).text_font)
	endif
	<id> :SE_SetProps generic_menu_smenu_iconitem_text_material = null
	if GotParam \{additional_unfocus_script}
		<additional_unfocus_script> {id = <id>} <additional_unfocus_params>
	endif
endscript

script set_generic_menu_scrollbar_pos 
	if ScreenElementExists \{id = generic_menu}
		GetScreenElementPosition id = <id>
		<id> :SE_GetParentId
		<parent_id> :GetTags
		if GotParam \{total_length}
			set_generic_menu_scrollbar_worker <...>
		endif
	endif
endscript

script set_generic_menu_scrollbar_index 

	if NOT GotParam \{index}
		index = 0
	endif
	if ScreenElementExists \{id = generic_menu}
		GetScreenElementChildren id = <VMenu>
		GetArraySize <children>
		if (<index> < <array_size>)
			if ScreenElementExists id = (<children> [<index>])
				GetScreenElementPosition id = (<children> [<index>])
				<VMenu> :GetTags
				if GotParam \{total_length}
					set_generic_menu_scrollbar_worker <...>
				endif
			endif
		endif
	endif
endscript

script set_generic_menu_scrollbar_worker 
	if ($generic_menu_ignore_first_line = 0)
		scroll_perc = ((<screenelementpos>.(0.0, 1.0)) / <total_length>)
	else
		if NOT GotParam \{tag_selected_index}
			tag_selected_index = 0
		endif
		if (<tag_selected_index> = 1)
			scroll_perc = 0.0
		else
			scroll_perc = ((<screenelementpos>.(0.0, 1.0)) / <total_length>)
		endif
	endif
	scroll_len = 545
	scroll_pos = (((<scroll_perc> * <scroll_len> - 54.0) * (0.0, 1.0)) + (-17.0, 0.0))
	generic_menu :SE_SetProps generic_menu_scrollbar_thumb_blue_pos = <scroll_pos>
endscript
generic_menu_block_input = 0

script generic_blocking_execute_script 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	begin
	if ($generic_menu_block_input = 0)
		break
	endif
	Wait \{1
		game
		frame}
	repeat
	if Is_ui_event_running
		return \{false}
	endif
	<pad_script> <pad_params> device_num = <device_num>
endscript

script split_text_into_menu 

	CreateScreenElement {
		type = HMenu
		parent = <parent>
		<...>
	}
	menu_id = <id>
	StringToCharArray string = <text>
	GetArraySize <char_array>
	if (<array_size>)
		i = 0
		begin
		CreateScreenElement {
			type = TextElement
			font = fontgrid_text_a3
			<text_params>
			parent = <menu_id>
			text = (<char_array> [<i>])
		}
		i = (<i> + 1)
		repeat <array_size>
	endif
	GetScreenElementChildren id = <menu_id>
	return {menu_id = <menu_id> text_element_array = <children> text_element_array_size = <array_size>}
endscript

script menu_finish controller = ($primary_controller)
	if NOT (($menu_over_ride_exclusive_device) = -1)
		controller = ($menu_over_ride_exclusive_device)
	endif
	if NOT GotParam \{no_helper_text}
		if GotParam \{no_back_button}
			add_user_control_helper text = qs("SELECT") button = green z = 100000 all_buttons <...>
		elseif GotParam \{car_helper_text}
			add_user_control_helper text = qs("SELECT") button = green z = 100000 all_buttons <...>
			add_user_control_helper text = qs("BACK") button = red z = 100000 <...>
			menu_finish_rotate_zoom <...>
		elseif GotParam \{car_helper_text_back}
			add_user_control_helper text = qs("SELECT") button = green z = 100000 all_buttons <...>
			add_user_control_helper text = qs("BACK") button = red z = 100000 <...>
			menu_finish_rotate_zoom <...>
		elseif GotParam \{car_helper_text_cancel}
			add_user_control_helper text = qs("SELECT") button = green z = 100000 all_buttons <...>
			add_user_control_helper text = qs("CANCEL") button = red z = 100000 <...>
			menu_finish_rotate_zoom <...>
		elseif GotParam \{car_helper_text_extra}
			add_user_control_helper text = qs("SELECT") button = green z = 100000 all_buttons <...>
			add_user_control_helper text = qs("DONE") button = red z = 100000 <...>
			add_user_control_helper text = qs("CANCEL") button = Yellow z = 100000 <...>
			menu_finish_rotate_zoom <...>
		elseif GotParam \{car_helper_text_alt}
			add_user_control_helper text = qs("SELECT") button = green z = 100000 all_buttons <...>
			add_user_control_helper text = qs("CANCEL") button = red z = 100000 <...>
			add_user_control_helper text = qs("COLOR") button = Yellow z = 100000 <...>
			menu_finish_rotate_zoom <...>
		elseif GotParam \{car_helper_text_purchase}
			add_user_control_helper text = qs("BUY") button = green z = 100000 all_buttons <...>
			add_user_control_helper text = qs("CANCEL") button = red z = 100000 <...>
			menu_finish_rotate_zoom <...>
		elseif GotParam \{car_rotate_zoom}
			menu_finish_rotate_zoom <...>
		elseif GotParam \{car_helper_text_swatches}
			add_user_control_helper controller = <controller> text = qs("SELECT") button = green z = 100000
			add_user_control_helper controller = <controller> text = qs("CANCEL") button = red z = 100000
			add_user_control_helper controller = <controller> text = qs("STYLES") button = Yellow z = 100000
			menu_finish_rotate_zoom <...>
		else
			add_user_control_helper text = qs("SELECT") button = green z = 100000 all_buttons <...>
			add_user_control_helper text = qs("BACK") button = red z = 100000 <...>
		endif
	endif
endscript

script menu_finish_rotate_zoom 
	if NOT GotParam \{no_rotate_zoom_text}
		if NOT GotParam \{no_rotate_text}
			button = Blue
			if NOT IsGuitarController \{controller = $primary_controller}
				if NOT IsDrumController \{controller = $primary_controller}
					button = LBRB
				endif
			endif
			add_user_control_helper text = qs("ROTATE") button = <button> z = 100000
		endif
		if NOT GotParam \{no_zoom_text}
			add_user_control_helper \{text = qs("ZOOM")
				button = Orange
				z = 100000}
		endif
	endif
endscript

script generic_ui_destroy \{parent_anchor = current_menu_anchor}
	cleanup_cas_menu_handlers
	if ScreenElementExists id = <parent_anchor>
		DestroyScreenElement id = <parent_anchor>
	endif
	if ScreenElementExists \{id = helper_text_anchor}
		DestroyScreenElement \{id = helper_text_anchor}
	endif
	destroy_viewport_ui
	clean_up_user_control_helpers
	destroy_generic_menu
endscript

script ps2_delay_pad_event_registration 
	Wait \{1
		seconds}
	if NOT ScreenElementExists \{id = current_menu}
		return
	endif
	if GotParam \{pad_down_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_down <pad_down_script> params = <pad_down_params>}
			]
		}
	endif
	if GotParam \{pad_up_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_up <pad_up_script> params = <pad_up_params>}
			]
		}
	endif
	if GotParam \{pad_start_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_start <pad_start_script> params = <pad_start_params>}
			]
		}
	endif
	if GotParam \{pad_option2_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_option2 <pad_back_sound>}
				{pad_option2 generic_blocking_execute_script params = {pad_script = <pad_option2_script> pad_params = {container_id = <id> <pad_option2_params>}}}
			]
		}
	endif
	if GotParam \{pad_option_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_option <pad_back_sound>}
				{pad_option generic_blocking_execute_script params = {pad_script = <pad_option_script> pad_params = {container_id = <id> <pad_option_params>}}}
			]
		}
	endif
	if GotParam \{pad_back_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_back <pad_back_sound>}
				{pad_back generic_blocking_execute_script params = {pad_script = <pad_back_script> pad_params = {container_id = <id> <pad_back_params>}}}
			]
			replace_handlers
		}
	endif
endscript

script ps2_add_generic_menu_icon_item_register_events 
	Wait \{1
		seconds}
	if NOT ScreenElementExists id = <id>
		return
	endif
	if GotParam \{pad_choose_script}
		SetScreenElementProps {
			id = <id>
			event_handlers = [
				{pad_choose <pad_choose_sound>}
				{pad_choose generic_blocking_execute_script params = {pad_script = <pad_choose_script> pad_params = {container_id = <id> <pad_choose_params>}}}
			]
		}
	endif
	if GotParam \{pad_square_script}
		SetScreenElementProps {
			id = <id>
			event_handlers = [
				{pad_square <pad_choose_sound>}
				{pad_square generic_blocking_execute_script params = {pad_script = <pad_square_script> pad_params = {container_id = <id> <pad_square_params>}}}
			]
		}
	endif
	if GotParam \{pad_start_script}
		SetScreenElementProps {
			id = <id>
			event_handlers = [
				{pad_start <pad_choose_sound>}
				{pad_start generic_blocking_execute_script params = {pad_script = <pad_start_script> pad_params = {container_id = <id> <pad_start_params>}}}
			]
		}
	endif
endscript
