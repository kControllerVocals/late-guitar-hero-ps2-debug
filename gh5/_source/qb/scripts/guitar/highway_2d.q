highway_lines = 1152
real_highway_lines = 1024
gHighwayStartFade = 400.0
gHighwayEndFade = 1000.0

script Set2DHighwaySpeed \{Speed = -1.0}
	change structurename = <player_status> highway_speed = <Speed>
	SetScreenElementProps id = <id> highway_speed = <Speed>
endscript

script Set2DHighwayFade \{start = 720.0
		end = 100.0}
	SetScreenElementProps id = <id> MaterialProps = [
		{name = m_startFade Property = <start>}
		{name = m_endFade Property = <end>}
		{name = m_playerIndex Property = <player>}
	]
endscript

script Set2DGemFade 
	SetScreenElementProps id = <id> MaterialProps = [
		{name = m_startFade Property = <start>}
		{name = m_endFade Property = <end>}
		{name = m_playerIndex Property = <player>}
	]
endscript
sidebar_angle = [
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
]
sidebar_x = [
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
]
sidebar_y = [
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
	0.0
]
highway_pos_table = [
	{
		highway_top_width = 0
	}
	{
		highway_top_width = 0
	}
	{
		highway_top_width = 0
	}
	{
		highway_top_width = 0
	}
	{
		highway_top_width = 0
	}
	{
		highway_top_width = 0
	}
	{
		highway_top_width = 0
	}
	{
		highway_top_width = 0
	}
]

script get_highway_struct 
	get_num_non_vocals_players_onscreen
	if (<num_non_vocals_players> = 1)
		struct = highway_guitar1
	elseif (<num_non_vocals_players> = 2)
		struct = highway_guitar2
	elseif (<num_non_vocals_players> = 3)
		struct = highway_guitar3
	else

	endif
	return <...>
endscript

script generate_pos_table 
	get_highway_struct player = <player>
	if GotParam \{debug}
		<pos_index> = ((<player> -1) + 4)
	else
		<pos_index> = (<player> -1)
	endif
	SetArrayElement GlobalArray ArrayName = highway_pos_table index = <pos_index> newvalue = ($<struct>)
	pos_table = ($highway_pos_table [<pos_index>])
	SetAllWhammyValues \{value = 1.0
		player = 1}
	SetAllWhammyValues \{value = 1.0
		player = 2}
	SetAllWhammyValues \{value = 1.0
		player = 3}
	SetAllWhammyValues \{value = 1.0
		player = 4}
	if NOT GotParam \{overrideperspective}
		heightOffsetFactor = (<pos_table>.perspectivefact)
		heightOffsetExp = (<pos_table>.perspectiveexp)
	endif

	highway_playline = (<pos_table>.highway_playline)
	startY = (<highway_playline> - (<pos_table>.highway_height))
	rows = $highway_lines
	normal_rows = $real_highway_lines
	Height = (<pos_table>.highway_height)
	htx = (640.0 - ((<pos_table>.highway_top_width) / 2.0))
	gts = ((<pos_table>.highway_top_width) / 5.0)
	if NOT PlayerInfoEquals <player> part = drum
		gsx = (<htx> + (<gts> / 2.0) + (<gts> * 0.0))
		rsx = (<htx> + (<gts> / 2.0) + (<gts> * 1.0))
		ysx = (<htx> + (<gts> / 2.0) + (<gts> * 2.0))
		bsx = (<htx> + (<gts> / 2.0) + (<gts> * 3.0))
		osx = (<htx> + (<gts> / 2.0) + (<gts> * 4.0))
		psx = (<htx> + (<gts> / 2.0) + (<gts> * -1.0))
	else
		if UseFourLaneHighway player = <player>
			gts = ((<pos_table>.highway_top_width) / 4.0)
		endif
		rsx = (<htx> + (<gts> * 0.5))
		ysx = (<rsx> + <gts>)
		bsx = (<ysx> + <gts>)
		if NOT UseFourLaneHighway player = <player>
			osx = (<bsx> + <gts>)
			gsx = (<osx> + <gts>)
		else
			osx = (<bsx> + (10 * <gts>))
			gsx = (<bsx> + <gts>)
		endif
		psx = (<htx> + ((<pos_table>.highway_top_width) * 0.5))
	endif
	hbw = ((<pos_table>.highway_top_width) + ((<pos_table>.highway_top_width) * (<pos_table>.widthOffsetFactor)))
	hbx = (640.0 - (<hbw> / 2.0))
	gbs = (<hbw> / 5.0)
	if NOT PlayerInfoEquals <player> part = drum
		gex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 0.0))
		rex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 1.0))
		yex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 2.0))
		bex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 3.0))
		oex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 4.0))
		pex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 2.0))
		pex1 = (<hbx> + (<gbs> / 2.0) + (<gbs> * -0.5))
		pex2 = (<hbx> + (<gbs> / 2.0) + (<gbs> * 4.5))
	else
		if UseFourLaneHighway player = <player>
			gbs = (<hbw> / 4.0)
		endif
		rex = (<hbx> + (<gbs> * 0.5))
		yex = (<rex> + <gbs>)
		bex = (<yex> + <gbs>)
		if NOT UseFourLaneHighway player = <player>
			oex = (<bex> + <gbs>)
			gex = (<oex> + <gbs>)
		else
			oex = (<bex> + (10 * <gbs>))
			gex = (<bex> + <gbs>)
		endif
		pex = (<hbx> + (<hbw> * 0.5))
		pex1 = (<hbx> + (<gbs> * -0.15))
		pex2 = (<gex> + (<gbs> * 0.65000004))
	endif
	Atan2 x = (<pos_table>.highway_height) y = (<gsx> - <gex>)
	ga = <atan>
	Atan2 x = (<pos_table>.highway_height) y = (<rsx> - <rex>)
	ra = <atan>
	Atan2 x = (<pos_table>.highway_height) y = (<ysx> - <yex>)
	ya = <atan>
	Atan2 x = (<pos_table>.highway_height) y = (<bsx> - <bex>)
	bA = <atan>
	Atan2 x = (<pos_table>.highway_height) y = (<osx> - <oex>)
	oa = <atan>
	Atan2 x = (<pos_table>.highway_height) y = (<psx> - <pex>)
	pa = <atan>
	if PlayerInfoEquals <player> part = drum
		SetButtonData player = <player> array = button_models color = red Angle = <ra> start_x = <rsx> start_y = <startY> end_x = <rex> end_y = <highway_playline> left_start_x = <rsx> left_end_x = <rex> left_angle = <ra>
		SetButtonData player = <player> array = button_models color = Yellow Angle = <ya> start_x = <ysx> start_y = <startY> end_x = <yex> end_y = <highway_playline> left_start_x = <ysx> left_end_x = <yex> left_angle = <ya>
		SetButtonData player = <player> array = button_models color = Blue Angle = <bA> start_x = <bsx> start_y = <startY> end_x = <bex> end_y = <highway_playline> left_start_x = <bsx> left_end_x = <bex> left_angle = <bA>
		SetButtonData player = <player> array = button_models color = Orange Angle = <oa> start_x = <osx> start_y = <startY> end_x = <oex> end_y = <highway_playline> left_start_x = <osx> left_end_x = <oex> left_angle = <oa>
		SetButtonData player = <player> array = button_models color = green Angle = <ga> start_x = <gsx> start_y = <startY> end_x = <gex> end_y = <highway_playline> left_start_x = <gsx> left_end_x = <gex> left_angle = <ga>
		SetButtonData player = <player> array = button_models color = white Angle = <pa> start_x = <psx> start_y = <startY> end_x = <pex> end_y = <highway_playline> left_start_x = <psx> left_end_x = <pex> left_angle = <pa>
		SetButtonData player = <player> array = button_up_models color = red pos_x = <rex> pos_y = <highway_playline> left_pos_x = <rex>
		SetButtonData player = <player> array = button_up_models color = Yellow pos_x = <yex> pos_y = <highway_playline> left_pos_x = <yex>
		SetButtonData player = <player> array = button_up_models color = Blue pos_x = <bex> pos_y = <highway_playline> left_pos_x = <bex>
		SetButtonData player = <player> array = button_up_models color = Orange pos_x = <oex> pos_y = <highway_playline> left_pos_x = <oex>
		SetButtonData player = <player> array = button_up_models color = green pos_x = <gex> pos_y = <highway_playline> left_pos_x = <gex>
		SetButtonData player = <player> array = button_up_models color = white pos_x = <pex> pos_y = <highway_playline> left_pos_x = <pex>
		SetButtonData player = <player> array = button_up_models color = extra pos_x = <pex1> pos_y = <highway_playline> left_pos_x = <pex2>
	else
		SetButtonData player = <player> array = button_models color = green Angle = <ga> start_x = <gsx> start_y = <startY> end_x = <gex> end_y = <highway_playline> left_start_x = <osx> left_end_x = <oex> left_angle = <oa>
		SetButtonData player = <player> array = button_models color = red Angle = <ra> start_x = <rsx> start_y = <startY> end_x = <rex> end_y = <highway_playline> left_start_x = <bsx> left_end_x = <bex> left_angle = <bA>
		SetButtonData player = <player> array = button_models color = Yellow Angle = <ya> start_x = <ysx> start_y = <startY> end_x = <yex> end_y = <highway_playline> left_start_x = <ysx> left_end_x = <yex> left_angle = <ya>
		SetButtonData player = <player> array = button_models color = Blue Angle = <bA> start_x = <bsx> start_y = <startY> end_x = <bex> end_y = <highway_playline> left_start_x = <rsx> left_end_x = <rex> left_angle = <ra>
		SetButtonData player = <player> array = button_models color = Orange Angle = <oa> start_x = <osx> start_y = <startY> end_x = <oex> end_y = <highway_playline> left_start_x = <gsx> left_end_x = <gex> left_angle = <ga>
		SetButtonData player = <player> array = button_models color = white Angle = <pa> start_x = <psx> start_y = <startY> end_x = <pex> end_y = <highway_playline> left_start_x = <psx> left_end_x = <pex> left_angle = <pa>
		SetButtonData player = <player> array = button_up_models color = green pos_x = <gex> pos_y = <highway_playline> left_pos_x = <oex>
		SetButtonData player = <player> array = button_up_models color = red pos_x = <rex> pos_y = <highway_playline> left_pos_x = <bex>
		SetButtonData player = <player> array = button_up_models color = Yellow pos_x = <yex> pos_y = <highway_playline> left_pos_x = <yex>
		SetButtonData player = <player> array = button_up_models color = Blue pos_x = <bex> pos_y = <highway_playline> left_pos_x = <rex>
		SetButtonData player = <player> array = button_up_models color = Orange pos_x = <oex> pos_y = <highway_playline> left_pos_x = <gex>
		SetButtonData player = <player> array = button_up_models color = white pos_x = <pex> pos_y = <highway_playline> left_pos_x = <pex>
		SetButtonData player = <player> array = button_up_models color = extra pos_x = <pex1> pos_y = <highway_playline> left_pos_x = <pex2>
	endif
	fe = (<highway_playline> - (<pos_table>.highway_height))
	fs = (<fe> + (<pos_table>.highway_fade))
	change gHighwayStartFade = <fs>
	change gHighwayEndFade = <fe>
	stx = (640.0 - ((<pos_table>.highway_top_width) / 2.0))
	sbx = (640.0 - (<hbw> / 2.0))
	Atan2 x = (<pos_table>.highway_height) y = (<stx> - <sbx>)
	vec_x = (<sbx> - <stx>)
	vec_y = (<pos_table>.highway_height)
	SetArrayElement GlobalArray ArrayName = sidebar_angle index = <pos_index> newvalue = <atan>
	SetArrayElement GlobalArray ArrayName = sidebar_x index = <pos_index> newvalue = ((<sbx> + (<vec_x> * 0.25)) - (<pos_table>.sidebar_x_offset))
	SetArrayElement GlobalArray ArrayName = sidebar_y index = <pos_index> newvalue = (<highway_playline> + (<vec_y> * 0.25))
	GeneratePosTable rows = <rows> normal_rows = <normal_rows> startY = <startY> Height = <Height> heightOffsetFactor = <heightOffsetFactor> heightOffsetExp = <heightOffsetExp> pos_index = <pos_index>
	SetRowHeightTables player = (<pos_index> + 1)
endscript
