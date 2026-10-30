ui_task_menu_default_focus_id = current_menu
ui_task_menu_default_anim_in_script = task_menu_default_anim_in
ui_task_menu_default_anim_out_script = task_menu_default_anim_out
0x86fdcfea = {
	enable = true
	active = false
	0xd77d3b61 = false
}
0x8e314709 = true

script ui_initializestatemachine 
	if objectexists \{id = ui}
		return
	endif
	<com_disabled> = 0
	if NOT iscompositeobjectmanagerenabled
		<com_disabled> = 1
		compositeobjectmanagersetenable \{on}
	endif
	createcompositeobject \{params = {
			name = ui
			permanent
		}
		components = [
			{
				component = eventcache
			}
			{
				component = statemachinemanager
			}
			{
				component = menustack
			}
		]
		heap = frontend}
	if (<com_disabled> = 1)
		compositeobjectmanagersetenable \{off}
	endif
	registeruistates
	mempushcontext \{heap_ui_pak_slot}
	createpakmanmap \{map = ui_paks
		links = uipaks
		folder = 'Pak/ui/'}
	mempopcontext
	ui :fsm_set \{state = uistate_null
		replacement = this
		params = {
			base_name = 'null'
		}}
endscript

script ui_print_states 
	ui :unpause
	ui :fsm_printstatemachine
	ui :menustack_printcontents
endscript

script is_ui_event_running 
	if scriptisrunning \{ui_event_block}
		return \{true}
	endif
	return \{false}
endscript

script ui_event_if_camera_finished 
	if is_menu_camera_finished
		ui_event <...>
	endif
endscript

script ui_event \{force_event = false}
	if NOT ((<event> = menu_anim_in_done) || (<event> = menu_anim_out_done) || (<event> = menu_add_data) || (<event> = menu_remove_data))
		if (<force_event> = false)
			if is_ui_event_running
				return
			endif
		endif
		spawnscriptnow ui_event_block params = <...>
	else
		ui_event_spawned <...>
	endif
endscript

script 0xb68cf6d4 

	if (<event> = menu_back || <event> = menu_change || <event> = menu_replace || <event> = menu_refresh)
		return \{true}
	else
		return \{false}
	endif
endscript
0x53308f96 = 0

script 0x3f946c68 
	if NOT 0xb68cf6d4 event = <event>
		return
	endif
	spawnscriptnow \{0xf29cdad1}
endscript

script 0xf29cdad1 
	setspawninstancelimits \{max = 1
		management = kill_oldest}
	change \{0x53308f96 = 0}
	0xd3f993c8 \{sustain}
	onexitrun \{0xe5a305c6}
	block \{type = 0xeac1163e}
	if ($0x53308f96 = 1)
		block
	endif
endscript

script ui_event_spawned \{event = menu_change
		data = {
		}}
	if structurecontains \{structure = data
			name = state}
		0x8dbdaee4 qs(0xd6e589bd) e = <event> s = (<data>.state) channel = ui_event
	else
		0x8dbdaee4 qs(0xde330243) e = <event> channel = ui_event
	endif
	0x3f946c68 event = <event>
	ui :unpause
	ui :eventcache_add event_id = <event> event_data = <data>
endscript

script ui_event_add_params 
	ui_event event = menu_add_data data = <...>
endscript

script ui_event_remove_params 
	ui_event event = menu_remove_data data = <...>
endscript

script ui_event_add_continue \{event = menu_change}
	ui_event event = menu_add data = <add_state_data>
	begin
	if NOT is_ui_event_running
		break
	endif
	waitonegameframe
	repeat
	ui_event event = <event> data = <continue_state_data>
	begin
	if NOT is_ui_event_running
		break
	endif
	waitonegameframe
	repeat
endscript

script ui_event_block \{event = menu_change
		data = {
		}}
	if gotparam \{state}
		data = {<data> state = <state>}
	endif
	ui_event_spawned event = <event> data = <data>
	if gotparam \{0xd1b494c2}
		if NOT 0xb68cf6d4 event = <event>
			0x93d8d5cf 'Called ui_event_block with wait_for_statechange with event %e' e = <event>
		endif
		begin
		if NOT scriptisrunning \{0xf29cdad1}
			return
		endif
		waitonegameframe
		repeat
	endif
	if (<event> = menu_focus)
		type = taskmenu_focus
	elseif (<event> = menu_unfocus)
		type = taskmenu_unfocus
	else
		type = taskmenu_callback
	endif
	block type = <type>
endscript

script ui_event_wait \{event = menu_change
		data = {
		}}
	spawnscriptnow ui_event_wait_spawned params = {<...>}
endscript

script ui_event_wait_spawned 

	if 0xb68cf6d4 event = <event>
		change \{0x53308f96 = 1}
	endif
	ui_event_wait_for_safe
	if gotparam \{state}
		data = {<data> state = <state>}
	endif
	spawnscriptnow ui_event_block params = <...>
endscript

script ui_event_wait_for_safe 
	begin
	if NOT is_ui_event_running
		break
	endif
	waitonegameframe
	repeat
endscript

script ui_event_exists_in_stack 

	ui :menustack_getstackcontents
	if (<stack_size> < 1)
		return \{false}
	endif
	i = 0
	begin
	if ((<stack> [<i>].base_name) = <name>)
		return \{true}
	endif
	if gotparam \{above}
		if ((<stack> [<i>].base_name) = <above>)
			return \{false}
		endif
	endif
	i = (<i> + 1)
	repeat <stack_size>
	return \{false}
endscript

script ui_event_get_stack 
	ui :menustack_getstackcontents
	return {<...>}
endscript

script ui_state_pak_load 

	setpakmancurrent map = ui_paks pakname = <pakname>
endscript

script ui_state_anim_in_done 
	ui_event \{event = menu_anim_in_done}
endscript

script ui_state_anim_out_done 
	ui_event \{event = menu_anim_out_done}
endscript

script ui_event_get_top 
	ui_event_get_stack
	getarraysize <stack>
	if (<array_size> > 0)
		return (<stack> [0])
	endif
endscript
