static func patch():
	var script_path = "res://nodes/day_night_cycle/DayNightEnvironment.gd"
	var patched_script : GDScript = preload("res://nodes/day_night_cycle/DayNightEnvironment.gd")

	if !patched_script.has_source_code():
		var file : File = File.new()
		var err = file.open(script_path, File.READ)
		if err != OK:
			push_error("Check that %s is included in Modified Files"% script_path)
			return
		patched_script.source_code = file.get_as_text()
		file.close()

	var code_lines:Array = patched_script.source_code.split("\n")

	var code_index = code_lines.find("	if WeatherSystem.fog >= 0.25 and environment.background_mode == Environment.BG_SKY:")
	if code_index >= 0:
		# adds sandstorm visuals to environment
		code_lines[code_index+7] = get_code("add_sandstorm")


	patched_script.source_code = ""
	for line in code_lines:
		patched_script.source_code += line + "\n"
	var err = patched_script.reload()
	if err != OK:
		push_error("Failed to patch %s." % script_path)
		return


static func get_code(block_name:String)->String:
	var blocks:Dictionary = {}
	
	blocks["add_sandstorm"] = """
	if WeatherSystem.fog == 0.96:
		fog_color = lerp(Color("F3DA53"), Color("FFF8D2"), fog_color_multiplier)
		fog_color_multiplier = 0.1
		environment.fog_color = fog_color
		environment.background_color = fog_color
	"""

	return blocks[block_name]
