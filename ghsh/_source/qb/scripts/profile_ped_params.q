defaultloddist1 = 20
defautsuspenddistance = 65
defaultrenderdistance = 65
human_creation_params = {
	skeletonname = gh3_ped
	suspenddistance = $defautsuspenddistance
	lod_dist1 = $defaultloddist1
	lod_dist2 = $defaultrenderdistance
	behavior_style = bv_agent
	agent_stats = stats_civilian
	targeting = $targeting_human
	navigation = $nav_ped
	char_collision = agent
	char_collision_height = 1.8
	char_collision_radius = 0.3
	anim_class = human
	species = human
	inventory = $inventory_fist
	maxbonepriority = 9
	voice_profile = teenmaleskater1
	faction = $faction_human
	sex = male
	notice_radius = 6.0
	animlodinterleave2 = 6
	ps3_animlodinterleave2 = 10
	xenon_animlodinterleave2 = 10
}
obj_ped_skinny_creation_params = {
	skeletonname = gh3_ped_skinny
	tree = $gameobj_animtree
	animtargets = [
		body
		bodytimer
	]
	zones = [
		global
	]
}
obj_testlevel_creation_params = {
	tree = $gameobj_animtree
	animtargets = [
		body
		bodytimer
	]
	zones = [
		global
	]
}
obj_ven_camera_creation_params = {
	skeletonname = gh3_camera
	tree = $gameobj_animtree
	animtargets = [
		body
		bodytimer
	]
	zones = [
		global
	]
}
obj_ven_record_creation_params = {
	skeletonname = skel_encore_record
	tree = $gameobj_animtree
	animtargets = [
		body
		bodytimer
	]
	zones = [
		global
	]
}
