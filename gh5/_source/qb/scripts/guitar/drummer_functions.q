drumtest = 1

script drummer_kill_spawnscripts 
	killspawnedscript \{name = drumdroid_timers}
	killspawnedscript \{name = hide_non_drummers}
	killspawnedscript \{name = hit_drumkit_piece}
	killspawnedscript \{name = default_kit_anims}
	killspawnedscript \{name = default_drummer_state}
	killspawnedscript \{name = drummer_controlscript}
	killspawnedscript \{name = drummer_transit}
	killspawnedscript \{name = drummer_transit_loops}
	killspawnedscript \{name = drummer_transit_idles}
	killspawnedscript \{name = create_trans_diff}
	killspawnedscript \{name = drummer_current_tempo}
	killspawnedscript \{name = set_drummer_active_values}
	killspawnedscript \{name = drummer_offset_anims}
endscript

script drummer_reset_globals 
	drummer_kill_spawnscripts
endscript
