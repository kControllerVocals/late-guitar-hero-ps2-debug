ui_options_from_submenu = 0

script ui_create_options 
	startrendering
	change \{rich_presence_context = presence_menus}
	change \{respond_to_signin_changed = 1}
	change \{respond_to_signin_changed_func = none}
	change \{top_rockers_enabled = 0}
	change \{memcard_after_func = none}
	update_ingame_controllers controller = ($primary_controller)
	createscreenelement {
		type = descinterface
		desc = 'settings_menu'
		id = current_menu_anchor
		parent = root_window
		just = [center center]
		exclusive_device = ($primary_controller)
	}
	if <id> :desc_resolvealias name = alias_menu_items_text
		assignalias id = <resolved_id> alias = current_menu
		current_menu :se_setprops \{event_handlers = [
				{
					pad_up
					generic_menu_up_or_down_sound
					params = {
						up
					}
				}
				{
					pad_down
					generic_menu_up_or_down_sound
					params = {
						down
					}
				}
				{
					pad_back
					generic_event_back
				}
			]}
		add_menu_frontend_item \{text = qs(0x3e3a98e6)
			choose_state = uistate_options_cheats
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [
				255
				255
				255
				255
			]}
		add_menu_frontend_item {
			text = qs(0x9baf87e5)
			pad_choose_script = menu_choose_band_make_selection
			pad_choose_params = {from_options = 1 device_num = ($primary_controller) event_params = {event = menu_back}}
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [255 255 255 255]
		}
		if NOT current_band_has_band_name
			<item_id> :se_setprops not_focusable rgba = [140 140 140 255]
		endif
		add_menu_frontend_item \{text = qs(0x98846417)
			pad_choose_script = ui_options_continue_to_data_submenu
			pad_choose_params = {
				is_popup
			}
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [
				255
				255
				255
				255
			]}
		add_menu_frontend_item \{text = qs(0x550b8c8e)
			choose_state = uistate_options_calibrate_lag
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [
				255
				255
				255
				255
			]}
		add_menu_frontend_item \{text = qs(0xa0345d1c)
			choose_state = uistate_options_audio
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [
				255
				255
				255
				255
			]}
		add_menu_frontend_item \{text = qs(0x7305a834)
			pad_choose_script = ui_options_continue_to_settings_submenu
			pad_choose_params = {
				is_popup
			}
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [
				255
				255
				255
				255
			]}
		add_menu_frontend_item \{text = qs(0x9560fb22)
			choose_state = uistate_bonus_videos
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [
				255
				255
				255
				255
			]}
		if getscreenelementchildren \{id = current_menu}
			getarraysize <children>
			i = 0
			begin
			curr_id = (<children> [<i>])
			<curr_id> :se_setprops {
				tags = {index = <i>}
			}
			i = (<i> + 1)
			repeat <array_size>
		endif
		current_menu_anchor :obj_spawnscriptnow \{0x44f4a908}
	endif
	clean_up_user_control_helpers
	menu_finish
endscript

script ui_return_options 
	clean_up_user_control_helpers
	menu_finish
endscript

script ui_options_anim_in 
	if NOT ($ui_options_from_submenu)
		menu_transition_in \{menu = current_menu_anchor}
	else
		change \{ui_options_from_submenu = 0}
	endif
	current_menu_anchor :se_setprops \{highlight_alpha = 1}
	current_menu :obj_spawnscript \{highlight_motion}
endscript

script ui_options_anim_out 
	menu_transition_out \{menu = current_menu_anchor}
endscript

script ui_destroy_options 
	killspawnedscript \{name = 0x44f4a908}
	if screenelementexists \{id = current_menu_anchor}
		destroyscreenelement \{id = current_menu_anchor}
	endif
endscript

script ui_options_get_controller_type controller = ($primary_controller)
	type = guitar
	text = qs(0x9504b94a)
	if NOT isguitarcontroller controller = <controller>
		type = drums
		text = qs(0xcf488ba5)
		if NOT isdrumcontroller controller = <controller>
			type = vocals
			text = qs(0xae6af654)
		endif
	endif
	return {type = <type> text = <text>}
endscript

script 0x44f4a908 
	if desc_resolvealias \{name = 0xb8c758ee
			param = 0xccfaaa11}
		<0xccfaaa11> :obj_spawnscript 0xa7a510a8 params = {0x4d641ae8 0xe99089a3 = $0x187899ed 0xffd05882 = $0xddccbea4}
	else

	endif
endscript

script ui_options_set_settings 
	if screenelementexists \{id = current_menu}
		getglobaltags \{user_options}
		current_menu :settags {user_options = <...>}
	endif
endscript

script ui_options_check_settings 
	removeparameter \{event}
	removeparameter \{controller}
	if NOT ($playing_song)
		if checkforsignin local controller_index = <device_num>
			removeparameter \{device_num}
			if screenelementexists \{id = current_menu}
				getglobaltags \{user_options}
				new_user_options = <...>
				current_menu :getsingletag \{user_options}
				if gotparam \{user_options}
					if NOT comparestructs struct1 = <new_user_options> struct2 = <user_options>
						generic_menu_pad_back_sound
						spawnscriptnow \{ui_memcard_autosave_replace}
						return
					endif
				endif
			endif
		endif
	endif
	generic_event_back
endscript

script ui_options_focus 
	obj_getid
	gettags
	se_setprops rgba = (($default_color_scheme).text_focus_color)
	if current_menu_anchor :desc_resolvealias \{name = alias_highlight}
		wait \{2
			gameframe}
		<objid> :se_getparentid
		<parent_id> :se_getprops
		hscale = ((1.0, 0.0).<scale>)
		<parent_id> :se_getparentid
		<parent_id> :se_getprops
		<resolved_id> :se_setprops rot_angle = <rot_angle>
		getscreenelementdims id = <objid>
		<width> = (<width> * <hscale>)
		<0xc446b6d3> = 10
		scale = (((1.0, 0.0) * ((<width> + (<0xc446b6d3> * 2)) / 256.0)) + (0.0, 1.5))
		getscreenelementposition id = <objid> summed
		<screenelementpos> = (<screenelementpos> - ((1.0, 0.0) * <0xc446b6d3>))
		<resolved_id> :se_setprops pos = {absolute <screenelementpos>} scale = <scale>
		<resolved_id> :se_waitprops
		getscreenelementposition id = <objid> summed
		<screenelementpos> = (<screenelementpos> - ((1.0, 0.0) * <0xc446b6d3>))
		<resolved_id> :se_setprops pos = {absolute (<screenelementpos> + (0.0, -10.0))} time = 0.05
		<resolved_id> :se_waitprops
		getscreenelementposition id = <objid> summed
		<screenelementpos> = (<screenelementpos> - ((1.0, 0.0) * <0xc446b6d3>))
		<resolved_id> :se_setprops pos = {absolute <screenelementpos>} scale = <scale> time = 0.05
		<resolved_id> :se_waitprops
	endif
endscript

script ui_options_unfocus 
	se_setprops rgba = (($default_color_scheme).text_color)
endscript

script ui_options_continue_to_settings_submenu 
	if is_ui_event_running
		return \{false}
	endif
	current_menu :obj_killspawnedscript \{name = highlight_motion}
	ui_event_block event = menu_change data = {state = uistate_options_settings <...>}
endscript

script ui_options_continue_to_data_submenu 
	if is_ui_event_running
		return \{false}
	endif
	current_menu :obj_killspawnedscript \{name = highlight_motion}
	ui_event_block event = menu_change data = {state = uistate_options_data <...>}
endscript
