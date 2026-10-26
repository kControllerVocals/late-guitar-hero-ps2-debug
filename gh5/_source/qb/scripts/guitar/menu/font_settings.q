text_enable_min_scale = 1
font_scaling = {
	`default` = {
		min_scale = 0.45000002
	}
	fontgrid_text_a3 = {
		min_scale = 0.18
	}
	fontgrid_text_a1 = {
		min_scale = 0.38000003
	}
	fontgrid_title_a1 = {
		min_scale = 0.28
	}
}

script test_font_scales 
	DestroyScreenElement \{id = test_font_scales_container}
	CreateScreenElement \{id = test_font_scales_container
		parent = root_window
		type = VMenu
		just = [
			left
			top
		]
		pos = (100.0, 50.0)
		dims = (100.0, 100.0)
		z_priority = 10000}
	ForEachIn \{Structure = $font_scaling
		do = test_font_scales_element
		pass_index}
endscript

script test_font_scales_element 
	if (<foreachin_name> = `default`)
		return
	endif
	CreateScreenElement {
		parent = test_font_scales_container
		type = TextBlockElement
		dims = (150.0, 50.0)
		font = <foreachin_name>
		text = qs("\LThe quick brown fox jumps over the lazy dog.")
		fit_width = `scale each line to fit`
		fit_height = `scale down if larger`
		tags = {debug_me}
	}
endscript
