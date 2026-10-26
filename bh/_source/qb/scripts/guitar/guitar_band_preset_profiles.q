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
}
Preset_Musician_Profiles_Modifiable = [
	{
		name = Quinton
		fullname = qs("\LQuincy Styles")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_izzy
		blurb = qs("Quincy is a legend in his hometown - an Urban Legend; a poet, musician, innovator.  On any given day he might be mixing it up with metal bands, rocking out with a string quartet, or easy jammin' with cool jazz fools - no two days are ever the same.")
		ghrocker
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = quinton_1
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr86_mm_axis
			}
			CAS_Guitar_Finish = {
				desc_id = gtr86_mm_axis_ld02
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr86_mm_axis_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_22fret_Fretboard_04
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = gtr84_mminlaypet22
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = gt86_neckhead_01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr86_neckhead_dtl02
				chosen_materials = {
					material1 = red_1
				}
			}
			cas_guitar_head_fade = {
				desc_id = head_fade_none
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr75_bridgeb
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = chromedomes_daisy2
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = zebradbl
			}
			CAS_Guitar_Misc = {
				desc_id = misc_switch
			}
			CAS_Bass_Body = {
				desc_id = Bass16_ESP_Surveyor_02
			}
			CAS_Bass_Finish = {
				desc_id = Bass14_esp_AX_LD_11
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bass14_esp_ax_dtl_02
				chosen_materials = {
					material1 = red_1
				}
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_22d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_02
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = Bass14_Neckhead_04
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = bass9_neckhead4_dtl_02
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
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass14_Bridge_4str_01
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Bass_Knobs = {
				desc_id = Bass14_ESP_Knob_10_04
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_pop
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			CAS_Drum_Detail = {
				desc_id = none
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Drum_Finish = {
				desc_id = none
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
		blurb = qs("An intricate blend of southern-flavored boogie and California pop suffuses the elegant brew that is Casey Lynch's masterpiece recording of 2009.  Casey breathes new life into the L.A. scene with fresh guitar stylings and breathy Texan vocals.")
		ghrocker
		appearance = {
			genre = `Heavy Metal`
			CAS_Full_Body = {
				desc_id = Casey_5
			}
			cas_physique = {
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
		}
	}
	{
		name = Midori
		fullname = qs("\LMidori")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_casey
		blurb = qs(0xeca9888e)
		ghrocker
		appearance = {
			genre = `Heavy Metal`
			CAS_Full_Body = {
				desc_id = Midori_4
			}
			cas_physique = {
				desc_id = FemalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr86_mm_axis
			}
			CAS_Guitar_Finish = {
				desc_id = gtr86_mm_axis_ld02
				chosen_materials = {
					material1 = green_3guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr86_mm_axis_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = gtr84_mminlaypet22
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Head = {
				desc_id = gt86_neckhead_01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = green_3guitar
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr86_neckhead_dtl02
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
				desc_id = gtr75_bridgeb
			}
			CAS_Guitar_Knobs = {
				desc_id = chromedomes_daisy2
			}
			CAS_Guitar_Pickups = {
				desc_id = emg81dbl
			}
			CAS_Guitar_Misc = {
				desc_id = misc_switch
			}
			CAS_Bass_Body = {
				desc_id = bas_sch_stil
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_stil_dtl01
				chosen_materials = {
					material1 = green_3guitar
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bs_sch_stil_ld02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_body_fade = {
				desc_id = bs_sch_stil_ld05
				chosen_materials = {
					material1 = green_1guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_24
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch_inl_ld40
				chosen_materials = {
					material1 = green_1guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = bas_neckhead_sch_stl
			}
			CAS_Bass_Head_Finish = {
				desc_id = gh5_solidcolor
				chosen_materials = {
					material1 = green_3guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = bs_sch_stl_hd_dtl01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_head_fade = {
				desc_id = bs_sch_stl_hd_dtl03
				chosen_materials = {
					material1 = green_1guitar
				}
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = basslines1b
			}
			CAS_Bass_Bridges = {
				desc_id = schbb104
			}
			CAS_Bass_Knobs = {
				desc_id = chromedomes
			}
			CAS_Mic = {
				desc_id = mic_sixties
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_blackmetal
			}
			CAS_Drums = {
				desc_id = singlebasskit
			}
			CAS_Drum_Detail = {
				desc_id = none
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld53
				chosen_materials = {
					material1 = green_3guitar
				}
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
		name = Clive
		fullname = qs("\LClive Winston")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		preset_icon = photo_Clive
		blurb = qs("Clive's famous moustache took a trimming when record sales slumped in the late 1990s.  A change of moustache brought new legions of fans-Winston was able to keep his homes in Bermuda, Florida, and Nova Scotia.")
		ghrocker
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = Clive_5
			}
			cas_physique = {
				desc_id = MalePhysique
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
		blurb = qs("As a child, Pandora owned a Victorian dollhouse.  Recently, she had a full scale replica built.  It has wind and smoke machines installed along with permanent moonlight streaming through the cobwebbed windows.")
		ghrocker
		appearance = {
			genre = Goth
			CAS_Full_Body = {
				desc_id = Pandora_5
			}
			cas_physique = {
				desc_id = FemalePhysique
				bones = {
					Physique = 0.0
				}
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
		blurb = qs("Eddie was lined up to play Fort Knox as the jewel in his touring crown, but cancelled last minute.  Instead, he played a charity event for poor sick orphans.  You see, he has a heart of gold...")
		ghrocker
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = Eddie_5
			}
			cas_physique = {
				desc_id = MalePhysique
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
		}
	}
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
		blurb = qs(0x08b07aae)
		ghrocker
		appearance = {
			genre = `Classic Rock`
			CAS_Full_Body = {
				desc_id = Axel_5
			}
			cas_physique = {
				desc_id = MalePhysique
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
		blurb = qs("Following the success of her album 'I Know Everything Ever', her new album 'You Can't Tell Me' features tracks: 'You're not the Boss of Me', 'Yes I am Going out Like This', and 'But Why?'.")
		ghrocker
		appearance = {
			genre = `Heavy Metal`
			CAS_Full_Body = {
				desc_id = Judy_5
			}
			cas_physique = {
				desc_id = FemalePhysique
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
				desc_id = gh5_skin_ld21
				chosen_materials = {
					material1 = red_3
				}
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld48
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
		blurb = qs(0xfe77434d)
		ghrocker
		appearance = {
			genre = Classic
			CAS_Full_Body = {
				desc_id = Izzy_5
			}
			cas_physique = {
				desc_id = MalePhysique
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
		blurb = qs("Johnny is as tough as old boots, as hard as nails, and strikes fear into the hearts of all who behold him.  But he loves tiny, fluffy, cute kittens with sad eyes.")
		ghrocker
		appearance = {
			genre = Punk
			CAS_Full_Body = {
				desc_id = Johnny_5
			}
			cas_physique = {
				desc_id = MalePhysique
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
		blurb = qs(0x5bf8e7de)
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
		name = Roblobster
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
		name = Ice
		fullname = qs(0x1f286295)
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		locked
		preset_icon = photo_casey
		blurb = qs(0x8f53b4f6)
		ghrocker
		appearance = {
			genre = Pop
			CAS_Full_Body = {
				desc_id = Ice
			}
			cas_physique = {
				desc_id = FemalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr1_sch_tempest
			}
			CAS_Guitar_Finish = {
				desc_id = gtr1_sch_tempest_body_ld2
				chosen_materials = {
					material1 = teal_5
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_body_fade = {
				desc_id = gtr1_sch_tempest_dtl_4
				chosen_materials = {
					material1 = teal_2
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = none
			}
			CAS_Guitar_Head = {
				desc_id = gtr1_sch_neckhead_1
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = teal_5
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_head_fade = {
				desc_id = gtr1_sch_neckhead_dtl_3
				chosen_materials = {
					material1 = teal_1
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr1_sch_pickguard_01
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr12_bridge_3
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = capit
			}
			CAS_Guitar_Pickups = {
				desc_id = fg101trpl
			}
			CAS_Bass_Body = {
				desc_id = bas_ibz_sr505
			}
			CAS_Bass_Finish = {
				desc_id = bs_ibz_sr_ld00
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = bs_ibz_sr_dtl01
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
				desc_id = neck_inlay_fl_blank
			}
			CAS_Bass_Head = {
				desc_id = bas_ibz_sr_head01
			}
			CAS_Bass_Head_Finish = {
				desc_id = gh5_solidcolor
				chosen_materials = {
					material1 = red_3
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = bs_ibz_sr_hd_dtl01
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
				desc_id = basslines2
			}
			CAS_Bass_Bridges = {
				desc_id = capsule
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
				desc_id = gh5_skin_ld90
				chosen_materials = {
					material1 = teal_3
				}
			}
			CAS_Drum_Finish = {
				desc_id = drumshell_ds_20
				chosen_materials = {
					material1 = blue_2
				}
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
		name = Hilda
		fullname = qs(0xb0cf676d)
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		locked
		preset_icon = photo_casey
		blurb = qs(0x508dc47d)
		ghrocker
		appearance = {
			genre = Pop
			CAS_Full_Body = {
				desc_id = Hilda
			}
			cas_physique = {
				desc_id = FemalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr82_prs_se1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr78_prs_sc_ld02
				chosen_materials = {
					material1 = violet_1
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_body_fade = {
				desc_id = gtr78_prs_sc_dtl05
				chosen_materials = {
					material1 = violet_3
				}
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = none
			}
			CAS_Guitar_Head = {
				desc_id = gtr80_neckhead_01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = violet_1
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gh5_none
			}
			cas_guitar_head_fade = {
				desc_id = gtr80_neckhead_dtl03
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr78_straightbridge
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = dice
			}
			CAS_Guitar_Pickups = {
				desc_id = chrmhum
			}
			CAS_Bass_Body = {
				desc_id = Bass16_ESP_Surveyor_02
			}
			CAS_Bass_Finish = {
				desc_id = bass14_esp_surveyor_d
			}
			CAS_Bass_Body_Detail = {
				desc_id = none_esp
			}
			cas_bass_body_fade = {
				desc_id = bass14_esp_ax_dtl_05
				chosen_materials = {
					material1 = green_3guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_22d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_02
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Bass_Head = {
				desc_id = Bass14_Neckhead_04
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = green_3guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = bass9_neckhead4_dtl_02
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
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass14_Bridge_4str_01
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Knobs = {
				desc_id = Bass14_ESP_Knob_10_04
				chosen_materials = {
					material1 = Black_1guitar
				}
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
				desc_id = gh5_skin_ld93
				chosen_materials = {
					material1 = yellow_1guitar
				}
			}
			CAS_Drum_Finish = {
				desc_id = gh5_shell_ld17
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
		name = Flaminga
		fullname = qs(0xb5f0972a)
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		locked
		preset_icon = photo_Pandora
		blurb = qs(0x7772795f)
		ghrocker
		appearance = {
			genre = Goth
			CAS_Full_Body = {
				desc_id = Flaminga
			}
			cas_physique = {
				desc_id = FemalePhysique
				bones = {
					Physique = 0.0
				}
			}
			CAS_Guitar_Body = {
				desc_id = gtr93_dr_siren
			}
			CAS_Guitar_Finish = {
				desc_id = gtr93_dr_siren_ld06
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr93_dr_siren_dtl01
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_22fret_Fretboard_01
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = none
			}
			CAS_Guitar_Head = {
				desc_id = gtr93_dr_neckhead02
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr90_neckhead01_ld02
				chosen_materials = {
					material1 = violet_1
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr90_neckhead01_dtl01
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
				desc_id = gtr94_bridge
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = capit_daisy1
			}
			CAS_Guitar_Pickups = {
				desc_id = hz
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
					material1 = violet_4
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
				desc_id = gh5_skin_ld68
			}
			CAS_Drum_Finish = {
				desc_id = popshell_09
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
		name = boombox
		fullname = qs(0x625b12a5)
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		locked
		preset_icon = photo_axel
		blurb = qs(0xf3183df9)
		ghrocker
		appearance = {
			genre = Pop
			CAS_Full_Body = {
				desc_id = boombox
			}
			cas_physique = {
				desc_id = MalePhysique
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
		}
	}
	{
		name = vbot
		fullname = qs("\LElectrika Steel")
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		locked
		preset_icon = photo_Pandora
		blurb = qs("Electrika Steel")
		ghrocker
		limited
		appearance = {
			genre = Pop
			CAS_Full_Body = {
				desc_id = vbot
			}
			cas_physique = {
				desc_id = FemalePhysique
				bones = {
					Physique = 0.0
				}
			}
			CAS_Guitar_Body = {
				desc_id = gtr93_dr_siren
			}
			CAS_Guitar_Finish = {
				desc_id = gtr93_dr_siren_ld06
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr93_dr_siren_dtl01
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_22fret_Fretboard_01
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = none
			}
			CAS_Guitar_Head = {
				desc_id = gtr93_dr_neckhead02
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr90_neckhead01_ld02
				chosen_materials = {
					material1 = violet_1
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr90_neckhead01_dtl01
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
				desc_id = gtr94_bridge
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Knobs = {
				desc_id = capit_daisy1
			}
			CAS_Guitar_Pickups = {
				desc_id = hz
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
					material1 = violet_4
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
				desc_id = gh5_skin_ld68
			}
			CAS_Drum_Finish = {
				desc_id = popshell_09
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
		}
	}
]
Preset_Musician_Profiles_Locked = [
	{
		name = GH_Rocker_AdamLevine
		fullname = qs("\LAdam Levine")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs(0xdae30c0a)
		no_random_pick
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = adamlevine
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr81_prs_miramt
			}
			CAS_Guitar_Finish = {
				desc_id = gtr81_prs_mt_ld01
				chosen_materials = {
					material1 = teal_5
				}
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gh5_none
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_02
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld81_prs_dots
			}
			CAS_Guitar_Head = {
				desc_id = gtr81_neckhead01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = teal_5
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = esp_none
			}
			cas_guitar_head_fade = {
				desc_id = head_fade_none
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr81_pguard
			}
			CAS_Guitar_Pickguard_Finish = {
				desc_id = custom_color_esp
				chosen_materials = {
					material1 = grey_5
				}
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr78_bridge01
			}
			CAS_Guitar_Knobs = {
				desc_id = lampshade
			}
			CAS_Guitar_Pickups = {
				desc_id = duncanbodbl
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body = {
				desc_id = bass_schect_030
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl01
				chosen_materials = {
					material1 = navy_4
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_22c
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch22_inl_ld47
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
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emgj
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
				desc_id = drumshell_ds_46
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Drum_Detail = {
				desc_id = GH5_Skin_LD57
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_AdamLevine_CareerOnly
		fullname = qs("\LAdam Levine")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		Win_Anims = [
			s_jeff_win_waving
		]
		Lose_Anims = [
			s_jeff_lose_walkoff
		]
		preset_icon = photo_Eddie
		blurb = qs(0xdae30c0a)
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = adamlevine
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr81_prs_miramt
			}
			CAS_Guitar_Finish = {
				desc_id = gtr81_prs_mt_ld01
				chosen_materials = {
					material1 = teal_5
				}
			}
			cas_guitar_body_fade = {
				desc_id = fade_none
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gh5_none
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_02
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld81_prs_dots
			}
			CAS_Guitar_Head = {
				desc_id = gtr81_neckhead01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = teal_5
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = esp_none
			}
			cas_guitar_head_fade = {
				desc_id = head_fade_none
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr81_pguard
			}
			CAS_Guitar_Pickguard_Finish = {
				desc_id = custom_color_esp
				chosen_materials = {
					material1 = grey_5
				}
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr78_bridge01
			}
			CAS_Guitar_Knobs = {
				desc_id = lampshade
			}
			CAS_Guitar_Pickups = {
				desc_id = duncanbodbl
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body = {
				desc_id = bass_schect_030
			}
			CAS_Bass_Finish = {
				desc_id = bs_sch_mt_dtl01
				chosen_materials = {
					material1 = navy_4
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_22c
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bs_sch22_inl_ld47
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
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bs_sch_t_pga
			}
			CAS_Bass_Pickups = {
				desc_id = emgj
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
				desc_id = drumshell_ds_46
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Drum_Detail = {
				desc_id = GH5_Skin_LD57
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_TaylorSwift
		fullname = qs("\LTaylor Swift")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Taylor Swift.")
		no_random_pick
		locked
		limited
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = TaylorSwift
			}
			cas_physique = {
				desc_id = FemalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr142_g6e_body
			}
			CAS_Guitar_Finish = {
				desc_id = gtr142_dtl010
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr142_bind001
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_22fret_Fretboard_04
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22_fret_Taylor_dots
			}
			CAS_Guitar_Head = {
				desc_id = GTR142_neckhead
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr142_nkhead_dtl009
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
				desc_id = gtr142_g6e_bridg
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr142_knob001
			}
			CAS_Guitar_Pickups = {
				desc_id = banjo1
			}
			CAS_Bass_Body = {
				desc_id = bass17_esp_ec_01
			}
			CAS_Bass_Finish = {
				desc_id = bass17_esp_ax_d
				chosen_materials = {
					material1 = yellow_4guitar
				}
			}
			CAS_Bass_Body_Detail = {
				desc_id = none_esp
			}
			cas_bass_body_fade = {
				desc_id = bass17_esp_ax_dtl_04
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_05
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
					material1 = yellow_4guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = none_gh5
			}
			cas_bass_head_fade = {
				desc_id = bass9_neckhead3_dtl_04
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Pickguards = {
				desc_id = none
			}
			CAS_Bass_Pickups = {
				desc_id = emgj
				chosen_materials = {
					material1 = grey_2guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass17_Bridge_4str_04
			}
			CAS_Bass_Knobs = {
				desc_id = Bass17_ESP_Knob_10
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
				desc_id = GH5_Skin_LD42
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_TaylorSwift2
		fullname = qs("\LTaylor Swift2")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Taylor Swift2.")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = TaylorSwift2
			}
			cas_physique = {
				desc_id = FemalePhysique
			}
			$preset_musician_instrument_hack
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_TaylorSwift3
		fullname = qs("\LTaylor Swift3")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Taylor Swift3.")
		intro_anims = [
			G_Taylor_Win_Waving
		]
		Win_Anims = [
			G_Taylor_Win_Waving
		]
		Lose_Anims = [
			G_Taylor_Lose_Depressed
		]
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = TaylorSwift3
			}
			cas_physique = {
				desc_id = FemalePhysique
			}
			$preset_musician_instrument_hack
			CAS_Guitar_Body = {
				desc_id = gtr142_g6e_body
			}
			CAS_Guitar_Finish = {
				desc_id = gtr142_g6e_body
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr142_bind001
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_22fret_Fretboard_04
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22_fret_Taylor_dots
			}
			CAS_Guitar_Head = {
				desc_id = GTR142_neckhead
			}
			CAS_Guitar_Head_Finish = {
				desc_id = gtr142_nkhead_dtl009
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
				desc_id = gtr142_g6e_bridg
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr142_knob001
			}
			CAS_Guitar_Pickups = {
				desc_id = banjo1
			}
			CAS_Mic = {
				desc_id = mic_cash
			}
			CAS_Mic_Stand = {
				desc_id = micstand_cash
			}
		}
	}
	{
		name = GH_Rocker_GwenStefani
		fullname = qs("\LGwen Stefani")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Gwen Stefani.")
		no_random_pick
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = GwenStefani
			}
			cas_physique = {
				desc_id = FemalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr33_boris
			}
			CAS_Guitar_Finish = {
				desc_id = gtr33_kh2_wood_d_color
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = none_esp
			}
			CAS_Guitar_Neck = {
				desc_id = GTR_24fret_Fretboard_01
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 24fret_ld86_esp_dots
			}
			CAS_Guitar_Head = {
				desc_id = gtr33_nekhed_01
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
				desc_id = gtr33_bridge_fr
			}
			CAS_Guitar_Knobs = {
				desc_id = gtr_33_knobs_b
			}
			CAS_Guitar_Pickups = {
				desc_id = GTR30_EMG
			}
			CAS_Bass_Body = {
				desc_id = bas_ibz_sr505
			}
			CAS_Bass_Finish = {
				desc_id = bs_ibz_sr_ld00
				chosen_materials = {
					material1 = grey_4guitar
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
			CAS_Bass_Neck_Finish = {
				desc_id = bass_ibz24_inlay_62
				chosen_materials = {
					material1 = teal_5
				}
			}
			CAS_Bass_Head = {
				desc_id = bas_ibz_sr_head01
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = grey_4guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = bs_ibz_sr_hd_dtl02
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
				desc_id = emgj
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = ibz01
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
				chosen_materials = {
					material1 = Black_1guitar
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
					material1 = grey_5guitar
				}
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_GwenStefani2
		fullname = qs("\LGwen Stefani2")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Gwen Stefani2.")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = GwenStefani2
			}
			cas_physique = {
				desc_id = FemalePhysique
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
			$preset_musician_instrument_hack
		}
	}
	{
		name = GH_Rocker_TomDumont
		fullname = qs("\LTom Dumont")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Tom Dumont")
		no_random_pick
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = TomDumont
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr73_sch_s1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr73_sch_s1_ld02
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr73_sch_s1_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22_fret_ld49_shctr_block
			}
			CAS_Guitar_Head = {
				desc_id = gtr73_neckhead_04
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
				desc_id = gtr73_pg1
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr72_bridge
			}
			CAS_Guitar_Knobs = {
				desc_id = speedknobs
			}
			CAS_Guitar_Pickups = {
				desc_id = emg81dbl
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
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
				desc_id = bass14_esp_ax_dtl_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_05
				chosen_materials = {
					material1 = grey_5guitar
				}
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
				desc_id = bass9_neckhead4_dtl_02
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
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass14_Bridge_4str_01
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
				chosen_materials = {
					material1 = Black_1guitar
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
					material1 = grey_5guitar
				}
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_TonyKanal
		fullname = qs("\LTony Kanal")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Tony Kanal")
		no_random_pick
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = TonyKanal
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr82_prs_se1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr78_prs_sc_ld02
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr78_prs_sc_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr78_prs_sc_dtl04
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld114_prs_dots
			}
			CAS_Guitar_Head = {
				desc_id = gtr82_neckhead01
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
				desc_id = gtr82_neckhead_01_dtl04
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr82_pguard
			}
			CAS_Guitar_Pickguard_Finish = {
				desc_id = custom_color_esp
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr78_bridge01
			}
			CAS_Guitar_Knobs = {
				desc_id = tophat02
			}
			CAS_Guitar_Pickups = {
				desc_id = chrmhum
			}
			CAS_Bass_Body = {
				desc_id = bass110_tony1
			}
			CAS_Bass_Finish = {
				desc_id = bass111_tony_ld06
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_22d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bass_fretboard_22_ld110_nodoubt
			}
			CAS_Bass_Head = {
				desc_id = bass110_neckhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass110_neckhead_ld02
			}
			CAS_Bass_Head_Detail = {
				desc_id = bass9_neckhead4_dtl_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bass111_pg
			}
			CAS_Bass_Pickups = {
				desc_id = bass110_pickup
			}
			CAS_Bass_Bridges = {
				desc_id = hardtail
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
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
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_AdrianYoung
		fullname = qs("\LAdrian Young")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Adrian Young")
		no_random_pick
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = AdrianYoung
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr73_sch_s1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr73_sch_s1_ld02
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr73_sch_s1_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22_fret_ld49_shctr_block
			}
			CAS_Guitar_Head = {
				desc_id = gtr73_neckhead_04
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
				desc_id = gtr73_pg1
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr72_bridge
			}
			CAS_Guitar_Knobs = {
				desc_id = speedknobs
			}
			CAS_Guitar_Pickups = {
				desc_id = emg81dbl
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Body = {
				desc_id = bas_ibz_sr505
			}
			CAS_Bass_Finish = {
				desc_id = bs_ibz_sr_ld00
				chosen_materials = {
					material1 = grey_4guitar
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
			CAS_Bass_Neck_Finish = {
				desc_id = bass_ibz24_inlay_62
				chosen_materials = {
					material1 = teal_5
				}
			}
			CAS_Bass_Head = {
				desc_id = bas_ibz_sr_head01
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = grey_4guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = bs_ibz_sr_hd_dtl02
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
				desc_id = emgj
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = ibz01
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
				chosen_materials = {
					material1 = Black_1guitar
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
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_TomDumont_CareerOnly
		fullname = qs("\LTom Dumont")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		intro_anims = [
			g_noDoubt_win_waving
		]
		Win_Anims = [
			g_noDoubt_win_waving
		]
		Lose_Anims = [
			g_noDoubt_lose_depressed
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Tom Dumont")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = TomDumont
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr73_sch_s1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr73_sch_s1_ld02
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr73_sch_s1_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22_fret_ld49_shctr_block
			}
			CAS_Guitar_Head = {
				desc_id = gtr73_neckhead_04
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
				desc_id = gtr73_pg1
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr72_bridge
			}
			CAS_Guitar_Knobs = {
				desc_id = speedknobs
			}
			CAS_Guitar_Pickups = {
				desc_id = emg81dbl
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
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
				desc_id = bass14_esp_ax_dtl_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_05
				chosen_materials = {
					material1 = grey_5guitar
				}
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
				desc_id = bass9_neckhead4_dtl_02
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
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass14_Bridge_4str_01
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
				chosen_materials = {
					material1 = Black_1guitar
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
					material1 = grey_5guitar
				}
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_TonyKanal_CareerOnly
		fullname = qs("\LTony Kanal")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		intro_anims = [
			b_noDoubt_win_waving
		]
		Win_Anims = [
			b_noDoubt_win_waving
		]
		Lose_Anims = [
			b_noDoubt_lose_depressed
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Tony Kanal")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = TonyKanal
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr82_prs_se1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr78_prs_sc_ld02
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr78_prs_sc_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr78_prs_sc_dtl04
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld114_prs_dots
			}
			CAS_Guitar_Head = {
				desc_id = gtr82_neckhead01
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
				desc_id = gtr82_neckhead_01_dtl04
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr82_pguard
			}
			CAS_Guitar_Pickguard_Finish = {
				desc_id = custom_color_esp
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr78_bridge01
			}
			CAS_Guitar_Knobs = {
				desc_id = tophat02
			}
			CAS_Guitar_Pickups = {
				desc_id = chrmhum
			}
			CAS_Bass_Body = {
				desc_id = bass110_tony1
			}
			CAS_Bass_Finish = {
				desc_id = bass111_tony_ld06
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_22d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bass_fretboard_22_ld110_nodoubt
			}
			CAS_Bass_Head = {
				desc_id = bass110_neckhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass110_neckhead_ld02
			}
			CAS_Bass_Head_Detail = {
				desc_id = bass110_neckhead_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bass111_pg
			}
			CAS_Bass_Pickups = {
				desc_id = bass110_pickup
			}
			CAS_Bass_Bridges = {
				desc_id = hardtail
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
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
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_TomDumont2
		fullname = qs("\LTom Dumont")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		intro_anims = [
			g_noDoubt_win_waving
		]
		Win_Anims = [
			g_noDoubt_win_waving
		]
		Lose_Anims = [
			g_noDoubt_lose_depressed
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Tom Dumont")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = TomDumont
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr73_sch_s1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr73_sch_s1_ld02
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr73_sch_s1_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22_fret_ld49_shctr_block
			}
			CAS_Guitar_Head = {
				desc_id = gtr73_neckhead_04
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
				desc_id = gtr73_pg1
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr72_bridge
			}
			CAS_Guitar_Knobs = {
				desc_id = speedknobs
			}
			CAS_Guitar_Pickups = {
				desc_id = emg81dbl
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
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
				desc_id = bass14_esp_ax_dtl_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = Bass_Fretboard_24d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_05
				chosen_materials = {
					material1 = grey_5guitar
				}
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
				desc_id = bass9_neckhead4_dtl_02
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
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass14_Bridge_4str_01
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
				chosen_materials = {
					material1 = Black_1guitar
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
					material1 = grey_5guitar
				}
			}
			CAS_Mic = {
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_TonyKanal2
		fullname = qs("\LTony Kanal")
		allowed_parts = [
			Bass
			drum
			guitar
			Vocals
		]
		intro_anims = [
			b_noDoubt_win_waving
		]
		Win_Anims = [
			b_noDoubt_win_waving
		]
		Lose_Anims = [
			b_noDoubt_lose_depressed
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Tony Kanal")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = TonyKanal
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Guitar_Body = {
				desc_id = gtr82_prs_se1
			}
			CAS_Guitar_Finish = {
				desc_id = gtr78_prs_sc_ld02
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr78_prs_sc_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr78_prs_sc_dtl04
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld114_prs_dots
			}
			CAS_Guitar_Head = {
				desc_id = gtr82_neckhead01
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
				desc_id = gtr82_neckhead_01_dtl04
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = gtr82_pguard
			}
			CAS_Guitar_Pickguard_Finish = {
				desc_id = custom_color_esp
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr78_bridge01
			}
			CAS_Guitar_Knobs = {
				desc_id = tophat02
			}
			CAS_Guitar_Pickups = {
				desc_id = chrmhum
			}
			CAS_Bass_Body = {
				desc_id = bass110_tony1
			}
			CAS_Bass_Finish = {
				desc_id = bass110_tony_ld06
			}
			CAS_Bass_Body_Detail = {
				desc_id = gh5_none
			}
			cas_bass_body_fade = {
				desc_id = fade_none
			}
			CAS_Bass_Neck = {
				desc_id = bass_fretboard_22d
			}
			CAS_Bass_Neck_Finish = {
				desc_id = bass_fretboard_22_ld110_nodoubt
			}
			CAS_Bass_Head = {
				desc_id = bass110_neckhead
			}
			CAS_Bass_Head_Finish = {
				desc_id = bass110_neckhead_d
			}
			CAS_Bass_Head_Detail = {
				desc_id = bass110_neckhead_dtl02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			cas_bass_head_fade = {
				desc_id = bass_head_fade_none
			}
			CAS_Bass_Pickguards = {
				desc_id = bass110_pg
			}
			CAS_Bass_Pickups = {
				desc_id = bass110_pickup
			}
			CAS_Bass_Bridges = {
				desc_id = hardtail
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
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
				desc_id = mic_standard
			}
			CAS_Mic_Stand = {
				desc_id = mic_stand_rock
			}
		}
	}
	{
		name = GH_Rocker_AdrianYoung_Drummer
		fullname = qs("\LAdrianYoung")
		allowed_parts = [
			drum
		]
		intro_anims = [
			d_jeff_win_waving
		]
		Win_Anims = [
			d_jeff_win_waving
		]
		Lose_Anims = [
			d_jeff_lose_depressed
		]
		preset_icon = photo_Eddie
		blurb = qs("I am Adrian Young")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			genre = Rock
			CAS_Full_Body = {
				desc_id = AdrianYoung
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			$preset_musician_instrument_hack
			CAS_Drums = {
				desc_id = nodoubt_drums
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = drumshell_nodoubt
			}
			CAS_Drum_Detail = {
				desc_id = bass_skin_ocdp_d
			}
		}
	}
	{
		name = GH_Rocker_TaylorSwift_Guitarist
		fullname = qs("\LGH_Rocker_TaylorSwift_Guitarist")
		allowed_parts = [
			guitar
		]
		preset_icon = photo_Eddie
		blurb = qs("Taylor Swift's Guitarist.")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			body_preset_index = 0
			genre = Pop
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				cap = [
					{
						base_tex = `tex/models/Characters/Global/Global_Blank_Head_dnc`
						material = CAR_Male_Head
						Cas_1
						post_layer = [
							{
								texture = `tex/models/Characters/Layers/CAR/Male/Makeup/CAR_Male_EYELINER_01`
								flags = 4
							}
						]
					}
				]
				bones = {
					EyeShape = 0.0
					EyeCornerShape = 0.1
					EyePosition = -0.43
					EyeDistance = -0.3
					MouthScale = 0.176
					EyebrowSize = 0.625
					EyebrowDistance = -0.9
					BrowPosition = 0.2
					EyebrowAngle = 0.3
					ChinWidth = 0.9
					NoseWidth = 0.23300001
					MouthPosition = 0.237
					EyeScale = 0.614
					EyeAngle = 0.5
					FaceFullness = 0.7
				}
			}
			CAS_Eyes = {
				desc_id = eyes_brown
			}
			CAS_Male_Hair = {
				desc_id = M_Glam_Hair_Izzy1
				chosen_materials = {
					material1 = carblack_1
				}
			}
			CAS_Male_Torso = {
				desc_id = M_Pop_Torso_Suit
				chosen_materials = {
					material1 = carblack_1
					material4 = red_2
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Metl_Legs_Axel5
			}
			CAS_Male_Shoes = {
				desc_id = M_Rock_Shoe_JCashChelsea
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			$preset_musician_instrument_hack
			CAS_Guitar_Body = {
				desc_id = gtr79_prs_cstm24
			}
			CAS_Guitar_Finish = {
				desc_id = gtr79_prs_ctm24_dtl06
				chosen_materials = {
					material1 = yellow_2guitar
				}
			}
			CAS_Guitar_Body_Detail = {
				desc_id = gtr79_prs_ctm24_ld01
				chosen_materials = {
					material1 = orange_5
				}
			}
			cas_guitar_body_fade = {
				desc_id = gtr79_prs_ctm24_ld03
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Guitar_Neck = {
				desc_id = gtr_22fret_fretboard_03
			}
			CAS_Guitar_Neck_Finish = {
				desc_id = 22fret_ld114_prs_dots
			}
			CAS_Guitar_Head = {
				desc_id = gtr82_neckhead01
			}
			CAS_Guitar_Head_Finish = {
				desc_id = espcolor
				chosen_materials = {
					material1 = grey_5guitar
				}
			}
			CAS_Guitar_Head_Detail = {
				desc_id = gtr82_neckhead_06
			}
			cas_guitar_head_fade = {
				desc_id = gtr82_neckhead_01_ld03
				chosen_materials = {
					material1 = red_1
				}
			}
			CAS_Guitar_Pickguards = {
				desc_id = none
			}
			CAS_Guitar_Bridges = {
				desc_id = gtr79_whammy
			}
			CAS_Guitar_Knobs = {
				desc_id = lampshade
				chosen_materials = {
					material1 = orange_2
				}
			}
			CAS_Guitar_Pickups = {
				desc_id = chrmhum
				chosen_materials = {
					material1 = yellow_4guitar
				}
			}
			CAS_Guitar_Misc = {
				desc_id = misc_switch
			}
		}
	}
	{
		name = GH_Rocker_TaylorSwift_Bassist
		fullname = qs("\LGH_Rocker_TaylorSwift_Bassist")
		allowed_parts = [
			Bass
		]
		preset_icon = photo_Eddie
		blurb = qs("Taylor Swift's Bassist.")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			body_preset_index = 0
			genre = Pop
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				bones = {
					NoseWidth = 0.2
					NoseLength = 0.6
					NoseAngle = 0.367
					NoseSize = 0.8
					NoseNostrilSize = 0.7
					NosePosition = 0.77199996
					MouthPosition = 0.3
					MouthDepth = 0.1
					MouthScale = 0.3
					LipShapeUpper = 1.0
					LowerLipThickness = 0.0
					MouthAngle = 0.6
					EyeCornerShape = 0.6
					EyeShape = 0.9
					EyeScale = 0.514
					EyePosition = -0.13
					EyeDistance = -0.414
					EyeAngle = 0.561
					EyebrowSize = 0.0
					EyebrowDistance = -0.556
					BrowPosition = 0.0
					EyebrowAngle = 0.8
					ChinWidth = 0.0
					ChinProminence = 0.4
					ChinHeight = 0.2
					CheekboneProminence = 0.6
					ChinAngle = 0.5
					CheekboneDepth = 0.1
					BrowDepth = 0.0
				}
			}
			CAS_Eyes = {
				desc_id = eyes_hazel
			}
			CAS_Male_Hair = {
				desc_id = M_Metl_Hair_Axel5
			}
			CAS_Male_Facial_Hair = {
				desc_id = M_Rock_Fhair_Stub
			}
			CAS_Male_Torso = {
				desc_id = M_Rock_Torso_JCashVest
				chosen_materials = {
					material3 = blue_5
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Metl_Legs_TooSkinny
			}
			CAS_Male_Shoes = {
				desc_id = M_Spnr_Shoe_VansH_BW
			}
			CAS_Male_Acc_Left = {
				desc_id = Pop_Acc_LQuinBracelet
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Pop_Acc_Rquin3
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			$preset_musician_instrument_hack
			CAS_Bass_Body = {
				desc_id = bas_ibz_sr505
			}
			CAS_Bass_Finish = {
				desc_id = bs_ibz_sr_ld00
				chosen_materials = {
					material1 = grey_4guitar
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
			CAS_Bass_Neck_Finish = {
				desc_id = bass_ibz24_inlay_62
				chosen_materials = {
					material1 = teal_5
				}
			}
			CAS_Bass_Head = {
				desc_id = bas_ibz_sr_head01
			}
			CAS_Bass_Head_Finish = {
				desc_id = esp_solidcolor
				chosen_materials = {
					material1 = grey_4guitar
				}
			}
			CAS_Bass_Head_Detail = {
				desc_id = bs_ibz_sr_hd_dtl02
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
				desc_id = emgj
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = ibz01
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
		}
	}
	{
		name = GH_Rocker_TaylorSwift_Drummer
		fullname = qs("\LGH_Rocker_TaylorSwift_Drummer")
		allowed_parts = [
			drum
		]
		preset_icon = photo_Eddie
		blurb = qs("Taylor Swift's Drummer.")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			body_preset_index = 0
			genre = Pop
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				bones = {
					NoseWidth = 0.2
					NoseLength = 0.6
					NoseNostrilSize = 0.7
					EyeCornerShape = 0.6
					EyeShape = 0.9
					EyebrowSize = 0.0
					EyebrowDistance = -0.556
					BrowPosition = 0.0
					ChinWidth = 0.0
					ChinProminence = 0.4
					ChinHeight = 0.2
					CheekboneProminence = 0.6
					ChinAngle = 0.5
					CheekboneDepth = 0.1
					BrowDepth = 0.0
					EyeAngle = 0.461
					EyeDistance = 0.186
					EyeScale = 0.7
					NoseSize = 0.6
					NoseBridge = 0.6
					NoseTipLength = 0.167
					NoseTipAngle = 0.6
					NoseAngle = 0.467
					LipShapeUpper = 0.0
					MouthPosition = 0.6
					MouthScale = 0.3
					JawProminence = 0.9
					EarSize = 0.333
					EarProminence = 0.32600003
					EyebrowAngle = 0.4
					MouthAngle = 0.6
					LowerLipThickness = 0.5
					MouthDepth = 0.4
					EyePosition = -0.8
					NosePosition = 1.0
				}
			}
			CAS_Eyes = {
				desc_id = eyes_blue
			}
			CAS_Male_Facial_Hair = {
				desc_id = M_Rock_Fhair_Goatee01
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Male_Torso = {
				desc_id = M_Metl_Torso_Unbttond
			}
			CAS_Male_Legs = {
				desc_id = M_Punk_Legs_Jny_5
			}
			CAS_Male_Shoes = {
				desc_id = M_Spnr_Shoe_ConverseCS
			}
			CAS_Male_Acc_Left = {
				desc_id = M_Punk_Acc_LRings
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Punk_Acc_RRings
			}
			CAS_Male_Acc_Ears = {
				desc_id = M_Punk_Acc_Ring
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Mature
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			$preset_musician_instrument_hack
			CAS_Drums = {
				desc_id = taylorkit
			}
			cas_drums_sticks_l = {
				desc_id = drm_stick_l
			}
			cas_drums_sticks_r = {
				desc_id = drm_stick_r
			}
			CAS_Drum_Finish = {
				desc_id = none
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Drum_Detail = {
				desc_id = bass_skin_swift
			}
		}
	}
	{
		name = GH_Rocker_AdamLevine_Guitarist
		fullname = qs("\LGH_Rocker_AdamLevine_Guitarist")
		allowed_parts = [
			guitar
		]
		preset_icon = photo_Eddie
		blurb = qs("Adam Levine's Guitarist.")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			body_preset_index = 0
			genre = Pop
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				bones = {
					NoseWidth = 0.2
					NoseLength = 0.6
					NoseAngle = 0.367
					NoseSize = 0.8
					NoseNostrilSize = 0.7
					NosePosition = 0.77199996
					MouthPosition = 0.3
					MouthDepth = 0.1
					MouthScale = 0.3
					LipShapeUpper = 1.0
					LowerLipThickness = 0.0
					MouthAngle = 0.6
					EyeCornerShape = 0.6
					EyeShape = 0.9
					EyeScale = 0.514
					EyePosition = -0.13
					EyeDistance = -0.414
					EyeAngle = 0.561
					EyebrowSize = 0.0
					EyebrowDistance = -0.556
					BrowPosition = 0.0
					EyebrowAngle = 0.8
					ChinWidth = 0.0
					ChinProminence = 0.4
					ChinHeight = 0.2
					CheekboneProminence = 0.6
					ChinAngle = 0.5
					CheekboneDepth = 0.1
					BrowDepth = 0.0
				}
			}
			CAS_Eyes = {
				desc_id = eyes_green
			}
			CAS_Male_Hair = {
				desc_id = M_Metl_Hair_Lars
				chosen_materials = {
					material1 = carblack_1
				}
			}
			CAS_Male_Torso = {
				desc_id = M_Metl_Torso_Unbttond
				chosen_materials = {
					material1 = blue_3
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Metl_Legs_TooSkinny
			}
			CAS_Male_Shoes = {
				desc_id = M_Spnr_Shoe_ConverseCS
			}
			CAS_Male_Acc_Left = {
				desc_id = M_Rock_Acc_LWatch
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Rock_Acc_RStrap
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			$preset_musician_instrument_hack
			CAS_Guitar_Body = {
				desc_id = gtr38_wv
			}
			CAS_Guitar_Finish = {
				desc_id = gtr37_rw_d_color
				chosen_materials = {
					material1 = yellow_orange_3
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
		}
	}
	{
		name = GH_Rocker_AdamLevine_Bassist
		fullname = qs("\LGH_Rocker_AdamLevine_Bassist")
		allowed_parts = [
			Bass
		]
		preset_icon = photo_Eddie
		blurb = qs("Adam Levine's Bassist.")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			body_preset_index = 0
			genre = Pop
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				chosen_materials = {
					skin = skin_asian3
				}
				bones = {
					NoseWidth = 0.2
					NoseLength = 0.6
					NoseNostrilSize = 0.7
					EyeCornerShape = 0.6
					EyeShape = 0.9
					EyebrowSize = 0.0
					EyebrowDistance = -0.556
					BrowPosition = 0.0
					ChinWidth = 0.0
					ChinProminence = 0.4
					ChinHeight = 0.2
					CheekboneProminence = 0.6
					ChinAngle = 0.5
					CheekboneDepth = 0.1
					BrowDepth = 0.0
					EyeAngle = 0.461
					EyeDistance = 0.186
					EyeScale = 0.7
					NoseSize = 0.6
					NoseBridge = 0.6
					NoseTipLength = 0.167
					NoseTipAngle = 0.6
					NoseAngle = 0.467
					LipShapeUpper = 0.0
					MouthPosition = 0.6
					MouthScale = 0.3
					JawProminence = 0.9
					EarSize = 0.333
					EarProminence = 0.32600003
					EyebrowAngle = 0.4
					MouthAngle = 0.6
					LowerLipThickness = 0.5
					MouthDepth = 0.4
					EyePosition = -0.8
					NosePosition = 1.0
				}
			}
			CAS_Eyes = {
				desc_id = eyes_blue
			}
			CAS_Male_Hair = {
				desc_id = M_Punk_Hair_Jny_5
				chosen_materials = {
					material1 = yellow_orange_1
				}
			}
			CAS_Male_Torso = {
				desc_id = M_Torso_TShirt
				chosen_materials = {
					material1 = grey_3guitar
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Rock_Legs_Jeans
				chosen_materials = {
					material1 = grey_4
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Metl_Shoe_ClscRunr
				chosen_materials = {
					material1 = carblack_3
				}
			}
			CAS_Male_Acc_Left = {
				desc_id = M_Rock_Acc_LWatch
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Rock_Acc_RStripe
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			$preset_musician_instrument_hack
			CAS_Bass_Body = {
				desc_id = Bass16_ESP_Surveyor_02
			}
			CAS_Bass_Finish = {
				desc_id = Bass14_ESP_Surveyor_D_color
				chosen_materials = {
					material1 = orange_3
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
			CAS_Bass_Neck_Finish = {
				desc_id = Bass_Fretboard_Inlay_05
				chosen_materials = {
					material1 = grey_5guitar
				}
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
				desc_id = bass9_neckhead4_dtl_02
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
				desc_id = Bass9_Pkup_Type1_Blk_02
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
			CAS_Bass_Bridges = {
				desc_id = Bass14_Bridge_4str_01
			}
			CAS_Bass_Knobs = {
				desc_id = speedster
				chosen_materials = {
					material1 = Black_1guitar
				}
			}
		}
	}
	{
		name = GH_Rocker_AdamLevine_Drummer
		fullname = qs("\LGH_Rocker_AdamLevine_Drummer")
		allowed_parts = [
			drum
		]
		preset_icon = photo_Eddie
		blurb = qs("Adam Levine's Drummer.")
		no_random_pick
		selection_not_allowed
		locked
		appearance = {
			body_preset_index = 0
			genre = Pop
			CAS_Male_Base_Torso = {
				desc_id = male_full
			}
			cas_physique = {
				desc_id = MalePhysique
			}
			CAS_Body = {
				desc_id = GH4_CAR_Male
				cap = [
					{
						base_tex = `tex/models/Characters/Global/Global_Blank_Head_dnc`
						material = CAR_Male_Head
						Cas_1
						post_layer = [
							{
								texture = `tex/models/Characters/Layers/CAR/Male/Makeup/CAR_Male_EYELINER_01`
								flags = 4
							}
						]
					}
				]
				bones = {
					NoseWidth = 0.2
					NoseLength = 0.6
					NoseNostrilSize = 0.7
					EyeCornerShape = 0.6
					EyebrowSize = 0.0
					EyebrowDistance = -0.556
					BrowPosition = 0.0
					ChinWidth = 0.0
					ChinHeight = 0.2
					CheekboneProminence = 0.6
					ChinAngle = 0.5
					CheekboneDepth = 0.1
					BrowDepth = 0.0
					EyeDistance = 0.186
					NoseTipLength = 0.167
					NoseTipAngle = 0.6
					NoseAngle = 0.467
					LipShapeUpper = 0.0
					EarSize = 0.333
					EyebrowAngle = 0.4
					MouthAngle = 0.6
					LowerLipThickness = 0.5
					MouthDepth = 0.4
					EyeScale = 0.5
					EyeShape = 0.0
					EyeAngle = 0.661
					EyePosition = 0.0
					NoseSize = 0.4
					NoseBridge = 0.0
					NosePosition = 0.3
					MouthPosition = 0.0
					MouthScale = 0.5
					JawProminence = 0.0
					ChinProminence = 0.9
					EarProminence = 0.126
				}
				chosen_materials = {
					Eyebrows = yellow_4
					skin = skin_asian4
				}
			}
			CAS_Eyes = {
				desc_id = eyes_hazel
			}
			CAS_Male_Hair = {
				desc_id = M_Metl_Hair_Axel5
				chosen_materials = {
					material1 = yellow_3
				}
			}
			CAS_Male_Torso = {
				desc_id = m_torso_layered_nostripe
				chosen_materials = {
					material1 = yellow_green_2
					material2 = grey_1
				}
			}
			CAS_Male_Legs = {
				desc_id = M_Pop_Legs_Jeans
				chosen_materials = {
					material1 = carblack_3
				}
			}
			CAS_Male_Shoes = {
				desc_id = M_Spnr_Shoe_VansH_BW
			}
			CAS_Male_Acc_Left = {
				desc_id = Pop_Acc_LQuinBracelet
			}
			CAS_Male_Acc_Right = {
				desc_id = M_Rock_Acc_RStrap
			}
			CAS_Male_Age = {
				desc_id = CAR_Male_Teen
			}
			CAS_Male_Teeth = {
				desc_id = CAR_male_teeth
			}
			$preset_musician_instrument_hack
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
				desc_id = drumshell_ds_tama03
			}
			CAS_Drum_Detail = {
				desc_id = bass_skin_ds_15
				chosen_materials = {
					material1 = Black_1guitar
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
		name = Worstmale
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		no_random_pick
		selection_not_allowed
		appearance = {
			$worst_male
			$worst_drum
			$worst_mic
			$worst_guitar
			$worst_bass
			$worst_male_appearance_hack
		}
	}
	{
		name = Worstmale2
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		no_random_pick
		selection_not_allowed
		appearance = {
			$worst_male
			$worst_drum
			$worst_mic
			$worst_guitar
			$worst_bass
			$worst_male_appearance_hack
		}
	}
	{
		name = Worstfemale
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		no_random_pick
		selection_not_allowed
		appearance = {
			$worst_female
			$worst_drum
			$worst_mic
			$worst_guitar
			$worst_bass
			$worst_female_appearance_hack
		}
	}
	{
		name = Worstfemale2
		allowed_parts = [
			drum
			Vocals
			guitar
			Bass
		]
		no_random_pick
		selection_not_allowed
		appearance = {
			$worst_female
			$worst_drum
			$worst_mic
			$worst_guitar
			$worst_bass
			$worst_female_appearance_hack
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
		}
	}
]
