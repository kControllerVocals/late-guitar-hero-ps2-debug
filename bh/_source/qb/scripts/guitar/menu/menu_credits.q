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
		<rate> = 567.5
		<screen_height> = 280.0
		<scale_head> = 0.9
		<color_head> = [80 120 200 255]
		<scale_body> = 0.65000004
		<color_body> = [200 220 230 255]
		<scale_title> = 0.65000004
		<color_title> = [80 120 200 255]
	else
		<rate> = 380.0
		<screen_height> = 690
		<scale_head> = 0.75
		<color_head> = [80 120 200 255]
		<scale_body> = 0.65000004
		<color_body> = [200 220 230 255]
		<scale_title> = 0.65000004
		<color_title> = [80 120 200 255]
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
		item = qs(0xc295cdf5)
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
		item = qs(0x2e465f3a)
	}
	{
		item = qs(0xca1583f2)
	}
	{
		item = qs(0x76d77fcd)
	}
	{
		item = qs(0xd48d801a)
	}
	{
		item = qs(0xeb14c36c)
	}
	{
		item = qs(0xb1df901f)
	}
	{
		item = qs(0x3d2e0c50)
	}
	{
		item = qs(0x86ab56f1)
	}
	{
		item = qs(0x3b953bad)
	}
	{
		item = qs(0x97191317)
	}
	{
		item = qs(0xbc35a950)
	}
	{
		item = qs(0x7f1d6f39)
	}
	{
		item = qs(0x9709ebac)
	}
	{
		item = qs(0x326d2082)
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
		item = qs(0x11b2d600)
	}
	{
		item = qs(0xd65cd726)
	}
	{
		item = qs(0x09a9b0fe)
	}
	{
		item = qs(0xf3d53698)
	}
	{
		item = qs(0xed63399b)
	}
	{
		item = qs(0x1512dbfb)
	}
	{
		item = qs(0x1d5dbdc5)
	}
	{
		item = qs(0xfbb8cfc0)
	}
	{
		item = qs(0xb304e65a)
	}
	{
		item = qs(0xca08e661)
	}
	{
		item = qs(0x07c7547b)
	}
	{
		item = qs(0x0e1d0e14)
	}
	{
		item = qs(0x796eb4ad)
	}
	{
		item = qs(0xf81663a8)
	}
	{
		item = qs(0x9ece20f8)
	}
	{
		item = qs(0xb1297c45)
	}
	{
		item = qs(0xb7f8490d)
	}
	{
		item = qs(0xe1539fc7)
	}
	{
		item = qs(0x180405f3)
	}
	{
		item = qs(0x4a5e827a)
	}
	{
		item = qs(0xd7bf47df)
	}
	{
		item = qs(0x8848e16f)
	}
	{
		item = qs(0xd484ef8b)
	}
	{
		item = qs(0xf68e9b75)
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
		item = qs("\LDesigned and\nDeveloped by\n\c5Neversoft\c0:")
	}
	{
		item = qs("\LAaron Williams\nAdam Micciulla\nAdam Tsui\nAlan Flores")
	}
	{
		item = qs("\LAlex Leffelman\nAllen Freese\nAndy Gentile\nAndy Lee")
	}
	{
		item = qs("\LAndy Marchal\nAndy Warwick\nAnet Hambarsumian\nAnthony Campos")
	}
	{
		item = qs("\LAnthony Carotenuto\nAnthony Saunders\nBen Kutcher\nBernie Corrigan")
	}
	{
		item = qs("\LBill Buckley\nBrad Bulkley\nBrandon Riggs\nBrendan Wiuff")
	}
	{
		item = qs("\LBrian Bright\nBrian Effinger\nBrian Marvin\nBrian Oles")
	}
	{
		item = qs("\LByeong Gyu Park\nChad Findley\nChad Sundman\nCharles Babb")
	}
	{
		item = qs("\LChris Barnes\nChris Boltz\nChris Myers\nChris Parise")
	}
	{
		item = qs("\LChris Self\nChris Ward\nChristopher George\nChristopher Vance")
	}
	{
		item = qs("\LClark Wen\nClaudia Franco\nClive Burdon\nCody Pierson")
	}
	{
		item = qs("\LColin Crenshaw\nCorey Teblum\nDallas Holloway\nDan Hong")
	}
	{
		item = qs("\LDan Savage\nDana De Lalla\nDaniel Nelson\nDaryl Kimoto")
	}
	{
		item = qs("\LDash Nash\nDave Cowling\nDave Rowe\nDavid ''Shinji'' Furuya")
	}
	{
		item = qs("\LDavid Hernandez\nDavid Hind\nDavid Nilsen\nDavid Rose")
	}
	{
		item = qs("\LDavid Schorn\nDavid Stowater\ndavidicus\nDominic Liberati")
	}
	{
		item = qs("\LDongWoo Thomas Shin\nDonovan Keele\nEric Feldman\nEric Milota")
	}
	{
		item = qs("\LFrancisco Mora\nGarett Jost\nGary Jesdanun\nGavin Pugh")
	}
	{
		item = qs("\LGenna Habibipour\nGeoffrey Inkel\nGiancarlo Surla\nGideon Stocek")
	}
	{
		item = qs("\LGreg Lopez\nGregory Kopina\nHari Khalsa\nIfedayo Ojomo")
	}
	{
		item = qs("\LIli Chiang\nJake Geiger\nJason Greenberg\nJason Maynard")
	}
	{
		item = qs("\LJason Uyeda\nJeff Swenty\nJeremiah Roa\nJeremy Page")
	}
	{
		item = qs("\LJeremy Rogers\nJessica Abroms\nJiwon Son\nJody Coglianese")
	}
	{
		item = qs("\LJoe Kirchoff\nJoe Pease\nJoel Jewett\nJohn ''Bunny'' Knutson")
	}
	{
		item = qs("\LJohn Webb\nJohnny Ow\nJon Bailey\nJordan Leckner")
	}
	{
		item = qs("\LJordan Sapp\nJosh Lord\nJun Hyuck Chang\nJustin Parish")
	}
	{
		item = qs("\LJustin Rote\nKarl Drown\nKen Moodie\nKendall Harrison")
	}
	{
		item = qs("\LKevin Chung\nKevin Mulhall\nKristin Gallagher\nKristina Adelmeyer")
	}
	{
		item = qs("\LKyle Johnson\nKyle Leonard\nKyle McKisic\nLars Kendall")
	}
	{
		item = qs("\LLe'Vere ''Lee'' Ross\nLisa Davies-Perissi\nLisa Perez\nLucy Andonian")
	}
	{
		item = qs("\LMarc DePeo\nMario Sanchez\nMark L. Scott\nMark Storie")
	}
	{
		item = qs("\LMatt Canale\nMatthew Jackowski\nMax Davidian\nMichael Bilodeau")
	}
	{
		item = qs("\LMichael Esposito\nMichael Friedrich\nMichael Winte\nMike Velasquez")
	}
	{
		item = qs("\LNathan Sisler\nNicholas E. Weaver\nNolan Nelson\nOrion Brown")
	}
	{
		item = qs("\LPam Detrich\nPat Connole\nPatrick Hagar\nPaul Interrante")
	}
	{
		item = qs("\LPaul Robinson\nPeter Day\nPeter Pon\nRandy Guillote")
	}
	{
		item = qs("\LRandy Mills\nRH Shih\nRiley Jewett\nRob T. Miller")
	}
	{
		item = qs("\LRobert Espinoza\nRobert Kim\nRock Gropper\nRulon Raymond")
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
		item = qs("\LStephanie Bayer\nStuart Scandrett\nTakashi Matsubara\nTed Barber")
	}
	{
		item = qs("\LThai Tran\nThomas Gawrys\nThomas Hong\nThomas Owen")
	}
	{
		item = qs("\LTimothy Rapp\nTim Stasica\nTina Stevenson\nTom Parker")
	}
	{
		item = qs("\LTony Solis\nTravis Chen\nWilson Truong\nZac Drake")
	}
	{
		item = qs("\LZach Parr\n\n\n")
	}
	{
		heading
		item = qs("\LAdditional\nDevelopment:\n\n")
	}
	{
		item = qs("\LAnthony Pesch\nBeth Cowling\nJacob Karesh\nJohn Sahas")
	}
	{
		item = qs("\LJohn Zagorski\nMark Wojtowicz\nOlin Georgescu\nRyan Ligon")
	}
	{
		heading
		item = qs("\LHardcore\nTesters:\n\n")
	}
	{
		item = qs("\LAbi Halo\nAdam Azami\nAdam Nelson\nAdry Walsh\nAndrew Colen")
	}
	{
		item = qs("\LAuston Jones\nBenjamin O'Brien\nBradley Lusenhop\nBrandon Tepezano\nBret Dubin")
	}
	{
		item = qs("\LClint Baptiste\nCorey Sullivan\nCurt Markwardt\nCurtis Pickrell\nDaniel Farina")
	}
	{
		item = qs("\LDaniel Lopez\nDavid Cramer\nDavid Delanty\nDavid Hyatt\nDuncan Brown")
	}
	{
		item = qs("\LEric Kiraly\nFrank Martinez\nGareth Davies\nGreg Spohn\nHelmo Cardenas")
	}
	{
		item = qs("\LIan Comi\nJacob Wilson\nJames Chen\nJames Gobert\nJames Rawlins")
	}
	{
		item = qs("\LJames Walker\nJamison Dyke\nJarod Long\nJarrett Loar\nJavier Feliz")
	}
	{
		item = qs("\LJeff Brys\nJeff Jaimes\nJefferson Kittell\nJeffrey Stanley\nJennifer Fusco")
	}
	{
		item = qs("\LJermaine Shockley\nJessica Hazlett\nJonathan Green\nJorge Aguayo\nJoshua Lewis")
	}
	{
		item = qs("\LJoshua Minette\nKami Talebi\nKen Ellis\nKevin Smith\nKhalin Mikkelsen")
	}
	{
		item = qs("\LKieron McKay\nKyle Novelli\nLee Ware\nLeroy Patterson\nMary Votava")
	}
	{
		item = qs("\LMathew Edwards\nMatthew Bravos\nMatthew Cutting\nMatthew Jones\nMoshe Chen")
	}
	{
		item = qs("\LNathan Makaryk\nNicholas Hayworth\nPeter Muravez\nRandall Becerra\nRaul Da Silva")
	}
	{
		item = qs("\LRion Jones\nRobert Byrd\nRobert Keating\nRonnie Stafford\nRyan Palys")
	}
	{
		item = qs("\LRyan Roderick\nSean Nagasawa\nSergio Pacheco\nShasta Rodriguez\nTiffani Burkett")
	}
	{
		item = qs("\LTim Flanagan\nTiron Quals\nTravis Ramon\nTristan Clark\nWesley Cook")
	}
	{
		item = qs("\LWilliam Widger\n\n\n\n")
	}
	{
		heading
		item = qs("\LAdditional\nTesting:\n\n")
	}
	{
		item = qs("\LJoseph Arco\nJimmy Nguyen\nRyan Clouse\n\n")
	}
	{
		heading
		item = qs("\LSpecial\nThanks:\n\n")
	}
	{
		item = qs("\LThe Team at AgoraGames\nSteve Ouimette\nJason Kocol\n")
	}
	{
		item = qs("\L\c3GL33k\n\c0Matt Piersall\nMarc Schafgen\nRandy Buck")
	}
	{
		item = qs("\L\c3Technicolor\n\c0Lydian Tone\nTom Hays\nAnthony Sorise")
	}
	{
		item = qs("\L\c3NASA\n\c0for imagery used in AMP Orbiter\nVisible Earth\n(http://visibleearth.nasa.gov/)")
	}
	{
		heading
		item = qs("\LData\nCapture\nPerformers:\n")
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
		item = qs("\L\c3Special Guests\n\c0Adam Levine\nTaylor Swift\n")
	}
	{
		item = qs("\LAdrian Young\nGwen Stefani\nTom Dumont\nTony Kanal")
	}
	{
		heading
		item = qs("\LVoice\nActing\n\n")
	}
	{
		item = qs("\L\c3Voice\nActor\n\c0Peter Lurie\n")
	}
	{
		item = qs("\L\c3Voice Casting:\n\c0PCB Productions\n\c3Talent Coordination:\n\c0Keith Arem")
	}
	{
		heading
		item = qs("\LPartners:\n\n\n")
	}
	{
		heading
		item = qs("\L\c3Coca-Cola\n\n\n")
	}
	{
		item = qs("\L©2009 The Coca-Cola Company.\n''Coca-Cola'' and the\nContour Bottle Design,\nare registered trademarks\nof The Coca-Cola Company.")
	}
	{
		heading
		item = qs("\LEndemics:\n\n\n")
	}
	{
		heading
		item = qs("\L\c3adidas\n\n\n")
	}
	{
		item = qs("\L© 2009 adidas America, Inc.,\nthe trefoil logo,\nand the 3-Stripes mark are\nregistered trademarks\nof the adidas Group.")
	}
	{
		heading
		item = qs("\L\c3AHEAD\n\n\n")
	}
	{
		item = qs("\L''AHEAD'' is\na registered\ntrademark of\nAHEAD\nPRODUCTS INC.")
	}
	{
		heading
		item = qs("\L\c3Ampeg\n\n\n")
	}
	{
		item = qs("\L''Ampeg'', ''SVT''\nand the Ampeg Logo\nare registered\ntrademarks of\nLOUD, Technologies, Inc.")
	}
	{
		heading
		item = qs("\L\c3Audio-Technica\n\n\n")
	}
	{
		item = qs("\L©2008 Audio-Technica U.S., Inc.,\nthe Audio-Technica name and logo\nare trademarks of\nAudio-Technica U.S., Inc.\nAll Rights Reserved.")
	}
	{
		heading
		item = qs("\L\c3Converse\n\n\n")
	}
	{
		item = qs("\LCONVERSE and\nALL STAR are\nregistered\ntrademarks of\nConverse Inc.")
	}
	{
		heading
		item = qs("\L\c3Daisy\nRock\n\n")
	}
	{
		item = qs("\LDAISY ROCK and Daisy,\nHeartbreaker, Star, Tomboy and\nSiren series guitars, and the distinctive\nheadstock designs used herein, are trademarks\nof DAISY ROCK. All rights reserved.")
	}
	{
		heading
		item = qs("\L\c3Divided by 13\n''The Sonic Difference''®\n\n")
	}
	{
		heading
		item = qs("\L\c3Dr.\nMartens\n\n")
	}
	{
		item = qs("\LThe Dr. Martens AirWair logo,\nDr. Martens, Doc's, DM's, Doc Martens\nand the ''Dr. Martens Air Cushion Sole''\nlogo are trademarks\nused under license.")
	}
	{
		item = qs("\LAirWair, ''Airware with Bouncing\nSoles'' and the 1460 boot\nlogo are trademarks of the\nR Griggs Group Ltd. and its\nsubsidiaries. All rights reserved")
	}
	{
		heading
		item = qs("\L\c3EMG\nPick-up\n\n")
	}
	{
		item = qs("\LEMG\nis a\nregistered\ntrademark\nof EMG Inc.")
	}
	{
		heading
		item = qs("\L\c3Ernie\nBall\n\n")
	}
	{
		item = qs("\LErnie Ball\nis a registered\ntrademark\nof Ernie\nBall Inc.")
	}
	{
		heading
		item = qs("\L\c3ESP &\nLTD\nbrands\n")
	}
	{
		item = qs("\LESP & LTD brands,\nmodel names and\nbody & headstock shapes are\nregistered trademarks of\nthe ESP Guitar Co. Inc.")
	}
	{
		heading
		item = qs("\L\c3ETNIES and\nEMERICA\n\n")
	}
	{
		item = qs("\LThe ''ETNIES'' and ''EMERICA''\ntrademarks featured or\ndepicted herewith are used\nunder license from\nSole Technology, Inc.")
	}
	{
		heading
		item = qs("\L\c3Guitar\nCenter\n\n")
	}
	{
		item = qs("\LGuitar Center® and\nthe Guitar Center® logo\nare registered trademarks of\nGuitar Center, Inc. and are\nused by permission, all rights reserved")
	}
	{
		heading
		item = qs("\L\c3Krank\n\n\n")
	}
	{
		item = qs("\LKrank Amplification is\na registered\ntrademark of\nKrank Amplification\nL.L.C.")
	}
	{
		heading
		item = qs("\L\c3MACKIE\n\n\n")
	}
	{
		item = qs("\LMACKIE loudspeakers,\nmixers and\nguitar amps make\nGuitar Heroes out of anyone:\nwww.mackie.com.")
	}
	{
		heading
		item = qs("\L\c3Marshall\n\n\n")
	}
	{
		item = qs("\LMarshall and\nthe Marshall logo\nare trademarks or\nregistered trademarks\nof Marshall Amplification plc.")
	}
	{
		heading
		item = qs("\L\c3McSwain\nGuitars\n\n")
	}
	{
		item = qs("\LMcSwain is a registered trademark\nof McSwain Guitars, Inc.\nThe Flame, Metal Inferno,\nThe Jonesy, The Machine, Life,\nand The Gunnar Bass are all")
	}
	{
		item = qs("\Lregistered with the\nUS Copyright Office.\nMcSwain Guitars would like to give a shout\nout to all my esteemed homies\nback in Gastonia, NC")
	}
	{
		heading
		item = qs("\L\c3Pork\nPie\n\n")
	}
	{
		item = qs("\LPork Pie\nis a registered\ntrademark of\nPork Pie\nPercussion Incorporated.")
	}
	{
		heading
		item = qs("\L\c3PRS\nGuitars\n\n")
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
		item = qs("\L\c3Regal\nTip\n\n")
	}
	{
		item = qs("\LRegal Tip\nis a\nregistered\ntrademark\n")
	}
	{
		heading
		item = qs("\L\c3Schecter\nGuitars\n\n")
	}
	{
		item = qs("\LSchecter Guitar Research, Diamond Series\nand the distinctive headstock design\nused herein are trademarks of\nSchecter Guitar Research, Inc.\nAll rights reserved.")
	}
	{
		heading
		item = qs("\L\c3Seymour\nDuncan\n\n")
	}
	{
		item = qs("\LSeymour Duncan, Blackouts,\nAntiquity, JB, '59, P-Rails\nand the stylized ''S'' logo are trademarks of\nSeymour Duncan and are used with permission.\nAll rights reserved.")
	}
	{
		heading
		item = qs("\L\c3Tama\nand\nIbanez\n")
	}
	{
		item = qs("\LTama and Ibanez\nare registered\ntrademarks of\nHoshino Gakki\nCol, ltd.")
	}
	{
		heading
		item = qs("\L\c3Taylor\nGuitars\n\n")
	}
	{
		item = qs("\LTAYLOR, TAYLOR GUITARS, TAYLOR SOLIDBODY,\nthe Taylor Peghead Shape Design, Taylor Bridge Design,\nand Taylor Pickguard Design are\nregistered trademarks of Taylor Guitars.\nAll rights reserved. ")
	}
	{
		heading
		item = qs("\L\c3Vans\n\n\n")
	}
	{
		item = qs("\L© 2009 Vans, Inc.\nAll Rights Reserved.\nVANS, the Vans logos, designs\nand model names herein\nare trademarks of Vans, Inc")
	}
	{
		heading
		item = qs("\L\c3Yamaha\n\n\n")
	}
	{
		item = qs("\LYamaha bass guitar designs\nand logos used herein are\nthe property of\nYamaha Corporation, Japan\nAll rights reserved.")
	}
	{
		heading
		item = qs("\L\c3Zildjian\n\n\n")
	}
	{
		item = qs("\LZildjian,\nand the stylized\nZildjian logo are registered\ntrademarks of the\nAvedis Zildjian Company")
	}
	{
		heading
		item = qs("\LActivision\nProduction:\n\n")
	}
	{
		item = qs("\L\c3Senior\nProducer\n\c0Jeremiah Maza\n")
	}
	{
		item = qs("\L\c3Associate\nProducer\n\c0Andrew Hoffacker\n")
	}
	{
		item = qs("\L\c3Production\nCoordinators\n\c0Billy Kaplan\nPeter Kavic")
	}
	{
		item = qs("\LJane Chung\n\n\n")
	}
	{
		item = qs("\L\c3Executive\nProducer\n\c0Jeff Matsushita\n")
	}
	{
		item = qs("\L\c3Vice\nPresident\nProduction\n\c0Keith Kirby")
	}
	{
		item = qs("\L\c3Head\nof\nProduction\n\c0Steve Ackrich")
	}
	{
		item = qs("\L\c3Additional\nProduction Support\n\c0Kragen Lum\nAaron Drayer")
	}
	{
		item = qs("\L\c0Chuck Park\nEric Grossman\nWill Townsend\nJohn C. Boone II")
	}
	{
		item = qs("\L\c0Alex Ortiz\nLorena Villa\nDoug Grutzmacher\nJared Yeager")
	}
	{
		item = qs("\L\c0Junko Nakamura\nJim Norris\nPhillip Greenspan\nDerek Dutilly")
	}
	{
		heading
		item = qs("\LMusic\nAffairs:\n\n")
	}
	{
		item = qs("\L\c3Vice President,\nMusic\nAffairs\n\c0Tim Riley")
	}
	{
		item = qs("\L\c3Sr. Manager,\nMusic\nAffairs\n\c0Brandon Young")
	}
	{
		item = qs("\L\c3Music\nSupervisor\n\c0Scott McDaniel\n")
	}
	{
		item = qs("\L\c3Audio\nAsset\nSpecialist\n\c0David Iscove")
	}
	{
		item = qs("\L\c3Music and\nLicensing Specialists\n\c0Jeremy Volk\nMike Phegley")
	}
	{
		item = qs("\L\c3Music\nCoordinator\n\c0Katie Sippel\n")
	}
	{
		heading
		item = qs("\LQuality\nAssurance:\n\n")
	}
	{
		item = qs("\L\c3VP Quality Assurance/\nCustomer Service\n\c0Paul Sterngold\nRich Robinson")
	}
	{
		heading
		item = qs("\LQA,\nFunctionality:\n\n")
	}
	{
		item = qs("\L\c3QA Project Leads\nDay Shift\n\c0Derek Faraci\nJosh Chandler")
	}
	{
		item = qs("\L\c3QA\nProject Lead\nNight Shift\n\c0José Juan Ornelas")
	}
	{
		item = qs("\L\c3QA Floor Leads\nDay Shift\n\c0Robert Hanscum\nKevin 'Dante' Tucker")
	}
	{
		item = qs("\L\c0Lee Staples\nAJ Jacobs\n\n")
	}
	{
		item = qs("\L\c3QA Floor Leads\nNight Shift\n\c0Chris Gerfen\nDidier Benitez")
	}
	{
		item = qs("\L\c0Roberto Benites\nOsvaldo Mejia\n\n")
	}
	{
		item = qs("\L\c3QA Database\nAdministrator\nDay Shift\n\c0Chris Kilian")
	}
	{
		item = qs("\L\c3QA Database\nAdministrator\nNight Shift\n\c0Dennis Soh")
	}
	{
		item = qs("\L\c3QA\nTesters\nDay Shift\n\c0Alfredo Barraza\nAnthony Randolph")
	}
	{
		item = qs("\LAshley Martin\nAustin Cammack\nBrandon Rojo\nCarson Derry\nChris Okano")
	}
	{
		item = qs("\LChristopher Chartchaiganan\nColt Carnes\nConor Metz\nCory Wyszynski\nDane De Forest")
	}
	{
		item = qs("\LDaniel Vazquez\nDwane Burgess\nEric Lanham\nGerman Gonzalez\nHenry Abrams")
	}
	{
		item = qs("\LJacob Goldman\nJed Galang\nJennifer Aguilar\nJoe Lozano\nJoi Tanner")
	}
	{
		item = qs("\LJonathan Cage\nJorge Diaz\nJose Ramirez\nJoseph Soccoccio\nKyle Bosman")
	}
	{
		item = qs("\LKyle Levitt\nMax Slosser\nRandall Brown\nRichard Gascon\nJose Ramirez")
	}
	{
		item = qs("\LJose Vega\nJoshua Medoza\nJuan Manuel Garcia\nKyle Hertz\nRob Lara")
	}
	{
		item = qs("\LRobert Sandoval\nRupert Singh\nTeresa Balwing\nTeresa Curry\nTim Peter")
	}
	{
		item = qs("\L\c3QA Testers\nNight Shift\n\c0Adrian Perez\nAkhil Conner\nAndres Navia")
	}
	{
		item = qs("\LAndrew Ramirez\nAnthony Bosco\nAnthony Gorski\nBenjamin Deutsch\nBernard Perlas")
	}
	{
		item = qs("\LBrian Conlisk\nBrittany Alexander\nByron Barrientos\nCaroline Hernandez\nChristopher Antes")
	}
	{
		item = qs("\LChristopher Davis\nConstantine Ananias\nCraig Baroody\nDaniel Martinez\nDaniel Pham")
	}
	{
		item = qs("\LDaniel Schueller\nDiego Carrillo\nDouglas James\nEarl Battice\nEarl Baylon")
	}
	{
		item = qs("\LElmer De Leon\nFrancisco Alfaro\nHarvey Bautista\nHugh MacNair\nIsaac Chung")
	}
	{
		item = qs("\LIsaiah Hayes\nJason Boggs\nJason Coleman\nJason Ruiz\nJeffery Katzenell")
	}
	{
		item = qs("\LJermaine Fordham\nJohn Garcia\nJonathan Villanueva\nJosé Brassea\nJulius Hipolito")
	}
	{
		item = qs("\LLeRon Ellis\nLuis Lector\nMarco Andrade\nMicah Hamilton\nMorgan Beilby")
	}
	{
		item = qs("\LNicholas Buckley\nNoah Ryan-Stout\nOsvaldo Gomez\nRalph Adaba\nRaphael Oseguera")
	}
	{
		item = qs("\LRoy Geer\nScott Clark\nSean Belloso\nShawn Alexander\nShawn Anderson")
	}
	{
		item = qs(0x72cbcc5e)
	}
	{
		item = qs(0x5403bfce)
	}
	{
		item = qs("\L\c3QA Senior\nProject Lead\nDay Shift\n\c0Thom Denick")
	}
	{
		item = qs("\L\c3QA Senior\nProject Lead\nNight Shift\n\c0Frank So")
	}
	{
		item = qs("\L\c3QA Manager,\nDay Shift\n\c0Jason Levine\n")
	}
	{
		item = qs("\L\c3QA Manager,\nNight Shift\n\c0Adam Hartsfield\n")
	}
	{
		heading
		item = qs("\LTechnical\nRequirements\nGroup:\n")
	}
	{
		item = qs("\L\c3Director\nQuality\nAssurance\n\c0Christopher Wilson")
	}
	{
		item = qs("\L\c3TRG\nManager\n\c0John Rosser\n")
	}
	{
		item = qs("\L\c3TRG Submissions\nLeads\n\c0Daniel L. Nichols\nChristopher Norman")
	}
	{
		item = qs("\L\c3TRG Submissions\nAdjutant\n\c0Dustin Carter\n")
	}
	{
		item = qs("\L\c3Sr. TRG\nPlatform Leads\n\c0Marc Villanueva\nTeak Holley")
	}
	{
		item = qs("\L\c0Kyle Carey\nJason Harris\nSasan Helmi\nTodd Sutton")
	}
	{
		item = qs("\L\c3TRG Platform Leads\n\c0Benjamin Abel\nJared Baca\nJames Rose")
	}
	{
		item = qs("\LBrian Bensi\nPaul Carrion\nTomohiro Shikami\nEric Stanzione")
	}
	{
		item = qs("\LZac Blitz\nMenas Kapitsas\n\n")
	}
	{
		item = qs("\L\c3TRG Testers\n\c0Jonathan Butcher\nRhonda Ramirez\nSantiago Salvador\nJessica Eckstein")
	}
	{
		item = qs("\LRichard Tom\nJacob Zwirn\nAlex Hirsch\nBrandon Miller\nPisoth Chham")
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
		item = qs("\LLacey Crawford\nAnthony Bellisario\nAlex Tomasino\nAntoine ''Bo'' Bohannon\nBryan Papa")
	}
	{
		item = qs("\LDaniel Fehskens\nEddie ''Fernando'' Araujo\nGary Rojas\nJeff Koyama\nJoe Pardo")
	}
	{
		item = qs("\LJustin Gogue\nLan Sha\nLucas Goodman\nMichael Laursen\nPatrick De Palma")
	}
	{
		item = qs("\LPeter Cho\nPhil Lawless\nRandall Lutcavich\nSteve McIlroy\nSteve Santarpia")
	}
	{
		item = qs("\LSteven Lin\nTomer Mor\nVincent Ju\n\n")
	}
	{
		heading
		item = qs("\LQA\nCode\nRelease\nGroup:")
	}
	{
		item = qs("\L\c3QA Certification\nLab Senior Leads\n\c0Brandon Valdez\nCyra Talton")
	}
	{
		item = qs("\L\c3QA Certification\nLab Project Lead\n\c0Fausto Lorenzano\n")
	}
	{
		item = qs("\L\c3QA CRG\nProject Lead\n\c0Matt Ryan\n")
	}
	{
		item = qs("\L\c3QA CRG\nFloor Lead\n\c0Jonathan Mack\n")
	}
	{
		item = qs("\L\c3QA CRG\nTester\n\c0Christian Vasco\n")
	}
	{
		heading
		item = qs("\LQA\nNetwork\nLab:\n")
	}
	{
		item = qs("\L\c3Manager\nQA\nOperations\n\c0Chris Keim")
	}
	{
		item = qs("\L\c3QA Network Lab\nProject Leads\n\c0Jessie Jones\nLeonard Rodriguez")
	}
	{
		item = qs("\L\c3QA\nNetwork Lab\nTester\n\c0Bryan Chice")
	}
	{
		heading
		item = qs("\LQA\nMultiplayer\nLab:\n")
	}
	{
		item = qs("\L\c3QA Multiplayer\nLab Lead\n\c0Garrett Oshiro\n")
	}
	{
		item = qs("\L\c3QA MPL\nSenior\nTester\n\c0Shamen'e Childress")
	}
	{
		item = qs("\L\c3QA MPL\nActing Floor Leads\n& Testers\n\c0Julio Medina\nBobby Jones")
	}
	{
		item = qs("\LJaemin Kang\nMatt Fawbush\nBrian Lay\nJohn Getty\nMatt Brannon")
	}
	{
		item = qs("\LTravis Otten\nBruce James\nNick Gram\nMario Ibarra\nJon Bunch")
	}
	{
		item = qs("\LJason Komen\nRichard Salmon\nMikey Ackland\n\n")
	}
	{
		heading
		item = qs("\LQA Audio\nVisual\nLab:\n")
	}
	{
		item = qs("\L\c3QA AV Lab\nProject\nLead\n\c0Victor Durling")
	}
	{
		item = qs("\L\c3QA AV Lab\nSenior\nTester\n\c0Cliff Hooper")
	}
	{
		item = qs("\L\c3QA AV Lab\nTesters\n\c0Delven Rutledge\nRyan Visteen")
	}
	{
		heading
		item = qs("\LQA\nMastering\nLab:\n")
	}
	{
		item = qs("\L\c3Senior\nManager\nQA Technologies\n\c0Indra Yee")
	}
	{
		item = qs("\L\c3Mastering\nLab\nSupervisor\n\c0John Donnelly")
	}
	{
		item = qs("\L\c3Senior\nMastering\nLab Technician\n\c0Sean Kim")
	}
	{
		item = qs("\L\c3Mastering Lab\nTechnicians\n\c0Tyree Deramus\nDanny Feng")
	}
	{
		item = qs("\L\c0Douglas Hernandez\nJose Hernandez\nKai Hsu\nRodrigo Magana")
	}
	{
		item = qs("\L\c0Steven Rodriguez\nLeejay Ronquillo\nOrbel Shakhmalian\nGary Washington")
	}
	{
		heading
		item = qs("\LQA-MIS:\n\n\n")
	}
	{
		item = qs("\L\c3Senior\nManager\nQA Technologies\n\c0Indra Yee")
	}
	{
		item = qs("\L\c3QA-MIS\nManager\n\c0Dave Garcia-Gomez\n")
	}
	{
		item = qs("\L\c3QA-MIS\nTechnicians\n\c0Chris Gill\nTeddy Hwang")
	}
	{
		item = qs("\L\c0Brian Martin\nJeremy Torres\nLawrence Wei\nLovely Morata")
	}
	{
		item = qs("\L\c0Neil Nikaido\n\n\n")
	}
	{
		item = qs("\L\c3Technology\nTechnician\n\c0Sean Olson\n")
	}
	{
		item = qs("\L\c3QA-MIS\nEquipment Coordinators\n\c0Long Le\nColeman Thaxton III")
	}
	{
		heading
		item = qs("\LQA Database\nAdministration\nGroup:\n")
	}
	{
		item = qs("\L\c3Senior Lead\nDatabase\nAdministrator\n\c0Jeremy Richards")
	}
	{
		item = qs("\L\c3Lead\nDatabase\nAdministrator\n\c0Kelly Huffine")
	}
	{
		item = qs("\L\c3Database\nTechnicians\n\c0Christopher Shanley\nTimothy Toledo")
	}
	{
		item = qs("\L\c3DBA\nSenior\nTester\n\c0Wayne Williams")
	}
	{
		item = qs("\L\c3DBA Testers\n\c0Randi Williams-Pardo\nRichard Ledesma\nDaniel Kim")
	}
	{
		item = qs("\L\c0David Trinh\n\n\n")
	}
	{
		heading
		item = qs("\LQA\nOperations\nGroup:\n")
	}
	{
		item = qs("\L\c3Director\nQA\nOperations\n\c0George Viegas")
	}
	{
		item = qs("\L\c3Operations\n& Planning\nSupervisor\n\c0Jeremy Shortell")
	}
	{
		item = qs("\L\c3Operations\nAssociate\n\c0Paul Colbert\n")
	}
	{
		heading
		item = qs("\LCustomer\nSupport:\n\n")
	}
	{
		item = qs("\L\c3Customer Support\nManagers\n\c0Gary Bolduc\nMichael Hill")
	}
	{
		heading
		item = qs("\LQA\nThanks:\n\n")
	}
	{
		item = qs("\LAbby Alvarado\nNuria Andres\nBrian Carlson\nMichael Clarke\nRandolph d'Amore")
	}
	{
		item = qs("\LSeth d'Amore\nMaria Gonzalez\nRachel Overton\nTracy Sheppard\nJacqueline Jolie Sheltmire")
	}
	{
		item = qs("\LNadine Theuzillot\nJennifer Vitiello\nMarc Williams\nMichelle Houang\nJessica Williams")
	}
	{
		item = qs("\LPaul Williams\nAlbert Yao\nDong Fan\nSteve Peñate\nAnthony Korotko")
	}
	{
		item = qs("\LLauren Chandler\nDevin Faraci\nAngela Brizuela\n\n")
	}
	{
		heading
		item = qs("\LProduction\nServices\nEurope:\n")
	}
	{
		item = qs("\L\c3Sr. Director of\nProduction Services\nEurope\n\c0Barry Kehoe")
	}
	{
		item = qs("\L\c3Localisation\nManager\n\c0Fiona Ebbs\n")
	}
	{
		item = qs("\L\c3Localisation\nProject Manager\n\c0Bobby Henderson\nJack O'Hara")
	}
	{
		item = qs("\L\c3Localisation\nQA\nManager\n\c0David Hickey")
	}
	{
		item = qs("\L\c3Localisation\nQA\nLead\n\c0Dominik Hilse")
	}
	{
		item = qs("\L\c3Localisation\nQA Floor Leads\n\c0Franck Morisseau\nDavid Arias")
	}
	{
		item = qs("\L\c3Localisation\nQA Testers\n\c0Teresa Mahrer\nMarcell Witek\nEsther Reimann")
	}
	{
		item = qs("\LJuergan Roeder\nKerill Meier O'Brien\nFranck Morrisseau\nDavid Arias\nJeremy Fantoni")
	}
	{
		item = qs("\LYves Saliou\nNora Menoumi\nStephanie Breda\nHugues Dumba\nSebastien Le Port")
	}
	{
		item = qs("\LMagdeline Champarnaud\nDaniele Celeghin\nClaudio Perazzo\nRoberto Schiavulli\nFranco Contessa")
	}
	{
		item = qs("\LGraziano Muscas\nDominic Hilse\nJuan Rodes-Arnau\nLuis Hernandez Dalmau\nUrtzi Goikoetxea")
	}
	{
		item = qs("\LDiana Xifre de la Prada\nAroia Murua\nShane Kerr\nDominic Byrne\n")
	}
	{
		item = qs("\L\c3Burn Lab\nTechnicians\n\c0Isha Jain\nFlaminio Pieralisi")
	}
	{
		item = qs("\L\c3IT\nNetwork\nTechnician\n\c0Fergus Lindsay")
	}
	{
		item = qs("\L\c3Localisation\nTools & Support\nProvided by\n\c0Stephanie Deming & XLOC, Inc")
	}
	{
		heading
		item = qs("\LGlobal\nBrand\nManagement:\n")
	}
	{
		item = qs("\L\c3Director\nGlobal Brand\nManagement\n\c0Amy Longhi")
	}
	{
		item = qs("\L\c3Global\nBrand Manager\n\c0Kristin Pagano\n")
	}
	{
		item = qs("\L\c3Associate\nBrand Manager\n\c0Matthew Cox\n")
	}
	{
		item = qs("\L\c3Team\nAssistant\n\c0Catherine Mangan\n")
	}
	{
		heading
		item = qs("\LPR:\n\n\n")
	}
	{
		item = qs("\L\c3Vice President\nPR\n\c0Eric Hollreiser\n")
	}
	{
		item = qs("\L\c3PR\nDirector\n\c0Ryh-Ming C. Poon\n")
	}
	{
		item = qs("\L\c3PR\nManager\n\c0Natalie Salzman DaRosa\n")
	}
	{
		item = qs("\L\c3Senior\nPublicist\n\c0Sean Maggard\n")
	}
	{
		item = qs("\L\c3Publicist\n\c0Lindsay Morio\n\n")
	}
	{
		item = qs("\L\c3Junior\nPublicist\n\c0Karen Fujimoto\n")
	}
	{
		item = qs("\L\c3PR\nCoordinator\n\c0Andrew Meyer\n")
	}
	{
		item = qs("\L\c3Global\nAsset\nManager\n\c0Karen Yi")
	}
	{
		heading
		item = qs("\LCreative\nServices:\n\n")
	}
	{
		item = qs("\L\c3Creative\nServices\nManager\n\c0Mike Doan")
	}
	{
		item = qs("\L\c3Web\nDesigner\n\c0Jennifer Nakamura\n")
	}
	{
		item = qs("\L\c3Graphic\nDesigners\n\c0Maly Bun\nMinna Hu")
	}
	{
		item = qs("\L\c0Damon Belanger\nJonathan Valiente\n\n")
	}
	{
		heading
		item = qs("\LHardware:\n\n\n")
	}
	{
		item = qs("\L\c3VP\nHardware\n\c0Lee Guinchard\n")
	}
	{
		item = qs("\L\c3Executive\nProducer\nHardware\n\c0Steve Withers")
	}
	{
		item = qs("\L\c3Electronics\nEngineering\nDirector\n\c0Duncan Miller")
	}
	{
		item = qs("\L\c3Director\nof\nHardware\n\c0Carter Lee")
	}
	{
		item = qs("\L\c3Hardware\nProgram\nDirector\n\c0David Dykes")
	}
	{
		item = qs("\L\c3Principal\nElectronics\nEngineer\n\c0Tim Clark")
	}
	{
		item = qs("\L\c3Senior\nProducer\n\c0Cendru Engstrom\n")
	}
	{
		item = qs("\L\c3Producer\n\c0Ted Lange\n\n")
	}
	{
		item = qs("\L\c3Production\nEngineering\nManager\n\c0Jared Chan")
	}
	{
		item = qs("\L\c3Mechanical\nEngineering\nManager\n\c0Colin Zen")
	}
	{
		item = qs("\L\c3Electronics\nEngineering\nManager\n\c0Thomas Tan")
	}
	{
		item = qs("\L\c3Product\nDesigner\n\c0Cody Lee\n")
	}
	{
		item = qs("\L\c3Electronics\nEngineer\n\c0Bashir Ziady\nBing Xu")
	}
	{
		item = qs("\L\c3Mechanical\nEngineer\n\c0Music Xu\nDavid Zhu")
	}
	{
		item = qs("\L\c3Certification\nManager\n\c0Shelly Zhou\n")
	}
	{
		item = qs("\L\c3Firmware\nEngineer\n\c0Herman Liu\n")
	}
	{
		item = qs("\L\c3Production\nEngineer\n\c0Fox Duan\nPeak Tan")
	}
	{
		item = qs("\L\c3Production\nConsultant\n\c0Chris Foulger\n")
	}
	{
		item = qs("\L\c3Hardware\nProduct\nCoordinators\n\c0Casimero Agustin Jr.")
	}
	{
		item = qs("\L\c0Raul Renteria\nMark Johnson\nBetty Shang\n")
	}
	{
		item = qs("\L\c3Administrator\n\c0June Xie\n\n")
	}
	{
		heading
		item = qs("\LManagement:\n\n\n")
	}
	{
		item = qs("\L\c3Sr.\nVice President\nPublishing\n\c0Will Kassoy")
	}
	{
		item = qs("\L\c3Sr.\nVice President\nProduction\n\c0Laird Malamed")
	}
	{
		item = qs("\L\c3Business Development\nand Downloadable\nContent\n\c0Matthew Allen")
	}
	{
		item = qs("\L\c3Founder\n\c0Kai Huang\n\n")
	}
	{
		item = qs("\L\c3Founder/VP\nBusiness\nDevelopment\n\c0Charles Huang")
	}
	{
		item = qs("\L\c3President\nCEO\n\c0Dan Rosenweig\n")
	}
	{
		item = qs("\L\c3Executive\nAssistant\n\c0Trina Deakin\n")
	}
	{
		item = qs("\L\c3Executive\nAssistant\n\c0Heather Porter\n")
	}
	{
		item = qs("\L\c3Licensing\nAssociate\n\c0Chris Larkin\n")
	}
	{
		item = qs("\L\c3Sr. Vice\nPresident\nFinance\n\c0Brian Kesterson")
	}
	{
		item = qs("\L\c3Controller\n\c0Monika Agarwal\n\n")
	}
	{
		item = qs("\L\c3Sr. Financial\nAnalysts\n\c0Kevin Lurie\nLu Truong")
	}
	{
		item = qs("\L\c3Sr.\nAccountant\n\c0Tina Xu\n")
	}
	{
		heading
		item = qs("\LE-Commerce:\n\n\n")
	}
	{
		item = qs("\L\c3Sr.\nE-Commerce\nManager\n\c0Michael Pan")
	}
	{
		item = qs("\L\c3Online\nMarketing\nSpecialist\n\c0David Hsu")
	}
	{
		item = qs("\L\c3E-Commerce\nAssistant\n\c0Hana Sakamoto\n")
	}
	{
		item = qs("\L\c3Customer\nService\nManager\n\c0Joe Mijares")
	}
	{
		item = qs("\L\c3Customer\nSupport\nTeam\n\c0Mike Dangerfield")
	}
	{
		item = qs("\L\c0Ashley Deakin\nMarshannon Powell\nMealnie Porzio\n")
	}
	{
		item = qs("\L\c3Webmaster\n\c0Suky Wong\n\n")
	}
	{
		item = qs("\L\c3The rest at\nGuitar Hero Business Unit,\nspecifically\n\c0John Devecka")
	}
	{
		heading
		item = qs("\LGuitar Hero\nBusiness Unit\nwould like\nto thank:")
	}
	{
		item = qs("\L\c0Lillian Qian\nKaylan Huang\nCharley Huang\nSimon Huang\nLily Huang")
	}
	{
		item = qs("\L\c0Ethan Huang\nSamantha Chien\nSkye Lang\nDream lange\nDorothy Yang")
	}
	{
		item = qs("\L\c0The Juco Family\nMB&GB:Da Bears\nThe Larkin Family\nFreddie Arnott\nGrey Hawke")
	}
	{
		item = qs("\L\c0Hunter Watson\nMatthew Salutillo\nDennis Goh\nCynthia Montijo\nCarol D'Eath")
	}
	{
		item = qs("\L\c0Ryan Wener\nDoug McCracken\nMichael Steiner\nJanice Loughman\nKonrad Ribeiro")
	}
	{
		item = qs("\L\c0Brandon Zien\nEvelyn Mendez\nAmondo Redmond\nDana Buchman\nJessie Wan")
	}
	{
		item = qs("\L\c0Jordan Dodge\nAaron Grant\n\n\n")
	}
	{
		heading
		item = qs("\LActivision\nBusiness\n& Legal\nAffairs:")
	}
	{
		item = qs("\L\c3Sr. Vice\nPresident\n& General Counsel\n\c0Greg Deutsch")
	}
	{
		item = qs("\L\c3Director\nGovernment and\nLegislative Affairs\n\c0Philip Terzian")
	}
	{
		item = qs("\L\c3Sr. Counsel\nBusiness &\nLegal Affairs\n\c0Mary Tuck")
	}
	{
		item = qs("\L\c3Transactional\nCounsel\n\c0Travis Stansbury\n")
	}
	{
		item = qs("\L\c3Senior\nParalegal\n\c0Kap Kang\n")
	}
	{
		item = qs("\L\c3Sr. Director\nof Production\nServices\n\c0Suzan Rude")
	}
	{
		heading
		item = qs("\LActivision\nCentral\nDesign and\nPlaytesting:")
	}
	{
		item = qs("\L\c3Sr. Director,\nGame Design\n\c0Carl Schnurr\n")
	}
	{
		item = qs("\L\c3Sr. Director,\nTechnology\n\c0Matt Wilkinson\n")
	}
	{
		item = qs("\L\c3Director,\nTechnology\n\c0Pat Griffith\n")
	}
	{
		item = qs("\L\c3Sr. VP\nof Technology\n\c0Steve Pearce\n")
	}
	{
		item = qs("\L\c3VP,\nTechnology\n\c0John Bojorquez\n")
	}
	{
		item = qs("\L\c3Sr. Manager\nCentral User\nTesting\n\c0Ray Kowalewski")
	}
	{
		item = qs("\L\c3User\nTesting\nSupervisor\n\c0Phil Keck")
	}
	{
		item = qs("\L\c3User\nTesting\nModerator\n\c0Vincent Edwards")
	}
	{
		item = qs("\L\c0Jeffrey Fletcher\nMichael LaMarr\nJohn Terceman\n")
	}
	{
		heading
		item = qs("\LCentral\nAudio:\n\n")
	}
	{
		item = qs("\L\c3Director,\nCentral\nAudio\n\c0Adam Levenson")
	}
	{
		item = qs("\L\c3Sound\nArtist\n\c0Trevor Bresaw\n")
	}
	{
		item = qs("\L\c3Talent\nAssociate\n\c0Noah Sarid\n")
	}
	{
		item = qs("\L\c3Talent\nCoordinator\n\c0Stefani Jones\n")
	}
	{
		item = qs("\L\c3Audio\nProgrammer\n\c0Blair Bitoni\n")
	}
	{
		heading
		item = qs("\LBusiness\nDevelopment:\n\n")
	}
	{
		item = qs("\L\c3Head of\nBusiness\nDevelopment\n\c0Dave Anderson")
	}
	{
		item = qs("\L\c3Corporate\nAlliances\n\c0Yasmine Benyamini\nTim Steudler")
	}
	{
		heading
		item = qs("\LActivision\nSpecial\nThanks:\n")
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
		item = qs("\LKathryn Murray\nChris Cosby\nBrenda Lindsay\nAlex Mahlke\nSheilah Brooks")
	}
	{
		heading
		item = qs("\LDemonWare:\n\n\n")
	}
	{
		item = qs("\LNadia Alramli\nDavid ''REspawn'' Brennan\nMorgan Brickley\nLuke Burden\nAaron Burt")
	}
	{
		item = qs("\LDavid Cahill\nMichael Collins\nTim Czerniak\nBrendan Dillon\nMalcolm Dows")
	}
	{
		item = qs("\LJonathan Frawley\nPaul Froese\nEoghan Gaffney\nArther Green\nPadraic Hallinan")
	}
	{
		item = qs("\LSteffen Higel\nTony Kelly\nJohn Kirk\nLance Laursen\nCraig McInnes")
	}
	{
		item = qs("\LIan McLeod\nEoin O'Fearghail\nByron Pile\nRuaidhrí Power\nFrancesco Riggi")
	}
	{
		item = qs("\LTilman Schäefer\nGordon Schneider\nAmy Smith\nRonny Southwood\nEmmanuel Stone")
	}
	{
		item = qs("\LJason ''Hagao'' Wei\nChristopher Werner\nPeter Wright\n\n")
	}
	{
		heading
		item = qs("\LAnimated\nsequences by\nSix Point Harness:\n")
	}
	{
		item = qs("\L\c3Supervising\nProducer\n\c0Andy Fiedler\n")
	}
	{
		item = qs("\L\c3Producer\n\c0Brendan Burch\n\n")
	}
	{
		item = qs("\L\c3Supervising\nDirector\n\c0James Krenzke\n")
	}
	{
		item = qs("\L\c3Art\nDirector\n\c0Saharat Tantivaranyoo\n")
	}
	{
		item = qs("\L\c3Background\nDesigner\n\c0Angelo Vilar\n")
	}
	{
		item = qs("\L\c3Background\nPainter\n\c0Gerald De Jesus\n")
	}
	{
		item = qs("\L\c3Backgrounds\n\c0Gerald De Jesus\n\n")
	}
	{
		item = qs("\L\c3Storyboards\n\c0Saharat Tantivaranyoo\nAngelo Vilar\nGerald De Jesus")
	}
	{
		item = qs("\L\c3Layout\nArtists\n\c0Chris Toms\nJulia Vickerman")
	}
	{
		item = qs("\L\c0Saharat Tantivaranyoo\nSeth Cooper\nMike Nassar\nAngelo Vilar")
	}
	{
		item = qs("\L\c0Eric Bauza\nRafael Hurtado\nBraden Poirier\nJonathan Coit")
	}
	{
		item = qs("\L\c3Production\nAssistant\n\c0Mike Nassar\n")
	}
	{
		item = qs("\L\c3Lead\nAnimator\n\c0James Krenzke\n")
	}
	{
		item = qs("\L\c3Animators\n\c0Julia Vickerman\nMichael Huang\nEd Skudder")
	}
	{
		item = qs("\L\c0Jaime Velasquez\nMac Whiting\nGreg Franklin\nMike Nassar")
	}
	{
		item = qs("\L\c0Seth Cooper\n\n\n")
	}
	{
		item = qs("\L\c3Efx\nAnimator\n\c0Ed Skudder\n")
	}
	{
		item = qs("\L\c33D\nAnimation\n\c0Jacob Bergman\nKenny Roy")
	}
	{
		item = qs("\L\c3Editorial/\nCompositing\n\c0Tony Christopherson\n")
	}
	{
		item = qs("\L\c3After\nEffects\nEditor\n\c0Tony Christopherson")
	}
	{
		item = qs("\L\c3Pre-Production\nSupervisor\n\c0Dave Vamos\n")
	}
	{
		item = qs("\L\c3Accounting\n\c0Robin Hewitt\n\n")
	}
	{
		item = qs("\L\c5Additional\nCompositions\nCreated by\n\c0Isaac Sprintis")
	}
	{
		item = qs("\L\c5Performed by\n\c0Isaac Sprintis\nMorgan Miracle\n")
	}
	{
		heading
		item = qs("\LMusic:\n\n\n")
	}
	{
		heading
		item = qs("\L\c3''A Million Ways''\n\n\n")
	}
	{
		item = qs("\LPerformed by OK Go\nWritten by Damian Kulash and\nTimothy Nordwind\nPublished by\nOK Go Publishing  (BMI)")
	}
	{
		item = qs("\LCourtesy of Capitol Records\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''ABC''\n\n\n")
	}
	{
		item = qs("\LPerformed by Jackson 5\nWritten by Berry Gordy Jr.,\nAlphonso Mizell, Frederick Perren\nand Deke Richards\nPublished by")
	}
	{
		item = qs("\LJobete Music Co., Inc. (ASCAP)\nCourtesy of Motown Records\nUnder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission")
	}
	{
		heading
		item = qs("\L\c3''The Adventure''\n\n\n")
	}
	{
		item = qs("\LPerformed by Angels & Airwaves\nWritten by Tom De Longe\nPublished by\nUniversal Music Corp.\nCourtesy of Geffen Records")
	}
	{
		item = qs("\Lunder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.\n")
	}
	{
		heading
		item = qs("\L\c3''American Pie''\n\n\n")
	}
	{
		item = qs("\LPerformed by Don McLean\nWritten by Don McLean\nPublished by\nSongs of Universal, Inc. \no/b/o itself and Benny Bird Co., Inc.")
	}
	{
		item = qs("\LCourtesy of Capitol Records\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Angels of\nthe Silences''\n\n")
	}
	{
		item = qs("\LPerformed by Counting Crows\nWritten by David Bryson,\nAdam Duritz, Charles Gillingham,\nMatthew Malley, Ben Mize\nand Daniel Vickrey")
	}
	{
		item = qs("\LPublished by EMI Blackwood Music Inc. (BMI)\nCourtesy of Interscope Records\nUnder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Back Again''\n\n\n")
	}
	{
		item = qs("\LPerformed by Parachute\nWritten by William Anderson\nPublished by How It Should Be Music (BMI)\nCourtesy of\nUniversal Records")
	}
	{
		item = qs("\LUnder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.\n")
	}
	{
		heading
		item = qs("\L\c3''Bad\nReputation''\n\n")
	}
	{
		item = qs("\LPerformed by Joan Jett\nWritten by Joan Jett,\nKenny Laguna, Ritchie Cordell,\nMartin Kupersmith\nPublished by")
	}
	{
		item = qs("\LJett Pack Music, Inc.\nCourtesy of\nBlackheart Records\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Beautiful Soul''\n\n\n")
	}
	{
		item = qs("\LPerformed by Jesse McCartney\nWritten by Andy Dodd\nand Adam Watts\nPublished by\nSeven Peaks Music o/b/o itself,")
	}
	{
		item = qs("\LDodd Music & Dying Ego Music (ASCAP)\nCourtesy of\nHollywood Records\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Believe''\n\n\n")
	}
	{
		item = qs("\LPerformed by The Bravery\nWritten by Samuel Endicott\nPublished by\nChrysalis Songs on behalf of\nAmalfi Coast Music (BMI)")
	}
	{
		item = qs("\LCourtesy of\nThe Island Def Jam Music Group\nUnder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Black Cat''\n\n\n")
	}
	{
		item = qs("\LPerformed by Janet Jackson\nWritten by Janet Jackson\nPublished by\nBlack Ice Publishing (BMI)\nCourtesy of A&M Records")
	}
	{
		item = qs("\LUnder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.\n")
	}
	{
		heading
		item = qs("\L\c3''Black Horse And\nThe Cherry Tree''\n\n")
	}
	{
		item = qs("\LPerformed by KT Tunstall\nWritten by Katie Tunstall\nPublished by Sony/ATV Tunes LLC\no/b/o Sony/ATV\nMusic Publishing UK Ltd.")
	}
	{
		item = qs("\LCourtesy of Jaydone Ltd\nTrading as Relentless Records\nUnder exclusive licence to\nVirgin Records Ltd\nUnder license from")
	}
	{
		item = qs("\LEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.\n\n")
	}
	{
		heading
		item = qs("\L\c3''Bring Me\nTo Life''\n\n")
	}
	{
		item = qs("\LPerformed by Evanescence\nWritten by Amy Lee,\nBen Moody and David Hodges\nPublished by\nForthefallen Publishing (BMI) &")
	}
	{
		item = qs("\LZombies Ate My Publishing (BMI) &\nFSMGI (IMRO), all rights administered by\nState One Music America (BMI).\nCourtesy of Wind-Up Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Dirty\nLittle\nSecret''\n")
	}
	{
		item = qs("\LPerformed by The All-American Rejects\nWritten by Tyson Ritter and Nick Wheeler\nPublished by Universal Music -\nMGB Songs o/b/o itself\nand Smells Like Phys Ed Music")
	}
	{
		item = qs("\LCourtesy of Interscope Records\nunder license from\nUniversal Music Enterprises\nAll Rights Reserved\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Do You\nReally Want\nTo Hurt Me''\n")
	}
	{
		item = qs("\LPerformed by Culture Club\nWritten by Michael Craig,\nRoy Hay, Jonathan Moss\nand George O'Dowd. Published by\nEMI Virgin Music, Inc. (ASCAP)")
	}
	{
		item = qs("\LCourtesy of Virgin Records, Ltd.\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Don't Speak''\n\n\n")
	}
	{
		item = qs("\LPerformed by No Doubt\nWritten by Eric Stefani and\nGwen Stefani. Published by\nUniversal Music Corp.\no/b/o itself and Knock Yourself Out Music")
	}
	{
		item = qs("\LCourtesy of Interscope Records\nUnder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Every Rose\nHas Its Thorn''\n\n")
	}
	{
		item = qs("\LPerformed by Poison\nWritten by Bobby Dall,\nBret Michaels, C.C. Deville\nand Rikki Rockett. Published by\nUniversal Music -")
	}
	{
		item = qs("\LZ Songs o/b/o Cyanide Publ.\nCourtesy of Capitol Records\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Fascination''\n\n\n")
	}
	{
		item = qs(0xedde3a64)
	}
	{
		item = qs("\LCopenhagen Records\nand EMI Records Ltd.\nAll Rights Reserved.\nUsed by Permission.\n")
	}
	{
		heading
		item = qs("\L\c3''Gasoline''\n\n\n")
	}
	{
		item = qs("\LPerformed by The Airborne Toxic Event\nWritten by Noah Harmon and Mikel Jollett\nPublished by Primary Wave Music\nCourtesy of\nThe Island Def Jam Music Group")
	}
	{
		item = qs("\LUnder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.\n")
	}
	{
		heading
		item = qs("\L\c3''Hands Down''\n\n\n")
	}
	{
		item = qs("\LPerformed by Dashboard Confessional\nWritten by Christopher Carrabba\nPublished by Universal Music Corp.\no/b/o itself and\nHey Did She Ask About Me Music")
	}
	{
		item = qs("\LCourtesy of Interscope Records\nUnder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Hang Me\nUp To Dry''\n\n")
	}
	{
		item = qs("\LPerformed by Cold War Kids\nWritten by Matthew Aveiro,\nMatthew Maust, Jonathan Russell\nand Nathan Willett\nPublished by")
	}
	{
		item = qs("\LDowntown Music Publishing\no/b/o DLJ Songs (ASCAP) and\nBayou Psalms (ASCAP)\nCourtesy of Downtown Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Happy Together''\n\n\n")
	}
	{
		item = qs("\LPerformed by The Turtles\nWritten by Alan Gordon and Garry Bonner\nPublished by Alley Music Corp.\nc/o Carlin America Inc. and\nBug Music - Trio Music Company (BMI)")
	}
	{
		item = qs("\LCourtesy of Flo & Eddie, Inc.\nAll Rights Reserved.\nUsed by Permission.\n\n")
	}
	{
		heading
		item = qs("\L\c3''Honky Tonk Women''\n\n\n")
	}
	{
		item = qs("\LPerformed by The Rolling Stones\nWritten by Mick Jagger and Keith Richards\nPublished by ABKCO Music, Inc\nCourtesy of ABKCO Music & Records, Inc.\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''I Heard It Through\nThe Grapevine''\n\n")
	}
	{
		item = qs("\LPerformed by Marvin Gaye\nWritten by Barrett Strong and\nNorman Whitfield. Published by\nStone Agate Music\n(A Division of Jobete Music Co., Inc.) (BMI)")
	}
	{
		item = qs("\LCourtesy of Motown Records\nUnder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''I Want You\nTo Want Me''\n(Live)\n")
	}
	{
		item = qs("\LPerformed by Cheap Trick\nWritten by Rick Nielsen\nPublished by Adult Music/Screen Gems-EMI Music Inc. (BMI)\nRecording Courtesy of Cheap Trick Unlimited, Inc.\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''If You Could\nOnly See''\n\n")
	}
	{
		item = qs("\LPerformed by Tonic\nWritten by Emerson Hart\nPublished by EMI Blackwood Music Inc. (BMI)\nCourtesy of Universal Records\nUnder license from")
	}
	{
		item = qs("\LUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.\n\n")
	}
	{
		heading
		item = qs("\L\c3''The Impression\nThat I Get''\n\n")
	}
	{
		item = qs("\LPerformed by Mighty Mighty Bosstones\nWritten by Richard Barrett and Joseph Gittleman\nPublished by EMI April Music Inc. (ASCAP)\nCourtesy of The Island Def Jam Music Group\nUnder license from")
	}
	{
		item = qs("\LUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.\n\n")
	}
	{
		heading
		item = qs("\L\c3''In a Big Country''\n\n\n")
	}
	{
		item = qs("\LPerformed by Big Country\nWritten by Stuart Adamson,\nMark Brzezicki, Anthony Butler\nand Bruce Watson. Published by\nEMI Virgin Music, Inc. (ASCAP)")
	}
	{
		item = qs("\LCourtesy of Mercury Records Limited\nUnder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Just A Girl''\n\n\n")
	}
	{
		item = qs("\LPerformed by No Doubt\nWritten by Tom Dumont and Gwen Stefani\nPublished by Songs of Universal, Inc.\no/b/o itself and Crazy Velcro Music / Universal Music Corp.\no/b/o itself and Knock Yourself Out Music")
	}
	{
		item = qs("\LCourtesy of Interscope Records\nUnder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Kids''\n\n\n")
	}
	{
		item = qs("\LPerformed by Robbie Williams and\nKylie Minogue. Written by\nRobbie Williams and Guy Chambers\nPublished by EMI Virgin Music, Inc. (ASCAP)\nand Guy Chambers Administered")
	}
	{
		item = qs("\Lby Kobalt Music Publishing America, Inc.\nCourtesy of Chrysalis Records\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Kung Fu\nFighting''\n\n")
	}
	{
		item = qs("\LPerformed by Carl Douglas\nWritten by Carl Douglas\nPublished by Edition Carren / SMV Schacht\nMusikverlage GmbH & Co. KG. Courtesy of Edition Carren / SMV\nSchacht Musikverlage GmbH & Co. KG")
	}
	{
		item = qs("\LAll Rights Reserved.\nUsed by Permission.\n\n\n")
	}
	{
		heading
		item = qs("\L\c3''L.E.S. Artistes''\n\n\n")
	}
	{
		item = qs("\LPerformed by Santigold\nWritten by John Hill and Santi White\nPublished by\nDowntown Music Publishing\no/b/o DLJ Songs (ASCAP), Little Jerk (ASCAP)")
	}
	{
		item = qs("\Land EMI April Music Inc. (ASCAP)\nCourtesy of\nDowntown Records/Lizard King\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Let's Dance''\n\n\n")
	}
	{
		item = qs("\LPerformed by David Bowie\nWritten by David Bowie\nPublished by\nJones Music America (ASCAP)\nadmin. by ARZO Publishing")
	}
	{
		item = qs("\LCourtesy of RZO Music\nAll Rights Reserved.\nUsed by Permission.\n\n")
	}
	{
		heading
		item = qs("\L\c3''Lifeline''\n\n\n")
	}
	{
		item = qs("\LPerformed by Papa Roach\nWritten by David Buckner,\nTobin Esperance, Jerry Horton,\nJacoby Shaddix. Published by\nDowntown Music Publishing")
	}
	{
		item = qs("\Lo/b/o Meat Locker Publishing (ASCAP)\nCourtesy of Geffen Records\nUnder license from Universal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Like Whoa''\n\n\n")
	}
	{
		item = qs("\LPerformed by Aly and AJ\nWritten by Antonina Armato,\nTim James, Alyson Michalka,\nAmanda Michalka. Published by\nSeven Summits Music")
	}
	{
		item = qs("\Lo/b/o Itself, In The Mouth of the Wolf Publishing\nand Half Heart Music (BMI)\nand Downtown Music Publishing\no/b/o Antonina Songs (ASCAP)\nCourtesy of")
	}
	{
		item = qs("\LHollywood Records\nAll Rights Reserved.\nUsed by Permission.\n\n")
	}
	{
		heading
		item = qs("\L\c3''Lips Of An Angel''\n\n\n")
	}
	{
		item = qs("\LPerformed by Hinder\nWritten by Lloyd Garvey,\nRoss Hanson, Brian Howes,\nMark King, Michael Rodden\nand Austin Winkler. Published by")
	}
	{
		item = qs("\LEMI Blackwood Music Inc. (BMI)\nCourtesy of Universal Records\nUnder license from\nUniversal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Love Is\nA Battlefield''\n\n")
	}
	{
		item = qs("\LPerformed by Pat Benatar\nWritten by Mike Chapman and\nHolly Knight. Published by\nMike Chapman Publishing Enterprises\nadmin by Music & Media International Inc. and")
	}
	{
		item = qs("\LUniversal Music - MGB Songs\nCourtesy of Capitol Records\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Love Story''\n\n\n")
	}
	{
		item = qs("\LPerformed by Taylor Swift\nWritten by Taylor Swift\nPublished by Sony/ATV Tree Publishing / Taylor Swift Music\nCourtesy of Big Machine Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Mr. Roboto''\n\n\n")
	}
	{
		item = qs("\LPerformed by Styx\nWritten by Dennis De Young\nPublished by Stygian Songs\nCourtesy of A&M Records\nUnder license from")
	}
	{
		item = qs("\LUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.\n\n")
	}
	{
		heading
		item = qs("\L\c3''Naïve''\n\n\n")
	}
	{
		item = qs("\LPerformed by The Kooks\nWritten by Paul Garred,\nHugh Harris, Luke Pritchard\nand Max Rafferty. Published by\nSony/ATV Harmony")
	}
	{
		item = qs("\Lo/b/o Sony/ATV Harmony UK\nCourtesy of Virgin Records, Ltd\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Ocean Avenue''\n\n\n")
	}
	{
		item = qs("\LPerformed by Yellowcard\nWritten by by Benjamin Eric Harper,\nWilliam Ryan Key, Peter Michael Mosely,\nLongineu Warren Parsons III\nand Sean Wellman-Mackin")
	}
	{
		item = qs("\LPublished by Universal Music - MGB Songs\no/b/o itself and Bromuda Music\nCourtesy of Capitol Records\nUnder license from EMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Oh Pretty Woman''\n\n\n")
	}
	{
		item = qs("\LPerformed by Roy Orbison\nWritten by Roy Orbison and\nBill Dees. Published by\nBarbara Orbison Music Company (BMI),\nOrbi-Lee Publishing (BMI),")
	}
	{
		item = qs("\LR-Key Darkus Publishing (BMI)\n(all admin. By Evergreen Copyrights) and\nSony/ATV Acuff Rose Music\nCourtesy of Orbison Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Our Lips\nAre Sealed''\n\n")
	}
	{
		item = qs("\LPerformed by The Go-Go's\nWritten by Terry Hall and Jane Wiedlin\nPublished by\nPlangent Visions Music Inc.\nand Universal Music - MGB Songs")
	}
	{
		item = qs("\LCourtesy of Capitol Records\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission")
	}
	{
		heading
		item = qs("\L\c3''Paralyzer''\n\n\n")
	}
	{
		item = qs("\LPerformed by\nFinger Eleven\nWritten by Scott Anderson,\nSean Anderson, Richard Beddoe,\nJames Black and Richard Jackett")
	}
	{
		item = qs("\LPublished by Finger Eleven Publishing (ASCAP)and\nFSMGI (IMRO), all rights controlled and administered by\nState One Songs America LLC (ASCAP)\nCourtesy of Wind-Up Records\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Picture To Burn''\n\n\n")
	}
	{
		item = qs("\LPerformed by Taylor Swift\nWritten by Taylor Swift and Liz Rose\nPublished by Sony/ATV Tree Publishing /\nTaylor Swift Music /\nSony/ATV Timber Publishing /")
	}
	{
		item = qs("\LHillsboro Valley Music\nCourtesy of Big Machine Records\nAll Rights Reserved.\nUsed by Permission.\n")
	}
	{
		heading
		item = qs("\L\c3''Pictures Of You''\n\n\n")
	}
	{
		item = qs("\LPerformed by The Last Goodnight\nWritten by Jeffrey Blue,\nKurtis Henneberry, Michael Nadeau\nPublished by\nUniversal Music - ")
	}
	{
		item = qs("\LZ Songs o/b/o itself and Stay Beautiful Songs\nCourtesy of Virgin Records America, Inc.\nUnder license from EMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Put Your\nRecords On''\n\n")
	}
	{
		item = qs("\LPerformed by Corinne Bailey Rae\nWritten by Corinne Bailey Rae,\nJohn Beck and Steven Chrisanthou\nPublished by\nShapiro Bernstein and Co., Inc.")
	}
	{
		item = qs("\Lo/b/o Good Groove Songs Ltd. and\nGlobal Talent Publishing, Ltd.\nAdministered by\nKobalt Music Publishing America, Inc.\nCourtesy of ")
	}
	{
		item = qs("\LEMI Records Ltd.\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Rio''\n\n\n")
	}
	{
		item = qs("\LPerformed by Duran Duran\nWritten by Nicholas Bates,\nSimon LeBon, Andrew Taylor,\nJohn Taylor and Roger Taylor\n© 1982, Gloucester Place Music Ltd,")
	}
	{
		item = qs("\LEMI Music Publishing UK Ltd.\nCourtesy of EMI Records Ltd.\nUnder license from EMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Rock Star''\n\n\n")
	}
	{
		item = qs("\LPerformed by N.E.R.D.\nWritten by Chad Hugo,\nand Pharrell Williams\nPublished by\nEMI April Music Inc. (ASCAP) and")
	}
	{
		item = qs("\LEMI Blackwood Music Inc. (BMI)\nCourtesy of Virgin Records America, Inc.\nUnder license from EMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Santa Monica''\n\n\n")
	}
	{
		item = qs("\LPerformed by Everclear\nWritten by Arthur P. Alexakis,\nGreg Eklund and Craig Montoya\nPublished by\nIrving Music, Inc.")
	}
	{
		item = qs("\Lo/b/o itself, Montalupis Music and\nCommongreen Music/Songs of Universal, Inc.\nCourtesy of Capitol Records\nUnder license from EMI Film & Television Music\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''She Will\nBe Loved''\n\n")
	}
	{
		item = qs("\LPerformed by Maroon 5\nWritten by Jesse Carmichael,\nRyan Dusick, Adam Levine,\nMickey Madden and James Valentine\nPublished by")
	}
	{
		item = qs("\LUniversal Music - Careers o/b/o itself and\nFebruary Twenty Second Music / Universal Music - MGB Songs\no/b/o itself and\nValentine Valentine\nCourtesy of")
	}
	{
		item = qs("\LCapitol Records\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''So Yesterday''\n\n\n")
	}
	{
		item = qs("\LPerformed by Hilary Duff\nWritten by Graham Edwards,\nLauren Christy, Scott Spock\nand Charles Kaufman\nPublished by")
	}
	{
		item = qs("\LUniversal Music - Careers\no/b/o itself and Lauren Christy Songs and\nScott Spock Songs / Universal Music -\nMGB Songs o/b/o itself\nand Graham Edwards Songs")
	}
	{
		item = qs("\Land Sony/ATV Melody / Shahasu Music\nCourtesy of\nHollywood Records\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Steal My Kisses''\n\n\n")
	}
	{
		item = qs("\LPerformed by Ben Harper and\nthe Innocent Criminals\nWritten by Ben Harper\nPublished by\nEMI Virgin Music, Inc. (ASCAP)")
	}
	{
		item = qs("\LCourtesy of Virgin Records America, Inc.\nUnder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Sugar, We're\nGoin' Down''\n\n")
	}
	{
		item = qs("\LPerformed by Fall Out Boy\nWritten by Andrew John Hurley,\nPatrick Martin Stumph, Joseph Mark Trohman\nand Peter L Wentz\nPublished by")
	}
	{
		item = qs("\LSony/ATV Songs LLC / Chicago X Softcore Songs\nCourtesy of The Island Def Jam Music Group\nUnder license from Universal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Take A Picture''\n\n\n")
	}
	{
		item = qs("\LPerformed by Filter\nWritten by Richard Patrick\nPublished by EMI April Music Inc. (ASCAP)\nCourtesy of No Pulse Music, LLC\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Take Back\nthe City''\n\n")
	}
	{
		item = qs("\LPerformed by Snow Patrol\nWritten by Nathan Connolly,\nGary Lightbody, Jonathan Quinn,\nTom Simpson and Paul Wilson\nPublished by")
	}
	{
		item = qs("\LUniversal - Songs of PolyGram Int., Inc.\no/b/o Big Life Music Ltd.\nCourtesy of Interscope Records\nUnder license from Universal Music Enterprises\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Take What\nYou Take''\n\n")
	}
	{
		item = qs("\LPerformed by Lily Allen\nWritten by Lily Allen,\nIyiola Babalola and Darren Lewis\nPublished by Universal -\nPolyGram Int. Publ., Inc.")
	}
	{
		item = qs("\Lo/b/o Universal Music Publ. Ltd.\nCourtesy of EMI Records Ltd.\nUnder license from EMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Turn Off\nThe Light''\n\n")
	}
	{
		item = qs("\LPerformed by Nelly Furtado\nWritten by Nelly Furtado\nPublished by\nEMI April Music Inc. (ASCAP)\nCourtesy of")
	}
	{
		item = qs("\LGeffen Records Under license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.\n")
	}
	{
		heading
		item = qs("\L\c3''Walking On\nSunshine''\n\n")
	}
	{
		item = qs("\LPerformed by Katrina and The Waves\nWritten by Kimberley Rew\nPublished by Primary Wave Music / Kyboside LTD.\nCourtesy of Primary Wave Music / Kyboside LTD.\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Wannabe''\n\n\n")
	}
	{
		item = qs("\LPerformed by Spice Girls\nWritten by Victoria Beckham,\nMelanie Brown, Emma Bunton,\nMelanie Chisholm, Geri Halliwell,\nMatt Rowe and Richard Stannard")
	}
	{
		item = qs("\LPublished by\nEMI Virgin Music, Inc.\nd/b/a EMI Full Keel Music\nand Universal - PolyGram Int. Publ., Inc.\no/b/o Universal Music Publ. Ltd. ")
	}
	{
		item = qs("\LCourtesy of\nVirgin Records, Ltd.\nUnder license from EMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Warwick Avenue''\n\n\n")
	}
	{
		item = qs("\LPerformed by Duffy\nWritten by Aimee Duffy,\nJames Hogarth and Francis White\nPublished by\nEMI Blackwood Music Inc. (BMI)")
	}
	{
		item = qs("\Land Universal - Songs of PolyGram Int., Inc.\no/b/o Universal Music Publ. Ltd. / Universal Music - Careers\no/b/o Dalmatian Songs Ltd.\nCourtesy of\nPolydor Ltd. (UK)")
	}
	{
		item = qs("\LUnder license from\nUniversal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.\n")
	}
	{
		heading
		item = qs("\L\c3''When I'm Gone''\n\n\n")
	}
	{
		item = qs("\LPerformed by 3 Doors Down\nWritten by Brad Arnold,\nRobert T. Harrell, Christopher Lee Henderson\nand Matthew D. Roberts\nPublished by Universal Songs of Universal, Inc. ")
	}
	{
		item = qs("\Lo/b/o itself and Escatawpa Songs\nCourtesy of Universal Records\nUnder license from Universal Music Enterprises\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Whip It''\n\n\n")
	}
	{
		item = qs("\LPerformed by Devo\nWritten by Gerald Casale and Mark Mothersbaugh\nPublished by EMI Virgin Songs, Inc. (BMI)\nCourtesy of Mutato Muzika\nAll Rights Reserved. Used by Permission.")
	}
	{
		heading
		item = qs("\L\c3''Y.M.C.A.''\n\n\n")
	}
	{
		item = qs("\LPerformed by Village People\nWritten by Henri Belolo,\nJacques Morali and Victor Willis\nPublished by\nCan't Stop Music")
	}
	{
		item = qs("\LCourtesy of The Island Def Jam Music Group\nUnder license from\nUniversal Music Enterprises and Scorpio Music\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''You Belong\nWith Me''\n\n")
	}
	{
		item = qs("\LPerformed by Taylor Swift\nWritten by Taylor Swift and Liz Rose\nPublished by Sony/ATV Tree Publishing /\nTaylor Swift Music and\nPotting Shed Music (SESAC),")
	}
	{
		item = qs("\LBarbara Orbison World Publishing (SESAC)\n(admin. By EverGreen Copyrights)\nCourtesy of Big Machine Records\nAll Rights Reserved.\nUsed by Permission.")
	}
	{
		heading
		item = qs("\L\c3''You Had Me''\n\n\n")
	}
	{
		item = qs("\LPerformed by Joss Stone\nWritten by Francis White,\nBetty Wright, Joss Stone\nand Wendy Stoker\nPublished by")
	}
	{
		item = qs("\LUniversal - Songs of PolyGram Int., Inc.\no/b/o Universal Music Publ. Ltd. /\nUniversal Music Corp.\no/b/o itself and Miami Spice Publ. /\n Universal Music - Careers")
	}
	{
		item = qs("\Lo/b/o Universal Music Publ. MGB Ltd. /\nUniversal Music - MGB Songs o/b/o itself and\nUniversal Music MGB Publ. Ltd.\nCourtesy of\nVirgin Records America, Inc.")
	}
	{
		item = qs("\LUnder license from\nEMI Film & Television Music\nAll Rights Reserved.\nUsed by Permission.\n")
	}
	{
		item = qs("\LBand Hero (TM)\n© 2009 Activision Publishing, Inc.\nActivision and RedOctane are registered trademarks\nand Band Hero is a trademark of Activision Publishing, Inc.\nCovered by one or more of the following patents:")
	}
	{
		item = qs("\LU.S. Patent Nos. 6379244, 6582309, 6609979,\n6425822, 6225547, 6607446, 6342665, 6769689, 6645067,\n6252153, 6758753, 6554711, 6347998, 6390923, 6612931,\n6461239, 6915488, 6638160, 6821203, 5739457, 6018121,\n6268557, 6369313, 6835887, 6429863 and D441403; ")
	}
	{
		item = qs("\Lpatents pending. The ratings icon is a registered trademark\nof the Entertainment Software Association.\nAll other trademarks and trade names are\nthe properties of their respective owners.\nAll rights reserved.")
	}
]
