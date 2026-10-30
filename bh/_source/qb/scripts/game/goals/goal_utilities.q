
script gman_songtool_setcurrentsong \{song = unset}
	change current_song = <song>
endscript

script gman_songtool_getcurrentsong 
	current_song = none
	current_song = $current_song
	return current_song = <current_song>
endscript

script gman_songtool_songwon 
	guitarevent_songwon
endscript

script get_current_songs_struct 
	gman_songtool_getcurrentsong
	get_song_struct song = <current_song>
	return song_struct = <song_struct>
endscript
