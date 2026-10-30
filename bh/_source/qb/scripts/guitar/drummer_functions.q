drumtest = 1

script drummer_kill_spawnscripts 
	killspawnedscript \{name = drumdroid_timers}
	killspawnedscript \{name = hide_non_drummers}
	killspawnedscript \{name = hit_drumkit_piece}
	killspawnedscript \{name = default_kit_anims}
	killspawnedscript \{name = default_drummer_state}
	killspawnedscript \{name = drummer_controlscript}
	killspawnedscript \{name = drummer_transit_base_short}
	killspawnedscript \{name = drummer_transit_base_long}
	killspawnedscript \{name = drummer_transit_arm_r}
	killspawnedscript \{name = drummer_transit_arm_l}
	killspawnedscript \{name = drummer_transit_loops}
	killspawnedscript \{name = drummer_transit_idles}
	killspawnedscript \{name = drummer_current_tempo}
	killspawnedscript \{name = set_drummer_active_values}
	killspawnedscript \{name = hold_transit_requests}
	killspawnedscript \{name = hold_transit_arms}
	killspawnedscript \{name = hold_active_values}
	killspawnedscript \{name = drummer_anticipation_arms}
	killspawnedscript \{name = hold_drummer_anticipation_arms}
	killspawnedscript \{name = hold_drumkit_piece}
	killspawnedscript \{name = hold_body_trans}
	killspawnedscript \{name = hold_body_loops}
	killspawnedscript \{name = idle_check}
endscript

script drummer_reset_globals 
	change \{use_db_branch_l = 1}
	change \{use_db_branch_r = 1}
	change \{use_db_base = 1}
	change \{current_db_base = 1}
	change \{drummer_idle = true}
	drummer_kill_spawnscripts
endscript
