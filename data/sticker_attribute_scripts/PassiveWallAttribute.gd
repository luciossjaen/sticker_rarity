extends StickerAttribute

export (int) var chance_min:int
export (int) var chance_max:int
export (int) var chance_mode:int
export (int) var amount:int = 2

var chance:int

func get_description(move)->String:
	var format = "MOVE_ATTRIBUTE_PASSIVE_WALL"
	return Loc.trf(format, {
		"chance":"%+d" % chance
	})

func on_move_end(move, user, _targets, attack_params):

	if user.battle.rand.rand_int(100) >= chance:
		return 
	var shield = WallStatus.new()
	shield.set_decoy(get_decoy(user))
	move.apply_status_effect(user, shield, amount)

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
	
func get_decoy(user)->Decoy:
	var types = user.status.get_types()
	var type = preload("res://data/elemental_types/beast.tres")
	if types.size() > 0:
		type = types[0]
	
	
	if type.id == "metal":
		var forms = user.get_species()
		for form in forms:
			if form is MonsterForm and form.move_tags.has("binvader"):
				return preload("res://data/decoys/wall_binvader.tres")
	
	return load("res://data/decoys/wall_" + type.id + ".tres") as Decoy
