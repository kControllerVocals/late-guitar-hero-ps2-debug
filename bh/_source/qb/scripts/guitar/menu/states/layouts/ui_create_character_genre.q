intial_genre_focus_hack = 0

script ui_create_create_character_genre 
	make_generic_menu \{title = qs("SELECT GENRE")
		vmenu_id = create_create_character_genre_vmenu}
	if <desc_id> :Desc_ResolveAlias name = alias_banner_art_glow param = banner_glow_id
		<banner_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $banner_move glow_brightness = $menu_glow}
	else

	endif
	if <desc_id> :Desc_ResolveAlias name = alias_skulls_glow param = skulls_glow_id
		<skulls_glow_id> :obj_spawnscript ui_flicker_glow params = {as_offset scale_movement = $skulls_move glow_brightness = $menu_glow}
	else

	endif
	change \{intial_genre_focus_hack = 1}
	current_genre = (($cas_current_appearance).genre)
	GetArraySize ($Genre_List)
	i = 0
	begin
	genre = (($Genre_List) [<i>].desc_id)
	if (<genre> = <current_genre>)
		select_index = <i>
	endif
	add_generic_menu_text_item {
		icon = (($Genre_List) [<i>].icon)
		text = (($Genre_List) [<i>].frontend_desc)
		pad_choose_script = load_character_before_state
		pad_choose_params = {state = UIstate_customize_character unfocus_menu = create_create_character_genre_vmenu}
		additional_focus_script = cas_create_character_genre_focus
		additional_focus_params = {genre = <genre>}
	}
	i = (<i> + 1)
	repeat <array_size>
	menu_finish \{no_rotate_zoom_text}
	LaunchEvent type = focus target = create_create_character_genre_vmenu data = {child_index = <select_index>}
	add_user_control_helper \{text = qs("RANDOMIZE")
		button = Yellow
		z = 100000}
endscript

script ui_destroy_create_character_genre 
	destroy_generic_menu
endscript

script ui_init_create_character_genre 
	if GetCurrentCASObject
		BandManager_ChangeStance name = <cas_object> stance = Stance_Old no_wait
	endif
	ui_load_cas_rawpak \{part = CAS_Body}
endscript
car_wait_before_load = 0.75

script cas_create_character_genre_focus 
	SetScreenElementProps {
		id = create_create_character_genre_vmenu
		event_handlers =
		[
			{pad_option2 cas_create_character_rerandomize params = {genre = <genre>}}
		]
		replace_handlers
	}
	if ($intial_genre_focus_hack = 1)
		change \{intial_genre_focus_hack = 0}
		return
	endif
	KillSpawnedScript \{name = generate_random_character}
	switch <genre>
		case Rock
		Anim = Rock
		case Punk
		Anim = Punk
		case `Heavy Metal`
		Anim = HeavyMetal
		case `Glam Rock`
		Anim = Glam
		case `Black Metal`
		Anim = BlackMetal
		case `Classic Rock`
		Anim = Classic
		case Goth
		Anim = Goth
		case Pop
		Anim = Pop
		default
		Anim = Rock
	endswitch
	spawnscriptnow generate_random_character params = {is_female = ($cas_current_is_female) genre = <genre> Anim = <Anim> Wait genre_select}
endscript

script cas_create_character_rerandomize 
	KillSpawnedScript \{name = generate_random_character}
	generic_menu_pad_choose_sound
	if GotParam \{genre}
		spawnscriptnow generate_random_character params = {is_female = ($cas_current_is_female) genre = <genre> genre_select}
	else
		if GetCASAppearance
			if StructureContains Structure = <appearance> genre
				spawnscriptnow generate_random_character params = {is_female = ($cas_current_is_female) genre = (<appearance>.genre) genre_select}
			endif
		endif
	endif
endscript

script cas_unblock_input_after_randomize 
	begin
	if NOT ScriptIsRunning \{generate_random_character}
		break
	endif
	Wait \{1
		gameframe}
	repeat
	SetButtonEventMappings \{unblock_menu_input}
endscript
