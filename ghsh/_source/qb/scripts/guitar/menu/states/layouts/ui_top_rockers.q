
script 0x95fb172c 
	change menu_flow_locked = ($menu_flow_locked + 1)
	if songispreviewplaying
		songstoppreview
	endif
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_create_top_rockers 
	change menu_flow_locked = ($menu_flow_locked + 1)
	create_top_rockers_menu <...>
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_top_rockers 
	destroy_top_rockers_menu
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript
