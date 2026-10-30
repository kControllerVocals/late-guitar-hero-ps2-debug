
script ui_create_helper_dialogue {
		pos = (-190.0, -150.0)
		dims = (800.0, 300.0)
		scale = (1.2, 1.2)
		choose_script = generic_event_back
		back_script = generic_event_back
		font = ($test_menu_font)
		font_rgba = (($uicolorref_palette).gh51_blue_lt.rgba)
		text_buffer = (-230.0, -20.0)
		text_scale = 0.5
		image_buffer = (0.0, 0.0)
		frame_width = 0.4
		frame_height = 0.2
		z_priority = 10000
	}
	pushassetcontext \{context = z_soundcheck}
	if screenelementexists \{id = helper_root}
		destroyscreenelement \{id = helper_root}
	endif
	createscreenelement {
		type = containerelement
		id = helper_root
		parent = root_window
		pos = <pos>
		scale = <scale>
		pos_anchor = [center , center]
		event_handlers = [
			{pad_back <choose_script>}
			{pad_choose <back_script>}
		]
		just = [center , center]
		z_priority = <z_priority>
	}
	if NOT gotparam \{dims}
		getscreenelementdims id = <id>
		dims = (<width> * (1.0, 0.0) + <height> * (0.0, 1.0))
	endif
	createscreenelement {
		type = descinterface
		parent = <id>
		desc = 'helper_box_bg'
		left_dims = (<dims> * (0.5, 1.0))
		left_pos = (0.0, 0.0)
		right_dims = (<dims> * (0.5, 1.0))
		right_pos = (<dims> * (0.495, 0.0))
		just = [left , top]
		pos_anchor = [left , top]
	}
	if ((gotparam text) && (gotparam image))
		image_height = ((<dims>.(0.0, 1.0)) * <frame_height>)
		text_height = ((<dims>.(0.0, 1.0)) - <image_height>)
		width = ((<dims>.(1.0, 0.0)) * (1 - frame_width))
		createscreenelement {
			type = spriteelement
			parent = helper_root
			texture = <image>
			dims = (<width> * (1.0, 0.0) + <image_height> * (0.0, 1.0) - (2 * <image_buffer>))
			pos = <image_buffer>
			z_priority = (<z_priority> + 4)
			just = [left top]
		}
		createscreenelement {
			type = textblockelement
			parent = helper_root
			font = <font>
			rgba = <font_rgba>
			text = <text>
			dims = (<width> * (1.0, 0.0) + <text_height> * (0.0, 1.0))
			z_priority = (<z_priority> + 4)
			just = [center top]
			pos = ((<image_height> * (0.0, 1.0)) + <text_buffer> + (((<dims> * <frame_height>) * 0.5) * (0.0, 1.0)))
			internal_scale = <text_scale>
			fit_width = wrap
			fit_height = `scale down if larger`
		}
	elseif gotparam \{text}
		0x30b38100 = ((<dims>.(1.0, 0.0)) * <frame_width>)
		dim_y = ((<dims>.(0.0, 1.0)) * <frame_height>)
		createscreenelement {
			type = textblockelement
			parent = helper_root
			font = <font>
			rgba = <font_rgba>
			text = <text>
			dims = ((<dims>.(1.0, 0.0) - <0x30b38100>) * (1.0, 0.0) + (<dims>.(0.0, 1.0) - <dim_y>) * (0.0, 1.0))
			z_priority = (<z_priority> + 4)
			just = [left top]
			pos = (<text_buffer> + (<0x30b38100> * (1.0, 0.0) + (0.0, 1.0) * <dim_y>) * 0.5)
			internal_scale = <text_scale>
			internal_just =
			[
				0.0
				0.0
			]
			fit_width = wrap
			fit_height = `scale down if larger`
		}
	elseif gotparam \{image}
		createscreenelement {
			type = spriteelement
			parent = helper_root
			texture = <image>
			dims = (<dims> - (2 * <image_buffer>))
			pos = <image_buffer>
			z_priority = (<z_priority> + 4)
			just = [left top]
		}
	else

	endif
	controller = ($primary_controller)
	if NOT (($menu_over_ride_exclusive_device) = -1)
		controller = ($menu_over_ride_exclusive_device)
	endif
	clean_up_user_control_helpers
	add_user_control_helper text = qs(0x182f0173) button = green z = 100000 all_buttons controller = <controller>
	if gotparam \{life}
		spawnscriptnow helper_dialogue_delayed_kill params = {life = <life>}
	endif
	popassetcontext \{context = z_soundcheck}
endscript

script ui_destroy_helper_dialogue 
	if screenelementexists \{id = helper_root}
		destroyscreenelement \{id = helper_root}
	endif
	if scriptisrunning \{helper_dialogue_delayed_kill}
		killspawnedscript \{name = helper_dialogue_delayed_kill}
	endif
endscript

script helper_dialogue_delayed_kill 
	wait <life> seconds
	generic_event_back
endscript
