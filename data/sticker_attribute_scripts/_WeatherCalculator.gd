extends StickerAttribute

export (Resource) var weather_state_collector:Resource
export (String) var weather_positive_toast:String = ""
export (String) var weather_negative_toast:String = ""

# this artificial attribute is added to all moves to add additional calculations to damage
# based on the ongoing weather effect in battle. The attribute is not visible in-game and

var chance:int = 100

func get_description(move)->String:
	var format = "MOVE_ATTRIBUTE_WEATHER_CALCULATOR"
	return Loc.trf(format, {
		"chance":"%+d" % chance
	})

func modify_damage(_move, _user, _target, damage)->void :
	
	# should not affect moves without damage
	if damage.damage > 0:
		var elemental_types = _move.get_types(_user)
		var damage_mod = 1.0
		var weather_mod = 0.0

		var weather = WeatherSystem.weather if WeatherSystem.weather else null
		if weather:
			weather_mod = weather_state_collector.getTotalModifier(weather, elemental_types)
			
		damage_mod += weather_mod
		damage.damage = int(max(1,damage.damage * damage_mod))
		
		# play toast based on effect value
		if weather_mod < 0 and damage.toast_message == "":
			damage.toast_message = weather_negative_toast
		elif weather_mod > 0 and damage.toast_message == "":
			damage.toast_message = weather_positive_toast
	
		

func generate(move, rand:Random)->void :
	.generate(move, rand)

func get_perfection()->float:
	return 1.0

func get_snapshot()->Dictionary:
	var snap = .get_snapshot()
	return snap

func set_snapshot(snap, version:int)->bool:
	if not .set_snapshot(snap, version):
		return false
	return true
