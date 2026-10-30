drumdroid_animnode_ids = [
	body
	bodytimer
	facialtimer
	ik
	lefthandpartial
	leftarm
	lefthand
	rightarm
	face
	femalediff
	0xd7adf5e7
	drumkit
	moment_branch
	moment_blend_inner
	moment_blend
	momenttimer
	faceoff_blend
	faceoff_branch
	faceoff_timer
	tweakbonesnode
	mirrornode
	heel
	cycle_drum_loop_body
	cycle_drum_arm_r
	cycle_drum_arm_l
	cycle_drum_foot_r
	cycle_tempo_drum_body
	mod_drum_loop_body
	mod_drum_arm_r
	mod_drum_arm_l
	mod_kit_cymbal_1
	mod_kit_cymbal_2
	mod_kit_cymbal_3
	mod_kit_hh
	add_drum_kit
	blend_drum_arm_r
	blend_drum_arm_l
	blend_drum_foot_r
	blend_kit_hh
	apply_drum_foot_r
	apply_drum_fingers
	apply_drum_base_arm
	apply_drum_base_ik
	apply_drum_kit
	ik_drum_hand_r
	ik_drum_hand_l
	ik_drum_feet
	db_drum_loop_anim_tempo
	db_drum_qhit_r_anim
	db_drum_mhit_r_anim
	db_drum_shit_r_anim
	db_drum_qhit_l_anim
	db_drum_mhit_l_anim
	db_drum_shit_l_anim
	db_drum_transition_base_anim
	db_drum_transition_arm_anim
	db_drum_transition_ik_anim
	db_drum_hh
	db_drum_cymbal_1
	db_drum_cymbal_2
	db_drum_cymbal_3
	source_drum_loop_anim_body
]
drumdroid_tree = {
	type = ikonactivevalue
	id = ik_drum_feet
	two_bone_chains = drummer_ik_feet_params
	active_value_source = av_drum_ik_feet
	active_value_lower_bound = 0.0
	active_value_upper_bound = 1.0
	0xe601ad74 = false
	0x44e0df74 = false
	[
		{
			type = ikonactivevalue
			id = ik_drum_hand_l
			two_bone_chains = drummer_ik_hand_l_params
			active_value_source = av_drum_ik_hand_l
			active_value_lower_bound = 0.0
			active_value_upper_bound = 1.0
			0xe601ad74 = false
			0x44e0df74 = false
			active_value_curve = [
				1.0
				0.9975
				0.98999995
				0.9775
				0.96
				0.9375
				0.90999997
				0.87750006
				0.84000003
				0.7975
				0.75
				0.69750005
				0.64000005
				0.57750005
				0.51
				0.4375
				0.36
				0.2775
				0.19
				0.097500004
				0.0
			]
			[
				{
					type = ikonactivevalue
					id = ik_drum_hand_r
					two_bone_chains = drummer_ik_hand_r_params
					active_value_source = av_drum_ik_hand_r
					active_value_lower_bound = 0.0
					active_value_upper_bound = 1.0
					0x44e0df74 = false
					active_value_curve = [
						1.0
						0.9975
						0.98999995
						0.9775
						0.96
						0.9375
						0.90999997
						0.87750006
						0.84000003
						0.7975
						0.75
						0.69750005
						0.64000005
						0.57750005
						0.51
						0.4375
						0.36
						0.2775
						0.19
						0.097500004
						0.0
					]
					[
						{
							type = applyheeldifference
							id = heel
							[
								{
									type = applyfemaledrummerdifference
									id = femalediff
									[
										{
											type = applydifference
											id = apply_drum_kit
											strength = 1.0
											[
												{
													$drum_kit_branch
												}
												{
													type = applydifferenceonactivevalue
													id = apply_drum_foot_r
													active_value_source = av_drum_mod_foot_r
													active_value_lower_bound = 0.0
													active_value_upper_bound = 1.0
													[
														{
															type = cycleonactivevalue
															id = cycle_drum_foot_r
															timing_track = standard
															active_value_source = av_drum_anim_foot_r
															active_value_lower_bound = 0.0
															active_value_upper_bound = 1.0
															[
																{
																	type = blendnactive
																	id = blend_drum_foot_r
																	active_value_source = av_drum_blend_foot_r
																	active_value_lower_bound = 0.0
																	active_value_upper_bound = 1.0
																	[
																		{
																			type = source
																			anim = drum_foot_qhit_r
																			timing_track = standard
																		}
																		{
																			type = source
																			anim = drum_foot_mhit_r
																			timing_track = standard
																		}
																		{
																			type = source
																			anim = drum_foot_shit_r
																			timing_track = standard
																		}
																	]
																}
															]
														}
														{
															type = applydifference
															strength = 1.0
															[
																{
																	type = addn
																	[
																		{
																			type = modulateonactivevalue
																			id = mod_drum_arm_r
																			active_value_source = av_drum_mod_hand_r
																			active_value_lower_bound = 0.0
																			active_value_upper_bound = 1.0
																			[
																				{
																					type = cycleonactivevalue
																					id = cycle_drum_arm_r
																					timing_track = standard
																					active_value_source = av_drum_anim_hand_r
																					active_value_lower_bound = 0.0
																					active_value_upper_bound = 1.0
																					[
																						{
																							type = blendnactive
																							id = blend_drum_arm_r
																							active_value_source = av_drum_blend_hand_r
																							active_value_lower_bound = 0.0
																							active_value_upper_bound = 1.0
																							[
																								{
																									type = degenerateblend
																									id = db_drum_qhit_r_anim
																								}
																								{
																									type = degenerateblend
																									id = db_drum_mhit_r_anim
																								}
																								{
																									type = degenerateblend
																									id = db_drum_shit_r_anim
																								}
																							]
																						}
																					]
																				}
																			]
																		}
																		{
																			type = modulateonactivevalue
																			id = mod_drum_arm_l
																			active_value_source = av_drum_mod_hand_l
																			active_value_lower_bound = 0.0
																			active_value_upper_bound = 1.0
																			[
																				{
																					type = cycleonactivevalue
																					id = cycle_drum_arm_l
																					timing_track = standard
																					active_value_source = av_drum_anim_hand_l
																					active_value_lower_bound = 0.0
																					active_value_upper_bound = 1.0
																					[
																						{
																							type = blendnactive
																							id = blend_drum_arm_l
																							active_value_source = av_drum_blend_hand_l
																							active_value_lower_bound = 0.0
																							active_value_upper_bound = 1.0
																							[
																								{
																									type = degenerateblend
																									id = db_drum_qhit_l_anim
																								}
																								{
																									type = degenerateblend
																									id = db_drum_mhit_l_anim
																								}
																								{
																									type = degenerateblend
																									id = db_drum_shit_l_anim
																								}
																							]
																						}
																					]
																				}
																			]
																		}
																		{
																			type = modulateonactivevalue
																			id = mod_drum_loop_body
																			active_value_source = av_drum_mod_loop_body
																			active_value_lower_bound = 0.0
																			active_value_upper_bound = 1.0
																			[
																				{
																					type = degenerateblend
																					id = db_drum_loop_anim_tempo
																				}
																			]
																		}
																	]
																}
																{
																	type = applypartial
																	id = apply_drum_fingers
																	strength = 1.0
																	[
																		{
																			type = source
																			anim = drum_fingers
																		}
																		{
																			type = applypartial
																			id = apply_drum_base_ik
																			strength = 1.0
																			[
																				{
																					type = degenerateblend
																					id = db_drum_transition_ik_anim
																					default_degeneration_duration = 0.0
																				}
																				{
																					type = applypartial
																					id = apply_drum_base_arm
																					strength = 1.0
																					[
																						{
																							type = degenerateblend
																							id = db_drum_transition_arm_anim
																							default_degeneration_duration = 0.0
																						}
																						{
																							type = degenerateblend
																							id = db_drum_transition_base_anim
																							default_degeneration_duration = 0.0
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
					]
				}
			]
		}
	]
}
single_source_tree = {
	type = source
	anim = use_anim
}
single_source_anim_event_tree = {
	type = source
	anim = use_anim
	timing_track = standard
}
drum_loop_anim_tempo = {
	type = tempocycle
	id = cycle_tempo_drum_body
	allow_beat_skipping = true
	start = start
	anim = loop_tempo_anim
	[
		{
			type = source
			id = source_drum_loop_anim_body
			anim = loop_anim_body
		}
	]
}
drum_loop_anim_notempo = {
	type = cycle
	start = start
	anim = loop_tempo_anim
	[
		{
			type = source
			id = source_drum_loop_anim_body
			anim = loop_anim_body
		}
	]
}
drum_kit_branch = {
	type = addn
	num_inputs = 4
	[
		{
			type = degenerateblend
			id = db_drum_cymbal_1
			default_degeneration_duration = 0.2
		}
		{
			type = degenerateblend
			id = db_drum_cymbal_2
			default_degeneration_duration = 0.2
		}
		{
			type = degenerateblend
			id = db_drum_cymbal_3
			default_degeneration_duration = 0.2
		}
		{
			type = degenerateblend
			id = db_drum_hh
			default_degeneration_duration = 0.2
		}
	]
}
gh_drum_cymbal_1_branch = {
	type = play
	anim = gh_drum_cymbal_1
	[
		{
			type = modulate
			strength = strength
			id = mod_kit_cymbal_1
			[
				{
					type = source
					anim = gh_drum_cymbal_1
				}
			]
		}
	]
}
gh_drum_cymbal_2_branch = {
	type = play
	anim = gh_drum_cymbal_2
	[
		{
			type = modulate
			strength = strength
			id = mod_kit_cymbal_2
			[
				{
					type = source
					anim = gh_drum_cymbal_2
				}
			]
		}
	]
}
gh_drum_cymbal_3_branch = {
	type = play
	anim = anim
	[
		{
			type = modulate
			strength = strength
			id = mod_kit_cymbal_3
			[
				{
					type = source
					anim = anim
				}
			]
		}
	]
}
gh_drum_hh_branch = {
	type = modulate
	strength = strength
	id = mod_kit_hh
	[
		{
			type = blendonactivevalue
			id = blend_kit_hh
			active_value_source = av_drum_blend_hh_kit
			active_value_lower_bound = 0.0
			active_value_upper_bound = 1.0
			[
				{
					type = play
					anim = gh_drum_cymbal_hh_closed
					[
						{
							type = source
							anim = gh_drum_cymbal_hh_closed
						}
					]
				}
				{
					type = play
					anim = gh_drum_cymbal_hh_open
					[
						{
							type = source
							anim = gh_drum_cymbal_hh_open
						}
					]
				}
			]
		}
	]
}
