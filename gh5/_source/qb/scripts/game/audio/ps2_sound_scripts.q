LoadedMenuLick = none
g_current_sfx_mode = none
TutorialSFXLoaded = none

script GetVenueCrowdSize 
	GetPakManCurrent \{map = zones}
	switch <pak>
		case z_ballpark
		return \{VenueSize = 'Medium_EXT'}
		case z_bayou
		return \{VenueSize = 'Small_INT'}
		case z_castle
		return \{VenueSize = 'Medium_EXT'}
		case z_cathedral
		return \{VenueSize = 'Medium_EXT'}
		case z_fairgrounds
		return \{VenueSize = 'Medium_EXT'}
		case z_frathouse
		return \{VenueSize = 'Small_INT'}
		case z_goth
		return \{VenueSize = 'Medium_EXT'}
		case z_harbor
		return \{VenueSize = 'Medium_EXT'}
		case z_hotel
		return \{VenueSize = 'Small_INT'}
		case z_metalfest
		return \{VenueSize = 'Large_EXT'}
		case z_military
		return \{VenueSize = 'Medium_EXT'}
		case z_newyork
		return \{VenueSize = 'Large_EXT'}
		case z_recordstore
		return \{VenueSize = 'Small_INT'}
		case z_tool
		return \{VenueSize = 'z_TOOL'}
		default
		return \{VenueSize = 'Medium_EXT'}
	endswitch
endscript

script LoadTutorialSFXWithPrefix \{Sound = 'none'}
	training_get_language_prefix
	FormatText TextName = lang_postfix '_%a' a = <language_prefix>
	ExtendCRC <Sound> <lang_postfix> out = sound_id
	LoadSound <sound_id>
endscript

script LoadJamDrumSamples 
	LoadSound \{HeavyRockCrash_Lvl_10_01}
	LoadSound \{HeavyRockCrash_Lvl_8_01}
	LoadSound \{HeavyRockFlTom_Lvl_10_01}
	LoadSound \{HeavyRockFlTom_Lvl_4_01}
	LoadSound \{HeavyRockFlTom_Lvl_6_01}
	LoadSound \{HeavyRockFlTom_Lvl_8_01}
	LoadSound \{HeavyRockHHClosed_Lvl_4_01}
	LoadSound \{HeavyRockHHClosed_Lvl_6_01}
	LoadSound \{HeavyRockHHClosed_Lvl_8_01}
	LoadSound \{HeavyRockHHClosed_Lvl_10_01}
	LoadSound \{HeavyRockHHOpen_Lvl_10_01}
	LoadSound \{HeavyRockHHOpen_Lvl_9_01}
	LoadSound \{HeavyRockHHOpen_Lvl_6_01}
	LoadSound \{HeavyRockHHOpen_Lvl_2_01}
	LoadSound \{HeavyRockHiTom_Lvl_10_01}
	LoadSound \{HeavyRockHiTom_Lvl_4_01}
	LoadSound \{HeavyRockHiTom_Lvl_6_01}
	LoadSound \{HeavyRockHiTom_Lvl_8_01}
	LoadSound \{HeavyRockKick_Lvl_10_01}
	LoadSound \{HeavyRockRide_Lvl_10_01}
	LoadSound \{HeavyRockSnare_Lvl_10_01}
	LoadSound \{HeavyRockSnare_Lvl_12_03}
	LoadSound \{HeavyRockSnare_Lvl_2_01}
	LoadSound \{HeavyRockSnare_Lvl_4_01}
	LoadSound \{HeavyRockSnare_Lvl_6_01}
	LoadSound \{HeavyRockSnare_Lvl_8_01}
endscript

script LoadIntroVO 
	<Structure> = $metallica_intro_vo_current_struct
	if StructureContains Structure = <Structure> rhythm_anim_name
		custom_anim_name = (<Structure>.rhythm_anim_name)
	else
		return
	endif
	switch <custom_anim_name>
		default

	endswitch
endscript

script LoadRandomIntroLick 
	Randomize
	change LoadedMenuLick = Random (@ Menu_Intro_Lick_01 @ Menu_Intro_Lick_02 @ Menu_Intro_Lick_03 )
	LoadSound ($LoadedMenuLick)
endscript

script LoadGenericMenuSfx 
	LoadSound \{GH3_Beat_Sound}
	LoadSound \{ui_sound_05}
	LoadSound \{UI_Sound_09}
	LoadSound \{Menu_Scroll_Down}
	LoadSound \{Menu_Scroll_Up}
	LoadSound \{Menu_Select_Negative}
	LoadSound \{checkbox_sfx}
	LoadSound \{CheckBox_Check_SFX}
endscript

script LoadStarHitSfx 
	LoadSound \{outro_one_star}
	LoadSound \{outro_two_stars}
	LoadSound \{outro_three_stars}
	LoadSound \{outro_four_stars}
	LoadSound \{outro_five_stars}
endscript

script LoadCrowdSfx 
	GetPakManCurrent \{map = zones}
	if (<pak> = z_studio || <pak> = z_studio2 || <pak> = z_tool || <pak> = z_credits || <pak> = z_soundcheck2)
		return
	endif
	GetVenueCrowdSize
	switch <VenueSize>
		case 'z_TOOL'

		return
		case 'Small_INT'

		LoadSound \{INT_SM_Crowd_Applause_01}
		LoadSound \{INT_SM_Crowd_Swell_SH_03}
		LoadSound \{INT_SM_Crowd_Swell_MD_01}
		LoadSound \{INT_SM_Crowd_Swell_LG_02}
		LoadSound \{SM_Crowd_Neutral_To_Good_03}
		LoadSound \{SM_Crowd_Good_To_Neutral_03}
		LoadSound \{SM_Crowd_Neutral_To_Bad_03}
		LoadSound \{SM_Crowd_Bad_To_Neutral_01}
		SaveSPUPosition
		LoadSound \{INT_SM_Crowd_Bad_Loop}
		LoadSound \{INT_SM_Crowd_Good_Loop}
		LoadSound \{INT_SM_Crowd_Neutral_Loop}
		case 'Medium_EXT'

		LoadSound \{EXT_MD_Crowd_Applause_02}
		LoadSound \{EXT_MD_Crowd_Swell_SH_01}
		LoadSound \{EXT_MD_Crowd_Swell_MD_02}
		LoadSound \{EXT_MD_Crowd_Swell_LG_02}
		LoadSound \{MD_Crowd_Neutral_To_Good_01}
		LoadSound \{MD_Crowd_Good_To_Neutral_01}
		LoadSound \{MD_Crowd_Neutral_To_Bad_02}
		LoadSound \{MD_Crowd_Bad_To_Neutral_01}
		SaveSPUPosition
		LoadSound \{EXT_MD_Crowd_Bad_Loop}
		LoadSound \{EXT_MD_Crowd_Good_Loop}
		LoadSound \{EXT_MD_Crowd_Neutral_Loop}
		case 'Large_EXT'

		LoadSound \{EXT_LG_Crowd_Applause_01}
		LoadSound \{EXT_LG_Crowd_Swell_SH_01}
		LoadSound \{EXT_LG_Crowd_Swell_MD_01}
		LoadSound \{EXT_LG_Crowd_Swell_LG_02}
		LoadSound \{LG_Crowd_Neutral_To_Good_01}
		LoadSound \{LG_Crowd_Good_To_Neutral_01}
		LoadSound \{LG_Crowd_Neutral_To_Bad_01}
		LoadSound \{LG_Crowd_Bad_To_Neutral_01}
		SaveSPUPosition
		LoadSound \{EXT_LG_Crowd_Bad_Loop}
		LoadSound \{EXT_LG_Crowd_Good_Loop}
		LoadSound \{EXT_LG_Crowd_Neutral_Loop}
		default

		LoadSound \{EXT_MD_Crowd_Applause_02}
		LoadSound \{EXT_MD_Crowd_Swell_SH_01}
		LoadSound \{EXT_MD_Crowd_Swell_MD_02}
		LoadSound \{EXT_MD_Crowd_Swell_LG_02}
		LoadSound \{MD_Crowd_Neutral_To_Good_01}
		LoadSound \{MD_Crowd_Good_To_Neutral_01}
		LoadSound \{MD_Crowd_Neutral_To_Bad_02}
		LoadSound \{MD_Crowd_Bad_To_Neutral_01}
		SaveSPUPosition
		LoadSound \{EXT_MD_Crowd_Bad_Loop}
		LoadSound \{EXT_MD_Crowd_Good_Loop}
		LoadSound \{EXT_MD_Crowd_Neutral_Loop}
	endswitch
endscript

script ReloadSfx \{mode = oogame
		noreset = 0
		force = 0
		tutorial = 0}
	if NOT (<noreset> = 1)
		ResetBCSND
		GetGlobalTags \{user_options}
		guitar_volume = (<volumes>.guitar.guitar.vol)
		band_volume = (<volumes>.guitar.Band.vol)
		sfx_volume = (<volumes>.guitar.sfx.vol)
	endif
	if NOT (<force> = 1)
		if ($g_current_sfx_mode = <mode>)
			return
		endif
	endif
	change g_current_sfx_mode = <mode>
	UnloadAllSFX
	change \{TutorialSFXLoaded = TutorialSFXLoaded}
	if ($g_current_sfx_mode = none)
		return
	endif
	LoadGenericMenuSfx
	switch <mode>
		case oogame

		LoadSound \{bad_note1}
		LoadSound \{bad_note2}
		LoadSound \{bad_note3}
		LoadSound \{bad_note4}
		LoadSound \{bad_note6}
		LoadSound \{bad_note_bass2}
		LoadSound \{bad_note_bass4}
		LoadSound \{bad_note_bass6}
		LoadSound \{Bad_Note_Tom1}
		LoadSound \{Bad_Note_HiHat1}
		LoadSound \{Bad_Note_Kick1}
		LoadSound \{Star_Available}
		LoadSound \{sp_available1}
		LoadSound \{sp_awarded1}
		LoadSound \{sp_deployed}
		LoadSound \{sp_cheer1}
		LoadSound \{sp_cheer2}
		LoadSound \{Notes_Ripple_Up_01}
		LoadSound \{you_rock}
		LoadSound \{Crowd_Fail_Song}
		LoadSound \{Highway_Rise}
		LoadSound \{UI_Song_Intro_Kick}
		LoadSound \{SongComplete_Out}
		LoadSound \{SongComplete_In}
		LoadSound \{Crowd_Group_Clap_01}
		LoadSound \{Crowd_Group_Clap_02}
		LoadSound \{Crowd_Group_Clap_03}
		LoadSound \{GH3_Sudden_Death}
		LoadSound \{StickClickLarge}
		LoadSound \{StickClickMed}
		LoadSound \{StickClickSmall}
		LoadSound \{HiHatClosed01}
		LoadSound \{UI_Lose_Multiplier}
		LoadSound \{UI_SFX_100_Note_Streak}
		LoadSound \{UI_SFX_50_Note_Streak}
		LoadSound \{Guitar_Smash_Large_GH4_01}
		LoadSound \{Guitar_Smash_Medium_GH4_01}
		LoadSound \{Guitar_Smash_Small_GH4_01}
		LoadSound \{Menu_Into_PauseMenu}
		LoadSound \{Menu_OutOf_PauseMenu}
		LoadSound \{SoundOptions_Menu_Reset}
		LoadSound \{Menu_Options_Sound_Fader_Move}
		LoadSound \{Menu_Options_Sound_Select}
		LoadSound \{Menu_Options_Sound_Back}
		LoadJamDrumSamples
		LoadCrowdSfx
		LoadStarHitSfx
		LoadSound \{Menu_EnterName_Select}
		LoadSound \{Menu_EnterName_Scroll_1}
		LoadSound \{Menu_EnterName_Finish_01}
		LoadSound \{Menu_EnterName_Back}
		LoadSound \{Menu_EnterName_Caps}
		case postgig

		LoadSound \{Gig_Complete_Sponsor}
		LoadSound \{GigComplete_Unlock_Item_Text_Appear}
		LoadSound \{GigComplete_Unlock_New_Item}
		LoadSound \{Gig_Complete_Magazine_In}
		LoadSound \{Gig_Complete_Magazine_Out}
		LoadSound \{Menu_EnterName_Select}
		LoadSound \{Menu_EnterName_Scroll_1}
		LoadSound \{Menu_EnterName_Finish_01}
		LoadSound \{Menu_EnterName_Back}
		LoadSound \{Menu_EnterName_Caps}
		LoadSound \{Cash}
		LoadSound \{Purchase_Item}
		LoadSound \{SongComplete_Out}
		LoadSound \{SongComplete_In}
		LoadSound \{Pre_Cutscence_SFX}
		case oogamevs

		LoadSound \{bad_note1}
		LoadSound \{bad_note2}
		LoadSound \{bad_note3}
		LoadSound \{bad_note4}
		LoadSound \{bad_note6}
		LoadSound \{bad_note_bass2}
		LoadSound \{bad_note_bass4}
		LoadSound \{bad_note_bass6}
		LoadSound \{Bad_Note_Tom1}
		LoadSound \{Bad_Note_HiHat1}
		LoadSound \{Bad_Note_Kick1}
		LoadSound \{Star_Available}
		LoadSound \{sp_available1}
		LoadSound \{sp_awarded1}
		LoadSound \{sp_deployed}
		LoadSound \{sp_cheer1}
		LoadSound \{sp_cheer2}
		LoadSound \{Notes_Ripple_Up_01}
		LoadSound \{Multiplayer_Win_Screen}
		LoadSound \{Crowd_Fail_Song}
		LoadSound \{Highway_Rise}
		LoadSound \{UI_Song_Intro_Kick}
		LoadSound \{Crowd_Group_Clap_01}
		LoadSound \{Crowd_Group_Clap_02}
		LoadSound \{Crowd_Group_Clap_03}
		LoadSound \{you_rock}
		LoadSound \{GH3_Sudden_Death}
		LoadSound \{StickClickLarge}
		LoadSound \{StickClickMed}
		LoadSound \{StickClickSmall}
		LoadSound \{HiHatClosed01}
		LoadSound \{UI_Lose_Multiplier}
		LoadSound \{UI_SFX_100_Note_Streak}
		LoadSound \{UI_SFX_50_Note_Streak}
		LoadSound \{Guitar_Smash_Large_GH4_01}
		LoadSound \{Guitar_Smash_Medium_GH4_01}
		LoadSound \{Guitar_Smash_Small_GH4_01}
		LoadSound \{Menu_Into_PauseMenu}
		LoadSound \{Menu_OutOf_PauseMenu}
		LoadSound \{SongComplete_Out}
		LoadSound \{SongComplete_In}
		LoadSound \{SoundOptions_Menu_Reset}
		LoadSound \{Menu_Options_Sound_Fader_Move}
		LoadJamDrumSamples
		LoadCrowdSfx
		case tutorials

		LoadSound \{Notes_Ripple_Up_01}
		LoadSound \{Highway_Rise}
		LoadSound \{UI_Song_Intro_Kick}
		LoadSound \{Finish_Chord}
		LoadSound \{Star_Available}
		LoadSound \{Menu_Into_PauseMenu}
		LoadSound \{Menu_OutOf_PauseMenu}
		if (<tutorial> != jam)
			LoadSound \{bad_note1}
			LoadSound \{bad_note2}
			LoadSound \{bad_note3}
			LoadSound \{bad_note4}
			LoadSound \{bad_note6}
			LoadSound \{bad_note_bass2}
			LoadSound \{bad_note_bass4}
			LoadSound \{bad_note_bass6}
		endif
		if (<tutorial> = 1)
			LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_PlayNotes_10_GTR}
		endif
		if ((<tutorial> = 1) || (<tutorial> = 4))
			LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Positive_01_GTR}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Positive_02_GTR}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Positive_03_GTR}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Positive_04_GTR}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Positive_05_GTR}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Positive_06_GTR}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Positive_07_GTR}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Positive_08_GTR}
			if (<tutorial> = 4)
				LoadSound \{Tutorial_String_1_Strum_Free}
				LoadSound \{Tutorial_String_3_Strum_Free}
				LoadSound \{Tutorial_String_1_HOPO_Free}
				LoadSound \{Tutorial_String_2_HOPO_Free}
				LoadSound \{Tutorial_String_3_HOPO_Free}
			endif
		elseif ((<tutorial> = drum_basic) || (<tutorial> = 6))
			if (<tutorial> = drum_basic)
				LoadJamDrumSamples
			endif
			LoadSound \{Bad_Note_Tom1}
			LoadSound \{Bad_Note_HiHat1}
			LoadSound \{Bad_Note_Kick1}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Positive_01_DRM}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Positive_02_DRM}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Positive_03_DRM}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Positive_04_DRM}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Positive_05_DRM}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Positive_06_DRM}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Positive_07_DRM}
			LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Positive_08_DRM}
		elseif (<tutorial> = battle)
			LoadSound \{GH3_Battle_DifficultyRampUp}
			LoadSound \{GH3_BattleMode_Attack_Over}
			LoadSound \{GH3_BattleMode_DoubleNoteAttack}
			LoadSound \{GH3_BattleMode_Lightning}
			LoadSound \{GH3_BattleMode_StringBreakAttack}
			LoadSound \{GH3_Battlemode_StringTune_2}
			LoadSound \{sp_awarded1}
			LoadSound \{sp_deployed}
		endif
		SaveSPUPosition
		case battle

		LoadSound \{bad_note1}
		LoadSound \{bad_note2}
		LoadSound \{bad_note3}
		LoadSound \{bad_note4}
		LoadSound \{bad_note6}
		LoadSound \{bad_note_bass2}
		LoadSound \{bad_note_bass4}
		LoadSound \{bad_note_bass6}
		LoadSound \{Bad_Note_Tom1}
		LoadSound \{Bad_Note_HiHat1}
		LoadSound \{Bad_Note_Kick1}
		LoadSound \{Notes_Ripple_Up_01}
		LoadSound \{Battle_MineAttack_Explode}
		LoadSound \{Battle_MineAttack_Release}
		LoadSound \{GH3_Battle_DifficultyRampUp}
		LoadSound \{GH3_BattleMode_Attack_Over}
		LoadSound \{GH3_BattleMode_DoubleNoteAttack}
		LoadSound \{GH3_BattleMode_LeftyAttack}
		LoadSound \{GH3_BattleMode_Lightning}
		LoadSound \{GH3_BattleMode_StealPowerup}
		LoadSound \{GH3_BattleMode_StringBreakAttack}
		LoadSound \{GH3_BattleMode_WhammyAttack}
		LoadSound \{GH3_Sudden_Death}
		LoadSound \{GHM_RideTheLightning_Release}
		LoadSound \{GHM_HitTheLights_Release}
		LoadSound \{GHM_DamageInc_Attack}
		LoadSound \{GHM_TrappedUnderIce_Release}
		LoadSound \{GHM_RideTheLightning_Attack}
		LoadSound \{GHM_HitTheLights_Attack}
		LoadSound \{GHM_TrappedUnderIce_Attack}
		LoadSound \{Highway_Rise}
		LoadSound \{GH3_Battlemode_StringTune_2}
		LoadSound \{UI_Song_Intro_Kick}
		LoadSound \{UI_Lose_Multiplier}
		LoadSound \{UI_SFX_100_Note_Streak}
		LoadSound \{UI_SFX_50_Note_Streak}
		LoadSound \{Multiplayer_Win_Screen}
		LoadSound \{StickClickMed}
		LoadSound \{you_rock}
		LoadSound \{sp_awarded1}
		LoadSound \{sp_deployed}
		LoadSound \{DoOrDie}
		LoadSound \{Menu_Into_PauseMenu}
		LoadSound \{Menu_OutOf_PauseMenu}
		LoadSound \{SongComplete_Out}
		LoadSound \{SongComplete_In}
		LoadSound \{SoundOptions_Menu_Reset}
		LoadSound \{Menu_Options_Sound_Fader_Move}
		LoadCrowdSfx
		case firstboot

		LoadSound \{Cash}
		LoadSound \{Fly_In_Whoosh}
		LoadSound \{Purchase_Item}
		LoadSound \{Menu_QuickPlay_RemoveSong}
		LoadSound \{Menu_Warning_01}
		LoadSound \{Menu_ZoomIn_Career}
		LoadSound \{Menu_ZoomOut_Career}
		LoadSound \{Menu_ZoomIn_Options}
		LoadSound \{Menu_ZoomOut_Options}
		LoadSound \{Menu_ZoomIn_HeadToHead}
		LoadSound \{Menu_ZoomOut_HeadToHead}
		LoadSound \{Menu_Options_Sound_Select}
		LoadSound \{Menu_Options_Sound_Back}
		LoadSound \{Menu_Options_Sound_Fader_Move}
		LoadSound \{Menu_Options_Sound_DolbyDigitalDisable}
		LoadSound \{Menu_Options_Sound_DolbyDigitalEnable}
		LoadSound \{Menu_EnterName_Select}
		LoadSound \{Menu_EnterName_Scroll_1}
		LoadSound \{Menu_EnterName_Finish_01}
		LoadSound \{Menu_EnterName_Back}
		LoadSound \{Menu_EnterName_Caps}
		LoadSound \{Menu_ColorWheel_GradientSelect}
		LoadSound \{Menu_ColorWheel_Rotate}
		LoadSound \{Menu_ColorWheel_HighLight_Up_Down_3}
		LoadSound \{Menu_ColorWheel_Deselect_PiePiece}
		LoadSound \{Menu_ColorWheel_SelectPie}
		LoadSound \{Menu_Main_Intro}
		LoadSound \{Guitar_Select_Affirmation_1}
		LoadSound \{Drum_Select_Affirmation_01}
		LoadSound \{Bass_Select_Affirmation_02}
		LoadSound \{Mic_Select_Affirmation_01}
		LoadSound \{Band_leader_affirmation}
		LoadSound \{Menu_Cheat_Red}
		LoadSound \{Menu_Cheat_Yellow}
		LoadSound \{Menu_Cheat_Blue}
		LoadSound \{Menu_Cheat_Green}
		LoadSound \{Gig_Complete_Sponsor}
		LoadSound \{GigComplete_Unlock_Item_Text_Appear}
		LoadSound \{GigComplete_Unlock_New_Item}
		LoadSound \{Gig_Complete_Magazine_In}
		LoadSound \{Gig_Complete_Magazine_Out}
		LoadSound \{Gig_Unlock}
		LoadSound \{UI_GigBoard_Scroll}
		LoadSound \{UI_GigBoard_SwishIN}
		LoadSound \{SoundOptions_Menu_Reset}
		LoadSound \{HeavyRockSnare_Lvl_12_03}
		LoadSound \{Menu_Gigboard_CameraPan_Right}
		LoadSound \{Menu_Gigboard_CameraPan_Left}
		LoadSound \{Menu_Restore_Defaults}
		LoadSound \{Crowd_Group_Clap_03}
		LoadSound \{bad_note2}
		LoadSound \{Pre_Cutscence_SFX}
		LoadSound \{CheckBox_Check_SFX_2}
		LoadRandomIntroLick
		change \{g_current_sfx_mode = FrontEnd}
		case FrontEnd

		LoadSound \{Cash}
		LoadSound \{Fly_In_Whoosh}
		LoadSound \{Purchase_Item}
		LoadSound \{Menu_QuickPlay_RemoveSong}
		LoadSound \{Menu_Warning_01}
		LoadSound \{Menu_ZoomIn_Career}
		LoadSound \{Menu_ZoomOut_Career}
		LoadSound \{Menu_ZoomIn_Options}
		LoadSound \{Menu_ZoomOut_Options}
		LoadSound \{Menu_ZoomIn_HeadToHead}
		LoadSound \{Menu_ZoomOut_HeadToHead}
		LoadSound \{Menu_Options_Sound_Select}
		LoadSound \{Menu_Options_Sound_Back}
		LoadSound \{Menu_Options_Sound_Fader_Move}
		LoadSound \{Menu_Options_Sound_DolbyDigitalDisable}
		LoadSound \{Menu_Options_Sound_DolbyDigitalEnable}
		LoadSound \{Menu_EnterName_Select}
		LoadSound \{Menu_EnterName_Scroll_1}
		LoadSound \{Menu_EnterName_Finish_01}
		LoadSound \{Menu_EnterName_Back}
		LoadSound \{Menu_EnterName_Caps}
		LoadSound \{Menu_ColorWheel_GradientSelect}
		LoadSound \{Menu_ColorWheel_Rotate}
		LoadSound \{Menu_ColorWheel_HighLight_Up_Down_3}
		LoadSound \{Menu_ColorWheel_Deselect_PiePiece}
		LoadSound \{Menu_ColorWheel_SelectPie}
		LoadSound \{Menu_Main_Intro}
		LoadSound \{Guitar_Select_Affirmation_1}
		LoadSound \{Drum_Select_Affirmation_01}
		LoadSound \{Bass_Select_Affirmation_02}
		LoadSound \{Mic_Select_Affirmation_01}
		LoadSound \{Band_leader_affirmation}
		LoadSound \{Menu_Cheat_Red}
		LoadSound \{Menu_Cheat_Yellow}
		LoadSound \{Menu_Cheat_Blue}
		LoadSound \{Menu_Cheat_Green}
		LoadSound \{Gig_Complete_Sponsor}
		LoadSound \{GigComplete_Unlock_Item_Text_Appear}
		LoadSound \{GigComplete_Unlock_New_Item}
		LoadSound \{Gig_Complete_Magazine_In}
		LoadSound \{Gig_Complete_Magazine_Out}
		LoadSound \{Gig_Unlock}
		LoadSound \{UI_GigBoard_Scroll}
		LoadSound \{UI_GigBoard_SwishIN}
		LoadSound \{SoundOptions_Menu_Reset}
		LoadSound \{HeavyRockSnare_Lvl_12_03}
		LoadSound \{Menu_Gigboard_CameraPan_Right}
		LoadSound \{Menu_Gigboard_CameraPan_Left}
		LoadSound \{Menu_Restore_Defaults}
		LoadSound \{Crowd_Group_Clap_03}
		LoadSound \{bad_note2}
		LoadSound \{Pre_Cutscence_SFX}
		LoadSound \{CheckBox_Check_SFX_2}
		if ($Menu_Music_On_Flag = 1)
			EnableMenuMusic
		endif
		default

	endswitch
endscript

script LoadTutorialSFX \{mode = none}
	if ($g_current_sfx_mode = jammode)
		ReloadSfx \{mode = tutorials
			tutorial = jam}
	elseif ($g_current_sfx_mode = battle)
		ReloadSfx \{mode = tutorials
			tutorial = battle
			noreset = 1}
	elseif ($g_current_sfx_mode != tutorials)
		ReloadSfx \{mode = tutorials
			tutorial = 0}
	endif
	if ($TutorialSFXLoaded = <mode>)
		return
	endif
	RestoreSPUPosition
	switch <mode>
		case Tut_Gtr_HoldGuitar
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HoldGuitar_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HoldGuitar_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HoldGuitar_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HoldGuitar_08_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HoldGuitar_09_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HoldGuitar_10_GTR}
		case Tut_Gtr_GuitarTune
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_GuitarTune_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_GuitarTune_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_GuitarTune_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_GuitarTune_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_GuitarTune_05_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_GuitarTune_10_GTR}
		LoadSound \{A_Tuning}
		LoadSound \{A_String}
		LoadSound \{B_Tuning}
		LoadSound \{B_String}
		LoadSound \{D_Tuning}
		LoadSound \{D_String}
		LoadSound \{G_Tuning}
		LoadSound \{G_String}
		LoadSound \{E_Tuning}
		LoadSound \{E_String}
		case Tut_Gtr_PlayNotes
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_PlayNotes_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_PlayNotes_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_PlayNotes_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_PlayNotes_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_PlayNotes_05_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_PlayNotes_13_GTR}
		case Tut_Gtr_OpenNotes
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_OpenNotes_01_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_OpenNotes_02_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_OpenNotes_03_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_OpenNotes_04_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_OpenNotes_05_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_OpenNotes_13_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_OpenNotes_11_BAS}
		case Tut_Gtr_DiffNotes
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_DiffNotes_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_DiffNotes_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_DiffNotes_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_DiffNotes_11_GTR}
		case Tut_Gtr_LongNotes
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_LongNotes_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_LongNotes_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_LongNotes_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_LongNotes_13_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_LongNotes_11_GTR}
		case Tut_Gtr_Chords
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Chords_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Chords_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Chords_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Chords_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Chords_12_GTR}
		case Tut_Gtr_UI
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_UI_01_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_UI_02_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_UI_03_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_UI_04_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_UI_05_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_UI_06_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_UI_07_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_UI_08_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_UI_09_BAS}
		case Tut_Gtr_StarPower
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StarPower_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StarPower_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StarPower_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StarPower_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StarPower_05_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StarPower_06_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StarPower_07_GTR}
		case Tut_Gtr_Whammy
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Whammy_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Whammy_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Whammy_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Whammy_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Whammy_05_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Whammy_06_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Whammy_07_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Whammy_15_GTR}
		case Tut_Gtr_ActivatingSP
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_ActivatingSP_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_ActivatingSP_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_ActivatingSP_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_ActivatingSP_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_ActivatingSP_08_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_ActivatingSP_09_GTR}
		case Tut_Gtr_StringBasics
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StringBasics_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StringBasics_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StringBasics_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StringBasics_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StringBasics_05_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_StringBasics_06_GTR}
		case Tut_Gtr_HOFinger
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HOFinger_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HOFinger_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HOFinger_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HOFinger_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HOFinger_05_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HOFinger_06_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HOFinger_07_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HOFinger_08_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HOFinger_15_GTR}
		case Tut_Gtr_HamOns
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HamOns_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HamOns_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_HamOns_10_GTR}
		case Tut_Gtr_POFinger
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_POFinger_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_POFinger_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_POFinger_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_POFinger_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_POFinger_05_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_POFinger_06_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_POFinger_07_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_POFinger_08_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_POFinger_15_GTR}
		case Tut_Gtr_PullOffs
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_PullOffs_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_PullOffs_09_GTR}
		case Tut_Gtr_Sustains
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Sustains_01_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Sustains_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Sustains_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Sustains_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_Sustains_13_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_01_GTR}
		case Tut_Gtr_SliderTap
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_02_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_03_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_04_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_05_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_06_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_07_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_14_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_15_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_17_GTR}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Gtr_SliderTap_18_GTR}
		case Tut_Dru_HoldSticks
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_HoldSticks_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_HoldSticks_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_HoldSticks_03_DRM}
		case Tut_Dru_DrumTest
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_DrumTest_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_DrumTest_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_DrumTest_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_DrumTest_04_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_DrumTest_05_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_DrumTest_06_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_DrumTest_07_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_DrumTest_08_DRM}
		case Tut_Dru_OneHand
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_OneHand_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_OneHand_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_OneHand_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_OneHand_04_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_OneHand_05_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_OneHand_06_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_OneHand_07_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_OneHand_08_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_OneHand_12_DRM}
		case Tut_Dru_TwoHands
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_TwoHands_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_TwoHands_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_TwoHands_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_TwoHands_04_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_TwoHands_06_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_TwoHands_07_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_TwoHands_08_DRM}
		case Tut_Dru_KickPedal
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_KickPedal_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_KickPedal_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_KickPedal_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_KickPedal_04_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_KickPedal_05_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_KickPedal_06_DRM}
		case Tut_Dru_KickSong
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_KickSong_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_KickSong_02_DRM}
		case Tut_Dru_Impro
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Impro_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Impro_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_KickSong_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_TwoHands_05_DRM}
		case Tut_Dru_UI
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_UI_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_UI_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_UI_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_UI_04_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_UI_05_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_UI_06_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_UI_07_DRM}
		case Tut_Dru_Accents
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Accents_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Accents_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Accents_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Accents_04_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Accents_05_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_Accents_06_DRM}
		case Tut_Dru_FirstDrum
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_FirstDrum_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_FirstDrum_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_FirstDrum_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_FirstDrum_04_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_FirstDrum_05_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_FirstDrum_06_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_FirstDrum_07_DRM}
		case Tut_Dru_AddDrum
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_AddDrum_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_AddDrum_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_AddDrum_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_AddDrum_04_DRM}
		case Tut_Dru_AddKick
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_AddKick_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_AddKick_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_AddKick_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_AddKick_04_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_AddKick_05_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_AddKick_06_DRM}
		case Tut_Dru_StarCombo
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_StarCombo_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_StarCombo_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_StarCombo_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_StarCombo_04_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_StarCombo_05_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_StarCombo_06_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_StarCombo_08_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_StarCombo_09_DRM}
		case Tut_Dru_ActStarPow
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_ActStarPow_01_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_ActStarPow_02_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_ActStarPow_03_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_ActStarPow_04_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_ActStarPow_05_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_ActStarPow_06_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_ActStarPow_07_DRM}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Dru_ActStarPow_09_DRM}
		case Tut_Vox_Intro
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Intro_01_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Intro_02_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Intro_03_VOX}
		case Tut_Vox_Highway
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Highway_01_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Highway_02_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Highway_03_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Highway_05_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Highway_06_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Highway_07_VOX}
		case Tut_Vox_HitNotes
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_01_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_02_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_03_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_04_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_05_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_06_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_07_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_08_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_09_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_10_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_HitNotes_11_VOX}
		case Tut_Vox_Meter
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Meter_01_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Meter_02_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Meter_03_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Meter_04_VOX}
		case Tut_Vox_Words
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_01_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_02_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_03_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_04_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_05_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_06_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_07_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_08_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_09_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_10_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Words_11_VOX}
		case Tut_Vox_Freeform
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Freeform_01_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Freeform_02_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Freeform_03_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Freeform_04_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Freeform_05_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Freeform_06_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Freeform_07_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Freeform_08_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Freeform_09_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_Freeform_10_VOX}
		case Tut_Vox_StarPower
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_StarPower_02_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_StarPower_03_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_StarPower_04_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_StarPower_05_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_StarPower_06_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_StarPower_07_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_StarPower_08_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_StarPower_09_VOX}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vox_StarPower_10_VOX}
		case Tut_Vs_Modes
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_Modes_01_BAS}
		case Tut_Vs_FaceOff
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_FaceOff_01_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_FaceOff_02_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_FaceOff_03_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_FaceOff_04_BAS}
		case Tut_Vs_Battle
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_Battle_01_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_Battle_02_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_Battle_03_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_Battle_04_BAS}
		case Tut_Vs_BattleTilt
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_BattleTilt_01_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_BattleTilt_02_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_BattleTilt_03_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_BattleTilt_04_BAS}
		case Tut_Vs_DiffAttacks
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_DiffAttacks_01_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_DiffAttacks_02_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_DiffAttacks_03_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_DiffAttacks_04_BAS}
		case Tut_Vs_Multiples
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_Multiples_01_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_Multiples_02_BAS}
		case Tut_Vs_DoOrDie
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_DoOrDie_01_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_DoOrDie_02_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Vs_DoOrDie_03_BAS}
		case Tut_Band_Intro
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Intro_01_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Intro_02_BAS}
		case Tut_Band_Play
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Play_01_BAS}
		case Tut_Band_Star
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Star_01_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Star_02_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Star_03_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Star_04_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Star_05_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Star_06_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Star_07_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Star_08_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Star_09_BAS}
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Star_10_BAS}
		case Tut_Band_Vs
		LoadTutorialSFXWithPrefix \{Sound = Tut_Band_Vs_01_BAS}
		default

	endswitch
	change TutorialSFXLoaded = <mode>
endscript

script LoadEncoreBuildSound 
	GetPakManCurrent \{map = zones}
	GetVenueCrowdSize
	switch <VenueSize>
		case 'Small_INT'
		LoadSound \{Small_INT_Encore_Crowd}
		LoadSound \{INT_SM_Crowd_Applause_01}
		LoadSound \{INT_SM_Crowd_Good_Loop}
		case 'Medium_EXT'
		LoadSound \{Medium_EXT_Encore_Crowd}
		LoadSound \{EXT_MD_Crowd_Applause_02}
		LoadSound \{EXT_MD_Crowd_Swell_SH_01}
		LoadSound \{EXT_MD_Crowd_Good_Loop}
		case 'Large_EXT'
		LoadSound \{Large_EXT_Encore_Crowd}
		LoadSound \{EXT_LG_Crowd_Applause_01}
		LoadSound \{EXT_LG_Crowd_Good_Loop}
	endswitch
	LoadSound \{Callout_A_5}
	LoadSound \{Callout_B_3}
	LoadSound \{Callout_C_22}
	LoadSound \{Callout_D_17}
	LoadSound \{Callout_D_8}
	LoadSound \{Callout_E_7}
endscript
