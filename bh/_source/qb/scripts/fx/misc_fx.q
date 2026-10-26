
script SafeGetUniqueCompositeObjectID \{preferredID = safeFXID01}
	if NOT GotParam \{ObjID}
		GetUniqueCompositeObjectID preferredID = <preferredID>
		return uniqueID = <uniqueID>
	endif
	i = 0
	FormatText TextName = index '%i' i = <i>
	ExtendCRC <preferredID> <index> out = preferredID
	begin
	MangleChecksums a = <preferredID> b = <ObjID>
	if NOT ObjectExists id = <mangled_ID>
		return uniqueID = <preferredID>
	else
		i = (<i> + 1)
		FormatText TextName = index '%i' i = <i>
		ExtendCRC <preferredID> <index> out = preferredID
	endif
	repeat
endscript

script SetLightIntensityOverTime \{i = 1.0
		time = 2.0
		stepTime = 0.05}
	targetI = <i>
	GetLightIntensity name = <name>
	numSteps = (<time> / <stepTime>)
	CastToInteger \{numSteps}
	stepSize = ((<targetI> - <i>) / <numSteps>)
	begin
	i = (<i> + <stepSize>)
	SetLightIntensity name = <name> intensity = <i>
	Wait <stepTime> seconds
	repeat (<numSteps> -1)
	SetLightIntensity name = <name> intensity = <targetI>
endscript

script Light_UpdatePosition \{offset = (0.0, 0.0, 0.0)}
	Obj_GetID
	begin
	if NOT IsCreated <attachObjID>
		Die
	endif
	<attachObjID> :Obj_GetPosition
	MoveLight name = <ObjID> pos = (<pos> + <offset>)
	Wait \{1
		frame}
	repeat
endscript
Obj_Scale = ASSERT_ON_USE

script Obj_SetMaterialColor_Spawner 
	Obj_KillSpawnedScript \{name = Obj_SetMaterialColor}
	Obj_SpawnScriptLater Obj_SetMaterialColor params = {<...>}
endscript

script Blend_RGBA 
	LinearMap result = bR from = (<a> [0]) to = (<b> [0]) basedOn = <i> lowerBound = 0 upperBound = 1
	LinearMap result = bG from = (<a> [1]) to = (<b> [1]) basedOn = <i> lowerBound = 0 upperBound = 1
	LinearMap result = bB from = (<a> [2]) to = (<b> [2]) basedOn = <i> lowerBound = 0 upperBound = 1
	LinearMap result = bA from = (<a> [3]) to = (<b> [3]) basedOn = <i> lowerBound = 0 upperBound = 1
	rgba = [0.0 0.0 0.0 0.0]
	SetArrayElement ArrayName = rgba index = 0 newvalue = <bR>
	SetArrayElement ArrayName = rgba index = 1 newvalue = <bG>
	SetArrayElement ArrayName = rgba index = 2 newvalue = <bB>
	SetArrayElement ArrayName = rgba index = 3 newvalue = <bA>
	return rgba = <rgba>
endscript

script Create_AVEdit_FX \{viewport = bg_viewport
		clearColor = [
			0
			0
			0
			255
		]
		blendMode = blend
		alphaFromGray = 1}
	ScreenFX_ClearFXInstances viewport = <viewport>
	change \{visualizer_events_enabled = false}
	if GotParam \{primitives}
		ScreenFX_AddFXInstance {
			viewport = <viewport>
			name = AVFX01
			scefName = AVFX01
			type = AudioVisualize
			on = 1
			primitives = <primitives>
			clearColor = <clearColor>
			blendMode = <blendMode>
			alphaFromGrayscale = <alphaFromGray>
			audio_Params = $Default_Visualizer_Audio_Params
		}
		ScreenFX_AddFXInstance {
			viewport = <viewport>
			name = AVFX_Bloom01
			scefName = AVFX_Bloom01
			type = bloom2
			on = 1
			materialfilter = 0
			fullscreen = 1
			subtract = [0 0 0 0]
			colormodulate = [1.0 1.0 1.0 1.0]
			saturation = 1.0
			equation = eq2
		}
		ScreenFX_AddFXInstance {
			viewport = <viewport>
			name = UberScreenFX
			scefName = UberScreenFX
			type = UberScreenFX
			on = 1
		}
	endif
endscript

script CameraBlur_FastZoom_InandOut 
	if NOT BG_fx_get_start_params \{viewport = bg_viewport
			effectName = Depth_of_Field__simplified_}
		return
	endif
	BG_fx_set_blur \{appendStrength = 1
		time = 0.1}
	Wait \{0.2
		seconds}
	BG_fx_set_blur \{appendStrength = 0
		time = 0.3}
	Wait \{0.2
		seconds}
	BG_fx_set_blur \{appendStrength = 0.5
		time = 0.1}
	Wait \{0.1
		second}
	BG_fx_set_blur effectParams = <startValue> time = 0.4
endscript

script CameraBlur_SlowZoom_InandOut 
	if NOT BG_fx_get_start_params \{viewport = bg_viewport
			effectName = Depth_of_Field__simplified_}
		return
	endif
	BG_fx_set_blur \{appendStrength = 1
		time = 0.5}
	Wait \{0.4
		seconds}
	BG_fx_set_blur \{appendStrength = 0
		time = 0.4}
	Wait \{0.5
		seconds}
	BG_fx_set_blur \{appendStrength = 1
		time = 0.3}
	Wait \{0.3
		second}
	BG_fx_set_blur effectParams = <startValue> time = 0.4
endscript

script CameraBlur_FocusIn 
	if NOT BG_fx_get_start_params \{viewport = bg_viewport
			effectName = Depth_of_Field__simplified_}
		return
	endif
	BG_fx_set_blur \{appendStrength = 1
		time = 0}
	Wait \{0.1
		second}
	BG_fx_set_blur effectParams = <startValue> time = 0.5
endscript
