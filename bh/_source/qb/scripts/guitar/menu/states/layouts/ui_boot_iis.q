attract_disabled = 0
attract_wait_time = 30
invalid_controller_lock = 0

script ui_init_boot_iis 
	ReAcquireControllers
	change \{primary_controller_assigned = 0}
	change \{respond_to_signin_changed = 0}
	SoundEvent \{event = Menu_Guitar_Lick_SFX}
	UnPauseGame
endscript

script ui_create_boot_iis 
	clean_up_user_control_helpers
	dumpcompactpoolprofile \{0}
	change \{rich_presence_context = presence_signed_in_2_3_and_4}
	if ScreenElementExists \{id = current_menu_anchor}
		DestroyScreenElement \{id = current_menu_anchor}
	endif
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = current_menu
		pos = (0.0, 0.0)
		just = [
			left
			center
		]
		z_priority = 0
		event_handlers = [
		]}
	CreateScreenElement \{type = SpriteElement
		parent = current_menu
		id = bG
		texture = boot_copyright_bg_1
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		just = [
			left
			top
		]
		z_priority = 0}
	CreateScreenElement \{type = SpriteElement
		parent = current_menu
		id = speakers
		texture = pressanybutton_speakers
		pos = (1280.0, 720.0)
		dims = (812.0, 512.0)
		just = [
			right
			bottom
		]
		z_priority = 1.0
		rot_angle = 0.0
		alpha = 1.0}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = top_gradient
		pos = (0.0, 95.0)
		just = [
			left
			center
		]
		z_priority = 0
		event_handlers = [
		]}
	CreateScreenElement \{type = SpriteElement
		parent = top_gradient
		blend = blend
		id = top_gradient_a
		texture = pressanybutton_gradient
		pos = (0.0, 0.0)
		dims = (1280.0, 20.0)
		just = [
			left
			center
		]
		z_priority = 0.6
		rot_angle = 0.0
		alpha = 0.7}
	CreateScreenElement \{type = SpriteElement
		parent = top_gradient
		blend = blend
		id = top_gradient_b
		texture = pressanybutton_gradient
		pos = (-1280.0, 0.0)
		dims = (1280.0, 20.0)
		just = [
			left
			center
		]
		z_priority = 0.6
		rot_angle = 0.0
		alpha = 0.7}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = bottom_gradient
		pos = (0.0, 630.0)
		just = [
			left
			center
		]
		z_priority = 0
		event_handlers = [
		]}
	CreateScreenElement \{type = SpriteElement
		parent = bottom_gradient
		blend = blend
		id = bottom_gradient_a
		texture = pressanybutton_gradient
		pos = (0.0, 0.0)
		dims = (1280.0, 20.0)
		just = [
			left
			center
		]
		z_priority = 0.6
		rot_angle = 0.0
		alpha = 0.7}
	CreateScreenElement \{type = SpriteElement
		parent = bottom_gradient
		blend = blend
		id = bottom_gradient_b
		texture = pressanybutton_gradient
		pos = (-1280.0, 0.0)
		dims = (1280.0, 20.0)
		just = [
			left
			center
		]
		z_priority = 0.6
		rot_angle = 0.0
		alpha = 0.7}
	gradient_width = 1280
	gradient_move_time = 5
	top_gradient :obj_spawnscript move_gradient params = {width = <gradient_width> move_time = <gradient_move_time>}
	bottom_gradient :obj_spawnscript move_gradient params = {width = <gradient_width> move_time = <gradient_move_time>}
	CreateScreenElement \{type = TextBlockElement
		parent = current_menu
		font = fontgrid_text_a1
		text = qs("PRESS ANY BUTTON TO ROCK...")
		dims = (450.0, 240.0)
		pos = (580.0, 105.0)
		just = [
			left
			top
		]
		internal_just = [
			center
			center
		]
		rgba = [
			220
			220
			220
			255
		]
		scale = 0.9
		rot_angle = 0.0
		fit_width = wrap
		fit_height = `scale down if larger`}
	fadetoblack \{off
		time = 0.0
		no_wait}
	if ($attract_disabled = 0)
		RunScriptOnScreenElement \{ui_boot_iis_attract_wait
			id = current_menu}
	endif
	RunScriptOnScreenElement \{ui_boot_iis_input
		id = current_menu}
	destroy_loading_screen
endscript

script ui_destroy_boot_iis 
	if ScreenElementExists \{id = current_menu}
		current_menu :Die
	endif
	if ScreenElementExists \{id = top_gradient}
		top_gradient :Die
	endif
	if ScreenElementExists \{id = bottom_gradient}
		bottom_gradient :Die
	endif
	kill_notify_box \{container_id = notify_invalid_device}
endscript

script ui_boot_iis_attract_wait 
	wait_time = ($attract_wait_time)
	begin

	if (<wait_time> = 1)
		Wait \{0.5
			seconds
			ignoreslomo}
		Obj_KillSpawnedScript \{name = ui_boot_iis_input}
		SetProps \{event_handlers = [
			]
			replace_handlers}
		Wait \{0.5
			seconds
			ignoreslomo}
		break
	endif
	Wait \{1
		second
		ignoreslomo}
	wait_time = (<wait_time> - 1)
	repeat
	if ($invalid_controller_lock = 1)
		begin
		if ($invalid_controller_lock = 0)
			break
		endif
		Wait \{1
			gameframe}
		repeat
	endif
	KillSpawnedScript \{name = ui_boot_iis_input}
	ui_event \{event = menu_change
		data = {
			state = UIstate_boot_attract
		}}
endscript

script move_gradient 
	begin
	SE_SetProps pos = {((1.0, 0.0) * <width>) relative} time = (<move_time> * 0.5)
	SE_WaitProps
	SE_SetProps pos = {((-1.0, 0.0) * <width>) relative}
	repeat
endscript

script ui_boot_iis_input \{button1 = {
		}
		button2 = {
		}}
	get_handlers_for_all_buttons \{event_script = ui_boot_iis_continue}
	begin
	RemoveParameter \{makes}
	RemoveParameter \{device_num}
	SetProps event_handlers = <event_handlers> replace_handlers
	Wait \{1
		gameframe}
	repeat
endscript

script ui_boot_iis_continue 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	if ($invalid_controller_lock = 0)
		StopSoundEvent \{Menu_Guitar_Lick_SFX}
		generic_menu_pad_choose_sound
		get_handlers_for_all_buttons
		current_menu :SetProps event_handlers = <event_handlers> replace_handlers
		KillSpawnedScript \{name = ui_boot_iis_input}
		change primary_controller = <device_num>
		ui_event event = menu_replace data = {state = uistate_signin device_num = <device_num> boot = 1}
	endif
endscript
