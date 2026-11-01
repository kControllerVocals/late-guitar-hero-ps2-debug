jowBlue = 717488127
jowGreen = 771697407
jowOrange = -6149377
jowRed = -15061505
jowYellow = -3267073

script JOW_Stars 



endscript

script SafeGetUniqueCompositeObjectID \{preferredID = safeFXID01}
	if NOT GotParam \{ObjID}
		GetUniqueCompositeObjectID preferredID = <preferredID>
		return uniqueID = <uniqueID>
	endif
	i = 0
	FormatText TextName = index '%i' i = <i>
	ExtendCRC <preferredID> <index> out = preferredID
	begin
	MangleChecksums a = <preferredID> b = <ObjID>
	if NOT ObjectExists id = <mangled_ID>
		return uniqueID = <preferredID>
	else
		i = (<i> + 1)
		FormatText TextName = index '%i' i = <i>
		ExtendCRC <preferredID> <index> out = preferredID
	endif
	repeat
endscript

script LoseFX_GuitarSmoke_01 
	Obj_GetID
	GetUniqueCompositeObjectID \{preferredID = FX_LoseSmoke_01}
	CreateParticleSystem name = <uniqueID> ObjID = <ObjID> bone = Bone_Guitar_Body params_Script = $GP_FX_LoseSmoke_01
endscript

script LoseFX_GuitarSparks_01 
	Obj_GetID
	GetUniqueCompositeObjectID \{preferredID = FX_LoseSparks_01}
	CreateParticleSystem name = <uniqueID> ObjID = <ObjID> bone = Bone_Guitar_Body params_Script = $GP_FX_LoseSparks_01
endscript
