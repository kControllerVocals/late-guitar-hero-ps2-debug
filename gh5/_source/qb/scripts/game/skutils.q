check_for_unplugged_controllers = 0
AnimLODInterleave2 = 12
AnimLODInterleave4 = 9
PS3_AnimLODInterleave2 = 20
PS3_AnimLODInterleave4 = 12
Xenon_AnimLODInterleave2 = 20
Xenon_AnimLODInterleave4 = 12

script autolaunch 
	LockGlobalTags \{forceoff}
	if GotParam \{level}
		change current_level = <level>
		startnow = 1
	endif
	if GotParam \{song}
		change current_song = <song>
		startnow = 1
	endif
	if GotParam \{difficulty}
		change structurename = player1_status difficulty = <difficulty>
		startnow = 1
	endif
	if GotParam \{difficulty2}
		change structurename = player2_status difficulty = <difficulty2>
		startnow = 1
	endif
	if GotParam \{difficulty3}
		change structurename = player3_status difficulty = <difficulty3>
		startnow = 1
	endif
	if GotParam \{difficulty4}
		change structurename = player4_status difficulty = <difficulty4>
		startnow = 1
	endif
	if GotParam \{StartTime}
		change current_starttime = <StartTime>
		startnow = 1
	endif
	if GotParam \{controller}
		change structurename = player1_status controller = <controller>
		change player1_device = <controller>
		change primary_controller = <controller>
		change \{primary_controller_assigned = 1}
		startnow = 1
	else
		change \{primary_controller = 0}
		change \{primary_controller_assigned = 1}
	endif
	if GotParam \{controller2}
		change structurename = player2_status controller = <controller2>
		change player2_device = <controller2>
		change primary_controller = <controller2>
		change \{primary_controller_assigned = 1}
		startnow = 1
	endif
	if GotParam \{controller3}
		change structurename = player3_status controller = <controller3>
		change player2_device = <controller3>
		change primary_controller = <controller3>
		change \{primary_controller_assigned = 1}
		startnow = 1
	endif
	if GotParam \{controller4}
		change structurename = player4_status controller = <controller4>
		change player2_device = <controller4>
		change primary_controller = <controller4>
		change \{primary_controller_assigned = 1}
		startnow = 1
	endif
	if GotParam \{part}
		change structurename = player1_status part = <part>
		startnow = 1
	endif
	if GotParam \{part2}
		change structurename = player2_status part = <part2>
		startnow = 1
	endif
	if GotParam \{part3}
		change structurename = player3_status part = <part3>
		startnow = 1
	endif
	if GotParam \{part4}
		change structurename = player4_status part = <part4>
		startnow = 1
	endif
	if GotParam \{game_mode}
		change game_mode = <game_mode>
		if ($game_mode = p2_pro_faceoff)
			change \{current_num_players = 2}
		elseif ($game_mode = p3_quickplay)
			change \{current_num_players = 3}
		elseif ($game_mode = p4_quickplay)
			change \{current_num_players = 4}
		endif
		startnow = 1
	endif
	if GotParam \{startnow}
		change autolaunch_startnow = <startnow>
	endif
	if GotParam \{force_encore}
		change \{force_encore_autolaunch = 1}
	endif
	if GotParam \{Guitarist}
		change structurename = player1_status character_id = <Guitarist>
	endif
	if GotParam \{bassist}
		change structurename = player2_status character_id = <bassist>
	endif
	if GotParam \{vocalist}
		change structurename = player3_status character_id = <vocalist>
	endif
	if GotParam \{Drummer}
		change structurename = player4_status character_id = <Drummer>
	endif
	translate_gamemode
endscript

script setup_4_player_bot 
	SetPlayerInfo \{1
		part = guitar}
	SetPlayerInfo \{2
		part = drum}
	SetPlayerInfo \{3
		part = Bass}
	SetPlayerInfo \{4
		part = Vocals}
	SetPlayerInfo \{1
		bot_play = 1}
	SetPlayerInfo \{2
		bot_play = 1}
	SetPlayerInfo \{3
		bot_play = 1}
	SetPlayerInfo \{4
		bot_play = 1}
	if ($use_worst_band = 1)
		SetPlayerInfo \{2
			double_kick_drum = 1}
		change \{force_fail_vignette_on = 1}
	endif
	return \{game_mode = p4_quickplay}
endscript

script change_level 

endscript

script KillElement3d 
	Wait \{1
		gameframe}
	Die
endscript

script script_assert 


endscript

script nullscript 
endscript

script DumpMetrics 
	GetMetrics



endscript
dummy_metrics_struct = {
	mainscene = 0
	skyscene = 0
	metrics = 0
	Sectors = 0
	ColSectors = 0
	Verts = 0
	BasePolys = 0
	TextureMemory = 0
}

script Restore_skater_camera 
endscript

script GetSkaterCam 
	camera_object = skatercam0
	if InSplitScreenGame
		if IsObjectScript
			Obj_GetID
			if NOT ChecksumEquals a = <ObjID> b = 0
				camera_object = skatercam1
			endif
		endif
	endif
	return skatercam = <camera_object>
endscript

script SetSkaterCamOverride 
	GetSkaterCam
	<skatercam> :SC_SetSkaterCamOverride <...>
endscript

script ClearSkaterCamOverride 
	GetSkaterCam
	<skatercam> :SC_ClearSkaterCamOverride <...>
endscript

script empty_script 
endscript

script restore_start_key_binding 
	if NOT GotParam \{nospam}

	endif
	SetScreenElementProps \{id = root_window
		event_handlers = [
			{
				pad_start
				handle_pause_event
			}
		]
		replace_handlers}
endscript

script kill_start_key_binding 
	if NOT GotParam \{nospam}

	endif
	SetScreenElementProps \{id = root_window
		event_handlers = [
			{
				pad_start
				null_script
			}
		]
		replace_handlers}
endscript

script BlockPendingPakManLoads \{map = all
		block_scripts = 0
		noparse = 0}
	if (<block_scripts> = 1)
		PendingPakManLoads map = <map> block_scripts = 1 noparse = <noparse> slot = <slot>
		if GotParam \{loaderror}
			return \{false}
		endif
		return \{true}
	endif
	begin
	if NOT (PendingPakManLoads map = <map> noparse = <noparse> slot = <slot>)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	if GotParam \{loaderror}
		return \{false}
	endif
	return \{true}
endscript

script SetPakManCurrentBlock \{block_scripts = 0
		noparse = 0}
	SetPakManCurrent map = <map> pak = <pak> pakname = <pakname> slot = <slot>
	if NOT BlockPendingPakManLoads map = <map> block_scripts = <block_scripts> noparse = <noparse> slot = <slot>
		return \{false}
	endif
	if (<map> = zones)
		GetPakManCurrentName \{map = zones}
		if GotParam \{pakname}
			FormatText checksumname = zone_setup '%s_setup' s = <pakname>
			if ScriptExists <zone_setup>
				if NOT ScriptIsRunning <zone_setup>
					spawnscriptnow <zone_setup>
				endif
			endif
		endif
	endif
	if ChecksumEquals a = <map> b = zones
		LightShow_SetVenueTweakParams zone = <pak>
	endif
	return \{true}
endscript

script RefreshPakManCurrent 
	SetPakManCurrentBlock map = <map> pak = <pak> pakname = <pakname>
endscript

script Zones_PakMan_Init 

	zone_name = <pak_name>
	zone_string_name = <pak_string_name>
	FormatText checksumname = sfx_zone_name '%z_sfx' z = <zone_string_name>
	FormatText checksumname = gfx_zone_name '%z_gfx' z = <zone_string_name>
	FormatText checksumname = lfx_zone_name '%z_lfx' z = <zone_string_name>
	FormatText checksumname = mfx_zone_name '%z_mfx' z = <zone_string_name>
	FormatText checksumname = array_name '%z_NodeArray' z = <zone_string_name>
	FormatText checksumname = sfx_array_name '%z_SFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = gfx_array_name '%z_GFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = lfx_array_name '%z_LFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = mfx_array_name '%z_MFX_NodeArray' z = <zone_string_name>
	zone_init <...>
	FormatText checksumname = script_zone_init '%z_init' z = <zone_string_name>
	FormatText checksumname = script_zone_sfx_init '%z_sfx_init' z = <zone_string_name>
	FormatText checksumname = script_zone_gfx_init '%z_gfx_init' z = <zone_string_name>
	FormatText checksumname = script_zone_lfx_init '%z_lfx_init' z = <zone_string_name>
	FormatText checksumname = script_zone_mfx_init '%z_mfx_init' z = <zone_string_name>
	if ScriptExists <script_zone_init>
		<script_zone_init>
	endif
	if ScriptExists <script_zone_sfx_init>
		<script_zone_sfx_init>
	endif
	if ScriptExists <script_zone_gfx_init>
		<script_zone_gfx_init>
	endif
	if ScriptExists <script_zone_lfx_init>
		<script_zone_lfx_init>
	endif
	if ScriptExists <script_zone_mfx_init>
		<script_zone_mfx_init>
	endif
	UpdatePakManVisibility \{map = zones}

endscript

script Zones_PakMan_DeInit 

	zone_name = <pak_name>
	zone_string_name = <pak_string_name>
	FormatText checksumname = sfx_zone_name '%z_sfx' z = <zone_string_name>
	FormatText checksumname = gfx_zone_name '%z_gfx' z = <zone_string_name>
	FormatText checksumname = lfx_zone_name '%z_lfx' z = <zone_string_name>
	FormatText checksumname = mfx_zone_name '%z_mfx' z = <zone_string_name>
	FormatText checksumname = array_name '%z_NodeArray' z = <zone_string_name>
	FormatText checksumname = sfx_array_name '%z_SFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = gfx_array_name '%z_GFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = lfx_array_name '%z_LFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = mfx_array_name '%z_MFX_NodeArray' z = <zone_string_name>
	zone_deinit <...>
	FormatText checksumname = script_zone_deinit '%z_deinit' z = <zone_string_name>
	FormatText checksumname = script_zone_sfx_deinit '%z_sfx_deinit' z = <zone_string_name>
	FormatText checksumname = script_zone_gfx_deinit '%z_gfx_deinit' z = <zone_string_name>
	FormatText checksumname = script_zone_lfx_deinit '%z_lfx_deinit' z = <zone_string_name>
	FormatText checksumname = script_zone_mfx_deinit '%z_mfx_deinit' z = <zone_string_name>
	if ScriptExists <script_zone_deinit>
		<script_zone_deinit>
	endif
	if ScriptExists <script_zone_sfx_deinit>
		<script_zone_sfx_deinit>
	endif
	if ScriptExists <script_zone_gfx_deinit>
		<script_zone_gfx_deinit>
	endif
	if ScriptExists <script_zone_lfx_deinit>
		<script_zone_lfx_deinit>
	endif
	if ScriptExists <script_zone_mfx_deinit>
		<script_zone_mfx_deinit>
	endif
	DestroyParticlesByGroupID \{groupID = zoneparticles}
	DestroyZoneEntities zone_name = <zone_name> zone_string_name = <zone_string_name>
	ResetWaypoints pak_name = <pak_name>
	ResetWaypoints pak_name = <gfx_zone_name>
	ResetWaypoints pak_name = <sfx_zone_name>
	ResetWaypoints pak_name = <lfx_zone_name>
	UpdatePakManVisibility \{map = zones}

endscript
