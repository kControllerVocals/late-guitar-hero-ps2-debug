song_summary_details_row_count = 0
list_base = 0
viewable_entries = 7
non_vocals_exist = 0
vocals_exist = 0
num_non_vocal_sections = 0
num_vocal_sections = 0

script ui_create_song_summary_details \{for_transition = 0}
	change menu_flow_locked = ($menu_flow_locked + 1)
	CacheStringTableCreate
	change \{song_summary_details_row_count = 0}
	GameMode_GetNumPlayersShown
	GameMode_GetType
	song_details_set_mins_and_maxes
	gig_details = ($gig_detailed_stats)
	GetArraySize <gig_details>
	if (<array_size> = 0)

	endif
	get_song_title song = ((<gig_details> [0] [0]).song)
	get_all_exclusive_devices
	CreateScreenElement {
		parent = root_window
		id = my_detailed_id
		type = DescInterface
		desc = 'song_summary_details'
		pos = {(-1500.0, 0.0) relative}
		event_handlers = [
			{pad_back generic_event_back}
		]
		song_title_text = <song_title>
		exclusive_device = <exclusive_device>
	}
	if (<type> = practice)
		my_detailed_id :SE_SetProps \{pos = (0.0, 0.0)
			main_menu_bg_alpha = 1}
	endif
	if my_detailed_id :Desc_ResolveAlias \{name = alias_song_summary_details_list
			param = details_list_alias}
	else

	endif
	p = 1
	begin
	GetPlayerInfo <p> part
	GetPlayerInfo <p> difficulty
	switch (<part>)
		case guitar
		icon_texture = mixer_icon_guitar
		case Bass
		icon_texture = mixer_icon_bass
		case drum
		icon_texture = mixer_icon_drums
		case Vocals
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
	endswitch
	FormatText checksumname = alpha_check 'icons_p%d_alpha' d = <p>
	FormatText checksumname = inst_check 'instrument_p%d_texture' d = <p>
	FormatText checksumname = diff_check 'DIFFICULTY_p%d_texture' d = <p>
	FormatText checksumname = double_kick_alpha 'double_kick_p%d_alpha' d = <p>
	FormatText checksumname = difficulty_alpha 'DIFFICULTY_p%d_alpha' d = <p>
	my_struct = {}
	AddParam structure_name = my_struct name = <alpha_check> value = 1
	AddParam structure_name = my_struct name = <inst_check> value = <icon_texture>
	AddParam structure_name = my_struct name = <diff_check> value = <diff_texture>
	GetPlayerInfo <p> double_kick_drum
	if (<double_kick_drum> = 1)
		AddParam structure_name = my_struct name = <double_kick_alpha> value = 1
		AddParam structure_name = my_struct name = <difficulty_alpha> value = 0
	else
		AddParam structure_name = my_struct name = <double_kick_alpha> value = 0
		AddParam structure_name = my_struct name = <difficulty_alpha> value = 1
	endif
	<details_list_alias> :SE_SetProps <my_struct>
	p = (<p> + 1)
	repeat <num_players_shown>
	song_details_create_scrolling_menu for_transition = <for_transition>
	vocalist = 0
	non_vocalist = 0
	GetArraySize (<gig_details> [0])
	num_songs = <array_size>
	song_indx = 0
	begin
	get_song_title song = ((<gig_details> [0] [<song_indx>]).song)
	CreateScreenElement \{parent = list_menu
		type = DescInterface
		autoSizeDims = false
		dims = (1150.0, 125.0)
		desc = 'song_summary_details_header'
		just = [
			left
			top
		]}
	if Italian
		<id> :Desc_SetChildProps child = avg_multiplier dims = (380.0, 35.0)
	endif
	GetScreenElementDims id = <id>
	change song_summary_details_row_count = (($song_summary_details_row_count) + 3)
	i = 1
	begin
	GetPlayerInfo <i> part
	GetPlayerInfo <i> difficulty
	if (<part> = Vocals)
		vocalist = <i>
	elseif (<non_vocalist> = 0)
		non_vocalist = <i>
	endif
	player_data = (<gig_details> [(<i> -1)] [<song_indx>])
	if (<part> = Vocals)
		vocal_phrase_max_qual = (<player_data>.vocal_phrase_max_qual)
		vocal_phrase_quality = (<player_data>.vocal_phrase_quality)
		vocal_phrase_pct = 0
		if (<vocal_phrase_max_qual> > 0)
			percent_notes_hit = (((<vocal_phrase_quality> * 1.0) / <vocal_phrase_max_qual>) * 100.0)
			MathFloor <percent_notes_hit>
			<percent_notes_hit> = <floor>
			if (<percent_notes_hit> = 0 && <vocal_phrase_quality> > 0)
				<percent_notes_hit> = 1
			endif
			FormatText TextName = notes_hit_entry qs("\L%p\%") p = <percent_notes_hit> DecimalPlaces = 0
		else
			<notes_hit_entry> = qs("N/A")
		endif
		<sp_entry> = qs("N/A")
	else
		if (<type> = practice)
			<sp_entry> = qs("N/A")
		else
			FormatText TextName = sp_entry qs("\L%g/%p") g = (<player_data>.sp_phrases_hit) p = (<player_data>.sp_phrases_total)
		endif
		if (<type> = practice)
			FormatText TextName = notes_hit_entry qs("\L%g/%p") g = (<player_data>.notes_hit) p = (<player_data>.total_notes)
		else
			FormatText TextName = notes_hit_entry qs("\L%g/%p") g = (<player_data>.notes_hit) p = (<player_data>.max_notes)
		endif
	endif
	average_mult = (<player_data>.avg_multiplier)
	if (<average_mult> > 8)
		average_mult = 8
	elseif (<average_mult> < 1)
		average_mult = 1
	endif
	FormatText TextName = mult_entry qs("\L%px") p = <average_mult>
	FormatText TextName = score_entry qs("\L%g") g = (<player_data>.score)
	FormatText checksumname = notes_hit_cs 'notes_hit_entry_text_p%j' j = <i>
	FormatText checksumname = sp_phrases_cs 'sp_phrases_entry_text_p%j' j = <i>
	FormatText checksumname = avg_mult_cs 'avg_multiplier_entry_text_p%j' j = <i>
	FormatText checksumname = score_cs 'score_entry_text_p%j' j = <i>
	AddParam name = <score_cs> structure_name = header_struct value = <score_entry>
	AddParam name = <notes_hit_cs> structure_name = header_struct value = <notes_hit_entry>
	AddParam name = <sp_phrases_cs> structure_name = header_struct value = <sp_entry>
	if NOT (<type> = practice)
		AddParam name = <avg_mult_cs> structure_name = header_struct value = <mult_entry>
	endif
	<id> :SE_SetProps <header_struct>
	i = (<i> + 1)
	repeat (<num_players_shown>)
	i = (<num_players_shown> + 1)
	if NOT (4 = <num_players_shown>)
		begin
		FormatText checksumname = entry_alpha 'entries_p%i_alpha' i = <i>
		AddParam name = <entry_alpha> structure_name = entry_alpha_struct value = 0.0
		<id> :SE_SetProps <entry_alpha_struct>
		i = (<i> + 1)
		repeat (4 - <num_players_shown>)
	endif
	if NOT (<type> = practice)
	else
		<id> :SE_SetProps {avg_multiplier_alpha = 0}
	endif
	CacheStringTableReset
	change \{non_vocals_exist = 0}
	change \{vocals_exist = 0}
	change \{num_non_vocal_sections = 0}
	change \{num_vocal_sections = 0}
	if (<non_vocalist> > 0)
		<sections> = ((<gig_details> [(<non_vocalist> -1)] [<song_indx>]).section_names)
		GetArraySize <sections>
		if (<array_size> > 0)
			change \{non_vocals_exist = 1}
			change num_non_vocal_sections = (<array_size> + 1)
			i = 0
			begin
			CacheStringTableSetString {
				ui_string = (<sections> [<i>])
				cache_index = <i>
				column = 0
			}
			change song_summary_details_row_count = (($song_summary_details_row_count) + 1)
			player = 1
			begin
			GetPlayerInfo <player> part
			if (<part> = Vocals)
			else
				section_hits = (((<gig_details> [(<player> -1)] [<song_indx>]).detailed_stats) [<i>] * 1.0)
				section_possibles = (((<gig_details> [(<player> -1)] [<song_indx>]).detailed_stats_max) [<i>] * 1.0)
				section_hits = (<section_hits> * 1.0)
				my_struct = {}
				if (<section_possibles> = 0)
					FormatText \{TextName = player_percent
						qs("N/A")}
					FormatText checksumname = field_name 'percent_p%d_text' d = <player>
					AddParam name = <field_name> structure_name = my_struct value = <player_percent>
					<id> :SE_SetProps <my_struct>
					CacheStringTableSetString {
						ui_string = <player_percent>
						cache_index = <i>
						column = <player>
					}
				else
					adjust_percent_for_display percent = (((<section_hits> * 1.0) / <section_possibles>) * 100)
					percent = <adjusted_percent>
					my_color_interp val = <percent> player = <player>
					FormatText TextName = player_percent qs("\L%d") d = <percent>
					player_percent = (<player_percent> + qs("\L%"))
					FormatText checksumname = field_name 'percent_p%d_text' d = <player>
					FormatText checksumname = field_name_rgba 'percent_p%d_rgba' d = <player>
					AddParam name = <field_name> structure_name = my_struct value = <player_percent>
					AddParam name = <field_name_rgba> structure_name = my_struct value = <color>
					<id> :SE_SetProps <my_struct>
					CacheStringTableSetString {
						ui_string = <player_percent>
						cache_index = <i>
						column = <player>
					}
				endif
			endif
			player = (<player> + 1)
			repeat (<num_players_shown>)
			player = (<num_players_shown> + 1)
			if NOT (4 = <num_players_shown>)
				begin
				FormatText checksumname = entry_alpha 'percent_P%i_alpha' i = <player>
				AddParam name = <entry_alpha> structure_name = entry_alpha_struct value = 0.0
				<id> :SE_SetProps <entry_alpha_struct>
				player = (<player> + 1)
				repeat (4 - <num_players_shown>)
			endif
			i = (<i> + 1)
			repeat <array_size>
		endif
	endif
	if NOT (<vocalist> = 0)
		vocal_sections = ((<gig_details> [(<vocalist> -1)] [<song_indx>]).section_names)
		i = 0
		GetArraySize <vocal_sections>
		if (<array_size> > 0)
			change \{vocals_exist = 1}
			change num_vocal_sections = (<array_size> + 1)
			begin
			RemoveParameter \{verse_rgba}
			if ((<vocal_sections> [<i>]) = qs(""))
				<verse_rgba> = $vocal_marker_hype_rgba
			endif
			if ((<vocal_sections> [<i>]) = qs(""))
				<short_ui_string> = qs("\L...")
			else
				ShortenUIString {
					ui_string = (<vocal_sections> [<i>])
					max_len = 24
				}
			endif
			add_row = 1
			if (<num_players_shown> = 2)
				GetPlayerInfo \{1
					part}
				p1_part = <part>
				GetPlayerInfo \{2
					part}
				p2_part = <part>
				if (<p1_part> = Vocals && <p2_part> = Vocals)
					if LocalizedStringEquals a = (<vocal_sections> [<i>]) b = $vocal_marker_freeform
						<add_row> = 0
					endif
					if LocalizedStringEquals a = (<vocal_sections> [<i>]) b = $vocal_marker_hype
						<add_row> = 0
					endif
				endif
			endif
			if (<add_row> = 1)
				adjusted_index = <i>
				if (($non_vocals_exist) = 1)
					<adjusted_index> = (($num_non_vocal_sections) + <i>)
				endif
				CacheStringTableSetString {
					ui_string = <short_ui_string>
					cache_index = <adjusted_index>
					column = 0
				}
				change song_summary_details_row_count = (($song_summary_details_row_count) + 1)
				player_index = 1
				begin
				GetPlayerInfo <player_index> part
				if (<part> = Vocals)
					section_hits = (((<gig_details> [(<player_index> -1)] [<song_indx>]).detailed_stats) [<i>] * 1.0)
					section_possibles = (((<gig_details> [(<player_index> -1)] [<song_indx>]).detailed_stats_max) [<i>] * 1.0)
					my_struct = {}
					if (<vocal_sections> [<i>] = qs(""))
						<section_possibles> = 0
					endif
					if (<section_possibles> = 0)
						FormatText \{TextName = player_percent
							qs("N/A")}
						FormatText checksumname = field_name 'percent_p%d_text' d = <player_index>
						AddParam name = <field_name> structure_name = my_struct value = <player_percent>
						<id> :SE_SetProps <my_struct>
						CacheStringTableSetString {
							ui_string = <player_percent>
							cache_index = <adjusted_index>
							column = <player_index>
						}
					else
						adjust_percent_for_display percent = (((<section_hits> * 1.0) / <section_possibles>) * 100)
						percent = <adjusted_percent>
						my_color_interp val = <percent> player = <player_index>
						vocals_score_percent_to_text percent = <percent>
						FormatText checksumname = field_name 'percent_p%d_text' d = <player_index>
						FormatText checksumname = field_name_rgba 'percent_p%d_rgba' d = <player_index>
						AddParam name = <field_name> structure_name = my_struct value = <vocals_score_text>
						AddParam name = <field_name_rgba> structure_name = my_struct value = <color>
						<id> :SE_SetProps <my_struct>
						CacheStringTableSetString {
							ui_string = <vocals_score_text>
							cache_index = <adjusted_index>
							column = <player_index>
						}
					endif
				endif
				<player_index> = (<player_index> + 1)
				repeat <num_players_shown>
				player = (<num_players_shown> + 1)
				if NOT (4 = <num_players_shown>)
					begin
					FormatText checksumname = entry_alpha 'percent_P%i_alpha' i = <player>
					AddParam name = <entry_alpha> structure_name = entry_alpha_struct value = 0.0
					<id> :SE_SetProps <entry_alpha_struct>
					player = (<player> + 1)
					repeat (4 - <num_players_shown>)
				endif
			endif
			i = (<i> + 1)
			repeat <array_size>
		endif
	endif
	ui_create_static_screen_elements
	ui_song_details_update_list \{Base = 0}
	song_indx = (<song_indx> + 1)
	repeat <num_songs>
	SetScreenElementProps {
		id = my_current_menu
		tags = {current = 0 fit = 10 total = ($song_summary_details_row_count)}
	}
	if should_use_all_buttons
		all_button_params = {all_buttons}
	endif
	add_user_control_helper text = qs("BACK") button = red <all_button_params> z = 100000
	LaunchEvent \{type = focus
		target = my_current_menu}
	if my_detailed_id :Desc_ResolveAlias \{name = alias_banner_art_glow
			param = banner_glow_id}
		<banner_glow_id> :obj_spawnscript ui_shakey params = {as_offset}
		<banner_glow_id> :obj_spawnscript ui_frazzmatazz
	else

	endif
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_song_summary_details 
	change menu_flow_locked = ($menu_flow_locked + 1)
	change \{list_base = 0}
	clean_up_user_control_helpers
	DestroyScreenElement \{id = my_detailed_id}
	CacheStringTableDestroy
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
	GameMode_GetNumPlayersShown
	i = 0
	begin
	sections = ((<gig_details> [<i>] [0]).section_names)
	section_hits_array = ((<gig_details> [<i>] [0]).detailed_stats)
	section_max_array = ((<gig_details> [<i>] [0]).detailed_stats_max)
	GetArraySize <sections>
	if (<array_size> > 0)
		j = 0
		begin
		section_max = (<section_max_array> [<j>] * 1.0)
		if NOT (<section_max> <= 0)
			section_hits = (<section_hits_array> [<j>] * 1.0)
			adjust_percent_for_display percent = (((<section_hits> * 1.0) / (<section_max> * 1.0)) * 100)
			percent = <adjusted_percent>
			if (<percent> < (<local_mins> [<i>]))
				SetArrayElement ArrayName = local_mins index = <i> newvalue = <percent>
			endif
			if (<percent> > (<local_maxs> [<i>]))
				SetArrayElement ArrayName = local_maxs index = <i> newvalue = <percent>
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

	GetArraySize \{array}
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
	if my_detailed_id :Desc_ResolveAlias \{name = alias_song_summary_details_list
			param = details_list_alias}
	else

	endif
	array = [
		{pad_up ui_song_details_shift params = {up}}
		{pad_down ui_song_details_shift params = {down}}
		{pad_back generic_event_back}
	]
	if (<for_transition> = 1)
		SetArrayElement \{ArrayName = array
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
	CreateScreenElement {
		type = WindowElement
		parent = <details_list_alias>
		id = my_current_menu
		dims = (1200.0, 600.0)
		pos = (48.0, 367.0)
		just = [left top]
		pos_anchor = [left top]
		event_handlers = <array>
		tags = {current = 0 fit = 11 total = 9}
	}
	CreateScreenElement \{type = VMenu
		parent = my_current_menu
		id = list_menu
		dims = (100.0, 380.0)
		just = [
			left
			top
		]
		internal_just = [
			left
			top
		]
		spacing_between = 0}
	SetScreenElementProps \{id = my_detailed_id
		arrow_top_alpha = 0}
endscript

script song_details_add_space_to_table 
	CreateScreenElement \{parent = list_menu
		type = DescInterface
		autoSizeDims = true
		desc = 'song_summary_details_entry'
		verse_text = qs("")
		percent_p1_text = qs("")
		percent_p2_text = qs("")
		percent_p3_text = qs("")
		percent_p4_text = qs("")}
	change song_summary_details_row_count = (($song_summary_details_row_count) + 1)
endscript

script ui_song_details_shift 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	GetTags
	GetScreenElementDims \{id = list_menu}
	GetScreenElementPosition \{id = list_menu}
	if GotParam \{down}
		if (<current> >= ((<total> - <fit>) + 1))
			return
		endif
		change list_base = ($list_base + 1)
		ui_song_details_update_list Base = ($list_base)
		SetTags current = (<current> + 1)
		generic_menu_up_or_down_sound \{down}
	else
		if (<current> <= 0)
			return
		endif
		if (($list_base) > 0)
			change list_base = ($list_base - 1)
			ui_song_details_update_list Base = ($list_base)
			SetTags current = (<current> - 1)
			generic_menu_up_or_down_sound \{up}
		endif
	endif
	GetTags
	max = ((<total> - <fit>) + 1)
	dx = (212.0 / <max>)
	pos = ((550.0, 33.0) + ((0.0, 1.0) * (<current> * <dx>)))
	my_detailed_id :SE_SetProps setlist_popup_scroll_thumb_pos = <pos> time = 0.1
endscript

script ui_create_static_screen_elements 
	i = 0
	begin
	FormatText checksumname = string_entry 'string_entry_%c' c = <i>
	CreateScreenElement {
		parent = list_menu
		id = <string_entry>
		type = DescInterface
		autoSizeDims = true
		desc = 'song_summary_details_entry'
		verse_text = qs("")
		percent_p1_text = qs("")
		percent_p2_text = qs("")
		percent_p3_text = qs("")
		percent_p4_text = qs("")
	}
	i = (<i> + 1)
	repeat ($viewable_entries)
endscript

script ui_song_details_update_list \{Base = 0}

	i = <Base>
	j = 0
	begin
	FormatText checksumname = string_entry 'string_entry_%c' c = <j>
	CacheStringTableGetStrings {
		cache_index = <i>
	}
	<string_entry> :SE_SetProps {
		verse_text = <label_string>
		percent_p1_text = <p1_string>
		percent_p2_text = <p2_string>
		percent_p3_text = <p3_string>
		percent_p4_text = <p4_string>
	}
	i = (<i> + 1)
	j = (<j> + 1)
	repeat ($viewable_entries)
endscript

script ui_song_summary_details_anim_in 
	GameMode_GetType
	if (<type> = practice)
		return
	endif
	SoundEvent \{event = Menu_Song_Complete_In}

	if ScreenElementExists \{id = my_detailed_id}
		SetScreenElementProps \{id = my_detailed_id
			pos = {
				(1500.0, 0.0)
				relative
			}
			time = 0.120000005}
		Wait \{0.2
			second}
	endif
endscript

script ui_song_summary_details_anim_out 
	GameMode_GetType
	if (<type> = practice)
		return
	endif
	SoundEvent \{event = Menu_Song_Complete_Out}

	if ScreenElementExists \{id = my_detailed_id}
		SetScreenElementProps \{id = my_detailed_id
			pos = {
				(1500.0, 0.0)
				relative
			}
			time = 0.120000005}
		Wait \{0.2
			second}
	endif
endscript
