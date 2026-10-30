gh4_career_drum_songs = {
	prefix = 'career_drum'
	part = drum
	num_tiers = 8
	tier1 = {
		title = qs(0xea47b2d9)
		songs = [
			iloverockandroll
			killerqueen
			hitmewithyourbestshot
			stellar
			heartshapedbox
			laydown
			morethanafeeling
		]
		stars = 0
		encore_stars = 16
		level = load_z_amazon
	}
	tier2 = {
		title = qs(0x12b22730)
		songs = [
			cherrypie
			takemeout
			backinthesaddle
			missmurder
			takeitoff
			electriceye
			rockandrollallnite
		]
		stars = 21
		encore_stars = 37
		level = load_z_canyon
	}
	tier3 = {
		title = qs(0x68a5b300)
		songs = [
			woman
			roundandround
			carryonmywaywardson
			shoutatthedevil
			playwithme
			nothinbutagoodtime
			iwannarock
		]
		stars = 42
		encore_stars = 58
		level = load_z_icecap
	}
	tier4 = {
		title = qs(0xdabbabe2)
		songs = [
			thembones
			mother
			cultofpersonality
			godzilla
			thunderkiss65
			killinginthenameof
			cowboysfromhell
		]
		stars = 63
		encore_stars = 79
		level = load_z_london
	}
	tier5 = {
		title = qs(0xb859513b)
		songs = [
			heyyou
			trippinonahole
			smokeonthewater
			unsung
			monkeywrench
			freya
			freebird
		]
		stars = 84
		encore_stars = 100
		level = load_z_sphinx
	}
	tier6 = {
		title = qs(0xf416949e)
		songs = [
			barracuda
			psychobillyfreakout
			nooneknows
			stop
			messageinabottle
			barkatthemoon
			thetrooper
		]
		stars = 105
		encore_stars = 121
		level = load_z_greatwall
	}
	tier7 = {
		title = qs(0xc0fcc8f7)
		songs = [
			yyz
			laidtorest
			beastandtheharlot
			caughtinamosh
			rainingblood
		]
		stars = 126
		level = load_z_atlantis
	}
	tier8 = {
		title = qs(0xf079fba9)
		songs = [
			throughthefire
		]
		stars = 141
		level = load_z_quebec
		end_with_credits
	}
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
