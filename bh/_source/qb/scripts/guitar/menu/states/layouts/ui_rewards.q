
script ui_create_rewards 
	progression_get_new_unlocks
	GetArraySize \{new_unlocks}
	new_unlocks_size = <array_size>

	if (<new_unlocks_size> > 10)
		<new_unlocks_size> = 10
	endif
	names_array = []
	textures_array = []
	items_array = []
	group_name_array = []
	checksum_array = []
	FormatText \{checksumname = default_cs
		''}
	cntr = 0
	if (<array_size> > 0)
		begin
		this_item = (<new_unlocks> [<cntr>])
		name = qs("unknown")
		texture = unknown
		if ((<this_item>.type) = car_piece)
			part = ((<this_item>.item).part)
			desc_id = ((<this_item>.item).desc_id)
			ps2_load_car_part_script
			if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>

			endif
			ps2_unload_car_part_script
			name = <frontend_desc>
			if GotParam \{polaroid}
				texture = <polaroid>
			else
				texture = rewards_image_placeholder
			endif


		elseif ((<this_item>.type) = car_pieces)
			list_of_pieces = (<this_item>.char_pieces)
			GetArraySize \{list_of_pieces}
			if (<array_size> > 0)
				my_item = (<list_of_pieces> [0])
				part = (<my_item>.part)
				desc_id = (<my_item>.desc_id)
				ps2_load_car_part_script
				if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>

				endif
				ps2_unload_car_part_script
				if StructureContains \{Structure = this_item
						group_name}
					name = (<this_item>.group_name)
				else
					name = <frontend_desc>
				endif
				if StructureContains \{Structure = this_item
						unlock_icon}
					texture = (<this_item>.unlock_icon)
				else
					texture = rewards_image_placeholder
				endif
			endif
		elseif ((<this_item>.type) = character)

			get_musician_profile_struct_by_id id = (<this_item>.item) savegame = 0
			name = (<profile_struct>.fullname)
			texture = (<this_item>.unlock_icon)
			RemoveParameter \{profile_struct}
		elseif ((<this_item>.type) = level)

			name = ($LevelZones.(<this_item>.item).title)
			FormatText checksumname = venue_image 'Venue_Reward_%t' t = ($LevelZones.(<this_item>.item).name)
			texture = <venue_image>
		endif
		group_name = qs("\L")
		if StructureContains \{Structure = this_item
				group_name}
			group_name = (<this_item>.group_name)
		else
			group_name = <name>
		endif
		FormatText checksumname = cs_grp_name '%s' s = <group_name>
		if NOT (ArrayContains array = <checksum_array> contains = <cs_grp_name>)
			AddArrayElement array = <checksum_array> element = <cs_grp_name>
			checksum_array = <array>
		else
			AddArrayElement array = <checksum_array> element = default_cs
			checksum_array = <array>
		endif
		AddArrayElement array = <group_name_array> element = <group_name>
		group_name_array = <array>
		AddArrayElement array = <names_array> element = <name>
		names_array = <array>
		AddArrayElement array = <textures_array> element = <texture>
		textures_array = <array>
		AddArrayElement array = <items_array> element = <this_item>
		items_array = <array>
		cntr = (<cntr> + 1)
		repeat <new_unlocks_size>
	endif
	GetArraySize <names_array>
	num_unlocks = <array_size>
	if ScreenElementExists \{id = my_rewards_id}
		DestroyScreenElement \{id = my_rewards_id}
	endif

	get_all_exclusive_devices
	texture = (<textures_array> [(<num_unlocks> -1)])
	if (<texture> = video)
		texture = black
	endif
	CreateScreenElement {
		parent = root_window
		id = my_rewards_id
		type = DescInterface
		desc = 'rewards'
		rewards_image_placeholder_texture = <texture>
		exclusive_device = <exclusive_device>
	}
	SoundEvent \{event = Unlock_New_Item}
	if my_rewards_id :Desc_ResolveAlias \{name = alias_list_menu}
	else

	endif
	i = 0
	if (<num_unlocks> > 0)
		debug_PrintStruct <...>
		if (<num_unlocks> > 1)
			<add_sound_event> = true
		else
			<add_sound_event> = false
		endif
		begin
		if NOT ((<checksum_array> [<i>]) = default_cs)
			CreateScreenElement {
				parent = <resolved_id>
				type = DescInterface
				desc = 'rewards_unlockable'
				autoSizeDims = true
				unlockable_text = (<group_name_array> [<i>])
				unlockable_control_pos = {(20.0, 0.0) relative}
				rewards_checkbox_alpha = 0
				unlockable_alpha = 0
			}
			SetScreenElementProps {
				id = <id>
				event_handlers = [
					{pad_choose rewards_continue_to_next_screen}
					{focus my_menu_focus params = {id = <id> item_textures = <textures_array> items_array = <items_array> item_index = <i> add_sound_event = <add_sound_event>}}
					{unfocus my_menu_unfocus params = {id = <id>}}
				]
			}
			<id> :obj_spawnscript anim_reward params = {index = <i> item_textures = <textures_array>}
		endif
		i = (<i> + 1)
		repeat <num_unlocks>
	endif
	spawnscriptnow set_focus_to_menu params = {menu_id = <resolved_id>}
	if loading_screen_exists
		destroy_loading_screen
	endif
endscript

script ui_destroy_rewards 
	clean_up_user_control_helpers
	DestroyScreenElement \{id = my_rewards_id}
	KillAllMovies
endscript

script ui_deinit_rewards 
	progression_reset_new_unlocks

endscript

script rewards_continue_to_next_screen 
	kill_reward_sparkle_scripts

	SE_SetProps \{block_events}
	progression_reset_new_unlocks
	ui_win_song_continue_next_menu
endscript

script my_menu_focus \{add_sound_event = true}
	SetScreenElementProps {
		id = <id>
		unlockable_rgba = [64 , 64 , 64 , 255]
	}
	texture = (<item_textures> [<item_index>])
	if (<texture> = video)
		texture = black
	endif
	SetScreenElementProps {
		id = my_rewards_id
		rewards_image_placeholder_texture = <texture>
	}
	if ((<item_textures> [<item_index>]) = video)
		if my_rewards_id :Desc_ResolveAlias \{name = alias_movie_parent}
			current_movie = ''
			<resolved_id> :GetSingleTag current_movie
			if NOT (<current_movie> = ($ui_select_venue_info.(<items_array> [<item_index>].item).movie))
				if ScreenElementExists \{id = reward_movie}
					DestroyScreenElement \{id = reward_movie}
					KillAllMovies
				endif
				Wait \{1
					gameframe}
				CreateScreenElement {
					type = MovieElement
					parent = <resolved_id>
					id = reward_movie
					dims = (280.0, 280.0)
					just = [center center]
					pos_anchor = [center center]
					pos = (3.0, 0.0)
					TextureSlot = 1
					TexturePri = 1000
					no_hold
					movie = ($ui_select_venue_info.(<items_array> [<item_index>].item).movie)
					z_priority = 10000
				}
				<resolved_id> :SetTags current_movie = ($ui_select_venue_info.(<items_array> [<item_index>].item).movie)
			endif
		endif
	else
		if ScreenElementExists \{id = reward_movie}
			DestroyScreenElement \{id = reward_movie}
			KillAllMovies
		endif
	endif
	Obj_GetID
	GetTags
	if my_rewards_id :Desc_ResolveAlias \{name = alias_highlight
			param = highlight_id}
		if <id> :Desc_ResolveAlias name = alias_unlockable param = text_id
			Wait \{2
				gameframe}
			highlight_width = 0
			highlight_height = 184
			GetScreenElementProps id = <text_id>
			text_hscale = ((1.0, 0.0).<scale>)
			GetScreenElementChildren id = <text_id>
			GetArraySize \{children}
			index = 0
			begin
			GetScreenElementDims id = (<children> [<index>])
			text_width = (<width> * <text_hscale>)
			if (<text_width> > <highlight_width>)
				highlight_width = <text_width>
			endif
			index = (<index> + 1)
			repeat <array_size>
			scale = ((1.0, 0.0) * ((<highlight_width> + 64.0) / 256.0))
			scale = (<scale> + ((0.0, 1.0) * ((<highlight_height> + 16.0) / 64.0)))
			GetScreenElementPosition id = <text_id> summed
			<highlight_id> :SE_SetProps pos = {absolute (<screenelementpos> + (0.0, 0.0))} scale = <scale>
			<highlight_id> :SE_WaitProps
			GetScreenElementPosition id = <text_id> summed
			<highlight_id> :SE_SetProps pos = {absolute (<screenelementpos> + (0.0, 10.0))} time = 0.05
			<highlight_id> :SE_WaitProps
			GetScreenElementPosition id = <text_id> summed
			<highlight_id> :SE_SetProps pos = {absolute (<screenelementpos> + (0.0, 0.0))} time = 0.05
			<highlight_id> :SE_WaitProps
		endif
	endif
	if (<add_sound_event> = true)
		if NOT ScriptIsRunning \{set_focus_to_menu}
			generic_menu_up_or_down_sound
		endif
	endif
endscript

script my_menu_unfocus 
	SetScreenElementProps {
		id = <id>
		unlockable_rgba = [255 , 255 , 255 , 255]
	}
endscript

script anim_reward 
	texture = (<item_textures> [<index>])
	if (<texture> = video)
		texture = black
	endif
	SetScreenElementProps {
		id = my_rewards_id
		rewards_image_placeholder_texture = <texture>
	}
	spawnscriptnow \{rewards_sparkle_manager}
	SE_SetProps \{unlockable_alpha = 1
		time = 0.4
		Anim = gentle}
endscript

script rewards_image_pulse_anim 
	SE_SetProps \{rewards_image_placeholder_scale = 1.4499999
		time = 0.01}
	SE_WaitProps
	SE_SetProps \{rewards_image_placeholder_scale = 1.2
		time = 0.01}
	SE_WaitProps
	SE_SetProps \{rewards_image_placeholder_scale = 0.9
		time = 0.01}
	SE_WaitProps
	SE_SetProps \{rewards_image_placeholder_scale = 1
		time = 0.01}
	SE_WaitProps
	SE_SetProps \{rewards_image_placeholder_scale = 1.15
		time = 0.01}
	SE_WaitProps
	SE_SetProps \{rewards_image_placeholder_scale = 1
		time = 0.01}
endscript

script set_focus_to_menu 
	SoundEvent \{event = Unlock_Item_Text_Appear}
	LaunchEvent type = focus target = <menu_id>
	add_user_control_helper \{text = qs("CONTINUE")
		button = green
		z = 100000}
endscript

script rewards_sparkle_manager 
	if NOT my_rewards_id :Desc_ResolveAlias \{name = alias_rewards_border
			param = rewards_border_id}
		debug_ScriptAssert \{qs(0x01c3bdb2)}
	endif
	parent = <rewards_border_id>
	left_side = {xa = 0.195 xb = 0.205 ya = 0.03 yb = 0.95 time_a = 0.2 time_b = 0.8}
	right_side = {xa = 0.8 xb = 0.815 ya = 0.03 yb = 0.95 time_a = 0.1 time_b = 0.7}
	top = {xa = 0.196 xb = 0.82 ya = 0.03 yb = 0.04 time_a = 0.3 time_b = 1.2}
	bottom = {xa = 0.196 xb = 0.82 ya = 0.945 yb = 0.955 time_a = 0.5 time_b = 1.5}
	<parent> :obj_spawnscript ui_sparkle_randomly params = {<left_side> parent = <parent>}
	<parent> :obj_spawnscript ui_sparkle_randomly params = {<top> parent = <parent>}
	Wait RandomFloat (0.1, 0.3) seconds
	<parent> :obj_spawnscript ui_sparkle_randomly params = {<bottom> parent = <parent>}
	Wait RandomFloat (0.1, 0.3) seconds
	<parent> :obj_spawnscript ui_sparkle_randomly params = {<right_side> parent = <parent>}
endscript

script kill_reward_sparkle_scripts 
	KillSpawnedScript \{name = rewards_sparkle_manager}
	ui_kill_sparkle_scripts
endscript
