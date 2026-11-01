gh4_career_drum_songs = {
	prefix = 'career_drum'
	part = drum
	num_tiers = 10
	tier1 = {
		$gh4_3_intro_tier
	}
	tier2 = {
		title = qs(0x28c2e38f)
		songs = [
			stacysmom
			whitewedding
			prettyflyforawhiteguy
			semicharmedlife
			endofheartache
		]
		stars = 6
		level = load_z_la_block_party
	}
	tier3 = {
		title = qs(0x584bc2fb)
		songs = [
			andthecradlewillrock
			prettywoman
			hearaboutitlater
			littleguitars
			jamiescryin
		]
		level = load_z_starwood
		stars = 16
	}
	tier4 = {
		title = qs(0xab50e027)
		songs = [
			rockandrollisdead
			doublevision
			iwantitall
			safeeuropeanhome
			sicksicksick
		]
		stars = 24
		level = load_z_rome
	}
	tier5 = {
		title = qs(0xc4332586)
		songs = [
			feelyourlovetonight
			ainttalkinboutlove
			everybodywantssome
			dancethenightaway
			atomicpunk
		]
		stars = 33
		level = load_z_s_stage
	}
	tier6 = {
		title = qs(0x4b4691c9)
		songs = [
			dopenose
			masterexploder
			pain
			cometolife
			bestofyou
		]
		stars = 42
		level = load_z_paris
	}
	tier7 = {
		title = qs(0xda232d28)
		songs = [
			eruption
			youreallygotme
			unchained
			icecreamman
			jump
		]
		stars = 51
		level = load_z_drum_kit
	}
	tier8 = {
		title = qs(0x57792bcb)
		songs = [
			firstdate
			thetakedown
			spacetruckin
			painkiller
		]
		stars = 60
		level = load_z_london
	}
	tier9 = {
		title = qs(0x91b6a806)
		songs = [
			somebodygetmeadoctor
			sothisislove
			beautifulgirls
			meanstreet
			romeodelight
		]
		stars = 69
		level = load_z_frankenstrat
	}
	tier10 = {
		title = qs(0x7646d4db)
		songs = [
			hangemhigh
			imtheone
			lossofcontrol
			hotforteacher
		]
		stars = 85
		level = load_z_starwood
	}
	0xb2c7c47b = [
		{
			$0x738b443f
		}
	]
}
gh4_career_drum_progression_unlock_order = {
	name = 'Career_Drum'
	freegigs = {
		gig1 = {
			name = 'gig1'
			num = 1
		}
		gig2 = {
			name = 'gig2'
			num = 2
		}
		gig3 = {
			name = 'gig3'
			num = 3
		}
		gig4 = {
			name = 'gig4'
			num = 4
		}
		gig5 = {
			name = 'gig5'
			num = 5
		}
		gig6 = {
			name = 'gig6'
			num = 6
		}
		gig7 = {
			name = 'gig7'
			num = 7
		}
		gig8 = {
			name = 'gig8'
			num = 8
		}
		gig9 = {
			name = 'gig9'
			num = 9
		}
		gig10 = {
			name = 'gig10'
			num = 10
		}
	}
}
gh4_career_drum_gig_complete_params = {
	career_drum
	unlock_order = gh4_career_drum_progression_unlock_order
	part = 'Drum'
}
gh4_career_drum_progression = [
	{
		name = set_initial_states
		type = scr
		atom_script = progression_career_drum_init
		atom_params = {
		}
	}
	{
		name = drum_career_gig1_complete
		type = scr
		atom_script = progression_career_gig_complete
		atom_params = $gh4_career_drum_gig_complete_params
		depends_on = [
			{
				type = scr
				scr = progression_career_check_gig_complete
				params = {
					career_drum
					gig = 1
				}
			}
		]
	}
	{
		name = end_of_first_update
		type = scr
		atom_script = progression_career_drum_endoffirstupdate
		atom_params = {
		}
	}
]

script progression_career_drum_init 

endscript

script progression_career_drum_endoffirstupdate 

endscript
