extends "res://mods/sticker_tiers/scripts/FurtherStickerAttribute.gd"

export (int) var amount:int = 1000 # treasure max value
export (int) var chance_min:int
export (int) var chance_max:int
export (int) var chance_mode:int

export (Resource) var loot_table:Resource
export (Color) var toast_color:Color = Color(-238922241)

var chance:int

func get_description(move)->String:
	var format = "MOVE_ATTRIBUTE_TREASURE_TROVE"
	return Loc.trf(format, {
		"chance":"%+d" % chance
	})

func on_move_end(move, user, _targets, attack_params):

	if user.battle.rand.rand_int(100) >= chance:
		return 
		
	var loot = loot_table.generate_rewards(user.battle.rand.get_child("treasure_dig"), amount, 1)
	if loot.size() == 0:
		return 
	
	for entry in loot:
		entry.category = "LOOT_HEADING_TREASURE"
	
	user.battle.extra_loot += loot
	
	var message = Loc.trf("ITEM_EXCHANGE_MULTIPLE", [loot[0].item.get_name(), loot[0].amount])
	var toast = user.battle.create_toast()
	toast.setup_text(message, toast_color, loot[0].item.icon)
	toast.number_text = "MOVE_TREASURE_DIG_TOAST"
	user.battle.queue_play_toast(toast, user.slot)

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
