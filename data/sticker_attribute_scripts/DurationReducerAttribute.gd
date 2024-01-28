extends "res://mods/sticker_tiers/scripts/FurtherStickerAttribute.gd"

export (int) var chance_min:int
export (int) var chance_max:int
export (int) var chance_mode:int
export (int) var amount:int = 1
export (String) var effect_toast:String = "MOVE_SANDSTORM_TOAST_TIMERS_REDUCED"

var chance:int

func get_description(move)->String:
	var format = "MOVE_ATTRIBUTE_DURATION_REDUCER"
	return Loc.trf(format, {
		"chance":"%+d" % chance
	})
	
func on_contact(move, _user, target, _damage)->void :
	if target.battle.rand.rand_int(100) >= chance:
		return 
	if reduce_status_durations(target) and effect_toast != "":
		var toast = target.battle.create_toast()
		toast.setup_text(effect_toast)
		target.battle.queue_play_toast(toast, target.slot)

func reduce_status_durations(target)->bool:
	var any_drained:bool = false
	for effect in target.status.get_effects():
		if effect.has_duration():
			effect.drain(amount)
			any_drained = true
	return any_drained

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
