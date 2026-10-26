CAS_Full_Body_Common_Settings_Male = {
	$CAS_Full_Body_Common_Settings
	is_female = 0
	anim_struct = car_male_anim_struct
	lefty = 0
	large_hands = 0
}
CAS_Full_Body_Common_Settings_Female = {
	$CAS_Full_Body_Common_Settings
	is_female = 1
	anim_struct = car_female_anim_struct
	lefty = 0
	large_hands = 0
}
CAS_Full_Body_Common_Settings = {
	shadow_pak = 'Pak\\models\\shadows\\male_shadow.pak'
	shadow_models = [
		'male_shadow_asset'
	]
	ik_params = Hero_Ik_params
	ik_params_guitar = Hero_Ik_params
	ik_params_drum = CAR_IK_Params
	ik_params_vocals = CAR_IK_Params
	ik_params_frontend = CAR_IK_Params
}
