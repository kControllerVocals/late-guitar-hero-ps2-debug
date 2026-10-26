Drumtest = 1

script Drummer_Kill_Spawnscripts 
	KillSpawnedScript \{name = DrumDroid_Timers}
	KillSpawnedScript \{name = hide_Non_Drummers}
	KillSpawnedScript \{name = Hit_DrumKit_Piece}
	KillSpawnedScript \{name = Default_Kit_anims}
	KillSpawnedScript \{name = Default_drummer_State}
	KillSpawnedScript \{name = Drummer_ControlScript}
	KillSpawnedScript \{name = Drummer_Transit}
	KillSpawnedScript \{name = Drummer_Transit_Loops}
	KillSpawnedScript \{name = Drummer_Transit_Idles}
	KillSpawnedScript \{name = create_Trans_diff}
	KillSpawnedScript \{name = Drummer_Current_Tempo}
	KillSpawnedScript \{name = Set_drummer_Active_Values}
	KillSpawnedScript \{name = Drummer_Offset_Anims}
endscript

script Drummer_Reset_Globals 
	Drummer_Kill_Spawnscripts
endscript
