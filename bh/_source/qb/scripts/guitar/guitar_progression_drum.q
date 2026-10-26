GH4_Career_Drum_Songs = {
	prefix = 'career_drum'
	part = drum
	num_tiers = 11
	tier1 = {
		title = qs(0xf055aee0)
		songs = [
			doyoureally
			everyrosehasitsthorn
			hangmeuptodry
			putyourrecordson
			wannabe
		]
		unlockable_songs = [
			letsdance
			prettywoman
		]
		stars = 0
		level = load_z_mall
	}
	tier2 = {
		title = qs(0x9ea1e51c)
		songs = [
			amillionways
			believe
			dirtylittlesecret
			ifyoucouldonlysee
			lipsofanangel
		]
		unlockable_songs = [
			ihearditthrough
			abc
		]
		stars = 15
		level = load_z_montreux
	}
	tier3 = {
		title = qs(0x2e2d9822)
		songs = [
			ourlipsaresealed
			santamonica
			soyesterday
			stealmykisses
			happytogether
		]
		unlockable_songs = [
			takewhatyoutake
			badreputation
		]
		stars = 30
		level = load_z_cabo
	}
	tier4 = {
		title = qs(0xc0b61c08)
		songs = [
			lesartistes
			oceanave
			bringmetolife
			picturesofyou
			LoveStory
		]
		unlockable_songs = [
			honkeytonkwomen
			mrroboto
		]
		stars = 45
		level = load_z_centralpark
	}
	tier5 = {
		title = qs(0x3986d53b)
		songs = [
			takebackthecity
			whipit
			rockstar
			loveisabattlefield
			shewillbeloved
		]
		unlockable_songs = [
			blackcat
			sugarweregoingdown
		]
		stars = 60
		level = load_z_tokyo
	}
	tier6 = {
		title = qs(0xd26e042b)
		songs = [
			inabigcountry
			iwantyoutowantme
			youhadme
			angelsofthesilences
			backagain
		]
		unlockable_songs = [
			walkingonsunshine
			theadventure
		]
		stars = 75
		level = load_z_easterisland
	}
	tier7 = {
		title = qs(0x2de3cf22)
		songs = [
			gasoline
			kids
			kungfufighting
			warwickave
			DontSpeak
		]
		unlockable_songs = [
			turnoffthelights
			ymca
		]
		stars = 90
		level = load_z_awardshow
	}
	tier8 = {
		title = qs(0x9bef74a5)
		songs = [
			whenimgone
			takeapicture
			beautifulsoul
			PictureToBurn
			YouBelongWithMe
		]
		unlockable_songs = [
			rio
		]
		stars = 105
		level = load_z_gorge
	}
	tier9 = {
		title = qs("\LParis")
		songs = [
			blackhorsecherrytree
			fascination
			paralyzer
			JustaGirl
		]
		unlockable_songs = [
			lifeline
		]
		stars = 120
		level = load_z_paris
	}
	tier10 = {
		title = qs(0x1a1191d2)
		songs = [
			likewhoa
			naive
			handsdown
		]
		unlockable_songs = [
			theimpressionthatiget
		]
		stars = 135
		level = load_z_space
	}
	tier11 = {
		title = qs("\LHypersphere")
		songs = [
			americanpie
		]
		stars = -1
		level = load_z_cube
	}
}
GH4_Career_Drum_Progression_Unlock_Order = {
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
		gig11 = {
			name = 'gig11'
			num = 11
		}
	}
}
GH4_Career_Drum_Gig_Complete_Params = {
	Career_Drum
	unlock_order = GH4_Career_Drum_Progression_Unlock_Order
	part = 'Drum'
}
GH4_Career_Drum_Progression = [
	{
		name = set_initial_states
		type = Scr
		atom_script = Progression_Career_Drum_Init
		atom_params = {
		}
	}
	{
		name = drum_career_gig1_complete
		type = Scr
		atom_script = Progression_Career_Gig_Complete
		atom_params = $GH4_Career_Drum_Gig_Complete_Params
		depends_on = [
			{
				type = Scr
				Scr = Progression_Career_Check_Gig_Complete
				params = {
					Career_Drum
					gig = 1
				}
			}
		]
	}
	{
		name = end_of_first_update
		type = Scr
		atom_script = Progression_Career_Drum_EndOfFirstUpdate
		atom_params = {
		}
	}
]

script Progression_Career_Drum_Init 

endscript

script Progression_Career_Drum_EndOfFirstUpdate 

endscript
