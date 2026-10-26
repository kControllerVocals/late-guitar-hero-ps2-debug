jowBlue = 717488127
jowGreen = 771697407
jowOrange = -6149377
jowRed = -15061505
jowYellow = -3267073

script JOW_Stars 



endscript

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

script anim_key 
	Obj_MoveToPos (<mov>) time = <time>
	Obj_Rotate absolute = <rot> time = <time>
	Obj_WaitMove
endscript

script ChangePassColor \{parameter = m_psPass0MaterialColor
		time = 1.0
		stepTime = 0.05}
	numSteps = (<time> / <stepTime>)
	CastToInteger \{numSteps}
	stepR = ((<endcolor> [0] - <startcolor> [0]) / <numSteps>)
	stepG = ((<endcolor> [1] - <startcolor> [1]) / <numSteps>)
	stepB = ((<endcolor> [2] - <startcolor> [2]) / <numSteps>)
	stepA = ((<endcolor> [3] - <startcolor> [3]) / <numSteps>)
	begin
	SetArrayElement ArrayName = startcolor index = 0 newvalue = (<startcolor> [0] + <stepR>)
	SetArrayElement ArrayName = startcolor index = 1 newvalue = (<startcolor> [1] + <stepG>)
	SetArrayElement ArrayName = startcolor index = 2 newvalue = (<startcolor> [2] + <stepB>)
	SetArrayElement ArrayName = startcolor index = 3 newvalue = (<startcolor> [3] + <stepA>)
	UpdateMaterialProperty {
		object = <ObjID>
		material = <material>
		parameter = <parameter>
		value = <startcolor>
	}
	Wait <stepTime> seconds
	repeat (<numSteps> -1)
	UpdateMaterialProperty {
		object = <ObjID>
		material = <material>
		parameter = <parameter>
		value = <endcolor>
	}
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

script Obj_Scale \{scale = (2.0, 2.0, 2.0)
		time = 2.0}
	if GotParam \{Cycle}
		begin
		Obj_MorphScaling target_scale = <scale> blend_duration = <time>
		Wait <time> seconds
		Obj_MorphScaling target_scale = (1.0, 1.0, 1.0) blend_duration = <time>
		Wait <time> seconds
		repeat
	else
		Obj_MorphScaling target_scale = <scale> blend_duration = <time>
	endif
endscript

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

script Create_AVFX \{viewport = bg_viewport}
	if NOT ViewportExists id = <viewport>
		return
	endif
	if ScreenFX_FxInstanceExists viewport = <viewport> name = Bloom__simplified_
		ScreenFX_RemoveFXInstance viewport = <viewport> name = Bloom__simplified_
	endif
	if ScreenFX_FxInstanceExists viewport = <viewport> name = Godray
		ScreenFX_RemoveFXInstance viewport = <viewport> name = Godray
	endif
	if ScreenFX_FxInstanceExists viewport = <viewport> name = Noise_Lite type = noise2
		ScreenFX_RemoveFXInstance viewport = <viewport> name = Noise_Lite type = noise2
	endif
	if GotParam \{primitives}
		if NOT ScreenFX_FxInstanceExists viewport = <viewport> name = AVFX01
			ScreenFX_AddFXInstance {
				viewport = <viewport>
				name = AVFX01
				scefName = AVFX01
				type = AudioVisualize
				on = 1
				primitives = <primitives>
				clearColor = [0 , 0 , 0 , 255]
				audio_Params = $Default_Visualizer_Audio_Params
			}
		else
			ScreenFX_UpdateFXInstanceParams {
				viewport = <viewport>
				name = AVFX01
				scefName = AVFX01
				type = AudioVisualize
				on = 1
				primitives = <primitives>
				clearColor = [0 , 0 , 0 , 255]
				audio_Params = $Default_Visualizer_Audio_Params
			}
		endif
		if NOT ScreenFX_FxInstanceExists viewport = <viewport> name = AVFX_Bloom01
			ScreenFX_AddFXInstance {
				viewport = <viewport>
				name = AVFX_Bloom01
				scefName = AVFX_Bloom01
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
	elseif GotParam \{profile}
		ScreenFX_ClearFXInstances viewport = <viewport>
		avPreset = ($Default_tod_manager.avPreset)
		fxParam = ($Default_tod_manager.fxParam)
		if StructureContains \{Structure = profile
				avPreset}
			avPreset = (<profile>.avPreset)
		endif
		i = 0
		GetArraySize <avPreset>
		begin
		FormatText checksumname = avName 'AVFX_%i' i = <i> DontAssertForChecksums
		ScreenFX_AddFXInstance {
			viewport = <viewport>
			name = <avName>
			scefName = <avName>
			type = AudioVisualize
			on = 1
			primitives = (<avPreset> [<i>])
			clearColor = [0 , 0 , 0 , 255]
			audio_Params = $Default_Visualizer_Audio_Params
		}
		i = (<i> + 1)
		repeat <array_size>
		if StructureContains \{Structure = profile
				fxParam}
			fxParam = (<profile>.fxParam)
		endif
		if StructureContains \{Structure = fxParam
				screen_fx}
			begin
			if GetNextArrayElement (<fxParam>.screen_fx)
				ScreenFX_AddFXInstance {
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

script Destroy_AVFX \{primitives = $OG_BluePhoenix
		viewport = bg_viewport}
	ScreenFX_ClearFXInstances viewport = <viewport>
	if ViewportExists id = <viewport>
		if ScreenFX_FxInstanceExists viewport = <viewport> name = AVFX01
			ScreenFX_RemoveFXInstance viewport = <viewport> name = AVFX01
		endif
	endif
endscript

script Display_AVFX_Message \{text = qs("pass text param")
		time = 10
		pos = (640.0, 640.0)}
	FormatText TextName = newText qs("%t") t = <text>
	if ScreenElementExists \{id = mb_text_container}
		DestroyScreenElement \{id = mb_text_container}
	endif
	CreateScreenElement \{id = mb_text_container
		type = ContainerElement
		parent = root_window}
	CreateScreenElement {
		id = mb_text
		type = TextElement
		parent = mb_text_container
		font = debug
		text = <newText>
		scale = 1.5
		pos = <pos>
		just = [center center]
		rgba = [150 185 200 255]
		z_priority = 80
	}
	CreateScreenElement {
		id = mb_text_shadow
		type = TextElement
		parent = mb_text_container
		font = debug
		text = <newText>
		scale = 1.5
		pos = (<pos> + (1.0, 1.0))
		just = [center center]
		rgba = [0 0 0 255]
		z_priority = 79
	}
	mb_text :SE_SetProps \{alpha = 0}
	mb_text_shadow :SE_SetProps \{alpha = 0}
	mb_text :SE_SetProps \{alpha = 1
		time = 0.1}
	mb_text_shadow :SE_SetProps \{alpha = 1
		time = 0.1}
	mb_text :SE_WaitProps
	Wait <time> seconds
	mb_text :SE_SetProps \{alpha = 0
		time = 0.1}
	mb_text_shadow :SE_SetProps \{alpha = 0
		time = 0.1}
	mb_text :SE_WaitProps
	if ScreenElementExists \{id = mb_text_container}
		DestroyScreenElement \{id = mb_text_container}
	endif
endscript

script HandofGod_ElectricCenter_Glow 
	DestroyScreenElement \{id = HOG_ElectricCenter_Glow}
	Wait \{1
		frame}
	CreateScreenElement \{type = SpriteElement
		parent = root_window
		id = HOG_ElectricCenter_Glow
		texture = PH_RadialGlow_01
		alpha = 1
		scale = (2.0, 2.0)
		dims = (800.0, 800.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = Add
		z_priority = 4
		rgba = [
			140
			200
			255
			255
		]}
endscript

script HandofGod_ElectricCenter_Glow_02 
	DestroyScreenElement \{id = HOG_ElectricCenter_Glow_02}
	Wait \{1
		frame}
	CreateScreenElement \{type = SpriteElement
		parent = root_window
		id = HOG_ElectricCenter_Glow_02
		texture = PH_RadialGlow_01
		alpha = 1
		scale = (2.0, 2.0)
		dims = (800.0, 800.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = Add
		z_priority = 4
		rgba = [
			140
			200
			255
			255
		]}
	HandofGod_ElectricCenter_Glow_Anim_02
endscript

script HandofGod_ElectricCenter_Glow_03 
	DestroyScreenElement \{id = HOG_ElectricCenter_Glow_03}
	Wait \{1
		frame}
	CreateScreenElement \{type = SpriteElement
		parent = root_window
		id = HOG_ElectricCenter_Glow_03
		texture = PH_RadialGlow_01
		alpha = 1
		scale = (2.0, 2.0)
		dims = (800.0, 800.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = Add
		z_priority = 4
		rgba = [
			140
			200
			255
			255
		]}
	HandofGod_ElectricCenter_Glow_Anim_03
endscript

script HandofGod_ElectricCenter_Flare 
	DestroyScreenElement \{id = HOG_ElectricCenter_Flare}
	Wait \{1
		frame}
	CreateScreenElement \{type = SpriteElement
		parent = root_window
		id = HOG_ElectricCenter_Flare
		texture = JOW_Flare02
		alpha = 1
		scale = (1.0, 1.0)
		dims = (800.0, 800.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = Add
		rot_angle = 45
		z_priority = 3
		rgba = [
			120
			200
			255
			255
		]}
	Wait \{1.0
		second}
	DestroyScreenElement \{id = HOG_ElectricCenter_Flare}
endscript

script HandofGod_ElectricCenter_Flare_02 
	DestroyScreenElement \{id = HOG_ElectricCenter_Flare_02}
	Wait \{1
		frame}
	CreateScreenElement \{type = SpriteElement
		parent = root_window
		id = HOG_ElectricCenter_Flare_02
		texture = JOW_ButtonFlare01
		alpha = 1
		scale = (1.0, 1.0)
		dims = (20.0, 20.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = Add
		z_priority = 3
		rgba = [
			220
			240
			255
			255
		]}
	HandofGod_ElectricCenter_Flare_02_Anim
endscript

script HandofGod_ElectricCenter 
	DestroyScreenElement \{id = HOG_ElectricCenter}
	Wait \{1
		frame}
	CreateScreenElement \{type = SpriteElement
		parent = root_window
		id = HOG_ElectricCenter
		texture = PH_Electricity_01
		alpha = 1
		scale = (2.0, 2.0)
		dims = (300.0, 300.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		blend = Add
		z_priority = 2
		rgba = [
			146
			200
			255
			255
		]}
	Wait \{1
		frame}
	spawnscriptnow \{HandofGod_ElectricCenter_Anim_Scale}
endscript

script HandofGod_ElectricCenter_02 
	DestroyScreenElement \{id = HOG_ElectricCenter_02}
	Wait \{1
		frame}
	CreateScreenElement \{type = SpriteElement
		parent = root_window
		id = HOG_ElectricCenter_02
		texture = PH_Electricity_01
		alpha = 1
		scale = (2.0, 2.0)
		dims = (300.0, 300.0)
		just = [
			center
			center
		]
		pos = (640.0, 120.0)
		rot_angle = 45
		blend = Add
		z_priority = 2
		rgba = [
			146
			200
			255
			255
		]}
	Wait \{1
		frame}
	HandofGod_ElectricCenter_Anim_Scale_02
endscript

script HandofGod_ElectricCenter_Glow_Anim 
	HandofGod_ElectricCenter_Glow
	begin
	HOG_ElectricCenter_Glow :SE_SetProps scale = (2.2, 2.2) alpha = 0.4 time = 0.05 motion = Random (@ ease_in @ ease_out )
	HOG_ElectricCenter_Glow :SE_WaitProps
	HOG_ElectricCenter_Glow :SE_SetProps scale = (2.0, 2.0) alpha = 0.6 time = 0.1 motion = Random (@ ease_in @ ease_out )
	HOG_ElectricCenter_Glow :SE_WaitProps
	repeat 8
	DestroyScreenElement \{id = HOG_ElectricCenter_Glow}
endscript

script HandofGod_ElectricCenter_Glow_Anim_02 
	begin
	HOG_ElectricCenter_Glow_02 :SE_SetProps \{scale = (0.5, 0.5)
		alpha = 1}
	HOG_ElectricCenter_Glow_02 :SE_SetProps \{scale = (3.0, 3.0)
		alpha = 0
		time = 0.2}
	HOG_ElectricCenter_Glow_02 :SE_WaitProps
	repeat 7
	DestroyScreenElement \{id = HOG_ElectricCenter_Glow_02}
endscript

script HandofGod_ElectricCenter_Glow_Anim_03 
	HOG_ElectricCenter_Glow_03 :SE_SetProps \{scale = (5.0, 5.0)
		alpha = 0.4}
	HOG_ElectricCenter_Glow_03 :SE_SetProps \{scale = (1.0, 1.0)
		alpha = 0
		time = 1}
	HOG_ElectricCenter_Glow_03 :SE_WaitProps
	DestroyScreenElement \{id = HOG_ElectricCenter_Glow_03}
endscript

script HandofGod_ElectricCenter_Anim_Scale 
	<rot> = 0
	begin
	<rot> = (<rot> + 45)
	HOG_ElectricCenter :SE_SetProps rot_angle = <rot> alpha = 0
	HOG_ElectricCenter :SE_SetProps \{scale = (1.0, 1.0)
		alpha = 0.3
		time = 0.1}
	HOG_ElectricCenter :SE_WaitProps
	HOG_ElectricCenter :SE_SetProps \{scale = (1.3, 1.3)
		alpha = 1
		time = 0.1}
	HOG_ElectricCenter :SE_WaitProps
	repeat 4
	DestroyScreenElement \{id = HOG_ElectricCenter}
endscript

script HandofGod_ElectricCenter_Anim_Scale_02 
	<rot> = 0
	begin
	<rot> = (<rot> + 45)
	HOG_ElectricCenter_02 :SE_SetProps rot_angle = <rot>
	HOG_ElectricCenter_02 :SE_SetProps \{scale = (1.0, 1.0)
		alpha = 1}
	HOG_ElectricCenter_02 :SE_WaitProps
	HOG_ElectricCenter_02 :SE_SetProps \{scale = (2.0, 2.0)
		alpha = 0
		time = 0.2}
	HOG_ElectricCenter_02 :SE_WaitProps
	repeat 4
	DestroyScreenElement \{id = HOG_ElectricCenter_02}
endscript

script HandofGod_ElectricCenter_Flare_02_Anim 
	HOG_ElectricCenter_Flare_02 :SE_SetProps \{scale = (200.0, 200.0)
		rot_angle = -360
		alpha = 0.5
		time = 0.1}
	HOG_ElectricCenter_Flare_02 :SE_WaitProps
	DestroyScreenElement \{id = HOG_ElectricCenter_Flare_02}
endscript

script HandofGod_ElectricCenter_Combo 
	spawnscriptnow \{HandofGod_ElectricCenter_Glow_Anim}
	spawnscriptnow \{HandofGod_ElectricCenter}
	spawnscriptnow \{HandofGod_ElectricCenter_02}
	spawnscriptnow \{HandofGod_ElectricCenter_Flare}
	spawnscriptnow \{HandofGod_Smoke_01}
	spawnscriptnow \{HandofGod_ElectricCenter_Sparks_01}
endscript

script HandofGod_FX_01 
	Wait \{2.0
		second}
	spawnscriptnow \{HandofGod_ElectricCenter_Glow_Anim}
	spawnscriptnow \{HandofGod_ElectricCenter}
	spawnscriptnow \{HandofGod_ElectricCenter_02}
	spawnscriptnow \{HandofGod_ElectricCenter_Flare}
	spawnscriptnow \{HandofGod_Smoke_01}
	spawnscriptnow \{HandofGod_ElectricCenter_Sparks_01}
	spawnscriptnow \{HandofGod_Lightning_Combo}
	Wait \{1.0
		second}
	HandofGod_ElectricCenter_Flare_02
endscript

script HandofGod_FX_02 
	Wait \{2.0
		second}
	spawnscriptnow \{HandofGod_ElectricCenter_Glow_02}
	spawnscriptnow \{HandofGod_ElectricCenter_Sparks_02}
	Wait \{0.0
		second}
	HandofGod_Smoke_02
	HandofGod_ElectricCenter_Glow_03
endscript

script HandofGod_Lightning_God 
	DestroyScreenElement \{id = HOG_Lightning_God}
	Wait \{1
		frame}
	CreateScreenElement \{type = SpriteElement
		parent = root_window
		id = HOG_Lightning_God
		alpha = 1
		scale = (1.1, 1.1)
		just = [
			center
			center
		]
		pos = (1000.0, 140.0)
		rot_angle = 80
		material = sys_Big_Bolt01_sys_Big_Bolt01
		blend = Add
		use_animated_uvs = true
		top_down_v
		frame_length = 0.08
		num_uv_frames = (8.0, 1.0)
		z_priority = 1}
	Wait \{1.0
		second}
	DestroyScreenElement \{id = HOG_Lightning_God}
endscript

script HandofGod_Lighting_Devil 
	DestroyScreenElement \{id = HOG_Lighting_Devil}
	Wait \{1
		frame}
	CreateScreenElement \{type = SpriteElement
		parent = root_window
		id = HOG_Lighting_Devil
		alpha = 1
		scale = (1.1, 1.1)
		just = [
			center
			center
		]
		pos = (210.0, 70.0)
		rot_angle = 280
		material = sys_Big_Bolt01_sys_Big_Bolt01
		blend = Add
		use_animated_uvs = true
		top_down_v
		frame_length = 0.08
		num_uv_frames = (8.0, 1.0)
		z_priority = 1}
	Wait \{1.0
		second}
	DestroyScreenElement \{id = HOG_Lighting_Devil}
endscript

script HandofGod_Lightning_Combo 
	spawnscriptnow \{HandofGod_Lightning_God}
	spawnscriptnow \{HandofGod_Lighting_Devil}
endscript

script HandofGod_FX_Kill 
	DestroyScreenElement \{id = HOG_ElectricCenter_Glow}
	DestroyScreenElement \{id = HOG_ElectricCenter_Flare}
	DestroyScreenElement \{id = HOG_ElectricCenter}
	DestroyScreenElement \{id = HOG_Lightning_God}
	DestroyScreenElement \{id = HOG_Lighting_Devil}
endscript

script HandofGod_ElectricCenter_Sparks_01 
	Destroy2DParticleSystem \{id = ElectricCenter_Sparks_01}
	Wait \{1
		frame}
	Create2DParticleSystem \{id = ElectricCenter_Sparks_01
		pos = (640.0, 260.0)
		z_priority = 2
		material = sys_Particle_Spark01_sys_Particle_Spark01
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
	Wait \{1.0
		second}
	Destroy2DParticleSystem \{id = ElectricCenter_Sparks_01}
endscript

script HandofGod_ElectricCenter_Sparks_02 
	Destroy2DParticleSystem \{id = ElectricCenter_Sparks_02}
	Wait \{1
		frame}
	Create2DParticleSystem \{id = ElectricCenter_Sparks_02
		pos = (640.0, 260.0)
		z_priority = 2
		material = sys_Particle_Spark01_sys_Particle_Spark01
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
	Wait \{1.0
		second}
	Destroy2DParticleSystem \{id = ElectricCenter_Sparks_02}
endscript

script HandofGod_Smoke_01 
	Destroy2DParticleSystem \{id = HOG_Smoke_01}
	Create2DParticleSystem \{id = HOG_Smoke_01
		pos = (640.0, 260.0)
		z_priority = 20.0
		material = Mat_HOG_Smoke
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
	Wait \{1.0
		second}
	Destroy2DParticleSystem \{id = HOG_Smoke_01}
endscript

script HandofGod_Smoke_02 
	Destroy2DParticleSystem \{id = HOG_Smoke_02}
	Create2DParticleSystem \{id = HOG_Smoke_02
		pos = (640.0, 260.0)
		z_priority = 20.0
		material = Mat_HOG_Smoke
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
	Wait \{1.0
		second}
	Destroy2DParticleSystem \{id = HOG_Smoke_02
		kill_when_empty}
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
