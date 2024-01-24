extends "res://mods/sticker_tiers/scripts/FurtherStickerAttribute.gd"

export (Resource) var resist_type:Resource
export (String) var toast_message:String = ""
export (int) var chance_min:int
export (int) var chance_max:int
export (int) var chance_mode:int


var chance:int

func get_description(move)->String:
	var format = "MOVE_ATTRIBUTE_ELEMENTAL_RESISTANCE"
	return Loc.trf(format, {
		"chance":"%+d" % chance,
		"type": resist_type.name
	})


func notify(move, fighter, id:String, args):
	if id == "damage_starting" and args.fighter == fighter:
		taking_damage(args.damage)

func taking_damage(damage:Damage):
	if damage.damage <= 0 or damage.is_critical or not damage.types.has(resist_type):
		return 
	
	damage.damage = int(max(1, damage.damage * (100 - chance) / 100))
	#damage.types.erase(resist_type)
	
	if damage.toast_message == "":
		damage.toast_message = toast_message

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
