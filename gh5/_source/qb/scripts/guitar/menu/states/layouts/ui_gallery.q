gallery_image_array = [
	gallery_01
	gallery_02
	gallery_03
	gallery_04
	gallery_05
	gallery_06
	gallery_07
	gallery_08
	gallery_09
	gallery_10
	gallery_11
	gallery_12
	gallery_13
	gallery_14
	gallery_15
	gallery_16
	gallery_17
	gallery_18
	gallery_19
	gallery_20
	gallery_21
	gallery_22
	gallery_23
	gallery_24
	gallery_25
	gallery_26
	gallery_27
	gallery_28
	gallery_29
	gallery_30
	gallery_31
	gallery_32
	gallery_33
	gallery_34
	gallery_35
	gallery_36
	gallery_37
	gallery_38
	gallery_39
	gallery_40
	gallery_41
	gallery_42
	gallery_43
	gallery_44
	gallery_45
	gallery_46
	gallery_47
	gallery_48
	gallery_49
	gallery_50
	gallery_51
	gallery_52
	gallery_53
	gallery_54
	gallery_55
	gallery_56
	gallery_57
	gallery_58
	gallery_59
	gallery_60
	gallery_61
	gallery_62
	gallery_63
	gallery_64
	gallery_65
	gallery_66
	gallery_67
	gallery_68
	gallery_69
	gallery_70
	gallery_71
	gallery_72
	gallery_73
	gallery_74
	gallery_75
	gallery_76
	gallery_77
	gallery_78
	gallery_79
	gallery_80
	gallery_81
	gallery_82
	gallery_83
	gallery_84
	gallery_85
	gallery_86
	gallery_87
	gallery_88
	gallery_89
	gallery_90
	gallery_91
	gallery_92
	gallery_93
	gallery_94
	gallery_95
	gallery_96
	gallery_97
	gallery_98
	gallery_99
	gallery_100
]
gallery_image_index = 0
gallery_swap_index = 0
gallery_current_pak_index = 0

script ui_create_gallery 
	spawnscriptnow ui_create_gallery_spawned params = {<...>}
endscript

script ui_create_gallery_spawned 
	stoprendering
	FormatText TextName = curr_pak 'pak/ui/gallery_%n.pak' n = ($gallery_current_pak_index)
	LoadPak <curr_pak> heap = BottomUpHeap
	startrendering
	CreateScreenElement {
		type = DescInterface
		desc = 'gallery'
		parent = root_window
		id = current_menu_anchor
		skeleton_left_pos = {relative (0.0, -50.0)}
		skeleton_right_pos = {relative (0.0, -50.0)}
		gallery_pho0_texture = ($gallery_image_array [($gallery_image_index)])
		exclusive_device = ($primary_controller)
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_up ui_gallery_switch params = {up}}
			{pad_down ui_gallery_switch params = {down}}
			{pad_back generic_event_back}
		]
		just = [center center]
	}
	<id> :SE_GetProps arrow_up_pos arrow_up_scale arrow_up_rgba
	<id> :SE_GetProps arrow_down_pos arrow_down_scale arrow_down_rgba
	<id> :SetTags {
		org_arrow_up_pos = <arrow_up_pos>
		org_arrow_up_scale = <arrow_up_scale>
		org_arrow_up_rgba = <arrow_up_rgba>
		org_arrow_down_pos = <arrow_down_pos>
		org_arrow_down_scale = <arrow_down_scale>
		org_arrow_down_rgba = <arrow_down_rgba>
	}
	<id> :SetTags {
		org_arrow_up_rgba = [30 , 30 , 30 , 255]
		org_arrow_down_rgba = [30 , 30 , 30 , 255]
	}
	change \{gallery_swap_index = 0}
	LaunchEvent \{type = focus
		target = current_menu_anchor}
	add_user_control_helper \{text = qs("BACK")
		button = red
		z = 100000}
	if NOT ScriptIsRunning \{song_extra_skull_a_anim}
		spawnscriptnow \{song_extra_skull_a_anim}
	endif
	if NOT ScriptIsRunning \{song_extra_skull_b_anim}
		spawnscriptnow \{song_extra_skull_b_anim}
	endif
endscript

script ui_destroy_gallery 
	if ScreenElementExists \{id = current_menu_anchor}
		DestroyScreenElement \{id = current_menu_anchor}
	endif
	clean_up_user_control_helpers
	if NOT GotParam \{keep_anims_alive}
		KillSpawnedScript \{name = song_extra_skull_a_anim}
		KillSpawnedScript \{name = song_extra_skull_b_anim}
	endif
	FormatText TextName = curr_pak 'pak/ui/gallery_%n.pak' n = ($gallery_current_pak_index)
	if IsPakLoaded <curr_pak> heap = BottomUpHeap
		UnloadPak <curr_pak> heap = BottomUpHeap
	endif
endscript

script ui_gallery_switch 
	GetArraySize ($gallery_image_array)
	if GotParam \{up}
		change gallery_swap_index = (1 - $gallery_swap_index)
		change gallery_image_index = ($gallery_image_index - 1)
		if ($gallery_image_index < 0)
			change gallery_image_index = (<array_size> - 1)
		endif
		current_menu_anchor :Obj_SpawnScriptNow \{gallery_pulse_up_arrow}
	elseif GotParam \{down}
		change gallery_swap_index = (1 - $gallery_swap_index)
		change gallery_image_index = ($gallery_image_index + 1)
		if ($gallery_image_index >= <array_size>)
			change \{gallery_image_index = 0}
		endif
		current_menu_anchor :Obj_SpawnScriptNow \{gallery_pulse_down_arrow}
	endif
	spawnscriptnow \{ui_gallery_update_pak}
	if ($gallery_swap_index = 0)
		SE_SetProps gallery_pho0_texture = (($gallery_image_array) [($gallery_image_index)])
		SE_SetProps \{gallery_pho0_alpha = 1
			time = 0.1}
		SE_SetProps \{gallery_pho1_alpha = 0
			time = 0.1}
	else
		SE_SetProps gallery_pho1_texture = (($gallery_image_array) [($gallery_image_index)])
		SE_SetProps \{gallery_pho1_alpha = 1
			time = 0.1}
		SE_SetProps \{gallery_pho0_alpha = 0
			time = 0.1}
	endif
endscript

script gallery_pulse_up_arrow 
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	GetTags
	SE_SetProps arrow_up_pos = <org_arrow_up_pos> arrow_up_scale = <org_arrow_up_scale> arrow_up_rgba = <org_arrow_up_rgba>
	SE_SetProps \{arrow_up_pos = {
			relative
			(0.0, -15.0)
		}
		time = 0.1}
	SE_SetProps \{arrow_up_scale = (1.2, 1.2)
		time = 0.1}
	SE_SetProps \{arrow_up_rgba = [
			200
			50
			50
			255
		]
		time = 0.1}
	Wait \{0.1
		seconds}
	SE_SetProps arrow_up_pos = <org_arrow_up_pos> arrow_up_scale = <org_arrow_up_scale> arrow_up_rgba = <org_arrow_up_rgba> time = 0.1
	Wait \{0.1
		seconds}
endscript

script gallery_pulse_down_arrow 
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	GetTags
	SE_SetProps arrow_down_pos = <org_arrow_down_pos> arrow_down_scale = <org_arrow_down_scale> arrow_down_rgba = <org_arrow_down_rgba>
	SE_SetProps \{arrow_down_pos = {
			relative
			(0.0, 15.0)
		}
		time = 0.1}
	SE_SetProps \{arrow_down_scale = (1.2, 1.2)
		time = 0.1}
	SE_SetProps \{arrow_down_rgba = [
			200
			50
			50
			255
		]
		time = 0.1}
	Wait \{0.1
		seconds}
	SE_SetProps arrow_down_pos = <org_arrow_down_pos> arrow_down_scale = <org_arrow_down_scale> arrow_down_rgba = <org_arrow_down_rgba> time = 0.1
	Wait \{0.1
		seconds}
endscript

script ui_gallery_update_pak 
	SetScriptCannotPause
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	<next_pak_index> = ($gallery_image_index / 10)
	if (<next_pak_index> != $gallery_current_pak_index)
		FormatText TextName = curr_pak 'pak/ui/gallery_%n.pak' n = ($gallery_current_pak_index)
		change gallery_current_pak_index = <next_pak_index>
		stoprendering
		PauseSpawnedScripts
		ui_destroy_gallery \{keep_anims_alive = 1}
		if IsPakLoaded <curr_pak> heap = BottomUpHeap
			UnloadPak <curr_pak> heap = BottomUpHeap
		endif
		ui_create_gallery
		UnpauseSpawnedScripts
		startrendering
	endif
endscript

script ui_gallery_anim_in 
	menu_transition_in \{menu = current_menu_anchor}
endscript

script ui_gallery_anim_out 
	menu_transition_out \{menu = current_menu_anchor}
endscript
