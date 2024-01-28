static func patch():
	var script_path = "res://data/BattleMove.gd"
	var patched_script : GDScript = preload("res://data/BattleMove.gd")

	if !patched_script.has_source_code():
		var file : File = File.new()
		var err = file.open(script_path, File.READ)
		if err != OK:
			push_error("Check that %s is included in Modified Files"% script_path)
			return
		patched_script.source_code = file.get_as_text()
		file.close()

	var code_lines:Array = patched_script.source_code.split("\n")
	
	var class_name_index = code_lines.find("class_name BattleMove")
	if class_name_index >= 0:
		code_lines.remove(class_name_index)
		
	var code_index = code_lines.find("func call_attributes(method_name:String, args:Array)->void :")
	if code_index >= 0:
		# adds artificial weather attribute call
		code_lines.insert(code_index+1,get_code("add_weather_attribute"))

	patched_script.source_code = ""
	for line in code_lines:
		patched_script.source_code += line + "\n"
	var err = patched_script.reload()
	if err != OK:
		push_error("Failed to patch %s." % script_path)
		return


static func get_code(block_name:String)->String:
	var blocks:Dictionary = {}
	
	blocks["add_weather_attribute"] = """
	var weather_calculator = preload("res://mods/sticker_tiers/data/sticker_attributes/weather_calculator.tres")
	if (method_name == "modify_damage"):
		weather_calculator.callv(method_name, args)
	"""

	return blocks[block_name]
