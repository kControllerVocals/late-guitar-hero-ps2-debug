cache_build_band_members = 0
nondrummer_anim_node_ids = [
	Body
	BodyTimer
	moment_blend
	moment_branch
	momenttimer
	StrumTimer
	FretTimer
	FingerTimer
	FacialTimer
	Ik
	LeftHandPartial
	LeftArm
	LeftHand
	RightArm
	Face
	strum_anim_mod
	fret_anim_mod
	chord_anim_mod
	chordhandnode
	strumhandnode
	low_chord
	med_chord
	high_chord
	MaleAnimAdjust
	MaleAnimAdjust_Moment
	TweakBonesNode
	MirrorNode
	FemaleDiff
	vocal_face_mod
	Heel
	MiscTimer
	misc_diff
	misc_diff_strength
	Enable_New_Strum
	Dynamic_strums
	RightHandPartial
	Dynamic_Strum_Base
	Dynamic_Strum_Roll_High
	Dynamic_Strum_Roll_Mid
	Dynamic_Strum_Roll_Low
]

script get_anim_struct_member 
	if GotParam \{loading_into_song}
		get_song_prefix song = <loading_into_song>
		GameMode_GetType
		if (<type> = career)
			get_band_configuration song = <loading_into_song>
			if (<Band> != default_band)
				if (<anim_struct> = car_female_anim_struct)
					anim_struct = car_female_alt_anim_struct
				else
					anim_struct = car_male_alt_anim_struct
				endif
			endif
		endif
		ExtendCRC <anim_struct> '_' out = song_anim_struct
		ExtendCRC <song_anim_struct> <song_prefix> out = song_anim_struct
		if (<member> = vocals_and_guitar)
			member = guitar
		endif
		if GlobalExists name = <song_anim_struct> type = Structure
			if StructureContains Structure = ($<song_anim_struct>) <member>


				return true anim_struct_member = (($<song_anim_struct>).<member>)
			elseif (<member> = Bass || <member> = rhythm)

				if StructureContains Structure = ($<song_anim_struct>) guitar

					return true anim_struct_member = (($<song_anim_struct>).guitar)
				endif
			endif
		endif
	endif
	if GlobalExists name = <anim_struct> type = Structure
		if StructureContains Structure = ($<anim_struct>) <member>


			return true anim_struct_member = (($<anim_struct>).<member>)
		elseif (<member> = Bass)

			if StructureContains Structure = ($<anim_struct>) guitar

				return true anim_struct_member = (($<anim_struct>).guitar)
			endif
		endif
	endif


	return \{false}
endscript

script unload_band_anims 

	band_stop_anims
	band_unload_anim_paks async = <async>
endscript

script unload_band_song_anims \{song = unknown}

	band_stop_anims
	band_unload_song_anim_paks song = <song> async = <async>
endscript

script EmptyScript 
endscript

script hero_pause_anim 
	if Anim_AnimNodeExists \{id = BodyTimer}
		Anim_Command \{target = BodyTimer
			command = Timer_SetSpeed
			params = {
				Speed = 0.0
			}}
	endif
endscript

script hero_unpause_anim 
	if Anim_AnimNodeExists \{id = BodyTimer}
		Anim_Command \{target = BodyTimer
			command = Timer_SetSpeed
			params = {
				Speed = 1.0
			}}
	endif
endscript

script hero_enable_mirroring 
	if Anim_AnimNodeExists \{id = MirrorNode}
		Anim_Command \{target = MirrorNode
			command = Mirror_SetState
			params = {
				on
			}}
	endif
endscript

script hero_disable_mirroring 
	if Anim_AnimNodeExists \{id = MirrorNode}
		Anim_Command \{target = MirrorNode
			command = Mirror_SetState
			params = {
				off
			}}
	endif
endscript

script band_play_fret_anim 
	if CompositeObjectExists name = <name>
		<name> :hero_play_fret_anim Anim = <Anim>
	endif
endscript

script hero_play_facial_anim \{BlendDuration = 0.0}
	if Anim_AnimNodeExists \{id = Face}
		Obj_GetID
		if ((<ObjID> = vocalist) || (<ObjID> = vocalist2))
			Tree = $vocalist_face_branch
		else
			Tree = $hero_face_branch
		endif
		Anim_Command {
			target = Face
			command = DegenerateBlend_AddBranch
			params = {
				Tree = <Tree>
				BlendDuration = <BlendDuration>
				params = {
					facial_anim = <Anim>
				}
			}
		}
	endif
endscript

script hero_clear_facial_anim \{BlendDuration = 0.0}
	if Anim_AnimNodeExists \{id = Face}
		Anim_Command {
			target = Face
			command = DegenerateBlend_AddBranch
			params = {
				Tree = $hero_empty_branch
				BlendDuration = <BlendDuration>
			}
		}
	endif
endscript

script hero_add_clothing_difference_anim 
	if NOT GotParam \{Anim}
		return
	endif
	Anim_Command target = Heel command = ApplyHeelDifference_SetAnim params = {Anim = <Anim>}
endscript

script hero_wait_until_anim_finished \{Timer = BodyTimer}
	Anim_Command target = <Timer> command = Timer_WaitAnimComplete
endscript

script killanim 
	obj_killallspawnedscripts
	Skeleton_GetSkeletonName
	ExtendCRC <SkeletonName> '_default' out = Anim
	hero_play_anim Anim = <Anim> BlendDuration = 0.0
endscript

script handle_moment_anim_blending 
	Obj_GetID
	Anim_Command \{target = moment_blend
		command = PartialSwitch_SetState
		params = {
			on
			BlendDuration = 0.0
		}}
	Anim_Command \{target = BodyTimer
		command = TempoMatch_Pause}
	Anim_Command \{target = momenttimer
		command = Timer_WaitAnimComplete}
	if GlobalExists \{name = debug_pops
			type = int}
		if ($debug_pops = 1)
			GetSongTimeMs
			CastToInteger \{time}
			finalprintf qs(0x26d868fe) a = <time> b = <ObjID>
		endif
	endif
	Wait \{2
		gameframes}
	end_moment_anim
endscript

script end_moment_anim 
	Obj_GetID
	Obj_KillSpawnedScript \{name = handle_drummer_moment_anim_blending}
	if Anim_AnimNodeExists \{id = moment_blend}
		Anim_Command \{target = moment_blend
			command = PartialSwitch_SetState
			params = {
				off
				BlendDuration = 0.0
			}}
		Anim_Command \{target = moment_branch
			command = DegenerateBlend_AddBranch
			params = {
				Tree = $hero_empty_branch
				BlendDuration = 0.0
			}}
	endif
	Anim_Command \{target = BodyTimer
		command = TempoMatch_Unpause}
	ExtendCRC <ObjID> '_Info' out = info_struct
	part = ($<info_struct>.part)
	if (<part> = guitar || <part> = Bass || <part> = rhythm)
		chain = guitar
	else
		chain = slave
	endif
	Band_SetIKChain name = <ObjID> chain = <chain>
	increase_band_bounding_spheres
	Wait \{1
		gameframe}
	GetPakManCurrent \{map = zones}
	if NOT is_frontend_venue venue = <pak>
		Band_MoveToStartNode name = <ObjID>
	endif
endscript

script set_timer_node_speed 
endscript

script handle_drummer_moment_anim_blending 
	Anim_Command \{target = moment_blend
		command = PartialSwitch_SetState
		params = {
			on
			BlendDuration = 0.1
		}}
	Anim_Command \{target = momenttimer
		command = Timer_WaitAnimComplete}
	Anim_Command \{target = moment_blend
		command = PartialSwitch_SetState
		params = {
			off
			BlendDuration = 0.1
		}}
endscript

script end_drummer_moment_anim 
endscript

script drummer_faceoff_rest 
	Anim = Drum_HTH_Loop_NoTempo
	Anim_Command {
		target = faceoff_branch
		command = DegenerateBlend_AddBranch
		params = {
			Tree = $faceoff_drummer_notempo
			BlendDuration = 0.0
			params = {
				Anim = <Anim>
			}
		}
	}
	Anim_Command \{target = faceoff_blend
		command = PartialSwitch_SetState
		params = {
			on
			BlendDuration = 0.3
		}}
endscript

script drummer_faceoff_play 
	Anim_Command \{target = faceoff_blend
		command = PartialSwitch_SetState
		params = {
			off
			BlendDuration = 0.3
		}}
endscript
faceoff_drummer_notempo = {
	type = Cycle
	id = faceoff_timer
	Anim = Anim
	[
		{
			type = Source
			Anim = Anim
		}
	]
}

script hide_mic 
	SwitchOffAtomic \{CAS_Mic}
	SwitchOffAtomic \{CAS_Mic_Stand}
endscript

script show_mic 
	SwitchOnAtomic \{CAS_Mic}
	SwitchOnAtomic \{CAS_Mic_Stand}
endscript

script hide_mic_stand 
	SwitchOffAtomic \{CAS_Mic_Stand}
endscript

script show_mic_stand 
	SwitchOnAtomic \{CAS_Mic_Stand}
endscript

script hide_mic_microphone 
	SwitchOffAtomic \{CAS_Mic}
endscript

script show_mic_microphone 
	SwitchOnAtomic \{CAS_Mic}
endscript

script hide_Drumkit 
	SwitchOffAtomic \{CAS_Drums}
endscript

script show_Drumkit 
	SwitchOnAtomic \{CAS_Drums}
endscript

script vocalist_facial_animations_start \{Blendtime = 0.3}
	Anim_Command target = vocal_face_mod command = Modulate_StartBlend params = {Blendtime = <Blendtime> blendcurve = [1 0]}
endscript

script vocalist_facial_animations_stop \{Blendtime = 0.3}
	Anim_Command target = vocal_face_mod command = Modulate_StartBlend params = {Blendtime = <Blendtime> blendcurve = [0 1]}
endscript
generic_static_tree = {
	type = DegenerateBlend
	id = Body
}
guitarist_static_tree = {
	type = ConstraintBones
	ConstraintBones = hero_ConstraintBones
	[
		{
			type = ApplyHeelDifference
			id = Heel
			[
				{
					type = Ik
					two_bone_chains = ik_params
					id = Ik
					[
						{
							type = applydifference
							id = misc_diff
							[
								{
									type = modulate
									strength = 0.0
									id = misc_diff_strength
									[
										{
											type = Cycle
											id = MiscTimer
											Anim = misc_anim
											[
												{
													type = Source
													Anim = misc_anim
												}
											]
										}
									]
								}
								{
									type = chordhand
									id = chordhandnode
									min_twist = 17.62
									max_twist = 145.40999
									min_roll = -7.3700004
									max_roll = 169.1
									hand_bone = Bone_Guitar_Fret_Pos
									elbow_bone = elbow_bone_chord
									negate_rolls = negate_rolls
									[
										{
											type = Ik
											two_bone_chains = hero_IK_Hand_L_Params
											[
												{
													type = TweakBones
													id = TweakBonesNode
													[
														{
															type = PartialSwitch
															state = on
															[
																{
																	type = DegenerateBlend
																	id = Face
																}
																{
																	type = applydifference
																	id = LeftHandPartial
																	[
																		{
																			$hero_arm_branch
																		}
																		{
																			type = chordhand
																			id = strumhandnode
																			min_twist = 40.0
																			max_twist = 150.0
																			min_roll = -0.0
																			max_roll = 65.0
																			hand_bone = Bone_Guitar_Body
																			elbow_bone = elbow_bone_strum
																			[
																				{
																					type = Ik
																					two_bone_chains = hero_IK_Hand_R_Params
																					[
																						{
																							type = applypartial
																							id = RightHandPartial
																							strength = 1.0
																							[
																								{
																									type = DegenerateBlend
																									id = Dynamic_Strum_Base
																								}
																								{
																									type = Switch
																									state = off
																									id = moment_blend
																									[
																										{
																											type = ApplyFemaleDifference
																											id = MaleAnimAdjust_Moment
																											Anim = GH_Rocker_Female_GuitarRaise_D
																											[
																												{
																													type = DegenerateBlend
																													id = moment_branch
																												}
																											]
																										}
																										{
																											type = ApplyFemaleDifference
																											id = MaleAnimAdjust
																											Anim = GH_Rocker_Female_GuitarRaise_D
																											[
																												{
																													type = DegenerateBlend
																													id = Body
																												}
																											]
																										}
																									]
																								}
																							]
																						}
																					]
																				}
																				{
																					type = DegenerateBlend
																					id = Dynamic_Strum_Roll_High
																				}
																				{
																					type = DegenerateBlend
																					id = Dynamic_Strum_Roll_Mid
																				}
																				{
																					type = DegenerateBlend
																					id = Dynamic_Strum_Roll_Low
																				}
																			]
																		}
																	]
																}
															]
														}
													]
												}
											]
										}
										{
											type = DegenerateBlend
											id = low_chord
										}
										{
											type = DegenerateBlend
											id = med_chord
										}
										{
											type = DegenerateBlend
											id = high_chord
										}
									]
								}
							]
						}
					]
				}
			]
		}
	]
}
lefty_guitarist_static_tree = {
	type = ConstraintBones
	ConstraintBones = hero_ConstraintBones
	[
		{
			type = ApplyHeelDifference
			id = Heel
			[
				{
					type = Ik
					two_bone_chains = ik_params
					id = Ik
					[
						{
							type = chordhand
							id = chordhandnode
							min_twist = 40.0
							max_twist = 150.0
							min_roll = -0.0
							max_roll = 65.0
							hand_bone = Bone_Guitar_Fret_Pos
							elbow_bone = elbow_bone_chord
							negate_rolls = negate_rolls
							[
								{
									type = Ik
									two_bone_chains = hero_IK_Hand_L_Params
									[
										{
											type = TweakBones
											id = TweakBonesNode
											[
												{
													type = PartialSwitch
													state = on
													[
														{
															type = DegenerateBlend
															id = Face
														}
														{
															type = applydifference
															id = LeftHandPartial
															[
																{
																	$hero_arm_branch
																}
																{
																	type = chordhand
																	id = strumhandnode
																	min_twist = 17.62
																	max_twist = 145.40999
																	min_roll = -7.3700004
																	max_roll = 169.1
																	negate_rolls = 1
																	hand_bone = Bone_Guitar_Body
																	elbow_bone = elbow_bone_strum
																	[
																		{
																			type = Ik
																			two_bone_chains = lefty_IK_Hand_R_Params
																			[
																				{
																					type = applypartial
																					id = RightHandPartial
																					strength = 1.0
																					[
																						{
																							type = DegenerateBlend
																							id = Dynamic_Strum_Base
																						}
																						{
																							type = Switch
																							state = off
																							id = moment_blend
																							[
																								{
																									type = ApplyFemaleDifference
																									id = MaleAnimAdjust_Moment
																									Anim = GH_Rocker_Female_GuitarRaise_D
																									[
																										{
																											type = DegenerateBlend
																											id = moment_branch
																										}
																									]
																								}
																								{
																									type = ApplyFemaleDifference
																									id = MaleAnimAdjust
																									Anim = GH_Rocker_Female_GuitarRaise_D
																									[
																										{
																											type = DegenerateBlend
																											id = Body
																										}
																									]
																								}
																							]
																						}
																					]
																				}
																			]
																		}
																		{
																			type = DegenerateBlend
																			id = Dynamic_Strum_Roll_High
																		}
																		{
																			type = DegenerateBlend
																			id = Dynamic_Strum_Roll_Mid
																		}
																		{
																			type = DegenerateBlend
																			id = Dynamic_Strum_Roll_Low
																		}
																	]
																}
															]
														}
													]
												}
											]
										}
									]
								}
								{
									type = DegenerateBlend
									id = low_chord
								}
								{
									type = DegenerateBlend
									id = med_chord
								}
								{
									type = DegenerateBlend
									id = high_chord
								}
							]
						}
					]
				}
			]
		}
	]
}
frontend_static_tree = {
	type = ConstraintBones
	ConstraintBones = hero_ConstraintBones
	[
		{
			type = ApplyHeelDifference
			id = Heel
			[
				{
					type = Ik
					two_bone_chains = ik_params
					id = Ik
					[
						{
							type = applydifference
							id = misc_diff
							[
								{
									type = modulate
									strength = 0.0
									id = misc_diff_strength
									[
										{
											type = Cycle
											id = MiscTimer
											Anim = misc_anim
											[
												{
													type = Source
													Anim = misc_anim
												}
											]
										}
									]
								}
								{
									type = ApplyFemaleDifference
									id = MaleAnimAdjust
									Anim = GH_Rocker_Female_GuitarRaise_D
									[
										{
											type = TweakBones
											id = TweakBonesNode
											[
												{
													type = PartialSwitch
													state = on
													[
														{
															type = DegenerateBlend
															id = Face
														}
														{
															type = DegenerateBlend
															type = PartialSwitch
															state = off
															id = moment_blend
															[
																{
																	type = DegenerateBlend
																	id = moment_branch
																}
																{
																	type = DegenerateBlend
																	id = Body
																}
															]
														}
													]
												}
											]
										}
									]
								}
							]
						}
					]
				}
			]
		}
	]
}
hero_arm_branch = {
	type = Add
	[
		{
			type = modulate
			strength = 1.0
			id = fret_anim_mod
			[
				{
					type = DegenerateBlend
					id = LeftArm
				}
			]
		}
		{
			type = modulate
			strength = 1.0
			id = strum_anim_mod
			[
				{
					type = DegenerateBlend
					id = Dynamic_strums
				}
			]
		}
	]
}
Dynamic_Strum_Source = {
	type = Source
	Anim = Anim
}
Dynamic_Strum_Branch = {
	type = Add
	[
		{
			type = Play
			start = startanim
			[
				{
					type = Source
					Anim = Strumanim
				}
			]
		}
		{
			type = Source
			Anim = baseanim
		}
	]
}
Dynamic_Strum_Idle_Branch = {
	type = Add
	[
		{
			type = Cycle
			start = startanim
			[
				{
					type = Source
					Anim = Strumanim
				}
			]
		}
		{
			type = Source
			Anim = baseanim
		}
	]
}
hero_body_branch = {
	type = timer_type
	id = BodyTimer
	Anim = anim_name
	Speed = Speed
	start = start
	end = end
	tempo_anim = tempo_anim
	min_time_factor = min_time_factor
	max_time_factor = max_time_factor
	allow_beat_skipping = allow_beat_skipping
	allow_tempo_override = allow_tempo_override
	anim_events = on
	[
		{
			type = source_type
			Anim = anim_name
		}
	]
}
hero_moment_branch = {
	type = timer_type
	id = momenttimer
	Anim = anim_name
	Speed = Speed
	start = start
	end = end
	tempo_anim = tempo_anim
	min_time_factor = min_time_factor
	max_time_factor = max_time_factor
	allow_beat_skipping = allow_beat_skipping
	allow_tempo_override = allow_tempo_override
	anim_events = on
	[
		{
			type = source_type
			Anim = anim_name
		}
	]
}
hero_fret_branch = {
	type = Play
	id = FretTimer
	Anim = fret_anim
	[
		{
			type = Source
			Anim = fret_anim
		}
	]
}
hero_finger_branch = {
	type = Play
	id = FingerTimer
	Anim = finger_anim
	[
		{
			type = Source
			Anim = finger_anim
		}
	]
}
hero_face_branch = {
	type = Play
	id = FacialTimer
	Anim = facial_anim
	[
		{
			type = FacialHackSource
			Anim = facial_anim
		}
	]
}
vocalist_face_branch = {
	type = Play
	id = FacialTimer
	Anim = facial_anim
	[
		{
			type = FacialHackSource
			Anim = facial_anim
		}
	]
}
hero_play_branch = {
	type = Play
	id = timer_id
	Anim = anim_name
	[
		{
			type = Source
			Anim = anim_name
		}
	]
}
hero_cycle_branch = {
	type = Cycle
	id = timer_id
	Anim = anim_name
	[
		{
			type = Source
			Anim = anim_name
		}
	]
}
hero_empty_branch = {
	type = Blank
}
hero_drumming_branch = {
	type = timer_type
	id = timer_id
	Anim = anim_name
	Speed = Speed
	[
		{
			type = Source
			Anim = anim_name
		}
	]
}
vocalist_static_tree = {
	type = ConstraintBones
	ConstraintBones = hero_ConstraintBones
	[
		{
			type = Ik
			two_bone_chains = singer_IK_Params
			id = Ik
			[
				{
					type = applydifference
					id = misc_diff
					[
						{
							type = modulate
							strength = 0.0
							id = misc_diff_strength
							[
								{
									type = Cycle
									id = MiscTimer
									Anim = misc_anim
									[
										{
											type = Source
											Anim = misc_anim
										}
									]
								}
							]
						}
						{
							type = ApplyHeelDifference
							id = Heel
							[
								{
									type = TweakBones
									id = TweakBonesNode
									[
										{
											type = PartialSwitch
											state = on
											[
												{
													type = modulate
													id = vocal_face_mod
													strength = 1
													[
														{
															type = DegenerateBlend
															id = Face
														}
													]
												}
												{
													type = Switch
													state = off
													id = moment_blend
													[
														{
															type = DegenerateBlend
															id = moment_branch
														}
														{
															type = DegenerateBlend
															id = Body
														}
													]
												}
											]
										}
									]
								}
							]
						}
					]
				}
			]
		}
	]
}
drummer_static_tree = {
	type = TweakBones
	id = TweakBonesNode
	[
		{
			type = PartialSwitch
			state = on
			[
				{
					type = DegenerateBlend
					id = Face
				}
				{
					type = Switch
					state = off
					id = moment_blend
					[
						{
							type = Ik
							two_bone_chains = drummer_IK_params
							id = Ik
							[
								{
									type = ApplyFemaleDrummerDifference
									id = FemaleDiff
									[
										{
											type = ApplyHeelDifference
											id = Heel
											[
												{
													type = Switch
													state = on
													id = moment_blend_inner
													[
														{
															type = DegenerateBlend
															id = moment_branch
														}
														{
															type = DegenerateBlend
															id = Body
														}
													]
												}
											]
										}
									]
								}
							]
						}
						{
							$drumdroid_tree
						}
					]
				}
			]
		}
	]
}
drummer_moment_branch = {
	type = timer_type
	id = momenttimer
	Anim = anim_name
	Speed = Speed
	start = start
	end = end
	skip_beats = skip_beats
	tempo_anim = tempo_anim
	anim_events = on
	[
		{
			type = source_type
			Anim = anim_name
		}
	]
}
hero_cymbal_branch = {
	type = Play
	id = cymbal_timer_id
	Anim = cymbal_anim
	[
		{
			type = Source
			Anim = cymbal_anim
		}
	]
}
hero_simple_source = {
	type = Play
	Anim = Anim
	[
		{
			type = Source
			Anim = Anim
		}
	]
}
hero_source_only = {
	type = Source
	Anim = Anim
}
empty_ik_params = [
]
CAR_IK_Params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Slave_R
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Slave_L
	}
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.1483, 0.0, 0.98889995)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (-0.1483, 0.0, 0.98889995)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
hero_IK_Hand_R_Params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_R
		NewTarget = Bone_IK_Hand_Slave_R
		stretch = 0.0
	}
]
lefty_IK_Hand_R_Params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_R
		NewTarget = Bone_IK_Hand_Slave_R
		stretch = 0.0
	}
]
hero_IK_Hand_L_Params = [
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_L
		NewTarget = Bone_IK_Hand_Slave_L
		stretch = 0.0
	}
]
lefty_IK_Params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.25, 0.0, -0.968246)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_R
		NewTarget = Bone_IK_Hand_Slave_R
		stretch = 1.0
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_L
		NewTarget = Bone_IK_Hand_Slave_L
		stretch = 1.0
	}
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
Hero_Ik_params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_R
		NewTarget = Bone_IK_Hand_Slave_R
		stretch = 1.0
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_L
		NewTarget = Bone_IK_Hand_Slave_L
		stretch = 1.0
	}
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
Hero_Feet_IK_Params = [
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
singer_IK_Params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Slave_R
		stretch = 1.0
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Slave_L
		stretch = 1.0
	}
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.1483, 0.0, 0.98889995)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (-0.1483, 0.0, 0.98889995)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
drummer_IK_Feet_Params = [
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (-0.3511, 0.0, 0.9362999)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
drummer_IK_Hand_R_Params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Slave_R
		stretch = 1.0
	}
]
drummer_IK_Hand_L_Params = [
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Slave_L
		stretch = 1.0
	}
]
drummer_IK_params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Slave_R
		stretch = 1.0
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Slave_L
		stretch = 1.0
	}
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
hero_ConstraintBones = [
	{
		type = Twistchild
		bone = Bone_Twist_Wrist_L
		target = Bone_Palm_L
		amount = 0.5
	}
	{
		type = Twistchild
		bone = Bone_Twist_Wrist_R
		target = Bone_Palm_R
		amount = 0.5
	}
	{
		type = Twist
		bone = Bone_Twist_Bicep_Mid_R
		target = Bone_Bicep_R
		amount = 0.5
	}
	{
		type = Twist
		bone = Bone_Twist_Bicep_Mid_L
		target = Bone_Bicep_L
		amount = 0.5
	}
	{
		type = Twist
		bone = Bone_Twist_Bicep_Top_R
		target = Bone_Bicep_R
		amount = 1.0
	}
	{
		type = Twist
		bone = Bone_Twist_Bicep_Top_L
		target = Bone_Bicep_L
		amount = 1.0
	}
]

script ps2_get_musician_context_data 
	switch (<name>)
		case Guitarist
		case cas_musician1
		case bassist2
		case vocalist2
		case drummer2
		asset_heap = heap_musician1
		bandmember_appearance = guitarist_appearance
		asset_slot_num = 0
		case bassist
		case cas_musician2
		case guitarist2
		asset_heap = heap_musician2
		bandmember_appearance = bassist_appearance
		asset_slot_num = 1
		case vocalist
		case cas_musician3
		asset_heap = heap_musician3
		bandmember_appearance = vocalist_appearance
		asset_slot_num = 2
		case Drummer
		case cas_musician4
		asset_heap = heap_musician4
		bandmember_appearance = drummer_appearance
		asset_slot_num = 3
		default

		asset_heap = heap_musician1
		bandmember_appearance = guitarist_appearance
		asset_slot_num = 0
	endswitch
	return <...>
endscript
