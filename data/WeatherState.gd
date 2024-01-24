extends Resource
class_name WeatherState

export (Resource) var weather:Resource
export (Array, Resource) var element_kinds:Array = []
export (Array, float) var element_mod: Array = []

func _ready():
	pass
	
func getTotalModifier(element_types)->float:
	var damage_mod = 0.0
	for element_type in element_types:
		print("manage element")
		print(element_type)
		damage_mod += getModifier(element_type)
	return damage_mod
	
func getModifier(element_type)->float:
	var index = 0
	for kind in element_kinds:
		print("checked type")
		print(kind.name)
		if kind == element_type:
			if element_mod[index]:
				print("found mod")
				print(element_mod[index])
				return element_mod[index]
		index += 1
	return 0.0
