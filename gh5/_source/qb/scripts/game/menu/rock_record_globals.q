DEBUG_ROCK_RECORD = 1
rock_record_main_stats = [
	{
		text = qs("Total Score:")
		columns = [
			0
		]
		format_script = rr_use_single_column
	}
	{
		text = qs(0x9aba1ff1)
		columns = [
			1
		]
		format_script = rr_use_single_column
	}
	{
		text = qs("Total Notes:")
		columns = [
			4
		]
		format_script = rr_use_single_column
	}
	{
		text = qs("Number of Songs:")
		columns = [
			2
		]
		format_script = rr_use_single_column
	}
	{
		text = qs("Longest Note Streak:")
		columns = [
			3
		]
		format_script = rr_use_single_column
	}
	{
		text = qs(0x5edde85c)
		columns = [
			5
			6
		]
		format_script = rr_slash_divider
	}
	{
		text = qs("Total Time:")
		columns = [
			7
		]
		format_script = rr_get_time_string
	}
	{
		text = qs("Preferred Instrument:")
		columns = [
			8
			9
			10
			11
		]
		format_script = rr_get_preferred_instrument
	}
	{
		text = qs(0xdc8d0fa7)
		columns = [
			12
		]
		format_script = rr_use_single_column
	}
	{
		text = qs("Average Multiplier:")
		columns = [
			13
			14
		]
		format_script = rr_average_two_columns
	}
	{
		text = qs(0xe61e53fb)
		columns = [
			15
		]
		format_script = rr_get_time_string
	}
	{
		text = qs(0xd8aa41c1)
		columns = [
			16
		]
		format_script = rr_get_time_string
	}
	{
		text = qs("Preferred Bass Difficulty:")
		columns = [
			17
			18
			19
			20
			21
		]
		format_script = rr_get_preferred_difficulty
	}
	{
		text = qs("Preferred Guitar Difficulty:")
		columns = [
			22
			23
			24
			25
			26
		]
		format_script = rr_get_preferred_difficulty
	}
	{
		text = qs("Preferred Vocals Difficulty:")
		columns = [
			27
			28
			29
			30
			31
		]
		format_script = rr_get_preferred_difficulty
	}
	{
		text = qs("Preferred Drum Difficulty:")
		columns = [
			32
			33
			34
			35
			36
			37
		]
		format_script = rr_get_preferred_difficulty
	}
	{
		text = qs("Number of Cooperative Games:")
		columns = [
			38
		]
		format_script = rr_use_single_column
	}
	{
		text = qs(0x47e79f9e)
		columns = [
			39
		]
		format_script = rr_use_single_column
	}
]

script rr_use_single_column 

	return Stat_Value = (<data> [0])
endscript

script rr_slash_divider 

	GetArraySize <data>
	if (<array_size> >= 2)
		FormatText TextName = data_text qs("%f/%s") f = (<data> [0]) s = (<data> [1])
		return data_text = <data_text>
	endif
	return Stat_Value = (<data> [0])
endscript

script get_max_value_index 

	GetArraySize <array>
	if (<array_size> > 0)
		<max_index> = 0
		<index> = 1
		begin
		if (<array> [<index>] >= <array> [<max_index>] && <array> [<index>] > 0)
			<max_index> = <index>
		endif
		<index> = (<index> + 1)
		repeat (<array_size> - 1)
		return index = <max_index>
	endif
endscript

script rr_get_preferred_instrument 

	get_max_value_index array = <data>
	if GotParam \{index}
		switch (<index>)
			case 0
			data_text = qs("GUITAR")
			case 1
			data_text = qs("BASS")
			case 2
			data_text = qs("DRUM")
			case 3
			data_text = qs("VOCALS")
			default
			data_text = qs("NA")
		endswitch
	else
		data_text = qs("NA")
	endif
	return data_text = <data_text>
endscript

script rr_average_two_columns 

	GetArraySize <data>
	if (<array_size> >= 2)
		FormatText TextName = data_text qs("%a") a = (<data> [0] / (<data> [1] * 1.0))
		return data_text = <data_text>
	endif
	return Stat_Value = (<data> [0])
endscript

script rr_get_preferred_difficulty 

	get_max_value_index array = <data>
	if GotParam \{index}
		switch (<index>)
			case 0
			data_text = qs("BEGINNER")
			case 1
			data_text = qs("EASY")
			case 2
			data_text = qs("MEDIUM")
			case 3
			data_text = qs("HARD")
			case 4
			data_text = qs("EXPERT")
			case 5
			data_text = qs(0xa841e548)
			default
			data_text = qs("NA")
		endswitch
	else
		data_text = qs("NA")
	endif
	return data_text = <data_text>
endscript

script rr_get_time_string 

	<total_time> = (<data> [0])
	Mod a = <total_time> b = 60
	<seconds> = <Mod>
	if (<seconds> < 10)
		FormatText TextName = data_text qs("0%a") a = <seconds>
	else
		FormatText TextName = data_text qs("%a") a = <seconds>
	endif
	<total_time> = (<total_time> - <seconds>)
	if (<total_time> > 0)
		Mod a = <total_time> b = (60 * 60)
		<minutes> = <Mod>
		FormatText TextName = data_text qs("%a:%t") a = (<minutes> / 60) t = <data_text>
		<total_time> = (<total_time> - <minutes>)
		if (<total_time> > 0)
			Mod a = <total_time> b = (60 * 60 * 60)
			<hours> = <Mod>
			FormatText TextName = data_text qs("%a:%t") a = (<hours> / (60 * 60)) t = <data_text>
			<total_time> = (<total_time> - <hours>)
			if (<total_time> > 0)
				Mod a = <total_time> b = (60 * 60 * 60 * 24)
				<days> = <Mod>
				FormatText TextName = data_text qs("%a:%t") a = (<days> / (60 * 60 * 60)) t = <data_text>
			endif
		endif
	endif
	return data_text = <data_text>
endscript
