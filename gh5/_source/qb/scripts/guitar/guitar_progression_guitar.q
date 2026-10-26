GH4_Career_Guitar_Songs = {
	prefix = 'career_guitar'
	part = guitar
	num_tiers = 14
	tier1 = {
		title = qs("\LThe 13th Rail")
		songs = [
			TheySay
			BlueDay
			CigarettesWeddingBands
			ExGirlfriend
			FeelGoodInc
		]
		unlockable_songs = [
			AllAlongTheWatchTower
			SympathyForTheDevil
		]
		stars = 0
		level = load_Z_Subway
	}
	tier2 = {
		title = qs("\LClub Boson")
		songs = [
			GammaRay
			InMyPlace
			Song2
			SowingSeason
		]
		unlockable_songs = [
			OnlyHappyWhenItRains
			BlueOrchid
			HurtsSoGood
		]
		stars = 15
		level = load_Z_LHC
	}
	tier3 = {
		title = qs("\LSideshow")
		songs = [
			SteadyAsSheGoes
			Comedown
			Fame
			Gratitude
			InTheMeantime
		]
		unlockable_songs = [
			UnderPressure
			SexOnFire
		]
		stars = 30
		level = load_Z_FreakShow
	}
	tier4 = {
		title = qs("\LAngel's Crypt")
		songs = [
			Jailbreak
			Kryptonite
			LoveToken
			NeverMissABeat
			PlayThatFunkyMusic
		]
		unlockable_songs = [
			DancingWithMyself
			ShoutItOutLoud
		]
		stars = 45
		level = load_Z_NewOrleans
	}
	tier5 = {
		title = qs("\LO'Connell's Corner")
		songs = [
			RockShow
			WomanFromTokyo
			YouAndMe
			BleedAmerican
			LA
		]
		unlockable_songs = [
			PlugInBaby
			Superstition
			SultansOfSwing
		]
		stars = 60
		level = load_Z_Dublin
	}
	tier6 = {
		title = qs("\LThe Aqueduct")
		songs = [
			LonelyIsTheNight
			MakeItWitChu
			NearlyLostYou
			WannaBeInLA
		]
		unlockable_songs = [
			HungryLikeTheWolf
			LooksThatKill
		]
		stars = 75
		level = load_Z_DragRace
	}
	tier7 = {
		title = qs("\LGuitarhenge")
		songs = [
			WhyBother
			YouGiveLove
			MirrorPeople
		]
		unlockable_songs = [
			SmellsLikeTeenSpirit
			Lithium
			AllThePrettyFaces
		]
		stars = 87
		level = load_Z_CarHenge
	}
	tier8 = {
		title = qs("\LNeon Oasis")
		songs = [
			Seven
			APunk
			BulletsButterfly
			Disconnected
		]
		unlockable_songs = [
			BringTheNoise
			DuHast
		]
		stars = 99
		level = load_Z_Vegas
	}
	tier9 = {
		title = qs("\LElectric Honky Tonk")
		songs = [
			RingOfFire
			MaidenMotherCrone
			OneBigHoliday
			Incinerate
		]
		unlockable_songs = [
			WereAnAmericanBand
		]
		stars = 111
		level = load_Z_Nashville
	}
	tier10 = {
		title = qs("\LCalavera Square")
		songs = [
			Medicate
			Sneakout
			SoLonely
			TwentiethCenturyBoy
		]
		unlockable_songs = [
			NoOneToDependOn
			RunninDownADream
		]
		stars = 123
		level = load_Z_MexicoCity
	}
	tier11 = {
		title = qs("\LCairo Bazaar")
		songs = [
			WhatIGot
			Deadbolt
			Demon
			Judith
		]
		unlockable_songs = [
			BackRound
			YounkFunk
		]
		stars = 135
		level = load_Z_Cairo
	}
	tier12 = {
		title = qs("\LThe Golden Gate")
		songs = [
			LustForLife
			SaturdayNightsAlright
			SixDaysAWeek
			StreamlineWoman
		]
		unlockable_songs = [
			Brianstorm
			TwoMinutesToMidnight
		]
		stars = 147
		level = load_Z_SanFrancisco
	}
	tier13 = {
		title = qs("\LFjord of Swords")
		songs = [
			WolfLikeMe
			AmericanGirl
			SweatingBullets
			DoYouFeelLikeWeDo
			DoneWithEverything
			Scatterbrain
		]
		unlockable_songs = [
			SpiritOfRadio
		]
		stars = 159
		level = load_z_norway
	}
	tier14 = {
		title = qs("\LHypersphere")
		songs = [
			TwentyFirstCentury
		]
		stars = -1
		level = load_z_cube
	}
}
GH4_Career_Guitar_Progression_Unlock_Order = {
	name = 'Career_Guitar'
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
		gig12 = {
			name = 'gig12'
			num = 12
		}
		gig13 = {
			name = 'gig13'
			num = 13
		}
		gig14 = {
			name = 'gig14'
			num = 14
		}
	}
}
GH4_Career_Guitar_Gig_Complete_Params = {
	Career_Guitar
	unlock_order = GH4_Career_Guitar_Progression_Unlock_Order
	part = 'Guitar'
}
GH4_Career_Guitar_Progression = [
	{
		name = set_initial_states
		type = Scr
		atom_script = Progression_Career_Guitar_Init
		atom_params = {
		}
	}
	{
		name = guitar_career_gig1_complete
		type = Scr
		atom_script = Progression_Career_Gig_Complete
		atom_params = $GH4_Career_Guitar_Gig_Complete_Params
		depends_on = [
			{
				type = Scr
				Scr = Progression_Career_Check_Gig_Complete
				params = {
					Career_Guitar
					gig = 1
				}
			}
		]
	}
	{
		name = end_of_first_update
		type = Scr
		atom_script = Progression_Career_Guitar_EndOfFirstUpdate
		atom_params = {
		}
	}
]

script Progression_Career_Guitar_Init 

endscript

script Progression_Career_Guitar_EndOfFirstUpdate 

endscript

script update_progression_guitar 
	UpdateAtoms \{name = Progression}
endscript
