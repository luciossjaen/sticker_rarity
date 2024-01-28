static func patch():
	var mod_test = File.new()
	
	if (mod_test.file_exists("res://mods/Sticker_Recycle_Bonus/scripts/AttributeCoreItem.gd")):
		var script_path = "res://mods/Sticker_Recycle_Bonus/scripts/AttributeCoreItem.gd"
		var patched_script : GDScript = load("res://mods/Sticker_Recycle_Bonus/scripts/AttributeCoreItem.gd")

		if !patched_script.has_source_code():
			var file : File = File.new()
			var err = file.open(script_path, File.READ)
			if err != OK:
				push_error("Check that %s is included in Modified Files"% script_path)
				return
			patched_script.source_code = file.get_as_text()
			file.close()

		var code_lines:Array = patched_script.source_code.split("\n")
		
		var code_index = code_lines.find("func get_template_rarity_color():")
		if code_index >= 0:
			# adds epic and legendary colors for updated default sticker attributes
			code_lines.remove(code_index+1)
			code_lines.remove(code_index+1)
			code_lines.insert(code_index+1,get_code("add_more_rarities"))

		patched_script.source_code = ""
		for line in code_lines:
			patched_script.source_code += line + "\n"
		var err = patched_script.reload(true)
		if err != OK:
			push_error("Failed to patch %s." % script_path)
			return


static func get_code(block_name:String)->String:
	var blocks:Dictionary = {}
	
	blocks["add_more_rarities"] = """
	var attribute:StickerAttribute = load(template_path)
	var rarity_colours:Dictionary = {
		Rarity.RARITY_COMMON:Color.black, 
		Rarity.RARITY_UNCOMMON:Color("225d31"), 
		Rarity.RARITY_RARE:Color("35379d"),
		Rarity.RARITY_EPIC:Color("BA55D3"),
		Rarity.RARITY_LEGENDARY:Color("DAA520")
	}
	return rarity_colours[attribute.rarity].to_html()
	"""
	
	return blocks[block_name]
