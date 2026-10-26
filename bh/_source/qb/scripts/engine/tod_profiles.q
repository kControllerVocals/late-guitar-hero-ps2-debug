Default_tod_manager = {
	screen_fx = [
		{
			name = Bloom__simplified_
			scefName = Bloom__simplified_
			type = bloom2
			on = 1
			fullscreen = 0
			materialfilter = 1
			subtract = [
				0.2
				0.2
				0.2
				1.0
			]
			colormodulate = [
				0.890196
				0.890196
				0.890196
				1.0
			]
			saturation = 0.8132
			thickness = 15.614799
			equation = eq0
		}
		{
			name = Depth_of_Field__REAL
			scefName = Depth_of_Field__REAL
			type = dof
			on = 1
			allowvideo = 0
			strength = 1.0
			BackDist = 3.4
			BackRange = 3.4
		}
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.0
			nearblurbegin = 0.0
			nearblurend = 2.0
			farblurbegin = 10.0
			farblurend = 20.0
		}
		{
			name = Godray
			scefName = Godray
			type = Godray
			on = 0
			colormodulate = [
				1.0
				1.0
				1.0
				1.0
			]
			depthmodulate = 0.0
			steps = 100.0
			range = 1.0
			fadeout_begin = 90.0
			fadeout_end = 120.0
			skycolor = [
				0.0
				0.0
				0.5
				0.0
			]
			lightposition = [
				100.0
				100.0
				100.0
				1.0
			]
			cliplightposition = 1
			lightsource = Sky
		}
		{
			name = Vignette
			scefName = Vignette
			type = Vignette
			on = 0
			aspectcorrection = 0
			inner_radius = 0.5
			outer_radius = 1.0
			color = [
				0.0
				0.0
				0.0
				0.0
			]
			alpha = 0.5
		}
		{
			name = Noise_Lite
			scefName = Noise_Lite
			type = noise2
			on = 1
			intensity = 0.1
			color = [
				0.5
				0.5
				0.5
				0.5
			]
			uv = [
				8.0
				6.0
				0.0
				0.0
			]
		}
		{
			name = UberScreenFX
			scefName = UberScreenFX
			type = UberScreenFX
		}
	]
}
ScreenFlash_TOD_Manager = {
	screen_fx = [
		{
			name = Brightness___Saturation
			scefName = Brightness___Saturation
			type = bright_sat
			on = 1
			target = 0.25
			brightness = 0.85
			contrast = 0.9
			hue = 1.0
			saturation = 0.0
			red_mix = [
				1.0
				0.0
				0.0
				0.0
			]
			green_mix = [
				0.0
				1.0
				0.0
				0.0
			]
			blue_mix = [
				0.0
				0.0
				1.0
				0.0
			]
			on_p2 = 0
			target_p2 = 0.75
			brightness_p2 = 1.0
			contrast_p2 = 1.0
			hue_p2 = 1.0
			saturation_p2 = 0.0
			red_mix_p2 = [
				1.0
				0.0
				0.0
				0.0
			]
			green_mix_p2 = [
				0.0
				1.0
				0.0
				0.0
			]
			blue_mix_p2 = [
				0.0
				0.0
				1.0
				0.0
			]
		}
	]
}
DOF_Long01_tod_manager_practice = {
	screen_fx = [
		{
			name = Depth_of_Field__REAL
			scefName = Depth_of_Field__REAL
			type = dof
			on = 1
			allowvideo = 1
			strength = 1.0
			allowvideo = 0
			BackDist = 2.0
			BackRange = 3.0
		}
	]
}
DOF_Off_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.0
			nearblurbegin = 0.0
			nearblurend = 2.0
			farblurbegin = 10.0
			farblurend = 20.0
		}
	]
}
DOF_CloseUp01_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 8.0
			farblurend = 12.0
		}
	]
}
DOF_CloseUp02_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 1.0
			farblurend = 8.0
		}
	]
}
DOF_CloseUp03_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 1.026
			farblurbegin = 2.3799999
			farblurend = 1.1
		}
	]
}
DOF_CloseUp04_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 7.0
			farblurbegin = 7.0
			farblurend = 8.0
		}
	]
}
DOF_Medium01_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.5
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 20.0
			farblurend = 30.0
		}
	]
}
DOF_Medium02_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.75
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 15.0
			farblurend = 30.0
		}
	]
}
DOF_Long01_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.8
			nearblurbegin = 0.0
			nearblurend = 20.0
			farblurbegin = 20.0
			farblurend = 50.0
		}
	]
}
DOF_Stage01_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.8
			nearblurbegin = 0.0
			nearblurend = 5.0
			farblurbegin = 5.0
			farblurend = 20.0
		}
	]
}
DOF_UIblur_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.9
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 0.0
			farblurend = 4.0
		}
	]
}
DOF_CAR_ACCL_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__REAL
			scefName = Depth_of_Field__REAL
			type = dof
			on = 1
			allowvideo = 0
			strength = 1.0
			BackDist = 0.45000002
			BackRange = 0.45000002
		}
	]
}
DOF_CAR_ACCR_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__REAL
			scefName = Depth_of_Field__REAL
			type = dof
			on = 1
			allowvideo = 0
			strength = 1.0
			BackDist = 0.45000002
			BackRange = 0.45000002
		}
	]
}
DOF_CAR_Main_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__REAL
			scefName = Depth_of_Field__REAL
			type = dof
			on = 1
			allowvideo = 0
			strength = 1.0
			BackDist = 3.4
			BackRange = 3.4
		}
	]
}
DOF_CAR_SelChar_open_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__REAL
			scefName = Depth_of_Field__REAL
			type = dof
			on = 1
			allowvideo = 0
			override_dist1 = 1.0
			override_strength1 = 0.65000004
			strength = 1.0
			BackDist = 3.4
			BackRange = 3.4
		}
	]
}
DOF_CAR_SelChar_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__REAL
			scefName = Depth_of_Field__REAL
			type = dof
			on = 1
			allowvideo = 0
			strength = 1.0
			BackDist = 3.4
			BackRange = 3.4
		}
	]
}
DOF_CAR_SelGender_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__REAL
			scefName = Depth_of_Field__REAL
			type = dof
			on = 1
			allowvideo = 0
			strength = 1.0
			BackDist = 3.4
			BackRange = 3.4
		}
	]
}
DOF_CAR_SelectTorso_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 1.9
			farblurend = 2.5
		}
	]
}
DOF_CAR_Sel_Instr_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.75
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 0.0
			farblurend = 14.29
		}
	]
}
DOF_CAR_Sel_Glasses_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__REAL
			scefName = Depth_of_Field__REAL
			type = dof
			on = 1
			allowvideo = 0
			strength = 1.0
			BackDist = 3.4
			BackRange = 3.4
		}
	]
}
DOF_CAR_Sel_Glasses_wide_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__REAL
			scefName = Depth_of_Field__REAL
			type = dof
			on = 1
			allowvideo = 0
			strength = 1.0
			BackDist = 2.7
			BackRange = 1.4
		}
	]
}
DOF_CAR_Sel_MicStand_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 3.0
			farblurend = 4.0
		}
	]
}
DOF_CAR_Sel_Microphone_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 0.55
			farblurend = 0.8
		}
	]
}
DOF_CAR_Sel_Guitar_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.82
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 1.7
			farblurend = 3.0
		}
	]
}
DOF_CAR_Sel_Guitar_Hardware_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.9
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 1.0
			farblurend = 1.1
		}
	]
}
DOF_CAR_Sel_Drums_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.5
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 3.0
			farblurend = 4.0
		}
	]
}
DOF_CAR_sel_drumsticks_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 1.0
			farblurend = 3.0
		}
	]
}
DOF_CAR_Sel_Tat_R_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 1.3
			farblurend = 1.6
		}
	]
}
DOF_CAR_Sel_Tat_L_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 1.3
			farblurend = 1.6
		}
	]
}
DOF_Band_Select_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 3.0
			farblurend = 13.0
		}
	]
}
GigRoom_Section01_tod_manager = ASSERT_ON_USE
GigRoom_Section02_tod_manager = ASSERT_ON_USE
GigRoom_Section03_tod_manager = ASSERT_ON_USE
GigRoom_Section04_tod_manager = ASSERT_ON_USE
GigRoom_Section05_tod_manager = ASSERT_ON_USE
DOF_CAR_Photo_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 1.0
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 1.5
			farblurend = 4.5
		}
	]
}
Credits_MinDOF_tod_manager = {
	screen_fx = [
		{
			name = Depth_of_Field__simplified_
			scefName = Depth_of_Field__simplified_
			type = dof3
			on = 1
			strength = 0.69229996
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 50.0
			farblurend = 100.0
		}
	]
}
