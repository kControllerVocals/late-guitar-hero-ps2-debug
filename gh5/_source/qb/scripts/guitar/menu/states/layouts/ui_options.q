ui_options_from_submenu = 0

script ui_create_options 
	startrendering
	change \{rich_presence_context = presence_menus}
	change \{respond_to_signin_changed = 1}
	change \{respond_to_signin_changed_func = none}
	change \{top_rockers_enabled = 0}
	change \{memcard_after_func = none}
	update_ingame_controllers controller = ($primary_controller)
	CreateScreenElement {
		type = DescInterface
		desc = 'settings_menu'
		id = current_menu_anchor
		parent = root_window
		just = [center center]
		exclusive_device = ($primary_controller)
	}
	if <id> :Desc_ResolveAlias name = alias_menu_items_text
		AssignAlias id = <resolved_id> alias = current_menu
		current_menu :SE_SetProps \{event_handlers = [
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
		add_menu_frontend_item \{text = qs("CHEATS")
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
			text = qs("BAND INFO")
			pad_choose_script = menu_choose_band_make_selection
			pad_choose_params = {from_options = 1 device_num = ($primary_controller) event_params = {event = menu_back}}
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [255 255 255 255]
		}
		if NOT current_band_has_band_name
			<item_id> :SE_SetProps not_focusable rgba = [140 140 140 255]
		endif
		add_menu_frontend_item \{text = qs("SAVE/LOAD")
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
		add_menu_frontend_item \{text = qs("CALIBRATE LAG")
			choose_state = UIstate_options_calibrate_lag
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [
				255
				255
				255
				255
			]}
		add_menu_frontend_item \{text = qs("AUDIO MIXER")
			choose_state = uistate_options_audio
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [
				255
				255
				255
				255
			]}
		add_menu_frontend_item \{text = qs("FUNCTIONAL OPTIONS")
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
		add_menu_frontend_item \{text = qs("VIDEOS")
			choose_state = uistate_bonus_videos
			focus_script = ui_options_focus
			unfocus_script = ui_options_unfocus
			rgba = [
				255
				255
				255
				255
			]}
		if GetScreenElementChildren \{id = current_menu}
			GetArraySize <children>
			i = 0
			begin
			curr_id = (<children> [<i>])
			<curr_id> :SE_SetProps {
				tags = {index = <i>}
			}
			i = (<i> + 1)
			repeat <array_size>
		endif
		current_menu_anchor :Obj_SpawnScriptNow \{GH5_logo_anim}
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
	current_menu_anchor :SE_SetProps \{highlight_alpha = 1}
	current_menu :obj_spawnscript \{highlight_motion}
endscript

script ui_options_anim_out 
	menu_transition_out \{menu = current_menu_anchor}
endscript

script ui_destroy_options 
	KillSpawnedScript \{name = GH5_logo_anim}
	if ScreenElementExists \{id = current_menu_anchor}
		DestroyScreenElement \{id = current_menu_anchor}
	endif
endscript

script ui_options_get_controller_type controller = ($primary_controller)
	type = guitar
	text = qs("GUITAR")
	if NOT IsGuitarController controller = <controller>
		type = Drums
		text = qs("DRUM")
		if NOT IsDrumController controller = <controller>
			type = Vocals
			text = qs("VOCAL")
		endif
	endif
	return {type = <type> text = <text>}
endscript

script GH5_logo_anim 
	if Desc_ResolveAlias \{name = alias_GH5_logo_glow
			param = GH5_logo_glow_id}
		<GH5_logo_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
endscript

script ui_options_set_settings 
	if ScreenElementExists \{id = current_menu}
		GetGlobalTags \{user_options}
		current_menu :SetTags {user_options = <...>}
	endif
endscript

script ui_options_check_settings 
	RemoveParameter \{event}
	RemoveParameter \{controller}
	if NOT ($playing_song)
		if CheckForSignIn local controller_index = <device_num>
			RemoveParameter \{device_num}
			if ScreenElementExists \{id = current_menu}
				GetGlobalTags \{user_options}
				new_user_options = <...>
				current_menu :GetSingleTag \{user_options}
				if GotParam \{user_options}
					if NOT CompareStructs struct1 = <new_user_options> struct2 = <user_options>
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
	Obj_GetID
	GetTags
	SE_SetProps rgba = (($default_color_scheme).text_focus_color)
	if current_menu_anchor :Desc_ResolveAlias \{name = alias_highlight}
		Wait \{2
			gameframe}
		<ObjID> :SE_GetParentId
		<parent_id> :SE_GetProps
		hscale = ((1.0, 0.0).<scale>)
		<parent_id> :SE_GetParentId
		<parent_id> :SE_GetProps
		<resolved_id> :SE_SetProps rot_angle = <rot_angle>
		GetScreenElementDims id = <ObjID>
		<width> = (<width> * <hscale>)
		<extend> = 10
		scale = (((1.0, 0.0) * ((<width> + (<extend> * 2)) / 256.0)) + (0.0, 1.5))
		GetScreenElementPosition id = <ObjID> summed
		<screenelementpos> = (<screenelementpos> - ((1.0, 0.0) * <extend>))
		<resolved_id> :SE_SetProps pos = {absolute <screenelementpos>} scale = <scale>
		<resolved_id> :SE_WaitProps
		GetScreenElementPosition id = <ObjID> summed
		<screenelementpos> = (<screenelementpos> - ((1.0, 0.0) * <extend>))
		<resolved_id> :SE_SetProps pos = {absolute (<screenelementpos> + (0.0, -10.0))} time = 0.05
		<resolved_id> :SE_WaitProps
		GetScreenElementPosition id = <ObjID> summed
		<screenelementpos> = (<screenelementpos> - ((1.0, 0.0) * <extend>))
		<resolved_id> :SE_SetProps pos = {absolute <screenelementpos>} scale = <scale> time = 0.05
		<resolved_id> :SE_WaitProps
	endif
endscript

script ui_options_unfocus 
	SE_SetProps rgba = (($default_color_scheme).text_color)
endscript

script ui_options_continue_to_settings_submenu 
	if Is_ui_event_running
		return \{false}
	endif
	current_menu :Obj_KillSpawnedScript \{name = highlight_motion}
	ui_event_block event = menu_change data = {state = uistate_options_settings <...>}
endscript

script ui_options_continue_to_data_submenu 
	if Is_ui_event_running
		return \{false}
	endif
	current_menu :Obj_KillSpawnedScript \{name = highlight_motion}
	ui_event_block event = menu_change data = {state = uistate_options_data <...>}
endscript
