default_custom_musician_profile_female = {
	allowed_parts = [
		drum
		Vocals
		guitar
		Bass
	]
	blurb = qs("\L")
	appearance = {
		CAS_Body = {
			desc_id = GH4_CAR_Female
		}
		cas_physique = {
			desc_id = FemalePhysique
		}
		$preset_musician_instrument_hack
		CAS_Female_Win_Anim = {
			desc_id = Win_Hype
		}
		CAS_Female_Lose_Anim = {
			desc_id = Lose_AngryAtCrowd
		}
		CAS_Female_Intro_Anim = {
			desc_id = Intro_Hype
		}
		genre = Rock
	}
}
default_custom_musician_profile_male = {
	allowed_parts = [
		drum
		Vocals
		guitar
		Bass
	]
	blurb = qs("\L")
	appearance = {
		CAS_Body = {
			desc_id = GH4_CAR_Male
		}
		cas_physique = {
			desc_id = MalePhysique
		}
		$preset_musician_instrument_hack
		CAS_Male_Intro_Anim = {
			desc_id = Intro_Waving
		}
		CAS_Male_Win_Anim = {
			desc_id = Win_Robot
		}
		CAS_Male_Lose_Anim = {
			desc_id = Lose_AngryAtCrowd
		}
		genre = Rock
	}
}
Net_Musician_Profiles = [
	{
		name = netappearance1
		fullname = qs("\Lnetappearance1")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		selection_not_allowed
		appearance = {
		}
	}
	{
		name = netappearance2
		fullname = qs("\Lnetappearance2")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		selection_not_allowed
		appearance = {
		}
	}
	{
		name = netappearance3
		fullname = qs("\Lnetappearance3")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		selection_not_allowed
		appearance = {
		}
	}
	{
		name = netappearance4
		fullname = qs("\Lnetappearance4")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		selection_not_allowed
		appearance = {
		}
	}
]
modifiable_preset_musician_parts = [
	CAS_Full_Body
	CAS_Female_Hair
	CAS_Female_Hat_Hair
	CAS_Female_Hat
	CAS_Female_Facial_Hair
	CAS_Female_Torso
	CAS_Female_Legs
	CAS_Female_Shoes
	CAS_Female_Acc_Left
	CAS_Female_Acc_Right
	CAS_Female_Acc_Face
	CAS_Female_Acc_Ears
	CAS_Male_Hair
	CAS_Male_Hat_Hair
	CAS_Male_Hat
	CAS_Male_Facial_Hair
	CAS_Male_Torso
	CAS_Male_Legs
	CAS_Male_Shoes
	CAS_Male_Acc_Left
	CAS_Male_Acc_Right
	CAS_Male_Acc_Face
	CAS_Male_Acc_Ears
]
modifiable_preset_musician_instrument_parts = [
	CAS_Full_Instrument
	CAS_Guitar_Body
	CAS_Guitar_Neck
	CAS_Guitar_Head
	CAS_Guitar_Pickguards
	CAS_Guitar_Bridges
	CAS_Guitar_Knobs
	CAS_Guitar_Pickups
	CAS_Guitar_Strings
	CAS_Guitar_Highway
	CAS_Bass_Body
	CAS_Bass_Neck
	CAS_Bass_Head
	CAS_Bass_Pickguards
	CAS_Bass_Pickups
	CAS_Bass_Bridges
	CAS_Bass_Knobs
	CAS_Bass_Strings
	CAS_Bass_Highway
	CAS_Drums
	CAS_Drums_Sticks
	CAS_Drums_Highway
	CAS_Mic
	CAS_Mic_Stand
	CAS_Guitar_Finish
	CAS_Guitar_Body_Detail
	cas_guitar_body_fade
	CAS_Guitar_Neck_Finish
	CAS_Guitar_Head_Finish
	CAS_Guitar_Head_Detail
	cas_guitar_head_fade
	CAS_Guitar_Pickguard_Finish
	cas_guitar_logo
	CAS_Bass_Finish
	CAS_Bass_Body_Detail
	cas_bass_body_fade
	CAS_Bass_Neck_Finish
	CAS_Bass_Head_Finish
	CAS_Bass_Head_Detail
	cas_bass_head_fade
	cas_bass_pickguard_finish
	cas_guitar_logo
	CAS_Drum_Finish
	CAS_Drum_Detail
	cas_drums_sticks_l
	cas_drums_sticks_r
]
default_band = {
	Guitarist = RandomCharacter
	bassist = RandomCharacter
	vocalist = RandomCharacter
	Drummer = RandomCharacter
}
worst_female_band = {
	Guitarist = WorstFemaleGuitarist
	bassist = WorstFemaleBassist
	vocalist = WorstFemaleVocalist
	Drummer = WorstFemaleDrummer
}
worst_male_band = {
	Guitarist = WorstmaleGuitarist
	bassist = WorstmaleBassist
	vocalist = WorstmaleVocalist
	Drummer = WorstmaleDrummer
}
jam_mode_band = 0
jam_mode_band_profiles = {
	Guitarist = Guitarist
	bassist = bassist
	vocalist = singer
	Drummer = Drummer
}
Band_JohnnyCash = {
	Guitarist = GH_Rocker_JohnnyCash_Guitarist
	bassist = GH_Rocker_JohnnyCash_Bassist
	vocalist = GH_Rocker_JohnnyCash
	Drummer = GH_Rocker_JohnnyCash_Drummer
	vocalist_has_guitar
}
Band_Santana = {
	Guitarist = GH_Rocker_Santana_Guitarist
	bassist = GH_Rocker_Santana_Bassist
	vocalist = GH_Rocker_Santana
	Drummer = GH_Rocker_Santana_Drummer
	vocalist_has_guitar
}
Band_KurtCobain = {
	Guitarist = GH_Rocker_KurtCobain_Guitarist
	bassist = GH_Rocker_KurtCobain_Bassist
	vocalist = GH_Rocker_KurtCobain_Lefty
	Drummer = GH_Rocker_KurtCobain_Drummer
	vocalist_has_guitar
}
Band_MattBellamy = {
	Guitarist = GH_Rocker_MattBellamy_Guitarist
	bassist = GH_Rocker_MattBellamy_Bassist
	vocalist = GH_Rocker_MattBellamy
	Drummer = GH_Rocker_MattBellamy_Drummer
	vocalist_has_guitar
}
Band_ShirleyManson = {
	Guitarist = GH_Rocker_ShirleyManson_Guitarist
	bassist = GH_Rocker_ShirleyManson_Bassist
	vocalist = GH_Rocker_ShirleyManson
	Drummer = GH_Rocker_ShirleyManson_Drummer
}
