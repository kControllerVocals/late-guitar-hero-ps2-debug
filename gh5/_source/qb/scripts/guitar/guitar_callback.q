
script pre_gameserver_callback 
	script_callback_script_cfunc
endscript

script script_callback_script 
endscript

script script_postcallback_script 
	updateguitarfuncs
	if NOT gameispaused
		getdeltatime \{ignore_slomo}
		update2dparticlesystems delta_time = <delta_time>
		runqueuedpulseevents
		if ($output_gpu_log = 1)
			0xbce9b567
		endif
	endif
	change current_frame_toggle = (1 - $current_frame_toggle)
endscript

script screenelement_postcallback_script 
endscript
