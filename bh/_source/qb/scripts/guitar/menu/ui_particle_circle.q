particle1_id = 0
particle2_id = 0
particle1_pos = (0.0, 0.0)

script ui_create_particle_circle \{offset = (0.0, 0.0)
		z_offset = 0.0}
	change particle1_pos = ((-270.0, 50.0) + <offset>)
	CreateScreenElement {
		blend = Add
		texture = particle_rotate
		type = SpriteElement
		hiddenLocal = false
		parent = root_window
		dims = (280.0, 280.0)
		just = [0.0 0.0]
		pos_anchor = [0.0 0.0]
		pos = $particle1_pos
		z_priority = <z_offset>
		rgba = [255 , 255 , 255 , 255]
		alpha = 1.0
	}
	change particle1_id = <id>
	particle_pos = ((-290.0, -50.0) + <offset>)
	CreateScreenElement {
		blend = Add
		texture = particle_rotate2
		type = SpriteElement
		hiddenLocal = false
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
	SpawnScriptLater \{ui_animate_particle_circle_spawned}
endscript

script ui_animate_particle_circle_spawned 
	angle1 = 0.0
	angle2 = 0.0
	begin
	angle1 = (<angle1> - 3.0)
	sin <angle1>
	scale1 = (0.15 * <sin> + 1.0)
	temp_angle = (<angle1> / 3.0)
	sin <temp_angle>
	particle1_cur_pos = ($particle1_pos + ((1.0, 0.2) * 20.0 * <sin>))
	angle2 = (<angle2> - 2.0)
	if (<angle1> < 0.0)
		angle1 = (<angle1> + 360.0 * 3.0)
	endif
	if (<angle2> < 0.0)
		angle2 = (<angle2> + 360.0 * 3.0)
	endif
	id = $particle1_id
	<id> :SE_SetProps {
		pos = <particle1_cur_pos>
		rot_angle = <angle1>
		scale = ((1.0, 1.0) * <scale1>)
	}
	id = $particle2_id
	<id> :SE_SetProps {
		rot_angle = <angle2>
	}
	Wait \{0
		frames}
	repeat
endscript

script ui_destroy_particle_circle 
	if ScriptExists \{ui_animate_particle_circle_spawned}
		KillSpawnedScript \{name = ui_animate_particle_circle_spawned}
	endif
	if ScreenElementExists \{id = $particle1_id}
		DestroyScreenElement \{id = $particle1_id}
	endif
	if ScreenElementExists \{id = $particle2_id}
		DestroyScreenElement \{id = $particle2_id}
	endif
endscript
