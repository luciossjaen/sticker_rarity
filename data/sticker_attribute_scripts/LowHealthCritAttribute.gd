extends "res://mods/sticker_tiers/scripts/FurtherStickerAttribute.gd"

export (int) var chance_min:int
export (int) var chance_max:int
export (int) var chance_mode:int


var chance:int

func get_description(move)->String:
	var format = "MOVE_ATTRIBUTE_LOW_HEALTH_CRIT"
	return Loc.trf(format, {
		"chance": chance
	})


func modify_damage(_move, user, _target, damage)->void:
	var max_hp = user.status.max_hp
	var hp = user.status.hp
	
	if ((hp / max_hp) * 100) <= chance:
		damage.is_critical = true
		return 

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
