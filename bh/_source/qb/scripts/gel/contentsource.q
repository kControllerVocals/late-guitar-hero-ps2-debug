
script get_marketplace_pack_struct 

	if StructureContains Structure = $GH4_download_songpacks_props <pack_name>
		songprops = (($GH4_download_songpacks_props).<pack_name>)
		if music_store_get_product_code name = <pack_name>
			if MarketplaceFunc func = get_content_info id = <code>
				music_store_generate_date year = (<songprops>.arrived_year) day = (<songprops>.arrived_day) month = (<songprops>.arrived_month)
				if ((<songprops>.type) = pack)
					music_store_get_pack_contents_strings pack_contents = (<songprops>.pack_contents)
				endif
				pack_entry = {
					song_checksum = <pack_name>
					song_title = (<songprops>.title)
					song_artist = (<songprops>.artist)
					type = (<songprops>.type)
					price = <cost>
					purchased = <purchased>
					code = <code>
					song_preview_asset_name = (<songprops>.asset_name)
					pack_contents = (<songprops>.pack_contents)
					song_year = (<songprops>.release_year)
					arrived_date = <date>
					contents_strings = <contents_strings>
				}
				if music_store_is_new_arrival name = <pack_name>
					pack_entry = {<pack_entry> new_arrival = 1}
				endif
				if NOT music_store_should_hide_item struct = <songprops>
					return true pack_entry = <pack_entry>
				endif
			else

			endif
		else

		endif
	endif
	return \{false}
endscript

script get_marketplace_song_struct 

	if StructureContains Structure = $download_songlist_props <song_name>
		if StructureContains Structure = $GH4_download_songlist_props_musicstore <song_name>
			songprops = (($download_songlist_props).<song_name>)
			songprops = {<songprops> (($GH4_download_songlist_props_musicstore).<song_name>)}
			if music_store_get_product_code name = <song_name>
				if MarketplaceFunc func = get_content_info id = <code>
					music_store_generate_date year = (<songprops>.arrived_year) day = (<songprops>.arrived_day) month = (<songprops>.arrived_month)
					song_entry = {
						song_checksum = <song_name>
						song_title = (<songprops>.title)
						song_artist = (<songprops>.artist)
						type = song
						album_pack_only = (<songprops>.album_pack_only)
						price = <cost>
						purchased = <purchased>
						code = <code>
						song_preview_asset_name = (<songprops>.asset_name)
						pack_list = (<songprops>.pack_list)
						album = (<songprops>.album)
						song_year = (<songprops>.release_year)
						arrived_date = <date>
					}
					if music_store_is_new_arrival name = <song_name>
						song_entry = {<song_entry> new_arrival = 1}
					endif
					if NOT music_store_should_hide_item struct = <songprops>
						return true song_entry = <song_entry>
					endif
				else

				endif
			else

			endif
		else

		endif
	else

	endif
	return \{false}
endscript

script music_store_should_hide_item 
	if StructureContains Structure = <struct> hide_on_platforms
		if IsPs3
			if ArrayContains array = (<struct>.hide_on_platforms) contains = ps3
				return \{true}
			endif
		else
			if ArrayContains array = (<struct>.hide_on_platforms) contains = xen
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script music_store_generate_date \{year = 9999
		month = 15
		day = 31}
	date = 0
	date = (<date> + (<year> * 512))
	date = (<date> + (<month> * 32))
	date = (<date> + <day>)
	return date = <date>
endscript

script IsSongAvailable 

	if NOT StructureContains Structure = ($gh_songlist_props) <song>
		return \{false}
	endif
	if StructureContains Structure = ($gh_songlist_props.<song>) never_show_in_setlist
		return \{false}
	endif
	if (($g_include_debug_songs) = 1)
		return \{true}
	else
		check_allowed_in_quickplay = 0
		GameMode_GetType
		if (($is_network_game = 1) || (<type> = quickplay) || (<type> = training) || (<type> = freeplay))
			check_allowed_in_quickplay = 1
		elseif ($game_mode = p2_pro_faceoff)
			check_allowed_in_quickplay = 1
		endif
		if (<check_allowed_in_quickplay> = 1)
			get_song_allowed_in_quickplay song = <song>
			if (<allowed_in_quickplay> = 0)
				return \{false}
			endif
		endif
	endif
	if StructureContains Structure = ($gh_songlist_props.<song>) doesnt_support_vocals
		if NOT is_part_supported \{part = Vocals}
			return \{false}
		endif
	endif
	if StructureContains Structure = ($gh_songlist_props.<song>) doesnt_support_drums
		if NOT is_part_supported \{part = drum}
			return \{false}
		endif
	endif
	if StructureContains Structure = ($gh_songlist_props.<song>) doesnt_support_guitar
		if NOT is_part_supported \{part = guitar}
			return \{false}
		endif
	endif
	if StructureContains Structure = ($gh_songlist_props.<song>) doesnt_support_bass
		if NOT is_part_supported \{part = Bass}
			return \{false}
		endif
	endif
	if StructureContains Structure = ($gh_songlist_props.<song>) always_unlocked
		return \{true}
	endif

	get_song_saved_in_globaltags song = <song>
	if (<saved_in_globaltags> = 1)
		GetNumPlayersInGame
		GameMode_GetType
		GameMode_GetProperty \{prop = cooperative}
		if ((<type> = quickplay) && (<cooperative> = true))
			GetGlobalTags <song> param = unlocked
			if (<unlocked> = 1)
				return \{true}
			endif
			if (<num_players> > 0)
				GetFirstPlayer
				begin
				GetPlayerInfo <player> controller
				GetSavegameFromController controller = <controller>
				GetGlobalTags <song> savegame = <savegame> param = unlocked
				if (<unlocked> = 1)
					return \{true}
				endif
				GetNextPlayer player = <player>
				repeat <num_players>
			endif
		else
			GetGlobalTags <song> param = unlocked
			if (<unlocked> = 1)
				return \{true}
			endif
		endif
	endif
	if ($g_hack_all_songs_unlocked = 1)
		return \{true}
	endif
	return \{false}
endscript

script is_part_supported 

	support_part = <part>
	GetNumPlayersInGame
	GameMode_GetProperty \{prop = cooperative}
	if (<cooperative> = false || $practice_enabled = 1)
		if (<num_players> = 1)
			GetFirstPlayer
			begin
			GetPlayerInfo <player> part
			if (<part> = <support_part>)
				return \{false}
			endif
			GetNextPlayer player = <player>
			repeat <num_players>
		endif
	endif
	return \{true}
endscript

script get_ui_song_struct_items 

	if NOT StructureContains Structure = ($gh_songlist_props) name = <song>

		return
	endif
	song_struct = ($gh_songlist_props.<song>)
	<song_title> = qs("Song Title Here!")
	if StructureContains Structure = <song_struct> title
		<song_title> = (<song_struct>.title)
	elseif StructureContains Structure = <song_struct> display_name
		<song_title> = (<song_struct>.display_name)
		<song> = jamsession
	elseif StructureContains Structure = <song_struct> filename
		<song_title> = (<song_struct>.filename)
		<song> = jamsession
	endif
	<song_artist> = qs("Song Artist Here!")
	if StructureContains Structure = <song_struct> artist
		<song_artist> = (<song_struct>.artist)
	endif
	<song_genre> = Other
	if StructureContains Structure = <song_struct> genre
		<song_genre> = (<song_struct>.genre)
	endif
	<song_genre_string> = qs("Other")
	if StructureContains Structure = $song_genre_list <song_genre>
		<song_genre_string> = (($song_genre_list.<song_genre>).genre_string)
	else
		<song_genre_string> = (($song_genre_list.Other).genre_string)
	endif
	<song_year> = 2009
	if StructureContains Structure = <song_struct> year
		<song_year> = (<song_struct>.year)
	endif
	<song_venue> = 20
	if StructureContains Structure = <song_struct> venue
		<song_venue> = (<song_struct>.venue)
	endif
	<song_album_title> = qs("Album Title Here!")
	if StructureContains Structure = <song_struct> album_title
		<song_album_title> = (<song_struct>.album_title)
	endif
	<song_duration> = 0
	if StructureContains Structure = <song_struct> duration
		<song_duration> = (<song_struct>.duration)
	endif
	<song_guitar_difficulty_rating> = 0
	if StructureContains Structure = <song_struct> guitar_difficulty_rating
		<song_guitar_difficulty_rating> = (<song_struct>.guitar_difficulty_rating)
	endif
	<song_bass_difficulty_rating> = 0
	if StructureContains Structure = <song_struct> bass_difficulty_rating
		<song_bass_difficulty_rating> = (<song_struct>.bass_difficulty_rating)
	endif
	<song_vocals_difficulty_rating> = 0
	if StructureContains Structure = <song_struct> vocals_difficulty_rating
		<song_vocals_difficulty_rating> = (<song_struct>.vocals_difficulty_rating)
	endif
	<song_drums_difficulty_rating> = 0
	if StructureContains Structure = <song_struct> drums_difficulty_rating
		<song_drums_difficulty_rating> = (<song_struct>.drums_difficulty_rating)
	endif
	<song_band_difficulty_rating> = 0
	if StructureContains Structure = <song_struct> band_difficulty_rating
		<song_band_difficulty_rating> = (<song_struct>.band_difficulty_rating)
	endif
	<song_preview_asset_name> = 'placeholder_album'
	if StructureContains Structure = <song_struct> album_img
		<song_preview_asset_name> = (<song_struct>.album_img)
	endif
	ui_struct = {
		song_checksum = <song>
		song_title = <song_title>
		song_artist = <song_artist>
		song_genre = <song_genre>
		song_genre_string = <song_genre_string>
		song_year = <song_year>
		song_album_title = <song_album_title>
		song_duration = <song_duration>
		song_guitar_difficulty_rating = <song_guitar_difficulty_rating>
		song_bass_difficulty_rating = <song_bass_difficulty_rating>
		song_vocals_difficulty_rating = <song_vocals_difficulty_rating>
		song_drums_difficulty_rating = <song_drums_difficulty_rating>
		song_band_difficulty_rating = <song_band_difficulty_rating>
		song_preview_asset_name = <song_preview_asset_name>
		song_venue = <song_venue>
	}
	if StructureContains Structure = <song_struct> playback_track1

		extra_jam_data = {
			filename = (<song_struct>.filename)
			playback_track1 = (<song_struct>.playback_track1)
			playback_track2 = (<song_struct>.playback_track2)
			playback_track_drums = (<song_struct>.playback_track_drums)
			playback_track_vocals = (<song_struct>.playback_track_vocals)
		}
		song = (<song_struct>.filename)
		ui_struct = (<ui_struct> + <extra_jam_data>)
	endif
	return ui_struct = <ui_struct> song = <song>
endscript

script music_store_is_new_arrival 
	if StructureContains \{Structure = $GH4_download_newarrivals
			WORLDWIDE}
		if ArrayContains array = ($GH4_download_newarrivals.WORLDWIDE) contains = <name>
			return \{true}
		endif
	endif
	if MarketplaceFunc \{func = get_region_checksum}
		if StructureContains Structure = $GH4_download_newarrivals <region_checksum>
			if ArrayContains array = ($GH4_download_newarrivals.<region_checksum>) contains = <name>
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script music_store_get_product_code 
	if StructureContains Structure = $GH4_download_productcodes <name>
		if StructureContains Structure = ($GH4_download_productcodes.<name>) omit_locales
			GetLocale
			omit_list = (($GH4_download_productcodes.<name>).omit_locales)
			if ArrayContains array = <omit_list> contains = <locale>
				return \{false}
			endif
		endif
		if isXenon
			if StructureContains Structure = ($GH4_download_productcodes.<name>) WORLDWIDE
				return true code = ($GH4_download_productcodes.<name>.WORLDWIDE)
			endif
		endif
		if MarketplaceFunc \{func = get_region_checksum}
			if StructureContains Structure = ($GH4_download_productcodes.<name>) <region_checksum>
				return true code = ($GH4_download_productcodes.<name>.<region_checksum>)
			endif
		endif
	endif
	return \{false}
endscript

script musicstore_additional_region_check 
	if IsPs3
		if GlobalExists \{name = ps3_musicstore_locales_allowed}
			GetLocale
			GetTerritory
			if NOT StructureContains Structure = $ps3_musicstore_locales_allowed <territory>
				return \{false}
			endif
			if NOT ArrayContains array = ($ps3_musicstore_locales_allowed.<territory>) contains = <locale>
				return \{false}
			endif
		endif
	endif
	return \{true}
endscript

script kill_songlist_request_page_when_ready 
	if ScriptIsRunning \{songlist_request_page_when_ready}
		KillSpawnedScript \{name = songlist_request_page_when_ready}
	endif
endscript

script callback_marketplace_raf_setup_fail 

endscript

script callback_marketplace_raf_get_fail 

endscript

script callback_marketplace_raf_init_fail 

endscript

script callback_marketplace_songlist_vram_pak_request_fail 

endscript

script callback_marketplace_songlist_vram_pak_download_fail 

endscript

script callback_marketplace_songlist_pak_request_fail 

endscript

script callback_marketplace_songlist_pak_download_fail 

endscript

script callback_marketplace_market_init_settings_fail 

endscript

script callback_marketplace_market_init_fail 

endscript

script callback_marketplace_market_state_fail 

endscript

script callback_marketplace_market_begin_enum_fail 

endscript

script callback_marketplace_no_guest_account 

endscript

script callback_marketplace_non_xbl_account 

endscript

script callback_marketplace_connection_lost 

endscript

script callback_marketplace_cannot_purchase_content 

endscript

script callback_marketplace_region_not_supported 

endscript
