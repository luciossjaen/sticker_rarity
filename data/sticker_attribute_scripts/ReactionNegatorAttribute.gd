extends StickerAttribute

export (int) var chance_min:int
export (int) var chance_max:int
export (int) var chance_mode:int


var chance:int

func get_description(move)->String:
	var format = "MOVE_ATTRIBUTE_REACTION_NEGATOR"
	return Loc.trf(format, {
		"chance":"%+d" % chance
	})


func notify(move, fighter, id:String, args):
	if id == "damage_starting" and args.fighter == fighter:
		remove_reaction(args.damage, fighter)

func remove_reaction(damage:Damage, fighter):
	if fighter.battle.rand.rand_int(100) >= chance:
		return 
	if damage.damage <= 0:
		return 
		
	print("no reaction for u")	
	damage.types.clear()

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
