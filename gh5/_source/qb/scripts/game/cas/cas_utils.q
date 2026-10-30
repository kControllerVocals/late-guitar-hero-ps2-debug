
script check_if_part_deformable 
	if getcasappearancepart part = <part>
		getactualcasoptionstruct part = <part> desc_id = <desc_id>
		if gotparam \{deform_bones}
			return \{is_enabled = 1}
		endif
	endif
	return \{is_enabled = 0}
endscript

script is_part_capable 

	if getcasappearancepart part = <part>
		getactualcasoptionstruct part = <part> desc_id = <desc_id>
		if gotparam \{sections}
			return \{true}
		endif
	endif
	return \{false}
endscript

script check_if_part_editable 
	<retval> = 0
	if gotparam \{part}
		if getcasappearancepart part = <part>
			if (<desc_id> = none)
				<retval> = 0
			else
				<retval> = 1
			endif
		endif
	endif
	if (<retval>)
		if gotparam \{extra_script}
			<extra_script> <extra_script_params> part = <part>
			<retval> = <is_enabled>
		endif
	endif
	return is_enabled = <retval>
endscript

script check_if_parts_editable 
	<retval> = 0
	if gotparam \{parts}
		getarraysize <parts>
		<index> = 0
		begin
		if getcasappearancepart part = (<parts> [<index>])
			if (<desc_id> = none)
				<retval> = 0
			else
				<retval> = 1
				break
			endif
		endif
		<index> = (<index> + 1)
		repeat <array_size>
	endif
	return is_enabled = <retval>
endscript

script check_if_part_logoable 
	<retval> = 0
	if gotparam \{extra_script}
		<extra_script> <extra_script_params>
		if (<is_enabled> = 0)
			return is_enabled = <is_enabled>
		endif
	endif
	if gotparam \{parts}
		getarraysize <parts>
		<index> = 0
		begin
		character_part = (<parts> [<index>])
		if getcasappearancepart part = <character_part>
			getactualcasoptionstruct part = <character_part> desc_id = <desc_id>
			if gotparam \{supports_logo}
				<retval> = 1
				break
			else
				<retval> = 0
				break
			endif
		endif
		<index> = (<index> + 1)
		repeat <array_size>
	endif
	return is_enabled = <retval>
endscript

script check_if_part_front_logoable 
	if gotparam \{extra_script}
		<extra_script> <extra_script_params>
		if (<is_enabled> = 0)
			return is_enabled = <is_enabled>
		endif
	endif
	check_if_part_logoable <...>
	if (<is_enabled> = 1)
		if gotparam \{parts}
			getarraysize <parts>
			<index> = 0
			begin
			character_part = (<parts> [<index>])
			if getcasappearancepart part = <character_part>
				getactualcasoptionstruct part = <character_part> desc_id = <desc_id>
				if gotparam \{no_front_logo}
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
	if gotparam \{extra_script}
		<extra_script> <extra_script_params>
		if (<is_enabled> = 0)
			return is_enabled = <is_enabled>
		endif
	endif
	check_if_part_logoable <...>
	if (<is_enabled> = 1)
		if gotparam \{parts}
			getarraysize <parts>
			<index> = 0
			begin
			character_part = (<parts> [<index>])
			if getcasappearancepart part = <character_part>
				getactualcasoptionstruct part = <character_part> desc_id = <desc_id>
				if gotparam \{no_back_logo}
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
	getarraysize \{parts}
	if NOT (<array_size> = 1)

	endif
	if getcasappearancepart part = <logo_part>
		if (<desc_id> = none)
			return \{is_enabled = 0}
		endif
	else
		return \{is_enabled = 0}
	endif
	character_part = (<parts> [0])
	if getcasappearancepart part = <character_part>
		getactualcasoptionstruct part = <character_part> desc_id = <desc_id>
		extendcrc <logo_part> '_Adjust' out = adjustcrc
		if gotparam <adjustcrc>
			if NOT structurecontains structure = <adjustcrc> material

			elseif NOT structurecontains structure = <adjustcrc> pass

			endif
			return \{is_enabled = 1}
		endif
	endif
	return \{is_enabled = 0}
endscript

script check_if_has_belt 
	<retval> = 0
	if getcasappearancepart \{part = cas_belt}
		if NOT (<desc_id> = none)
			<retval> = 1
		endif
	endif
	return is_enabled = <retval>
endscript

script check_if_part_colorable 
	<retval> = 0
	if gotparam \{extra_script}
		<extra_script> <extra_script_params>
		if (<is_enabled> = 0)
			return is_enabled = <is_enabled>
		endif
	endif
	if gotparam \{parts}
		getarraysize <parts>
		<index> = 0
		begin
		character_part = (<parts> [<index>])
		if getcasappearancepart part = <character_part>
			if (<desc_id> = none)
				<retval> = 0
				break
			else
				if getactualcasoptionstruct part = <character_part> desc_id = <desc_id> dont_assert
					if gotparam \{color_all_materials}
						<retval> = 1
						break
					else
						if gotparam \{materials}
							getarraysize <materials>
							if (<array_size> > 0)
								<retval> = 1
							else
								<retval> = 0
							endif
						else
							<retval> = 0
						endif
						break
					endif
				endif
			endif
		endif
		<index> = (<index> + 1)
		repeat <array_size>
	endif
	return is_enabled = <retval>
endscript

script check_if_secondary_colorable 
	check_if_part_colorable <...>
	if (<is_enabled> = 0)
		return is_enabled = <is_enabled>
	endif
	if gotparam \{parts}
		getarraysize <parts>
		<index> = 0
		begin
		character_part = (<parts> [<index>])
		if getcasappearancepart part = <character_part>
			getactualcasoptionstruct part = <character_part> desc_id = <desc_id>
			if gotparam \{color_all_materials}
				<retval> = 1
				break
			endif
			if gotparam \{materials}
				getarraysize <materials>
				if (<array_size> > 1)
					<retval> = 1
				else
					<retval> = 0
				endif
			else
				<retval> = 0
			endif
			break
		endif
		<index> = (<index> + 1)
		repeat <array_size>
	endif
	return is_enabled = <retval>
endscript

script cas_item_is_visible 
	if istrue \{$worst_case_cas_debug}
		return \{true}
	endif
	if structurecontains structure = ($<part> [<part_index>]) hidden
		return \{false}
	endif
	return \{true}
endscript

script cas_item_rebuild 
	if NOT getcasappearancepart part = <part>

	endif
	if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>

	endif
	if NOT gotparam \{no_rebuild}
		return \{true}
	else
		return \{false}
	endif
endscript

script cas_item_matches_genre 
endscript

script get_part_current_desc_id 
	if getcasappearancepart part = <part>
		if gotparam \{desc_id}
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
	getarraysize \{$master_editable_list}
	i = 0
	begin
	part_name = ((($master_editable_list) [<i>]).part)
	if structurecontains structure = <appearance> <part_name>
		if structurecontains structure = (<appearance>.<part_name>) desc_id
			desc_id = ((<appearance>.<part_name>).desc_id)
			0x508a0517 part_type = <part_name> desc_id = <desc_id>
			0xbff21a2f = 0
			if filterpartbyinstrument part = <part_name> instrument = none
				0xbff21a2f = 1
			endif
			if NOT (<index> = -1 && <0xbff21a2f>)
				if getactualcasoptionstruct part = <part_name> desc_id = <desc_id>
					if gotparam <key>
						ret_struct = {}
						updatestructelement struct = <ret_struct> element = <key> value = ((<...>).<key>)
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
	if structurecontains structure = <appearance> <part>
		if structurecontains structure = (<appearance>.<part>) desc_id
			0x5a95f6d5 = 0
			if NOT load_part_desc_pak part_type = <part>
				0x5a95f6d5 = 1
			endif
			if getactualcasoptionstruct part = <part> desc_id = ((<appearance>.<part>).desc_id)
				if (<0x5a95f6d5> = 1)
					unload_part_desc_pak part_type = <part>
				endif
				if gotparam <key>
					ret_struct = {}
					updatestructelement struct = <ret_struct> element = <key> value = ((<...>).<key>)
					return true {<newstruct>}
				endif
			endif
			if (<0x5a95f6d5> = 1)
				unload_part_desc_pak part_type = <part>
			endif
		endif
	endif
	return \{false}
endscript

script get_body_key_from_appearance 
	if structurecontains structure = <appearance> cas_body
		getactualcasoptionstruct part = cas_body desc_id = (<appearance>.cas_body.desc_id)
		if gotparam <key>
			ret_struct = {}
			updatestructelement struct = <ret_struct> element = <key> value = ((<...>).<key>)
			return true {<newstruct>}
		endif
	elseif structurecontains structure = <appearance> cas_full_body
		getactualcasoptionstruct part = cas_full_body desc_id = (<appearance>.cas_full_body.desc_id)
		if gotparam <key>
			ret_struct = {}
			updatestructelement struct = <ret_struct> element = <key> value = ((<...>).<key>)
			return true {<newstruct>}
		endif
	else

	endif
	return \{false}
endscript

script findfrontenddescfromchecksum 
	part_struct = ($<part>)
	getarraysize <part_struct>
	<i> = 0
	begin
	if ((<part_struct> [<i>].desc_id) = <desc_id>)
		if structurecontains structure = (<part_struct> [<i>]) frontend_desc
			<return_val> = (<part_struct> [<i>].frontend_desc)
		endif
	endif
	<i> = (<i> + 1)
	repeat <array_size>

endscript

script check_need_to_block_back 
	switch <part>
		case cas_male_intro_anim
		case cas_male_win_anim
		case cas_male_lose_anim
		case cas_female_intro_anim
		case cas_female_win_anim
		case cas_female_lose_anim
		case cas_guitar_highway
		case cas_bass_highway
		case cas_drums_highway
		return \{true}
	endswitch
	return \{false}
endscript

script cas_add_item_to_appearance 

	cas_handle_disqualifications part = <part> desc_id = <desc_id>
	if gotparam \{new_desc_id}
		desc_id = <new_desc_id>

	endif
	editcasappearance target = setpart targetparams = {part = <part> desc_id = <desc_id>}
	ps2_getactualcasoptionstruct_as_struct part = <part> desc_id = <desc_id>
	if structurecontains structure = (<ps2_part_struct>) finishable
		editcasappearance target = setpart targetparams = {part = (<ps2_part_struct>.finishable) desc_id = none}
	endif
	if structurecontains structure = (<ps2_part_struct>) detailable
		editcasappearance target = setpart targetparams = {part = (<ps2_part_struct>.detailable) desc_id = none}
	endif
	if structurecontains structure = (<ps2_part_struct>) logoable
		editcasappearance target = setpart targetparams = {part = (<ps2_part_struct>.logoable) desc_id = none}
	endif
	if structurecontains structure = (<ps2_part_struct>) fadeable
		editcasappearance target = setpart targetparams = {part = (<ps2_part_struct>.fadeable) desc_id = none}
	endif
	if NOT gotparam \{no_rebuild}
		if gotparam \{incremental}
			spawnscriptnow \{trigger_cas_rebuild_loop}
		else
			spawnscriptnow \{trigger_cas_rebuild_loop}
		endif
	endif
	if istrue \{$cas_debug}
		dumpheaps
	endif
endscript

script 0x59249cc9 
	if screenelementexists \{id = sponsor_logo}
		setscreenelementprops \{id = sponsor_logo
			alpha = 0.4
			texture = 0xdd6b320b}
	else
		createscreenelement \{blend = add
			type = spriteelement
			parent = generic_menu
			id = sponsor_logo
			texture = 0xdd6b320b
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

script 0xa4b975b7 

	if (<sponsor_id> = 0xc0671aff)
		return \{0x37f7fccf = white}
	endif
	i = 0
	getarraysize \{$cas_sponsors}
	begin
	if ($cas_sponsors [<i>].id = <sponsor_id>)
		return 0x37f7fccf = ($cas_sponsors [<i>].texture)
	endif
	i = (<i> + 1)
	repeat (<array_size>)
	0x93d8d5cf qs(0xb042eb53) s = <sponsor_id>
	return \{0x37f7fccf = white}
endscript

script 0x4b5f92af 
	if NOT gotparam \{0x37f7fccf}
		if NOT gotparam \{sponsor_id}
			0x93d8d5cf \{qs(0x48adbe09)}
		else
			0xa4b975b7 sponsor_id = <sponsor_id>
		endif
	endif
	if (<0x37f7fccf> = white)
		alpha = 0.0
	else
		alpha = 1.0
	endif
	if screenelementexists \{id = sponsor_logo}
		setscreenelementprops id = sponsor_logo {
			alpha = <alpha>
			texture = <0x37f7fccf>
		}
	else
		createscreenelement {
			blend = add
			type = spriteelement
			parent = generic_menu
			id = sponsor_logo
			pos = (130.0, 460.0)
			dims = (360.0, 180.0)
			just = [left top]
			rgba = [255 255 255 255]
			z_priority = 4
			alpha = <alpha>
			texture = <0x37f7fccf>
			rot_angle = 0.0
		}
	endif
endscript

script cas_find_tex_swap_parts \{tex_swap_parts = [
		]}

	getarraysize <part_list>
	i = 0
	begin
	if structurecontains structure = (<part_list> [<i>]) part
		part_name = (<part_list> [<i>].part)
		if structurecontains structure = <appearance> <part_name>
			part_desc = ((<appearance>).<part_name>)
			if structurecontains structure = <part_desc> desc_id
				if cas_has_tex_replace part = <part_name> desc_id = ((<part_desc>).desc_id)
					if NOT arraycontains array = <tex_swap_parts> contains = <part_name>
						ve_convert_checksum_to_array checksum = <part_name>
						tex_swap_parts = (<tex_swap_parts> + <checksum_array>)
					endif
				endif
			endif
		endif
		if structurecontains structure = (<part_list> [<i>]) desc_id
			if cas_has_tex_replace part = <part_name> desc_id = ((<part_list> [<i>]).desc_id)
				if NOT arraycontains array = <tex_swap_parts> contains = <part_name>
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
	getactualcasoptionstruct part = <part> desc_id = <desc_id>
	if ((gotparam replace) || (gotparam replace1) || (gotparam replace2) || (gotparam replace3))
		return \{true}
	endif
	return \{false}
endscript

script cas_desc_id_is_excluded \{part_name = none
		part_desc_id = none}
	if checksumequals a = <part_desc_id> b = none
		return \{false}
	endif
	if cas_part_is_excluded part_name = <part_name>
		return true conflict_part = <conflict_part>
	endif
	getarraysize ($master_editable_list)
	i = 0
	begin
	list_part_name = ((($master_editable_list) [<i>]).part)
	if NOT checksumequals a = <list_part_name> b = <part_name>
		if cas_desc_id_is_excluded_part list_part_name = <list_part_name> change_part_name = <part_name> change_part_desc_id = <part_desc_id>
			return true conflict_part = <conflict_part>
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script cas_desc_id_is_excluded_part 
	if getcasappearancepart part = <list_part_name>
		if getactualcasoptionstruct part = <list_part_name> desc_id = <desc_id>
			if gotparam \{exclusions}
				conflict_part = {part = <list_part_name> desc_id = <desc_id>}
				if structurecontains structure = <exclusions> <change_part_name>
					exclusion = (<exclusions>.<change_part_name>)
					if NOT structurecontains structure = <exclusion> reverse
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
	getarraysize ($master_editable_list)
	i = 0
	begin
	list_part_name = ((($master_editable_list) [<i>]).part)
	if NOT checksumequals a = <list_part_name> b = <part_name>
		if cas_part_is_excluded_part list_part_name = <list_part_name> change_part_name = <part_name> change_part_desc_id = <part_desc_id>
			return true conflict_part = <conflict_part>
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	return \{false}
endscript

script cas_part_is_excluded_part 
	if getcasappearancepart part = <list_part_name>
		if getactualcasoptionstruct part = <list_part_name> desc_id = <desc_id>
			conflict_part = {part = <list_part_name> desc_id = <desc_id>}
			if gotparam \{exclusions}
				if structurecontains structure = <exclusions> <change_part_name>
					exclusion = (<exclusions>.<change_part_name>)
					if NOT structurecontains structure = <exclusion> reverse
						if NOT structurecontains structure = <exclusion> change_from
							return true conflict_part = <conflict_part>
						endif
					endif
				endif
			endif
			if gotparam \{hide_parts}
				i = 0
				getarraysize <hide_parts>
				if (<array_size> > 0)
					begin
					if checksumequals a = (<hide_parts> [<i>]) b = <change_part_name>
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
	if checksumequals a = <part_desc_id> b = none
		return \{false}
	endif
	if checksumequals a = <part_name> b = none
		return \{false}
	endif
	getactualcasoptionstruct part = <part_name> desc_id = <part_desc_id>
	change_parts = []
	conflict = false
	if gotparam \{inclusion}
		getarraysize <inclusion>
		inclusion_size = (<array_size>)
		0x95083ac8 = <inclusion>
		if (<inclusion_size> > 0)
			i = 0
			begin
			if getcasappearancepart part = (<0x95083ac8> [<i>].part)
				valid = (<0x95083ac8> [<i>].valid)
				if NOT ((checksumequals a = <desc_id> b = none) || (arraycontains array = <valid> contains = <desc_id>))
					getarraysize <valid>
					j = 0
					begin
					if is_part_unlocked_purchased part = (<0x95083ac8> [<i>].part) desc_id = ((<0x95083ac8> [<i>].valid) [<j>]) savegame = ($cas_current_savegame)
						addarrayelement array = <change_parts> element = {part = (<0x95083ac8> [<i>].part) desc_id = ((<0x95083ac8> [<i>].valid) [<j>])}
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
	getarraysize \{change_parts}
	if (<array_size> > 0)
		return change_parts = <change_parts>
	else
		return
	endif
endscript

script cas_in_inclusion_list 
	if gotparam \{inclusion}
		getarraysize \{inclusion}
		matched_part = 0
		if (<array_size> > 0)
			i = 0
			begin
			inc_part = (<inclusion> [<i>].part)
			if (checksumequals a = <inc_part> b = <part_name>)
				matched_part = 1
				if arraycontains array = (<inclusion> [<i>].valid) contains = <part_desc_id>

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

	if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>

	endif
	if gotparam \{locked}
		get_current_band_part_flags part = <part> desc_id = <desc_id> savegame = <savegame>
		if gotparam \{part_flags}
			if structurecontains structure = <part_flags> unlocked
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

	if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>

	endif
	if gotparam \{price}
		get_current_band_part_flags part = <part> desc_id = <desc_id> savegame = <savegame>
		if gotparam \{part_flags}
			if structurecontains structure = <part_flags> purchased
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

	if structurecontains structure = <preset> price
		get_current_band_part_flags part = <part> desc_id = <desc_id> savegame = <savegame>
		if gotparam \{part_flags}
			if structurecontains structure = <part_flags> purchased
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

script incrementpartpakunloading 

	change ps2_part_pak_unloading = ($ps2_part_pak_unloading + 1)
endscript

script decrementpartpakunloading 

	change ps2_part_pak_unloading = ($ps2_part_pak_unloading - 1)
endscript

script unloadappearancepaks \{asset_context = 0
		async = 0}

	if gotparam \{appearance}
		if NOT ($ps2_cas_load_canceled = 1)
			setcasappearance appearance = <appearance>
		endif
	endif
	if (<async> = 1)
		change \{ps2_part_pak_unloading = 0}
		foreachincas do = unloadpartpak params = {asset_context = <asset_context> <...>}
		begin
		if ispartpakunloaddone
			break
		endif
		wait \{1
			gameframe}
		repeat
		if get_key_from_appearance \{key = shadow_pak
				appearance = $cas_current_appearance}
			incrementpartpakunloading
			spawnscriptlater unloadappearancepak_async params = {asset_context = <asset_context> pak = <shadow_pak>}
			begin
			if ispartpakunloaddone
				break
			endif
			wait \{1
				gameframe}
			repeat
		endif
	else
		foreachincas do = unloadpartpak params = {asset_context = <asset_context> <...>}
		if get_key_from_appearance \{key = shadow_pak
				appearance = $cas_current_appearance}
			pushassetcontext context = <asset_context>
			unloadpak (<shadow_pak>) sameheaps
			if NOT gotparam \{no_wait}
				waitunloadpak <shadow_pak> block
			endif
			popassetcontext
		endif
	endif
endscript
ps2_part_pak_loading = 0

script incrementpartpakloading 

	change ps2_part_pak_loading = ($ps2_part_pak_loading + 1)
endscript

script decrementpartpakloading 

	change ps2_part_pak_loading = ($ps2_part_pak_loading - 1)
endscript
ps2_loading_appearance_paks = 0

script loadappearancepaks \{reload = 0
		async = 0}

	change \{ps2_loading_appearance_paks = 1}

	if (<reload> = 1)
		unloadappearancepaks {asset_context = <asset_context> <...>}
	endif
	if gotparam \{appearance}
		if NOT ($ps2_cas_load_canceled = 1)
			setcasappearance appearance = <appearance>
		endif
	endif
	if (<async> = 1)
		change \{ps2_part_pak_loading = 0}
		getarraysize ($master_editable_list)
		i = 0
		begin
		part_struct = ($master_editable_list [(<i>)])
		part_slot = (<part_struct>.part)
		if loadpartpak {part = <part_slot> asset_context = <asset_context> <...>}
			begin
			if ispartpakloaddone
				break
			endif
			wait \{1
				gameframes}
			repeat
		endif
		i = (<i> + 1)
		repeat <array_size>
		if NOT ($ps2_cas_load_canceled = 1)
			if get_key_from_appearance \{key = shadow_pak
					appearance = $cas_current_appearance}
				change \{ps2_part_pak_loading = 0}
				pushassetcontext context = <asset_context>
				incrementpartpakloading
				loadpak <shadow_pak> heap = <heap> load_callback = loadpartpak_done callback_data = none
				popassetcontext
				begin
				if ispartpakloaddone
					break
				endif
				wait \{1
					gameframes}
				repeat
			endif
		endif
	else
		foreachincas do = loadpartpak params = {asset_context = <asset_context> <...>}
		if NOT ($ps2_cas_load_canceled = 1)
			if get_key_from_appearance \{key = shadow_pak
					appearance = $cas_current_appearance}
				pushassetcontext context = <asset_context>
				loadpak <shadow_pak> heap = <heap>
				popassetcontext
			endif
		endif
	endif
	change \{ps2_loading_appearance_paks = 0}
endscript

script loadpartpak \{instrument = none
		asset_context = 0
		async = 0}
	if ($ps2_cas_load_canceled = 1)
		return
	endif
	setcasappearance appearance = <appearance>
	if getcasappearancepart part = <part>
		if filterpartbyinstrument part = <part> instrument = <instrument>
			return \{false}
		endif
		if (<part> = cas_male_hair || <part> = cas_female_hair)
			get_hat_hair_choice appearance = <appearance>
			if (<hat_hair_choice> = hat_hair)
				return \{false}
			endif
		endif
		0xc4dfc41c part_type = <part> desc_id = <desc_id>
		if gotparam \{0x9c8a3b7a}
			if 0x4b6e50ba <...>
				return \{true}
			endif
		elseif getactualcasoptionstruct part = <part> desc_id = <desc_id>
			if gotparam \{add_to_nodes}
				pushassetcontext context = <asset_context>
				0xc7e33433 = <add_to_nodes>
				getarraysize <add_to_nodes>
				i = 0
				begin
				node_child_struct = (<0xc7e33433> [<i>])
				if getactualcasoptionstruct part = (<node_child_struct>.part_type) desc_id = (<node_child_struct>.desc_id)
					if (<async> = 1)
						incrementpartpakloading
						loadpak <pak> heap = <heap> load_callback = loadpartpak_done callback_data = none
					else
						loadpak <pak> heap = <heap>
					endif
				endif
				i = (<i> + 1)
				repeat <array_size>
				popassetcontext
				return \{true}
			elseif gotparam \{pak}
				pushassetcontext context = <asset_context>
				if (<async> = 1)
					incrementpartpakloading
					loadpak <pak> heap = <heap> load_callback = loadpartpak_done callback_data = none
				else
					loadpak <pak> heap = <heap>
				endif
				popassetcontext
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script loadpartpak_done 

	if ($ps2_part_pak_loading > 0)
		decrementpartpakloading
	endif
endscript

script ispartpakloaddone 
	if ($ps2_part_pak_loading > 0)
		return \{false}
	endif
	return \{true}
endscript

script unloadpartpak \{asset_context = 0
		async = 0}
	if NOT ($ps2_cas_load_canceled = 1)
		setcasappearance appearance = <appearance>
	endif
	if getcasappearancepart part = <part>
		if filterpartbyinstrument part = <part> instrument = <instrument>
			return
		endif
		0xc4dfc41c part_type = <part> desc_id = <desc_id>
		if gotparam \{0x9c8a3b7a}
			if 0xfcdb12cb <...>
				return \{true}
			endif
		elseif getactualcasoptionstruct part = <part> desc_id = <desc_id>
			if gotparam \{add_to_nodes}
				0xc7e33433 = <add_to_nodes>
				getarraysize <add_to_nodes>
				i = 0
				begin
				node_child_struct = (<0xc7e33433> [<i>])
				if getactualcasoptionstruct part = (<node_child_struct>.part_type) desc_id = (<node_child_struct>.desc_id)
					if (<async> = 1)
						incrementpartpakunloading
						spawnscriptlater unloadappearancepak_async params = {asset_context = <asset_context> pak = <pak>}
					else
						pushassetcontext context = <asset_context>
						unloadpak <pak> sameheaps
						if NOT gotparam \{no_wait}
							waitunloadpak <pak> block
						endif
						popassetcontext
					endif
				endif
				i = (<i> + 1)
				repeat <array_size>
				return \{true}
			elseif gotparam \{pak}
				if (<async> = 1)
					incrementpartpakunloading
					spawnscriptlater unloadappearancepak_async params = {asset_context = <asset_context> pak = <pak>}
				else
					pushassetcontext context = <asset_context>
					unloadpak <pak> sameheaps
					if NOT gotparam \{no_wait}
						waitunloadpak <pak> block
					endif
					popassetcontext
				endif
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script unloadappearancepak_async 
	pushassetcontext context = <context>
	unloadpak <pak> sameheaps
	begin
	if waitunloadpak <pak> noblock
		break
	endif
	wait \{1
		gameframe}
	repeat
	decrementpartpakunloading
	popassetcontext
endscript

script ispartpakunloaddone 
	if ($ps2_part_pak_unloading = 0)
		return \{true}
	endif
	return \{false}
endscript
ps2_changing_appearance_paks = 0

script changeappearancepaks \{current_instrument = none
		new_instrument = none}
	change \{ps2_changing_appearance_paks = 1}
	if NOT gotparam \{diff_array}
		if NOT gotparam \{diff_array_size}
			diffappearances <...>
		endif
	endif
	if (<diff_array_size> = 0)
		change \{ps2_changing_appearance_paks = 0}
		return
	endif
	if NOT ($ps2_cas_load_canceled = 1)
		setcasappearance appearance = <current_appearance>
	endif
	i = 0
	begin
	part = (<diff_array> [<i>])
	if structurecontains structure = current_appearance <part>
		unloadpartpak part = <part> instrument = <current_instrument> no_wait asset_context = <asset_context> appearance = <current_appearance>
		if (<part> = cas_male_base_torso || <part> = cas_female_base_torso || <part> = cas_full_body)
			if get_key_from_appearance \{key = shadow_pak
					appearance = $cas_current_appearance}
				pushassetcontext context = <asset_context>
				unloadpak (<shadow_pak>)
				popassetcontext
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <diff_array_size>
	if NOT ($ps2_cas_load_canceled = 1)
		setcasappearance appearance = <new_appearance>
	endif
	i = 0
	begin
	part = (<diff_array> [<i>])
	if structurecontains structure = new_appearance <part>
		loadpartpak part = <part> heap = <heap> instrument = <new_instrument> asset_context = <asset_context> appearance = <new_appearance>
		if (<part> = cas_male_base_torso || <part> = cas_female_base_torso || <part> = cas_full_body)
			if get_key_from_appearance \{key = shadow_pak
					appearance = $cas_current_appearance}
				pushassetcontext context = <asset_context>
				loadpak <shadow_pak> heap = <heap>
				popassetcontext
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <diff_array_size>
	change \{ps2_changing_appearance_paks = 0}
endscript
ps2_car_part_scripts_loaded = 0
0x56978d8a = 0

script ps2_load_car_part_script \{heap = heap_song}
	if ($ps2_car_part_scripts_loaded = 0)
		if ispakloaded 'pak/car_parts/car_part_list.pak' heap = <heap>

		else
			pushassetcontext context = <heap>
			loadpak 'pak/car_parts/car_part_list.pak' heap = <heap>
			popassetcontext
			0xd4905dfc 0xb17c6bb3 = <0xb17c6bb3>
		endif
	else

	endif
	change \{ps2_car_part_scripts_loaded = 1}
	change 0x56978d8a = ($0x56978d8a + 1)
endscript

script 0xce69e479 \{heap = heap_song}
	change \{0x56978d8a = 0}
	0xf8e735a8
	pushassetcontext context = <heap>
	unloadpak \{'pak/car_parts/car_part_list.pak'}
	popassetcontext
	change \{ps2_car_part_scripts_loaded = 0}
endscript

script ps2_unload_car_part_script \{heap = heap_song}
	change 0x56978d8a = ($0x56978d8a - 1)
	if ($0x56978d8a = 0)
		pushassetcontext context = <heap>
		unloadpak \{'pak/car_parts/car_part_list.pak'}
		popassetcontext
	else

	endif
	change \{ps2_car_part_scripts_loaded = 0}
endscript
ps2_cas_load_canceled = 0

script cascancelloading 
endscript

script 0x6aa93fce 
	if 0xe3c6a8d1 context = <context>
		pushassetcontext context = <context>
		getarraysize <asset_list>
		0x4e3aa167 = <array_size>
		i = 0
		begin
		unloadpak (<asset_list> [<i>])
		i = (<i> + 1)
		repeat <0x4e3aa167>
		popassetcontext
	endif
endscript

script ps2_getactualcasoptionstruct_as_struct 
	if getactualcasoptionstruct part = <part> desc_id = <desc_id>
		removeparameter \{part}
		return true ps2_part_struct = {<...>}
	endif
	return \{false}
endscript

script caswaitforloading 
	begin
	if ($ps2_changing_appearance_paks = 0 && $ps2_loading_appearance_paks = 0)
		break
	endif
	wait \{1
		seconds}
	repeat
endscript
