fake_net = 0
assertonmissingscripts = 0
assertonmissingassets = 1

script zone_init 

	if (<zone_string_name> = 'z_viewer')

		change \{assertonmissingscripts = 0}
	endif
	mempushcontext \{topdownheap}
	formattext textname = zone_editable_text checksumname = zone_editable_list '%a%b' a = <zone_string_name> b = '_editable_list'
	if globalexists name = <zone_editable_list> type = array
		addeditablelist <zone_editable_list>
	endif
	mempopcontext
	mempushcontext \{bottomupheap}
	parsenodearray {
		queue
		zone_name = <zone_name>
		array_name = <array_name>
	}
	if gotparam \{sfx_array_name}
		parsenodearray {
			queue
			zone_name = <sfx_zone_name>
			array_name = <sfx_array_name>
		}
	endif
	if gotparam \{gfx_array_name}
		parsenodearray {
			queue
			zone_name = <gfx_zone_name>
			array_name = <gfx_array_name>
		}
	endif
	if gotparam \{lfx_array_name}
		parsenodearray {
			queue
			zone_name = <lfx_zone_name>
			array_name = <lfx_array_name>
		}
	endif
	if gotparam \{mfx_array_name}
		parsenodearray {
			queue
			zone_name = <mfx_zone_name>
			array_name = <mfx_array_name>
		}
	endif
	mempopcontext
	if NOT infrontend
		formattext checksumname = zone_setup_script '%a_Setup' a = <zone_string_name>

		if scriptexists <zone_setup_script>

			spawnscriptnow zone_init_wait_run_setup params = {zone_setup_script = <zone_setup_script>}
		endif
	endif
endscript

script zone_init_wait_run_setup 
	begin
	if NOT nodearraybusy
		break
	endif
	waitonegameframe
	repeat
	clearmasterbloom
	if scriptexists <zone_setup_script>

		<zone_setup_script>
	endif
endscript

script zone_deinit 

	parsenodearray abort array_name = <array_name>
	if gotparam \{sfx_array_name}
		parsenodearray abort array_name = <sfx_array_name>
	endif
	if gotparam \{gfx_array_name}
		parsenodearray abort array_name = <gfx_array_name>
	endif
	if gotparam \{lfx_array_name}
		parsenodearray abort array_name = <lfx_array_name>
	endif
	if gotparam \{mfx_array_name}
		parsenodearray abort array_name = <mfx_array_name>
	endif
	formattext textname = zone_editable_text checksumname = zone_editable_list '%a%b' a = <zone_string_name> b = '_editable_list'
	if globalexists name = <zone_editable_list> type = array
		removeeditablelist <zone_editable_list>
	endif
endscript

script setupcoim 
	pushmemprofile \{'COIM'}
	initcoim {
		size = <size>
		blockalign = $generic_coim_blockalign
		coim_min_scratch_blocks
		$generic_coim_params
	}
	popmemprofile
endscript
