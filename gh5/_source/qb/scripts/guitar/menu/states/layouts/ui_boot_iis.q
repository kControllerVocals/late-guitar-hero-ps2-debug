attract_disabled = 0
attract_wait_time = 30
invalid_controller_lock = 0

script ui_init_boot_iis 
	reacquirecontrollers
	change \{primary_controller_assigned = 0}
	change \{respond_to_signin_changed = 0}
	soundevent \{event = menu_guitar_lick_sfx}
	unpausegame
endscript

script ui_create_boot_iis 
	clean_up_user_control_helpers
	dumpcompactpoolprofile \{0}
	change \{rich_presence_context = presence_signed_in_2_3_and_4}
	if screenelementexists \{id = current_menu_anchor}
		destroyscreenelement \{id = current_menu_anchor}
	endif
	createscreenelement \{type = containerelement
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
	createscreenelement \{type = spriteelement
		parent = current_menu
		id = bg
		texture = boot_copyright_bg_1
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		just = [
			left
			top
		]
		z_priority = 0}
	createscreenelement \{type = spriteelement
		parent = current_menu
		blend = blend
		id = 0x466a9d75
		texture = 0xd39400bd
		pos = (720.0, 0.0)
		dims = (450.0, 375.0)
		just = [
			left
			top
		]
		z_priority = 0.5
		rot_angle = -4.7
		alpha = 1.0}
	createscreenelement \{type = spriteelement
		parent = current_menu
		blend = add
		id = 0x6ca2d201
		texture = 0xd39400bd
		pos = (720.0, 0.0)
		dims = (450.0, 375.0)
		just = [
			left
			top
		]
		z_priority = 0.6
		rot_angle = -4.7
		alpha = 0.0}
	0x6ca2d201 :obj_spawnscript \{0xa7a510a8
		params = {
			0x4d641ae8
			0xe99089a3 = $0x187899ed
			0xffd05882 = $0xddccbea4
		}}
	createscreenelement \{type = textblockelement
		parent = current_menu
		font = fontgrid_text_a1
		text = qs(0x71da7fc7)
		dims = (450.0, 240.0)
		pos = (75.0, 225.0)
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
		rot_angle = 8.0
		fit_width = wrap
		fit_height = `scale down if larger`}
	fadetoblack \{off
		time = 0.0
		no_wait}
	if ($attract_disabled = 0)
		runscriptonscreenelement \{ui_boot_iis_attract_wait
			id = current_menu}
	endif
	runscriptonscreenelement \{ui_boot_iis_input
		id = current_menu}
	destroy_loading_screen
endscript

script boot_bg_swap 
	begin
	se_setprops \{alpha = 0
		time = 0}
	wait \{0.25
		seconds}
	se_setprops \{alpha = 1
		time = 0}
	wait \{0.4
		seconds}
	repeat
endscript

script ui_destroy_boot_iis 
	if screenelementexists \{id = current_menu}
		current_menu :die
	endif
	kill_notify_box \{container_id = notify_invalid_device}
endscript

script ui_boot_iis_attract_wait 
	wait_time = ($attract_wait_time)
	begin

	if (<wait_time> = 1)
		wait \{0.5
			seconds
			ignoreslomo}
		obj_killspawnedscript \{name = ui_boot_iis_input}
		setprops \{event_handlers = [
			]
			replace_handlers}
		wait \{0.5
			seconds
			ignoreslomo}
		break
	endif
	wait \{1
		second
		ignoreslomo}
	wait_time = (<wait_time> - 1)
	repeat
	if ($invalid_controller_lock = 1)
		begin
		if ($invalid_controller_lock = 0)
			break
		endif
		wait \{1
			gameframe}
		repeat
	endif
	killspawnedscript \{name = ui_boot_iis_input}
	ui_event \{event = menu_change
		data = {
			state = uistate_boot_attract
		}}
endscript

script ui_boot_iis_input \{button1 = {
		}
		button2 = {
		}}
	get_handlers_for_all_buttons \{event_script = ui_boot_iis_continue}
	begin
	removeparameter \{makes}
	removeparameter \{device_num}
	setprops event_handlers = <event_handlers> replace_handlers
	wait \{1
		gameframe}
	repeat
endscript

script ui_boot_iis_continue 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	if ($invalid_controller_lock = 0)
		stopsoundevent \{menu_guitar_lick_sfx}
		generic_menu_pad_choose_sound
		get_handlers_for_all_buttons
		current_menu :setprops event_handlers = <event_handlers> replace_handlers
		killspawnedscript \{name = ui_boot_iis_input}
		change primary_controller = <device_num>
		ui_event event = menu_replace data = {state = uistate_signin device_num = <device_num> boot = 1}
	endif
endscript
