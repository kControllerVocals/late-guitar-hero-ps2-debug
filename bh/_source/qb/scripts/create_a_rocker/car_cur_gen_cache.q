0x1f144dea = [
]
0xd9ed6f85 = 4
0xa32e828a = {
}
0x44007ccb = {
	0x288ddb10 = [
		cas_torso_art
		cas_left_arm_art
		cas_right_arm_art
		cas_eye_makeup
		cas_lip_makeup
		cas_eyes
		cas_female_hair
		cas_female_hat_hair
		cas_male_facial_hair
		cas_male_hair
		cas_male_hat_hair
	]
	0x658a2d2c = [
		cas_female_torso
		cas_female_legs
		cas_female_shoes
		cas_female_acc_left
		cas_female_acc_right
		cas_female_acc_face
		cas_female_acc_ears
		cas_female_hair
		cas_female_hat_hair
		cas_female_hat
		cas_male_torso
		cas_male_legs
		cas_male_shoes
		cas_male_acc_left
		cas_male_acc_right
		cas_male_acc_face
		cas_male_acc_ears
		cas_male_hair
		cas_male_hat_hair
		cas_male_hat
	]
}

script 0xcd94e1bc 
	change \{0x1f144dea = [
		]}
endscript

script 0xc4dfc41c 
	0x508a0517 <...>
	if NOT (<index> = -1)
		return 0x9c8a3b7a = ($0x1f144dea [<index>])
	endif
endscript

script 0x44a395ce 
	0x508a0517 <...>
	if (<index> = -1)
		removeparameter \{index}
		if gotparam \{0x1fe128af}
			removeparameter \{0x1fe128af}
			0x1ff90073 = {<...> ref_count = 0}
		else
			0x1ff90073 = {<...> ref_count = 1}
		endif
		addarrayelement array = ($0x1f144dea) element = <0x1ff90073>
		change 0x1f144dea = <array>
	else
		0x1ff90073 = ($0x1f144dea [<index>])
		if gotparam \{0x1fe128af}
			0x5eb1d8b0 = (<0x1ff90073>.ref_count)
		else
			0x5eb1d8b0 = (<0x1ff90073>.ref_count + 1)
		endif
		0x1ff90073 = {<0x1ff90073> ref_count = <0x5eb1d8b0>}
		setarrayelement arrayname = 0x1f144dea index = <index> newvalue = <0x1ff90073> globalarray resolveglobals = 0
	endif
endscript

script 0x51979d5e 
	0x508a0517 <...>
	if (<index> = -1)
		switch (<part_type>)
			case cas_body
			case cas_physique
			case cas_full_instrument
			return
			default
			0x8dbdaee4 \{qs(0x5dce1217)}
		endswitch
	else
		0x1ff90073 = ($0x1f144dea [<index>])
		0x5eb1d8b0 = ((<0x1ff90073>.ref_count) - 1)
		if (<0x5eb1d8b0> < 0)
			0x5eb1d8b0 = 0
		endif
		0x1ff90073 = {<0x1ff90073> ref_count = <0x5eb1d8b0>}
		setarrayelement arrayname = 0x1f144dea index = <index> newvalue = <0x1ff90073> globalarray resolveglobals = 0
	endif
	if gotparam \{0x4b1eab50}
		0xe30b16ca
	endif
endscript

script 0xbaf89f2d 
	resolvebodyspecificpartinappearance appearance = <appearance> part = <part_type>
	part_type = <part>
	if NOT gotparam \{desc_id}
		if structurecontains structure = <appearance> <part_type>
			desc_id = (<appearance>.<part_type>.desc_id)
		else
			0x93d8d5cf \{qs(0x9018370d)}
			return
		endif
	endif
	if getactualcasoptionstruct part = <part_type> desc_id = <desc_id>
		removeparameter \{appearance}
		removeparameter \{part}
		0x44a395ce <...>
		if NOT gotparam \{0x88fd222e}
			if gotparam \{add_to_nodes}
				0x219d4ef3 = <desc_id>
				0xc7e33433 = <add_to_nodes>
				getarraysize <add_to_nodes>
				i = 0
				begin
				node_child_struct = (<0xc7e33433> [<i>])
				if gotparam \{0x1fe128af}
					0xbaf89f2d part_type = (<node_child_struct>.part_type) desc_id = (<node_child_struct>.desc_id) 0x1fe128af 0x88fd222e
				else
					0xbaf89f2d part_type = (<node_child_struct>.part_type) desc_id = (<node_child_struct>.desc_id) 0x88fd222e
				endif
				i = (<i> + 1)
				repeat <array_size>
			endif
		endif
		if gotparam \{hat_hair}
			switch (<part_type>)
				case cas_male_hair
				case cas_male_hat
				part = cas_male_hat_hair
				case cas_female_hair
				case cas_female_hat
				part = cas_female_hat_hair
				default
				0x93d8d5cf \{qs(0xea6f7c2d)}
			endswitch
			if NOT (<hat_hair> = original_hair)
				0xcc05dce0 = 0
				if NOT load_part_desc_pak part_type = <part>
					0xcc05dce0 = 1
				endif
				if gotparam \{0x1fe128af}
					0xbaf89f2d part_type = <part> desc_id = <hat_hair> 0x1fe128af
				else
					0xbaf89f2d part_type = <part> desc_id = <hat_hair>
				endif
				if (<0xcc05dce0> = 1)
					unload_part_desc_pak part_type = <part>
				endif
			endif
		endif
	else
		0x93d8d5cf qs(0x0e84b604) a = <desc_id> b = <part_type>
	endif
endscript

script 0x4f3fed72 
	resolvebodyspecificpartinappearance appearance = <appearance> part = <part_type>
	if structurecontains structure = <appearance> <part>
		desc_id = (<appearance>.<part>.desc_id)
		0x51979d5e part_type = <part> desc_id = <desc_id>
	endif
endscript

script 0xfb4ec1d6 
	if 0xccaf9669 <...>
		begin
		if NOT 0x7f5001ce appearance = <appearance>
			break
		endif
		wait \{1
			gameframe}
		repeat
	endif
	0xe71b17e8
endscript

script 0x4b6e50ba \{async = 0}
	if NOT gotparam \{0x9c8a3b7a}
		0xc4dfc41c part = <part> desc_id = <desc_id>
	endif
	if structurecontains structure = <0x9c8a3b7a> add_to_nodes
		pushassetcontext context = <asset_context>
		getarraysize (<0x9c8a3b7a>.add_to_nodes)
		i = 0
		begin
		node_child_struct = (<0x9c8a3b7a>.add_to_nodes [<i>])
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
	elseif structurecontains structure = <0x9c8a3b7a> pak
		pak = (<0x9c8a3b7a>.pak)
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
	return \{false}
endscript

script 0xfcdb12cb 
	if NOT gotparam \{0x9c8a3b7a}
		0xc4dfc41c part = <part> desc_id = <desc_id>
	endif
	if structurecontains structure = <0x9c8a3b7a> 0x74303e14
		getarraysize (<0x9c8a3b7a>.0x74303e14)
		i = 0
		begin
		0xc04dade1 = (<0x9c8a3b7a>.0x74303e14 [<i>])
		if (<async> = 1)
			incrementpartpakunloading
			spawnscriptlater unloadappearancepak_async params = {asset_context = <asset_context> pak = <0xc04dade1>}
		else
			pushassetcontext context = <asset_context>
			unloadpak <0xc04dade1>
			if NOT gotparam \{no_wait}
				waitunloadpak <0xc04dade1> block
			endif
			popassetcontext
		endif
		i = (<i> + 1)
		repeat <array_size>
		return \{true}
	elseif structurecontains structure = <0x9c8a3b7a> pak
		pak = (<0x9c8a3b7a>.pak)
		if (<async> = 1)
			incrementpartpakunloading
			spawnscriptlater unloadappearancepak_async params = {asset_context = <asset_context> pak = <pak>}
		else
			pushassetcontext context = <asset_context>
			unloadpak <pak>
			if NOT gotparam \{no_wait}
				waitunloadpak <pak> block
			endif
			popassetcontext
		endif
		return \{true}
	endif
endscript

script 0x39cf47f4 
	0x8dbdaee4 \{qs(0xc080aee1)}
	0xc245fbf7 = []
	getarraysize ($0x1f144dea)
	if (<array_size> < 1)
		0x8dbdaee4 \{qs(0x3de76e3b)}
		return
	endif
	i = 0
	begin
	0x1ff90073 = ($0x1f144dea [<i>])
	0x6eeda48a = 1
	if gotparam \{part_type}
		if NOT (<0x1ff90073>.part_type = <part_type>)
			0x6eeda48a = 0
		endif
	endif
	if gotparam \{desc_id}
		if NOT (<0x1ff90073>.desc_id = <desc_id>)
			0x6eeda48a = 0
		endif
	endif
	if (<0x6eeda48a> = 1)
		addarrayelement array = <0xc245fbf7> element = <0x1ff90073>
		0xc245fbf7 = <array>
	endif
	i = (<i> + 1)
	repeat <array_size>
	0xe6b61ea6 <0xc245fbf7>
endscript

script load_part_desc_pak \{heap = heap_song}
	if NOT structurecontains structure = ($car_part_desc_paks) <part_type>
		0x8dbdaee4 qs(0x7f310966) a = <part_type>
		return \{true}
	endif
	temp_struct = ($car_part_desc_paks.<part_type>)
	if NOT structurecontains structure = <temp_struct> 0xe4313507
		temp_struct = {<temp_struct> 0xe4313507 = 0}
	endif
	if NOT (<temp_struct>.0xe4313507 = 1)
		pushassetcontext context = <heap>
		loadpak (<temp_struct>.pak) heap = <heap>
		popassetcontext
		temp_struct = {<temp_struct> 0xe4313507 = 1 heap = <heap>}
		updatestructelement struct = $car_part_desc_paks element = <part_type> value = <temp_struct>
		change car_part_desc_paks = <newstruct>
		return \{false}
	endif
	return \{true}
endscript

script unload_part_desc_pak 
	if NOT structurecontains structure = ($car_part_desc_paks) <part_type>
		switch (<part_type>)
			case cas_body
			case cas_physique
			case cas_full_instrument
			return
			default
			0x93d8d5cf \{qs(0xae803f64)}
		endswitch
	endif
	temp_struct = ($car_part_desc_paks.<part_type>)
	if NOT structurecontains structure = <temp_struct> 0xe4313507
		return
	endif
	if (<temp_struct>.0xe4313507 = 1)
		pushassetcontext context = (<temp_struct>.heap)
		unloadpak (<temp_struct>.pak)
		popassetcontext
		temp_struct = {<temp_struct> 0xe4313507 = 0}
		updatestructelement struct = $car_part_desc_paks element = <part_type> value = <temp_struct>
		change car_part_desc_paks = <newstruct>
	endif
endscript

script 0xd4905dfc 
	0x9f6a53bc = [heap_song bottomupheap]
	if gotparam \{0xb17c6bb3}
		if (<0xb17c6bb3> = 1)
			0x9f6a53bc = [heap_song bottomupheap]
		endif
	endif
	getarraysize (<0x9f6a53bc>)
	0x90627e26 = (<array_size> - 1)
	0x5caa84a4 = 0
	getarraysize ($master_editable_list)
	i = 0
	begin
	0x61e827a0 = ($master_editable_list [<i>])
	part_type = (<0x61e827a0>.part)
	heap = (<0x9f6a53bc> [<0x5caa84a4>])
	if structurecontains structure = ($car_part_desc_paks) <part_type>
		if 0xe86416fc file = ($car_part_desc_paks.<part_type>.pak) context = <heap>
			load_part_desc_pak part_type = <part_type> heap = <heap>
		else
			0x5caa84a4 = (<0x5caa84a4> + 1)
			if (<0x5caa84a4> > <0x90627e26>)
				0x93d8d5cf \{qs(0xec94660e)}
			endif
			i = (<i> - 1)
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script 0xf8e735a8 
	if NOT globalexists \{name = car_part_desc_paks}
		return
	endif
	getarraysize ($master_editable_list)
	i = 0
	begin
	0x61e827a0 = ($master_editable_list [<i>])
	part_type = (<0x61e827a0>.part)
	if structurecontains structure = ($car_part_desc_paks) <part_type>
		unload_part_desc_pak part_type = <part_type>
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script 0x6af9e5dc 
	0x8dbdaee4 \{qs(0x84d2d657)}
	0x31e13444 = 0
	getarraysize ($master_editable_list)
	i = 0
	begin
	0x61e827a0 = ($master_editable_list [<i>])
	part_type = (<0x61e827a0>.part)
	if structurecontains structure = ($car_part_desc_paks) <part_type>
		temp_struct = ($car_part_desc_paks.<part_type>)
		0xe4313507 = 0
		if structurecontains structure = <temp_struct> 0xe4313507
			0xe4313507 = (<temp_struct>.0xe4313507)
		endif
		0x0bbdd740 = none
		if structurecontains structure = <temp_struct> heap
			if ispakloaded (<temp_struct>.pak) heap = (<temp_struct>.heap)
				0x0bbdd740 = (<temp_struct>.heap)
			endif
		endif
		if (<0xe4313507> = 0)
			if NOT (<0x0bbdd740> = none)
				0x8dbdaee4 qs(0x4c341dde) a = <part_type> b = <0x0bbdd740>
				0x31e13444 = 1
			endif
		else
			if NOT (<0x0bbdd740> = none)
				0x8dbdaee4 qs(0xf4efa7ad) a = <part_type> b = <0x0bbdd740>
			else
				0x8dbdaee4 qs(0x560c3271) a = <part_type>
				0x31e13444 = 1
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	if gotparam \{assert}
		if (<0x31e13444> = 1)
			0x93d8d5cf \{qs(0xbb5e6c67)}
		endif
	endif
endscript

script 0xbe6e9296 
	0x63cedf49 = []
	getarraysize <part_list>
	if (<array_size> < 1)
		return \{0x63cedf49 = [
			]}
	endif
	i = 0
	begin
	if NOT load_part_desc_pak part_type = (<part_list> [<i>])
		addarrayelement array = <0x63cedf49> element = (<part_list> [<i>])
		0x63cedf49 = <array>
	endif
	i = (<i> + 1)
	repeat <array_size>
	return 0x63cedf49 = <0x63cedf49>
endscript

script 0x9219fac2 
	getarraysize <part_list>
	if (<array_size> < 1)
		return
	endif
	i = 0
	begin
	unload_part_desc_pak part_type = (<part_list> [<i>])
	i = (<i> + 1)
	repeat <array_size>
endscript

script 0xe55f0d87 
	if structurecontains structure = ($0xa32e828a) <genre>
		if NOT structurecontains structure = ($0xa32e828a.<genre>) <part_type>
			dummy_struct = ($0xa32e828a.<genre>)
			addparam structure_name = dummy_struct name = <part_type> value = []
			updatestructelement struct = $0xa32e828a element = <genre> value = <dummy_struct>
			change 0xa32e828a = <newstruct>
		endif
	else
		dummy_struct = {}
		addparam \{structure_name = dummy_struct
			name = 0x93157503
			value = [
			]}
		addparam structure_name = dummy_struct name = <part_type> value = []
		updatestructelement struct = 0xa32e828a element = <genre> value = <dummy_struct>
		change 0xa32e828a = <newstruct>
	endif
endscript

script 0xf9aae7bd 
	0xba84b155 <...>
	begin
	if NOT 0x8836ad8e
		break
	endif
	if gotparam \{async}
		wait \{1
			gameframe}
	endif
	repeat
	0xbc13404f
endscript

script 0x971fa914 
	0x8a4e63f1 = {cas_body = {desc_id = gh4_car_male}}
	0x5a57a328 = {cas_body = {desc_id = gh4_car_female}}
	getarraysize ($cas_randomized_parts)
	i = 0
	begin
	part_type = ($cas_randomized_parts [<i>].part)
	if resolvebodyspecificpartinappearance appearance = <0x8a4e63f1> part = <part_type>
		0xf9aae7bd part_type = <part>
		if resolvebodyspecificpartinappearance appearance = <0x5a57a328> part = <part_type>
			0xf9aae7bd part_type = <part>
		endif
	else
		0xf9aae7bd part_type = <part_type>
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script 0x5a2ee4d5 
	getarraysize ($genre_list)
	genre_count = <array_size>
	0xe54d3be1 = 0
	begin
	genre = (($genre_list [<0xe54d3be1>]).desc_id)
	if NOT (<genre> = any)
		0x0a881629 = ($0xa32e828a.<genre>.<part_type>)
		getarraysize (<0x0a881629>)
		part_count = <array_size>
		part_loop = 0
		begin
		0x51979d5e part_type = <part_type> desc_id = (<0x0a881629> [<part_loop>])
		part_loop = (<part_loop> + 1)
		repeat <part_count>
	endif
	0xe54d3be1 = (<0xe54d3be1> + 1)
	repeat <genre_count>
endscript

script 0xa2cdaafd 
	0x8a4e63f1 = {cas_body = {desc_id = gh4_car_male}}
	0x5a57a328 = {cas_body = {desc_id = gh4_car_female}}
	getarraysize ($cas_randomized_parts)
	0x415fb9ae = <array_size>
	0x49821931 = 0
	begin
	part_type = ($cas_randomized_parts [<0x49821931>].part)
	if resolvebodyspecificpartinappearance appearance = <0x8a4e63f1> part = <part_type>
		0x5a2ee4d5 {<...> part_type = <part>}
		if resolvebodyspecificpartinappearance appearance = <0x5a57a328> part = <part_type>
			0x5a2ee4d5 {<...> part_type = <part>}
		endif
	else
		0x5a2ee4d5 <...>
	endif
	0x49821931 = (<0x49821931> + 1)
	repeat <0x415fb9ae>
	change \{0xa32e828a = {
		}}
endscript

script 0x35d95d03 
	if NOT structurecontains structure = ($0xa32e828a) <genre>
		<genre> = (($song_genre_list.<genre>).0xa30449d0)
	endif
	begin
	if NOT (<genre> = any)
		break
	endif
	getarraysize ($genre_list)
	getrandomvalue name = rand_val a = 0 b = (<array_size> - 1) name = idx integer
	genre = (($genre_list [<idx>]).desc_id)
	repeat
	0x0a881629 = ($0xa32e828a.<genre>.<part_type>)
	getarraysize (<0x0a881629>)
	if (<array_size> < 1)
		0xf9aae7bd part_type = <part_type> async
		0x0a881629 = ($0xa32e828a.<genre>.<part_type>)
		getarraysize (<0x0a881629>)
	endif
	getrandomvalue name = rand_val a = 0 b = (<array_size> - 1) name = idx integer
	0x2bbc2c14 = (($0xa32e828a.<genre>.<part_type>) [<idx>])
	if NOT 0x8017346b array = ($0xa32e828a.<genre>.0x93157503) element = <part_type>
		0x51979d5e part_type = <part_type> desc_id = <0x2bbc2c14>
		removearrayelement array = <0x0a881629> index = <idx>
		0x0a881629 = <array>
		updatestructelement struct = ($0xa32e828a.<genre>) element = <part_type> value = <0x0a881629>
		updatestructelement struct = $0xa32e828a element = <genre> value = <newstruct>
		change 0xa32e828a = <newstruct>
	endif
	return part_desc_id = <0x2bbc2c14>
endscript
