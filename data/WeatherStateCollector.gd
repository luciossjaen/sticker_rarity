extends Resource
class_name WeatherStateCollector

export (Array, Resource) var weather_states:Array = []

func _ready():
	pass
	
func getTotalModifier(weather, element_types)->float:
	var damage_mod = 0.0
	var state = getWeatherState(weather)
	
	if state:
		damage_mod = state.getTotalModifier(element_types)
		
	return damage_mod
	
func getWeatherState(weather):
	for state in weather_states:
		if state.weather == weather:
			return state
	return null
