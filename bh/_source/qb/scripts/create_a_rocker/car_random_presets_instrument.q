CAS_Unlockable_Presets = [
	{
		desc_id = MetallicaBlackPBass
	}
	{
		desc_id = Truckster_Black
	}
]
ESP_JH_Black_Truckster = {
	genre = [
		Rock
		Punk
		`Classic Rock`
		Goth
		`Black Metal`
		`Heavy Metal`
		`Glam Rock`
		Pop
	]
	Preset_Name = qs(0x4047e65e)
	Is_Metallica = 1
	CAS_Guitar_Body = {
		desc_id = GTR31_Horizon
	}
	CAS_Guitar_Finish = {
		desc_id = GTR33_flamed
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
}
CAS_Preset_Metallica_Guitars = [
	{
		desc_id = GTR2_ESP_Truckster_02
		$ESP_JH_Black_Truckster
	}
]
MetallicaBlackPBass = {
	genre = [
		Rock
		Punk
		`Classic Rock`
		Goth
		`Black Metal`
		`Heavy Metal`
		`Glam Rock`
		Pop
	]
	Preset_Name = qs(0x4047e65e)
	Is_Metallica = 1
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
}
CAS_Preset_Metallica_Basses = [
	{
		desc_id = Bass16_ESP_Surveyor_02
		$MetallicaBlackPBass
	}
]
cas_preset_guitars = [
	{
		CAS_Guitar_Body = {
			desc_id = GTR9_ESP_AX
		}
		CAS_Guitar_Finish = {
			desc_id = gtr9_esp_eclipse_LD_16
			chosen_materials = {
				material1 = navy_3
			}
		}
		CAS_Guitar_Body_Detail = {
			desc_id = none_esp
		}
		cas_guitar_body_fade = {
			desc_id = fade_none
		}
		CAS_Guitar_Neck = {
			desc_id = GTR_24fret_Fretboard_02
		}
		CAS_Guitar_Head = {
			desc_id = gtr62_neckhead04
		}
		CAS_Guitar_Head_Finish = {
			desc_id = espcolor
			chosen_materials = {
				material1 = navy_1
			}
		}
		CAS_Guitar_Head_Detail = {
			desc_id = esp_none
		}
		cas_guitar_head_fade = {
			desc_id = head_fade_none
		}
		CAS_Guitar_Pickguards = {
			desc_id = none
		}
		CAS_Guitar_Bridges = {
			desc_id = GTR9_ESP_Bridge_03
		}
		CAS_Guitar_Knobs = {
			desc_id = GTR9_Knob_02
			chosen_materials = {
				material1 = red_3
			}
		}
		CAS_Guitar_Pickups = {
			desc_id = GTR1_ESP_EMG_Pkup_2
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Guitar_Body = {
			desc_id = GTR62b_ESP_Jack
		}
		CAS_Guitar_Finish = {
			desc_id = GTR62_ESP_Alexi_LD_10_color
			chosen_materials = {
				material1 = grey_5guitar
			}
		}
		CAS_Guitar_Body_Detail = {
			desc_id = none_esp
		}
		cas_guitar_body_fade = {
			desc_id = fade_none
		}
		CAS_Guitar_Neck = {
			desc_id = GTR_24fret_Fretboard_02
		}
		CAS_Guitar_Head = {
			desc_id = gtr62_neckhead03
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
			desc_id = head_fade_none
		}
		CAS_Guitar_Pickguards = {
			desc_id = none
		}
		CAS_Guitar_Bridges = {
			desc_id = GTR_Hardware62a
		}
		CAS_Guitar_Knobs = {
			desc_id = GTR62_Knob_Type01
		}
		CAS_Guitar_Pickups = {
			desc_id = GTR1_ESP_EMG_Pkup_2
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Guitar_Body = {
			desc_id = GTR2_ESP_Truckster_02
		}
		CAS_Guitar_Finish = {
			desc_id = gtr9_esp_eclipse_LD_11
			chosen_materials = {
				material1 = green_2
			}
		}
		CAS_Guitar_Body_Detail = {
			desc_id = none_esp
		}
		cas_guitar_body_fade = {
			desc_id = fade_none
		}
		CAS_Guitar_Neck = {
			desc_id = GTR_22fret_Fretboard_04
		}
		CAS_Guitar_Head = {
			desc_id = gtr12_neckhead_01
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
			desc_id = head_fade_none
		}
		CAS_Guitar_Pickguards = {
			desc_id = GTR5_Pickguard_01
		}
		CAS_Guitar_Bridges = {
			desc_id = GTR4_ESP_Bridge_02
			chosen_materials = {
				material1 = grey_2guitar
			}
		}
		CAS_Guitar_Knobs = {
			desc_id = GTR4_Knob_02
		}
		CAS_Guitar_Pickups = {
			desc_id = GTR3_ESP_EMG_Pkup_2
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Guitar_Body = {
			desc_id = GTR63c_ESP_EX
		}
		CAS_Guitar_Finish = {
			desc_id = GTR63F_ESP_EX_LD_12
			chosen_materials = {
				material1 = purple_blue_3
			}
		}
		CAS_Guitar_Body_Detail = {
			desc_id = none_esp
		}
		cas_guitar_body_fade = {
			desc_id = fade_none
		}
		CAS_Guitar_Neck = {
			desc_id = GTR_22fret_Fretboard_01
		}
		CAS_Guitar_Head = {
			desc_id = gtr12_neckhead_01
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
			desc_id = head_fade_none
		}
		CAS_Guitar_Pickguards = {
			desc_id = GTR63e_ESP_PG1
		}
		CAS_Guitar_Pickguard_Finish = {
			desc_id = custom_color
			chosen_materials = {
				material1 = grey_4guitar
			}
		}
		CAS_Guitar_Bridges = {
			desc_id = GTR_Hardware63
		}
		CAS_Guitar_Knobs = {
			desc_id = GTR63_Knob_Type5
		}
		CAS_Guitar_Pickups = {
			desc_id = GTR3_ESP_EMG_Pkup_2
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Guitar_Body = {
			desc_id = gtr64_esp_F
		}
		CAS_Guitar_Finish = {
			desc_id = GTR64_ESP_F_LD_04_color
			chosen_materials = {
				material1 = Black_1guitar
			}
		}
		CAS_Guitar_Body_Detail = {
			desc_id = none_esp
		}
		cas_guitar_body_fade = {
			desc_id = fade_none
		}
		CAS_Guitar_Neck = {
			desc_id = GTR_24fret_Fretboard_03
		}
		CAS_Guitar_Head = {
			desc_id = gtr64_neckhead02
		}
		CAS_Guitar_Head_Finish = {
			desc_id = GTR9_Neckhead_D_01
		}
		CAS_Guitar_Head_Detail = {
			desc_id = esp_none
		}
		cas_guitar_head_fade = {
			desc_id = head_fade_none
		}
		CAS_Guitar_Pickguards = {
			desc_id = gtr64_esp_PG2
		}
		CAS_Guitar_Pickguard_Finish = {
			desc_id = custom_color
			chosen_materials = {
				material1 = grey_3guitar
			}
		}
		CAS_Guitar_Bridges = {
			desc_id = GTR_Hardware63
		}
		CAS_Guitar_Knobs = {
			desc_id = GTR64_Knob_Type3
		}
		CAS_Guitar_Pickups = {
			desc_id = GTR3_ESP_EMG_Pkup_2
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Guitar_Body = {
			desc_id = gtr30_h101
		}
		CAS_Guitar_Finish = {
			desc_id = gtr30_ld15
		}
		CAS_Guitar_Body_Detail = {
			desc_id = none_esp
		}
		cas_guitar_body_fade = {
			desc_id = fade_none
		}
		CAS_Guitar_Neck = {
			desc_id = GTR_24fret_Fretboard_03
		}
		CAS_Guitar_Head = {
			desc_id = gtr30_nekhed_e
		}
		CAS_Guitar_Head_Finish = {
			desc_id = GTR4_Neckhead_06_LD_11
		}
		CAS_Guitar_Head_Detail = {
			desc_id = esp_none
		}
		cas_guitar_head_fade = {
			desc_id = head_fade_none
		}
		CAS_Guitar_Pickguards = {
			desc_id = none
		}
		CAS_Guitar_Bridges = {
			desc_id = GTR30_Bridge_D
		}
		CAS_Guitar_Knobs = {
			desc_id = gtr_30_knobs_d
		}
		CAS_Guitar_Pickups = {
			desc_id = gtr30_pickup_gold
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Guitar_Body = {
			desc_id = gtr30_h101
		}
		CAS_Guitar_Finish = {
			desc_id = GTR30_H101_D_color
			chosen_materials = {
				material1 = purple_blue_1
			}
		}
		CAS_Guitar_Body_Detail = {
			desc_id = none_esp
		}
		cas_guitar_body_fade = {
			desc_id = fade_none
		}
		CAS_Guitar_Neck = {
			desc_id = GTR_24fret_Fretboard_01
		}
		CAS_Guitar_Head = {
			desc_id = gtr30_neckhead_b
		}
		CAS_Guitar_Head_Finish = {
			desc_id = espcolor
			chosen_materials = {
				material1 = purple_blue_1
			}
		}
		CAS_Guitar_Head_Detail = {
			desc_id = esp_none
		}
		cas_guitar_head_fade = {
			desc_id = head_fade_none
		}
		CAS_Guitar_Pickguards = {
			desc_id = none
		}
		CAS_Guitar_Bridges = {
			desc_id = GTR30_Brdg_StrgThru
		}
		CAS_Guitar_Knobs = {
			desc_id = gtr_30_knobs_c
		}
		CAS_Guitar_Pickups = {
			desc_id = GTR30_EMG
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Guitar_Body = {
			desc_id = GTR31_Horizon
		}
		CAS_Guitar_Finish = {
			desc_id = GTR33_flamed
		}
		CAS_Guitar_Body_Detail = {
			desc_id = none_esp
		}
		cas_guitar_body_fade = {
			desc_id = fade_none
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
			desc_id = esp_none
		}
		cas_guitar_head_fade = {
			desc_id = head_fade_none
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
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
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
		CAS_Guitar_Body_Detail = {
			desc_id = gh5_none
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
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Guitar_Body = {
			desc_id = gtr70_sch_ultra
		}
		CAS_Guitar_Finish = {
			desc_id = gtr70_sch_ultra_ld08
		}
		cas_guitar_body_fade = {
			desc_id = fade_none
		}
		CAS_Guitar_Body_Detail = {
			desc_id = gh5_none
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
			desc_id = gtr70_neckhead_04
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
			desc_id = gtr74_neckhead_01_dtl04
			chosen_materials = {
				material1 = red_2
			}
		}
		CAS_Guitar_Pickguards = {
			desc_id = none
		}
		CAS_Guitar_Bridges = {
			desc_id = gtr70_bridge
		}
		CAS_Guitar_Knobs = {
			desc_id = chromedomes
			chosen_materials = {
				material1 = Black_1guitar
			}
		}
		CAS_Guitar_Pickups = {
			desc_id = duncanbodbl
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Guitar_Body = {
			desc_id = gtr90_dr_daisy
		}
		CAS_Guitar_Finish = {
			desc_id = gtr90_dr_daisy_ld02
			chosen_materials = {
				material1 = red_2
			}
		}
		cas_guitar_body_fade = {
			desc_id = gtr90_dr_daisy_dtl04
			chosen_materials = {
				material1 = red_orange_2
			}
		}
		CAS_Guitar_Body_Detail = {
			desc_id = gtr90_dr_daisy_dtl07
			chosen_materials = {
				material1 = grey_5guitar
			}
		}
		CAS_Guitar_Neck = {
			desc_id = GTR_22fret_Fretboard_04
		}
		CAS_Guitar_Neck_Finish = {
			desc_id = 22fret_ld86_esp_dots
			chosen_materials = {
				material1 = grey_4guitar
			}
		}
		CAS_Guitar_Head = {
			desc_id = gtr90_dr_neckhead01
		}
		CAS_Guitar_Head_Finish = {
			desc_id = espcolor
			chosen_materials = {
				material1 = red_2
			}
		}
		CAS_Guitar_Head_Detail = {
			desc_id = esp_none
		}
		cas_guitar_head_fade = {
			desc_id = gtr90_neckhead01_dtl04
			chosen_materials = {
				material1 = red_orange_2
			}
		}
		CAS_Guitar_Pickguards = {
			desc_id = gtr90_pg
		}
		CAS_Guitar_Pickguard_Finish = {
			desc_id = custom_color_esp
			chosen_materials = {
				material1 = grey_4guitar
			}
		}
		CAS_Guitar_Bridges = {
			desc_id = gtr_bridge_mcswain_l_4daisy
		}
		CAS_Guitar_Knobs = {
			desc_id = chromedomes
			chosen_materials = {
				material1 = grey_4guitar
			}
		}
		CAS_Guitar_Pickups = {
			desc_id = lipstick
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Guitar_Body = {
			desc_id = gtr81_prs_miramt
		}
		CAS_Guitar_Finish = {
			desc_id = gtr81_prs_mt_ld03
			chosen_materials = {
				material1 = purple_blue_1
			}
		}
		cas_guitar_body_fade = {
			desc_id = gtr81_prs_mt_dtl04
			chosen_materials = {
				material1 = navy_1
			}
		}
		CAS_Guitar_Body_Detail = {
			desc_id = gh5_none
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
			desc_id = gtr81_neckhead01
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
			desc_id = gtr78_neckhead_dtl04
			chosen_materials = {
				material1 = purple_blue_1
			}
		}
		CAS_Guitar_Pickguards = {
			desc_id = gtr81_pguard
		}
		CAS_Guitar_Pickguard_Finish = {
			desc_id = custom_color_esp
			chosen_materials = {
				material1 = grey_4guitar
			}
		}
		CAS_Guitar_Bridges = {
			desc_id = gtr78_straightbridge
		}
		CAS_Guitar_Knobs = {
			desc_id = chromedomes
			chosen_materials = {
				material1 = Black_1guitar
			}
		}
		CAS_Guitar_Pickups = {
			desc_id = duncanbodbl
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
]
cas_preset_basses = [
	{
		CAS_Bass_Body = {
			desc_id = Bass16_ESP_Surveyor_02
		}
		CAS_Bass_Finish = {
			desc_id = Bass14_esp_AX_LD_11
			chosen_materials = {
				material1 = green_2guitar
			}
		}
		CAS_Bass_Body_Detail = {
			desc_id = none_esp
		}
		cas_bass_body_fade = {
			desc_id = fade_none
		}
		CAS_Bass_Neck = {
			desc_id = Bass_Fretboard_22a
		}
		CAS_Bass_Neck_Finish = {
			desc_id = Bass_Fretboard_Inlay_02
			chosen_materials = {
				material1 = grey_3guitar
			}
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
		cas_bass_head_fade = {
			desc_id = bass_head_fade_none
		}
		CAS_Bass_Pickguards = {
			desc_id = none
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Bass_Body = {
			desc_id = Bass63_EX
		}
		CAS_Bass_Finish = {
			desc_id = Bass63_Ex_LD_16
			chosen_materials = {
				material1 = red_2
			}
		}
		CAS_Bass_Body_Detail = {
			desc_id = none_esp
		}
		cas_bass_body_fade = {
			desc_id = fade_none
		}
		CAS_Bass_Neck = {
			desc_id = Bass_Fretboard_24d
		}
		CAS_Bass_Head = {
			desc_id = Bass63_Neckhead
		}
		CAS_Bass_Head_Finish = {
			desc_id = Bass63_Neckhead_LD_11
			chosen_materials = {
				material1 = yellow_orange_2
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
			chosen_materials = {
				material1 = grey_2guitar
			}
		}
		CAS_Bass_Bridges = {
			desc_id = bass_bridges_03
		}
		CAS_Bass_Knobs = {
			desc_id = Bass63_Knob_Type4
			chosen_materials = {
				material1 = red_2
			}
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Bass_Body = {
			desc_id = Bass16_ESP_Surveyor_02
		}
		CAS_Bass_Finish = {
			desc_id = Bass14_ESP_Surveyor_D_color
			chosen_materials = {
				material1 = grey_5guitar
			}
		}
		CAS_Bass_Body_Detail = {
			desc_id = none_esp
		}
		cas_bass_body_fade = {
			desc_id = bass14_esp_ax_dtl_05
			chosen_materials = {
				material1 = Black_1guitar
			}
		}
		CAS_Bass_Neck = {
			desc_id = Bass_Fretboard_24d
		}
		CAS_Bass_Neck_Finish = {
			desc_id = Bass_Fretboard_24_inlay_05
		}
		CAS_Bass_Head = {
			desc_id = Bass14_Neckhead_04
		}
		CAS_Bass_Head_Finish = {
			desc_id = esp_solidcolor
			chosen_materials = {
				material1 = grey_5guitar
			}
		}
		CAS_Bass_Head_Detail = {
			desc_id = none_esp
		}
		cas_bass_head_fade = {
			desc_id = bass9_neckhead4_dtl_05
			chosen_materials = {
				material1 = Black_1guitar
			}
		}
		CAS_Bass_Pickguards = {
			desc_id = none
		}
		CAS_Bass_Pickups = {
			desc_id = Bass9_Pkup_Type3_Blk_2
		}
		CAS_Bass_Bridges = {
			desc_id = Bass14_Bridge_4str_01
		}
		CAS_Bass_Knobs = {
			desc_id = Bass14_ESP_Knob_10_04
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
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
			desc_id = none_esp
		}
		cas_bass_body_fade = {
			desc_id = bass9_esp_ax_dtl_04
			chosen_materials = {
				material1 = grey_2guitar
			}
		}
		CAS_Bass_Neck = {
			desc_id = Bass_Fretboard_22b
		}
		CAS_Bass_Neck_Finish = {
			desc_id = Bass_Fretboard_Inlay_03
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
			chosen_materials = {
				material1 = grey_2guitar
			}
		}
		CAS_Bass_Bridges = {
			desc_id = Bass9_Bridge_4str_01
		}
		CAS_Bass_Knobs = {
			desc_id = Bass9_Knob_03
			chosen_materials = {
				material1 = grey_3guitar
			}
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Bass_Body = {
			desc_id = bass17_esp_ec_01
		}
		CAS_Bass_Finish = {
			desc_id = Bass17_esp_EC_LD_16
		}
		CAS_Bass_Body_Detail = {
			desc_id = none_esp
		}
		cas_bass_body_fade = {
			desc_id = fade_none
		}
		CAS_Bass_Neck = {
			desc_id = Bass_Fretboard_24c
		}
		CAS_Bass_Neck_Finish = {
			desc_id = Bass_Fretboard_Inlay_03
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
		cas_bass_head_fade = {
			desc_id = bass_head_fade_none
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
			desc_id = Bass17_knob_05
			chosen_materials = {
				material1 = grey_3guitar
			}
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Bass_Body = {
			desc_id = bass17_esp_ec_01
		}
		CAS_Bass_Finish = {
			desc_id = Bass17_esp_EC_LD_color
			chosen_materials = {
				material1 = blue_1
			}
		}
		CAS_Bass_Body_Detail = {
			desc_id = none_esp
		}
		cas_bass_body_fade = {
			desc_id = fade_none
		}
		CAS_Bass_Neck = {
			desc_id = Bass_Fretboard_24black
		}
		CAS_Bass_Neck_Finish = {
			desc_id = Bass_Fretboard_Inlay_05
		}
		CAS_Bass_Head = {
			desc_id = Bass14_Neckhead_02
		}
		CAS_Bass_Head_Finish = {
			desc_id = esp_solidcolor
			chosen_materials = {
				material1 = purple_blue_1
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
			desc_id = Bass9_Pkup_Type3_Blk_2
			chosen_materials = {
				material1 = grey_2guitar
			}
		}
		CAS_Bass_Bridges = {
			desc_id = Bass17_Bridge_4str_04
		}
		CAS_Bass_Knobs = {
			desc_id = Bass17_knob_03
			chosen_materials = {
				material1 = grey_3guitar
			}
		}
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
		CAS_Bass_Body = {
			desc_id = bass17_esp_ec_01
		}
		CAS_Bass_Finish = {
			desc_id = Bass17_esp_EC_LD_12
			chosen_materials = {
				material1 = yellow_1
			}
		}
		CAS_Bass_Body_Detail = {
			desc_id = none_esp
		}
		cas_bass_body_fade = {
			desc_id = fade_none
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
		cas_bass_head_fade = {
			desc_id = bass_head_fade_none
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
		cas_guitar_logo = {
			desc_id = none
		}
	}
	{
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
			desc_id = bass_head_fade_none
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
	{
		CAS_Bass_Body = {
			desc_id = bas_ibz_sr505
		}
		CAS_Bass_Finish = {
			desc_id = bs_ibz_sr_ld01
		}
		CAS_Bass_Body_Detail = {
			desc_id = bs_ibz_sr_dtl02
		}
		cas_bass_body_fade = {
			desc_id = bass17_esp_ax_dtl_05
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
			desc_id = bas_ibz_sr_head01
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
			desc_id = bs_ibz_sr_hd_dtl04
			chosen_materials = {
				material1 = orange_2
			}
		}
		CAS_Bass_Pickguards = {
			desc_id = none
		}
		CAS_Bass_Pickups = {
			desc_id = ibz_type1
		}
		CAS_Bass_Bridges = {
			desc_id = ibztrad
		}
		CAS_Bass_Knobs = {
			desc_id = chromedomes
		}
	}
	{
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
	}
	{
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
	}
]
cas_preset_drums = [
	{
		CAS_Drums = {
			desc_id = singlebasskit
		}
		CAS_Drum_Finish = {
			desc_id = gh5_shell_ld19
			chosen_materials = {
				material1 = red_1
			}
		}
		CAS_Drum_Detail = {
			desc_id = gh5_skin_ld63
			chosen_materials = {
				material1 = red_1
			}
		}
		cas_drums_sticks_l = {
			desc_id = drm_stick_l
		}
		cas_drums_sticks_r = {
			desc_id = drm_stick_r
		}
	}
	{
		CAS_Drums = {
			desc_id = singlebasskit
		}
		CAS_Drum_Finish = {
			desc_id = gh5_shell_ld39
			chosen_materials = {
				material1 = red_1
			}
		}
		CAS_Drum_Detail = {
			desc_id = gh5_skin_ld63
		}
		cas_drums_sticks_l = {
			desc_id = drm_stick_l
		}
		cas_drums_sticks_r = {
			desc_id = drm_stick_r
		}
	}
	{
		CAS_Drums = {
			desc_id = singlebasskit
		}
		CAS_Drum_Finish = {
			desc_id = gh5_shell_ld36
		}
		CAS_Drum_Detail = {
			desc_id = gh5_skin_ld92
		}
		cas_drums_sticks_l = {
			desc_id = drm_stick_l
		}
		cas_drums_sticks_r = {
			desc_id = drm_stick_r
		}
	}
	{
		CAS_Drums = {
			desc_id = singlebasskit
		}
		CAS_Drum_Finish = {
			desc_id = gh5_shell_ld42
		}
		CAS_Drum_Detail = {
			desc_id = gh5_skin_ld102
		}
		cas_drums_sticks_l = {
			desc_id = drm_stick_l
		}
		cas_drums_sticks_r = {
			desc_id = drm_stick_r
		}
	}
	{
		CAS_Drums = {
			desc_id = singlebasskit
		}
		CAS_Drum_Finish = {
			desc_id = gh5_shell_ld34
		}
		CAS_Drum_Detail = {
			desc_id = gh5_skin_ld21b
		}
		cas_drums_sticks_l = {
			desc_id = drm_stick_l
		}
		cas_drums_sticks_r = {
			desc_id = drm_stick_r
		}
	}
	{
		CAS_Drums = {
			desc_id = singlebasskit
		}
		CAS_Drum_Finish = {
			desc_id = gh5_shell_ld17
		}
		CAS_Drum_Detail = {
			desc_id = gh5_skin_ld15
		}
		cas_drums_sticks_l = {
			desc_id = drm_stick_l
		}
		cas_drums_sticks_r = {
			desc_id = drm_stick_r
		}
	}
	{
		CAS_Drums = {
			desc_id = singlebasskit
		}
		CAS_Drum_Finish = {
			desc_id = gh5_shell_ld16
		}
		CAS_Drum_Detail = {
			desc_id = gh5_skin_ld41
		}
		cas_drums_sticks_l = {
			desc_id = drm_stick_l
		}
		cas_drums_sticks_r = {
			desc_id = drm_stick_r
		}
	}
]
cas_preset_female_vocals = [
	{
		CAS_Mic = {
			desc_id = mic_standard
		}
		CAS_Mic_Stand = {
			desc_id = mic_stand_female
		}
	}
]
cas_preset_male_vocals = [
	{
		CAS_Mic = {
			desc_id = mic_standard
		}
		CAS_Mic_Stand = {
			desc_id = mic_stand_female
		}
	}
]
