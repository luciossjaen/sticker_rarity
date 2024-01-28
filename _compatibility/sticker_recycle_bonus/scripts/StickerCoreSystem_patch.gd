static func patch():
	var mod_test = File.new()
	
	if (mod_test.file_exists("res://mods/Sticker_Recycle_Bonus/scripts/StickerCoreSystem.gd")):
		var script_path = "res://mods/Sticker_Recycle_Bonus/scripts/StickerCoreSystem.gd"
		var patched_script = load("res://mods/Sticker_Recycle_Bonus/scripts/StickerCoreSystem.gd")

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
			
		code_index = code_lines.find("func get_html_color(effect)->int:")
		if code_index >= 0:
			# adds epic and legendary colors to general rarity color fetcher
			code_lines.insert(code_index+1,get_code("get_effect_colors"))
			
		code_index = code_lines.find("		if not upgradable_effects and not exists_onsticker(sticker,attr):")
		if code_index >= 0:
			# adds epic and legendary rarity comparison for max attribute types
			code_lines.insert(code_index+1,get_code("check_additional_rarities"))
			
		code_index = code_lines.find("func get_sticker_potential(sticker)->Dictionary:")
		if code_index >= 0:
			# adds epic and legendary rarity fetch for attribute count
			code_lines.insert(code_index+2,get_code("add_ratity_max_attribute_check"))


		patched_script.source_code = ""
		for line in code_lines:
			patched_script.source_code += line + "\n"
		var err = patched_script.reload(true)
		if err != OK:
			push_error("Failed to patch %s." % script_path)
			return


static func get_code(block_name:String)->String:
	var blocks:Dictionary = {}
	
	blocks["get_effect_colors"] = """
	if effect.rarity == BaseItem.Rarity.RARITY_LEGENDARY:
			var legendary_color = "DAA520"
			return legendary_color
	if effect.rarity == BaseItem.Rarity.RARITY_EPIC:
			var epic_color = "BA55D3"
			return epic_color
	"""
	
	blocks["choose_effect_colors"] = """
		var html_color = ""
		if mod_attribute.rarity == BaseItem.Rarity.RARITY_LEGENDARY:
			html_color = "DAA520"
		elif mod_attribute.rarity == BaseItem.Rarity.RARITY_EPIC:
			html_color = "BA55D3"
		else:
			html_color = rare_color if mod_attribute.rarity == BaseItem.Rarity.RARITY_RARE else uncommon_color
	"""
	
	blocks["check_additional_rarities"] = """
			if attr.rarity == BaseItem.Rarity.RARITY_EPIC and get_sticker_potential(sticker).epic_full:
				continue
			if attr.rarity == BaseItem.Rarity.RARITY_LEGENDARY and get_sticker_potential(sticker).legendary_full:
				continue	
	"""
	
	blocks["add_ratity_max_attribute_check"] = """
	var epic_count:int = 0
	var legendary_count:int = 0
	for attribute in sticker.attributes:
		if attribute.rarity == BaseItem.Rarity.RARITY_EPIC:
			epic_count += 1
		if attribute.rarity == BaseItem.Rarity.RARITY_LEGENDARY:
			legendary_count += 1
	potential.epic_full = epic_count >= ItemFactory.MAX_ATTRIBUTES[BaseItem.Rarity.RARITY_EPIC]
	potential.legendary_full = legendary_count >= ItemFactory.MAX_ATTRIBUTES[BaseItem.Rarity.RARITY_LEGENDARY]
	"""
	
	return blocks[block_name]
