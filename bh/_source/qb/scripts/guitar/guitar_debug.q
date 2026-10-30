
script debug_gem_text 
	if (<pattern> && 65536)
		formattext textname = text qs(0x14db9cdc) t = <text> p = <prefix>
	else
		formattext textname = text qs(0xa0e44c32) t = <text> p = <prefix>
	endif
	if (<pattern> && 4096)
		formattext textname = text qs(0xfadeba75) t = <text>
	else
		formattext textname = text qs(0x79548c8f) t = <text>
	endif
	if (<pattern> && 256)
		formattext textname = text qs(0x192a63be) t = <text>
	else
		formattext textname = text qs(0x79548c8f) t = <text>
	endif
	if (<pattern> && 16)
		formattext textname = text qs(0xb01ca824) t = <text>
	else
		formattext textname = text qs(0x79548c8f) t = <text>
	endif
	if (<pattern> && 1)
		formattext textname = text qs(0x4e0b861f) t = <text>
	else
		formattext textname = text qs(0xcd911679) t = <text>
	endif
	return <...>
endscript

script debug_output 
	if ($output_log_file = 1)
		<showtime> = (<time> - ($check_time_early * 1000.0))
		formattext textname = text qs(0x6f973620) t = <showtime> c = ($<player_status>.controller)
		if (<ignore_time> >= 0)
			debug_gem_text text = <text> pattern = <ignore_strum> prefix = qs(0x10ec1370)
		else
			formattext textname = text qs(0xbf0b68d5) t = <text>
		endif
		getheldpattern controller = ($<player_status>.controller) player = ($<player_status>.player) nobrokenstring
		debug_gem_text text = <text> pattern = <strummed_pattern> prefix = qs(0xc7e758af)
		debug_gem_text text = <text> pattern = <original_strum> prefix = qs(0x859889df)
		debug_gem_text text = <text> pattern = <hold_pattern> prefix = qs(0x918eb2e5)
		if (<hit_strum> = 1)
			if (<fake_strum> = 1)
				formattext textname = text qs(0x5b352041) t = <text>
			else
				formattext textname = text qs(0xdc2df0df) t = <text>
			endif
		else
			if (<fake_strum> = 1)
				formattext textname = text qs(0xbbea5772) t = <text>
			else
				formattext textname = text qs(0x4578889e) t = <text>
			endif
		endif
		if (<strummed_before_forming> >= 0.0)
			formattext textname = text qs(0x41fac866) t = <text>
		else
			formattext textname = text qs(0xa5a7ffad) t = <text>
		endif
		if (<tapping> = 1)
			action_tap = qs(0x18c99bac)
		else
			action_tap = qs(0x92e2c9d5)
		endif
		get_input_debug_text <...>
		formattext textname = text qs(0x4793bf41) t = <text> h = <action_hit> m = <action_mis> u = <action_unn> l = <action_tol> i = <input_text> k = <action_tap>
		formattext textname = text qs(0xd30b02ca) t = <text> o = ($<player_status>.hammer_on_tolerance) n = <notes_open>
		getarraysize <strum_hits>
		if (<array_size> > 0)
			formattext textname = text qs(0x14f47ad7) t = <text>
			<index> = 0
			begin
			<strum> = (<strum_hits> [<index>])
			debug_gem_text text = <text> pattern = <strum> prefix = qs(0x03ac90f0)
			<index> = (<index> + 1)
			repeat <array_size>
			formattext textname = text qs(0x36151a48) t = <text>
		endif
		getarraysize <hammer_hits>
		if (<array_size> > 0)
			formattext textname = text qs(0x93ecaa49) t = <text>
			<index> = 0
			begin
			<strum> = (<hammer_hits> [<index>])
			debug_gem_text text = <text> pattern = <strum> prefix = qs(0x03ac90f0)
			<index> = (<index> + 1)
			repeat <array_size>
			formattext textname = text qs(0x36151a48) t = <text>
		endif
		if gotparam \{off_note}
			getglobaltags \{user_options}
			if gotparam \{lag_calibration}
				casttointeger \{lag_calibration}
				mod a = <lag_calibration> b = 1000
				<video_offset> = <mod>
				<audio_offset> = ((<lag_calibration> / 1000) - 1)
				<off_note> = (0 - (<off_note> - ($time_input_offset + <audio_offset> + <video_offset>)))
				casttointeger \{off_note}
			endif
			formattext textname = text qs(0x7fe80a6d) t = <text> o = <off_note>
		endif
		extendcrc log ($<player_status>.text) out = log_channel

	endif
endscript

script flexparticlewarning 
	setscreenelementlock \{id = root_window
		off}
	if objectexists \{id = particle_warn_anchor}
		destroyscreenelement \{id = particle_warn_anchor}
	endif
	createscreenelement \{type = containerelement
		parent = root_window
		id = particle_warn_anchor
		pos = (25.0, 80.0)
		just = [
			center
			center
		]
		internal_just = [
			left
			center
		]}
	createscreenelement \{type = textelement
		parent = particle_warn_anchor
		id = particle_warn_text
		pos = (0.0, 0.0)
		text = qs(0x475886ae)
		font = debug
		rgba = [
			255
			0
			0
			255
		]
		just = [
			left
			top
		]}
	setscreenelementlock \{id = root_window
		on}
	wait \{2
		seconds}
	if objectexists \{id = particle_warn_anchor}
		destroyscreenelement \{id = particle_warn_anchor}
	endif
endscript

script charge_star_power \{player = 1}
	<player_status> = ($0x2994109a [<player>])
	if (gamemode_isbandscoring)
		getbandindexbyplayer player = ($<player_status>.player)
		band_id = ($band_ids [<band_index>])
		change structurename = <band_id> star_power_amount = 100
	else
		change structurename = <player_status> star_power_amount = 100
	endif
endscript

script activate_star_power \{player = 1}
	<player_status> = ($0x2994109a [<player>])
	<player_text> = ($0x57e22f28 [<player>])
	star_power_activate_and_drain <...>
endscript

script wait_until_ingame \{player = 1}
	<player_status> = ($0x2994109a [<player>])
	begin
	if NOT (($<player_status>.playline_song_measure_time) = 0)
		break
	endif
	wait \{1
		gameframe
		ignoreslomo}
	repeat
endscript

script auto_infinite_star_power \{player = 1}
	wait_until_ingame player = <player>
	charge_star_power player = <player>
	spawnscriptnow activate_star_power params = {player = <player> infinite_drain}
	begin
	charge_star_power player = <player>
	wait \{1
		gameframe
		ignoreslomo}
	repeat
endscript

script auto_trigger_star_power \{player = 1}
	wait_until_ingame player = <player>
	<player_status> = ($0x2994109a [<player>])
	begin
	if (($<player_status>.star_power_amount) >= 50.0)
		activate_star_power player = <player>
	endif
	if (($band1_status.star_power_amount) >= 50.0)
		activate_star_power player = <player>
	endif
	wait \{1
		gameframe
		ignoreslomo}
	repeat
endscript

script auto_full_star_power \{player = 1}
	wait_until_ingame player = <player>
	<player_status> = ($0x2994109a [<player>])
	begin
	if (($<player_status>.star_power_used) = 0)
		charge_star_power player = <player>
	endif
	wait \{1
		gameframe
		ignoreslomo}
	repeat
endscript

script init_star_power_debug \{player = 1}
	<player_status> = ($0x2994109a [<player>])
	if (($<player_status>.star_power_debug_mode) = 1)
		spawnscriptnow auto_infinite_star_power params = {player = <player>}
	else
		if (($<player_status>.star_power_debug_mode) = 2)
			spawnscriptnow auto_trigger_star_power params = {player = <player>}
		else
			if (($<player_status>.star_power_debug_mode) = 3)
				spawnscriptnow auto_full_star_power params = {player = <player>}
			endif
		endif
	endif
endscript

script deinit_star_power_debug 
	killspawnedscript \{name = auto_infinite_star_power}
	killspawnedscript \{name = auto_trigger_star_power}
	killspawnedscript \{name = auto_full_star_power}
	killspawnedscript \{name = activate_star_power}
endscript

script update_rock_meter_debug_text 
	begin
	if screenelementexists id = <id>
		if ($current_num_players > 1)
			<player> = 1
			begin
			<player_status> = ($0x2994109a [<player>])
			<part> = qs(0xbc6d5b69)
			if (($<player_status>.part) = bass)
				<part> = qs(0x26fc5cd2)
			endif
			if (($<player_status>.part) = guitar)
				<part> = qs(0x5b8ba897)
			endif
			if (($<player_status>.part) = drum)
				<part> = qs(0x70a6fb54)
			endif
			if (($<player_status>.part) = vocals)
				<part> = qs(0x08528b87)
			endif
			formattext checksumname = rmdt 'rock_meter_debug_text%i' i = <player> addtostringlookup
			formattext textname = string qs(0x589fda4a) p = <part> v = ($<player_status>.current_health)
			setscreenelementprops id = <rmdt> text = <string>
			<player> = (<player> + 1)
			repeat $current_num_players
		endif
		formattext \{textname = text_string
			qs(0x0bc409e2)
			a = $current_crowd}
		setscreenelementprops id = <id> text = <text_string>
	endif
	wait \{1
		gameframe}
	repeat
endscript

script setlist_quit_song_menu_input 
	setscriptcannotpause
	<return_to_base_selection> = 0
	begin
	block \{type = setlist_created}
	wait RandomFloat (1.0, 2.0) seconds
	begin
	if screenelementexists \{id = setlist_menu}
		break
	endif
	wait \{1
		gameframes}
	repeat

	if (<return_to_base_selection> > 0)
		begin
		launchevent \{type = pad_up
			target = setlist_menu}
		wait RandomFloat (0.2, 0.6) seconds
		repeat <return_to_base_selection>
	endif
	<count> = RandomInteger (1.0, 8.0)
	<return_to_base_selection> = <count>
	begin
	launchevent \{type = pad_down
		target = setlist_menu}
	wait RandomFloat (0.2, 0.6) seconds
	repeat <count>
	setlist_menu :menu_getselectedindex
	launchevent type = pad_choose target = {setlist_menu child = <selected_index>}
	block \{type = song_started}
	wait RandomFloat (5.0, 60.0) seconds

	launchevent \{type = pad_start
		target = root_window}
	block \{type = pause_menu_created}
	wait RandomFloat (1.0, 2.0) seconds
	begin
	if screenelementexists \{id = current_menu}
		break
	endif
	wait \{1
		gameframes}
	repeat

	begin
	launchevent \{type = pad_down
		target = current_menu}
	wait \{0.3
		seconds}
	repeat 5
	current_menu :menu_getselectedindex
	launchevent type = pad_choose target = {current_menu child = <selected_index>}
	block \{type = popup_created}
	wait RandomFloat (1.0, 2.0) seconds
	begin
	if screenelementexists \{id = dialog_box_vmenu}
		break
	endif
	wait \{1
		gameframes}
	repeat

	launchevent \{type = pad_down
		target = dialog_box_vmenu}
	wait \{0.5
		seconds}
	dialog_box_vmenu :menu_getselectedindex
	launchevent type = pad_choose target = {dialog_box_vmenu child = <selected_index>}
	block \{type = popup_created}
	wait RandomFloat (1.0, 2.0) seconds
	begin
	if screenelementexists \{id = dialog_box_vmenu}
		break
	endif
	wait \{1
		gameframes}
	repeat

	launchevent \{type = pad_down
		target = dialog_box_vmenu}
	wait \{0.5
		seconds}
	dialog_box_vmenu :menu_getselectedindex
	launchevent type = pad_choose target = {dialog_box_vmenu child = <selected_index>}
	repeat
endscript
