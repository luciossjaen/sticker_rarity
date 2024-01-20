static func patch():
	var script_path = "res://data/item_scripts/StickerItem.gd"
	var patched_script : GDScript = preload("res://data/item_scripts/StickerItem.gd")

	if !patched_script.has_source_code():
		var file : File = File.new()
		var err = file.open(script_path, File.READ)
		if err != OK:
			push_error("Check that %s is included in Modified Files"% script_path)
			return
		patched_script.source_code = file.get_as_text()
		file.close()
		

	var code_lines:Array = patched_script.source_code.split("\n")
	print(code_lines[0])
	print(code_lines[1])
	
	var class_name_index = code_lines.find("class_name StickerItem")
	if class_name_index >= 0:
		code_lines.remove(class_name_index)
		
	# replaces default rarity values		
	var code_index = code_lines.find("	value = appraise_move(battle_move)")
	if code_index >= 0:
		code_lines.remove(code_index+2) 
		code_lines.remove(code_index+2)		
		code_lines.insert(code_index+1,get_code("rarity_values"))

 
	patched_script.source_code = ""
	for line in code_lines:
		patched_script.source_code += line + "\n"
	var err = patched_script.reload()
	if err != OK:
		push_error("Failed to patch %s." % script_path)
		return


static func get_code(block_name:String)->String:
	var blocks:Dictionary = {}
	
	blocks["rarity_values"] = """
	var rarity_values:Dictionary = {
		Rarity.RARITY_COMMON:0, 
		Rarity.RARITY_UNCOMMON:300, 
		Rarity.RARITY_RARE:500,
		Rarity.RARITY_EPIC:1250,
		Rarity.RARITY_LEGENDARY: 2000
	}
	
	assert (rarity_values.has(rarity))
	value += rarity_values[rarity]
	"""

	return blocks[block_name]
