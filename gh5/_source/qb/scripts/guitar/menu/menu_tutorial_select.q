
script create_tutorial_select_menu 
	change \{rich_presence_context = presence_menus}
	if ScreenElementExists \{id = dialog_box_container}
		destroy_dialog_box
	endif
	if ((<allowances> = drum) || (<allowances> = rb_drum))
		if isRBDrum \{controller = $primary_controller}
			create_dialog_box \{no_background
				heading_text = qs("DRUMS")
				body_text = qs("You must use an Official Guitar Hero drum controller to play the drum tutorials.")
				options = [
					{
						func = tutorials_event_back
						text = qs("GO BACK")
						no_sound
					}
				]}
			return
		endif
	endif
	if (<allowances> = not_specific)
		create_dialog_box \{no_background
			heading_text = qs(0x8bcc0ba3)
			body_text = qs(0x8ca563b3)
			options = [
				{
					func = tutorials_event_back
					text = qs("GO BACK")
					no_sound
				}
			]}
		return
	endif
	make_generic_menu \{title = qs("TUTORIALS")
		pad_back_script = tutorials_event_back
		vmenu_id = tutorial_select_menu}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	generic_menu :SE_SetProps \{vmenu_spacing_between = -10}
	if generic_menu :Desc_ResolveAlias \{name = alias_generic_menu_smenu
			param = generic_smenu}
		<generic_smenu> :SetTags treat_not_focusable_as_header
		<generic_smenu> :SE_SetProps pos = {relative (20.0, 0.0)}
	endif
	GetArraySize \{$tutorial_lessons}
	<total_size> = <array_size>
	<i> = 0
	begin
	<lessons> = ($tutorial_lessons [<i>])
	ForEachIn <lessons> do = add_lesson_menu_item params = {allowances = <allowances> lesson = <i>}
	<i> = (<i> + 1)
	repeat <total_size>
	menu_finish
	LaunchEvent \{type = focus
		target = current_menu}
	current_menu :Obj_SpawnScriptNow menu_tutorial_select_check_disconnected_controllers params = {allowances = <allowances>}
endscript

script menu_tutorial_select_check_disconnected_controllers 
	<my_allowances> = <allowances>
	begin
	check_tutorial_allowances
	if NOT (<my_allowances> = <allowances>)
		destroy_tutorial_select_menu
		create_tutorial_select_menu allowances = <allowances>
		return
	endif
	Wait \{10
		gameframes}
	repeat
endscript

script destroy_tutorial_select_menu 

	if ScreenElementExists \{id = current_menu}
		LaunchEvent \{type = unfocus
			target = current_menu}
	endif
	if ScreenElementExists \{id = dialog_box_container}
		destroy_dialog_box
	endif
	generic_ui_destroy
	destroy_generic_menu
	clean_up_user_control_helpers
endscript
tutorial_lessons = [
	$guitar_lessons
	$drum_lessons
	$vocals_lessons
	$band_lessons
]
guitar_lessons = [
	{
		text = qs("GUITAR/BASS:")
		item = 'basic'
		focusable = -1
	}
	{
		text = qs("BASICS")
		item = 'basic'
	}
	{
		text = qs("STAR POWER")
		item = 'star_power'
	}
	{
		text = qs("ADVANCED")
		item = 'advanced_techniques'
	}
	{
		text = qs("NEW FEATURES")
		item = 'new_features'
	}
]
drum_lessons = [
	{
		text = qs("DRUMS:")
		item = 'basic'
		focusable = -1
	}
	{
		text = qs("BASICS")
		item = 'drum_basic'
	}
	{
		text = qs("INTERMEDIATE")
		item = 'drum_int'
	}
]
vocals_lessons = [
	{
		text = qs("OTHER:")
		item = 'basic'
		focusable = -1
	}
	{
		text = qs("VOCALS")
		item = 'vocals'
	}
]
band_lessons = [
	{
		text = qs("BAND")
		item = 'band'
	}
]

script add_lesson_menu_item \{focusable = 1}
	<needs_mic> = 0
	if NOT (<focusable> = -1)
		if (<lesson> = 0)
			if NOT (<allowances> = guitar || <allowances> = all)
				<focusable> = 0
			endif
		elseif (<lesson> = 1)
			if NOT (<allowances> = drum || <allowances> = all)
				<focusable> = 0
			endif
		elseif (<lesson> = 2)
			<needs_mic> = 1
			if NOT (<allowances> = Vocals || <allowances> = all)
				<focusable> = 0
			endif
		elseif (<lesson> = 3)
			if (<allowances> = not_specific)
				<focusable> = 0
			endif
		endif
	endif
	FormatText checksumname = lesson_tag '%i_lesson' i = <item>
	GetGlobalTags \{practice}
	if ((<...>.<lesson_tag>) = complete)
		<icon> = Options_Controller_Check
	else
		<icon> = Options_Controller_X
	endif
	if (<focusable> = 1)
		add_generic_menu_icon_item {
			icon = <icon>
			text = <text>
			pad_choose_script = menu_tutorial_select_choose
			pad_choose_params = {item = <item> needs_mic = <needs_mic>}
		}
		<item_container_id> :SE_SetProps generic_menu_smenu_iconitem_text_pos = {relative (-15.0, 0.0)}
		<item_container_id> :SE_SetProps generic_menu_smenu_iconitem_container_pos = {relative (0.0, -5.0)}
	elseif (<focusable> = 0)
		add_generic_menu_icon_item {
			icon = <icon>
			text = <text>
			not_focusable
		}
		<item_container_id> :SE_SetProps generic_menu_smenu_iconitem_text_pos = {relative (-15.0, 0.0)}
		<item_container_id> :SE_SetProps generic_menu_smenu_iconitem_container_pos = {relative (0.0, -5.0)}
	else
		add_generic_menu_text_item {
			text = <text>
			not_focusable
			header_text
			internal_just = [left center]
		}
		<item_container_id> :SE_SetProps textitem_text_dims = (350.0, 60.0)
		<item_container_id> :SE_SetProps textitem_text_pos = {relative (-20.0, 0.0)}
	endif
endscript

script menu_tutorial_select_choose \{item = basic
		needs_mic = 0}
	if (<needs_mic> = 1)
		ui_get_controller_parts_allowed \{controller = $primary_controller}


		if NOT StructureContains Structure = <allowed> Vocals
			LaunchEvent \{type = unfocus
				target = current_menu}
			if isXenon
				text = qs("You must connect a microphone or Xbox 360 Headset to continue.")
			else
				text = qs("You must plug in a microphone with your controller to continue.")
			endif
			create_dialog_box {
				no_background
				heading_text = qs("WARNING")
				body_text = <text>
				options = [
					{
						func = ui_event
						func_params = {event = menu_refresh}
						text = qs("OK")
					}
				]
			}
			return
		endif
	endif
	FormatText checksumname = tutorial_script 'training_%i_tutorial_script' i = <item>
	change \{rich_presence_context = presence_tutorial}
	set_training_script name = <tutorial_script>
	FormatText checksumname = ps2_tutorial_state 'uistate_play_tutorial_%i' i = <item>
	generic_event_choose state = <ps2_tutorial_state>
endscript

script tutorials_event_back 
	set_loading_screen \{full}
	change \{in_tutorial_mode = 0}
	destroy_band
	destroy_bandname_viewport
	frontend_load_soundcheck
	destroy_loading_screen
	ui_event_get_stack
	i = 0
	begin
	if ((<stack> [<i>].base_name) = 'singleplayer_character_hub')
		create_loading_screen \{destroy_state = 'gig_posters'}
		break
	endif
	i = (<i> + 1)
	repeat <stack_size>
	generic_event_back \{data = {
			pass_to_gigboard = true
		}
		no_sound}
endscript
