particle1_id = 0
particle2_id = 0
0x6a58b2ed = (0.0, 0.0)

script 0x87679bf6 \{offset = (0.0, 0.0)
		z_offset = 0.0}
	change 0x6a58b2ed = ((-270.0, 50.0) + <offset>)
	createscreenelement {
		blend = add
		texture = 0xa2859aff
		type = spriteelement
		hiddenlocal = false
		parent = root_window
		dims = (280.0, 280.0)
		just = [0.0 0.0]
		pos_anchor = [0.0 0.0]
		pos = $0x6a58b2ed
		z_priority = <z_offset>
		rgba = [255 , 255 , 255 , 255]
		alpha = 1.0
	}
	change particle1_id = <id>
	particle_pos = ((-290.0, -50.0) + <offset>)
	createscreenelement {
		blend = add
		texture = 0xe5773b97
		type = spriteelement
		hiddenlocal = false
		parent = root_window
		dims = (260.0, 260.0)
		just = [0.0 0.0]
		pos_anchor = [0.0 0.0]
		pos = <particle_pos>
		z_priority = (<z_offset> - 0.001)
		rgba = [255 , 255 , 255 , 255]
		alpha = 1.0
	}
	change particle2_id = <id>
	spawnscriptlater \{0x628125b1}
endscript

script 0x628125b1 
	angle1 = 0.0
	angle2 = 0.0
	begin
	angle1 = (<angle1> - 3.0)
	sin <angle1>
	scale1 = (0.15 * <sin> + 1.0)
	0x69de1bf7 = (<angle1> / 3.0)
	sin <0x69de1bf7>
	0x182742d5 = ($0x6a58b2ed + ((1.0, 0.2) * 20.0 * <sin>))
	angle2 = (<angle2> - 2.0)
	if (<angle1> < 0.0)
		angle1 = (<angle1> + 360.0 * 3.0)
	endif
	if (<angle2> < 0.0)
		angle2 = (<angle2> + 360.0 * 3.0)
	endif
	id = $particle1_id
	<id> :se_setprops {
		pos = <0x182742d5>
		rot_angle = <angle1>
		scale = ((1.0, 1.0) * <scale1>)
	}
	id = $particle2_id
	<id> :se_setprops {
		rot_angle = <angle2>
	}
	wait \{0
		frames}
	repeat
endscript

script 0xafd96096 
	if scriptexists \{0x628125b1}
		killspawnedscript \{name = 0x628125b1}
	endif
	if screenelementexists \{id = $particle1_id}
		destroyscreenelement \{id = $particle1_id}
	endif
	if screenelementexists \{id = $particle2_id}
		destroyscreenelement \{id = $particle2_id}
	endif
endscript
