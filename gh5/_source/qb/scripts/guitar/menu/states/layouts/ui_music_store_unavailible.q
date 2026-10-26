
script ui_create_music_store_unavailible \{text = qs("\L")
		back_to_state = UIstate_downloads}
	LaunchEvent \{type = unfocus
		target = current_menu}
	destroy_popup_warning_menu
	create_popup_warning_menu {
		title = <title>
		textblock = {
			text = <text>
		}
		options = [
			{
				func = {music_store_unavailable_return_out}
				func_params = {back_to_state = <back_to_state>}
				text = qs("CONTINUE")
			}
		]
	}
endscript

script ui_destroy_music_store_unavailible 
	destroy_popup_warning_menu
endscript

script music_store_unavailable_return_out 
	destroy_popup_warning_menu
	Wait \{3
		gameframes}
	generic_event_back state = <back_to_state>
endscript

script ui_deinit_music_store_unavailible 
endscript
