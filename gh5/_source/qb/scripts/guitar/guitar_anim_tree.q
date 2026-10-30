cache_build_band_members = 0
nondrummer_anim_node_ids = [
	body
	bodytimer
	moment_blend
	moment_branch
	momenttimer
	strumtimer
	frettimer
	fingertimer
	facialtimer
	ik
	lefthandpartial
	leftarm
	lefthand
	rightarm
	face
	strum_anim_mod
	fret_anim_mod
	chord_anim_mod
	chordhandnode
	strumhandnode
	low_chord
	med_chord
	high_chord
	maleanimadjust
	maleanimadjust_moment
	tweakbonesnode
	mirrornode
	femalediff
	vocal_face_mod
	heel
	enable_new_strum
	dynamic_strums
	righthandpartial
	dynamic_strum_base
	dynamic_strum_roll_high
	dynamic_strum_roll_mid
	dynamic_strum_roll_low
]
drummer_anim_node_ids = [
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
	drumkit
	moment_branch
	moment_blend
	momenttimer
	faceoff_blend
	faceoff_branch
	faceoff_timer
	tweakbonesnode
	mirrornode
	heel
]

script get_anim_struct_member 
	if gotparam \{loading_into_song}
		get_song_prefix song = <loading_into_song>
		extendcrc <anim_struct> '_' out = song_anim_struct
		extendcrc <song_anim_struct> <song_prefix> out = song_anim_struct
		if (<member> = vocals_and_guitar)
			member = guitar
		endif
		if globalexists name = <song_anim_struct> type = structure
			if structurecontains structure = ($<song_anim_struct>) <member>


				return true anim_struct_member = (($<song_anim_struct>).<member>)
			elseif (<member> = bass || <member> = rhythm)

				if structurecontains structure = ($<song_anim_struct>) guitar

					return true anim_struct_member = (($<song_anim_struct>).guitar)
				endif
			endif
		endif
	endif
	if globalexists name = <anim_struct> type = structure
		if structurecontains structure = ($<anim_struct>) <member>


			return true anim_struct_member = (($<anim_struct>).<member>)
		elseif (<member> = bass)

			if structurecontains structure = ($<anim_struct>) guitar

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

script emptyscript 
endscript

script hero_pause_anim 
	if anim_animnodeexists \{id = bodytimer}
		anim_command \{target = bodytimer
			command = timer_setspeed
			params = {
				speed = 0.0
			}}
	endif
endscript

script hero_unpause_anim 
	if anim_animnodeexists \{id = bodytimer}
		anim_command \{target = bodytimer
			command = timer_setspeed
			params = {
				speed = 1.0
			}}
	endif
endscript

script hero_enable_mirroring 
	if anim_animnodeexists \{id = mirrornode}
		anim_command \{target = mirrornode
			command = mirror_setstate
			params = {
				on
			}}
	endif
endscript

script hero_disable_mirroring 
	if anim_animnodeexists \{id = mirrornode}
		anim_command \{target = mirrornode
			command = mirror_setstate
			params = {
				off
			}}
	endif
endscript

script band_play_strum_anim 
	if compositeobjectexists name = <name>
		<name> :hero_play_strum_anim anim = <anim>
	endif
endscript

script band_play_fret_anim 
	if compositeobjectexists name = <name>
		<name> :hero_play_fret_anim anim = <anim>
	endif
endscript

script band_play_finger_anim 
	if compositeobjectexists name = <name>
		<name> :hero_play_finger_anim anim = <anim>
	endif
endscript

script hero_play_facial_anim \{blendduration = 0.0}
	if anim_animnodeexists \{id = face}
		obj_getid
		if ((<objid> = vocalist) || (<objid> = vocalist2))
			tree = $vocalist_face_branch
		else
			tree = $hero_face_branch
		endif
		anim_command {
			target = face
			command = degenerateblend_addbranch
			params = {
				tree = <tree>
				blendduration = <blendduration>
				params = {
					facial_anim = <anim>
				}
			}
		}
	endif
endscript

script hero_clear_facial_anim \{blendduration = 0.0}
	if anim_animnodeexists \{id = face}
		anim_command {
			target = face
			command = degenerateblend_addbranch
			params = {
				tree = $hero_empty_branch
				blendduration = <blendduration>
			}
		}
	endif
endscript

script hero_add_clothing_difference_anim 
	if NOT gotparam \{anim}
		return
	endif
	anim_command target = heel command = applyheeldifference_setanim params = {anim = <anim>}
endscript

script hero_wait_until_anim_finished \{timer = bodytimer}
	anim_command target = <timer> command = timer_waitanimcomplete
endscript

script hero_wait_until_anim_near_end \{timer = bodytimer
		time_from_end = 0.2}
	begin
	if hero_anim_near_end timer = <timer> time_from_end = <time_from_end>
		break
	endif
	waitonegameframe
	repeat
endscript

script hero_anim_near_end \{timer = bodytimer}
	if NOT anim_animnodeexists id = <timer>
		return \{true}
	else
		if anim_command target = <timer> command = timer_wait params = {secondsfromend = <time_from_end>}
			return \{true}
		else
			return \{false}
		endif
	endif
endscript

script killanim 
	obj_killallspawnedscripts
	skeleton_getskeletonname
	extendcrc <skeletonname> '_default' out = anim
	hero_play_anim anim = <anim> blendduration = 0.0
endscript

script handle_moment_anim_blending 
	obj_getid
	anim_command \{target = moment_blend
		command = partialswitch_setstate
		params = {
			on
			blendduration = 0.0
		}}
	anim_command \{target = bodytimer
		command = tempomatch_pause}
	anim_command \{target = momenttimer
		command = timer_waitanimcomplete}
	if globalexists \{name = 0x9f26bd2b
			type = int}
		if ($0x9f26bd2b = 1)
			getsongtimems
			casttointeger \{time}
			finalprintf qs(0x26d868fe) a = <time> b = <objid>
		endif
	endif
	wait \{2
		gameframes}
	end_moment_anim
endscript

script end_moment_anim 
	obj_getid
	obj_killspawnedscript \{name = handle_drummer_moment_anim_blending}
	if anim_animnodeexists \{id = moment_blend}
		anim_command \{target = moment_blend
			command = partialswitch_setstate
			params = {
				off
				blendduration = 0.0
			}}
		anim_command \{target = moment_branch
			command = degenerateblend_addbranch
			params = {
				tree = $hero_empty_branch
				blendduration = 0.0
			}}
	endif
	anim_command \{target = bodytimer
		command = tempomatch_unpause}
	extendcrc <objid> '_Info' out = info_struct
	part = ($<info_struct>.part)
	if (<part> = guitar || <part> = bass || <part> = rhythm)
		chain = guitar
	else
		chain = slave
	endif
	band_setikchain name = <objid> chain = <chain>
	increase_band_bounding_spheres
	wait \{1
		gameframe}
	getpakmancurrent \{map = zones}
	if NOT 0x078ad386 venue = <pak>
		band_movetostartnode name = <objid>
	endif
endscript

script set_timer_node_speed 
endscript

script handle_drummer_moment_anim_blending 
	anim_command \{target = moment_blend
		command = partialswitch_setstate
		params = {
			on
			blendduration = 0.1
		}}
	anim_command \{target = momenttimer
		command = timer_waitanimcomplete}
	anim_command \{target = moment_blend
		command = partialswitch_setstate
		params = {
			off
			blendduration = 0.1
		}}
endscript

script end_drummer_moment_anim 
endscript

script drummer_faceoff_rest 
	anim = drum_hth_loop_notempo
	anim_command {
		target = faceoff_branch
		command = degenerateblend_addbranch
		params = {
			tree = $faceoff_drummer_notempo
			blendduration = 0.0
			params = {
				anim = <anim>
			}
		}
	}
	anim_command \{target = faceoff_blend
		command = partialswitch_setstate
		params = {
			on
			blendduration = 0.3
		}}
endscript

script drummer_faceoff_play 
	anim_command \{target = faceoff_blend
		command = partialswitch_setstate
		params = {
			off
			blendduration = 0.3
		}}
endscript
faceoff_drummer_notempo = {
	type = cycle
	id = faceoff_timer
	anim = anim
	[
		{
			type = source
			anim = anim
		}
	]
}

script hide_mic 
	switchoffatomic \{cas_mic}
	switchoffatomic \{cas_mic_stand}
endscript

script show_mic 
	switchonatomic \{cas_mic}
	switchonatomic \{cas_mic_stand}
endscript

script hide_mic_stand 
	switchoffatomic \{cas_mic_stand}
endscript

script show_mic_stand 
	switchonatomic \{cas_mic_stand}
endscript

script hide_mic_microphone 
	switchoffatomic \{cas_mic}
endscript

script show_mic_microphone 
	switchonatomic \{cas_mic}
endscript

script hide_drumkit 
	switchoffatomic \{cas_drums}
endscript

script show_drumkit 
	switchonatomic \{cas_drums}
endscript

script vocalist_facial_animations_start \{blendtime = 0.3}
	anim_command target = vocal_face_mod command = modulate_startblend params = {blendtime = <blendtime> blendcurve = [1 0]}
endscript

script vocalist_facial_animations_stop \{blendtime = 0.3}
	anim_command target = vocal_face_mod command = modulate_startblend params = {blendtime = <blendtime> blendcurve = [0 1]}
endscript
generic_static_tree = {
	type = degenerateblend
	id = body
}
guitarist_static_tree = {
	type = constraintbones
	constraintbones = hero_constraintbones
	[
		{
			type = applyheeldifference
			id = heel
			[
				{
					type = ik
					two_bone_chains = ik_params
					id = ik
					[
						{
							type = chordhand
							id = chordhandnode
							min_twist = 17.62
							max_twist = 145.40999
							min_roll = -7.3700004
							max_roll = 169.1
							hand_bone = bone_guitar_fret_pos
							elbow_bone = elbow_bone_chord
							negate_rolls = negate_rolls
							[
								{
									type = ik
									two_bone_chains = hero_ik_hand_l_params
									[
										{
											type = tweakbones
											id = tweakbonesnode
											[
												{
													type = partialswitch
													state = on
													[
														{
															type = degenerateblend
															id = face
														}
														{
															type = applydifference
															id = lefthandpartial
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
																	hand_bone = bone_guitar_body
																	elbow_bone = elbow_bone_strum
																	[
																		{
																			type = ik
																			two_bone_chains = hero_ik_hand_r_params
																			[
																				{
																					type = applypartial
																					id = righthandpartial
																					strength = 1.0
																					[
																						{
																							type = degenerateblend
																							id = dynamic_strum_base
																						}
																						{
																							type = switch
																							state = off
																							id = moment_blend
																							[
																								{
																									type = applyfemaledifference
																									id = maleanimadjust_moment
																									anim = gh_rocker_female_guitarraise_d
																									[
																										{
																											type = degenerateblend
																											id = moment_branch
																										}
																									]
																								}
																								{
																									type = applyfemaledifference
																									id = maleanimadjust
																									anim = gh_rocker_female_guitarraise_d
																									[
																										{
																											type = degenerateblend
																											id = body
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
																			type = degenerateblend
																			id = dynamic_strum_roll_high
																		}
																		{
																			type = degenerateblend
																			id = dynamic_strum_roll_mid
																		}
																		{
																			type = degenerateblend
																			id = dynamic_strum_roll_low
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
									type = degenerateblend
									id = low_chord
								}
								{
									type = degenerateblend
									id = med_chord
								}
								{
									type = degenerateblend
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
0xb67a972f = {
	type = constraintbones
	constraintbones = hero_constraintbones
	[
		{
			type = applyheeldifference
			id = heel
			[
				{
					type = ik
					two_bone_chains = ik_params
					id = ik
					[
						{
							type = chordhand
							id = chordhandnode
							min_twist = 40.0
							max_twist = 150.0
							min_roll = -0.0
							max_roll = 65.0
							hand_bone = bone_guitar_fret_pos
							elbow_bone = elbow_bone_chord
							negate_rolls = negate_rolls
							[
								{
									type = ik
									two_bone_chains = hero_ik_hand_l_params
									[
										{
											type = tweakbones
											id = tweakbonesnode
											[
												{
													type = partialswitch
													state = on
													[
														{
															type = degenerateblend
															id = face
														}
														{
															type = applydifference
															id = lefthandpartial
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
																	hand_bone = bone_guitar_body
																	elbow_bone = elbow_bone_strum
																	[
																		{
																			type = ik
																			two_bone_chains = 0x055926f9
																			[
																				{
																					type = applypartial
																					id = righthandpartial
																					strength = 1.0
																					[
																						{
																							type = degenerateblend
																							id = dynamic_strum_base
																						}
																						{
																							type = switch
																							state = off
																							id = moment_blend
																							[
																								{
																									type = applyfemaledifference
																									id = maleanimadjust_moment
																									anim = gh_rocker_female_guitarraise_d
																									[
																										{
																											type = degenerateblend
																											id = moment_branch
																										}
																									]
																								}
																								{
																									type = applyfemaledifference
																									id = maleanimadjust
																									anim = gh_rocker_female_guitarraise_d
																									[
																										{
																											type = degenerateblend
																											id = body
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
																			type = degenerateblend
																			id = dynamic_strum_roll_high
																		}
																		{
																			type = degenerateblend
																			id = dynamic_strum_roll_mid
																		}
																		{
																			type = degenerateblend
																			id = dynamic_strum_roll_low
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
									type = degenerateblend
									id = low_chord
								}
								{
									type = degenerateblend
									id = med_chord
								}
								{
									type = degenerateblend
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
	type = constraintbones
	constraintbones = hero_constraintbones
	[
		{
			type = applyheeldifference
			id = heel
			[
				{
					type = ik
					two_bone_chains = ik_params
					id = ik
					[
						{
							type = applyfemaledifference
							id = maleanimadjust
							anim = gh_rocker_female_guitarraise_d
							[
								{
									type = tweakbones
									id = tweakbonesnode
									[
										{
											type = partialswitch
											state = on
											[
												{
													type = degenerateblend
													id = face
												}
												{
													type = degenerateblend
													type = partialswitch
													state = off
													id = moment_blend
													[
														{
															type = degenerateblend
															id = moment_branch
														}
														{
															type = degenerateblend
															id = body
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
	type = add
	[
		{
			type = modulate
			strength = 1.0
			id = fret_anim_mod
			[
				{
					type = degenerateblend
					id = leftarm
				}
			]
		}
		{
			type = modulate
			strength = 1.0
			id = strum_anim_mod
			[
				{
					type = degenerateblend
					id = dynamic_strums
				}
			]
		}
	]
}
dynamic_strum_source = {
	type = source
	anim = anim
}
dynamic_strum_branch = {
	type = add
	[
		{
			type = play
			start = startanim
			[
				{
					type = source
					anim = strumanim
				}
			]
		}
		{
			type = source
			anim = baseanim
		}
	]
}
dynamic_strum_idle_branch = {
	type = add
	[
		{
			type = cycle
			start = startanim
			[
				{
					type = source
					anim = strumanim
				}
			]
		}
		{
			type = source
			anim = baseanim
		}
	]
}
hero_body_branch = {
	type = timer_type
	id = bodytimer
	anim = anim_name
	speed = speed
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
			anim = anim_name
		}
	]
}
hero_moment_branch = {
	type = timer_type
	id = momenttimer
	anim = anim_name
	speed = speed
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
			anim = anim_name
		}
	]
}
hero_strumming_branch = {
	type = play
	id = strumtimer
	anim = strum_name
	[
		{
			type = source
			anim = strum_name
		}
	]
}
hero_fret_branch = {
	type = play
	id = frettimer
	anim = fret_anim
	[
		{
			type = source
			anim = fret_anim
		}
	]
}
hero_finger_branch = {
	type = play
	id = fingertimer
	anim = finger_anim
	[
		{
			type = source
			anim = finger_anim
		}
	]
}
hero_face_branch = {
	type = play
	id = facialtimer
	anim = facial_anim
	[
		{
			type = source
			anim = facial_anim
		}
	]
}
vocalist_face_branch = {
	type = play
	id = facialtimer
	anim = facial_anim
	[
		{
			type = source
			anim = facial_anim
		}
	]
}
hero_play_branch = {
	type = play
	id = timer_id
	anim = anim_name
	[
		{
			type = source
			anim = anim_name
		}
	]
}
hero_cycle_branch = {
	type = cycle
	id = timer_id
	anim = anim_name
	[
		{
			type = source
			anim = anim_name
		}
	]
}
hero_empty_branch = {
	type = blank
}
hero_drumming_branch = {
	type = timer_type
	id = timer_id
	anim = anim_name
	speed = speed
	[
		{
			type = source
			anim = anim_name
		}
	]
}
vocalist_static_tree = {
	type = constraintbones
	constraintbones = hero_constraintbones
	[
		{
			type = ik
			two_bone_chains = singer_ik_params
			id = ik
			[
				{
					type = applyheeldifference
					id = heel
					[
						{
							type = tweakbones
							id = tweakbonesnode
							[
								{
									type = partialswitch
									state = on
									[
										{
											type = modulate
											id = vocal_face_mod
											strength = 1
											[
												{
													type = degenerateblend
													id = face
												}
											]
										}
										{
											type = switch
											state = off
											id = moment_blend
											[
												{
													type = degenerateblend
													id = moment_branch
												}
												{
													type = degenerateblend
													id = body
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
	type = tweakbones
	id = tweakbonesnode
	[
		{
			type = partialswitch
			state = on
			[
				{
					type = degenerateblend
					id = face
				}
				{
					type = switch
					state = off
					id = moment_blend
					[
						{
							type = ik
							two_bone_chains = drummer_ik_params
							id = ik
							[
								{
									type = applyfemaledrummerdifference
									id = femalediff
									[
										{
											type = applyheeldifference
											id = heel
											[
												{
													type = switch
													state = on
													id = moment_blend_inner
													[
														{
															type = degenerateblend
															id = moment_branch
														}
														{
															type = degenerateblend
															id = body
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
	anim = anim_name
	speed = speed
	start = start
	end = end
	skip_beats = skip_beats
	tempo_anim = tempo_anim
	anim_events = on
	[
		{
			type = source_type
			anim = anim_name
		}
	]
}
hero_cymbal_branch = {
	type = play
	id = cymbal_timer_id
	anim = cymbal_anim
	[
		{
			type = source
			anim = cymbal_anim
		}
	]
}
hero_simple_source = {
	type = play
	anim = anim
	[
		{
			type = source
			anim = anim
		}
	]
}
hero_source_only = {
	type = source
	anim = anim
}
empty_ik_params = [
]
car_ik_params = [
	{
		bone0 = bone_bicep_r
		bone1 = bone_forearm_r
		bone2 = bone_palm_r
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_slave_r
	}
	{
		bone0 = bone_bicep_l
		bone1 = bone_forearm_l
		bone2 = bone_palm_l
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_slave_l
	}
	{
		bone0 = bone_thigh_l
		bone1 = bone_knee_l
		bone2 = bone_ankle_l
		hingeaxis = (0.1483, 0.0, 0.98889995)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_l
	}
	{
		bone0 = bone_thigh_r
		bone1 = bone_knee_r
		bone2 = bone_ankle_r
		hingeaxis = (-0.1483, 0.0, 0.98889995)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_r
	}
]
hero_ik_hand_r_params = [
	{
		bone0 = bone_bicep_r
		bone1 = bone_forearm_r
		bone2 = bone_palm_r
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_guitar_r
		newtarget = bone_ik_hand_slave_r
		stretch = 0.0
	}
]
0x055926f9 = [
	{
		bone0 = bone_bicep_r
		bone1 = bone_forearm_r
		bone2 = bone_palm_r
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_guitar_r
		newtarget = bone_ik_hand_slave_r
		stretch = 0.0
	}
]
hero_ik_hand_l_params = [
	{
		bone0 = bone_bicep_l
		bone1 = bone_forearm_l
		bone2 = bone_palm_l
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_guitar_l
		newtarget = bone_ik_hand_slave_l
		stretch = 0.0
	}
]
0xf56342fc = [
	{
		bone0 = bone_bicep_r
		bone1 = bone_forearm_r
		bone2 = bone_palm_r
		hingeaxis = (0.25, 0.0, -0.968246)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_guitar_r
		newtarget = bone_ik_hand_slave_r
		stretch = 1.0
	}
	{
		bone0 = bone_bicep_l
		bone1 = bone_forearm_l
		bone2 = bone_palm_l
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_guitar_l
		newtarget = bone_ik_hand_slave_l
		stretch = 1.0
	}
	{
		bone0 = bone_thigh_l
		bone1 = bone_knee_l
		bone2 = bone_ankle_l
		hingeaxis = (0.0, 0.0, 1.0)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_l
	}
	{
		bone0 = bone_thigh_r
		bone1 = bone_knee_r
		bone2 = bone_ankle_r
		hingeaxis = (0.0, 0.0, 1.0)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_r
	}
]
hero_ik_params = [
	{
		bone0 = bone_bicep_r
		bone1 = bone_forearm_r
		bone2 = bone_palm_r
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_guitar_r
		newtarget = bone_ik_hand_slave_r
		stretch = 1.0
	}
	{
		bone0 = bone_bicep_l
		bone1 = bone_forearm_l
		bone2 = bone_palm_l
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_guitar_l
		newtarget = bone_ik_hand_slave_l
		stretch = 1.0
	}
	{
		bone0 = bone_thigh_l
		bone1 = bone_knee_l
		bone2 = bone_ankle_l
		hingeaxis = (0.0, 0.0, 1.0)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_l
	}
	{
		bone0 = bone_thigh_r
		bone1 = bone_knee_r
		bone2 = bone_ankle_r
		hingeaxis = (0.0, 0.0, 1.0)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_r
	}
]
hero_feet_ik_params = [
	{
		bone0 = bone_thigh_l
		bone1 = bone_knee_l
		bone2 = bone_ankle_l
		hingeaxis = (0.0, 0.0, 1.0)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_l
	}
	{
		bone0 = bone_thigh_r
		bone1 = bone_knee_r
		bone2 = bone_ankle_r
		hingeaxis = (0.0, 0.0, 1.0)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_r
	}
]
singer_ik_params = [
	{
		bone0 = bone_bicep_r
		bone1 = bone_forearm_r
		bone2 = bone_palm_r
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_slave_r
		stretch = 1.0
	}
	{
		bone0 = bone_bicep_l
		bone1 = bone_forearm_l
		bone2 = bone_palm_l
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_slave_l
		stretch = 1.0
	}
	{
		bone0 = bone_thigh_l
		bone1 = bone_knee_l
		bone2 = bone_ankle_l
		hingeaxis = (0.1483, 0.0, 0.98889995)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_l
	}
	{
		bone0 = bone_thigh_r
		bone1 = bone_knee_r
		bone2 = bone_ankle_r
		hingeaxis = (-0.1483, 0.0, 0.98889995)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_r
	}
]
drummer_ik_feet_params = [
	{
		bone0 = bone_thigh_l
		bone1 = bone_knee_l
		bone2 = bone_ankle_l
		hingeaxis = (0.0, 0.0, 1.0)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_l
	}
	{
		bone0 = bone_thigh_r
		bone1 = bone_knee_r
		bone2 = bone_ankle_r
		hingeaxis = (0.0, 0.0, 1.0)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_r
	}
]
drummer_ik_hand_r_params = [
	{
		bone0 = bone_bicep_r
		bone1 = bone_forearm_r
		bone2 = bone_palm_r
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_slave_r
		stretch = 1.0
	}
]
drummer_ik_hand_l_params = [
	{
		bone0 = bone_bicep_l
		bone1 = bone_forearm_l
		bone2 = bone_palm_l
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_slave_l
		stretch = 1.0
	}
]
drummer_ik_params = [
	{
		bone0 = bone_bicep_r
		bone1 = bone_forearm_r
		bone2 = bone_palm_r
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_slave_r
		stretch = 1.0
	}
	{
		bone0 = bone_bicep_l
		bone1 = bone_forearm_l
		bone2 = bone_palm_l
		hingeaxis = (0.0, 0.0, -1.0)
		cosmaxhingeangle = -0.96999997
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_hand_slave_l
		stretch = 1.0
	}
	{
		bone0 = bone_thigh_l
		bone1 = bone_knee_l
		bone2 = bone_ankle_l
		hingeaxis = (0.0, 0.0, 1.0)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_l
	}
	{
		bone0 = bone_thigh_r
		bone1 = bone_knee_r
		bone2 = bone_ankle_r
		hingeaxis = (0.0, 0.0, 1.0)
		cosmaxhingeangle = -0.98999995
		cosminhingeangle = 0.96999997
		bonetarget = bone_ik_foot_slave_r
	}
]
hero_constraintbones = [
	{
		type = twist
		bone = bone_twist_bicep_mid_r
		target = bone_bicep_r
		amount = 0.5
	}
	{
		type = twist
		bone = bone_twist_bicep_mid_l
		target = bone_bicep_l
		amount = 0.5
	}
	{
		type = twist
		bone = bone_twist_bicep_top_r
		target = bone_bicep_r
		amount = 1.0
	}
	{
		type = twist
		bone = bone_twist_bicep_top_l
		target = bone_bicep_l
		amount = 1.0
	}
]

script ps2_get_musician_context_data 
	switch (<name>)
		case guitarist
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
		case drummer
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
