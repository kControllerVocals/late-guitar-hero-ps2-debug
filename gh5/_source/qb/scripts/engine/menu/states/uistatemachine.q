ui_task_menu_default_focus_id = current_menu
ui_task_menu_default_anim_in_script = task_menu_default_anim_in
ui_task_menu_default_anim_out_script = task_menu_default_anim_out
g_ui_event_mini_loading_screen = {
	enable = true
	active = false
	skip_next = false
}
g_ui_event_use_mini_loading_screen = true

script UI_InitializeStateMachine 
	if ObjectExists \{id = ui}
		return
	endif
	<com_disabled> = 0
	if NOT IsCompositeObjectManagerEnabled
		<com_disabled> = 1
		CompositeObjectManagerSetEnable \{on}
	endif
	CreateCompositeObject \{params = {
			name = ui
			permanent
		}
		Components = [
			{
				Component = EventCache
			}
			{
				Component = StateMachineManager
			}
			{
				Component = MenuStack
			}
		]
		heap = FrontEnd}
	if (<com_disabled> = 1)
		CompositeObjectManagerSetEnable \{off}
	endif
	RegisterUIStates
	MemPushContext \{heap_ui_pak_slot}
	CreatePakManMap \{map = ui_paks
		links = UIPaks
		folder = 'Pak/ui/'}
	MemPopContext
	ui :Fsm_Set \{state = UIstate_Null
		replacement = this
		params = {
			base_name = 'null'
		}}
endscript

script ui_print_states 
	ui :UnPause
	ui :FSM_PrintStateMachine
	ui :MenuStack_PrintContents
endscript

script Is_ui_event_running 
	if ScriptIsRunning \{ui_event_block}
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
			if Is_ui_event_running
				return
			endif
		endif
		spawnscriptnow ui_event_block params = <...>
	else
		ui_event_spawned <...>
	endif
endscript

script ui_event_is_statechange 

	if (<event> = menu_back || <event> = menu_change || <event> = menu_replace || <event> = menu_refresh)
		return \{true}
	else
		return \{false}
	endif
endscript
waiting_for_statechange = 0

script ui_event_create_watch 
	if NOT ui_event_is_statechange event = <event>
		return
	endif
	spawnscriptnow \{ui_event_create_watch_spawned}
endscript

script ui_event_create_watch_spawned 
	SetSpawnInstanceLimits \{max = 1
		management = kill_oldest}
	change \{waiting_for_statechange = 0}
	push_loading_screen \{sustain}
	OnExitRun \{pop_loading_screen}
	Block \{type = TaskMenu_StateChanged}
	if ($waiting_for_statechange = 1)
		Block
	endif
endscript

script ui_event_spawned \{event = menu_change
		data = {
		}}
	if StructureContains \{Structure = data
			name = state}
		debug_Printf qs("\Lui_event event=%e state=%s") e = <event> s = (<data>.state) channel = ui_event
	else
		debug_Printf qs("\Lui_event event=%e") e = <event> channel = ui_event
	endif
	ui_event_create_watch event = <event>
	ui :UnPause
	ui :EventCache_Add event_id = <event> event_data = <data>
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
	if NOT Is_ui_event_running
		break
	endif
	WaitOneGameFrame
	repeat
	ui_event event = <event> data = <continue_state_data>
	begin
	if NOT Is_ui_event_running
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script ui_event_block \{event = menu_change
		data = {
		}}
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	ui_event_spawned event = <event> data = <data>
	if GotParam \{wait_for_statechange}
		if NOT ui_event_is_statechange event = <event>
			debug_ScriptAssert 'Called ui_event_block with wait_for_statechange with event %e' e = <event>
		endif
		begin
		if NOT ScriptIsRunning \{ui_event_create_watch_spawned}
			return
		endif
		WaitOneGameFrame
		repeat
	endif
	if (<event> = menu_focus)
		type = TaskMenu_focus
	elseif (<event> = menu_unfocus)
		type = TaskMenu_unfocus
	else
		type = TaskMenu_Callback
	endif
	Block type = <type>
endscript

script ui_event_wait \{event = menu_change
		data = {
		}}
	spawnscriptnow ui_event_wait_spawned params = {<...>}
endscript

script ui_event_wait_spawned 

	if ui_event_is_statechange event = <event>
		change \{waiting_for_statechange = 1}
	endif
	ui_event_wait_for_safe
	if GotParam \{state}
		data = {<data> state = <state>}
	endif
	spawnscriptnow ui_event_block params = <...>
endscript

script ui_event_wait_for_safe 
	begin
	if NOT Is_ui_event_running
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script ui_event_exists_in_stack 

	ui :MenuStack_GetStackContents
	if (<stack_size> < 1)
		return \{false}
	endif
	i = 0
	begin
	if ((<stack> [<i>].base_name) = <name>)
		return \{true}
	endif
	if GotParam \{above}
		if ((<stack> [<i>].base_name) = <above>)
			return \{false}
		endif
	endif
	i = (<i> + 1)
	repeat <stack_size>
	return \{false}
endscript

script ui_event_get_stack 
	ui :MenuStack_GetStackContents
	return {<...>}
endscript

script ui_state_pak_load 

	SetPakManCurrent map = ui_paks pakname = <pakname>
endscript

script ui_state_anim_in_done 
	ui_event \{event = menu_anim_in_done}
endscript

script ui_state_anim_out_done 
	ui_event \{event = menu_anim_out_done}
endscript

script ui_event_get_top 
	ui_event_get_stack
	GetArraySize <stack>
	if (<array_size> > 0)
		return (<stack> [0])
	endif
endscript
