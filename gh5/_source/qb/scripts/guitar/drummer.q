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

script Drummer_Transit 
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	smooth_transit_curve_Body = [1.0 , 0.99960196 , 0.9982739 , 0.995815 , 0.992026 , 0.98671097 , 0.9796699 , 0.97069895 , 0.95959204 , 0.946134 , 0.93010396 , 0.91126895 , 0.889385 , 0.86419207 , 0.835415 , 0.802758 , 0.76589996 , 0.724496 , 0.6781651 , 0.626492 , 0.569015 , 0.505221 , 0.434534 , 0.35751104 , 0.281412 , 0.20999001 , 0.145196 , 0.0889148 , 0.043468494 , 0.0121238 , 0.0]
	smooth_transit_curve_Arm = [1.0 , 0.99872696 , 0.994802 , 0.988059 , 0.978324 , 0.96540695 , 0.949108 , 0.9292079 , 0.905469 , 0.87763 , 0.845403 , 0.80846906 , 0.76646996 , 0.719005 , 0.665619 , 0.605793 , 0.53893197 , 0.464341 , 0.38269204 , 0.30501202 , 0.23405398 , 0.17038701 , 0.114788994 , 0.068295404 , 0.032288197 , 0.00864603 , 0.0]
	smooth_transit_curve_Ik = [1.0 , 0.996066 , 0.984568 , 0.96588695 , 0.940315 , 0.90806997 , 0.869298 , 0.82408 , 0.772429 , 0.714292 , 0.6495411 , 0.57796204 , 0.49924302 , 0.413491 , 0.331354 , 0.25736797 , 0.19188 , 0.13525799 , 0.0878982 , 0.050220903 , 0.0226798 , 0.0057634 , 0.0]
	time_to_trans = (<time_to_trans> / 1000.0)
	time_to_Hit_1 = (<time_to_Hit_1> / 1000.0)
	time_to_trans_IK = <time_to_trans>
	time_to_trans_Body = <time_to_trans>
	time_to_trans_Arm = <time_to_trans>
	if (<tapin> = true)
		FormatText \{checksumname = QHit_R
			'DrumDroid_CountOff_QHit_R'}
		FormatText \{checksumname = MHit_R
			'DrumDroid_CountOff_MHit_R'}
		FormatText \{checksumname = SHit_R
			'DrumDroid_CountOff_SHit_R'}
		FormatText \{checksumname = QHit_L
			'DrumDroid_CountOff_QHit_L'}
		FormatText \{checksumname = MHit_L
			'DrumDroid_CountOff_MHit_L'}
		FormatText \{checksumname = SHit_L
			'DrumDroid_CountOff_SHit_L'}
		FormatText checksumname = Base 'Drum_%a' a = <Drum_Target_State_String>
		FormatText checksumname = Base_IK 'Drum_IK_%a' a = <Drum_Target_State_String>
		FormatText checksumname = Base_Arm 'Drum_Arm_%a' a = <Drum_Target_State_String>
		tapin = false
		Idle = false
		Should_Idle = false
	else
		FormatText checksumname = QHit_R 'Drum_%a_QHit_R' a = <Drum_Target_State_String>
		FormatText checksumname = MHit_R 'Drum_%a_MHit_R' a = <Drum_Target_State_String>
		FormatText checksumname = SHit_R 'Drum_%a_SHit_R' a = <Drum_Target_State_String>
		FormatText checksumname = QHit_L 'Drum_%a_QHit_L' a = <Drum_Target_State_String>
		FormatText checksumname = MHit_L 'Drum_%a_MHit_L' a = <Drum_Target_State_String>
		FormatText checksumname = SHit_L 'Drum_%a_SHit_L' a = <Drum_Target_State_String>
		FormatText checksumname = Base 'Drum_%a' a = <Drum_Target_State_String>
		FormatText checksumname = Base_IK 'Drum_IK_%a' a = <Drum_Target_State_String>
		FormatText checksumname = Base_Arm 'Drum_Arm_%a' a = <Drum_Target_State_String>
	endif
	GetTags \{Idle}
	GetTags \{tap}
	Time_From_Idle = (((1 - $Drum_Idlepoint_Arm_SHit) * $Drum_Slowest_Arm_Hit) / 1000.0)
	if (<Idle> = true)
		if (<time_to_Hit_1> > <Time_From_Idle>)
			waittime = (<time_to_Hit_1> - <Time_From_Idle>)
			Wait <waittime> seconds
			Obj_KillSpawnedScript \{name = Drummer_Transit_Idles}
			time_to_trans = ((<time_to_trans> - <time_to_Hit_1>) + <Time_From_Idle>)
			SetTags \{Idle = false}
			Obj_SpawnScriptNow Drummer_Transit_Loops params = {state = in BlendDuration = <time_to_trans>}
		else
			Obj_KillSpawnedScript \{name = Drummer_Transit_Idles}
			SetTags \{Idle = false}
			Obj_SpawnScriptNow Drummer_Transit_Loops params = {state = in BlendDuration = <time_to_trans>}
		endif
	else
		if (<Should_Idle> = true)
			Obj_KillSpawnedScript \{name = Drummer_Transit_Loops}
			Obj_SpawnScriptNow Drummer_Transit_Idles params = {state = in tap = <tap>}
			waittime = (<time_to_Hit_1> - <Time_From_Idle>)
			Wait <waittime> seconds
			Obj_KillSpawnedScript \{name = Drummer_Transit_Idles}
			time_to_trans = ((<time_to_trans> - <time_to_Hit_1>) + <Time_From_Idle>)
			Obj_SpawnScriptNow Drummer_Transit_Loops params = {state = in BlendDuration = <time_to_trans>}
		endif
	endif
	if (<time_to_trans> < 0.0)
		time_to_trans = 0.0
	endif
	create_Trans_diff time_to_trans = <time_to_trans>
	Anim_Command target = DB_Drum_SHit_R_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = <SHit_R>
		}
	}
	Anim_Command target = DB_Drum_MHit_R_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = <MHit_R>
		}
	}
	Anim_Command target = DB_Drum_QHit_R_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = <QHit_R>
		}
	}
	Anim_Command target = DB_Drum_SHit_L_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = <SHit_L>
		}
	}
	Anim_Command target = DB_Drum_MHit_L_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = <MHit_L>
		}
	}
	Anim_Command target = DB_Drum_QHit_L_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = <QHit_L>
		}
	}
	Anim_Command target = DB_Drum_Transition_Base_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans_Body>
		blendcurve = <smooth_transit_curve_Body>
		Tree = $Single_Source_tree
		params = {
			Use_anim = <Base>
		}
	}
	Anim_Command target = DB_Drum_Transition_Arm_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans_Arm>
		blendcurve = <smooth_transit_curve_Arm>
		Tree = $Single_Source_tree
		params = {
			Use_anim = <Base_Arm>
		}
	}
	Anim_Command target = DB_Drum_Transition_IK_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = <time_to_trans_IK>
		blendcurve = <smooth_transit_curve_Ik>
		Tree = $Single_Source_tree
		params = {
			Use_anim = <Base_IK>
		}
	}
	SetTags tap = <tapin>
endscript

script Drummer_Transit_Idles 
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	SetTags \{Idle = true}
	if NOT GotParam \{Last_Hit}
		Last_Hit = false
	endif
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
	if (<tap> = false)
		Obj_SpawnScriptNow Default_drummer_State params = {BlendDuration = <BlendDuration>}
	endif
	begin
	if (<Last_Hit> = true)
		GetRandomValue \{name = randomanim
			Integer
			a = 1
			b = 5}
		switch <randomanim>
			case 1
			Anim = DrumDroid_PeerIntoCrowd_InOut
			case 2
			Anim = DrumDroid_FistPump_InOut
			case 3
			Anim = DrumDroid_Outro_02
			case 4
			Anim = DrumDroid_Outro_04
			case 5
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
	oldset = d
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
	begin
	Current_Tempo = $Current_Tempo
	if (<Current_Tempo> < 85.0)
		set = a
	elseif (<Current_Tempo> > 115.0)
		set = c
	else
		set = b
	endif
	if (<oldset> != <set>)
		if (<set> = a)
			Loop_Body = Drum_Loop_HighEnergy_075
			oldset = a
		elseif (<set> = b)
			Loop_Body = Drum_Loop_HighEnergy_100
			oldset = b
		elseif (<set> = c)
			Loop_Body = Drum_Loop_HighEnergy_120
			oldset = c
		endif
		if (<BlendDuration> < 0.0)
			BlendDuration = 0.0
		endif
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
	endif
	Wait <blend_duration> seconds
	BlendDuration = 0.6
	begin
	if (<Current_Tempo> = $Current_Tempo)
		Wait \{1
			gameframe}
	else
		break
	endif
	repeat
	repeat
endscript

script create_Trans_diff 
	Short_Trans = 0.1
	Short_Trans_Diff = 2.5
	Long_Trans = 0.9
	Long_Trans_Diff = 1.5
	if (<time_to_trans> > <Long_Trans>)
		Trans_Diff = <Long_Trans_Diff>
	elseif (<time_to_trans> < <Short_Trans>)
		Trans_Diff = <Short_Trans_Diff>
	else
		Trans_Diff = (((<Long_Trans> - <time_to_trans>) / (<Long_Trans> - <Short_Trans>)))
		Trans_Diff = ((<Short_Trans_Diff> * <Trans_Diff>) + (<Long_Trans_Diff> * (1 - <Trans_Diff>)))
	endif
	time_to_trans_IK = (<time_to_trans> * 1.1)
	time_to_trans_Body = (<time_to_trans_IK> * <Trans_Diff>)
	time_to_trans_Arm = ((<time_to_trans_IK> + <time_to_trans_Body>) / 2)
	return time_to_trans_IK = <time_to_trans_IK> time_to_trans_Body = <time_to_trans_Body> time_to_trans_Arm = <time_to_trans_Arm>
endscript

script Default_Kit_anims 
	<name> :Anim_Command target = DB_Drum_Cymbal_1 command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.2
		Tree = $GH_Drum_Cymbal_1_Branch
		params = {
			strength = 1.0
		}
	}
	<name> :Anim_Command target = DB_Drum_Cymbal_2 command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.2
		Tree = $GH_Drum_Cymbal_2_Branch
		params = {
			strength = 1.0
		}
	}
	<name> :Anim_Command target = DB_Drum_Cymbal_3 command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.2
		Tree = $GH_Drum_Cymbal_3_Branch
		params = {
			strength = 1.0
			Anim = GH_Drum_Cymbal_3_1
		}
	}
	<name> :Anim_Command target = DB_Drum_HH command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.2
		Tree = $GH_Drum_HH_Branch
		params = {
			strength = 1.0
		}
	}
endscript

script Default_drummer_State 
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	smooth_transit_curve_Body = [1.0 , 0.99960196 , 0.9982739 , 0.995815 , 0.992026 , 0.98671097 , 0.9796699 , 0.97069895 , 0.95959204 , 0.946134 , 0.93010396 , 0.91126895 , 0.889385 , 0.86419207 , 0.835415 , 0.802758 , 0.76589996 , 0.724496 , 0.6781651 , 0.626492 , 0.569015 , 0.505221 , 0.434534 , 0.35751104 , 0.281412 , 0.20999001 , 0.145196 , 0.0889148 , 0.043468494 , 0.0121238 , 0.0]
	smooth_transit_curve_Arm = [1.0 , 0.99872696 , 0.994802 , 0.988059 , 0.978324 , 0.96540695 , 0.949108 , 0.9292079 , 0.905469 , 0.87763 , 0.845403 , 0.80846906 , 0.76646996 , 0.719005 , 0.665619 , 0.605793 , 0.53893197 , 0.464341 , 0.38269204 , 0.30501202 , 0.23405398 , 0.17038701 , 0.114788994 , 0.068295404 , 0.032288197 , 0.00864603 , 0.0]
	smooth_transit_curve_Ik = [1.0 , 0.996066 , 0.984568 , 0.96588695 , 0.940315 , 0.90806997 , 0.869298 , 0.82408 , 0.772429 , 0.714292 , 0.6495411 , 0.57796204 , 0.49924302 , 0.413491 , 0.331354 , 0.25736797 , 0.19188 , 0.13525799 , 0.0878982 , 0.050220903 , 0.0226798 , 0.0057634 , 0.0]
	create_Trans_diff time_to_trans = <BlendDuration>
	Anim_Command target = DB_Drum_SHit_R_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.001
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = DrumDroid_CountOff_SHit_R
		}
	}
	Anim_Command target = DB_Drum_MHit_R_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.001
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = DrumDroid_CountOff_MHit_R
		}
	}
	Anim_Command target = DB_Drum_QHit_R_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.001
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = DrumDroid_CountOff_QHit_R
		}
	}
	Anim_Command target = DB_Drum_SHit_L_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.001
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = DrumDroid_CountOff_SHit_L
		}
	}
	Anim_Command target = DB_Drum_MHit_L_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.001
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = DrumDroid_CountOff_MHit_L
		}
	}
	Anim_Command target = DB_Drum_QHit_L_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.001
		blendcurve = <smooth_transit_curve>
		Tree = $Single_Source_Anim_Event_tree
		params = {
			Use_anim = DrumDroid_CountOff_QHit_L
		}
	}
	Anim_Command target = DB_Drum_Transition_Base_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.001
		blendcurve = <smooth_transit_curve_Body>
		Tree = $Single_Source_tree
		params = {
			Use_anim = Drum_S1T3
		}
	}
	Anim_Command target = DB_Drum_Transition_Arm_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.001
		blendcurve = <smooth_transit_curve_Arm>
		Tree = $Single_Source_tree
		params = {
			Use_anim = Drum_Arm_S1T3
		}
	}
	Anim_Command target = DB_Drum_Transition_IK_Anim command = DegenerateBlend_AddBranch params = {
		BlendDuration = 0.001
		blendcurve = <smooth_transit_curve_Ik>
		Tree = $Single_Source_tree
		params = {
			Use_anim = Drum_IK_S1T3
		}
	}
endscript
