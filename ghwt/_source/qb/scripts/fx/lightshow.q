lightshow_enabled = 0
lightshow_debug = 0
lightvolume_flarecutoff_low = 0.2
lightvolume_flarecutoff_high = 0.35000002
lightvolume_flarematerialcrc = flarematerial_flarematerial
lightvolume_flaresaturate = 0.6
lightvolume_follow = {
	allowedradius = {
		amplitude = 0.2
		center = 1.0
		periodbase = 0.0065
		periodmultiples = [
			1
			3
			4
			7
		]
	}
	driftlerpmap = [
		(0.0, 0.4)
		(0.2, 0.7)
	]
}
lightshow_spotlightoverrides = {
	fade_time = 0.5
	snapshot_names_to_search = [
		solo01
	]
	default_params = {
		startradius = 0.3
		endradius = 1.5
		innerradius = 0.0
		range = 7.36
		volumedensity = 0.6442
		projectorcolorred = 170.0
		projectorcolorgreen = 170.0
		projectorcolorblue = 170.0
		volumecolorred = 255.0
		volumecolorgreen = 255.0
		volumecolorblue = 255.0
	}
}
lightshow_defaultblendtime = 0.15
lightshow_coloroverrideblend = 0.4
lightshow_offset_ms = 100
lightshow_projectortargetnames = {
	z_artdeco_gfx_trg_lh_stagehsaccent = z_artdeco_spotlight_stagehsaccent
	z_artdeco_gfx_trg_lh_guitaristhotspot01 = z_artdeco_spotlight_guitaristhotspot01
	z_artdeco_gfx_trg_lh_bassisthotspot01 = z_artdeco_spotlight_bassist
	z_artdeco_gfx_trg_lh_stagehsaccent01 = z_artdeco_spotlight_vocalist
	z_budokan_gfx_trg_lh_hotspot01 = z_budokan_spotlight_hotspot01
	z_budokan_gfx_trg_lh_hotspot02 = z_budokan_spotlight_hotspot02
	z_budokan_gfx_trg_lh_hotspot03 = z_budokan_spotlight_hotspot03
	z_budokan_gfx_trg_lh_guitarist_hotspot01 = z_budokan_spotlight_guitaristhotspot01
	z_dive_gfx_trg_lh_hotspot01 = z_dive_spotlight_hotspot01
	z_dive_gfx_trg_lh_hotspot02 = z_dive_spotlight_hotspot02
	z_dive_gfx_trg_lh_dancer_hotspot01 = z_dive_spotlight_dancer_hotspot01
	z_dive_gfx_trg_lh_dancer_hotspot02 = z_dive_spotlight_dancer_hotspot02
	z_dive_gfx_trg_lh_guitarist_hotspot01 = z_dive_spotlight_guitarist_hotspot01
	z_hell_gfx_trg_lh_hotspot01 = z_hell_spotlight_hotspot01
	z_hell_gfx_trg_lh_hotspot02 = z_hell_spotlight_hotspot02
	z_hell_gfx_trg_lh_guitarist_hotspot01 = z_hell_spotlight_guitaristhotspot01
	z_party_gfx_trg_lh_hotspot01 = z_party_spotlight_hotspot01
	z_party_gfx_trg_lh_hotspot02 = z_party_spotlight_hotspot02
	z_party_gfx_trg_lh_guitarist_hotspot01 = z_party_spotlight_guitarist_hotspot01
	z_prison_gfx_trg_lh_hotspot01 = z_prison_spotlight_hotspot01
	z_prison_gfx_trg_lh_hotspot02 = z_prison_spotlight_hotspot02
	z_prison_gfx_trg_lh_guitarist_hotspot01 = z_prison_spotlight_guitarist_hotspot01
	z_video_gfx_trg_lh_hotspot01 = z_video_spotlight_hotspot01
	z_wikker_gfx_trg_lh_vocalist_hotspot01 = z_wikker_spotlight_vocalist_hotspot01
	z_wikker_gfx_trg_lh_bassist_hotspot01 = z_wikker_spotlight_bassist_hotspot01
	z_wikker_gfx_trg_lh_bassist_hotspot01a = z_wikker_spotlight_bassist_hotspot01a
	z_wikker_gfx_trg_lh_guitarist_hotspot01 = z_wikker_spotlight_guitarist_hotspot01
	z_wikker_gfx_trg_lh_guitarist_hotspot01a = z_wikker_spotlight_guitarist_hotspot01a
}
lightshow_blobshadowtargetnames = {
	guitarist = [
		z_artdeco_shadow_guitarist
		z_budokan_shadow_guitarist
		z_dive_shadow_guitarist
		z_hell_shadow_guitarist
		z_party_shadow_guitarist
		z_prison_shadow_guitarist
		z_video_shadow_guitarist
		z_wikker_shadow_guitarist
	]
	guitarist01 = [
		z_artdeco_shadow_guitarist01
		z_budokan_shadow_guitarist01
		z_dive_shadow_guitarist2
		z_hell_shadow_guitarist01
		z_party_shadow_guitarist01
		z_prison_shadow_guitarist01
		z_video_shadow_guitarist01
		z_wikker_shadow_guitarist01
	]
	vocalist = [
		z_artdeco_shadow_vocalist
		z_budokan_shadow_vocalist
		z_dive_shadow_vocalist
		z_hell_shadow_vocalist
		z_party_shadow_vocalist
		z_prison_shadow_vocalist
		z_video_shadow_vocalist
		z_wikker_shadow_vocalist
	]
	bassist = [
		z_artdeco_shadow_bassist
		z_budokan_shadow_bassist
		z_hell_shadow_bassist
		z_party_shadow_bassist
		z_prison_shadow_bassist
		z_video_shadow_bassist
		z_wikker_shadow_bassist
	]
	dancer01 = [
		z_dive_shadow_dancer01
	]
	dancer02 = [
		z_dive_shadow_dancer02
	]
}
lightshow_spotlights = [
	z_artdeco_gfx_l_band_guitarist_spot01
	z_budokan_gfx_l_band_guitarist_spot01
	z_dive_gfx_l_band_guitarist_spot01
	z_hell_gfx_l_band_guitarist_spot01
	z_party_gfx_l_band_guitarist_spot01
	z_prison_gfx_l_band_guitarist_spot01
	z_video_gfx_l_band_guitarist_spot01
	z_wikker_gfx_l_band_guitarist_spot01
	z_dive_gfx_l_band_dancer_spot01
	z_dive_gfx_l_band_dancer_spot02
]
lightshow_customweights = [
	{
		z_artdeco_gfx_l_band_guitarist_spot01
		10.0
	}
	{
		z_budokan_gfx_l_band_guitarist_spot01
		10.0
	}
	{
		z_dive_gfx_l_band_guitarist_spot01
		10.0
	}
	{
		z_hell_gfx_l_band_guitarist_spot01
		10.0
	}
	{
		z_prison_gfx_l_band_guitarist_spot01
		10.0
	}
	{
		z_video_gfx_l_band_guitarist_spot01
		10.0
	}
	{
		z_wikker_gfx_l_band_guitarist_spot01
		10.0
	}
	{
		z_dive_gfx_l_band_dancer_spot01
		10.0
	}
	{
		z_dive_gfx_l_band_dancer_spot02
		10.0
	}
	{
		z_party_gfx_l_stage_center_direct01
		0.1
	}
	{
		z_video_gfx_vc_cola_omni01
		0.1
	}
	{
		z_video_gfx_vc_exit_omni01
		0.1
	}
	{
		z_video_gfx_vc_exit_omni02
		0.1
	}
	{
		z_video_gfx_vc_exit_omni03
		0.1
	}
	{
		z_video_gfx_vc_exit_omni04
		0.1
	}
	{
		z_video_gfx_vc_periph_left_direct01
		0.1
	}
	{
		z_video_gfx_vc_periph_right_direct01
		0.1
	}
]
lightshow_groupremap = {
	band = [
		band
		alt_band
		0x7d2a88ef
	]
}
lightshow_debuglightgrouppriorities = 0
0x34abba0e = {
	`default` = {
		0x67776396 = 20
		0x40301151 = 0.5
		0xfd227566 = 0.8
		0xd7d33493 = [
			1.3
			0.5
			0.1
			0.04
		]
		0xb1165287 = 1.8
	}
	z_soundcheck = {
		0x67776396 = 20
		0x40301151 = 1.0
		0xfd227566 = 0.8
		0xd7d33493 = [
			1.3
			0.5
			0.1
			0.04
		]
		0xb1165287 = 1.8
	}
	z_wikker = {
		0x67776396 = 40
		0x40301151 = 0.6
		0xfd227566 = 0.9
		0xd7d33493 = [
			1.0
			0.5
			0.2
			0.04
		]
		0xb1165287 = 1.2
	}
	z_budokan = {
		0x67776396 = 40
		0x40301151 = 0.6
		0xfd227566 = 0.9
		0xd7d33493 = [
			1.3
			0.4
			0.2
			0.04
		]
		0xb1165287 = 1.3
	}
}
lightshow_housingmodels = [
]

script 0x8bfa392d 
	if gotparam \{zone}
		if structurecontains structure = $0x34abba0e <zone>

			0xb80b667e ($0x34abba0e.<zone>)
			return
		else

		endif
	endif

	0xb80b667e ($0x34abba0e.`default`)
endscript

script lightshow_createpermmodels 
endscript

script ls_alloff 
	killspawnedscript \{id = lightshow}
endscript

script ls_setupvenuelights 
endscript

script ls_resetvenuelights 
	ls_alloff
	ls_killfx
	getpakmancurrent \{map = zones}
endscript

script ls_killfx 
endscript
lightshow_spotlightfollownames = [
	guitarist
	vocalist
	bassist
	drummer
]
lightshow_coloroverrides = {
	red = (255.0, 0.0, 0.0)
	blue = (20.0, 132.0, 247.0)
	yellow = (252.0, 227.0, 61.0)
	white = (255.0, 255.0, 255.0)
	magenta = (240.0, 79.0, 255.0)
	green = (66.0, 228.0, 97.0)
	purple = (162.0, 80.0, 232.0)
	orange = (248.0, 142.0, 56.0)
}
lightshow_coloroverrideexcludelights = [
	z_budokan_gfx_l_band_ambient01
	z_budokan_gfx_l_band_guitarist_spot01
	z_budokan_gfx_l_band_up_direct01
	z_budokan_gfx_l_crowd_ambient01
	z_budokan_gfx_l_neonsigns_ambient01
	z_budokan_gfx_l_periph_ambient01
	z_budokan_gfx_l_periph_up_direct01
	z_budokan_gfx_l_stage_ambient01
	z_budokan_gfx_l_stage_up_direct01
	z_budokan_gfx_vc_flames_omni01
	z_budokan_gfx_vc_flames_omni02
	z_budokan_gfx_vc_flames_omni03
	z_budokan_gfx_vc_flames_omni04
	z_dive_gfx_l_ambient01
	z_dive_gfx_l_band_ambient01
	z_dive_gfx_l_band_dancer_spot01
	z_dive_gfx_l_band_dancer_spot02
	z_dive_gfx_l_band_guitarist_spot01
	z_dive_gfx_l_band_up_direct01
	z_dive_gfx_l_crowd_ambient01
	z_dive_gfx_l_stage_dancer_omni01
	z_dive_gfx_l_stage_up_direct01
	z_dive_gfx_trg_lh_dancer_hotspot01
	z_dive_gfx_trg_lh_dancer_hotspot02
	z_dive_gfx_trg_lh_guitarist_hotspot01
	z_dive_gfx_vc_arcade_omni01
	z_dive_gfx_vc_bathroom_omni01
	z_dive_gfx_vc_bathroom_omni02
	z_dive_gfx_vc_corner_omni01
	z_dive_gfx_vc_exit_omni01
	z_dive_gfx_vc_exit_omni02
	z_dive_gfx_vc_fill_omni01
	z_dive_gfx_vc_neon_omni01
	z_dive_gfx_vc_periph_back_direct01
	z_dive_gfx_vc_periph_back_direct02
	z_hell_gfx_l_band_ambient01
	z_hell_gfx_l_band_fire_direct01
	z_hell_gfx_l_band_guitarist_spot01
	z_hell_gfx_l_band_up_direct01
	z_hell_gfx_l_crowd_ambient01
	z_hell_gfx_l_stage_ambient01
	z_hell_gfx_l_stage_up_direct01
	z_hell_gfx_trg_lh_guitarist_hotspot01
	z_party_gfx_l_band_back_direct01
	z_party_gfx_l_band_center_direct01
	z_party_gfx_l_stage_back_direct01
	z_party_gfx_l_stage_center_direct01
	z_party_gfx_trg_flare_back01
	z_party_gfx_trg_flare_center01
	z_party_gfx_trg_flare_chimney01
	z_party_gfx_trg_flare_chimney02
	z_party_gfx_trg_flare_chimney03
	z_party_gfx_vc_viewer_ambient01
	z_party_gfx_vc_viewer_center_direct01
	z_party_gfx_vc_viewer_left_direct01
	z_party_gfx_vc_viewer_left_direct02
	z_party_gfx_vc_viewer_right_direct01
	z_party_gfx_vc_viewer_right_direct02
	z_party_gfx_vc_viewer_up_direct01
	z_prison_gfx_l_band_ambient01
	z_prison_gfx_l_band_guitarist_spot01
	z_prison_gfx_l_band_sky_fdirect01
	z_prison_gfx_l_band_up_direct01
	z_prison_gfx_l_crowd_ambient01
	z_prison_gfx_l_crowd_sky_fdirect01
	z_prison_gfx_l_stage_ambient01
	z_prison_gfx_l_stage_sky_fdirect01
	z_prison_gfx_l_stage_sky_fdirect02
	z_prison_gfx_l_stage_up_direct01
	z_video_gfx_l_backdrop_ambient01
	z_video_gfx_l_band_ambient01
	z_video_gfx_l_band_guitarist_spot01
	z_video_gfx_l_band_up_direct01
	z_video_gfx_l_crowd_ambient01
	z_video_gfx_l_stage_ambient01
	z_video_gfx_l_stage_up_direct01
	z_video_gfx_vc_cola_omni01
	z_video_gfx_vc_exit_omni01
	z_video_gfx_vc_exit_omni02
	z_video_gfx_vc_exit_omni03
	z_video_gfx_vc_exit_omni04
	z_video_gfx_vc_periph_left_direct01
	z_video_gfx_vc_periph_right_direct01
	z_wikker_gfx_l_ambient01
	z_wikker_gfx_l_band_ambient01
	z_wikker_gfx_l_band_guitarist_spot01
	z_wikker_gfx_l_band_up_direct01
	z_wikker_gfx_l_crowd_ambient01
	z_wikker_gfx_l_stage_up_direct01
]
lightshow_statenodeflags = [
	ls_perf_poor
	ls_perf_medium
	ls_perf_good
	ls_perf_poor_medium
	ls_perf_medium_good
	ls_perf_poor_medium_good
	ls_perf_poor_noblackout
	ls_perf_medium_noblackout
	ls_perf_good_noblackout
	ls_perf_poor_medium_noblackout
	ls_perf_medium_good_noblackout
	ls_perf_poor_medium_good_noblackout
	ls_mood_intro
	ls_mood_blackout
	ls_mood_flare
	ls_mood_strobe
	ls_mood_wash
	ls_mood_prelude
	ls_mood_exposition
	ls_mood_rising
	ls_mood_tension
	ls_mood_climax
	ls_mood_falling
	ls_mood_resolution
	ls_mood_pyro
	ls_mood_silhouette
]
lightshow_statenodeflagmapping = {
	performance = {
		poor = [
			{
				ls_perf_poor
				1
			}
			{
				ls_perf_poor_medium
				1
			}
			{
				ls_perf_poor_medium_good
				1
			}
			{
				ls_perf_poor_noblackout
				1
			}
			{
				ls_perf_poor_medium_noblackout
				1
			}
			{
				ls_perf_poor_medium_good_noblackout
				1
			}
		]
		medium = [
			{
				ls_perf_poor_medium
				1
			}
			{
				ls_perf_medium
				1
			}
			{
				ls_perf_medium_good
				1
			}
			{
				ls_perf_poor_medium_good
				1
			}
			{
				ls_perf_poor_medium_noblackout
				1
			}
			{
				ls_perf_medium_noblackout
				1
			}
			{
				ls_perf_medium_good_noblackout
				1
			}
			{
				ls_perf_poor_medium_good_noblackout
				1
			}
		]
		good = [
			{
				ls_perf_medium_good
				1
			}
			{
				ls_perf_good
				1
			}
			{
				ls_perf_poor_medium_good
				1
			}
			{
				ls_perf_medium_good_noblackout
				1
			}
			{
				ls_perf_good_noblackout
				1
			}
			{
				ls_perf_poor_medium_good_noblackout
				1
			}
		]
	}
	mood = {
		intro = [
			{
				ls_mood_intro
				1
			}
		]
		blackout = [
			{
				ls_mood_blackout
				1
			}
			{
				ls_perf_poor
				0
			}
			{
				ls_perf_medium
				0
			}
			{
				ls_perf_good
				0
			}
			{
				ls_perf_poor_medium
				0
			}
			{
				ls_perf_medium_good
				0
			}
			{
				ls_perf_poor_medium_good
				0
			}
		]
		flare = [
			{
				ls_mood_flare
				1
			}
			{
				ls_perf_poor
				0
			}
			{
				ls_perf_medium
				0
			}
			{
				ls_perf_good
				0
			}
			{
				ls_perf_poor_medium
				0
			}
			{
				ls_perf_medium_good
				0
			}
			{
				ls_perf_poor_medium_good
				0
			}
		]
		strobe = [
			{
				ls_mood_strobe
				1
			}
		]
		wash = [
			{
				ls_mood_wash
				1
			}
		]
		prelude = [
			{
				ls_mood_prelude
				1
			}
		]
		exposition = [
			{
				ls_mood_exposition
				1
			}
		]
		risingaction = [
			{
				ls_mood_rising
				1
			}
		]
		tension = [
			{
				ls_mood_tension
				1
			}
		]
		climax = [
			{
				ls_mood_climax
				1
			}
		]
		fallingaction = [
			{
				ls_mood_falling
				1
			}
		]
		resolution = [
			{
				ls_mood_resolution
				1
			}
		]
		pyro = [
			{
				ls_mood_pyro
				1
			}
		]
		silhouette = [
			{
				ls_mood_silhouette
				1
			}
		]
	}
}
lightshow_notemapping = [
	{
		midinote = 105
		scr = lightshow_spotlightcolor
		params = {
			color = red
		}
	}
	{
		midinote = 104
		scr = lightshow_spotlightcolor
		params = {
			color = orange
		}
	}
	{
		midinote = 103
		scr = lightshow_spotlightcolor
		params = {
			color = yellow
		}
	}
	{
		midinote = 102
		scr = lightshow_spotlightcolor
		params = {
			color = green
		}
	}
	{
		midinote = 101
		scr = lightshow_spotlightcolor
		params = {
			color = blue
		}
	}
	{
		midinote = 100
		scr = lightshow_spotlightcolor
		params = {
			color = purple
		}
	}
	{
		midinote = 99
		scr = lightshow_spotlightcolor
		params = {
			color = magenta
		}
	}
	{
		midinote = 98
		scr = lightshow_spotlightcolor
		params = {
			color = white
		}
	}
	{
		midinote = 97
		scr = lightshow_enablespotlights
		params = {
			enabled = true
			spots = [
				vocalist
			]
		}
	}
	{
		midinote = 96
		scr = lightshow_enablespotlights
		params = {
			enabled = false
			spots = [
				vocalist
			]
		}
	}
	{
		midinote = 95
		scr = lightshow_enablespotlights
		params = {
			enabled = true
			spots = [
				guitarist
			]
		}
	}
	{
		midinote = 94
		scr = lightshow_enablespotlights
		params = {
			enabled = false
			spots = [
				guitarist
			]
		}
	}
	{
		midinote = 93
		scr = lightshow_enablespotlights
		params = {
			enabled = true
			spots = [
				bassist
			]
		}
	}
	{
		midinote = 92
		scr = lightshow_enablespotlights
		params = {
			enabled = false
			spots = [
				bassist
			]
		}
	}
	{
		midinote = 91
		scr = lightshow_enablespotlights
		params = {
			enabled = true
			spots = [
				drummer
			]
		}
	}
	{
		midinote = 90
		scr = lightshow_enablespotlights
		params = {
			enabled = false
			spots = [
				drummer
			]
		}
	}
	{
		midinote = 88
		scr = lightshow_setparams
		params = {
			resetcycleonmoodchange = true
		}
	}
	{
		midinote = 87
		scr = lightshow_setparams
		params = {
			resetcycleonmoodchange = false
		}
	}
	{
		midinote = 84
		scr = lightshow_setparams
		params = {
			mood = intro
		}
	}
	{
		midinote = 83
		scr = lightshow_setparams
		params = {
			mood = blackout
		}
	}
	{
		midinote = 82
		scr = lightshow_setparams
		params = {
			mood = flare
		}
	}
	{
		midinote = 81
		scr = lightshow_setparams
		params = {
			mood = strobe
		}
	}
	{
		midinote = 80
		scr = lightshow_setparams
		params = {
			mood = wash
		}
	}
	{
		midinote = 79
		scr = lightshow_setparams
		params = {
			mood = prelude
		}
	}
	{
		midinote = 78
		scr = lightshow_setparams
		params = {
			mood = exposition
		}
	}
	{
		midinote = 77
		scr = lightshow_setparams
		params = {
			mood = risingaction
		}
	}
	{
		midinote = 76
		scr = lightshow_setparams
		params = {
			mood = tension
		}
	}
	{
		midinote = 75
		scr = lightshow_setparams
		params = {
			mood = climax
		}
	}
	{
		midinote = 74
		scr = lightshow_setparams
		params = {
			mood = fallingaction
		}
	}
	{
		midinote = 73
		scr = lightshow_setparams
		params = {
			mood = resolution
		}
	}
	{
		midinote = 72
		scr = lightshow_setparams
		params = {
			mood = pyro
		}
	}
	{
		midinote = 71
		scr = lightshow_setparams
		params = {
			mood = silhouette
		}
	}
	{
		midinote = 69
		scr = lightshow_overridecolor
		params = {
			color = red
		}
	}
	{
		midinote = 68
		scr = lightshow_overridecolor
		params = {
			color = orange
		}
	}
	{
		midinote = 67
		scr = lightshow_overridecolor
		params = {
			color = yellow
		}
	}
	{
		midinote = 66
		scr = lightshow_overridecolor
		params = {
			color = green
		}
	}
	{
		midinote = 65
		scr = lightshow_overridecolor
		params = {
			color = blue
		}
	}
	{
		midinote = 64
		scr = lightshow_overridecolor
		params = {
			color = purple
		}
	}
	{
		midinote = 63
		scr = lightshow_overridecolor
		params = {
			color = magenta
		}
	}
	{
		midinote = 62
		scr = lightshow_overridecolor
		params = {
			color = white
		}
	}
	{
		midinote = 61
		scr = lightshow_overridecolor
		params = {
			off
		}
	}
	{
		midinote = 60
		event = strobetoggle
		params = {
			usesnapshotpositions = false
		}
	}
	{
		midinote = 58
		event = snapshotchange
		params = {
			usesnapshotpositions = true
		}
	}
	{
		midinote = 57
		event = snapshotchange
		params = {
			usesnapshotpositions = false
		}
	}
	{
		midinote = 53
		scr = lightshow_settime
		params = {
			time = 1.0
		}
	}
	{
		midinote = 52
		scr = lightshow_settime
		params = {
			time = 0.9
		}
	}
	{
		midinote = 51
		scr = lightshow_settime
		params = {
			time = 0.8
		}
	}
	{
		midinote = 50
		scr = lightshow_settime
		params = {
			time = 0.7
		}
	}
	{
		midinote = 49
		scr = lightshow_settime
		params = {
			time = 0.6
		}
	}
	{
		midinote = 48
		scr = lightshow_settime
		params = {
			time = 0.5
		}
	}
	{
		midinote = 47
		scr = lightshow_settime
		params = {
			time = 0.4
		}
	}
	{
		midinote = 46
		scr = lightshow_settime
		params = {
			time = 0.3
		}
	}
	{
		midinote = 45
		scr = lightshow_settime
		params = {
			time = 0.25
		}
	}
	{
		midinote = 44
		scr = lightshow_settime
		params = {
			time = 0.2
		}
	}
	{
		midinote = 43
		scr = lightshow_settime
		params = {
			time = 0.15
		}
	}
	{
		midinote = 42
		scr = lightshow_settime
		params = {
			time = 0.1
		}
	}
	{
		midinote = 41
		scr = lightshow_settime
		params = {
			time = 0.05
		}
	}
	{
		midinote = 40
		scr = lightshow_settime
		params = {
			time = 0.0
		}
	}
	{
		midinote = 39
		scr = lightshow_settime
		params = {
			`default`
		}
	}
	{
		midinote = 37
		scr = lightshow_pyroevent
		params = {
			type = generic
		}
	}
	{
		midinote = 35
		scr = lightshow_pyroevent
		params = {
			type = front_1
		}
	}
	{
		midinote = 34
		scr = lightshow_pyroevent
		params = {
			type = front_2
		}
	}
	{
		midinote = 33
		scr = lightshow_pyroevent
		params = {
			type = front_3
		}
	}
	{
		midinote = 32
		scr = lightshow_pyroevent
		params = {
			type = front_4
		}
	}
	{
		midinote = 31
		scr = lightshow_pyroevent
		params = {
			type = top_1
		}
	}
	{
		midinote = 30
		scr = lightshow_pyroevent
		params = {
			type = top_2
		}
	}
	{
		midinote = 29
		scr = lightshow_pyroevent
		params = {
			type = top_3
		}
	}
	{
		midinote = 28
		scr = lightshow_pyroevent
		params = {
			type = top_4
		}
	}
	{
		midinote = 27
		scr = lightshow_pyroevent
		params = {
			type = mid_1
		}
	}
	{
		midinote = 26
		scr = lightshow_pyroevent
		params = {
			type = mid_2
		}
	}
	{
		midinote = 25
		scr = lightshow_pyroevent
		params = {
			type = mid_3
		}
	}
	{
		midinote = 24
		scr = lightshow_pyroevent
		params = {
			type = mid_4
		}
	}
	{
		midinote = 23
		scr = lightshow_pyroevent
		params = {
			type = back_1
		}
	}
	{
		midinote = 22
		scr = lightshow_pyroevent
		params = {
			type = back_2
		}
	}
	{
		midinote = 21
		scr = lightshow_pyroevent
		params = {
			type = back_3
		}
	}
	{
		midinote = 20
		scr = lightshow_pyroevent
		params = {
			type = back_4
		}
	}
]
lightshow_sharedprocessors = [
	{
		name = default_generic
		screnter = lightshow_genericmood_enter
		screvent = lightshow_genericmood_event
		screxit = lightshow_genericmood_exit
	}
	{
		name = poor_generic
		screnter = lightshow_poor_enter
		screvent = lightshow_poor_event
		screxit = lightshow_poor_exit
	}
	{
		name = blackout_generic
		screnter = lightshow_blackout_enter
		screvent = lightshow_blackout_event
		screxit = lightshow_blackout_exit
	}
	{
		name = flare_generic
		screnter = lightshow_flare_enter
		screvent = lightshow_flare_event
		screxit = lightshow_flare_exit
	}
	{
		name = strobe_generic
		screnter = lightshow_strobe_enter
		screvent = lightshow_strobe_event
		screxit = lightshow_strobe_exit
	}
]

script lightshow_iterator 
	return

	lightshow_setactive \{active = false}
	if cd
		destroyscreenelement \{id = lightshow_debuganchor}
		if ($lightshow_debug = 1)
			lightshow_displaydebuginfo
		endif
	endif
	if ($lightshow_enabled = 0)

		return
	endif
	get_song_prefix song = <song_name>
	formattext checksumname = event_array '%s_lightshow_notes' s = <song_prefix> addtostringlookup
	if NOT globalexists name = <event_array> type = array

		return
	endif
	if NOT lightshow_initeventmappings
		return
	endif
	array_entry = 0
	fretbar_count = 0
	getarraysize $<event_array>
	array_size = (<array_size> / 2)
	getsongtimems time_offset = <time_offset>
	if NOT (<array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>])
			break
		endif
		<array_entry> = (<array_entry> + 2)
		repeat <array_size>
		array_size = (<array_size> - (<array_entry> / 2))
		if NOT (<array_size> = 0)
			begin
			timemarkerreached_setparams time_offset = <time_offset> array = <event_array> array_entry = <array_entry>
			begin
			lightshow_update
			if timemarkerreached
				getsongtimems time_offset = <time_offset>
				break
			endif
			waitonegameframe
			repeat
			timemarkerreached_clearparams
			decompressnotevalue note_value = ($<event_array> [(<array_entry> + 1)])
			if lightshow_beginprocessblock {time = ($<event_array> [<array_entry>])
					note = <note>
					length = <length>}
				switch <process_mode>
					case event
					lightshow_passevent
					case scr
					<eventscr> <eventparams>
				endswitch
				lightshow_endprocessblock
			endif
			<array_entry> = (<array_entry> + 2)
			repeat <array_size>
		endif
	endif
	if cd
		if screenelementexists \{id = lightshow_debugtext}
			lightshow_debugtext :se_setprops \{text = qs(0xcbc0eb10)}
		endif
	endif
endscript

script lightshow_toggledebuginfo 
	if ($lightshow_debug = 1)
		change \{lightshow_debug = 0}
		destroyscreenelement \{id = lightshow_debuganchor}
	else
		change \{lightshow_debug = 1}
		lightshow_displaydebuginfo
	endif
endscript

script lightshow_displaydebuginfo 
	destroyscreenelement \{id = lightshow_debuganchor}
	createscreenelement \{type = containerelement
		parent = root_window
		id = lightshow_debuganchor
		pos = (400.0, 440.0)
		z_priority = 1000}
	createscreenelement \{type = spriteelement
		parent = lightshow_debuganchor
		dims = (500.0, 220.0)
		just = [
			left
			top
		]
		rgba = [
			0
			0
			0
			255
		]
		alpha = 0.7}
	createscreenelement \{type = textblockelement
		parent = lightshow_debuganchor
		id = lightshow_debugtext
		just = [
			left
			top
		]
		pos = (0.0, 0.0)
		dims = (1000.0, 1000.0)
		font = fontgrid_text_a11
		internal_scale = (0.6, 0.4)
		text = qs(0xcbc0eb10)}
	if NOT lightshow_getparams
		lightshow_debugtext = qs(0x46e08381)
	endif
endscript

script lightshow_pyroevent 
	if lightshow_getpyroscript
		if structurecontains structure = pyro_scripts <type>
			<scr> = (<pyro_scripts>.<type>)
			if lightshow_getparams
				if scriptexists <scr>
					spawnscriptnow <scr> id = lightshow params = {performance = <performance>}
				endif
			endif
		else

		endif
	else

	endif
endscript

script lightshow_poor_enter 
	lightshow_cyclenextsnapshot \{usesnapshotpositions = true
		save = true}
endscript

script lightshow_poor_exit 
endscript

script lightshow_poor_event 
	begin
	lightshow_waitfornextevent \{events = [
			snapshotchange
		]}
	repeat
endscript

script lightshow_genericmood_enter 
	lightshow_cyclenextsnapshot \{usesnapshotpositions = true
		save = true}
endscript

script lightshow_genericmood_exit 
endscript

script lightshow_genericmood_event 
	begin
	lightshow_waitfornextevent \{events = [
			snapshotchange
		]}
	lightshow_cyclenextsnapshot usesnapshotpositions = <usesnapshotpositions> save = true
	repeat
endscript

script lightshow_blackout_enter 
	getpakmancurrent \{map = zones}
	switch <pak>
		case z_soundcheck
		case z_training
		case z_viewer
		lightshow_appendsnapshotparams \{intensity = 0.25
			specularintensity = 0.25}
	endswitch
	lightshow_cyclenextsnapshot \{save = false
		usesnapshotpositions = true}
endscript

script lightshow_blackout_event 
endscript

script lightshow_blackout_exit 
	getpakmancurrent \{map = zones}
	switch <pak>
		case z_soundcheck
		case z_training
		case z_viewer
		lightshow_appendsnapshotparams \{clear}
	endswitch
endscript

script lightshow_flare_enter 
	getpakmancurrent \{map = zones}
	switch <pak>
		case z_soundcheck
		case z_training
		case z_viewer
		lightshow_appendsnapshotparams \{intensity = 0.25
			specularintensity = 0.25}
	endswitch
	lightshow_cyclenextsnapshot \{save = false
		usesnapshotpositions = true}
endscript

script lightshow_flare_event 
endscript

script lightshow_flare_exit 
	getpakmancurrent \{map = zones}
	switch <pak>
		case z_soundcheck
		case z_training
		case z_viewer
		lightshow_appendsnapshotparams \{clear}
	endswitch
endscript

script lightshow_strobe_enter 
	lightshow_settime \{enable = false}
endscript

script lightshow_strobe_event 
	lightshow_getparams
	<original_snapshot> = <previous_snapshot>
	begin
	lightshow_cyclenextsnapshot \{usesnapshotpositions = false
		save = false}
	lightshow_waitfornextevent \{events = [
			strobetoggle
		]}
	lightshow_appendsnapshotparams \{intensity = 1.0}
	if gotparam \{original_snapshot}
		lightshow_playsnapshot name = <original_snapshot> save = false usesnapshotpositions = false
	else
		lightshow_cyclenextsnapshot \{usesnapshotpositions = false
			save = true}
	endif
	lightshow_waitfornextevent \{events = [
			strobetoggle
		]}
	repeat
endscript

script lightshow_strobe_exit 
	lightshow_appendsnapshotparams \{clear}
	lightshow_settime \{enable = true}
endscript

script lightshow_addnodeflags 
	getarraysize \{$lightshow_statenodeflags}
	<i> = 0
	begin
	createnodeflag ($lightshow_statenodeflags [<i>])
	<i> = (<i> + 1)
	repeat <array_size>
	createnodeflag \{ls_always}
	createnodeflag \{ls_3_5_pre}
	createnodeflag \{ls_3_5_post}
	createnodeflag \{ls_encore_pre}
	createnodeflag \{ls_encore_post}
	createnodeflag \{ls_spotlight_guitarist}
	createnodeflag \{ls_spotlight_bassist}
endscript

script lightshow_initeventmappings 
	lightshow_appendsnapshotparams \{clear}
	lightshow_overridecolor \{off}
	lightshow_settime \{`default`
		enable = true}
	changenodeflag \{ls_spotlight_guitarist
		1}
	if ($current_num_players = 1)
		changenodeflag \{ls_spotlight_bassist
			0}
	else
		changenodeflag \{ls_spotlight_bassist
			1}
	endif
	getpakmancurrentname \{map = zones}
	formattext checksumname = event_struct '%s_lightshow_mapping' s = <pakname> addtostringlookup
	formattext checksumname = snapshot_struct '%s_snapshots' s = <pakname> addtostringlookup
	formattext checksumname = processors_struct '%s_lightshow_processors' s = <pakname> addtostringlookup
	if NOT globalexists name = <event_struct> type = structure


		return \{false}
	endif
	if NOT globalexists name = <snapshot_struct> type = structure


		return \{false}
	endif
	if globalexists name = <processors_struct> type = array

		lightshow_setprocessors venue = $<processors_struct>
	endif
	lightshow_setmapping ($<event_struct>)
	lightshow_setactive \{active = true}
	lightshow_setparams {
		performance = medium
		mood = intro
		venuesnapshots = $<snapshot_struct>
	}
	lightshow_spotlightcolor \{color = white}
	if NOT ($debug_forcescore = off)
		crowdincrease \{player_status = player1_status}
	endif
	formattext checksumname = venue_setup_scr '%s_SetupLightShow' s = <pakname> addtostringlookup
	if scriptexists <venue_setup_scr>
		spawnscriptnow <venue_setup_scr> id = lightshow
	endif
	return \{true}
endscript

script lightshow_shutdown 

	lightshow_setactive \{active = false}
	lightshow_setprocessors \{clear}
	lightshow_setmapping \{clear}
	killspawnedscript \{name = lightshow_iterator}
	killspawnedscript \{id = lightshow}
	killspawnedscript \{id = screenflash}

endscript

script kill_lightshow_fx 
	getpakmancurrent \{map = zones}
	switch <pak>
		case z_wikker
		destroyparticlesbygroupid \{groupid = z_wikker_fx}
	endswitch
endscript

script lightshow_waitandenablespotlights 


	wait <time> seconds
	lightshow_enablespotlights <enable>
endscript

script venue_pulseonevents \{amount = 1.12
		time = 0.1}
	if gotparam \{delay}

		obj_enablescaling
		obj_getscaling
		<start_scale> = <scaling>
		<end_scale> = (<scaling> * <amount>)
		begin
		block anytypes = <events>
		wait <delay> seconds
		obj_applyscaling scale = <end_scale>
		waitonegameframe
		obj_morphscaling target_scale = <start_scale> blend_duration = <time>
		repeat
	else
		addpulseevent events = <events> amount = <amount> time = <time>
	endif
endscript

script venue_pulsegreen 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_green
		]}
endscript

script venue_pulsered 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_red
		]}
endscript

script venue_pulseyellow 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_yellow
		]}
endscript

script venue_pulseblue 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_blue
		]}
endscript

script venue_pulseorange 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_orange
		]}
endscript

script venue_pulseopen 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
endscript

script venue_pulsedrumleft 
	setspawninstancelimits \{max = 2
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			drumkick_left
		]
		amount = 1.1
		delay = $drum_kick_anim_delay}
endscript

script venue_pulsedrumright 
	setspawninstancelimits \{max = 2
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			drumkick_right
		]
		amount = 1.1
		delay = $drum_kick_anim_delay}
endscript

script venue_pulsedrumboth 
	setspawninstancelimits \{max = 4
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			drumkick_left
			drumkick_right
		]
		amount = 1.1
		delay = $drum_kick_anim_delay}
endscript

script venue_pulseany 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_green
			hitnote_red
			hitnote_yellow
			hitnote_blue
			hitnote_orange
		]}
endscript

script venue_pulsegreenred 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_green
			hitnote_red
		]}
endscript

script venue_pulsegreenyellow 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_green
			hitnote_yellow
		]}
endscript

script venue_pulsegreenblue 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_green
			hitnote_blue
		]}
endscript

script venue_pulsegreenorange 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_green
			hitnote_orange
		]}
endscript

script venue_pulsegreenopen 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_green
		]}
endscript

script venue_pulseredyellow 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_red
			hitnote_yellow
		]}
endscript

script venue_pulseredblue 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_red
			hitnote_blue
		]}
endscript

script venue_pulseredorange 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_red
			hitnote_orange
		]}
endscript

script venue_pulseredopen 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_red
		]}
endscript

script venue_pulseyellowblue 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_yellow
			hitnote_blue
		]}
endscript

script venue_pulseyelloworange 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_yellow
			hitnote_orange
		]}
endscript

script venue_pulseyellowopen 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_yellow
		]}
endscript

script venue_pulseblueorange 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_blue
			hitnote_orange
		]}
endscript

script venue_pulseblueopen 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_blue
		]}
endscript

script venue_pulseorangeopen 
	setspawninstancelimits \{max = 8
		management = ignore_spawn_request}
	venue_pulseonevents \{events = [
			hitnote_orange
		]}
endscript
