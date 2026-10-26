Drum_Idlepoint_Arm_SHit = 0.4521
Drum_Idlepoint_Arm_MHit = 0.125
Drum_Idlepoint_Foot_Hit = 0.391
Drum_Slowest_Arm_Hit = 2433.33
Drum_Medium_Arm_Hit = 533.33
Drum_Fastest_Arm_Hit = 166.66
Drummer_Offset = 0.3
longest_Transit = 3000.0
Number_drummers_Created = 4

script Drummer_ControlScript 
	Drummer_ControlScript_Init
	begin
	GetSongTimeMs time_offset = <Drummer_Offset>
	if (<time> >= -2000.0)
		break
	endif
	WaitOneGameFrame
	repeat
	WaitOneGameFrame
	begin
	Drummer_ControlScript_Cfunc
	GetFrameLength
	frame_length1 = (<frame_length> * 1000.0)
	WaitOneGameFrame
	GetFrameLength
	frame_length = ((<frame_length> * 1000.0) + <frame_length1>)
	Drummer_ControlScript_Cfunc frame_length = <frame_length>
	WaitOneGameFrame
	repeat
endscript

script Check_for_drummers 
	array = []
	num_Drummers = 0
	musician_id = musician1
	musician_info = musician1_info
	index = 0
	begin
	switch <index>
		case 0
		musician_id = Guitarist
		musician_info = guitarist_info
		case 1
		musician_id = bassist
		musician_info = bassist_info
		case 2
		musician_id = vocalist
		musician_info = vocalist_info
		case 3
		musician_id = Drummer
		musician_info = drummer_info
	endswitch
	if ($<musician_info>.part = drum)
		addchecksumarrayelement array = <array> element = <musician_id>
		num_Drummers = (<num_Drummers> + 1)
		if (<num_Drummers> >= $Number_drummers_Created)
			break
		endif
	endif
	index = (<index> + 1)
	repeat 4
	if (<num_Drummers> > 0)
		return true drummer_Ids = <array> num_Drummers = <num_Drummers>
	else
		return \{false}
	endif
endscript
