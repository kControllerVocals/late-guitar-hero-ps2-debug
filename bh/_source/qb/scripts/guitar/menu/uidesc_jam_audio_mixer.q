uidesc_jam_audio_mixer = {
	DescVersion = 8
	name = uidesc_jam_audio_mixer
	rect = [
		0.0
		0.0
		1280.0
		720.0
	]
	aliases = [
		{
			path = [
				{
					validateLocalID = AudioMixer_master_container
				}
				{
					index = 0
					validateLocalID = audio_mixer_menu_container
					includeParentOwned = false
				}
				{
					index = 0
					validateLocalID = audio_mixer_menu
					includeParentOwned = false
				}
			]
			name = alias_audio_mixer_menu
		}
		{
			path = [
				{
					validateLocalID = AudioMixer_master_container
				}
				{
					index = 1
					validateLocalID = faders_container
					includeParentOwned = false
				}
			]
			name = alias_faders_container
		}
		{
			path = [
				{
					validateLocalID = AudioMixer_master_container
				}
				{
					index = 2
					validateLocalID = VU_lights_container
					includeParentOwned = false
				}
			]
			name = alias_VU_lights_container
		}
	]
	props = [
		{
			path = [
				{
					validateLocalID = AudioMixer_master_container
				}
				{
					index = 4
					validateLocalID = info_area
					includeParentOwned = false
				}
				{
					index = 1
					validateLocalID = mixer_info
					includeParentOwned = false
				}
			]
			name = mixer_info_text
			target = text
			type = string_wchar
		}
		{
			path = [
				{
					validateLocalID = AudioMixer_master_container
				}
				{
					index = 3
					validateLocalID = mixer_channel_lamp
					includeParentOwned = false
				}
			]
			name = mixer_channel_lamp_pos
			target = pos
			type = pair
		}
		{
			path = [
				{
					validateLocalID = AudioMixer_master_container
				}
				{
					index = 0
					validateLocalID = audio_mixer_menu_container
					includeParentOwned = false
				}
				{
					index = 1
					validateLocalID = mixer_menu_highlight
					includeParentOwned = false
				}
			]
			name = mixer_menu_highlight_pos
			target = pos
			type = pair
		}
		{
			path = [
				{
					validateLocalID = AudioMixer_master_container
				}
				{
					index = 0
					validateLocalID = audio_mixer_menu_container
					includeParentOwned = false
				}
				{
					index = 1
					validateLocalID = mixer_menu_highlight
					includeParentOwned = false
				}
			]
			name = mixer_menu_highlight_alpha
			target = alpha
			type = float
		}
		{
			path = [
				{
					validateLocalID = AudioMixer_master_container
				}
				{
					index = 3
					validateLocalID = mixer_channel_lamp
					includeParentOwned = false
				}
			]
			name = mixer_channel_lamp_alpha
			target = alpha
			type = float
		}
	]
	materials = [
	]
	FormatVersion = 2
	elements = {
		props = {
			local_id = AudioMixer_master_container
			type = ContainerElement
			hiddenLocal = false
			alpha = 1.0
			dims = (10.0, 10.0)
			just = [
				-1.0
				-1.0
			]
			pos_anchor = [
				-1.0
				-1.0
			]
			pos = (0.0, 0.0)
			z_priority = 0.0
			scale = (1.0, 1.0)
			rot_angle = 0.0
			rgba = [
				255
				255
				255
				255
			]
			events_blocked = 0
			preserve_local_orientation = false
		}
		children = [
			{
				props = {
					local_id = audio_mixer_menu_container
					type = ContainerElement
					hiddenLocal = false
					alpha = 1.0
					dims = (30.0, 30.0)
					just = [
						-1.0
						-1.0
					]
					pos_anchor = [
						-1.0
						-1.0
					]
					pos = (309.0, 373.0)
					z_priority = 1.0
					scale = (1.0, 1.0)
					rot_angle = 0.0
					rgba = [
						255
						255
						255
						255
					]
					events_blocked = 0
					preserve_local_orientation = false
				}
				children = [
					{
						props = {
							local_id = audio_mixer_menu
							type = MenuElement
							hiddenLocal = false
							alpha = 1.0
							dims = (120.0, 471.0)
							just = [
								0.0
								-1.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (-7.23233, -230.7677)
							z_priority = 1.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
							isVertical = true
							internal_just = [
								0.0
								0.0
							]
							regular_space_amount = -1
							padding_scale = 1.0
							spacing_between = 15
							position_children = true
							fit_major = `expand if content larger`
							fit_minor = `keep dims`
							scale_mode = proportional
							allow_wrap = true
							allow_alternate_directional_events = false
						}
						children = [
							{
								props = {
									local_id = menu_item_rhythm
									type = TextBlockElement
									hiddenLocal = false
									alpha = 1.0
									dims = (135.0, 30.0)
									just = [
										0.0
										0.0
									]
									pos_anchor = [
										-1.0
										-1.0
									]
									pos = (60.0, 145.5)
									z_priority = 3.0
									scale = (1.0, 1.0)
									rot_angle = 0.0
									rgba = [
										255
										255
										255
										255
									]
									events_blocked = 0
									preserve_local_orientation = false
									text = qs("RHYTHM")
									font = fontgrid_text_a3
									material = 0x00000000
									single_line = false
									fit_width = `scale each line if larger`
									fit_height = `scale down if larger`
									scale_mode = `per axis`
									text_case = Original
									internal_just = [
										0.0
										0.0
									]
									internal_scale = (1.0, 1.0)
									blend = blend
									font_spacing = -1
									override_color_tag_alpha = true
									override_color_tag_rgba = false
									use_shadow = true
									shadow_rgba = [
										0
										0
										0
										255
									]
									shadow_offs = (1.0, 1.0)
									line_spacing = 1.0
								}
							}
							{
								props = {
									local_id = menu_item_lead
									type = TextBlockElement
									hiddenLocal = false
									alpha = 1.0
									dims = (135.0, 30.0)
									just = [
										0.0
										0.0
									]
									pos_anchor = [
										-1.0
										-1.0
									]
									pos = (60.0, 190.5)
									z_priority = 3.0
									scale = (1.0, 1.0)
									rot_angle = 0.0
									rgba = [
										128
										128
										128
										255
									]
									events_blocked = 0
									preserve_local_orientation = false
									text = qs("LEAD")
									font = fontgrid_text_a3
									material = 0x00000000
									single_line = false
									fit_width = `scale each line if larger`
									fit_height = `scale down if larger`
									scale_mode = `per axis`
									text_case = Original
									internal_just = [
										0.0
										0.0
									]
									internal_scale = (1.0, 1.0)
									blend = blend
									font_spacing = -1
									override_color_tag_alpha = true
									override_color_tag_rgba = false
									use_shadow = true
									shadow_rgba = [
										0
										0
										0
										255
									]
									shadow_offs = (1.0, 1.0)
									line_spacing = 1.0
								}
							}
							{
								props = {
									local_id = menu_item_BASS
									type = TextBlockElement
									hiddenLocal = false
									alpha = 1.0
									dims = (135.0, 30.0)
									just = [
										0.0
										0.0
									]
									pos_anchor = [
										-1.0
										-1.0
									]
									pos = (60.0, 235.5)
									z_priority = 3.0
									scale = (1.0, 1.0)
									rot_angle = 0.0
									rgba = [
										128
										128
										128
										255
									]
									events_blocked = 0
									preserve_local_orientation = false
									text = qs("BASS")
									font = fontgrid_text_a3
									material = 0x00000000
									single_line = false
									fit_width = `scale each line if larger`
									fit_height = `scale down if larger`
									scale_mode = `per axis`
									text_case = Original
									internal_just = [
										0.0
										0.0
									]
									internal_scale = (1.0, 1.0)
									blend = blend
									font_spacing = -1
									override_color_tag_alpha = true
									override_color_tag_rgba = false
									use_shadow = true
									shadow_rgba = [
										0
										0
										0
										255
									]
									shadow_offs = (1.0, 1.0)
									line_spacing = 1.0
								}
							}
							{
								props = {
									local_id = menu_item_DRUMS
									type = TextBlockElement
									hiddenLocal = false
									alpha = 1.0
									dims = (135.0, 30.0)
									just = [
										0.0
										0.0
									]
									pos_anchor = [
										-1.0
										-1.0
									]
									pos = (60.0, 280.5)
									z_priority = 3.0
									scale = (1.0, 1.0)
									rot_angle = 0.0
									rgba = [
										128
										128
										128
										255
									]
									events_blocked = 0
									preserve_local_orientation = false
									text = qs("DRUMS")
									font = fontgrid_text_a3
									material = 0x00000000
									single_line = false
									fit_width = `scale each line if larger`
									fit_height = `scale down if larger`
									scale_mode = `per axis`
									text_case = Original
									internal_just = [
										0.0
										0.0
									]
									internal_scale = (1.0, 1.0)
									blend = blend
									font_spacing = -1
									override_color_tag_alpha = true
									override_color_tag_rgba = false
									use_shadow = true
									shadow_rgba = [
										0
										0
										0
										255
									]
									shadow_offs = (1.0, 1.0)
									line_spacing = 1.0
								}
							}
							{
								props = {
									local_id = menu_item_keyboard
									type = TextBlockElement
									hiddenLocal = false
									alpha = 1.0
									dims = (135.0, 30.0)
									just = [
										0.0
										0.0
									]
									pos_anchor = [
										-1.0
										-1.0
									]
									pos = (60.0, 325.5)
									z_priority = 3.0
									scale = (1.0, 1.0)
									rot_angle = 0.0
									rgba = [
										128
										128
										128
										255
									]
									events_blocked = 0
									preserve_local_orientation = false
									text = qs("KEYBOARD")
									font = fontgrid_text_a3
									material = 0x00000000
									single_line = false
									fit_width = `scale each line if larger`
									fit_height = `scale down if larger`
									scale_mode = `per axis`
									text_case = Original
									internal_just = [
										0.0
										0.0
									]
									internal_scale = (1.0, 1.0)
									blend = blend
									font_spacing = -1
									override_color_tag_alpha = true
									override_color_tag_rgba = false
									use_shadow = true
									shadow_rgba = [
										0
										0
										0
										255
									]
									shadow_offs = (1.0, 1.0)
									line_spacing = 1.0
								}
							}
						]
					}
					{
						props = {
							blend = blend
							texture = mixer_menu_highlight
							local_id = mixer_menu_highlight
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (170.0, 35.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (-11.0, -84.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							local_id = tape_stops
							type = ContainerElement
							hiddenLocal = false
							alpha = 1.0
							dims = (100.0, 100.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								0.0
								0.0
							]
							pos = (100.0, 116.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
						children = [
							{
								props = {
									blend = blend
									texture = mix_tape_001
									local_id = mix_tape_001
									type = SpriteElement
									hiddenLocal = false
									alpha = 1.0
									dims = (128.0, 64.0)
									just = [
										0.0
										0.0
									]
									pos_anchor = [
										0.0
										0.0
									]
									pos = (7.686188, 13.974128)
									z_priority = 5.0
									scale = (1.0, 1.0)
									rot_angle = 0.0
									rgba = [
										255
										255
										255
										255
									]
									events_blocked = 0
									preserve_local_orientation = false
								}
							}
							{
								props = {
									blend = blend
									texture = mix_tape_003
									local_id = mix_tape_003
									type = SpriteElement
									hiddenLocal = false
									alpha = 1.0
									dims = (128.0, 64.0)
									just = [
										0.0
										0.0
									]
									pos_anchor = [
										0.0
										0.0
									]
									pos = (131.35529, 14.540093)
									z_priority = 5.0
									scale = (1.0, 1.0)
									rot_angle = 0.0
									rgba = [
										255
										255
										255
										255
									]
									events_blocked = 0
									preserve_local_orientation = false
								}
							}
							{
								props = {
									blend = blend
									texture = mix_tape_004
									local_id = mix_tape_004
									type = SpriteElement
									hiddenLocal = false
									alpha = 1.0
									dims = (128.0, 64.0)
									just = [
										0.0
										0.0
									]
									pos_anchor = [
										0.0
										0.0
									]
									pos = (254.09332, 19.534332)
									z_priority = 5.0
									scale = (1.0, 1.0)
									rot_angle = 0.0
									rgba = [
										255
										255
										255
										255
									]
									events_blocked = 0
									preserve_local_orientation = false
								}
							}
							{
								props = {
									blend = blend
									texture = mix_tape_005
									local_id = mix_tape_005
									type = SpriteElement
									hiddenLocal = false
									alpha = 1.0
									dims = (128.0, 64.0)
									just = [
										0.0
										0.0
									]
									pos_anchor = [
										0.0
										0.0
									]
									pos = (379.98288, 21.246368)
									z_priority = 5.0
									scale = (1.0, 1.0)
									rot_angle = 0.0
									rgba = [
										255
										255
										255
										255
									]
									events_blocked = 0
									preserve_local_orientation = false
								}
							}
							{
								props = {
									blend = blend
									texture = mix_tape_006
									local_id = mix_tape_006
									type = SpriteElement
									hiddenLocal = false
									alpha = 1.0
									dims = (128.0, 64.0)
									just = [
										0.0
										0.0
									]
									pos_anchor = [
										0.0
										0.0
									]
									pos = (504.97412, 19.290956)
									z_priority = 6.0
									scale = (1.0, 1.0)
									rot_angle = 0.0
									rgba = [
										255
										255
										255
										255
									]
									events_blocked = 0
									preserve_local_orientation = false
								}
							}
						]
					}
				]
			}
			{
				props = {
					local_id = faders_container
					type = MenuElement
					hiddenLocal = false
					alpha = 1.0
					dims = (650.0, 550.0)
					just = [
						-1.0
						-1.0
					]
					pos_anchor = [
						-1.0
						-1.0
					]
					pos = (371.92297, 41.92405)
					z_priority = 1.0
					scale = (1.0, 1.0)
					rot_angle = 0.0
					rgba = [
						255
						255
						255
						255
					]
					events_blocked = 0
					preserve_local_orientation = false
					isVertical = false
					internal_just = [
						-1.0
						0.0
					]
					regular_space_amount = 125
					padding_scale = 1.0
					spacing_between = 0
					position_children = true
					fit_major = `expand if content larger`
					fit_minor = `keep dims`
					scale_mode = proportional
					allow_wrap = true
					allow_alternate_directional_events = false
				}
				children = [
					{
						props = {
							local_id = fader_rhythm_desc
							type = DescInterface
							hiddenLocal = false
							alpha = 1.0
							dims = (130.0, 550.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (62.5, 275.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
							desc = 'options_audio_mixer_fader_desc'
							autoSizeDims = true
							knob_highlight_alpha = 0.0
							mixer_knob_rot_angle = 90.0
							mixer_fader_highlight_alpha = 0.0
							mixer_fader_pos = (0.0, 0.0)
							mixer_icon_texture = mixer_icon_guitar
							mixer_knob_detent_texture = mixer_knob_three
							mixer_knob_container_alpha = 1.0
							mixer_icon_alpha = 1.0
							knob_highlight_rgba = [
								0
								250
								154
								255
							]
							mixer_fader_highlight_rgba = [
								0
								250
								154
								255
							]
							knob_note_text = qs("")
						}
					}
					{
						props = {
							local_id = fader_lead_desc
							type = DescInterface
							hiddenLocal = false
							alpha = 1.0
							dims = (130.0, 550.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (187.5, 275.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
							desc = 'options_audio_mixer_fader_desc'
							autoSizeDims = true
							knob_highlight_alpha = 0.0
							mixer_knob_rot_angle = 90.0
							mixer_fader_highlight_alpha = 0.0
							mixer_fader_pos = (0.0, 0.0)
							mixer_icon_texture = mixer_icon_guitar
							mixer_knob_detent_texture = mixer_knob_three
							mixer_knob_container_alpha = 1.0
							mixer_icon_alpha = 1.0
							knob_highlight_rgba = [
								0
								250
								154
								255
							]
							mixer_fader_highlight_rgba = [
								0
								250
								154
								255
							]
							knob_note_text = qs("")
						}
					}
					{
						props = {
							local_id = fader_bass_desc
							type = DescInterface
							hiddenLocal = false
							alpha = 1.0
							dims = (130.0, 550.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (312.5, 275.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
							desc = 'options_audio_mixer_fader_desc'
							autoSizeDims = true
							knob_highlight_alpha = 0.0
							mixer_knob_rot_angle = 90.0
							mixer_fader_highlight_alpha = 0.0
							mixer_fader_pos = (0.0, 0.0)
							mixer_icon_texture = mixer_icon_bass
							mixer_knob_detent_texture = mixer_knob_three
							mixer_knob_container_alpha = 1.0
							mixer_icon_alpha = 1.0
							knob_highlight_rgba = [
								0
								250
								154
								255
							]
							mixer_fader_highlight_rgba = [
								0
								250
								154
								255
							]
							knob_note_text = qs("")
						}
					}
					{
						props = {
							local_id = fader_drums_desc
							type = DescInterface
							hiddenLocal = false
							alpha = 1.0
							dims = (130.0, 550.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (437.5, 275.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
							desc = 'options_audio_mixer_fader_desc'
							autoSizeDims = true
							knob_highlight_alpha = 0.0
							mixer_knob_rot_angle = 90.0
							mixer_fader_highlight_alpha = 0.0
							mixer_fader_pos = (0.0, 0.0)
							mixer_icon_texture = mixer_icon_drums
							mixer_knob_detent_texture = mixer_knob_three
							mixer_knob_container_alpha = 1.0
							mixer_icon_alpha = 1.0
							knob_highlight_rgba = [
								0
								250
								154
								255
							]
							mixer_fader_highlight_rgba = [
								0
								250
								154
								255
							]
							knob_note_text = qs("")
						}
					}
					{
						props = {
							local_id = fader_keyboard_desc
							type = DescInterface
							hiddenLocal = false
							alpha = 1.0
							dims = (130.0, 550.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (562.5, 275.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
							desc = 'options_audio_mixer_fader_desc'
							autoSizeDims = true
							knob_highlight_alpha = 0.0
							mixer_knob_rot_angle = 90.0
							mixer_fader_highlight_alpha = 0.0
							mixer_fader_pos = (0.0, 0.0)
							mixer_icon_texture = mixer_icon_crowd
							mixer_knob_detent_texture = mixer_knob_three
							mixer_knob_container_alpha = 1.0
							mixer_icon_alpha = 1.0
							knob_highlight_rgba = [
								0
								250
								154
								255
							]
							mixer_fader_highlight_rgba = [
								0
								250
								154
								255
							]
							knob_note_text = qs("")
						}
					}
				]
			}
			{
				props = {
					local_id = VU_lights_container
					type = MenuElement
					hiddenLocal = false
					alpha = 1.0
					dims = (20.0, 245.0)
					just = [
						0.0
						0.0
					]
					pos_anchor = [
						0.0
						0.0
					]
					pos = (1010.41907, 388.98288)
					z_priority = 1.0
					scale = (1.0, 1.0)
					rot_angle = 180.0
					rgba = [
						255
						255
						255
						255
					]
					events_blocked = 0
					preserve_local_orientation = false
					isVertical = true
					internal_just = [
						0.0
						0.0
					]
					regular_space_amount = -1
					padding_scale = 1.0
					spacing_between = 5
					position_children = true
					fit_major = `expand if content larger`
					fit_minor = `keep dims`
					scale_mode = proportional
					allow_wrap = true
					allow_alternate_directional_events = false
				}
				children = [
					{
						props = {
							blend = blend
							texture = mixer_bulb
							local_id = mixer_bulb_01
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (20.0, 20.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (10.0, 10.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 180.0
							rgba = [
								0
								250
								154
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_bulb
							local_id = mixer_bulb_02
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (20.0, 20.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (10.0, 35.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 180.0
							rgba = [
								0
								250
								154
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_bulb
							local_id = mixer_bulb_03
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (20.0, 20.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (10.0, 60.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 180.0
							rgba = [
								0
								250
								154
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_bulb
							local_id = mixer_bulb_04
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (20.0, 20.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (10.0, 85.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 180.0
							rgba = [
								0
								250
								154
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_bulb
							local_id = mixer_bulb_05
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (20.0, 20.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (10.0, 110.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 180.0
							rgba = [
								0
								250
								154
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_bulb
							local_id = mixer_bulb_06
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (20.0, 20.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (10.0, 135.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 180.0
							rgba = [
								0
								250
								154
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_bulb
							local_id = mixer_bulb_07
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (20.0, 20.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (10.0, 160.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 180.0
							rgba = [
								218
								165
								32
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_bulb
							local_id = mixer_bulb_08
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (20.0, 20.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (10.0, 185.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 180.0
							rgba = [
								218
								165
								32
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_bulb
							local_id = mixer_bulb_09
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (20.0, 20.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (10.0, 210.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 180.0
							rgba = [
								255
								128
								128
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_bulb
							local_id = mixer_bulb_10
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (20.0, 20.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (10.0, 235.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 180.0
							rgba = [
								255
								128
								128
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
				]
			}
			{
				props = {
					texture = mixer_channel_lamp
					blend = Add
					local_id = mixer_channel_lamp
					type = SpriteElement
					hiddenLocal = false
					alpha = 1.0
					dims = (180.0, 650.0)
					just = [
						0.0
						-1.0
					]
					pos_anchor = [
						-1.0
						-1.0
					]
					pos = (436.35968, 0.0)
					z_priority = 3.0
					scale = (1.0, 1.0)
					rot_angle = 0.0
					rgba = [
						255
						255
						255
						255
					]
					events_blocked = 0
					preserve_local_orientation = false
				}
			}
			{
				props = {
					local_id = info_area
					type = ContainerElement
					hiddenLocal = false
					alpha = 1.0
					dims = (100.0, 100.0)
					just = [
						0.0
						0.0
					]
					pos_anchor = [
						0.0
						0.0
					]
					pos = (702.43353, 598.3912)
					z_priority = 1.0
					scale = (1.0, 1.0)
					rot_angle = 0.0
					rgba = [
						255
						255
						255
						255
					]
					events_blocked = 0
					preserve_local_orientation = false
				}
				children = [
					{
						props = {
							blend = blend
							texture = mixer_info_area
							local_id = mixer_info_frame
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (760.0, 100.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (50.265884, 50.26594)
							z_priority = 1.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							local_id = mixer_info
							type = TextBlockElement
							hiddenLocal = false
							alpha = 1.0
							dims = (600.00006, 70.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								0.0
								0.0
							]
							pos = (0.0, 0.0)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								128
								64
								64
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
							text = qs("USE THIS TO ADJUST THE VOLUME OF YOUR GUITAR")
							font = fontgrid_text_a6
							material = 0x00000000
							single_line = false
							fit_width = wrap
							fit_height = `scale down if larger`
							scale_mode = proportional
							text_case = Original
							internal_just = [
								0.0
								0.0
							]
							internal_scale = (1.0, 1.0)
							blend = blend
							font_spacing = -1
							override_color_tag_alpha = true
							override_color_tag_rgba = false
							use_shadow = false
							shadow_rgba = [
								0
								0
								0
								255
							]
							shadow_offs = (3.0, 3.0)
							line_spacing = 0.8
						}
					}
				]
			}
			{
				props = {
					blend = blend
					texture = mixer_BG
					local_id = mixer_BG
					type = SpriteElement
					hiddenLocal = false
					alpha = 1.0
					dims = (1280.0, 720.0)
					just = [
						-1.0
						-1.0
					]
					pos_anchor = [
						-1.0
						-1.0
					]
					pos = (0.0, 0.0)
					z_priority = 1.0
					scale = (1.0, 1.0)
					rot_angle = 0.0
					rgba = [
						255
						255
						255
						255
					]
					events_blocked = 0
					preserve_local_orientation = false
				}
			}
			{
				props = {
					local_id = mixer_screws
					type = ContainerElement
					hiddenLocal = false
					alpha = 1.0
					dims = (50.0, 50.0)
					just = [
						-1.0
						-1.0
					]
					pos_anchor = [
						-1.0
						-1.0
					]
					pos = (0.0, 0.0)
					z_priority = 3.0
					scale = (1.0, 1.0)
					rot_angle = 0.0
					rgba = [
						255
						255
						255
						255
					]
					events_blocked = 0
					preserve_local_orientation = false
				}
				children = [
					{
						props = {
							blend = blend
							texture = mixer_screw
							local_id = mixer_screw_TL
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (45.0, 45.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								0.0
								0.0
							]
							pos = (234.53175, 11.204512)
							z_priority = 3.0
							scale = (1.0, 1.0)
							rot_angle = 15.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_screw
							local_id = mixer_screw_BR
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (40.0, 40.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								0.0
								0.0
							]
							pos = (997.60016, 658.43823)
							z_priority = 3.0
							scale = (1.0, 1.0)
							rot_angle = 20.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_screw
							local_id = mixer_screw_TR
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (40.0, 40.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								0.0
								0.0
							]
							pos = (996.50964, 16.558783)
							z_priority = 3.0
							scale = (1.0, 1.0)
							rot_angle = -8.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							texture = mixer_screw
							local_id = mixer_screw_BL
							type = SpriteElement
							hiddenLocal = false
							alpha = 1.0
							dims = (55.0, 55.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								0.0
								0.0
							]
							pos = (230.9766, 655.83167)
							z_priority = 3.0
							scale = (1.0, 1.0)
							rot_angle = 5.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
				]
			}
			{
				props = {
					local_id = dividers
					type = ContainerElement
					hiddenLocal = false
					alpha = 1.0
					dims = (100.0, 100.0)
					just = [
						0.0
						0.0
					]
					pos_anchor = [
						0.0
						0.0
					]
					pos = (100.0, 100.0)
					z_priority = 1.0
					scale = (1.0, 1.0)
					rot_angle = 0.0
					rgba = [
						255
						255
						255
						255
					]
					events_blocked = 0
					preserve_local_orientation = false
				}
				children = [
					{
						props = {
							blend = blend
							local_id = divider_01
							type = SpriteElement
							hiddenLocal = false
							alpha = 0.2
							dims = (3.0, 540.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (329.962, 228.88602)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							local_id = divider_02
							type = SpriteElement
							hiddenLocal = false
							alpha = 0.2
							dims = (3.0, 540.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (442.962, 228.88602)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 1.5
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							local_id = divider_03
							type = SpriteElement
							hiddenLocal = false
							alpha = 0.2
							dims = (3.0, 540.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (570.96204, 228.88602)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 1.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							local_id = divider_04
							type = SpriteElement
							hiddenLocal = false
							alpha = 0.2
							dims = (3.0, 540.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (696.96204, 228.88602)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 2.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							local_id = divider_05
							type = SpriteElement
							hiddenLocal = false
							alpha = 0.2
							dims = (3.0, 540.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (817.96204, 228.88602)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.0
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
					{
						props = {
							blend = blend
							local_id = divider_06
							type = SpriteElement
							hiddenLocal = false
							alpha = 0.2
							dims = (3.0, 540.0)
							just = [
								0.0
								0.0
							]
							pos_anchor = [
								-1.0
								-1.0
							]
							pos = (935.96204, 228.88602)
							z_priority = 2.0
							scale = (1.0, 1.0)
							rot_angle = 0.5
							rgba = [
								255
								255
								255
								255
							]
							events_blocked = 0
							preserve_local_orientation = false
						}
					}
				]
			}
		]
	}
}
uidesc_jam_audio_mixer_nxgui = {
	WorkspaceForm = {
		ExpansionState = [
			1
			2
			9
			33
			37
			42
		]
	}
	EditMaterialForm = {
	}
}
