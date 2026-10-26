
script ui_init_character_hub 
endscript

script ui_create_character_hub 
	spawnscriptnow \{qi_initialize
		params = {
			mode = character_hub
		}}
endscript

script ui_destroy_character_hub 
	qi_destroy
endscript

script ui_deinit_character_hub 
endscript

script ui_create_character_hub_spawned 
	debug_ScriptAssert \{qs(0x98ff84b9)}
endscript

script ui_character_hub_continue 
	debug_ScriptAssert \{qs(0x98ff84b9)}
endscript
