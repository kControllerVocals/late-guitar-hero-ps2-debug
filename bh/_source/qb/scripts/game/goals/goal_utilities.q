
script GMan_SongTool_SetCurrentSong \{song = unset}
	change current_song = <song>
endscript

script GMan_SongTool_GetCurrentSong 
	current_song = none
	current_song = $current_song
	return current_song = <current_song>
endscript

script GMan_SongTool_SongWon 
	GuitarEvent_SongWon
endscript

script get_current_songs_struct 
	GMan_SongTool_GetCurrentSong
	get_song_struct song = <current_song>
	return song_struct = <song_struct>
endscript
