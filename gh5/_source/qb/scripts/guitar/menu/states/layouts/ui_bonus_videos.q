
script ui_create_bonus_videos 
	change \{rich_presence_context = presence_videos}
	KillSpawnedScript \{name = ui_destroy_bonus_videos_spawned}
	set_bink_heap_state \{state = big}
	CreateScreenElement {
		type = DescInterface
		desc = 'videos'
		parent = root_window
		id = current_menu_anchor
		just = [center center]
		exclusive_device = ($primary_controller)
		tags = {
			current_preview = none
		}
	}
	if <id> :Desc_ResolveAlias name = alias_vmenu
		AssignAlias id = <resolved_id> alias = current_menu
		current_menu :SE_SetProps \{event_handlers = [
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
				{
					pad_back
					generic_event_back
				}
			]}
		current_menu :obj_spawnscript \{highlight_motion}
		GetArraySize ($Bonus_Videos)
		i = 0
		locked_count = 0
		begin
		if NOT ui_bonus_videos_is_locked id = ($Bonus_Videos [<i>].id)
			if (($Bonus_Videos [<i>].id) = credits)
				add_menu_frontend_item {
					text = ($Bonus_Videos [<i>].text)
					choose_state = uistate_bonus_videos_credits
					focus_script = ui_bonus_videos_focus
					focus_params = {credits}
					unfocus_script = ui_bonus_videos_unfocus
				}
			else
				movie = ($Bonus_Videos [<i>].movie)
				if (IsPAL)
					debug_Printf \{'VIDEO: IsPal'}
					if (<movie> = 'band_hero_teaser')
						movie = 'Band_Hero_Teaser_NO_ESRB'
					elseif (<movie> = 'djhero_teaser')
						movie = 'DJHero_Teaser_NO_ESRB'
					endif
				endif
				debug_Printf 'VIDEO: %v' v = <movie>
				add_menu_frontend_item {
					text = ($Bonus_Videos [<i>].text)
					pad_choose_script = ui_bonus_videos_play_video
					pad_choose_params = {($Bonus_Videos [<i>]) movie = <movie>}
					focus_script = ui_bonus_videos_focus
					focus_params = {($Bonus_Videos [<i>])}
					unfocus_script = ui_bonus_videos_unfocus
				}
			endif
		else
			<locked_count> = (<locked_count> + 1)
		endif
		<i> = (<i> + 1)
		repeat <array_size>
		if (<locked_count> > 0)
			begin
			add_menu_frontend_item {
				text = qs("LOCKED")
				pad_choose_script = nullscript
				pad_choose_sound = ui_bonus_videos_negative_sfx
				focus_script = ui_bonus_videos_focus
				focus_params = {($Bonus_Videos [0]) locked}
				unfocus_script = ui_bonus_videos_unfocus
				rgba = [160 150 140 175]
				not_focusable
			}
			repeat <locked_count>
		endif
		GetScreenElementDims id = <item_id>
		<Height> = (<Height> * <array_size>)
		current_menu :SetTags {total_height = <Height>}
	endif
	add_user_control_helper \{text = qs("SELECT")
		button = green
		z = 100000}
	add_user_control_helper \{text = qs("BACK")
		button = red
		z = 100000}
endscript

script ui_destroy_bonus_videos 
	KillSpawnedScript \{name = ui_bonus_video_preview}
	spawnscriptnow \{ui_destroy_bonus_videos_spawned}
	if ScreenElementExists \{id = current_menu_anchor}
		DestroyScreenElement \{id = current_menu_anchor}
	endif
	clean_up_user_control_helpers
endscript

script ui_destroy_bonus_videos_spawned 
	if ($bink_heap_state = small)
		return
	endif
	KillMovie \{TextureSlot = 1}
	WaitForAllMoviesToFinish
	set_bink_heap_state \{state = small}
	menu_music_on
	spawnscriptnow \{Skate8_SFX_Backgrounds_New_Area
		params = {
			BG_SFX_Area = FrontEnd_Menu_Music
		}}
endscript

script ui_bonus_videos_play_video \{movie = 'atvi'}
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	if ui_bonus_videos_is_locked id = <id>
		return
	endif
	ui_event_block \{event = menu_unfocus}
	current_menu :SE_SetProps \{block_events}
	KillSpawnedScript \{name = ui_bonus_video_preview}
	DestroyScreenElement \{id = preview_movie}
	WaitForAllMoviesToFinish
	Menu_Music_Off
	spawnscriptnow \{BG_Crowd_Front_End_Silence
		params = {
			immediate = 1
		}}
	fadetoblack \{on
		alpha = 1.0
		time = 0
		z_priority = 200}
	clean_up_user_control_helpers
	NetSessionFunc \{func = RemoveAllControllers}
	pop_loading_screen
	PlayMovieAndWait noblack movie = <movie>
	push_loading_screen \{sustain}
	if ($invite_controller = -1)
		NetSessionFunc func = AddControllers params = {controller = ($primary_controller)}
	else
		NetSessionFunc func = AddControllers params = {controller = ($invite_controller)}
	endif
	menu_finish
	fadetoblack \{off
		time = 0}
	spawnscriptnow \{Skate8_SFX_Backgrounds_New_Area
		params = {
			BG_SFX_Area = FrontEnd_Menu_Music
		}}
	SpawnScript ui_bonus_video_preview params = <...>
	current_menu :SE_SetProps \{unblock_events}
	ui_event_block \{event = menu_focus}
endscript

script ui_bonus_videos_is_locked 
	GetArraySize ($Bonus_Videos)
	i = 0
	begin
	if GotParam \{id}
		if (<id> = ($Bonus_Videos [<i>].id))
			GetGlobalTags ($Bonus_Videos [<i>].id)
			if (<unlocked> = 0)
				return \{true}
			else
				return \{false}
			endif
		endif
	elseif GotParam \{movie}
		if (<movie> = ($Bonus_Videos [<i>].movie))
			GetGlobalTags ($Bonus_Videos [<i>].id)
			if (<unlocked> = 0)
				return \{true}
			else
				return \{false}
			endif
		endif
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script get_movie_id_by_name 
	GetArraySize ($Bonus_Videos)
	i = 0
	begin
	if (($Bonus_Videos [<i>].movie) = <movie>)
		return id = ($Bonus_Videos [<i>].id)
	endif
	<i> = (<i> + 1)
	repeat <array_size>

endscript

script ui_bonus_videos_negative_sfx 
	SoundEvent \{event = UI_SFX_Negative_Select}
endscript

script ui_bonus_videos_anim_in 
	menu_transition_in \{menu = current_menu_anchor}
endscript

script ui_bonus_videos_anim_out 
	menu_transition_out \{menu = current_menu_anchor}
endscript

script ui_bonus_videos_focus 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request
		CheckWholeCallstack}
	current_menu :SE_SetProps \{block_events}
	Obj_GetID
	GetTags
	SE_SetProps \{rgba = [
			0
			0
			0
			255
		]}
	<ObjID> :SE_GetParentId
	current_menu :GetTags \{total_height}
	GetScreenElementPosition id = <ObjID>
	scroll_perc = ((<screenelementpos>.(0.0, 1.0)) / (<total_height>))
	scroll_len = 370
	scroll_pos = (((<scroll_perc> * 370) * (0.0, 1.0)) + (1.0, 0.0))
	current_menu_anchor :SE_SetProps setlist_B_scrollthumb_pos = <scroll_pos>
	if current_menu_anchor :Desc_ResolveAlias \{name = alias_highlight}
		Wait \{2
			gameframe}
		<ObjID> :SE_GetParentId
		<parent_id> :SE_GetProps
		hscale = ((1.0, 0.0).<scale>)
		<parent_id> :SE_GetParentId
		<parent_id> :SE_GetProps
		<resolved_id> :SE_SetProps rot_angle = <rot_angle>
		GetScreenElementDims id = <ObjID>
		<width> = (<width> * <hscale>)
		<extend> = 15
		scale = (((1.0, 0.0) * ((<width> + (<extend> * 2)) / 256.0)) + (0.0, 1.0))
		GetScreenElementPosition id = <ObjID> summed
		<screenelementpos> = (<screenelementpos> - ((1.0, 0.0) * <extend>))
		<resolved_id> :SE_SetProps pos = {absolute <screenelementpos>} scale = <scale>
		<resolved_id> :SE_WaitProps
		GetScreenElementPosition id = <ObjID> summed
		<screenelementpos> = (<screenelementpos> - ((1.0, 0.0) * <extend>))
		<resolved_id> :SE_SetProps pos = {absolute (<screenelementpos> + (0.0, -10.0))} time = 0.05
		<resolved_id> :SE_WaitProps
		GetScreenElementPosition id = <ObjID> summed
		<screenelementpos> = (<screenelementpos> - ((1.0, 0.0) * <extend>))
		<resolved_id> :SE_SetProps pos = {absolute <screenelementpos>} scale = <scale> time = 0.05
		<resolved_id> :SE_WaitProps
	endif
	current_menu :SE_SetProps \{unblock_events}
	if ((GotParam credits) || (GotParam locked))
		current_menu_anchor :SE_SetProps \{video_placeholder_texture = video_placeholder}
		current_menu_anchor :SE_SetProps \{info_text = qs("")}
	else
		FormatText checksumname = video_image 'Video_%n' n = <movie>
		current_menu_anchor :SE_SetProps video_placeholder_texture = <video_image>
		FormatText checksumname = movie_checksum '%m' m = <movie>
		current_menu_anchor :SE_SetProps \{info_text = qs("")}
	endif
endscript

script ui_bonus_video_preview \{movie = 'atvi'}
	Wait \{0.35000002
		second}
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	current_menu_anchor :GetTags
	clean_up_user_control_helpers
	if ((GotParam credits) || (GotParam locked))
		DestroyScreenElement \{id = preview_movie}
		WaitForAllMoviesToFinish
		current_menu_anchor :SE_SetProps \{info_text = qs("")}
		menu_music_on
		spawnscriptnow \{Skate8_SFX_Backgrounds_New_Area
			params = {
				BG_SFX_Area = FrontEnd_Menu_Music
			}}
		add_user_control_helper \{text = qs("SELECT")
			button = green
			z = 100000}
		add_user_control_helper \{text = qs("BACK")
			button = red
			z = 100000}
		current_menu_anchor :SE_SetProps \{video_placeholder_alpha = 1.0
			time = 0.1}
	elseif GotParam \{movie}
		Menu_Music_Off
		spawnscriptnow \{BG_Crowd_Front_End_Silence
			params = {
				immediate = 1
			}}
		add_user_control_helper \{text = qs("SELECT")
			button = green
			z = 100000}
		add_user_control_helper \{text = qs("BACK")
			button = red
			z = 100000}
		if (<movie> = <current_preview>)
			if ScreenElementExists \{id = preview_movie}
				return
			endif
		endif
		if current_menu_anchor :Desc_ResolveAlias \{name = alias_video_container}
			DestroyScreenElement \{id = preview_movie}
			WaitForAllMoviesToFinish
			FormatText checksumname = movie_checksum '%m' m = <movie>
			current_menu_anchor :SE_SetProps \{info_text = qs("")}
			set_bink_heap_state \{state = big}
			if GotParam \{locked}
				alpha = 0.1
			endif
			CreateScreenElement {
				type = MovieElement
				parent = <resolved_id>
				id = preview_movie
				dims = (490.0, 275.0)
				just = [center center]
				pos_anchor = [center center]
				pos = (0.0, 0.0)
				TextureSlot = 1
				TexturePri = 1000
				no_hold
				movie = <movie>
				alpha = <alpha>
			}
			current_menu_anchor :SetTags current_preview = <movie>
			begin
			if IsMoviePlaying \{TextureSlot = 1}
				break
			endif
			Wait \{1
				gameframes}
			repeat
			current_menu_anchor :SE_SetProps \{video_placeholder_alpha = 0.0
				time = 0.1}
		endif
	endif
endscript

script ui_bonus_videos_unfocus 
	SE_SetProps \{rgba = [
			255
			255
			255
			255
		]}
endscript
