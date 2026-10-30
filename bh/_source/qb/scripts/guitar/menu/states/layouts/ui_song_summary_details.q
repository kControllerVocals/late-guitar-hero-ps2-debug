song_summary_details_row_count = 0
0x7a85de77 = 0
0x3ef40519 = 7
0x04ef1201 = 4
0x4027c7fa = 0
0xb1808f7f = 0
num_non_vocal_sections = 0
num_vocal_sections = 0

script ui_create_song_summary_details \{for_transition = 0}
	change menu_flow_locked = ($menu_flow_locked + 1)
	0x4b5f7892
	change \{song_summary_details_row_count = 0}
	gamemode_getnumplayersshown
	gamemode_gettype
	song_details_set_mins_and_maxes
	gig_details = ($gig_detailed_stats)
	getarraysize <gig_details>
	if (<array_size> = 0)

	endif
	get_song_title song = ((<gig_details> [0] [0]).song)
	get_all_exclusive_devices
	createscreenelement {
		parent = root_window
		id = my_detailed_id
		type = descinterface
		desc = 'song_summary_details'
		pos = {(-1500.0, 0.0) relative}
		event_handlers = [
			{pad_back generic_event_back}
		]
		song_title_text = <song_title>
		exclusive_device = <exclusive_device>
	}
	if (<type> = practice)
		my_detailed_id :se_setprops \{pos = (0.0, 0.0)
			main_menu_bg_alpha = 1}
	endif
	if my_detailed_id :desc_resolvealias \{name = alias_song_summary_details_list
			param = details_list_alias}
	else

	endif
	p = 1
	begin
	getplayerinfo <p> part
	getplayerinfo <p> difficulty
	switch (<part>)
		case guitar
		icon_texture = mixer_icon_guitar
		case bass
		icon_texture = mixer_icon_bass
		case drum
		icon_texture = mixer_icon_drums
		case vocals
		icon_texture = mixer_icon_vox
	endswitch
	switch (<difficulty>)
		case beginner
		diff_texture = icon_difficulty_beginner
		case easy
		diff_texture = icon_difficulty_easy
		case medium
		diff_texture = icon_difficulty_medium
		case hard
		diff_texture = icon_difficulty_hard
		case expert
		diff_texture = icon_difficulty_expert
		if (<part> = drum)
			getplayerinfo <p> double_kick_drum
			if (<double_kick_drum> = 1)
				diff_texture = icon_difficulty_expert_plus
			endif
		endif
	endswitch
	formattext checksumname = alpha_check 'icons_p%d_alpha' d = <p>
	formattext checksumname = inst_check 'instrument_p%d_texture' d = <p>
	formattext checksumname = diff_check 'DIFFICULTY_p%d_texture' d = <p>
	formattext checksumname = double_kick_alpha 'double_kick_p%d_alpha' d = <p>
	formattext checksumname = difficulty_alpha 'DIFFICULTY_p%d_alpha' d = <p>
	my_struct = {}
	addparam structure_name = my_struct name = <alpha_check> value = 1.0
	addparam structure_name = my_struct name = <inst_check> value = <icon_texture>
	addparam structure_name = my_struct name = <diff_check> value = <diff_texture>
	getplayerinfo <p> double_kick_drum
	if (<double_kick_drum> = 1)
		addparam structure_name = my_struct name = <double_kick_alpha> value = 1
		addparam structure_name = my_struct name = <difficulty_alpha> value = 0
	else
		addparam structure_name = my_struct name = <double_kick_alpha> value = 0
		addparam structure_name = my_struct name = <difficulty_alpha> value = 1
	endif
	<details_list_alias> :se_setprops <my_struct>
	my_struct = {}
	formattext checksumname = 0x2caca66e 'gamer_tag_0%d_text' d = <p>
	formattext checksumname = 0xadffeaaa 'gamer_tag_0%d_alpha' d = <p>
	formattext textname = 0x49047faf qs(0x72f23aff) d = <p>
	addparam structure_name = my_struct name = <0x2caca66e> value = <0x49047faf>
	addparam structure_name = my_struct name = <0xadffeaaa> value = 1.0
	my_detailed_id :se_setprops <my_struct>
	p = (<p> + 1)
	repeat <num_players_shown>
	song_details_create_scrolling_menu for_transition = <for_transition>
	vocalist = 0
	non_vocalist = 0
	getarraysize (<gig_details> [0])
	num_songs = <array_size>
	song_indx = 0
	get_song_title song = ((<gig_details> [0] [<song_indx>]).song)
	0xb7251e92
	change \{0x4027c7fa = 0}
	change \{0xb1808f7f = 0}
	change \{num_non_vocal_sections = 0}
	change \{num_vocal_sections = 0}
	change \{song_summary_details_row_count = 0}
	0x9a50f97c = 0
	0xe661d380 = 1
	0xdcdcf63f = 2
	0xc61905e9 = <id>
	0x15ccb0bc {
		ui_string = qs(0x8795155b)
		0x678c9e77 = <0x9a50f97c>
		column = 0
	}
	0x15ccb0bc {
		ui_string = qs(0xf75837da)
		0x678c9e77 = <0xe661d380>
		column = 0
	}
	0x15ccb0bc {
		ui_string = qs(0xff3216c6)
		0x678c9e77 = <0xdcdcf63f>
		column = 0
	}
	change \{song_summary_details_row_count = $0x04ef1201}
	i = 1
	begin
	getplayerinfo <i> part
	getplayerinfo <i> difficulty
	if (<part> = vocals)
		vocalist = <i>
	elseif (<non_vocalist> = 0)
		non_vocalist = <i>
	endif
	player_data = (<gig_details> [(<i> -1)] [<song_indx>])
	if (<part> = vocals)
		vocal_phrase_max_qual = (<player_data>.vocal_phrase_max_qual)
		vocal_phrase_quality = (<player_data>.vocal_phrase_quality)
		vocal_phrase_pct = 0
		if (<vocal_phrase_max_qual> > 0)
			percent_notes_hit = (((<vocal_phrase_quality> * 1.0) / <vocal_phrase_max_qual>) * 100.0)
			mathfloor <percent_notes_hit>
			<percent_notes_hit> = <floor>
			if (<percent_notes_hit> = 0 && <vocal_phrase_quality> > 0)
				<percent_notes_hit> = 1
			endif
			formattext textname = notes_hit_entry qs(0xea41c83d) p = <percent_notes_hit> decimalplaces = 0
		else
			<notes_hit_entry> = qs(0x6a5cf46c)
		endif
		<sp_entry> = qs(0x6a5cf46c)
	else
		if (<type> = practice)
			<sp_entry> = qs(0x6a5cf46c)
		else
			formattext textname = sp_entry qs(0x2ba0d6d6) g = (<player_data>.sp_phrases_hit) p = (<player_data>.sp_phrases_total)
		endif
		if (<type> = practice)
			formattext textname = notes_hit_entry qs(0x2ba0d6d6) g = (<player_data>.notes_hit) p = (<player_data>.total_notes)
		else
			formattext textname = notes_hit_entry qs(0x2ba0d6d6) g = (<player_data>.notes_hit) p = (<player_data>.max_notes)
		endif
	endif
	average_mult = (<player_data>.avg_multiplier)
	if (<average_mult> > 8)
		average_mult = 8
	elseif (<average_mult> < 1)
		average_mult = 1
	endif
	formattext textname = 0xd2fd3c13 qs(0x5d9eae64) g = (<player_data>.score)
	formattext textname = mult_entry qs(0x1ad7e10a) p = <average_mult>
	0x15ccb0bc {
		ui_string = <notes_hit_entry>
		0x678c9e77 = <0x9a50f97c>
		column = <i>
	}
	0x15ccb0bc {
		ui_string = <sp_entry>
		0x678c9e77 = <0xe661d380>
		column = <i>
	}
	0x15ccb0bc {
		ui_string = <mult_entry>
		0x678c9e77 = <0xdcdcf63f>
		column = <i>
	}
	i = (<i> + 1)
	repeat (<num_players_shown>)
	if (<non_vocalist> > 0)
		<sections> = ((<gig_details> [(<non_vocalist> -1)] [<song_indx>]).section_names)
		getarraysize <sections>
		if (<array_size> > 0)
			change \{0x4027c7fa = 1}
			change num_non_vocal_sections = (<array_size> + 1)
			i = 0
			begin
			0x50866222 = (<i> + ($0x04ef1201))
			0x15ccb0bc {
				ui_string = (<sections> [<i>])
				0x678c9e77 = <0x50866222>
				column = 0
			}
			change song_summary_details_row_count = (($song_summary_details_row_count) + 1)
			player = 1
			begin
			getplayerinfo <player> part
			if (<part> = vocals)
			else
				section_hits = (((<gig_details> [(<player> -1)] [<song_indx>]).detailed_stats) [<i>] * 1.0)
				section_possibles = (((<gig_details> [(<player> -1)] [<song_indx>]).detailed_stats_max) [<i>] * 1.0)
				section_hits = (<section_hits> * 1.0)
				my_struct = {}
				if (<section_possibles> = 0)
					0x15ccb0bc {
						ui_string = qs(0x6a5cf46c)
						0x678c9e77 = <0x50866222>
						column = <player>
					}
				else
					adjust_percent_for_display percent = (((<section_hits> * 1.0) / <section_possibles>) * 100)
					percent = <adjusted_percent>
					formattext textname = player_percent qs(0x76b3fda7) d = <percent>
					player_percent = (<player_percent> + qs(0x0c40a1b2))
					0x15ccb0bc {
						ui_string = <player_percent>
						0x678c9e77 = <0x50866222>
						column = <player>
					}
				endif
			endif
			player = (<player> + 1)
			repeat (<num_players_shown>)
			i = (<i> + 1)
			repeat <array_size>
		endif
	endif
	if NOT (<vocalist> = 0)
		vocal_sections = ((<gig_details> [(<vocalist> -1)] [<song_indx>]).section_names)
		i = 0
		getarraysize <vocal_sections>
		if (<array_size> > 0)
			change \{0xb1808f7f = 1}
			change num_vocal_sections = (<array_size> + 1)
			begin
			removeparameter \{verse_rgba}
			if ((<vocal_sections> [<i>]) = qs(0x00000000))
				<verse_rgba> = $vocal_marker_hype_rgba
			endif
			if ((<vocal_sections> [<i>]) = qs(0x00000000))
				<short_ui_string> = qs(0xb723938a)
			else
				shortenuistring {
					ui_string = (<vocal_sections> [<i>])
					max_len = 24
				}
			endif
			add_row = 1
			if (<num_players_shown> = 2)
				getplayerinfo \{1
					part}
				p1_part = <part>
				getplayerinfo \{2
					part}
				p2_part = <part>
				if (<p1_part> = vocals && <p2_part> = vocals)
					if localizedstringequals a = (<vocal_sections> [<i>]) b = $vocal_marker_freeform
						<add_row> = 0
					endif
					if localizedstringequals a = (<vocal_sections> [<i>]) b = $vocal_marker_hype
						<add_row> = 0
					endif
				endif
			endif
			if (<add_row> = 1)
				0x50866222 = (<i> + ($0x04ef1201))
				if (($0x4027c7fa) = 1)
					<0x50866222> = (($num_non_vocal_sections) + <i> + ($0x04ef1201))
				endif
				0x15ccb0bc {
					ui_string = <short_ui_string>
					0x678c9e77 = <0x50866222>
					column = 0
				}
				change song_summary_details_row_count = (($song_summary_details_row_count) + 1)
				player_index = 1
				begin
				getplayerinfo <player_index> part
				if (<part> = vocals)
					section_hits = (((<gig_details> [(<player_index> -1)] [<song_indx>]).detailed_stats) [<i>] * 1.0)
					section_possibles = (((<gig_details> [(<player_index> -1)] [<song_indx>]).detailed_stats_max) [<i>] * 1.0)
					my_struct = {}
					if (<vocal_sections> [<i>] = qs(0x00000000))
						<section_possibles> = 0
					endif
					if (<section_possibles> = 0)
						0x15ccb0bc {
							ui_string = qs(0x6a5cf46c)
							0x678c9e77 = <0x50866222>
							column = <player_index>
						}
					else
						adjust_percent_for_display percent = (((<section_hits> * 1.0) / <section_possibles>) * 100)
						percent = <adjusted_percent>
						vocals_score_percent_to_text percent = <percent>
						0x15ccb0bc {
							ui_string = <vocals_score_text>
							0x678c9e77 = <0x50866222>
							column = <player_index>
						}
					endif
				endif
				<player_index> = (<player_index> + 1)
				repeat <num_players_shown>
			endif
			i = (<i> + 1)
			repeat <array_size>
		endif
	endif
	0x145f9f35
	0xd7a60c99 \{base = 0}
	0x261bed48 = ($song_summary_details_row_count - $0x04ef1201)
	if (($0x4027c7fa) = 1)
		0x261bed48 = (<0x261bed48> + 2)
	endif
	setscreenelementprops {
		id = my_current_menu
		tags = {current = 0 fit = 7 total = <0x261bed48>}
	}
	if should_use_all_buttons
		all_button_params = {all_buttons}
	endif
	add_user_control_helper text = qs(0xaf4d5dd2) button = red <all_button_params> z = 100000
	launchevent \{type = focus
		target = my_current_menu}
	if my_detailed_id :desc_resolvealias \{name = alias_banner
			param = 0x7363d093}
		<0x7363d093> :obj_spawnscript ui_shakey params = {0x4d641ae8}
		<0x7363d093> :obj_spawnscript ui_frazzmatazz
	else

	endif
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_song_summary_details 
	change menu_flow_locked = ($menu_flow_locked + 1)
	change \{0x7a85de77 = 0}
	clean_up_user_control_helpers
	destroyscreenelement \{id = my_detailed_id}
	0x9ae23992
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script my_color_interp \{val = 100
		player = 1}
	array = [0 0 0 255]
	min = (($min_percents) [(<player> -1)])
	if (<val> = 100)
		color = [0 128 0 255]
	elseif (<val> <= 90 && <val> = <min>)
		color = [128 0 0 255]
	else
		color = [59 62 52 255]
	endif
	return color = <color>
endscript
min_percents = [
]
max_percents = [
]

script reset_mins_and_maxes 
	change \{my_min = [
		]}
	change \{my_max = [
		]}
endscript

script song_details_set_mins_and_maxes 
	gig_details = ($gig_detailed_stats)
	local_mins = [101 101 101 101]
	local_maxs = [-1 -1 -1 -1]
	gamemode_getnumplayersshown
	i = 0
	begin
	sections = ((<gig_details> [<i>] [0]).section_names)
	section_hits_array = ((<gig_details> [<i>] [0]).detailed_stats)
	section_max_array = ((<gig_details> [<i>] [0]).detailed_stats_max)
	getarraysize <sections>
	if (<array_size> > 0)
		j = 0
		begin
		section_max = (<section_max_array> [<j>] * 1.0)
		if NOT (<section_max> <= 0)
			section_hits = (<section_hits_array> [<j>] * 1.0)
			adjust_percent_for_display percent = (((<section_hits> * 1.0) / (<section_max> * 1.0)) * 100)
			percent = <adjusted_percent>
			if (<percent> < (<local_mins> [<i>]))
				setarrayelement arrayname = local_mins index = <i> newvalue = <percent>
			endif
			if (<percent> > (<local_maxs> [<i>]))
				setarrayelement arrayname = local_maxs index = <i> newvalue = <percent>
			endif
		endif
		j = (<j> + 1)
		repeat <array_size>
	endif
	i = (<i> + 1)
	repeat <num_players_shown>
	change min_percents = <local_mins>
	change max_percents = <local_maxs>
endscript

script my_find_max_and_min 
	t_max = -1
	t_min = -1

	getarraysize \{array}
	if (<array_size> > 0)
		t_max = <array> [0]
		t_min = <array> [0]
		i = 0
		begin
		if (<array> [<i>] < min)
			t_min = <array> [0]
		endif
		if (<array> [<i>] > max)
			t_max = <array> [0]
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	return max = <t_max> min = <t_min>
endscript

script song_details_create_scrolling_menu 
	if my_detailed_id :desc_resolvealias \{name = alias_song_summary_details_list
			param = details_list_alias}
	else

	endif
	array = [
		{pad_up ui_song_details_shift params = {up}}
		{pad_down ui_song_details_shift params = {down}}
		{pad_back generic_event_back}
	]
	if (<for_transition> = 1)
		setarrayelement \{arrayname = array
			index = 2
			newvalue = {
				pad_back
				generic_event_back
				params = {
					data = {
						transitioning = 1
					}
				}
			}}
	endif
	createscreenelement {
		type = windowelement
		parent = <details_list_alias>
		id = my_current_menu
		dims = (980.0, 280.0)
		pos = (48.0, 367.0)
		just = [left top]
		pos_anchor = [left top]
		event_handlers = <array>
		tags = {current = 0 fit = 7 total = 7}
	}
	createscreenelement \{type = vmenu
		parent = my_current_menu
		id = list_menu
		dims = (980.0, 280.0)
		just = [
			left
			top
		]
		internal_just = [
			left
			top
		]
		spacing_between = 0}
	setscreenelementprops \{id = my_detailed_id
		arrow_top_alpha = 0}
endscript

script ui_song_details_shift 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	gettags
	getscreenelementdims \{id = list_menu}
	getscreenelementposition \{id = list_menu}
	if gotparam \{down}
		if (<current> >= ((<total> - <fit>) + 1))
			return
		endif
		change 0x7a85de77 = ($0x7a85de77 + 1)
		if ($0x7a85de77 < $0x04ef1201)
			change \{0x7a85de77 = $0x04ef1201}
		endif
		0xd7a60c99 base = ($0x7a85de77)
		settags current = (<current> + 1)
		generic_menu_up_or_down_sound \{down}
	else
		if (<current> <= 0)
			return
		endif
		if (($0x7a85de77) > 0)
			change 0x7a85de77 = ($0x7a85de77 - 1)
			if ($0x7a85de77 < $0x04ef1201)
				change \{0x7a85de77 = 0}
			endif
			0xd7a60c99 base = ($0x7a85de77)
			settags current = (<current> - 1)
			generic_menu_up_or_down_sound \{up}
		endif
	endif
	gettags
	max = ((<total> - <fit>) + 1)
	dx = (212.0 / <max>)
	pos = ((0.0, -100.0) + ((0.0, 1.0) * (<current> * <dx>)))
	my_detailed_id :se_setprops slider_nub_cont_pos = <pos> time = 0.1
endscript

script 0x145f9f35 
	i = 0
	begin
	formattext checksumname = 0x00d23912 'string_entry_%c' c = <i>
	createscreenelement {
		parent = list_menu
		id = <0x00d23912>
		type = descinterface
		autosizedims = true
		desc = 'song_summary_details_entry'
		verse_text = qs(0x00000000)
		percent_p1_text = qs(0x00000000)
		percent_p2_text = qs(0x00000000)
		percent_p3_text = qs(0x00000000)
		percent_p4_text = qs(0x00000000)
	}
	i = (<i> + 1)
	repeat ($0x3ef40519)
endscript

script 0xd7a60c99 \{base = 0}

	i = <base>
	j = 0
	begin
	formattext checksumname = 0x00d23912 'string_entry_%c' c = <j>
	0x258b3203 {
		0x678c9e77 = <i>
	}
	<0x00d23912> :se_setprops {
		verse_text = <0x866b7ee7>
		percent_p1_text = <0x5ad3f133>
		percent_p2_text = <0xd45cf6d0>
		percent_p3_text = <0x18f6f64e>
		percent_p4_text = <0x1233ff57>
	}
	if (<i> = 0)
		<0x00d23912> :se_setprops {
			verse_rgba = [255 , 200 , 200 , 255]
			percent_p1_rgba = [255 , 200 , 200 , 255]
			percent_p2_rgba = [255 , 200 , 200 , 255]
			percent_p3_rgba = [255 , 200 , 200 , 255]
			percent_p4_rgba = [255 , 200 , 200 , 255]
		}
	elseif ((<i> = 1) || (<i> = 2))
		<0x00d23912> :se_setprops {
			verse_rgba = [200 , 200 , 255 , 255]
			percent_p1_rgba = [200 , 200 , 255 , 255]
			percent_p2_rgba = [200 , 200 , 255 , 255]
			percent_p3_rgba = [200 , 200 , 255 , 255]
			percent_p4_rgba = [200 , 200 , 255 , 255]
		}
	else
		<0x00d23912> :se_setprops {
			verse_rgba = [255 , 255 , 255 , 255]
			percent_p1_rgba = [255 , 255 , 255 , 255]
			percent_p2_rgba = [255 , 255 , 255 , 255]
			percent_p3_rgba = [255 , 255 , 255 , 255]
			percent_p4_rgba = [255 , 255 , 255 , 255]
		}
	endif
	i = (<i> + 1)
	j = (<j> + 1)
	repeat ($0x3ef40519)
endscript

script ui_song_summary_details_anim_in 
	gamemode_gettype
	if (<type> = practice)
		return
	endif
	soundevent \{event = menu_song_complete_in}

	if screenelementexists \{id = my_detailed_id}
		setscreenelementprops \{id = my_detailed_id
			pos = {
				(1500.0, 0.0)
				relative
			}
			time = 0.120000005}
		wait \{0.2
			second}
	endif
endscript

script ui_song_summary_details_anim_out 
	gamemode_gettype
	if (<type> = practice)
		return
	endif
	soundevent \{event = menu_song_complete_out}

	if screenelementexists \{id = my_detailed_id}
		setscreenelementprops \{id = my_detailed_id
			pos = {
				(1500.0, 0.0)
				relative
			}
			time = 0.120000005}
		wait \{0.2
			second}
	endif
endscript
