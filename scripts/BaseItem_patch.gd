static func patch():
	var script_path = "res://data/BaseItem.gd"
	var patched_script : GDScript = preload("res://data/BaseItem.gd")

	if !patched_script.has_source_code():
		var file : File = File.new()
		var err = file.open(script_path, File.READ)
		if err != OK:
			push_error("Check that %s is included in Modified Files"% script_path)
			return
		patched_script.source_code = file.get_as_text()
		file.close()

	var code_lines:Array = patched_script.source_code.split("\n")
	
	var class_name_index = code_lines.find("class_name BaseItem")
	if class_name_index >= 0:
		code_lines.remove(class_name_index)  

	var code_index = code_lines.find("enum Rarity{RARITY_COMMON, RARITY_UNCOMMON, RARITY_RARE}")
	if code_index >= 0:
		# adds epic and legendary as valid rarities to the game
		code_lines[code_index] = get_code("more_rarities")
		
	# removed BaseItem reference to avoid 
	code_index = code_lines.find("func matches(other_item:BaseItem)->bool:")
	if code_index >= 0:
		code_lines[code_index] = "func matches(other_item)->bool:"
		
	code_index = code_lines.find("	return RARITY_COLORS.get(rarity, Color.black)")
	if code_index >= 0:
		#code_lines[code_index] = get_code("new_rarity_colour_fetch")
		code_lines.insert(code_index+1,get_code("new_rarity_colours"))
		code_lines.remove(code_index)


	patched_script.source_code = ""
	for line in code_lines:
		patched_script.source_code += line + "\n"
	var err = patched_script.reload(true)
	if err != OK:
		push_error("Failed to patch %s." % script_path)
		return


static func get_code(block_name:String)->String:
	var blocks:Dictionary = {}
	
	blocks["more_rarities"] = """
enum Rarity{RARITY_COMMON, RARITY_UNCOMMON, RARITY_RARE, RARITY_EPIC, RARITY_LEGENDARY}
	"""
	
	blocks["rarity_colours"] = """
	Rarity.RARITY_COMMON:Color.black, 
	Rarity.RARITY_UNCOMMON:Color("225d31"), 
	Rarity.RARITY_RARE:Color("35379d"),
	Rarity.RARITY_EPIC:Color("BA55D3"),
	Rarity.RARITY_LEGENDARY:Color("DAA520")
	"""
	
	blocks["new_rarity_colours"] = """
	var rarity_colours = DLC.mods_by_id["lucioss_rarity_tiers"].get_rarity_colors()
	return rarity_colours.get(rarity, Color.black)
	"""

	return blocks[block_name]
