
script make_generic_stripe_menu {
		pad_back_script = generic_event_back
		exclusive_device = ($primary_controller)
	}
	set_focus_color
	set_unfocus_color
	if GotParam \{use_all_controllers}
		RemoveParameter \{exclusive_device}
	else
		add_gamertag_helper exclusive_device = <exclusive_device>
	endif
	CreateScreenElement {
		type = DescInterface
		parent = root_window
		id = current_menu_anchor
		desc = 'generic_stripe_menu'
		just = [center center]
		exclusive_device = <exclusive_device>
	}
	<stripe_id> = <id>
	if <stripe_id> :Desc_ResolveAlias name = alias_menu
		AssignAlias id = <resolved_id> alias = current_menu
	else

	endif
	if NOT <stripe_id> :Desc_ResolveAlias name = alias_menu_window param = menu_window_id

	endif
	if NOT <stripe_id> :Desc_ResolveAlias name = alias_menu_up param = menu_up_id

	endif
	if NOT <stripe_id> :Desc_ResolveAlias name = alias_menu_down param = menu_down_id

	endif
	if GotParam \{title}
		<stripe_id> :SE_SetProps menu_title = <title>
	endif
	CreateScreenElement {
		type = SpriteElement
		id = stripe_menu_background_id
		parent = <id>
		rgba = [255 255 255 255]
		pos = (640.0, 360.0)
		just = [center center]
		dims = (1280.0, 720.0)
		z_priority = 9.0
		texture = song_summary_bg
	}
	if GotParam \{option_arrows}
		current_menu :SetTags \{smooth_morph_time = 0.1}
		current_menu :SE_SetProps {
			event_handlers = [
				{pad_up generic_stripe_menu_scroll params = {arrow_id = <menu_up_id> up}}
				{pad_up SmoothMenuScroll params = {dir = -1 isVertical = true}}
				{pad_down generic_stripe_menu_scroll params = {arrow_id = <menu_down_id> down}}
				{pad_down SmoothMenuScroll params = {dir = 1 isVertical = true}}
				{pad_back <pad_back_script> params = <pad_back_params>}
			]
			loop_view = true
			loop_center = true
		}
	else
		SetScreenElementProps {id = <menu_up_id> alpha = 0.0}
		SetScreenElementProps {id = <menu_down_id> alpha = 0.0}
		GetScreenElementDims id = <menu_window_id>
		dims = ((<width> * (1.0, 0.0)) + (0.0, 512.0))
		SetScreenElementProps {id = <menu_window_id> dims = <dims>}
		current_menu :SE_SetProps {
			event_handlers = [
				{pad_up generic_menu_up_or_down_sound params = {up}}
				{pad_down generic_menu_up_or_down_sound params = {down}}
				{pad_back <pad_back_script> params = <pad_back_params>}
			]
		}
	endif
	return \{window_id = current_menu_anchor
		desc_id = current_menu_anchor}
endscript

script add_generic_stripe_menu_item {
		parent = current_menu
		focus_rgba = ($menu_focus_color)
		unfocus_rgba = ($menu_unfocus_color)
		inactive_rgba = [64 64 64 255]
	}

	if GotParam \{option_left}
		just = [left center]
	else
		just = [right center]
	endif
	has_texture = false
	if GotParam \{option_texture}
		has_texture = true
	elseif GotParam \{overlay_texture}
		has_texture = true
	elseif GotParam \{texture}
		has_texture = true
	elseif GotParam \{background_texture}
		has_texture = true
	endif
	if GotParam \{option_checkbox}
		has_texture = true
		overlay_texture = Options_Controller_Check
		texture = Options_Controller_X
	endif
	if (<has_texture> = true)
		if GotParam \{option_left}
			desc = 'menurow_ico_txt_desc'
		else
			desc = 'menurow_txt_ico_desc'
		endif
		CreateScreenElement {
			type = DescInterface
			parent = <parent>
			desc = <desc>
			autoSizeDims = true
			menurow_just = <just>
			menurow_internal_just = <just>
			menurow_txt_item_text = <text>
			menurow_txt_item_font = fontgrid_title_a1
			menurow_txt_item_rgba = <unfocus_rgba>
		}
		if GotParam \{overlay_texture}
			<id> :SE_SetProps {menurow_ico_overlay_texture = <overlay_texture>}
		else
			<id> :SE_SetProps {menurow_ico_overlay_alpha = 0.0}
		endif
		if GotParam \{texture}
			<id> :SE_SetProps {menurow_ico_item_texture = <texture>}
		else
			<id> :SE_SetProps {menurow_ico_item_alpha = 0.0}
		endif
		if GotParam \{background_texture}
			<id> :SE_SetProps {menurow_ico_background_texture = <background_texture>}
		else
			<id> :SE_SetProps {menurow_ico_background_alpha = 0.0}
		endif
	else
		CreateScreenElement {
			type = DescInterface
			parent = <parent>
			desc = 'menurow_txt_desc'
			autoSizeDims = true
			menurow_just = <just>
			menurow_internal_just = <just>
			menurow_txt_item_text = <text>
			menurow_txt_item_font = fontgrid_title_a1
			menurow_txt_item_rgba = <unfocus_rgba>
		}
	endif
	if GotParam \{blank_entry}
		<id> :SE_SetProps {
			not_focusable
		}
	elseif GotParam \{not_focusable}
		<id> :SE_SetProps {
			not_focusable
			menurow_txt_item_rgba = <inactive_rgba>
		}
	else
		if GotParam \{helper_text}
			<id> :SE_SetProps menu_help = <helper_text>
		endif
		array = []
		if GotParam \{additional_focus_script}
			AddArrayElement array = <array> element = {
				focus
				generic_stripe_menu_focus
				params = {
					focus_rgba = <focus_rgba>
					additional_focus_script = <additional_focus_script>
					additional_focus_params = <additional_focus_params>
				}
			}
		else
			AddArrayElement array = <array> element = {
				focus
				generic_stripe_menu_focus
				params = {focus_rgba = <focus_rgba>}
			}
		endif
		if GotParam \{additional_unfocus_script}
			AddArrayElement array = <array> element = {
				unfocus
				generic_stripe_menu_unfocus
				params = {
					unfocus_rgba = <unfocus_rgba>
					additional_unfocus_script = <additional_unfocus_script>
					additional_unfocus_params = <additional_unfocus_params>
				}
			}
		else
			AddArrayElement array = <array> element = {
				unfocus
				generic_stripe_menu_unfocus
				params = {unfocus_rgba = <unfocus_rgba>}
			}
		endif
		if NOT (GotParam option_checkbox)
			if (GotParam pad_choose_sound)
				AddArrayElement array = <array> element = {pad_choose <pad_choose_sound>}
			else
				AddArrayElement array = <array> element = {pad_choose generic_menu_pad_choose_sound}
			endif
		endif
		if GotParam \{choose_state}
			AddArrayElement array = <array> element = {
				pad_choose
				generic_event_choose
				params = {state = <choose_state> data = {<choose_state_data>}}
			}
		elseif GotParam \{pad_choose_script}
			AddArrayElement array = <array> element = {
				pad_choose
				<pad_choose_script>
				params = <pad_choose_params>
			}
		endif
		if GotParam \{back_state}
			AddArrayElement array = <array> element = {
				pad_back generic_event_back params = {state = <back_state>}
			}
		elseif GotParam \{pad_back_script}
			AddArrayElement array = <array> element = {pad_back <pad_back_script>}
		endif
		<id> :SE_SetProps event_handlers = <array>
	endif
	return item_container_id = <id> item_id = <id>
endscript

script generic_stripe_menu_focus time = 0.05 grow_scale = 1.5 {
		focus_rgba = ($menu_focus_color)
	}
	if NOT GotParam \{id}
		Obj_GetID
		<id> = <ObjID>
	endif
	<id> :GetTags
	if GotParam \{helper_text}
		<id> :SE_SetProps menu_help = <helper_text>
	endif
	<id> :SE_SetProps {
		menurow_scale = <grow_scale>
		menurow_txt_item_font = fontgrid_title_a1
		menurow_txt_item_rgba = <focus_rgba>
		motion = ease_in
		time = <time>
	}
	if GotParam \{additional_focus_script}
		<additional_focus_script> <additional_focus_params>
	endif
endscript

script generic_stripe_menu_unfocus time = 0.05 {
		unfocus_rgba = ($menu_unfocus_color)
	}
	if NOT GotParam \{id}
		Obj_GetID
		<id> = <ObjID>
	endif
	<id> :SE_SetProps {
		menurow_scale = 1.0
		menurow_txt_item_font = fontgrid_title_a1
		menurow_txt_item_rgba = <unfocus_rgba>
		motion = ease_in
		time = <time>
	}
	if GotParam \{additional_unfocus_script}
		<additional_unfocus_script> <additional_unfocus_params>
	endif
endscript

script generic_stripe_menu_scroll 

	if GotParam \{down}
		generic_menu_up_or_down_sound \{down}
		<arrow_id> :obj_spawnscript stripe_menu_scroll_glow
		<arrow_id> :obj_spawnscript stripe_menu_arrow_pulse params = {down}
	else
		generic_menu_up_or_down_sound \{up}
		<arrow_id> :obj_spawnscript stripe_menu_scroll_glow
		<arrow_id> :obj_spawnscript stripe_menu_arrow_pulse
	endif
endscript

script stripe_menu_arrow_pulse 
	Obj_GetID
	<ObjID> :SE_SetProps hiddenLocal = true
	CreateScreenElement {
		type = SpriteElement
		parent = <ObjID>
		texture = Dropdown_Arrow
		dims = (40.0, 40.0)
		pos = (20.0, 15.0)
		just = [center center]
		rgba = [225 , 225 , 225 , 200]
		z_priority = 112
	}
	if GotParam \{down}
		<id> :SE_SetProps flip_h
		<id> :SE_SetProps pos = {(0.0, 9.0) relative}
	endif
	<id> :SE_SetProps scale = 1.3 time = 0.01 relative_scale
	<id> :SE_WaitProps
	<id> :SE_SetProps scale = 1.0 time = 0.1 relative_scale
	<id> :SE_WaitProps
	<ObjID> :SE_SetProps hiddenLocal = false
	DestroyScreenElement id = <id>
endscript

script stripe_menu_scroll_glow 
	Obj_GetID
	CreateScreenElement {
		type = SpriteElement
		parent = <ObjID>
		texture = circle_gradient_64
		dims = (64.0, 64.0)
		pos = (20.0, 15.0)
		rgba = [255 215 0 255]
		just = [center center]
		z_priority = 100
		alpha = 0.2
		blend = Add
	}
	<id> :SE_SetProps scale = 1.2 relative_scale
	<id> :SE_SetProps scale = (Random (@ 2.0 @ 2.5 @ 3.0 )) alpha = 0.0 time = 0.2 relative_scale motion = ease_out
	<id> :SE_WaitProps
	DestroyScreenElement id = <id>
endscript
