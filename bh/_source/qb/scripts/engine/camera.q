camera_default_far_clip = 500.0
widescreen_camera_fov = 72.0
current_screen_mode = standard_screen_mode
last_screen_mode = standard_screen_mode

script screen_setup_widescreen 
	SetScreen \{Aspect = 1.7777778
		Angle = $widescreen_camera_fov
		letterbox = 0}
	change \{current_screen_mode = widescreen_screen_mode}

endscript
fake_letterboxing = ASSERT_ON_USE
