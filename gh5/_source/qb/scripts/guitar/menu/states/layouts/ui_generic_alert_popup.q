
script ui_create_generic_alert_popup pad_choose_script = generic_event_back player_device = ($primary_controller)
	change menu_flow_locked = ($menu_flow_locked + 1)

	create_dialog_box {
		heading_text = <title>
		body_text = <text>
		options = [
			{
				func = <pad_choose_script>
				func_params = <pad_choose_params>
				text = qs(0x494b4d7f)
			}
		]
	}
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript

script ui_destroy_generic_alert_popup 
	change menu_flow_locked = ($menu_flow_locked + 1)
	destroy_dialog_box
	change menu_flow_locked = ($menu_flow_locked - 1)
endscript
