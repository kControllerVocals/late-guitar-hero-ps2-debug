default_section_rgba = [
	183
	186
	255
	255
]
default_section_focus_rgba = [
	21
	41
	78
	255
]
0x0fda6dc9 = 0

script 0xb9063743 

	if NOT resolvescreenelementid id = <id>
		0x93d8d5cf \{'Could not resolve id.'}
	endif
	return <...>
endscript

script ui_init_select_song_section 
	change menu_flow_locked = ($menu_flow_locked + 1)
	menu_music_off
	0xfd22d1e7 \{num = 1}
	change \{current_num_players = 1}
	gamemode_updatenumplayers \{num_players = 1}
	if NOT ($game_mode = practice)
		if gotparam \{from_in_game}
			change \{practice_enabled = 1}
			change came_to_practice_from = ($game_mode)
			if NOT ($current_progression_flag = none)
				change came_to_practice_from_progression = ($current_progression_flag)
			endif
			getplayerinfo \{1
				character_id}
			if NOT (<character_id> = emptyguy)
				change came_to_practice_character_id = <character_id>
				setplayerinfo \{1
					character_id = emptyguy}
			endif
			change \{game_mode = practice}
		else
			change \{came_to_practice_from = main_menu}
		endif
	endif
	disable_pause
	unpausegame
endscript

script ui_create_select_song_section 
	change \{current_speedfactor = 1.0}
	setslomo \{$current_speedfactor}
	0xce69e479
	load_songqpak song_name = ($current_song) async = 0
	createscreenelement \{parent = root_window
		type = descinterface
		id = songsectiondesc
		desc = 'setlist_b_practice_sessions_desc'}
	if NOT songsectiondesc :desc_resolvealias \{name = alias_menu}
		0x93d8d5cf \{'Failed to resolve alias_menu.'}
	endif
	assignalias id = <resolved_id> alias = current_menu
	current_menu :se_setprops {
		allow_wrap = false
		exclusive_device = ($primary_controller)
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back ui_select_song_section_back}
		]
		tags = {
			start_index = -1
			end_index = -1
		}
	}
	createscreenelement \{parent = current_menu
		type = descinterface
		desc = 'setlist_b_practice_sessions_item_desc'
		autosizedims = false
		dims = (600.0, 40.0)
		section_text = qs(0xe1f4baaf)
		section_rgba = $default_section_rgba
		event_handlers = [
			{
				focus
				ui_select_song_section_focus_item
			}
			{
				focus
				ui_select_song_section_preview
			}
			{
				unfocus
				ui_select_song_section_unfocus_item
			}
			{
				pad_choose
				ui_select_song_section_choose_item
			}
		]
		tags = {
			playfullsong
			section_index = 0
			menu_index = 0
			strikeout_alpha = 0
			default_rgba = $default_section_rgba
		}}
	get_song_section_array
	getarraysize <song_section_array>
	marker_array_size = <array_size>
	getplayerinfo \{1
		part}
	if (<marker_array_size> > 0)
		section_index = 1
		menu_index = 1
		begin
		shortenuistring {
			ui_string = ((<song_section_array> [(<section_index> - 1)]).marker)
			max_len = 50
		}
		if (<short_ui_string> != qs(0x03ac90f0))
			getrandomvalue \{a = 1
				b = 2
				name = rand_int
				integer}
			formattext checksumname = strikeout_texture 'strike_0%d' d = <rand_int>
			strikeout_alpha = 0
			<section_rgba> = $default_section_rgba
			createscreenelement {
				parent = current_menu
				type = descinterface
				desc = 'setlist_b_practice_sessions_item_desc'
				autosizedims = false
				dims = (600.0, 40.0)
				section_text = <short_ui_string>
				section_rgba = <section_rgba>
				event_handlers = [
					{focus ui_select_song_section_focus_item}
					{focus ui_select_song_section_preview}
					{unfocus ui_select_song_section_unfocus_item}
					{pad_choose ui_select_song_section_choose_item}
				]
				strikeout_texture = <strikeout_texture>
				strikeout_alpha = <strikeout_alpha>
				tags = {
					section_index = <section_index>
					menu_index = <menu_index>
					strikeout_texture = <strikeout_texture>
					strikeout_alpha = <strikeout_alpha>
					default_rgba = <section_rgba>
				}
			}
			menu_index = (<menu_index> + 1)
		endif
		section_index = (<section_index> + 1)
		repeat <marker_array_size>
	endif
	if gotparam \{selected_index}
		getscreenelementchildren \{id = current_menu}
		getarraysize <children>
		ratio = (<selected_index> / (<marker_array_size> - 1.0))
		scroll_pos = ((358.0, -174.0) + ((0.0, 184.0) * <ratio>))
		songsectiondesc :se_setprops scroll_thumb_pos = <scroll_pos> time = <time>
	endif
	add_user_control_helper text = qs(0xc18d5e76) button = green z = 100000 all_buttons <...>
	if ($0x0fda6dc9 = 0)
		add_user_control_helper text = qs(0xaf4d5dd2) button = red z = 100000 <...>
	endif
	current_menu :settags \{lead_in = 0}
	current_menu :settags \{lead_out = 0}
	spawnscriptnow \{0x720e0033}
	change menu_flow_locked = ($menu_flow_locked - 1)
	change \{0x4026c71d = 1}
	change target_practice_songpreview = ($current_song)
	spawnscriptnow \{0x6fda5080}
endscript

script 0x6fda5080 
	begin
	if NOT scriptisrunning \{practice_songpreview_monitor}
		spawnscriptnow \{practice_songpreview_monitor}
		break
	endif
	waitonegameframe
	repeat
endscript

script 0x720e0033 
	change menu_flow_locked = ($menu_flow_locked + 1)
	wait \{20
		gameframes}
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_select_song_section 
	change menu_flow_locked = ($menu_flow_locked + 1)
	killspawnedscript \{name = 0x6fda5080}
	change \{0xe6376e68 = 0}
	destroyscreenelement \{id = songsectiondesc}
	setsoundbussparams {leadvox_balance = {vol = ($default_bussset.leadvox_balance.vol)}}
	setsoundbussparams {drums_balance = {vol = ($default_bussset.drums_balance.vol)}}
	setsoundbussparams {leadgtr_balance = {vol = ($default_bussset.leadgtr_balance.vol)}}
	setsoundbussparams {bass_balance = {vol = ($default_bussset.bass_balance.vol)}}
	setsoundbussparams {rhythmgtr_balance = {vol = ($default_bussset.rhythmgtr_balance.vol)}}
	setsoundbussparams {crowd_balance = {vol = ($default_bussset.crowd_balance.vol)}}
	setsoundbussparams {crowdsingalong_balance = {vol = ($default_bussset.crowdsingalong_balance.vol)}}
	setsoundbussparams {band_balance = {vol = ($default_bussset.band_balance.vol)}}
	clean_up_user_control_helpers
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_deinit_select_song_section 
	0x88e84c31
	change menu_flow_locked = ($menu_flow_locked + 1)
	change \{0x0fda6dc9 = 0}
	if NOT gotparam \{0xc6fc2b2b}
		spawnscriptnow \{end_practice_song}
	endif
	unload_songqpak
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_select_song_section_focus_item 
	current_menu :gettags
	gettags
	getscreenelementchildren \{id = current_menu}
	getarraysize <children>
	children_array_size = <array_size>
	if NOT (<start_index> = -1)
		i = 0
		begin
		0xb9063743 id = {current_menu child = <i>}
		<resolved_id> :getsingletag section_index
		if (<section_index> = <start_index>)
			if NOT (<i> = <menu_index>)
				<resolved_id> :se_setprops {
					section_rgba = $default_section_focus_rgba
					highlight_rgba = [255 , 255 , 255 , 220]
					highlight_alpha = 1.0
				}
				i = (<i> + 1)
			endif
			break
		endif
		i = (<i> + 1)
		repeat
		begin
		if (<i> = <menu_index>)
			break
		endif
		0xb9063743 id = {current_menu child = <i>}
		<resolved_id> :se_setprops {
			section_rgba = $default_section_focus_rgba
			highlight_rgba = [255 255 255 160]
			highlight_alpha = 1.0
		}
		i = (<i> + 1)
		repeat
	endif
	if (<children_array_size> > 1.0)
		ratio = (<menu_index> / (<children_array_size> - 1.0))
	else
		ratio = 0
	endif
	scroll_pos = ((358.0, -174.0) + ((0.0, 184.0) * <ratio>))
	se_setprops {
		section_rgba = $default_section_focus_rgba
		highlight_rgba = [255 , 255 , 255 , 220]
		highlight_alpha = 1.0
		scroll_thumb_pos = <scroll_pos>
		time = 0.1
	}
endscript

script ui_select_song_section_unfocus_item 
	getsingletag \{default_rgba}
	se_setprops section_rgba = <default_rgba> highlight_alpha = 0.0 time = 0.1
endscript

script ui_select_song_section_choose_item 
	if ($transitions_locked = 1 || $menu_flow_locked > 0)
		return
	endif
	current_menu :gettags
	gettags
	if gotparam \{playfullsong}
		current_menu :settags \{start_index = 0}
		current_menu :settags \{lead_in = 0}
		current_menu :settags \{lead_out = 0}
		params = {playfullsong}
		current_menu :obj_spawnscript ui_select_song_section_set_times params = {<params>}
		return
	endif
	if (<start_index> = -1)
		generic_menu_up_or_down_sound
		current_menu :settags start_index = <section_index>
	else
		current_menu :settags start_index = (<start_index> - 1)
		current_menu :settags end_index = <section_index>
		current_menu :obj_spawnscript \{ui_select_song_section_set_times}
		return
	endif
	songsectiondesc :se_setprops \{message_text = qs(0x3da2472b)}
	clean_up_user_control_helpers
	add_user_control_helper \{text = qs(0xc18d5e76)
		button = green
		z = 100000
		all_buttons}
	add_user_control_helper text = qs(0xaf4d5dd2) button = red z = 100000 <...>
	getscreenelementchildren \{id = current_menu}
	getarraysize <children>
	i = 0
	begin
	if (<i> >= <menu_index>)
		break
	endif
	curr_item = (<children> [<i>])
	<curr_item> :se_setprops {
		not_focusable
		section_rgba = <default_section_rgba>
		highlight_rgba = [255 , 255 , 255 , 220]
		highlight_alpha = 0.0
		strikeout_texture = <strikeout_texture>
		strikeout_alpha = <strikeout_alpha>
	}
	i = (<i> + 1)
	repeat <array_size>
endscript

script ui_select_song_section_back 
	current_menu :getsingletag \{start_index}
	if (<start_index> = -1)
		if ($0x0fda6dc9 = 1)
			return
		endif
		change \{0xe6376e68 = 0}
		generic_menu_pad_back_sound
		0xe9384b7a \{full}
		0x73676c55
		if ($came_to_practice_from != main_menu)
			ui_win_song_continue_next_menu \{for_practice = 1}
		else
			generic_event_back \{nosound}
		endif
	else
		change \{0xe6376e68 = 0}
		generic_menu_pad_back_sound
		0xe9384b7a \{0x9fe16047}
		change \{practice_start_index = -1}
		change \{practice_end_index = -1}
		generic_event_refresh
	endif
endscript

script return_to_quickplay_from_practice 
	create_loading_screen
	change \{practice_enabled = 0}
	change game_mode = ($came_to_practice_from)
	if NOT ($came_to_practice_from_progression = none)
		change current_progression_flag = ($came_to_practice_from_progression)
	endif
	if NOT ($came_to_practice_character_id = emptyguy)
		setplayerinfo 1 character_id = ($came_to_practice_character_id)
	endif
	change \{gameplay_restart_song = 1}
	destroy_band
	ui_event_wait_for_safe
	ui_event_block \{event = menu_back
		data = {
			state = uistate_gameplay
		}}
	if ui_event_exists_in_stack \{name = 'practice_warning'}
		ui_event_block \{event = menu_back
			data = {
				state = uistate_practice_warning
			}}
		ui_event_block \{event = menu_back
			data = {
				state = uistate_gameplay
			}}
	endif
	generic_event_replace state = uistate_play_song no_sound data = {selected_level = ($practice_return_venue) can_change_level = 0}
endscript

script ui_select_song_section_set_times \{state = uistate_practice_select_speed}
	0xd3f993c8 \{0x9fe16047}
	onexitrun \{0xe5a305c6}
	generic_menu_pad_choose_sound
	0x73676c55
	se_setprops \{block_events}
	gettags
	get_song_section_array
	getarraysize <song_section_array>
	if (<array_size> > 0)
		change practice_start_time = ((<song_section_array> [<start_index>]).time)
		change practice_start_index = <start_index>
		if ((gotparam playfullsong) || (<end_index> >= <array_size>))
			setup_gemarrays song_name = ($current_song) difficulty = ($player1_status.difficulty) player_status = player1_status
			get_song_end_time song = ($current_song) for_practice = 1
			change practice_end_time = <total_end_time>
			change practice_end_index = <array_size>
		else
			change practice_end_time = ((<song_section_array> [<end_index>]).time - 1)
			change practice_end_index = <end_index>
		endif
		resetnongraymarkers
		change practice_start_time = ($practice_start_time - <lead_in>)
		change practice_end_time = ($practice_end_time + <lead_out>)
	else
		change \{practice_start_time = 0}
		change \{practice_end_time = 0}
		change \{practice_start_index = 0}
		change \{practice_end_index = 0}
	endif
	getplayerinfo \{1
		part}
	if (<part> = vocals)
		change \{0x0fda6dc9 = 1}
		<state> = uistate_play_song
	endif
	generic_event_choose state = <state> no_sound
endscript

script ui_select_song_section_preview 
	setspawninstancelimits \{max = 1
		management = kill_oldest}
	if NOT ($0x4026c71d = 1)
		change \{0x4026c71d = 1}
	endif
	if getsingletag \{playfullsong}
		get_song_end_time song = ($current_song) for_practice = 1
		change \{target_practice_songpreview_starttime = 0}
		change target_practice_songpreview_endtime = <total_end_time>
		change \{0x4026c71d = 0}
		change \{force_practice_songpreview_restart = 1}
		return
	endif
	getsingletag \{section_index}
	if NOT (<section_index> > 0)
		0x93d8d5cf \{'Expected positive, non-zero section index.'}
	endif
	get_song_section_array
	getarraysize <song_section_array>
	if NOT (<array_size> > 0)
		0x93d8d5cf \{'There are no sections to play in this song!'}
	endif
	<section_index> = (<section_index> - 1)
	start_time = ((<song_section_array> [<section_index>]).time)
	if (<section_index> < (<array_size> - 1))
		end_time = ((<song_section_array> [<section_index> + 1]).time)
	else
		get_song_end_time song = ($current_song) for_practice = 1
		end_time = <total_end_time>
	endif
	change target_practice_songpreview_starttime = <start_time>
	change target_practice_songpreview_endtime = <end_time>
	change \{0x4026c71d = 0}
	change \{force_practice_songpreview_restart = 1}
endscript

script 0x73676c55 
	change \{0xe6376e68 = 0}
	begin
	if NOT scriptisrunning \{practice_songpreview_monitor}
		break
	endif
	waitonegameframe
	repeat
endscript
practice_start_index = 0
practice_end_index = 0
target_practice_songpreview = none
target_practice_songpreview_starttime = 0
target_practice_songpreview_endtime = 0
force_practice_songpreview_restart = 0
current_practice_songpreview = none
current_practice_songpreview_starttime = 0
current_practice_songpreview_endtime = 0
0x4026c71d = 0
in_destroy_choose_practice_section_menu = 0
0xe6376e68 = 1

script practice_songpreview_monitor 
	setscriptcannotpause
	change \{0xe6376e68 = 1}
	setsoundbussparams {leadvox_balance = {vol = (($default_bussset.leadvox_balance.vol) - 9)} time = 1}
	setsoundbussparams {drums_balance = {vol = (($default_bussset.drums_balance.vol) - 9)} time = 1}
	setsoundbussparams {leadgtr_balance = {vol = (($default_bussset.leadgtr_balance.vol) - 9)} time = 1}
	setsoundbussparams {bass_balance = {vol = (($default_bussset.bass_balance.vol) - 9)} time = 1}
	setsoundbussparams {rhythmgtr_balance = {vol = (($default_bussset.rhythmgtr_balance.vol) - 9)} time = 1}
	setsoundbussparams {crowd_balance = {vol = (($default_bussset.crowd_balance.vol) - 100)} time = 1}
	setsoundbussparams {crowdsingalong_balance = {vol = (($default_bussset.crowdsingalong_balance.vol) - 100)} time = 1}
	setsoundbussparams {band_balance = {vol = (($default_bussset.band_balance.vol) - 9)} time = 1}
	playing_song = 0
	begin
	if NOT ($current_practice_songpreview = $target_practice_songpreview &&
			$current_practice_songpreview_starttime = $target_practice_songpreview_starttime &&
			$force_practice_songpreview_restart = 0)
		song = ($target_practice_songpreview)
		starttime = ($target_practice_songpreview_starttime)
		endtime = ($target_practice_songpreview_endtime)
		killspawnedscript \{name = practice_songpreview_fadeinandrepeat}
		0xdcc8a36f time = <starttime> 0xa5522a7f = false
		0x54844412 = (<adjustedtime>)
		if (<playing_song> = 1)
			end_song
			playing_song = 0
		endif
		if ($shutdown_game_for_signin_change_flag = 0 &&
				$0x4026c71d = 0 &&
				$0xe6376e68 = 1)
			songunload
			preload_song song_name = <song> starttime = <0x54844412>
			change current_practice_songpreview = <song>
			change \{force_practice_songpreview_restart = 0}
			change current_practice_songpreview_starttime = <starttime>
			change current_practice_songpreview_endtime = <endtime>
			if ($current_practice_songpreview = $target_practice_songpreview &&
					$current_practice_songpreview_starttime = $target_practice_songpreview_starttime &&
					$force_practice_songpreview_restart = 0 &&
					$0xe6376e68 = 1)
				begin_song
				playing_song = 1
				spawnscriptnow practice_songpreview_fadeinandrepeat params = {start = <0x54844412> end = <endtime>}
			endif
		endif
	endif
	if ($0xe6376e68 = 0)
		break
	endif
	waitonegameframe
	repeat
	killspawnedscript \{name = practice_songpreview_fadeinandrepeat}
	end_song
	songunload
	change \{current_practice_songpreview = none}
endscript

script practice_songpreview_fadeinandrepeat 

	current = <start>
	begin
	wait \{0.1
		seconds
		ignoreslomo}
	current = (<current> + 100)
	if (<current> >= <end>)
		break
	endif
	repeat
	change \{force_practice_songpreview_restart = 1}
endscript
