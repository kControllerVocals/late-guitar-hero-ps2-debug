Current_Tempo = 100
drummer_active_values = [
	AV_Drum_Anim_Hand_L
	AV_Drum_Anim_Hand_R
	AV_Drum_Anim_Foot_R
	AV_Drum_Anim_Transit
	AV_Drum_Blend_Hand_L
	AV_Drum_Blend_Hand_R
	AV_Drum_Blend_Foot_R
	AV_Drum_Blend_HH_Kit
	AV_Drum_Mod_Loop_Body
	AV_Drum_Mod_Hand_R
	AV_Drum_Mod_Hand_L
	AV_Drum_Mod_Foot_R
	AV_Drum_IK_Hand_L
	AV_Drum_IK_Hand_R
	AV_Drum_IK_Feet
]

script Drummer_Transit_Base_Long 
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	if (<time_to_trans> < 0.0)
		time_to_trans = 0.0
	endif
	if (<time_to_trans_base> < 0.0)
		time_to_trans_base = 0.0
	endif
	if (<node> = Body)
		target = DB_Drum_Transition_Base_Anim
		ExtendCRCWithString checksum = Drum_ string = <Drum_Old_Long_String>
		OldBase = <ExtendedChecksum>
		ExtendCRCWithString checksum = Drum_ string = <Drum_New_Long_String>
		NewBase = <ExtendedChecksum>
		switch <currentset>
			case 1
			master_node = DB_Drum_Base_Master1
			master_tree = $Drum_Base_Branch_Master1
			tree1 = $Drum_Base_Branch_Old1
			target1 = DB_Drum_Base_Anim_Old1
			tree2 = $Drum_Base_Branch_New1
			target2 = DB_Drum_Base_Anim_New1
			case 2
			master_node = DB_Drum_Base_Master2
			master_tree = $Drum_Base_Branch_Master2
			tree1 = $Drum_Base_Branch_Old2
			target1 = DB_Drum_Base_Anim_Old2
			tree2 = $Drum_Base_Branch_New2
			target2 = DB_Drum_Base_Anim_New2
			case 3
			master_node = DB_Drum_Base_Master3
			master_tree = $Drum_Base_Branch_Master3
			tree1 = $Drum_Base_Branch_Old3
			target1 = DB_Drum_Base_Anim_Old3
			tree2 = $Drum_Base_Branch_New3
			target2 = DB_Drum_Base_Anim_New3
			case 4
			master_node = DB_Drum_Base_Master4
			master_tree = $Drum_Base_Branch_Master4
			tree1 = $Drum_Base_Branch_Old4
			target1 = DB_Drum_Base_Anim_Old4
			tree2 = $Drum_Base_Branch_New4
			target2 = DB_Drum_Base_Anim_New4
		endswitch
	else
		target = DB_Drum_Transition_BaseIK_Anim
		ExtendCRCWithString checksum = Drum_ string = <Drum_Old_Long_String>
		OldPrefix = <ExtendedChecksum>
		ExtendCRCWithString checksum = <OldPrefix> string = '_IK'
		OldBase = <ExtendedChecksum>
		ExtendCRCWithString checksum = Drum_ string = <Drum_New_Long_String>
		NewPrefix = <ExtendedChecksum>
		ExtendCRCWithString checksum = <NewPrefix> string = '_IK'
		NewBase = <ExtendedChecksum>
		switch <currentset>
			case 1
			master_node = DB_Drum_BaseIK_Master1
			master_tree = $Drum_BaseIK_Branch_Master1
			tree1 = $Drum_BaseIK_Branch_Old1
			target1 = DB_Drum_BaseIK_Anim_Old1
			tree2 = $Drum_BaseIK_Branch_New1
			target2 = DB_Drum_BaseIK_Anim_New1
			case 2
			master_node = DB_Drum_BaseIK_Master2
			master_tree = $Drum_BaseIK_Branch_Master2
			tree1 = $Drum_BaseIK_Branch_Old2
			target1 = DB_Drum_BaseIK_Anim_Old2
			tree2 = $Drum_BaseIK_Branch_New2
			target2 = DB_Drum_BaseIK_Anim_New2
			case 3
			master_node = DB_Drum_BaseIK_Master3
			master_tree = $Drum_BaseIK_Branch_Master3
			tree1 = $Drum_BaseIK_Branch_Old3
			target1 = DB_Drum_BaseIK_Anim_Old3
			tree2 = $Drum_BaseIK_Branch_New3
			target2 = DB_Drum_BaseIK_Anim_New3
			case 4
			master_node = DB_Drum_BaseIK_Master4
			master_tree = $Drum_BaseIK_Branch_Master4
			tree1 = $Drum_BaseIK_Branch_Old4
			target1 = DB_Drum_BaseIK_Anim_Old4
			tree2 = $Drum_BaseIK_Branch_New4
			target2 = DB_Drum_BaseIK_Anim_New4
		endswitch
	endif
	Anim_Command target = <target> command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans_base>
		blendcurve = <smooth_transit_curve>
		Tree = <master_tree>
		params = {
		}
	}
	Anim_Command target = <master_node> command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.0
		blendcurve = <smooth_transit_curve>
		Tree = <tree1>
		params = {
		}
	}
	if Anim_AnimNodeExists id = <target1>
		Anim_Command target = <target1> command = DegenerateBlend_AddBranch params = {
			BlendDuration = 0.0
			Tree = $Single_Source_tree
			params = {
				Use_anim = <OldBase>
			}
		}
	endif
	Anim_Command target = <master_node> command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = <tree2>
		params = {
		}
	}
	if Anim_AnimNodeExists id = <target2>
		Anim_Command target = <target2> command = DegenerateBlend_AddBranch params = {
			BlendDuration = 0.0
			Tree = $Single_Source_tree
			params = {
				Use_anim = <NewBase>
			}
		}
	endif
	Drum_Old_Long_String = 'S1T3'
	Drum_New_Long_String = 'S1T3'
	currentset = 0
	OldBase = Drum_S1T3
	NewBase = Drum_S1T3
	ExtendedChecksum = null
endscript

script Drummer_Anticipation_Arms 
	smooth_In = [1.0 , 0.99024594 , 0.95976996 , 0.906626 , 0.82877296 , 0.724314 , 0.59211797 , 0.43345502 , 0.256324 , 0.0871634 , 0.0]
	if (<Blendtime> < 0.0)
		Blendtime = 0.0
	endif
	Anim_Command target = <target> command = DegenerateBlend_AddBranch params = {
		BlendDuration = <Blendtime>
		blendcurve = <smooth_In>
		Tree = <Tree>
		params = {
		}
	}
	if Anim_AnimNodeExists id = <target2>
		Anim_Command target = <target2> command = DegenerateBlend_AddBranch params = {
			BlendDuration = 0.0
			Tree = $Sorce_Mod_Branch
			params = {
				strength = <strength>
				Use_anim = <Anim>
			}
		}
	endif
endscript

script Drummer_Anticipation_Arms_Out 
	smooth_Out = [1.0 , 0.970518 , 0.86650604 , 0.68276 , 0.471731 , 0.296009 , 0.17043701 , 0.086863294 , 0.0352961 , 0.0081358 , 0.0]
	if Anim_AnimNodeExists id = <target2>
		Anim_Command target = <target2> command = DegenerateBlend_AddBranch params = {
			blendcurve = <smooth_Out>
			BlendDuration = <Blendtime>
			Tree = $Sorce_Mod_Branch_blank
			params = {
			}
		}
	endif
endscript

script Drummer_Transit_Idles 
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	Obj_GetID
	switch <ObjID>
		case musician1
		start = 0.0
		case musician2
		start = 0.25
		case musician3
		start = 0.5
		case musician4
		start = 0.75
		default
		start = 0.0
	endswitch
	BlendDuration = (($Drum_Idlepoint_Arm_SHit * $Drum_Slowest_Arm_Hit) / 1000.0)
	if (<tapin> = false)
		Obj_SpawnScriptNow Default_drummer_State params = {time_to_trans = <BlendDuration> currentset = <currentset>}
	endif
	begin
	if (<Last_Hit> = true)
		GetRandomValue \{name = randomanim
			Integer
			a = 1
			b = 4}
		switch <randomanim>
			case 1
			Anim = DrumDroid_PeerIntoCrowd_InOut
			case 2
			Anim = DrumDroid_FistPump_InOut
			case 3
			Anim = DrumDroid_Outro_02
			case 4
			Anim = DrumDroid_Outro_05
		endswitch
	else
		GetRandomValue \{name = randomanim
			Integer
			a = 1
			b = 6}
		switch <randomanim>
			case 1
			Anim = DrumDroid_LoosenUp_In
			case 2
			Anim = DrumDroid_PeerIntoCrowd_InOut
			case 3
			Anim = DrumDroid_FistPump_InOut
			case 4
			Anim = DrumDroid_ArmAtReady_In
			case 5
			Anim = DrumDroid_LittleChairTwist_In
			case 6
			Anim = DrumDroid_PointCenter_In
		endswitch
	endif
	SetSearchAllAssetContexts
	if Anim_AnimExists Anim = <Anim>
		anim_Getanimlength Anim = <Anim>
	else
		length = 5.0
	endif
	SetSearchAllAssetContexts \{off}
	length = (<length> - <BlendDuration>)
	if (<length> < 0)
		length = 0
	endif
	if (<BlendDuration> < 0.0)
		BlendDuration = 0.0
	endif
	Anim_Command target = DB_Drum_Loop_Anim_Tempo command = DegenerateBlend_AddBranch params = {
		BlendDuration = <BlendDuration>
		Tree = $Drum_Loop_Anim_NoTempo
		params = {
			start = <start>
			Loop_Tempo_Anim = <Anim>
			Loop_Anim_Body = <Anim>
		}
	}
	BlendDuration = 0.6
	Wait <length> seconds
	Last_Hit = false
	repeat
	currentset = 0
	ObjID = musician1
	randomanim = 0
endscript

script Drummer_Transit_Loops 
	Obj_GetID
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	switch <ObjID>
		case musician1
		start = 0.0
		case musician2
		start = 0.25
		case musician3
		start = 0.5
		case musician4
		start = 0.75
		default
		start = 0.0
	endswitch
	if (<BlendDuration> < 0.0)
		BlendDuration = 0.0
	endif
	Current_Tempo = $Current_Tempo
	if (<Current_Tempo> < 85.0)
		Loop_Body = Drum_Loop_HighEnergy_075
	elseif (<Current_Tempo> > 115.0)
		Loop_Body = Drum_Loop_HighEnergy_120
	else
		Loop_Body = Drum_Loop_HighEnergy_100
	endif
	begin
	Anim_Command target = DB_Drum_Loop_Anim_Tempo command = DegenerateBlend_AddBranch params = {
		BlendDuration = <BlendDuration>
		blendcurve = <smooth_transit_curve>
		Tree = $Drum_Loop_Anim_Tempo
		params = {
			start = <start>
			Loop_Tempo_Anim = <Loop_Body>
			Loop_Anim_Body = <Loop_Body>
		}
	}
	Wait <blend_duration> seconds
	drumdroid_loop_wait
	repeat
endscript

script Drummer_Current_Tempo 
	tempo_change_threshold = 10.0
	begin
	floatvalue = 0.0
	GetPlayerFloat \{player = 1
		checksum = current_song_beat_time}
	current_song_beat_time = <floatvalue>
	tempo_bpm = ((1000.0 / <current_song_beat_time>) * 60.0)
	if (<tempo_bpm> > 202.5)
		tempo_bpm = (<tempo_bpm> / 3.0)
	elseif (<tempo_bpm> > 135.0)
		tempo_bpm = (<tempo_bpm> / 2.0)
	elseif (<tempo_bpm> < 67.5)
		tempo_bpm = (<tempo_bpm> * 2.0)
	endif
	tempodiff = (<tempo_bpm> - $Current_Tempo)
	if (<tempodiff> < 0.0)
		tempodiff = (<tempodiff> * (0.0 -1.0))
	endif
	if (<tempodiff> > <tempo_change_threshold>)
		change Current_Tempo = <tempo_bpm>
		Wait \{2
			seconds}
	endif
	Wait \{1
		gameframe}
	repeat
	current_song_beat_time = 0
endscript

script Set_drummer_Active_Values 
	Obj_GetID
	<ObjID> :AnimPreview_SetSourceValues {
		AV_Drum_Anim_Hand_L = <AV_Drum_Anim_Hand_L>
		AV_Drum_Anim_Hand_R = <AV_Drum_Anim_Hand_R>
		AV_Drum_Anim_Foot_R = <AV_Drum_Anim_Foot_R>
		AV_Drum_Blend_Hand_L = <AV_Drum_Blend_Hand_L>
		AV_Drum_Blend_Hand_R = <AV_Drum_Blend_Hand_R>
		AV_Drum_Blend_Foot_R = <AV_Drum_Blend_Foot_R>
		AV_Drum_Blend_HH_Kit = <AV_Drum_Blend_HH_Kit>
		AV_Drum_Mod_Loop_Body = <AV_Drum_Mod_Loop_Body>
		AV_Drum_Mod_Hand_R = <AV_Drum_Mod_Hand_R>
		AV_Drum_Mod_Hand_L = <AV_Drum_Mod_Hand_L>
		AV_Drum_Mod_Foot_R = <AV_Drum_Mod_Foot_R>
		AV_Drum_IK_Hand_L = <AV_Drum_IK_Hand_L>
		AV_Drum_IK_Hand_R = <AV_Drum_IK_Hand_R>
	}
	ObjID = musician0
	AV_Drum_Anim_Hand_L = 0.0
	AV_Drum_Anim_Hand_R = 0.0
	AV_Drum_Anim_Foot_R = 0.0
	AV_Drum_Blend_Hand_L = 0.0
	AV_Drum_Blend_Hand_R = 0.0
	AV_Drum_Blend_Foot_R = 0.0
	AV_Drum_Blend_HH_Kit = 0.0
	AV_Drum_Mod_Loop_Body = 0.0
	AV_Drum_Mod_Hand_R = 0.0
	AV_Drum_Mod_Hand_L = 0.0
	AV_Drum_Mod_Foot_R = 0.0
	AV_Drum_IK_Hand_L = 0.0
	AV_Drum_IK_Hand_R = 0.0
endscript

script Hit_DrumKit_Piece \{strength = 0.0}
	BlendDuration = 0.25
	if (<pieces_Hit> = 2)
		Anim_Command \{target = DB_Drum_HH
			command = DegenerateBlend_AddBranch
			params = {
				BlendDuration = 0.2
				Tree = $GH_Drum_HH_Branch
				params = {
					strength = 1.0
				}
			}}
	elseif (<pieces_Hit> = 3)
		Anim_Command target = DB_Drum_Cymbal_1 command = DegenerateBlend_AddBranch params = {
			BlendDuration = <BlendDuration>
			Tree = $GH_Drum_Cymbal_1_Branch
			params = {
				strength = <strength>
			}
		}
	elseif (<pieces_Hit> = 6)
		Anim_Command target = DB_Drum_Cymbal_2 command = DegenerateBlend_AddBranch params = {
			BlendDuration = <BlendDuration>
			Tree = $GH_Drum_Cymbal_2_Branch
			params = {
				strength = <strength>
			}
		}
	elseif (<pieces_Hit> = 8)
		Anim_Command target = DB_Drum_Cymbal_3 command = DegenerateBlend_AddBranch params = {
			BlendDuration = <BlendDuration>
			Tree = $GH_Drum_Cymbal_3_Branch
			params = {
				strength = <strength>
				Anim = Random (@ GH_Drum_Cymbal_3_1 @ GH_Drum_Cymbal_3_2 @ GH_Drum_Cymbal_3_3 )
			}
		}
	endif
endscript

script Default_Kit_anims 
	<name> :Anim_Command target = DB_Drum_Cymbal_1 command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.0
		Tree = $GH_Drum_Cymbal_1_Branch
		params = {
			strength = 0.0
		}
	}
	<name> :Anim_Command target = DB_Drum_Cymbal_2 command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.0
		Tree = $GH_Drum_Cymbal_2_Branch
		params = {
			strength = 0.0
		}
	}
	<name> :Anim_Command target = DB_Drum_Cymbal_3 command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.0
		Tree = $GH_Drum_Cymbal_3_Branch
		params = {
			strength = 0.0
			Anim = GH_Drum_Cymbal_3_1
		}
	}
	<name> :Anim_Command target = DB_Drum_HH command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.0
		Tree = $GH_Drum_HH_Branch
		params = {
			strength = 0.0
		}
	}
endscript

script Default_drummer_State 
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	switch <currentset>
		case 1
		TargetIK1 = DB_Drum_BaseIK_Anim_Old1
		targetIK2 = DB_Drum_BaseIK_Anim_New1
		target1 = DB_Drum_Base_Anim_Old1
		target2 = DB_Drum_Base_Anim_New1
		case 2
		TargetIK1 = DB_Drum_BaseIK_Anim_Old2
		targetIK2 = DB_Drum_BaseIK_Anim_New2
		target1 = DB_Drum_Base_Anim_Old2
		target2 = DB_Drum_Base_Anim_New2
		case 3
		TargetIK1 = DB_Drum_BaseIK_Anim_Old3
		targetIK2 = DB_Drum_BaseIK_Anim_New3
		target1 = DB_Drum_Base_Anim_Old3
		target2 = DB_Drum_Base_Anim_New3
		case 4
		TargetIK1 = DB_Drum_BaseIK_Anim_Old4
		targetIK2 = DB_Drum_BaseIK_Anim_New4
		target1 = DB_Drum_Base_Anim_Old4
		target2 = DB_Drum_Base_Anim_New4
	endswitch
	Anim_Command target = DB_Drum_SHit_R_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = Drum_S1T3_SHit_R
		}
	}
	Anim_Command target = DB_Drum_MHit_R_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = Drum_S1T3_MHit_R
		}
	}
	Anim_Command target = DB_Drum_QHit_R_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = Drum_S1T3_QHit_R
		}
	}
	Anim_Command target = DB_Drum_SHit_L_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = Drum_S1T3_SHit_L
		}
	}
	Anim_Command target = DB_Drum_MHit_L_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = Drum_S1T3_MHit_L
		}
	}
	Anim_Command target = DB_Drum_QHit_L_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = Drum_S1T3_QHit_L
		}
	}
	if Anim_AnimNodeExists id = <target1>
		Anim_Command target = <target1> command = DegenerateBlend_AddBranch params = {
			BlendDuration = <time_to_trans>
			blendcurve = <smooth_transit_curve>
			Tree = $Single_Source_tree
			params = {
				Use_anim = Drum_S1T3
			}
		}
	endif
	if Anim_AnimNodeExists id = <target2>
		Anim_Command target = <target2> command = DegenerateBlend_AddBranch params = {
			BlendDuration = <time_to_trans>
			blendcurve = <smooth_transit_curve>
			Tree = $Single_Source_tree
			params = {
				Use_anim = Drum_S1T3
			}
		}
	endif
	if Anim_AnimNodeExists id = <TargetIK1>
		Anim_Command target = <TargetIK1> command = DegenerateBlend_AddBranch params = {
			BlendDuration = <time_to_trans>
			blendcurve = <smooth_transit_curve>
			Tree = $Single_Source_tree
			params = {
				Use_anim = Drum_S1T3_IK
			}
		}
	endif
	if Anim_AnimNodeExists id = <targetIK2>
		Anim_Command target = <targetIK2> command = DegenerateBlend_AddBranch params = {
			BlendDuration = <time_to_trans>
			blendcurve = <smooth_transit_curve>
			Tree = $Single_Source_tree
			params = {
				Use_anim = Drum_S1T3_IK
			}
		}
	endif
	currentset = 0
	time_to_trans = 0.0
endscript
