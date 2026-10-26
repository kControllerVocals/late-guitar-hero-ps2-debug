
script ui_create_bonus_videos 
	change \{rich_presence_context = presence_videos}
	KillSpawnedScript \{name = ui_destroy_bonus_videos_spawned}
	set_bink_heap_state \{state = big}
	make_generic_stripe_menu \{title = qs("VIDEOS")
		pad_back_script = ui_select_instrument_back
		option_arrows}
	GetArraySize ($Bonus_Videos)
	i = 0
	locked_count = 0
	begin
	if NOT ui_bonus_videos_is_locked id = ($Bonus_Videos [<i>].id)
		if (($Bonus_Videos [<i>].id) = credits)
			add_generic_stripe_menu_item {
				text = ($Bonus_Videos [<i>].text)
				choose_state = uistate_bonus_videos_credits
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
			add_generic_stripe_menu_item {
				text = ($Bonus_Videos [<i>].text)
				pad_choose_script = ui_bonus_videos_play_video
				pad_choose_params = {($Bonus_Videos [<i>]) movie = <movie>}
			}
		endif
	else
		<locked_count> = (<locked_count> + 1)
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	if (<locked_count> > 0)
		begin
		add_generic_stripe_menu_item \{text = qs("LOCKED")
			pad_choose_script = nullscript
			pad_choose_sound = ui_bonus_videos_negative_sfx
			focus_rgba = [
				160
				150
				140
				175
			]
			unfocus_rgba = [
				160
				150
				140
				175
			]}
		repeat <locked_count>
	endif
	add_user_control_helper \{text = qs("SELECT")
		button = green
		z = 100000}
	add_user_control_helper \{text = qs("BACK")
		button = red
		z = 100000}
endscript

script ui_destroy_bonus_videos 
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
	menu_music_on
	current_menu :SE_SetProps \{unblock_events}
	LaunchEvent \{type = focus
		target = current_menu}
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
