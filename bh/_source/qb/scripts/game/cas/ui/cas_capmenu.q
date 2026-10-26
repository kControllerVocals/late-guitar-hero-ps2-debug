cas_max_layers = 32
color_min_alpha = 0.0
color_max_alpha = 100.0
max_trans = 100.0
min_trans = -100.0
max_skew = 75.0
min_skew = -75.0
max_rot = 6283.0
min_rot = 0.0
max_scale = 150.0
min_scale = 1.0
scale_increment = 1.0
trans_increment = 1.0
skew_increment = 3.0
rot_increment = 30.0
color_alpha_increment = 5
default_cap_alpha = 100
default_cap_scale = 100
default_cap_trans = 0
default_cap_rot = 0
default_cap_skew = 0
default_cap_red = 250
default_cap_green = 250
default_cap_blue = 250

script cap_artist_layer_edit 

	mask = (<section>.mask)
	if NOT StructureContains Structure = ((<mask>) [<mask_index>]) no_color
		cap_get_current_rgb section = <section> part = <part> mask_index = <mask_index>
		colorwheel_add_item {
			scale = 0.6
			pad_choose_script = unfocus_color_wheel
			pad_choose_params = {part = <part>}
			increment_focus_script = cap_artist_colorwheel_focus_change
			increment_focus_params = {section = <section> part = <part> mask_index = <mask_index>}
			initial_rgb = <rgb>
			lookup_table = <color_wheel>
			special_exit_script = restore_color_initial
			special_exit_params = {part = <part> add_script = cap_artist_colorwheel_focus_change add_params = {color = <rgb> section = <section> part = <part> mask_index = <mask_index>}}
			special_choose_script = widget_init_cap
		}
	endif
	if NOT StructureContains Structure = ((<mask>) [<mask_index>]) no_alpha
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		a = ($default_cap_alpha)
		if GotParam \{pre_layer}
			if StructureContains Structure = <pre_layer> a
				a = (<pre_layer>.a)
			endif
		elseif GotParam \{post_layer}
			if StructureContains Structure = <post_layer> a
				a = (<post_layer>.a)
			endif
		endif
		button_widget_add_item {
			widget_id = alpha_widget
			text = qs("Transparency")
			button_icon = widget_transparency
			start_value = <a>
			min = ($color_min_alpha)
			max = ($color_max_alpha)
			step = ($color_alpha_increment)
			pad_up_script = cap_layer_set_alpha
			pad_up_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			pad_down_script = cap_layer_set_alpha
			pad_down_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			fill_type = `Bottom to Top`
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			init_script = widget_init_cap
			accept_script = widget_accept_cap
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
		}
	endif
	if NOT StructureContains Structure = ((<mask>) [<mask_index>]) no_scale
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		x_scale = ($default_cap_scale)
		if GotParam \{pre_layer}
			if StructureContains Structure = <pre_layer> x_scale
				x_scale = (<pre_layer>.x_scale)
			endif
		elseif GotParam \{post_layer}
			if StructureContains Structure = <post_layer> x_scale
				x_scale = (<post_layer>.x_scale)
			endif
		endif
		button_widget_add_item {
			widget_id = x_scale_widget
			text = qs("Width")
			button_icon = widget_uni_scale
			start_value = <x_scale>
			min = ($min_scale)
			max = ($max_scale)
			step = ($scale_increment)
			pad_left_script = cap_layer_set_x_scale
			pad_left_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			pad_right_script = cap_layer_set_x_scale
			pad_right_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			fill_type = `Center Left/Right`
			icon_rot = 90
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			init_script = widget_init_cap
			accept_script = widget_accept_cap
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
		}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		y_scale = ($default_cap_scale)
		if GotParam \{pre_layer}
			if StructureContains Structure = <pre_layer> y_scale
				y_scale = (<pre_layer>.y_scale)
			endif
		elseif GotParam \{post_layer}
			if StructureContains Structure = <post_layer> y_scale
				y_scale = (<post_layer>.y_scale)
			endif
		endif
		button_widget_add_item {
			widget_id = y_scale_widget
			text = qs("Height")
			button_icon = widget_uni_scale
			start_value = <y_scale>
			min = ($min_scale)
			max = ($max_scale)
			step = ($scale_increment)
			pad_up_script = cap_layer_set_y_scale
			pad_up_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			pad_down_script = cap_layer_set_y_scale
			pad_down_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			fill_type = `Center Up/Down`
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			init_script = widget_init_cap
			accept_script = widget_accept_cap
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
		}
	endif
	if NOT StructureContains Structure = ((<mask>) [<mask_index>]) no_translate
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		x_trans = ($default_cap_trans)
		if GotParam \{pre_layer}
			if StructureContains Structure = <pre_layer> x_trans
				x_trans = (<pre_layer>.x_trans)
			endif
		elseif GotParam \{post_layer}
			if StructureContains Structure = <post_layer> x_trans
				x_trans = (<post_layer>.x_trans)
			endif
		endif
		button_widget_add_item {
			widget_id = x_trans_widget
			text = qs("Horizontal")
			button_icon = widget_uni_move
			start_value = <x_trans>
			min = ($min_trans)
			max = ($max_trans)
			step = ($trans_increment)
			pad_left_script = cap_layer_set_x_trans
			pad_left_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			pad_right_script = cap_layer_set_x_trans
			pad_right_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			fill_type = `Center Left/Right`
			icon_rot = 90
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			init_script = widget_init_cap
			accept_script = widget_accept_cap
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
		}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		y_trans = ($default_cap_trans)
		if GotParam \{pre_layer}
			if StructureContains Structure = <pre_layer> y_trans
				y_trans = (<pre_layer>.x_scale)
			endif
		elseif GotParam \{post_layer}
			if StructureContains Structure = <post_layer> y_trans
				y_trans = (<post_layer>.y_trans)
			endif
		endif
		button_widget_add_item {
			widget_id = y_trans_widget
			text = qs("Vertical")
			button_icon = widget_uni_move
			start_value = <y_trans>
			min = ($min_trans)
			max = ($max_trans)
			step = ($trans_increment)
			pad_up_script = cap_layer_set_y_trans
			pad_up_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			pad_down_script = cap_layer_set_y_trans
			pad_down_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			fill_type = `Center Up/Down`
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			init_script = widget_init_cap
			accept_script = widget_accept_cap
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
		}
	endif
	if NOT StructureContains Structure = ((<mask>) [<mask_index>]) no_skew
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		x_skew = ($default_cap_skew)
		if GotParam \{pre_layer}
			if StructureContains Structure = <pre_layer> x_skew
				x_skew = (<pre_layer>.x_skew)
			endif
		elseif GotParam \{post_layer}
			if StructureContains Structure = <post_layer> x_skew
				x_skew = (<post_layer>.x_skew)
			endif
		endif
		button_widget_add_item {
			widget_id = x_skew_widget
			text = qs("Lean")
			button_icon = widget_shear
			start_value = <x_skew>
			min = ($min_skew)
			max = ($max_skew)
			step = ($skew_increment)
			pad_left_script = cap_layer_set_x_skew
			pad_left_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			pad_right_script = cap_layer_set_x_skew
			pad_right_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			fill_type = `Center Left/Right`
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			init_script = widget_init_cap
			accept_script = widget_accept_cap
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
		}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		y_skew = ($default_cap_skew)
		if GotParam \{pre_layer}
			if StructureContains Structure = <pre_layer> y_skew
				y_skew = (<pre_layer>.y_skew)
			endif
		elseif GotParam \{post_layer}
			if StructureContains Structure = <post_layer> y_skew
				y_skew = (<post_layer>.y_skew)
			endif
		endif
		button_widget_add_item {
			widget_id = y_skew_widget
			text = qs("Tilt")
			button_icon = widget_shear
			start_value = <y_skew>
			min = ($min_skew)
			max = ($max_skew)
			step = ($skew_increment)
			pad_up_script = cap_layer_set_y_skew
			pad_up_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			pad_down_script = cap_layer_set_y_skew
			pad_down_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			fill_type = `Center Up/Down`
			icon_rot = 90
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			init_script = widget_init_cap
			accept_script = widget_accept_cap
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
		}
	endif
	if NOT StructureContains Structure = ((<mask>) [<mask_index>]) no_rotate
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		rot = ($default_cap_rot)
		if GotParam \{pre_layer}
			if StructureContains Structure = <pre_layer> rot
				rot = (<pre_layer>.rot)
			endif
		elseif GotParam \{post_layer}
			if StructureContains Structure = <post_layer> rot
				rot = (<post_layer>.rot)
			endif
		endif
		rot_widget_add_item {
			widget_id = rot_widget
			text = qs("Rotate")
			button_icon = widget_rotate
			start_value = <rot>
			min = ($min_rot)
			max = ($max_rot)
			step = ($rot_increment)
			pad_up_script = cap_layer_set_rot
			pad_up_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			pad_down_script = cap_layer_set_rot
			pad_down_params = {section = <section> part = <part> mask_index = <mask_index> pre_layer = <pre_layer> post_layer = <post_layer>}
			fill_type = `Counter Clockwise`
			wrap
			sweep
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			init_script = widget_init_cap
			accept_script = widget_accept_cap
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
		}
	endif
	add_generic_menu_icon_item {
		icon = widget_default
		text = qs("Default")
		pad_choose_sound = ui_menu_select_sfx
		pad_choose_script = reset_to_default
		pad_choose_params = {part = <part> section = <section> mask_index = <mask_index>}
		not_focusable = <not_focusable>
		scale_highlight_text = 0
	}
endscript

script edit_cas_layer 

	if NOT StructureContains Structure = <mask> no_color
		add_generic_menu_icon_item {
			icon = widget_colorwheel
			text = qs("Color")
			choose_state = UIstate_cap_color_wheel
			choose_state_data = {part = <part> cap_index = <cap_index> layer_index = <layer_index> color_wheel = <color_wheel> camera_list = <camera_list> zoom_camera = <zoom_camera>}
		}
	endif
	if NOT StructureContains Structure = <mask> no_alpha
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		if StructureContains Structure = <layer> a
			a = (<layer>.a)
		else
			a = ($default_cap_alpha)
		endif
		button_widget_add_item {
			widget_id = alpha_widget
			text = qs("Transparency")
			button_icon = widget_transparency
			start_value = <a>
			min = ($color_min_alpha)
			max = ($color_max_alpha)
			step = ($color_alpha_increment)
			pad_up_script = cap_layer_set_alpha
			pad_up_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			pad_down_script = cap_layer_set_alpha
			pad_down_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			fill_type = `Bottom to Top`
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			deinit_params = {part = <part>}
			init_script = widget_init_cap
			init_params = {part = <part>}
			accept_script = widget_accept_cap
			accept_params = {part = <part>}
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
		}
	endif
	if NOT StructureContains Structure = <mask> no_scale
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		if StructureContains Structure = <layer> x_scale
			x_scale = (<layer>.x_scale)
		else
			x_scale = ($default_cap_scale)
		endif
		if StructureContains Structure = <layer> y_scale
			y_scale = (<layer>.y_scale)
		else
			y_scale = ($default_cap_scale)
		endif
		if StructureContains Structure = <mask> uniform_scale
			MathMax a = <y_scale> b = <x_scale>
			MathMin a = <y_scale> b = <x_scale>
			button_widget_add_item {
				widget_id = uni_scale_widget
				text = qs("Scale")
				start_value = <max>
				min = (<max> - (<min> - ($min_scale)))
				max = ($max_scale)
				step = (2 * ($scale_increment))
				pad_left_script = cap_layer_set_uni_scale
				pad_left_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer> aspect_ratio = (<min> / <max>)}
				pad_right_script = cap_layer_set_uni_scale
				pad_right_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer> aspect_ratio = (<min> / <max>)}
				fill_type = `Center Out`
				button_icon = widget_scale
				icon_rot = 90
				<no_cas_handlers>
				deinit_script = widget_accept_cap
				deinit_params = {part = <part>}
				init_script = widget_init_cap
				init_params = {part = <part>}
				accept_script = widget_accept_cap
				accept_params = {part = <part>}
				camera_list = <camera_list>
				zoom_camera = <zoom_camera>
			}
		else
			if (<part> = CAS_Guitar_Body || <part> = CAS_Bass_Body || <part> = CAS_Guitar_Head || <part> = CAS_Bass_Head)
				additional_width_params = {
					pad_left_script = cap_layer_set_y_scale
					pad_right_script = cap_layer_set_y_scale
					start_value = <y_scale>
				}
				additional_height_params = {
					pad_up_script = cap_layer_set_x_scale
					pad_down_script = cap_layer_set_x_scale
					start_value = <x_scale>
				}
			endif
			button_widget_add_item {
				widget_id = x_scale_widget
				text = qs("Width")
				button_icon = widget_uni_scale
				start_value = <x_scale>
				min = ($min_scale)
				max = ($max_scale)
				step = ($scale_increment)
				pad_left_script = cap_layer_set_x_scale
				pad_left_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
				pad_right_script = cap_layer_set_x_scale
				pad_right_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
				fill_type = `Center Left/Right`
				icon_rot = 90
				<no_cas_handlers>
				deinit_script = widget_accept_cap
				deinit_params = {part = <part>}
				init_script = widget_init_cap
				init_params = {part = <part>}
				accept_script = widget_accept_cap
				accept_params = {part = <part>}
				camera_list = <camera_list>
				zoom_camera = <zoom_camera>
				<additional_width_params>
			}
			button_widget_add_item {
				widget_id = y_scale_widget
				text = qs("Height")
				button_icon = widget_uni_scale
				start_value = <y_scale>
				min = ($min_scale)
				max = ($max_scale)
				step = ($scale_increment)
				pad_up_script = cap_layer_set_y_scale
				pad_up_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
				pad_down_script = cap_layer_set_y_scale
				pad_down_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
				fill_type = `Center Up/Down`
				<no_cas_handlers>
				deinit_script = widget_accept_cap
				deinit_params = {part = <part>}
				init_script = widget_init_cap
				init_params = {part = <part>}
				accept_script = widget_accept_cap
				accept_params = {part = <part>}
				camera_list = <camera_list>
				zoom_camera = <zoom_camera>
				<additional_height_params>
			}
		endif
	endif
	if NOT StructureContains Structure = <mask> no_translate
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		if StructureContains Structure = <layer> x_trans
			x_trans = (<layer>.x_trans)
		else
			x_trans = ($default_cap_trans)
		endif
		if (<part> = CAS_Guitar_Body || <part> = CAS_Bass_Body || <part> = CAS_Guitar_Head || <part> = CAS_Bass_Head)
			additional_x_trans_params = {
				pad_left_script = cap_layer_set_y_trans
				pad_right_script = cap_layer_set_y_trans
				pad_left_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer> reverse}
				pad_right_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer> reverse}
				start_value = <y_trans>
			}
			additional_y_trans_params = {
				pad_up_script = cap_layer_set_x_trans
				pad_down_script = cap_layer_set_x_trans
				start_value = <x_trans>
			}
		endif
		button_widget_add_item {
			widget_id = x_trans_widget
			text = qs("Horizontal")
			button_icon = widget_uni_move
			start_value = <x_trans>
			min = ($min_trans)
			max = ($max_trans)
			step = ($trans_increment)
			pad_left_script = cap_layer_set_x_trans
			pad_left_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			pad_right_script = cap_layer_set_x_trans
			pad_right_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			fill_type = `Center Left/Right`
			icon_rot = 90
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			deinit_params = {part = <part>}
			init_script = widget_init_cap
			init_params = {part = <part>}
			accept_script = widget_accept_cap
			accept_params = {part = <part>}
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
			<additional_x_trans_params>
		}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		if StructureContains Structure = <layer> y_trans
			y_trans = (<layer>.y_trans)
		else
			y_trans = ($default_cap_trans)
		endif
		button_widget_add_item {
			widget_id = y_trans_widget
			text = qs("Vertical")
			button_icon = widget_uni_move
			start_value = <y_trans>
			min = ($min_trans)
			max = ($max_trans)
			step = ($trans_increment)
			pad_up_script = cap_layer_set_y_trans
			pad_up_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			pad_down_script = cap_layer_set_y_trans
			pad_down_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			fill_type = `Center Up/Down`
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			deinit_params = {part = <part>}
			init_script = widget_init_cap
			init_params = {part = <part>}
			accept_script = widget_accept_cap
			accept_params = {part = <part>}
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
			<additional_y_trans_params>
		}
	endif
	if NOT StructureContains Structure = <mask> no_skew
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		if StructureContains Structure = <layer> x_skew
			x_skew = (<layer>.x_skew)
		else
			x_skew = ($default_cap_skew)
		endif
		if (<part> = CAS_Guitar_Body || <part> = CAS_Bass_Body || <part> = CAS_Guitar_Head || <part> = CAS_Bass_Head)
			additional_x_skew_params = {
				pad_left_script = cap_layer_set_y_skew
				pad_right_script = cap_layer_set_y_skew
				pad_left_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer> reverse}
				pad_right_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer> reverse}
				start_value = <y_skew>
			}
			additional_y_skew_params = {
				pad_up_script = cap_layer_set_x_skew
				pad_down_script = cap_layer_set_x_skew
				start_value = <x_skew>
			}
		endif
		button_widget_add_item {
			widget_id = x_skew_widget
			text = qs("Lean")
			button_icon = widget_shear
			start_value = <x_skew>
			min = ($min_skew)
			max = ($max_skew)
			step = ($skew_increment)
			pad_left_script = cap_layer_set_x_skew
			pad_left_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			pad_right_script = cap_layer_set_x_skew
			pad_right_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			fill_type = `Center Left/Right`
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			deinit_params = {part = <part>}
			init_script = widget_init_cap
			init_params = {part = <part>}
			accept_script = widget_accept_cap
			accept_params = {part = <part>}
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
			<additional_x_skew_params>
		}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		if StructureContains Structure = <layer> y_skew
			y_skew = (<layer>.y_skew)
		else
			y_skew = ($default_cap_skew)
		endif
		button_widget_add_item {
			widget_id = y_skew_widget
			text = qs("Tilt")
			button_icon = widget_shear
			start_value = <y_skew>
			min = ($min_skew)
			max = ($max_skew)
			step = ($skew_increment)
			pad_up_script = cap_layer_set_y_skew
			pad_up_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			pad_down_script = cap_layer_set_y_skew
			pad_down_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			fill_type = `Center Up/Down`
			icon_rot = 90
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			deinit_params = {part = <part>}
			init_script = widget_init_cap
			init_params = {part = <part>}
			accept_script = widget_accept_cap
			accept_params = {part = <part>}
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
			<additional_y_skew_params>
		}
	endif
	if NOT StructureContains Structure = <mask> no_rotate
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		if StructureContains Structure = <layer> rot
			rot = (<layer>.rot)
		else
			rot = ($default_cap_rot)
		endif
		rot_widget_add_item {
			widget_id = rot_widget
			text = qs("Rotate")
			button_icon = widget_rotate
			start_value = <rot>
			min = ($min_rot)
			max = ($max_rot)
			step = ($rot_increment)
			pad_up_script = cap_layer_set_rot
			pad_up_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			pad_down_script = cap_layer_set_rot
			pad_down_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>}
			fill_type = `Counter Clockwise`
			wrap
			sweep
			<no_cas_handlers>
			deinit_script = widget_accept_cap
			deinit_params = {part = <part>}
			init_script = widget_init_cap
			init_params = {part = <part>}
			accept_script = widget_accept_cap
			accept_params = {part = <part>}
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
		}
	endif
	if NOT StructureContains Structure = <mask> no_u_flip
		if is_flip_layer_horizontal part = <part> cap_index = <cap_index> layer_index = <layer_index>
			horiz_on = true
		endif
		if (<part> = CAS_Guitar_Body || <part> = CAS_Bass_Body || <part> = CAS_Guitar_Head || <part> = CAS_Bass_Head)
			pad_choose_script = flip_layer_vertical
		else
			pad_choose_script = flip_layer_horizontal
		endif
		add_generic_menu_button_icon_item {
			id = flip_horiz_widget
			icon = widget_flip
			text = qs("Flip Horiz.")
			pad_choose_sound = ui_menu_select_sfx
			pad_choose_script = <pad_choose_script>
			pad_choose_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index>}
			icon_rot = 90
			on = <horiz_on>
		}
	endif
	if NOT StructureContains Structure = <mask> no_v_flip
		if is_flip_layer_vertical part = <part> cap_index = <cap_index> layer_index = <layer_index>
			vert_on = true
		endif
		if (<part> = CAS_Guitar_Body || <part> = CAS_Bass_Body || <part> = CAS_Guitar_Head || <part> = CAS_Bass_Head)
			pad_choose_script = flip_layer_horizontal
		else
			pad_choose_script = flip_layer_vertical
		endif
		add_generic_menu_button_icon_item {
			id = flip_vert_widget
			icon = widget_flip
			text = qs("Flip Vert.")
			pad_choose_sound = ui_menu_select_sfx
			pad_choose_script = <pad_choose_script>
			pad_choose_params = {part = <part> cap_index = <cap_index> layer_index = <layer_index>}
			on = <vert_on>
		}
	endif
	add_generic_menu_icon_item {
		icon = widget_default
		text = qs("Default")
		pad_choose_sound = ui_menu_select_sfx
		pad_choose_script = reset_layer_to_default
		pad_choose_params = {mask = <mask> part = <part> cap_index = <cap_index> layer_index = <layer_index> section = <section> mask = <mask>}
	}
endscript

script cap_layer_set_alpha 
	CastToInteger \{value}
	if GotParam \{pre_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		pre_layer = {<pre_layer>
			a = <value>}
		set_CAP part = <part> section = <section> pre_layer = <pre_layer> mask_index = <mask_index>
	endif
	if GotParam \{post_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		post_layer = {<post_layer>
			a = <value>}
		set_CAP part = <part> section = <section> post_layer = <post_layer> mask_index = <mask_index>
	endif
	if GotParam \{layer}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		layer = {<layer>
			a = <value>}
		SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
	endif
endscript

script cap_layer_set_x_scale 
	CastToInteger \{value}
	if GotParam \{pre_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		pre_layer = {<pre_layer>
			x_scale = <value>}
		set_CAP part = <part> section = <section> pre_layer = <pre_layer> mask_index = <mask_index>
	endif
	if GotParam \{post_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		post_layer = {<post_layer>
			x_scale = <value>}
		set_CAP part = <part> section = <section> post_layer = <post_layer> mask_index = <mask_index>
	endif
	if GotParam \{layer}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		layer = {<layer>
			x_scale = <value>}
		SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
	endif
endscript

script cap_layer_set_y_scale 
	CastToInteger \{value}
	if GotParam \{pre_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		pre_layer = {<pre_layer>
			y_scale = <value>}
		set_CAP part = <part> section = <section> pre_layer = <pre_layer> mask_index = <mask_index>
	endif
	if GotParam \{post_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		post_layer = {<post_layer>
			y_scale = <value>}
		set_CAP part = <part> section = <section> post_layer = <post_layer> mask_index = <mask_index>
	endif
	if GotParam \{layer}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		layer = {<layer>
			y_scale = <value>}
		SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
	endif
endscript

script cap_layer_set_uni_scale 
	CastToInteger \{value}
	x_scale = ($default_cap_scale)
	y_scale = ($default_cap_scale)
	if GotParam \{layer}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		if StructureContains Structure = <layer> x_scale
			x_scale = (<layer>.x_scale)
		endif
		if StructureContains Structure = <layer> y_scale
			y_scale = (<layer>.y_scale)
		endif
	endif
	if GotParam \{pre_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		if StructureContains Structure = <pre_layer> x_scale
			x_scale = (<pre_layer>.x_scale)
		endif
		if StructureContains Structure = <pre_layer> y_scale
			y_scale = (<pre_layer>.y_scale)
		endif
	endif
	if GotParam \{post_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		if StructureContains Structure = <post_layer> x_scale
			x_scale = (<post_layer>.x_scale)
		endif
		if StructureContains Structure = <post_layer> y_scale
			y_scale = (<post_layer>.y_scale)
		endif
	endif
	y_scale = (<y_scale> * 1.0)
	x_scale = (<x_scale> * 1.0)
	if (<y_scale> > <x_scale>)
		y_scale = <value>
		x_scale = (<value> * <aspect_ratio>)
	else
		x_scale = <value>
		y_scale = (<value> * <aspect_ratio>)
	endif
	y_scale = (<y_scale> + 0.5)
	x_scale = (<x_scale> + 0.5)
	CastToInteger \{y_scale}
	CastToInteger \{x_scale}

	if GotParam \{pre_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		pre_layer = {<pre_layer>
			y_scale = <y_scale>
			x_scale = <x_scale>}
		set_CAP part = <part> section = <section> pre_layer = <pre_layer> mask_index = <mask_index>
	endif
	if GotParam \{post_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		post_layer = {<post_layer>
			y_scale = <y_scale>
			x_scale = <x_scale>}
		set_CAP part = <part> section = <section> post_layer = <post_layer> mask_index = <mask_index>
	endif
	if GotParam \{layer}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		layer = {<layer>
			y_scale = <y_scale>
			x_scale = <x_scale>}
		SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
	endif
endscript

script cap_layer_set_x_trans 
	CastToInteger \{value}
	if GotParam \{pre_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		pre_layer = {<pre_layer>
			x_trans = <value>}
		set_CAP part = <part> section = <section> pre_layer = <pre_layer> mask_index = <mask_index>
	endif
	if GotParam \{post_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		post_layer = {<post_layer>
			x_trans = <value>}
		set_CAP part = <part> section = <section> post_layer = <post_layer> mask_index = <mask_index>
	endif
	if GotParam \{layer}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		layer = {<layer>
			x_trans = <value>}
		SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
	endif
endscript

script cap_layer_set_y_trans 
	if GotParam \{reverse}
		value = (-1 * <value>)
	endif
	CastToInteger \{value}
	if GotParam \{pre_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		pre_layer = {<pre_layer>
			y_trans = <value>}
		set_CAP part = <part> section = <section> pre_layer = <pre_layer> mask_index = <mask_index>
	endif
	if GotParam \{post_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		post_layer = {<post_layer>
			y_trans = <value>}
		set_CAP part = <part> section = <section> post_layer = <post_layer> mask_index = <mask_index>
	endif
	if GotParam \{layer}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		layer = {<layer>
			y_trans = <value>}
		SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
	endif
endscript

script cap_layer_set_x_skew 
	if GotParam \{reverse}
		value = (-1 * <value>)
	endif
	CastToInteger \{value}
	if GotParam \{pre_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		pre_layer = {<pre_layer>
			x_skew = <value>}
		set_CAP part = <part> section = <section> pre_layer = <pre_layer> mask_index = <mask_index>
	endif
	if GotParam \{post_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		post_layer = {<post_layer>
			x_skew = <value>}
		set_CAP part = <part> section = <section> post_layer = <post_layer> mask_index = <mask_index>
	endif
	if GotParam \{layer}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		layer = {<layer>
			x_skew = <value>}
		SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
	endif
endscript

script cap_layer_set_y_skew 
	CastToInteger \{value}
	if GotParam \{pre_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		pre_layer = {<pre_layer>
			y_skew = <value>}
		set_CAP part = <part> section = <section> pre_layer = <pre_layer> mask_index = <mask_index>
	endif
	if GotParam \{post_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		post_layer = {<post_layer>
			y_skew = <value>}
		set_CAP part = <part> section = <section> post_layer = <post_layer> mask_index = <mask_index>
	endif
	if GotParam \{layer}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		layer = {<layer>
			y_skew = <value>}
		SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
	endif
endscript

script cap_layer_set_rot 
	CastToInteger \{value}
	if GotParam \{pre_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		pre_layer = {<pre_layer>
			rot = <value>}
		set_CAP part = <part> section = <section> pre_layer = <pre_layer> mask_index = <mask_index>
	endif
	if GotParam \{post_layer}
		get_CAP part = <part> section = <section> mask_index = <mask_index>
		post_layer = {<post_layer>
			rot = <value>}
		set_CAP part = <part> section = <section> post_layer = <post_layer> mask_index = <mask_index>
	endif
	if GotParam \{layer}
		GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
		layer = {<layer>
			rot = <value>}
		SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
	endif
endscript

script get_CAP 
	if NOT GetCASAppearancePart part = <part>

	endif
	mask = (<section>.mask)
	set_cap_flags mask = ((<mask>) [<mask_index>])
	if GotParam \{cap}
		GetArraySize (cap)
		capsize = <array_size>
		i = 0
		begin
		if is_matching_section cap = (<cap> [<i>]) section = <section>
			if StructureContains Structure = (<cap> [<i>]) pre_layer
				if StructureContains Structure = <section> pre_userlayer
					cap_populate_layer cap_entry = ((<cap> [<i>]).pre_layer) mask_entry = ((<mask>) [<mask_index>]) flags = <flags>
					if GotParam \{layer}
						return pre_layer = <layer>
					endif
				endif
			endif
			if StructureContains Structure = (<cap> [<i>]) post_layer
				if StructureContains Structure = <section> post_userlayer
					cap_populate_layer cap_entry = ((<cap> [<i>]).post_layer) mask_entry = ((<mask>) [<mask_index>]) flags = <flags>
					if GotParam \{layer}
						return post_layer = <layer>
					endif
				endif
			endif
		endif
		i = (<i> + 1)
		repeat <capsize>
	endif
	if StructureContains Structure = <section> pre_userlayer
		cap_new_artist_layer section = <section> mask_entry = ((<mask>) [<mask_index>]) flags = <flags>
		return pre_layer = <layer>
	endif
	if StructureContains Structure = <section> post_userlayer
		cap_new_artist_layer section = <section> mask_entry = ((<mask>) [<mask_index>]) flags = <flags>
		return post_layer = <layer>
	endif
endscript

script set_CAP 

	if NOT GetCASAppearancePart part = <part>

	endif
	mask = (<section>.mask)
	if GotParam \{cap}
		found_mat = 0
		GetArraySize (cap)
		cap_array_size = <array_size>
		i = 0
		begin
		FormatText checksumname = name '%s' s = (<section>.base_tex)
		if is_matching_section cap = (<cap> [<i>]) section = <section>
			found_mat = 1
			found_tex = 0
			capstruct = (<cap> [<i>])
			if ((GotParam pre_layer) && (StructureContains Structure = <capstruct> pre_layer))
				GetArraySize ((<cap> [<i>]).pre_layer)
				mat_array_size = <array_size>
				j = 0
				begin
				if StructureContains Structure = ((<mask>) [<mask_index>]) pattern
					FixImagePath path = (((<mask>) [<mask_index>]).pattern)
					if in_tex_same_section section = <section> prev_tex = <name> new_tex = ((((<cap> [<i>]).pre_layer) [<j>]).texture)
						found_tex = 1
						pre_layers = ((<cap> [<i>]).pre_layer)
						SetArrayElement ArrayName = pre_layers index = <j> newvalue = <pre_layer>
						SetArrayElement ArrayName = cap index = <i> newvalue = {
							(<cap> [<i>])
							pre_layer = <pre_layers>
						}
						SetCASAppearanceCAP part = <part> cap = <cap>
						UpdateCASModelCAP part = <part>
						return
					endif
				elseif StructureContains Structure = ((<mask>) [<mask_index>]) font
					if in_font_same_section section = <section> prev_text = (((<mask>) [<mask_index>]).text) new_text = ((((<cap> [<i>]).pre_layer) [<j>]).text)
						found_tex = 1
						pre_layers = ((<cap> [<i>]).pre_layer)
						SetArrayElement ArrayName = pre_layers index = <j> newvalue = <pre_layer>
						SetArrayElement ArrayName = cap index = <i> newvalue = {
							(<cap> [<i>])
							pre_layer = <pre_layers>
						}
						SetCASAppearanceCAP part = <part> cap = <cap>
						UpdateCASModelCAP part = <part>
						return
					endif
				endif
				j = (<j> + 1)
				repeat <mat_array_size>
				get_proper_location section = <section> pre_layer = ((<cap> [<i>]).pre_layer) part = <part>
				if GotParam \{index}
					InsertArrayElement array = ((<cap> [<i>]).pre_layer) element = <pre_layer> index = <index>
					SetArrayElement ArrayName = cap index = <i> newvalue = {
						(<cap> [<i>])
						pre_layer = <array>
					}
				else
					AddArrayElement array = ((<cap> [<i>]).pre_layer) element = <pre_layer>
					SetArrayElement ArrayName = cap index = <i> newvalue = {
						(<cap> [<i>])
						pre_layer = <array>
					}
				endif
				SetCASAppearanceCAP part = <part> cap = <cap>
				UpdateCASModelCAP part = <part>
				return
			elseif ((GotParam post_layer) && (StructureContains Structure = <capstruct> post_layer))
				GetArraySize ((<cap> [<i>]).post_layer)
				mat_array_size = <array_size>
				j = 0
				begin
				if StructureContains Structure = ((<mask>) [<mask_index>]) pattern
					FixImagePath path = (((<mask>) [<mask_index>]).pattern)
					if in_tex_same_section section = <section> prev_tex = <name> new_tex = ((((<cap> [<i>]).post_layer) [<j>]).texture)
						found_tex = 1
						post_layers = ((<cap> [<i>]).post_layer)
						SetArrayElement ArrayName = post_layers index = <j> newvalue = <post_layer>
						SetArrayElement ArrayName = cap index = <i> newvalue = {
							(<cap> [<i>])
							post_layer = <post_layers>
						}
						SetCASAppearanceCAP part = <part> cap = <cap>
						UpdateCASModelCAP part = <part>
						return
					endif
				elseif StructureContains Structure = ((<mask>) [<mask_index>]) font
					if in_font_same_section section = <section> prev_text = (((<mask>) [<mask_index>]).text) new_text = ((((<cap> [<i>]).post_layer) [<j>]).text)
						found_tex = 1
						post_layer = ((<cap> [<i>]).post_layer)
						SetArrayElement ArrayName = post_layer index = <j> newvalue = <post_layer>
						SetArrayElement ArrayName = cap index = <i> newvalue = {
							(<cap> [<i>])
							post_layer = <post_layer>
						}
						SetCASAppearanceCAP part = <part> cap = <cap>
						UpdateCASModelCAP part = <part>
						return
					endif
				endif
				j = (<j> + 1)
				repeat <mat_array_size>
				get_proper_location section = <section> post_layer = ((<cap> [<i>]).post_layer) part = <part>
				if GotParam \{index}
					InsertArrayElement array = ((<cap> [<i>]).post_layer) element = <post_layer> index = <index>
					SetArrayElement ArrayName = cap index = <i> newvalue = {
						(<cap> [<i>])
						post_layer = <array>
					}
				else
					AddArrayElement array = ((<cap> [<i>]).post_layer) element = <post_layer>
					SetArrayElement ArrayName = cap index = <i> newvalue = {
						(<cap> [<i>])
						post_layer = <array>
					}
				endif
				SetCASAppearanceCAP part = <part> cap = <cap>
				UpdateCASModelCAP part = <part>
				return
			else

				if GotParam \{pre_layer}

					pre_layers = [{<pre_layer>}]
					SetArrayElement ArrayName = cap index = <i> newvalue = {
						(<cap> [<i>])
						pre_layer = <pre_layers>
					}
				endif
				if GotParam \{post_layer}

					post_layers = [{<post_layer>}]
					SetArrayElement ArrayName = cap index = <i> newvalue = {
						(<cap> [<i>])
						post_layer = <post_layers>
					}
				endif
				SetCASAppearanceCAP part = <part> cap = <cap>
				UpdateCASModelCAP part = <part>
				return
			endif
		endif
		i = (<i> + 1)
		repeat <cap_array_size>
		if (<found_mat> = 0)
			FormatText checksumname = name '%s' s = (<section>.base_tex)
			if GotParam \{pre_layer}
				new_select = [{<pre_layer>}]
				entry = {
					base_tex = <name>
					material = (<section>.material)
					pre_layer = <new_select>
				}
				cap_set_target entry = <entry> section = <section>
			endif
			if GotParam \{post_layer}
				new_select = [{<post_layer>}]
				entry = {
					base_tex = <name>
					material = (<section>.material)
					post_layer = <new_select>
				}
				cap_set_target entry = <entry> section = <section>
			endif
			AddArrayElement array = <cap> element = <entry>
			<cap> = <array>
			SetCASAppearanceCAP part = <part> cap = <cap>
			UpdateCASModelCAP part = <part>
			return
		endif
	else
		FormatText checksumname = name '%s' s = (<section>.base_tex)
		if GotParam \{pre_layer}
			new_select = [{<pre_layer>}]
			entry = {
				base_tex = <name>
				material = (<section>.material)
				pre_layer = <new_select>
			}
			cap_set_target entry = <entry> section = <section>
			cap = [{<entry>}]
		endif
		if GotParam \{post_layer}
			new_select = [{<post_layer>}]
			entry = {
				base_tex = <name>
				material = (<section>.material)
				post_layer = <new_select>
			}
			cap_set_target entry = <entry> section = <section>
			cap = [{<entry>}]
		endif
		SetCASAppearanceCAP part = <part> cap = <cap>
		UpdateCASModelCAP part = <part>
		return
	endif
endscript

script in_tex_same_section 

	mask = (<section>.mask)
	match_prev_tex = 0
	match_new_tex = 0
	GetArraySize (<mask>)
	j = 0
	begin
	FixImagePath path = (((<mask>) [<j>]).pattern)
	if (<name> = <prev_tex>)
		match_prev_tex = 1
	endif
	if (<name> = <new_tex>)
		match_new_tex = 1
	endif
	j = (<j> + 1)
	repeat <array_size>
	if (<match_prev_tex> = 1)
		if (<match_new_tex> = 1)
			return \{true}
		endif
	endif
	return \{false}
endscript

script in_font_same_section 

	mask = (<section>.mask)
	match_prev_text = 0
	match_new_text = 0
	GetArraySize (<mask>)
	j = 0
	begin
	FixImagePath path = (((<mask>) [<j>]).text)
	if (<name> = <prev_text>)
		match_prev_text = 1
	endif
	if (<name> = <new_text>)
		match_new_text = 1
	endif
	j = (<j> + 1)
	repeat <array_size>
	if (<match_prev_text> = 1)
		if (<match_new_text> = 1)
			return \{true}
		endif
	endif
	return \{false}
endscript

script reset_to_default 

	mask = (<section>.mask)
	set_cap_flags mask = ((<mask>) [<mask_index>])
	if StructureContains Structure = <section> pre_userlayer
		reset_to_default_helper mask_entry = ((<mask>) [<mask_index>]) flags = <flags> section = <section>
		set_CAP part = <part> section = <section> pre_layer = <layer> mask_index = <mask_index>
	endif
	if StructureContains Structure = <section> post_userlayer
		reset_to_default_helper mask_entry = ((<mask>) [<mask_index>]) flags = <flags> section = <section>
		set_CAP part = <part> section = <section> post_layer = <layer> mask_index = <mask_index>
	endif
	reset_widgets layer = <layer>
endscript

script reset_to_default_helper 

	if StructureContains Structure = <mask_entry> pattern
		FixImagePath path = (<mask_entry>.pattern)
		layer = {texture = <name>}
	elseif StructureContains Structure = <mask_entry> font
		layer = {font = (<mask_entry>.font)
			text = (<mask_entry>.text)}
	endif
	if NOT (<flags> = 0)
		layer = {<layer>
			flags = <flags>}
	endif
	if StructureContains Structure = <section> initial_values
		layer = {<layer> (<section>.initial_values)}
	endif
	if StructureContains Structure = <mask_entry> initial_values
		layer = {<layer> (<mask_entry>.initial_values)}
	endif
	return layer = <layer>
endscript

script add_layer_to_profile 

	if NOT GetCASAppearancePart part = <part>

	endif
	set_cap_flags mask = (<mask>)
	if StructureContains Structure = <mask> pattern
		FixImagePath path = (<mask>.pattern)
		layer = {texture = <name>}
	elseif StructureContains Structure = <mask> font
		layer = {font = (<mask>.font)
			text = (<mask>.text)}
	endif
	if NOT (<flags> = 0)
		layer = {<layer>
			flags = <flags>}
	endif
	if StructureContains Structure = <section> initial_values
		initial_values = (<section>.initial_values)
		layer = {<layer>
			<initial_values>}
		if ((StructureContains Structure = initial_values x_trans) || (StructureContains Structure = initial_values y_trans))
			no_average = 1
		endif
	endif
	if StructureContains Structure = (<mask>) initial_values
		initial_values = ((<mask>).initial_values)
		layer = {<layer>
			((<mask>).initial_values)}
		if ((StructureContains Structure = initial_values x_trans) || (StructureContains Structure = initial_values y_trans))
			no_average = 1
		endif
	endif
	if StructureContains Structure = <section> center
		x_trans = (50 - (<section>.center [0]))
		y_trans = (50 - (<section>.center [1]))
		CastToInteger \{x_trans}
		CastToInteger \{y_trans}
		if NOT (<x_trans> = 0)
			layer = {<layer>
				x_trans = <x_trans>}
		endif
		if NOT (<y_trans> = 0)
			layer = {<layer>
				y_trans = <y_trans>}
		endif
	endif
	if GotParam \{cap}
		GetArraySize (cap)
		cap_array_size = <array_size>
		if (<cap_array_size> > 0)
			i = 0
			begin
			FormatText checksumname = name '%s' s = (<section>.base_tex)
			if is_matching_section cap = (<cap> [<i>]) section = <section>
				if StructureContains Structure = (<cap> [<i>]) layers
					GetArraySize (((<cap> [<i>]).layers))
					AddArrayElement array = ((<cap> [<i>]).layers) element = <layer>
					new_layers = <array>
					SetArrayElement ArrayName = cap index = <i> newvalue = {
						(<cap> [<i>])
						layers = <new_layers>
					}
					SetCASAppearanceCAP part = <part> cap = <cap>
					UpdateCASModelCAP part = <part>
					return cap_index = <i> layer_index = <array_size>
				else
					SetArrayElement ArrayName = cap index = <i> newvalue = {
						(<cap> [<i>])
						layers = [{<layer>}]
					}
					SetCASAppearanceCAP part = <part> cap = <cap>
					UpdateCASModelCAP part = <part>
					return cap_index = <i> layer_index = 0
				endif
			endif
			i = (<i> + 1)
			repeat <cap_array_size>
		endif
		FormatText checksumname = name '%s' s = (<section>.base_tex)
		entry = {
			base_tex = <name>
			material = (<section>.material)
			layers = [{<layer>}]
		}
		cap_set_target entry = <entry> section = <section>
		AddArrayElement array = <cap> element = <entry>
		<cap> = <array>
		SetCASAppearanceCAP part = <part> cap = <cap>
		UpdateCASModelCAP part = <part>
		return cap_index = (<cap_array_size>) layer_index = 0
	endif
	FormatText checksumname = name '%s' s = (<section>.base_tex)
	new_layers = [{<layer>}]
	entry = {
		base_tex = <name>
		material = (<section>.material)
		layers = <new_layers>
	}
	cap_set_target entry = <entry> section = <section>
	cap = [{<entry>}]
	SetCASAppearanceCAP part = <part> cap = <cap>
	UpdateCASModelCAP part = <part>
	return \{cap_index = 0
		layer_index = 0}
endscript

script match_layers_texture 

	GetArraySize (sections)
	sections_size = <array_size>
	i = 0
	begin
	if StructureContains Structure = (<sections> [<i>]) mask
		if section_has_target_and_material section = (<sections> [<i>]) target = <target> material = <material>
			mask = (<sections> [<i>].mask)
			if IsArray (mask)
				GetArraySize (mask)
				mask_size = <array_size>
				j = 0
				begin
				if StructureContains Structure = ((<mask>) [<j>]) pattern
					FixImagePath path = ((<mask>) [<j>].pattern)
					if (<name> = <prof_texture>)
						return mask = ((<mask>) [<j>]) section_index = <i> mask_index = <j>
					endif
				endif
				j = (<j> + 1)
				repeat <mask_size>
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <sections_size>
endscript

script match_layers_font 

	GetArraySize (sections)
	sections_size = <array_size>
	i = 0
	begin
	if StructureContains Structure = (<sections> [<i>]) mask
		if section_has_target_and_material section = (<sections> [<i>]) target = <target> material = <material>
			mask = (<sections> [<i>].mask)
			if IsArray (mask)
				GetArraySize (mask)
				mask_size = <array_size>
				j = 0
				begin
				if StructureContains Structure = ((<mask>) [<j>]) font
					if ChecksumEquals a = ((<mask>) [<j>].font) b = <prof_font>
						if (<prof_text> = ((<mask>) [<j>].text))
							return mask = ((<mask>) [<j>]) section_index = <i> mask_index = <j>
						endif
					endif
				endif
				j = (<j> + 1)
				repeat <mask_size>
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <sections_size>
endscript

script GetLayer 
	if NOT GetCASAppearancePart part = <part>

	endif
	if NOT CD
		GetArraySize <cap>
		if (<cap_index> > (<array_size> -1))

		endif
		GetArraySize ((<cap> [<cap_index>]).layers)
		if (<layer_index> > (<array_size> -1))

		endif
	endif
	if GotParam \{cap}
		if StructureContains Structure = (((<cap> [<cap_index>]).layers) [<layer_index>]) texture
			layer = {texture = ((((<cap> [<cap_index>]).layers) [<layer_index>]).texture)}
		elseif StructureContains Structure = (((<cap> [<cap_index>]).layers) [<layer_index>]) font
			layer = {font = ((((<cap> [<cap_index>]).layers) [<layer_index>]).font)
				text = ((((<cap> [<cap_index>]).layers) [<layer_index>]).text)}
		endif
		layer = {
			<layer>
			color = ((((<cap> [<cap_index>]).layers) [<layer_index>]).color)
			a = ((((<cap> [<cap_index>]).layers) [<layer_index>]).a)
			x_trans = ((((<cap> [<cap_index>]).layers) [<layer_index>]).x_trans)
			y_trans = ((((<cap> [<cap_index>]).layers) [<layer_index>]).y_trans)
			x_skew = ((((<cap> [<cap_index>]).layers) [<layer_index>]).x_skew)
			y_skew = ((((<cap> [<cap_index>]).layers) [<layer_index>]).y_skew)
			x_scale = ((((<cap> [<cap_index>]).layers) [<layer_index>]).x_scale)
			y_scale = ((((<cap> [<cap_index>]).layers) [<layer_index>]).y_scale)
			rot = ((((<cap> [<cap_index>]).layers) [<layer_index>]).rot)
			flags = ((((<cap> [<cap_index>]).layers) [<layer_index>]).flags)
		}
		return layer = <layer>
	endif
	return \{layer = {
		}}
endscript

script SetLayer 

	if NOT GetCASAppearancePart part = <part>

	endif
	if GotParam \{cap}
		old_layers = ((<cap> [<cap_index>]).layers)
		SetArrayElement ArrayName = old_layers index = <layer_index> newvalue = <layer>
		SetArrayElement ArrayName = cap index = <cap_index> newvalue = {
			(<cap> [<cap_index>])
			layers = <old_layers>
		}
		SetCASAppearanceCAP part = <part> cap = <cap>
		UpdateCASModelCAP part = <part> nounload
	endif
endscript

script reset_layer_to_default 

	GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
	set_cap_flags mask = (<mask>)
	if StructureContains Structure = <mask> pattern
		FixImagePath path = (<mask>.pattern)
		layer = {texture = <name>}
	elseif StructureContains Structure = <mask> font
		layer = {font = (<mask>.font) text = (<mask>.text)}
	endif
	if NOT (<flags> = 0)
		layer = {<layer>
			flags = <flags>}
	endif
	if StructureContains Structure = <section> initial_values
		layer = {<layer> (<section>.initial_values)}
	endif
	if StructureContains Structure = <mask> initial_values
		layer = {<layer> (<mask>.initial_values)}
	endif
	SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
	reset_widgets layer = <layer>
	reset_flip_buttons part = <part> cap_index = <cap_index> layer_index = <layer_index>
endscript

script delete_layer 

	if NOT GetCASAppearancePart part = <part>

	endif
	if GotParam \{cap}
		RemoveArrayElement array = ((<cap> [<cap_index>]).layers) index = <layer_index>
		SetArrayElement ArrayName = cap index = <cap_index> newvalue = {
			(<cap> [<cap_index>])
			layers = <array>
		}
		GetArraySize (array)
		if (<array_size> = 0)
			cap_struct = (<cap> [<cap_index>])
			if ((StructureContains Structure = <cap_struct> pre_layer) || (StructureContains Structure = <cap_struct> post_layer))
				capstruct = (<cap> [<cap_index>])
				RemoveComponent \{name = layers
					structure_name = capstruct}
				SetArrayElement ArrayName = cap index = <cap_index> newvalue = <capstruct>
			else
				RemoveArrayElement array = (<cap>) index = <cap_index>
				cap = <array>
			endif
		endif
		GetArraySize (cap)
		if (<array_size> = 0)
			SetCASAppearanceCAP part = <part>
		else
			SetCASAppearanceCAP part = <part> cap = <cap>
		endif
		if NOT GotParam \{skip_build}
			UpdateCASModelCAP part = <part>
		endif
	endif
endscript
has_user_layers = ASSERT_ON_USE

script get_proper_location 

	if GotParam \{pre_layer}
		GetArraySize (pre_layer)
		i = 0
		begin
		if NOT is_pre_layer_before_section section = <section> pre_layer = (<pre_layer> [<i>]) part = <part>
			return index = <i>
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	if GotParam \{post_layer}
		GetArraySize (post_layer)
		i = 0
		begin
		if NOT is_pre_layer_before_section section = <section> post_layer = (<post_layer> [<i>]) part = <part>
			return index = <i>
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
endscript

script is_pre_layer_before_section 

	if GotParam \{pre_layer}
		get_section_index_of_pre_layer pre_layer = <pre_layer> section = <section> part = <part>
	endif
	if GotParam \{post_layer}
		get_section_index_of_pre_layer post_layer = <post_layer> section = <section> part = <part>
	endif
	if ((GotParam pre_layer_section_index) && (GotParam section_index))
		if (<pre_layer_section_index> < <section_index>)
			return \{true}
		else
			return \{false}
		endif
	endif
endscript

script get_section_index_of_pre_layer 
	if NOT GetCASAppearancePart part = <part>

	endif
	if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>

	endif
	if GotParam \{sections}
		if GotParam \{pre_layer}
			if StructureContains Structure = <pre_layer> texture
				match_layers_texture prof_texture = (<pre_layer>.texture) sections = <sections>
			elseif StructureContains Structure = <pre_layer> font
				match_layers_font prof_font = (<pre_layer>.font) prof_text = (<pre_layer>.text) sections = <sections>
			endif
			GetArraySize (sections)
			i = 0
			begin
			if ((<sections> [<i>].mask) = (<section>.mask))
				return pre_layer_section_index = <section_index> section_index = <i>
			endif
			i = (<i> + 1)
			repeat <array_size>
		endif
		if GotParam \{post_layer}
			if StructureContains Structure = <post_layer> texture
				match_layers_texture prof_texture = (<post_layer>.texture) sections = <sections>
			elseif StructureContains Structure = <post_layer> font
				match_layers_font prof_font = (<post_layer>.font) prof_text = (<post_layer>.text) sections = <sections>
			endif
			GetArraySize (sections)
			i = 0
			begin
			if ((<sections> [<i>].mask) = (<section>.mask))
				return pre_layer_section_index = <section_index> section_index = <i>
			endif
			i = (<i> + 1)
			repeat <array_size>
		endif
	else

	endif
endscript

script set_cap_flags 

	flags = 0
	if StructureContains Structure = <mask> clamp_u
		flags = (<flags> || 1)
	endif
	if StructureContains Structure = <mask> clamp_v
		flags = (<flags> || 2)
	endif
	if StructureContains Structure = <mask> clamp_uv
		flags = 3
	endif
	if StructureContains Structure = <mask> static_alpha
		flags = (<flags> || 4)
	endif
	if StructureContains Structure = <mask> wrap_texture
		flags = (<flags> || 32)
	endif
	return flags = <flags>
endscript

script flip_layer_horizontal 
	if NOT GetCASAppearancePart part = <part>

	endif
	layer = (((<cap> [<cap_index>]).layers) [<layer_index>])
	if GotParam \{cap}
		if StructureContains Structure = <layer> flags
			if ((<layer>.flags) && 8)
				newflags = ((<layer>.flags) && -9)
				layer = {<layer>
					flags = <newflags>}
			else
				newflags = ((<layer>.flags) || 8)
				layer = {<layer>
					flags = <newflags>}
			endif
		else
			layer = {<layer>
				flags = 8}
		endif
	endif
	old_layers = ((<cap> [<cap_index>]).layers)
	SetArrayElement ArrayName = old_layers index = <layer_index> newvalue = <layer>
	SetArrayElement ArrayName = cap index = <cap_index> newvalue = {
		(<cap> [<cap_index>])
		layers = <old_layers>
	}
	SetCASAppearanceCAP part = <part> cap = <cap>
	UpdateCASModelCAP part = <part>
endscript

script is_flip_layer_horizontal 
	if NOT GetCASAppearancePart part = <part>

	endif
	layer = (((<cap> [<cap_index>]).layers) [<layer_index>])
	if GotParam \{cap}
		if StructureContains Structure = <layer> flags
			if ((<layer>.flags) && 8)
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script flip_layer_vertical 
	if NOT GetCASAppearancePart part = <part>

	endif
	layer = (((<cap> [<cap_index>]).layers) [<layer_index>])
	if GotParam \{cap}
		if StructureContains Structure = <layer> flags
			if ((<layer>.flags) && 16)
				newflags = ((<layer>.flags) && -17)
				layer = {<layer>
					flags = <newflags>}
			else
				newflags = ((<layer>.flags) || 16)
				layer = {<layer>
					flags = <newflags>}
			endif
		else
			layer = {<layer>
				flags = 8}
		endif
	endif
	old_layers = ((<cap> [<cap_index>]).layers)
	SetArrayElement ArrayName = old_layers index = <layer_index> newvalue = <layer>
	SetArrayElement ArrayName = cap index = <cap_index> newvalue = {
		(<cap> [<cap_index>])
		layers = <old_layers>
	}
	SetCASAppearanceCAP part = <part> cap = <cap>
	UpdateCASModelCAP part = <part>
endscript

script is_flip_layer_vertical 
	if NOT GetCASAppearancePart part = <part>

	endif
	layer = (((<cap> [<cap_index>]).layers) [<layer_index>])
	if GotParam \{cap}
		if StructureContains Structure = <layer> flags
			if ((<layer>.flags) && 16)
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script UpdateCASModelCAP 
	CASUpdateUnloads
	if NOT GotParam \{part}

	endif
	UpdateCurrentCASModel buildScript = update_cap_part buildscriptparams = {part = <part>}
	if NOT GotParam \{nounload}
		CASTemporariesFlush \{group = cap}
	endif
endscript

script is_matching_section 
	FormatText checksumname = name '%s' s = (<section>.base_tex)
	if (((<cap>.material) = (<section>.material)) && ((<cap>.base_tex) = <name>))
		if ((StructureContains Structure = <section> normal_map) && (StructureContains Structure = <cap> normal_map))
			return \{true}
		elseif ((StructureContains Structure = <section> Cas_1) && (StructureContains Structure = <cap> Cas_1))
			return \{true}
		elseif ((StructureContains Structure = <section> cas_2) && (StructureContains Structure = <cap> cas_2))
			return \{true}
		elseif ((StructureContains Structure = <section> specular) && (StructureContains Structure = <cap> specular))
			return \{true}
		elseif ((StructureContains Structure = <section> diffuse) && (StructureContains Structure = <cap> diffuse))
			return \{true}
		else
			return \{false}
		endif
	endif
	return \{false}
endscript

script cap_set_target 

	if StructureContains Structure = <section> normal_map
		entry = {<entry>
			normal_map}
	elseif StructureContains Structure = <section> Cas_1
		entry = {<entry>
			Cas_1}
	elseif StructureContains Structure = <section> cas_2
		entry = {<entry>
			cas_2}
	elseif StructureContains Structure = <section> specular
		entry = {<entry>
			specular}
	elseif StructureContains Structure = <section> diffuse
		entry = {<entry>
			diffuse}
	else
		entry = {<entry>
			diffuse}
	endif
	return entry = <entry>
endscript

script is_target_in_div 

	if NOT GetCASAppearancePart part = <part>

	endif
	if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>

	endif
	if NOT GotParam \{divisions}
		return \{true}
	elseif NOT GotParam \{div_id}
		return \{true}
	else
		GetArraySize \{divisions}
		if (<array_size> > 0)
			i = 0
			begin
			if ((<divisions> [<i>].desc_id) = <div_id>)
				if ((<target>.material) = (<divisions> [<i>].material))
					if StructureContains Structure = <target> (<divisions> [<i>].target)
						return \{true}
					endif
				endif
			endif
			i = (<i> + 1)
			repeat <array_size>
		endif
	endif
	return \{false}
endscript

script get_div_info 

	if NOT GotParam \{div_id}
		return
	endif
	if NOT GetCASAppearancePart part = <part>

	endif
	if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>

	endif
	if GotParam \{divisions}
		GetArraySize \{divisions}
		if (<array_size> > 0)
			i = 0
			begin
			if ((<divisions> [<i>].desc_id) = <div_id>)
				return target = (<divisions> [<i>].target) material = (<divisions> [<i>].material)
			endif
			i = (<i> + 1)
			repeat <array_size>
		endif
	endif
endscript

script section_has_target_and_material 

	if NOT GotParam \{target}
		return \{true}
	elseif NOT GotParam \{material}
		return \{true}
	else
		if StructureContains Structure = <section> <target>
			if ChecksumEquals a = (<section>.material) b = <material>
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script add_cap_array_to_part 

	if NOT GetActualCASOptionStruct part = <part> desc_id = (<newstruct>.desc_id)

	endif
	if GotParam \{default_cap}
		newstruct = {<newstruct>
			cap = <default_cap>}
		return newstruct = <newstruct>
	endif
endscript

script cap_artist_colorwheel_focus_change 
	get_CAP part = <part> section = <section> mask_index = <mask_index>
	if GotParam \{pre_layer}
		pre_layer = {<pre_layer>
			color = <color>}
		set_CAP part = <part> section = <section> pre_layer = <pre_layer> mask_index = <mask_index>
	endif
	if GotParam \{post_layer}
		post_layer = {<post_layer>
			color = <color>}
		set_CAP part = <part> section = <section> post_layer = <post_layer> mask_index = <mask_index>
	endif
endscript

script unfocus_color_wheel 
	color_slice_back
	color_wheel_back \{skip_exit_script}
	widget_accept_cap part = <part>
endscript

script cap_get_current_rgb 

	get_CAP part = <part> section = <section> mask_index = <mask_index>
	if GotParam \{pre_layer}
		if StructureContains Structure = <pre_layer> color
			rgba = ((($color_lookup_table).(<pre_layer>.color)).diffuse)
		else
			AddArrayElement array = [] element = ($default_cap_red)
			AddArrayElement array = <array> element = ($default_cap_green)
			AddArrayElement array = <array> element = ($default_cap_blue)
			rgba = <array>
		endif
	else
		if StructureContains Structure = <post_layer> color
			rgba = ((($color_lookup_table).(<post_layer>.color)).diffuse)
		else
			AddArrayElement array = [] element = ($default_cap_red)
			AddArrayElement array = <array> element = ($default_cap_green)
			AddArrayElement array = <array> element = ($default_cap_blue)
			rgba = <array>
		endif
	endif
	return rgb = <rgba>
endscript

script cap_no_transforms 

	if StructureContains Structure = <mask> no_edit_options
		return \{true}
	elseif NOT StructureContains Structure = <mask> no_color
		return \{false}
	elseif NOT StructureContains Structure = <mask> no_alpha
		return \{false}
	elseif NOT StructureContains Structure = <mask> no_translate
		return \{false}
	elseif NOT StructureContains Structure = <mask> no_scale
		return \{false}
	elseif NOT StructureContains Structure = <mask> no_rotate
		return \{false}
	elseif NOT StructureContains Structure = <mask> no_skew
		return \{false}
	elseif NOT StructureContains Structure = <mask> no_u_flip
		return \{false}
	elseif NOT StructureContains Structure = <mask> no_v_flip
		return \{false}
	else
		return \{true}
	endif
endscript

script cap_populate_layer 
	GetArraySize <cap_entry>
	j = 0
	begin
	cap_entry_struct = (<cap_entry> [<j>])
	if ((StructureContains Structure = <cap_entry_struct> texture) && (StructureContains Structure = <mask_entry> pattern))
		FixImagePath path = (<mask_entry>.pattern)
		if (((<cap_entry> [<j>]).texture) = <name>)
			FixImagePath path = (<mask_entry>.pattern)
			layer = {
				texture = <name>
				color = ((<cap_entry> [<j>]).color)
				a = ((<cap_entry> [<j>]).a)
				x_trans = ((<cap_entry> [<j>]).x_trans)
				y_trans = ((<cap_entry> [<j>]).y_trans)
				x_scale = ((<cap_entry> [<j>]).x_scale)
				y_scale = ((<cap_entry> [<j>]).y_scale)
				rot = ((<cap_entry> [<j>]).rot)
				flags = ((<cap_entry> [<j>]).flags)
				x_skew = ((<cap_entry> [<j>]).x_skew)
				y_skew = ((<cap_entry> [<j>]).y_skew)
			}
			if NOT (<flags> = 0)
				layer = {<layer>
					flags = <flags>}
			endif
			return layer = <layer>
		endif
	elseif ((StructureContains Structure = <cap_entry_struct> font) && (StructureContains Structure = <mask_entry> font))
		layer = {
			font = (<mask_entry>.font)
			text = (<mask_entry>.text)
			color = ((<cap_entry> [<j>]).color)
			a = ((<cap_entry> [<j>]).a)
			x_trans = ((<cap_entry> [<j>]).x_trans)
			y_trans = ((<cap_entry> [<j>]).y_trans)
			x_scale = ((<cap_entry> [<j>]).x_scale)
			y_scale = ((<cap_entry> [<j>]).y_scale)
			rot = ((<cap_entry> [<j>]).rot)
			flags = ((<cap_entry> [<j>]).flags)
			x_skew = ((<cap_entry> [<j>]).x_skew)
			y_skew = ((<cap_entry> [<j>]).y_skew)
		}
		if NOT (<flags> = 0)
			layer = {<layer>
				flags = <flags>}
		endif
		return layer = <layer>
	endif
	j = (<j> + 1)
	repeat <array_size>
endscript

script cap_new_artist_layer 
	if StructureContains Structure = <mask_entry> pattern
		FixImagePath path = (<mask_entry>.pattern)
		layer = {texture = <name>}
	elseif StructureContains Structure = <mask_entry> font
		layer = {font = (<mask_entry>.font) text = (<mask_entry>.text)}
	endif
	if NOT (<flags> = 0)
		layer = {<layer>
			flags = <flags>}
	endif
	if StructureContains Structure = <section> center
		x_trans = (50 - (<section>.center [0]))
		y_trans = (50 - (<section>.center [1]))
		CastToInteger \{x_trans}
		CastToInteger \{y_trans}
		if NOT (<x_trans> = 0)
			layer = {<layer>
				x_trans = <x_trans>}
		endif
		if NOT (<y_trans> = 0)
			layer = {<layer>
				y_trans = <y_trans>}
		endif
	endif
	return layer = <layer>
endscript

script cap_color_wheel_focus_change_color 
	GetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index>
	layer = {<layer>
		color = <color>}
	SetLayer part = <part> cap_index = <cap_index> layer_index = <layer_index> layer = <layer>
endscript

script reset_widgets 

	if StructureContains Structure = <layer> a
		button_widget_set_value widget_id = alpha_widget new_value = (<layer>.a)
	else
		button_widget_set_value widget_id = alpha_widget new_value = ($default_cap_alpha)
	endif
	if StructureContains Structure = <layer> x_trans
		button_widget_set_value widget_id = x_trans_widget new_value = (<layer>.x_trans)
	else
		button_widget_set_value widget_id = x_trans_widget new_value = ($default_cap_trans)
	endif
	if StructureContains Structure = <layer> y_trans
		button_widget_set_value widget_id = y_trans_widget new_value = (<layer>.y_trans)
	else
		button_widget_set_value widget_id = y_trans_widget new_value = ($default_cap_trans)
	endif
	if StructureContains Structure = <layer> x_scale
		button_widget_set_value widget_id = x_scale_widget new_value = (<layer>.x_scale)
	else
		button_widget_set_value widget_id = x_scale_widget new_value = ($default_cap_scale)
	endif
	if StructureContains Structure = <layer> y_scale
		button_widget_set_value widget_id = y_scale_widget new_value = (<layer>.y_scale)
	else
		button_widget_set_value widget_id = y_scale_widget new_value = ($default_cap_scale)
	endif
	if StructureContains Structure = <layer> rot
		rotate_widget_set_value widget_id = rot_widget new_value = (<layer>.rot)
	else
		rotate_widget_set_value widget_id = rot_widget new_value = ($default_cap_rot)
	endif
	if StructureContains Structure = <layer> x_skew
		button_widget_set_value widget_id = x_skew_widget new_value = (<layer>.x_skew)
	else
		button_widget_set_value widget_id = x_skew_widget new_value = ($default_cap_skew)
	endif
	if StructureContains Structure = <layer> y_skew
		button_widget_set_value widget_id = y_skew_widget new_value = (<layer>.y_skew)
	else
		button_widget_set_value widget_id = y_skew_widget new_value = ($default_cap_skew)
	endif
	if ((StructureContains Structure = <layer> x_scale) && (StructureContains Structure = <layer> y_scale))
		MathMax a = (<layer>.x_scale) b = (<layer>.y_scale)
		button_widget_set_value widget_id = uni_scale_widget new_value = <max>
	endif
endscript

script reset_flip_buttons 
	if is_flip_layer_horizontal part = <part> cap_index = <cap_index> layer_index = <layer_index>
		button_generic_set_value \{id = flip_horiz_widget
			new_value = true}
	else
		button_generic_set_value \{id = flip_horiz_widget
			new_value = false}
	endif
	if is_flip_layer_vertical part = <part> cap_index = <cap_index> layer_index = <layer_index>
		button_generic_set_value \{id = flip_vert_widget
			new_value = true}
	else
		button_generic_set_value \{id = flip_vert_widget
			new_value = false}
	endif
endscript

script widget_restore_cap 
	widget_accept_cap <...>
endscript

script widget_init_cap 
	clean_up_user_control_helpers
	if GotParam \{part}
		if ChecksumEquals a = <part> b = CAS_Band_Logo
			menu_finish \{car_helper_text_cancel
				no_rotate_zoom_text}
		else
			menu_finish \{car_helper_text_cancel}
		endif
	else
		menu_finish \{car_helper_text_cancel}
	endif
endscript

script widget_accept_cap 
	clean_up_user_control_helpers
	if GotParam \{part}
		if ChecksumEquals a = <part> b = CAS_Band_Logo
			menu_finish \{car_helper_text_back
				no_rotate_zoom_text}
		else
			menu_finish \{car_helper_text_back}
		endif
	else
		menu_finish \{car_helper_text_back}
	endif
endscript

script restore_color_initial 
	clean_up_user_control_helpers
	if StructureContains \{Structure = add_params
			part}
		if ChecksumEquals a = (<add_params>.part) b = CAS_Band_Logo
			menu_finish \{car_helper_text_back
				no_rotate_zoom_text}
		else
			menu_finish \{car_helper_text_back}
		endif
	else
		menu_finish \{car_helper_text_back}
	endif
endscript
