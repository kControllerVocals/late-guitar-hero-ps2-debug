g_head_to_head_instrument_type = none
g_head_to_head_active_controllers = [
]
back_once = 0

script ui_init_select_controller 
	push_num_players \{num = 2}
endscript

script ui_deinit_select_controller 
	pop_num_players
endscript

script ui_create_select_controller \{player = 2}
	spawnscriptnow ui_create_select_controller_spawned params = {<...>}
endscript

script ui_create_select_controller_spawned 
	change \{back_once = 0}
	clear_exclusive_devices
	change \{respond_to_signin_changed = 0}
	change \{respond_to_signin_changed_all_players = 0}
	change \{respond_to_signin_changed_func = main_menu_signin_changed}
	change \{in_controller_select_menu = 1}
	GetActiveControllers
	GetArraySize <active_controllers>
	i = 0
	begin
	ui_options_get_controller_type controller = <i>
	if (<type> = Vocals)
		SetArrayElement ArrayName = active_controllers index = <i> newvalue = 0
	endif
	i = (<i> + 1)
	repeat <array_size>
	change g_head_to_head_active_controllers = <active_controllers>
	CreateScreenElement \{type = DescInterface
		id = current_menu
		parent = root_window
		desc = 'p2_select_controller'}
	if current_menu :Desc_ResolveAlias \{name = alias_all_controllers}
		<alias_players> = <resolved_id>
		<alias_players> :SetTags {p1 = -1 p2 = -1 p1_ready = 0 p2_ready = 0}
		GetScreenElementChildren id = <alias_players>
		<players_children> = <children>

		GetArraySize <players_children>
		i = 0
		begin
		ui_select_controller_hide_or_unhide_icons i = <i> players_children = <players_children> active_controllers = <active_controllers>
		i = (<i> + 1)
		repeat <array_size>
		Wait \{1
			seconds}
		i = 0
		begin
		ui_select_controller_register_events i = <i> players_children = <players_children> active_controllers = <active_controllers>
		i = (<i> + 1)
		repeat <array_size>
	endif
	current_menu :obj_spawnscript ui_select_controller_poll_for_controllers params = {players_children = <players_children>}
	current_menu :obj_spawnscript \{ui_select_controller_ready_motion
		params = {
			name = alias_ready_banner_p1
		}}
	current_menu :obj_spawnscript \{ui_select_controller_ready_motion
		params = {
			name = alias_ready_banner_p2
		}}
	current_menu :Obj_SpawnScriptNow \{head2head_skull_anim}
	ui_return_game_mode
	change \{back_once = 1}
endscript

script get_controller_texture 
	switch <type>
		case guitar

		<texture> = guitar_controller
		case Drums

		<texture> = drum_controller
		case Vocals

		<texture> = vocal_controller
		case vocals_no_mic

		<texture> = vocal_controller
	endswitch
	return texture = <texture>
endscript

script ui_select_controller_anim_in 
	menu_transition_in \{menu = current_menu}
endscript

script ui_select_controller_anim_out 
	menu_transition_out \{menu = current_menu}
endscript

script ui_destroy_select_controller 
	if ScreenElementExists \{id = current_menu}
		DestroyScreenElement \{id = current_menu}
	endif
	change \{in_controller_select_menu = 0}
	if ScreenElementExists \{id = dialog_box_container}
		destroy_dialog_box
	endif
	KillSpawnedScript \{name = head2head_skull_anim}
endscript

script ui_select_controller_hide_or_unhide_icons 
	GetArraySize <players_children>
	if NOT (<i> < <array_size>)

		return
	endif
	<child_id> = (<players_children> [<i>])
	if ((<active_controllers> [<i>]) = 0)
		<child_id> :SE_GetParentId
		<parent_id> :GetTags
		<child_id> :GetTags
		<child_id> :SE_SetProps hide pos = <old_pos>
		<child_id> :SetTags hidden = 1
		get_controller_ready_se_objs
		if (<p1> = <i>)
			<parent_id> :SetTags p1 = -1
			<parent_id> :SetTags p1_ready = 0
			SetScreenElementProps id = {<p1_se> child = ready} alpha = 0.0 time = 0.1
		elseif (<p2> = <i>)
			<parent_id> :SetTags p2 = -1
			<parent_id> :SetTags p2_ready = 0
			SetScreenElementProps id = {<p2_se> child = ready} alpha = 0.0 time = 0.1
		endif

	else

		ui_options_get_controller_type controller = <i>
		if (<type> = Vocals)
			get_num_mics_plugged_in
			if (<num_mics_plugged_in> < 2)
				<type> = vocals_no_mic
			endif
		elseif (<type> = Drums)
			<child_id> :SE_SetProps {
				pos = (60.0, -177.0)
			}
		elseif (<type> = guitar)
			<child_id> :SE_SetProps {
				pos = (-75.0, -177.0)
			}
		endif
		get_controller_texture type = <type>
		<child_id> :SE_SetProps {
			texture = <texture>
			unhide
		}
		<child_id> :SetTags hidden = 0
		LaunchEvent type = focus target = <child_id>
	endif
endscript

script ui_select_controller_register_events 
	<child_id> = (<players_children> [<i>])
	if ((<active_controllers> [<i>]) = 0)
		<child_id> :SE_GetParentId
		<parent_id> :GetTags
		<child_id> :GetTags
		if NOT IsGuitarController controller = <i>
			if NOT IsDrumController controller = <i>
				<child_id> :SE_SetProps {
					exclusive_device = <i>
					event_handlers = [
						{pad_back ui_select_controller_back}
					]
					replace_handlers
				}
				LaunchEvent type = focus target = <child_id>
			endif
		endif
	else
		<child_id> :SE_GetProps
		<child_id> :SE_SetProps {
			event_handlers = [] replace_handlers
		}
		<child_id> :SE_SetProps {
			exclusive_device = <i>
			event_handlers = [
				{pad_left ui_select_controller_move params = {left}}
				{pad_up ui_select_controller_move params = {left}}
				{pad_right ui_select_controller_move params = {right}}
				{pad_down ui_select_controller_move params = {right}}
				{pad_choose ui_select_controller_choose}
				{pad_back ui_select_controller_back}
			]
			replace_handlers
			tags = {old_pos = <pos>}
		}
	endif
endscript

script skull_blur 
	begin
	a = Random (@ 0.0 @ 0.5 @ 1 )
	ui_fx_set_blur amount = <a> time = 0.09
	Wait \{0.1
		seconds}
	ui_fx_set_blur \{amount = 0}
	SE_WaitProps
	<time> = Random (@ 3 @ 1.5 @ 4 )
	Wait <time> seconds
	repeat
endscript

script head2head_skull_anim 
endscript

script ui_select_controller_poll_for_controllers 
	begin
	GetActiveControllers
	GetArraySize <active_controllers>
	<i> = 0
	begin
	ui_options_get_controller_type controller = <i>
	if NOT (($g_head_to_head_active_controllers [<i>]) = (<active_controllers> [<i>]) || (<type> = Vocals))
		ui_select_controller_hide_or_unhide_icons i = <i> players_children = <players_children> active_controllers = <active_controllers>
		ui_select_controller_register_events i = <i> players_children = <players_children> active_controllers = <active_controllers>
		SetArrayElement ArrayName = g_head_to_head_active_controllers GlobalArray index = <i> newvalue = (<active_controllers> [<i>])
	elseif IsPs3
		<child_id> = (<players_children> [<i>])
		<child_id> :SE_GetProps
		<my_texture> = <texture>
		<child_id> :GetTags
		if (<hidden> = 0)
			ui_options_get_controller_type controller = <i>
			if (<type> = Vocals)
				get_num_mics_plugged_in
				if (<num_mics_plugged_in> < 2)
					<type> = vocals_no_mic
				endif
			endif
			get_controller_texture type = <type>
			<new_texture> = <texture>
			if NOT (<my_texture> = <new_texture>)
				<child_id> :SE_SetProps {
					texture = <new_texture>
					unhide
				}
				<child_id> :SetTags hidden = 0
			endif
		endif
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	Wait \{1
		gameframe}
	repeat
endscript

script ui_select_controller_move 
	SE_GetParentId
	Obj_GetID
	<parent_id> :GetTags
	GetTags
	<play_sound> = 1
	if GotParam \{left}
		<dir> = {up}
		if (<p2> = <device_num>)
			if (<p2_ready> = 1)
				return
			endif
			<parent_id> :SetTags p2 = -1
			SE_SetProps pos = <old_pos> time = 0.1
		elseif (<p1> = -1)
			<parent_id> :SetTags p1 = <device_num>
			SE_SetProps \{pos = (-400.0, 150.0)
				time = 0.1}
		else
			<play_sound> = 0
		endif
	else
		<dir> = {down}
		if (<p1> = <device_num>)
			if (<p1_ready> = 1)
				return
			endif
			<parent_id> :SetTags p1 = -1
			SE_SetProps pos = <old_pos> time = 0.1
		elseif (<p2> = -1)
			<parent_id> :SetTags p2 = <device_num>
			SE_SetProps \{pos = (350.0, -100.0)
				time = 0.1}
		else
			<play_sound> = 0
		endif
	endif
	if (<play_sound>)
		generic_menu_up_or_down_sound <dir>
	endif
endscript

script get_controller_ready_se_objs 
	current_menu :Desc_ResolveAlias \{name = alias_players}
	<alias_players> = <resolved_id>
	GetScreenElementChildren id = <alias_players>
	return p1_se = (<children> [0]) p2_se = (<children> [1])
endscript

script ui_select_controller_choose 
	get_controller_ready_se_objs
	SE_GetParentId
	Obj_GetID
	<parent_id> :GetTags
	if (<p1> = <device_num>)
		<parent_id> :SetTags p1_ready = 1
		SetScreenElementProps id = {<p1_se> child = ready} alpha = 1.0 time = 0.1
		if NOT (<p1_ready> = 1)
			SoundEvent \{event = CheckBox_Check_2_SFX}
		endif
	elseif (<p2> = <device_num>)
		<parent_id> :SetTags p2_ready = 1
		SetScreenElementProps id = {<p2_se> child = ready} alpha = 1.0 time = 0.1
		if NOT (<p2_ready> = 1)
			SoundEvent \{event = CheckBox_Check_2_SFX}
		endif
	endif
	<parent_id> :GetTags
	if ((<p1_ready> = 1) && (<p2_ready> = 1))
		if ((<p1> < 0) || (<p1> >= 8))
			return
		endif
		if ((<p2> < 0) || (<p2> >= 8))
			return
		endif
		ui_options_get_controller_type controller = <p1>
		p1_type = <type>
		ui_options_get_controller_type controller = <p2>
		p2_type = <type>
		if ($allow_controller_for_all_instruments = 0)
			if NOT (<p1_type> = <p2_type>)
				LaunchEvent \{type = unfocus
					target = current_menu}
				create_dialog_box \{heading_title = qs("MISMATCH")
					body_text = qs("You can only go Head to Head with the same instrument type!")
					options = [
						{
							func = ui_select_controller_warning_go_back
							text = qs("GO BACK")
						}
					]}
				SoundEvent \{event = Menu_Warning_SFX}
				ui_select_controller_back <...>
				return
			endif
			if ChecksumEquals a = <p1_type> b = Vocals
				get_num_mics_plugged_in
				if (<num_mics_plugged_in> < 2)
					LaunchEvent \{type = unfocus
						target = current_menu}
					if isXenon
						<text> = qs("You need to have two microphones or Xbox 360 Headsets to go Head to Head on vocals!")
					else
						<text> = qs("You need to have two microphones plugged in to go Head to Head on vocals!")
					endif
					create_dialog_box {
						body_text = <text>
						options = [
							{
								func = ui_select_controller_warning_go_back
								text = qs("GO BACK")
							}
						]
					}
					SoundEvent \{event = Menu_Warning_SFX}
					ui_select_controller_back <...>
					return
				endif
			endif
		endif
		change g_head_to_head_instrument_type = <p1_type>
		LaunchEvent \{type = unfocus
			target = current_menu}
		if (<p1> != ($player1_status.controller))
			swap_player_status_elements \{player_A = 1
				player_B = 2
				lefty_flip}
		endif
		change structurename = player1_status controller = <p1>
		change structurename = player2_status controller = <p2>
		change player1_device = <p1>
		change player2_device = <p2>
		add_exclusive_device device = <p1>
		add_exclusive_device device = <p2>

		if ChecksumEquals a = <p1_type> b = Vocals
			change \{structurename = player1_status
				part = Vocals}
			change \{structurename = player2_status
				part = Vocals}
			vocals_distribute_mics
		endif
		Wait \{0.25
			seconds}
		change \{current_num_players = 2}
		change \{band_mode_menu_tags = none}
		mp_select_mode_menu_select_mode \{mode = p2_pro_faceoff
			friendly}
	endif
endscript

script ui_select_controller_warning_go_back 
	destroy_dialog_box
	ui_destroy_select_controller
	ui_create_select_controller
endscript

script ui_select_controller_back 
	get_controller_ready_se_objs
	SE_GetParentId
	Obj_GetID
	<parent_id> :GetTags
	if ((<p1_ready> = 0) && (<p2_ready> = 0))
		if ($back_once = 1)
			change \{back_once = 0}
			generic_event_back
		endif
	endif
	if (<p1> = <device_num>)
		<parent_id> :SetTags p1_ready = 0
		SetScreenElementProps id = {<p1_se> child = ready} alpha = 0.0 time = 0.1
		generic_menu_pad_back_sound
	elseif (<p2> = <device_num>)
		<parent_id> :SetTags p2_ready = 0
		SetScreenElementProps id = {<p2_se> child = ready} alpha = 0.0 time = 0.1
		generic_menu_pad_back_sound
	endif
endscript

script swap_player_status_elements \{player_A = 1
		player_B = 2}
	player_status_A = ($player_status_array [<player_A>])
	player_status_B = ($player_status_array [<player_B>])
	if GotParam \{lefty_flip}
		<temp_value> = ($<player_status_A>.lefty_flip)
		change structurename = <player_status_A> lefty_flip = ($<player_status_B>.lefty_flip)
		change structurename = <player_status_B> lefty_flip = <temp_value>
		<temp_value> = ($<player_status_A>.lefthanded_gems)
		change structurename = <player_status_A> lefthanded_gems = ($<player_status_B>.lefthanded_gems)
		change structurename = <player_status_B> lefthanded_gems = <temp_value>
		<temp_value> = ($<player_status_A>.lefthanded_gems_flip_save)
		change structurename = <player_status_A> lefthanded_gems_flip_save = ($<player_status_B>.lefthanded_gems_flip_save)
		change structurename = <player_status_B> lefthanded_gems_flip_save = <temp_value>
		<temp_value> = ($<player_status_A>.lefthanded_button_ups)
		change structurename = <player_status_A> lefthanded_button_ups = ($<player_status_B>.lefthanded_button_ups)
		change structurename = <player_status_B> lefthanded_button_ups = <temp_value>
		<temp_value> = ($<player_status_A>.lefthanded_button_ups_flip_save)
		change structurename = <player_status_A> lefthanded_button_ups_flip_save = ($<player_status_B>.lefthanded_button_ups_flip_save)
		change structurename = <player_status_B> lefthanded_button_ups_flip_save = <temp_value>
	endif
endscript

script ui_select_controller_ready_motion 
	if Desc_ResolveAlias name = <name>
		if GetScreenElementChildren id = <resolved_id>
			GetArraySize <children>
			prev = 0
			curr = 1
			begin
			prev_id = (<children> [<prev>])
			curr_id = (<children> [<curr>])
			<prev_id> :SE_SetProps alpha = 0.0
			<curr_id> :SE_SetProps alpha = 1
			prev = <curr>
			next = RandomInteger (0.0, 2.0)
			if (<next> = <prev>)
				curr = (<curr> + 1)
			else
				curr = <next>
			endif
			if (<curr> >= <array_size>)
				curr = 0
			endif
			Wait \{0.075
				second}
			repeat
		endif
	endif
endscript
