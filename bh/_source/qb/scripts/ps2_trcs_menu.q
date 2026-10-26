ps2_trc_menu_font = text_a4

script get_string_ps2 \{message = unknown}
	format_string = qs("\L")
	switch <message>
		case loading
		format_string = qs(0xb5fd5f50)
		case Saving
		format_string = qs(0x7b9d1538)
		case autosaving
		format_string = qs(0xdf8b877a)
		case overwriting
		format_string = qs(0xc8bf9bfa)
		case formatting
		format_string = qs(0x5686c523)
		case deleting
		format_string = qs(0x0f8ea30e)
		case load_successful
		format_string = qs(0x627e3b93)
		case format_successful
		format_string = qs(0x699ece64)
		case save_successful
		format_string = qs(0x6dd9a39e)
		case overwrite_successful
		format_string = qs(0xe2a6d737)
		case delete_successful
		format_string = qs(0xf06f3a47)
		case boot_autosave_warning
		format_string = qs(0xff3234d8)
		case check_memcard
		format_string = qs(0x6c51be44)
		case no_memcard_boot
		format_string = qs(0xf11e2539)
		case no_memcard
		format_string = qs(0xf9539a91)
		case no_save_boot
		format_string = qs(0x066746d2)
		case no_save_ingame
		format_string = qs(0x5de0d43d)
		case save_failed
		format_string = qs(0x063f5a8c)
		case overwrite_failed
		format_string = qs(0x7a5d2f1c)
		case attempt_format
		format_string = qs(0xd4999f10)
		case confirm_format
		format_string = qs(0x8a8542b6)
		case format_failed
		format_string = qs(0x3a004164)
		case is_formatted
		format_string = qs(0xe69da4f9)
		case new_memcard_format_boot
		format_string = qs(0xfb49c678)
		case disable_autosave
		format_string = qs(0x932b0827)
		case insufficient_space_boot
		format_string = qs(0xdf08cdde)
		case insufficient_space_ingame
		format_string = qs(0x321594b1)
		case corrupt_boot
		format_string = qs(0x98573884)
		case corrupt_ingame
		format_string = qs(0xace08af7)
		case confirm_overwrite
		format_string = qs(0x709d9856)
		case new_memcard
		format_string = qs(0xe975d495)
		case new_memcard_boot
		format_string = qs(0xa7187842)
		case widescreen_string
		format_string = qs(0x16589c40)
		case progressivescan_string
		format_string = qs(0xaec6cab2)
		default

		format_string = qs("\L")
	endswitch
	if IsPAL
		memcard = qs(0xe34669f7)
		memcard_full = qs(0xe34669f7)
	else
		memcard = qs(0x722a39cd)
		memcard_full = qs(0x92f2cd71)
	endif
	slot_1 = qs(0x3a7c6072)
	memcard_2 = <memcard>
	game_name = qs("\LBand Hero")
	GetMemCardSpaceRequired \{Progress}
	FormatText TextName = progress_size qs(0x13866852) d = <SpaceRequired>
	FormatText TextName = localized_string <format_string> slot_1 = <slot_1> memcard = <memcard> memcard_2 = <memcard_2> memcard_full = <memcard_full> progress_size = <progress_size> game_name = <game_name>
	return localized_string = <localized_string>
endscript

script create_ps2_saveload_screen 

	if ($Menu_Music_On_Flag = 1)
		change \{restartMenuMusic = 1}
	endif
	Menu_Music_Off
	AddParams (<...>.$saveMode)

	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = ps2_trc_container
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	z = 4
	get_string_ps2 message = <message>
	text_params = {
		header = <header>
		message = <localized_string>
	}
	if NOT GotParam \{option1_text}
		create_dialog_box {
			heading_text = <header>
			body_text = <localized_string>
		}
	else
		create_dialog_box {
			heading_text = <header>
			body_text = <localized_string>
			options = [
				{
					func = {ui_flow_manager_respond_to_action params = {action = <option1_action>}}
					text = <option1_text>
				}
				{
					func = {ui_flow_manager_respond_to_action params = {action = <option2_action>}}
					text = <option2_text>
				}
			]
		}
	endif
endscript

script destroy_ps2_saveload_screen 
	clean_up_user_control_helpers
	destroy_pause_menu_frame
	destroy_menu \{menu_id = sd_warning_scroll}
	destroy_menu \{menu_id = ps2_trc_container}
	destroy_dialog_box
endscript

script refresh_ps2_trc_menu 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	if GotParam \{seconds_before_continue}
		Wait <seconds_before_continue> seconds
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = continue
			}}
	endif
endscript
