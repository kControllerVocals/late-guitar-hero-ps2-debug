current_tempo = 100
drummer_active_values = [
	av_drum_anim_hand_l
	av_drum_anim_hand_r
	av_drum_anim_foot_r
	av_drum_anim_transit
	av_drum_blend_hand_l
	av_drum_blend_hand_r
	av_drum_blend_foot_r
	av_drum_blend_hh_kit
	av_drum_mod_loop_body
	av_drum_mod_hand_r
	av_drum_mod_hand_l
	av_drum_mod_foot_r
	av_drum_ik_hand_l
	av_drum_ik_hand_r
	av_drum_ik_feet
]

script drummer_transit 
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	smooth_transit_curve_body = [1.0 , 0.99960196 , 0.9982739 , 0.995815 , 0.992026 , 0.98671097 , 0.9796699 , 0.97069895 , 0.95959204 , 0.946134 , 0.93010396 , 0.91126895 , 0.889385 , 0.86419207 , 0.835415 , 0.802758 , 0.76589996 , 0.724496 , 0.6781651 , 0.626492 , 0.569015 , 0.505221 , 0.434534 , 0.35751104 , 0.281412 , 0.20999001 , 0.145196 , 0.0889148 , 0.043468494 , 0.0121238 , 0.0]
	smooth_transit_curve_arm = [1.0 , 0.99872696 , 0.994802 , 0.988059 , 0.978324 , 0.96540695 , 0.949108 , 0.9292079 , 0.905469 , 0.87763 , 0.845403 , 0.80846906 , 0.76646996 , 0.719005 , 0.665619 , 0.605793 , 0.53893197 , 0.464341 , 0.38269204 , 0.30501202 , 0.23405398 , 0.17038701 , 0.114788994 , 0.068295404 , 0.032288197 , 0.00864603 , 0.0]
	smooth_transit_curve_ik = [1.0 , 0.996066 , 0.984568 , 0.96588695 , 0.940315 , 0.90806997 , 0.869298 , 0.82408 , 0.772429 , 0.714292 , 0.6495411 , 0.57796204 , 0.49924302 , 0.413491 , 0.331354 , 0.25736797 , 0.19188 , 0.13525799 , 0.0878982 , 0.050220903 , 0.0226798 , 0.0057634 , 0.0]
	time_to_trans = (<time_to_trans> / 1000.0)
	time_to_hit_1 = (<time_to_hit_1> / 1000.0)
	time_to_trans_ik = <time_to_trans>
	time_to_trans_body = <time_to_trans>
	time_to_trans_arm = <time_to_trans>
	if (<tapin> = true)
		formattext \{checksumname = qhit_r
			'DrumDroid_CountOff_QHit_R'}
		formattext \{checksumname = mhit_r
			'DrumDroid_CountOff_MHit_R'}
		formattext \{checksumname = shit_r
			'DrumDroid_CountOff_SHit_R'}
		formattext \{checksumname = qhit_l
			'DrumDroid_CountOff_QHit_L'}
		formattext \{checksumname = mhit_l
			'DrumDroid_CountOff_MHit_L'}
		formattext \{checksumname = shit_l
			'DrumDroid_CountOff_SHit_L'}
		formattext checksumname = base 'Drum_%a' a = <drum_target_state_string>
		formattext checksumname = base_ik 'Drum_IK_%a' a = <drum_target_state_string>
		formattext checksumname = base_arm 'Drum_Arm_%a' a = <drum_target_state_string>
		tapin = false
		idle = false
		should_idle = false
	else
		formattext checksumname = qhit_r 'Drum_%a_QHit_R' a = <drum_target_state_string>
		formattext checksumname = mhit_r 'Drum_%a_MHit_R' a = <drum_target_state_string>
		formattext checksumname = shit_r 'Drum_%a_SHit_R' a = <drum_target_state_string>
		formattext checksumname = qhit_l 'Drum_%a_QHit_L' a = <drum_target_state_string>
		formattext checksumname = mhit_l 'Drum_%a_MHit_L' a = <drum_target_state_string>
		formattext checksumname = shit_l 'Drum_%a_SHit_L' a = <drum_target_state_string>
		formattext checksumname = base 'Drum_%a' a = <drum_target_state_string>
		formattext checksumname = base_ik 'Drum_IK_%a' a = <drum_target_state_string>
		formattext checksumname = base_arm 'Drum_Arm_%a' a = <drum_target_state_string>
	endif
	gettags \{idle}
	gettags \{tap}
	time_from_idle = (((1 - $drum_idlepoint_arm_shit) * $drum_slowest_arm_hit) / 1000.0)
	if (<idle> = true)
		if (<time_to_hit_1> > <time_from_idle>)
			waittime = (<time_to_hit_1> - <time_from_idle>)
			wait <waittime> seconds
			obj_killspawnedscript \{name = drummer_transit_idles}
			time_to_trans = ((<time_to_trans> - <time_to_hit_1>) + <time_from_idle>)
			settags \{idle = false}
			obj_spawnscriptnow drummer_transit_loops params = {state = in blendduration = <time_to_trans>}
		else
			obj_killspawnedscript \{name = drummer_transit_idles}
			settags \{idle = false}
			obj_spawnscriptnow drummer_transit_loops params = {state = in blendduration = <time_to_trans>}
		endif
	else
		if (<should_idle> = true)
			obj_killspawnedscript \{name = drummer_transit_loops}
			obj_spawnscriptnow drummer_transit_idles params = {state = in tap = <tap>}
			waittime = (<time_to_hit_1> - <time_from_idle>)
			wait <waittime> seconds
			obj_killspawnedscript \{name = drummer_transit_idles}
			time_to_trans = ((<time_to_trans> - <time_to_hit_1>) + <time_from_idle>)
			obj_spawnscriptnow drummer_transit_loops params = {state = in blendduration = <time_to_trans>}
		endif
	endif
	if (<time_to_trans> < 0.0)
		time_to_trans = 0.0
	endif
	create_trans_diff time_to_trans = <time_to_trans>
	anim_command target = db_drum_shit_r_anim command = degenerateblend_addbranch params = {
		blendduration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = <shit_r>
		}
	}
	anim_command target = db_drum_mhit_r_anim command = degenerateblend_addbranch params = {
		blendduration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = <mhit_r>
		}
	}
	anim_command target = db_drum_qhit_r_anim command = degenerateblend_addbranch params = {
		blendduration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = <qhit_r>
		}
	}
	anim_command target = db_drum_shit_l_anim command = degenerateblend_addbranch params = {
		blendduration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = <shit_l>
		}
	}
	anim_command target = db_drum_mhit_l_anim command = degenerateblend_addbranch params = {
		blendduration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = <mhit_l>
		}
	}
	anim_command target = db_drum_qhit_l_anim command = degenerateblend_addbranch params = {
		blendduration = <time_to_trans>
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = <qhit_l>
		}
	}
	anim_command target = db_drum_transition_base_anim command = degenerateblend_addbranch params = {
		blendduration = <time_to_trans_body>
		blendcurve = <smooth_transit_curve_body>
		tree = $single_source_tree
		params = {
			use_anim = <base>
		}
	}
	anim_command target = db_drum_transition_arm_anim command = degenerateblend_addbranch params = {
		blendduration = <time_to_trans_arm>
		blendcurve = <smooth_transit_curve_arm>
		tree = $single_source_tree
		params = {
			use_anim = <base_arm>
		}
	}
	anim_command target = db_drum_transition_ik_anim command = degenerateblend_addbranch params = {
		blendduration = <time_to_trans_ik>
		blendcurve = <smooth_transit_curve_ik>
		tree = $single_source_tree
		params = {
			use_anim = <base_ik>
		}
	}
	settags tap = <tapin>
endscript

script drummer_transit_idles 
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	settags \{idle = true}
	if NOT gotparam \{last_hit}
		last_hit = false
	endif
	obj_getid
	switch <objid>
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
	blendduration = (($drum_idlepoint_arm_shit * $drum_slowest_arm_hit) / 1000.0)
	if (<tap> = false)
		obj_spawnscriptnow default_drummer_state params = {blendduration = <blendduration>}
	endif
	begin
	if (<last_hit> = true)
		getrandomvalue \{name = randomanim
			integer
			a = 1
			b = 5}
		switch <randomanim>
			case 1
			anim = drumdroid_peerintocrowd_inout
			case 2
			anim = drumdroid_fistpump_inout
			case 3
			anim = drumdroid_outro_02
			case 4
			anim = drumdroid_outro_04
			case 5
			anim = drumdroid_outro_05
		endswitch
	else
		getrandomvalue \{name = randomanim
			integer
			a = 1
			b = 6}
		switch <randomanim>
			case 1
			anim = drumdroid_loosenup_in
			case 2
			anim = drumdroid_peerintocrowd_inout
			case 3
			anim = drumdroid_fistpump_inout
			case 4
			anim = drumdroid_armatready_in
			case 5
			anim = drumdroid_littlechairtwist_in
			case 6
			anim = drumdroid_pointcenter_in
		endswitch
	endif
	setsearchallassetcontexts
	if anim_animexists anim = <anim>
		anim_getanimlength anim = <anim>
	else
		length = 5.0
	endif
	setsearchallassetcontexts \{off}
	length = (<length> - <blendduration>)
	if (<length> < 0)
		length = 0
	endif
	if (<blendduration> < 0.0)
		blendduration = 0.0
	endif
	anim_command target = db_drum_loop_anim_tempo command = degenerateblend_addbranch params = {
		blendduration = <blendduration>
		tree = $drum_loop_anim_notempo
		params = {
			start = <start>
			loop_tempo_anim = <anim>
			loop_anim_body = <anim>
		}
	}
	blendduration = 0.6
	wait <length> seconds
	last_hit = false
	repeat
	currentset = 0
	objid = musician1
	randomanim = 0
endscript

script drummer_transit_loops 
	obj_getid
	oldset = d
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	switch <objid>
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
	current_tempo = $current_tempo
	if (<current_tempo> < 85.0)
		set = a
	elseif (<current_tempo> > 115.0)
		set = c
	else
		set = b
	endif
	if (<oldset> != <set>)
		if (<set> = a)
			loop_body = drum_loop_highenergy_075
			oldset = a
		elseif (<set> = b)
			loop_body = drum_loop_highenergy_100
			oldset = b
		elseif (<set> = c)
			loop_body = drum_loop_highenergy_120
			oldset = c
		endif
		if (<blendduration> < 0.0)
			blendduration = 0.0
		endif
		anim_command target = db_drum_loop_anim_tempo command = degenerateblend_addbranch params = {
			blendduration = <blendduration>
			blendcurve = <smooth_transit_curve>
			tree = $drum_loop_anim_tempo
			params = {
				start = <start>
				loop_tempo_anim = <loop_body>
				loop_anim_body = <loop_body>
			}
		}
	endif
	wait <blend_duration> seconds
	blendduration = 0.6
	begin
	if (<current_tempo> = $current_tempo)
		wait \{1
			gameframe}
	else
		break
	endif
	repeat
	repeat
endscript

script create_trans_diff 
	short_trans = 0.1
	short_trans_diff = 2.5
	long_trans = 0.9
	long_trans_diff = 1.5
	if (<time_to_trans> > <long_trans>)
		trans_diff = <long_trans_diff>
	elseif (<time_to_trans> < <short_trans>)
		trans_diff = <short_trans_diff>
	else
		trans_diff = (((<long_trans> - <time_to_trans>) / (<long_trans> - <short_trans>)))
		trans_diff = ((<short_trans_diff> * <trans_diff>) + (<long_trans_diff> * (1 - <trans_diff>)))
	endif
	time_to_trans_ik = (<time_to_trans> * 1.1)
	time_to_trans_body = (<time_to_trans_ik> * <trans_diff>)
	time_to_trans_arm = ((<time_to_trans_ik> + <time_to_trans_body>) / 2)
	return time_to_trans_ik = <time_to_trans_ik> time_to_trans_body = <time_to_trans_body> time_to_trans_arm = <time_to_trans_arm>
endscript

script default_kit_anims 
	<name> :anim_command target = db_drum_cymbal_1 command = degenerateblend_addbranch params = {
		blendduration = 0.2
		tree = $gh_drum_cymbal_1_branch
		params = {
			strength = 1.0
		}
	}
	<name> :anim_command target = db_drum_cymbal_2 command = degenerateblend_addbranch params = {
		blendduration = 0.2
		tree = $gh_drum_cymbal_2_branch
		params = {
			strength = 1.0
		}
	}
	<name> :anim_command target = db_drum_cymbal_3 command = degenerateblend_addbranch params = {
		blendduration = 0.2
		tree = $gh_drum_cymbal_3_branch
		params = {
			strength = 1.0
			anim = gh_drum_cymbal_3_1
		}
	}
	<name> :anim_command target = db_drum_hh command = degenerateblend_addbranch params = {
		blendduration = 0.2
		tree = $gh_drum_hh_branch
		params = {
			strength = 1.0
		}
	}
endscript

script default_drummer_state 
	smooth_transit_curve = [1.0 , 0.9927499 , 0.97199994 , 0.93924993 , 0.89599997 , 0.84375006 , 0.784 , 0.71825 , 0.64800006 , 0.57475 , 0.5 , 0.42525002 , 0.35200003 , 0.28175 , 0.216 , 0.15625 , 0.104 , 0.0607499 , 0.027999999 , 0.00725001 , 0.0]
	smooth_transit_curve_body = [1.0 , 0.99960196 , 0.9982739 , 0.995815 , 0.992026 , 0.98671097 , 0.9796699 , 0.97069895 , 0.95959204 , 0.946134 , 0.93010396 , 0.91126895 , 0.889385 , 0.86419207 , 0.835415 , 0.802758 , 0.76589996 , 0.724496 , 0.6781651 , 0.626492 , 0.569015 , 0.505221 , 0.434534 , 0.35751104 , 0.281412 , 0.20999001 , 0.145196 , 0.0889148 , 0.043468494 , 0.0121238 , 0.0]
	smooth_transit_curve_arm = [1.0 , 0.99872696 , 0.994802 , 0.988059 , 0.978324 , 0.96540695 , 0.949108 , 0.9292079 , 0.905469 , 0.87763 , 0.845403 , 0.80846906 , 0.76646996 , 0.719005 , 0.665619 , 0.605793 , 0.53893197 , 0.464341 , 0.38269204 , 0.30501202 , 0.23405398 , 0.17038701 , 0.114788994 , 0.068295404 , 0.032288197 , 0.00864603 , 0.0]
	smooth_transit_curve_ik = [1.0 , 0.996066 , 0.984568 , 0.96588695 , 0.940315 , 0.90806997 , 0.869298 , 0.82408 , 0.772429 , 0.714292 , 0.6495411 , 0.57796204 , 0.49924302 , 0.413491 , 0.331354 , 0.25736797 , 0.19188 , 0.13525799 , 0.0878982 , 0.050220903 , 0.0226798 , 0.0057634 , 0.0]
	create_trans_diff time_to_trans = <blendduration>
	anim_command target = db_drum_shit_r_anim command = degenerateblend_addbranch params = {
		blendduration = 0.001
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = drumdroid_countoff_shit_r
		}
	}
	anim_command target = db_drum_mhit_r_anim command = degenerateblend_addbranch params = {
		blendduration = 0.001
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = drumdroid_countoff_mhit_r
		}
	}
	anim_command target = db_drum_qhit_r_anim command = degenerateblend_addbranch params = {
		blendduration = 0.001
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = drumdroid_countoff_qhit_r
		}
	}
	anim_command target = db_drum_shit_l_anim command = degenerateblend_addbranch params = {
		blendduration = 0.001
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = drumdroid_countoff_shit_l
		}
	}
	anim_command target = db_drum_mhit_l_anim command = degenerateblend_addbranch params = {
		blendduration = 0.001
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = drumdroid_countoff_mhit_l
		}
	}
	anim_command target = db_drum_qhit_l_anim command = degenerateblend_addbranch params = {
		blendduration = 0.001
		blendcurve = <smooth_transit_curve>
		tree = $single_source_anim_event_tree
		params = {
			use_anim = drumdroid_countoff_qhit_l
		}
	}
	anim_command target = db_drum_transition_base_anim command = degenerateblend_addbranch params = {
		blendduration = 0.001
		blendcurve = <smooth_transit_curve_body>
		tree = $single_source_tree
		params = {
			use_anim = drum_s1t3
		}
	}
	anim_command target = db_drum_transition_arm_anim command = degenerateblend_addbranch params = {
		blendduration = 0.001
		blendcurve = <smooth_transit_curve_arm>
		tree = $single_source_tree
		params = {
			use_anim = drum_arm_s1t3
		}
	}
	anim_command target = db_drum_transition_ik_anim command = degenerateblend_addbranch params = {
		blendduration = 0.001
		blendcurve = <smooth_transit_curve_ik>
		tree = $single_source_tree
		params = {
			use_anim = drum_ik_s1t3
		}
	}
endscript
