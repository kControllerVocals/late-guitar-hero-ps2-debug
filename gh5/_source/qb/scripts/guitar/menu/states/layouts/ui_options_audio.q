Restart_Menu_Music = 0
Stereo_Switch_Warning = 0

script ui_create_options_audio 
	if ($Menu_Music_On_Flag = 1)
		Menu_Music_Off
		change \{Restart_Menu_Music = 1}
	endif
	if GotParam \{from_pause}
		change \{Stereo_Switch_Warning = 1}
	else
		change \{Stereo_Switch_Warning = 0}
	endif
	if NOT GotParam \{device_num}
		device_num = ($primary_controller)
	endif
	player = 1
	i = 1
	begin
	GetPlayerInfo <i> controller
	if (<controller> = <device_num>)
		player = <i>
		break
	endif
	i = (<i> + 1)
	repeat ($current_num_players)
	vocals_mute_all_mics \{mute = false}
	GetPlayerInfo <player> checksum
	get_savegame_from_player_status player_status = <checksum>
	GetGlobalTags user_options savegame = <savegame>
	volume = [0 0 0 0 0 0]
	SetArrayElement ArrayName = volume index = 0 newvalue = (<volumes>.guitar.guitar.vol)
	SetArrayElement ArrayName = volume index = 1 newvalue = (<volumes>.guitar.Bass.vol)
	SetArrayElement ArrayName = volume index = 2 newvalue = (<volumes>.guitar.drum.vol)
	SetArrayElement ArrayName = volume index = 3 newvalue = (<volumes>.guitar.Band.vol)
	SetArrayElement ArrayName = volume index = 4 newvalue = (<volumes>.guitar.mic.vol)
	SetArrayElement ArrayName = volume index = 5 newvalue = (<volumes>.guitar.sfx.vol)
	eq = [1 1 1 1]
	SetArrayElement ArrayName = eq index = 0 newvalue = (<volumes>.guitar.guitar.eq)
	SetArrayElement ArrayName = eq index = 1 newvalue = (<volumes>.guitar.Bass.eq)
	SetArrayElement ArrayName = eq index = 2 newvalue = (<volumes>.guitar.drum.eq)
	SetArrayElement ArrayName = eq index = 3 newvalue = (<volumes>.guitar.mic.rev)
	initial_volume = [7 7 7 7 7 7]
	CreateScreenElement {
		parent = root_window
		id = AudioInterface
		type = DescInterface
		desc = 'options_audio_mixer'
		tags = {volume = <volume> eq = <eq> dolby_digital = <dolby_digital>
			initial_volume = <initial_volume> initial_eq = <eq>
			player = <player>}
		z_priority = 650
		exclusive_device = <device_num>
	}
	AudioInterface :SE_SetProps \{mixer_channel_lamp_alpha = 0.0}
	if AudioInterface :Desc_ResolveAlias \{name = alias_audio_mixer_menu}
		AssignAlias id = <resolved_id> alias = current_menu
		current_menu :SE_SetProps \{event_handlers = [
				{
					pad_back
					ui_options_check_settings
				}
				{
					pad_option
					ui_options_audio_reset_values
				}
				{
					pad_option2
					ui_options_audio_stereo_warning
				}
				{
					pad_up
					sound_options_scroll
				}
				{
					pad_down
					sound_options_scroll
				}
			]}
		if GetScreenElementChildren \{id = current_menu}
			GetArraySize <children>
			i = 0
			begin
			<current_item> = (<children> [<i>])
			<current_item> :SE_SetProps {
				event_handlers = [
					{focus ui_options_audio_focus_text_menu params = {text_idx = <i>}}
					{unfocus ui_options_audio_unfocus_text_menu}
					{pad_choose ui_options_audio_choose}
				]
				tags = {
					index = <i>
				}
			}
			i = (<i> + 1)
			repeat (<array_size>)
		endif
	endif
	if AudioInterface :Desc_ResolveAlias \{name = alias_faders_container}
		if GetScreenElementChildren id = <resolved_id>
			GetArraySize <children>
			i = 0
			begin
			<current_item> = (<children> [<i>])
			<current_item> :SE_SetProps {
				event_handlers = [
					{focus ui_options_audio_focus_fader_menu}
					{unfocus ui_options_audio_unfocus_fader_menu}
					{pad_back ui_options_audio_fader_back}
					{pad_choose ui_options_audio_fader_choose}
					{pad_up ui_options_audio_fader_dir params = {up}}
					{pad_down ui_options_audio_fader_dir params = {down}}
				]
				tags = {
					index = <i>
					current = none
					highlight = slider
				}
			}
			i = (<i> + 1)
			repeat <array_size>
		endif
	endif
	ui_options_audio_set_values
	ui_options_audio_set_default_volume_lights default_volumes = <initial_volume>
	GetGlobalTags \{user_options}
	if (<PS2_Stereo_Sound> = 1)
		stereo_text_alpha = 1.0
		mono_text_alpha = 0.5
	else
		stereo_text_alpha = 0.5
		mono_text_alpha = 1.0
	endif
	AudioInterface :SE_SetProps {
		stereo_text_alpha = <stereo_text_alpha>
		mono_text_alpha = <mono_text_alpha>
	}
	AudioInterface :obj_spawnscript \{highlight_motion
		params = {
			menu_id = AudioInterface
			alias_name = alias_mixer_menu_highlight
		}}
	ui_options_audio_add_helpers
	ui_options_set_settings
endscript

script ui_destroy_options_audio 
	spawnscriptnow \{No_Dolby_Digital_Sounds}
	vocals_mute_all_mics \{mute = true}
	if ($Restart_Menu_Music = 1)
		menu_music_on
		change \{Restart_Menu_Music = 0}
	endif
	DestroyScreenElement \{id = AudioInterface}
	generic_ui_destroy
endscript

script ui_options_audio_reset_values 
	AudioInterface :GetTags
	AudioInterface :SetTags {volume = <initial_volume> eq = <initial_eq>}
	ui_options_audio_set_values \{time = 0.1}
	SoundEvent \{event = Menu_Audio_Options_Reset}
endscript

script ui_options_audio_set_values \{time = 0.0}
	AudioInterface :GetTags
	if AudioInterface :Desc_ResolveAlias \{name = alias_faders_container}
		if GetScreenElementChildren id = <resolved_id>
			GetArraySize <volume>
			i = 0
			begin
			posx = 3
			posy = (-27 + (265 * (1.0 - ((<volume> [<i>]) / 11.0))))
			<fader> = (<children> [<i>])
			<fader> :SE_SetProps {
				mixer_fader_pos = (((1.0, 0.0) * <posx>) + ((0.0, 1.0) * <posy>))
				time = <time>
			}
			j = 1
			alpha_value = 0
			begin
			FormatText checksumname = fader_light 'lights_ON_%a_alpha' a = <j>
			<alpha_value> = 0
			if (<j> <= (<volume> [<i>]))
				<alpha_value> = 1
			endif
			AddParam structure_name = fader_light_alpha_struct name = <fader_light> value = <alpha_value>
			<fader> :SE_SetProps {
				<fader_light_alpha_struct>
				time = <time>
			}
			<j> = (<j> + 1)
			repeat 10
			i = (<i> + 1)
			repeat (<array_size>)
		endif
	endif
	GetPlayerInfo <player> controller
	if PlayerInfoEquals <player> bot_play = 1
		<controller> = 0
	endif
	UpdateVolumesTag part = guitar name = guitar params = {vol = (<volume> [0])}
	UpdateVolumesTag part = guitar name = Bass params = {vol = (<volume> [1])}
	UpdateVolumesTag part = guitar name = drum params = {vol = (<volume> [2])}
	UpdateVolumesTag part = guitar name = Band params = {vol = (<volume> [3])}
	UpdateVolumesTag part = guitar name = mic params = {vol = (<volume> [4])} controller = <controller>
	UpdateVolumesTag part = guitar name = sfx params = {vol = (<volume> [5])}
	ui_options_audio_update_all_volumes
	SongSetPlayerEQSettings
endscript

script ui_options_audio_focus_text_menu 
	SoundEvent \{event = UI_Fader}

	if ScreenElementExists \{id = AudioInterface}
		initial_highlight_pos = (-100.0, -143.0)
		GetTags
		Obj_GetID
		GetScreenElementPosition id = <ObjID>
		SE_SetProps \{alpha = 1.0}
		AudioInterface :SE_GetProps
		switch <text_idx>
			case 0
			AudioInterface :SE_SetProps \{mixer_menu_highlight_dims = (95.0, 40.0)}
			spacing = (115.0, 0.0)
			case 1
			AudioInterface :SE_SetProps \{mixer_menu_highlight_dims = (105.0, 40.0)}
			spacing = (157.0, 0.0)
			case 2
			AudioInterface :SE_SetProps \{mixer_menu_highlight_dims = (105.0, 40.0)}
			spacing = (162.0, 0.0)
			case 3
			AudioInterface :SE_SetProps \{mixer_menu_highlight_dims = (145.0, 40.0)}
			spacing = (155.5, 0.0)
			case 4
			AudioInterface :SE_SetProps \{mixer_menu_highlight_dims = (95.0, 40.0)}
			spacing = (165.0, 0.0)
			case 5
			AudioInterface :SE_SetProps \{mixer_menu_highlight_dims = (105.0, 40.0)}
			spacing = (165.4, 0.0)
			case 6
			AudioInterface :SE_SetProps \{mixer_menu_highlight_dims = (105.0, 40.0)}
			spacing = (118.6, 0.0)
			case 7
			AudioInterface :SE_SetProps \{mixer_menu_highlight_dims = (95.0, 40.0)}
			spacing = (119.5, 0.0)
			default

		endswitch
		if NOT (<mixer_menu_highlight_alpha> = 0.3)
			AudioInterface :SE_SetProps \{mixer_menu_highlight_alpha = 0.3
				time = 0.1}
		endif
		AudioInterface :SE_SetProps mixer_menu_highlight_pos = (<initial_highlight_pos> + (<spacing> * <text_idx>)) time = 0.1
		if ScreenElementExists \{id = mixer_text_menu}
			mixer_text_menu :SetTags {current_focused_idx = <text_idx>}
			mixer_text_menu :SE_SetProps \{alpha = 1
				time = 0.1}
		endif
	endif
endscript

script ui_options_audio_unfocus_text_menu 
	GetTags
	if NOT GotParam \{dolby_option}
	else
		AudioInterface :SE_SetProps \{mixer_stereo_toggle_text_color = [
				128
				128
				128
				255
			]}
	endif
	GetTags
	Obj_GetID
	GetScreenElementPosition id = <ObjID>
	SE_SetProps \{alpha = 0.5}
endscript

script ui_options_audio_choose 
	clean_up_user_control_helpers
	menu_finish
	GetTags
	if AudioInterface :Desc_ResolveAlias \{name = alias_faders_container}
		if ResolveScreenElementId id = {<resolved_id> child = <index>}
			AudioInterface :SE_SetProps \{mixer_channel_lamp_alpha = 1.0
				time = 0.1}
			LaunchEvent \{type = unfocus
				target = current_menu}
			<resolved_id> :SE_GetProps
			<resolved_id> :SetTags current = slider highlight = slider
			LaunchEvent type = focus target = <resolved_id>
		endif
	endif
	current_menu :SE_SetProps \{alpha = 0.5
		time = 0.1}
	ui_options_sound_event \{choose}
endscript

script ui_options_audio_dolby_flash 
	AudioInterface :SE_SetProps \{mixer_red_light_OFF_alpha = 1.0}
	begin
	AudioInterface :SE_SetProps dolby_highlight_container_alpha = RandomFloat (0.2, 0.5)
	Wait \{0.1
		seconds
		ignoreslomo}
	repeat
endscript

script ui_options_audio_stereo_warning 
	if ($Stereo_Switch_Warning = 0)
		ui_options_audio_choose_stereo <...>
		return
	endif
	disable_pause
	LaunchEvent \{type = unfocus
		target = AudioInterface}
	player_device = ($last_start_pressed_device)
	<num_players> = ($current_num_players)
	if (<num_players> > 0)
		i = 1
		begin
		GetPlayerInfo <i> controller
		if (<controller> = <player_device>)
			player = <i>
			break
		endif
		i = (<i> + 1)
		repeat <num_players>
	endif
	create_dialog_box {
		body_text = qs(0x450ad8bf)
		player_device = <player_device>
		no_background
		options = [
			{
				func = ui_options_audio_destroy_stereo_warning
				text = qs("CANCEL")
			}
			{
				func = ui_options_audio_choose_stereo
				func_params = {player = <player>}
				text = qs("RESTART")
			}
		]
		back_button_script = ui_options_audio_destroy_stereo_warning
	}
	LaunchEvent \{type = focus
		target = dialog_box_vmenu}
endscript

script ui_options_audio_destroy_stereo_warning 
	LaunchEvent \{type = unfocus
		target = dialog_box_vmenu}
	enable_pause
	destroy_dialog_box
	LaunchEvent \{type = focus
		target = current_menu}
	ui_options_audio_add_helpers
endscript

script ui_options_audio_choose_stereo 
	if IsPs3
		return
	endif
	AudioInterface :SE_SetProps \{block_events}
	generic_menu_pad_choose_sound
	GetGlobalTags \{user_options}
	if (<PS2_Stereo_Sound> = 1)
		SetGlobalTags \{user_options
			params = {
				PS2_Stereo_Sound = 0
			}}
		SetStereoSound \{0}
	else
		SetGlobalTags \{user_options
			params = {
				PS2_Stereo_Sound = 1
			}}
		SetStereoSound \{1}
	endif
	ui_options_audio_set_values
	Wait \{1
		seconds
		ignoreslomo}
	AudioInterface :GetTags
	GetGlobalTags \{user_options}
	if (<PS2_Stereo_Sound> = 1)
		stereo_text_alpha = 1.0
		mono_text_alpha = 0.5
	else
		stereo_text_alpha = 0.5
		mono_text_alpha = 1.0
	endif
	AudioInterface :SE_SetProps {
		stereo_text_alpha = <stereo_text_alpha>
		mono_text_alpha = <mono_text_alpha>
	}
	ui_options_sound_event \{dolby_option}
	AudioInterface :SE_SetProps \{unblock_events}
	if ($Stereo_Switch_Warning = 1)
		ui_options_audio_destroy_stereo_warning
		ui_destroy_options_audio
		if ($game_mode = practice)
			practice_restart_song
		else
			career_restart_song
		endif
	endif
endscript

script ui_options_audio_focus_fader_menu 
	GetTags
	if (<current> = none)
		if (<highlight> = slider)
			SE_SetProps \{knob_highlight_alpha = 0.0
				mixer_fader_highlight_alpha = 0.5}
		else
			SE_SetProps \{knob_highlight_alpha = 0.5
				mixer_fader_highlight_alpha = 0.0}
		endif
	elseif (<current> = slider)
		SE_SetProps \{knob_highlight_alpha = 0.0
			mixer_fader_highlight_alpha = 1.0}
	else
		SE_SetProps \{knob_highlight_alpha = 1.0
			mixer_fader_highlight_alpha = 0.0}
	endif
endscript

script ui_options_audio_unfocus_fader_menu 
	GetTags
	SE_SetProps \{knob_highlight_alpha = 0.0
		mixer_fader_highlight_alpha = 0.0}
endscript

script ui_options_audio_fader_choose 
	GetTags
	SE_GetProps
	ui_options_audio_add_helpers
	if (<current> = none)
		SetTags \{current = slider
			highlight = slider}
	elseif (<current> = slider)
		SetTags \{current = none}
		LaunchEvent \{type = focus
			target = current_menu}
		current_menu :SE_SetProps \{alpha = 1.0
			time = 0.1}
		LaunchEvent type = unfocus target = <ObjID>
		ui_options_sound_event \{choose}
		return
	else
		SetTags \{current = none
			highlight = dial}
	endif
	generic_menu_pad_choose_sound
	ui_options_audio_focus_fader_menu
endscript

script ui_options_audio_fader_back 
	GetTags
	Obj_GetID
	SE_GetProps
	ui_options_audio_add_helpers
	if (<current> = none)
		LaunchEvent \{type = focus
			target = current_menu}
		current_menu :SE_SetProps \{alpha = 1.0
			time = 0.1}
		LaunchEvent type = unfocus target = <ObjID>
	elseif (<current> = slider)
		ui_options_sound_event \{back}
		SetTags \{current = none}
		LaunchEvent \{type = focus
			target = current_menu}
		current_menu :SE_SetProps \{alpha = 1.0
			time = 0.1}
		LaunchEvent type = unfocus target = <ObjID>
	else
		SetTags \{current = none}
		ui_options_audio_focus_fader_menu
	endif
endscript

script ui_options_audio_fader_dir 
	SoundEvent \{event = Audio_Options_Scroll}
	GetTags
	if (<current> = none)
		SetTags \{highlight = slider}
		generic_menu_up_or_down_sound
	elseif (<current> = slider)
		AudioInterface :GetTags
		new_volume = 0
		min_volume = 0
		dolby_changed = 0
		if GotParam \{down}
			new_volume = (<volume> [<index>])
			if (<index> <= 4)
				min_volume = 5
			endif
			if NOT (<new_volume> <= <min_volume>)
				new_volume = ((<volume> [<index>]) - 1)
			else
				if ($paused_for_hardware = 0)
				endif
			endif
		else
			new_volume = (<volume> [<index>])
			if NOT (<new_volume> >= 10)
				new_volume = ((<volume> [<index>]) + 1)
			else
				if ($paused_for_hardware = 0)
				endif
			endif
		endif
		if NOT (<new_volume> = (<volume> [<index>]))
			SetArrayElement ArrayName = volume index = <index> newvalue = <new_volume>
			AudioInterface :SetTags volume = <volume>
			ui_options_audio_set_values \{time = 0.1}
			ui_options_sound_event slider index = <index>
		endif
	endif
	ui_options_audio_focus_fader_menu
endscript

script ui_options_sound_event 
	AudioInterface :GetTags
	if GotParam \{slider}
		current_volume = (<volume> [<index>])
		switch (<index>)
			case 0
			SoundEvent \{event = UI_SFX_Scroll_Down}
			spawnscriptnow \{playing_sound_fader
				params = {
					instrument = guitar
					time = 1.3379999
				}}
			case 1
			SoundEvent \{event = UI_SFX_Scroll_Down}
			spawnscriptnow \{playing_sound_fader
				params = {
					instrument = Bass
					time = 1.235
				}}
			case 2
			SoundEvent \{event = UI_SFX_Scroll_Down}
			spawnscriptnow \{playing_sound_fader
				params = {
					instrument = Drums
					time = 1.8379999
				}}
			case 3
			SoundEvent \{event = UI_SFX_Scroll_Down}
			spawnscriptnow \{playing_sound_fader
				params = {
					instrument = mic
					time = 2.826
				}}
			case 4
			SoundEvent \{event = UI_SFX_Scroll_Down}
			spawnscriptnow \{playing_sound_fader
				params = {
					instrument = Instruments
					time = 1.938
				}}
			case 5
			SoundEvent \{event = UI_SFX_Scroll_Down}
			spawnscriptnow \{playing_sound_fader
				params = {
					instrument = sfx
					time = 2.612
				}}
		endswitch
	elseif GotParam \{knob}
		current_volume = (<eq> [<index>])
		SoundEvent \{event = UI_Knob}
		switch (<index>)
			case 0
			if GotParam \{newvalue}
				switch <newvalue>
					case 1
					if issoundplaying \{Audio_Options_Guitar}
						setsoundbusseffects \{effects = [
								{
									$EQ_GuitarLead_Crisp
									name = audiooptionssound
								}
							]
							time = 0.2}
					else
						spawnscriptnow \{playing_sound_knob
							params = {
								eq_setting = $EQ_GuitarLead_Crisp
								instrument = guitar
							}}
					endif
					change \{Guitar_Knob_Effects_Position = 1}
					case 2
					if issoundplaying \{Audio_Options_Guitar}
						setsoundbusseffects \{effects = [
								{
									$EQ_GuitarLead_Edgy
									name = audiooptionssound
								}
							]
							time = 0.2}
					else
						spawnscriptnow \{playing_sound_knob
							params = {
								eq_setting = $EQ_GuitarLead_Edgy
								instrument = guitar
							}}
					endif
					change \{Guitar_Knob_Effects_Position = 2}
					case 3
					if issoundplaying \{Audio_Options_Guitar}
						setsoundbusseffects \{effects = [
								{
									$EQ_GuitarLead_Fuzz
									name = audiooptionssound
								}
							]
							time = 0.2}
					else
						spawnscriptnow \{playing_sound_knob
							params = {
								eq_setting = $EQ_GuitarLead_Fuzz
								instrument = guitar
							}}
					endif
					change \{Guitar_Knob_Effects_Position = 3}
				endswitch
			endif
			case 1
			if GotParam \{newvalue}
				switch <newvalue>
					case 1
					if issoundplaying \{Audio_Options_Bass}
						setsoundbusseffects \{effects = [
								{
									$EQ_Bass_Bari
									name = audiooptionssound
								}
							]
							time = 0.2}
					else
						spawnscriptnow \{playing_sound_knob
							params = {
								eq_setting = $EQ_Bass_Bari
								instrument = Bass
							}}
					endif
					change \{Bass_Knob_Effects_Position = 1}
					case 2
					if issoundplaying \{Audio_Options_Bass}
						setsoundbusseffects \{effects = [
								{
									$EQ_Bass_Boomy
									name = audiooptionssound
								}
							]
							time = 0.2}
					else
						spawnscriptnow \{playing_sound_knob
							params = {
								eq_setting = $EQ_Bass_Boomy
								instrument = Bass
							}}
					endif
					change \{Bass_Knob_Effects_Position = 2}
					case 3
					if issoundplaying \{Audio_Options_Bass}
						setsoundbusseffects \{effects = [
								{
									$EQ_Bass_Fretty
									name = audiooptionssound
								}
							]
							time = 0.2}
					else
						spawnscriptnow \{playing_sound_knob
							params = {
								eq_setting = $EQ_Bass_Fretty
								instrument = Bass
							}}
					endif
					change \{Bass_Knob_Effects_Position = 3}
				endswitch
			endif
			case 2
			if GotParam \{newvalue}
				switch <newvalue>
					case 1
					if issoundplaying \{Audio_Options_Drum}
						setsoundbusseffects \{effects = [
								{
									$EQ_Drum_Punch
									name = audiooptionssound
								}
							]
							time = 0.2}
					else
						spawnscriptnow \{playing_sound_knob
							params = {
								eq_setting = $EQ_Drum_Punch
								instrument = Drums
							}}
					endif
					change \{Drum_Knob_Effects_Position = 1}
					case 2
					if issoundplaying \{Audio_Options_Drum}
						setsoundbusseffects \{effects = [
								{
									$EQ_Drum_Crack
									name = audiooptionssound
								}
							]
							time = 0.2}
					else
						spawnscriptnow \{playing_sound_knob
							params = {
								eq_setting = $EQ_Drum_Crack
								instrument = Drums
							}}
					endif
					change \{Drum_Knob_Effects_Position = 2}
					case 3
					if issoundplaying \{Audio_Options_Drum}
						setsoundbusseffects \{effects = [
								{
									$EQ_Drum_Sizzle
									name = audiooptionssound
								}
							]
							time = 0.2}
					else
						spawnscriptnow \{playing_sound_knob
							params = {
								eq_setting = $EQ_Drum_Sizzle
								instrument = Drums
							}}
					endif
					change \{Drum_Knob_Effects_Position = 3}
				endswitch
			endif
			case 3
		endswitch
	elseif GotParam \{dolby_option}
		if (<dolby_digital> = 1)
			PlaySound \{Menu_DolbyDigitalEnable_Surround_L
				vol = 4
				pan1x = -1
				pan1y = 1
				buss = front_end}
			PlaySound \{Menu_DolbyDigitalEnable_Surround_C
				vol = 4
				pan1x = 0
				pan1y = 1
				buss = front_end}
			PlaySound \{Menu_DolbyDigitalEnable_Surround_R
				vol = 4
				pan1x = 1
				pan1y = 1
				buss = front_end}
			PlaySound \{Menu_DolbyDigitalEnable_Surround_Ls
				vol = 4
				pan1x = -1
				pan1y = -1
				buss = front_end}
			PlaySound \{Menu_DolbyDigitalEnable_Surround_Rs
				vol = 4
				pan1x = 1
				pan1y = -1
				buss = front_end}
			PlaySound \{Menu_DolbyDigitalEnable_Surround_Lf
				vol = 4
				LFEOnly = true
				LFE_vol = -15
				buss = front_end}
		else
			SoundEvent \{Dolby_Off}
		endif
	elseif GotParam \{back}
		SoundEvent \{event = Sound_Options_Back}
		StopSound \{Audio_Options_Guitar
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_Bass
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_Drum
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_Mic
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_SFX
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_Instruments
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_Vocals
			fade_time = 0.3
			fade_type = linear}
		spawnscriptnow \{No_Dolby_Digital_Sounds}
	elseif GotParam \{backgeneric}
		generic_menu_pad_back_sound
	elseif GotParam \{choose}
		StopSound \{Audio_Options_Guitar
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_Bass
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_Drum
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_Mic
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_SFX
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_Instruments
			fade_time = 0.3
			fade_type = linear}
		StopSound \{Audio_Options_Vocals
			fade_time = 0.3
			fade_type = linear}
		SoundEvent \{event = Sound_Options_Select}
		spawnscriptnow \{No_Dolby_Digital_Sounds}
	endif
endscript

script ChangeSpinalTapVolume \{spinal_tap_volume_max = 11}
	<spinal_tap_volume> = (<spinal_tap_volume> + <change>)
	if (<spinal_tap_volume> < 0)
		<spinal_tap_volume> = 0
	elseif (<spinal_tap_volume> > <spinal_tap_volume_max>)
		<spinal_tap_volume> = <spinal_tap_volume_max>
	endif
	return volume = <spinal_tap_volume>
endscript

script ui_options_audio_get_buss_volume 
	switch <volume>
		case 11
		<vol> = -1.5
		case 10
		<vol> = -2.0
		case 9
		<vol> = -2.5
		case 8
		<vol> = -3.0
		case 7
		<vol> = -3.5
		case 6
		<vol> = -4.5
		case 5
		<vol> = -5.75
		case 4
		<vol> = -7.0
		case 3
		<vol> = -8.25
		case 2
		<vol> = -9.5
		case 1
		<vol> = -10.75
		case 0
		<vol> = -12.0
		default
		<vol> = -3.5
	endswitch
	return vol = <vol>
endscript

script ui_options_audio_update_all_volumes \{time = 0}
	AudioInterface :GetTags
	update_all_volumes <...>
endscript

script update_all_volumes \{time = 0
		player = 1}
	GetPlayerInfo <player> checksum
	get_savegame_from_player_status player_status = <checksum>
	GetGlobalTags user_options savegame = <savegame>
	ui_options_audio_get_buss_volume volume = (<volumes>.guitar.guitar.vol)
	SoundBussUnlock \{User_LeadGTR}
	SoundBussUnlock \{User_RhythmGTR}
	SetSoundBussParams {User_RhythmGTR = {vol = <vol>} time = <time>}
	SetSoundBussParams {User_LeadGTR = {vol = <vol>} time = <time>}
	SoundBussLock \{User_LeadGTR}
	SoundBussLock \{User_RhythmGTR}
	ui_options_audio_get_buss_volume volume = (<volumes>.guitar.Bass.vol)
	SoundBussUnlock \{User_Bass}
	SetSoundBussParams {User_Bass = {vol = <vol>} time = <time>}
	SoundBussLock \{User_Bass}
	ui_options_audio_get_buss_volume volume = (<volumes>.guitar.drum.vol)
	SoundBussUnlock \{User_Drums}
	SetSoundBussParams {User_Drums = {vol = <vol>} time = <time>}
	SoundBussLock \{User_Drums}
	ui_options_audio_get_buss_volume volume = (<volumes>.guitar.mic.vol)
	ui_options_audio_update_mic_volume player = <player>
	SoundBussUnlock \{User_LeadVox}
	SetSoundBussParams {Options_Vox = {vol = <vol>} time = <time>}
	SoundBussLock \{User_LeadVox}
	ui_options_audio_get_buss_volume volume = (<volumes>.guitar.Band.vol)
	SoundBussUnlock \{User_Band}
	SetSoundBussParams {User_Band = {vol = <vol>} time = <time>}
	SoundBussLock \{User_Band}
	ui_options_audio_get_buss_volume volume = (<volumes>.guitar.sfx.vol)
	SoundBussUnlock \{User_Sfx}
	SetSoundBussParams {User_Sfx = {vol = <vol>} time = <time>}
	SoundBussLock \{User_Sfx}
	ui_options_audio_get_buss_volume volume = (<volumes>.guitar.backup.vol)
endscript

script ui_options_audio_update_mic_volume \{player = 1}
	if PlayerInfoEquals <player> is_local_client = 0
		return
	endif
	if is_mic_volume_shared
		<share_mic_settings> = 1
	else
		<share_mic_settings> = 0
	endif
	if (<share_mic_settings> = 1)
		GetGlobalTags \{user_options}
	else
		GetPlayerInfo <player> checksum
		get_savegame_from_player_status player_status = <checksum>
		GetGlobalTags savegame = <savegame> user_options
	endif
	micvolume = (<volumes>.guitar.mic.vol)
	if (<share_mic_settings> = 1)
		GameMode_GetNumPlayersShown
		<player> = 1
		begin
		mic_set_device_volume player = <player> micvolume = <micvolume>
		<player> = (<player> + 1)
		repeat <num_players_shown>
	else
		mic_set_device_volume player = <player> micvolume = <micvolume>
	endif
endscript

script mic_set_device_volume 

	if PlayerInfoEquals <player> bot_play = 1
		return
	endif
	GetInputHandlerBotIndex player = <player>
	<bot_controller> = <controller>
	GetPlayerInfo <player> controller
	if (<bot_controller> = <controller>)
		return
	endif
	if PlayerInfoEquals <player> is_local_client = 0
		return
	endif
	if NOT PlayerInfoEquals <player> part = Vocals
		return
	endif
	if IsPs3
		switch <micvolume>
			case 11
			<micgain> = 0.0
			<micthreshold> = -10
			<gainmakeup> = 6
			case 10
			<micgain> = 0.0
			<micthreshold> = -12
			<gainmakeup> = 6
			case 9
			<micgain> = 0.0
			<micthreshold> = -12
			<gainmakeup> = 4
			case 8
			<micgain> = 0.0
			<micthreshold> = -13
			<gainmakeup> = 4
			case 7
			<micgain> = 0.0
			<micthreshold> = -14
			<gainmakeup> = 3
			case 6
			<micgain> = 0.0
			<micthreshold> = -15
			<gainmakeup> = 1
			case 5
			<micgain> = 0.0
			<micthreshold> = -16
			<gainmakeup> = 1
			case 4
			<micgain> = 0.0
			<micthreshold> = -18
			<gainmakeup> = 1
			case 3
			<micgain> = 0.0
			<micthreshold> = -19
			<gainmakeup> = 0
			case 2
			<micgain> = 0.0
			<micthreshold> = -20
			<gainmakeup> = 0
			case 1
			<micgain> = 0.0
			<micthreshold> = -22
			<gainmakeup> = 0
			case 0
			<micgain> = 0.0
			<micthreshold> = -24
			<gainmakeup> = 0
			default
			<micgain> = 0.0
			<micthreshold> = -14
			<gainmakeup> = 3
		endswitch
	else
		switch <micvolume>
			case 11
			<micgain> = 0.0
			<micthreshold> = -12
			<gainmakeup> = 5
			case 10
			<micgain> = 0.0
			<micthreshold> = -13
			<gainmakeup> = 5
			case 9
			<micgain> = 0.0
			<micthreshold> = -14
			<gainmakeup> = 5
			case 8
			<micgain> = 0.0
			<micthreshold> = -14
			<gainmakeup> = 4.5
			case 7
			<micgain> = 0.0
			<micthreshold> = -15
			<gainmakeup> = 4
			case 6
			<micgain> = 0.0
			<micthreshold> = -17
			<gainmakeup> = 4
			case 5
			<micgain> = 0.0
			<micthreshold> = -18
			<gainmakeup> = 3
			case 4
			<micgain> = 0.0
			<micthreshold> = -19
			<gainmakeup> = 2
			case 3
			<micgain> = 0.0
			<micthreshold> = -20
			<gainmakeup> = 1
			case 2
			<micgain> = 0.0
			<micthreshold> = -23
			<gainmakeup> = 0
			case 1
			<micgain> = 0.0
			<micthreshold> = -26
			<gainmakeup> = 0
			case 0
			<micgain> = 0.0
			<micthreshold> = -30
			<gainmakeup> = 0
			default
			<micgain> = 0.0
			<micthreshold> = -15
			<gainmakeup> = 4
		endswitch
	endif
	Vocals_SetMicGain player = <player> gain = <micvolume>
endscript

script ui_options_audio_set_default_volume_lights 

	num_mixer_light_children = ((11 * 2) - 1)
	if ScreenElementExists \{id = AudioInterface}
		if AudioInterface :Desc_ResolveAlias \{name = alias_faders_container
				param = fader_menu_id}
			GetScreenElementChildren id = <fader_menu_id>
			fader_children = <children>
			GetArraySize <fader_children>
			faders_size = <array_size>
			GetArraySize <default_volumes>
			default_volumes_size = <array_size>
			if (<faders_size> != <default_volumes_size>)

			endif
			if (<faders_size> > 0)
				i = 0
				begin
				if (<fader_children> [<i>]) :Desc_ResolveAlias name = alias_lights param = lights_id
					child_pos_to_retrieve = (<num_mixer_light_children> - ((<default_volumes> [<i>]) * 2))
					GetScreenElementChildren id = <lights_id>
					GetArraySize <children>
					if (<array_size> > 0)
						GetScreenElementPosition id = (<children> [<child_pos_to_retrieve>]) local
						FormatText checksumname = lights_alpha 'lights_ON_%a_alpha' a = (<default_volumes> [<i>])
						AddParam structure_name = fader_light_alpha_struct name = <lights_alpha> value = 0
						x_pos = (<screenelementpos> [0])
						y_pos = (<screenelementpos> [1])
						CastToInteger \{x_pos}
						CastToInteger \{y_pos}
						(<fader_children> [<i>]) :SE_SetProps {
							amber_lights_ON_pos = (((1.0, 0.0) * <x_pos>) + ((0.0, 1.0) * <y_pos>))
							amber_lights_OFF_pos = (((1.0, 0.0) * <x_pos>) + ((0.0, 1.0) * <y_pos>))
							<fader_light_alpha_struct>
						}
					endif
				endif
				<i> = (<i> + 1)
				repeat <faders_size>
			endif
		endif
	endif
endscript

script ui_options_audio_set_dolby_digital 
	GetGlobalTags \{user_options}
	if (<dolby_digital> = 0)
		DisableDolbyDigital
	else
		EnableDolbyDigital
	endif
endscript

script ui_options_audio_add_helpers 
	clean_up_user_control_helpers
	menu_finish
	add_user_control_helper \{text = qs("RESET")
		button = Blue
		z = 100000}
	add_user_control_helper \{text = qs(0xb1818a4d)
		button = Yellow
		z = 100000}
endscript
