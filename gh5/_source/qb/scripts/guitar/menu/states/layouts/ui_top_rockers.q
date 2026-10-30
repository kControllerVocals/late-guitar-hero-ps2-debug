
script 0x95fb172c 
	change menu_flow_locked = ($menu_flow_locked + 1)
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_create_top_rockers 
	change menu_flow_locked = ($menu_flow_locked + 1)
	create_top_rockers_menu <...>
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_top_rockers 
	change menu_flow_locked = ($menu_flow_locked + 1)
	if gotparam \{for_options}
		if (<for_options> = 1)
			if NOT gotparam \{0xf768bc05}
				create_loading_screen \{spawn}
			endif
		endif
	endif
	destroy_top_rockers_menu
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript
