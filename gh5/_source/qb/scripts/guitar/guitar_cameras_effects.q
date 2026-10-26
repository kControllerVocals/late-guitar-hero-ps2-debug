ccam_min_fov_interp = 5
ccam_max_fov_interp = 100

script CameraCutsEffect_FOVPulse_GetType 

	switch <type>
		case pulse1
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, -0.05)}
				{(0.3, -0.05)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, -0.07)}
				{(1.0, 0.0)}
			]
			frequency = 15
		}
		case pulse2
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, -0.2)}
				{(1.0, -0.2)}
			]
			offset_curve = [
				{(0.0, -0.07)}
				{(1.0, 0.0)}
			]
			frequency = 15
		}
		case pulse3
		<pulseParams> = {
			amplitude_curve = [
				(0.0, -10.0)
				(1.0, -10.0)
			]
			offset_curve = [
				(0.0, -7.0)
				(1.0, 0.0)
			]
			frequency = 15
		}
		case pulse4
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, -0.025)}
				{(0.3, -0.025)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, -0.07)}
				{(1.0, 0.0)}
			]
			frequency = 15
		}
		case pulse5
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, -0.017499998)}
				{(0.3, -0.017499998)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, -0.07)}
				{(1.0, 0.0)}
			]
			frequency = 15
		}
		case zoom_in_quick_small
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, 0.0)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, 0.0)}
				{(0.05, -0.2) smooth}
				{(1.0, -0.2) ease_out}
			]
			frequency = 15
		}
		case zoom_in_quick_large
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, 0.0)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, 0.0)}
				{(0.05, -0.4) smooth}
				{(1.0, -0.4) ease_out}
			]
			frequency = 15
		}
		case zoom_in_slow_small
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, 0.0)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, 0.0)}
				{(0.15, -0.2) smooth}
				{(1.0, -0.2) ease_out}
			]
			frequency = 15
		}
		case zoom_in_slow_large
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, 0.0)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, 0.0)}
				{(0.15, -0.4) smooth}
				{(1.0, -0.4) ease_out}
			]
			frequency = 15
		}
		case zoom_out_quick_small
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, 0.0)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, 0.0)}
				{(0.05, 0.2) smooth}
				{(1.0, 0.2) ease_out}
			]
			frequency = 15
		}
		case zoom_out_quick_large
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, 0.0)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, 0.0)}
				{(0.05, 0.4) smooth}
				{(1.0, 0.4) ease_out}
			]
			frequency = 15
		}
		case zoom_out_slow_small
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, 0.0)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, 0.0)}
				{(0.15, 0.2) smooth}
				{(1.0, 0.2) ease_out}
			]
			frequency = 15
		}
		case zoom_out_slow_large
		<pulseParams> = {
			amplitude_curve = [
				{(0.0, 0.0)}
				{(1.0, 0.0)}
			]
			offset_curve = [
				{(0.0, 0.0)}
				{(0.15, 0.4) smooth}
				{(1.0, 0.4) ease_out}
			]
			frequency = 15
		}
		default

	endswitch
	return pulseParams = <pulseParams>
endscript
