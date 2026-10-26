guitar_hero_cheat_index = [
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
]
guitar_hero_cheats = [
	{
		name = 'AlwaysSlide'
		name_text = qs("ALWAYS SLIDE")
		var = Cheat_AlwaysSlide
		unlock_pattern = [
			green
			green
			red
			red
			Yellow
			red
			Yellow
			Blue
		]
		options = [
			{
				text = qs("ALWAYS SLIDE: OFF")
				globals = [
					{
						set = Cheat_AlwaysSlide
						value = 0
					}
				]
			}
			{
				text = qs("ALWAYS SLIDE: ON")
				globals = [
					{
						set = Cheat_AlwaysSlide
						value = 1
					}
				]
			}
		]
	}
	{
		name = 'AirInstruments'
		name_text = qs("AIR INSTRUMENTS")
		var = Cheat_AirInstruments
		unlock_pattern = [
			red
			red
			Blue
			Yellow
			green
			green
			green
			Yellow
		]
		options = [
			{
				text = qs(0xd86c0764)
				globals = [
					{
						set = Cheat_AirInstruments
						value = 0
					}
					{
						set = AirInstruments
						value = 0
					}
				]
			}
			{
				text = qs(0x8f98f190)
				exclude = [
					Cheat_InvisibleCharacters
				]
				globals = [
					{
						set = Cheat_AirInstruments
						value = 1
					}
					{
						set = AirInstruments
						value = 1
					}
				]
			}
		]
	}
	{
		name = 'InvisibleCharacters'
		name_text = qs("INVISIBLE ROCKER")
		var = Cheat_InvisibleCharacters
		unlock_pattern = [
			green
			red
			Yellow
			Yellow
			Yellow
			Blue
			Blue
			green
		]
		options = [
			{
				text = qs("INVISIBLE ROCKER: OFF")
				globals = [
					{
						set = Cheat_InvisibleCharacters
						value = 0
					}
					{
						set = InvisibleCharacters
						value = 0
					}
				]
			}
			{
				text = qs("INVISIBLE ROCKER: ON")
				exclude = [
					Cheat_AirInstruments
				]
				globals = [
					{
						set = Cheat_InvisibleCharacters
						value = 1
					}
					{
						set = InvisibleCharacters
						value = 1
					}
				]
			}
		]
	}
	{
		name = 'PerformanceMode'
		name_text = qs("PERFORMANCE MODE")
		var = Cheat_PerformanceMode
		unlock_pattern = [
			Yellow
			Yellow
			Blue
			red
			Blue
			green
			red
			red
		]
		options = [
			{
				text = qs("PERFORMANCE MODE:\nOFF")
				globals = [
					{
						set = Cheat_PerformanceMode
						value = 0
					}
				]
			}
			{
				text = qs("PERFORMANCE MODE: ON")
				globals = [
					{
						set = Cheat_PerformanceMode
						value = 1
					}
				]
			}
		]
	}
	{
		name = 'Hyperspeed'
		name_text = qs("HYPERSPEED")
		part = guitar
		var = Cheat_Hyperspeed
		unlock_pattern = [
			green
			Blue
			red
			Yellow
			Yellow
			red
			green
			green
		]
		options = [
			{
				text = qs("HYPERGUITAR: OFF")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 0
					}
					{
						set = Hyperspeed_Guitar
						value = 1.0
					}
				]
			}
			{
				text = qs("HYPERGUITAR: ON 1")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 1
					}
					{
						set = Hyperspeed_Guitar
						value = 0.88
					}
				]
			}
			{
				text = qs("HYPERGUITAR: ON 2")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 2
					}
					{
						set = Hyperspeed_Guitar
						value = 0.83
					}
				]
			}
			{
				text = qs("HYPERGUITAR: ON 3")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 3
					}
					{
						set = Hyperspeed_Guitar
						value = 0.78
					}
				]
			}
			{
				text = qs("HYPERGUITAR: ON 4")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 4
					}
					{
						set = Hyperspeed_Guitar
						value = 0.72999996
					}
				]
			}
			{
				text = qs("HYPERGUITAR: ON 5")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 5
					}
					{
						set = Hyperspeed_Guitar
						value = 0.68
					}
				]
			}
		]
	}
	{
		name = 'Hyperspeed'
		name_text = qs("HYPERSPEED")
		part = Bass
		var = Cheat_Hyperspeed
		unlock_pattern = [
			green
			Blue
			red
			Yellow
			Yellow
			red
			green
			green
		]
		options = [
			{
				text = qs("HYPERBASS: OFF")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 0
					}
					{
						set = Hyperspeed_Bass
						value = 1.0
					}
				]
			}
			{
				text = qs("HYPERBASS: ON 1")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 1
					}
					{
						set = Hyperspeed_Bass
						value = 0.88
					}
				]
			}
			{
				text = qs("HYPERBASS: ON 2")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 2
					}
					{
						set = Hyperspeed_Bass
						value = 0.83
					}
				]
			}
			{
				text = qs("HYPERBASS: ON 3")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 3
					}
					{
						set = Hyperspeed_Bass
						value = 0.78
					}
				]
			}
			{
				text = qs("HYPERBASS: ON 4")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 4
					}
					{
						set = Hyperspeed_Bass
						value = 0.72999996
					}
				]
			}
			{
				text = qs("HYPERBASS: ON 5")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 5
					}
					{
						set = Hyperspeed_Bass
						value = 0.68
					}
				]
			}
		]
	}
	{
		name = 'Hyperspeed'
		name_text = qs("HYPERSPEED")
		part = drum
		var = Cheat_Hyperspeed
		unlock_pattern = [
			green
			Blue
			red
			Yellow
			Yellow
			red
			green
			green
		]
		options = [
			{
				text = qs("HYPERDRUMS: OFF")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 0
					}
					{
						set = Hyperspeed_Drum
						value = 1.0
					}
				]
			}
			{
				text = qs("HYPERDRUMS: ON 1")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 1
					}
					{
						set = Hyperspeed_Drum
						value = 0.88
					}
				]
			}
			{
				text = qs("HYPERDRUMS: ON 2")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 2
					}
					{
						set = Hyperspeed_Drum
						value = 0.83
					}
				]
			}
			{
				text = qs("HYPERDRUMS: ON 3")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 3
					}
					{
						set = Hyperspeed_Drum
						value = 0.78
					}
				]
			}
			{
				text = qs("HYPERDRUMS: ON 4")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 4
					}
					{
						set = Hyperspeed_Drum
						value = 0.72999996
					}
				]
			}
			{
				text = qs("HYPERDRUMS: ON 5")
				globals = [
					{
						set = Cheat_Hyperspeed
						value = 5
					}
					{
						set = Hyperspeed_Drum
						value = 0.68
					}
				]
			}
		]
	}
	{
		name = 'AutoKick'
		name_text = qs("AUTO KICK")
		var = Cheat_AutoKick
		unlock_pattern = [
			Yellow
			green
			red
			Blue
			Blue
			Blue
			Blue
			red
		]
		options = [
			{
				text = qs("AUTO KICK: OFF")
				globals = [
					{
						set = Cheat_AutoKick
						value = 0
					}
				]
			}
			{
				text = qs("AUTO KICK: ON")
				globals = [
					{
						set = Cheat_AutoKick
						value = 1
					}
				]
			}
		]
	}
	{
		name = 'GemColor'
		name_text = qs("GEM COLOR")
		var = Cheat_GemColor
		unlock_pattern = [
			Blue
			red
			red
			green
			red
			green
			red
			Yellow
		]
		options = [
			{
				text = qs("GEM COLOR: NORMAL")
				globals = [
					{
						set = Cheat_GemColor
						value = 0
					}
					{
						set = gem_set
						value = standard_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: PINK")
				globals = [
					{
						set = Cheat_GemColor
						value = 1
					}
					{
						set = gem_set
						value = pink_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: STEALTH")
				globals = [
					{
						set = Cheat_GemColor
						value = 2
					}
					{
						set = gem_set
						value = stealth_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: EGGS & BACON")
				globals = [
					{
						set = Cheat_GemColor
						value = 3
					}
					{
						set = gem_set
						value = Eggs_N_Bacon_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: OLD GLORY")
				globals = [
					{
						set = Cheat_GemColor
						value = 4
					}
					{
						set = gem_set
						value = old_glory_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: SOLID GOLD")
				globals = [
					{
						set = Cheat_GemColor
						value = 5
					}
					{
						set = gem_set
						value = solid_gold_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: PLATINUM")
				globals = [
					{
						set = Cheat_GemColor
						value = 6
					}
					{
						set = gem_set
						value = platinum_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: DIABOLIC")
				globals = [
					{
						set = Cheat_GemColor
						value = 7
					}
					{
						set = gem_set
						value = diabolic_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: TOXIC WASTE")
				globals = [
					{
						set = Cheat_GemColor
						value = 8
					}
					{
						set = gem_set
						value = toxic_waste_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: BLACK")
				globals = [
					{
						set = Cheat_GemColor
						value = 9
					}
					{
						set = gem_set
						value = black_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: PASTEL")
				globals = [
					{
						set = Cheat_GemColor
						value = 10
					}
					{
						set = gem_set
						value = pastel_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: DARK")
				globals = [
					{
						set = Cheat_GemColor
						value = 11
					}
					{
						set = gem_set
						value = dark_gems
					}
				]
			}
			{
				text = qs("GEM COLOR: OUTLINE")
				globals = [
					{
						set = Cheat_GemColor
						value = 12
					}
					{
						set = gem_set
						value = outline_gems
					}
				]
			}
		]
	}
	{
		name = 'FlameColor'
		name_text = qs("FLAME COLOR")
		var = Cheat_FlameColor
		unlock_pattern = [
			green
			red
			green
			Blue
			red
			red
			Yellow
			Blue
		]
		options = [
			{
				text = qs("FLAME COLOR: NORMAL")
				globals = [
					{
						set = Cheat_FlameColor
						value = 0
					}
					{
						set = FX_Set
						value = standard_fx
					}
				]
			}
			{
				text = qs("FLAME COLOR: PINK")
				globals = [
					{
						set = Cheat_FlameColor
						value = 1
					}
					{
						set = FX_Set
						value = pink_fx
					}
				]
			}
			{
				text = qs("FLAME COLOR: STEALTH")
				globals = [
					{
						set = Cheat_FlameColor
						value = 2
					}
					{
						set = FX_Set
						value = stealth_fx
					}
				]
			}
			{
				text = qs("FLAME COLOR: EGGS & BACON")
				globals = [
					{
						set = Cheat_FlameColor
						value = 3
					}
					{
						set = FX_Set
						value = Eggs_N_Bacon_fx
					}
				]
			}
			{
				text = qs("FLAME COLOR: OLD GLORY")
				globals = [
					{
						set = Cheat_FlameColor
						value = 4
					}
					{
						set = FX_Set
						value = Old_Glory_fx
					}
				]
			}
			{
				text = qs("FLAME COLOR: DIABOLIC")
				globals = [
					{
						set = Cheat_FlameColor
						value = 5
					}
					{
						set = FX_Set
						value = Diabolic_fx
					}
				]
			}
			{
				text = qs("FLAME COLOR: TOXIC WASTE")
				globals = [
					{
						set = Cheat_FlameColor
						value = 6
					}
					{
						set = FX_Set
						value = Toxic_Waste_fx
					}
				]
			}
		]
	}
	{
		name = 'StarColor'
		name_text = qs("STAR COLOR")
		var = Cheat_StarColor
		unlock_pattern = [
			red
			red
			Yellow
			red
			Blue
			red
			red
			Blue
		]
		options = [
			{
				text = qs("STAR COLOR: NORMAL")
				globals = [
					{
						set = Cheat_StarColor
						value = 0
					}
					{
						set = Star_Set
						value = standard_stars
					}
				]
			}
			{
				text = qs("STAR COLOR: GOLD")
				globals = [
					{
						set = Cheat_StarColor
						value = 1
					}
					{
						set = Star_Set
						value = gold_stars
					}
				]
			}
		]
	}
	{
		name = 'VocalFireball'
		name_text = qs("VOCAL FIREBALL")
		var = Cheat_VocalFireball
		unlock_pattern = [
			red
			green
			green
			Yellow
			Blue
			green
			Yellow
			green
		]
		options = [
			{
				text = qs("VOCAL FIREBALL: NORMAL")
				globals = [
					{
						set = Cheat_VocalFireball
						value = 0
					}
				]
			}
			{
				text = qs("VOCAL FIREBALL: PINK")
				globals = [
					{
						set = Cheat_VocalFireball
						value = 2
					}
				]
			}
		]
	}
	{
		name = 'Invincible'
		name_text = qs(0x6eb81461)
		var = Cheat_Invincible
		unlock_pattern = [
			green
			Blue
			green
			Yellow
			green
			green
			Blue
			green
		]
		options = [
			{
				text = qs(0x7166a1e5)
				globals = [
					{
						set = Cheat_Invincible
						value = 0
					}
				]
			}
			{
				text = qs(0xe16720af)
				globals = [
					{
						set = Cheat_Invincible
						value = 1
					}
				]
			}
		]
	}
	{
		name = 'FocusMode'
		name_text = qs("FOCUS MODE")
		var = Cheat_FocusMode
		unlock_pattern = [
			Yellow
			green
			red
			green
			Yellow
			Blue
			green
			green
		]
		options = [
			{
				text = qs(0xb417f013)
				globals = [
					{
						set = Cheat_FocusMode
						value = 0
					}
				]
			}
			{
				text = qs(0xea9c141f)
				globals = [
					{
						set = Cheat_FocusMode
						value = 1
					}
				]
			}
		]
	}
	{
		name = 'HUDFreeMode'
		name_text = qs("HUD FREE MODE")
		var = Cheat_HUDFreeMode
		unlock_pattern = [
			green
			red
			green
			green
			Yellow
			green
			green
			green
		]
		options = [
			{
				text = qs(0x098bc07b)
				globals = [
					{
						set = Cheat_HUDFreeMode
						value = 0
					}
				]
			}
			{
				text = qs(0x9c1c512b)
				globals = [
					{
						set = Cheat_HUDFreeMode
						value = 1
					}
				]
			}
		]
	}
	{
		name = 'allHOPOs'
		name_text = qs("All HOPOs")
		var = Cheat_allHOPOs
		unlock_pattern = [
			green
			green
			Blue
			green
			green
			green
			Yellow
			green
		]
		options = [
			{
				text = qs("All HOPOs: Off")
				globals = [
					{
						set = Cheat_allHOPOs
						value = 0
					}
				]
			}
			{
				text = qs("All HOPOs: On")
				globals = [
					{
						set = Cheat_allHOPOs
						value = 1
					}
				]
			}
		]
	}
	{
		name = 'FreeDrum'
		name_text = qs("FREEDRUM")
		var = Cheat_FreeDrum
		unlock_pattern = [
			Blue
			green
			red
			green
			Blue
			green
			green
			green
		]
		options = [
			{
				text = qs(0x27636825)
				globals = [
					{
						set = Cheat_FreeDrum
						value = 0
					}
				]
			}
			{
				text = qs(0x8aa92890)
				globals = [
					{
						set = Cheat_FreeDrum
						value = 1
					}
				]
			}
		]
	}
]
guitar_hero_hidden_cheats = [
	{
		name = 'SuperUser'
		name_text = qs("Superuser")
		var = Cheat_SuperUser
		unlock_pattern = [
			green
			Blue
			red
			Yellow
			Yellow
			red
			Blue
			green
		]
		global = Cheat_SuperUser
		value = 1
	}
]

script ui_options_cheats_screen_anim 
endscript
ui_cheats_settings = {
}
ui_cheats_do_anim = 0

script ui_create_options_cheats 
	GetArraySize ($guitar_hero_cheats)
	GetGlobalTags \{user_options}
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 0 newvalue = <cheat_index0>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 1 newvalue = <cheat_index1>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 2 newvalue = <cheat_index2>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 3 newvalue = <cheat_index3>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 4 newvalue = <cheat_index4>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 5 newvalue = <cheat_index5>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 6 newvalue = <cheat_index6>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 7 newvalue = <cheat_index7>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 8 newvalue = <cheat_index8>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 9 newvalue = <cheat_index9>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 10 newvalue = <cheat_index10>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 11 newvalue = <cheat_index11>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 12 newvalue = <cheat_index12>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 13 newvalue = <cheat_index13>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 14 newvalue = <cheat_index14>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 15 newvalue = <cheat_index15>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 16 newvalue = <cheat_index16>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 17 newvalue = <cheat_index17>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 18 newvalue = <cheat_index18>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 19 newvalue = <cheat_index19>
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = 20 newvalue = <cheat_index20>
	CreateScreenElement {
		parent = root_window
		id = CheatsInterface
		type = DescInterface
		desc = 'select_cheat'
		pos_anchor = [left top]
		pos = (0.0, 0.0)
		new_cheat_alpha = 0.0
		exclusive_device = ($primary_controller)
	}
	if CheatsInterface :Desc_ResolveAlias \{name = alias_menu}
		AssignAlias id = <resolved_id> alias = current_menu
		current_menu :SE_SetProps \{event_handlers = [
				{
					pad_back
					ui_options_cheats_back
				}
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
			]}
	endif
	CheatsInterface :obj_spawnscript \{highlight_motion
		params = {
			menu_id = CheatsInterface
		}}
	add_generic_menu_text_item \{text = qs("Enter new cheat")
		pad_choose_script = generic_event_choose
		pad_choose_params = {
			state = uistate_options_cheats_new
		}
		focus_script = ui_options_cheats_focus
		unfocus_script = ui_options_cheats_unfocus}
	<item_container_id> :SE_GetParentId
	<item_container_id> :SE_SetProps {
		event_handlers = [
			{focus ui_options_cheats_update_helper}
		]
		tags = {
			unlocked = 1
			toggle = 0
			index = -1
		}
	}
	GetArraySize \{$guitar_hero_cheats}
	i = 0
	begin
	FormatText checksumname = cheat_unlocked 'unlock_Cheat_%a' a = ($guitar_hero_cheats [<i>].name)
	if GotParam <cheat_unlocked>
		rgba = [255 255 255 255]
		<text> = qs("locked")
		unlocked = 0
		toggle = 1
		pad_choose_script = ui_bonus_videos_negative_sfx
		item_height = 50
		if ((<...>.<cheat_unlocked>) > 0)
			if StructureContains Structure = ($guitar_hero_cheats [<i>]) options
				name = ($guitar_hero_cheats [<i>].name)
				var = ($guitar_hero_cheats [<i>].var)
				cheat_index = ($guitar_hero_cheat_index [<i>])
				option_struct = ($guitar_hero_cheats [<i>].options [<cheat_index>])
				text = (<option_struct>.text)
				pad_choose_params = {}
				if StructureContains Structure = ($guitar_hero_cheats [<i>]) pad_choose_script
					pad_choose_script = ($guitar_hero_cheats [<i>].pad_choose_script)
					if StructureContains Structure = ($guitar_hero_cheats [<i>]) pad_choose_params
						pad_choose_params = ($guitar_hero_cheats [<i>].pad_choose_params)
					endif
				else
					pad_choose_script = ui_options_cheat_toggle
				endif
			else
				pad_choose_script = ($guitar_hero_cheats [<i>].unlock_script)
				text = ($guitar_hero_cheats [<i>].name_text)
			endif
			item_height = 100
			if StructureContains Structure = ($guitar_hero_cheats [<i>]) not_toggle
				toggle = 0
				item_height = 50
			endif
			unlocked = 1
		endif
		add_generic_menu_text_item {
			text = <text>
			pad_choose_script = <pad_choose_script>
			pad_choose_params = <pad_choose_params>
			focus_script = ui_options_cheats_focus
			unfocus_script = ui_options_cheats_unfocus
		}
		<item_container_id> :SE_GetParentId
		<item_container_id> :SE_SetProps {
			generic_menu_smenu_textitem_text_rgba = <rgba>
			event_handlers = [
				{focus ui_options_cheats_update_helper}
			]
			tags = {
				name = <name>
				var = <var>
				index = <i>
				unlocked = <unlocked>
				toggle = <toggle>
			}
		}
	endif
	i = (<i> + 1)
	repeat <array_size>
	menu_finish
	CheatsInterface :SetTags array_size = (<i>)
	if NOT CompareStructs \{struct1 = $ui_cheats_settings
			struct2 = {
			}}
		current_menu :SetTags \{user_options = $ui_cheats_settings}
	else
		ui_options_set_settings
		current_menu :GetSingleTag \{user_options}
		change ui_cheats_settings = <user_options>
	endif
	CheatsInterface :Obj_SpawnScriptNow \{ui_options_cheats_screen_anim}
endscript

script ui_destroy_options_cheats 
	DestroyScreenElement \{id = CheatsInterface}
	generic_ui_destroy
	KillSpawnedScript \{name = ui_options_cheats_screen_anim}
endscript

script ui_deinit_options_cheats 
	change \{ui_cheats_settings = {
		}}
	check_CAR_unlocks
endscript

script ui_options_cheats_back 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	if Is_ui_event_running
		return
	endif

	change \{ui_cheats_do_anim = 0}
	menu_start_transition
	if (($Cheat_AlwaysSlide = 1) || ($Cheat_AutoKick = 1) || ($Cheat_FreeDrum = 1) || ($Cheat_allHOPOs = 1) || ($Cheat_Invincible = 1))
		generic_event_choose \{state = uistate_options_cheats_warning}
	else
		ui_options_check_settings
	endif
endscript

script ui_options_cheat_toggle 
	GetTags
	cheat_index = ($guitar_hero_cheat_index [<index>])
	<cheat_index> = (<cheat_index> + 1)
	option_array = ($guitar_hero_cheats [<index>].options)
	GetArraySize <option_array>
	if (<cheat_index> >= <array_size>)
		<cheat_index> = 0
	endif
	SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = <index> newvalue = <cheat_index>
	GetGlobalTags \{user_options}
	FormatText checksumname = cheat_idx 'cheat_index%a' a = <index>
	AddParam structure_name = params name = <cheat_idx> value = <cheat_index>
	SetGlobalTags user_options params = <params>
	option_struct = (<option_array> [<cheat_index>])
	globals = (<option_struct>.globals)
	cheat_set_globals globals = <globals>
	text = (<option_struct>.text)
	SE_SetProps generic_menu_smenu_textitem_text_text = <text>
	exclude_option option_struct = <option_struct>
	refresh_autokick_cheat
endscript

script cheat_set_globals 
	GetGlobalTags \{user_options}
	GetArraySize <globals>
	<idx> = 0
	begin
	<entry> = (<globals> [<idx>])
	<set> = (<entry>.set)
	if StructureContains Structure = <entry> value
		<set_value> = (<entry>.value)
	elseif StructureContains Structure = <entry> global
		<global> = (<entry>.global)
		<value> = ($<global>)
		if StructureContains Structure = <entry> scale
			<scale> = (<entry>.scale)
			<set_value> = (<value> * <scale>)
		else
			<set_value> = <value>
		endif
	endif
	if GotParam <set>
		AddParam structure_name = params name = <set> value = <set_value>
	else
		change globalname = <set> newvalue = <set_value>
	endif
	<idx> = (<idx> + 1)
	repeat <array_size>
	if GotParam \{params}
		SetGlobalTags user_options params = <params>
	endif
endscript

script cheat_turnoffall 
	GetArraySize \{$guitar_hero_cheats}
	<idx> = 0
	begin
	RemoveParameter \{var}
	<var> = ($guitar_hero_cheats [<idx>].var)
	if GotParam \{var}
		change globalname = <var> newvalue = 0
	endif
	<idx> = (<idx> + 1)
	repeat <array_size>
endscript

script cheat_turnoffalllocked 
	GetArraySize \{$guitar_hero_cheats}
	<idx> = 0
	begin
	RemoveParameter \{var}
	<var> = ($guitar_hero_cheats [<idx>].var)
	savegame = 0
	unlocked = 0
	begin
	GetGlobalTags savegame = <savegame> user_options
	FormatText checksumname = cheat_idx 'cheat_index%a' a = <idx>
	if NOT (<...>.<cheat_idx> = 0)
		unlocked = 1
	endif
	savegame = (<savegame> + 1)
	repeat 4
	if (<unlocked> = 0)
		if GotParam \{var}
			change globalname = <var> newvalue = 0
		endif
	endif
	<idx> = (<idx> + 1)
	repeat <array_size>
endscript

script exclude_option 
	if StructureContains Structure = <option_struct> exclude
		<exclude_array> = (<option_struct>.exclude)
		<exclude_index> = 0
		GetArraySize <exclude_array>
		<exclude_array_size> = <array_size>
		GetGlobalTags \{user_options}
		begin
		<exclude> = (<exclude_array> [<exclude_index>])
		GetArraySize \{$guitar_hero_cheats}
		<idx> = 0
		begin
		RemoveParameter \{var}
		<var> = ($guitar_hero_cheats [<idx>].var)
		if GotParam \{var}
			if (<var> = <exclude>)
				<name> = ($guitar_hero_cheats [<idx>].name)
				FormatText checksumname = cheat_checksum 'unlock_Cheat_%a' a = <name>
				if NOT ((<...>.<cheat_checksum>) = 0)
					exclude_array = ($guitar_hero_cheats [<idx>].options)
					SetArrayElement ArrayName = guitar_hero_cheat_index GlobalArray index = <idx> newvalue = 0
					GetGlobalTags \{user_options}
					FormatText checksumname = cheat_idx 'cheat_index%a' a = <idx>
					AddParam structure_name = params name = <cheat_idx> value = 0
					SetGlobalTags user_options params = <params>
					exclude_struct = (<exclude_array> [0])
					if NOT GotParam \{no_menu_update}
						text = (<exclude_struct>.text)
						SetScreenElementProps id = {current_menu child = (<idx> + 1)} generic_menu_smenu_textitem_text_text = <text>
					endif
					globals = (<exclude_struct>.globals)
					cheat_set_globals globals = <globals>
				endif
				break
			endif
		endif
		<idx> = (<idx> + 1)
		repeat <array_size>
		<exclude_index> = (<exclude_index> + 1)
		repeat <exclude_array_size>
	endif
endscript

script ui_options_cheats_update_helper 
	GetTags
	clean_up_user_control_helpers
	add_gamertag_helper \{exclusive_device = $primary_controller}
	if GotParam \{unlocked}
		if (<unlocked> = 1)
			if (<toggle> = 0)
				<green_text> = qs("SELECT")
			else
				<green_text> = qs("TOGGLE")
			endif
			add_user_control_helper text = <green_text> button = green z = 100000
			add_user_control_helper \{text = qs("BACK")
				button = red
				z = 100000}
		else
			add_user_control_helper \{text = qs("BACK")
				button = red
				z = 100000}
		endif
	else
		menu_finish
	endif
endscript

script check_CAR_unlocks 
	get_savegame_from_controller controller = ($primary_controller)
	GetGlobalTags savegame = <savegame> user_options
endscript

script disable_because_of_cheats 
	disable = 0
	count_players_by_part \{part = drum}
	if (<players_by_part> > 0)
		if ($Cheat_AutoKick = 1 || $Cheat_FreeDrum = 1)
			disable = 1
		endif
	endif
	count_players_by_part \{part = guitar}
	gtrs_cnt = <players_by_part>
	count_players_by_part \{part = Bass}
	gtrs_cnt = (<players_by_part> + <gtrs_cnt>)
	if (<gtrs_cnt> > 0)
		if ($Cheat_AlwaysSlide = 1 || $Cheat_allHOPOs = 1)
			disable = 1
		endif
	endif
	if ($Cheat_Invincible = 1)
		disable = 1
	endif
	return cheat_disable = <disable>
endscript

script ui_options_cheats_focus 
	<id> :SE_SetProps generic_menu_smenu_textitem_text_rgba = (($default_color_scheme).text_focus_color)
	Obj_GetID
	GetTags
	CheatsInterface :GetSingleTag \{array_size}
	if (<index> < 0)
		change \{ui_cheats_do_anim = 1}
	else
		change \{ui_cheats_do_anim = 0}
	endif
	CheatsInterface :SE_SetProps scrollthumb_pos = (((((<index> + 1.0) / <array_size>) * 320.0) * (0.0, 1.0))) time = 0.05
	if CheatsInterface :Desc_ResolveAlias \{name = alias_highlight}
		Wait \{2
			gameframe}
		GetScreenElementChildren id = <ObjID>
		GetScreenElementChildren id = (<children> [0])
		GetScreenElementChildren id = (<children> [0])
		GetScreenElementDims id = (<children> [0])
		scale = (((1.0, 0.0) * (((<width> + 100.0) / 256.0))) + (0.0, 1.7))
		GetScreenElementPosition id = (<children> [0]) summed
		<resolved_id> :SE_SetProps pos = {absolute <screenelementpos>} scale = <scale>
		<resolved_id> :SE_WaitProps
		GetScreenElementPosition id = (<children> [0]) summed
		<resolved_id> :SE_SetProps pos = {absolute (<screenelementpos> + (0.0, -15.0))} time = 0.05
		<resolved_id> :SE_WaitProps
		GetScreenElementPosition id = (<children> [0]) summed
		<resolved_id> :SE_SetProps pos = {absolute <screenelementpos>} scale = <scale> time = 0.05
		<resolved_id> :SE_WaitProps
	endif
endscript

script ui_options_cheats_unfocus 
	<id> :SE_SetProps generic_menu_smenu_textitem_text_rgba = (($default_color_scheme).text_color)
endscript

script ui_options_cheats_anim_out 
endscript
