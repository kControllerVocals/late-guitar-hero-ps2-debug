
script BG_fx_set_blur \{time = 0
		viewport = bg_viewport
		effectName = Depth_of_Field__simplified_}
	if GotParam \{appendStrength}
		effectParams = {
			on = 1
			nearblurbegin = 0.0
			nearblurend = 0.0
			farblurbegin = 0.0
			farblurend = 0.0
			strength = <appendStrength>
		}
	else
		if NOT GotParam \{effectParams}
			return
		endif
	endif
	if ScreenFX_FxInstanceExists viewport = <viewport> name = <effectName>
		ScreenFX_UpdateFXInstanceParams {
			<effectParams>
			viewport = <viewport>
			name = <effectName>
			time = <time>
		}
	else

	endif
endscript

script BG_fx_set_brightness_WhiteFlash \{time = 0
		viewport = bg_viewport
		effectName = Brightness___Saturation}
	if GotParam \{appendBrightness}
		effectParams = {
			on = 1
			brightness = <appendBrightness>
			contrast = 0
			hue = 1.0
			saturation = 0.5348
			red_mix_r = 1
			red_mix_g = 0
			red_mix_b = 0
			green_mix_r = 0
			green_mix_g = 1
			green_mix_b = 0
			blue_mix_r = 0
			blue_mix_g = 0
			blue_mix_b = 1
		}
	else
		if NOT GotParam \{effectParams}
			return
		endif
	endif
	if ScreenFX_FxInstanceExists viewport = <viewport> name = <effectName>
		ScreenFX_UpdateFXInstanceParams {
			<effectParams>
			viewport = <viewport>
			name = <effectName>
			time = <time>
		}
	else

	endif
endscript

script BG_fx_set_brightness_BlackFade \{time = 0
		viewport = bg_viewport
		effectName = Brightness___Saturation}
	if GotParam \{appendBrightness}
		effectParams = {
			on = 1
			brightness = <appendBrightness>
		}
	else
		if NOT GotParam \{effectParams}
			return
		endif
	endif
	if ScreenFX_FxInstanceExists viewport = <viewport> name = <effectName>
		ScreenFX_UpdateFXInstanceParams {
			<effectParams>
			viewport = <viewport>
			name = <effectName>
			time = <time>
		}
	else

	endif
endscript

script BG_fx_get_start_params 

	<startValue> = {}
	<rv> = false
	if ScreenFX_FxInstanceExists viewport = <viewport> name = <effectName>
		if ScreenFX_GetActiveScreenFXInstances viewport = <viewport> effectName = <effectName>
			<startValue> = <curEffect>
			<rv> = true
		endif
	endif
	return {
		<rv>
		startValue = <startValue>
	}
endscript
