training_band_tutorial_script = [
	{
		call = training_band_tutorial_startup
	}
	{
		time = 1000
		call = training_band_tutorial_show_title
	}
	{
		lesson = 1
		call = training_6_1_show_lesson_header
	}
	{
		call = training_6_1_complete_message
	}
	{
		lesson = 2
		call = training_6_2_show_lesson_header
	}
	{
		call = training_6_2_show_instruments
	}
	{
		call = training_6_2_show_highway
	}
	{
		call = training_6_2_show_items_on_highway
	}
	{
		call = training_6_2_show_bands_rock_meter_and_demo
	}
	{
		call = training_6_2_show_individual_indicators_and_demo
	}
	{
		call = training_6_2_show_individual_note_streak_and_demo
	}
	{
		call = training_6_2_complete_message
	}
	{
		lesson = 3
		call = training_6_3_show_lesson_header
	}
	{
		call = training_6_3_show_highway
	}
	{
		call = training_6_3_show_bands_rock_meter_and_demo
	}
	{
		call = training_6_3_show_band_playing_in_unison
	}
	{
		call = training_6_3_complete_message
	}
	{
		call = training_band_tutorial_1_end
	}
]

script training_band_tutorial_startup 

	training_init_session
	0xc1c4e84c \{mode = tutorials
		tutorial = 1}
	setplayerinfo \{1
		four_lane_highway = 0}
	launchevent \{type = unfocus
		target = root_window}
	create_training_pause_handler
	training_create_narrator_icons
endscript

script training_band_tutorial_show_title 
	change \{g_training_lessons_completed = 0}

	training_show_title \{title = qs(0xab248876)}
	begin
	if ($transitions_locked = 0)
		break
	endif
	wait \{1
		gameframe}
	repeat
	create_training_pause_handler
	wait \{3
		seconds}
	training_destroy_title
endscript

script training_6_1_show_lesson_header 

	training_set_lesson_header_text \{number = qs(0x22ee76e7)
		text = qs(0x80328de0)}
	training_show_lesson_header
	create_training_pause_handler
	training_show_narrator \{narrator = 'bassist'}
	0x4de05aff \{mode = 0xb33bf552}
	training_play_sound \{sound = 'Tut_Band_Intro_01_BAS'
		wait}
	wait \{0.25
		seconds}
	training_play_sound \{sound = 'Tut_Band_Intro_02_BAS'
		wait}
	training_hide_narrator
endscript

script training_6_1_complete_message 

	training_generic_lesson_complete
endscript

script training_6_2_show_lesson_header 

	training_set_lesson_header_text \{number = qs(0x09c32524)
		text = qs(0x9a21156c)}
	training_show_lesson_header
	create_training_pause_handler
endscript

script training_6_2_show_instruments 

	create_training_pause_handler
	if screenelementexists \{id = menu_tutorial}
		launchevent \{type = unfocus
			target = menu_tutorial}
		destroy_menu \{menu_id = menu_tutorial}
	endif
	event_handlers = [
		{pad_start show_training_pause_screen}
	]
	new_menu {
		scrollid = menu_tutorial
		vmenuid = vmenu_tutorial
		menu_pos = (0.0, 0.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	launchevent \{type = focus
		target = menu_tutorial}
	createscreenelement \{parent = menu_tutorial
		id = training_instrument_select_hub
		type = descinterface
		desc = 'band_play'}
	assignalias id = <id> alias = myinterfaceelement
	if training_instrument_select_hub :desc_resolvealias \{name = alias_hmenu}
		band_hmenu = <resolved_id>
	endif
	training_instrument_select_hub :se_getprops
	menu_array = []
	desc_array = []
	i = 0
	begin
	resolvescreenelementid id = [
		{id = <band_hmenu>}
		{index = <i>}
	]
	addarrayelement array = <desc_array> element = <resolved_id>
	desc_array = <array>
	desc_id = <resolved_id>
	<resolved_id> :obj_spawnscript highlight_motion params = {menu_id = <resolved_id>}
	<resolved_id> :desc_resolvealias name = alias_menu
	if screenelementexists id = <resolved_id>
		allowed = {guitar bass drum vocals}
		<resolved_id> :settags {
			menu = instrument
			instrument = none
			difficulty = none
			controller = <i>
			allowed = <allowed>
			index = <i>
		}
		destroyscreenelement id = <resolved_id> preserve_parent
		text_params = {
			type = textblockelement
			fit_width = `scale each line if larger`
			fit_height = `scale down if larger`
			parent = <resolved_id>
			event_handlers = [
				{focus ui_band_mode_focus}
				{unfocus retail_menu_unfocus}
			]
			internal_scale = 0.75
			just = [center bottom]
			internal_just = [center center]
			font = fontgrid_text_a6
			rgba = [255 255 255 255]
			dims = (200.0, 40.0)
		}
		createscreenelement {
			<text_params>
			text = qs(0x9504b94a)
		}
		createscreenelement {
			<text_params>
			text = qs(0x7d4f9214)
		}
		createscreenelement {
			<text_params>
			text = qs(0x388cd3db)
		}
		createscreenelement {
			<text_params>
			text = qs(0x1b9f6f84)
		}
		addarrayelement array = <menu_array> element = <resolved_id>
		menu_array = <array>
		if <desc_id> :desc_resolvealias name = alias_highlight
			<resolved_id> :se_setprops pos = ((0.0, -120.0) + ((0.0, 34.0) * <i>))
		endif
	endif
	i = (<i> + 1)
	repeat 4
	training_instrument_select_hub :settags {menus = <menu_array> descs = <desc_array>}
	menu_finish
	clean_up_user_control_helpers
	training_show_narrator \{narrator = 'bassist'}
	0x4de05aff \{mode = 0xd37d8f70}
	training_play_sound \{sound = 'Tut_Band_Play_01_BAS'
		wait}
	training_hide_narrator
	destroy_menu \{menu_id = menu_tutorial}
	training_hide_lesson_header
endscript

script training_6_2_show_highway 

	setplayerinfo \{2
		four_lane_highway = 0}
	training_start_gem_scroller \{players = 4
		song = tut_demo
		bot_array = [
			1
			1
			1
			1
		]}
	if screenelementexists \{id = menu_tutorial}
		launchevent \{type = unfocus
			target = menu_tutorial}
		destroy_menu \{menu_id = menu_tutorial}
	endif
	create_training_pause_handler
	change \{structurename = band1_status
		score = 3141975}
	training_wait_for_gem_scroller_startup
endscript

script training_6_2_show_items_on_highway 

	create_training_pause_handler
	wait \{3.6
		seconds
		ignoreslomo}
	training_pause_gem_scroller
	0x4de05aff \{mode = 0x442f0bde}
	training_play_sound \{sound = 'Tut_Band_Star_01_BAS'}
	wait \{2
		seconds
		ignoreslomo}
	<0xf907476f> = 2.3
	training_add_arrow id = training_arrow2 life = 2 pos = (640.0, 120.0) scale = <0xf907476f> rot = 180
	wait \{2
		seconds
		ignoreslomo}
	training_add_arrow id = training_arrow2 life = 2 pos = (235.0, 360.0) scale = <0xf907476f>
	training_add_arrow id = training_arrow2 life = 2 pos = (1045.0, 360.0) scale = <0xf907476f>
	training_add_arrow id = training_arrow2 life = 2 pos = (640.0, 360.0) scale = <0xf907476f>
	wait \{3
		seconds
		ignoreslomo}
	training_destroy_all_arrows
endscript

script training_6_2_spawn_meter_changing 

	<0xf907476f> = 2.3
	training_add_arrow id = training_arrow2 life = 4 pos = (275.0, 250.0) scale = <0xf907476f> rot = 90
	killspawnedscript \{name = training_set_health}
	spawnscriptnow \{training_set_health
		params = {
			health = 1.0
			band
		}
		id = training_spawned_script}
	wait \{9
		seconds
		ignoreslomo}
	wait \{2
		seconds
		ignoreslomo}
	killspawnedscript \{name = training_set_health}
	spawnscriptnow \{training_set_health
		params = {
			health = 1.6
			band
		}
		id = training_spawned_script}
	wait \{2
		seconds
		ignoreslomo}
	killspawnedscript \{name = training_set_health}
	spawnscriptnow \{training_set_health
		params = {
			health = 0.4
			band
		}
		id = training_spawned_script}
	wait \{2
		seconds
		ignoreslomo}
	training_start_hud_flashing_red
endscript

script training_6_2_show_bands_rock_meter_and_demo 

	create_training_pause_handler
	spawnscriptnow \{training_6_2_spawn_meter_changing
		id = training_spawned_script}
	training_play_sound \{sound = 'Tut_Band_Star_02_BAS'
		wait}
	training_stop_hud_flashing_red
endscript

script training_6_2_move_individual_indicators 

	<0xf907476f> = 2.3
	killspawnedscript \{name = training_set_health}
	spawnscriptnow \{training_set_health
		params = {
			health = 1.0
			band
		}
		id = training_spawned_script}
	training_add_arrow id = training_arrow2 life = 4 pos = (475.0, 500.0) scale = <0xf907476f> rot = -45
	player_status = player1_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.5 ignore_band_members} id = training_spawned_script
	player_status = player2_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.2 ignore_band_members} id = training_spawned_script
	player_status = player3_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 1.4 ignore_band_members} id = training_spawned_script
	player_status = player4_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.8 ignore_band_members} id = training_spawned_script
	wait \{2.0
		seconds
		ignoreslomo}
	killspawnedscript \{name = training_set_health}
	player_status = player1_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.2 ignore_band_members} id = training_spawned_script
	player_status = player2_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 1.1 ignore_band_members} id = training_spawned_script
	player_status = player3_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.8 ignore_band_members} id = training_spawned_script
	player_status = player4_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 1.6 ignore_band_members} id = training_spawned_script
	wait \{2.0
		seconds
		ignoreslomo}
	killspawnedscript \{name = training_set_health}
	player_status = player1_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 1.1 ignore_band_members} id = training_spawned_script
	player_status = player2_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.6 ignore_band_members} id = training_spawned_script
	player_status = player3_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 1.6 ignore_band_members} id = training_spawned_script
	player_status = player4_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.2 ignore_band_members} id = training_spawned_script
	wait \{2.0
		seconds
		ignoreslomo}
	killspawnedscript \{name = training_set_health}
	player_status = player1_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.2 ignore_band_members} id = training_spawned_script
	player_status = player2_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.2 ignore_band_members} id = training_spawned_script
	player_status = player3_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.2 ignore_band_members} id = training_spawned_script
	player_status = player4_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 0.2 ignore_band_members} id = training_spawned_script
endscript

script training_6_2_show_individual_indicators_and_demo 

	create_training_pause_handler
	wait \{2.0
		seconds
		ignoreslomo}
	spawnscriptnow \{training_6_2_move_individual_indicators
		id = training_spawned_script}
	training_play_sound \{sound = 'Tut_Band_Star_03_BAS'
		wait}
	wait \{1.0
		seconds
		ignoreslomo}
endscript

script training_6_2_show_note_streak_indicator 

	killspawnedscript \{name = training_set_health}
	spawnscriptnow \{training_set_health
		params = {
			health = 1.6
			band
		}
		id = training_spawned_script}
	player_status = player1_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 1.6 ignore_band_members} id = training_spawned_script
	player_status = player2_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 1.6 ignore_band_members} id = training_spawned_script
	player_status = player3_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 1.6 ignore_band_members} id = training_spawned_script
	player_status = player4_status
	spawnscriptnow training_set_health params = {player_status = <player_status> health = 1.6 ignore_band_members} id = training_spawned_script
	wait \{4.0
		seconds
		ignoreslomo}
	<0xf907476f> = 2.3
	training_add_arrow id = training_arrow2 life = 4 pos = (875.0, 250.0) scale = <0xf907476f> rot = -90
endscript

script training_6_2_show_individual_note_streak_and_demo 

	create_training_pause_handler
	gamemode_updatecooperative \{cooperative = 1}
	spawnscriptnow \{training_6_2_show_note_streak_indicator
		id = training_spawned_script}
	tutorialsetbandstreak \{streak = 50}
	training_play_sound \{sound = 'Tut_Band_Star_04_BAS'
		wait}
	tutorialsetbandstreak \{streak = 0}
	gamemode_updatecooperative \{cooperative = 0}
endscript

script training_6_2_complete_message 

	training_play_sound \{sound = 'Tut_Band_Star_05_BAS'
		wait}
	training_resume_gem_scroller
	destroy_menu \{menu_id = menu_tutorial}
	create_training_pause_handler
	training_destroy_gem_scroller
	training_generic_lesson_complete
endscript

script training_6_3_show_lesson_header 

	training_set_lesson_header_text \{number = qs(0x10d81465)
		text = qs(0x9b6522a5)}
	create_training_pause_handler
	0x4de05aff \{mode = 0x442f0bde}
endscript

script training_6_3_show_highway 

	setplayerinfo \{2
		four_lane_highway = 0}
	training_start_gem_scroller \{players = 4
		song = tut_demo
		bot_array = [
			1
			1
			1
			1
		]}
	if screenelementexists \{id = menu_tutorial}
		launchevent \{type = unfocus
			target = menu_tutorial}
		destroy_menu \{menu_id = menu_tutorial}
	endif
	event_handlers = [
		{pad_start show_training_pause_screen}
	]
	new_menu {
		scrollid = menu_tutorial
		vmenuid = vmenu_tutorial
		menu_pos = (120.0, 190.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	launchevent \{type = focus
		target = menu_tutorial}
	change \{structurename = band1_status
		score = 3141975}
	training_wait_for_gem_scroller_startup
	spawnscriptnow \{training_set_health
		params = {
			health = 1.6
			band
		}
		id = training_spawned_script}
endscript

script training_6_3_trigger_band_star_power 

	change \{structurename = band1_status
		star_power_amount = 100}
	change \{structurename = band1_status
		star_power_display_amount = 100}
	<i> = 1
	begin
	getplayerinfo <i> checksum
	getplayerinfo <i> player
	getplayerinfo <i> text
	change structurename = <checksum> star_power_amount = 100
	spawnscriptnow star_power_activate_and_drain params = {player_status = <checksum> player = <player> player_text = <text>} id = training_spawned_script
	<i> = (<i> + 1)
	repeat 4
	spawnscriptnow \{training_6_3_drain_star_power
		id = training_spawned_script}
endscript

script training_6_3_drain_star_power 

	training_resume_gem_scroller
	<i> = 0.0
	begin
	j = 1
	begin
	getplayerinfo <j> checksum
	getplayerinfo <j> player
	getplayerinfo <j> text
	change structurename = <checksum> star_power_amount = (100.0 - ((<i> / 450.0) * 100.0))
	j = (<j> + 1)
	repeat 4
	change structurename = band1_status star_power_amount = (100.0 - ((<i> / 450.0) * 100.0))
	change structurename = band1_status star_power_display_amount = (100.0 - ((<i> / 450.0) * 100.0))
	wait \{1
		gameframes}
	i = (<i> + 1.0)
	repeat 450
	change \{structurename = band1_status
		star_power_display_amount = 0.0}
	training_clear_out_star_power
	training_pause_gem_scroller
endscript

script training_6_3_show_arrow_pointing_to_bulbs 

	wait \{3.0
		seconds
		ignoreslomo}
	killspawnedscript \{name = training_set_health}
	<0xf907476f> = 2.3
	training_add_arrow id = training_arrow2 life = 4 pos = (300.0, 225.0) scale = <0xf907476f> rot = 90
endscript

script training_6_3_show_bands_rock_meter_and_demo 

	create_training_pause_handler
	wait \{3.6
		seconds
		ignoreslomo}
	training_pause_gem_scroller
	spawnscriptnow \{training_6_3_show_arrow_pointing_to_bulbs
		id = training_spawned_script}
	training_play_sound \{sound = 'Tut_Band_Star_06_BAS'
		wait}
endscript

script training_6_3_show_band_playing_in_unison 

	create_training_pause_handler
	training_6_3_trigger_band_star_power
	wait \{4.0
		seconds
		ignoreslomo}
	training_play_sound \{sound = 'Tut_Band_Star_07_BAS'
		wait}
	wait \{0.5
		seconds
		ignoreslomo}
	training_play_sound \{sound = 'Tut_Band_Star_08_BAS'
		wait}
	training_clear_out_star_power
	wait \{3.0
		seconds
		ignoreslomo}
	training_play_sound \{sound = 'Tut_Band_Star_09_BAS'
		wait}
endscript

script training_6_3_complete_message 

	training_play_sound \{sound = 'Tut_Band_Star_10_BAS'
		wait}
	destroy_menu \{menu_id = menu_tutorial}
	create_training_pause_handler
	training_hide_lesson_header
	training_destroy_gem_scroller
	soundevent \{event = tutorial_mode_finish_chord}
	spawnscriptnow \{create_exploding_text
		id = training_spawned_script
		params = {
			parent = 'lesson_complete'
			text = qs(0x9e47f4d7)
			text_physics = 0
			placement = ps2_tut_top
		}}
	spawnscriptnow \{create_exploding_text
		id = training_spawned_script
		params = {
			parent = 'complete_text'
			text = qs(0x232d1eaf)
			text_physics = 0
			placement = ps2_tut_bottom
		}}
	wait \{7
		seconds
		ignoreslomo}
	killspawnedscript \{name = create_exploding_text}
	destroy_all_exploding_text
	change g_training_lessons_completed = ($g_training_lessons_completed + 1)
endscript

script training_band_tutorial_1_end 

	training_container :gettags
	if ($g_training_lessons_completed = 3)
		setglobaltags \{practice
			params = {
				band_lesson = complete
			}}
	endif
	training_kill_session
	if screenelementexists \{id = menu_tutorial}
		launchevent \{type = unfocus
			target = menu_tutorial}
		destroy_menu \{menu_id = menu_tutorial}
	endif
	training_destroy_narrator_icons
	setscreenelementprops \{id = root_window
		event_handlers = [
			{
				pad_start
				gh3_start_pressed
			}
		]
		replace_handlers}
	training_check_for_all_tutorials_finished
	decide_tutorial_back_destination
endscript
