
script ui_create_play_tutorial 
	run_training_script
endscript

script ui_destroy_play_tutorial 
	change \{ps2_training_gem_scroller_paused = 0}
	if IsPakLoaded \{'pak/oogame/oogame.pak'
			heap = heap_cas}
		UnloadPak \{'pak/oogame/oogame.pak'
			heap = heap_cas}
	elseif IsPakLoaded \{'pak/oogame/oogamebattle.pak'
			heap = heap_cas}
		UnloadPak \{'pak/oogame/oogamebattle.pak'
			heap = heap_cas}
	elseif IsPakLoaded \{'pak/oogame/oogameband.pak'
			heap = heap_cas}
		UnloadPak \{'pak/oogame/oogameband.pak'
			heap = heap_cas}
	elseif IsPakLoaded \{'pak/oogame/oogamevs.pak'
			heap = heap_cas}
		UnloadPak \{'pak/oogame/oogamevs.pak'
			heap = heap_cas}
	endif
	startrendering
endscript

script ui_play_tutorial_anim_out 
	tutorial_shutdown
endscript

script ui_return_play_tutorial 
	if ScreenElementExists \{id = menu_tutorial}
		LaunchEvent \{type = focus
			target = menu_tutorial}
	else
		create_training_pause_handler
	endif
endscript
ui_create_play_tutorial_advanced_techniques = $ui_create_play_tutorial
ui_destroy_play_tutorial_advanced_techniques = $ui_destroy_play_tutorial
ui_create_play_tutorial_band = $ui_create_play_tutorial
ui_destroy_play_tutorial_band = $ui_destroy_play_tutorial
ui_create_play_tutorial_basic = $ui_create_play_tutorial
ui_destroy_play_tutorial_basic = $ui_destroy_play_tutorial
ui_create_play_tutorial_drum_basic = $ui_create_play_tutorial
ui_destroy_play_tutorial_drum_basic = $ui_destroy_play_tutorial
ui_create_play_tutorial_drum_int = $ui_create_play_tutorial
ui_destroy_play_tutorial_drum_int = $ui_destroy_play_tutorial
ui_create_play_tutorial_new_features = $ui_create_play_tutorial
ui_destroy_play_tutorial_new_features = $ui_destroy_play_tutorial
ui_create_play_tutorial_star_power = $ui_create_play_tutorial
ui_destroy_play_tutorial_star_power = $ui_destroy_play_tutorial
ui_create_play_tutorial_versus = $ui_create_play_tutorial
ui_destroy_play_tutorial_versus = $ui_destroy_play_tutorial
ui_create_play_tutorial_vocals = $ui_create_play_tutorial
ui_destroy_play_tutorial_vocals = $ui_destroy_play_tutorial
