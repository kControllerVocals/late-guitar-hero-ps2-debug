cas_object_name_list = [
	cas_musician1
	cas_musician2
	cas_musician3
	cas_musician4
]
cas_queue_min_frames_between_jobs = 12
cas_queue_min_frames_between_jobs_fast_cas = 6

script cas_queue_add_request 


	if ((<player> < 1) || (<player> > 4))

	endif
	index = (<player> - 1)
	GenerateChecksumFromStruct \{StructName = appearance}
	if NOT StructureContains Structure = ($cas_queue_player_info [<index>]) pos
		cas_set_object_node_pos player = <player>
	endif
	player_info = ($cas_queue_player_info [<index>])
	if NOT GotParam \{force_update}
		if StructureContains Structure = <player_info> object

			old_object = (<player_info>.object)
		endif
		if cas_queue_is_busy \{characters_only}
			if (($cas_queue_current_job.current_player_index) = <index>)
				if (($cas_queue_current_job.appearance_checksum) = <structure_checksum>)
					if NOT GotParam \{in_cas}

						return
					endif
				endif
				CasCancelLoading
				cancelled_loading = 1

				if GotParam \{old_object}
					if CompositeObjectExists name = <old_object>
						if NOT <old_object> :GetSingleTag body_checksum

						endif
						current_body_checksum = <body_checksum>
					endif
				endif
			endif
		endif
		if NOT GotParam \{cancelled_loading}
			if GotParam \{old_object}
				if CompositeObjectExists name = <old_object>
					if NOT <old_object> :GetSingleTag appearance_checksum

					endif
					if NOT <old_object> :GetSingleTag body_checksum

					endif
					if (<appearance_checksum> = <structure_checksum>)
						if NOT GotParam \{in_cas}

							return
						endif
					endif
					current_body_checksum = <body_checksum>
				endif
			endif
		endif
	endif

	fast_cas_update = 0
	if GotParam \{in_cas}
		get_body_checksum_from_appearance appearance = <appearance>
		if GotParam \{current_body_checksum}
			if (<current_body_checksum> = <body_checksum>)
				fast_cas_update = 1
			endif
		endif
		if GotParam \{instrument}
			cas_object = (<player_info>.object)
			if GotParam \{cas_object}
				<cas_object> :GetSingleTag current_instrument
				if NOT (<current_instrument> = <instrument>)
					fast_cas_update = 0
				endif
			endif
		endif
	endif
	GetLogicFrame
	get_is_female_from_appearance appearance = <appearance>
	player_info = {
		<player_info>
		pending_appearance = <appearance>
		pending_instrument = <instrument>
		pending_is_female = <is_female>
		requested_frame = <LogicFrame>
		fast_cas_update = <fast_cas_update>
		hide_old_character = <hide_old_character>
	}
	SetArrayElement ArrayName = cas_queue_player_info GlobalArray index = <index> newvalue = <player_info>
	spawnscriptnow cas_queue_update params = {new_request_index = <index>}
endscript

script cas_queue_kill_player 


	if ((<player> < 1) || (<player> > 4))

	endif
	index = (<player> - 1)
	if cas_queue_is_busy \{characters_only}
		if (($cas_queue_current_job.current_player_index) = <index>)
			CasCancelLoading
			if StructureContains \{Structure = $cas_queue_current_job
					old_object}
				old_object = ($cas_queue_current_job.old_object)
				if CompositeObjectExists name = <old_object>
					cas_queue_internal_destroy_object object = <old_object> kill_pending_jobs
					return
				endif
			endif
		endif
	endif
	if cas_player_has_character_object player = <player>
		cas_queue_internal_destroy_object object = <character_object> kill_pending_jobs
	endif
	player_info = ($cas_queue_player_info [<index>])
	cas_queue_remove_job_details player_info = <player_info> index = <index>
endscript

script cas_cancel_loading_callback 
	if ($cas_queue_waiting_to_start = 1)
		change \{cas_queue_waiting_to_start_cancelled = 1}
	endif
endscript

script cancel_all_cas_loads 
	if cas_queue_is_busy \{characters_only}
		active_player = ($cas_queue_current_job.current_player_index)
	else
		active_player = 999
	endif
	if GotParam \{except}
		except = (<except> -1)
	else
		except = 999
	endif
	i = 0
	begin
	if (<i> != <except>)
		if (<i> = <active_player>)
			CasCancelLoading
		else
			player_info = ($cas_queue_player_info [<i>])
			cas_queue_remove_job_details player_info = <player_info> index = <i>
			if GotParam \{kill}
				if StructureContains Structure = <player_info> requested_frame
					cas_queue_kill_player player = (<i> + 1)
				endif
			endif
		endif
	endif
	i = (<i> + 1)
	repeat 4
	if GotParam \{kill}
		if (<active_player> <= 4)
			if NOT (<active_player> = <except>)
				cas_queue_kill_player player = (<active_player> + 1)
			endif
		endif
	endif
endscript

script cas_queue_update 

	SetScriptCannotPause
	if ScriptIsRunning \{UpdateCurrentCASModelSpawned}

		return
	endif
	if GotParam \{new_request_index}
		cas_start_loading_anim player_index = <new_request_index>
	endif
	if cas_queue_is_busy
		return
	endif
	OnExitRun \{cas_queue_update_death}
	if ($cas_queue_lock = 1)

	endif
	change \{cas_queue_lock = 1}
	cas_queue_rawpak_update
	if cas_queue_get_next_entry
		cas_start_loading_anim player_index = <index>
		player_info = ($cas_queue_player_info [<index>])
		fast_cas_update = (<player_info>.fast_cas_update)
		new_appearance = (<player_info>.pending_appearance)
		new_instrument = (<player_info>.pending_instrument)
		hide_old_character = (<player_info>.hide_old_character)
		cas_queue_prepare_new_object player_info = <player_info>
		cas_queue_start_job new_object = <new_object> old_object = <old_object> index = <index>
		min_frames = ($cas_queue_min_frames_between_jobs)
		if (<fast_cas_update> = 1)
			min_frames = ($cas_queue_min_frames_between_jobs_fast_cas)
		endif
		if ($cas_queue_waiting_to_start_cancelled = 1)

		endif
		change \{cas_queue_waiting_to_start = 1}
		begin
		GetLogicFrame
		waited = (<LogicFrame> - ($cas_queue_last_job_frame))
		if (<waited> >= <min_frames>)
			break
		endif
		if ($cas_queue_waiting_to_start_cancelled = 1)
			break
		endif
		Wait \{1
			gameframe}

		repeat
		change cas_queue_last_job_frame = <LogicFrame>
		change \{cas_queue_waiting_to_start = 0}
		if ($cas_queue_waiting_to_start_cancelled = 0)
			if NOT ScreenElementExists id = ($cas_queue_current_job.control_object)
				CreateScreenElement {
					parent = root_window
					type = ContainerElement
					id = ($cas_queue_current_job.control_object)
				}
			endif
			if (<fast_cas_update> = 1)
				($cas_queue_current_job.control_object) :SetTags control_building = 1
				RunScriptOnScreenElement id = ($cas_queue_current_job.control_object) cas_queue_fast_update params = {
					cas_object = <new_object>
					appearance = <new_appearance>
					instrument = <new_instrument>
				}
				begin
				if ScreenElementExists id = ($cas_queue_current_job.control_object)
					($cas_queue_current_job.control_object) :GetTags
					if (<control_building> = 0)
						break
					endif
					RemoveParameter \{control_building}
				else
					break
				endif
				Wait \{1
					gameframe}
				repeat
			else
				($cas_queue_current_job.control_object) :SetTags control_building = 1
				RunScriptOnScreenElement id = ($cas_queue_current_job.control_object) cas_queue_build_new_character params = {
					index = <index>
					old_object = <old_object>
					new_object = <new_object>
					profile = {
						name = 'frontendguy'
						appearance = <new_appearance>
					}
					instrument = <new_instrument>
					hide_old_character = <hide_old_character>
				}
				begin
				if ScreenElementExists id = ($cas_queue_current_job.control_object)
					($cas_queue_current_job.control_object) :GetTags
					if (<control_building> = 0)
						break
					endif
					RemoveParameter \{control_building}
				else
					break
				endif
				Wait \{1
					gameframe}
				repeat
			endif
		else

			change \{cas_queue_waiting_to_start_cancelled = 0}
		endif
		if ($cas_queue_waiting_to_start_cancelled = 1)

		endif
		player_info = ($cas_queue_player_info [<index>])
		if NOT StructureContains Structure = <player_info> requested_frame
			cas_stop_loading_anim player_index = <index>
		endif
		change \{cas_queue_current_job = {
			}}
		change \{cas_queue_lock = 0}
		spawnscriptnow \{cas_queue_update}
	endif
	change \{cas_queue_lock = 0}
	OnExitRun \{nullscript
		overwrite = true}
endscript

script cas_queue_update_death 

endscript

script cas_queue_rawpak_update 
	if ExistsPakManMap \{map = cas_rawpaks}
		begin
		if ($cas_queue_rawpak = none)
			break
		endif
		current_loading_rawpak = ($cas_queue_rawpak)
		change \{cas_queue_rawpak = none}
		if NOT ExistsPakManMap \{map = cas_rawpaks}

			return
		endif
		if NOT cas_rawpak_check_current check = <current_loading_rawpak>
			SetPakManCurrent map = cas_rawpaks pak = <current_loading_rawpak>
			cas_rawpak_wait_for_load
		endif
		repeat
	endif
endscript

script cas_queue_get_next_entry 
	GetArraySize \{$cas_queue_player_info}
	i = 0
	begin
	player_info = ($cas_queue_player_info [<i>])
	if StructureContains Structure = <player_info> requested_frame
		frame = (<player_info>.requested_frame)
		if NOT GotParam \{earliest_frame}
			earliest_frame = <frame>
		endif
		if (<frame> <= <earliest_frame>)
			earliest_frame = <frame>
			earliest_frame_index = <i>
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	if GotParam \{earliest_frame_index}
		return true index = <earliest_frame_index>
	endif
	return \{false}
endscript

script cas_queue_prepare_new_object 
	if StructureContains Structure = <player_info> object
		old_object = (<player_info>.object)
	endif
	if (<player_info>.fast_cas_update = 1)
		if NOT CompositeObjectExists name = <old_object>

		endif
		new_object = <old_object>
		RemoveParameter \{old_object}
	else
		if GotParam \{old_object}
			cas_queue_internal_destroy_object object = <old_object>
			return new_object = <old_object>
		endif
		if cas_queue_get_unused_object
			new_object = <unused_object>
		else
			if NOT GotParam \{old_object}

			endif
			cas_queue_internal_destroy_object object = <old_object>
			new_object = <old_object>
			RemoveParameter \{old_object}
		endif
		if CompositeObjectExists name = <new_object>

		endif
	endif
	return old_object = <old_object> new_object = <new_object>
endscript

script cas_queue_start_job 

	player_info = ($cas_queue_player_info [<index>])
	GenerateChecksumFromStruct struct = (<player_info>.pending_appearance)
	appearance_checksum = <structure_checksum>
	get_body_checksum_from_appearance appearance = (<player_info>.pending_appearance)
	is_female = (<player_info>.pending_is_female)
	control_object = default_control
	switch (<new_object>)
		case cas_musician1
		control_object = cas_musician1_control
		case cas_musician2
		control_object = cas_musician2_control
		case cas_musician3
		control_object = cas_musician3_control
		case cas_musician4
		control_object = cas_musician4_control
	endswitch
	change cas_queue_current_job = {
		new_object = <new_object>
		old_object = <old_object>
		current_player_index = <index>
		appearance_checksum = <appearance_checksum>
		body_checksum = <body_checksum>
		is_female = <is_female>
		control_object = <control_object>
	}
	cas_queue_remove_job_details player_info = <player_info> index = <index> startedjob
endscript

script cas_queue_remove_job_details 
	RemoveComponent \{structure_name = player_info
		name = pending_appearance}
	RemoveComponent \{structure_name = player_info
		name = pending_instrument}
	RemoveComponent \{structure_name = player_info
		name = pending_is_female}
	RemoveComponent \{structure_name = player_info
		name = requested_frame}
	RemoveComponent \{structure_name = player_info
		name = fast_cas_update}
	RemoveComponent \{structure_name = player_info
		name = hide_old_character}
	SetArrayElement ArrayName = cas_queue_player_info GlobalArray index = <index> newvalue = <player_info>
	if NOT GotParam \{startedjob}
		cas_stop_loading_anim player_index = <index>
	endif
endscript

script cas_queue_build_new_character \{instrument = none}
	if GotParam \{old_object}
		if CompositeObjectExists name = <old_object>
			cas_queue_internal_destroy_object object = <old_object>
		endif
	endif
	assigned_control_object = ($cas_queue_current_job.control_object)
	player_info = ($cas_queue_player_info [<index>])
	ui_event_get_stack
	if ((<stack> [0].base_name) = 'band_mode')
		hide_old_character = 1
	elseif ((<stack> [0].base_name) = 'character_hub')
		hide_old_character = 1
	endif
	if GotParam \{hide_old_character}
		if GotParam \{old_object}
			if CompositeObjectExists name = <old_object>
				cas_queue_internal_destroy_object object = <old_object>
			endif
		endif
	endif
	if create_frontend_musician {
			profile = <profile>
			name = <new_object>
			async = 1
			pos = (<player_info>.pos)
			dir = (<player_info>.dir)
			instrument = <instrument>
		}
		stars

		stars
		player_info = ($cas_queue_player_info [<index>])
		<new_object> :Obj_SetPosition position = (<player_info>.pos)
		<new_object> :Obj_SetOrientation dir = (<player_info>.dir)
		player_info = {
			<player_info>
			object = <new_object>
		}
		SetArrayElement ArrayName = cas_queue_player_info GlobalArray index = <index> newvalue = <player_info>
		FormatText checksumname = aliasname 'cas_player%d' d = (<index> + 1)
		AssignAlias id = <new_object> alias = <aliasname>
		if ($band_mode_mode = none)
		else
			Band_PlayAnim name = <new_object> Anim = PopIn no_wait
		endif
	else
		stars

		stars
		if CompositeObjectExists name = <new_object>
			cas_queue_internal_destroy_object object = <new_object>
		endif
	endif
	(<assigned_control_object>) :SetTags control_building = 0
endscript

script cas_queue_new_character_profile 

	get_musician_profile_struct_by_id id = <id> savegame = <savegame>
	cas_queue_add_request appearance = (<profile_struct>.appearance) player = <player> force_update = <force_update> hide_old_character = <hide_old_character>
endscript

script cas_queue_get_unused_object 
	GetArraySize \{$cas_object_name_list}
	i = 0
	begin
	object = ($cas_object_name_list [<i>])
	if NOT CompositeObjectExists name = <object>
		return true unused_object = <object>
	endif
	i = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script cas_queue_internal_destroy_object 
	destroy_band_member name = <object>
	GetArraySize \{$cas_queue_player_info}
	i = 0
	begin
	player_info = ($cas_queue_player_info [<i>])
	if StructureContains Structure = <player_info> object
		if ((<player_info>.object) = <object>)
			RemoveComponent \{structure_name = player_info
				name = object}
			if GotParam \{kill_pending_jobs}
				cas_queue_remove_job_details player_info = <player_info> index = <i>
			else
				SetArrayElement ArrayName = cas_queue_player_info GlobalArray index = <i> newvalue = <player_info>
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script cas_queue_is_busy 
	if StructureContains \{Structure = $cas_queue_current_job
			new_object}
		return true busy_player = ($cas_queue_current_job.current_player_index)
	endif
	if GotParam \{in_queue_too}
		if cas_queue_get_next_entry
			return \{true}
		endif
	endif
	if NOT GotParam \{characters_only}
		if ($cas_queue_lock = 1)
			return \{true}
		endif
	endif
	return \{false}
endscript

script cas_queue_wait 
	begin
	if NOT cas_queue_is_busy in_queue_too <...>
		break
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script cas_destroy_all_characters 
	ps2_load_car_part_script

	cas_queue_kill_player \{player = 1}
	cas_queue_kill_player \{player = 2}
	cas_queue_kill_player \{player = 3}
	cas_queue_kill_player \{player = 4}
endscript

script cas_player_has_character_object 
	if ((<player> < 1) || (<player> > 4))

	endif
	index = (<player> - 1)
	player_info = ($cas_queue_player_info [<index>])
	if StructureContains Structure = <player_info> object
		if CompositeObjectExists name = (<player_info>.object)
			return true character_object = (<player_info>.object)
		endif
	endif
	return \{false}
endscript

script cas_player_has_pending_request 
	if ((<player> < 1) || (<player> > 4))
		return \{false}
	endif
	index = (<player> - 1)
	player_info = ($cas_queue_player_info [<index>])
	if StructureContains Structure = <player_info> requested_frame
		return \{true}
	endif
	return \{false}
endscript

script cas_get_is_female 
	if ((<player> < 1) || (<player> > 4))

	endif
	index = (<player> - 1)
	player_info = ($cas_queue_player_info [<index>])
	if StructureContains Structure = <player_info> pending_is_female

		return is_female = (<player_info>.pending_is_female)
	endif
	if cas_queue_is_busy \{characters_only}
		if (($cas_queue_current_job.current_player_index) = <index>)

			return is_female = ($cas_queue_current_job.is_female)
		endif
	endif
	if NOT StructureContains Structure = <player_info> object



		return \{is_female = 0}
	endif
	old_object = (<player_info>.object)
	if NOT CompositeObjectExists name = <old_object>

	endif
	if NOT <old_object> :GetSingleTag is_female

	endif

	return is_female = <is_female>
endscript

script cas_queue_fast_update instrument = ($cas_current_instrument) async = 1
	ps2_get_musician_context_data name = <cas_object>
	get_hat_hair_choice appearance = <appearance>
	buildscriptparams = {<buildscriptparams> instrument = <instrument> temporary_heap = heap_cas lightgroup = <lightgroup> hat_hair_choice = <hat_hair_choice> fast_update}
	<cas_object> :GetSingleTag current_instrument
	<cas_object> :Obj_ClearGeoms
	DiffAppearances {
		current_appearance = ($<bandmember_appearance>) current_instrument = <current_instrument>
		new_appearance = <appearance> new_instrument = <instrument>
	}
	ChangeAppearancePaks {
		current_appearance = ($<bandmember_appearance>) current_instrument = <current_instrument>
		new_appearance = <appearance> new_instrument = <instrument>
		heap = <asset_heap> asset_context = <asset_heap>
		diff_array = <diff_array>
		diff_array_size = <diff_array_size>
	}
	change globalname = <bandmember_appearance> newvalue = (<appearance>)
	<cas_object> :SetTags current_instrument = <instrument>
	if NOT GotParam \{buildScript}
		buildScript = create_model_from_appearance
	endif
	CASWaitForLoading
	flush_part_cache
	if GotParam \{cancelled}
		($cas_queue_current_job.control_object) :SetTags control_building = 0
		return \{false}
	endif
	params = {
		appearance = <appearance>
		buildScript = <buildScript>
		buildscriptparams = <buildscriptparams>
	}
	<cas_object> :ModelBuilder_Build <params>
	GenerateChecksumFromStruct struct = <appearance>
	<cas_object> :SetTags appearance_checksum = <structure_checksum>
	if (<instrument> = drum)
		FormatText checksumname = skeleton 'drummer_skeleton%am' a = <asset_slot_num>
		get_is_female_from_appearance appearance = <appearance>
		if (<is_female> = 1)
			<cas_object> :Anim_Command target = FemaleDiff command = ApplyFemaleDrummerDifference_SetAnim params = {Anim = GH_Rocker_Female_Drummer_D}
			<cas_object> :Anim_Command target = FemaleDiff_droid command = ApplyFemaleDrummerDifference_SetAnim params = {Anim = GH_Rocker_Female_Drummer_D}
			FormatText checksumname = skeleton 'drummer_skeleton%af' a = <asset_slot_num>
		endif
		if get_key_from_appearance key = drummer_skeleton appearance = (<appearance>)
			FormatText checksumname = skeleton '%a' a = <drummer_skeleton>
		endif
		if ((<skeleton> = gh_drummer_lars_1))
			<name> :Anim_Command target = FemaleDiff command = ApplyFemaleDrummerDifference_SetAnim params = {Anim = GH_Rocker_Lars_Drummer_D}
		endif
		if ((<skeleton> = gh_drummer_axel_1) || (<skeleton> = gh_drummer_rocktopus))
			<name> :Anim_Command target = FemaleDiff command = ApplyFemaleDrummerDifference_SetAnim params = {Anim = GH_Rocker_Axel_Drummer_D}
		endif
		<cas_object> :cas_drum_stick_bake_transforms part = cas_drums_sticks_l SkeletonName = <skeleton> material_index = 0
		<cas_object> :cas_drum_stick_bake_transforms part = cas_drums_sticks_r SkeletonName = <skeleton> material_index = 1
	endif
	if NOT GotParam \{loading_into_song}
		if NOT (<instrument> = drum)
			FormatText checksumname = skeleton 'rocker_skeleton%am' a = <asset_slot_num>
			get_is_female_from_appearance appearance = <appearance>
			if (<is_female> = 1)
				FormatText checksumname = skeleton 'rocker_skeleton%af' a = <asset_slot_num>
			endif
			if get_key_from_appearance key = rocker_skeleton appearance = ($cas_current_appearance)
				FormatText checksumname = skeleton '%a' a = <rocker_skeleton>
			endif
			if ((<skeleton> = gh_rocker_axel_1) || (<skeleton> = gh_rocker_rocktopus))
				<name> :cas_apply_bone_transforms bone_info = {bone = Bone_IK_Hand_Slave_L translation = {value = (0.0, 0.038, 0.0)}}
			endif
		endif
	endif
	<cas_object> :unhide
	shadow_models = []
	get_key_from_appearance key = shadow_models appearance = (<appearance>)
	switch (<instrument>)
		case guitar
		case Bass
		shadow_key = 'car_guitar_shadow01'
		shadow_pak_key = 'pak/models/shadows/car_guitar_shadow01.pak'
		case Vocals
		shadow_key = 'car_mic_shadow01'
		shadow_pak_key = 'pak/models/shadows/car_mic_shadow01.pak'
		case drum
		default
		shadow_key = no_shadow
		shadow_pak_key = no_shadow_pak
	endswitch
	if NOT (<shadow_key> = no_shadow)
		AddArrayElement array = <shadow_models> element = (<shadow_key>)
		shadow_models = <array>
	endif
	<cas_object> :Obj_ShadowOn ShadowType = volume ShadowVolumeModels = (<shadow_models>)
	<cas_object> :Obj_ShadowFinalize
	<cas_object> :Obj_ShadowShow
	($cas_queue_current_job.control_object) :SetTags control_building = 0
	return \{true}
endscript

script cas_set_object_node_pos \{instrument = none}

	index = (<player> - 1)
	if GotParam \{node}
		GetWaypointPos name = <node>
		GetWaypointDir name = <node>
	else
		if GetInstrumentNodeName instrument = <instrument>
			GetWaypointPos name = <instrument_node_name>
			GetWaypointDir name = <instrument_node_name>
		else
			GetWaypointPos \{name = $CAS_node_name}
			GetWaypointDir \{name = $CAS_node_name}
		endif
	endif
	if ($autolaunch_cas_artist = 1)
		if GetNode \{Z_ObjViewer_TRG_01}

			<pos> = (<node>.pos)
			<dir> = (0.0, 0.0, 1.0)
			spawnscriptnow cas_wait_and_move params = {pos = <pos> dir = <dir> player = <player>}
		endif
	endif
	player_info = ($cas_queue_player_info [<index>])
	player_info = {
		<player_info>
		pos = <pos>
		dir = <dir>
	}
	SetArrayElement ArrayName = cas_queue_player_info GlobalArray index = <index> newvalue = <player_info>
	if cas_player_has_character_object player = <player>
		newpos = <pos>
		<character_object> :Obj_GetPosition
		<character_object> :Obj_SetPosition position = <newpos>
		if NOT (<pos> = <newpos>)
			<character_object> :Obj_SetOrientation dir = <dir>
		endif
	endif
endscript

script cas_wait_and_move 
	index = (<player> - 1)
	begin
	if StructureContains Structure = ($cas_queue_player_info [<index>]) object
		<object> = ($cas_queue_player_info [<index>].object)
		<object> :Obj_SetPosition position = <pos>
		<object> :Obj_SetOrientation dir = <dir>
		break
	endif
	Wait \{1
		gameframe}
	repeat 120
endscript

script cas_queue_block 
	begin
	if NOT cas_queue_is_busy in_queue_too <...>
		return
	endif
	CASBlockForLoading
	CasBlockForComposite
	Wait \{1
		gameframe}
	repeat
endscript

script cas_get_loading_id 
	FormatText checksumname = id 'cas_loading_clock_%d' d = <player_index> AddToStringLookup = true
	return id = <id>
endscript

script cas_start_loading_anim 

	cas_get_loading_id player_index = <player_index>
	get_cas_loading_pos player_index = <player_index>
	if ScreenElementExists id = <id>
		<id> :Obj_KillSpawnedScript name = kill_watch_timer
		<id> :SE_SetProps pos = <pos>
		<id> :Obj_SpawnScriptNow watch_animate_in params = {time = 0.2}
	else
		make_watch_timer id = <id> pos = <pos>
	endif
endscript

script cas_stop_loading_anim 
	cas_get_loading_id player_index = <player_index>
	if ScreenElementExists id = <id>
		<id> :Obj_SpawnScriptNow kill_watch_timer
	endif
endscript

script kill_watch_timer 
	SetScriptCannotPause
	watch_animate_out \{time = 0.2}
	Wait \{0.2
		seconds}
	Die
endscript

script get_cas_loading_pos 

	if (<player_index> > 3)

	endif
	switch ($cas_loading_setup)
		case Band
		switch <player_index>
			case 0
			return \{pos = (-100.0, -375.0)}
			case 1
			return \{pos = (133.0, -375.0)}
			case 2
			return \{pos = (366.0, -375.0)}
			case 3
			return \{pos = (600.0, -375.0)}
		endswitch
		case h2h
		switch <player_index>
			case 0
			return \{pos = (-37.5, -375.0)}
			case 1
			return \{pos = (600.0, -375.0)}
		endswitch
		case single
		return \{pos = (460.0, -375.0)}
		default

	endswitch

endscript

script set_cas_loading_setup 

	change cas_loading_setup = <setup>
	i = 0
	begin
	cas_get_loading_id player_index = <i>
	if ScreenElementExists id = <id>
		get_cas_loading_pos player_index = <i>
		<id> :SE_SetProps pos = <pos>
	endif
	i = (<i> + 1)
	repeat 4
endscript
