
script check_if_part_deformable 
	if GetCASAppearancePart part = <part>
		GetActualCASOptionStruct part = <part> desc_id = <desc_id>
		if GotParam \{deform_bones}
			return \{is_enabled = 1}
		endif
	endif
	return \{is_enabled = 0}
endscript

script is_part_capable 

	if GetCASAppearancePart part = <part>
		GetActualCASOptionStruct part = <part> desc_id = <desc_id>
		if GotParam \{sections}
			return \{true}
		endif
	endif
	return \{false}
endscript

script check_if_part_editable 
	<retVal> = 0
	if GotParam \{part}
		if GetCASAppearancePart part = <part>
			if (<desc_id> = none)
				<retVal> = 0
			else
				<retVal> = 1
			endif
		endif
	endif
	if (<retVal>)
		if GotParam \{extra_script}
			<extra_script> <extra_script_params> part = <part>
			<retVal> = <is_enabled>
		endif
	endif
	return is_enabled = <retVal>
endscript

script check_if_parts_editable 
	<retVal> = 0
	if GotParam \{parts}
		GetArraySize <parts>
		<index> = 0
		begin
		if GetCASAppearancePart part = (<parts> [<index>])
			if (<desc_id> = none)
				<retVal> = 0
			else
				<retVal> = 1
				break
			endif
		endif
		<index> = (<index> + 1)
		repeat <array_size>
	endif
	return is_enabled = <retVal>
endscript

script check_if_part_logoable 
	<retVal> = 0
	if GotParam \{extra_script}
		<extra_script> <extra_script_params>
		if (<is_enabled> = 0)
			return is_enabled = <is_enabled>
		endif
	endif
	if GotParam \{parts}
		GetArraySize <parts>
		<index> = 0
		begin
		character_part = (<parts> [<index>])
		if GetCASAppearancePart part = <character_part>
			GetActualCASOptionStruct part = <character_part> desc_id = <desc_id>
			if GotParam \{supports_logo}
				<retVal> = 1
				break
			else
				<retVal> = 0
				break
			endif
		endif
		<index> = (<index> + 1)
		repeat <array_size>
	endif
	return is_enabled = <retVal>
endscript

script check_if_part_front_logoable 
	if GotParam \{extra_script}
		<extra_script> <extra_script_params>
		if (<is_enabled> = 0)
			return is_enabled = <is_enabled>
		endif
	endif
	check_if_part_logoable <...>
	if (<is_enabled> = 1)
		if GotParam \{parts}
			GetArraySize <parts>
			<index> = 0
			begin
			character_part = (<parts> [<index>])
			if GetCASAppearancePart part = <character_part>
				GetActualCASOptionStruct part = <character_part> desc_id = <desc_id>
				if GotParam \{no_front_logo}
					return \{is_enabled = 0}
				endif
			endif
			<index> = (<index> + 1)
			repeat <array_size>
		endif
	endif
	return is_enabled = <is_enabled>
endscript

script check_if_part_back_logoable 
	if GotParam \{extra_script}
		<extra_script> <extra_script_params>
		if (<is_enabled> = 0)
			return is_enabled = <is_enabled>
		endif
	endif
	check_if_part_logoable <...>
	if (<is_enabled> = 1)
		if GotParam \{parts}
			GetArraySize <parts>
			<index> = 0
			begin
			character_part = (<parts> [<index>])
			if GetCASAppearancePart part = <character_part>
				GetActualCASOptionStruct part = <character_part> desc_id = <desc_id>
				if GotParam \{no_back_logo}
					return \{is_enabled = 0}
				endif
			endif
			<index> = (<index> + 1)
			repeat <array_size>
		endif
	endif
	return is_enabled = <is_enabled>
endscript

script check_if_part_back_logo_adjustable 
	check_if_part_back_logoable <...>
	if (<is_enabled> = 1)
		check_if_part_logo_adjustable <...>
		return is_enabled = <is_enabled>
	endif
	return is_enabled = <is_enabled>
endscript

script check_if_part_front_logo_adjustable 
	check_if_part_front_logoable <...>
	if (<is_enabled> = 1)
		check_if_part_logo_adjustable <...>
		return is_enabled = <is_enabled>
	endif
	return is_enabled = <is_enabled>
endscript

script check_if_part_logo_adjustable 
	GetArraySize \{parts}
	if NOT (<array_size> = 1)

	endif
	if GetCASAppearancePart part = <logo_part>
		if (<desc_id> = none)
			return \{is_enabled = 0}
		endif
	else
		return \{is_enabled = 0}
	endif
	character_part = (<parts> [0])
	if GetCASAppearancePart part = <character_part>
		GetActualCASOptionStruct part = <character_part> desc_id = <desc_id>
		ExtendCRC <logo_part> '_Adjust' out = adjustcrc
		if GotParam <adjustcrc>
			if NOT StructureContains Structure = <adjustcrc> material

			elseif NOT StructureContains Structure = <adjustcrc> pass

			endif
			return \{is_enabled = 1}
		endif
	endif
	return \{is_enabled = 0}
endscript

script check_if_has_belt 
	<retVal> = 0
	if GetCASAppearancePart \{part = CAS_Belt}
		if NOT (<desc_id> = none)
			<retVal> = 1
		endif
	endif
	return is_enabled = <retVal>
endscript

script check_if_part_colorable 
	<retVal> = 0
	if GotParam \{extra_script}
		<extra_script> <extra_script_params>
		if (<is_enabled> = 0)
			return is_enabled = <is_enabled>
		endif
	endif
	if GotParam \{parts}
		GetArraySize <parts>
		<index> = 0
		begin
		character_part = (<parts> [<index>])
		if GetCASAppearancePart part = <character_part>
			if (<desc_id> = none)
				<retVal> = 0
				break
			else
				if GetActualCASOptionStruct part = <character_part> desc_id = <desc_id> dont_assert
					if GotParam \{color_all_materials}
						<retVal> = 1
						break
					else
						if GotParam \{materials}
							GetArraySize <materials>
							if (<array_size> > 0)
								<retVal> = 1
							else
								<retVal> = 0
							endif
						else
							<retVal> = 0
						endif
						break
					endif
				endif
			endif
		endif
		<index> = (<index> + 1)
		repeat <array_size>
	endif
	return is_enabled = <retVal>
endscript

script check_if_secondary_colorable 
	check_if_part_colorable <...>
	if (<is_enabled> = 0)
		return is_enabled = <is_enabled>
	endif
	if GotParam \{parts}
		GetArraySize <parts>
		<index> = 0
		begin
		character_part = (<parts> [<index>])
		if GetCASAppearancePart part = <character_part>
			GetActualCASOptionStruct part = <character_part> desc_id = <desc_id>
			if GotParam \{color_all_materials}
				<retVal> = 1
				break
			endif
			if GotParam \{materials}
				GetArraySize <materials>
				if (<array_size> > 1)
					<retVal> = 1
				else
					<retVal> = 0
				endif
			else
				<retVal> = 0
			endif
			break
		endif
		<index> = (<index> + 1)
		repeat <array_size>
	endif
	return is_enabled = <retVal>
endscript

script cas_item_is_visible 
	if IsTrue \{$worst_case_cas_debug}
		return \{true}
	endif
	if StructureContains Structure = ($<part> [<part_index>]) hidden
		return \{false}
	endif
	return \{true}
endscript

script cas_item_rebuild 
	if NOT GetCASAppearancePart part = <part>

	endif
	if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>

	endif
	if NOT GotParam \{no_rebuild}
		return \{true}
	else
		return \{false}
	endif
endscript

script cas_item_matches_genre 
endscript

script get_part_current_desc_id 
	if GetCASAppearancePart part = <part>
		if GotParam \{desc_id}
			return true current_desc_id = <desc_id>
		endif
	endif
	return \{false
		current_desc_id = none}
endscript

script get_is_wearing_cas_item 
	if get_part_current_desc_id part = <part>
		if (<current_desc_id> = <desc_id>)
			return \{true}
		endif
	endif
	return \{false}
endscript

script get_key_from_appearance 
	GetArraySize \{$master_editable_list}
	i = 0
	begin
	part_name = ((($master_editable_list) [<i>]).part)
	if StructureContains Structure = <appearance> <part_name>
		if StructureContains Structure = (<appearance>.<part_name>) desc_id
			desc_id = ((<appearance>.<part_name>).desc_id)
			find_part_in_cache part_type = <part_name> desc_id = <desc_id>
			is_instrument_part = 0
			if FilterPartByInstrument part = <part_name> instrument = none
				is_instrument_part = 1
			endif
			if NOT (<index> = -1 && <is_instrument_part>)
				if GetActualCASOptionStruct part = <part_name> desc_id = <desc_id>
					if GotParam <key>
						ret_struct = {}
						UpdateStructElement struct = <ret_struct> element = <key> value = ((<...>).<key>)
						return true {<newstruct>}
					endif
				endif
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script get_part_key_from_appearance 
	if StructureContains Structure = <appearance> <part>
		if StructureContains Structure = (<appearance>.<part>) desc_id
			unload_pak_after = 0
			if NOT load_part_desc_pak part_type = <part>
				unload_pak_after = 1
			endif
			if GetActualCASOptionStruct part = <part> desc_id = ((<appearance>.<part>).desc_id)
				if (<unload_pak_after> = 1)
					unload_part_desc_pak part_type = <part>
				endif
				if GotParam <key>
					ret_struct = {}
					UpdateStructElement struct = <ret_struct> element = <key> value = ((<...>).<key>)
					return true {<newstruct>}
				endif
			endif
			if (<unload_pak_after> = 1)
				unload_part_desc_pak part_type = <part>
			endif
		endif
	endif
	return \{false}
endscript

script get_body_key_from_appearance 
	if StructureContains Structure = <appearance> CAS_Body
		GetActualCASOptionStruct part = CAS_Body desc_id = (<appearance>.CAS_Body.desc_id)
		if GotParam <key>
			ret_struct = {}
			UpdateStructElement struct = <ret_struct> element = <key> value = ((<...>).<key>)
			return true {<newstruct>}
		endif
	elseif StructureContains Structure = <appearance> CAS_Full_Body
		GetActualCASOptionStruct part = CAS_Full_Body desc_id = (<appearance>.CAS_Full_Body.desc_id)
		if GotParam <key>
			ret_struct = {}
			UpdateStructElement struct = <ret_struct> element = <key> value = ((<...>).<key>)
			return true {<newstruct>}
		endif
	else

	endif
	return \{false}
endscript

script FindFrontEndDescFromChecksum 
	part_struct = ($<part>)
	GetArraySize <part_struct>
	<i> = 0
	begin
	if ((<part_struct> [<i>].desc_id) = <desc_id>)
		if StructureContains Structure = (<part_struct> [<i>]) frontend_desc
			<return_val> = (<part_struct> [<i>].frontend_desc)
		endif
	endif
	<i> = (<i> + 1)
	repeat <array_size>

endscript

script check_need_to_block_back 
	switch <part>
		case CAS_Male_Intro_Anim
		case CAS_Male_Win_Anim
		case CAS_Male_Lose_Anim
		case CAS_Female_Intro_Anim
		case CAS_Female_Win_Anim
		case CAS_Female_Lose_Anim
		case CAS_Guitar_Highway
		case CAS_Bass_Highway
		case CAS_Drums_Highway
		return \{true}
	endswitch
	return \{false}
endscript

script cas_add_item_to_appearance 

	cas_handle_disqualifications part = <part> desc_id = <desc_id>
	if GotParam \{new_desc_id}
		desc_id = <new_desc_id>

	endif
	EditCASAppearance target = SetPart targetParams = {part = <part> desc_id = <desc_id>}
	ps2_GetActualCASOptionStruct_as_struct part = <part> desc_id = <desc_id>
	if StructureContains Structure = (<ps2_part_struct>) Finishable
		EditCASAppearance target = SetPart targetParams = {part = (<ps2_part_struct>.Finishable) desc_id = none}
	endif
	if StructureContains Structure = (<ps2_part_struct>) Detailable
		EditCASAppearance target = SetPart targetParams = {part = (<ps2_part_struct>.Detailable) desc_id = none}
	endif
	if StructureContains Structure = (<ps2_part_struct>) Logoable
		EditCASAppearance target = SetPart targetParams = {part = (<ps2_part_struct>.Logoable) desc_id = none}
	endif
	if StructureContains Structure = (<ps2_part_struct>) Fadeable
		EditCASAppearance target = SetPart targetParams = {part = (<ps2_part_struct>.Fadeable) desc_id = none}
	endif
	if NOT GotParam \{no_rebuild}
		if GotParam \{incremental}
			spawnscriptnow \{trigger_CAS_rebuild_loop}
		else
			spawnscriptnow \{trigger_CAS_rebuild_loop}
		endif
	endif
	if IsTrue \{$cas_debug}
		DumpHeaps
	endif
endscript

script draw_guitar_center_logo 
	if ScreenElementExists \{id = sponsor_logo}
		SetScreenElementProps \{id = sponsor_logo
			alpha = 0.4
			texture = gc_logo}
	else
		CreateScreenElement \{blend = Add
			type = SpriteElement
			parent = generic_menu
			id = sponsor_logo
			texture = gc_logo
			alpha = 0.4
			pos = (130.0, 430.0)
			dims = (360.0, 180.0)
			just = [
				left
				top
			]
			rgba = [
				255
				255
				255
				255
			]
			z_priority = 4
			rot_angle = 0.0}
	endif
endscript

script get_sponsor_logo_from_id 

	if (<sponsor_id> = no_sponsor)
		return \{sponsor_texture = white}
	endif
	i = 0
	GetArraySize \{$CAS_Sponsors}
	begin
	if ($CAS_Sponsors [<i>].id = <sponsor_id>)
		return sponsor_texture = ($CAS_Sponsors [<i>].texture)
	endif
	i = (<i> + 1)
	repeat (<array_size>)
	debug_ScriptAssert qs(0xb042eb53) s = <sponsor_id>
	return \{sponsor_texture = white}
endscript

script draw_sponsor_logo 
	if NOT GotParam \{sponsor_texture}
		if NOT GotParam \{sponsor_id}
			debug_ScriptAssert \{qs(0x48adbe09)}
		else
			get_sponsor_logo_from_id sponsor_id = <sponsor_id>
		endif
	endif
	if (<sponsor_texture> = white)
		alpha = 0.0
	else
		alpha = 1.0
	endif
	if ScreenElementExists \{id = sponsor_logo}
		SetScreenElementProps id = sponsor_logo {
			alpha = <alpha>
			texture = <sponsor_texture>
		}
	else
		CreateScreenElement {
			blend = Add
			type = SpriteElement
			parent = generic_menu
			id = sponsor_logo
			pos = (130.0, 460.0)
			dims = (360.0, 180.0)
			just = [left top]
			rgba = [255 255 255 255]
			z_priority = 4
			alpha = <alpha>
			texture = <sponsor_texture>
			rot_angle = 0.0
		}
	endif
endscript

script cas_find_tex_swap_parts \{tex_swap_parts = [
		]}

	GetArraySize <part_list>
	i = 0
	begin
	if StructureContains Structure = (<part_list> [<i>]) part
		part_name = (<part_list> [<i>].part)
		if StructureContains Structure = <appearance> <part_name>
			part_desc = ((<appearance>).<part_name>)
			if StructureContains Structure = <part_desc> desc_id
				if cas_has_tex_replace part = <part_name> desc_id = ((<part_desc>).desc_id)
					if NOT ArrayContains array = <tex_swap_parts> contains = <part_name>
						ve_convert_checksum_to_array checksum = <part_name>
						tex_swap_parts = (<tex_swap_parts> + <checksum_array>)
					endif
				endif
			endif
		endif
		if StructureContains Structure = (<part_list> [<i>]) desc_id
			if cas_has_tex_replace part = <part_name> desc_id = ((<part_list> [<i>]).desc_id)
				if NOT ArrayContains array = <tex_swap_parts> contains = <part_name>
					ve_convert_checksum_to_array checksum = <part_name>
					tex_swap_parts = (<tex_swap_parts> + <checksum_array>)
				endif
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	return tex_swap_parts = <tex_swap_parts>
endscript

script cas_has_tex_replace 
	GetActualCASOptionStruct part = <part> desc_id = <desc_id>
	if ((GotParam replace) || (GotParam replace1) || (GotParam replace2) || (GotParam replace3))
		return \{true}
	endif
	return \{false}
endscript

script cas_desc_id_is_excluded \{part_name = none
		part_desc_id = none}
	if ChecksumEquals a = <part_desc_id> b = none
		return \{false}
	endif
	if cas_part_is_excluded part_name = <part_name>
		return true conflict_part = <conflict_part>
	endif
	GetArraySize ($master_editable_list)
	i = 0
	begin
	list_part_name = ((($master_editable_list) [<i>]).part)
	if NOT ChecksumEquals a = <list_part_name> b = <part_name>
		if cas_desc_id_is_excluded_part list_part_name = <list_part_name> change_part_name = <part_name> change_part_desc_id = <part_desc_id>
			return true conflict_part = <conflict_part>
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script cas_desc_id_is_excluded_part 
	if GetCASAppearancePart part = <list_part_name>
		if GetActualCASOptionStruct part = <list_part_name> desc_id = <desc_id>
			if GotParam \{exclusions}
				conflict_part = {part = <list_part_name> desc_id = <desc_id>}
				if StructureContains Structure = <exclusions> <change_part_name>
					exclusion = (<exclusions>.<change_part_name>)
					if NOT StructureContains Structure = <exclusion> reverse
						if cas_disq_matches_change_from exclusion = <exclusion> desc_id = <change_part_desc_id>
							return true conflict_part = <conflict_part>
						endif
					endif
				endif
			endif
		endif
	endif
	return \{false}
endscript

script cas_part_is_excluded \{part_name = none}
	GetArraySize ($master_editable_list)
	i = 0
	begin
	list_part_name = ((($master_editable_list) [<i>]).part)
	if NOT ChecksumEquals a = <list_part_name> b = <part_name>
		if cas_part_is_excluded_part list_part_name = <list_part_name> change_part_name = <part_name> change_part_desc_id = <part_desc_id>
			return true conflict_part = <conflict_part>
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script cas_part_is_excluded_part 
	if GetCASAppearancePart part = <list_part_name>
		if GetActualCASOptionStruct part = <list_part_name> desc_id = <desc_id>
			conflict_part = {part = <list_part_name> desc_id = <desc_id>}
			if GotParam \{exclusions}
				if StructureContains Structure = <exclusions> <change_part_name>
					exclusion = (<exclusions>.<change_part_name>)
					if NOT StructureContains Structure = <exclusion> reverse
						if NOT StructureContains Structure = <exclusion> change_from
							return true conflict_part = <conflict_part>
						endif
					endif
				endif
			endif
			if GotParam \{hide_parts}
				i = 0
				GetArraySize <hide_parts>
				if (<array_size> > 0)
					begin
					if ChecksumEquals a = (<hide_parts> [<i>]) b = <change_part_name>
						return true conflict_part = <conflict_part>
					endif
					i = (<i> + 1)
					repeat <array_size>
				endif
			endif
		endif
	endif
	return \{false}
endscript

script cas_part_will_conflict \{part_name = none
		part_desc_id = none}
	if ChecksumEquals a = <part_desc_id> b = none
		return \{false}
	endif
	if ChecksumEquals a = <part_name> b = none
		return \{false}
	endif
	GetActualCASOptionStruct part = <part_name> desc_id = <part_desc_id>
	change_parts = []
	conflict = false
	if GotParam \{inclusion}
		GetArraySize <inclusion>
		inclusion_size = (<array_size>)
		actual_inclusion = <inclusion>
		if (<inclusion_size> > 0)
			i = 0
			begin
			if GetCASAppearancePart part = (<actual_inclusion> [<i>].part)
				valid = (<actual_inclusion> [<i>].valid)
				if NOT ((ChecksumEquals a = <desc_id> b = none) || (ArrayContains array = <valid> contains = <desc_id>))
					GetArraySize <valid>
					j = 0
					begin
					if is_part_unlocked_purchased part = (<actual_inclusion> [<i>].part) desc_id = ((<actual_inclusion> [<i>].valid) [<j>]) savegame = ($cas_current_savegame)
						AddArrayElement array = <change_parts> element = {part = (<actual_inclusion> [<i>].part) desc_id = ((<actual_inclusion> [<i>].valid) [<j>])}
						change_parts = <array>
						conflict = true
						break
					else
						if ((<j> + 1) = <array_size>)

						endif
					endif
					j = (<j> + 1)
					repeat <array_size>
				endif
			endif
			i = (<i> + 1)
			repeat <inclusion_size>
		endif
	endif
	GetArraySize \{change_parts}
	if (<array_size> > 0)
		return change_parts = <change_parts>
	else
		return
	endif
endscript

script cas_in_inclusion_list 
	if GotParam \{inclusion}
		GetArraySize \{inclusion}
		matched_part = 0
		if (<array_size> > 0)
			i = 0
			begin
			inc_part = (<inclusion> [<i>].part)
			if (ChecksumEquals a = <inc_part> b = <part_name>)
				matched_part = 1
				if ArrayContains array = (<inclusion> [<i>].valid) contains = <part_desc_id>

					return \{true}
				endif
			endif
			i = (<i> + 1)
			repeat <array_size>
			if (<matched_part> = 0)
				return \{true}
			endif
		endif
	else
		return \{true}
	endif
	return \{false}
endscript

script is_part_unlocked 

	if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>

	endif
	if GotParam \{locked}
		get_current_band_part_flags part = <part> desc_id = <desc_id> savegame = <savegame>
		if GotParam \{part_flags}
			if StructureContains Structure = <part_flags> unlocked
				return \{true}
			else
				return \{false}
			endif
		else
			return \{false}
		endif
	else
		return \{true}
	endif
endscript

script is_part_purchased 

	if NOT GetActualCASOptionStruct part = <part> desc_id = <desc_id>

	endif
	if GotParam \{price}
		get_current_band_part_flags part = <part> desc_id = <desc_id> savegame = <savegame>
		if GotParam \{part_flags}
			if StructureContains Structure = <part_flags> purchased
				return \{true}
			else
				return \{false}
			endif
		else
			return \{false}
		endif
	else
		return \{true}
	endif
endscript

script is_part_unlocked_purchased 

	if is_part_unlocked part = <part> desc_id = <desc_id> savegame = <savegame>
		if is_part_purchased part = <part> desc_id = <desc_id> savegame = <savegame>
			return \{true}
		endif
	endif
	return \{false}
endscript

script is_part_purchased_preset 

	if StructureContains Structure = <preset> price
		get_current_band_part_flags part = <part> desc_id = <desc_id> savegame = <savegame>
		if GotParam \{part_flags}
			if StructureContains Structure = <part_flags> purchased
				return \{true}
			else
				return \{false}
			endif
		else
			return \{false}
		endif
	else
		return \{true}
	endif
endscript
ps2_part_pak_unloading = 0

script IncrementPartPakUnloading 

	change ps2_part_pak_unloading = ($ps2_part_pak_unloading + 1)
endscript

script DecrementPartPakUnloading 

	change ps2_part_pak_unloading = ($ps2_part_pak_unloading - 1)
endscript

script UnloadAppearancePaks \{asset_context = 0
		async = 0}

	if GotParam \{appearance}
		if NOT ($ps2_cas_load_canceled = 1)
			SetCASAppearance appearance = <appearance>
		endif
	endif
	if (<async> = 1)
		change \{ps2_part_pak_unloading = 0}
		foreachincas do = UnloadPartPak params = {asset_context = <asset_context> <...>}
		begin
		if IsPartPakUnloadDone
			break
		endif
		Wait \{1
			gameframe}
		repeat
		if get_key_from_appearance \{key = shadow_pak
				appearance = $cas_current_appearance}
			IncrementPartPakUnloading
			SpawnScriptLater UnloadAppearancePak_Async params = {asset_context = <asset_context> pak = <shadow_pak>}
			begin
			if IsPartPakUnloadDone
				break
			endif
			Wait \{1
				gameframe}
			repeat
		endif
	else
		foreachincas do = UnloadPartPak params = {asset_context = <asset_context> <...>}
		if get_key_from_appearance \{key = shadow_pak
				appearance = $cas_current_appearance}
			PushAssetContext context = <asset_context>
			UnloadPak (<shadow_pak>) SameHeaps
			if NOT GotParam \{no_wait}
				WaitUnloadPak <shadow_pak> Block
			endif
			PopAssetContext
		endif
	endif
endscript
ps2_part_pak_loading = 0

script IncrementPartPakLoading 

	change ps2_part_pak_loading = ($ps2_part_pak_loading + 1)
endscript

script DecrementPartPakLoading 

	change ps2_part_pak_loading = ($ps2_part_pak_loading - 1)
endscript
ps2_loading_appearance_paks = 0

script LoadAppearancePaks \{reload = 0
		async = 0}

	change \{ps2_loading_appearance_paks = 1}

	if (<reload> = 1)
		UnloadAppearancePaks {asset_context = <asset_context> <...>}
	endif
	if GotParam \{appearance}
		if NOT ($ps2_cas_load_canceled = 1)
			SetCASAppearance appearance = <appearance>
		endif
	endif
	if (<async> = 1)
		change \{ps2_part_pak_loading = 0}
		GetArraySize ($master_editable_list)
		i = 0
		begin
		part_struct = ($master_editable_list [(<i>)])
		part_slot = (<part_struct>.part)
		if LoadPartPak {part = <part_slot> asset_context = <asset_context> <...>}
			begin
			if IsPartPakLoadDone
				break
			endif
			Wait \{1
				gameframes}
			repeat
		endif
		i = (<i> + 1)
		repeat <array_size>
		if NOT ($ps2_cas_load_canceled = 1)
			if get_key_from_appearance \{key = shadow_pak
					appearance = $cas_current_appearance}
				change \{ps2_part_pak_loading = 0}
				PushAssetContext context = <asset_context>
				IncrementPartPakLoading
				LoadPak <shadow_pak> heap = <heap> load_callback = LoadPartPak_Done callback_data = none
				PopAssetContext
				begin
				if IsPartPakLoadDone
					break
				endif
				Wait \{1
					gameframes}
				repeat
			endif
		endif
	else
		foreachincas do = LoadPartPak params = {asset_context = <asset_context> <...>}
		if NOT ($ps2_cas_load_canceled = 1)
			if get_key_from_appearance \{key = shadow_pak
					appearance = $cas_current_appearance}
				PushAssetContext context = <asset_context>
				LoadPak <shadow_pak> heap = <heap>
				PopAssetContext
			endif
		endif
	endif
	change \{ps2_loading_appearance_paks = 0}
endscript

script LoadPartPak \{instrument = none
		asset_context = 0
		async = 0}
	if ($ps2_cas_load_canceled = 1)
		return
	endif
	SetCASAppearance appearance = <appearance>
	if GetCASAppearancePart part = <part>
		if FilterPartByInstrument part = <part> instrument = <instrument>
			return \{false}
		endif
		if (<part> = CAS_Male_Hair || <part> = CAS_Female_Hair)
			get_hat_hair_choice appearance = <appearance>
			if (<hat_hair_choice> = hat_hair)
				return \{false}
			endif
		endif
		get_cached_part part_type = <part> desc_id = <desc_id>
		if GotParam \{cached_part_struct}
			if load_cached_part_pak <...>
				return \{true}
			endif
		elseif GetActualCASOptionStruct part = <part> desc_id = <desc_id>
			if GotParam \{add_to_nodes}
				PushAssetContext context = <asset_context>
				add_to_nodes_copy = <add_to_nodes>
				GetArraySize <add_to_nodes>
				i = 0
				begin
				node_child_struct = (<add_to_nodes_copy> [<i>])
				if GetActualCASOptionStruct part = (<node_child_struct>.part_type) desc_id = (<node_child_struct>.desc_id)
					if (<async> = 1)
						IncrementPartPakLoading
						LoadPak <pak> heap = <heap> load_callback = LoadPartPak_Done callback_data = none
					else
						LoadPak <pak> heap = <heap>
					endif
				endif
				i = (<i> + 1)
				repeat <array_size>
				PopAssetContext
				return \{true}
			elseif GotParam \{pak}
				PushAssetContext context = <asset_context>
				if (<async> = 1)
					IncrementPartPakLoading
					LoadPak <pak> heap = <heap> load_callback = LoadPartPak_Done callback_data = none
				else
					LoadPak <pak> heap = <heap>
				endif
				PopAssetContext
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script LoadPartPak_Done 

	if ($ps2_part_pak_loading > 0)
		DecrementPartPakLoading
	endif
endscript

script IsPartPakLoadDone 
	if ($ps2_part_pak_loading > 0)
		return \{false}
	endif
	return \{true}
endscript

script UnloadPartPak \{asset_context = 0
		async = 0}
	if NOT ($ps2_cas_load_canceled = 1)
		SetCASAppearance appearance = <appearance>
	endif
	if GetCASAppearancePart part = <part>
		if FilterPartByInstrument part = <part> instrument = <instrument>
			return
		endif
		get_cached_part part_type = <part> desc_id = <desc_id>
		if GotParam \{cached_part_struct}
			if unload_cached_part_pak <...>
				return \{true}
			endif
		elseif GetActualCASOptionStruct part = <part> desc_id = <desc_id>
			if GotParam \{add_to_nodes}
				add_to_nodes_copy = <add_to_nodes>
				GetArraySize <add_to_nodes>
				i = 0
				begin
				node_child_struct = (<add_to_nodes_copy> [<i>])
				if GetActualCASOptionStruct part = (<node_child_struct>.part_type) desc_id = (<node_child_struct>.desc_id)
					if (<async> = 1)
						IncrementPartPakUnloading
						SpawnScriptLater UnloadAppearancePak_Async params = {asset_context = <asset_context> pak = <pak>}
					else
						PushAssetContext context = <asset_context>
						UnloadPak <pak> SameHeaps
						if NOT GotParam \{no_wait}
							WaitUnloadPak <pak> Block
						endif
						PopAssetContext
					endif
				endif
				i = (<i> + 1)
				repeat <array_size>
				return \{true}
			elseif GotParam \{pak}
				if (<async> = 1)
					IncrementPartPakUnloading
					SpawnScriptLater UnloadAppearancePak_Async params = {asset_context = <asset_context> pak = <pak>}
				else
					PushAssetContext context = <asset_context>
					UnloadPak <pak> SameHeaps
					if NOT GotParam \{no_wait}
						WaitUnloadPak <pak> Block
					endif
					PopAssetContext
				endif
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script UnloadAppearancePak_Async 
	PushAssetContext context = <context>
	UnloadPak <pak> SameHeaps
	begin
	if WaitUnloadPak <pak> noblock
		break
	endif
	Wait \{1
		gameframe}
	repeat
	DecrementPartPakUnloading
	PopAssetContext
endscript

script IsPartPakUnloadDone 
	if ($ps2_part_pak_unloading = 0)
		return \{true}
	endif
	return \{false}
endscript
ps2_changing_appearance_paks = 0

script ChangeAppearancePaks \{current_instrument = none
		new_instrument = none}
	change \{ps2_changing_appearance_paks = 1}
	if NOT GotParam \{diff_array}
		if NOT GotParam \{diff_array_size}
			DiffAppearances <...>
		endif
	endif
	if (<diff_array_size> = 0)
		change \{ps2_changing_appearance_paks = 0}
		return
	endif
	if NOT ($ps2_cas_load_canceled = 1)
		SetCASAppearance appearance = <current_appearance>
	endif
	i = 0
	begin
	part = (<diff_array> [<i>])
	if StructureContains Structure = current_appearance <part>
		UnloadPartPak part = <part> instrument = <current_instrument> no_wait asset_context = <asset_context> appearance = <current_appearance>
		if (<part> = CAS_Male_Base_Torso || <part> = CAS_Female_Base_Torso || <part> = CAS_Full_Body)
			if get_key_from_appearance \{key = shadow_pak
					appearance = $cas_current_appearance}
				PushAssetContext context = <asset_context>
				UnloadPak (<shadow_pak>)
				PopAssetContext
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <diff_array_size>
	if NOT ($ps2_cas_load_canceled = 1)
		SetCASAppearance appearance = <new_appearance>
	endif
	i = 0
	begin
	part = (<diff_array> [<i>])
	if StructureContains Structure = new_appearance <part>
		LoadPartPak part = <part> heap = <heap> instrument = <new_instrument> asset_context = <asset_context> appearance = <new_appearance>
		if (<part> = CAS_Male_Base_Torso || <part> = CAS_Female_Base_Torso || <part> = CAS_Full_Body)
			if get_key_from_appearance \{key = shadow_pak
					appearance = $cas_current_appearance}
				PushAssetContext context = <asset_context>
				LoadPak <shadow_pak> heap = <heap>
				PopAssetContext
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <diff_array_size>
	change \{ps2_changing_appearance_paks = 0}
endscript
ps2_car_part_scripts_loaded = 0
ps2_car_parts_count = 0

script ps2_load_car_part_script \{heap = heap_song}
	if ($ps2_car_part_scripts_loaded = 0)
		if IsPakLoaded 'pak/car_parts/car_part_list.pak' heap = <heap>

		else
			PushAssetContext context = <heap>
			LoadPak 'pak/car_parts/car_part_list.pak' heap = <heap>
			PopAssetContext
			load_all_part_desc_paks alternate_heap = <alternate_heap>
		endif
	else

	endif
	change \{ps2_car_part_scripts_loaded = 1}
	change ps2_car_parts_count = ($ps2_car_parts_count + 1)
endscript

script ps2_force_unload_car_part_script \{heap = heap_song}
	change \{ps2_car_parts_count = 0}
	unload_all_part_desc_paks
	PushAssetContext context = <heap>
	UnloadPak \{'pak/car_parts/car_part_list.pak'}
	PopAssetContext
	change \{ps2_car_part_scripts_loaded = 0}
endscript

script ps2_unload_car_part_script \{heap = heap_song}
	change ps2_car_parts_count = ($ps2_car_parts_count - 1)
	if ($ps2_car_parts_count = 0)
		PushAssetContext context = <heap>
		UnloadPak \{'pak/car_parts/car_part_list.pak'}
		PopAssetContext
	else

	endif
	change \{ps2_car_part_scripts_loaded = 0}
endscript
ps2_cas_load_canceled = 0

script CasCancelLoading 
endscript

script unload_paks_in_heap_context 
	if GetAssetsInHeapContext context = <context>
		PushAssetContext context = <context>
		GetArraySize <asset_list>
		total_assets = <array_size>
		i = 0
		begin
		UnloadPak (<asset_list> [<i>])
		i = (<i> + 1)
		repeat <total_assets>
		PopAssetContext
	endif
endscript

script ps2_GetActualCASOptionStruct_as_struct 
	if GetActualCASOptionStruct part = <part> desc_id = <desc_id>
		RemoveParameter \{part}
		return true ps2_part_struct = {<...>}
	endif
	return \{false}
endscript

script CASWaitForLoading 
	begin
	if ($ps2_changing_appearance_paks = 0 && $ps2_loading_appearance_paks = 0)
		break
	endif
	Wait \{1
		seconds}
	repeat
endscript
