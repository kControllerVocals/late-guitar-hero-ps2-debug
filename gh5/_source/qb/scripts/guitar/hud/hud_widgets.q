hide_rockmeter_ind_health = 1

script HUD_attach_widget_band_meter \{local_id = rock_meter
		pos = (0.0, 0.0)}

	if NOT ResolveScreenElementId id = <parent> param = id
		return
	endif
	<id> :Desc_ResolveAlias name = alias_glow param = glow_id
	if ($current_num_players = 1)
		health_input = {
			object = player1_status
			value = health
		}
	else
		health_input = {
			value = band_health
		}
	endif
	AttachHudWidget {
		Input = <health_input>
		outputs = [
			{
				type = DescPropertyFloat
				desc_id = <id>
				Property = needle_rot_angle
				value_range = [0.0 2.0]
				range = [-66.0 66.0]
				single
			}
			{
				type = ScreenElementConditionalFloat
				desc_id = <id>
				Property = red_light_alpha
				value_range = [0.0 0.6666]
			}
			{
				type = ScreenElementConditionalFloat
				desc_id = <id>
				Property = yellow_light_alpha
				value_range = [0.6666 1.3333]
			}
			{
				type = ScreenElementConditionalFloat
				desc_id = <id>
				Property = green_light_alpha
				value_range = [1.3333 2.0]
			}
			{
				type = ScreenElementConditionalFloat
				desc_id = <id>
				Property = hud_meter_red_bg_alpha
				value_range = [0.0 0.6666]
			}
			{
				type = ScreenElementConditionalFloat
				desc_id = <id>
				Property = hud_meter_yellow_bg_alpha
				value_range = [0.6666 1.3333]
			}
			{
				type = ScreenElementConditionalFloat
				desc_id = <id>
				Property = hud_meter_green_bg_alpha
				value_range = [1.3333 2.0]
			}
		]
	}
	if ($current_num_players = 1)
		AttachHudWidget {
			Input = {
				object = player1_status
				value = score
			}
			output = {
				type = SEIntToString
				desc_id = <id>
				Property = score_text
			}
		}
		if PlayerInfoEquals \{1
				part = Vocals}
			<divide_by_10> = true
		else
			<divide_by_10> = false
		endif
		AttachHudWidget {
			Input = {
				object = player1_status
				value = note_streak
			}
			output = {
				type = SEIntToString
				desc_id = <id>
				Property = streak_number_text
				divide_by_10 = <divide_by_10>
			}
		}
		AttachHudWidget {
			Input = {
				object = player1_status
				value = starpower_amount
			}
			output = {
				type = SETubes
				desc_id = <id>
				player = 1
				default_scale = (1.0, 1.0)
				value_range = [0.0 100.0]
				textures = [glow0_texture glow1_texture glow2_texture glow3_texture glow4_texture glow5_texture]
				scales = [glow0_scale glow1_scale glow2_scale glow3_scale glow4_scale glow5_scale]
			}
		}
		<tubes_widget_id> = <observer_id>
		AttachHudWidget {
			Input = {
				object = player1_status
				value = starpower_active
			}
			output = {id = <tubes_widget_id>}
		}
		AttachHudWidget {
			Input = {
				object = player1_status
				value = projected_song_stars
			}
			output = {
				type = SEStarMeter
				desc_id = <id>
				full_scale = 0.7
			}
		}
		color1 = [238 , 204 , 120 , 255]
		color2 = <color1>
		AttachHudWidget {
			Input = {
				object = player1_status
				value = has_missed_note
			}
			outputs = [
				{
					type = ScreenElementAlphaToggle
					desc_id = <id>
					Property = band_hud_gold_star_glow_alpha
				}
				{
					type = ScreenElementRGBASwitch
					desc_id = <id>
					Property = star_filler_rgba
					color1 = <color1>
					color2 = <color2>
				}
				{
					type = ScreenElementRGBASwitch
					desc_id = <id>
					Property = star_meter_num_rgba
					color1 = <color1>
					color2 = <color2>
				}
			]
		}
	else
		if ($hide_rockmeter_ind_health = 1)
			if ScreenElementExists \{id = hud_root}
				if hud_root :Desc_ResolveAlias \{name = alias_band_meter
						param = band_meter}
					ResolveScreenElementId id = <band_meter> param = meter_element
					if <meter_element> :Desc_ResolveAlias name = alias_rock_meter_lanes param = health_lanes
						<health_lanes> :SE_SetProps hide
					endif
				endif
			endif
		endif
		AttachHudWidget {
			Input = {
				value = band1_score
			}
			output = {
				type = SEIntToString
				desc_id = <id>
				Property = score_text
			}
		}
		AttachHudWidget {
			Input = {
				value = band1_streak
			}
			output = {
				type = SEIntToString
				desc_id = <id>
				Property = streak_number_text
			}
		}
		AttachHudWidget {
			Input = {
				value = band1_multiplier
			}
			output = {
				type = SEBandMultiplier
				desc_id = <id>
				textures = [
					band_HUD_multiplier_one
					band_HUD_multiplier_two
					band_HUD_multiplier_three
					band_HUD_multiplier_four
				]
			}
		}
		AttachHudWidget {
			Input = {
				value = band_projected_song_stars
			}
			output = {
				type = SEStarMeter
				desc_id = <id>
				full_scale = 1.0
			}
		}
		color1 = [238 , 204 , 120 , 255]
		color2 = <color1>
		AttachHudWidget {
			Input = {
				value = band_has_missed_note
			}
			outputs = [
				{
					type = ScreenElementAlphaToggle
					desc_id = <id>
					Property = band_hud_gold_star_glow_alpha
				}
				{
					type = ScreenElementRGBASwitch
					desc_id = <id>
					Property = star_filler_rgba
					color1 = <color1>
					color2 = <color2>
				}
				{
					type = ScreenElementRGBASwitch
					desc_id = <id>
					Property = star_meter_num_rgba
					color1 = <color1>
					color2 = <color2>
				}
			]
		}
		health_value_range = [0.0 2.0]
		health_mask_range = [(128.0, 0.0) (128.0, 64.0)]
		AttachHudWidget {
			Input = {
				object = player1_status
				value = health
			}
			outputs = [
				{
					type = DescPropertyPair
					desc_id = <id>
					Property = band_HUD_p1_mask_dims
					value_range = <health_value_range>
					range = <health_mask_range>
					single
				}
				{
					type = ScreenElementRGBALerp
					desc_id = <id>
					Property = band_HUD_p1_fill_rgba
					value_range = [0.67 1.3299999]
					colors = [
						[255 0 0 100]
						[255 255 0 100]
						[0 255 0 100]
					]
				}
				{
					type = ScreenElementRGBALerp
					desc_id = <id>
					Property = band_HUD_instrument_p1_rgba
					value_range = [0.0 2.0]
					colors = [
						[220 64 64 255]
						[255 255 255 255]
						[255 255 255 255]
					]
				}
			]
		}
		if ($current_num_players > 1)
			AttachHudWidget {
				Input = {
					object = player2_status
					value = health
				}
				outputs = [
					{
						type = DescPropertyPair
						desc_id = <id>
						Property = band_HUD_p2_mask_dims
						value_range = <health_value_range>
						range = <health_mask_range>
						single
					}
					{
						type = ScreenElementRGBALerp
						desc_id = <id>
						Property = band_HUD_p2_fill_rgba
						value_range = [0.67 1.3299999]
						colors = [
							[255 0 0 100]
							[255 255 0 100]
							[0 255 0 100]
						]
					}
					{
						type = ScreenElementRGBALerp
						desc_id = <id>
						Property = band_HUD_instrument_p2_rgba
						value_range = [0.0 2.0]
						colors = [
							[220 64 64 255]
							[255 255 255 255]
							[255 255 255 255]
						]
					}
				]
			}
		else
			SetScreenElementProps id = <id> band_HUD_p2_fill_rgba = [0 0 0 0]
		endif
		if ($current_num_players > 2)
			AttachHudWidget {
				Input = {
					object = player3_status
					value = health
				}
				outputs = [
					{
						type = DescPropertyPair
						desc_id = <id>
						Property = band_HUD_p3_mask_dims
						value_range = <health_value_range>
						range = <health_mask_range>
						single
					}
					{
						type = ScreenElementRGBALerp
						desc_id = <id>
						Property = band_HUD_p3_fill_rgba
						value_range = [0.67 1.3299999]
						colors = [
							[255 0 0 100]
							[255 255 0 100]
							[0 255 0 100]
						]
					}
					{
						type = ScreenElementRGBALerp
						desc_id = <id>
						Property = band_HUD_instrument_p3_rgba
						value_range = [0.0 2.0]
						colors = [
							[220 64 64 255]
							[255 255 255 255]
							[255 255 255 255]
						]
					}
				]
			}
		else
			SetScreenElementProps id = <id> band_HUD_p3_fill_rgba = [0 0 0 0]
		endif
		if ($current_num_players > 3)
			AttachHudWidget {
				Input = {
					object = player4_status
					value = health
				}
				outputs = [
					{
						type = DescPropertyPair
						desc_id = <id>
						Property = band_HUD_p4_mask_dims
						value_range = <health_value_range>
						range = <health_mask_range>
						single
					}
					{
						type = ScreenElementRGBALerp
						desc_id = <id>
						Property = band_HUD_p4_fill_rgba
						value_range = [0.67 1.3299999]
						colors = [
							[255 0 0 100]
							[255 255 0 100]
							[0 255 0 100]
						]
					}
					{
						type = ScreenElementRGBALerp
						desc_id = <id>
						Property = band_HUD_instrument_p4_rgba
						value_range = [0.0 2.0]
						colors = [
							[220 64 64 255]
							[255 255 255 255]
							[255 255 255 255]
						]
					}
				]
			}
		else
			SetScreenElementProps id = <id> band_HUD_p4_fill_rgba = [0 0 0 0]
		endif
		HUD_set_band_meter_instrument_icons desc_element = <id>
		AttachHudWidget {
			Input = {
				value = band1_starpower
			}
			output = {
				type = SETubes
				desc_id = <id>
				Band = true
				band_num = 1
				default_scale = (1.0, 1.0)
				value_range = [0.0 100.0]
				textures = [glow0_texture glow1_texture glow2_texture glow3_texture glow4_texture glow5_texture]
				scales = [glow0_scale glow1_scale glow2_scale glow3_scale glow4_scale glow5_scale]
			}
		}
	endif
	HUD_setup_streak_meter_animation
	HUD_setup_band_mult_animation
	if NOT GameMode_IsBandScoring
		HUD_setup_secondary_starpower_bulb_animation
	endif
	if ($rock_meter_debug = 1)
		if <id> :Desc_ResolveAlias name = alias_bg param = bg_id
			CreateScreenElement {
				parent = <bg_id>
				id = rock_meter_debug_text
				type = TextElement
				pos = (128.0, 24.0)
				text = qs("\L1337")
				font = debug
				just = [center bottom]
				scale = (0.7, 0.4)
				z_priority = 100
			}
			if ($current_num_players > 1)
				<player> = 1
				<pos> = (128.0, 24.0)
				begin
				FormatText checksumname = rmdt 'rock_meter_debug_text%i' i = <player> AddToStringLookup
				<pos> = (<pos> - (0.0, 16.0))
				CreateScreenElement {
					parent = <bg_id>
					id = <rmdt>
					type = TextElement
					pos = <pos>
					text = qs("\L1337")
					font = debug
					just = [center bottom]
					scale = (0.7, 0.4)
					z_priority = 100
				}
				<player> = (<player> + 1)
				repeat $current_num_players
			endif
			KillSpawnedScript \{name = update_rock_meter_debug_text}
			spawnscriptnow \{update_rock_meter_debug_text
				params = {
					id = rock_meter_debug_text
				}}
		endif
	endif
endscript

script HUD_set_band_meter_instrument_icons 
	index = 1
	begin
	GetPlayerInfo <index> part
	switch <part>
		case guitar
		icon = band_HUD_guitar
		glow_icon = band_HUD_guitar_glow
		case Bass
		icon = band_HUD_bass
		glow_icon = band_HUD_bass_glow
		case drum
		icon = band_HUD_drums
		glow_icon = band_HUD_drums_glow
		case Vocals
		icon = band_HUD_microphone
		glow_icon = band_HUD_mic_glow
	endswitch
	if (<index> <= $current_num_players)
		alpha = 1.0
	else
		alpha = 0.0
	endif
	glow_rgba = [255 255 255 0]
	switch <index>
		case 1
		SetScreenElementProps id = <desc_element> band_HUD_instrument_p1_texture = <icon>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_p1_alpha = <alpha>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p1_texture = <glow_icon>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p1_alpha = 0
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p1_rgba = <glow_rgba>
		case 2
		SetScreenElementProps id = <desc_element> band_HUD_instrument_p2_texture = <icon>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_p2_alpha = <alpha>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p2_texture = <glow_icon>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p2_alpha = 0
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p2_rgba = <glow_rgba>
		case 3
		SetScreenElementProps id = <desc_element> band_HUD_instrument_p3_texture = <icon>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_p3_alpha = <alpha>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p3_texture = <glow_icon>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p3_alpha = 0
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p3_rgba = <glow_rgba>
		case 4
		SetScreenElementProps id = <desc_element> band_HUD_instrument_p4_texture = <icon>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_p4_alpha = <alpha>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p4_texture = <glow_icon>
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p4_alpha = 0
		SetScreenElementProps id = <desc_element> band_HUD_instrument_glow_p4_rgba = <glow_rgba>
	endswitch
	index = (<index> + 1)
	repeat 4
endscript

script HUD_set_team_colors 
	SetScreenElementProps \{id = hud_root
		highway_icon_mic1_rgba = $player_slot_team1}
	SetScreenElementProps \{id = hud_root
		highway_icon_mic2_rgba = $player_slot_team2}
endscript
HUD_set_band_meter_instrument_streak_color_rgba_on = [
	255
	200
	0
	255
]
HUD_set_band_meter_instrument_streak_color_rgba_off = [
	255
	255
	255
	255
]
HUD_set_band_meter_instrument_streak_color_glow_rgba_on = [
	255
	255
	255
	255
]
HUD_set_band_meter_instrument_streak_color_glow_rgba_off = [
	255
	255
	255
	0
]

script HUD_band_streak_notify 
	GetPlayerInfo \{1
		bot_play}
	if (<bot_play> = 1)
		return
	endif
	if NOT GotParam \{new_player_in_streak}
		if NOT GotParam \{streak}
			return
		endif
		if (<streak> < 1)
			return
		endif
		FormatText TextName = notification qs("%d\_Note\_Band\_Streak!") d = <streak>
	else
		FormatText TextName = notification qs("Streak") d = <new_player_in_streak>
		priority = -1
	endif
	hud_create_message {text = <notification> Band priority = <priority> style_script = hud_message_band_streak_style style_script_params = {players = <players>}}
endscript

script HUD_band_streak_end 
	GetPlayerInfo \{1
		bot_play}
	if (<bot_play> = 1)
		return
	endif
	FormatText TextName = notification qs("%d\_Point\_Band\_Streak") d = <score>
	hud_create_message {text = <notification> Band priority = <priority> style_script = hud_message_band_streak_style style_script_params = {players = [0 0 0 0]}}
endscript

script HUD_attach_widget_band_faceoff_meter 
	AttachHudWidget {
		Input = {
			value = faceoff_ratio
		}
		outputs = [
			{
				type = DescPropertyFloat
				desc_id = <parent_id>
				Property = hud_band_battle_meter_needle_rot_angle
				value_range = [1.0 -1.0]
				range = [-51.5 51.5]
				single
			}
			{
				type = DescPropertyFloat
				desc_id = <parent_id>
				Property = hud_band_battle_meter_amber_on_alpha
				value_range = [0.0 0.1]
				range = [0.0 1.0]
				single
			}
			{
				type = DescPropertyFloat
				desc_id = <parent_id>
				Property = hud_band_battle_meter_violet_on_alpha
				value_range = [-0.1 0.0]
				range = [1.0 0.0]
				single
			}
		]
	}
	if NOT ResolveScreenElementId id = <parent_id> param = id
		return
	endif
	HUD_set_team_colors desc_element = <id>
	if ($current_num_players > 2)
		AttachHudWidget {
			Input = {
				value = band1_score
			}
			output = {
				type = SEIntToString
				desc_id = <parent_id>
				Property = score_1_text
			}
		}
		AttachHudWidget {
			Input = {
				value = band2_score
			}
			output = {
				type = SEIntToString
				desc_id = <parent_id>
				Property = score_2_text
			}
		}
		AttachHudWidget {
			Input = {
				value = band1_multiplier
			}
			output = {
				type = SEMultiplierNixie
				desc_id = <parent_id>
				Property = hud_bb_multiplier_nixie_1_texture
				player = 1
				textures = [
					HUD_score_nixie_1a
					HUD_score_nixie_2a
					HUD_score_nixie_3a
					HUD_score_nixie_4a
					HUD_score_nixie_1a
				]
				sp_textures = [
					HUD_score_nixie_2b
					HUD_score_nixie_4b
					HUD_score_nixie_6b
					HUD_score_nixie_8b
					HUD_score_nixie_1a
				]
			}
		}
		AttachHudWidget {
			Input = {
				value = band2_multiplier
			}
			output = {
				type = SEMultiplierNixie
				desc_id = <parent_id>
				Property = hud_bb_multiplier_nixie_2_texture
				player = 2
				textures = [
					HUD_score_nixie_1a
					HUD_score_nixie_2a
					HUD_score_nixie_3a
					HUD_score_nixie_4a
					HUD_score_nixie_1a
				]
				sp_textures = [
					HUD_score_nixie_2b
					HUD_score_nixie_4b
					HUD_score_nixie_6b
					HUD_score_nixie_8b
					HUD_score_nixie_1a
				]
			}
		}
		AttachHudWidget {
			Input = {
				value = band1_starpower
			}
			output = {
				type = SETubes
				desc_id = <parent_id>
				Band = true
				band_num = 1
				default_scale = (1.0, 1.0)
				value_range = [0.0 100.0]
				textures = [fill_1_1_texture fill_1_2_texture fill_1_3_texture fill_1_4_texture fill_1_5_texture fill_1_6_texture]
				scales = [fill_1_1_scale fill_1_2_scale fill_1_3_scale fill_1_4_scale fill_1_5_scale fill_1_6_scale]
			}
		}
		<tubes_widget_id> = <observer_id>
		AttachHudWidget {
			Input = {
				object = band1_status
				value = starpower_active
			}
			output = {id = <tubes_widget_id>}
		}
		AttachHudWidget {
			Input = {
				value = band2_starpower
			}
			output = {
				type = SETubes
				desc_id = <parent_id>
				Band = true
				band_num = 2
				default_scale = (1.0, 1.0)
				value_range = [0.0 100.0]
				textures = [fill_2_1_texture fill_2_2_texture fill_2_3_texture fill_2_4_texture fill_2_5_texture fill_2_6_texture]
				scales = [fill_2_1_scale fill_2_2_scale fill_2_3_scale fill_2_4_scale fill_2_5_scale fill_2_6_scale]
			}
		}
		<tubes_widget_id> = <observer_id>
		AttachHudWidget {
			Input = {
				object = band2_status
				value = starpower_active
			}
			output = {id = <tubes_widget_id>}
		}
		HUD_setup_streak_meter_animation \{player = 1
			faceoff}
		HUD_setup_streak_meter_animation \{player = 2
			faceoff}
		AttachHudWidget {
			Input = {
				value = band1_streak
			}
			output = {
				type = SEIntToString
				desc_id = <parent_id>
				Property = p1_streak_number_text
			}
		}
		AttachHudWidget {
			Input = {
				value = band2_streak
			}
			output = {
				type = SEIntToString
				desc_id = <parent_id>
				Property = p2_streak_number_text
			}
		}
	else
		AttachHudWidget {
			Input = {
				object = player1_status
				value = score
			}
			output = {
				type = SEIntToString
				desc_id = <parent_id>
				Property = score_1_text
			}
		}
		AttachHudWidget {
			Input = {
				object = player2_status
				value = score
			}
			output = {
				type = SEIntToString
				desc_id = <parent_id>
				Property = score_2_text
			}
		}
		AttachHudWidget {
			Input = {
				object = player1_status
				value = multiplier
			}
			output = {
				type = SEMultiplierNixie
				desc_id = <parent_id>
				Property = hud_bb_multiplier_nixie_1_texture
				player = 1
				textures = [
					HUD_score_nixie_1a
					HUD_score_nixie_2a
					HUD_score_nixie_3a
					HUD_score_nixie_4a
					HUD_score_nixie_1a
				]
				sp_textures = [
					HUD_score_nixie_2b
					HUD_score_nixie_4b
					HUD_score_nixie_6b
					HUD_score_nixie_8b
					HUD_score_nixie_1a
				]
			}
		}
		AttachHudWidget {
			Input = {
				object = player2_status
				value = multiplier
			}
			output = {
				type = SEMultiplierNixie
				desc_id = <parent_id>
				Property = hud_bb_multiplier_nixie_2_texture
				player = 2
				textures = [
					HUD_score_nixie_1a
					HUD_score_nixie_2a
					HUD_score_nixie_3a
					HUD_score_nixie_4a
					HUD_score_nixie_1a
				]
				sp_textures = [
					HUD_score_nixie_2b
					HUD_score_nixie_4b
					HUD_score_nixie_6b
					HUD_score_nixie_8b
					HUD_score_nixie_1a
				]
			}
		}
		AttachHudWidget {
			Input = {
				object = player1_status
				value = starpower_amount
			}
			output = {
				type = SETubes
				desc_id = <parent_id>
				player = 1
				default_scale = (1.0, 1.0)
				value_range = [0.0 100.0]
				textures = [fill_1_1_texture fill_1_2_texture fill_1_3_texture fill_1_4_texture fill_1_5_texture fill_1_6_texture]
				scales = [fill_1_1_scale fill_1_2_scale fill_1_3_scale fill_1_4_scale fill_1_5_scale fill_1_6_scale]
			}
		}
		<tubes_widget_id> = <observer_id>
		AttachHudWidget {
			Input = {
				object = player1_status
				value = starpower_active
			}
			output = {id = <tubes_widget_id>}
		}
		AttachHudWidget {
			Input = {
				object = player2_status
				value = starpower_amount
			}
			output = {
				type = SETubes
				desc_id = <parent_id>
				player = 2
				default_scale = (1.0, 1.0)
				value_range = [0.0 100.0]
				textures = [fill_2_1_texture fill_2_2_texture fill_2_3_texture fill_2_4_texture fill_2_5_texture fill_2_6_texture]
				scales = [fill_2_1_scale fill_2_2_scale fill_2_3_scale fill_2_4_scale fill_2_5_scale fill_2_6_scale]
			}
		}
		<tubes_widget_id> = <observer_id>
		AttachHudWidget {
			Input = {
				object = player2_status
				value = starpower_active
			}
			output = {id = <tubes_widget_id>}
		}
		HUD_setup_streak_meter_animation \{player = 1
			faceoff}
		HUD_setup_streak_meter_animation \{player = 2
			faceoff}
		if PlayerInfoEquals \{1
				part = Vocals}
			<divide_by_10> = true
		else
			<divide_by_10> = false
		endif
		AttachHudWidget {
			Input = {
				object = player1_status
				value = note_streak
			}
			output = {
				type = SEIntToString
				desc_id = <parent_id>
				Property = p1_streak_number_text
				divide_by_10 = <divide_by_10>
			}
		}
		if PlayerInfoEquals \{2
				part = Vocals}
			<divide_by_10> = true
		else
			<divide_by_10> = false
		endif
		AttachHudWidget {
			Input = {
				object = player2_status
				value = note_streak
			}
			output = {
				type = SEIntToString
				desc_id = <parent_id>
				Property = p2_streak_number_text
				divide_by_10 = <divide_by_10>
			}
		}
	endif
endscript

script HUD_attach_widget_player_multiplier 

	GetPlayerInfo <player> checksum
	ResolveScreenElementId id = <parent_id> param = id
	AttachHudWidget {
		Input = {
			object = <checksum>
			value = note_streak
		}
		output = {
			type = SENoteStreakLights
			desc_id = <id>
			player = <player>
			bulb_textures = [
				[
					HUD_score_light_0
					HUD_score_light_1
					HUD_score_light_2
				]
				[
					HUD_score_light_0_yellow
					HUD_score_light_1_yellow
					HUD_score_light_2_yellow
				]
				[
					HUD_score_light_0_green
					HUD_score_light_1_green
					HUD_score_light_2_green
				]
				[
					HUD_score_light_0_purple
					HUD_score_light_1_purple
					HUD_score_light_2_purple
				]
				[
					HUD_score_light_0_blue
					HUD_score_light_1_blue
					HUD_score_light_2_blue
				]
			]
			bulb_props = [light0_texture light1_texture light2_texture light3_texture light4_texture]
		}
	}
	<note_streak_widget_id> = <observer_id>
	AttachHudWidget {
		Input = {
			object = <checksum>
			value = starpower_active
		}
		output = {id = <note_streak_widget_id>}
	}
	if PlayerInfoEquals <player> part = Vocals
		textures = [
			band_HUD_score_1a
			vocal_HUD_score_2a
			vocal_HUD_score_3a
			vocal_HUD_score_4a
			band_HUD_score_1a
		]
		sp_textures = [
			vocal_HUD_score_2a
			vocal_HUD_score_4a
			vocal_HUD_score_6a
			vocal_HUD_score_8b
			band_HUD_score_1a
		]
	else
		textures = [
			band_HUD_score_1a
			band_HUD_score_2a
			band_HUD_score_3a
			band_HUD_score_4a
			band_HUD_score_1a
		]
		sp_textures = [
			band_HUD_score_2b
			band_HUD_score_4b
			band_HUD_score_6b
			band_HUD_score_8b
			band_HUD_score_1a
		]
	endif
	colors = [
		[127 127 127 127]
		[127 127 127 127]
		[127 127 127 127]
		[127 127 127 127]
		[127 127 127 127]
	]
	if GameMode_IsBandScoring
		<default_mul_tex> = band_HUD_score_1a
		GetPlayerInfo <player> part
		switch <part>
			case Bass
			<default_mul_tex> = higway_icon_bass
			case drum
			<default_mul_tex> = higway_icon_drum
			case guitar
			<default_mul_tex> = higway_icon_guitar
			case Vocals
			<default_mul_tex> = higway_icon_mic
		endswitch
		SetArrayElement ArrayName = textures index = 4 newvalue = <default_mul_tex>
	endif
	AttachHudWidget {
		Input = {
			object = <checksum>
			value = multiplier
		}
		output = {
			type = SEMultiplierNixie
			desc_id = <id>
			Property = nixie_texture
			property2 = mult_bg_alpha
			color_prop = nixie_rgba
			player = <player>
			num_players = $current_num_players
			textures = <textures>
			sp_textures = <sp_textures>
			colors = <colors>
		}
	}
endscript

script HUD_attach_widget_player_health 

	GetPlayerInfo <player> checksum
	ResolveScreenElementId id = <parent_id> param = id
	pos_prop = side_meter_needle_pos
	pos_range = [(-4.0, 2.0) (8.0, -32.0) (21.0, -67.0) (33.0, -100.0)]
	pos_value_range = [0.0 0.6666 1.3333 2.0]
	pos_type = IndividualHealthNeedlePos
	scale_prop = side_meter_needle_scale
	scale_range = [(1.0, 1.0) (1.0, 1.0)]
	red_light = SIDE_meter_red_ON_alpha
	yel_light = SIDE_meter_yellow_ON_alpha
	grn_light = SIDE_meter_green_ON_alpha
	red_light_rgba = SIDE_meter_red_ON_rgba
	red_glow_rgba = side_meter_red_glow_rgba
	if GotParam \{Vocals}
		pos_type = DescPropertyPair
		pos_range = [(0.0, -105.0) (0.0, -5.0)]
		pos_value_range = [0.0 2.0]
		scale_range = [(1.0, 1.0) (1.0, 1.0)]
		red_light = TOP_meter_red_ON_alpha
		yel_light = TOP_meter_yellow_ON_alpha
		grn_light = TOP_meter_green_ON_alpha
		red_light_rgba = TOP_meter_red_ON_rgba
		red_glow_rgba = top_red_glow_rgba
	else
		get_num_non_vocals_players_onscreen
		if (<num_non_vocals_players> = 1)
			pos_range = [(0.0, 0.0) (11.0, -24.0) (28.0, -57.0) (41.0, -80.0)]
		elseif (<num_non_vocals_players> = 2)
			pos_range = [(0.0, 0.0) (13.0, -28.0) (26.0, -58.0) (37.0, -84.0)]
		endif
	endif
	AttachHudWidget {
		Input = {
			object = <checksum>
			value = health
		}
		outputs = [
			{
				type = <pos_type>
				desc_id = <id>
				Property = <pos_prop>
				value_range = <pos_value_range>
				range = <pos_range>
				single
			}
			{
				type = DescPropertyPair
				desc_id = <id>
				Property = <scale_prop>
				value_range = [0.0 2.0]
				range = <scale_range>
				single
			}
			{
				type = ScreenElementConditionalFloat
				desc_id = <id>
				Property = <red_light>
				value_range = [0.0 0.6666]
			}
			{
				type = ScreenElementConditionalFloat
				desc_id = <id>
				Property = <yel_light>
				value_range = [0.6666 1.3333]
			}
			{
				type = ScreenElementConditionalFloat
				desc_id = <id>
				Property = <grn_light>
				value_range = [1.3333 2.0]
			}
		]
	}
	blink_rate = 0.3
	AttachHudWidget {
		Input = {
			value = time
		}
		outputs = [
			{
				type = ScreenElementPlayerHealthBlink
				desc_id = <id>
				Property = <red_light_rgba>
				blink_rate = <blink_rate>
				color1 = [255 , 255 , 255 , 255]
				color2 = [255 , 255 , 255 , 0]
			}
			{
				type = ScreenElementPlayerHealthBlink
				desc_id = <id>
				Property = <red_glow_rgba>
				blink_rate = <blink_rate>
				color1 = [255 , 255 , 255 , 255]
				color2 = [255 , 255 , 255 , 0]
			}
		]
	}
endscript

script HUD_attach_widget_player_star_power 

	GetPlayerInfo <player> checksum
	ResolveScreenElementId id = <parent_id> param = id
	if ($current_num_players > 1)
		AttachHudWidget {
			Input = {
				object = <checksum>
				value = starpower_amount
			}
			output = {
				type = SETubes
				desc_id = <id>
				player = <player>
				value_range = [0.0 100.0]
				textures = [glow0_texture glow1_texture glow2_texture]
				scales = [glow0_scale glow1_scale glow2_scale]
			}
		}
	endif
endscript

script HUD_setup_streak_meter_animation \{player = 1}
	if NOT GotParam \{faceoff}
		if hud_root :Desc_ResolveAlias \{name = alias_band_meter
				param = band_meter}
			<band_meter> :Desc_ResolveAlias name = alias_streak param = streak_id
		endif
	else
		if hud_root :Desc_ResolveAlias \{name = alias_faceoff_meter
				param = faceoff_meter}
			if (<player> = 1)
				<faceoff_meter> :Desc_ResolveAlias name = alias_streak_p1 param = streak_id
			else
				<faceoff_meter> :Desc_ResolveAlias name = alias_streak_p2 param = streak_id
			endif
		endif
	endif
	if NOT GotParam \{streak_id}
		return
	endif
	if ScreenElementExists id = <streak_id>
		GetScreenElementProps id = <streak_id>
		if NOT GotParam \{faceoff}
			hide_pos = (<pos> - (0.0, 65.0))
			if ($current_num_players = 1)
				GetPlayerInfo <player> part
				if (<part> = Vocals)
					pos = (913.0, 438.0)
					hide_pos = (<pos> + (0.0, 65.0))
				endif
			endif
		else
			if (<player> = 1)
				hide_pos = (<pos> + (200.0, 0.0))
			else
				hide_pos = (<pos> - (200.0, 0.0))
			endif
		endif
		streak_pos = <pos>
		if GameMode_IsBandScoring
			if (<player> = 1)
				event_handlers = [
					{band1_streak_started SetScreenElementProps params = {id = <streak_id> time = 0.3 pos = <streak_pos>}}
					{band1_streak_ended SetScreenElementProps params = {id = <streak_id> time = 0.3 pos = <hide_pos>}}
				]
			elseif (<player> = 2)
				event_handlers = [
					{band2_streak_started SetScreenElementProps params = {id = <streak_id> time = 0.3 pos = <streak_pos>}}
					{band2_streak_ended SetScreenElementProps params = {id = <streak_id> time = 0.3 pos = <hide_pos>}}
				]
			endif
		else
			if (<player> = 1)
				event_handlers = [
					{player1_streak_started SetScreenElementProps params = {id = <streak_id> time = 0.3 pos = <streak_pos>}}
					{player1_streak_ended SetScreenElementProps params = {id = <streak_id> time = 0.3 pos = <hide_pos>}}
				]
			elseif (<player> = 2)
				event_handlers = [
					{player2_streak_started SetScreenElementProps params = {id = <streak_id> time = 0.3 pos = <streak_pos>}}
					{player2_streak_ended SetScreenElementProps params = {id = <streak_id> time = 0.3 pos = <hide_pos>}}
				]
			endif
		endif
		SetScreenElementProps {
			id = <streak_id>
			event_handlers = <event_handlers>
			replace_handlers
			pos = <hide_pos>
		}
	endif
endscript

script HUD_setup_band_mult_animation 
	if ($current_num_players = 1)
		return
	endif
	if hud_root :Desc_ResolveAlias \{name = alias_band_meter
			param = band_meter}
		<band_meter> :Desc_ResolveAlias name = alias_band_multiplier param = mult_id
	endif
	if NOT GotParam \{mult_id}
		return
	endif
	if ScreenElementExists id = <mult_id>
		GetScreenElementProps id = <mult_id>
		hide_pos = (<pos> + (100.0, 0.0))
		hide_scale = 0.5
		event_handlers = [
			{show_band_mult SetScreenElementProps params = {id = <mult_id> time = 0.3 pos = <pos> scale = <scale>}}
			{hide_band_mult SetScreenElementProps params = {id = <mult_id> time = 0.3 pos = <hide_pos> scale = <hide_scale>}}
		]
		SetScreenElementProps {
			id = <mult_id>
			event_handlers = <event_handlers>
			replace_handlers
			pos = <hide_pos>
			scale = <hide_scale>
		}
	endif
endscript

script HUD_setup_secondary_starpower_bulb_animation 
	hud_root :Desc_ResolveAlias \{name = alias_band_meter
		param = band_meter}
	<band_meter> :Desc_ResolveAlias name = alias_secondary_bulbs param = container_id
	if ScreenElementExists id = <container_id>
		GetScreenElementProps id = <container_id>
		hide_pos = (<pos> + (-15.0, 60.0))
		show_pos = <pos>
		event_handlers = [
			{starpower_bulbs_unhide SetScreenElementProps params = {id = <container_id> time = 0.3 pos = <show_pos>}}
			{starpower_bulbs_hide SetScreenElementProps params = {id = <container_id> time = 0.3 pos = <hide_pos>}}
		]
		SetScreenElementProps {
			id = <container_id>
			event_handlers = <event_handlers>
			replace_handlers
			pos = <hide_pos>
		}
	endif
endscript

script HUD_start_blink_rock_meter 
	if ($current_num_players = 1)
		return
	endif
	if ($game_mode = p2_pro_faceoff)
		return
	endif
	Band_Failing_Vignette_on
endscript

script HUD_start_blink_rock_meter_spawn 
	if ScreenElementExists \{id = hud_root}
		if hud_root :Desc_ResolveAlias \{name = alias_band_meter
				param = band_meter}
			if ScreenElementExists id = <band_meter>
				if <band_meter> :Desc_ResolveAlias name = alias_HUD_meter_red_bg param = bg_id
					begin
					if NOT ScreenElementExists id = <bg_id>
						break
					endif
					SetScreenElementProps {
						id = <bg_id>
						rgba = [50 50 50 255]
						time = 0.1
					}
					HUD_meter_set_rgba \{new_rgba = [
							0
							0
							0
							0
						]}
					if <band_meter> :Desc_ResolveAlias name = alias_pulse_container param = scale_id
						if ScreenElementExists id = <scale_id>
							SetScreenElementProps {
								id = <scale_id>
								scale = 1.0
								relative_scale
								time = 0.1
							}
						endif
					endif
					Wait \{0.1
						seconds}
					if NOT ScreenElementExists id = <bg_id>
						break
					endif
					SetScreenElementProps {
						id = <bg_id>
						rgba = [255 255 255 255]
						time = 0.1
					}
					HUD_meter_set_rgba \{new_rgba = [
							255
							0
							0
							255
						]}
					if <band_meter> :Desc_ResolveAlias name = alias_pulse_container param = scale_id
						if ScreenElementExists id = <scale_id>
							SetScreenElementProps {
								id = <scale_id>
								scale = 1.2
								relative_scale
								time = 0.1
							}
						endif
					endif
					Wait \{0.1
						seconds}
					repeat
				endif
			endif
		endif
	endif
endscript

script HUD_stop_blink_rock_meter 
	Band_Failing_Vignette_off
	KillSpawnedScript \{name = HUD_start_blink_rock_meter_spawn}
	HUD_meter_set_rgba \{new_rgba = [
			0
			0
			0
			0
		]}
	if ScreenElementExists \{id = hud_root}
		if hud_root :Desc_ResolveAlias \{name = alias_band_meter
				param = band_meter}
			if ScreenElementExists id = <band_meter>
				if <band_meter> :Desc_ResolveAlias name = alias_HUD_meter_red_bg param = id
					if ScreenElementExists id = <id>
						SetScreenElementProps {
							id = <id>
							rgba = [255 255 255 255]
							time = 0.1
						}
					endif
				endif
				if <band_meter> :Desc_ResolveAlias name = alias_pulse_container param = scale_id
					if ScreenElementExists id = <scale_id>
						SetScreenElementProps {
							id = <scale_id>
							scale = 1.0
							relative_scale
							time = 0.1
						}
					endif
				endif
			endif
		endif
	endif
endscript

script HUD_pulse_rock_meter 
	KillSpawnedScript \{name = HUD_pulse_rock_meter_spawn}
	SpawnScriptLater \{HUD_pulse_rock_meter_spawn}
endscript

script HUD_pulse_rock_meter_spawn 
	if ScreenElementExists \{id = hud_root}
		if hud_root :Desc_ResolveAlias \{name = alias_band_meter
				param = band_meter}
			if ScreenElementExists id = <band_meter>
				if <band_meter> :Desc_ResolveAlias name = alias_pulse_container param = id
					if ScreenElementExists id = <id>
						SetScreenElementProps {
							id = <id>
							scale = 1.2
							relative_scale
							time = 0.1
						}
						Wait \{0.1
							seconds}
						if NOT ScreenElementExists id = <id>
							return
						endif
						SetScreenElementProps {
							id = <id>
							scale = 1.0
							relative_scale
							time = 0.1
						}
					endif
				endif
			endif
		endif
	endif
endscript

script HUD_meter_glow_red 
endscript

script HUD_meter_glow_blue 
endscript

script HUD_meter_glow_hide_blue 
endscript

script HUD_meter_glow_hide 
endscript

script HUD_meter_set_rgba \{new_rgba = [
			0
			0
			0
			0
		]}
	if ScreenElementExists \{id = hud_root}
		if hud_root :Desc_ResolveAlias \{name = alias_band_meter
				param = band_meter}
			if ScreenElementExists id = <band_meter>
				if <band_meter> :Desc_ResolveAlias name = alias_band_HUD_meter_outer_glow param = id
					if ScreenElementExists id = <id>
						if GotParam \{old_rgba}
							GetScreenElementProps id = <id>
							i = 0
							begin
							if NOT (<rgba> [<i>] = <old_rgba> [<i>])
								return
							endif
							i = (<i> + 1)
							repeat 4
						endif
						SetScreenElementProps {
							id = <id>
							rgba = <new_rgba>
							alpha = 1.0
							time = 0.1
						}
					endif
				endif
			endif
		endif
	endif
endscript

script HUD_animate_star_meter_flames 
	KillSpawnedScript \{name = HUD_animate_star_meter_flames_spawn}
	SpawnScriptLater \{HUD_animate_star_meter_flames_spawn}
endscript

script HUD_animate_star_meter_flames_spawn 
	if ScreenElementExists \{id = hud_root}
		if hud_root :Desc_ResolveAlias \{name = alias_band_meter
				param = band_meter}
			if ScreenElementExists id = <band_meter>
				if <band_meter> :Desc_ResolveAlias name = alias_star_flame param = parent
					if ScreenElementExists id = <parent>
						Star_Meter_Sparks01 parent = <parent>
						SoundEvent \{event = Star_Get}
					endif
				endif
			endif
		endif
	endif
endscript

script Star_Meter_Sparks01 
	props = {
		type = SpriteElement
		parent = <parent>
		dims = (128.0, 128.0)
		scale = (1.0, 1.0)
		pos = (70.0, 85.0)
		just = [center bottom]
		material = Mat_Note_hit_Xplosion1
		blend = Add
		use_animated_uvs = true
		top_down_v
		frame_length = 0.08
		num_uv_frames = (4.0, 4.0)
		z_priority = 18
	}
	DestroyScreenElement \{id = Star_spark01}
	DestroyScreenElement \{id = Star_spark02}
	DestroyScreenElement \{id = Star_spark03}
	DestroyScreenElement \{id = Star_spark04}
	CreateScreenElement {
		id = Star_spark01
		rot_angle = 0
		<props>
	}
	CreateScreenElement {
		id = Star_spark02
		rot_angle = 90
		<props>
	}
	CreateScreenElement {
		id = Star_spark03
		rot_angle = 180
		<props>
	}
	CreateScreenElement {
		id = Star_spark04
		rot_angle = 270
		<props>
	}
	Wait \{16
		frames}
	DestroyScreenElement \{id = Star_spark01}
	DestroyScreenElement \{id = Star_spark02}
	DestroyScreenElement \{id = Star_spark03}
	DestroyScreenElement \{id = Star_spark04}
endscript
