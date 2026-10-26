text = qs(0xe5b08ef0)
use_pcmcia = 'true'
viewer_ip = '10.2.1.1'
viewer_subnet = '255.252.0.0'
viewer_gateway = '10.2.0.1'
use_qbr = 0
show_gpu_time = 0
output_gpu_log = 0
show_cpu_time = 0
show_play_log = 0
play_log_lines = 10
show_guitar_tilt = 0
nxwatson_channels = 1
output_song_stats = 0
show_sensor_debug = 0
pause_menu_no_bg = 0
vocal_debug_hud = 0
roland_drumkit = 1
rock_meter_debug = 0
ps2_venues = 0
current_song = Demon
current_difficulty_coop = easy
current_level = load_Z_Cairo
current_highway = highway
current_time = 0.0
current_deltatime = 0.0167
current_starttime = 0
current_endtime = 0
current_looppoint = -1000000
current_speedfactor = 1.0
autolaunch_startnow = 0
autolaunch_showstorageselector = 1
current_song_qpak = none
current_song_qpak_mocap = none
current_song_qpak_performance = 0
current_band = 1
last_song_failed = none
current_song_failed_num = 0
current_transition = none
debug_current_transition = none
current_num_players = 1
in_join_band_screens = 0
num_players_finished = 0
guitar_fretbar_divisions = 2
drum_fretbar_divisions = 2
disable_band = 0
disable_crowd = 1
disable_note_input = 0
tutorial_disable_hud = 0
current_frame_toggle = 0
whammyon_lockp1 = 0
whammyon_lockp2 = 0
is_network_game = 0
net_ready_to_start = 0
rich_presence_context = presence_menus
game_mode = p1_quickplay
is_partyplay_mode = 0
is_freeplay_mode = 0
top_rocker_active_controller = none

script game_is_scored 
	if (($is_partyplay_mode = 1) || ($is_freeplay_mode = 1))
		return \{false}
	endif
	return \{true}
endscript
skip_boot_menu = 0
autolaunch_cas = 0
autolaunch_cas_soak_test = 0
autolaunch_cas_artist = 0
objviewer_light_test = 0
autolaunch_jam = 0
skip_signin = 0
show_movies = 1
is_demo_mode = 0
is_multiplayer_beta = 0
downloadcontent_enabled = 0
songtime_paused = 0
drum_solo_songtime_paused = 0
drum_solo_length = 0.0
drum_solo_no_gems = 0
PS2_ProgressiveScan = 0
drum_rock_meter_weights = {
	beginner = [
		1.0
		1.0
	]
	easy = [
		1.0
		1.0
	]
	medium = [
		1.5
		1.5
	]
	hard = [
		2.0
		2.5
	]
	expert = [
		2.0
		2.5
	]
}
input_debug_display = 0
display_debug_input = 0
output_log_file = 0
practice_start_time = 0
practice_end_time = 0
practice_loop_section = 0
startup_song = Demon
startup_difficulty = easy
time_audio_offset = 0.0
time_gem_offset = 0.0
time_input_offset = 0.0
time_drum_midi_offset = 0.0
time_gem_offset_with_lag = 0.0
time_drum_midi_offset_with_lag = 0.0
crowd_band_multiplier = 1.0
Cheat_AlwaysSlide = -1
Cheat_SuperUser = -1
Cheat_AirInstruments = -1
Cheat_InvisibleCharacters = -1
Cheat_SnobCrowd = -1
Cheat_PerformanceMode = -1
Cheat_Hyperspeed = -1
Cheat_AutoKick = -1
Cheat_FreeDrum = -1
Cheat_GemColor = -1
Cheat_FlameColor = -1
Cheat_StarColor = -1
Cheat_VocalFireball = -1
Cheat_allHOPOs = -1
Cheat_Invincible = -1
Cheat_FocusMode = -1
Cheat_HUDFreeMode = -1
original_check_time_early = 0.0
original_check_time_late = 0.0
crowd_model_array = none
failed_song_time = 0.0
current_section_array = none
current_section_array_entry = 0
last_time_in_lead = 0.0
last_time_in_lead_player = -1
enable_saving = 1
primary_controller = 0
primary_controller_assigned = 0
invite_controller = -1
num_career_bands = 1
streamall_fsb_index = -1
enable_button_cheats = 1
enable_debug_menus = 1
whammy_mania_achievement_invalidated = 0
vocalist_height = 1.6
winning_player_camera_percentage = 100
cas_heap_state = in_game
playerserver_frame_lag = 0
guest_character_names = {
}
guest_character_fullnames = {
}
num_quickplay_song_list = 0
quickplay_song_list_current = 0
quickplay_song_list = [
	null
	null
	null
	null
	null
	null
]

script reset_quickplay_song_list 
	change \{quickplay_song_list_current = -1}
	GetArraySize \{$quickplay_song_list}
	i = 0
	begin
	SetArrayElement ArrayName = quickplay_song_list GlobalArray index = <i> newvalue = null
	<i> = (<i> + 1)
	repeat <array_size>
endscript
sysnotify_menus_position = topright
sysnotify_ingame_position = topright
CameraCuts_EnableVideoVenueCams = 0

script IsLevelZoneVideoVenue \{level_zone = none}


	if StructureContains Structure = $GHZones <level_zone>

		return \{true}
	endif

	return \{false}
endscript
g_video_venues_enable_count = 0
g_zones_pak = none

script IsVideoVenuesEnabled 
	if ($g_video_venues_enable_count > 0)
		return \{true}
	endif
	return \{false}
endscript

script EnableVideoVenues 
	if ($Cheat_FocusMode = 1)
		return
	endif
	if ($g_video_venues_enable_count = 0)
		GetPakManCurrent \{map = zones}
		change g_zones_pak = <pak>
		SetPakManCurrentBlock \{map = zones
			pak = none
			block_scripts = 1}
		DestroyPakManMap \{map = zones}
		MemPushContext \{heap_zones}
		CreatePakManMap \{map = zones
			links = GHZones
			folder = 'zones/'
			uselinkslots}
		MemPopContext
		StartVideoVenues
		change \{g_video_venues_enable_count = 1}
	endif
endscript

script DisableVideoVenues 
	if ($g_video_venues_enable_count > 0)
		StopVideoVenues
		SetPakManCurrentBlock \{map = zones
			pak = none
			block_scripts = 1}
		DestroyPakManMap \{map = zones}
		MemPushContext \{heap_zones}
		CreatePakManMap \{map = zones
			links = GHFullZones
			folder = 'zones/'
			uselinkslots}
		MemPopContext
		SetPakManCurrentBlock \{map = zones
			pak = $g_zones_pak
			block_scripts = 1}
		change \{g_zones_pak = none}
		change \{g_video_venues_enable_count = 0}
	endif
endscript

script PushVideoVenues 
	if ($g_video_venues_enable_count < 10)
		if ($g_video_venues_enable_count = 0)
			EnableVideoVenues
		else
			change g_video_venues_enable_count = ($g_video_venues_enable_count + 1)
		endif
	endif
endscript

script PopVideoVenues 
	if ($g_video_venues_enable_count > 0)
		if ($g_video_venues_enable_count = 1)
			DisableVideoVenues
		else
			change g_video_venues_enable_count = ($g_video_venues_enable_count - 1)
		endif
	endif
endscript

script get_heap_sizes 
	GetPlatform
	switch <platform>
		case Ps2
		<heap_size_globalpak> = (512 * 1024)
		<heap_size_globalpak_vram> = (0)
		<heap_size_audio> = (0)
		<heap_size_audio_vram> = (0)
		<heap_size_musician> = (693 * 1024)
		<heap_size_musician_highway> = (65 * 1024)
		<heap_size_musician_vram> = (0)
		<heap_size_musician_anim> = (3766 * 1024)
		<heap_size_cas> = (2183 * 1024)
		<heap_size_cas_vram> = (0)
		<heap_size_song> = (1784 * 1024)
		<heap_size_zones> = (1664 * 1024)
		<heap_size_zones_vram> = (0)
		<heap_size_ui_pak_slot> = (1024 * 1024)
		<heap_size_ui_pak_slot_vram> = (0)
		default

	endswitch
	return <...>
endscript

script print_loading_time 
	GetElapsedTime StartTime = <StartTime>
	finalprintf qs("\LLoading time: %a (%t)") a = <ElapsedTime> t = <text>
endscript

script guitar_startup 
	change \{AssertOnMissingScripts = 0}
	SetScreen \{widescreen = 1}
	GetStartTime
	OverallStartTime = <StartTime>
	spawnscriptnow \{start_legal_timer}
	stoprendering

	get_heap_sizes
	PushMemProfile \{'Global Pak Heap'}
	MemInitHeap name = 'heap_global_pak' size = <heap_size_globalpak> vram_size = <heap_size_globalpak_vram>
	PopMemProfile
	PushMemProfile \{'Characters'}
	MemInitHeap name = 'heap_musician1' size = (<heap_size_musician> + 3 * <heap_size_musician_highway>) vram_size = <heap_size_musician_vram>
	MemInitHeap name = 'heap_musician2' size = <heap_size_musician> vram_size = <heap_size_musician_vram>
	MemInitHeap name = 'heap_musician3' size = <heap_size_musician> vram_size = <heap_size_musician_vram>
	MemInitHeap name = 'heap_musician4' size = <heap_size_musician> vram_size = <heap_size_musician_vram>
	MemInitHeap name = 'heap_musician_anim' size = <heap_size_musician_anim>
	PopMemProfile
	SetupMusicianFallBackHeaps
	PushMemProfile \{'CAS Heap'}
	MemInitHeap name = 'heap_cas' size = <heap_size_cas> vram_size = <heap_size_cas_vram> topDownName = 'heap_cas_topdown'
	PopMemProfile

	PushMemProfile \{'COIM'}
	InitCOIM \{size = $Generic_COIM_Size
		BlockAlign = $Generic_COIM_BlockAlign
		COIM_Min_Scratch_Blocks
		$Generic_COIM_Params}
	PopMemProfile
	PushMemProfile \{'CompositeObjectManager_startup'}
	CompositeObjectManager_startup
	PopMemProfile

	PushMemProfile \{'MemCardSystem'}
	MemCardSystemInitialize
	PopMemProfile
	MC_SetActivePlayer \{QueryDefault}

	PushMemProfile \{'AnimCompressTable'}
	InitAnimCompressTable \{'anims\\standardkeyq.bin'
		q48}
	InitAnimCompressTable \{'anims\\standardkeyt.bin'
		t48}
	PopMemProfile
	PushMemProfile \{'Animation Cache'}
	InitAnimSystem {
		AnimHeapSize = 0
		CacheBlockAlign = 3072
		AnimNxBufferSize = (2 * 1024 * 1024)
		DefCacheType = fullres
		MaxAnimStages = 2
		MaxAnimSubsets = 4
		MaxDegenerateAnims = 3
		AnimJQSize = (140 * 1024)
	}
	PopMemProfile
	LoadPak \{'pak/anims/animq.pak'
		heap = TopDownHeap
		no_vram}
	RegisterAllAnimEvents
	UnloadPak \{'pak/anims/animq.pak'}
	PushMemProfile \{'InitLightManager'}
	InitLightManager \{max_lights = 2
		max_model_lights = 8
		max_groups = 8
		max_render_verts_per_geom = 4096
		max_diffuse_lights = 4}
	PopMemProfile
	PushMemProfile \{'LightShow'}
	LightShow_AddNodeFlags
	LightShow_Init \{notes = $LightShow_NoteMapping
		nodeflags = $LightShow_StateNodeFlags
		ColorOverrideExclusions = $LightShow_ColorOverrideExcludeLights}
	LightShow_SetProcessors \{shared = $LightShow_SharedProcessors}
	LightShow_SetVenueTweakParams
	PopMemProfile
	Transition_RandomizeVOIntros
	PushMemProfile \{'create_node_flags'}
	create_node_flags
	PopMemProfile
	PushMemProfile \{'Game Heaps'}
	MemInitHeap name = 'heap_zones' size = <heap_size_zones>
	MemPushContext \{heap_zones}
	CreatePakManMap \{map = zones
		links = GHFullZones
		folder = 'zones/'
		uselinkslots}
	MemPopContext
	MemInitHeap name = 'heap_song' size = <heap_size_song>
	PopMemProfile
	if NOT ($cas_heap_state = in_game)

	endif
	if ScriptExists \{init_globaltags}
		get_num_globaltag_sets
		init_packed_structs globaltag_sets = <num_globaltag_sets>
		init_globaltags globaltag_sets = <num_globaltag_sets>
	endif
	set_plat_jam_maximums
	engineconfig \{particlelod = 0}
	if ScriptExists \{enable_qbr}
		enable_qbr
	endif
	if ($use_qbr = 1)
		UseNetworkPreferences
		network_driver_startup
	endif
	if ($is_demo_mode = 1)
		change \{enable_button_cheats = 0}
	endif
	if CD
		change \{enable_button_cheats = 1}
	endif
	if ($enable_button_cheats = 1)
		LaunchViewer
		change \{select_shift = 1}
	endif
	if NOT CD
		change \{skip_boot_menu = 1}
	endif

	Master_SFX_Adding_Sound_Busses

	if ScriptExists \{startup}
		startup
	endif
	AllocateDecompressedFontBuffers

	PushMemProfile \{'UI Pak Slot'}
	MemInitHeap name = 'heap_ui_pak_slot' size = <heap_size_ui_pak_slot> vram_size = <heap_size_ui_pak_slot_vram>
	PopMemProfile
	PushMemProfile \{'UI_InitializeStateMachine'}
	UI_InitializeStateMachine
	PopMemProfile

	GetStartTime
	LoadPak \{'zones/global/global.pak'
		heap = heap_global_pak
		splitfile}
	print_loading_time StartTime = <StartTime> text = qs("\Lzones/global/global.pak")
	ParseNodeArray \{queue
		zone_name = global
		array_name = global_nodearray}
	GetStartTime
	LoadPak \{'pak/anims/perm_anims/perm_anims.pak'
		heap = heap_musician_anim
		no_vram}
	print_loading_time StartTime = <StartTime> text = qs("\Lpak/anims/perm_anims/perm_anims.pak & pak/ui_shared/ui_shared.pak")
	LoadPak \{'pak/fonts/fonts.pak'
		heap = TopDownHeap}
	DecompressFonts \{buttons}
	DecompressFonts \{fontgrid_numeral_a9}
	DecompressFonts \{fontgrid_numeral_a7}
	DecompressFonts \{fontgrid_text_a1}
	DecompressFonts \{fontgrid_text_a8}
	DecompressFonts \{fontgrid_text_a10}
	DecompressFonts \{fontgrid_title_a1}
	UnloadPak \{'pak/fonts/fonts.pak'}
	buttons_font = 'Buttons'
	SetFontProperties <buttons_font> buttons_font
	SetFontProperties \{'fontgrid_numeral_a7'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_numeral_a9'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_text_a1'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_text_a3'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_text_a5'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_text_a6'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_text_a8'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_text_a10'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_text_a11'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_text_a11_b'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_text_a11_large'
		color_tab = $Default_Font_Colors}
	SetFontProperties \{'fontgrid_title_a1'
		color_tab = $Default_Font_Colors}
	SetScenePermanent \{scene = 'zones/global/global_gfx.scn'
		permanent}
	PushMemProfile \{'setup_models'}
	setup_models
	PopMemProfile
	output_status \{text = 'SmartPak_Init'}
	PushMemProfile \{'SmartPak'}
	SmartPak_Init
	PopMemProfile


	SetPakManCurrentBlock \{map = zones
		pak = none
		block_scripts = 1}
	LoadPak \{'pak\\sfxheader\\sfxheader.pak'
		heap = heap_song}
	init_sfx_wad_header
	UnloadPak \{'pak\\sfxheader\\sfxheader.pak'}
	PushMemProfile \{'Audio Stream header'}

	LoadStreamHeader \{'streams\\streams'}
	PopMemProfile
	AddEditableList \{ped_editable_list}

	PushMemProfile \{'Atoms Progression Globaltags'}
	InitAtoms
	SetProgressionMaxDifficulty \{difficulty = 4}

	FinalProfile_Start \{'reset_globaltags_all'}
	GetStartTime
	reset_globaltags_all
	print_loading_time StartTime = <StartTime> text = qs("\Lreset_globaltags_all")
	FinalProfile_Stop \{'reset_globaltags_all'}

	PopMemProfile
	ReloadSfx \{mode = firstboot}
	setup_sprites
	disable_pause
	SetShadowRenderingFlags \{enable = 'true'
		object = 'skin'}
	SetShadowMapParams \{far = 16.0}
	ShowStencilShadow
	PushMemProfile \{'BG Viewport'}
	setup_bg_viewport
	restore_dummy_bg_camera
	PopMemProfile
	GetMaxPlayers
	player = 1
	begin
	<player_status> = ($player_status_array [<player>])
	<player_text> = ($player_text_array [<player>])
	SpawnScriptLater create_guitar_events params = {<...>}
	player = (<player> + 1)
	repeat <max_players>
	Randomize
	SetShadowProjectionTexture \{texture = white}
	if ($autolaunch_startnow = 0)
		if GlobalExists \{name = autolaunch_state
				type = checksum}
			fadetoblack \{off
				no_wait}
			change \{primary_controller_assigned = 1}
			ui_event \{event = menu_change
				data = {
					state = $autolaunch_state
				}}
		elseif ($skip_boot_menu = 1)
			change \{primary_controller_assigned = 1}
			Hideloadingscreen
			startrendering
			if (($autolaunch_cas = 1) || ($autolaunch_cas_artist) || ($autolaunch_jam = 1) || ($skip_signin = 1))
				change \{skip_signin = 0}
				change \{primary_controller_assigned = 1}
				ui_event \{event = menu_change
					data = {
						state = UIstate_mainmenu
					}}
			else
				ui_event \{event = menu_change
					data = {
						state = UIstate_boot_iis
					}}
			endif
		else
			startrendering
			ui_event \{event = menu_change
				data = {
					state = UIstate_boot_legal
				}}
			AddParams \{donthide}
		endif
	else
		startrendering
		SpawnScriptLater \{autolaunch_spawned}
	endif
	guitar_create_character_maps
	create_font_arrays
	change \{tutorial_disable_hud = 0}
	vocals_start_mic
	if ($autolaunch_startnow != 0)
		vocals_distribute_mics
	endif
	<profile_gpu> = 0
	if ($show_gpu_time = 1)
		<profile_gpu> = 1
	endif
	if ($output_gpu_log = 1)
		<profile_gpu> = 1
	endif
	if (<profile_gpu> = 1)
		ToggleMetrics \{mode = 5}
	endif
	SetGlobalTags \{user_options
		params = {
			ps2_widescreen = 1
		}}
	ps2_load_car_part_script
	print_loading_time StartTime = <OverallStartTime> text = qs("\LOverall")
endscript

script verify_cas_budgets 
	VerifyCASBudgets editable_list = $master_editable_list budgets = $cas_budget_groups <...>
	if GotParam \{textures}
		VerifyCAPTextures
	endif
	if GotParam \{profiles}
		VerifyCAPProfile profile = ($default_custom_musician_profile_female) <...>
		VerifyCAPProfile profile = ($default_custom_musician_profile_male) <...>
		VerifyCAPProfile profiles = ($Preset_Musician_Profiles_Modifiable) <...>
		VerifyCAPProfile profiles = ($Preset_Musician_Profiles_Locked) <...>
		VerifyCAPProfile appearances = ($cas_preset_guitars) <...>
		VerifyCAPProfile appearances = ($cas_preset_basses) <...>
		VerifyCAPProfile appearances = ($cas_preset_drums) <...>
		VerifyCAPProfile appearances = ($cas_preset_female_vocals) <...>
		VerifyCAPProfile appearances = ($cas_preset_male_vocals) <...>
		VerifyCAPProfile appearances = ($cas_preset_tattoo_female) <...>
		VerifyCAPProfile appearances = ($cas_preset_tattoo_male) <...>
		VerifyCAPProfile appearances = ($cas_preset_face_skin_female) <...>
		VerifyCAPProfile appearances = ($cas_preset_face_skin_male) <...>
		VerifyCAPProfile appearances = ($cas_preset_body_female) <...>
		VerifyCAPProfile appearances = ($cas_preset_body_male) <...>
	endif
endscript

script generate_worst_cas_appearances 
	VerifyCASBudgets \{editable_list = $master_editable_list
		budgets = $cas_budget_groups
		specific_parts = [
			CAS_Body
			CAS_Guitar_Body
			CAS_Female_Hat_Hair
		]
		forcebody = GH4_CAR_Female}
	guitar_appearance = (<budget_report_geo>.worst_parts)
	VerifyCASBudgets \{editable_list = $master_editable_list
		budgets = $cas_budget_groups
		specific_parts = [
			CAS_Body
			CAS_Bass_Body
			CAS_Female_Hat_Hair
		]
		forcebody = GH4_CAR_Female}
	bass_appearance = (<budget_report_geo>.worst_parts)
	VerifyCASBudgets \{editable_list = $master_editable_list
		budgets = $cas_budget_groups
		specific_parts = [
			CAS_Body
			CAS_Drums
			CAS_Female_Hat_Hair
		]
		forcebody = GH4_CAR_Female}
	drum_appearance = (<budget_report_geo>.worst_parts)
	VerifyCASBudgets \{editable_list = $master_editable_list
		budgets = $cas_budget_groups
		specific_parts = [
			CAS_Body
			CAS_Mic
			CAS_Female_Hat_Hair
		]
		forcebody = GH4_CAR_Female}
	vocals_appearance = (<budget_report_geo>.worst_parts)
	VerifyCASBudgets \{editable_list = $master_editable_list
		budgets = $cas_budget_groups
		specific_parts = [
			CAS_Body
			CAS_Guitar_Body
			CAS_Male_Hat_Hair
		]
		forcebody = GH4_CAR_Male}
	m_guitar_appearance = (<budget_report_geo>.worst_parts)
	VerifyCASBudgets \{editable_list = $master_editable_list
		budgets = $cas_budget_groups
		specific_parts = [
			CAS_Body
			CAS_Bass_Body
			CAS_Male_Hat_Hair
		]
		forcebody = GH4_CAR_Male}
	m_bass_appearance = (<budget_report_geo>.worst_parts)
	VerifyCASBudgets \{editable_list = $master_editable_list
		budgets = $cas_budget_groups
		specific_parts = [
			CAS_Body
			CAS_Drums
			CAS_Male_Hat_Hair
		]
		forcebody = GH4_CAR_Male}
	m_drum_appearance = (<budget_report_geo>.worst_parts)
	VerifyCASBudgets \{editable_list = $master_editable_list
		budgets = $cas_budget_groups
		specific_parts = [
			CAS_Body
			CAS_Mic
			CAS_Male_Hat_Hair
		]
		forcebody = GH4_CAR_Male}
	m_vocals_appearance = (<budget_report_geo>.worst_parts)
	OutputWorstCaseCASFile {
		path = 'car_worst_appearances.q'
		structs = {
			worst_female_guitar_appearance = <guitar_appearance>
			worst_female_bass_appearance = <bass_appearance>
			worst_female_drum_appearance = <drum_appearance>
			worst_female_vocals_appearance = <vocals_appearance>
			worst_male_guitar_appearance = <m_guitar_appearance>
			worst_male_bass_appearance = <m_bass_appearance>
			worst_male_drum_appearance = <m_drum_appearance>
			worst_male_vocals_appearance = <m_vocals_appearance>
		}
	}
endscript

script set_cas_heap_state 
	change cas_heap_state = <state>
endscript

script should_put_zones_on_debug_heap 
	return \{false}
endscript

script create_zone_maps 
	get_heap_sizes
	slop_heap = BottomUpHeap
	main_mem_heap = heap_cas
	vram_heap = heap_cas
	if should_put_zones_on_debug_heap
		main_mem_heap = debugrsxheap
		slop_heap = DebugHeap
		size_zones = ((25 * 1024 * 1024) - 1024)
	endif

	MemPushContext <slop_heap>
	if ($ps2_venues = 1)
		CreatePakManMap map = zones links = GHZones folder = 'zones_ps2/' size = (<size_zones> / 1024) vram_size = (<size_zones_vram> / 1024) allocheap = <main_mem_heap> vramheap = <vram_heap>
	else
		CreatePakManMap map = zones links = GHZones folder = 'zones/' size = (<size_zones> / 1024) vram_size = (<size_zones_vram> / 1024) allocheap = <main_mem_heap> vramheap = <vram_heap>
	endif
	MemPopContext
endscript
force_encore_autolaunch = 0

script autolaunch_spawned 
	($default_loading_screen.create)
	MC_SetActivePlayer \{QueryDefault}
	if ($autolaunch_showstorageselector = 1)
		NewShowStorageSelector
	endif
	if GlobalExists \{name = debug_unlockall}
		playday_unlockall
	endif
	ui_event_block \{event = menu_add
		state = UIstate_mainmenu
		data = {
			base_name = 'mainmenu'
		}}
	ui_event_block \{event = menu_add
		state = uistate_select_difficulty
		data = {
			base_name = 'select_difficulty'
		}}
	ui_event_block \{event = menu_add
		state = uistate_setlist
		data = {
			base_name = 'setlist'
		}}
	pausegh3
	ui_event event = menu_change data = {state = uistate_play_song device_num = ($player1_status.controller) uselaststarttime = 1 force_encore = $force_encore_autolaunch}
endscript

script kill_dummy_bg_camera 
	KillCamAnim \{name = dummy_cam_bg}
endscript

script restore_dummy_bg_camera 
	kill_dummy_bg_camera
	PlayIGCCam \{name = dummy_cam_bg
		viewport = bg_viewport
		pos = (-28.344543, 0.47631302, 7.1957684)
		Quat = (-0.00071999995, -0.99706, -0.07604)
		FOV = 72.0
		Play_hold}
endscript

script get_LevelZoneArray_size 
	GetArraySize \{$LevelZoneArray}
	size = (<array_size>)
	if GlobalExists \{name = download_LevelZoneArray
			type = array}
		GetArraySize \{$download_LevelZoneArray}
		size = (<array_size> + <size>)
	endif
	return array_size = <size>
endscript

script get_LevelZoneArray_checksum 
	GetArraySize \{$LevelZoneArray}
	if (<index> < <array_size>)
		return level_checksum = ($LevelZoneArray [<index>])
	else
		return level_checksum = ($download_LevelZoneArray [(<index> - <array_size>)])
	endif
endscript

script Is_LevelZone_Downloaded \{level_checksum = load_z_artdeco}
	if ArrayContains array = ($download_LevelZoneArray) contains = <level_checksum>
		FormatText TextName = filename '%s.pak' s = (($download_LevelZones.<level_checksum>).name)
		GetContentFolderIndexFromFile <filename>
		if (<device> = content)
			return \{download = 1
				true}
		else
			return \{download = 1
				false}
		endif
	else
		return \{download = 0
			true}
	endif
endscript
debug_cas_checksum_names = [
	largest_desc_id
	budget_report_main
	budget_report_vram
	budget_report_geo
	main
	vram
	underbudget
	overbudget
	totalsize
	slack
	heap_cas_vram
	assetsizes
	budgetsizes
	largestpieces
	worst_parts
	specific_parts
	custom_character_0
	custom_character_1
	custom_character_2
	custom_character_3
	custom_character_4
]

script GetCurrentLevel 
	return level = ($current_level)
endscript

script get_level_prefix 
	if StructureContains \{Structure = $LevelZones
			$current_level}
		return prefix = ($LevelZones.($current_level).name) prefix_crc = ($LevelZones.($current_level).zone)
	endif





	return \{prefix = 'z_unknown'
		prefix_crc = z_unknown}
endscript

script preqbromid 
	pausegh3
endscript

script postqbromid 
	restart_gem_scroller {
		song_name = ($current_song)
		difficulty = ($player1_status.difficulty)
		difficulty2 = ($player2_status.difficulty)
		difficulty3 = ($player3_status.difficulty)
		difficulty4 = ($player4_status.difficulty)
		StartTime = ($current_starttime)
		device_num = ($player1_status.controller)
	}
endscript

script InFrontend 
	return \{false}
endscript
rendering_has_been_stopped_explicit = 0
rendering_has_been_stopped_hide_glitch = 0
rendering_has_been_stopped_menu_transition = 0
rendering_has_been_stopped_invalid_viewports = 0
rendering_has_been_stopped_loading_screen = 0

script startrendering \{reason = explicit}
	debug_Printf 'StartRendering (noop) reason=%r' r = <reason>
	return
	switch <reason>
		case explicit
		change \{ps3_fader_started_rendering = 0}
		if ($rendering_has_been_stopped_explicit <= 0)
			return
		endif
		change rendering_has_been_stopped_explicit = ($rendering_has_been_stopped_explicit - 1)
		case hide_glitch
		if ($rendering_has_been_stopped_hide_glitch <= 0)
			return
		endif
		change rendering_has_been_stopped_hide_glitch = ($rendering_has_been_stopped_hide_glitch - 1)
		case menu_transition
		if ($rendering_has_been_stopped_menu_transition <= 0)
			return
		endif
		change rendering_has_been_stopped_menu_transition = ($rendering_has_been_stopped_menu_transition - 1)
		case invalid_viewports
		if ($rendering_has_been_stopped_invalid_viewports <= 0)
			return
		endif
		change rendering_has_been_stopped_invalid_viewports = ($rendering_has_been_stopped_viewports - 1)
		case loading_screen
		if ($rendering_has_been_stopped_loading_screen <= 0)
			return
		endif
		change rendering_has_been_stopped_loading_screen = ($rendering_has_been_stopped_loading_screen - 1)
		default

	endswitch
	if ($rendering_has_been_stopped_explicit > 0)
		return
	endif
	if ($rendering_has_been_stopped_hide_glitch > 0)
		return
	endif
	if ($rendering_has_been_stopped_menu_transition > 0)
		return
	endif
	if ($rendering_has_been_stopped_invalid_viewports > 0)
		return
	endif
	if ($rendering_has_been_stopped_loading_screen > 0)
		return
	endif
	StartRendering_C
endscript

script stoprendering \{reason = explicit}
	debug_Printf 'StopRendering (noop) reason=%r' r = <reason>
	return
	early_out = false
	if ($rendering_has_been_stopped_explicit > 0)
		early_out = true
	endif
	if ($rendering_has_been_stopped_hide_glitch > 0)
		early_out = true
	endif
	if ($rendering_has_been_stopped_menu_transition > 0)
		early_out = true
	endif
	if ($rendering_has_been_stopped_invalid_viewports > 0)
		early_out = true
	endif
	if ($rendering_has_been_stopped_loading_screen > 0)
		early_out = true
	endif
	switch <reason>
		case explicit
		change rendering_has_been_stopped_explicit = ($rendering_has_been_stopped_explicit + 1)
		case hide_glitch
		change rendering_has_been_stopped_hide_glitch = ($rendering_has_been_stopped_hide_glitch + 1)
		case menu_transition
		change rendering_has_been_stopped_menu_transition = ($rendering_has_been_stopped_menu_transition + 1)
		case invalid_viewports
		change rendering_has_been_stopped_invalid_viewports = ($rendering_has_been_stopped_invalid_viewports + 1)
		case loading_screen
		change rendering_has_been_stopped_loading_screen = ($rendering_has_been_stopped_loading_screen + 1)
		default

	endswitch
	if (<early_out> = true)
		return
	endif
	StopRendering_C
endscript

script get_player_status_checksum 

	GetMaxPlayers
	if ((<player> < 1) || (<player> > <max_players>))

		<player> = 1
	endif
	<player_status> = ($player_status_array [<player>])
	return player_status = <player_status>
endscript

script get_replay_heap 
	return \{replay_heap = none}
	return \{replay_heap = BottomUpHeap}
endscript

script are_replays_enabled 
	return \{false}
endscript

script RunOnQBR 
	if CD
		return
	endif
	if (<file> = 'reloads\\guitar_band_preset_profiles.qb.xen')
		stars

		stars
		if ($cas_heap_state = in_cas)
			if GetCurrentCASObject
				GetArraySize \{$Preset_Musician_Profiles_Modifiable}
				i = 0
				begin
				globaltag_set_preset_musician savegame = ($cas_current_savegame) index = <i> appearance = ($Preset_Musician_Profiles_Modifiable [<i>].appearance)
				i = (<i> + 1)
				repeat <array_size>
				if NOT is_completely_custom_musician id = ($cas_current_profile) savegame = ($cas_current_savegame)
					RefreshCASProfile
				endif
			endif
		endif
	endif
endscript

script hide_glitch \{num_frames = 1}
	spawnscriptnow hide_glitch_spawned params = {num_frames = <num_frames>}
endscript
hide_glitch_count = 0

script hide_glitch_spawned 
	OnExitRun \{hide_glitch_spawned_exit}
	SetScriptCannotPause
	change hide_glitch_count = ($hide_glitch_count + 1)
	if ($hide_glitch_count = 1)
		stoprendering \{reason = hide_glitch}
	endif
	Wait <num_frames> gameframes
endscript

script hide_glitch_spawned_exit 
	change hide_glitch_count = ($hide_glitch_count - 1)
	if ($hide_glitch_count = 0)
		startrendering \{reason = hide_glitch}
	endif
endscript

script PlayAnimatedTexture 
	spawnscriptnow AnimatedTextureLoop params = {<...>}
endscript

script AnimatedTextureLoop \{u = -1
		v = -1
		framerate = 10
		grid_size_x = 8
		grid_size_y = 8
		count = -1
		ShowStats = 0
		start_x = 0
		start_y = 0}
	if NOT AnimatedTextureLoop_CFunc_Setup
		return
	endif
	begin
	if AnimatedTextureLoop_CFunc
		break
	endif
	repeat
	AnimatedTextureLoop_CFunc_Cleanup
endscript

script SetAnimatingTextureState \{state = -1}
	ExtendCRC <object> '_AnimTexture_State' out = state_flag
	if (<state> = -1)
		if GetNodeFlag (<state_flag>)
			ChangeNodeFlag (<state_flag>) 0
		else
			ChangeNodeFlag (<state_flag>) 1
		endif
	else
		ChangeNodeFlag (<state_flag>) (<state>)
	endif
endscript
g_movie_setup_count = 0

script pre_movie_cleanup 
	change g_movie_setup_count = ($g_movie_setup_count + 1)

	if ($g_movie_setup_count > 1)
		return
	endif
	if NOT (isps2)
		return
	endif

	unload_songqpak
	GetHeapSize \{heap_song}
	heap_size_song = <size>
	memdeleteheap \{name = 'heap_song'}

	GetPakManCurrent \{map = zones}
	zones_pak = <pak>
	SetPakManCurrentBlock \{map = zones
		pak = none
		block_scripts = 1}
	DestroyPakManMap \{map = zones}

	UnloadPak \{'pak/oogame/oogame.pak'}
	return reset_state = {
		zones_pak = <zones_pak>
		heap_size_song = <heap_size_song>
		heap_size_zones = <heap_size_zones>
		ui_flow_manager_state = ($ui_flow_manager_state [0])
	}
endscript

script post_movie_reset 
	change g_movie_setup_count = ($g_movie_setup_count - 1)

	if ($g_movie_setup_count > 0)
		return
	endif
	if NOT ((isps2) || (IsNgc))
		return
	endif

	PushMemProfile \{'Characters'}
	MemPushContext \{heap_cas}
	if ($ps2_venues = 1)
		CreatePakManMap map = zones links = GHZones folder = 'zones_ps2/' uselinkslots size = (<size_zones> / 1024) vram_size = (<size_zones_vram> / 1024)
	else
		CreatePakManMap map = zones links = GHZones folder = 'zones/' uselinkslots size = (<size_zones> / 1024) vram_size = (<size_zones_vram> / 1024)
	endif
	MemPopContext
	ResetWaypoints
	SetPakManCurrentBlock map = zones pak = (<reset_state>.zones_pak) block_scripts = 1

	MemInitHeap name = 'heap_song' size = (<reset_state>.heap_size_song) vram_size = <heap_size_song_vram>
	PopMemProfile
endscript

script reload_venue \{force_encore = 0}
	spawnscriptnow convoluted_because_of_wait_blocking_reload_venue params = {force_encore = <force_encore>}
endscript

script convoluted_because_of_wait_blocking_reload_venue 
	shut_down_flow_manager
	PauseGame
	kill_gem_scroller
	start_song force_venue_reload = 1 force_encore = <force_encore>
endscript

script EnableAnimVideoSync 
	SetAnimSync \{mode = video}
endscript

script EnableAnim60Sync 
	SetAnimSync \{mode = everyframe}
endscript

script DisableAnimVideoSync 
	SetAnimSync \{mode = `default`}
endscript

script drum_shadow_test 
	hide
	ps2_get_musician_context_data \{name = Drummer}
	inf_loop_count = 0
	begin
	if CompositeObjectExists \{name = Drummer}
		break
	endif
	inf_loop_count = (<inf_loop_count> + 1)
	if (<inf_loop_count> > 1500)
		return
	endif
	Wait \{1
		gameframe}
	repeat
	drum_part = ($<bandmember_appearance>.CAS_Drums)
	if GotParam \{drum_part}
		if (<drum_part>.desc_id = <drum_kit>)
			unhide
			return
		endif
	endif
endscript

script UserSelectRight 
	stars
	debug_Printf \{qs(0xa378e9d2)}
	debug_PrintStruct ($edit_graphic_layer_infos)
	temp_struct = {($edit_graphic_layer_infos)}
	debug_PrintStructToFile file = 'CAL_design.txt' label = 'CAL_Design' Structure = <temp_struct>
endscript
