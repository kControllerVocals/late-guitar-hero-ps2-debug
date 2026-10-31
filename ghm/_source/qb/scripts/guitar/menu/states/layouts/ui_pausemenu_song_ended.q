
script ui_create_pausemenu_song_ended 
	kill_intro_celeb_ui
	create_song_ended_menu
endscript

script ui_destroy_pausemenu_song_ended 
	change menu_flow_locked = ($menu_flow_locked + 1)
	destroy_song_ended_menu
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript
