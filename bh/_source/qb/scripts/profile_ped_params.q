DefaultLodDist1 = 20
DefautSuspendDistance = 65
DefaultRenderDistance = 65
human_creation_params = {
	SkeletonName = GH3_ped
	SuspendDistance = $DefautSuspendDistance
	lod_dist1 = $DefaultLodDist1
	lod_dist2 = $DefaultRenderDistance
	behavior_style = Bv_Agent
	agent_stats = stats_civilian
	targeting = $targeting_human
	navigation = $nav_ped
	char_collision = Agent
	char_collision_height = 1.8
	char_collision_radius = 0.3
	anim_class = human
	species = human
	inventory = $inventory_fist
	MaxBonePriority = 9
	voice_profile = TeenMaleSkater1
	faction = $faction_human
	sex = Male
	notice_radius = 6.0
	AnimLODInterleave2 = 6
	PS3_AnimLODInterleave2 = 10
	Xenon_AnimLODInterleave2 = 10
}
obj_Ped_Skinny_creation_params = {
	SkeletonName = GH3_ped_skinny
	Tree = $GameObj_AnimTree
	AnimTargets = [
		Body
		BodyTimer
	]
	zones = [
		global
	]
}
obj_testlevel_creation_params = {
	Tree = $GameObj_AnimTree
	AnimTargets = [
		Body
		BodyTimer
	]
	zones = [
		global
	]
}
obj_Ven_Camera_creation_params = {
	SkeletonName = GH3_Camera
	Tree = $GameObj_AnimTree
	AnimTargets = [
		Body
		BodyTimer
	]
	zones = [
		global
	]
}
obj_Ven_Record_creation_params = {
	SkeletonName = Skel_Encore_Record
	Tree = $GameObj_AnimTree
	AnimTargets = [
		Body
		BodyTimer
	]
	zones = [
		global
	]
}
