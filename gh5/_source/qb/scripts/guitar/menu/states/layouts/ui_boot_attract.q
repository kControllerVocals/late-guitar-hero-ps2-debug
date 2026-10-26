
script ui_create_boot_attract 
	PushVideoVenues
	spawnscriptnow \{ui_create_boot_attract_spawned}
endscript

script ui_destroy_boot_attract 
	PauseGh3Sounds
	PauseGame
	KillSpawnedScript \{name = ui_create_boot_attract_spawned}
	if ScreenElementExists \{id = current_menu}
		current_menu :Die
	endif
	spawnscriptnow \{kill_gem_scroller}
	destroy_magazine_viewport
	setup_bg_viewport
	band_builder_clear_random_appearances
	reset_character_ids
	UnPauseGame
	UnpauseGh3Sounds
	spawnscriptnow \{Attract_Mode_Ends_Sound_Script}
	SpawnScriptLater \{Undo_attract_bots}
	change \{is_attract_mode = 0}
	PopVideoVenues
	spawnscriptnow \{menu_music_on}
endscript

script Undo_attract_bots 
	Wait \{2
		gameframes}

	change \{structurename = player1_status
		bot_play = 0}
	change \{structurename = player2_status
		bot_play = 0}
	change \{structurename = player3_status
		bot_play = 0}
	change \{structurename = player4_status
		bot_play = 0}
endscript

script ui_create_boot_attract_spawned 
	change \{is_attract_mode = 1}
	spawnscriptnow \{Attract_Mode_Start_Sound_Script}
	GetArraySize \{$Attract_Mode_Info}
	if (<array_size> = 1)
		attract_mode_index = 0
	else
		if ($last_attract_mode >= 0)
			GetRandomValue name = attract_mode_index Integer a = 0 b = (<array_size> - 2)
			if (<attract_mode_index> >= $last_attract_mode)
				attract_mode_index = (<attract_mode_index> + 1)
			endif
		else
			GetRandomValue name = attract_mode_index Integer a = 0 b = (<array_size> - 1)
		endif
		change last_attract_mode = <attract_mode_index>
	endif
	AddParams ($Attract_Mode_Info [<attract_mode_index>])
	change \{structurename = player1_status
		bot_play = 1}
	change \{structurename = player2_status
		bot_play = 1}
	change \{structurename = player3_status
		bot_play = 1}
	change \{structurename = player4_status
		bot_play = 1}
	change current_level = <level>
	change current_song = <song>
	change game_mode = <mode>
	change \{current_num_players = 4}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = Bass}
	change \{structurename = player3_status
		part = drum}
	change \{structurename = player4_status
		part = Vocals}
	change structurename = player1_status character_id = <guitar_character_id>
	change structurename = player2_status character_id = <bass_character_id>
	change structurename = player3_status character_id = <drum_character_id>
	change structurename = player4_status character_id = <vocals_character_id>
	p1_difficulty = expert
	p2_difficulty = expert
	destroy_band
	mark_unsafe_for_shutdown
	UnPauseGame
	Load_Venue
	start_gem_scroller song_name = <song> difficulty = <p1_difficulty> difficulty2 = <p2_difficulty> StartTime = 0 device_num = ($player1_status.controller)
	destroy_loading_screen
	get_handlers_for_all_buttons \{event_script = ui_boot_attract_wait_for_input}
	CreateScreenElement {
		type = ContainerElement
		dims = (1280.0, 720.0)
		just = [0.0 0.0]
		pos_anchor = [-1.0 -1.0]
		pos = (640.0, 360.0)
		z_priority = 0.0
		parent = root_window
		id = current_menu
		event_handlers = <event_handlers>
	}
	CreateScreenElement \{type = TextElement
		text = qs("PRESS ANY BUTTON TO ROCK!")
		pos = (640.0, 637.0)
		parent = current_menu
		rgba = [
			220
			220
			220
			255
		]
		font = fontgrid_text_a1
		just = [
			center
			bottom
		]
		scale = 0.6
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]}
	CreateScreenElement \{texture = logo_GH5_256
		type = SpriteElement
		alpha = 0.75
		dims = (256.0, 256.0)
		just = [
			0.0
			0.0
		]
		pos_anchor = [
			-1.0
			-1.0
		]
		pos = (1023.4459, 183.96547)
		parent = current_menu}
	LaunchEvent \{type = focus
		target = current_menu}
	fadetoblack \{off
		alpha = 1.0
		time = 0.0
		z_priority = -100
		no_wait}
endscript

script ui_boot_attract_wait_for_input 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	wait_for_safe_shutdown
	PauseGh3Sounds
	set_loading_screen \{full}
	ui_event \{event = menu_back}
endscript
Attract_Mode_Info = [
	{
		level = load_Z_Subway
		song = AllAlongTheWatchTower
		mode = p4_quickplay
		guitar_character_id = RandomCharacter
		bass_character_id = RandomCharacter
		drum_character_id = RandomCharacter
		vocals_character_id = RandomCharacter
	}
	{
		level = load_Z_LHC
		song = OnlyHappyWhenItRains
		mode = p4_quickplay
		guitar_character_id = RandomCharacter
		bass_character_id = RandomCharacter
		drum_character_id = RandomCharacter
		vocals_character_id = RandomCharacter
	}
	{
		level = load_Z_FreakShow
		song = YouGiveLove
		mode = p4_quickplay
		guitar_character_id = RandomCharacter
		bass_character_id = RandomCharacter
		drum_character_id = RandomCharacter
		vocals_character_id = RandomCharacter
	}
	{
		level = load_Z_NewOrleans
		song = HurtsSoGood
		mode = p4_quickplay
		guitar_character_id = RandomCharacter
		bass_character_id = RandomCharacter
		drum_character_id = RandomCharacter
		vocals_character_id = RandomCharacter
	}
]
last_attract_mode = -1
is_attract_mode = 0
