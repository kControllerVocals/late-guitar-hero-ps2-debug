
script debug_gem_text 
	if (<pattern> && 65536)
		FormatText TextName = text qs("\L%t%pG") t = <text> p = <prefix>
	else
		FormatText TextName = text qs("\L%t%p.") t = <text> p = <prefix>
	endif
	if (<pattern> && 4096)
		FormatText TextName = text qs("\L%tR") t = <text>
	else
		FormatText TextName = text qs("\L%t.") t = <text>
	endif
	if (<pattern> && 256)
		FormatText TextName = text qs("\L%tY") t = <text>
	else
		FormatText TextName = text qs("\L%t.") t = <text>
	endif
	if (<pattern> && 16)
		FormatText TextName = text qs("\L%tB") t = <text>
	else
		FormatText TextName = text qs("\L%t.") t = <text>
	endif
	if (<pattern> && 1)
		FormatText TextName = text qs("\L%tO ") t = <text>
	else
		FormatText TextName = text qs("\L%t. ") t = <text>
	endif
	return <...>
endscript

script debug_output 
	if ($output_log_file = 1)
		<showtime> = (<time> - ($check_time_early * 1000.0))
		FormatText TextName = text qs("\L%t: (%c)") t = <showtime> c = ($<player_status>.controller)
		if (<ignore_time> >= 0)
			debug_gem_text text = <text> pattern = <ignore_strum> prefix = qs("\LIg: ")
		else
			FormatText TextName = text qs("\L%tIg: ..... ") t = <text>
		endif
		GetHeldPattern controller = ($<player_status>.controller) player = ($<player_status>.player) nobrokenstring
		debug_gem_text text = <text> pattern = <strummed_pattern> prefix = qs("\LLS: ")
		debug_gem_text text = <text> pattern = <original_strum> prefix = qs("\LOr: ")
		debug_gem_text text = <text> pattern = <hold_pattern> prefix = qs("\LHe: ")
		if (<hit_strum> = 1)
			if (<fake_strum> = 1)
				FormatText TextName = text qs("\L%t H ") t = <text>
			else
				FormatText TextName = text qs("\L%t S ") t = <text>
			endif
		else
			if (<fake_strum> = 1)
				FormatText TextName = text qs("\L%t F ") t = <text>
			else
				FormatText TextName = text qs("\L%t . ") t = <text>
			endif
		endif
		if (<strummed_before_forming> >= 0.0)
			FormatText TextName = text qs("\L%t T ") t = <text>
		else
			FormatText TextName = text qs("\L%t   ") t = <text>
		endif
		if (<tapping> = 1)
			action_tap = qs(" TAP ")
		else
			action_tap = qs("\L     ")
		endif
		get_input_debug_text <...>
		FormatText TextName = text qs("\L%t%h%m%u%l%k%i") t = <text> h = <action_hit> m = <action_mis> u = <action_unn> l = <action_tol> i = <input_text> k = <action_tap>
		FormatText TextName = text qs("\L%t :%o: %n") t = <text> o = ($<player_status>.hammer_on_tolerance) n = <notes_open>
		GetArraySize <strum_hits>
		if (<array_size> > 0)
			FormatText TextName = text qs("\L%t S(") t = <text>
			<index> = 0
			begin
			<strum> = (<strum_hits> [<index>])
			debug_gem_text text = <text> pattern = <strum> prefix = qs("\L")
			<index> = (<index> + 1)
			repeat <array_size>
			FormatText TextName = text qs("\L%t)") t = <text>
		endif
		GetArraySize <hammer_hits>
		if (<array_size> > 0)
			FormatText TextName = text qs("\L%t H(") t = <text>
			<index> = 0
			begin
			<strum> = (<hammer_hits> [<index>])
			debug_gem_text text = <text> pattern = <strum> prefix = qs("\L")
			<index> = (<index> + 1)
			repeat <array_size>
			FormatText TextName = text qs("\L%t)") t = <text>
		endif
		if GotParam \{off_note}
			GetGlobalTags \{user_options}
			if GotParam \{lag_calibration}
				CastToInteger \{lag_calibration}
				Mod a = <lag_calibration> b = 1000
				<video_offset> = <Mod>
				<audio_offset> = ((<lag_calibration> / 1000) - 1)
				<off_note> = (0 - (<off_note> - ($time_input_offset + <audio_offset> + <video_offset>)))
				CastToInteger \{off_note}
			endif
			FormatText TextName = text qs("\L%t (%oms)") t = <text> o = <off_note>
		endif
		ExtendCRC log ($<player_status>.text) out = log_channel

	endif
endscript

script FlexParticleWarning 
	SetScreenElementLock \{id = root_window
		off}
	if ObjectExists \{id = particle_warn_anchor}
		DestroyScreenElement \{id = particle_warn_anchor}
	endif
	CreateScreenElement \{type = ContainerElement
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
	CreateScreenElement \{type = TextElement
		parent = particle_warn_anchor
		id = particle_warn_text
		pos = (0.0, 0.0)
		text = qs("\LParticle failed: Too many at once")
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
	SetScreenElementLock \{id = root_window
		on}
	Wait \{2
		seconds}
	if ObjectExists \{id = particle_warn_anchor}
		DestroyScreenElement \{id = particle_warn_anchor}
	endif
endscript

script charge_star_power \{player = 1}
	<player_status> = ($player_status_array [<player>])
	if (GameMode_IsBandScoring)
		GetBandIndexByPlayer player = ($<player_status>.player)
		band_id = ($band_ids [<band_index>])
		change structurename = <band_id> star_power_amount = 100
	else
		change structurename = <player_status> star_power_amount = 100
	endif
endscript

script activate_star_power \{player = 1}
	<player_status> = ($player_status_array [<player>])
	<player_text> = ($player_text_array [<player>])
	star_power_activate_and_drain <...>
endscript

script wait_until_ingame \{player = 1}
	<player_status> = ($player_status_array [<player>])
	begin
	if NOT (($<player_status>.playline_song_measure_time) = 0)
		break
	endif
	Wait \{1
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
	Wait \{1
		gameframe
		ignoreslomo}
	repeat
endscript

script auto_trigger_star_power \{player = 1}
	wait_until_ingame player = <player>
	<player_status> = ($player_status_array [<player>])
	begin
	if (($<player_status>.star_power_amount) >= 50.0)
		activate_star_power player = <player>
	endif
	if (($band1_status.star_power_amount) >= 50.0)
		activate_star_power player = <player>
	endif
	Wait \{1
		gameframe
		ignoreslomo}
	repeat
endscript

script auto_full_star_power \{player = 1}
	wait_until_ingame player = <player>
	<player_status> = ($player_status_array [<player>])
	begin
	if (($<player_status>.star_power_used) = 0)
		charge_star_power player = <player>
	endif
	Wait \{1
		gameframe
		ignoreslomo}
	repeat
endscript

script init_star_power_debug \{player = 1}
	<player_status> = ($player_status_array [<player>])
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
	KillSpawnedScript \{name = auto_infinite_star_power}
	KillSpawnedScript \{name = auto_trigger_star_power}
	KillSpawnedScript \{name = auto_full_star_power}
	KillSpawnedScript \{name = activate_star_power}
endscript

script update_rock_meter_debug_text 
	begin
	if ScreenElementExists id = <id>
		if ($current_num_players > 1)
			<player> = 1
			begin
			<player_status> = ($player_status_array [<player>])
			<part> = qs("\L?")
			if (($<player_status>.part) = Bass)
				<part> = qs("\LB")
			endif
			if (($<player_status>.part) = guitar)
				<part> = qs("\LG")
			endif
			if (($<player_status>.part) = drum)
				<part> = qs("\LD")
			endif
			if (($<player_status>.part) = Vocals)
				<part> = qs("\LV")
			endif
			FormatText checksumname = rmdt 'rock_meter_debug_text%i' i = <player> AddToStringLookup
			FormatText TextName = string qs("\L%p:%v") p = <part> v = ($<player_status>.current_health)
			SetScreenElementProps id = <rmdt> text = <string>
			<player> = (<player> + 1)
			repeat $current_num_players
		endif
		FormatText \{TextName = text_string
			qs("\L%a")
			a = $current_crowd}
		SetScreenElementProps id = <id> text = <text_string>
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script setlist_quit_song_menu_input 
	SetScriptCannotPause
	<return_to_base_selection> = 0
	begin
	Block \{type = setlist_created}
	Wait RandomFloat (1.0, 2.0) seconds
	begin
	if ScreenElementExists \{id = setlist_menu}
		break
	endif
	Wait \{1
		gameframes}
	repeat

	if (<return_to_base_selection> > 0)
		begin
		LaunchEvent \{type = pad_up
			target = setlist_menu}
		Wait RandomFloat (0.2, 0.6) seconds
		repeat <return_to_base_selection>
	endif
	<count> = RandomInteger (1.0, 8.0)
	<return_to_base_selection> = <count>
	begin
	LaunchEvent \{type = pad_down
		target = setlist_menu}
	Wait RandomFloat (0.2, 0.6) seconds
	repeat <count>
	setlist_menu :Menu_GetSelectedIndex
	LaunchEvent type = pad_choose target = {setlist_menu child = <selected_index>}
	Block \{type = song_started}
	Wait RandomFloat (5.0, 60.0) seconds

	LaunchEvent \{type = pad_start
		target = root_window}
	Block \{type = pause_menu_created}
	Wait RandomFloat (1.0, 2.0) seconds
	begin
	if ScreenElementExists \{id = current_menu}
		break
	endif
	Wait \{1
		gameframes}
	repeat

	begin
	LaunchEvent \{type = pad_down
		target = current_menu}
	Wait \{0.3
		seconds}
	repeat 5
	current_menu :Menu_GetSelectedIndex
	LaunchEvent type = pad_choose target = {current_menu child = <selected_index>}
	Block \{type = popup_created}
	Wait RandomFloat (1.0, 2.0) seconds
	begin
	if ScreenElementExists \{id = dialog_box_vmenu}
		break
	endif
	Wait \{1
		gameframes}
	repeat

	LaunchEvent \{type = pad_down
		target = dialog_box_vmenu}
	Wait \{0.5
		seconds}
	dialog_box_vmenu :Menu_GetSelectedIndex
	LaunchEvent type = pad_choose target = {dialog_box_vmenu child = <selected_index>}
	Block \{type = popup_created}
	Wait RandomFloat (1.0, 2.0) seconds
	begin
	if ScreenElementExists \{id = dialog_box_vmenu}
		break
	endif
	Wait \{1
		gameframes}
	repeat

	LaunchEvent \{type = pad_down
		target = dialog_box_vmenu}
	Wait \{0.5
		seconds}
	dialog_box_vmenu :Menu_GetSelectedIndex
	LaunchEvent type = pad_choose target = {dialog_box_vmenu child = <selected_index>}
	repeat
endscript
