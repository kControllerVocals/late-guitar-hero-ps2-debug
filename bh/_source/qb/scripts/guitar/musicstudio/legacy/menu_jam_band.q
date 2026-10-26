jam_reverb = 0

script jam_init_reverb 

	CreateEffectSendStack \{slot = 2
		effects = [
			{
				$Jam_Mode_MedRoom_Reverb
			}
		]}
	SetSoundBussParams \{JamMode_RhythmGuitar = {
			send_vol2 = -30
		}}
	SetSoundBussParams \{JamMode_LeadGuitar = {
			send_vol2 = -30
		}}

	if ($jam_reverb = 0)
		change \{jam_reverb = 1}
	endif
endscript

script jam_deinit_reverb 

	SetSoundBussParams \{JamMode_RhythmGuitar = {
			send_vol2 = -100
		}}
	SetSoundBussParams \{JamMode_LeadGuitar = {
			send_vol2 = -100
		}}
	DestroyEffectSendStack \{slot = 2}

	if ($jam_reverb = 1)
		change \{jam_reverb = 0}
	endif
endscript
