gamemode_list = [
	p1_quickplay
	p2_quickplay
	p3_quickplay
	p4_quickplay
	gh4_p1_career
	gh4_p2_career
	gh4_p3_career
	gh4_p4_career
	p2_pro_faceoff
	p4_pro_faceoff
	p8_pro_faceoff
	p6_pro_faceoff_no_mics
	tutorial
	practice
]
default_gamemode_props = {
	debug_name = qs(0x1d1be7f1)
	num_players = 1
	team_size = 1
	type = quickplay
	cooperative = false
	faceoff = false
	singleplayer = false
}
p1_quickplay_props = {
	debug_name = qs(0xf8741321)
	num_players = 1
	type = quickplay
	singleplayer = true
}
p2_quickplay_props = {
	debug_name = qs(0xc10cbe61)
	num_players = 2
	type = quickplay
	cooperative = true
}
p3_quickplay_props = {
	debug_name = qs(0xd624daa1)
	num_players = 3
	type = quickplay
	cooperative = true
}
p4_quickplay_props = {
	debug_name = qs(0xb3fde4e1)
	num_players = 4
	type = quickplay
	cooperative = true
}
gh4_p1_career_props = {
	debug_name = qs(0x54549c0f)
	num_players = 1
	type = career
	singleplayer = true
}
gh4_p2_career_props = {
	debug_name = qs(0x7d9c28fd)
	num_players = 2
	type = career
	cooperative = true
}
gh4_p3_career_props = {
	debug_name = qs(0xd3f4b96c)
	num_players = 3
	type = career
	cooperative = true
}
gh4_p4_career_props = {
	debug_name = qs(0x2e0d4119)
	num_players = 4
	type = career
	cooperative = true
}
p2_pro_faceoff_props = {
	debug_name = qs(0x0fc5176c)
	num_players = 2
	type = pro_faceoff
	faceoff = true
}
p4_pro_faceoff_props = {
	debug_name = qs(0x301bcadd)
	num_players = 4
	team_size = 2
	type = pro_faceoff
	faceoff = true
}
p6_pro_faceoff_no_mics_props = {
	num_players = 6
	team_size = 3
	type = pro_faceoff
	faceoff = true
}
p8_pro_faceoff_props = {
	debug_name = qs(0x4fa671bf)
	num_players = 8
	team_size = 4
	type = pro_faceoff
	faceoff = true
}
tutorial_props = {
	debug_name = qs(0xb931e0b2)
	num_players = 4
	type = tutorial
	singleplayer = false
	cooperative = false
}
practice_props = {
	num_players = 1
	type = practice
	singleplayer = false
}
