jowblue = 717488127
jowgreen = 771697407
joworange = -6149377
jowred = -15061505
jowyellow = -3267073

script jow_stars 



endscript

script safegetuniquecompositeobjectid \{preferredid = safefxid01}
	if NOT gotparam \{objid}
		getuniquecompositeobjectid preferredid = <preferredid>
		return uniqueid = <uniqueid>
	endif
	i = 0
	formattext textname = index '%i' i = <i>
	extendcrc <preferredid> <index> out = preferredid
	begin
	manglechecksums a = <preferredid> b = <objid>
	if NOT objectexists id = <mangled_id>
		return uniqueid = <preferredid>
	else
		i = (<i> + 1)
		formattext textname = index '%i' i = <i>
		extendcrc <preferredid> <index> out = preferredid
	endif
	repeat
endscript

script setlightintensityovertime \{i = 1.0
		time = 2.0
		steptime = 0.05}
	targeti = <i>
	getlightintensity name = <name>
	numsteps = (<time> / <steptime>)
	casttointeger \{numsteps}
	stepsize = ((<targeti> - <i>) / <numsteps>)
	begin
	i = (<i> + <stepsize>)
	setlightintensity name = <name> intensity = <i>
	wait <steptime> seconds
	repeat (<numsteps> -1)
	setlightintensity name = <name> intensity = <targeti>
endscript

script anim_key 
	obj_movetopos (<mov>) time = <time>
	obj_rotate absolute = <rot> time = <time>
	obj_waitmove
endscript

script changepasscolor \{parameter = m_pspass0materialcolor
		time = 1.0
		steptime = 0.05}
	numsteps = (<time> / <steptime>)
	casttointeger \{numsteps}
	stepr = ((<endcolor> [0] - <startcolor> [0]) / <numsteps>)
	stepg = ((<endcolor> [1] - <startcolor> [1]) / <numsteps>)
	stepb = ((<endcolor> [2] - <startcolor> [2]) / <numsteps>)
	stepa = ((<endcolor> [3] - <startcolor> [3]) / <numsteps>)
	begin
	setarrayelement arrayname = startcolor index = 0 newvalue = (<startcolor> [0] + <stepr>)
	setarrayelement arrayname = startcolor index = 1 newvalue = (<startcolor> [1] + <stepg>)
	setarrayelement arrayname = startcolor index = 2 newvalue = (<startcolor> [2] + <stepb>)
	setarrayelement arrayname = startcolor index = 3 newvalue = (<startcolor> [3] + <stepa>)
	updatematerialproperty {
		object = <objid>
		material = <material>
		parameter = <parameter>
		value = <startcolor>
	}
	wait <steptime> seconds
	repeat (<numsteps> -1)
	updatematerialproperty {
		object = <objid>
		material = <material>
		parameter = <parameter>
		value = <endcolor>
	}
endscript

script light_updateposition \{offset = (0.0, 0.0, 0.0)}
	obj_getid
	begin
	if NOT iscreated <attachobjid>
		die
	endif
	<attachobjid> :obj_getposition
	movelight name = <objid> pos = (<pos> + <offset>)
	wait \{1
		frame}
	repeat
endscript

script obj_scale \{scale = (2.0, 2.0, 2.0)
		time = 2.0}
	if gotparam \{cycle}
		begin
		obj_morphscaling target_scale = <scale> blend_duration = <time>
		wait <time> seconds
		obj_morphscaling target_scale = (1.0, 1.0, 1.0) blend_duration = <time>
		wait <time> seconds
		repeat
	else
		obj_morphscaling target_scale = <scale> blend_duration = <time>
	endif
endscript

script obj_setmaterialcolor_spawner 
	obj_killspawnedscript \{name = obj_setmaterialcolor}
	obj_spawnscriptlater obj_setmaterialcolor params = {<...>}
endscript

script blend_rgba 
	linearmap result = br from = (<a> [0]) to = (<b> [0]) basedon = <i> lowerbound = 0 upperbound = 1
	linearmap result = bg from = (<a> [1]) to = (<b> [1]) basedon = <i> lowerbound = 0 upperbound = 1
	linearmap result = bb from = (<a> [2]) to = (<b> [2]) basedon = <i> lowerbound = 0 upperbound = 1
	linearmap result = ba from = (<a> [3]) to = (<b> [3]) basedon = <i> lowerbound = 0 upperbound = 1
	rgba = [0.0 0.0 0.0 0.0]
	setarrayelement arrayname = rgba index = 0 newvalue = <br>
	setarrayelement arrayname = rgba index = 1 newvalue = <bg>
	setarrayelement arrayname = rgba index = 2 newvalue = <bb>
	setarrayelement arrayname = rgba index = 3 newvalue = <ba>
	return rgba = <rgba>
endscript

script create_avedit_fx \{viewport = bg_viewport
		clearcolor = [
			0
			0
			0
			255
		]
		blendmode = blend
		alphafromgray = 1}
	screenfx_clearfxinstances viewport = <viewport>
	change \{visualizer_events_enabled = false}
	if gotparam \{primitives}
		screenfx_addfxinstance {
			viewport = <viewport>
			name = avfx01
			scefname = avfx01
			type = audiovisualize
			on = 1
			primitives = <primitives>
			clearcolor = <clearcolor>
			blendmode = <blendmode>
			alphafromgrayscale = <alphafromgray>
			audio_params = $default_visualizer_audio_params
		}
		screenfx_addfxinstance {
			viewport = <viewport>
			name = avfx_bloom01
			scefname = avfx_bloom01
			type = bloom2
			on = 1
			materialfilter = 0
			fullscreen = 1
			subtract = [0 0 0 0]
			colormodulate = [1.0 1.0 1.0 1.0]
			saturation = 1.0
			equation = eq2
		}
		screenfx_addfxinstance {
			viewport = <viewport>
			name = uberscreenfx
			scefname = uberscreenfx
			type = uberscreenfx
			on = 1
		}
	endif
endscript

script create_avfx \{viewport = bg_viewport}
	if NOT viewportexists id = <viewport>
		return
	endif
	if screenfx_fxinstanceexists viewport = <viewport> name = bloom__simplified_
		screenfx_removefxinstance viewport = <viewport> name = bloom__simplified_
	endif
	if screenfx_fxinstanceexists viewport = <viewport> name = godray
		screenfx_removefxinstance viewport = <viewport> name = godray
	endif
	if screenfx_fxinstanceexists viewport = <viewport> name = noise_lite type = noise2
		screenfx_removefxinstance viewport = <viewport> name = noise_lite type = noise2
	endif
	if gotparam \{primitives}
		if NOT screenfx_fxinstanceexists viewport = <viewport> name = avfx01
			screenfx_addfxinstance {
				viewport = <viewport>
				name = avfx01
				scefname = avfx01
				type = audiovisualize
				on = 1
				primitives = <primitives>
				clearcolor = [0 , 0 , 0 , 255]
				audio_params = $default_visualizer_audio_params
			}
		else
			screenfx_updatefxinstanceparams {
				viewport = <viewport>
				name = avfx01
				scefname = avfx01
				type = audiovisualize
				on = 1
				primitives = <primitives>
				clearcolor = [0 , 0 , 0 , 255]
				audio_params = $default_visualizer_audio_params
			}
		endif
		if NOT screenfx_fxinstanceexists viewport = <viewport> name = avfx_bloom01
			screenfx_addfxinstance {
				viewport = <viewport>
				name = avfx_bloom01
				scefname = avfx_bloom01
				type = bloom2
				on = 1
				materialfilter = 0
				fullscreen = 1
				subtract = [0 0 0 0]
				colormodulate = [1.0 1.0 1.0 0.8]
				saturation = 1.0
				equation = eq2
			}
		endif
	elseif gotparam \{profile}
		screenfx_clearfxinstances viewport = <viewport>
		avpreset = ($default_tod_manager.avpreset)
		fxparam = ($default_tod_manager.fxparam)
		if structurecontains \{structure = profile
				avpreset}
			avpreset = (<profile>.avpreset)
		endif
		i = 0
		getarraysize <avpreset>
		begin
		formattext checksumname = avname 'AVFX_%i' i = <i> dontassertforchecksums
		screenfx_addfxinstance {
			viewport = <viewport>
			name = <avname>
			scefname = <avname>
			type = audiovisualize
			on = 1
			primitives = (<avpreset> [<i>])
			clearcolor = [0 , 0 , 0 , 255]
			audio_params = $default_visualizer_audio_params
		}
		i = (<i> + 1)
		repeat <array_size>
		if structurecontains \{structure = profile
				fxparam}
			fxparam = (<profile>.fxparam)
		endif
		if structurecontains \{structure = fxparam
				screen_fx}
			begin
			if getnextarrayelement (<fxparam>.screen_fx)
				screenfx_addfxinstance {
					viewport = <viewport>
					<element>
				}
			else
				break
			endif
			repeat
		endif
	endif
endscript

script destroy_avfx \{primitives = $og_bluephoenix
		viewport = bg_viewport}
	screenfx_clearfxinstances viewport = <viewport>
	if viewportexists id = <viewport>
		if screenfx_fxinstanceexists viewport = <viewport> name = avfx01
			screenfx_removefxinstance viewport = <viewport> name = avfx01
		endif
	endif
endscript

script display_avfx_message \{text = qs(0x7223952e)
		time = 10
		pos = (640.0, 640.0)}
	formattext textname = newtext qs(0x0204c31d) t = <text>
	if screenelementexists \{id = mb_text_container}
		destroyscreenelement \{id = mb_text_container}
	endif
	createscreenelement \{id = mb_text_container
		type = containerelement
		parent = root_window}
	createscreenelement {
		id = mb_text
		type = textelement
		parent = mb_text_container
		font = debug
		text = <newtext>
		scale = 1.5
		pos = <pos>
		just = [center center]
		rgba = [150 185 200 255]
		z_priority = 80
	}
	createscreenelement {
		id = mb_text_shadow
		type = textelement
		parent = mb_text_container
		font = debug
		text = <newtext>
		scale = 1.5
		pos = (<pos> + (1.0, 1.0))
		just = [center center]
		rgba = [0 0 0 255]
		z_priority = 79
	}
	mb_text :se_setprops \{alpha = 0}
	mb_text_shadow :se_setprops \{alpha = 0}
	mb_text :se_setprops \{alpha = 1
		time = 0.1}
	mb_text_shadow :se_setprops \{alpha = 1
		time = 0.1}
	mb_text :se_waitprops
	wait <time> seconds
	mb_text :se_setprops \{alpha = 0
		time = 0.1}
	mb_text_shadow :se_setprops \{alpha = 0
		time = 0.1}
	mb_text :se_waitprops
	if screenelementexists \{id = mb_text_container}
		destroyscreenelement \{id = mb_text_container}
	endif
endscript

script handofgod_electriccenter_glow 
	destroyscreenelement \{id = hog_electriccenter_glow}
	wait \{1
		frame}
	createscreenelement \{type = spriteelement
		parent = root_window
		id = hog_electriccenter_glow
		texture = ph_radialglow_01
		alpha = 1
		scale = (2.0, 2.0)
		dims = (800.0, 800.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = add
		z_priority = 4
		rgba = [
			140
			200
			255
			255
		]}
endscript

script handofgod_electriccenter_glow_02 
	destroyscreenelement \{id = hog_electriccenter_glow_02}
	wait \{1
		frame}
	createscreenelement \{type = spriteelement
		parent = root_window
		id = hog_electriccenter_glow_02
		texture = ph_radialglow_01
		alpha = 1
		scale = (2.0, 2.0)
		dims = (800.0, 800.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = add
		z_priority = 4
		rgba = [
			140
			200
			255
			255
		]}
	handofgod_electriccenter_glow_anim_02
endscript

script handofgod_electriccenter_glow_03 
	destroyscreenelement \{id = hog_electriccenter_glow_03}
	wait \{1
		frame}
	createscreenelement \{type = spriteelement
		parent = root_window
		id = hog_electriccenter_glow_03
		texture = ph_radialglow_01
		alpha = 1
		scale = (2.0, 2.0)
		dims = (800.0, 800.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = add
		z_priority = 4
		rgba = [
			140
			200
			255
			255
		]}
	handofgod_electriccenter_glow_anim_03
endscript

script handofgod_electriccenter_flare 
	destroyscreenelement \{id = hog_electriccenter_flare}
	wait \{1
		frame}
	createscreenelement \{type = spriteelement
		parent = root_window
		id = hog_electriccenter_flare
		texture = jow_flare02
		alpha = 1
		scale = (1.0, 1.0)
		dims = (800.0, 800.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = add
		rot_angle = 45
		z_priority = 3
		rgba = [
			120
			200
			255
			255
		]}
	wait \{1.0
		second}
	destroyscreenelement \{id = hog_electriccenter_flare}
endscript

script handofgod_electriccenter_flare_02 
	destroyscreenelement \{id = hog_electriccenter_flare_02}
	wait \{1
		frame}
	createscreenelement \{type = spriteelement
		parent = root_window
		id = hog_electriccenter_flare_02
		texture = jow_buttonflare01
		alpha = 1
		scale = (1.0, 1.0)
		dims = (20.0, 20.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = add
		z_priority = 3
		rgba = [
			220
			240
			255
			255
		]}
	handofgod_electriccenter_flare_02_anim
endscript

script handofgod_electriccenter 
	destroyscreenelement \{id = hog_electriccenter}
	wait \{1
		frame}
	createscreenelement \{type = spriteelement
		parent = root_window
		id = hog_electriccenter
		texture = ph_electricity_01
		alpha = 1
		scale = (2.0, 2.0)
		dims = (300.0, 300.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = add
		z_priority = 2
		rgba = [
			146
			200
			255
			255
		]}
	wait \{1
		frame}
	spawnscriptnow \{handofgod_electriccenter_anim_scale}
endscript

script handofgod_electriccenter_02 
	destroyscreenelement \{id = hog_electriccenter_02}
	wait \{1
		frame}
	createscreenelement \{type = spriteelement
		parent = root_window
		id = hog_electriccenter_02
		texture = ph_electricity_01
		alpha = 1
		scale = (2.0, 2.0)
		dims = (300.0, 300.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		rot_angle = 45
		blend = add
		z_priority = 2
		rgba = [
			146
			200
			255
			255
		]}
	wait \{1
		frame}
	handofgod_electriccenter_anim_scale_02
endscript

script handofgod_electriccenter_glow_anim 
	handofgod_electriccenter_glow
	begin
	hog_electriccenter_glow :se_setprops scale = (2.2, 2.2) alpha = 0.4 time = 0.05 motion = Random (@ ease_in @ ease_out )
	hog_electriccenter_glow :se_waitprops
	hog_electriccenter_glow :se_setprops scale = (2.0, 2.0) alpha = 0.6 time = 0.1 motion = Random (@ ease_in @ ease_out )
	hog_electriccenter_glow :se_waitprops
	repeat 8
	destroyscreenelement \{id = hog_electriccenter_glow}
endscript

script handofgod_electriccenter_glow_anim_02 
	begin
	hog_electriccenter_glow_02 :se_setprops \{scale = (0.5, 0.5)
		alpha = 1}
	hog_electriccenter_glow_02 :se_setprops \{scale = (3.0, 3.0)
		alpha = 0
		time = 0.2}
	hog_electriccenter_glow_02 :se_waitprops
	repeat 7
	destroyscreenelement \{id = hog_electriccenter_glow_02}
endscript

script handofgod_electriccenter_glow_anim_03 
	hog_electriccenter_glow_03 :se_setprops \{scale = (5.0, 5.0)
		alpha = 0.4}
	hog_electriccenter_glow_03 :se_setprops \{scale = (1.0, 1.0)
		alpha = 0
		time = 1}
	hog_electriccenter_glow_03 :se_waitprops
	destroyscreenelement \{id = hog_electriccenter_glow_03}
endscript

script handofgod_electriccenter_anim_scale 
	<rot> = 0
	begin
	<rot> = (<rot> + 45)
	hog_electriccenter :se_setprops rot_angle = <rot> alpha = 0
	hog_electriccenter :se_setprops \{scale = (1.0, 1.0)
		alpha = 0.3
		time = 0.1}
	hog_electriccenter :se_waitprops
	hog_electriccenter :se_setprops \{scale = (1.3, 1.3)
		alpha = 1
		time = 0.1}
	hog_electriccenter :se_waitprops
	repeat 4
	destroyscreenelement \{id = hog_electriccenter}
endscript

script handofgod_electriccenter_anim_scale_02 
	<rot> = 0
	begin
	<rot> = (<rot> + 45)
	hog_electriccenter_02 :se_setprops rot_angle = <rot>
	hog_electriccenter_02 :se_setprops \{scale = (1.0, 1.0)
		alpha = 1}
	hog_electriccenter_02 :se_waitprops
	hog_electriccenter_02 :se_setprops \{scale = (2.0, 2.0)
		alpha = 0
		time = 0.2}
	hog_electriccenter_02 :se_waitprops
	repeat 4
	destroyscreenelement \{id = hog_electriccenter_02}
endscript

script handofgod_electriccenter_flare_02_anim 
	hog_electriccenter_flare_02 :se_setprops \{scale = (200.0, 200.0)
		rot_angle = -360
		alpha = 0.5
		time = 0.1}
	hog_electriccenter_flare_02 :se_waitprops
	destroyscreenelement \{id = hog_electriccenter_flare_02}
endscript

script handofgod_electriccenter_combo 
	spawnscriptnow \{handofgod_electriccenter_glow_anim}
	spawnscriptnow \{handofgod_electriccenter}
	spawnscriptnow \{handofgod_electriccenter_02}
	spawnscriptnow \{handofgod_electriccenter_flare}
	spawnscriptnow \{handofgod_smoke_01}
	spawnscriptnow \{handofgod_electriccenter_sparks_01}
endscript

script handofgod_fx_01 
	wait \{2.0
		second}
	spawnscriptnow \{handofgod_electriccenter_glow_anim}
	spawnscriptnow \{handofgod_electriccenter}
	spawnscriptnow \{handofgod_electriccenter_02}
	spawnscriptnow \{handofgod_electriccenter_flare}
	spawnscriptnow \{handofgod_smoke_01}
	spawnscriptnow \{handofgod_electriccenter_sparks_01}
	spawnscriptnow \{handofgod_lightning_combo}
	wait \{1.0
		second}
	handofgod_electriccenter_flare_02
endscript

script handofgod_fx_02 
	wait \{2.0
		second}
	spawnscriptnow \{handofgod_electriccenter_glow_02}
	spawnscriptnow \{handofgod_electriccenter_sparks_02}
	wait \{0.0
		second}
	handofgod_smoke_02
	handofgod_electriccenter_glow_03
endscript

script handofgod_lightning_god 
	destroyscreenelement \{id = hog_lightning_god}
	wait \{1
		frame}
	createscreenelement \{type = spriteelement
		parent = root_window
		id = hog_lightning_god
		alpha = 1
		scale = (1.1, 1.1)
		just = [
			center
			center
		]
		pos = (1000.0, 140.0)
		rot_angle = 80
		material = sys_big_bolt01_sys_big_bolt01
		blend = add
		use_animated_uvs = true
		top_down_v
		frame_length = 0.08
		num_uv_frames = (8.0, 1.0)
		z_priority = 1}
	wait \{1.0
		second}
	destroyscreenelement \{id = hog_lightning_god}
endscript

script handofgod_lighting_devil 
	destroyscreenelement \{id = hog_lighting_devil}
	wait \{1
		frame}
	createscreenelement \{type = spriteelement
		parent = root_window
		id = hog_lighting_devil
		alpha = 1
		scale = (1.1, 1.1)
		just = [
			center
			center
		]
		pos = (210.0, 70.0)
		rot_angle = 280
		material = sys_big_bolt01_sys_big_bolt01
		blend = add
		use_animated_uvs = true
		top_down_v
		frame_length = 0.08
		num_uv_frames = (8.0, 1.0)
		z_priority = 1}
	wait \{1.0
		second}
	destroyscreenelement \{id = hog_lighting_devil}
endscript

script handofgod_lightning_combo 
	spawnscriptnow \{handofgod_lightning_god}
	spawnscriptnow \{handofgod_lighting_devil}
endscript

script handofgod_fx_kill 
	destroyscreenelement \{id = hog_electriccenter_glow}
	destroyscreenelement \{id = hog_electriccenter_flare}
	destroyscreenelement \{id = hog_electriccenter}
	destroyscreenelement \{id = hog_lightning_god}
	destroyscreenelement \{id = hog_lighting_devil}
endscript

script handofgod_electriccenter_sparks_01 
	destroy2dparticlesystem \{id = electriccenter_sparks_01}
	wait \{1
		frame}
	create2dparticlesystem \{id = electriccenter_sparks_01
		pos = (640.0, 260.0)
		z_priority = 2
		material = sys_particle_spark01_sys_particle_spark01
		parent = root_window
		start_color = [
			100
			200
			255
			255
		]
		end_color = [
			100
			200
			255
			0
		]
		start_scale = (1.2, 1.2)
		end_scale = (0.6, 0.5)
		start_angle_spread = 360.0
		min_rotation = -500.0
		max_rotation = 500.0
		emit_start_radius = 0.0
		emit_radius = 1.0
		emit_rate = 0.03
		emit_dir = 0.0
		emit_spread = 355.0
		velocity = 10
		friction = (0.0, 20.0)
		time = 0.5}
	wait \{1.0
		second}
	destroy2dparticlesystem \{id = electriccenter_sparks_01}
endscript

script handofgod_electriccenter_sparks_02 
	destroy2dparticlesystem \{id = electriccenter_sparks_02}
	wait \{1
		frame}
	create2dparticlesystem \{id = electriccenter_sparks_02
		pos = (640.0, 260.0)
		z_priority = 2
		material = sys_particle_spark01_sys_particle_spark01
		parent = root_window
		start_color = [
			100
			200
			255
			255
		]
		end_color = [
			100
			200
			255
			0
		]
		start_scale = (1.0, 1.0)
		end_scale = (0.6, 0.5)
		start_angle_spread = 360.0
		min_rotation = -500.0
		max_rotation = 500.0
		emit_start_radius = 0.0
		emit_radius = 1.0
		emit_rate = 0.02
		emit_dir = 0.0
		emit_spread = 355.0
		velocity = 20
		friction = (0.0, 20.0)
		time = 0.5}
	wait \{1.0
		second}
	destroy2dparticlesystem \{id = electriccenter_sparks_02}
endscript

script handofgod_smoke_01 
	destroy2dparticlesystem \{id = hog_smoke_01}
	create2dparticlesystem \{id = hog_smoke_01
		pos = (640.0, 260.0)
		z_priority = 20.0
		material = mat_hog_smoke
		parent = root_window
		start_color = [
			140
			200
			255
			175
		]
		end_color = [
			140
			200
			255
			0
		]
		start_scale = (1.0, 1.0)
		end_scale = (2.0, 2.0)
		start_angle_spread = 360.0
		min_rotation = -500.0
		max_rotation = 500.0
		emit_start_radius = 0.0
		emit_radius = 1.0
		emit_rate = 0.5
		emit_dir = 0.0
		emit_spread = 355.0
		velocity = 4
		friction = (0.0, 0.0)
		time = 0.5}
	wait \{1.0
		second}
	destroy2dparticlesystem \{id = hog_smoke_01}
endscript

script handofgod_smoke_02 
	destroy2dparticlesystem \{id = hog_smoke_02}
	create2dparticlesystem \{id = hog_smoke_02
		pos = (640.0, 260.0)
		z_priority = 20.0
		material = mat_hog_smoke
		parent = root_window
		start_color = [
			140
			200
			255
			40
		]
		end_color = [
			140
			200
			255
			0
		]
		start_scale = (2.0, 2.0)
		end_scale = (6.0, 6.0)
		start_angle_spread = 360.0
		min_rotation = -1000.0
		max_rotation = 900.0
		emit_start_radius = 2.0
		emit_radius = 3.0
		emit_rate = 0.09
		emit_dir = 0.0
		emit_spread = 355.0
		velocity = 10
		friction = (0.0, 0.0)
		time = 1}
	wait \{1.0
		second}
	destroy2dparticlesystem \{id = hog_smoke_02
		kill_when_empty}
endscript

script camerablur_fastzoom_inandout 
	if NOT bg_fx_get_start_params \{viewport = bg_viewport
			effectname = depth_of_field__simplified_}
		return
	endif
	bg_fx_set_blur \{appendstrength = 1
		time = 0.1}
	wait \{0.2
		seconds}
	bg_fx_set_blur \{appendstrength = 0
		time = 0.3}
	wait \{0.2
		seconds}
	bg_fx_set_blur \{appendstrength = 0.5
		time = 0.1}
	wait \{0.1
		second}
	bg_fx_set_blur effectparams = <startvalue> time = 0.4
endscript

script camerablur_slowzoom_inandout 
	if NOT bg_fx_get_start_params \{viewport = bg_viewport
			effectname = depth_of_field__simplified_}
		return
	endif
	bg_fx_set_blur \{appendstrength = 1
		time = 0.5}
	wait \{0.4
		seconds}
	bg_fx_set_blur \{appendstrength = 0
		time = 0.4}
	wait \{0.5
		seconds}
	bg_fx_set_blur \{appendstrength = 1
		time = 0.3}
	wait \{0.3
		second}
	bg_fx_set_blur effectparams = <startvalue> time = 0.4
endscript

script camerablur_focusin 
	if NOT bg_fx_get_start_params \{viewport = bg_viewport
			effectname = depth_of_field__simplified_}
		return
	endif
	bg_fx_set_blur \{appendstrength = 1
		time = 0}
	wait \{0.1
		second}
	bg_fx_set_blur effectparams = <startvalue> time = 0.5
endscript
