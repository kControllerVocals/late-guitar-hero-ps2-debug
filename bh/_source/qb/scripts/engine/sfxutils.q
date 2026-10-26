SfxPreviewEventTree_FAM = {
	type = FAM
	[
		{
			type = Source
			Anim = sk9_skater_Default
		}
	]
}

script SfxCreateTestFAMObject 
	if CompositeObjectExists \{SfxPreviewEventObject}
		SfxPreviewEventObject :Die
	endif
	skater :Obj_GetPosition
	skater :Obj_GetQuat
	CreateCompositeObject priority = COIM_Priority_Permanent heap = generic {
		Components = [{Component = SetDisplayMatrix} {Component = AnimTree}
			{Component = skeleton} {Component = Model}
			{Component = Agent} {Component = FAM} {Component = stream}]
		params = {name = SfxPreviewEventObject pos = <pos> Orientation = <Quat> CloneFrom = skater
			SkeletonName = sk9_skater species = human voice_profile = TeenMaleSkater1 sex = Male
			notice_radius = 6.0 agent_stats = stats_player faction = $faction_test}
	}
	SfxPreviewEventObject :Anim_InitTree \{Tree = SfxPreviewEventTree_FAM
		NodeIdDeclaration = [
			FAM
		]}
endscript

script SfxCreateTestObject 
	if CompositeObjectExists \{SfxPreviewEventObject}
		SfxPreviewEventObject :Die
	endif
	GetCurrentCameraObject
	<camid> :Obj_GetPosition
	<camid> :Obj_GetQuat
	pos = (<pos> + (10 * <Quat>))
	CreateCompositeObject priority = COIM_Priority_Permanent heap = generic {
		Components = [{Component = Sound}]
		params = {name = SfxPreviewEventObject pos = <pos> Orientation = <Quat>}
	}
endscript

script SfxDestroyTestObject 
	if CompositeObjectExists \{SfxPreviewEventObject}
		SfxPreviewEventObject :Die
	endif
endscript

script PreviewSoundEvent 
	ExtendCRC <event> '_container' out = container_name
	if StructureContains Structure = $<container_name> command

		if ChecksumEquals a = ($<container_name>.command) b = PlaySound

			SoundEvent event = <event>
		elseif ChecksumEquals a = ($<container_name>.command) b = Obj_PlaySound

			SfxCreateTestObject
			SoundEvent event = <event> object = SfxPreviewEventObject
		elseif ChecksumEquals a = ($<container_name>.command) b = Agent_PlayVO

			<stream_priority> = 1
			<logic_priority> = 50
			<animate_mouth> = true
			<buss_id> = `default`
			<no_pitch_mod> = false
			<use_pos_info> = true
			<can_use_stream> = true
			<dropoff> = 50
			<dropoff_function> = standard
			SfxCreateTestFAMObject
			SoundEvent event = <event> object = SfxPreviewEventObject <...>
		else

		endif
		waittime = 0
		begin
		if NOT (isSoundEventPlaying <event>)
			break
		endif
		if (<waittime> > 200)
			StopSoundEvent <event>
			break
		endif
		Wait \{0.1
			seconds}
		waittime = (<waittime> + 1)
		repeat
		SfxDestroyTestObject
	else

	endif
endscript
