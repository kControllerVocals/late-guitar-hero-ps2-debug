
script 0x5e1a3a04 {
		pad_back_script = generic_event_back
		exclusive_device = ($primary_controller)
	}
	set_focus_color
	set_unfocus_color
	if gotparam \{use_all_controllers}
		removeparameter \{exclusive_device}
	else
		add_gamertag_helper exclusive_device = <exclusive_device>
	endif
	createscreenelement {
		type = descinterface
		parent = root_window
		id = current_menu_anchor
		desc = 'generic_stripe_menu'
		just = [center center]
		exclusive_device = <exclusive_device>
	}
	<0xc0e4ef67> = <id>
	if <0xc0e4ef67> :desc_resolvealias name = alias_menu
		assignalias id = <resolved_id> alias = current_menu
	else

	endif
	if NOT <0xc0e4ef67> :desc_resolvealias name = 0x035b354d param = 0x67b68786

	endif
	if NOT <0xc0e4ef67> :desc_resolvealias name = 0xf334fdea param = 0x6b7cf884

	endif
	if NOT <0xc0e4ef67> :desc_resolvealias name = 0x5236112a param = 0x6518488b

	endif
	if gotparam \{title}
		<0xc0e4ef67> :se_setprops menu_title = <title>
	endif
	createscreenelement {
		type = spriteelement
		id = 0x80ac0b16
		parent = <id>
		rgba = [255 255 255 255]
		pos = (640.0, 360.0)
		just = [center center]
		dims = (1280.0, 720.0)
		z_priority = 9.0
		texture = song_summary_bg
	}
	if gotparam \{option_arrows}
		current_menu :settags \{smooth_morph_time = 0.1}
		current_menu :se_setprops {
			event_handlers = [
				{pad_up 0x8b8c56fa params = {arrow_id = <0x6b7cf884> up}}
				{pad_up smoothmenuscroll params = {dir = -1 isvertical = true}}
				{pad_down 0x8b8c56fa params = {arrow_id = <0x6518488b> down}}
				{pad_down smoothmenuscroll params = {dir = 1 isvertical = true}}
				{pad_back <pad_back_script> params = <pad_back_params>}
			]
			loop_view = true
			loop_center = true
		}
	else
		setscreenelementprops {id = <0x6b7cf884> alpha = 0.0}
		setscreenelementprops {id = <0x6518488b> alpha = 0.0}
		getscreenelementdims id = <0x67b68786>
		dims = ((<width> * (1.0, 0.0)) + (0.0, 512.0))
		setscreenelementprops {id = <0x67b68786> dims = <dims>}
		current_menu :se_setprops {
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

script 0x9d0992fe {
		parent = current_menu
		focus_rgba = ($menu_focus_color)
		unfocus_rgba = ($menu_unfocus_color)
		0xfdfdc7a4 = [64 64 64 255]
	}

	if gotparam \{0x6d96b274}
		just = [left center]
	else
		just = [right center]
	endif
	0x1a689a56 = false
	if gotparam \{0x656de5f8}
		0x1a689a56 = true
	elseif gotparam \{overlay_texture}
		0x1a689a56 = true
	elseif gotparam \{texture}
		0x1a689a56 = true
	elseif gotparam \{background_texture}
		0x1a689a56 = true
	endif
	if gotparam \{0xc1f386b6}
		0x1a689a56 = true
		overlay_texture = options_controller_check
		texture = options_controller_x
	endif
	if (<0x1a689a56> = true)
		if gotparam \{0x6d96b274}
			desc = 'menurow_ico_txt_desc'
		else
			desc = 'menurow_txt_ico_desc'
		endif
		createscreenelement {
			type = descinterface
			parent = <parent>
			desc = <desc>
			autosizedims = true
			menurow_just = <just>
			menurow_internal_just = <just>
			menurow_txt_item_text = <text>
			menurow_txt_item_font = fontgrid_title_a1
			menurow_txt_item_rgba = <unfocus_rgba>
		}
		if gotparam \{overlay_texture}
			<id> :se_setprops {0x119b297a = <overlay_texture>}
		else
			<id> :se_setprops {0xba238713 = 0.0}
		endif
		if gotparam \{texture}
			<id> :se_setprops {menurow_ico_item_texture = <texture>}
		else
			<id> :se_setprops {0xc1d5f75c = 0.0}
		endif
		if gotparam \{background_texture}
			<id> :se_setprops {0x199bfdea = <background_texture>}
		else
			<id> :se_setprops {0x8e7a2106 = 0.0}
		endif
	else
		createscreenelement {
			type = descinterface
			parent = <parent>
			desc = 'menurow_txt_desc'
			autosizedims = true
			menurow_just = <just>
			menurow_internal_just = <just>
			menurow_txt_item_text = <text>
			menurow_txt_item_font = fontgrid_title_a1
			menurow_txt_item_rgba = <unfocus_rgba>
		}
	endif
	if gotparam \{blank_entry}
		<id> :se_setprops {
			not_focusable
		}
	elseif gotparam \{not_focusable}
		<id> :se_setprops {
			not_focusable
			menurow_txt_item_rgba = <0xfdfdc7a4>
		}
	else
		if gotparam \{helper_text}
			<id> :se_setprops 0x3f37531d = <helper_text>
		endif
		array = []
		if gotparam \{additional_focus_script}
			addarrayelement array = <array> element = {
				focus
				0xf0f98915
				params = {
					focus_rgba = <focus_rgba>
					additional_focus_script = <additional_focus_script>
					additional_focus_params = <additional_focus_params>
				}
			}
		else
			addarrayelement array = <array> element = {
				focus
				0xf0f98915
				params = {focus_rgba = <focus_rgba>}
			}
		endif
		if gotparam \{additional_unfocus_script}
			addarrayelement array = <array> element = {
				unfocus
				0x4e9d4e51
				params = {
					unfocus_rgba = <unfocus_rgba>
					additional_unfocus_script = <additional_unfocus_script>
					additional_unfocus_params = <additional_unfocus_params>
				}
			}
		else
			addarrayelement array = <array> element = {
				unfocus
				0x4e9d4e51
				params = {unfocus_rgba = <unfocus_rgba>}
			}
		endif
		if NOT (gotparam 0xc1f386b6)
			if (gotparam pad_choose_sound)
				addarrayelement array = <array> element = {pad_choose <pad_choose_sound>}
			else
				addarrayelement array = <array> element = {pad_choose generic_menu_pad_choose_sound}
			endif
		endif
		if gotparam \{choose_state}
			addarrayelement array = <array> element = {
				pad_choose
				generic_event_choose
				params = {state = <choose_state> data = {<choose_state_data>}}
			}
		elseif gotparam \{pad_choose_script}
			addarrayelement array = <array> element = {
				pad_choose
				<pad_choose_script>
				params = <pad_choose_params>
			}
		endif
		if gotparam \{back_state}
			addarrayelement array = <array> element = {
				pad_back generic_event_back params = {state = <back_state>}
			}
		elseif gotparam \{pad_back_script}
			addarrayelement array = <array> element = {pad_back <pad_back_script>}
		endif
		<id> :se_setprops event_handlers = <array>
	endif
	return item_container_id = <id> item_id = <id>
endscript

script 0xf0f98915 time = 0.05 grow_scale = 1.5 {
		focus_rgba = ($menu_focus_color)
	}
	if NOT gotparam \{id}
		obj_getid
		<id> = <objid>
	endif
	<id> :gettags
	if gotparam \{helper_text}
		<id> :se_setprops 0x3f37531d = <helper_text>
	endif
	<id> :se_setprops {
		menurow_scale = <grow_scale>
		menurow_txt_item_font = fontgrid_title_a1
		menurow_txt_item_rgba = <focus_rgba>
		motion = ease_in
		time = <time>
	}
	if gotparam \{additional_focus_script}
		<additional_focus_script> <additional_focus_params>
	endif
endscript

script 0x4e9d4e51 time = 0.05 {
		unfocus_rgba = ($menu_unfocus_color)
	}
	if NOT gotparam \{id}
		obj_getid
		<id> = <objid>
	endif
	<id> :se_setprops {
		menurow_scale = 1.0
		menurow_txt_item_font = fontgrid_title_a1
		menurow_txt_item_rgba = <unfocus_rgba>
		motion = ease_in
		time = <time>
	}
	if gotparam \{additional_unfocus_script}
		<additional_unfocus_script> <additional_unfocus_params>
	endif
endscript

script 0x8b8c56fa 

	if gotparam \{down}
		generic_menu_up_or_down_sound \{down}
		<arrow_id> :obj_spawnscript 0x81ae5138
		<arrow_id> :obj_spawnscript 0xf4207007 params = {down}
	else
		generic_menu_up_or_down_sound \{up}
		<arrow_id> :obj_spawnscript 0x81ae5138
		<arrow_id> :obj_spawnscript 0xf4207007
	endif
endscript

script 0xf4207007 
	obj_getid
	<objid> :se_setprops hiddenlocal = true
	createscreenelement {
		type = spriteelement
		parent = <objid>
		texture = dropdown_arrow
		dims = (40.0, 40.0)
		pos = (20.0, 15.0)
		just = [center center]
		rgba = [225 , 225 , 225 , 200]
		z_priority = 112
	}
	if gotparam \{down}
		<id> :se_setprops flip_h
		<id> :se_setprops pos = {(0.0, 9.0) relative}
	endif
	<id> :se_setprops scale = 1.3 time = 0.01 relative_scale
	<id> :se_waitprops
	<id> :se_setprops scale = 1.0 time = 0.1 relative_scale
	<id> :se_waitprops
	<objid> :se_setprops hiddenlocal = false
	destroyscreenelement id = <id>
endscript

script 0x81ae5138 
	obj_getid
	createscreenelement {
		type = spriteelement
		parent = <objid>
		texture = circle_gradient_64
		dims = (64.0, 64.0)
		pos = (20.0, 15.0)
		rgba = [255 215 0 255]
		just = [center center]
		z_priority = 100
		alpha = 0.2
		blend = add
	}
	<id> :se_setprops scale = 1.2 relative_scale
	<id> :se_setprops scale = (Random (@ 2.0 @ 2.5 @ 3.0 )) alpha = 0.0 time = 0.2 relative_scale motion = ease_out
	<id> :se_waitprops
	destroyscreenelement id = <id>
endscript
