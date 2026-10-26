vocals_comet_particle_effects = {
	scrolling = [
		{
			Base = {
				start_color = [
					255
					128
					0
					255
				]
				end_color = [
					255
					0
					0
					0
				]
			}
			miss = {
				start_color = [
					128
					0
					255
					255
				]
				end_color = [
					0
					0
					255
					0
				]
			}
		}
	]
	scrolling_sp = [
		{
			Base = {
				start_color = [
					64
					128
					128
					255
				]
				end_color = [
					0
					0
					0
					0
				]
			}
		}
		{
			Base = {
				start_color = [
					255
					255
					255
					255
				]
				end_color = [
					255
					255
					255
					128
				]
			}
		}
		{
			Base = {
				start_color = [
					255
					255
					255
					255
				]
				end_color = [
					255
					255
					255
					0
				]
			}
		}
		{
			Base = {
				start_color = [
					128
					255
					255
					255
				]
				end_color = [
					0
					255
					255
					0
				]
			}
		}
	]
	static = [
		{
			Base = {
				start_color = [
					255
					128
					0
					255
				]
				end_color = [
					255
					0
					0
					0
				]
			}
			miss = {
				start_color = [
					128
					0
					255
					255
				]
				end_color = [
					0
					0
					255
					0
				]
			}
		}
	]
	static_sp = [
		{
			Base = {
				start_color = [
					64
					128
					128
					255
				]
				end_color = [
					0
					0
					0
					0
				]
			}
		}
		{
			Base = {
				start_color = [
					255
					255
					255
					255
				]
				end_color = [
					255
					255
					255
					128
				]
			}
		}
		{
			Base = {
				start_color = [
					255
					255
					255
					255
				]
				end_color = [
					255
					255
					255
					0
				]
			}
		}
		{
			Base = {
				start_color = [
					128
					255
					255
					255
				]
				end_color = [
					0
					255
					255
					0
				]
			}
		}
	]
}
vocal_cheat_fireball_start_color = [
	255
	0
	200
	255
]
vocal_cheat_fireball_end_color = [
	255
	0
	200
	64
]

script VocalsHighway_GetMaterial 

	FormatText {
		checksumname = vocals_highway_material
		TextName = vocals_highway_material_text
		'VocalEKGMaterial_p%p'
		p = <player>
		AddToStringLookup
	}
	return vocals_highway_material = <vocals_highway_material> vocals_highway_material_text = <vocals_highway_material_text>
endscript

script vocals_setup_paint_material \{player = 1}
	VocalsHighway_GetId player = <player>
	VocalsHighway_GetMaterial player = <player>
	Vocals_GetVocalistNum player = <player>
	DestroyMaterial name = <vocals_highway_material>
	if ScreenElementExists id = {<vocals_highway_id> child = EKGElement}
		DestroyScreenElement id = {<vocals_highway_id> child = EKGElement}
	endif
	CreateMaterial {
		name = <vocals_highway_material>
		Template = Waveform_UI
		technique = `default`
		blendMode = blend
		alphacutoff = 1
		MaterialProps = [
			{name = m_sampNoise TextureProperty = `tex\_______Default_M_____.dds`}
			{name = m_psColors0 VectorProperty = [2.0 1.0 0.0 1.0]}
			{name = m_psColors1 VectorProperty = [1.2 0.8 0.0 5.0]}
			{name = m_psColors2 VectorProperty = [1.0 0.75 0.120000005 0.8]}
			{name = m_psColors3 VectorProperty = [0.0 0.0 0.0 0.8]}
			{name = m_psColors4 VectorProperty = [2.0 1.0 0.0 1.2]}
			{name = m_psColors5 VectorProperty = [0.0 0.0 0.1 0.8]}
			{name = m_psColors6 VectorProperty = [1.0 0.6 0.2 1.0]}
			{name = m_psColors7 VectorProperty = [1.0 1.0 0.3 1.0]}
			{name = m_noiseScale FloatProperty = 0.8}
			{name = m_noiseBias FloatProperty = 0.0}
			{name = m_noisePower FloatProperty = 0.25}
			{name = m_noise1SpeedX FloatProperty = 0.2}
			{name = m_noise1SpeedY FloatProperty = 0.25}
			{name = m_noise2SpeedX FloatProperty = 0.2}
			{name = m_noise2SpeedY FloatProperty = -0.25}
			{name = m_splineFadeDistance FloatProperty = 5.0}
			{name = m_playerIndex FloatProperty = <vocalist_num>}
		]
	}
	CreateScreenElement {
		parent = <vocals_highway_id>
		local_id = EKGElement
		type = SpriteElement
		pos = (0.0, 0.0)
		dims = (512.0, 128.0)
		scale = 1.0
		material = <vocals_highway_material>
		texture = white
		z_priority = 10
	}
endscript

script vocals_end_phrase_GOOD_comet_fx 
	Obj_GetID
	VocalsHighway_GetId player = <player>
	<vocals_highway_id> :Desc_ResolveAlias name = alias_pitch_indicator param = pitch_indicator
	if (($current_num_players) > 1)
		pos = (0.0, 8.0)
	else
		pos = (0.0, 8.0)
	endif
	if ScreenElementExists \{id = vocal_phrase_id}
		DestroyScreenElement \{id = vocal_phrase_id}
	endif
	CreateScreenElement {
		type = SpriteElement
		id = vocal_phrase_id
		parent = <pitch_indicator>
		material = vocal_phrase
		blend = Add
		use_animated_uvs = true
		top_down_v
		frame_length = 0.04
		num_uv_frames = (6.0, 1.0)
		rgba = [0 255 0 255]
		pos = <pos>
		scale = 0.75
		z_priority = 19.0
	}
	Wait \{12
		frames}
	DestroyScreenElement \{id = vocal_phrase_id}
endscript

script vocals_end_phrase_BAD_comet_fx 
	Obj_GetID
	VocalsHighway_GetId player = <player>
	<vocals_highway_id> :Desc_ResolveAlias name = alias_pitch_indicator param = pitch_indicator
	if (($current_num_players) > 1)
		pos = (0.0, 8.0)
	else
		pos = (0.0, 8.0)
	endif
	if ScreenElementExists \{id = vocal_phrase_id}
		DestroyScreenElement \{id = vocal_phrase_id}
	endif
	CreateScreenElement {
		type = SpriteElement
		id = vocal_phrase_id
		parent = <pitch_indicator>
		material = vocal_phrase
		blend = Add
		use_animated_uvs = true
		top_down_v
		frame_length = 0.04
		num_uv_frames = (6.0, 1.0)
		rgba = [255 0 0 255]
		pos = <pos>
		scale = 0.5
		z_priority = 19.0
	}
	Wait \{12
		frames}
	DestroyScreenElement \{id = vocal_phrase_id}
endscript

script vocals_paint_star_power_on \{player = 1}
	VocalsHighway_GetId player = <player>
	if NOT ScreenElementExists id = {<vocals_highway_id> child = EKGElement}
		return
	endif
	VocalsHighway_GetMaterial player = <player>
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors0' x = 0.0 y = 1.0 z = 2.0 w = 1.0
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors1' x = 0.0 y = 0.4 z = 0.6 w = 5.0
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors2' x = 0.120000005 y = 0.75 z = 1.0 w = 1.0
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors3' x = 0.0 y = 0.0 z = 0.0 w = 1.0
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors4' x = 0.0 y = 1.4 z = 1.4 w = 2.0
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors5' x = 0.0 y = 0.0 z = 0.1 w = 1.0
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors6' x = 0.2 y = 0.6 z = 1.0 w = 1.0
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors7' x = 0.3 y = 1.0 z = 1.0 w = 1.0
endscript

script vocals_paint_star_power_off \{player = 1}
	VocalsHighway_GetId player = <player>
	if NOT ScreenElementExists id = {<vocals_highway_id> child = EKGElement}
		return
	endif
	VocalsHighway_GetMaterial player = <player>
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors0' x = 2.0 y = 1.0 z = 0.0 w = 1.0
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors1' x = 1.2 y = 0.8 z = 0.0 w = 5.0
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors2' x = 1.0 y = 0.75 z = 0.120000005 w = 0.8
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors3' x = 0.0 y = 0.0 z = 0.0 w = 0.8
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors4' x = 2.0 y = 1.0 z = 0.0 w = 1.2
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors5' x = 0.0 y = 0.0 z = 0.1 w = 0.8
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors6' x = 1.0 y = 0.6 z = 0.2 w = 1.0
	SetMaterialProperty mat = <vocals_highway_material_text> prop = 'm_psColors7' x = 1.0 y = 1.0 z = 0.3 w = 1.0
endscript
