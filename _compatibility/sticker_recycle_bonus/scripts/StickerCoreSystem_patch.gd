static func patch():
	var script_path = "res://mods/Sticker_Recycle_Bonus/scripts/StickerCoreSystem.gd"
	var patched_script : GDScript = preload("res://mods/Sticker_Recycle_Bonus/scripts/StickerCoreSystem.gd")

	if !patched_script.has_source_code():
		var file : File = File.new()
		var err = file.open(script_path, File.READ)
		if err != OK:
			push_error("Check that %s is included in Modified Files"% script_path)
			return
		patched_script.source_code = file.get_as_text()
		file.close()

	var code_lines:Array = patched_script.source_code.split("\n")
	
	var code_index = code_lines.find("		var html_color = rare_color if mod_attribute.rarity == BaseItem.Rarity.RARITY_RARE else uncommon_color")
	if code_index >= 0:
		# adds epic and legendary colors to sticker core system (mod)
		code_lines.insert(code_index+1,get_code("choose_effect_colors"))
		code_lines.remove(code_index)
	
	# we have to do it twice to replace both appearances of the color assignment	
	code_index = code_lines.find("		var html_color = rare_color if mod_attribute.rarity == BaseItem.Rarity.RARITY_RARE else uncommon_color")
	if code_index >= 0:
		# adds epic and legendary colors to sticker core system (mod)
		code_lines.insert(code_index+1,get_code("choose_effect_colors"))
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
	
	blocks["choose_effect_colors"] = """
		var html_color = ""
		if mod_attribute.rarity == BaseItem.Rarity.RARITY_LEGENDARY:
			html_color = "DAA520"
		elif mod_attribute.rarity == BaseItem.Rarity.RARITY_EPIC:
			html_color = "BA55D3"
		else:
			html_color = rare_color if mod_attribute.rarity == BaseItem.Rarity.RARITY_RARE else uncommon_color
	"""

	return blocks[block_name]
