Drumtest = 1

script Drummer_Kill_Spawnscripts 
	KillSpawnedScript \{name = DrumDroid_Timers}
	KillSpawnedScript \{name = hide_Non_Drummers}
	KillSpawnedScript \{name = Hit_DrumKit_Piece}
	KillSpawnedScript \{name = Default_Kit_anims}
	KillSpawnedScript \{name = Default_drummer_State}
	KillSpawnedScript \{name = Drummer_ControlScript}
	KillSpawnedScript \{name = Drummer_Transit_Base_Short}
	KillSpawnedScript \{name = Drummer_Transit_Base_Long}
	KillSpawnedScript \{name = Drummer_Transit_Arm_R}
	KillSpawnedScript \{name = Drummer_Transit_Arm_L}
	KillSpawnedScript \{name = Drummer_Transit_Loops}
	KillSpawnedScript \{name = Drummer_Transit_Idles}
	KillSpawnedScript \{name = Drummer_Current_Tempo}
	KillSpawnedScript \{name = Set_drummer_Active_Values}
	KillSpawnedScript \{name = Hold_Transit_requests}
	KillSpawnedScript \{name = Hold_Transit_Arms}
	KillSpawnedScript \{name = Hold_Active_Values}
	KillSpawnedScript \{name = Drummer_Anticipation_Arms}
	KillSpawnedScript \{name = Hold_Drummer_Anticipation_Arms}
	KillSpawnedScript \{name = Hold_DrumKit_Piece}
	KillSpawnedScript \{name = hold_Body_Trans}
	KillSpawnedScript \{name = Hold_Body_Loops}
	KillSpawnedScript \{name = Idle_Check}
endscript

script Drummer_Reset_Globals 
	change \{Use_DB_Branch_L = 1}
	change \{Use_DB_Branch_R = 1}
	change \{Use_DB_Base = 1}
	change \{Current_DB_Base = 1}
	change \{Drummer_Idle = true}
	Drummer_Kill_Spawnscripts
endscript
