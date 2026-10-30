
script check_to_hide_element 
	begin
	if NOT (screenelementexists id = <elementtohide>)
		break
	else
		if NOT (screenelementexists id = friendslistinterface)
			<elementtohide> :se_setprops alpha = 0.0 time = 0.1
			break
		endif
	endif
	wait \{1
		gameframe}
	repeat
endscript
