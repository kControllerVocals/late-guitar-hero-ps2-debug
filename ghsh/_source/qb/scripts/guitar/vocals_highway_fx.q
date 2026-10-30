vocals_comet_particle_effects = {
	scrolling = [
		{
			base = {
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
			base = {
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
			base = {
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
			base = {
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
			base = {
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
			base = {
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
			base = {
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
			base = {
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
			base = {
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
			base = {
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

script vocalshighway_getmaterial 

	formattext {
		checksumname = vocals_highway_material
		textname = vocals_highway_material_text
		'VocalEKGMaterial_p%p'
		p = <player>
		addtostringlookup
	}
	return vocals_highway_material = <vocals_highway_material> vocals_highway_material_text = <vocals_highway_material_text>
endscript

script vocals_setup_paint_material \{player = 1}
	vocalshighway_getid player = <player>
	vocalshighway_getmaterial player = <player>
	vocals_getvocalistnum player = <player>
	destroymaterial name = <vocals_highway_material>
	if screenelementexists id = {<vocals_highway_id> child = ekgelement}
		destroyscreenelement id = {<vocals_highway_id> child = ekgelement}
	endif
	creatematerial {
		name = <vocals_highway_material>
		template = waveform_ui
		technique = `default`
		blendmode = blend
		alphacutoff = 1
		materialprops = [
			{name = m_sampnoise textureproperty = `tex\_______default_m_____.dds`}
			{name = m_pscolors0 vectorproperty = [2.0 1.0 0.0 1.0]}
			{name = m_pscolors1 vectorproperty = [1.2 0.8 0.0 5.0]}
			{name = m_pscolors2 vectorproperty = [1.0 0.75 0.120000005 0.8]}
			{name = m_pscolors3 vectorproperty = [0.0 0.0 0.0 0.8]}
			{name = m_pscolors4 vectorproperty = [2.0 1.0 0.0 1.2]}
			{name = m_pscolors5 vectorproperty = [0.0 0.0 0.1 0.8]}
			{name = m_pscolors6 vectorproperty = [1.0 0.6 0.2 1.0]}
			{name = m_pscolors7 vectorproperty = [1.0 1.0 0.3 1.0]}
			{name = m_noisescale floatproperty = 0.8}
			{name = m_noisebias floatproperty = 0.0}
			{name = m_noisepower floatproperty = 0.25}
			{name = m_noise1speedx floatproperty = 0.2}
			{name = m_noise1speedy floatproperty = 0.25}
			{name = m_noise2speedx floatproperty = 0.2}
			{name = m_noise2speedy floatproperty = -0.25}
			{name = m_splinefadedistance floatproperty = 5.0}
			{name = m_playerindex floatproperty = <vocalist_num>}
		]
	}
	createscreenelement {
		parent = <vocals_highway_id>
		local_id = ekgelement
		type = spriteelement
		pos = (0.0, 0.0)
		dims = (512.0, 128.0)
		scale = 1.0
		material = <vocals_highway_material>
		texture = white
		z_priority = 10
	}
endscript

script vocals_end_phrase_good_comet_fx 
	obj_getid
	vocalshighway_getid player = <player>
	<vocals_highway_id> :desc_resolvealias name = alias_pitch_indicator param = pitch_indicator
	if (($current_num_players) > 1)
		pos = (0.0, 8.0)
	else
		pos = (0.0, 8.0)
	endif
	if screenelementexists \{id = 0xa4a4627e}
		destroyscreenelement \{id = 0xa4a4627e}
	endif
	createscreenelement {
		type = spriteelement
		id = 0xa4a4627e
		parent = <pitch_indicator>
		material = vocal_phrase
		blend = add
		use_animated_uvs = true
		top_down_v
		frame_length = 0.04
		num_uv_frames = (6.0, 1.0)
		rgba = [0 255 0 255]
		pos = <pos>
		scale = 0.75
		z_priority = 19.0
	}
	wait \{12
		frames}
	destroyscreenelement \{id = 0xa4a4627e}
endscript

script vocals_end_phrase_bad_comet_fx 
	obj_getid
	vocalshighway_getid player = <player>
	<vocals_highway_id> :desc_resolvealias name = alias_pitch_indicator param = pitch_indicator
	if (($current_num_players) > 1)
		pos = (0.0, 8.0)
	else
		pos = (0.0, 8.0)
	endif
	if screenelementexists \{id = 0xa4a4627e}
		destroyscreenelement \{id = 0xa4a4627e}
	endif
	createscreenelement {
		type = spriteelement
		id = 0xa4a4627e
		parent = <pitch_indicator>
		material = vocal_phrase
		blend = add
		use_animated_uvs = true
		top_down_v
		frame_length = 0.04
		num_uv_frames = (6.0, 1.0)
		rgba = [255 0 0 255]
		pos = <pos>
		scale = 0.5
		z_priority = 19.0
	}
	wait \{12
		frames}
	destroyscreenelement \{id = 0xa4a4627e}
endscript

script vocals_paint_star_power_on \{player = 1}
	vocalshighway_getid player = <player>
	if NOT screenelementexists id = {<vocals_highway_id> child = ekgelement}
		return
	endif
	vocalshighway_getmaterial player = <player>
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors0' x = 0.0 y = 1.0 z = 2.0 w = 1.0
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors1' x = 0.0 y = 0.4 z = 0.6 w = 5.0
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors2' x = 0.120000005 y = 0.75 z = 1.0 w = 1.0
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors3' x = 0.0 y = 0.0 z = 0.0 w = 1.0
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors4' x = 0.0 y = 1.4 z = 1.4 w = 2.0
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors5' x = 0.0 y = 0.0 z = 0.1 w = 1.0
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors6' x = 0.2 y = 0.6 z = 1.0 w = 1.0
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors7' x = 0.3 y = 1.0 z = 1.0 w = 1.0
endscript

script vocals_paint_star_power_off \{player = 1}
	vocalshighway_getid player = <player>
	if NOT screenelementexists id = {<vocals_highway_id> child = ekgelement}
		return
	endif
	vocalshighway_getmaterial player = <player>
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors0' x = 2.0 y = 1.0 z = 0.0 w = 1.0
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors1' x = 1.2 y = 0.8 z = 0.0 w = 5.0
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors2' x = 1.0 y = 0.75 z = 0.120000005 w = 0.8
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors3' x = 0.0 y = 0.0 z = 0.0 w = 0.8
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors4' x = 2.0 y = 1.0 z = 0.0 w = 1.2
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors5' x = 0.0 y = 0.0 z = 0.1 w = 0.8
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors6' x = 1.0 y = 0.6 z = 0.2 w = 1.0
	setmaterialproperty mat = <vocals_highway_material_text> prop = 'm_psColors7' x = 1.0 y = 1.0 z = 0.3 w = 1.0
endscript
