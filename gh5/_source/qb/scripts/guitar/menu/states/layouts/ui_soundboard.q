soundboard_array = [
	{
		text = qs("Hello!")
		event = VO_SB_hello
		button_1 = green
		button_2 = green
	}
	{
		text = qs("Hey!")
		event = VO_SB_hey
		button_1 = green
		button_2 = red
	}
	{
		text = qs("I got a question...")
		event = VO_SB_question
		button_1 = green
		button_2 = Yellow
	}
	{
		text = qs("Do you have the album...?")
		event = VO_SB_killemall
		button_1 = green
		button_2 = Blue
	}
	{
		text = qs("Are you feeling good?")
		event = VO_SB_feelinggood
		button_1 = red
		button_2 = green
	}
	{
		text = qs("Are you having fun today?")
		event = VO_SB_havingfun
		button_1 = red
		button_2 = red
	}
	{
		text = qs("Do you feel it?")
		event = VO_SB_youfeelit
		button_1 = red
		button_2 = Yellow
	}
	{
		text = qs("Are you out there?")
		event = VO_SB_outthere
		button_1 = red
		button_2 = Blue
	}
	{
		text = qs("You want more?")
		event = VO_SB_wantmore
		button_1 = Yellow
		button_2 = green
	}
	{
		text = qs("What'd you say?")
		event = VO_SB_whatdyousay
		button_1 = Yellow
		button_2 = red
	}
	{
		text = qs("Are you sure?")
		event = VO_SB_areyousure
		button_1 = Yellow
		button_2 = Yellow
	}
	{
		text = qs("Oh yeah?")
		event = VO_SB_ohyeah
		button_1 = Yellow
		button_2 = Blue
	}
	{
		text = qs("That's good to hear.")
		event = VO_SB_goodtohear
		button_1 = Blue
		button_2 = green
	}
	{
		text = qs("That's right.")
		event = VO_SB_thatsright
		button_1 = Blue
		button_2 = red
	}
	{
		text = qs("Yeah.")
		event = VO_SB_yeah
		button_1 = Blue
		button_2 = Yellow
	}
	{
		text = qs("No.")
		event = VO_SB_no
		button_1 = Blue
		button_2 = Blue
	}
]

script ui_create_soundboard 
	Menu_Music_Off
	ReloadSfx \{mode = soundboard}
	<pad_green> = pad_green
	<pad_red> = pad_red
	<pad_blue> = pad_blue
	<pad_yellow> = pad_yellow
	if IsPs3
		if IsDrumController \{controller = $primary_controller}
			<pad_blue> = pad_btn_top
			<pad_yellow> = pad_btn_left
		endif
	endif
	CreateScreenElement {
		type = DescInterface
		desc = 'james_soundboard'
		id = current_menu_anchor
		parent = root_window
		event_handlers = [
			{pad_start generic_event_back}
			{<pad_green> ui_soundboard_button params = {button = green}}
			{<pad_red> ui_soundboard_button params = {button = red}}
			{<pad_yellow> ui_soundboard_button params = {button = Yellow}}
			{<pad_blue> ui_soundboard_button params = {button = Blue}}
		]
		exclusive_device = ($primary_controller)
		tags = {
			button_1 = none
			button_2 = none
		}
	}
	GetArraySize \{$soundboard_array}
	soundboard_size = <array_size>
	if current_menu_anchor :Desc_ResolveAlias \{name = alias_entries}
		GetScreenElementChildren id = <resolved_id>
		current_menu_anchor :SetTags entries = <children>
		i = 0
		begin
		curr_item = (<children> [<i>])
		if (<i> >= <soundboard_size>)
			<curr_item> :SE_SetProps {
				one_btn_alpha = 0.0
				two_btn_alpha = 0.0
			}
		else
			switch ($soundboard_array [<i>].button_1)
				case green
				btn_01_texture = sb_btn_green
				case red
				btn_01_texture = sb_btn_red
				case Yellow
				btn_01_texture = sb_btn_yellow
				case Blue
				btn_01_texture = sb_btn_blue
			endswitch
			switch ($soundboard_array [<i>].button_2)
				case green
				btn_02_texture = sb_btn_green
				case red
				btn_02_texture = sb_btn_red
				case Yellow
				btn_02_texture = sb_btn_yellow
				case Blue
				btn_02_texture = sb_btn_blue
			endswitch
			<curr_item> :SE_SetProps {
				btn_01_texture = <btn_01_texture>
				btn_02_texture = <btn_02_texture>
				btn_01_alpha = 0.5
				btn_02_alpha = 0.5
				sound_text = ($soundboard_array [<i>].text)
			}
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	AssignAlias \{id = current_menu_anchor
		alias = current_menu}
	add_user_control_helper \{text = qs("BACK")
		button = start
		z = 100000}
endscript

script ui_destroy_soundboard 
	GetArraySize \{$soundboard_array}
	i = 0
	begin
	StopSoundEvent ($soundboard_array [<i>].event)
	i = (<i> + 1)
	repeat <array_size>
	generic_ui_destroy
	ReloadSfx \{mode = FrontEnd}
	menu_music_on
endscript

script ui_soundboard_button 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	GetTags
	GetArraySize \{$soundboard_array}
	if (<button_1> = none)
		SetTags button_1 = <button>
	else
		SetTags button_2 = <button>
	endif
	GetTags
	GetArraySize \{$soundboard_array}
	soundboard_size = <array_size>
	GetArraySize <entries>
	i = 0
	begin
	if (<i> >= <soundboard_size>)
		break
	endif
	curr_item = (<entries> [<i>])
	if (<button_1> = ($soundboard_array [<i>].button_1))
		<curr_item> :SE_SetProps btn_01_alpha = 1.0
		if (<button_2> = ($soundboard_array [<i>].button_2))
			<curr_item> :SE_SetProps btn_02_alpha = 1.0
			ui_soundboard_play_sound event = ($soundboard_array [<i>].event)
			should_wait = 1
			break
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	GetTags
	if NOT (<button_2> = none)
		SetTags \{button_1 = none}
		SetTags \{button_2 = none}
		i = 0
		begin
		if (<i> >= <soundboard_size>)
			break
		endif
		new_curr_item = (<entries> [<i>])
		if NOT (<new_curr_item> = <curr_item>)
			<new_curr_item> :SE_SetProps btn_01_alpha = 0.5
			<new_curr_item> :SE_SetProps btn_02_alpha = 0.5
		endif
		i = (<i> + 1)
		repeat <array_size>
		if GotParam \{should_wait}
			Wait \{1.0
				seconds}
		endif
		<curr_item> :SE_SetProps btn_01_alpha = 0.5
		<curr_item> :SE_SetProps btn_02_alpha = 0.5
	endif
endscript

script ui_soundboard_play_sound \{event = VO_SB_hello}
	StopSoundEvent <event>
	SoundEvent event = <event>
endscript
