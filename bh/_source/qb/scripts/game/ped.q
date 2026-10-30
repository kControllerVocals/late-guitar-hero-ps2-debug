gameobj_animtree = {
	type = degenerateblend
	id = body
}
gameobj_standardanimbranch = {
	type = timertype
	id = bodytimer
	anim = anim
	anim_events = animevents
	speed = speed
	start = start
	[
		{
			type = source
			anim = anim
		}
	]
}
ped_flip = 0x24d8810d
ped_setanimcyclemode = 0x24d8810d
ped_getanimduration = 0x24d8810d
ped_animcomplete = 0x24d8810d
ped_waitanim = 0x24d8810d
ped_waitanimfinished = 0x24d8810d
ped_anim_command = 0x24d8810d
ped_playanim = 0x24d8810d
ped_adddegenerateblendbranch = 0x24d8810d
ped_initstaticanimtree = 0x24d8810d

script gameobj_init_animtree 
	if gotparam \{profile}
		addparams <profile>
	endif
	if gotparam \{animtargets}
		anim_inittree {
			tree = <tree>
			defaultcommandtarget = <defaultcommandtarget>
			nodeiddeclaration = <animtargets>
			params = <animtreeparams>
			animeventtablename = <animeventtablename>
		}
		anim_enable \{off}
	endif
endscript

script gameobj_playanim \{target = body
		tree = $gameobj_standardanimbranch
		timertype = play
		speed = 1.0
		start = 0.0
		animevents = off
		blendduration = -1.0}
	if NOT gotparam \{anim}
		anim_getdefaultanimname
		anim = <defaultanimname>
	endif
	anim_enable
	anim_command target = <target> command = degenerateblend_addbranch params = {
		tree = <tree>
		blendduration = <blendduration>
		params = {
			anim = <anim>
			speed = <speed>
			timertype = <timertype>
			start = <start>
			animevents = <animevents>
		}
	}
endscript

script gameobj_waitanimfinished \{timer = bodytimer}
	anim_command target = <timer> command = timer_waitanimcomplete
endscript

script gameobj_waitanim 
	anim_command target = bodytimer command = timer_wait params = {<...>}
endscript

script gameobj_animcomplete \{timer = bodytimer}
	if anim_command target = <timer> command = timer_isanimcomplete
		return \{scriptresult = 1}
	else
		return \{scriptresult = 0}
	endif
endscript

script createobjlabel 
	obj_getid
	spawnscriptlater maintainobjlabel params = {objid = <objid>}
endscript

script maintainobjlabel 
	<id> = (<objid> + 5)
	begin
	if compositeobjectexists name = <objid>
		<objid> :obj_getposition
		formattext textname = text qs(0x0bc409e2) a = <objid> nowarning
		if objectexists id = <id>
			setscreenelementprops id = <id> text = <text> pos3d = (<pos> + (0.0, 80.0, 0.0)) rgba = [100 0 0 128]
		else
			create_object_label id = <id> text = <text> pos3d = (<pos> + (0.0, 80.0, 0.0)) rgba = [100 0 0 128]
		endif
	else
		if screenelementexists id = <id>
			destroyscreenelement id = <id>
		endif
		break
	endif
	wait \{1
		frame}
	repeat
endscript

script ped_disable_bones 
endscript

script ped_enable_bones 
endscript

script ped_initbehaviorfromprofile 
	if gotparam \{behaviorinitscript}
		<behaviorinitscript>
	endif
endscript

script create_ped_label 
	setscreenelementlock \{id = root_window
		off}
	createscreenelement {
		id = <id>
		type = textblockelement
		parent = root_window
		font = fontgrid_text_a3
		text = qs(0x03ac90f0)
		scale = 1.0
		pos = (0.0, 0.0)
		rgba = [0 128 0 128]
		dims = (250.0, 0.0)
		allow_expansion
		just = [center top]
	}
endscript

script destroy_ped_label 
	if objectexists id = <id>
		destroyscreenelement id = <id>
	endif
endscript

script destroy_global_peds_in_zone 
	if NOT ($disable_global_pedestrians = 1)
		if NOT innetgame
			if iscoiminited

				cleanupglobalpednodearray name = 'zones/z_peds/z_peds.qb' zone = <zone>
			endif
		endif
	endif
endscript

script spawn_global_peds_in_zone 
	if NOT ($disable_global_pedestrians = 1)
		if NOT innetgame
			if iscoiminited

				parseglobalpednodearray name = 'zones/z_peds/z_peds.qb' zone = <zone>
			endif
		endif
	endif
endscript
