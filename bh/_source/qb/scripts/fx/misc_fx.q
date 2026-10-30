
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
obj_scale = 0x24d8810d

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
