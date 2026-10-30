current_crowd = 1.0
average_crowd = 1.0
total_crowd = 0.0
max_crowd = 0.0
crowd_scale = 2.0
health_scale = 2.0
crowd_debug_mode = 0
viewercam_nofail = 0
crowd_ped_camera_dist = 3.5
crowd_ped_camera_height = 1.07
crowd_ped_camera_fov = 21
crowd_base_viewport_id = crowd_base_viewport
crowd_base_viewport_texture = `tex/models/real_crowd/crowd_atlas0.dds`

script crowd_reset \{loading_transition = 0
		restarting = 0}

	if ($game_mode = tutorial)
		return
	endif
	change \{total_crowd = 0.0}
	change \{max_crowd = 0.0}
	change \{last_time_in_lead = 0.0}
	change \{last_time_in_lead_player = -1}
	if getnodeflag \{ls_encore_post}
		0x45261787 = 1
	elseif NOT 0xf99301bb
		0x45261787 = 1
	elseif ($end_credits = 1)
		0x45261787 = 1
	elseif ($is_attract_mode = 1)
		0x45261787 = 1
	else
		0x45261787 = 0
	endif
	if (<player> = 1)
		if (<0x45261787> = 1)
			change \{current_crowd = 1.6666}
			change \{average_crowd = 1.6666}
		else
			change \{current_crowd = 1.0}
			change \{average_crowd = 1.0}
		endif
		if (<0x45261787> = 1)
			0xe8b8a61e = good
		else
			0xe8b8a61e = neutral
		endif
		stopsoundevent \{$currentlyplayingoneshotsoundevent}
		if ($current_playing_transition = loading)
			change_crowd_looping_sfx crowd_looping_state = <0xe8b8a61e>
		elseif ($game_mode = practice)
			bg_crowd_front_end_silence \{immediate = 1}
		elseif (<0x45261787> = 1)
			if scriptexists \{loading_screen_crowd_swell}
				killspawnedscript \{name = loading_screen_crowd_swell}
				setsoundbussparams {crowd_beds = {vol = ($default_bussset.crowd_beds.vol)} time = 1}
			endif
			change_crowd_looping_sfx crowd_looping_state = <0xe8b8a61e>
		elseif (<restarting> = 1)
			change_crowd_looping_sfx crowd_looping_state = <0xe8b8a61e>
		else
			change_crowd_looping_sfx crowd_looping_state = <0xe8b8a61e> loading_transition = <loading_transition> restarting = <restarting>
		endif
	endif
	getbandindexbyplayer player = ($<player_status>.player)
	band_id = ($band_ids [<band_index>])
	if (<0x45261787> = 1)
		change structurename = <player_status> current_health = 1.6666
		change structurename = <band_id> current_health = 1.6666
	else
		change structurename = <player_status> current_health = 1.0
		change structurename = <band_id> current_health = 1.0
	endif
	crowdreset
endscript

script forcescore 
	switch $debug_forcescore
		case poor
		health = ($health_poor_medium / 2)
		case medium
		health = (($health_poor_medium + $health_medium_good) / 2)
		case good
		health = (($health_medium_good + $health_scale) / 2)
		default
		health = ($health_poor_medium / 2)
	endswitch
	change structurename = <player_status> current_health = <health>
	change current_crowd = <health>
endscript
base_resolve_priority = 7

script create_crowd_models 
	if ($disable_crowd = 1)
		return
	endif
	getpakmancurrentname \{map = zones}
	formattext checksumname = crowd_models '%s_crowd_models' s = <pakname>
	if NOT globalexists name = <crowd_models>
		return
	endif
	change crowd_model_array = $<crowd_models>
	getarraysize $<crowd_models>
	array_count = 0
	begin
	pos = ((-500.0, -200.0, 0.0) + (0.0, -100.0, 0.0) * <array_count>)
	viewport = ($<crowd_models> [<array_count>].id)
	camera = ($<crowd_models> [<array_count>].camera)
	bb_sector_name = ($<crowd_models> [<array_count>].bb_mesh_id)
	if NOT structurecontains structure = ($<crowd_models> [<array_count>]) remap_only
		mempushcontext \{bottomupheap}
		createfromstructure {
			spouse = <viewport>
			pos = <pos>
			quat = (0.0, 1.0, 0.0)
			class = gameobject
			type = ghost
			createdatstart
			($<crowd_models> [<array_count>])
			suspenddistance = 0
			lod_dist1 = 400
			lod_dist2 = 401
			profile = $profile_ped_crowd_obj
			lightgroup = crowd
			interleave_animations
			object_type = crowd
			profilecolor = 49344
			profilebudget = 200
			use_jq
		}
		model_id = ($<crowd_models> [<array_count>].name)
		extra_model = 'Real_Crowd\\Crowd_HandL_Lighter.skin'
		<model_id> :addgeom lhand_lighter model = <extra_model> lightgroup = crowd spouse = <viewport>
		extra_model = 'Real_Crowd\\Crowd_HandL_Rock.skin'
		<model_id> :addgeom lhand_rock model = <extra_model> lightgroup = crowd spouse = <viewport>
		extra_model = 'Real_Crowd\\Crowd_HandL_Clap.skin'
		<model_id> :addgeom lhand_clap model = <extra_model> lightgroup = crowd spouse = <viewport>
		extra_model = 'Real_Crowd\\Crowd_HandL_Fist.skin'
		<model_id> :addgeom lhand_fist model = <extra_model> lightgroup = crowd spouse = <viewport>
		extra_model = 'Real_Crowd\\Crowd_HandR_Lighter.skin'
		<model_id> :addgeom rhand_lighter model = <extra_model> lightgroup = crowd spouse = <viewport>
		extra_model = 'Real_Crowd\\Crowd_HandR_Rock.skin'
		<model_id> :addgeom rhand_rock model = <extra_model> lightgroup = crowd spouse = <viewport>
		extra_model = 'Real_Crowd\\Crowd_HandR_Clap.skin'
		<model_id> :addgeom rhand_clap model = <extra_model> lightgroup = crowd spouse = <viewport>
		extra_model = 'Real_Crowd\\Crowd_HandR_Fist.skin'
		<model_id> :addgeom rhand_fist model = <extra_model> lightgroup = crowd spouse = <viewport>
		<model_id> :switchoffatomic lhand_lighter
		<model_id> :switchoffatomic lhand_rock
		<model_id> :switchoffatomic lhand_fist
		<model_id> :switchonatomic lhand_clap
		<model_id> :switchoffatomic rhand_lighter
		<model_id> :switchoffatomic rhand_rock
		<model_id> :switchoffatomic rhand_fist
		<model_id> :switchonatomic rhand_clap
		roty = 0
		if structurecontains structure = ($<crowd_models> [<array_count>]) roty
			roty = ($<crowd_models> [<array_count>].roty)
		endif
		if (<roty> = 0)
			apply_correction = 1
		else
			apply_correction = 0
			($<crowd_models> [<array_count>].name) :obj_setorientation y = (180 + <roty>)
		endif
		if NOT (<bb_sector_name> = 0)
			toggleintrameshsorting on = 1 objid = <bb_sector_name>
		endif
		mempopcontext \{bottomupheap}
		style = imposter_rendering
		if structurecontains structure = ($<crowd_models> [<array_count>]) viewportparams
			<style> = ($<crowd_models> [<array_count>].viewportparams)
		endif
		use_resource = 0x00000000
		if structurecontains structure = ($<crowd_models> [<array_count>]) resourceviewport
			<use_resource> = ($<crowd_models> [<array_count>].resourceviewport)
		endif

		createscreenelement {
			parent = root_window
			just = [center center]
			type = viewportelement
			id = <viewport>
			texture = ($<crowd_models> [<array_count>].texture)
			pos = (2000.0, 200.0)
			dims = (64.0, 64.0)
			alpha = 1
			style = <style>
		}
		createcompositeobjectinstance {
			priority = $coim_priority_permanent
			heap = generic
			components = [
				{component = camera}
			]
			params = {
				name = <camera>
				viewport = <viewport>
				object_type = crowd
				profilecolor = 12632064
				profilebudget = 10
				use_jq
				far_clip = 20
			}
		}
		setactivecamera viewport = <viewport> id = <camera>
		<camera> :sethfov hfov = $crowd_ped_camera_fov
		if structurecontains structure = ($<crowd_models> [<array_count>]) no_resolve_colorbuffer
			setviewportproperties viewport = <viewport> no_resolve_colorbuffer = true no_resolve_depthstencilbuffer = true crowd_impostor = true
		else
			setviewportproperties viewport = <viewport> no_resolve_depthstencilbuffer = true crowd_impostor = true
		endif
		addcrowdmodelcam camera = <camera> pos = <pos> viewport = <viewport> apply_correction = <apply_correction>
	endif
	setsearchallassetcontexts
	createviewporttextureoverride {
		id = <viewport>
		viewportid = <viewport>
		texture = ($<crowd_models> [<array_count>].textureasset)
		texdict = ($<crowd_models> [<array_count>].texdict)
	}
	setsearchallassetcontexts \{off}
	<array_count> = (<array_count> + 1)
	repeat <array_size>
endscript

script update_crowd_model_cam 
	crowd_scaler = 25
	begin
	getviewportcameraorient \{viewport = bg_viewport}
	getvectorcomponents <at>
	angle = (<x> * <crowd_scaler>)
	rotatevector vector = <at> ry = <angle>
	at = <result_vector>
	rotatevector vector = <left> ry = <angle>
	left = <result_vector>
	rotatevector vector = <up> ry = <angle>
	up = <result_vector>
	posdir = (<model_pos> + (0.0, 1.0, 0.0) + (<at> * 3.5))
	<camera> :obj_setposition position = <posdir>
	<camera> :obj_setorientation dir = <at> only handles upright cameras
	setviewportcameraorient viewport = <viewport> at = <at> left = <left> up = <up>
	<camera> :unpause
	waitonegameframe
	repeat
endscript

script hide_crowd_models \{active = true}
	crowd_models = $crowd_model_array
	if (<crowd_models> = none)
		return
	endif
	getarraysize <crowd_models>
	array_count = 0
	begin
	viewport = (<crowd_models> [<array_count>].id)
	objid = (<crowd_models> [<array_count>].name)
	if NOT structurecontains structure = (<crowd_models> [<array_count>]) remap_only
		if (<active> = true)
			<objid> :hide
		else
			<objid> :unhide
		endif
	endif
	<array_count> = (<array_count> + 1)
	repeat <array_size>
endscript

script destroy_crowd_models 
	clearcrowdmodelcams
	clearcrowdsfromvisibilitytest
	crowd_models = $crowd_model_array
	if (<crowd_models> = none)
		return
	endif
	getarraysize <crowd_models>
	array_count = 0
	begin
	if NOT structurecontains structure = (<crowd_models> [<array_count>]) remap_only
		killspawnedscript \{name = update_crowd_model_cam}
		if compositeobjectexists name = (<crowd_models> [<array_count>].camera)
			(<crowd_models> [<array_count>].camera) :die
		endif
		if screenelementexists id = (<crowd_models> [<array_count>].id)
			setsearchallassetcontexts
			destroyviewporttextureoverride id = (<crowd_models> [<array_count>].id)
			setsearchallassetcontexts \{off}
			destroyscreenelement id = (<crowd_models> [<array_count>].id)
		endif
		setsearchallassetcontexts
		destroyviewporttextureoverride id = (<crowd_models> [<array_count>].id)
		setsearchallassetcontexts \{off}
		destroyviewport id = (<crowd_models> [<array_count>].id)
		if compositeobjectexists name = (<crowd_models> [<array_count>].name)
			(<crowd_models> [<array_count>].name) :die
		endif
	endif
	<array_count> = (<array_count> + 1)
	repeat <array_size>
	destroyviewport id = ($crowd_base_viewport_id)
	change \{crowd_model_array = none}
endscript

script set_crowd_hand \{hand = left
		type = clap}
	obj_getid
	name = <objid>
	if (<hand> = left)
		switch (<type>)
			case lighter
			part = lhand_lighter
			case rock
			part = lhand_rock
			case clap
			part = lhand_clap
			case fist
			part = lhand_fist
			default
			return
		endswitch
		<name> :switchoffatomic lhand_lighter
		<name> :switchoffatomic lhand_rock
		<name> :switchoffatomic lhand_clap
		<name> :switchoffatomic lhand_fist
		<name> :switchonatomic <part>
	else
		switch (<type>)
			case lighter
			part = rhand_lighter
			case rock
			part = rhand_rock
			case clap
			part = rhand_clap
			case fist
			part = rhand_fist
			default
			return
		endswitch
		<name> :switchoffatomic rhand_lighter
		<name> :switchoffatomic rhand_rock
		<name> :switchoffatomic rhand_clap
		<name> :switchoffatomic rhand_fist
		<name> :switchonatomic <part>
	endif
endscript

script crowd_sethand \{name = crowd1
		hand = left
		type = clap}
	if compositeobjectexists <name>
		<name> :set_crowd_hand hand = <hand> type = <type>
	endif
endscript

script crowd_startlighters 
	killspawnedscript \{name = crowd_monitor_performance}
	spawnscriptnow \{crowd_monitor_performance}
endscript

script crowd_monitor_performance 
	lighters_on = false
	begin
	get_skill_level
	if (<skill> != bad)
		if (<lighters_on> = false)
			crowd_allsethand \{hand = right
				type = lighter}
			crowd_allplayanim \{anim = special}
			lighters_on = true
			crowd_togglelighters \{on}
		endif
	else
		if (<lighters_on> = true)
			crowd_allsethand \{hand = right
				type = clap}
			crowd_allplayanim \{anim = idle}
			lighters_on = false
			crowd_togglelighters \{off}
		endif
	endif
	waitonegameframe
	repeat
endscript

script crowd_stoplighters 
	killspawnedscript \{name = crowd_monitor_performance}
	crowd_allsethand \{hand = right
		type = clap}
	crowd_allplayanim \{anim = idle}
	crowd_togglelighters \{off}
endscript

script crowd_allsethand 
	crowd_sethand name = crowd1 hand = <hand> type = <type>
	crowd_sethand name = crowd2 hand = <hand> type = <type>
	crowd_sethand name = crowd3 hand = <hand> type = <type>
	crowd_sethand name = crowd4 hand = <hand> type = <type>
	crowd_sethand name = crowd5 hand = <hand> type = <type>
	crowd_sethand name = crowd6 hand = <hand> type = <type>
	crowd_sethand name = crowd7 hand = <hand> type = <type>
	crowd_sethand name = crowd8 hand = <hand> type = <type>
endscript

script crowd_allplayanim \{playonce = false}
	waitonegameframe
	crowd_playanim name = crowd1 anim = <anim> playonce = <playonce>
	waitonegameframe
	crowd_playanim name = crowd2 anim = <anim> playonce = <playonce>
	waitonegameframe
	crowd_playanim name = crowd3 anim = <anim> playonce = <playonce>
	waitonegameframe
	crowd_playanim name = crowd4 anim = <anim> playonce = <playonce>
	waitonegameframe
	crowd_playanim name = crowd5 anim = <anim> playonce = <playonce>
	waitonegameframe
	crowd_playanim name = crowd6 anim = <anim> playonce = <playonce>
	waitonegameframe
	crowd_playanim name = crowd7 anim = <anim> playonce = <playonce>
	waitonegameframe
	crowd_playanim name = crowd8 anim = <anim> playonce = <playonce>
endscript

script crowd_playanim \{name = crowd1
		anim = idle
		playonce = false}
	if NOT compositeobjectexists <name>
		return
	endif
	if structurecontains structure = ($crowd_profiles) name = <name>
		anim_set = ($crowd_profiles.<name>.anim_set)
		<name> :obj_killspawnedscript name = crowd_play_adjusting_random_anims
		<name> :obj_spawnscriptnow crowd_play_adjusting_random_anims params = {anim_set = <anim_set> anim = <anim> playonce = <playonce>}
	else

	endif
endscript

script crowd_create_lighters 
	getpakmancurrent \{map = zones}
	if (<pak> = z_artdeco)
		return
	endif
	getpakmancurrentname \{map = zones}
	index = 0
	begin
	if (<index> < 10)
		formattext checksumname = crowd_lighter '%s_LIGHTER_Geo0%a' s = <pakname> a = <index>
	else
		formattext checksumname = crowd_lighter '%s_LIGHTER_Geo%a' s = <pakname> a = <index>
	endif
	if compositeobjectexists name = <crowd_lighter>
		<crowd_lighter> :hide
	else
		if isinnodearray <crowd_lighter>
			if NOT iscreated <crowd_lighter>
				create name = <crowd_lighter>
				if compositeobjectexists name = <crowd_lighter>
					<crowd_lighter> :hide
				else

				endif
			else
			endif
		else
		endif
	endif
	index = (<index> + 1)
	if (<index> = 15)
		break
	endif
	repeat
endscript

script crowd_togglelighters 
	getpakmancurrentname \{map = zones}
	index = 0
	begin
	if (<index> < 10)
		formattext checksumname = crowd_lighter '%s_LIGHTER_Geo0%a' s = <pakname> a = <index>
	else
		formattext checksumname = crowd_lighter '%s_LIGHTER_Geo%a' s = <pakname> a = <index>
	endif
	if compositeobjectexists name = <crowd_lighter>
		if gotparam \{on}
			<crowd_lighter> :unhide
		elseif gotparam \{off}
			<crowd_lighter> :hide
		endif
	endif
	index = (<index> + 1)
	if (<index> = 15)
		break
	endif
	repeat
endscript

script crowd_stagediver_hide \{index = 1}
	getpakmancurrentname \{map = zones}
	formattext checksumname = stagediver '%s_TRG_Ped_StageDive0%a' s = <pakname> a = <index>
	if compositeobjectexists name = <stagediver>
		<stagediver> :hide
	endif
endscript

script crowd_stagediver_jump \{index = 1}
	getpakmancurrentname \{map = zones}
	formattext checksumname = stagediver '%s_TRG_Ped_StageDive0%a' s = <pakname> a = <index>
	if compositeobjectexists name = <stagediver>
		<stagediver> :unhide
		getpakmancurrent \{map = zones}
		if structurecontains structure = ($stagediver_anims) name = <pak>
			anims = ($stagediver_anims.<pak>)
		else
			anims = ($stagediver_anims.`default`)
		endif
		getarraysize <anims>
		getrandomvalue name = anim_index integer a = 0 b = (<array_size> - 1)
		anim_name = (<anims> [<anim_index>])

		<stagediver> :gameobj_playanim anim = <anim_name>
		<stagediver> :gameobj_waitanimfinished
		<stagediver> :hide
	else

	endif
endscript
