
script ui_init_band_difficulty 
endscript

script ui_create_band_difficulty 
	spawnscriptnow \{ui_create_band_difficulty_spawned}
endscript

script ui_create_band_difficulty_spawned 
	qi_initialize \{mode = band_difficulty}
endscript

script ui_destroy_band_difficulty 
	qi_destroy
endscript

script ui_deinit_band_difficulty 
endscript

script ui_band_instrument_check_controllers 
	debug_ScriptAssert \{qs(0xddd8011e)}
endscript

script ui_band_difficulty_continue 
	debug_ScriptAssert \{qs(0xddd8011e)}
endscript

script ui_band_difficulty_delay_input 
	debug_ScriptAssert \{qs(0xddd8011e)}
endscript
