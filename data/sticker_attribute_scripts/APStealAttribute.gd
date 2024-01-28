extends "res://mods/sticker_tiers/scripts/FurtherStickerAttribute.gd"

export (int) var chance_min:int
export (int) var chance_max:int
export (int) var chance_mode:int
export (String) var toast_message:String = "MOVE_AP_STEAL_TOAST"

var chance:int

func get_description(move)->String:
	var format = "MOVE_ATTRIBUTE_AP_STEAL"
	return Loc.trf(format, {
		"chance":"%+d" % chance
	})

func on_move_end(move, user, targets, attack_params):

	if targets.size() > 0:
		var stolen = 0
		for target in targets:
			if user.battle.rand.rand_int(100) >= chance:
				continue 
		
			stolen = min(target.status.ap, 1)
			if stolen == 0 or target.get_character_kind() == Character.CharacterKind.ARCHANGEL:
				continue 

			target.status.change_ap( - stolen, toast_message)
			target.battle.queue_status_update(target, false)
			if stolen > 0:
				user.status.change_ap(stolen)
				user.battle.queue_status_update(user, false)

func generate(move, rand:Random)->void :
	.generate(move, rand)
	chance = rand.rand_range_int_triangular(chance_min, chance_max, chance_mode)

func get_perfection()->float:
	return clamp(float(chance - chance_min) / float(chance_max - chance_min), 0.0, 1.0)

func get_snapshot()->Dictionary:
	var snap = .get_snapshot()
	snap.chance = chance
	return snap

func set_snapshot(snap, version:int)->bool:
	if not .set_snapshot(snap, version):
		return false
	chance = snap.chance
	return true
