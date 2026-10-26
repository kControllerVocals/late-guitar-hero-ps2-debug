empty_appearance = {
	CAS_Body = {
		desc_id = NoBody
	}
}
preset_musician_instrument_hack = {
	CAS_Guitar_Body = {
		desc_id = GTR31_Horizon
	}
	CAS_Guitar_Finish = {
		desc_id = GTR33_flamed
	}
	CAS_Guitar_Body_Detail = {
		desc_id = gtr33_dtl11
		chosen_materials = {
			material1 = Black_1guitar
		}
	}
	CAS_Guitar_Neck = {
		desc_id = GTR_24fret_Fretboard_03
	}
	CAS_Guitar_Head = {
		desc_id = GTR31c_NeckHead_02
	}
	CAS_Guitar_Head_Finish = {
		desc_id = espcolor
		chosen_materials = {
			material1 = Black_1guitar
		}
	}
	CAS_Guitar_Head_Detail = {
		desc_id = GTR37_nekhed_DTL02
		chosen_materials = {
			material1 = red_1
		}
	}
	CAS_Guitar_Pickguards = {
		desc_id = none
	}
	CAS_Guitar_Bridges = {
		desc_id = GTR31_Bridge_FR
	}
	CAS_Guitar_Knobs = {
		desc_id = GTR_32_KNOBS_B
	}
	CAS_Guitar_Pickups = {
		desc_id = gtr31_pickup_gold
	}
	CAS_Bass_Body = {
		desc_id = bass17_esp_ec_01
	}
	CAS_Bass_Finish = {
		desc_id = Bass17_esp_EC_LD_12
		chosen_materials = {
			material1 = yellow_1
		}
	}
	CAS_Bass_Neck = {
		desc_id = Bass_Fretboard_24black
	}
	CAS_Bass_Neck_Finish = {
		desc_id = Bass_Fretboard_Inlay_01
	}
	CAS_Bass_Head = {
		desc_id = Bass14_Neckhead_04
	}
	CAS_Bass_Head_Finish = {
		desc_id = esp_solidcolor
		chosen_materials = {
			material1 = Black_1guitar
		}
	}
	CAS_Bass_Head_Detail = {
		desc_id = none_esp
	}
	CAS_Bass_Pickguards = {
		desc_id = none
	}
	CAS_Bass_Pickups = {
		desc_id = Bass9_Pkup_Type3_Blk_2
		chosen_materials = {
			material1 = grey_2guitar
		}
	}
	CAS_Bass_Bridges = {
		desc_id = Bass17_Bridge_4str_04
	}
	CAS_Bass_Knobs = {
		desc_id = Bass17_ESP_Knob_10
		chosen_materials = {
			material1 = grey_3guitar
		}
	}
	CAS_Mic = {
		desc_id = mic_standard
	}
	CAS_Mic_Stand = {
		desc_id = mic_stand_female
	}
	CAS_Drums = {
		desc_id = singlebasskit
	}
	cas_drums_sticks_l = {
		desc_id = drm_stick_l
	}
	cas_drums_sticks_r = {
		desc_id = drm_stick_r
	}
}
preset_male_base_parts = {
	CAS_Male_Base_Torso = {
		desc_id = car_male_torso
	}
}
preset_female_base_parts = {
	CAS_Female_Base_Torso = {
		desc_id = car_female_torso
	}
}
worst_male_appearance_hack = {
	cas_physique = {
		desc_id = MalePhysique
		bones = {
			Height = 1.0
			Physique = 1.0
		}
	}
	CAS_Highway = {
		desc_id = highway
	}
	CAS_Gems = {
		desc_id = gem_set_01
	}
}
worst_female_appearance_hack = {
	cas_physique = {
		desc_id = FemalePhysique
		bones = {
			Height = 1.0
			Physique = 1.0
			Chest = 1.0
		}
	}
	CAS_Highway = {
		desc_id = AxelHighway
	}
	CAS_Gems = {
		desc_id = gem_set_01
	}
}
Preset_Musician_Profiles_Modifiable = [
	{
		name = axel
		fullname = qs("\LAxel Steel")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_axel
		blurb = qs("In his recently published autobiography 'Broken Axel', the noticeably more mature man of Steel wrote, 'I killed emo. And disco still sucks.'")
		ghrocker
		appearance = {
			genre = `Classic Rock`
			CAS_Full_Body = {
				desc_id = axel_1
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Male_Intro_Anim = {
				desc_id = Intro_Pointing
			}
			CAS_Male_Win_Anim = {
				desc_id = Win_Kick
			}
			CAS_Male_Lose_Anim = {
				desc_id = Lose_AngryAtCrowd
			}
			CAS_Guitar_Body = {
				desc_id = gtr12_esp_v_01
			}
			CAS_Guitar_Finish = {
				desc_id = gtr12_esp_v_series_ld_01_color
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr12_esp_v_series_dtl_7b
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr12_esp_v_series_dtl_7a
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld03_hero_tribal
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr12_neckhead_07
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr33_nhead_dtl03
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_head_fade = {
				desc_id = head_fade_none
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr12_bridge_1
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr12_esp_knob_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = GTR1_ESP_EMG_Pkup_2
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body = {
				desc_id = bass_schect_030
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_bod04_ld01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bs_sch_bod04_dtl21
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_bod04_dtl05
				chosen_materials = {
					material1 = orange_5
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch_inl_ld44
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_030_nhead01
			}
			CAS_Bass_Head_Finish = {
				desc_id = gh5_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = bs_sch_04_hd_dtl09
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_030_pga
			}
			CAS_Bass_Pickups = {
				desc_id = basslines1b
			}
			CAS_Bass_Bridges = {
				desc_id = schbb104
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
			}
			CAS_Mic = {
				desc_id = mic_sixties
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_sixties
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld61
				chosen_materials = {
					material1 = yellow_orange_2
				}
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld25
				chosen_materials = {
					material1 = yellow_orange_3
				}
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Bass_Highway = {
				desc_id = AxelHighway
			}
			CAS_Guitar_Highway = {
				desc_id = AxelHighway
			}
			CAS_Drums_Highway = {
				desc_id = AxelHighway
			}
		}
	}
	{
		name = Casey
		fullname = qs("\LCasey Lynch")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_casey
		blurb = qs("Casey has always led the charge towards innovative new sounds and style. Move over, sliced bread because this year, two words: Burlesque Rock.")
		ghrocker
		appearance = {
			genre = `Heavy Metal`
			CAS_Full_Body = {
				desc_id = Casey_1
			}
			cas_physique = {
				desc_id = FemalePhysique
			}
			CAS_Female_Win_Anim = {
				desc_id = Win_Hype
			}
			CAS_Female_Lose_Anim = {
				desc_id = Lose_AngryAtCrowd
			}
			CAS_Female_Intro_Anim = {
				desc_id = Intro_Hype
			}
			CAS_Guitar_Body = {
				desc_id = gtr12_esp_v_01
			}
			CAS_Guitar_Finish = {
				desc_id = gtr12_esp_v_series_ld_01_color
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr12_esp_v_series_dtl_19
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr12_esp_v_series_dtl_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld03_hero_tribal
				chosen_materials = {
					material1 = red_2
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr12_neckhead_07
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr33_nhead_dtl03
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_head_fade = {
				desc_id = gtr33_nhead_dtl01
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr12_bridge_3
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr12_esp_knob_01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = GTR1_ESP_EMG_Pkup_2
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body = {
				desc_id = Bass9_ESP_AX_01
			}
			CAS_Bass_Finish = {
				desc_id = Bass9_ESP_AX_D_color
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bass9_esp_ax_dtl_19
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_body_fade = {
				desc_id = bass9_esp_ax_dtl_03
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24black
			}
			CAS_Bass_Neck_Finish = {
				desc_id = neck_inlay_fl_blank
			}
			CAS_Bass_Head = {
				desc_id = Bass9_Neckhead_01
			}
			CAS_Bass_Head_Finish = {
				desc_id = gh5_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_esp
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type1_Blk_02
			}
			CAS_Bass_Bridges = {
				desc_id = Bass9_Bridge_4str_01
			}
			CAS_Bass_Knobs = {
				desc_id = bass9_esp_knob_10_04
			}
			CAS_Mic = {
				desc_id = mic_sixties
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_sixties
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld65
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld39
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Bass_Highway = {
				desc_id = CaseyHighway
			}
			CAS_Guitar_Highway = {
				desc_id = CaseyHighway
			}
			CAS_Drums_Highway = {
				desc_id = CaseyHighway
			}
		}
	}
	{
		name = Izzy
		fullname = qs("\LIzzy Sparks")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_izzy
		blurb = qs(0xb689556b)
		ghrocker
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = izzy_1
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Male_Intro_Anim = {
				desc_id = Intro_Hype
			}
			CAS_Male_Win_Anim = {
				desc_id = Win_KungFu
			}
			CAS_Male_Lose_Anim = {
				desc_id = Lose_Tantrum
			}
			CAS_Guitar_Body = {
				desc_id = gtr94_dr_tomboy
			}
			CAS_Guitar_Finish = {
				desc_id = gtr94_dr_tomboy_ld06
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr94_dr_tomboy_dtl14
				chosen_materials = {
					material1 = purple_blue_1
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr94_dr_tomboy_dtl03
				chosen_materials = {
					material1 = purple_blue_1
				}
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld125_dr_elite
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr94_dr_neckhead01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr93_neckhead01_ld07
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_head_fade = {
				desc_id = head_fade_none
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr94_bridge
			}
			CAS_Guitar_Knobs = {
				desc_id = starlights
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = hz
			}
			CAS_Bass_Body = {
				desc_id = bass15_mcswain_machine
			}
			CAS_Bass_Finish = {
				desc_id = bass15_mcswain_machine_ld2
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_21a
			}
			CAS_Bass_Neck_Finish = {
				desc_id = 22fret_ld06_mcswn_bolts
			}
			CAS_Bass_Head = {
				desc_id = bass15_neckhead_mcswain1
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass15_nkhd_mcswain_ld2
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_esp
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = basslines1b
			}
			CAS_Bass_Bridges = {
				desc_id = mcswainbullet
			}
			CAS_Bass_Knobs = {
				desc_id = chromedomes
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld21
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld48
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Bass_Highway = {
				desc_id = IzzyHighway
			}
			CAS_Guitar_Highway = {
				desc_id = IzzyHighway
			}
			CAS_Drums_Highway = {
				desc_id = IzzyHighway
			}
		}
	}
	{
		name = judy
		fullname = qs("\LJudy Nails")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_judy
		blurb = qs(0x7dd6fbb1)
		ghrocker
		appearance = {
			genre = `Heavy Metal`
			CAS_Full_Body = {
				desc_id = Judy_1
			}
			cas_physique = {
				desc_id = FemalePhysique
			}
			CAS_Female_Win_Anim = {
				desc_id = Win_Hype
			}
			CAS_Female_Lose_Anim = {
				desc_id = Lose_AngryAtCrowd
			}
			CAS_Female_Intro_Anim = {
				desc_id = Intro_Hype
			}
			CAS_Guitar_Body = {
				desc_id = gtr73_sch_s1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr73_sch_s1_ld01judy
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22_fret_ld34_shctr_ladyluck
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr73_neckhead_01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr73_neckhead_ld01
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_head_fade = {
				desc_id = head_fade_none
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr73_pg1
			}
			CAS_Guitar_Pickguard_Finish = {
				desc_id = black
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr71_bridge
			}
			CAS_Guitar_Knobs = {
				desc_id = speedster
			}
			CAS_Guitar_Pickups = {
				desc_id = emg81dbl
			}
			CAS_Guitar_Misc = {
				desc_id = misc_switch
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body = {
				desc_id = bs_sch_t_body
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl01
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bs_sch_mt_ld02
				chosen_materials = {
					material1 = red_1
				}
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_mt_ld09
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_21a
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch22_inl_ld32
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_t_nhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass_neckhead_mt
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_esp
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = basslines1b
			}
			CAS_Bass_Bridges = {
				desc_id = schbb104
			}
			CAS_Bass_Knobs = {
				desc_id = knurled
			}
			CAS_Mic = {
				desc_id = mic_sixties
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_sixties
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld64
				chosen_materials = {
					material1 = red_3
				}
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld53
				chosen_materials = {
					material1 = red_3
				}
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Bass_Highway = {
				desc_id = JudyHighway
			}
			CAS_Guitar_Highway = {
				desc_id = JudyHighway
			}
			CAS_Drums_Highway = {
				desc_id = JudyHighway
			}
		}
	}
	{
		name = Johnny
		fullname = qs("\LJohnny Napalm")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_Johnny
		blurb = qs("Johnny is back in full form and he's not clowning around. 'Punk is dead!' a crowd member was heard screaming at a Johnny Napalm show last summer. A truly prophetic statement for the young man...")
		ghrocker
		appearance = {
			genre = Punk
			CAS_Full_Body = {
				desc_id = johnny_1
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Male_Intro_Anim = {
				desc_id = Intro_Generic1
			}
			CAS_Male_Win_Anim = {
				desc_id = Win_Kick
			}
			CAS_Male_Lose_Anim = {
				desc_id = Lose_kick
			}
			CAS_Guitar_Body = {
				desc_id = gtr33_boris
			}
			CAS_Guitar_Finish = {
				desc_id = gtr_33_snakskul
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld103_esp_skulls2
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr33_nekhed_01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr4_neckhead_d_06
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_head_fade = {
				desc_id = head_fade_none
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr33_bridge_fr
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr_33_knobs_a
			}
			CAS_Guitar_Pickups = {
				desc_id = GTR30_EMG
			}
			CAS_Bass_Body = {
				desc_id = Bass63_EX
			}
			CAS_Bass_Finish = {
				desc_id = bass63_ex_ld_09_color
				chosen_materials = {
					material1 = red_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bass63_ex_dtl_7b
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			cas_bass_body_fade = {
				desc_id = bass63_ex_dtl_7a
				chosen_materials = {
					material1 = grey_4guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_21d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_06
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = Bass63_Neckhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = red_2
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_esp
			}
			cas_bass_head_fade = {
				desc_id = bass9_neckhead5_dtl_04
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = bass_bridges_01
			}
			CAS_Bass_Knobs = {
				desc_id = bass63_knob_type1
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			CAS_Drum_Detail = {
				desc_id = bass_skin_ds_13
				chosen_materials = {
					material1 = red_2
				}
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld20
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Bass_Highway = {
				desc_id = JohnnyHighway
			}
			CAS_Guitar_Highway = {
				desc_id = JohnnyHighway
			}
			CAS_Drums_Highway = {
				desc_id = JohnnyHighway
			}
		}
	}
	{
		name = Lars
		fullname = qs("\LLars Umlaut")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_Lars
		blurb = qs("Lars winters at his Uncle Otto's Bavarian Castle in the Regierungsbezirke of Unterfranken, near Bad Kissingen. A typical winter is passed in the castle known as Schloss Umlautstein by the great fireplace in the grand bathroom.")
		ghrocker
		appearance = {
			genre = `Black Metal`
			CAS_Full_Body = {
				desc_id = lars_1
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Male_Intro_Anim = {
				desc_id = Intro_Scary
			}
			CAS_Male_Win_Anim = {
				desc_id = Win_Scary
			}
			CAS_Male_Lose_Anim = {
				desc_id = Lose_AngryAtCrowd
			}
			CAS_Guitar_Body = {
				desc_id = gtr21_bc_rich_warbeast
			}
			CAS_Guitar_Finish = {
				desc_id = gtr_bc_rich_warbeast_ld6
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld03_bcr_trance
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr21_neckhead_beast01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr20_neckhead_dtl01
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			cas_guitar_head_fade = {
				desc_id = head_fade_none
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = bcr_thru
			}
			CAS_Guitar_Knobs = {
				desc_id = chromedomes
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = duncan59dbl
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body = {
				desc_id = Bass9_ESP_AX_01
			}
			CAS_Bass_Finish = {
				desc_id = Bass9_ESP_AX_D_color
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bass9_esp_ax_dtl_01
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24black
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_24_inlay_05
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = Bass9_Neckhead_01
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = bass9_neckhead_dtl_01
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass9_Bridge_4str_01
			}
			CAS_Bass_Knobs = {
				desc_id = bass9_esp_knob_10_04
			}
			CAS_Mic = {
				desc_id = mic_sixties
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_sixties
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld35
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld43
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Bass_Highway = {
				desc_id = LarsHighway
			}
			CAS_Guitar_Highway = {
				desc_id = LarsHighway
			}
			CAS_Drums_Highway = {
				desc_id = LarsHighway
			}
		}
	}
	{
		name = Clive
		fullname = qs("\LClive Winston")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_Clive
		blurb = qs(0xac8c05ed)
		ghrocker
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = Clive_1
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Male_Intro_Anim = {
				desc_id = Intro_Generic3
			}
			CAS_Male_Win_Anim = {
				desc_id = Win_Generic2
			}
			CAS_Male_Lose_Anim = {
				desc_id = Lose_Generic
			}
			CAS_Guitar_Body = {
				desc_id = gtr38_wv
			}
			CAS_Guitar_Finish = {
				desc_id = gtr37_rw_d_color
				chosen_materials = {
					material1 = navy_3
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_fboard_22
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld86_esp_dots
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr37_neckhead
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr37_nekhed
			}
			CAS_Guitar_Head_Detail = {
				desc_id = esp_none
			}
			cas_guitar_head_fade = {
				desc_id = head_fade_none
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr37_pguard01
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr37_bridge
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr37_knobs01
			}
			CAS_Guitar_Pickups = {
				desc_id = gtr37_pickup1
			}
			CAS_Bass_Body = {
				desc_id = bs_sch_t_body
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl02
				chosen_materials = {
					material1 = red_orange_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_mt_ld04
				chosen_materials = {
					material1 = orange_3
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24c
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch_inl_ld42
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_t_nhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass_neckhead_mt
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emg35double
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = schsimple
			}
			CAS_Bass_Knobs = {
				desc_id = knurled
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			CAS_Drum_Detail = {
				desc_id = bass_skin_ds_01
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld14
				chosen_materials = {
					material1 = red_orange_3
				}
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Bass_Highway = {
				desc_id = WinstonHighway
			}
			CAS_Guitar_Highway = {
				desc_id = WinstonHighway
			}
			CAS_Drums_Highway = {
				desc_id = WinstonHighway
			}
		}
	}
	{
		name = Pandora
		fullname = qs("\LPandora")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_Pandora
		blurb = qs("Pandora's finger calluses have been pulling double-duty as she's been designing not only new fretting techniques, but sewing her own wild costumes.")
		ghrocker
		appearance = {
			genre = Goth
			CAS_Full_Body = {
				desc_id = Pandora_1
			}
			cas_physique = {
				desc_id = FemalePhysique
				bones = {
					Physique = 0.0
				}
			}
			CAS_Female_Intro_Anim = {
				desc_id = Intro_Hype
			}
			CAS_Female_Win_Anim = {
				desc_id = Win_Hype
			}
			CAS_Female_Lose_Anim = {
				desc_id = Lose_AngryAtCrowd
			}
			CAS_Guitar_Body = {
				desc_id = gtr75_ibz_xpt
			}
			CAS_Guitar_Finish = {
				desc_id = gtr75_ibz_xpt_ld02
				chosen_materials = {
					material1 = grey_4guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr75_ibz_xpt_dtl01
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr75_ibz_xpt_dtl03
				chosen_materials = {
					material1 = blue_1
				}
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_02
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld63_ibz_diamond
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr75_neckhead_01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = esp_none
			}
			cas_guitar_head_fade = {
				desc_id = gtr75_neckhead_dtl03
				chosen_materials = {
					material1 = blue_1
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = ibz_pu_edgezero
			}
			CAS_Guitar_Knobs = {
				desc_id = chickenheads
			}
			CAS_Guitar_Pickups = {
				desc_id = humandrail
				chosen_materials = {
					material1 = blue_3
				}
			}
			CAS_Guitar_Misc = {
				desc_id = misc_switch
			}
			CAS_Bass_Body = {
				desc_id = bass17_esp_ec_01
			}
			CAS_Bass_Finish = {
				desc_id = Bass17_esp_EC_LD_11
				chosen_materials = {
					material1 = blue_1
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bass17_esp_ax_dtl_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24black
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bass_fretboard_24_inlay_01
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = Bass14_Neckhead_03
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = bass9_neckhead3_dtl_01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type3_Blk_2
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = bass17_bridge_4str_05
			}
			CAS_Bass_Knobs = {
				desc_id = bass17_knob_02
			}
			CAS_Mic = {
				desc_id = mic_blackmetal
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld11
				chosen_materials = {
					material1 = navy_1
				}
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld31
				chosen_materials = {
					material1 = navy_3
				}
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Bass_Highway = {
				desc_id = JudyHighway
			}
			CAS_Guitar_Highway = {
				desc_id = JudyHighway
			}
			CAS_Drums_Highway = {
				desc_id = JudyHighway
			}
		}
	}
	{
		name = Eddie
		fullname = qs("\LEddie Knox")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_Eddie
		blurb = qs(0x1e1ea82c)
		ghrocker
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = Eddie_1
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Male_Intro_Anim = {
				desc_id = Intro_Elvis
			}
			CAS_Male_Win_Anim = {
				desc_id = Win_Elvis
			}
			CAS_Male_Lose_Anim = {
				desc_id = Lose_kick
			}
			CAS_Guitar_Body = {
				desc_id = gtr82_prs_se1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr78_prs_sc_ld02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr78_prs_sc_dtl7a
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr78_prs_sc_dtl7b
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld115_prs_bats
				chosen_materials = {
					material1 = teal_1
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr82_neckhead01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = esp_none
			}
			cas_guitar_head_fade = {
				desc_id = gtr82_neckhead_01_dtl04
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr82_pguard
			}
			CAS_Guitar_Pickguard_Finish = {
				desc_id = custom_color_esp
				chosen_materials = {
					material1 = teal_1
				}
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr78_straightbridge
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = dice
				chosen_materials = {
					material1 = teal_1
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = soap
			}
			CAS_Bass_Body = {
				desc_id = bass_schect_030
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_bod04_ld01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bs_sch_bod04_dtl11
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_21d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch22_inl_ld47
				chosen_materials = {
					material1 = teal_1
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_030_nhead01
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bs_sch_04_hd_dtl05
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_030_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emgj
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = capsule
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Knobs = {
				desc_id = dice
				chosen_materials = {
					material1 = teal_1
				}
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld46
				chosen_materials = {
					material1 = red_orange_1
				}
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld16
				chosen_materials = {
					material1 = yellow_1guitar
				}
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
			CAS_Bass_Highway = {
				desc_id = CaseyHighway
			}
			CAS_Guitar_Highway = {
				desc_id = CaseyHighway
			}
			CAS_Drums_Highway = {
				desc_id = CaseyHighway
			}
		}
	}
	{
		name = Metalhead
		fullname = qs(0x6fae039b)
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_Metalhead
		blurb = qs(0x00781a77)
		locked
		ghrocker
		appearance = {
			genre = `Classic Rock`
			CAS_Full_Body = {
				desc_id = Metalhead_1
			}
			cas_physique = {
				desc_id = MalePhysique
				additional_bone_transforms = [
					{
						bone = Bone_Collar_R
						translation = {
							value = (0.0, -0.15, 0.0)
						}
					}
					{
						bone = Bone_Collar_L
						translation = {
							value = (0.0, -0.15, 0.0)
						}
					}
				]
			}
			CAS_Bass_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Guitar_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Drums_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Gems = {
				desc_id = gem_set_01
			}
			CAS_Guitar_Body = {
				desc_id = rocket_body
			}
			CAS_Guitar_Neck = {
				desc_id = rocket_fretboard
			}
			CAS_Guitar_Head = {
				desc_id = rocket_neckhead01
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = customnone
			}
			CAS_Guitar_Knobs = {
				desc_id = guitarnone
			}
			CAS_Guitar_Pickups = {
				desc_id = rocket_dome
			}
			CAS_Bass_Body = {
				desc_id = Bass16_ESP_Surveyor_02
			}
			CAS_Bass_Finish = {
				desc_id = Bass14_esp_AX_LD_11
				chosen_materials = {
					material1 = violet_1
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = Bass14_ESP_AX_DTL_01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_22b
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_06
			}
			CAS_Bass_Head = {
				desc_id = Bass14_Neckhead_04
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass14_Bridge_4str_02
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Bass_Knobs = {
				desc_id = Bass14_knob_03
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = none
			}
			CAS_Drum_Detail = {
				desc_id = none
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Mic = {
				desc_id = mic_sixties
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = Fembot
		fullname = qs(0xd9275462)
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_Fembot
		blurb = qs(0x59d77608)
		locked
		ghrocker
		appearance = {
			genre = `Classic Rock`
			CAS_Full_Body = {
				desc_id = Fembot_1
			}
			cas_physique = {
				desc_id = FemalePhysique
				additional_bone_transforms = [
					{
						bone = Bone_Collar_R
						translation = {
							value = (0.0, -0.1, 0.0)
						}
					}
					{
						bone = Bone_Collar_L
						translation = {
							value = (0.0, -0.1, 0.0)
						}
					}
				]
			}
			CAS_Bass_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Guitar_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Drums_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Gems = {
				desc_id = gem_set_01
			}
			CAS_Guitar_Body = {
				desc_id = rocket_body
			}
			CAS_Guitar_Neck = {
				desc_id = rocket_fretboard
			}
			CAS_Guitar_Head = {
				desc_id = rocket_neckhead01
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = customnone
			}
			CAS_Guitar_Knobs = {
				desc_id = guitarnone
			}
			CAS_Guitar_Pickups = {
				desc_id = rocket_dome
			}
			CAS_Bass_Body = {
				desc_id = Bass16_ESP_Surveyor_02
			}
			CAS_Bass_Finish = {
				desc_id = Bass14_esp_AX_LD_11
				chosen_materials = {
					material1 = violet_1
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = Bass14_ESP_AX_DTL_01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_22b
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_06
			}
			CAS_Bass_Head = {
				desc_id = Bass14_Neckhead_04
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass14_Bridge_4str_02
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Bass_Knobs = {
				desc_id = Bass14_knob_03
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = none
			}
			CAS_Drum_Detail = {
				desc_id = none
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Mic = {
				desc_id = mic_sixties
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = Scrap_Heap
		fullname = qs(0xca13039a)
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		locked
		preset_icon = photo_Metalhead
		blurb = qs(0xc8ba2436)
		ghrocker
		appearance = {
			genre = `Classic Rock`
			CAS_Full_Body = {
				desc_id = junkbot
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Bass_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Guitar_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Drums_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Gems = {
				desc_id = gem_set_01
			}
			CAS_Guitar_Body = {
				desc_id = gtr82_prs_se1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr78_prs_sc_ld03
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr78_prs_sc_dtl20
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld115_prs_bats
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr82_neckhead01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr82_neckhead_01_ld01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr82_neckhead_06
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			cas_guitar_head_fade = {
				desc_id = gtr82_neckhead_01_dtl04
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr82_pguard
			}
			CAS_Guitar_Pickguard_Finish = {
				desc_id = shell2
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr79_whammy
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = speedknobs
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = dantiqsngl
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body = {
				desc_id = bass15_mcswain_machine
			}
			CAS_Bass_Finish = {
				desc_id = bass15_mcswain_machine_ld4
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24black
			}
			CAS_Bass_Neck_Finish = {
				desc_id = 22fret_ld06_mcswn_bolts
			}
			CAS_Bass_Head = {
				desc_id = bass15_neckhead_mcswain1
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass15_nkhd_mcswain_ld4
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_esp
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = basslines1b
			}
			CAS_Bass_Bridges = {
				desc_id = mcswainbullet
			}
			CAS_Bass_Knobs = {
				desc_id = chromedomes
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld06
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld28
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Mic = {
				desc_id = mic_sixties
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = Robbie_Lobster
		fullname = qs(0x97ce23c5)
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		locked
		preset_icon = photo_Metalhead
		blurb = qs(0x45165d26)
		ghrocker
		appearance = {
			genre = `Classic Rock`
			CAS_Full_Body = {
				desc_id = rob_lobster
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Bass_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Guitar_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Drums_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Gems = {
				desc_id = gem_set_01
			}
			CAS_Guitar_Body = {
				desc_id = gtr70_sch_ultra
			}
			CAS_Guitar_Finish = {
				desc_id = gtr70_sch_ultra_ld04
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_body_fade = {
				desc_id = gtr70_sch_ultra_dtl05
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld31_shctr_c1
			}
			CAS_Guitar_Head = {
				desc_id = gtr70_neckhead_02
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr70_pg
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr70_bridge
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = starlights
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = duncanbodbl
			}
			CAS_Bass_Body = {
				desc_id = bass17_esp_ec_01
			}
			CAS_Bass_Finish = {
				desc_id = Bass14_esp_AX_LD_11
				chosen_materials = {
					material1 = green_2guitar
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bass17_esp_ax_dtl_13
			}
			cas_bass_body_fade = {
				desc_id = bass17_esp_ax_dtl_04
				chosen_materials = {
					material1 = yellow_green_1guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = none
			}
			CAS_Bass_Head = {
				desc_id = Bass14_Neckhead_04
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = green_2guitar
				}
			}
			cas_bass_head_fade = {
				desc_id = bass9_neckhead4_dtl_05
				chosen_materials = {
					material1 = yellow_green_2guitar
				}
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type3_Blk_2
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass17_Bridge_4str_04
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Bass_Knobs = {
				desc_id = Bass17_ESP_Knob_10
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld19
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld94
			}
			CAS_Mic = {
				desc_id = mic_sixties
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = Racques_Topus
		fullname = qs(0xc195a33d)
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		locked
		preset_icon = photo_Metalhead
		blurb = qs(0x7a4e1608)
		ghrocker
		appearance = {
			genre = `Classic Rock`
			CAS_Full_Body = {
				desc_id = rocktopus
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Bass_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Guitar_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Drums_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Highway = {
				desc_id = BudcatHighway
			}
			CAS_Gems = {
				desc_id = gem_set_01
			}
			CAS_Guitar_Body = {
				desc_id = gtr12_mcswain_minferno
			}
			CAS_Guitar_Finish = {
				desc_id = gtr12_mcswain_minferno_ld4
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr12_mcswain_minferno_dtl1
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr12_mcswain_minferno_fd2
				chosen_materials = {
					material1 = purple_blue_1
				}
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = none
			}
			CAS_Guitar_Head = {
				desc_id = gtr12_neckhead_mcswain12
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr12_nkhd_mcswain_ld4
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr11_neckhead_dtl_01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_head_fade = {
				desc_id = gtr12_neckhead_dtl_02
				chosen_materials = {
					material1 = purple_blue_1
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr_brdg_mcswn_inferno_3
			}
			CAS_Guitar_Knobs = {
				desc_id = chromespeedster
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = emg81sngl
			}
			CAS_Bass_Body = {
				desc_id = Bass16_ESP_Surveyor_02
			}
			CAS_Bass_Finish = {
				desc_id = Bass14_esp_AX_LD_11
				chosen_materials = {
					material1 = violet_1
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = Bass14_ESP_AX_DTL_01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_22b
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_06
			}
			CAS_Bass_Head = {
				desc_id = Bass14_Neckhead_04
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass14_Bridge_4str_02
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Bass_Knobs = {
				desc_id = Bass14_knob_03
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = drumshell_ds_11
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld92
				chosen_materials = {
					material1 = violet_1
				}
			}
			CAS_Mic = {
				desc_id = mic_sixties
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
]
Preset_Musician_Profiles_Locked = [
	{
		name = GH_Rocker_JohnnyCash_CAR
		fullname = qs("\LJohnny Cash")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		locked
		preset_icon = photo_Eddie
		blurb = qs("I'm Johnny Cash.")
		no_random_pick
		locked
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = JohnnyCash_CAR
			}
			cas_male_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = GTR27_NSFT_Acoustic
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_cash_acoustic
			}
			CAS_Guitar_Head = {
				desc_id = gtr27_neckhead_acoustic
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr27_bridge_acoustic
			}
			CAS_Guitar_Knobs = {
				desc_id = guitarnone
			}
			CAS_Guitar_Pickups = {
				desc_id = banjo1
			}
			CAS_Bass_Body = {
				desc_id = bs_sch_t_body
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl02
				chosen_materials = {
					material1 = red_orange_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_mt_ld04
				chosen_materials = {
					material1 = orange_3
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24c
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch_inl_ld42
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_t_nhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass_neckhead_mt
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emg35double
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = schsimple
			}
			CAS_Bass_Knobs = {
				desc_id = knurled
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_female
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
		}
	}
	{
		name = GH_Rocker_Santana
		fullname = qs("\LCarlos Santana")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I'm Carlos Santana")
		no_random_pick
		locked
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = Santana_1
			}
			cas_male_physique = {
				desc_id = MalePhysique
			}
			$preset_musician_instrument_hack
			CAS_Guitar_Body = {
				desc_id = gtr_santana
			}
			CAS_Guitar_Body_Detail = {
				desc_id = none
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_04
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld80_prs_birds02
			}
			CAS_Guitar_Head = {
				desc_id = gtr80_neckhead_01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr80_neckhead_ld06
				chosen_materials = {
					material1 = red_orange_2
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = none
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr79_whammy
			}
			CAS_Guitar_Knobs = {
				desc_id = lampshade
			}
			CAS_Guitar_Pickups = {
				desc_id = banjo1
			}
			CAS_Bass_Body = {
				desc_id = bs_sch_t_body
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl02
				chosen_materials = {
					material1 = red_orange_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_mt_ld04
				chosen_materials = {
					material1 = orange_3
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24c
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch_inl_ld42
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_t_nhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass_neckhead_mt
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emg35double
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = schsimple
			}
			CAS_Bass_Knobs = {
				desc_id = knurled
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_female
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
		}
	}
	{
		name = GH_Rocker_MattBellamy
		fullname = qs("\LMatt BellamyXXX")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		Win_Anims = [
			g_GuitMic_win_waving
		]
		Lose_Anims = [
			G_GuitMic_Lose_Depressed
		]
		preset_icon = photo_Eddie
		blurb = qs("Muse")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = Matt_Bellamy
			}
			cas_male_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr25_manson_bellamy
			}
			CAS_Guitar_Finish = {
				desc_id = none
			}
			CAS_Guitar_Body_Detail = {
				desc_id = none
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_22fret_Fretboard_04
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = none
			}
			CAS_Guitar_Head = {
				desc_id = gtr25_neckhead_manson
			}
			CAS_Guitar_Head_Detail = {
				desc_id = none
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr_brdg_manson_1
			}
			CAS_Guitar_Knobs = {
				desc_id = chromedomes
			}
			CAS_Guitar_Pickups = {
				desc_id = banjo1
			}
			CAS_Bass_Body = {
				desc_id = bs_sch_t_body
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl02
				chosen_materials = {
					material1 = red_orange_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_mt_ld04
				chosen_materials = {
					material1 = orange_3
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24c
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch_inl_ld42
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_t_nhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass_neckhead_mt
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emg35double
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = schsimple
			}
			CAS_Bass_Knobs = {
				desc_id = knurled
			}
			CAS_Mic = {
				desc_id = mic_cash
			}
			CAS_Mic_Stand = {
				desc_id = micstand_cash
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
		}
	}
	{
		name = GH_Rocker_MattBellamy_CAR
		fullname = qs("\LMatt Bellamy")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I'm Matt Bellamy")
		no_random_pick
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = Matt_Bellamy_CAR
			}
			cas_male_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr25_manson_bellamy
			}
			CAS_Guitar_Finish = {
				desc_id = none
			}
			CAS_Guitar_Body_Detail = {
				desc_id = none
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_22fret_Fretboard_04
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = none
			}
			CAS_Guitar_Head = {
				desc_id = gtr25_neckhead_manson
			}
			CAS_Guitar_Head_Detail = {
				desc_id = none
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr_brdg_manson_1
			}
			CAS_Guitar_Knobs = {
				desc_id = chromedomes
			}
			CAS_Guitar_Pickups = {
				desc_id = banjo1
			}
			CAS_Bass_Body = {
				desc_id = bs_sch_t_body
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl02
				chosen_materials = {
					material1 = red_orange_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_mt_ld04
				chosen_materials = {
					material1 = orange_3
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24c
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch_inl_ld42
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_t_nhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass_neckhead_mt
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emg35double
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = schsimple
			}
			CAS_Bass_Knobs = {
				desc_id = knurled
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_female
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
		}
	}
	{
		name = GH_Rocker_KurtCobain
		fullname = qs("\LKurt Cobain")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I'm Kurt Cobain")
		no_random_pick
		locked
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = KurtCobain
			}
			cas_male_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr78_kurt
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld86_esp_dots
			}
			CAS_Guitar_Head = {
				desc_id = gtr78_neckhead
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr78_pg
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr78_bridge
			}
			CAS_Guitar_Knobs = {
				desc_id = tophat
			}
			CAS_Guitar_Pickups = {
				desc_id = gtr78_pickup1
			}
			CAS_Guitar_Misc = {
				desc_id = gtr78_misc
			}
			CAS_Bass_Body = {
				desc_id = bs_sch_t_body
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl02
				chosen_materials = {
					material1 = red_orange_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_mt_ld04
				chosen_materials = {
					material1 = orange_3
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24c
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch_inl_ld42
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_t_nhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass_neckhead_mt
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emg35double
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = schsimple
			}
			CAS_Bass_Knobs = {
				desc_id = knurled
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_female
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
		}
	}
	{
		name = GH_Rocker_KurtCobain_Lefty
		fullname = qs("\LKurt Cobain Lefty")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		Win_Anims = [
			G_Lefty_win_waving
		]
		Lose_Anims = [
			G_Lefty_Lose_Depressed
		]
		preset_icon = photo_Eddie
		blurb = qs("I'm Kurt Cobain")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = kurtcobain_left
			}
			cas_male_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr78_kurt
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld86_esp_dots
			}
			CAS_Guitar_Head = {
				desc_id = gtr78_neckhead
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr78_pg
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr78_bridge
			}
			CAS_Guitar_Knobs = {
				desc_id = tophat
			}
			CAS_Guitar_Pickups = {
				desc_id = gtr78_pickup1
			}
			CAS_Guitar_Misc = {
				desc_id = gtr78_misc
			}
			CAS_Bass_Body = {
				desc_id = bs_sch_t_body
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl02
				chosen_materials = {
					material1 = red_orange_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_mt_ld04
				chosen_materials = {
					material1 = orange_3
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24c
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch_inl_ld42
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_t_nhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass_neckhead_mt
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emg35double
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = schsimple
			}
			CAS_Bass_Knobs = {
				desc_id = knurled
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_female
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
		}
	}
	{
		name = GH_Rocker_ShirleyManson
		fullname = qs("\LShirley Manson")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		locked
		preset_icon = photo_Eddie
		blurb = qs("I'm Shirley Manson")
		no_random_pick
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = ShirleyManson
			}
			cas_female_physique = {
				desc_id = FemalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr12_esp_v_01
			}
			CAS_Guitar_Finish = {
				desc_id = gtr12_esp_v_series_ld_01_color
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr12_esp_v_series_dtl_19
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr12_esp_v_series_dtl_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld03_hero_tribal
				chosen_materials = {
					material1 = red_2
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr12_neckhead_07
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr33_nhead_dtl03
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_head_fade = {
				desc_id = gtr33_nhead_dtl01
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr12_bridge_3
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr12_esp_knob_01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = GTR1_ESP_EMG_Pkup_2
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body = {
				desc_id = Bass9_ESP_AX_01
			}
			CAS_Bass_Finish = {
				desc_id = Bass9_ESP_AX_D_color
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bass9_esp_ax_dtl_19
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_body_fade = {
				desc_id = bass9_esp_ax_dtl_03
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24black
			}
			CAS_Bass_Neck_Finish = {
				desc_id = neck_inlay_fl_blank
			}
			CAS_Bass_Head = {
				desc_id = Bass9_Neckhead_01
			}
			CAS_Bass_Head_Finish = {
				desc_id = gh5_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_esp
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type1_Blk_02
			}
			CAS_Bass_Bridges = {
				desc_id = Bass9_Bridge_4str_01
			}
			CAS_Bass_Knobs = {
				desc_id = bass9_esp_knob_10_04
			}
			CAS_Mic = {
				desc_id = mic_shirley
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_shirley
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
		}
	}
	{
		name = GH_Rocker_JohnnyCash
		fullname = qs("\LJohnny Cash")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		Win_Anims = [
			g_GuitMic_win_waving
		]
		Lose_Anims = [
			G_GuitMic_Lose_Depressed
		]
		preset_icon = photo_Eddie
		blurb = qs("Johnny Cash")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = johnnycash_1
			}
			cas_male_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = GTR27_NSFT_Acoustic
			}
			CAS_Guitar_Finish = {
				desc_id = gtr27_nsft_acoustic_d
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_cash_acoustic
			}
			CAS_Guitar_Head = {
				desc_id = gtr27_neckhead_acoustic
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr27_bridge_acoustic
			}
			CAS_Guitar_Knobs = {
				desc_id = guitarnone
			}
			CAS_Guitar_Pickups = {
				desc_id = banjo1
			}
			CAS_Bass_Body = {
				desc_id = bs_sch_t_body
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl02
				chosen_materials = {
					material1 = red_orange_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_mt_ld04
				chosen_materials = {
					material1 = orange_3
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24c
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch_inl_ld42
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_t_nhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass_neckhead_mt
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emg35double
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = schsimple
			}
			CAS_Bass_Knobs = {
				desc_id = knurled
			}
			CAS_Mic = {
				desc_id = mic_cash
			}
			CAS_Mic_Stand = {
				desc_id = micstand_cash
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
		}
	}
	{
		name = GH_Rocker_JohnnyCash_Guitarist
		fullname = qs("\LJohnny Cash's Guitarist")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Johnny Cash's Guitarist")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = `Classic Rock`
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				bones = {
					FaceFullness = 0.0
					JawProminence = 0.0
					JawShape = 1.0
					ChinProminence = 1.0
					ChinWidth = 0.0
					ChinHeight = 0.9
					ChinAngle = 1.0
					ChinCleft = 0.0
					CheekboneProminence = 0.24800001
					CheekboneDepth = 0.0
					EarProminence = 0.025999999
					EarShape = 0.6
					NoseWidth = 0.133
					NoseLength = 1.0
					NoseAngle = 0.3
					NosePosition = 0.0
					NoseTipHeight = 0.167
					NoseTipWidth = 0.167
					MouthAngle = 0.0
					MouthDepth = 0.0
					MouthPosition = 0.167
					LipShapeLower = 1.0
					LipShapeUpper = 1.0
					UpperLipThickness = 0.148
					EyebrowDistance = -1.0
					BrowPosition = 0.0
					EyebrowAngle = 0.5
					BrowDepth = 1.0
					EyebrowSize = 1.0
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique2
			}
			CAS_Eyes = {
				desc_id = eyes_green
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Default_Brow
			}
			CAS_Male_Hair = {
				desc_id = M_Rock_Hair_MidPart
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = none
			}
			CAS_Male_Torso = {
				desc_id = M_Rock_Torso_JCashVest
				chosen_materials = {
					material2 = carblack_1
					material3 = grey_1
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Pop_Legs_Pants
				chosen_materials = {
					material1 = carblack_1
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Clsc_Shoe_Clive3
				chosen_materials = {
					material1 = carblack_1
					material2 = carblack_1
					material3 = carblack_1
				}
			}
			CAS_Guitar_Body = {
				desc_id = GTR27_NSFT_Acoustic
			}
			CAS_Guitar_Finish = {
				desc_id = gtr27_nsft_acoustic_d
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_cash_acoustic
			}
			CAS_Guitar_Head = {
				desc_id = gtr27_neckhead_acoustic
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr27_bridge_acoustic
			}
			CAS_Guitar_Knobs = {
				desc_id = guitarnone
			}
			CAS_Guitar_Pickups = {
				desc_id = banjo1
			}
		}
	}
	{
		name = GH_Rocker_JohnnyCash_Bassist
		fullname = qs("\LJohnny Cash's Bassist")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Johnny Cash's Bassist")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = Rock
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				bones = {
					JawProminence = 1.0
					JawShape = 1.0
					ChinProminence = 1.0
					ChinWidth = 0.0
					ChinCleft = 0.8
					Waddle = 1.0
					EarlobeSize = 0.7
					FaceFullness = 1.0
					HeadSize = -1.0
					ChinAngle = 1.0
					NoseWidth = 1.0
					BrowPosition = 0.0
					EyebrowAngle = 0.29
					EyebrowSize = 1.0
					EyeCornerShape = 0.337
					EyeAngle = 0.6
					EyeDistance = -0.414
					MouthScale = 0.9
					LipShapeLower = 1.0
					LowerLipThickness = 1.0
					NoseAngle = 0.0
					NosePosition = 0.0
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique5
				bones = {
					Height = -1.0
				}
			}
			CAS_Eyes = {
				desc_id = eyes_hazel
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Default_Brow
			}
			CAS_Male_Hair = {
				desc_id = M_Rock_Hair_Eddie3
				chosen_materials = {
					material2 = carblack_1
				}
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = M_Rock_Fhair_Goatee01
			}
			CAS_Male_Torso = {
				desc_id = M_Pop_Torso_Suit
				chosen_materials = {
					material1 = grey_1
					material2 = grey_1
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Pop_Legs_Pants
				chosen_materials = {
					material1 = grey_1
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Rock_Shoe_Dressboot
			}
			CAS_Male_Acc_Left = {
				desc_id = M_Clsc_Acc_L3Rings
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Clsc_Acc_R3Rings
			}
			CAS_Male_Acc_Face = {
				desc_id = none
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Bass_Body = {
				desc_id = bass17_esp_ec_01
			}
			CAS_Bass_Finish = {
				desc_id = Bass17_esp_EC_LD_11
				chosen_materials = {
					material1 = teal_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bass17_esp_ax_dtl_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_22b
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_06
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = Bass14_Neckhead_03
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = Bass9_Neckhead3_LD_02
				chosen_materials = {
					material1 = teal_1
				}
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_030_pga
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type3_Blk_2
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = bass17_bridge_4str_05
			}
			CAS_Bass_Knobs = {
				desc_id = bass17_knob_02
			}
		}
	}
	{
		name = GH_Rocker_JohnnyCash_Drummer
		fullname = qs("\LJohnny Cash's Drummer")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Johnny Cash's Drummer")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = Rock
			CAS_Male_Base_Torso = {
				desc_id = male_full
				chosen_materials = {
					skin = skin_black4
				}
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				chosen_materials = {
					skin = skin_black4
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique4
				bones = {
					Height = -0.9
				}
			}
			CAS_Eyes = {
				desc_id = eyes_violet
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_No_Brow
			}
			CAS_Male_Hair = {
				desc_id = M_Pop_Hair_Pomp
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = none
			}
			CAS_Male_Torso = {
				desc_id = M_Rock_Torso_RolledSlvs
				chosen_materials = {
					material1 = carblack_3
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Punk_Legs_Cuff
			}
			CAS_Male_Shoes = {
				desc_id = M_Spnr_Shoe_Converse01
			}
			CAS_Male_Acc_Left = {
				desc_id = none
			}
			CAS_Male_Acc_Right = {
				desc_id = none
			}
			CAS_Male_Acc_Face = {
				desc_id = none
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Mature
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = drumshell_ds_55
				chosen_materials = {
					material1 = yellow_4guitar
				}
			}
			CAS_Drum_Detail = {
				desc_id = bass_skin_ds_11
				chosen_materials = {
					material1 = yellow_4guitar
				}
			}
		}
	}
	{
		name = GH_Rocker_Santana_Guitarist
		fullname = qs("\LSantana's Guitarist")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Carlos Santana's Guitarist")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = `Classic Rock`
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				chosen_materials = {
					Eyebrows = yellow_orange_4
					skin = skin_latin2
				}
				bones = {
					HeadSize = 1.0
					ChinProminence = 1.0
					ChinAngle = 1.0
					EarShape = 0.167
					EarSize = 0.98599994
					EyebrowSize = 1.0
					JawProminence = 0.6
					CheekboneProminence = 0.0
					CheekboneDepth = 0.4
					BrowDepth = 0.3
					BrowPosition = 0.4
					EyebrowAngle = 0.0
					ChinHeight = 0.2
					MouthPosition = 0.1
					NoseTipAngle = 0.2
					EyeCornerShape = 0.9
					EyeShape = 1.0
					FaceFullness = 0.8
					NoseTipWidth = 0.86700004
					EyeScale = 0.3
					EyeDistance = -0.5
					LipShapeUpper = 0.5
					MouthDepth = 0.5
					MouthAngle = 0.3
					MouthScale = 0.6
					LowerLipThickness = 1.0
					UpperLipThickness = 0.948
					EyeAngle = 0.8
					EyePosition = 0.1
					NoseSize = 0.6
					NoseWidth = 0.4
					NoseAngle = 0.5
					NosePosition = 0.0
					NoseNostrilHeight = 0.93299997
					NoseNostrilSize = 0.7
					ChinWidth = 1.0
					ChinCleft = 0.0
					Waddle = 0.2
					NoseTipHeight = 0.2
					NoseLength = 0.2
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique1
			}
			CAS_Eyes = {
				desc_id = eyes_brown
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Rounded
			}
			CAS_Male_Hair = {
				desc_id = M_Clsc_Hair_Clive4
				chosen_materials = {
					material2 = hairred_3
				}
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = M_Clsc_Fhair_Country
				chosen_materials = {
					material1 = yellow_orange_2
				}
			}
			CAS_Male_Torso = {
				desc_id = M_Clsc_Torso_Santana_D2
			}
			CAS_Male_Legs = {
				desc_id = M_Clsc_Legs_Clive
				chosen_materials = {
					material1 = red_5
					material2 = teal_3
					material3 = teal_4
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Clsc_Shoe_Platform
				chosen_materials = {
					material2 = yellow_orange_3
					material1 = orange_3
				}
			}
			CAS_Male_Acc_Left = {
				desc_id = M_Clsc_Acc_LScarf
				chosen_materials = {
					material1 = orange_2
				}
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Punk_Acc_RRings
			}
			CAS_Male_Acc_Face = {
				desc_id = M_Clsc_Glasses_Avtr
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Old
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Guitar_Body = {
				desc_id = gtr93_dr_siren
			}
			CAS_Guitar_Finish = {
				desc_id = gtr93_DR_Siren_LD04
				chosen_materials = {
					material1 = orange_2
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr94_dr_tomboy_dtl09
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld86_esp_dots
				chosen_materials = {
					material1 = grey_4guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = GTR93_DR_Neckhead01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr93_neckhead01_ld04
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr_bridge_01daisy
			}
			CAS_Guitar_Knobs = {
				desc_id = speedster
			}
			CAS_Guitar_Pickups = {
				desc_id = rockfadbl
			}
		}
	}
	{
		name = GH_Rocker_Santana_Bassist
		fullname = qs("\LSantana's Bassist")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Carlos Santana's Bassist")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = `Glam Rock`
			CAS_Female_Base_Torso = {
				desc_id = female_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Female
				random_weight = 1.75
				CAS_Eyes = {
					desc_id = eyes_blue
				}
				cap = [
					{
						base_tex = `tex/models/Characters/Global/Global_Blank_Head_dnc`
						material = CAR_female_head
						Cas_1
						post_layer = [
							{
								texture = `tex/models/Characters/Layers/CAR/Female/Makeup/CAR_female_EYESHADOW_A01`
								color = carblack_2
							}
						]
					}
				]
				chosen_materials = {
					skin = skin_white1
					Eyebrows = yellow_orange_2
				}
				bones = {
					MouthPosition = 0.2
					EyebrowAngle = 0.49
					EyebrowSize = 0.0
					BrowPosition = 1.0
					EyebrowDistance = 1.0
					JawProminence = 0.6
					JawShape = 0.7
					ChinProminence = 0.0
					LowerLipThickness = 0.79599994
					MouthDepth = 0.0
					FaceFullness = 0.5
					UpperLipThickness = 0.64800006
					NoseBridge = 0.1
					EyeCornerShape = 1.0
					EyeShape = 0.5
					EarSize = 1.0
					EarShape = 0.56700003
					EarTip = 0.0
					NosePosition = 0.72199994
					NoseAngle = 0.7
					BrowDepth = 0.0
					EyeDistance = -0.4
					NoseTipWidth = 1.0
					NoseSize = 0.5
					NoseTipLength = 0.0
					NoseTipHeight = 0.4
					NoseWidth = 0.133
					NoseLength = 0.6
					EyeScale = 0.414
					EyeAngle = 0.3
					EyePosition = 1.0
				}
			}
			cas_female_physique = {
				desc_id = FemalePhysique4
			}
			CAS_Eyes = {
				desc_id = eyes_brown
			}
			CAS_Female_Eyebrows = {
				desc_id = CAR_Rounded_Brow
			}
			CAS_Female_Hair = {
				desc_id = F_Rock_Hair_Wavy
				chosen_materials = {
					material1 = carblack_1
				}
			}
			CAS_Female_Hat = {
				desc_id = none
			}
			CAS_Female_Facial_Hair = {
				desc_id = none
			}
			CAS_Female_Torso = {
				desc_id = F_Glam_Torso_LaceBraTop
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Female_Legs = {
				desc_id = F_Clsc_Legs_Skrt
				chosen_materials = {
					material1 = yellow_orange_3
				}
			}
			CAS_Female_Shoes = {
				desc_id = f_mtl_shoes_flameb
				chosen_materials = {
					material1 = grey_5
				}
			}
			CAS_Female_Acc_Left = {
				desc_id = f_glam_l_acc_baggyclobber
			}
			CAS_Female_Acc_Right = {
				desc_id = none
			}
			CAS_Female_Acc_Face = {
				desc_id = none
			}
			CAS_Female_Acc_Ears = {
				desc_id = none
			}
			CAS_Female_Age = {
				desc_id = CAR_Female_Teen
			}
			CAS_Female_Teeth = {
				desc_id = CAR_Female_teeth
			}
			CAS_Bass_Body = {
				desc_id = bass_schect_030
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_bod04_ld01
				chosen_materials = {
					material1 = red_1
				}
			}
			cas_bass_body_fade = {
				desc_id = BS_Sch_Bod04_DTL20
				chosen_materials = {
					material1 = teal_1
				}
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_21d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = BS_Sch22_INL_LD30
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bs_sch_030_nhead01
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass_neckhead_030
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_030_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emgj
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = bs_sch_brdg_a
			}
			CAS_Bass_Knobs = {
				desc_id = knurled
				chosen_materials = {
					material1 = teal_1
				}
			}
		}
	}
	{
		name = GH_Rocker_Santana_Drummer
		fullname = qs("\LSantana's Drummer")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Carlos Santana's Drummer")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = `Heavy Metal`
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				random_weight = 1.0
				cas_male_physique = {
					desc_id = MalePhysique1
				}
				CAS_Eyes = {
					desc_id = eyes_brown
				}
				CAS_Male_Eyebrows = {
					desc_id = CAR_Default_Brow
				}
				chosen_materials = {
					skin = skin_black3
				}
				cap = [
					{
						base_tex = `tex/models/Characters/Global/Global_Blank_Head_dnc`
						material = CAR_Male_Head
						Cas_1
						post_layer = [
							{
								texture = `tex/models/Characters/CAR/CAR_Shared_None2`
								flags = 4
							}
						]
					}
					{
						base_tex = `tex\models\Characters\CAR\female\CAR_female_ARMR_tat_O_dnc`
						material = CAR_male_ArmR
						Cas_1
						layers = [
							{
								texture = `tex/models/Characters/Skater_Male/Decals/CAG_graphics076`
								color = grey_3guitar
								a = 100
								x_trans = 10
								y_trans = -22
								x_scale = 45
								y_scale = 40
								flags = 3
								x_skew = 0
							}
						]
					}
				]
				bones = {
					ChinHeight = 0.1
					ChinCleft = 1.0
					NoseNostrilAngle = 0.7
					NoseAngle = 0.267
					MouthScale = 0.367
					EyebrowDistance = -0.256
					EyebrowAngle = 0.98999995
					CheekboneProminence = 0.148
					CheekboneDepth = 0.5
					BrowDepth = 0.4
					HeadSize = 0.5
					FaceFullness = 1.0
					JawProminence = 1.0
					ChinWidth = 0.3
					ChinProminence = 0.2
					JawShape = 0.0
					NoseLength = 0.3
					NoseSize = 0.4
					UpperLipThickness = 0.9
					MouthDepth = 0.0
					MouthAngle = 0.3
					MouthPosition = 0.5
					LipShapeLower = 0.6
					LipShapeUpper = 1.0
					NosePosition = 0.0
					EyeScale = 0.414
					EyeDistance = -0.8
					EyeShape = 1.0
					NoseWidth = 0.8
					NoseBridge = 0.6
					LowerLipThickness = 0.0
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique7
				bones = {
					Height = -1.0
				}
			}
			CAS_Eyes = {
				desc_id = eyes_brown
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_No_Brow
			}
			CAS_Male_Hair = {
				desc_id = M_Bmtl_Hair_Lars_3
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Male_Hat_Hair = {
				desc_id = M_Bmtl_HatHair_Lars_3
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Male_Hat = {
				desc_id = M_Hat_Pimp
				chosen_materials = {
					material1 = yellow_orange_2
					material2 = grey_4
				}
			}
			CAS_Male_Facial_Hair = {
				desc_id = M_Metl_Fhair_Zzbeard
			}
			CAS_Male_Torso = {
				desc_id = M_Torso_TasselVest
				chosen_materials = {
					material1 = grey_4
					material2 = grey_5
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Metl_Legs_Zippertight
				chosen_materials = {
					material1 = grey_4
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Flipflops
			}
			CAS_Male_Acc_Left = {
				desc_id = M_Punk_Acc_LMetalskull
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Punk_Acc_RChain
			}
			CAS_Male_Acc_Face = {
				desc_id = M_Pop_Glasses_Riot
			}
			CAS_Male_Acc_Ears = {
				desc_id = M_Punk_Acc_Ring_02
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Old
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld36
			}
			CAS_Drum_Detail = {
				desc_id = GH5_Skin_LD95
			}
		}
	}
	{
		name = GH_Rocker_ShirleyManson_Guitarist
		fullname = qs("\LShirley Manson's Guitarist")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Shirley Manson's Guitarist")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = `Heavy Metal`
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				random_weight = 3.0
				bones = {
					JawProminence = 0.0
					JawShape = 0.0
					ChinProminence = 1.0
					CheekboneProminence = 0.348
					CheekboneDepth = 0.7
					FaceFullness = 0.7
					NoseWidth = 0.0
					NoseTipWidth = 1.0
					NoseNostrilAngle = 0.6
					NoseNostrilHeight = 0.4
					NoseNostrilSize = 0.7
					NoseAngle = 0.66700006
					NoseTipHeight = 1.0
					MouthScale = 0.167
					LipShapeUpper = 0.883
					UpperLipThickness = 0.64800006
					LowerLipThickness = 1.0
					NoseLength = 0.767
					MouthDepth = 0.8
					MouthPosition = 0.1
					NoseSize = 0.5
					NosePosition = 0.122
					EyeDistance = -0.514
					EyeAngle = 0.5
					EyeCornerShape = 0.0
					EyeScale = 0.614
					EyePosition = 1.0
					EyebrowDistance = -0.056
					BrowPosition = 0.0
					EyebrowAngle = 0.29
					EyebrowSize = 0.2
				}
				chosen_materials = {
					skin = skin_white4
				}
				cas_male_physique = {
					desc_id = MalePhysique1
				}
				CAS_Eyes = {
					desc_id = eyes_deepblue
				}
				CAS_Male_Eyebrows = {
					desc_id = CAR_Default_Brow
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique1
			}
			CAS_Eyes = {
				desc_id = eyes_deepblue
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Default_Brow
			}
			CAS_Male_Hair = {
				desc_id = M_Clsc_Hair_Clive2
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = none
			}
			CAS_Male_Torso = {
				desc_id = M_Pop_Torso_OpenShirt
				chosen_materials = {
					material1 = carblack_1
					material2 = grey_1
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Pop_Legs_Slacks
				chosen_materials = {
					material1 = grey_1
					material2 = carblack_3
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Metl_Shoes_TallPlain
			}
			CAS_Male_Acc_Left = {
				desc_id = none
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Metl_Acc_RStuds
			}
			CAS_Male_Acc_Face = {
				desc_id = M_Pop_Glasses_Riot
				chosen_materials = {
					material1 = carblack_1
				}
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Guitar_Body = {
				desc_id = GTR2_ESP_Truckster_02
			}
			CAS_Guitar_Finish = {
				desc_id = gtr4_esp_eclipse_d_01_color
				chosen_materials = {
					material1 = red_2
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr4_esp_eclipse_dtl_03
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld86_esp_dots
				chosen_materials = {
					material1 = grey_4guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr62_neckhead01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = red_4
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = esp_none
			}
			cas_guitar_head_fade = {
				desc_id = gtr4_neckhead_dtl_03
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = GTR4_ESP_Bridge_02
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr4_esp_knob_10_03
			}
			CAS_Guitar_Pickups = {
				desc_id = GTR1_ESP_EMG_Pkup_2
			}
		}
	}
	{
		name = GH_Rocker_ShirleyManson_Bassist
		fullname = qs("\LShirley Manson's Bassist")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Shirley Manson's Bassist")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = `Heavy Metal`
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				random_weight = 3.0
				cas_male_physique = {
					desc_id = MalePhysique1
				}
				CAS_Eyes = {
					desc_id = eyes_deepblue
				}
				CAS_Male_Eyebrows = {
					desc_id = CAR_Default_Brow
				}
				chosen_materials = {
					skin = skin_asian4
				}
				bones = {
					JawShape = 0.0
					CheekboneDepth = 0.7
					NoseNostrilAngle = 0.6
					NoseNostrilSize = 0.7
					NoseLength = 0.767
					EyeScale = 0.614
					EyebrowAngle = 0.29
					EyebrowSize = 0.2
					HeadSize = -0.2
					FaceFullness = 0.4
					JawProminence = 0.3
					ChinProminence = 0.4
					ChinWidth = 0.471
					CheekboneProminence = 0.148
					NoseWidth = 0.0
					NoseAngle = 0.66700006
					NosePosition = 0.3
					NoseTipHeight = 0.3
					NoseTipWidth = 0.6
					NoseNostrilHeight = 1.0
					NoseTipAngle = 0.3
					NoseTipLength = 0.5
					NoseSize = 0.6
					MouthScale = 0.367
					MouthAngle = 0.0
					MouthDepth = 0.4
					MouthPosition = 0.3
					LipShapeUpper = 0.4
					LipShapeLower = 0.0
					UpperLipThickness = 1.0
					LowerLipThickness = 0.7
					EyeShape = 0.405
					EyeCornerShape = 0.1
					EyeAngle = 0.6
					EyePosition = 0.8
					EyeDistance = -0.614
					BrowPosition = 0.2
					EyebrowDistance = 0.344
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique4
				bones = {
					Height = 0.5
				}
			}
			CAS_Eyes = {
				desc_id = eyes_brown
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Rounded
			}
			CAS_Male_Hair = {
				desc_id = M_Pop_Hair_Buzz
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = M_Rock_Fhair_Stub
			}
			CAS_Male_Torso = {
				desc_id = M_Pop_Torso_Leather
				chosen_materials = {
					material1 = carblack_1
					material2 = blue_4
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Pop_Legs_Jeans
				chosen_materials = {
					material1 = grey_1
					material2 = carblack_1
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Glam_Shoes_mart
			}
			CAS_Male_Acc_Left = {
				desc_id = none
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Metl_Acc_RStuds
			}
			CAS_Male_Acc_Face = {
				desc_id = M_Clsc_Glasses_WtNose
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Mature
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Bass_Body = {
				desc_id = bass17_esp_ec_01
			}
			CAS_Bass_Finish = {
				desc_id = Bass17_esp_EC_LD_11
				chosen_materials = {
					material1 = orange_2
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bass17_esp_ax_dtl_13
			}
			cas_bass_body_fade = {
				desc_id = bass17_esp_ax_dtl_05
				chosen_materials = {
					material1 = orange_2
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_22b
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_06
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = Bass14_Neckhead_03
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = Bass9_Pkup_Type1_Blk_02
			}
			CAS_Bass_Bridges = {
				desc_id = Bass17_Bridge_4str_04
			}
			CAS_Bass_Knobs = {
				desc_id = Bass17_ESP_Knob_10
			}
		}
	}
	{
		name = GH_Rocker_ShirleyManson_Drummer
		fullname = qs("\LShirley Manson's Drummer")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Shirley Manson's Drummer")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = Pop
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				random_weight = 3.0
			}
			cas_male_physique = {
				desc_id = MalePhysique2
				bones = {
					Height = 0.3
				}
			}
			CAS_Eyes = {
				desc_id = eyes_hazel
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Rounded
			}
			CAS_Male_Hair = {
				desc_id = M_Pop_Hair_Emo1
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = M_Rock_Fhair_Goatee03
			}
			CAS_Male_Torso = {
				desc_id = M_Rock_Torso_Tie
				chosen_materials = {
					material2 = grey_1
					material3 = red_2
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Pop_Legs_Pants
				chosen_materials = {
					material1 = grey_1
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Spnr_Shoe_ConverseCS
				chosen_materials = {
					material1 = carblack_1
					material2 = grey_1
					material3 = red_2
				}
			}
			CAS_Male_Acc_Left = {
				desc_id = none
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Pop_Acc_RGlove
			}
			CAS_Male_Acc_Face = {
				desc_id = M_Pop_Glasses_Riot
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld52
				chosen_materials = {
					material1 = orange_1
				}
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld28
				chosen_materials = {
					material1 = red_orange_1
				}
			}
		}
	}
	{
		name = GH_Rocker_KurtCobain_Guitarist
		fullname = qs("\LKurt Cobain's Guitarist")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Kurt Cobain's Guitarist")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = Rock
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				bones = {
					NoseNostrilAngle = 0.0
					NoseBridge = 0.5
					NoseTipWidth = 0.467
					NoseTipHeight = 1.0
					NoseLength = 0.4
					NosePosition = 0.6
					NoseAngle = 0.1
					NoseTipLength = 0.9
					NoseTipAngle = 0.0
					NoseNostrilSize = 0.9
					EyebrowSize = 1.0
					BrowDepth = 0.1
					EyebrowDistance = -0.956
					EyebrowAngle = 0.8
					LipShapeLower = 0.111
					LipShapeUpper = 0.083
					MouthDepth = 0.433
					MouthAngle = 0.467
					MouthPosition = 1.0
					UpperLipThickness = 0.5
					LowerLipThickness = 0.39600003
					HeadSize = 0.0
					JawProminence = 0.0
					JawShape = 1.0
					ChinHeight = 1.0
					ChinAngle = 1.0
					ChinProminence = 0.6
					FaceFullness = 0.5
					EarlobeSize = 0.1
					EarlobeLength = 1.0
					EarShape = 0.067
					ChinCleft = 1.0
					Waddle = 0.7
					ChinWidth = 0.0
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique1
			}
			CAS_Eyes = {
				desc_id = eyes_brown
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Rounded
			}
			CAS_Male_Hair = {
				desc_id = M_Glam_Hair_Izzy2
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = none
			}
			CAS_Male_Torso = {
				desc_id = M_Torso_TShirt
			}
			CAS_Male_Legs = {
				desc_id = M_Rock_Legs_RipJeans
			}
			CAS_Male_Shoes = {
				desc_id = M_Spnr_Shoe_Converse04
			}
			CAS_Male_Acc_Left = {
				desc_id = M_Rock_Acc_LWatch
			}
			CAS_Male_Acc_Right = {
				desc_id = none
			}
			CAS_Male_Acc_Face = {
				desc_id = none
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Mature
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Guitar_Body = {
				desc_id = gtr33_boris
			}
			CAS_Guitar_Finish = {
				desc_id = gtr33_kh2_wood_d_color
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_LD102_ESP_Logo
				chosen_materials = {
					material1 = teal_1
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr33_nekhed_01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr4_neckhead_d_06
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr33_bridge_fr
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr_33_knobs_a
			}
			CAS_Guitar_Pickups = {
				desc_id = GTR30_EMG
			}
		}
	}
	{
		name = GH_Rocker_KurtCobain_Bassist
		fullname = qs("\LKurt Cobain's Bassist")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Kurt Cobain's Bassist")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = `Glam Rock`
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				chosen_materials = {
					Eyebrows = carblack_1
					skin = skin_white4
					Nails = carblack_1
				}
				bones = {
					EyeDistance = -1.0
					EyePosition = -1.0
					EyeCornerShape = 0.0
					EyeShape = 1.0
					MouthScale = 0.0
					MouthAngle = 0.4
					LipShapeLower = 1.0
					UpperLipThickness = 0.4
					LipShapeUpper = 0.8
					NoseSize = 0.0
					NoseWidth = 0.733
					NoseTipHeight = 1.0
					NoseTipWidth = 0.86700004
					NoseNostrilHeight = 1.0
					NoseNostrilSize = 1.0
					NoseTipAngle = 1.0
					NoseAngle = 0.8
					NosePosition = 0.5
					NoseLength = 0.5
					ChinWidth = 0.271
					EarShape = 0.267
					Waddle = 1.0
					ChinAngle = 0.4
					ChinCleft = 0.5
					ChinHeight = 0.0
					ChinProminence = 0.0
					JawShape = 0.7
					EyeScale = 0.6
					EyeAngle = 0.9
					EyebrowSize = 1.0
					EyebrowAngle = 0.3
					BrowDepth = 1.0
					BrowPosition = 0.0
					EyebrowDistance = -0.556
					HeadSize = 0.6
					FaceFullness = 0.9
					JawProminence = 0.0
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique1
			}
			CAS_Eyes = {
				desc_id = eyes_brown
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Default_Brow
			}
			CAS_Male_Hair = {
				desc_id = M_Pop_Hair_Emo1
				chosen_materials = {
					material1 = carblack_1
				}
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = none
			}
			CAS_Male_Torso = {
				desc_id = M_Torso_Layered
				chosen_materials = {
					material2 = grey_5
					material1 = yellow_green_1
				}
			}
			CAS_Male_Legs = {
				desc_id = m_mtl_legs_axel01
			}
			CAS_Male_Shoes = {
				desc_id = M_Spnr_Shoe_VansH_Skull
			}
			CAS_Male_Acc_Left = {
				desc_id = none
			}
			CAS_Male_Acc_Right = {
				desc_id = none
			}
			CAS_Male_Acc_Face = {
				desc_id = none
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Mature
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Bass_Body = {
				desc_id = bass15_mcswain_machine
			}
			CAS_Bass_Finish = {
				desc_id = bass15_mcswain_machine_ld2
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_21a
			}
			CAS_Bass_Neck_Finish = {
				desc_id = 22fret_ld06_mcswn_bolts
			}
			CAS_Bass_Head = {
				desc_id = bass15_neckhead_mcswain1
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass15_nkhd_mcswain_ld2
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_esp
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = basslines1b
			}
			CAS_Bass_Bridges = {
				desc_id = mcswainbullet
			}
			CAS_Bass_Knobs = {
				desc_id = chromedomes
			}
		}
	}
	{
		name = GH_Rocker_KurtCobain_Drummer
		fullname = qs("\LKurt Cobain's Drummer")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Kurt Cobain's Drummer")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = Punk
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				bones = {
					FaceFullness = 0.4
					ChinHeight = 0.2
					Waddle = 0.0
					CheekboneDepth = 0.6
					CheekboneProminence = 0.0
					ChinCleft = 0.6
					ChinWidth = 0.6
					ChinProminence = 1.0
					JawShape = 1.0
					JawProminence = 1.0
					EarProminence = 0.1
					EarSize = 0.3
					EarlobeSize = 0.8
					EyeScale = 0.9
					EyeShape = 0.6
					EyeCornerShape = 0.337
					EyeAngle = 0.661
					EyePosition = -0.63
					MouthAngle = 1.0
					MouthDepth = 0.833
					MouthPosition = 0.4
					MouthScale = 0.66700006
					EyebrowSize = 0.72499996
					BrowPosition = 1.0
					EyebrowDistance = -0.856
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique1
			}
			CAS_Eyes = {
				desc_id = eyes_hazel
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Default_Brow
			}
			CAS_Male_Hair = {
				desc_id = m_bmtl_hair_lars
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = M_Rock_Fhair_Goatee03
			}
			CAS_Male_Torso = {
				desc_id = none
			}
			CAS_Male_Legs = {
				desc_id = M_Rock_Legs_Jeans
				chosen_materials = {
					material1 = carblack_3
					material2 = red_2
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Spnr_Shoe_VansH_BW
				chosen_materials = {
					material1 = red_3
				}
			}
			CAS_Male_Acc_Left = {
				desc_id = M_Punk_AccL_Jny_2
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Rock_Acc_RStrap
			}
			CAS_Male_Acc_Face = {
				desc_id = none
			}
			CAS_Male_Acc_Ears = {
				desc_id = M_Punk_Acc_Ring_02
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld16
				chosen_materials = {
					material1 = blue_1
				}
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld09
				chosen_materials = {
					material1 = navy_3
				}
			}
		}
	}
	{
		name = GH_Rocker_MattBellamy_Guitarist
		fullname = qs("\LMatt Bellamy's Guitarist")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Matt Bellamy's Guitarist")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = Rock
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				random_weight = 1.0
				cas_male_physique = {
					desc_id = MalePhysique1
				}
				CAS_Eyes = {
					desc_id = eyes_brown
				}
				CAS_Male_Eyebrows = {
					desc_id = CAR_Default_Brow
				}
				CAS_Male_Hair = {
					desc_id = none
				}
				chosen_materials = {
					skin = skin_asian4
					Eyebrows = grey_2
				}
				bones = {
					JawProminence = 0.0
					JawShape = 0.0
					ChinProminence = 1.0
					ChinWidth = 1.0
					ChinHeight = 0.5
					ChinAngle = 1.0
					ChinCleft = 1.0
					Waddle = 0.3
					NoseSize = 0.1
					NoseWidth = 0.4
					NoseLength = 0.9
					NoseNostrilSize = 1.0
					LipShapeUpper = 0.783
					LowerLipThickness = 0.8
					UpperLipThickness = 1.0
					MouthScale = 0.0
					MouthPosition = 0.9
					EyeCornerShape = 1.0
					EyebrowSize = 0.0
					EyebrowDistance = -0.8
					EyebrowAngle = 1.0
					CheekboneProminence = 0.24800001
					CheekboneDepth = 0.4
					FaceFullness = 0.5
					EyeAngle = 0.5
					NoseBridge = 0.3
					NoseAngle = 0.0
					EyePosition = -1.0
					EyeScale = 0.7
					EyeDistance = -0.5
					NosePosition = 0.4
					HeadSize = -1.0
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique3
				bones = {
					Height = 1.0
				}
			}
			CAS_Eyes = {
				desc_id = eyes_blue
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Rounded
			}
			CAS_Male_Hair = {
				desc_id = M_Glam_Hair_Izzy2
				chosen_materials = {
					material1 = yellow_orange_5
				}
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = none
			}
			CAS_Male_Torso = {
				desc_id = M_Rock_Torso_JCashVest
				chosen_materials = {
					material3 = red_3
					material1 = grey_5
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Metl_Legs_TooSkinny
				chosen_materials = {
					material1 = grey_5
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Goth_Shoes_Spats
				chosen_materials = {
					material1 = red_4
					material2 = carblack_3
				}
			}
			CAS_Male_Acc_Left = {
				desc_id = M_Punk_Acc_LLeather
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Punk_Acc_RBands
			}
			CAS_Male_Acc_Face = {
				desc_id = none
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Guitar_Body = {
				desc_id = gtr33_boris
			}
			CAS_Guitar_Finish = {
				desc_id = gtr33_kh2_wood_d_color
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_LD102_ESP_Logo
				chosen_materials = {
					material1 = teal_1
				}
			}
			CAS_Guitar_Head = {
				desc_id = gtr33_nekhed_01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr4_neckhead_d_06
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr33_bridge_fr
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr_33_knobs_a
			}
			CAS_Guitar_Pickups = {
				desc_id = GTR30_EMG
			}
		}
	}
	{
		name = GH_Rocker_MattBellamy_Bassist
		fullname = qs("\LMatt Bellamy's Bassist")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Matt Bellamy's Bassist")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = Pop
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				random_weight = 1.0
				cas_male_physique = {
					desc_id = MalePhysique1
				}
				CAS_Eyes = {
					desc_id = eyes_brown
				}
				CAS_Male_Eyebrows = {
					desc_id = CAR_Default_Brow
				}
				CAS_Male_Hair = {
					desc_id = none
				}
				chosen_materials = {
					skin = skin_black4
					Nails = carblack_1
				}
				bones = {
					FaceFullness = 0.4
					JawProminence = 0.7
					JawShape = 0.0
					ChinAngle = 0.8
					LowerLipThickness = 1.0
					NoseWidth = 0.7
					NoseSize = 0.4
					NoseTipWidth = 1.0
					EyeScale = 0.514
					EyeDistance = -0.8
					EyeAngle = 0.7
					EyeCornerShape = 0.137
					EyeShape = 0.0
					EyebrowDistance = -0.756
					EyebrowAngle = 0.9
					EyebrowSize = 0.0
					BrowDepth = 0.6
					MouthScale = 0.467
					UpperLipThickness = 1.0
					LipShapeLower = 0.6
					LipShapeUpper = 0.4
					BrowPosition = 1.0
					NosePosition = 0.0
					MouthDepth = 0.0
					MouthPosition = 0.7
					NoseBridge = 0.5
					ChinCleft = 1.0
					ChinProminence = 0.5
					ChinHeight = 0.5
					ChinWidth = 0.5
					NoseLength = 0.5
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique1
			}
			CAS_Eyes = {
				desc_id = eyes_brown
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Default_Brow
			}
			CAS_Male_Hair = {
				desc_id = M_Pop_Hair_Emo1
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = none
			}
			CAS_Male_Torso = {
				desc_id = M_Clsc_Torso_confed
				chosen_materials = {
					material1 = red_3
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Pop_Legs_Pants
				chosen_materials = {
					material1 = grey_1
				}
			}
			CAS_Male_Shoes = {
				desc_id = m_mtl_shoes_axel01
				chosen_materials = {
					material2 = red_3
					material1 = grey_5
					material3 = red_3
				}
			}
			CAS_Male_Acc_Left = {
				desc_id = none
			}
			CAS_Male_Acc_Right = {
				desc_id = none
			}
			CAS_Male_Acc_Face = {
				desc_id = none
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Bass_Body = {
				desc_id = bass15_mcswain_machine
			}
			CAS_Bass_Finish = {
				desc_id = bass15_mcswain_machine_ld2
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_21a
			}
			CAS_Bass_Neck_Finish = {
				desc_id = 22fret_ld06_mcswn_bolts
			}
			CAS_Bass_Head = {
				desc_id = bass15_neckhead_mcswain1
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass15_nkhd_mcswain_ld2
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_esp
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = basslines1b
			}
			CAS_Bass_Bridges = {
				desc_id = mcswainbullet
			}
			CAS_Bass_Knobs = {
				desc_id = chromedomes
			}
		}
	}
	{
		name = GH_Rocker_MattBellamy_Drummer
		fullname = qs("\LMatt Bellamy's Drummer")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("Matt Bellamy's Drummer")
		no_random_pick
		selection_not_allowed
		appearance = {
			genre = `Heavy Metal`
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				random_weight = 1.0
				cas_male_physique = {
					desc_id = MalePhysique1
				}
				CAS_Eyes = {
					desc_id = eyes_brown
				}
				CAS_Male_Eyebrows = {
					desc_id = CAR_Default_Brow
				}
				chosen_materials = {
					skin = skin_white3
				}
				bones = {
					FaceFullness = 0.0
					JawShape = 0.0
					JawProminence = 0.3
					MouthPosition = 0.0
					ChinWidth = 1.0
					ChinCleft = 1.0
					NoseAngle = 0.5
					NoseTipWidth = 0.66700006
					NoseTipAngle = 0.1
					NoseNostrilSize = 0.2
					NoseNostrilHeight = 0.5
					NoseNostrilAngle = 1.0
					NoseWidth = 0.7
					EyeScale = 0.4
					EyePosition = -0.6
					EyeAngle = 0.6
					EyeCornerShape = 0.0
					EyeShape = 0.105000004
					EyeDistance = -1.0
					LowerLipThickness = 1.0
					MouthDepth = 0.0
					NosePosition = 0.4
					NoseLength = 0.2
					EyebrowAngle = 1.0
					EyebrowDistance = -0.8
					BrowPosition = 0.0
					LipShapeUpper = 0.0
					UpperLipThickness = 0.5
					EarProminence = 0.42600003
					EarSize = 0.0
				}
			}
			cas_male_physique = {
				desc_id = MalePhysique4
			}
			CAS_Eyes = {
				desc_id = eyes_brown
			}
			CAS_Male_Eyebrows = {
				desc_id = CAR_Default_Brow
			}
			CAS_Male_Hair = {
				desc_id = M_Metl_Hair_Lars
				chosen_materials = {
					material1 = carblack_1
				}
			}
			CAS_Male_Hat = {
				desc_id = none
			}
			CAS_Male_Facial_Hair = {
				desc_id = none
			}
			CAS_Male_Torso = {
				desc_id = M_Punk_Torso_Beater
			}
			CAS_Male_Legs = {
				desc_id = M_Punk_Legs_Cutoff
				chosen_materials = {
					material1 = red_3
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Metl_Shoes_DirtyHightops
			}
			CAS_Male_Acc_Left = {
				desc_id = none
			}
			CAS_Male_Acc_Right = {
				desc_id = none
			}
			CAS_Male_Acc_Face = {
				desc_id = none
			}
			CAS_Male_Acc_Ears = {
				desc_id = none
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Mature
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld16
				chosen_materials = {
					material1 = blue_1
				}
			}
			CAS_Drum_Detail = {
				desc_id = gh5_skin_ld09
				chosen_materials = {
					material1 = navy_3
				}
			}
		}
	}
	{
		name = RandomAppearance0
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		selection_not_allowed
		random_appearance_lookup
		appearance = {
		}
	}
	{
		name = RandomAppearance1
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		selection_not_allowed
		random_appearance_lookup
		appearance = {
		}
	}
	{
		name = RandomAppearance2
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		selection_not_allowed
		random_appearance_lookup
		appearance = {
		}
	}
	{
		name = RandomAppearance3
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		selection_not_allowed
		random_appearance_lookup
		appearance = {
		}
	}
	{
		name = EmptyGuy
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		selection_not_allowed
		appearance = {
			CAS_Body = {
				desc_id = NoBody
			}
			CAS_Bass_Highway = {
				desc_id = AxelHighway
			}
			CAS_Guitar_Highway = {
				desc_id = AxelHighway
			}
			CAS_Drums_Highway = {
				desc_id = AxelHighway
			}
			CAS_Female_Win_Anim = {
				desc_id = Win_Hype
			}
			CAS_Female_Lose_Anim = {
				desc_id = Lose_AngryAtCrowd
			}
			CAS_Female_Intro_Anim = {
				desc_id = Intro_Hype
			}
		}
	}
]
