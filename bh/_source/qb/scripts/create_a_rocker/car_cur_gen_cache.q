car_part_cache = [
]
number_of_random_parts_to_cache_per_genre = 4
randomizer_part_cache = {
}
part_def_clusters = {
	ui_customize_character = [
		CAS_Torso_Art
		CAS_Left_Arm_Art
		CAS_Right_Arm_Art
		CAS_Eye_Makeup
		CAS_Lip_Makeup
		CAS_Eyes
		CAS_Female_Hair
		CAS_Female_Hat_Hair
		CAS_Male_Facial_Hair
		CAS_Male_Hair
		CAS_Male_Hat_Hair
	]
	ui_customize_character_outfit = [
		CAS_Female_Torso
		CAS_Female_Legs
		CAS_Female_Shoes
		CAS_Female_Acc_Left
		CAS_Female_Acc_Right
		CAS_Female_Acc_Face
		CAS_Female_Acc_Ears
		CAS_Female_Hair
		CAS_Female_Hat_Hair
		CAS_Female_Hat
		CAS_Male_Torso
		CAS_Male_Legs
		CAS_Male_Shoes
		CAS_Male_Acc_Left
		CAS_Male_Acc_Right
		CAS_Male_Acc_Face
		CAS_Male_Acc_Ears
		CAS_Male_Hair
		CAS_Male_Hat_Hair
		CAS_Male_Hat
	]
}

script clear_part_cache 
	change \{car_part_cache = [
		]}
endscript

script get_cached_part 
	find_part_in_cache <...>
	if NOT (<index> = -1)
		return cached_part_struct = ($car_part_cache [<index>])
	endif
endscript

script add_part_to_cache 
	find_part_in_cache <...>
	if (<index> = -1)
		RemoveParameter \{index}
		if GotParam \{no_ref}
			RemoveParameter \{no_ref}
			temp_part = {<...> ref_count = 0}
		else
			temp_part = {<...> ref_count = 1}
		endif
		AddArrayElement array = ($car_part_cache) element = <temp_part>
		change car_part_cache = <array>
	else
		temp_part = ($car_part_cache [<index>])
		if GotParam \{no_ref}
			temp_ref = (<temp_part>.ref_count)
		else
			temp_ref = (<temp_part>.ref_count + 1)
		endif
		temp_part = {<temp_part> ref_count = <temp_ref>}
		SetArrayElement ArrayName = car_part_cache index = <index> newvalue = <temp_part> GlobalArray ResolveGlobals = 0
	endif
endscript

script remove_part_from_cache 
	find_part_in_cache <...>
	if (<index> = -1)
		switch (<part_type>)
			case CAS_Body
			case cas_physique
			case CAS_Full_Instrument
			return
			default
			debug_Printf \{qs(0x5dce1217)}
		endswitch
	else
		temp_part = ($car_part_cache [<index>])
		temp_ref = ((<temp_part>.ref_count) - 1)
		if (<temp_ref> < 0)
			temp_ref = 0
		endif
		temp_part = {<temp_part> ref_count = <temp_ref>}
		SetArrayElement ArrayName = car_part_cache index = <index> newvalue = <temp_part> GlobalArray ResolveGlobals = 0
	endif
	if GotParam \{flush}
		flush_part_cache
	endif
endscript

script add_part_in_appearance_to_cache 
	ResolveBodySpecificPartInAppearance appearance = <appearance> part = <part_type>
	part_type = <part>
	if NOT GotParam \{desc_id}
		if StructureContains Structure = <appearance> <part_type>
			desc_id = (<appearance>.<part_type>.desc_id)
		else
			debug_ScriptAssert \{qs(0x9018370d)}
			return
		endif
	endif
	if GetActualCASOptionStruct part = <part_type> desc_id = <desc_id>
		RemoveParameter \{appearance}
		RemoveParameter \{part}
		add_part_to_cache <...>
		if NOT GotParam \{no_add_nodes}
			if GotParam \{add_to_nodes}
				desc_id_copy = <desc_id>
				add_to_nodes_copy = <add_to_nodes>
				GetArraySize <add_to_nodes>
				i = 0
				begin
				node_child_struct = (<add_to_nodes_copy> [<i>])
				if GotParam \{no_ref}
					add_part_in_appearance_to_cache part_type = (<node_child_struct>.part_type) desc_id = (<node_child_struct>.desc_id) no_ref no_add_nodes
				else
					add_part_in_appearance_to_cache part_type = (<node_child_struct>.part_type) desc_id = (<node_child_struct>.desc_id) no_add_nodes
				endif
				i = (<i> + 1)
				repeat <array_size>
			endif
		endif
		if GotParam \{hat_hair}
			switch (<part_type>)
				case CAS_Male_Hair
				case CAS_Male_Hat
				part = CAS_Male_Hat_Hair
				case CAS_Female_Hair
				case CAS_Female_Hat
				part = CAS_Female_Hat_Hair
				default
				debug_ScriptAssert \{qs(0xea6f7c2d)}
			endswitch
			if NOT (<hat_hair> = original_hair)
				unload_pak_after_caching = 0
				if NOT load_part_desc_pak part_type = <part>
					unload_pak_after_caching = 1
				endif
				if GotParam \{no_ref}
					add_part_in_appearance_to_cache part_type = <part> desc_id = <hat_hair> no_ref
				else
					add_part_in_appearance_to_cache part_type = <part> desc_id = <hat_hair>
				endif
				if (<unload_pak_after_caching> = 1)
					unload_part_desc_pak part_type = <part>
				endif
			endif
		endif
	else
		debug_ScriptAssert qs(0x0e84b604) a = <desc_id> b = <part_type>
	endif
endscript

script remove_part_in_appearance_from_cache 
	ResolveBodySpecificPartInAppearance appearance = <appearance> part = <part_type>
	if StructureContains Structure = <appearance> <part>
		desc_id = (<appearance>.<part>.desc_id)
		remove_part_from_cache part_type = <part> desc_id = <desc_id>
	endif
endscript

script cache_parts_in_appearance 
	if cache_parts_in_appearance_setup <...>
		begin
		if NOT cache_parts_in_appearance_loop appearance = <appearance>
			break
		endif
		Wait \{1
			gameframe}
		repeat
	endif
	cache_parts_in_appearance_shutdown
endscript

script load_cached_part_pak \{async = 0}
	if NOT GotParam \{cached_part_struct}
		get_cached_part part = <part> desc_id = <desc_id>
	endif
	if StructureContains Structure = <cached_part_struct> add_to_nodes
		PushAssetContext context = <asset_context>
		GetArraySize (<cached_part_struct>.add_to_nodes)
		i = 0
		begin
		node_child_struct = (<cached_part_struct>.add_to_nodes [<i>])
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
	elseif StructureContains Structure = <cached_part_struct> pak
		pak = (<cached_part_struct>.pak)
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
	return \{false}
endscript

script unload_cached_part_pak 
	if NOT GotParam \{cached_part_struct}
		get_cached_part part = <part> desc_id = <desc_id>
	endif
	if StructureContains Structure = <cached_part_struct> node_paks
		GetArraySize (<cached_part_struct>.node_paks)
		i = 0
		begin
		node_child_name = (<cached_part_struct>.node_paks [<i>])
		if (<async> = 1)
			IncrementPartPakUnloading
			SpawnScriptLater UnloadAppearancePak_Async params = {asset_context = <asset_context> pak = <node_child_name>}
		else
			PushAssetContext context = <asset_context>
			UnloadPak <node_child_name>
			if NOT GotParam \{no_wait}
				WaitUnloadPak <node_child_name> Block
			endif
			PopAssetContext
		endif
		i = (<i> + 1)
		repeat <array_size>
		return \{true}
	elseif StructureContains Structure = <cached_part_struct> pak
		pak = (<cached_part_struct>.pak)
		if (<async> = 1)
			IncrementPartPakUnloading
			SpawnScriptLater UnloadAppearancePak_Async params = {asset_context = <asset_context> pak = <pak>}
		else
			PushAssetContext context = <asset_context>
			UnloadPak <pak>
			if NOT GotParam \{no_wait}
				WaitUnloadPak <pak> Block
			endif
			PopAssetContext
		endif
		return \{true}
	endif
endscript

script dump_part_cache 
	debug_Printf \{qs(0xc080aee1)}
	dump_list = []
	GetArraySize ($car_part_cache)
	if (<array_size> < 1)
		debug_Printf \{qs(0x3de76e3b)}
		return
	endif
	i = 0
	begin
	temp_part = ($car_part_cache [<i>])
	add_to_list = 1
	if GotParam \{part_type}
		if NOT (<temp_part>.part_type = <part_type>)
			add_to_list = 0
		endif
	endif
	if GotParam \{desc_id}
		if NOT (<temp_part>.desc_id = <desc_id>)
			add_to_list = 0
		endif
	endif
	if (<add_to_list> = 1)
		AddArrayElement array = <dump_list> element = <temp_part>
		dump_list = <array>
	endif
	i = (<i> + 1)
	repeat <array_size>
	debug_PrintStruct <dump_list>
endscript

script load_part_desc_pak \{heap = heap_song}
	if NOT StructureContains Structure = ($car_part_desc_paks) <part_type>
		debug_Printf qs(0x7f310966) a = <part_type>
		return \{true}
	endif
	temp_struct = ($car_part_desc_paks.<part_type>)
	if NOT StructureContains Structure = <temp_struct> is_loaded
		temp_struct = {<temp_struct> is_loaded = 0}
	endif
	if NOT (<temp_struct>.is_loaded = 1)
		PushAssetContext context = <heap>
		LoadPak (<temp_struct>.pak) heap = <heap>
		PopAssetContext
		temp_struct = {<temp_struct> is_loaded = 1 heap = <heap>}
		UpdateStructElement struct = $car_part_desc_paks element = <part_type> value = <temp_struct>
		change car_part_desc_paks = <newstruct>
		return \{false}
	endif
	return \{true}
endscript

script unload_part_desc_pak 
	if NOT StructureContains Structure = ($car_part_desc_paks) <part_type>
		switch (<part_type>)
			case CAS_Body
			case cas_physique
			case CAS_Full_Instrument
			return
			default
			debug_ScriptAssert \{qs(0xae803f64)}
		endswitch
	endif
	temp_struct = ($car_part_desc_paks.<part_type>)
	if NOT StructureContains Structure = <temp_struct> is_loaded
		return
	endif
	if (<temp_struct>.is_loaded = 1)
		PushAssetContext context = (<temp_struct>.heap)
		UnloadPak (<temp_struct>.pak)
		PopAssetContext
		temp_struct = {<temp_struct> is_loaded = 0}
		UpdateStructElement struct = $car_part_desc_paks element = <part_type> value = <temp_struct>
		change car_part_desc_paks = <newstruct>
	endif
endscript

script load_all_part_desc_paks 
	heap_list = [heap_song BottomUpHeap]
	if GotParam \{alternate_heap}
		if (<alternate_heap> = 1)
			heap_list = [heap_song BottomUpHeap]
		endif
	endif
	GetArraySize (<heap_list>)
	max_heap_index = (<array_size> - 1)
	current_heap_index = 0
	GetArraySize ($master_editable_list)
	i = 0
	begin
	master_edit_struct = ($master_editable_list [<i>])
	part_type = (<master_edit_struct>.part)
	heap = (<heap_list> [<current_heap_index>])
	if StructureContains Structure = ($car_part_desc_paks) <part_type>
		if IsRoomForFileInHeapContext file = ($car_part_desc_paks.<part_type>.pak) context = <heap>
			load_part_desc_pak part_type = <part_type> heap = <heap>
		else
			current_heap_index = (<current_heap_index> + 1)
			if (<current_heap_index> > <max_heap_index>)
				debug_ScriptAssert \{qs(0xec94660e)}
			endif
			i = (<i> - 1)
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script unload_all_part_desc_paks 
	if NOT GlobalExists \{name = car_part_desc_paks}
		return
	endif
	GetArraySize ($master_editable_list)
	i = 0
	begin
	master_edit_struct = ($master_editable_list [<i>])
	part_type = (<master_edit_struct>.part)
	if StructureContains Structure = ($car_part_desc_paks) <part_type>
		unload_part_desc_pak part_type = <part_type>
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script dump_loaded_part_desc_paks 
	debug_Printf \{qs(0x84d2d657)}
	should_assert = 0
	GetArraySize ($master_editable_list)
	i = 0
	begin
	master_edit_struct = ($master_editable_list [<i>])
	part_type = (<master_edit_struct>.part)
	if StructureContains Structure = ($car_part_desc_paks) <part_type>
		temp_struct = ($car_part_desc_paks.<part_type>)
		is_loaded = 0
		if StructureContains Structure = <temp_struct> is_loaded
			is_loaded = (<temp_struct>.is_loaded)
		endif
		on_heap = none
		if StructureContains Structure = <temp_struct> heap
			if IsPakLoaded (<temp_struct>.pak) heap = (<temp_struct>.heap)
				on_heap = (<temp_struct>.heap)
			endif
		endif
		if (<is_loaded> = 0)
			if NOT (<on_heap> = none)
				debug_Printf qs(0x4c341dde) a = <part_type> b = <on_heap>
				should_assert = 1
			endif
		else
			if NOT (<on_heap> = none)
				debug_Printf qs(0xf4efa7ad) a = <part_type> b = <on_heap>
			else
				debug_Printf qs(0x560c3271) a = <part_type>
				should_assert = 1
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <array_size>
	if GotParam \{assert}
		if (<should_assert> = 1)
			debug_ScriptAssert \{qs(0xbb5e6c67)}
		endif
	endif
endscript

script load_part_desc_pak_list 
	parts_loaded = []
	GetArraySize <part_list>
	if (<array_size> < 1)
		return \{parts_loaded = [
			]}
	endif
	i = 0
	begin
	if NOT load_part_desc_pak part_type = (<part_list> [<i>])
		AddArrayElement array = <parts_loaded> element = (<part_list> [<i>])
		parts_loaded = <array>
	endif
	i = (<i> + 1)
	repeat <array_size>
	return parts_loaded = <parts_loaded>
endscript

script unload_part_desc_pak_list 
	GetArraySize <part_list>
	if (<array_size> < 1)
		return
	endif
	i = 0
	begin
	unload_part_desc_pak part_type = (<part_list> [<i>])
	i = (<i> + 1)
	repeat <array_size>
endscript

script init_random_cache_queue 
	if StructureContains Structure = ($randomizer_part_cache) <genre>
		if NOT StructureContains Structure = ($randomizer_part_cache.<genre>) <part_type>
			dummy_struct = ($randomizer_part_cache.<genre>)
			AddParam structure_name = dummy_struct name = <part_type> value = []
			UpdateStructElement struct = $randomizer_part_cache element = <genre> value = <dummy_struct>
			change randomizer_part_cache = <newstruct>
		endif
	else
		dummy_struct = {}
		AddParam \{structure_name = dummy_struct
			name = low_number_parts
			value = [
			]}
		AddParam structure_name = dummy_struct name = <part_type> value = []
		UpdateStructElement struct = randomizer_part_cache element = <genre> value = <dummy_struct>
		change randomizer_part_cache = <newstruct>
	endif
endscript

script queue_random_cache_part 
	queue_random_cache_part_setup <...>
	begin
	if NOT queue_random_cache_part_loop
		break
	endif
	if GotParam \{async}
		Wait \{1
			gameframe}
	endif
	repeat
	queue_random_cache_part_shutdown
endscript

script fill_random_part_queues 
	male_dummy_appearance = {CAS_Body = {desc_id = GH4_CAR_Male}}
	female_dummy_appearance = {CAS_Body = {desc_id = GH4_CAR_Female}}
	GetArraySize ($cas_randomized_parts)
	i = 0
	begin
	part_type = ($cas_randomized_parts [<i>].part)
	if ResolveBodySpecificPartInAppearance appearance = <male_dummy_appearance> part = <part_type>
		queue_random_cache_part part_type = <part>
		if ResolveBodySpecificPartInAppearance appearance = <female_dummy_appearance> part = <part_type>
			queue_random_cache_part part_type = <part>
		endif
	else
		queue_random_cache_part part_type = <part_type>
	endif
	i = (<i> + 1)
	repeat <array_size>
endscript

script empty_genre_from_random_part_queue 
	GetArraySize ($Genre_List)
	genre_count = <array_size>
	genre_loop = 0
	begin
	genre = (($Genre_List [<genre_loop>]).desc_id)
	if NOT (<genre> = any)
		queue_array = ($randomizer_part_cache.<genre>.<part_type>)
		GetArraySize (<queue_array>)
		part_count = <array_size>
		part_loop = 0
		begin
		remove_part_from_cache part_type = <part_type> desc_id = (<queue_array> [<part_loop>])
		part_loop = (<part_loop> + 1)
		repeat <part_count>
	endif
	genre_loop = (<genre_loop> + 1)
	repeat <genre_count>
endscript

script empty_random_part_queues 
	male_dummy_appearance = {CAS_Body = {desc_id = GH4_CAR_Male}}
	female_dummy_appearance = {CAS_Body = {desc_id = GH4_CAR_Female}}
	GetArraySize ($cas_randomized_parts)
	part_type_count = <array_size>
	part_type_loop = 0
	begin
	part_type = ($cas_randomized_parts [<part_type_loop>].part)
	if ResolveBodySpecificPartInAppearance appearance = <male_dummy_appearance> part = <part_type>
		empty_genre_from_random_part_queue {<...> part_type = <part>}
		if ResolveBodySpecificPartInAppearance appearance = <female_dummy_appearance> part = <part_type>
			empty_genre_from_random_part_queue {<...> part_type = <part>}
		endif
	else
		empty_genre_from_random_part_queue <...>
	endif
	part_type_loop = (<part_type_loop> + 1)
	repeat <part_type_count>
	change \{randomizer_part_cache = {
		}}
endscript

script get_random_part_from_queue 
	if NOT StructureContains Structure = ($randomizer_part_cache) <genre>
		<genre> = (($song_genre_list.<genre>).car_genre)
	endif
	begin
	if NOT (<genre> = any)
		break
	endif
	GetArraySize ($Genre_List)
	GetRandomValue name = rand_val a = 0 b = (<array_size> - 1) name = idx Integer
	genre = (($Genre_List [<idx>]).desc_id)
	repeat
	queue_array = ($randomizer_part_cache.<genre>.<part_type>)
	GetArraySize (<queue_array>)
	if (<array_size> < 1)
		queue_random_cache_part part_type = <part_type> async
		queue_array = ($randomizer_part_cache.<genre>.<part_type>)
		GetArraySize (<queue_array>)
	endif
	GetRandomValue name = rand_val a = 0 b = (<array_size> - 1) name = idx Integer
	target_part_desc_id = (($randomizer_part_cache.<genre>.<part_type>) [<idx>])
	if NOT IsInArray array = ($randomizer_part_cache.<genre>.low_number_parts) element = <part_type>
		remove_part_from_cache part_type = <part_type> desc_id = <target_part_desc_id>
		RemoveArrayElement array = <queue_array> index = <idx>
		queue_array = <array>
		UpdateStructElement struct = ($randomizer_part_cache.<genre>) element = <part_type> value = <queue_array>
		UpdateStructElement struct = $randomizer_part_cache element = <genre> value = <newstruct>
		change randomizer_part_cache = <newstruct>
	endif
	return part_desc_id = <target_part_desc_id>
endscript
