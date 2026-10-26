
script restore_group_defaults 

	if NOT GetCASAppearancePart part = <part>

	endif
	cas_bonemenu_exit \{part = CAS_Body}
	if GotParam \{bones}
		SoundEvent \{event = character_reset}
		GetArraySize \{option_array}
		i = 0
		begin
		if StructureContains Structure = (<option_array> [<i>]) group_name
			if StructureContains Structure = bones name = ((<option_array> [<i>]).group_name)
				RemoveComponent structure_name = bones name = ((<option_array> [<i>]).group_name)
			endif
		elseif StructureContains Structure = (<option_array> [<i>]) part
			if ChecksumEquals a = ((<option_array> [<i>]).part) b = CAS_Eyes
				cas_add_item_to_appearance \{part = CAS_Eyes
					desc_id = eyes_blue}
			endif
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	cas_bonemenu_begin \{part = CAS_Body}
	SetCASAppearanceBones part = <part> bones = <bones>
	cas_bonemenu_apply_changes
	GetArraySize \{option_array}
	i = 0
	begin
	if StructureContains Structure = ((<option_array>) [<i>]) bonemenu
		FormatText checksumname = widget_id 'widget_%i' i = <i>
		cas_get_bone_slider_value part = CAS_Body group_name = ((<option_array> [<i>]).group_name)
		button_widget_set_value widget_id = <widget_id> new_value = <slider>
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script update_bone_deformation 

	GetCASAppearancePart part = <part>
	if NOT GotParam \{bones}
		bones = {}
	endif
	UpdateStructElement struct = <bones> element = <group_name> value = <value>
	SetCASAppearanceBones part = <part> bones = <newstruct>
	UpdateCurrentCASModel buildScript = reskin_model_from_appearance buildscriptparams = {kill_objects = <kill_objects>}
endscript
