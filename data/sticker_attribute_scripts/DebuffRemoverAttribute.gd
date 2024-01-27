extends "res://mods/sticker_tiers/scripts/FurtherStickerAttribute.gd"

export (int) var chance_min:int
export (int) var chance_max:int
export (int) var chance_mode:int
export (int) var amount:int = 1

var chance:int

func get_description(move)->String:
	var format = "MOVE_ATTRIBUTE_DEBUFF_REMOVAL"
	return Loc.trf(format, {
		"chance":"%+d" % chance
	})
	
func notify(move, fighter, id:String, args):
		if id == "round_ending":
			trigger_check(move, fighter)

func trigger_check(move, fighter):
	print("trying to remove debuff")
	if fighter.battle.rand.rand_int(100) < chance:
		print(" -> sucess")
		var size = 0
		var removal = 0
		var debuffs = get_debuffs(fighter)
		
		if debuffs.size() == 0:
			return
			
		size = amount if amount < debuffs.size() else debuffs.size()
		for debuff in debuffs:
			if (size > 0):
				debuff.remove()
			else:
				break
			size -= 1

func get_debuffs(fighter)->Array:
	var result = []
	for status in fighter.status.get_effects():
		print(status)
		if status.effect.is_debuff and status.effect.is_removable:
			result.push_back(status)
	return result

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
