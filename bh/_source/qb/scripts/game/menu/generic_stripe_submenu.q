
script make_generic_stripe_submenu {
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
	if ScreenElementExists \{id = current_submenu_anchor}
		DestroyScreenElement \{id = current_submenu_anchor}
	endif
	CreateScreenElement {
		type = DescInterface
		parent = root_window
		id = current_submenu_anchor
		desc = 'generic_stripe_submenu'
		just = [center center]
		exclusive_device = <exclusive_device>
	}
	<stripe_sub_id> = <id>
	if <stripe_sub_id> :Desc_ResolveAlias name = alias_submenu
		AssignAlias id = <resolved_id> alias = current_submenu
	else

	endif
	if NOT <stripe_sub_id> :Desc_ResolveAlias name = alias_submenu_window param = submenu_window_id

	endif
	if NOT <stripe_sub_id> :Desc_ResolveAlias name = alias_submenu_up param = submenu_up_id

	endif
	if NOT <stripe_sub_id> :Desc_ResolveAlias name = alias_submenu_down param = submenu_down_id

	endif
	if GotParam \{option_arrows}
		current_submenu :SetTags \{smooth_morph_time = 0.1}
		current_submenu :SE_SetProps {
			event_handlers = [
				{pad_up generic_stripe_menu_scroll params = {arrow_id = <submenu_up_id> up}}
				{pad_up SmoothMenuScroll params = {dir = -1 isVertical = true}}
				{pad_down generic_stripe_menu_scroll params = {arrow_id = <submenu_down_id> down}}
				{pad_down SmoothMenuScroll params = {dir = 1 isVertical = true}}
				{pad_back <pad_back_script> params = <pad_back_params>}
			]
			loop_view = true
			loop_center = true
		}
	else
		SetScreenElementProps {id = <submenu_up_id> alpha = 0.0}
		SetScreenElementProps {id = <submenu_down_id> alpha = 0.0}
		GetScreenElementDims id = <submenu_window_id>
		dims = ((<width> * (1.0, 0.0)) + (0.0, 512.0))
		SetScreenElementProps {id = <submenu_window_id> dims = <dims>}
		current_submenu :SE_SetProps {
			event_handlers = [
				{pad_up generic_menu_up_or_down_sound params = {up}}
				{pad_down generic_menu_up_or_down_sound params = {down}}
				{pad_back <pad_back_script> params = <pad_back_params>}
			]
		}
	endif
	return \{VMenu = current_submenu_anchor}
endscript

script destroy_generic_stripe_submenu 
	if ScreenElementExists \{id = current_submenu_anchor}
		DestroyScreenElement \{id = current_submenu_anchor}
	endif
	clean_up_user_control_helpers
endscript
