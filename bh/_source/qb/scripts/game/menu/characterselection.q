
script make_character_selection_menu {
		pad_back_sound = ui_menu_select_sfx
		pad_back_script = generic_event_back_block
		exclusive_device = ($primary_controller)
	}
	destroy_character_selection_menu
	if GotParam \{use_all_controllers}
		RemoveParameter \{exclusive_device}
		get_all_exclusive_devices
	endif
	if NOT (($menu_over_ride_exclusive_device) = -1)
		exclusive_device = ($menu_over_ride_exclusive_device)
	endif
	CreateScreenElement {
		type = DescInterface
		parent = root_window
		desc = 'character_selection'
		id = character_selection
		exclusive_device = <exclusive_device>
	}
	if character_selection :Desc_ResolveAlias \{name = alias_character_selection_window
			param = character_selection_parent}
		menu_pos = (457.0, 410.0)
		make_generic_barrel_menu {
			centered = 1
			pos = <menu_pos>
			max_expansion = 3
			scale = 0.78
			pad_back_script = <pad_back_script>
			pad_back_params = <pad_back_params>
		}
		AssignAlias id = <vmenu_id> alias = current_menu
		if GotParam \{vmenu_alias}
			AssignAlias id = generic_barrel_menu alias = <vmenu_alias>
		endif
	else

	endif
	if character_selection :Desc_ResolveAlias \{name = alias_character_selection_window
			param = character_selection_window}
		SetScreenElementProps id = <character_selection_window> allow_child_rotate = true
		AssignAlias id = <character_selection_window> alias = character_selection_bio_window
	else

	endif
	if NOT CD
		SetScreenElementProps \{id = current_menu
			event_handlers = [
				{
					pad_alt2
					cas_toggle_free_cam
				}
			]}
	endif
endscript

script destroy_character_selection_menu 
	destroy_generic_barrel_menu
	if ScreenElementExists \{id = character_selection}
		DestroyScreenElement \{id = character_selection}
	endif
	cleanup_cas_menu_handlers
	clean_up_user_control_helpers
endscript

script add_character_selection_item \{pad_choose_sound = ui_menu_select_sfx
		parent = character_selection_bio_window}
	random_rot_angle = RandomFloat (-7.0, 7.0)
	if GotParam \{price}
		FormatText TextName = price_text qs("\L$%p") p = <price>
		show_price = 1
	endif
	if ScreenElementExists id = <parent>
		CreateScreenElement {
			type = DescInterface
			parent = <parent>
			desc = 'character_selection_item'
			dims = (64.0, 64.0)
			character_selection_item_bio_text = <bio>
		}
	else

	endif
	if GotParam \{additional_focus_params}
		<additional_focus_params> = {<additional_focus_params> id = <id>}
	endif
	if GotParam \{additional_unfocus_params}
		<additional_unfocus_params> = {<additional_unfocus_params> id = <id>}
	endif
	if GotParam \{not_focusable}
		add_generic_barrel_menu_text_item {
			text = <name>
			pad_choose_script = <pad_choose_script>
			pad_choose_params = <pad_choose_params>
			additional_focus_script = <additional_focus_script>
			additional_focus_params = <additional_focus_params>
			additional_unfocus_script = <additional_unfocus_script>
			additional_unfocus_params = <additional_unfocus_params>
			not_focusable
		}
	else
		add_generic_barrel_menu_text_item {
			text = <name>
			pad_choose_script = <pad_choose_script>
			pad_choose_params = <pad_choose_params>
			additional_focus_script = <additional_focus_script>
			additional_focus_params = <additional_focus_params>
			additional_unfocus_script = <additional_unfocus_script>
			additional_unfocus_params = <additional_unfocus_params>
		}
	endif
	return item_container_id = <item_container_id>
endscript

script character_selection_animate_in 
	spawnscriptnow \{character_selection_animate_in_worker}
endscript

script character_selection_animate_in_worker 
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	if ScreenElementExists \{id = character_selection}
		character_selection :SE_SetProps \{character_selection_control_pos = {
				(0.0, -1000.0)
				relative
			}}
		if character_selection :Desc_ResolveAlias \{name = alias_banner_art_glow
				param = banner_glow_id}
			<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
		else

		endif
		if character_selection :Desc_ResolveAlias \{name = alias_skulls_glow
				param = skulls_glow_id}
			<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
		else

		endif
	else
		return
	endif
	if ScreenElementExists \{id = character_selection}
		character_selection :SE_SetProps \{character_selection_control_pos = {
				(0.0, 1030.0)
				relative
			}
			time = 0.2
			Anim = gentle}
	else
		return
	endif
	Wait \{0.22
		second}
	if ScreenElementExists \{id = character_selection}
		character_selection :SE_SetProps \{character_selection_control_pos = {
				(0.0, -30.0)
				relative
			}
			time = 0.1
			Anim = gentle}
	else
		return
	endif
endscript

script character_selection_focus 
	<id> :SE_SetProps character_selection_item_text_alpha = 1.0
	if GotParam \{additional_focus_script}
		<additional_focus_script> <additional_focus_params>
	endif
endscript

script character_selection_unfocus 
	<id> :SE_SetProps character_selection_item_text_alpha = 0.0
	if GotParam \{additional_unfocus_script}
		<additional_unfocus_script> <additional_unfocus_params>
	endif
endscript
