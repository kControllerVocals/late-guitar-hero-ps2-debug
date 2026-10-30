transition_playing = false
current_playing_transition = none
finalbandintro_transition_playing = 0
skipping_jimmy_encore_anim = 0
metallica_intro_vo_order = [
]
metallica_intro_vo_index = 0
metallica_intro_vo_current_struct = {
}
careerintro_current_slomo = 1.0
0x5a01213a = 825
transition_types = {
	careerintro = {
		textnl = 'careerintro'
	}
	intro = {
		textnl = 'intro'
	}
	fastintro = {
		textnl = 'fastintro'
	}
	fastintrotutorial = {
		textnl = 'fastintrotutorial'
	}
	practice = {
		textnl = 'practice'
	}
	preencore = {
		textnl = 'preencore'
	}
	encore = {
		textnl = 'encore'
	}
	restartencore = {
		textnl = 'restartencore'
	}
	preboss = {
		textnl = 'preboss'
	}
	boss = {
		textnl = 'boss'
	}
	restartboss = {
		textnl = 'restartboss'
	}
	songwon = {
		textnl = 'songwon'
	}
	songlost = {
		textnl = 'songlost'
	}
	loading = {
		textnl = 'loading'
	}
	loadingintro = {
		textnl = 'loadingintro'
	}
	finalbandintro = {
		textnl = 'finalbandintro'
	}
	finalbandoutro = {
		textnl = 'finalbandoutro'
	}
	metallicavointro = {
		textnl = 'metallicavointro'
	}
}
celeb_intro_transitions = [
	{
		intro = 'intro_lemmy'
		song = aceofspades
		part = no_replacements
		debug_preview_in_venue = load_z_amazon
	}
	{
		intro = 'intro_kingdiamond'
		song = evil
		part = no_replacements
		debug_preview_in_venue = load_z_amazon
	}
]
default_immediate_transition = {
	time = 0
	scripttable = [
	]
}
common_immediate_transition = {
	scripttable = [
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras'
				changenow
			}
		}
		{
			time = 0
			scr = bandmanager_setplayingintroanims
		}
		{
			time = 0
			scr = transition_startrendering
		}
	]
}
default_fastintro_transition = {
	time = 3000
	scripttable = [
	]
}
common_fastintro_transition = {
	scripttable = [
		{
			time = 0
			scr = transition_stoprendering
		}
		{
			time = 0
			scr = bandmanager_setplayingintroanims
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
				fast
			}
		}
		{
			time = 0
			scr = spirit_fadein
			params = {
			}
		}
		{
			time = 0
			scr = transition_startrendering
		}
		{
			time = 100
			scr = gh_sfx_intro_warmup_fast
		}
		{
			time = 0
			scr = band_playtransitionidles
			params = {
				from_restart = true
			}
		}
		{
			time = 100
			scr = enable_tutorial_pause
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
default_fastintrotutorial_transition = {
	time = 3000
	scripttable = [
	]
}
common_fastintrotutorial_transition = {
	scripttable = [
		{
			time = 0
			scr = transition_stoprendering
		}
		{
			time = 0
			scr = bandmanager_setplayingintroanims
		}
		{
			time = 0
			scr = training_setup_camera
			params = {
				name = cameracutcam
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
				fast
			}
		}
		{
			time = 0
			scr = band_playtransitionidles
		}
		{
			time = 0
			scr = transition_startrendering
		}
		{
			time = 100
			scr = enable_tutorial_pause
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
default_restartencore_transition = {
	time = 3000
	scripttable = [
	]
}
common_restartencore_transition = {
	scripttable = [
		{
			time = 0
			scr = transition_stoprendering
		}
		{
			time = 0
			scr = bandmanager_setplayingintroanims
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
				fast
			}
		}
		{
			time = 0
			scr = band_playtransitionidles
			params = {
				from_restart = true
			}
		}
		{
			time = 0
			scr = transition_startrendering
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
default_restartboss_transition = {
	time = 3000
	scripttable = [
	]
}
common_restartboss_transition = {
	scripttable = [
		{
			time = 0
			scr = transition_stoprendering
		}
		{
			time = 0
			scr = bandmanager_setplayingintroanims
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
				fast
			}
		}
		{
			time = 0
			scr = band_playtransitionidles
		}
		{
			time = 0
			scr = transition_startrendering
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
default_practice_transition = {
	time = 5000
	scripttable = [
	]
}
common_practice_transition = {
	scripttable = [
		{
			time = 0
			scr = transition_stoprendering
		}
		{
			time = 0
			scr = bandmanager_setplayingintroanims
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
				practice
			}
		}
		{
			time = 0
			scr = transition_startrendering
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
default_intro_transition = {
	time = 19500
	scripttable = [
	]
}
common_intro_transition = {
	scripttable = [
		{
			time = 0
			scr = transition_stoprendering
		}
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
			}
		}
		{
			time = 0
			scr = 0x29c769a7
			params = {
			}
		}
		{
			time = 0
			scr = transition_startrendering
		}
		{
			time = 100
			scr = gh_sfx_intro_warmup
		}
		{
			time = 100
			scr = start_preloaded_celeb_intro_stream
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
default_finalbandintro_transition = {
	time = 20000
	scripttable = [
	]
}
common_finalbandintro_transition = {
	scripttable = [
		{
			time = 0
			scr = start_preloaded_celeb_intro_stream
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_finalbandintro'
				changenow
			}
		}
		{
			time = 60
			scr = transition_startrendering
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
default_preencore_transition = {
	time = 10000
	scripttable = [
		{
			time = 0
			scr = change_crowd_looping_sfx
			params = {
				crowd_looping_state = good
			}
		}
	]
}
common_preencore_transition = {
	scripttable = [
		{
			time = 0
			scr = 0x86ce76d8
			params = {
			}
		}
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = change_crowd_looping_sfx
			params = {
				crowd_looping_state = good
			}
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_no_band'
				changenow
			}
		}
		{
			time = 0
			scr = change_crowd_looping_sfx
			params = {
				crowd_looping_state = good
			}
		}
	]
	endwithdefaultcamera
}
default_encore_transition = {
	time = 5000
	scripttable = [
		{
			time = 0
			scr = 0x8c046839
			params = {
			}
		}
	]
}
common_encore_transition = {
	scripttable = [
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = transition_stoprendering
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_encore'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
			}
		}
		{
			time = 0
			scr = transition_startrendering
		}
		{
			time = 100
			scr = start_preloaded_encore_event_stream
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
default_preboss_transition = {
	time = 10000
	scripttable = [
	]
}
common_preboss_transition = {
	scripttable = [
		{
			time = 0
			scr = 0x86ce76d8
			params = {
			}
		}
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_preboss'
				changenow
			}
		}
	]
	endwithdefaultcamera
}
default_boss_transition = {
	time = 10000
	scripttable = [
	]
}
common_boss_transition = {
	scripttable = [
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = transition_stoprendering
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_boss'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
			}
		}
		{
			time = 0
			scr = play_intro_anims
			params = {
			}
		}
		{
			time = 100
			scr = transition_startrendering
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
default_songwon_transition = {
	time = 10000
	scripttable = [
	]
}
common_songwon_transition = {
	scripttable = [
		{
			time = 0
			scr = 0x86ce76d8
			params = {
			}
		}
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_win'
				changenow
			}
		}
	]
	endwithdefaultcamera
}
default_songlost_transition = {
	time = 8000
	scripttable = [
	]
}
common_songlost_transition = {
	scripttable = [
		{
			time = 0
			scr = 0xf4c437d3
			params = {
			}
		}
		{
			time = 0
			scr = change_crowd_looping_sfx
			params = {
				crowd_looping_state = bad
			}
		}
		{
			time = 0
			scr = kill_gem_scroller
			params = {
				type = outro
				kill_cameracuts_iterator
				song_failed_pitch_streams = 1
			}
		}
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_lose'
				changenow
			}
		}
	]
	endwithdefaultcamera
}
default_finalbandoutro_transition = {
	time = 10000
	scripttable = [
	]
}
common_finalbandoutro_transition = {
	scripttable = [
		{
			time = 0
			scr = 0x86ce76d8
			params = {
			}
		}
		{
			time = 0
			scr = kill_gem_scroller
			params = {
				type = outro
				kill_cameracuts_iterator
			}
		}
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_finalbandoutro'
				changenow
			}
		}
		{
			time = 0
			scr = start_preloaded_finalbandoutro_stream
		}
	]
	endwithdefaultcamera
}
default_loading_transition = {
	time = 12000
	scripttable = [
	]
}
common_loading_transition = {
	scripttable = [
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_no_band'
				changenow
			}
		}
		{
			time = 0
			scr = createinvenueloadingscreen
			params = {
			}
		}
	]
}
default_loadingintro_transition = {
	time = 12000
	scripttable = [
	]
}
common_loadingintro_transition = {
	scripttable = [
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = bandmanager_setplayingintroanims
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
				fast
			}
		}
		{
			time = 0
			scr = band_playtransitionidles
		}
		{
			time = 0
			scr = transition_startrendering
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
override_intro_lemmy_transition = {
	time = 10500
	scripttable = [
		{
			time = 1
			scr = band_playtransitionidles
		}
		{
			time = 1
			scr = lemmy_introfx
		}
		{
			time = 1
			scr = band_hide
			params = {
				name = guitarist
			}
		}
		{
			time = 1
			scr = transition_playsimpleanim
			params = {
				name = vocalist
				anim = s_lemmy_intro_aceofspades
			}
		}
		{
			time = 1
			scr = specialcamera_playanim
			params = {
				obj = 'TRG_Geo_Camera_Performance_SING01'
				anim = s_lemmy_intro_aceofspades_c01
			}
		}
		{
			time = 1
			scr = transition_changeik
			params = {
				name = vocalist
				enabled = false
			}
		}
		{
			time = 10500
			scr = transition_changeik
			params = {
				name = vocalist
				enabled = true
			}
		}
		{
			time = 10500
			scr = band_unhide
			params = {
				name = guitarist
			}
		}
		{
			time = 10500
			scr = lemmy_introfx_kill
		}
	]
}
override_intro_kingdiamond_transition = {
	time = 13200
	scripttable = [
		{
			time = 1
			scr = band_playtransitionidles
		}
		{
			time = 1
			scr = kingdiamond_introfx
		}
		{
			time = 1
			scr = transition_playsimpleanim
			params = {
				name = vocalist
				anim = s_kingd_intro_evil
			}
		}
		{
			time = 1
			scr = specialcamera_playanim
			params = {
				obj = 'TRG_Geo_Camera_Performance_SING01'
				anim = s_kingd_intro_evil_c01
			}
		}
		{
			time = 1
			scr = transition_changeik
			params = {
				name = vocalist
				enabled = false
			}
		}
		{
			time = 13200
			scr = transition_changeik
			params = {
				name = vocalist
				enabled = true
			}
		}
		{
			time = 13200
			scr = kingdiamond_introfx_kill
		}
	]
}

script play_metallica_intro_slomo_anims 
	band_playidle \{name = guitarist
		restart
		no_wait}
	band_playidle \{name = bassist
		restart
		no_wait}
	band_playidle \{name = vocalist
		restart
		no_wait}
	band_playidle \{name = drummer
		restart
		no_wait}
	killspawnedscript \{name = band_movetostartnode}
	band_playclip \{clip = metallica_intro_underground_clip}
endscript
metallica_intro_slomo_clip = {
	anims = {
		vocalist = sbdg_slowmo_introtest_s
		guitarist = sbdg_slowmo_introtest_g
		bassist = sbdg_slowmo_introtest_b
		drummer = sbdg_slowmo_introtest_d
	}
	startnodes = {
		vocalist = 'drummer_start'
		guitarist = 'drummer_start'
		bassist = 'drummer_start'
		drummer = 'drummer_start'
	}
	arms = {
		vocalist = {
			ik_targetl = slave
			ik_targetr = slave
			strum = off
			fret = off
			chord = off
		}
		guitarist = {
			ik_targetl = slave
			ik_targetr = slave
			strum = off
			fret = off
			chord = off
		}
		bassist = {
			ik_targetl = slave
			ik_targetr = slave
			strum = off
			fret = off
			chord = off
		}
		drummer = {
			ik_targetl = slave
			ik_targetr = slave
			strum = off
			fret = off
			chord = off
		}
	}
	cameras = [
		{
			name = 'TRG_Geo_Camera_Performance_DRUM01'
			anim = sbdg_slowmo_introtest_c01
			weight = 1
		}
		{
			name = 'TRG_Geo_Camera_Performance_DRUM01'
			anim = sbdg_slowmo_introtest_c02
			weight = 1
		}
		{
			name = 'TRG_Geo_Camera_Performance_DRUM01'
			anim = sbdg_slowmo_introtest_c01
			weight = 1
		}
		{
			name = 'TRG_Geo_Camera_Performance_DRUM01'
			anim = sbdg_slowmo_introtest_c03
			weight = 1
		}
		{
			name = 'TRG_Geo_Camera_Performance_DRUM01'
			anim = sbdg_slowmo_introtest_c01
			weight = 1
		}
	]
}
metallica_intro_underground_clip = {
	anims = {
		vocalist = sbdg_slowmo_introtest_s_understage
		guitarist = sbdg_slowmo_introtest_g_understage
		bassist = sbdg_slowmo_introtest_b_understage
		drummer = sbdg_slowmo_introtest_d_understage
	}
	startnodes = {
		vocalist = 'drummer_start'
		guitarist = 'drummer_start'
		bassist = 'drummer_start'
		drummer = 'drummer_start'
	}
	arms = {
		vocalist = {
			ik_targetl = slave
			ik_targetr = slave
			strum = off
			fret = off
			chord = off
		}
		guitarist = {
			ik_targetl = slave
			ik_targetr = slave
			strum = off
			fret = off
			chord = off
		}
		bassist = {
			ik_targetl = slave
			ik_targetr = slave
			strum = off
			fret = off
			chord = off
		}
		drummer = {
			ik_targetl = slave
			ik_targetr = slave
			strum = off
			fret = off
			chord = off
		}
	}
}

script z_forum_camera_careerintro 
	setslomo \{1}
	wait \{1537
		frames}
endscript

script setslomo_intro \{slomo_factor = 1.0}
	change careerintro_current_slomo = <slomo_factor>
	setslomo <slomo_factor>
endscript

script 0x52d930fd 

	preload_celeb_intro_stream
endscript
default_careerintro_transition = {
	time = 57666
	scripttable = [
	]
}
common_careerintro_transition = {
	scripttable = [
		{
			time = 0
			scr = setslomo
			params = {
				1
			}
		}
		{
			time = 0
			scr = 0xcb4eae5f
		}
		{
			time = 0
			scr = disable_pause
		}
		{
			time = 0
			scr = start_preloaded_celeb_intro_stream
		}
		{
			time = 0
			scr = transition_stoprendering
		}
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
			}
		}
		{
			time = 0
			scr = play_intro_anims
			params = {
			}
		}
		{
			time = 100
			scr = careerintro_transition_ecstacyofgold
		}
		{
			time = 100
			scr = careerintro_lightingandfx
		}
		{
			time = 100
			scr = band_playclip
			params = {
				clip = metallica_intro_underground_clip
			}
		}
		{
			time = 300
			scr = transition_startrendering
		}
		{
			time = 5800
			scr = band_playclip
			params = {
				clip = metallica_intro_slomo_clip
			}
		}
		{
			time = 5800
			scr = careerintro_transition_resetslomo
		}
		{
			time = 6300
			scr = careerintro_transition_titlecard
		}
		{
			time = 12000
			scr = band_playclip
			params = {
				clip = metallica_intro_underground_clip
			}
		}
		{
			time = 11000
			scr = setslomo_intro
			params = {
				slomo_factor = 1.0
			}
		}
		{
			time = 57666
			scr = 0xcb3dba58
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}

script 0xcb4eae5f 
	vocalist :hide
	bassist :hide
	drummer :hide
	guitarist :hide
endscript

script 0xcb3dba58 
	vocalist :unhide
	bassist :unhide
	drummer :unhide
	guitarist :unhide
	bandmanager_airguitarcheat
	bandmanager_invisiblecharacterscheat
endscript

script careerintro_lightingandfx 
	safekill \{nodename = z_forum_js_ground}
	safecreate \{nodename = z_forum_careerintro_ground}
	changenodeflag \{ls_mood_blackout
		0}
	safekill \{nodename = z_forum_tunnel_light}
	wait \{6.0
		seconds}
	wait \{1.3
		seconds}
	spawnscriptnow \{z_forumcareerintro_pyro}
	wait \{2.5
		seconds}
	z_forum_pyro_moments_front_1
	z_forum_pyro_moments_mid_2
	z_forum_pyro_moments_back_2
endscript

script careerintro_introcamsnapshots 
	lightshow_playsnapshot \{name = falling02
		usesnapshotpositions = true
		save = true}
	wait \{4
		seconds}
	lightshow_settime \{time = 1}
	lightshow_playsnapshot \{name = careerintro_cut1_02
		usesnapshotpositions = true
		save = true}
endscript

script careerintro_logocamsnapshots 
	lightshow_settime \{time = 0}
	lightshow_playsnapshot \{name = careerintro_dark_02
		usesnapshotpositions = true
		save = true}
	wait \{0.5
		seconds}
	lightshow_settime \{time = 0.4}
	lightshow_playsnapshot \{name = careerintro_logocam_dark_01
		usesnapshotpositions = true
		save = true}
endscript

script careerintro_cam6snapshots 
	wait \{1.3
		second}
	lightshow_settime \{time = 0.5}
	lightshow_playsnapshot \{name = careerintro_dark_02
		usesnapshotpositions = true
		save = true}
endscript

script careerintro_pyrolightmodulate 
	enablelight \{name = z_forum_gfx_careerintro_pyrolight_front_01}
	setlightintensity \{name = z_forum_gfx_careerintro_pyrolight_front_01
		i = 0}
	setlightintensityovertime \{name = z_forum_gfx_careerintro_pyrolight_front_01
		i = 2
		time = 0.2}
	setlightintensityovertime \{name = z_forum_gfx_careerintro_pyrolight_front_01
		i = 0
		time = 0.2}
	disablelight \{name = z_forum_gfx_careerintro_pyrolight_front_01}
endscript

script sunflareright 
	obj_rotz \{speed = 100}
endscript

script sunflareleft 
	obj_rotx \{speed = -100}
endscript
z_forumcareerintro_pyro_pos = [
	(9.64964, -1.33624, -15.3742)
	(10.7390995, -0.781065, -15.618501)
	(11.1995, -1.2849901, -14.436999)
	(12.541901, -1.11918, -14.3761)
]

script z_forumcareerintro_pyro 
	getuniquecompositeobjectid \{preferredid = fe_rocket_01}
	createparticlesystem_withscript name = <uniqueid> objid = z_forum_gfx_fx_fireworks_launchbox_01 params_script = $gp_fx_fe_fireworks_sparklerocq groupid = zoneparticles
	getuniquecompositeobjectid \{preferredid = fe_rocket_02}
	createparticlesystem_withscript name = <uniqueid> objid = z_forum_gfx_fx_fireworks_launchbox_01 params_script = $gp_fx_fe_fireworks_sparklerocket_top_01 groupid = zoneparticles
	wait \{1
		frame}
	getuniquecompositeobjectid \{preferredid = fe_rocket_05}
	createparticlesystem_withscript name = <uniqueid> objid = z_forum_gfx_fx_fireworks_launchbox_02 params_script = $gp_fx_fe_fireworks_sparklerocq groupid = zoneparticles
	getuniquecompositeobjectid \{preferredid = fe_rocket_06}
	createparticlesystem_withscript name = <uniqueid> objid = z_forum_gfx_fx_fireworks_launchbox_02 params_script = $gp_fx_fe_fireworks_sparklerocket_top_01 groupid = zoneparticles
	wait \{1
		frame}
	getuniquecompositeobjectid \{preferredid = fe_rocket_051}
	createparticlesystem_withscript name = <uniqueid> objid = z_forum_gfx_fx_fireworks_launchbox_05 params_script = $gp_fx_fe_fireworks_sparklerocq groupid = zoneparticles
	getuniquecompositeobjectid \{preferredid = fe_rocket_061}
	createparticlesystem_withscript name = <uniqueid> objid = z_forum_gfx_fx_fireworks_launchbox_05 params_script = $gp_fx_fe_fireworks_sparklerocket_top_01 groupid = zoneparticles
	wait \{1
		frame}
	getuniquecompositeobjectid \{preferredid = fe_rocket_052}
	createparticlesystem_withscript name = <uniqueid> objid = z_forum_gfx_fx_fireworks_launchbox_06 params_script = $gp_fx_fe_fireworks_sparklerocq groupid = zoneparticles
	getuniquecompositeobjectid \{preferredid = fe_rocket_062}
	createparticlesystem_withscript name = <uniqueid> objid = z_forum_gfx_fx_fireworks_launchbox_06 params_script = $gp_fx_fe_fireworks_sparklerocket_top_01 groupid = zoneparticles
	wait \{1
		frame}
	getuniquecompositeobjectid \{preferredid = fe_rocket_053}
	createparticlesystem_withscript name = <uniqueid> objid = z_forum_gfx_fx_fireworks_launchbox_07 params_script = $gp_fx_fe_fireworks_sparklerocq groupid = zoneparticles
	getuniquecompositeobjectid \{preferredid = fe_rocket_063}
	createparticlesystem_withscript name = <uniqueid> objid = z_forum_gfx_fx_fireworks_launchbox_07 params_script = $gp_fx_fe_fireworks_sparklerocket_top_01 groupid = zoneparticles
	z_forum_gfx_fx_fireworks_launchbox_01 :obj_movetopos \{(9.70019, 6.8198104, -20.407299)
		time = 1}
	z_forum_gfx_fx_fireworks_launchbox_02 :obj_movetopos \{(15.811001, 8.627581, -13.018901)
		time = 1}
	z_forum_gfx_fx_fireworks_launchbox_05 :obj_movetopos \{(7.64603, 4.50002, -21.449202)
		time = 1}
	z_forum_gfx_fx_fireworks_launchbox_06 :obj_movetopos \{(10.5491, 8.120601, -17.01)
		time = 1}
	z_forum_gfx_fx_fireworks_launchbox_07 :obj_movetopos \{(17.361599, 5.06249, -14.971999)
		time = 1}
	getuniquecompositeobjectid \{preferredid = z_forumcareerintro_pyro_fsc06ww}
	createparticlesystem name = <uniqueid> pos = (16.4316, -0.37734798, -24.3222) params_script = $gp_careerintro_bigexplosion groupid = zoneparticles
	getuniquecompositeobjectid \{preferredid = z_forumcareerintro_pyro_fsc022sww3}
	createparticlesystem name = <uniqueid> pos = (10.0069, 4.23252, -12.061501) params_script = $gp_careerintro_widesparks_01 groupid = zoneparticles
	i = 0
	begin
	getuniquecompositeobjectid \{preferredid = z_forumcareerintro_pyro_fsc01}
	createparticlesystem name = <uniqueid> pos = ($z_forumcareerintro_pyro_pos [<i>]) params_script = $gp_fx_fsc_bottomglow_01 groupid = zoneparticles
	getuniquecompositeobjectid \{preferredid = z_forumcareerintro_pyro_fsc02}
	createparticlesystem name = <uniqueid> pos = ($z_forumcareerintro_pyro_pos [<i>]) params_script = $gp_fx_careerintro_pyroglow_01 groupid = zoneparticles
	wait \{1
		frame}
	getuniquecompositeobjectid \{preferredid = z_forumcareerintro_pyro_fsc03}
	createparticlesystem name = <uniqueid> pos = ($z_forumcareerintro_pyro_pos [<i>]) params_script = $gp_fx_careerintro_pyroglow_02 groupid = zoneparticles
	wait \{1
		frame}
	getuniquecompositeobjectid \{preferredid = z_forumcareerintro_pyro_fsc04}
	createparticlesystem name = <uniqueid> pos = ($z_forumcareerintro_pyro_pos [<i>]) params_script = $gp_fx_fsc_glowsmoke_01 groupid = zoneparticles
	wait \{1
		frame}
	getuniquecompositeobjectid \{preferredid = z_forumcareerintro_pyro_fsc05}
	createparticlesystem name = <uniqueid> pos = ($z_forumcareerintro_pyro_pos [<i>] + (0.0, 1.0, 0.0)) params_script = $gp_fx_careerintro_pyrosmoke_01 groupid = zoneparticles
	wait \{1
		frame}
	getuniquecompositeobjectid \{preferredid = z_forumcareerintro_pyro_fsc0555}
	createparticlesystem name = <uniqueid> pos = ($z_forumcareerintro_pyro_pos [<i>]) params_script = $gp_fx_fsc_greysmoke_column_01 groupid = zoneparticles
	i = (<i> + 1)
	wait \{1
		frame}
	repeat 4
endscript
default_metallicavointro_transition = {
	time = 9500
	scripttable = [
	]
}
common_metallicavointro_transition = {
	time = 9500
	scripttable = [
		{
			time = 0
			scr = start_preloaded_celeb_intro_stream
		}
		{
			time = 0
			scr = transition_stoprendering
		}
		{
			time = 0
			scr = crowd_allplayanim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = transition_cameracut
			params = {
				prefix = 'cameras_MetallicaVOIntro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
			}
		}
		{
			time = 0
			scr = play_intro_anims
			params = {
			}
		}
		{
			time = 100
			scr = gh_metallicavo_intro_warmup
		}
		{
			time = 100
			scr = transition_startrendering
		}
	]
	endwithdefaultcamera
	syncwithnotecameras
}
default_cameras_metallicavointro = [
	{
		name = intro
		lockto = moment_cam_lock_target_01
		locktobone = bone_camera
		pos = (0.0, 0.0, 0.0)
		quat = (0.0, 0.0, 0.0)
		fov = 71.0
	}
]

script playintrocam 
	if NOT gotparam \{anim}

		return
	endif
	if NOT compositeobjectexists \{name = vocalist}

		return
	endif
	momentcamera_playanim lock_target = moment_cam_lock_target_01 node = 'TRG_Geo_Camera_Performance_SING01' anim = <anim>
endscript

script createinvenueloadingscreen 

	gamemode_gettype
	if NOT (($current_transition) = encore)
		ui_event_wait \{event = menu_change
			data = {
				state = uistate_song_breakdown
			}}
	else
		ui_event_wait \{event = menu_change
			data = {
				state = uistate_encore_confirmation
			}}
	endif
endscript
0xa3ce893c = 0

script pauseinvenueloadingscreen 
	begin
	if screenelementexists \{id = my_breakdown_id}
		break
	elseif screenelementexists \{id = encoreinterface}
		0x4fe76d9d
		break
	else
		waitonegameframe
	endif
	repeat
	change \{0xa3ce893c = 0}
	begin
	if ($0xa3ce893c = 1)
		if screenelementexists \{id = 0x6bb63ae6}
			destroyscreenelement \{id = 0x6bb63ae6}
		endif
		create_loading_screen
		break
	else
		waitonegameframe
	endif
	repeat
	if screenelementexists \{id = my_breakdown_id}
		destroyscreenelement \{id = my_breakdown_id}
	elseif screenelementexists \{id = encoreinterface}
		destroyscreenelement \{id = encoreinterface}
	endif
	if screenelementexists \{id = my_breakdown_id}
		destroyscreenelement \{id = my_breakdown_id}
	endif
	if screenelementexists \{id = user_control_container}
		destroyscreenelement \{id = user_control_container}
	endif
endscript

script common_loading_transitionend 

	gamemode_gettype
	if (($is_network_game = 1 && <type> = career) || $is_network_game = 0)
		if ((<type> = quickplay) && ($is_network_game = 0))
			return
		endif
		ui_event \{event = menu_back
			data = {
				state = uistate_gameplay
			}}
		if compositeobjectexists \{name = vocalist}
			vocalist :unhide
		endif
	endif
endscript

script transition_selecttransition \{practice_intro = 0
		force_encore = 0}

	change \{finalbandintro_transition_playing = 0}
	change \{show_boss_helper_screen = 0}
	change \{skipping_jimmy_encore_anim = 0}
	if (<practice_intro> = 1)
		return
	endif
	if ($current_transition = debugintro)
		change \{current_transition = intro}
		return
	endif
	if ($coop_dlc_active = 1)
		change \{current_transition = fastintro}
		return
	endif
	if ($debug_encore = 1)
		change \{current_transition = encore}
		return
	endif
	if ($game_mode = p1_career ||
			$game_mode = p2_career ||
			$game_mode = p3_career ||
			$game_mode = p4_career)
		get_progression_globals ($current_progression_flag) use_current_tab = 1
		career_songs = <tier_global>
		tier = ($current_gig_number)
		if progression_isencoresong tier_global = <tier_global> tier = <tier> song = ($current_song)
			<is_encore> = true
			if getpakmancurrent \{map = zones}
				if (<pak> = z_atlantis || <pak> = z_quebec)
					<is_encore> = false
				endif
			endif
			if (<is_encore> = true)
				change \{current_transition = encore}
				return
			endif
		endif
		if (<force_encore> = 1)
			change \{current_transition = encore}
			return
		endif
		if NOT progression_check_intro_complete
			change \{current_transition = careerintro}
			return
		endif
		if transition_selectcelebtransition
			return
		endif
	endif
	if ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff || $game_mode = p2_battle)
		change \{current_transition = fastintro}
		return
	endif
	change \{current_transition = intro}
endscript

script 0x4b275644 
	valid = 1
	if structurecontains structure = ($celeb_intro_transitions [<index>]) song
		if NOT ($current_song = $celeb_intro_transitions [<index>].song)
			return \{false}
		endif
	else
		return \{false}
	endif
	if structurecontains structure = ($celeb_intro_transitions [<index>]) venue
		if NOT ($current_level = $celeb_intro_transitions [<index>].venue)
			return \{false}
		endif
	else
		return \{false}
	endif
	if (<num_players_shown> > 1)
		part = ($celeb_intro_transitions [<index>].part)
		switch <part>
			case guitar
			if is_any_player_on_part \{part = guitar}
				return \{false}
			endif
			case guitar_vocals
			if is_any_player_on_part \{part = guitar}
				if is_any_player_on_part \{part = vocals}
					return \{false}
				endif
			endif
			case bass_vocals
			if is_any_player_on_part \{part = bass}
				if is_any_player_on_part \{part = vocals}
					return \{false}
				endif
			endif
			case vocals
			if is_any_player_on_part \{part = vocals}
				return \{false}
			endif
			case drums
			if is_any_player_on_part \{part = drum}
				return \{false}
			endif
			case no_replacements
			valid = <valid>
			default
			return \{false}
		endswitch
	endif
	if structurecontains structure = ($celeb_intro_transitions [<index>]) boss_song
		boss_song = ($celeb_intro_transitions [<index>].intro)
		gamemode_getnumplayersshown
		if ((<num_players_shown> = 1) && ($player1_status.part = guitar))
			if (<boss_song> = false)
				return \{false}
			endif
		else
			if (<boss_song> = true)
				return \{false}
			endif
		endif
	endif
	return \{true}
endscript

script 0xc982aa27 
	getarraysize ($celeb_intro_transitions)
	index = 0
	gamemode_getnumplayersshown
	begin
	if 0x4b275644 index = <index> num_players_shown = <num_players_shown>
		return true index = <index>
	endif
	index = (<index> + 1)
	repeat <array_size>
	return \{false}
endscript

script transition_selectcelebtransition 
	return \{false}
endscript

script transition_randomizevointros 
	<result> = []
	getarraysize ($metallica_intro_vo_data.random_sets)
	<i> = 0
	begin
	addarrayelement array = <result> element = <i>
	<result> = <array>
	<i> = (<i> + 1)
	repeat <array_size>
	<i> = 0
	begin
	getrandomvalue a = 0 b = (<array_size> -1) integer name = newindex
	<temp> = (<result> [<i>])
	setarrayelement arrayname = result index = <i> newvalue = (<result> [<newindex>])
	setarrayelement arrayname = result index = <newindex> newvalue = <temp>
	<i> = (<i> + 1)
	repeat <array_size>
	change \{metallica_intro_vo_index = 0}
	change metallica_intro_vo_order = <result>
endscript

script transition_selectnextmetallicavoindex 
	change metallica_intro_vo_index = ($metallica_intro_vo_index + 1)
	getarraysize ($metallica_intro_vo_data.random_sets)
	if NOT ($metallica_intro_vo_index < <array_size>)
		transition_randomizevointros
	endif
endscript

script transition_shouldusevotransition 
	return \{false}
endscript

script transition_selectmetallicavotransition 
	if is_current_band_metallica
		<venue> = ($current_level)
		if transition_shouldusevotransition tier_global = <tier_global> tier = <tier> song = <song> venue = <venue>
			if gotparam \{transition_data}
				change \{current_transition = metallicavointro}
				change metallica_intro_vo_current_struct = <transition_data>
			endif
		endif
		return \{true}
	endif
	return \{false}
endscript

script transition_gettransitionspecificanim 

	if ($current_transition = <type>)
		<structure> = $metallica_intro_vo_current_struct
		if structurecontains structure = <structure> <key>
			return custom_anim_name = (<structure>.<key>)
		endif
	endif
endscript

script transition_killall 
	killspawnedscript \{id = transitions}
	change \{transition_playing = false}
	change \{current_playing_transition = none}
	0x11918493
endscript

script transition_getprefix \{type = intro}
	celeb_intro = 0
	if structurecontains structure = $transition_types <type>
		type_textnl = ($transition_types.<type>.textnl)
	else
		getarraysize ($celeb_intro_transitions)
		index = 0
		begin
		formattext checksumname = transition '%s' s = ($celeb_intro_transitions [<index>].intro)
		if (<type> = <transition>)
			type_textnl = ($celeb_intro_transitions [<index>].intro)
			celeb_intro = 1
			break
		endif
		index = (<index> + 1)
		repeat <array_size>
	endif
	if NOT gotparam \{type_textnl}


	endif
	return type_textnl = <type_textnl> celeb_intro = <celeb_intro>
endscript

script transition_getprops 
	transition_getprefix <...>
	getpakmancurrentname \{map = zones}
	formattext checksumname = transition_props '%s_%p_Transition' p = <type_textnl> s = <pakname>
	if NOT globalexists name = <transition_props>
		formattext checksumname = transition_props 'override_%p_Transition' p = <type_textnl>
	endif
	if NOT globalexists name = <transition_props>
		formattext checksumname = transition_props 'default_%p_Transition' p = <type_textnl> s = <pakname>
	endif
	if (<celeb_intro> = 1)
		if NOT globalexists name = <transition_props>
			transition_props = default_intro_transition
		endif
	endif
	formattext checksumname = common_transition_props 'Common_%p_Transition' p = <type_textnl>
	common_type_textnl = <type_textnl>
	if (<celeb_intro> = 1)
		common_type_textnl = 'intro'
		if NOT globalexists name = <common_transition_props>
			common_transition_props = common_intro_transition
		endif
	endif
	return type_textnl = <type_textnl> common_type_textnl = <common_type_textnl> transition_props = <transition_props> common_transition_props = <common_transition_props>
endscript

script transition_gettime \{type = intro}
	transition_getprops type = <type>
	return transition_time = ($<transition_props>.time)
endscript

script transition_play \{type = intro}

	transition_killall
	change current_playing_transition = <type>
	transition_getprops type = <type>
	getpakmancurrentname \{map = zones}
	formattext checksumname = event 'Common_%p_TransitionSetup' p = <common_type_textnl> s = <pakname>
	if scriptexists <event>
		<event>
	endif
	formattext checksumname = event '%s_%p_TransitionSetup' p = <type_textnl> s = <pakname>
	if scriptexists <event>
		spawnscriptnow <event>
	endif
	spawnscriptnow transition_play_spawned id = transitions params = {<...>}
	formattext checksumname = event 'GuitarEvent_Transition%s' s = <type_textnl>
	if scriptexists <event>
		spawnscriptnow <event>
	endif
endscript

script transition_play_spawned \{time_offset = -1}
	change \{transition_playing = true}
	getpakmancurrentname \{map = zones}
	transition_gettime type = <type>
	spawnscriptnow transition_play_iterator id = transitions params = {<...>}
	spawnscriptnow transition_play_iterator id = transitions params = {<...> transition_props = <common_transition_props>}
	if NOT (<time_offset> >= 0)
		getsongtimems
		time_offset = (0 - <time>)
	else
		time_offset = (0 - <time_offset>)
	endif
	begin
	getsongtimems time_offset = <time_offset>
	if (<transition_time> <= <time>)
		change \{transition_playing = false}
		break
	endif
	waitonegameframe
	repeat
	if structurecontains structure = ($<common_transition_props>) endwithdefaultcamera
		if ($finalbandintro_transition_playing = 1)
			if ($current_playing_transition = finalbandintro)
				change \{finalbandintro_transition_playing = 0}
			else
				stoprendering
			endif
		elseif ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff || $game_mode = p2_battle || $boss_battle = 1 || $current_song = jamsession)
			cameracuts_enablechangecam \{enable = false}
			getfps
			delay_ms = (0.0 - $time_input_offset)
			ms_per_frame = (1000.0 / <fps>)
			frames = (<delay_ms> / <ms_per_frame>)
			casttointeger \{frames}
			wait <frames> gameframes
			if ($current_song = jamsession)
				cameracuts_setarrayprefix \{prefix = 'cameras_jam_mode'
					changenow}
			else
				cameracuts_setarrayprefix \{prefix = 'cameras_headtohead'
					changenow}
			endif
		else
			if structurecontains structure = ($<common_transition_props>) syncwithnotecameras
				cameracuts_getnextnotecameratime
				getsongtimems
				if (<camera_time> >= -200 &&
						<camera_time> - <time> < 2000)
					cameracuts_enablechangecam \{enable = false}
				else
					if NOT ($game_mode = training || $game_mode = tutorial || $game_mode = practice)
						cameracuts_setarrayprefix \{prefix = 'cameras'
							changenow}
					else
						cameracuts_enablechangecam \{enable = false}
					endif
				endif
			else
				if NOT ($game_mode = training || $game_mode = tutorial || $game_mode = practice)
					cameracuts_setarrayprefix \{prefix = 'cameras'
						changenow}
				else
					cameracuts_enablechangecam \{enable = false}
				endif
			endif
		endif
	endif
	formattext checksumname = event 'Common_%p_TransitionEnd' p = <type_textnl> s = <pakname>
	if scriptexists <event>
		spawnscriptnow <event>
	endif
	formattext checksumname = event '%s_%p_TransitionEnd' p = <type_textnl> s = <pakname>
	if scriptexists <event>
		spawnscriptnow <event>
	endif
	change \{current_playing_transition = none}
endscript

script 0x93be8bd8 
	killspawnedscript \{name = 0xc5a6b981}
	if NOT ($0xc5b024f4 = none)
		0xc7acd659 unique_id = ($0xc5b024f4)
		change \{0xc5b024f4 = none}
	endif
endscript

script 0xc5a6b981 
	setspawninstancelimits \{max = 1
		management = ignore_spawn_request}
	vol = 65
	begin
	if ($0xc5b024f4 = none)
		return
	endif
	vol = (<vol> -0.65000004)
	0x7c757af0 $0xc5b024f4 vol = (<vol> / 100.0)
	waitonegameframe
	repeat 99
	if NOT ($0xc5b024f4 = none)
		0xc7acd659 unique_id = ($0xc5b024f4)
		change \{0xc5b024f4 = none}
	endif
endscript

script istransitionplaying 
	if gotparam \{type}
		if (<type> = $current_playing_transition)
			return \{true}
		endif
	else
		if NOT (<type> = none)
			return \{true}
		endif
	endif
	return \{false}
endscript

script transition_play_iterator 
	getsongtimems
	time_offset = (0 - <time>)
	getarraysize ($<transition_props>.scripttable)
	if (<array_size> = 0)
		return
	endif
	getsongtimems time_offset = <time_offset>
	array_count = 0
	begin
	begin
	getsongtimems time_offset = <time_offset>
	if ($<transition_props>.scripttable [<array_count>].time <= <time>)
		break
	endif
	waitonegameframe
	repeat
	if scriptexists ($<transition_props>.scripttable [<array_count>].scr)
		spawnscriptnow ($<transition_props>.scripttable [<array_count>].scr) id = transitions params = {transition_time = <transition_time> ($<transition_props>.scripttable [<array_count>].params) time_offset = (0 - <time_offset>)}
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
endscript

script transition_wait 
	begin
	if ($transition_playing = false)
		return
	endif
	waitonegameframe
	repeat
endscript

script clipplaydrummercamera 
	if NOT gotparam \{anim}

	endif
	if NOT gotparam \{index}

	endif
	if (<index> < 10)
		formattext checksumname = lock_target 'drummer_mocap_lock_target_0%i' i = <index>
	else
		formattext checksumname = lock_target 'drummer_mocap_lock_target_%i' i = <index>
	endif
	momentcamera_playanim {anim = <anim> $drumcam_params lock_target = <lock_target>}
endscript

script momentcamera_playanim \{cycle = 0
		start = 0.0
		blendduration = 0.0}
	if NOT compositeobjectexists name = <lock_target>

		return
	endif
	setsearchallassetcontexts
	getpakmancurrent \{map = zones}
	getpakmancurrentname \{map = zones}
	if gotparam \{start_node}
		extendcrc <pak> <start_node> out = start_node_id
		getwaypointpos name = <start_node_id>
		getwaypointdir name = <start_node_id>
		<lock_target> :obj_setposition position = <pos>
		<lock_target> :obj_setorientation dir = <dir>
	else
		suffix = ('_' + <node>)
		appendsuffixtochecksum base = <pak> suffixstring = <suffix>
		if compositeobjectexists name = <appended_id>
			<appended_id> :obj_getposition
			<lock_target> :obj_setposition position = <pos>
			<appended_id> :obj_getorientation
			dir = ((1.0, 0.0, 0.0) * <x> + (0.0, 1.0, 0.0) * <y> + (0.0, 0.0, 1.0) * <z>)
			<lock_target> :obj_setorientation dir = <dir>
		else

		endif
	endif
	if NOT gotparam \{tempo_anim}
		tempo_anim = <anim>
	endif
	spawnscriptnow momentcamera_playanim_spawned params = {name = <lock_target> anim = <anim> tempoanim = <tempo_anim> cycle = <cycle> start = <start> blendduration = <blendduration>}
	setsearchallassetcontexts \{off}
endscript

script momentcamera_playanim_spawned \{start = 0.0
		speed = 1.0
		blendduration = -1.0}

	if NOT compositeobjectexists name = <name>

		return
	endif
	begin
	setsearchallassetcontexts
	if NOT gotparam \{anim}
		<name> :anim_getdefaultanimname
		anim = <defaultanimname>
	endif
	if NOT gotparam \{tempoanim}
		tempoanim = anim
	endif
	<name> :removetags [animrequestedfovradians]
	<name> :anim_enable
	<name> :anim_command target = body command = degenerateblend_addbranch params = {
		tree = $specialcamera_standardanimbranch
		blendduration = <blendduration>
		params = {
			anim = <anim>
			speed = <speed>
			timertype = tempo
			start = <start>
			animevents = on
			tempoanim = <tempoanim>
			allowbeatskipping = true
		}
	}
	<name> :anim_command target = bodytimer command = timer_waitanimcomplete
	setsearchallassetcontexts \{off}
	if (<cycle> = 0)
		break
	endif
	repeat
endscript
specialcamera_objectcleanuplist = [
]

script specialcamera_addobjecttocleanuplist 
	<arr> = ($specialcamera_objectcleanuplist)
	addarrayelement array = <arr> element = <name>
	change specialcamera_objectcleanuplist = <array>

endscript

script specialcamera_cleanupallobjects 
	getarraysize ($specialcamera_objectcleanuplist)
	if (<array_size> > 0)
		<i> = 0
		begin
		<name> = ($specialcamera_objectcleanuplist [<i>])

		if compositeobjectexists name = <name>
			<name> :obj_switchscript specialcamera_cleanupobject
		endif
		<i> = (<i> + 1)
		repeat <array_size>
	endif
	change \{specialcamera_objectcleanuplist = [
		]}
endscript

script specialcamera_cleanupobject 
	setsearchallassetcontexts
	anim_getdefaultanimname
	anim = <defaultanimname>
	anim_command target = body command = degenerateblend_addbranch params = {
		tree = $specialcamera_standardanimbranch
		blendduration = 0.0
		params = {
			timertype = play
			anim = <anim>
		}
	}
	setsearchallassetcontexts \{off}
endscript

script specialcamera_playanim \{cycle = 0
		start = 0.0}
	setsearchallassetcontexts
	getpakmancurrent \{map = zones}
	getpakmancurrentname \{map = zones}
	formattext textname = suffix '_%s' s = <obj>
	appendsuffixtochecksum base = <pak> suffixstring = <suffix>
	cameraname = (<pakname> + <suffix>)
	if compositeobjectexists name = <appended_id>
		specialcamera_addobjecttocleanuplist name = <appended_id>
		<appended_id> :obj_switchscript specialcamera_playanim_spawned params = {anim = <anim> cycle = <cycle> start = <start> blendduration = <blendduration>}
	else

	endif
	setsearchallassetcontexts \{off}
endscript

script specialcamera_playanim_spawned \{start = 0.0
		speed = 1.0
		blendduration = -1.0}
	begin
	setsearchallassetcontexts
	if NOT gotparam \{anim}
		anim_getdefaultanimname
		anim = <defaultanimname>
	endif
	if NOT gotparam \{tempoanim}
		tempoanim = anim
	endif

	removetags \{[
			animrequestedfovradians
		]}
	anim_enable
	anim_command target = body command = degenerateblend_addbranch params = {
		tree = $specialcamera_standardanimbranch
		blendduration = <blendduration>
		params = {
			anim = <anim>
			speed = <speed>
			timertype = tempo
			start = <start>
			animevents = on
			tempoanim = <tempoanim>
			allowbeatskipping = true
		}
	}
	specialcamera_waitanimfinished
	setsearchallassetcontexts \{off}
	if (<cycle> = 0)
		break
	endif
	repeat
endscript

script specialcamera_waitanimfinished \{timer = bodytimer}
	anim_command target = <timer> command = timer_waitanimcomplete
endscript
specialcamera_standardanimbranch = {
	type = timertype
	id = bodytimer
	anim = anim
	tempo_anim = tempoanim
	anim_events = animevents
	allow_beat_skipping = allowbeatskipping
	speed = speed
	start = start
	[
		{
			type = source
			anim = anim
		}
	]
}

script transition_playanim \{cycle = 0}
	<obj> :obj_switchscript transition_playanim_spawned params = {anim = <anim> cycle = <cycle> blendduration = <blendduration>}
endscript

script transition_playanim_spawned 
	begin
	gameobj_playanim anim = <anim> blendduration = <blendduration>
	gameobj_waitanimfinished
	if (<cycle> = 0)
		break
	endif
	repeat
endscript

script transition_cameracut 
	if gotparam \{prefix}
		cameracuts_setarrayprefix <...> length = <transition_time>
	else
		if NOT ($current_playing_transition = none)
			transition_getprefix type = ($current_playing_transition)
		else
			transition_getprefix \{type = intro}
		endif
		getpakmancurrentname \{map = zones}
		formattext checksumname = cameras_array 'default_cameras_%t' t = <type_textnl>
		formattext textname = prefix 'cameras_%t' t = <type_textnl>
		if NOT globalexists name = <cameras_array>
			formattext checksumname = cameras_array '%s_cameras_%t' s = <pakname> t = <type_textnl>
			if NOT globalexists name = <cameras_array>
				prefix = 'cameras_intro'
			endif
		endif
		cameracuts_setarrayprefix <...> length = <transition_time>
	endif
endscript

script transition_stoprendering 

	stoprendering
endscript

script transition_startrendering 

	startrendering
	change \{is_changing_levels = 0}
	if ($blade_active = 1)
		change \{blade_active = 0}
		gh3_start_pressed \{from_handler}
	endif
endscript

script transition_printf 

endscript

script transitions_resetzone 

	getpakmancurrentname \{map = zones}
	formattext checksumname = reset_func '%s_ResetTransition' s = <pakname>
	if scriptexists <reset_func>
		<reset_func>
	endif
	formattext checksumname = nodearray_checksum '%s_NodeArray' s = <pakname>
	if NOT globalexists name = <nodearray_checksum> type = array
		return
	endif
	getarraysize $<nodearray_checksum>
	array_count = 0
	begin
	resetvalid = true
	if gotparam \{profile}
		resetvalid = false
		if structurecontains structure = ($<nodearray_checksum> [<array_count>]) profile
			if comparestructs struct1 = ($<nodearray_checksum> [<array_count>].profile) struct2 = (<profile>)
				resetvalid = true
			endif
		endif
	endif
	if structurecontains structure = ($<nodearray_checksum> [<array_count>]) createdfromvariable
		resetvalid = false
	endif
	if structurecontains structure = ($<nodearray_checksum> [<array_count>]) createdonprogress
		resetvalid = false
	endif
	if structurecontains structure = ($<nodearray_checksum> [<array_count>]) class
		if NOT ($<nodearray_checksum> [<array_count>].class = gameobject ||
				$<nodearray_checksum> [<array_count>].class = levelgeometry ||
				$<nodearray_checksum> [<array_count>].class = levelobject)
			resetvalid = false
		endif
	else
		resetvalid = false
	endif
	if (<resetvalid> = true)

		kill name = ($<nodearray_checksum> [<array_count>].name)
		if structurecontains structure = ($<nodearray_checksum> [<array_count>]) createdatstart
			create name = ($<nodearray_checksum> [<array_count>].name)
		endif
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
endscript

script common_intro_transitionsetup 


	preload_celeb_intro_stream
endscript

script common_preencore_transitionsetup 
	change_crowd_looping_sfx \{crowd_looping_state = good}
endscript

script common_preencore_transitionend 
endscript

script finalbandintro_transitionsetup 

	transition_getprefix type = ($current_playing_transition)
	if NOT ($celeb_intro_stream_id = none)
		0xc7acd659 unique_id = ($celeb_intro_stream_id)
		change \{celeb_intro_stream_id = none}
	endif
	if NOT ($0xc5b024f4 = none)
		0xc7acd659 unique_id = ($0xc5b024f4)
		change \{0xc5b024f4 = none}
	endif
	return
	preloadstream \{intro_finalgig}
	change celeb_intro_stream_id = <unique_id>
endscript

script common_finalbandoutro_transitionsetup 

	if NOT ($celeb_intro_stream_id = none)
		0xc7acd659 unique_id = ($celeb_intro_stream_id)
		change \{celeb_intro_stream_id = none}
	endif
	if NOT ($0xc5b024f4 = none)
		0xc7acd659 unique_id = ($0xc5b024f4)
		change \{0xc5b024f4 = none}
	endif
	return
	preloadstream \{encore_finalgig}
	change celeb_intro_stream_id = <unique_id>
	begin

	if preloadstreamdone <unique_id>
		break
	endif
	wait \{1
		gameframe}
	repeat
endscript

script common_encore_transitionsetup 

	preload_encore_event_stream
endscript

script common_boss_transitionsetup 
endscript

script common_encore_transitionend 
endscript

script preload_encore_bink_audio \{movie_name = 'z_artdeco_encore_audio'}
endscript

script common_loading_transitionsetup 
endscript
celeb_intro_stream_id = none
0xc5b024f4 = none

script preload_celeb_intro_stream 


	transition_getprefix type = ($current_playing_transition)
	if NOT ($celeb_intro_stream_id = none)
		0xc7acd659 unique_id = ($celeb_intro_stream_id)
		change \{celeb_intro_stream_id = none}
	endif
	if NOT ($0xc5b024f4 = none)
		0xc7acd659 unique_id = ($0xc5b024f4)
		change \{0xc5b024f4 = none}
	endif
	if ($current_song = jamsession)
		return
	endif
	if ((<celeb_intro> = 0) && ($current_playing_transition != careerintro))
		if NOT ($celeb_intro_stream_id = none)
			0xc7acd659 unique_id = ($celeb_intro_stream_id)
			change \{celeb_intro_stream_id = none}
		endif
		getpakmancurrentname \{map = zones}
		formattext checksumname = intro_stream_name '%s_intro' s = <pakname> addtostringlookup = true
		if NOT 0x810401fe filename_crc = <intro_stream_name> 0x3dd98e8d = 22050 stereo = true
			return
		endif
		if NOT (<unique_id> = 0x00000000)
			change celeb_intro_stream_id = <unique_id>
		endif
		if NOT ($celeb_intro_stream_id = none)
			begin

			if preloadstreamdone <unique_id>
				break
			endif
			wait \{1
				gameframe}
			repeat
		endif
		0xe68e695e
		return
	endif
	celeb_intro_checksum = ($current_playing_transition)
	if NOT 0x810401fe filename_crc = <celeb_intro_checksum> 0x3dd98e8d = 22050 stereo = true
		return
	endif
	if NOT (<unique_id> = 0x00000000)
		change celeb_intro_stream_id = <unique_id>
	endif
	if NOT ($celeb_intro_stream_id = none)
		begin

		if preloadstreamdone <unique_id>
			break
		endif
		wait \{1
			gameframe}
		repeat
	endif
endscript

script 0x7dd62285 

	begin
	getsongtimems
	if (<time> >= <time_offset>)
		return
	endif
	wait \{1
		gameframe}
	repeat
endscript

script 0x0499d8db 
	0x7dd62285 time_offset = (<time_offset> + ($0x5a01213a))
	startpreloadedstream ($celeb_intro_stream_id) buss = encore_events forcesafepreload = 1 pitch = 100
	change 0xc5b024f4 = ($celeb_intro_stream_id)
	change \{celeb_intro_stream_id = none}
endscript

script start_preloaded_celeb_intro_stream 

	if ($current_playing_transition = careerintro)
		return
	endif

	if NOT ($celeb_intro_stream_id = none)
		spawnscriptnow 0x0499d8db params = {time_offset = <time_offset>}
	endif
endscript

script 0x11918493 
	killspawnedscript \{name = 0x0499d8db}
	killspawnedscript \{name = 0x2d7f6343}
endscript
encore_event_stream_id = none

script preload_encore_event_stream 

	if NOT ($encore_event_stream_id = none)
		0xc7acd659 unique_id = ($encore_event_stream_id)
		change \{encore_event_stream_id = none}
	endif
	if NOT ($0xc5b024f4 = none)
		0xc7acd659 unique_id = ($0xc5b024f4)
		change \{0xc5b024f4 = none}
	endif
	getpakmancurrentname \{map = zones}
	formattext checksumname = encore_stream_name '%s_encore' s = <pakname> addtostringlookup = true
	if NOT 0x810401fe filename_crc = <encore_stream_name> 0x3dd98e8d = 22050 stereo = true
		return
	endif
	if NOT (<unique_id> = 0x00000000)
		change encore_event_stream_id = <unique_id>
	endif
	if NOT ($encore_event_stream_id = none)
		begin

		if preloadstreamdone <unique_id>
			break
		endif
		wait \{1
			gameframe}
		repeat
	endif
endscript

script 0x2d7f6343 
	0x7dd62285 time_offset = (<time_offset> + ($0x5a01213a))
	stopsoundevent \{$current_crowd_encore
		fade_time = 3
		fade_type = linear}

	startpreloadedstream \{$encore_event_stream_id
		buss = encore_events
		forcesafepreload = 1
		pitch = 100}
	change 0xc5b024f4 = ($encore_event_stream_id)
	change \{encore_event_stream_id = none}
endscript

script start_preloaded_encore_event_stream 

	if NOT ($encore_event_stream_id = none)
		spawnscriptnow 0x2d7f6343 params = {time_offset = <time_offset>}
	endif
endscript

script start_preloaded_finalbandoutro_stream 

	if NOT ($celeb_intro_stream_id = none)
		stopsoundevent \{$current_crowd_encore
			fade_time = 2.5
			fade_type = log_slow}
		startpreloadedstream \{$celeb_intro_stream_id
			buss = encore_events
			forcesafepreload = 1
			pitch = 100}
		change 0xc5b024f4 = ($celeb_intro_stream_id)
		change \{celeb_intro_stream_id = none}
	endif
endscript

script kill_transition_preload_streams 
	killspawnedscript \{name = preload_encore_event_stream}
	killspawnedscript \{name = preload_celeb_intro_stream}
	0x11918493
	change \{encore_event_stream_id = none}
	change \{celeb_intro_stream_id = none}
endscript

script default_camera_intro_lemmy 
	cameracuts_calctime
	getpakmancurrent \{map = zones}
	extendcrc <pak> '_TRG_Geo_Camera_Performance_SING01' out = cam_id
	ccam_domorph {
		lockto = <cam_id>
		locktobone = bone_camera
		pos = (0.0, 0.0, 0.0)
		quat = (0.0, 0.0, 0.0)
		fov = 71.0
	}
	ccam_waitmorph
	cameracuts_waitscript camera_songtime = <camera_songtime>
endscript

script default_camera_intro_kingdiamond 
	cameracuts_calctime
	getpakmancurrent \{map = zones}
	extendcrc <pak> '_TRG_Geo_Camera_Performance_SING01' out = cam_id
	ccam_domorph {
		lockto = <cam_id>
		locktobone = bone_camera
		pos = (0.0, 0.0, 0.0)
		quat = (0.0, 0.0, 0.0)
		fov = 71.0
	}
	ccam_waitmorph
	cameracuts_waitscript camera_songtime = <camera_songtime>
endscript

script 0x0ad512cc 
	if ($finalbandintro_transition_playing = 1)
		return \{true}
	else
		return \{false}
	endif
endscript

script 0x028d37f2 
	get_progression_globals ($current_progression_flag) game_mode = ($game_mode) use_current_tab = 1
	format_globaltag_gigname setlist_prefix = ($<tier_global>.prefix) gignum = ($current_gig_number)
	getglobaltags <gig_name> param = completed

	if (<completed> = 0)
		return \{true}
	else
		return \{false}
	endif
endscript
