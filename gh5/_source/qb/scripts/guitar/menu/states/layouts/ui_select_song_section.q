g_sss_highlighted_index = 0
default_section_rgba = [
	64
	64
	64
	255
]
default_section_focus_rgba = GH5_blue_xdk

script ui_init_select_song_section 
	push_num_players \{num = 1}
	change menu_flow_locked = ($menu_flow_locked + 1)
	disable_pause
	UnPauseGame
	if NOT ($game_mode = practice)
		if GotParam \{from_in_game}
			change \{practice_enabled = 1}
			change came_to_practice_from = ($game_mode)
			if NOT ($current_progression_flag = none)
				change came_to_practice_from_progression = ($current_progression_flag)
			endif
			GetPlayerInfo \{1
				character_id}
			if NOT (<character_id> = EmptyGuy)
				change came_to_practice_character_id = <character_id>
				SetPlayerInfo \{1
					character_id = EmptyGuy}
			endif
			change \{game_mode = practice}
			destroy_loading_screen
			startrendering
		else
			change \{came_to_practice_from = main_menu}
		endif
	endif
	change \{current_num_players = 1}
	GameMode_UpdateNumPlayers \{num_players = 1}
	destroy_loading_screen
	Menu_Music_Off
endscript

script ui_create_select_song_section 
	change \{current_speedfactor = 1.0}
	if ScriptIsRunning \{destroy_practice_songpreview_spawned}
		KillSpawnedScript \{name = destroy_practice_songpreview_spawned}
	endif
	ps2_force_unload_car_part_script
	load_songqpak song_name = ($current_song) async = 0
	CreateScreenElement \{parent = root_window
		type = DescInterface
		id = SongSectionDesc
		desc = 'setlist_b_practice_sessions_desc'}
	focus2_script = ui_select_song_section_preview
	spawnsongpreview = 0
	if SongSectionDesc :Desc_ResolveAlias \{name = alias_menu}
		AssignAlias id = <resolved_id> alias = current_menu
		current_menu :SE_SetProps {
			allow_wrap = false
			exclusive_device = ($primary_controller)
			event_handlers = [
				{pad_up ui_select_song_section_play_sound params = {up}}
				{pad_down ui_select_song_section_play_sound params = {down}}
				{pad_back ui_select_song_section_back}
			]
			tags = {
				start_index = -1
				end_index = -1
			}
		}
		CreateScreenElement {
			parent = current_menu
			type = DescInterface
			desc = 'setlist_b_practice_sessions_item_desc'
			autoSizeDims = false
			dims = (760.0, 42.0)
			section_text = qs("Entire Song")
			section_rgba = $default_section_rgba
			event_handlers = [
				{focus ui_select_song_section_focus_item}
				{focus <focus2_script>}
				{unfocus ui_select_song_section_unfocus_item}
				{pad_choose ui_select_song_section_choose_item}
			]
			tags = {playfullsong index = 0 strikeout_alpha = 0 default_rgba = $default_section_rgba}
		}
		if (<spawnsongpreview> = 1)
			<id> :obj_spawnscript ui_select_song_section_preview
		endif
		get_song_section_array
		GetArraySize <song_section_array>
		marker_array_size = <array_size>
		GetPlayerInfo \{1
			part}
		if (<marker_array_size> > 0)
			i = 1
			actual_index = 1
			begin
			ShortenUIString {
				ui_string = ((<song_section_array> [(<i> - 1)]).marker)
				max_len = 50
			}
			if (<short_ui_string> != qs("\L"))
				GetRandomValue \{a = 1
					b = 2
					name = rand_int
					Integer}
				FormatText checksumname = strikeout_texture 'strike_0%d' d = <rand_int>
				strikeout_alpha = 0
				<section_rgba> = $default_section_rgba
				CreateScreenElement {
					parent = current_menu
					type = DescInterface
					desc = 'setlist_b_practice_sessions_item_desc'
					autoSizeDims = false
					dims = (760.0, 42.0)
					section_text = <short_ui_string>
					section_rgba = <section_rgba>
					event_handlers = [
						{focus ui_select_song_section_focus_item}
						{focus <focus2_script>}
						{unfocus ui_select_song_section_unfocus_item}
						{pad_choose ui_select_song_section_choose_item}
					]
					strikeout_texture = <strikeout_texture>
					strikeout_alpha = <strikeout_alpha>
					tags = {
						index = <actual_index>
						strikeout_texture = <strikeout_texture>
						strikeout_alpha = <strikeout_alpha>
						default_rgba = <section_rgba>
					}
				}
				actual_index = (<actual_index> + 1)
			endif
			i = (<i> + 1)
			repeat <marker_array_size>
		endif
	endif
	if GotParam \{selected_index}
		GetScreenElementChildren \{id = current_menu}
		GetArraySize <children>
		ratio = (<selected_index> / (<marker_array_size> - 1.0))
		scroll_pos = ((358.0, -174.0) + ((0.0, 184.0) * <ratio>))
		SongSectionDesc :SE_SetProps scroll_thumb_pos = <scroll_pos> time = <time>
	endif
	ui_select_song_section_preview \{index = 0
		nowait}
	menu_finish
	current_menu :SetTags \{lead_in = 0}
	current_menu :SetTags \{lead_out = 0}
	spawnscriptnow \{force_short_wait}
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script force_short_wait 
	change menu_flow_locked = ($menu_flow_locked + 1)
	Wait \{20
		gameframes}
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_select_song_section_play_sound 
	get_song_section_array
	GetArraySize <song_section_array>
	if GotParam \{up}
		change g_sss_highlighted_index = ($g_sss_highlighted_index - 1)
		if ($g_sss_highlighted_index < 0)
			change \{g_sss_highlighted_index = 0}
		else
			generic_menu_up_or_down_sound \{up}
		endif
	else
		change g_sss_highlighted_index = ($g_sss_highlighted_index + 1)
		if ($g_sss_highlighted_index > <array_size>)
			change g_sss_highlighted_index = ($g_sss_highlighted_index - 1)
		else
			generic_menu_up_or_down_sound \{down}
		endif
	endif
endscript

script ui_destroy_select_song_section 
	change menu_flow_locked = ($menu_flow_locked + 1)
	change \{should_play_practice_songpreview = 0}
	DestroyScreenElement \{id = SongSectionDesc}
	SetSoundBussParams {LeadVox_Balance = {vol = ($Default_BussSet.LeadVox_Balance.vol)}}
	SetSoundBussParams {Drums_Balance = {vol = ($Default_BussSet.Drums_Balance.vol)}}
	SetSoundBussParams {leadGTR_balance = {vol = ($Default_BussSet.leadGTR_balance.vol)}}
	SetSoundBussParams {bass_balance = {vol = ($Default_BussSet.bass_balance.vol)}}
	SetSoundBussParams {RhythmGTR_Balance = {vol = ($Default_BussSet.RhythmGTR_Balance.vol)}}
	SetSoundBussParams {Crowd_Balance = {vol = ($Default_BussSet.Crowd_Balance.vol)}}
	SetSoundBussParams {CrowdSingalong_Balance = {vol = ($Default_BussSet.CrowdSingalong_Balance.vol)}}
	SetSoundBussParams {Band_Balance = {vol = ($Default_BussSet.Band_Balance.vol)}}
	clean_up_user_control_helpers
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_deinit_select_song_section 
	pop_num_players
	change menu_flow_locked = ($menu_flow_locked + 1)
	spawnscriptnow \{end_practice_song}
	unload_songqpak
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_select_song_section_focus_item \{time = 0.1}
	current_menu :GetTags
	GetTags
	my_strikeout_texture = <strikeout_texture>
	my_strikeout_alpha = <strikeout_alpha>
	highlight_alpha = 1.0
	strikeout_alpha = 0
	GetScreenElementChildren \{id = current_menu}
	GetArraySize <children>
	children_array_size = <array_size>
	if NOT (<start_index> = -1)
		i = <start_index>
		begin
		if ResolveScreenElementId id = {current_menu child = <i>}
			<resolved_id> :GetSingleTag strikeout_texture
			<resolved_id> :GetSingleTag strikeout_alpha
			<resolved_id> :GetSingleTag default_rgba
			if ((<i> >= <start_index>) && (<i> <= <index>))

				if (<i> = <start_index>)
					<resolved_id> :SE_SetProps {
						section_rgba = $default_section_focus_rgba
						highlight_rgba = [255 , 255 , 255 , 220]
						highlight_alpha = <highlight_alpha>
						strikeout_texture = <strikeout_texture>
						strikeout_alpha = <strikeout_alpha>
					}
				elseif NOT (<i> = <index>)

					<resolved_id> :SE_SetProps {
						section_rgba = $default_section_focus_rgba
						highlight_rgba = [255 255 255 160]
						highlight_alpha = <highlight_alpha>
						strikeout_texture = <strikeout_texture>
						strikeout_alpha = <strikeout_alpha>
					}
				endif
			else
				<resolved_id> :SE_SetProps {
					section_rgba = <default_rgba>
					highlight_rgba = [255 255 255 220]
					highlight_alpha = 0.0
					strikeout_texture = <strikeout_texture>
					strikeout_alpha = <strikeout_alpha>
				}
			endif
		endif
		i = (<i> + 1)
		repeat <children_array_size>
	endif
	if (<children_array_size> > 1.0)
		ratio = (<index> / (<children_array_size> - 1.0))
	else
		ratio = 0
	endif
	scroll_pos = ((358.0, -174.0) + ((0.0, 184.0) * <ratio>))
	SongSectionDesc :SE_SetProps scroll_thumb_pos = <scroll_pos> time = <time>
	SE_SetProps {
		section_rgba = $default_section_focus_rgba
		highlight_rgba = [255 , 255 , 255 , 220]
		highlight_alpha = <highlight_alpha>
		strikeout_texture = <my_strikeout_texture>
		strikeout_alpha = <my_strikeout_alpha>
		time = 0.1
	}
endscript

script ui_select_song_section_unfocus_item 
	GetSingleTag \{default_rgba}
	SE_SetProps section_rgba = <default_rgba> highlight_alpha = 0.0 time = 0.1
endscript

script ui_select_song_section_choose_item 
	if ($transitions_locked = 1 || $menu_flow_locked > 0)
		return
	endif
	current_menu :GetTags
	GetTags
	if GotParam \{playfullsong}
		current_menu :SetTags \{start_index = 0}
		current_menu :SetTags \{lead_in = 0}
		current_menu :SetTags \{lead_out = 0}
		params = {playfullsong}
		current_menu :obj_spawnscript ui_select_song_section_set_times params = {<params>}
		return
	endif
	if (<start_index> = -1)
		generic_menu_up_or_down_sound
		current_menu :SetTags start_index = <index>
	else
		current_menu :SetTags start_index = (<start_index> - 1)
		current_menu :SetTags end_index = <index>
		current_menu :obj_spawnscript \{ui_select_song_section_set_times}
	endif
	SongSectionDesc :SE_SetProps \{message_text = qs("SELECT END SECTION")}
	GetScreenElementChildren \{id = current_menu}
	GetArraySize <children>
	i = 0
	begin
	if (<i> >= <index>)
		break
	endif
	curr_item = (<children> [<i>])
	<curr_item> :SE_SetProps not_focusable
	i = (<i> + 1)
	repeat <array_size>
endscript

script ui_select_song_section_back 
	current_menu :GetTags
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	begin
	if ($practice_songpreview_changing = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	SongUnLoad
	begin
	GetContentFolderState
	if (<contentfolderstate> = free)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	if (<start_index> = -1)
		if ($came_to_practice_from != main_menu)
			generic_menu_pad_back_sound
			if ($came_to_practice_from = p1_quickplay)
				return_to_quickplay_from_practice
			else
				ui_win_song_continue_next_menu \{for_practice = 1}
			endif
		else
			if ui_event_exists_in_stack \{name = 'practice_select_difficulty'}
				create_loading_screen
				Wait \{3
					gameframes}
			endif
			generic_event_back
		endif
	else
		generic_menu_up_or_down_sound
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
	if NOT ($came_to_practice_character_id = EmptyGuy)
		SetPlayerInfo 1 character_id = ($came_to_practice_character_id)
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
	SE_SetProps \{block_events}
	GetTags
	get_song_section_array
	GetArraySize <song_section_array>
	if (<array_size> > 0)
		change practice_start_time = ((<song_section_array> [<start_index>]).time)
		change practice_start_index = <start_index>
		if ((GotParam playfullsong) || (<end_index> >= <array_size>))
			setup_gemarrays song_name = ($current_song) difficulty = ($player1_status.difficulty) player_status = player1_status
			get_song_end_time song = ($current_song) for_practice = 1
			change practice_end_time = <total_end_time>
			change practice_end_index = <array_size>
		else
			change practice_end_time = ((<song_section_array> [<end_index>]).time - 1)
			change practice_end_index = <end_index>
		endif
		if GotParam \{playfullsong}
			ResetNonGrayMarkers
		else
			ResetNonGrayMarkers
		endif
		change practice_start_time = ($practice_start_time - <lead_in>)
		change practice_end_time = ($practice_end_time + <lead_out>)
	else
		change \{practice_start_time = 0}
		change \{practice_end_time = 0}
		change \{practice_start_index = 0}
		change \{practice_end_index = 0}
	endif
	GetPlayerInfo \{1
		part}
	if (<part> = Vocals)
		<state> = uistate_play_song
	endif
	generic_event_choose state = <state>
endscript

script ui_select_song_section_preview \{extras = 0}
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	if NOT ($force_practice_songpreview_silent = 1)
		change \{force_practice_songpreview_restart = 1}
		change \{force_practice_songpreview_silent = 1}
	endif
	if NOT GotParam \{nowait}
		Wait \{0.5
			seconds}
	endif
	if IsObjectScript
		GetTags
	endif
	get_song_end_time song = ($current_song) for_practice = 1
	change target_practice_songpreview = ($current_song)
	change \{target_practice_songpreview_starttime = 0}
	change target_practice_songpreview_endtime = <total_end_time>
	change \{force_practice_songpreview_silent = 0}
	get_song_section_array
	GetArraySize <song_section_array>
	if (<array_size> > 0)
		if (<index> > 0)
			<index> = (<index> - 1)
			end_index = (<index> + 1)
			if (<end_index> >= <array_size>)
				RemoveParameter \{end_index}
			endif
		endif
		start_time = ((<song_section_array> [<index>]).time)
		if NOT GotParam \{end_index}
			setup_gemarrays song_name = ($current_song) difficulty = ($player1_status.difficulty) player_status = player1_status
			end_time = <total_end_time>
		else
			end_time = ((<song_section_array> [<end_index>]).time + 750)
		endif
		if (<extras> = 1)
			end_time = <total_end_time>
		endif
		change target_practice_songpreview = ($current_song)
		change target_practice_songpreview_starttime = <start_time>
		change target_practice_songpreview_endtime = <end_time>
	endif
	if NOT IsObjectScript
		change \{force_practice_songpreview_restart = 1}
		SpawnScript practice_songpreview_monitor params = {extras = <extras>}
	endif
endscript
practice_start_index = 0
practice_end_index = 0
target_practice_songpreview = none
target_practice_songpreview_starttime = 0
target_practice_songpreview_endtime = 0
force_practice_songpreview_restart = 0
practice_songpreview_changing = 0
current_practice_songpreview = none
current_practice_songpreview_starttime = 0
current_practice_songpreview_endtime = 0
force_practice_songpreview_silent = 0
in_destroy_choose_practice_section_menu = 0
should_play_practice_songpreview = 1

script practice_songpreview_monitor 
	SetScriptCannotPause
	change \{should_play_practice_songpreview = 1}
	SetSoundBussParams {LeadVox_Balance = {vol = (($Default_BussSet.LeadVox_Balance.vol) - 9)} time = 1}
	SetSoundBussParams {Drums_Balance = {vol = (($Default_BussSet.Drums_Balance.vol) - 9)} time = 1}
	SetSoundBussParams {leadGTR_balance = {vol = (($Default_BussSet.leadGTR_balance.vol) - 9)} time = 1}
	SetSoundBussParams {bass_balance = {vol = (($Default_BussSet.bass_balance.vol) - 9)} time = 1}
	SetSoundBussParams {RhythmGTR_Balance = {vol = (($Default_BussSet.RhythmGTR_Balance.vol) - 9)} time = 1}
	SetSoundBussParams {Crowd_Balance = {vol = (($Default_BussSet.Crowd_Balance.vol) - 100)} time = 1}
	SetSoundBussParams {CrowdSingalong_Balance = {vol = (($Default_BussSet.CrowdSingalong_Balance.vol) - 100)} time = 1}
	SetSoundBussParams {Band_Balance = {vol = (($Default_BussSet.Band_Balance.vol) - 9)} time = 1}
	playing_song = 0
	begin
	skip_wait = 0
	if NOT ($current_practice_songpreview = $target_practice_songpreview &&
			$current_practice_songpreview_starttime = $target_practice_songpreview_starttime &&
			$force_practice_songpreview_restart = 0)
		song = ($target_practice_songpreview)
		StartTime = ($target_practice_songpreview_starttime)
		endtime = ($target_practice_songpreview_endtime)
		KillSpawnedScript \{name = practice_songpreview_fadeinandrepeat}
		GetIMFAdjustedTime time = <StartTime> round_up = false
		<StartTime> = <adjustedtime>
		change target_practice_songpreview_starttime = <adjustedtime>
		change \{practice_songpreview_changing = 1}
		end_song
		playing_song = 0
		if ($shutdown_game_for_signin_change_flag = 0 &&
				$force_practice_songpreview_silent = 0 &&
				$should_play_practice_songpreview = 1)
			SongUnLoad
			preload_song song_name = <song> StartTime = <StartTime>
			change current_practice_songpreview = <song>
			change \{force_practice_songpreview_restart = 0}
			change current_practice_songpreview_starttime = <StartTime>
			change current_practice_songpreview_endtime = <endtime>
			change \{practice_songpreview_changing = 0}
			if ($current_practice_songpreview = $target_practice_songpreview &&
					$current_practice_songpreview_starttime = $target_practice_songpreview_starttime &&
					$force_practice_songpreview_restart = 0 &&
					$should_play_practice_songpreview = 1)
				begin_song
				playing_song = 1
				spawnscriptnow \{practice_songpreview_fadeinandrepeat}
			else
				skip_wait = 1
			endif
		endif
	endif
	if ($should_play_practice_songpreview = 0)
		break
	endif
	if (<skip_wait> = 0)
		WaitOneGameFrame
	endif
	repeat
	KillSpawnedScript \{name = practice_songpreview_fadeinandrepeat}
	if (<playing_song> = 1)
		end_song
	endif
	SongUnLoad
endscript

script practice_songpreview_fadeinandrepeat 
	current_time = $target_practice_songpreview_starttime
	end_time = $target_practice_songpreview_endtime
	begin
	Wait \{0.1
		seconds}
	current_time = (<current_time> + 100)
	if (<current_time> >= <end_time>)
		break
	endif
	repeat
	change \{force_practice_songpreview_restart = 1}
endscript

script destroy_practice_songpreview_spawned 
	SetScriptCannotPause
	unpausespawnedscript \{practice_songpreview_monitor}
	change \{force_practice_songpreview_silent = 0}
	begin
	if ($practice_songpreview_changing = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	KillSpawnedScript \{name = practice_songpreview_monitor}
	KillSpawnedScript \{name = practice_songpreview_fadeinandrepeat}
	if NOT ($current_practice_songpreview = none)
		end_song
	endif
endscript
