
script SafeCreate 
	if IsInNodeArray <nodeName>
		if NOT IsCreated <nodeName>
			create name = <nodeName>
		endif
	endif
endscript

script SafeKill 
	if IsCreated <nodeName>
		kill name = <nodeName>
	endif
endscript

script ScreenFlash \{time = 1}
	KillSpawnedScript \{id = ScreenFlash}
	SpawnScriptLater ScreenFlashOn id = ScreenFlash params = {time = <time>}
endscript

script ScreenFlashOn 
	if NOT ScreenFX_FxInstanceExists \{viewport = bg_viewport
			name = FlashBS}
		ScreenFX_AddFXInstance {
			viewport = bg_viewport
			name = FlashBS
			($ScreenFlash_TOD_Manager.screen_fx [0])
		}
	else
		ScreenFX_UpdateFXInstanceParams {
			viewport = bg_viewport
			name = FlashBS
			($ScreenFlash_TOD_Manager.screen_fx [0])
		}
	endif
	Wait (0.1 * <time>) seconds
	if ScreenFX_FxInstanceExists \{viewport = bg_viewport
			name = FlashBS}
		ScreenFX_UpdateFXInstanceParams {
			viewport = bg_viewport
			name = FlashBS
			time = <time>
			($ScreenFlash_TOD_Manager.screen_fx [0])
			contrast = 1
			brightness = 1.5
		}
	endif
	Wait <time> seconds
	SpawnScriptLater \{ScreenFlashOff
		id = ScreenFlash}
endscript

script ScreenFlashOff 
	if ViewportExists \{id = bg_viewport}
		if ScreenFX_FxInstanceExists \{viewport = bg_viewport
				name = FlashBS}
			ScreenFX_RemoveFXInstance \{viewport = bg_viewport
				name = FlashBS}
		endif
	endif
endscript
