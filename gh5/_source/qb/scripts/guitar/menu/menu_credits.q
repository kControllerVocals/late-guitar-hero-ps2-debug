credits_menu_font = fontgrid_text_a1
credits_menu_scroll = horizontal

script ui_create_end_credits 

	spawnscriptnow ui_create_end_credits_spawned params = {<...>}
endscript

script ui_create_end_credits_spawned 
	kill_gem_scroller
	Progression_EndCredits
endscript

script ui_destroy_end_credits 
	progression_set_credits_complete
endscript

script create_credits_menu 
	if ($shutdown_game_for_signin_change_flag = 1)
		return
	endif
	if NOT ($end_credits = 1)
		disable_pause
		create_loading_screen
		destroy_band
		unload_songqpak
		destroy_loading_screen
		SpawnScript \{menu_music_on}
	endif
	PushAssetContext \{context = Z_Subway}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = credits_backdrop_container
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	TileSprite \{parent = credits_backdrop_container
		texture = credits_bg
		tile_dims = (2560.0, 720.0)
		dims = (1280.0, 720.0)
		pos = (-1280.0, 0.0)}
	PopAssetContext
	RunScriptOnScreenElement TileSpriteLoop id = <id> params = {move_x = 5 move_y = 0}
	if NOT ($end_credits = 1)
		if NOT GotParam \{end_credits}
			event_handlers = [
				{pad_back end_credits_button params = <...>}
			]
			new_menu scrollid = mc_scroll vmenuid = current_menu event_handlers = <event_handlers>
			add_user_control_helper \{text = qs("BACK")
				button = red
				z = 1001}
		else
			event_handlers = [
				{pad_choose end_credits_button params = <...>}
			]
			new_menu scrollid = mc_scroll vmenuid = current_menu event_handlers = <event_handlers>
			add_user_control_helper \{text = qs("CONTINUE")
				button = green
				z = 1001}
		endif
	else
		new_menu \{scrollid = mc_scroll
			vmenuid = current_menu}
	endif
	RunScriptOnScreenElement id = credits_backdrop_container scrolling_list_begin_credits params = <...>
	LaunchEvent \{target = current_menu
		type = focus}
endscript

script end_credits_button 
	if ScreenElementExists \{id = current_menu}
		current_menu :SE_SetProps \{block_events}
	endif
	destroy_credits_menu
	if NOT GotParam \{end_credits}
		generic_event_back
	else
		progression_set_credits_complete
		ui_win_song_career_continue
	endif
endscript

script destroy_credits_menu 
	if ($shutdown_game_for_signin_change_flag = 1)
		KillSpawnedScript \{name = create_credits_menu}
		if ScreenElementExists \{id = credits_list_container}
			DestroyScreenElement \{id = credits_list_container}
		endif
		KillSpawnedScript \{name = scrolling_list_begin_credits}
	endif
	clean_up_user_control_helpers
	KillSpawnedScript \{name = TileSpriteLoop}
	if ScreenElementExists \{id = credits_backdrop_container}
		DestroyScreenElement \{id = credits_backdrop_container}
	endif
	if ScreenElementExists \{id = mc_scroll}
		DestroyScreenElement \{id = mc_scroll}
	endif
endscript

script scrolling_list_begin_credits 
	if ($end_credits = 1)
		Wait \{2
			seconds}
		CreateScreenElement \{type = ContainerElement
			parent = root_window
			id = credits_backdrop_container
			pos = (0.0, 0.0)
			just = [
				left
				top
			]}
	endif
	scrolling_list_init_credits
	scrolling_list_add_item <...>
endscript

script scrolling_list_add_item \{i = 0}
	if (<i> = 0)
		if NOT ($end_credits = 1)
			<i> = 6
		endif
	endif
	GetArraySize ($credits)
	if (<i> = <array_size>)

		Wait <time> seconds
		if ScreenElementExists \{id = credits_list_container}
			DestroyScreenElement \{id = credits_list_container}
		endif
		if NOT ($end_credits = 1)
			end_credits_button <...> soundcheck
		endif
		return
	endif
	if StructureContains Structure = ($credits [<i>]) item
		text = (($credits [<i>]).item)
	else
		text = qs(" ")
	endif
	if StructureContains Structure = ($credits [<i>]) heading
		scale = <scale_head>
		color = <color_head>
		color_shadow = [20 10 5 90]
		shadow_offs = (3.0, 3.0)
	else
		scale = <scale_body>
		color = <color_body>
		color_shadow = [0 0 0 255]
		shadow_offs = (3.0, 3.0)
	endif
	if StructureContains Structure = ($credits [<i>]) title
		scale = <scale_title>
		color = <color_title>
		color_shadow = [20 10 5 90]
		shadow_offs = (3.0, 3.0)
	endif
	if StructureContains Structure = ($credits [<i>]) small
		scale = 0.5
		color = <color_body>
		color_shadow = [0 0 0 255]
		shadow_offs = (1.0, 1.0)
	endif
	FormatText checksumname = item_id 'item_%n' n = <i>
	if ScreenElementExists id = <item_id>
		DestroyScreenElement id = <item_id>
	endif
	if ($credits_menu_scroll = vertical)
		<fit_width> = `scale each line if larger`
		<fit_height> = `expand dims`
	else
		<fit_width> = `expand dims`
		<fit_height> = `scale down if larger`
	endif
	CreateScreenElement {
		type = TextBlockElement
		id = <item_id>
		parent = credits_list_container
		font = fontgrid_title_a1
		dims = <our_dims>
		fit_width = <fit_width>
		fit_height = <fit_height>
		font_spacing = 1
		pos = (0.0, 0.0)
		internal_scale = <scale>
		text = <text>
		just = <just>
		internal_just = <just>
		rgba = <color>
		alpha = 1
		shadow
		shadow_offs = <shadow_offs>
		shadow_rgba = <color_shadow>
		z_priority = <z_priority_credits>
	}
	GetScreenElementDims id = <item_id>
	if ($credits_menu_scroll = vertical)
		<item_height> = (<Height> + <spacer>)
		<item_pos> = (<base_pos> + (<item_height> * (0.0, 1.0)))
	else
		<item_width> = (<width> + <spacer>)
		if GotParam \{prev_dim_x}
			<item_pos> = (<base_pos> + ((<prev_dim_x> + <spacer>) * (1.0, 0.0)))
		else
			<item_pos> = (<base_pos> + (<item_width> * (1.0, 0.0)))
		endif
	endif
	<item_id> :SE_SetProps pos = <item_pos>
	if ($credits_menu_scroll = vertical)
		<distance> = (<screen_height> + ((<item_pos>.(0.0, 1.0)) - <screen_height>))
	else
		<distance> = (<screen_width> + ((<item_pos>.(1.0, 0.0)) - <screen_width> + <width>))
	endif
	<time> = (<distance> / <rate>)
	if ScreenElementExists id = <item_id>
		RunScriptOnScreenElement id = <item_id> scrolling_list_move_item params = {<...>}
	endif
endscript

script scrolling_list_move_item 
	RunScriptOnScreenElement id = credits_backdrop_container scrolling_list_queue_next_item params = {<...>}
	if ($credits_menu_scroll = vertical)
		<target_pos> = (<item_pos> - ((0.0, 1.0) * <distance>))
	else
		<target_pos> = (<item_pos> - ((1.0, 0.0) * <distance>))
	endif
	SE_SetProps time = <time> pos = <target_pos>
	SE_WaitProps
	if ScreenElementExists id = <item_id>
		DestroyScreenElement id = <item_id>
	endif
endscript

script scrolling_list_queue_next_item 
	begin
	if ScreenElementExists id = <item_id>
		GetScreenElementProps id = <item_id>
	endif
	if ($credits_menu_scroll = vertical)
		pos_y = (<pos>.(0.0, 1.0))
		if (<pos_y> < <screen_height>)
			<i> = (<i> + 1)
			scrolling_list_add_item <...>
			return
		endif
	else
		pos_x = (<pos>.(1.0, 0.0))
		if (<pos_x> < <screen_width>)
			<i> = (<i> + 1)
			<prev_dim_x> = (<dims>.(1.0, 0.0))
			scrolling_list_add_item <...>
			return
		endif
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script scrolling_list_init_credits 
	if ($end_credits = 1)
		z_priority_credits = 100
	else
		z_priority_credits = 1000
	endif
	if ($end_credits = 1)
		<rate> = 425.0
		<screen_height> = 280.0
		<scale_head> = 0.9
		<color_head> = [180 165 120 255]
		<scale_body> = 0.65000004
		<color_body> = [180 200 200 255]
		<scale_title> = 0.65000004
		<color_title> = [180 165 120 255]
	else
		<rate> = 380.0
		<screen_height> = 690
		<scale_head> = 0.75
		<color_head> = [180 165 120 255]
		<scale_body> = 0.65000004
		<color_body> = [180 200 200 255]
		<scale_title> = 0.65000004
		<color_title> = [180 165 120 255]
	endif
	<screen_width> = 1280
	if ($credits_menu_scroll = vertical)
		<just> = [center bottom]
		<base_pos> = ((640.0, 0.0) + ((0.0, 1.0) * <screen_height>))
		<column_width> = 450
		<our_dims> = (<column_width> * (1.0, 0.0))
		<spacer> = 5
	else
		<just> = [left center]
		<base_pos> = ((0.0, 320.0) + ((1.0, 0.0) * <screen_width>))
		<column_height> = 180
		<our_dims> = ((<column_height> * (0.0, 1.0)) + (70.0, 0.0))
		<spacer> = 15
	endif
	if ScreenElementExists \{id = credits_list_container}
		DestroyScreenElement \{id = credits_list_container}
	endif
	CreateScreenElement \{type = ContainerElement
		parent = credits_backdrop_container
		id = credits_list_container
		pos = (0.0, 0.0)}
	return <...>
endscript
credits = [
	{
		title
		item = qs("You've unlocked")
	}
	{
		heading
		item = qs(0xda1fdbbc)
	}
	{
		emptyspace
	}
	{
		emptyspace
	}
	{
		emptyspace
	}
	{
		emptyspace
	}
	{
		heading
		item = qs(0xa46dc961)
	}
	{
		item = qs(0x5466c4e1)
	}
	{
		item = qs(0x66c6e698)
	}
	{
		item = qs(0xca1583f2)
	}
	{
		item = qs(0x736bc434)
	}
	{
		item = qs(0xe586429b)
	}
	{
		item = qs(0x2d9befe1)
	}
	{
		item = qs(0xfe8fa289)
	}
	{
		item = qs(0x2f44456d)
	}
	{
		item = qs(0x0aad5d59)
	}
	{
		item = qs(0x1c863057)
	}
	{
		item = qs(0x69e4d1dc)
	}
	{
		item = qs(0x32d188c4)
	}
	{
		item = qs(0x3b953bad)
	}
	{
		item = qs(0x41fb46d2)
	}
	{
		item = qs(0x35cc2d98)
	}
	{
		item = qs(0x69a72291)
	}
	{
		item = qs(0xff5f200e)
	}
	{
		item = qs(0x43478a2e)
	}
	{
		emptyspace
	}
	{
		emptyspace
	}
	{
		heading
		item = qs("\LSpecial Thanks To")
	}
	{
		item = qs(0xa5f60a35)
	}
	{
		item = qs(0x3ae18198)
	}
	{
		item = qs(0xeff5ffa4)
	}
	{
		item = qs(0xb645a734)
	}
	{
		item = qs(0xaee4ffbb)
	}
	{
		item = qs(0xb56d1ae7)
	}
	{
		item = qs(0x82fc1b4c)
	}
	{
		item = qs(0xc9205392)
	}
	{
		item = qs(0xf9bc4d00)
	}
	{
		item = qs(0xcca21076)
	}
	{
		item = qs(0xc4d28a8b)
	}
	{
		item = qs(0xf664cc4d)
	}
	{
		item = qs(0x9fd3b82b)
	}
	{
		item = qs(0xf1f85cc9)
	}
	{
		item = qs(0x3a744fd8)
	}
	{
		item = qs(0xae3d1a72)
	}
	{
		item = qs(0xc3a7b28c)
	}
	{
		emptyspace
	}
	{
		emptyspace
	}
	{
		emptyspace
	}
	{
		emptyspace
	}
	{
		heading
		item = qs("\LDesigned\nand Developed\nby Neversoft")
	}
	{
		item = qs("\LAaron Williams\nAdam Micciulla\nAdam Tsui\nAlan Flores")
	}
	{
		item = qs("\LAllen Freese\nAndy Gentile\nAndy Lee\nAndy Marchal")
	}
	{
		item = qs("\LAndy Warwick\nAnet Hambarsumian\nAnthony Campos\nAnthony Carotenuto")
	}
	{
		item = qs("\LAnthony Saunders\nBen Kutcher\nBernie Corrigan\nBill Buckley")
	}
	{
		item = qs("\LBrad Bulkley\nBrandon Riggs\nBrendan Wiuff\nBrian Bright")
	}
	{
		item = qs("\LBrian Effinger\nBrian Marvin\nBrian Oles\nByeong Gyu Park")
	}
	{
		item = qs("\LChad Findley\nChad Sundman\nChris Barnes\nChris Boltz")
	}
	{
		item = qs("\LChris Myers\nChris Parise\nChris Self\nChris Ward")
	}
	{
		item = qs("\LChristopher George\nChristopher Vance\nClark Wen\nClaudia Franco")
	}
	{
		item = qs("\LClive Burdon\nCody Pierson\nColin Crenshaw\nCorey Teblum")
	}
	{
		item = qs("\LDallas Holloway\nDan Hong\nDan Savage\nDana De Lalla")
	}
	{
		item = qs("\LDaniel Nelson\nDaryl Kimoto\nDave Cowling\nDave Rowe")
	}
	{
		item = qs("\LDavid ''Shinji'' Furuya\nDavid Hernandez\nDavid Hind\nDavid Nilsen")
	}
	{
		item = qs("\LDavid Rose\nDavid Schorn\nDavid Stowater\ndavidicus")
	}
	{
		item = qs("\LDominic Liberati\nDongWoo Thomas Shin\nDonovan Keele\nEric Feldman")
	}
	{
		item = qs("\LEric Milota\nFrancisco Mora\nGarett Jost\nGary Jesdanun")
	}
	{
		item = qs("\LGavin Pugh\nGenna Habibipour\nGeoffrey Inkel\nGiancarlo Surla")
	}
	{
		item = qs("\LGideon Stocek\nGreg Lopez\nGregory Kopina\nHari Khalsa")
	}
	{
		item = qs("\LIfedayo Ojomo\nIli Chiang\nJake Geiger\nJason Greenberg")
	}
	{
		item = qs("\LJason Maynard\nJason Uyeda\nJeff Swenty\nJeremiah Roa")
	}
	{
		item = qs("\LJeremy Page\nJeremy Rogers\nJessica Abroms\nJiwon Son")
	}
	{
		item = qs("\LJody Coglianese\nJoe Pease\nJoe Kirchoff\nJoel Jewett")
	}
	{
		item = qs("\LJohn ''Bunny'' Knutson\nJohn Sahas\nJohn Webb\nJohn Zagorski")
	}
	{
		item = qs("\LJohnny Ow\nJon Bailey\nJordan Leckner\nJordan Sapp")
	}
	{
		item = qs("\LJosh Lord\nJun Hyuck Chang\nJustin Parish\nJustin Rote")
	}
	{
		item = qs("\LKarl Drown\nKen Moodie\nKendall Harrison\nKevin Chung")
	}
	{
		item = qs("\LKevin Mulhall\nKristin Gallagher\nKristina Adelmeyer\nKyle Johnson")
	}
	{
		item = qs("\LKyle Leonard\nKyle McKisic\nLars Kendall\nLe'Vere ''Lee'' Ross")
	}
	{
		item = qs("\LLisa Davies-Perissi\nLisa Perez\nLucy Andonian\nMarc DePeo")
	}
	{
		item = qs("\LMario Sanchez\nMark L. Scott\nMark Storie\nMark Wojtowicz")
	}
	{
		item = qs("\LMatt Canale\nMatthew Jackowski\nMax Davidian\nMichael Bilodeau")
	}
	{
		item = qs("\LMichael Esposito\nMichael Friedrich\nMike Velasquez\nMichael Winte")
	}
	{
		item = qs("\LNathan Sisler\nNicholas E. Weaver\nNolan Nelson\nOlin Georgescu")
	}
	{
		item = qs("\LOrion Brown\nPam Detrich\nPat Connole\nPatrick Hagar")
	}
	{
		item = qs("\LPaul Interrante\nPaul Robinson\nPeter Day\nPeter Pon")
	}
	{
		item = qs("\LRandy Guillote\nRandy Mills\nRH Shih\nRiley Jewett")
	}
	{
		item = qs("\LRob T. Miller\nRobert Espinoza\nRock Gropper\nRulon Raymond")
	}
	{
		item = qs("\LRyan Magid\nRyan Palser\nSam Ware\nScott Pease")
	}
	{
		item = qs("\LSean Watson\nSebastien St. Laurent\nSergio Gil\nShane Calnan")
	}
	{
		item = qs("\LSimon Ebejer\nSimon Ko\nSivarak ''Kai'' Tawarotip\nSkye Kang")
	}
	{
		item = qs("\LStephanie Bayer\nStuart Scandrett\nTakashi Matsubara\nThai Tran")
	}
	{
		item = qs("\LThomas Gawrys\nThomas Owen\nTim Rapp\nTim Stasica")
	}
	{
		item = qs("\LTina Stevenson\nTom Parker\nTony Solis\nTravis Chen")
	}
	{
		item = qs("\LWilson Truong\nZac Drake\nZach Parr\n")
	}
	{
		heading
		item = qs(0x44722efb)
	}
	{
		item = qs("\LAaron Habibipour\nAnthony Pesch\nBeth Cowling\nCameron Davis\nCharles Babb")
	}
	{
		item = qs("\LJacob Karesh\nJeff Morgan\nRyan Ligon\nWeichen Wu\n")
	}
	{
		heading
		item = qs(0x88e4482f)
	}
	{
		item = qs("\LAdam Azami\nAdam Nelson\nAdry Walsh\nAndrew Colen\nBrandyn Betton")
	}
	{
		item = qs("\LAuston Jones\nBenjamin O'Brien\nBradley Lusenhop\nBret Dubin\nClint Baptiste")
	}
	{
		item = qs("\LCurt Markwardt\nCurtis Pickrell\nDaniel Farina\nDavid Cramer\nDavid Delanty")
	}
	{
		item = qs("\LDavid Hyatt\nDuncan Brown\nEric Kiraly\nGareth Davies\nGarry Dervishian")
	}
	{
		item = qs("\LGreg Spohn\nHelmo Cardenas\nJacob Wilson\nJames Chen\nJames Gobert")
	}
	{
		item = qs("\LJamison Dyke\nJarrett Loar\nJavier Feliz\nJeff Brys\nJeff Jaimes")
	}
	{
		item = qs("\LJefferson Kittell\nJeffrey Stanley\nJennifer Fusco\nJimmy Nguyen\nJonathan Green")
	}
	{
		item = qs("\LJorge Aguayo\nJoseph Arco\nJoseph Perez\nJoshua Dodge\nJoshua Hebenstreit")
	}
	{
		item = qs("\LJoshua Lewis\nKami Talebi\nKen Ellis\nKevin Colwell\nKhalin Mikkelsen")
	}
	{
		item = qs("\LKieron McKay\nKimberly Lansang\nLee Ware\nLeroy Patterson\nMatthew Bravos")
	}
	{
		item = qs("\LMatthew Cutting\nMathew Edwards\nMatthew Jones\nMichael Flores\nMoshe Chen")
	}
	{
		item = qs("\LNeil Cortez\nPeter Muravez\nRion Jones\nRobert Byrd\nRobert Keating")
	}
	{
		item = qs("\LRon Williams\nRonnie Stafford\nRyan Clouse\nRyan Roderick\nSergio Pacheco")
	}
	{
		item = qs("\LShasta Rodriguez\nStephan Brezinsky\nSteve Flack\nTiffani Burkett\nTim Flanagan")
	}
	{
		item = qs("\LTommy Coello\nTravis Ramon\nTristan Clark\nWesley Cook\nJames Rawlins")
	}
	{
		item = qs("\LTiron Quals\n\n\n\n")
	}
	{
		heading
		item = qs(0x5fd190d9)
	}
	{
		item = qs("\LThe Team at AgoraGames\nSteve Ouimette\nJason Kocol\n")
	}
	{
		item = qs("\L\c5GL33k\n\c0Matt Piersall\nMarc Schafgen\nRandy Buck")
	}
	{
		item = qs("\L\c5Technicolor\n\c0Lydian Tone\nTom Hays\nAnthony Sorise")
	}
	{
		heading
		item = qs(0x54b18d8b)
	}
	{
		item = qs("\LAdam Jennings\nAmanda Marsh\nAlex Rodriquez\nDallas Halloway")
	}
	{
		item = qs("\LDeborah Venegas\nJason Kakebeen\nKyle Johnson\nPatrick McLaughlin")
	}
	{
		item = qs("\LTerry Lee Goffe\nRandy Van Stone\nPFC Kurt Gibson\nStevie Peavey")
	}
	{
		item = qs("\LJ.D. Atkins\nJerry Ramoan\nLes Mohr\nHawk")
	}
	{
		item = qs("\LMercedes Lander\nMorgan Lander\nTara McLeod\nIvy Vujic")
	}
	{
		heading
		item = qs(0x72c4f2f5)
	}
	{
		item = qs("\L\c5Voice\nActor\n\c0Peter Lurie\n")
	}
	{
		item = qs("\L\c5Voice Casting:\n\c0PCB Productions\n\c5Talent Coordination:\n\c0Keith Arem")
	}
	{
		heading
		item = qs("\LPartners:")
	}
	{
		heading
		item = qs(0xbcfbe1d1)
	}
	{
		item = qs("\L©2009 The Coca-Cola Company.\n''Coca-Cola'' and the\nContour Bottle Design,\nare registered trademarks\nof The Coca-Cola Company.")
	}
	{
		heading
		item = qs(0x6c89e64a)
	}
	{
		heading
		item = qs(0x203330ca)
	}
	{
		item = qs("\L''AHEAD is\na registered\ntrademark of\nAHEAD\nPRODUCTS INC.")
	}
	{
		heading
		item = qs(0x54eb85ee)
	}
	{
		item = qs("\L''Ampeg'', ''SVT''\nand the Ampeg Logo\nare registered\ntrademarks of\nLOUD, Technologies, Inc.")
	}
	{
		heading
		item = qs(0x2cea23a7)
	}
	{
		item = qs("\L©2008 Audio-Technica U.S., Inc.,\nthe Audio-Technica name and logo\nare trademarks of\nAudio-Technica U.S., Inc.\nAll Rights Reserved.")
	}
	{
		heading
		item = qs(0x1532dba5)
	}
	{
		item = qs("\LCONVERSE and\nALL STAR are\nregistered\ntrademarks of\nConverse Inc.")
	}
	{
		heading
		item = qs(0xa64a9f64)
	}
	{
		item = qs("\LDAISY ROCK and Daisy,\nHeartbreaker, Star, Tomboy and\nSiren series guitars, and the distinctive\nheadstock designs used herein, are trademarks\nof DAISY ROCK. All rights reserved.")
	}
	{
		heading
		item = qs(0x97c5e8d7)
	}
	{
		item = qs("\LThe Dr. Martens AirWair logo,\nDr. Martens, Doc's, DM's, Doc Martens\nand the ''Dr. Martens Air Cushion Sole''\nlogo are trademarks\nused under license.")
	}
	{
		item = qs("\LAirWair, ''Airware with Bouncing\nSoles'' and the 1460 boot\nlogo are trademarks of the\nR Griggs Group Ltd. and its\nsubsidiaries. All rights reserved")
	}
	{
		heading
		item = qs(0xc927a81f)
	}
	{
		item = qs("\LEMG\nis a\nregistered\ntrademark\nof EMG Inc.")
	}
	{
		heading
		item = qs(0x1063e816)
	}
	{
		item = qs("\LErnie Ball\nis a registered\ntrademark\nof Ernie\nBall Inc.")
	}
	{
		heading
		item = qs("\L\c5ESP &\nLTD\nbrands")
	}
	{
		item = qs("\LESP & LTD brands,\nmodel names and\nbody & headstock shapes are\nregistered trademarks of\nthe ESP Guitar Co. Inc.")
	}
	{
		heading
		item = qs(0x19c44938)
	}
	{
		item = qs("\LGuitar Center® and\nthe Guitar Center® logo\nare registered trademarks of\nGuitar Center, Inc. and are\nused by permission, all rights reserved")
	}
	{
		heading
		item = qs(0x556c2f93)
	}
	{
		item = qs("\LKrank Amplification is\na registered\ntrademark of\nKrank Amplification\nL.L.C.")
	}
	{
		heading
		item = qs(0xf643006c)
	}
	{
		item = qs("\LMACKIE loudspeakers,\nmixers and\nguitar amps make\nGuitar Heroes out of anyone:\nwww.mackie.com.")
	}
	{
		heading
		item = qs(0xd6ef8ad3)
	}
	{
		item = qs("\LMarshall and\nthe Marshall logo\nare trademarks or\nregistered trademarks\nof Marshall Amplification plc.")
	}
	{
		heading
		item = qs(0x70fe18f3)
	}
	{
		item = qs("\LMcSwain is a registered trademark\nof McSwain Guitars, Inc.\nThe Flame, Metal Inferno,\nThe Jonesy, The Machine, Life,\nand The Gunnar Bass are all")
	}
	{
		item = qs("\Lregistered with the\nUS Copyright Office.\nMcSwain Guitars would like to give a shout\nout to all my esteemed homies\nback in Gastonia, NC")
	}
	{
		heading
		item = qs(0xb4324cbf)
	}
	{
		item = qs("\LPork Pie\nis a registered\ntrademark of\nPork Pie\nPercussion Incorporated.")
	}
	{
		heading
		item = qs(0xf39d1ad5)
	}
	{
		item = qs("\LPaul Reed Smith, ''PRS,'' the PRS logo,\nthe PRS Paul Reed Smith logo,\nthe Paul Reed Smith signature,\nthe bird inlays, the headstock bird,\nthe PRS headstock shape,")
	}
	{
		item = qs("\Lthe Santana headstock shape,\nthe PRS body shape, the PRS\n''scoop'' design and ''Singlecut''\nare all registered trademarks of\nPaul Reed Smith Guitars.")
	}
	{
		item = qs("\L''Custom 24'' and ''SC 245''\nare both trademarks of Paul Reed Smith Guitars.\nThe Birds and New Birds are\ncopyrighted by PRS Guitars.\nArt Direction by Marc Quigley.")
	}
	{
		heading
		item = qs(0xbf50769d)
	}
	{
		item = qs("\LRegal Tip\nis a\nregistered\ntrademark\n")
	}
	{
		heading
		item = qs(0x2bfacf63)
	}
	{
		item = qs("\LSchecter Guitar Research, Diamond Series\nand the distinctive headstock design\nused herein nare trademarks of\nSchecter Guitar Research, Inc.\nAll rights reserved.")
	}
	{
		heading
		item = qs(0xb82fc5a2)
	}
	{
		item = qs("\LSeymour Duncan, Blackouts,\nAntiquity, JB, '59, P-Rails\nand the stylized ''S'' logo are trademarks of\nSeymour Duncan and are used with permission.\nAll rights reserved.")
	}
	{
		heading
		item = qs(0xd519ad02)
	}
	{
		item = qs(0x8a6359fc)
	}
	{
		heading
		item = qs(0xca8d617d)
	}
	{
		item = qs("\L© 2009 Vans, Inc.\nAll Rights Reserved.\nVANS, the Vans logos, designs\nand model names herein\nare trademarks of Vans, Inc")
	}
	{
		heading
		item = qs("\L\c5Zildjian")
	}
	{
		item = qs("\LZildjian,\nand the stylized\nZildjian logo are registered\ntrademarks of the\nAvedis Zildjian Company")
	}
	{
		heading
		item = qs(0x9b63cff8)
	}
	{
		item = qs("\L\c5Producer\n\c0Kragen Lum\n\n")
	}
	{
		item = qs("\L\c5Associate\nProducer\n\c0Andrew Hoffacker\n")
	}
	{
		item = qs("\L\c5Senior\nProducer\n\c0Jeremiah Maza\n")
	}
	{
		item = qs("\L\c5Executive\nProducer\n\c0Jeff Matsushita\n")
	}
	{
		item = qs("\L\c5Vice\nPresident\nProduction\n\c0Keith Kirby")
	}
	{
		item = qs("\L\c5Sr. Vice\nPresident\nProduction\n\c0Laird Malamed")
	}
	{
		item = qs("\L\c5Additional\nProduction Support\n\c0Aaron Drayer\nChuck Park")
	}
	{
		item = qs("\L\c0Eric Grossman\nWill Townsend\nJohn C. Boone II\nAlex Ortiz")
	}
	{
		item = qs("\L\c0Lorena Villa\nDoug Grutzmacher\nJared Yeager\nJunko Nakamura")
	}
	{
		item = qs("\L\c0Jim Norris\nPeter Kavic\nBilly Kaplan\n")
	}
	{
		heading
		item = qs("\LRedOctane:")
	}
	{
		item = qs("\L\c5Sr. Vice\nPresident\nPublishing\n\c0Will Kassoy")
	}
	{
		item = qs("\L\c5Vice President\nGlobal Brand\nManagement\n\c0Kim Salzer")
	}
	{
		item = qs("\L\c5Sr. Director\nGlobal Brand\nManagement\n\c0Tom Silk")
	}
	{
		item = qs("\L\c5Director\nGlobal Brand\nManagement\n\c0Amy Longhi")
	}
	{
		item = qs("\L\c5Director\nFranchise\nDevelopment\n\c0Ryan Wener")
	}
	{
		item = qs("\L\c5Sr. Global\nBrand\nManager\n\c0Doug McCracken")
	}
	{
		item = qs("\L\c5Global Brand Managers\n\c0Michael Steiner (Lead)\nKristin Pagano\nJanice Loughman")
	}
	{
		item = qs("\L\c5Associate Brand Managers\n\c0Brandon Zien (Lead)\nMatthew Cox\nEvelyn Mendez")
	}
	{
		item = qs(0xd92799fc)
	}
	{
		item = qs("\L\c5Marketing\nAssociate\n\c0Jesse Wan\n")
	}
	{
		item = qs("\L\c5Team\nAssistant\n\c0Catherin Mangan\n")
	}
	{
		heading
		item = qs("\LPR:")
	}
	{
		item = qs("\L\c5Vice President\nPR\n\c0Eric Hollreiser\n")
	}
	{
		item = qs("\L\c5PR\nDirector\n\c0Ryh-Ming C. Poon\n")
	}
	{
		item = qs("\L\c5PR\nManager\n\c0Natalie Salzman DaRosa\n")
	}
	{
		item = qs("\L\c5Senior\nPublicist\n\c0Sean Maggard\n")
	}
	{
		item = qs("\L\c5Junior\nPublicist\n\c0Karen Fujimoto\n")
	}
	{
		item = qs("\L\c5PR\nCoordinator\n\c0Andrew Meyer\n")
	}
	{
		item = qs("\L\c5Global\nAsset\nManager\n\c0Karen Yi")
	}
	{
		heading
		item = qs(0xe427df17)
	}
	{
		item = qs("\L\c5VP,\nBrand\nActivation\n\c0Stacey Hirata")
	}
	{
		item = qs("\L\c5Director\nDigital\nDistribution\n\c0Jon Estanislao")
	}
	{
		item = qs("\L\c5Brand\nActivation\nManager\n\c0Emily Uyehara-Kunkel")
	}
	{
		item = qs("\L\c5Associate\nBrand Activation\nManager\n\c0Matthew Allen")
	}
	{
		item = qs("\L\c5Brand\nActivation\nAssociate\n\c0Megan Ferguson")
	}
	{
		item = qs("\L\c5Brand\nActivation\nAssistant\n\c0Kyle Rechsteiner")
	}
	{
		heading
		item = qs(0x89b1aa8d)
	}
	{
		item = qs("\L\c5Creative\nServices\nManager\n\c0Mike Doan")
	}
	{
		item = qs("\L\c5Web\nDesigner\n\c0Jennifer Nakamura\n")
	}
	{
		item = qs("\L\c5Graphic\nDesigners\n\c0Maly Bun\nMinna Hu")
	}
	{
		item = qs(0xa4a0ad11)
	}
	{
		heading
		item = qs("\LRedOctane:")
	}
	{
		item = qs("\L\c5Founder\n\c0Kai Huang\n\n")
	}
	{
		item = qs("\L\c5Founder/VP\nBusiness\nDevelopment\n\c0Charles Huang")
	}
	{
		item = qs("\L\c5President\nCEO\n\c0Dan Rosenweig\n")
	}
	{
		item = qs("\L\c5Executive\nAssistant\n\c0Trina Deakin\n")
	}
	{
		item = qs("\L\c5Executive\nAssistant\n\c0Heather Porter\n")
	}
	{
		item = qs("\L\c5Licensing\nAssociate\n\c0Chris Larkin\n")
	}
	{
		item = qs("\L\c5Sr. Vice\nPresident\nFinance\n\c0Brian Kesterson")
	}
	{
		item = qs("\L\c5Controller\n\c0Monika Agarwal\n\n")
	}
	{
		item = qs("\L\c5Sr. Financial\nAnalysts\n\c0Kevin Lurie\nLu Truong")
	}
	{
		item = qs("\L\c5Sr.\nAccountant\n\c0Tina Xu\n")
	}
	{
		heading
		item = qs("\LHardware:")
	}
	{
		item = qs("\L\c5VP Hardware\n\c0Lee Guinchard\n\n")
	}
	{
		item = qs("\L\c5Executive\nProducer\nHardware\n\c0Steve Withers")
	}
	{
		item = qs("\L\c5Electronics\nEngineering\nDirector\n\c0Duncan Miller")
	}
	{
		item = qs("\L\c5Director\nof\nHardware\n\c0Carter Lee")
	}
	{
		item = qs("\L\c5Hardware\nProgram\nDirector\n\c0David Dykes")
	}
	{
		item = qs("\L\c5Principal\nElectronics\nEngineer\n\c0Tim Clark")
	}
	{
		item = qs("\L\c5Electronics\nEngineer\n\c0Bashir Ziady\n")
	}
	{
		item = qs("\L\c5Production\nEngineering\nManager\n\c0Jared Chan")
	}
	{
		item = qs("\L\c5Product\nDesigner\n\c0Cody Lee\n")
	}
	{
		item = qs("\L\c5Senior\nProducer\n\c0Cendru Engstrom\n")
	}
	{
		item = qs("\L\c5Producer\n\c0Ted Lange\n\n")
	}
	{
		item = qs("\L\c5Hardware\nProduct\nCoordinators\n\c0Chris Foulger")
	}
	{
		item = qs(0x14cf7ea5)
	}
	{
		heading
		item = qs("\LE-Commerce:")
	}
	{
		item = qs("\L\c5Sr.\nE-Commerce\nManager\n\c0Michael Pan")
	}
	{
		item = qs("\L\c5Online\nMarketing\nSpecialist\n\c0David Hsu")
	}
	{
		item = qs("\L\c5E-Commerce\nAssistant\n\c0Hana Sakamoto\n")
	}
	{
		item = qs("\L\c5Customer\nService\nManager\n\c0Joe Mijares")
	}
	{
		item = qs("\L\c5Customer\nSupport\nTeam\n\c0Mike Dangerfield")
	}
	{
		item = qs("\L\c0Ashley Deakin\nMarshannon Powell\nMealnie Porzio\n")
	}
	{
		item = qs("\L\c5Webmaster\n\c0Suky Wong\n\n")
	}
	{
		item = qs("\L\c5The rest at\nRedOctane,\nspecifically\n\c0John Devecka")
	}
	{
		item = qs(0xb751c976)
	}
	{
		heading
		item = qs("\LRedOctane\nwould\nlike to\nthank:")
	}
	{
		item = qs("\L\c0Lillian Qian\nKaylan Huang\nCharley Huang\nSimon Huang\nLily Huang")
	}
	{
		item = qs("\L\c0Ethan Huang\nSamantha Chien\nSkye Lang\nDream lange\nDorothy Yang")
	}
	{
		item = qs("\L\c0The San Jose Sharks\nThe Juco Family\nMB&GB:Da Bears\nThe Larkin Family\nFreddie Arnott")
	}
	{
		item = qs("\L\c0Grey Hawke\nHunter Watson\nMatthew Salutillo\nRedOctane India Crew\nDennis Goh")
	}
	{
		item = qs(0x8165b07d)
	}
	{
		heading
		item = qs(0x55fefa6c)
	}
	{
		item = qs("\L\c5Vice President,\nMusic\nAffairs\n\c0Tim Riley")
	}
	{
		item = qs("\L\c5Sr. Manager,\nMusic\nAffairs\n\c0Brandon Young")
	}
	{
		item = qs(0xb0a5fae5)
	}
	{
		item = qs(0xeefd4428)
	}
	{
		item = qs("\L\c5Music and\nLicensing Specialists\n\c0Jeremy Volk\nMike Phegley")
	}
	{
		item = qs("\L\c5Music\nCoordinators\n\c0Jonathan Bodell\nKatie Sippel")
	}
	{
		heading
		item = qs("\LActivision\nBusiness\n& Legal\nAffairs:")
	}
	{
		item = qs("\L\c5Sr. Vice\nPresident\n& General Counsel\n\c0Greg Deutsch")
	}
	{
		item = qs("\L\c5Director\nGovernment and\nLegislative Affairs\n\c0Philip Terzian")
	}
	{
		item = qs("\L\c5Sr. Counsel\nBusiness &\nLegal Affairs\n\c0Mary Tuck")
	}
	{
		item = qs(0x7cd8fb95)
	}
	{
		item = qs(0x694bbf8c)
	}
	{
		item = qs("\L\c5Sr. Director\nof Production\nServices\n\c0Suzan Rude")
	}
	{
		heading
		item = qs("\LActivision\nCentral\nDesign and\nPlaytesting:")
	}
	{
		item = qs(0x1bb65834)
	}
	{
		item = qs(0xef9c36c7)
	}
	{
		item = qs(0x92767a58)
	}
	{
		item = qs(0x7489556b)
	}
	{
		item = qs(0x86d12bff)
	}
	{
		item = qs("\L\c5Manager\nCentral User\nTesting\n\c0Ray Kowalewski")
	}
	{
		heading
		item = qs(0xb226bb9e)
	}
	{
		item = qs("\L\c5Director,\nCentral\nAudio\n\c0Adam Levenson")
	}
	{
		item = qs(0xc4029dea)
	}
	{
		item = qs(0xa5fe4019)
	}
	{
		item = qs(0xbeb54a96)
	}
	{
		item = qs("\L\c5Audio\nProgrammers\n\c0Blair Bitoni\nSteve Merel")
	}
	{
		heading
		item = qs("\LBusiness\nDevelopment:\n\n")
	}
	{
		item = qs("\L\c5Head of\nBusiness\nDevelopment\n\c0Dave Anderson")
	}
	{
		item = qs("\L\c5Corporate\nAlliances\n\c0Yasmine Benyamini\nTim Steudler")
	}
	{
		heading
		item = qs(0x7238f64d)
	}
	{
		item = qs("\LMike Griffith\nRon Doornink\nThomas Tippl\nBrian Kelly\nBobby Kotick")
	}
	{
		item = qs("\LBrian Ward\nBrian Hodous\nDave Stohl\nDusty Welch\nMaria Stipp")
	}
	{
		item = qs("\LSteve Young\nJosh Taub\nJim McGinnis\nLaura Hoegler\nJennifer Sullivan")
	}
	{
		item = qs("\LBeverly Liggett\nWade Pottinger\nJulie Grovdahl\nBillie Cheng\nEzequiel Murillo")
	}
	{
		item = qs("\LSean Dexheimer\nMolly Hinchey\nAlex Gomez\nDavid Blackwell\nJane Elms")
	}
	{
		item = qs("\LKate Ogosta\nGeorge Rose\nDave Anderson\nRic Romero\nJason Posada")
	}
	{
		item = qs("\LRodrigo Mora\nJohn Dillulo\nMaryanne Lataif\nMichelle Schroder\nNikunj Dalal")
	}
	{
		item = qs("\LVictor Lopez\nJay Komas\nPeter Oey\nSteve Wereb\nTodd Szalla")
	}
	{
		item = qs("\LKathryn Murray\nChris Cosby\nBrenda Lindsay\nAlex Mahlke\nCynthia Montijo")
	}
	{
		item = qs(0x208940fd)
	}
	{
		heading
		item = qs("\LQuality\nAssurance:")
	}
	{
		item = qs("\L\c5VP Quality Assurance/\nCustomer Service\n\c0Paul Sterngold\nRich Robinson")
	}
	{
		item = qs("\L\c5Director,\nQuality\nAssurance\n\c0Marilena Morini")
	}
	{
		heading
		item = qs(0x254a644a)
	}
	{
		item = qs("\L\c5QA\nProject Lead\nDay Shift\n\c0Albert Yao")
	}
	{
		item = qs("\L\c5QA\nProject Lead\nNight Shift\n\c0Steve Peñate")
	}
	{
		item = qs("\L\c5Downloadable Content\nProject Lead\nDay Shift\n\c0T'Challa Jackson")
	}
	{
		item = qs("\L\c5Downloadable Content\nProject Lead\nNight Shift\n\c0Christian Murillo")
	}
	{
		item = qs("\L\c5QA Floor Leads\nDay Shift\n\c0Lou Studdert\nDong Fan")
	}
	{
		item = qs(0x71a1c311)
	}
	{
		item = qs("\L\c5QA Floor Leads\nNight Shift\n\c0Colin Tistaert\nJovani Bañuelos")
	}
	{
		item = qs(0x1bc8bc88)
	}
	{
		item = qs("\L\c5Downloadable Content\nFloor Lead\nDay Shift\n\c0Ramon Ramirez")
	}
	{
		item = qs("\L\c5Downloadable Content\nFloor Lead\nNight Shift\n\c0Andrew Jones")
	}
	{
		item = qs("\L\c5QA Database\nAdministrator\nDay Shift\n\c0Michael Taing")
	}
	{
		item = qs("\L\c5QA Database\nAdministrator\nNight Shift\n\c0Charlton Chu")
	}
	{
		item = qs("\L\c5QA Testers\nDay Shift\n\c0A.J.Seley\nAlan Garcia\nAndrew Aarsvold")
	}
	{
		item = qs("\LBenjamin Plunk\nBryan Marquez\nCalvin Kel Mendoza\nChris Gregory\nChris Myers")
	}
	{
		item = qs("\LChris Shepherd\nChristian Velasquez\nColt Carnes\nConor Metz\nCorey Sullivan")
	}
	{
		item = qs("\LDanielle Ruiz\nDanny Reynoso\nDarryl Kennedy Jr.\nDavid Kim\nD'wane Burgess")
	}
	{
		item = qs("\LEnrique Roldan\nForrest Thompson\nGabriel Casanova\nGraham McGuire\nIan Whaley")
	}
	{
		item = qs("\LJacklyn Kraus\nJames Heaney\nJames Muro\nJean Medina\nJeff Shabashev")
	}
	{
		item = qs("\LJeffrey Placencia\nJoe Soccoccio\nJonathan Cage\nJordan Bondus\nJorge Diaz")
	}
	{
		item = qs("\LJose Ramirez\nJose Vega\nJoshua Medoza\nJuan Manuel Garcia\nKyle Hertz")
	}
	{
		item = qs("\LLandon Morgan\nMarc Hirsch\nMark Simons\nMartin Ramirez\nMatthew Haugen")
	}
	{
		item = qs("\LMichael Stella\nMike Fuller\nNelson Herrera\nOscar Arias\nPatrick Duhaney")
	}
	{
		item = qs("\LPatrick Garcia\nPaul Goldilla\nRamon Ramirez\nRichard Denton\nRichard Dicks")
	}
	{
		item = qs("\LRichard Lopez\nRob Chaplan\nRobert Knox\nRotona Khoeut\nSam Cohn")
	}
	{
		item = qs("\LSean Harris\nSean Moline\nShawn Belew\nSteve Wrublevski\nTeresa Balwing")
	}
	{
		item = qs("\LTodd Carrigan\nWill Holstein\nJacob Goldman\nCreed Weatherman\nDaniel Hasid")
	}
	{
		item = qs("\LMario Garcia\nMicah Abshear\nRandall Becerra\nMoshe Moadeb\nGrant Steen")
	}
	{
		item = qs("\LAdam Black\nAlfred Mandagi\nDan Beach\nEric Chan\nMarquis Gayle")
	}
	{
		item = qs("\LIsidro Saldago\nDan Parraguez\nJames Stickley\nCary Seto\nJonathan Atkinson")
	}
	{
		item = qs("\L\c5QA Testers\nNight Shift\n\c0Akhil Conner\nAmanda Rose\nAmos Hirsh")
	}
	{
		item = qs("\LAnthony Ruiz\nBradon Miller\nBrian Adams\nBrian Conlisk\nCaroline Hernandez")
	}
	{
		item = qs("\LDavid Aguilar-Zamora\nDee Gibson\nDiego Carrillo\nDomenique Pineda\nDonnell Jones")
	}
	{
		item = qs("\LEJ Alcantara\nElmer De Leon\nEric Kelly\nErik Steinmetz\nFrancisco Delgadillo")
	}
	{
		item = qs("\LGerald Arteaga\nHugh MacNair II\nHugo Felix\nIan Comi\nIan Pepple")
	}
	{
		item = qs("\LIsara Nareesrisawatdi\nJaime Segovia\nJake Siegel\nJames Burzelic\nJames McCormick")
	}
	{
		item = qs("\LJimmy Yang\nJohn Garcia\nJonathan Ramsay\nJoshua Alison\nJoshua Valdez")
	}
	{
		item = qs("\LJuan Arias\nJules Lewis\nJulio Espada\nJustin Abrams\nJustin Huthmacher")
	}
	{
		item = qs("\LKenneth Wesley\nLuiz Coutinho\nMiguel Reyes\nMike Akins\nMike Allen")
	}
	{
		item = qs("\LNadia Jones\nPhuc Truong\nRigo Garcia\nRoberto Dominguez\nSalvador Garcia")
	}
	{
		item = qs("\LScott Bergin\nSean Belloso\nSean Urner\nShawn Alexander\nVicente Gutierrez")
	}
	{
		item = qs("\LWilliam Collins\nRalph Adaba\nGregory Morgan\nDidier Benitez\nChristopher Antes")
	}
	{
		item = qs("\LBilly Heron\nAnthony Bosco\nLewis Brace\nAndrew Jones\nShane Pomeroy")
	}
	{
		item = qs("\LBrittany Alexander\nChristopher Davis\nMarco Andrade\nFrancisco Alfaro\nLa Vonce Ervin")
	}
	{
		item = qs(0xfcfa389b)
	}
	{
		item = qs("\L\c5QA Senior\nProject Lead\nDay Shift\n\c0Paul Williams")
	}
	{
		item = qs("\L\c5QA Senior\nProject Lead\nNight Shift\n\c0Frank So")
	}
	{
		item = qs("\L\c5QA Managers\nDay Shift\n\c0Jason Levine\nJohn Rosser")
	}
	{
		item = qs(0xae1a2901)
	}
	{
		heading
		item = qs("\LVMC\nGame\nLabs\nMontréal")
	}
	{
		item = qs(0xfa97453d)
	}
	{
		item = qs(0x1dd0ea3b)
	}
	{
		item = qs("\L\c5Floor\nLeads\n\c0Jonnathon Turpin\nJustin Parker")
	}
	{
		item = qs("\L\c5Testers\n\c0Robert Argentin\nCharles Brodeau-Tanguay\nRashon Brothers\nBryan Callaghan")
	}
	{
		item = qs("\L\c0Olivier Chrun\nSébastien Clermont\nMark Di Francesco\nPatrick Drought\nAntonio Fernandez")
	}
	{
		item = qs("\L\c0Carl Gonzalez\nSean Grothé\nBlair Henderson\nJames Howden\nAlex Janes")
	}
	{
		item = qs("\L\c0James Kane\nArthur Kerr\nJoey Leblanc\nThomas Lefebre\nHector Libreros")
	}
	{
		item = qs("\L\c0Kevin Marti\nAdam Noodelman\nAsher Ohayon\nDonovan Olivera\nJoe Parisella")
	}
	{
		item = qs("\L\c0Ahmad Rahman\nCraig Read\nChris Roy\nScott Smith\nRyan Statz")
	}
	{
		item = qs(0xf1b336d8)
	}
	{
		heading
		item = qs("\LTechnical\nRequirements\nGroup:")
	}
	{
		item = qs("\L\c5Director\nQuality\nAssurance\n\c0Christopher Wilson")
	}
	{
		item = qs("\L\c5TRG Submissions\nLeads\n\c0Dan Nichols\nChristopher Norman")
	}
	{
		item = qs(0x39d8c32f)
	}
	{
		item = qs("\L\c5Sr. TRG\nPlatform Leads\n\c0Marc Villanueva\nTeak Holley")
	}
	{
		item = qs(0x135ba726)
	}
	{
		item = qs("\L\c5TRG Platform Leads\n\c0Benjamin Abel\nJared Baca\nJames Rose")
	}
	{
		item = qs("\LBrian Bensi\nPaul Carrion\nTomohiro Shikami")
	}
	{
		item = qs("\L\c5TRG Testers\n\c0Jonathan Butcher\nRhonda Ramirez\nSantiago Salvador\nJessica Eckstein")
	}
	{
		item = qs("\LRichard Tom\nJacob Zwim\nAlex Hirsch\nBrandon Miller\nPisoth Chham")
	}
	{
		item = qs("\LMark Ruzicka\nDustin Carter\nJason Garza\nJosue Medina\nLaurence Silva")
	}
	{
		item = qs("\LEdgar Sunga\nBrian Baker\nKeith Kodama\nColin Kawakami\nKirt Sanchez")
	}
	{
		item = qs("\LPaco Erskine\nScott Borakove\nJohn McCurry\nTodd Baron\nBrent Gothold")
	}
	{
		item = qs("\LMelvin Allen\nCaleb Huddleston\nIan Plitcher\nDemetrius Hoston\nJennifer Goodman")
	}
	{
		item = qs("\LStefan Goodreau\nMike Juarez\nKyle Robbins\nChristopher McCardle\nZachary Blough")
	}
	{
		item = qs(0xb4ea2b12)
	}
	{
		heading
		item = qs("\LQA\nNetwork\nLab:")
	}
	{
		item = qs("\L\c5Manager\nQA\nOperations\n\c0Chris Keim")
	}
	{
		item = qs("\L\c5QA Network Lab\nSenior\nProject Lead\n\c0Francis Jimenez")
	}
	{
		item = qs("\L\c5QA Network Lab\nProject Leads\n\c0Jessie Jones\nLeonard Rodriguez")
	}
	{
		item = qs("\L\c5QA\nNetwork Lab\nTester\n\c0Bryan Chice")
	}
	{
		heading
		item = qs(0x8a232966)
	}
	{
		item = qs("\L\c5QA Multiplayer\nLab\nLead\n\c0Garrett Oshiro")
	}
	{
		item = qs("\L\c5QA MPL\nSenior\nTester\n\c0Shamen'e Childress")
	}
	{
		item = qs("\L\c5QA MPL\nActing Floor Leads\n& Testers\n\c0Julio Medina\nBobby Jones")
	}
	{
		item = qs("\LJaemin Kang\nMatt Fawbush\nBrian Lay\nJohn Getty\nMatt Brannon")
	}
	{
		item = qs("\LTravis Otten\nBruce James\nNick Gram\nMario Ibarra\nJon Bunch")
	}
	{
		item = qs(0xa684036d)
	}
	{
		heading
		item = qs("\LQA Audio\nVisual Lab:")
	}
	{
		item = qs("\L\c5QA AV Lab\nProject\nLead\n\c0Victor Durling")
	}
	{
		item = qs("\L\c5QA AV Lab\nSenior\nTester\n\c0Cliff Hooper")
	}
	{
		item = qs("\L\c5QA AV Lab\nTesters\n\c0Delven Rutledge\nRyan Visteen")
	}
	{
		heading
		item = qs(0x0320a808)
	}
	{
		item = qs("\L\c5Senior\nManager\nQA Technologies\n\c0Indra Yee")
	}
	{
		item = qs("\L\c5Mastering\nLab\nSupervisor\n\c0John Donnelly")
	}
	{
		item = qs("\L\c5Senior\nMastering\nLab Technician\n\c0Sean Kim")
	}
	{
		item = qs("\L\c5Mastering Lab\nTechnicians\n\c0Tyree Deramus\nDanny Feng")
	}
	{
		item = qs("\L\c0Douglas Hernandez\nJose Hernandez\nKai Hsu\nRodrigo Magana")
	}
	{
		item = qs("\L\c0Steven Rodriguez\nLeejay Ronquillo\nOrbel Shakhmalian\nGary Washington")
	}
	{
		heading
		item = qs("\LQA-MIS:")
	}
	{
		item = qs(0xcf9b9ca0)
	}
	{
		item = qs(0xc88689a2)
	}
	{
		item = qs("\L\c5QA-MIS\nTechnicians\n\c0Chris Gill\nTeddy Hwang")
	}
	{
		item = qs(0xaedeb080)
	}
	{
		item = qs(0x16da40d0)
	}
	{
		item = qs("\L\c5QA-MIS\nEquipment Coordinators\n\c0Long Le\nColeman Thaxton")
	}
	{
		heading
		item = qs(0x275698c2)
	}
	{
		item = qs("\L\c5Senior Lead\nDatabase\nAdministrator\n\c0Jeremy Richards")
	}
	{
		item = qs("\L\c5Lead\nDatabase\nAdministrator\n\c0Kelly Huffine")
	}
	{
		item = qs("\L\c5Database\nTechnicians\n\c0Christopher Shanley\nTimothy Toledo")
	}
	{
		item = qs("\L\c5DBA\nSenior\nTester\n\c0Wayne Williams")
	}
	{
		item = qs("\L\c5DBA Testers\n\c0Dennish Soh\nRandi Williams-Pardo\nRichard Ledesma")
	}
	{
		item = qs(0x7d343f27)
	}
	{
		heading
		item = qs(0xdc8b13dc)
	}
	{
		item = qs("\L\c5Director\nQA\nOperations\n\c0George Viegas")
	}
	{
		item = qs("\L\c5Operations\n& Planning\nSupervisor\n\c0Jeremy Shortell")
	}
	{
		item = qs(0xa9183304)
	}
	{
		heading
		item = qs("\LCustomer\nSupport:")
	}
	{
		item = qs("\L\c5Customer Support\nManagers\n\c0Gary Bolduc\nMichael Hill")
	}
	{
		heading
		item = qs(0xbc468bcd)
	}
	{
		item = qs("\LAbby Alvarez\nNuria Andres\nBrian Carlson\nMichael Clarke\nRandolph d'Amore")
	}
	{
		item = qs("\LTiffany Beh-John Asghary\nTim Shanks\nSeth d'Amore\nMaria Gonzalez\nSofia Hadjeri")
	}
	{
		item = qs("\LRachel Overton\nDylan Rixford\nTracy Sheppard\nJacqueline Jolie Sheltmire\nNadine Theuzillot")
	}
	{
		item = qs(0x443b345f)
	}
	{
		item = qs("\LLee Cheramie\nBaro Jung\nJose Ornelas\nAna Peñate\nKristen Peñate")
	}
	{
		heading
		item = qs("\LLocalisations:")
	}
	{
		item = qs("\L\c5Director of\nProduction Services\nEurope\n\c0Barry Kehoe")
	}
	{
		item = qs("\L\c5Localisation\nProject\nManager\n\c0Fiona Ebbs")
	}
	{
		item = qs("\L\c5Senior\nLocalisation\nProject Manager\n\c0Bobby Henderson")
	}
	{
		item = qs("\L\c5Localisation\nCoordinators\n\c0Nelly Bergman\nChris Osberg")
	}
	{
		item = qs("\L\c5Localisation\nQA\nManager\n\c0David Hickey")
	}
	{
		item = qs("\L\c5Localisation\nAssistant\nQA Manager\n\c0Yvonne Costello")
	}
	{
		item = qs("\L\c5Localisation\nQA\nLead\n\c0Dominik Hilse")
	}
	{
		item = qs("\L\c5Localisation\nQA Floor Leads\n\c0Yves-Marie Delatouche\nAindreas Kugler\nJuergen Roeder")
	}
	{
		item = qs("\L\c5Localisation\nQA Testers\n\c0Daniel Luque Bautista\nMartin Buist\nEugen Brab")
	}
	{
		item = qs("\LStephanie Breda\nJohn Bonham\nDaniele Celeghin\nAna Charruff Cevinelli\nJonas Cigas")
	}
	{
		item = qs("\LFranco Contessa\nJames Dunne\nMiranda Durcan\nSamuel Fretigne\nAlberto Gilli")
	}
	{
		item = qs("\LJerome Grandgeorge\nRicardo Hernandez\nJeremy Janel\nAndrew Judge\nMartin Jungkunz")
	}
	{
		item = qs("\LAnthony Keane\nShane Kerr\nChristopher Kocksch\nGrégoire Léger\nGuillaume Lerouvreur")
	}
	{
		item = qs("\LMatthias Loffler\nSebastien Mazzerbo\nNora Menoumi\nAroia Murua\nGraziano Muscas")
	}
	{
		item = qs("\LTom O' Carroll\nJone Ordono\nCedric Piaud\nSandra Ramirez\nRoberta Raspa")
	}
	{
		item = qs("\LSergio Redondo\nEsther Reimann\nHeberto Rios\nAntonio Rosselli\nRoberto Schiavulli")
	}
	{
		item = qs("\LAlberto Valgimigli\nVictor Vega\nPhillip Winkels\nDiana Xifre\nSven Zimmermann")
	}
	{
		item = qs(0xccfcbf81)
	}
	{
		item = qs("\L\c5Burn Lab\nTechnicians\n\c0Isha Jain\nPierre Soltowski")
	}
	{
		item = qs("\L\c5IT\nNetwork\nTechnician\n\c0Fergus Lindsay")
	}
	{
		item = qs("\L\c5Localisation Consultant\n\c0Stephanie O'Malley Deming\n\c5Localisation Tools and Support\n\c0Provided by Xloc Inc.")
	}
	{
		heading
		item = qs("\LMusic:")
	}
	{
		heading
		item = qs(0x12d59066)
	}
	{
		item = qs("\LPerformed by Vampire Weekend\nWritten by R Batmanglij,\nE Koenig, C Tomson and C Baio\nPublished by\nVampire Weekend Music (ASCAP)")
	}
	{
		item = qs("\L(P) 2007 XL Recordings Limited\nLicensed Courtesy of\nXL Recordings Limited\nAll Rights Reserved\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c5''All\nAlong\nthe\nWatchtower''")
	}
	{
		item = qs("\LPerformed by Bob Dylan\nWritten by Bob Dylan\nPublished by Dwarf Music\nCourtesy of Columbia Records\nBy arrangement with")
	}
	{
		item = qs("\LSony Music\nEntertainment\nAll Rights\nReserved\nUsed by Permission")
	}
	{
		heading
		item = qs("\L\c5''All\nThe\nPretty\nFaces''")
	}
	{
		item = qs("\LPerformed by The Killers\nWritten by Brandon Flowers, Dave Brent Keuning,\nMark August Stoermer and Ronnie Jr. Vannucci\nPublished by Universal - Polygram Int. Publ., Inc.\no/b/o Universal Music Publ. Ltd.")
	}
	{
		item = qs("\LCourtesy of The Island Def Jam Music Group\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x326cacb5)
	}
	{
		item = qs("\LPerformed by Tom Petty & The Heartbreakers\nWritten by Tom Petty\nPublished by Almo Music Corp. o/b/o Tarka Music\nCourtesy of Gone Gator Musicn\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0xd3f139da)
	}
	{
		item = qs("\LPerformed by Wolfmother\nWritten by Andrew Stockdale\nPublished by CGG Courtesy of\nInterscope Records under license from Universal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0xcdcbb95b)
	}
	{
		item = qs("\LPerformed by Jimmy Eat World\nWritten by James Adkins,\nRichard Burch,\nZachary Lind\nand Thomas Linton")
	}
	{
		item = qs("\LPublished by FSMGI(IMRO) and Turkey on Rye Music (ASCAP)\nadministered by State One Songs America(ASCAP)\nCourtesy of Interscope Records\nunder license from Universal Music Enterprises.\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0xfbcbde40)
	}
	{
		item = qs("\LPerformed by Darker My Love\nWritten by Tim Presley\nand Rob Barbato\nPublished by\nDangerous Birdsongs (BMI).")
	}
	{
		item = qs("\LAdministered by\nAffiliated Music Publishing, LLC\nCourtesy of\nDangerbird Records.\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0xa084eda9)
	}
	{
		item = qs("\LPerformed by The White Stripes\nWritten by Jack White\nPublished by\nPeppermint Stripe Music\n(P)2005 XL Recordings Limited")
	}
	{
		item = qs("\LLicensed courtesy of\nThird Man Records and\nXL Recordings Limited\nAll Rights Reserved.\nUsed by Permission")
	}
	{
		heading
		item = qs(0x4f73912d)
	}
	{
		item = qs("\LPerformed by Arctic Monkeys\nWritten by Alexander Turner\nPublished by EMI Music Publishing\nCourtesy of Domino Recording Co. LTD\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Bring\nThe\nNoise\n20XX''")
	}
	{
		item = qs("\LPerformed by Public Enemy\nfeaturing Zakk Wylde\nWritten by Chuck D,\nEric Sadler, and Hank Shocklee\nPublished by Reach Global")
	}
	{
		item = qs("\Land Songs of Universal, Inc.\nCourtesy of Reach Global, Inc.\no/b/o Bring the Noize Music, Inc.\nand Zachary Wylde\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Bullet\nWith\nButterfly\nWings''")
	}
	{
		item = qs("\LPerformed by\nThe Smashing Pumpkins\nWritten by\nWilliam Patrick Corgan\nPublished by Cinderful Music")
	}
	{
		item = qs("\LCourtesy of Virgin Records, Inc\nUnder License from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x04a428e0)
	}
	{
		item = qs("\LPerformed by Band of Horses\nWritten by\nBenjamin Bridwell\nRobert Hampton\nand Creighton Barrett")
	}
	{
		item = qs("\LPublished by Birdsmell Brand\nSongs Music (ASCAP)\nCourtesy of Sub Pop Records\nAll Rights Reserved\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x7e52c31f)
	}
	{
		item = qs("\LPerformed by Bush\nWritten by Gavin Rossdale\nPublished by Mad Dog Winston Music Ltd. (BMI)\nCourtesy of Kirtland Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0xcf78ed83)
	}
	{
		item = qs("\LPerformed by Billy Idol\nWritten by Billy Idol\nand Anthony James\nPublished by Chrysalis Music and\nUniversal - PolyGram Int. Publ., Inc.")
	}
	{
		item = qs("\Lo/b/o Universal Music Publ. Ltd.\nCourtesy of Capitol Records\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0xdb1f3bdd)
	}
	{
		item = qs("\LPerformed by Thrice\nWritten by\nEdward Carrington Breckenridge,\nJames Riley Breckenridge,\nDustin Michael Kensrue\nand Teppei Teranishi")
	}
	{
		item = qs("\LPublished by Universal\nMusic - MGB Songs\no/b/o Itself and Sceptor Of Malice\nCourtesy of Hopeless & Subcity Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x5fe2ba0e)
	}
	{
		item = qs("\LPerformed by Darkest Hour\nWritten by Paul Burnette,\nJohn Henry,\nKristopher Norris,\nRyan Parrish and Michael Schleibaum")
	}
	{
		item = qs("\LPublished by\nAnother Victory Publishing\nCourtesy of Victory Records\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x2ffb65f3)
	}
	{
		item = qs("\LPerformed by Face to Face\nWritten by Trever Keith and Matt Riddle\nPublished by EMI Blackwood Music, Inc.\nCourtesy of Railer Entertainment o/b/o Antagonist Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Do You\nFeel\nLike We\nDo?''(Live)")
	}
	{
		item = qs("\LPerformed by Peter Frampton\nWritten by Peter Frampton, Michael Gallagher,\nJohn T. Siomos and Rick Wills\nPublished by Glenwood Music Corp.\nEMI U Catalog Inc.,\nAlamo Music Corp. o/b/o itself")
	}
	{
		item = qs("\Land Nuages Artists Music Ltd.\nCourtesy of A&M Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Done With\nEverything,\nDie For\nNothing''")
	}
	{
		item = qs("\LPerformed by Children of Bodom\nWritten by Marku Laiho\n©Magic Arts Publishing/Edition\nMusik-Knotor-Verlag\nand Continental/Musik Kontor Publishing")
	}
	{
		item = qs("\LCourtesy of Universal Music Finland\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x968d9a49)
	}
	{
		item = qs("\LPerformed by Rammstein\nWritten by Richard Z. Kruspe,\nPaul Landers,Till Lindemann,\nDoktor Christian Lorenz,\nChristoph Doom Schneider and Oliver Riedel")
	}
	{
		item = qs("\LPublished by Tam Tam Fialik Musikverlag\nadministered by\nKobalt Music Publishing America, Inc.\nand Universal Music - MGB Songs\no/b/o Discoton Musik Ed. GmbH")
	}
	{
		item = qs("\LCourtesy of Motor Music GMBH\nUnder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x71b29fbc)
	}
	{
		item = qs("\LPerformed by No Doubt\nWritten by Thomas Dumont,\nTony Ashwin Kanal\nand Gwen Renee Stefani\nPublished by Universal Music Corp.")
	}
	{
		item = qs("\Lo/b/o itself and World of the Dolphin Music\nCourtesy of Interscope Records\nunder license frm Universal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x1afb5811)
	}
	{
		item = qs("\LPerformed by David Bowie\nWritten by David Bowie,\nCarlos Alomar and John Lennon\nPublished by EMI Blackwood Music Inc.,\nColgems-EMI Music Inc.,")
	}
	{
		item = qs("\LJones Music America (ASCAP)\nadministered by ARZO Publishing\nand Chrysalis Music\nCourtesy of RZO Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0xe02a33a8)
	}
	{
		item = qs("\LPerformed by Gorillaz\nWritten by Damon Albarn,\nBrian Joseph Burton,\nJamie Christopher Hewlett\nand David J. Jolicoeur")
	}
	{
		item = qs("\LPublished by EMI Blackwood Music Inc.,\nChrysalis Music and 80's Kid Music (BMI)\nCourtesy of EMI Records\nUnder license from EMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x6180ce43)
	}
	{
		item = qs("\LPerformed by Beck\nWritten by\nBeck Hansen\nPublished by Youthless\nCourtesy of")
	}
	{
		item = qs("\LInterscope Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x56a7e715)
	}
	{
		item = qs("\LPerformed by Beastie Boys\nWritten by Adam Horovitz, Adam Yauch\nMike Diamond and Tom Cushman\nPublished by Universal -\nPolygram International Publishing, Inc.")
	}
	{
		item = qs("\Lo/b/o Itself and Brooklyn Dust Music\nCourtesy of Capital Records\nUnder license from EMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Hungry\nLike\nThe\nWolf''")
	}
	{
		item = qs("\LPerformed by Duran Duran\nWritten by Nicholas James Bates,\nSimon John LeBon,\nAndrew Taylor,\nJohn Taylor and Roger Taylor")
	}
	{
		item = qs("\L© 1982, Gloucester Place Music Ltd.\nEMI Music Publishing UK Ltd.\nCourtesy of EMI Records\nUnder license from EMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0xc95bdb12)
	}
	{
		item = qs("\LPerformed by John Mellencamp\nWritten by John Mellencamp and George Michael Green\nPublished by EMI Full Keel Music\nCourtesy of Universal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x06bb132a)
	}
	{
		item = qs("\LPerformed by Coldplay\nWritten by Guy Berryman,\nJonathan Buckland,\nWill Champion\nand Christopher Martin")
	}
	{
		item = qs("\LPublished by Universal Music -\nMGB Songs o/b/o Universal Music Publ. MGB Ltd.\nCourtesy of EMI Records\nUnder license from EMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x09f899fe)
	}
	{
		item = qs("\LPerformed by Spacehog\nWritten by Royston Langdon\nPublished by Hogspace Music Ltd.\nCourtesy of Hogspace Music Ltd.\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x8c899cab)
	}
	{
		item = qs("\LPerformed by Sonic Youth\nWritten by Kim Gordon,\nThurston Moore,\nLee Ranaldo\nand Steve Shelley")
	}
	{
		item = qs("\LPublished by\nSonik Tooth Music(BMI)\nCourtesy of Geffen Records\nUnder license from Universal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x9c26af16)
	}
	{
		item = qs("\LPerformed by Thin Lizzy\nWritten by\nPhilip Parris Lynott\nPublished by Universal -\nPolyGram Int. Publ., Inc.")
	}
	{
		item = qs("\Lo/b/o Pippin the\nFriendly Ranger Mus. Co. Ltd.\nCourtesy of Mercury Records Limited under\nlicense from Universal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x1d0e5d20)
	}
	{
		item = qs("\LPerformed by A Perfect Circle\nWritten by Billy Howerdel\nand Maynard James Keenan\nPublished by\nToolshed Music/EMI")
	}
	{
		item = qs("\LApril Music Inc.\nand Transfixed Music\nCourtesy of Virgin Records, Inc.\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0xa2b25eab)
	}
	{
		item = qs("\LPerformed by 3 Doors Down\nWritten by Brad Arnold,\nMatthew Darrick Roberts,\nand Robert Todd Harrell\nPublished by Songs of Universal, Inc.")
	}
	{
		item = qs("\Lo/b/o Itself\nand Escatawpa Songs\nCourtesy of Universal Records\nunder license from Universal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x543b61eb)
	}
	{
		item = qs("\LPerformed by Elliott Smith\nWritten by Elliott Smith\nPublished by\nUniversal Music -\nCareers o/b/o Itself and")
	}
	{
		item = qs("\LSpent Bullets Music\nCourtesy of\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x8f6a4dbc)
	}
	{
		item = qs("\LPerformed by Nirvana\nWritten by Kurt Cobain\nPublished by EMI Virgin Songs, Inc.\no/b/o The End of Music\nand Primary Wave Tunes")
	}
	{
		item = qs("\LCourtesy of Geffen Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission")
	}
	{
		heading
		item = qs("\L\c5''Lonely\nIs\nThe\nNight''")
	}
	{
		item = qs("\LPerformed by Billy Squier\nWritten by Billy Squier\nPublished by Spirit Two Music, Inc.\no/b/o Songs Of The Knight\nCourtesy of")
	}
	{
		item = qs("\LCapitol Records\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0xcc82023f)
	}
	{
		item = qs("\LPerformed by Mötley Crüe\nWritten by Nikki Sixx\nPublished by Downtown Music Publishing\no/b/o Sixx Gunner Music (ASCAP),\nSafe 'n Sound Royalty Management")
	}
	{
		item = qs("\Lo/b/o Tommyland Music (ASCAP) and Mars Mountain Music\nadministered by Cherry Lane Music Publishing\nCourtesy of 11-7 Recordings\nby arrangement with Downtown Music Publishing\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Lust\nFor\nLife''\n(Live)")
	}
	{
		item = qs("\LPerformed by Iggy Pop\nWritten by David Bowie and Iggy Pop\nPublished by Screen Gems-EMI Music Inc.,\nBug Music (BMI),\nand Tintoretto Music (BMI)")
	}
	{
		item = qs("\Ladministered by RZO Music, Inc.\nCourtesy of Virgin Records, Inc.\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x6cc39cc6)
	}
	{
		item = qs("\LPerformed by The Sword\nWritten by John D. Cronise\nand Jason Shutt\nPublished by\nBlood of Kings Music")
	}
	{
		item = qs("\Land Stop Moping Music\nCourtesy of\nKemado Records\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Make\nIt\nWit\nChu''")
	}
	{
		item = qs("\LPerformed by Queens of the Stone Age\nWritten by Josh Homme,\nMichael Melchiondo\nand Alain Moschulski\nPublished by Brown Dog Music,")
	}
	{
		item = qs("\LBoard Stiff Music and Sony\nATV Harmony/Channel This Music\nCourtesy of Interscope Records under license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x0cb8fc18)
	}
	{
		item = qs("\LPerformed by AFI\nWritten by Hunter Burgen,\nAdam Carson,\nDavid Marchand\nand Jade Puget")
	}
	{
		item = qs("\LPublished by Ex Noctem Nacimur Music\nCourtesy of Interscope Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x6f0c30ea)
	}
	{
		item = qs("\LPerformed by Love and Rockets\nWritten by Daniel Gaston Ash,\nKevin Haskins and David Jay\nPublished by Universal -\nPolyGram Int. Publ., Inc.")
	}
	{
		item = qs("\Lo/b/o Universal/Momentum Music 3 Ltd.\n(c) 2008 Ash/Haskins/Haskins\n(p) 2009 Love and Rockets\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x90437984)
	}
	{
		item = qs("\LPerformed by Screaming Trees\nWritten by Gary Lee Conner,\nVan Conner and Mark Lanegan\nPublished by Ripplestick Music Inc/\nSolomon Grundy Music/")
	}
	{
		item = qs("\LGlowing Eel Music\nCourtesy of Epic Records\nBy arrangement with\nSony Music Entertainment\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Never\nMiss\nA\nBeat''")
	}
	{
		item = qs("\LPerformed by Kaiser Chiefs\nWritten by Nicholas Baines,\nNicholas Hodgson, James Rix,\nAndrew White and Charles Wilson\nPublished by Almo Music")
	}
	{
		item = qs("\Lo/b/o Imagem Songs Ltd.\nCourtesy of Universal Records\nunder license from\nUniversal Music Enterprisess\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''No One\nTo Depend\nOn\n(Live)''")
	}
	{
		item = qs("\LPerformed by Santana\nWritten by Michael John Carabello,\nThomas Escovedo\nand Gregg Rolie\nPublished by  Universal Music - Careers")
	}
	{
		item = qs("\Lo/b/o Itself and Love Pirate Music\nCourtesy of The Island Def Jam Music Group\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x3448a8f9)
	}
	{
		item = qs("\LPerformed by My Morning Jacket\nWritten by James Edward Olliges, Jr.\nPublished by Chrysalis Songs o/b/o Itself and Removador Songs\nCourtesy of ATO Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Only\nHappy\nWhen It\nRains''")
	}
	{
		item = qs("\LPerformed by Garbage\nWritten by Douglas Erickson,\nShirley Manson,\nSteve W. Marker\nand Butch Vig")
	}
	{
		item = qs("\LPublished by Irving Music, Inc.\no/b/o Itself and Vibecrusher Music/\nAlmo Music o/b/o Itself and Deadarm Music\nCourtesy of Natural Entergy Lab\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Play\nThat\nFunky\nMusic''")
	}
	{
		item = qs("\LPerformed by Wild Cherry\nWritten by Robert Parissi\nPublished by BEMA Music\na division of\nSweet City Records Inc.")
	}
	{
		item = qs("\Lo/b/o and as administrator of RWP Music\nCourtesy of Epic Records\nBy arrangement with Sony Music Entertainment\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x26ac26be)
	}
	{
		item = qs("\LPerformed by Muse\nWritten by Matt Bellamy\nPublished by\nHewrate Ltd and Taste Music Ltd.\nCourtesy of Warner Bros. Records Inc./")
	}
	{
		item = qs("\LWarner Music UK\nBy arrangement with\nWarner Music Group Video Game Licensing\n(P) 2001 A & E Records Limited\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x5654910e)
	}
	{
		item = qs("\LPerformed by Johnny Cash\nWritten by\nJune Carter and Merle Kilgore\nPublished by Painted Desert Music Corp.\nCourtesy of")
	}
	{
		item = qs("\LThe Island Def Jam Music Group\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0xdfbc4f93)
	}
	{
		item = qs("\LPerformed by Blink-182\nWritten by Tom De Longe,\nMark Hoppus,\nand Travis Barker\nPublished by EMI April Music Inc.")
	}
	{
		item = qs("\LCourtesy of Geffen Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Runnin'\nDown\nA\nDream''")
	}
	{
		item = qs("\LPerformed by Tom Petty\nWritten by Tom Petty,\nJeff Lynn and Mike Campbell\nPublished by EMI April Music Inc.,\nGone Gator Music (ASCAP)")
	}
	{
		item = qs("\Land Wild Gator Music (ASCAP)\nCourtesy of Geffen Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Saturday\nNight's\nAlright\n(For Fighting)''")
	}
	{
		item = qs("\LPerformed by Elton John\nWritten by Elton John\nand Bernie Taupin\nPublished by Universal Songs\nof Polygram Int., Inc.,")
	}
	{
		item = qs("\Lo/b/o Universal/Dick James Music Ltd.\nCourtesy of Mercury Records Limited\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x9f36b8d9)
	}
	{
		item = qs("\LPerformed by Jeff Beck\nWritten by Jeff Beck and Max Middleton\nPublished by Equator Music Publishing\nCourtesy of Deuce Music Ltd.\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Send A\nLittle\nLove\nToken''")
	}
	{
		item = qs("\LPerformed by The Duke Spirit\nWritten by Toby Butler\nand Liela Rosemary Sadie\nLouise Moss\nPublished by Universal Music -")
	}
	{
		item = qs("\LCareers o/b/o\nUniversal Music Publ. MGB Ltd.\nCourtesy of Shangri-La Music, LLC\nAll Rights Reserved.\nUsed by Permission")
	}
	{
		heading
		item = qs(0xfaa21a8d)
	}
	{
		item = qs("\LPerformed by Sunny Day Real Estate\nWritten by Jeremy Enigk,\nWilliam Goldsmith,\nDan Hoerner\nand Nate Mendel")
	}
	{
		item = qs("\LPublished by Ironic Superlative Music (BMI),\nadministered by Bug, Ebot Music (BMI),\nDan Hoerner (BMI) and Copyright Control\nCourtesy of Sub Pop Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x3aac966e)
	}
	{
		item = qs("\LPerformed by Kings of Leon\nWritten by Caleb Followill,\nNathan Followill,\nJared Followill,\nand Matthew Followill")
	}
	{
		item = qs("\LSongs of Combustion Music (ASCAP)/\nPublished by\nMcFearless Music (BMI)/\nCoffee Tea or Me Publishing (BMI),\nadministered by Bug")
	}
	{
		item = qs("\Land Bug Music-Music of Windswept (ASCAP)/\nFollowill Music (ASCAP)/\nMartha Street Music (ASCAP),\nadministered by\nBug Music -")
	}
	{
		item = qs("\LMusic of Windswept\nCourtesy of RCA/JIVE Label Group,\na unit of Sony Music Entertainment\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Shout\nIt\nOut\nLoud''")
	}
	{
		item = qs("\LPerformed by Kiss\nWritten by Bob Ezrin,\nGene Simmons and Paul Stanley\nPublished by Hori\nProductions America, Inc.")
	}
	{
		item = qs("\LAnd Cafe Americana Inc.\nand All By Myself Music Administered by Universal -\nPolyGram International Publishing, Inc.\nCourtesy of Kiss Catalog\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Six\nDays\na\nWeek''")
	}
	{
		item = qs("\LPerformed by The Bronx\nWritten by Matt Caughthran,\nJoby Ford, Jorma Vik,\nBrad Magers, and Ken Horne\nPublished by Crush Mgmt")
	}
	{
		item = qs("\LPublished by Elvis\nThe Other White Meat (ASCAP)\nCourtesy of White Drugs\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Smells\nLike\nTeen\nSpirit''")
	}
	{
		item = qs("\LPerformed by Nirvana\nWritten by Kurt Cobain,\nDave Grohl\nand Krist Novoselic\nPublished by EMI Virgin Songs, Inc.")
	}
	{
		item = qs("\Lo/b/o The End of Music\nand Primary Wave Tunes,\nSongs of Universal, Inc.\no/b/o MJ Twelve Music\nand Murky Slough Music")
	}
	{
		item = qs("\LCourtesy of Geffen Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x48d904a2)
	}
	{
		item = qs("\LPerformed by Rose Hill Drive\nWritten by\nDaniel Sproul,\nJacob Sproul,\nand Nathan Barnes")
	}
	{
		item = qs("\LPublished by\nRHD Songs (SESAC)\nCourtesy of Megaforce Records\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x116c9a70)
	}
	{
		item = qs("\LPerformed by The Police\nWritten by Sting\nPublished by EMI Blackwood Music Inc.\nCourtesy of A&M Records under license from Universal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x1a5085e8)
	}
	{
		item = qs("\LPerformed by Blur\nWritten by Damon Albarn,\nGraham Coxon,\nSteven James, and David Rowntree\nPublished by EMI Blackwood Music Inc.")
	}
	{
		item = qs("\LCourtesy of EMI Records Ltd\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0xcc04f8e4)
	}
	{
		item = qs("\LPerformed by Brand New\nWritten by Vincent Accardi\nPublished by Universal Music -\nZ Melodies o/b/o Itself\nand Gut Bloodfoot Music")
	}
	{
		item = qs("\LCourtesy of Interscope Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c5''The\nSpirit\nof\nRadio\n(Live)''")
	}
	{
		item = qs("\LPerformed by Rush\nWritten by Geddy Lee,\nAlex Lifeson\nand Neil Peart\nPublished by Core Music")
	}
	{
		item = qs("\LCourtesy of Anthem Entertainment\nand The Island Def Jam Music Group\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Steady\nAs\nShe\nGoes''")
	}
	{
		item = qs("\LPerformed by The Raconteurs\n(p) 2006 XL Recordings Limited\nWritten by Jack White and Brendan Benson\nPublished by Stacy Fass\nand Chrysalis Music")
	}
	{
		item = qs("\Lo/b/o Itself and Gladsad Music\nLicensed Courtesy of XL Recordings Limited\nand Third Man Records\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0xa08e0e94)
	}
	{
		item = qs("\LPerformed by Gov't Mule\nWritten by Warren Haynes\nPublished by\nBuzzard Rock Music\nadministered by")
	}
	{
		item = qs("\LCherry Lane\nMusic Publishing\nCourtesy of ATO Records\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x59763f62)
	}
	{
		item = qs("\LPerformed by Dire Straits\nWritten by\nMark Knopfler\nPublished by\nAlmo Music Corp.")
	}
	{
		item = qs("\Lo/b/o Straitjacket Songs Ltd.\nCourtesy of Mercury Records (London) Ltd\nUnder license from\nUniversal Music Operations Ltd\nAll Rights Reserved. Used by Permission")
	}
	{
		heading
		item = qs(0xe6d84ea3)
	}
	{
		item = qs("\LPerformed by Stevie Wonder\nWritten by Stevie Wonder\nPublished by Jobete Music Co., Inc.\nand Black Bull Music\nCourtesy of")
	}
	{
		item = qs("\LMotown Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x1ef35121)
	}
	{
		item = qs("\LPerformed by Megadeth\nWritten by Dave Mustaine\nPublished by\nEMI Blackwood Music Inc.\nand Theory Music")
	}
	{
		item = qs("\LCourtesy of Capitol Records\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Sympathy\nFor\nThe\nDevil''")
	}
	{
		item = qs("\LPerformed by The Rolling Stones\nWritten by Mick Jagger and Keith Richards\nPublished by ABKCO Music, Inc\nCourtesy of ABKCO Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0xc4f40e07)
	}
	{
		item = qs("\LPerformed by Scars On Broadway\nWritten by Daron V. Malakian\nPublished by Sony ATV Songs LLC/\nDolmayan Publishing /\nMalakian Publishing")
	}
	{
		item = qs("\LCourtesy of Interscope Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x57aa50cc)
	}
	{
		item = qs("\LPerformed by T. Rex\nWritten by Marc Bolan\nPublished by Spirit One Music o/b/o ITS Music Publishing B.V.\nCourtesy of Spirit Music Group\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''21st\nCentury\nSchizoid\nMan''")
	}
	{
		item = qs("\LPerformed by King Crimson\nWritten by Robert Fripp\nMichael Giles,\nGreg Lake,\nIan McDonald,and Peter Sinfield")
	}
	{
		item = qs("\LPublished by Universal Music MGB Ltd.\nCourtesy of DGM Ltd.\no/b/o King Crimson\nAll Rights Reserved.\nUsed by Permission")
	}
	{
		heading
		item = qs(0x3d5debe4)
	}
	{
		item = qs("\LPerformed by Iron Maiden\nWritten by Bruce Dickinson and Adrian Smith\nPublished by Universal Music -\nZ Tunes LLC o/b/o Adrian Smith Ent. Ltd.\nCourtesy of EMI Records Ltd.")
	}
	{
		item = qs("\Land Sanctuary Records Group Inc.\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x12c5c4f2)
	}
	{
		item = qs("\LPerformed by Queen & David Bowie\nWritten by David Bowie,\nBrian May,\nFreddie Mercury,\nJohn Deacon")
	}
	{
		item = qs("\Land Roger Taylor\nPublished by Beechwood Music Corp.,\nScreen Gems-EMI Music Inc.\nand Tintoretto Music (BMI)\nadministered by RZO Music, Inc.")
	}
	{
		item = qs("\LCourtesy of Hollywood Records,\nRZO Music\nand EMI Records Ltd.\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x5aa21a17)
	}
	{
		item = qs("\LPerformed by Eagles of Death Metal\nWritten by Jessie Everett Hughes and Josh Homme\nPublished by MAFFG/Board Stiff Music\nand Universal Music -\nZ Songs o/b/o Imagem London Ltd.")
	}
	{
		item = qs("\LCourtesy of Downtown Records\nBy arrangement with\nRekords Rekords\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c5''We're\nAn\nAmerican\nBand''")
	}
	{
		item = qs("\LPerformed by Grand Funk Railroad\nWritten by Don Brewer\nPublished by\nBrew Music Company\nCourtesy of")
	}
	{
		item = qs("\LCapitol Records\nunder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0x8eb17a3e)
	}
	{
		item = qs("\LPerformed by Sublime\nWritten by Floyd I. Gaugh IV,\nBradley James Nowell, Lindon Roberts\nand Eric John Wilson\nPublished by Songs of Universal, Inc.")
	}
	{
		item = qs("\Lo/b/o itself, Eric John Wilson Publ.,\nFloyd I. Gaugh, IIII Publ.,\nGasoline Alley Music,And Lou Dog Publ./\nUniversal Music -Careers\no/b/o itself and Halfpint Music")
	}
	{
		item = qs("\LCourtesy of Geffen Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0xff671dc9)
	}
	{
		item = qs("\LPerformed by Weezer\nWritten by\nRivers Cuomo\nPublished by E.O. Smith Music\nCourtesy of")
	}
	{
		item = qs("\LGeffen Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs(0xe3ddf8f4)
	}
	{
		item = qs("\LPerformed by TV On The Radio\nWritten by Babatunde Omoroga Adebimpe,\nJaleel Bunton, David Kyp,\nJoel Malone, David Andrew Sitek\nand Gerard Anthony Smith")
	}
	{
		item = qs("\LPublished by Chrysalis Music\no/b/o itself and Stunzeed Music\nCourtesy of Geffen Records\nunder license from Universal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5''Woman\nFrom\nTokyo\n('99 Remix)''")
	}
	{
		item = qs("\LPerformed by Deep Purple\nWritten by\nRitchie Blackmore, Ian Gillan,\nRoger Glover,\nJon Lord and Ian Paice")
	}
	{
		item = qs("\LPublished by Glenwood Music Corp.\nCourtesy of\nSpark Marketing Entertainment\nand EMI Records Ltd.\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0xa8d7cefb)
	}
	{
		item = qs("\LPerformed by Attack! Attack! (UK)\nWritten by Mike Griffiths,\nNeil Starr,\nRyan Day\nand Will Davies")
	}
	{
		item = qs("\LPublished by Imagen\nCourtesy of\nRockridge Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c5''You\nGive\nLove A\nBad Name''")
	}
	{
		item = qs("\LPerformed by Bon Jovi\nWritten by Jon Bon Jovi,\nDesmond Child\nand Richard S. Sambora\nPublished by Sony ATV Tunes LLC/")
	}
	{
		item = qs("\LAggressive Music\nand Universal\n- PolyGram Int. Publ., Inc.\non behalf of Itself\nand Bon Jovi Publishing")
	}
	{
		item = qs("\LCourtesy of\nThe Island Def Jam Music Group\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs(0x5dff043f)
	}
	{
		item = qs("\LPerformed by The Derek Trucks Band featuring Jimmy Herring\nWritten by Derek Trucks and Jimmy Herring\nPublished by Derek Trucks and Jimmy Herring\nCourtesy of Derek Trucks\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c5© 2009\nActivision\nPublishing,\nInc.")
	}
	{
		item = qs("\LGuitar Hero, Activision and RedOctane\nare registered trademarks of\nActivision Publishing, Inc.\nCovered by one or more of the\nfollowing patents:")
	}
	{
		item = qs("\LU.S. Patent Nos. 6379244, 6582309,6609979,\n6425822, 6225547, 6607446, 6342665,\n6769689, 6645067, 6252153, 6758753,\n6554711, 6347998, 6390923, 6612931,\n6461239, 6915488, 6638160, 6821203,")
	}
	{
		item = qs("\L5739457, 6018121, 6268557, 6369313,\n6835887 and D441403; patents pending.\nAll other trademarks and trade names\nare the properties of their\nrespective owners. All rights reserved.")
	}
]
